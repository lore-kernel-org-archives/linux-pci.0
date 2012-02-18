Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:16899 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751669Ab2BRG2h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 18 Feb 2012 01:28:37 -0500
Message-ID: <4F3F4509.4070003@amd.com>
Date: Sat, 18 Feb 2012 14:28:25 +0800
From: Andiry Xu <andiry.xu@amd.com>
MIME-Version: 1.0
To: Clemens Ladisch <clemens@ladisch.de>
CC: "Alex,Shi" <alex.shi@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	<stern@rowland.harvard.edu>, Greg KH <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Oliver Neukum <oneukum@suse.de>, Takashi Iwai <tiwai@suse.de>,
	<trenn@suse.de>, <linux-pci@vger.kernel.org>,
	Michal Marek <MMarek@suse.com>
Subject: Re: [PATCH] usb: enable pci MSI/MSIX in usb core
References: <1328531341-22705-1-git-send-email-alex.shi@intel.com>  <4F311233.9070404@intel.com> <20120207144204.GA7214@kroah.com>  <20120207172743.GA4780@xanatos> <20120207221317.GA6103@xanatos>  <1328664392.12669.233.camel@debian> <1328682430.12669.443.camel@debian>  <1328692300.12669.593.camel@debian>  <20120214002030.GA10364@xanatos>  <1329359801.12669.2872.camel@debian> <1329461087.12669.2911.camel@debian>  <4F3E0C3D.4030307@ladisch.de> <1329468418.12669.2988.camel@debian> <4F3E28D1.1030509@ladisch.de>
In-Reply-To: <4F3E28D1.1030509@ladisch.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2012 06:15 PM, Clemens Ladisch wrote:
> Alex,Shi wrote:
>>> The controller driver will need to know which of the multiple MSI-X
>>> interrupts has been raised:
>>>
>>> irqreturn_t (*msix_irq)(struct usb_hcd *hcd, unsigned int nr_or_index);
>>
>> Actually, hcd has 2 object for msix, msix_count and msix_entries.
>>
>> Do you mean msix_count maybe smaller than we decide in hcd_setup_msix()?
> 
> No.  But when msic_count > 1, we have multiple interrupts.
> 
>> Which situation will make this?
> 
> Assume that an XHCI controller has two rings, and that each one gets its
> own MSI-X interrupt.  How should the driver decide which of the rings
> needs to be handled?
> 
> irqreturn_t xhci_msix_irq(struct usb_hcd *hcd)
> {
> 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> 
> 	if (...)
> 		handle(xhci->ring[0]);
> 	else
> 		handle(xhci->ring[1]);
> }
> 
> I.e., what should go into the if()?
> 
> 

Currently xHCI driver only support one ERST event ring. If we need to
support multiple event rings in the future, it's simple: in
usb_hcd_request_msi_msix_irqs, change the last parameter of
request_irq() to xhci->erst[i], and we can get the corresponding erst[i]
in xhci_msi_irq() like this:

irqreturn_t xhci_msi_irq(int irq, void *dev_id)
{
	struct xhci_erst *erst = dev_id;
	...
	/* Handle corresponding event ring pointed by erst */
}

See Matthew Wilcox's patchset below for reference:

www.spinics.net/lists/linux-usb/msg47353.html

Thanks,
Andiry
Andiry





