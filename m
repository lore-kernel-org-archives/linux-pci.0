Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4F3E0C3D.4030307@ladisch.de>
Date: Fri, 17 Feb 2012 09:13:49 +0100
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: "Alex,Shi" <alex.shi@intel.com>
CC: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	stern@rowland.harvard.edu, Greg KH <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, andiry.xu@amd.com,
	linux-kernel@vger.kernel.org, Oliver Neukum <oneukum@suse.de>,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>
Subject: Re: [PATCH] usb: enable pci MSI/MSIX in usb core
References: <1328531341-22705-1-git-send-email-alex.shi@intel.com>  <4F311233.9070404@intel.com> <20120207144204.GA7214@kroah.com>  <20120207172743.GA4780@xanatos> <20120207221317.GA6103@xanatos>  <1328664392.12669.233.camel@debian> <1328682430.12669.443.camel@debian>  <1328692300.12669.593.camel@debian>  <20120214002030.GA10364@xanatos>  <1329359801.12669.2872.camel@debian> <1329461087.12669.2911.camel@debian>
In-Reply-To: <1329461087.12669.2911.camel@debian>
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex,Shi wrote:
> On Thu, 2012-02-16 at 10:36 +0800, Alex,Shi wrote:
>>>> +/* msi irq handler should be here, if driver has */
>>>> +irqreturn_t hcd_msi_irq(int irq, struct usb_hcd *hcd)
>>>> +{
>>>> +	return hcd->driver->irq(hcd);
>>>> +}
>>>
>>> This works for now, but it isn't going to work in the future.  We need
>>> the USB core to provide us with the irq number so we can map the MSI-X
>>> interrupt to the event ring that generated the interrupt, whenever we
>>> get around to adding multiple event rings.
>>
>> Do you mean to add 2 new vectors for MSI/MSIX in hc_driver?
>
> +	irqreturn_t	(*msi_irq) (struct usb_hcd *hcd);
> +	irqreturn_t	(*msix_irq) (struct usb_hcd *hcd);

The controller driver will need to know which of the multiple MSI-X
interrupts has been raised:

irqreturn_t (*msix_irq)(struct usb_hcd *hcd, unsigned int nr_or_index);


Regards,
Clemens
