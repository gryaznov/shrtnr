import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Magic from '../images/magic.gif'

const Link = props => (
  <div className='success'>
    <img src={Magic} />
    Your short link is:&nbsp;
    <a href={props.link}>{props.link}</a>
  </div>
)

Link.propTypes = {
  link: PropTypes.string.isRequired
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('link')
  const link = node.getAttribute('link')
  const wrapper = document.createElement('div')
  wrapper.className = 'wrapper'

  ReactDOM.render(
    <Link link={link} />,
    document.body.appendChild(wrapper)
  )
})
