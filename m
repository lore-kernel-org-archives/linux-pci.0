Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46155 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758562Ab2JYPgr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 11:36:47 -0400
Date: Thu, 25 Oct 2012 08:36:38 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: shashank chaturvedi <chaturvedi9950@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xhci Portsc register issue
Message-ID: <20121025153552.GA5205@xanatos>
References: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 25, 2012 at 12:31:09PM +0530, shashank chaturvedi wrote:
> Hi sarah,
>              I am using Ubuntu 11.04 OS and NEC USB3.0 Host controller.
> I want to write the PLS [8:5] field in the PORTSC register through C
> program ,as per xhci spec first we have to write the LWS field
> I am doing that also,  But its unable to write above fields.
> Can you help me for how to write these field of PORTSC register?
> I am sending you the code below.  Please provide me the solution for
> writing the PLS field of PORTSC register

Why would you want to do that?  For link power management?  What is the
xHCI kernel driver not providing you such that you have to write a
userspace program?

If you're trying to write the PLS register from userspace while the xHCI
driver is loaded, I don't think that will work.  The PCI registers have
already been mapped by the xHCI driver, and I don't think another
program would be able to map them again.

But I'm not sure, since I've never attempted to memory map PCI registers
from userspace.  I was under the impression that you just can't do that.

Sarah Sharp
