Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6075 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbbH1IWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Aug 2015 04:22:03 -0400
Message-ID: <1440750106.5982.2.camel@rzhang1-mobl4>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
From: Zhang Rui <rui.zhang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, chuansheng.liu@intel.com,
	Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	mister.freeman@laposte.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Fri, 28 Aug 2015 16:21:46 +0800
In-Reply-To: <20150825024941.GA25829@google.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
	 <20150825024941.GA25829@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Bjorn,

On Mon, 2015-08-24 at 21:49 -0500, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2015 at 09:42:27AM +0800, Zhang Rui wrote:
> > From 57edba9c677e47354846db951014dc4d5b13ce54 Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Sun, 26 Jul 2015 14:15:36 +0800
> > Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
> 
> ...
> 
> In the interest of making progress on this, I reworked this to be what I'm
> looking for.  It's not significantly different code-wise from what you
> posted originally, so I left your Signed-off-by.  But let me know if I
> messed it up.
> 
thanks for the follow up. Sorry for my late response as I was traveling
and then took some vacation in the last two weeks.
The patch looks fine to me.

thanks,
rui
> We don't actually *know* whether the quirk needs to be applied before
> pata_jmicron is loaded, but my guess is that is does, so I left it as a PCI
> quirk rather than as a driver quirk.

> Comments welcome!
> 
> Bjorn
> 
> 
> commit 09981db5b0c9a6865aa39126b71bc87718577e4b
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Mon Aug 24 15:27:11 2015 -0500
> 
>     PCI: Disable async suspend/resume for JMicron multi-function SATA/AHCI
>     
>     On multi-function JMicron SATA/PATA/AHCI devices, the PATA controller at
>     function 1 doesn't work if it is powered on before the SATA controller at
>     function 0.  The result is that PATA doesn't work after resume, and
>     messages like this:
>     
>       pata_jmicron 0000:02:00.1: Refused to change power state, currently in D3
>       irq 17: nobody cared (try booting with the "irqpoll" option)
>     
>     e6b7e41cdd8c ("ata: Disabling the async PM for JMicron chip 363/361")
>     solved this problem for JMicron 361 and 363 devices.  With async suspend
>     disabled, we always power on function 0 before function 1.
>     
>     Barto then reported the same problem with a JMicron 368 (see comment #57 in
>     the bugzilla).
>     
>     Rather than extending the blacklist piecemeal, disable async suspend for
>     all JMicron multi-function SATA/PATA/AHCI devices.
>     
>     This quirk could stay in the ahci and pata_jmicron drivers, but it's likely
>     the problem will occur even if pata_jmicron isn't loaded until after the
>     suspend/resume.  Making it a PCI quirk ensures that we'll preserve the
>     power-on order even if the drivers aren't loaded.
>     
>     [bhelgaas: changelog, limit to multi-function, limit to IDE/ATA]
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=81551
>     Reported-by: Barto <mister.freeman@laposte.net>
>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 7e62751..a466602 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -351,6 +351,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	/* JMicron 362B and 362C have an AHCI function with IDE class code */
>  	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
>  	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },
> +	/* May need to update quirk_jmicron_async_suspend() for additions */
>  
>  	/* ATI */
>  	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
> @@ -1451,18 +1452,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
>  		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
>  
> -	/*
> -	 * The JMicron chip 361/363 contains one SATA controller and one
> -	 * PATA controller,for powering on these both controllers, we must
> -	 * follow the sequence one by one, otherwise one of them can not be
> -	 * powered on successfully, so here we disable the async suspend
> -	 * method for these chips.
> -	 */
> -	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
> -		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
> -		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
> -		device_disable_async_suspend(&pdev->dev);
> -
>  	/* acquire resources */
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
> diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
> index 47e418b..4d1a5d2 100644
> --- a/drivers/ata/pata_jmicron.c
> +++ b/drivers/ata/pata_jmicron.c
> @@ -143,18 +143,6 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
>  
> -	/*
> -	 * The JMicron chip 361/363 contains one SATA controller and one
> -	 * PATA controller,for powering on these both controllers, we must
> -	 * follow the sequence one by one, otherwise one of them can not be
> -	 * powered on successfully, so here we disable the async suspend
> -	 * method for these chips.
> -	 */
> -	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
> -		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
> -		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
> -		device_disable_async_suspend(&pdev->dev);
> -
>  	return ata_pci_bmdma_init_one(pdev, ppi, &jmicron_sht, NULL, 0);
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b6af4b0..5e35a9d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1570,6 +1570,18 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB3
>  
>  #endif
>  
> +static void quirk_jmicron_async_suspend(struct pci_dev *dev)
> +{
> +	if (dev->multifunction) {
> +		device_disable_async_suspend(&dev->dev);
> +		dev_info(&dev->dev, "async suspend disabled to avoid multi-function power-on ordering issue\n");
> +	}
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_IDE, 8, quirk_jmicron_async_suspend);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY, PCI_CLASS_STORAGE_SATA_AHCI, 0, quirk_jmicron_async_suspend);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x2362, quirk_jmicron_async_suspend);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x236f, quirk_jmicron_async_suspend);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  static void quirk_alder_ioapic(struct pci_dev *pdev)
>  {


