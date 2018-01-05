Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeAEAar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 19:30:47 -0500
Date: Thu, 4 Jan 2018 18:30:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI, sysfs: show ari_enabled in sysfs
Message-ID: <20180105003044.GM189897@bhelgaas-glaptop.roam.corp.google.com>
References: <3cfc87ab-755a-680a-d06f-ee7cc38d2195@gmail.com>
 <20180104000811.GB189897@bhelgaas-glaptop.roam.corp.google.com>
 <4309152a-1d02-7e82-fa1d-4b5f613856a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4309152a-1d02-7e82-fa1d-4b5f613856a0@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 04, 2018 at 05:09:58PM -0600, Stuart Hayes wrote:
> 
> 
> On 1/3/2018 6:08 PM, Bjorn Helgaas wrote:
> > Hi Stuart,
> > 
> > Please run "git log --oneline drivers/pci/pci-sysfs.c" and follow the
> > convention.
> > 
> 
> Bjorn,
> 
> Is the problem just with the subject line (i.e., it should be something
> like "PCI: Expose ari_enabled...")?

Yep, exactly.  I don't have any issue with the patch itself; I just
like the logs to be consistent to make them easier to read because I
spend a lot of time reading them :)

> I'm happy to fix, I just want to make sure I understand the problem so I
> get it right next time.

> > On Wed, Jan 03, 2018 at 10:36:46AM -0600, Stuart Hayes wrote:
> >> Some multifunction PCI devices with more than 8 functions use "alternative
> >> routing-ID interpretation" (ARI), which means the 8-bit device/function
> >> number field will be interpreted as 8 bits specifying the function number
> >> (the device number is 0 implicitly), rather than the upper 5 bits
> >> specifying the device number and the lower 3 bits specifying the function
> >> number. The kernel can enable and use this.
> >>
> >> Expose in a sysfs attribute whether the kernel has enabled ARI, so that a
> >> program in userspace won't have to parse PCI devices and PCI configuration
> >> space to figure out if it is enabled. This will allow better predictable
> >> network naming using PCI function numbers without using PCI bus or device
> >> numbers, which is desirable because bus and device numbers can change with
> >> system configuration but function numbers will not.
> >>
> >> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> >> ---
> >>
> >> --- linux-4.15-rc6/drivers/pci/pci-sysfs.c.orig	2017-12-31 17:47:43.000000000 -0500
> >> +++ linux-4.15-rc6/drivers/pci/pci-sysfs.c	2018-01-02 13:58:23.372928377 -0500
> >> @@ -278,6 +278,16 @@ static ssize_t subordinate_bus_number_sh
> >>  }
> >>  static DEVICE_ATTR_RO(subordinate_bus_number);
> >>  
> >> +static ssize_t ari_enabled_show(struct device *dev,
> >> +				struct device_attribute *attr,
> >> +				char *buf)
> >> +{
> >> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> >> +
> >> +	return sprintf(buf, "%u\n", pci_ari_enabled(pci_dev->bus));
> >> +}
> >> +static DEVICE_ATTR_RO(ari_enabled);
> >> +
> >>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> >>  			     char *buf)
> >>  {
> >> @@ -786,6 +796,7 @@ static struct attribute *pci_dev_attrs[]
> >>  	&dev_attr_devspec.attr,
> >>  #endif
> >>  	&dev_attr_driver_override.attr,
> >> +	&dev_attr_ari_enabled.attr,
> >>  	NULL,
> >>  };
> >>  
> >>
> >>
> >> ---
> >> This email has been checked for viruses by Avast antivirus software.
> >> https://www.avast.com/antivirus
> >>
