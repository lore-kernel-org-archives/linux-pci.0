Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37854 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab2JZRRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Oct 2012 13:17:52 -0400
Date: Fri, 26 Oct 2012 10:17:42 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: shashank chaturvedi <chaturvedi9950@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xhci Portsc register issue
Message-ID: <20121026171742.GF4713@xanatos>
References: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com>
 <20121025153552.GA5205@xanatos>
 <20121025223706.17034.qmail@stuge.se>
 <CALuomMs-Z_PH3KpEPDgjBr5oy86Go2G2PAxu_k2yxgzWwRhJYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALuomMs-Z_PH3KpEPDgjBr5oy86Go2G2PAxu_k2yxgzWwRhJYQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 26, 2012 at 10:32:05AM +0530, shashank chaturvedi wrote:
> >Why would you want to do that?  For link power management?  What is the
> >xHCI kernel driver not providing you such that you have to write a
> >userspace program?
> 
> I want to do this for link power managment.But i am able to read & write
> the PORTPMSC register (as per xhci spec 5.4.9) from userspace program.Why
> not the PORTSC regsiter?

Do NOT do this from userspace!  You need to modify the xHCI kernel
driver to support link PM for your host controller.  The USB core has
specific times it disables link PM (e.g. before a device is reset) and
some drivers may require link PM to be disabled.  You are circumventing
kernel policy by writing the link PM registers from userspace.  Do NOT
do this!

Sarah Sharp
