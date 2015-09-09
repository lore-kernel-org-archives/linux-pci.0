Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36596 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbIITMR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 15:12:17 -0400
Received: by wicgb1 with SMTP id gb1so128314395wic.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 12:12:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55EF119E.5030905@linux.intel.com>
References: <55EE8106.6060100@internode.on.net> <1441697190-27993-1-git-send-email-jiang.liu@linux.intel.com>
 <20150908162735.GK829@google.com> <55EF119E.5030905@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Sep 2015 14:11:56 -0500
Message-ID: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com>
Subject: Re: [Bugfix] PCI, x86: Correctly allocate IRQs for PCI devices
 managed by non-PCI drivers
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 8, 2015 at 11:49 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Hi Bjorn,
>         We have used another draft version to fix this issue by changing
> eata driver as below. But that needs to export pcibios_alloc_irq. And
> I'm not sure whether there are other drivers having the same behavior.
> If we think it's a legacy behavior and only a few drivers may have
> such a behavior, I prefer changing drivers to fix the issue too.

Did you look at changing the driver to use pci_register_driver()?  I
bet it's pretty straightforward.

>  drivers/pci/pci-driver.c |    1 +
>  drivers/scsi/eata.c      |    2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 52a880ca1768..17d2a0b1de18 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -392,6 +392,7 @@ int __weak pcibios_alloc_irq(struct pci_dev *dev)
>  {
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(pcibios_alloc_irq);
>
>  void __weak pcibios_free_irq(struct pci_dev *dev)
>  {
> diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
> index 227dd2c2ec2f..7e6eaf867987 100644
> --- a/drivers/scsi/eata.c
> +++ b/drivers/scsi/eata.c
> @@ -1061,6 +1061,7 @@ static void enable_pci_ports(void)
>                        driver_name, dev->bus->number, dev->devfn);
>  #endif
>
> +               pcibios_alloc_irq(dev);
>                 if (pci_enable_device(dev))
>                         printk
>                             ("%s: warning, pci_enable_device failed, bus %d devfn 0x%x.\n",
> @@ -1520,6 +1521,7 @@ static void add_pci_ports(void)
>                 if (!(dev = pci_get_class(PCI_CLASS_STORAGE_SCSI << 8, dev)))
>                         break;
>
> +               pcibios_alloc_irq(dev);
>                 if (pci_enable_device(dev)) {
>  #if defined(DEBUG_PCI_DETECT)
>                         printk
>
>
>>
>>>      return pci_enable_resources(dev, mask);
>>>  }
>>>
>>> --
>>> 1.7.10.4
>>>
