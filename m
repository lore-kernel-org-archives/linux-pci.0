Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39179 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759914Ab2JYQqO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2012 12:46:14 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1475924wgb.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2012 09:46:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121025153552.GA5205@xanatos>
References: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com>
 <20121025153552.GA5205@xanatos>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Oct 2012 10:45:51 -0600
Message-ID: <CAErSpo6m8YOJnv3gwPo8=HXNTMSJ5xfCgvdp2==tkWn6Wfvpnw@mail.gmail.com>
Subject: Re: xhci Portsc register issue
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: shashank chaturvedi <chaturvedi9950@gmail.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 25, 2012 at 9:36 AM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Thu, Oct 25, 2012 at 12:31:09PM +0530, shashank chaturvedi wrote:
>> Hi sarah,
>>              I am using Ubuntu 11.04 OS and NEC USB3.0 Host controller.
>> I want to write the PLS [8:5] field in the PORTSC register through C
>> program ,as per xhci spec first we have to write the LWS field
>> I am doing that also,  But its unable to write above fields.
>> Can you help me for how to write these field of PORTSC register?
>> I am sending you the code below.  Please provide me the solution for
>> writing the PLS field of PORTSC register
>
> Why would you want to do that?  For link power management?  What is the
> xHCI kernel driver not providing you such that you have to write a
> userspace program?
>
> If you're trying to write the PLS register from userspace while the xHCI
> driver is loaded, I don't think that will work.  The PCI registers have
> already been mapped by the xHCI driver, and I don't think another
> program would be able to map them again.
>
> But I'm not sure, since I've never attempted to memory map PCI registers
> from userspace.  I was under the impression that you just can't do that.

PORTSC looks like an xHCI-specific register that would be inside one
of the BARs (xHCI spec sec 5.4.8).  This would typically be mapped by
the driver.  Writing it from userspace behind the driver's back is
asking for trouble because the driver owns the device, and it won't be
aware of what you're doing.

PCI config space isn't mapped by drivers in the same way PCI BARs are,
and you can change things there with "setpci".  But again, this is
asking for trouble because those registers are really owned by the PCI
core, and things will go wrong if you change things behind its back.

Bjorn
