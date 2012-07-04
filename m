Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53209 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab2GDVJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Jul 2012 17:09:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
Date: Wed, 4 Jul 2012 23:14:58 +0200
Cc: AceLan Kao <acelan.kao@canonical.com>, linux-pci@vger.kernel.org,
	" =?utf-8?q?=E6=B4=AA?=(Alex)=?utf-8?q?=E8=8C=82=E8=80=95?="
	<alex.hung@canonical.com>
References: <Pine.LNX.4.44L0.1207041442430.15857-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1207041442430.15857-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201207042314.58365.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 04, 2012, Alan Stern wrote:
> On Wed, 4 Jul 2012, AceLan Kao wrote:
> 
> > We contacted the ASUS' BIOS engineer and try to verify this issue, for
> > it happened
> > on many ASUS' machines. Then they found that the system hangs in their
> > BIOS code.
> > The code will try to disable the USB if they found the PCI COMMAND
> > register is not zero.
> > 
> > That's not a correct behavior that BIOS should do, the PCI COMMAND
> > register is not
> > represent if the USB is disabled or not, It's a workaround they tried to fix
> > another issue in windows long time ago, but ASUS' BIOS engineer refuse to remove
> > that part of code. But windows will clear the PCI COMMAND register if
> > windows is already
> > disabled the USB.
> > So, I try to write this quirk.
> 
> > > Is there any reason not to clear the PCI COMMAND register of every PCI
> > > USB host controller when entering S3?
> > Quote from ASUS, they only mentioned EHCI
> > ---------
> > BIOS will check EHCI command register PCI regiter offset 04h to see if
> > USB is disabled or not.
> > Because regiter offset 04h is not cleared, BIOS think USB is not disabled.
> > Then BIOS will try to disabled USB, but the USB is disabled by Ubuntu
> > already. This conflict will cause system hang.
> > ASUS think since Ubuntu will disable USB, it also need to clear the
> > register too.
> > ---------
> 
> How about this patch instead?  (I haven't tested it yet...)
> 
> Rafael, does this seem okay with no special quirk flag?  Or should the 
> command register be cleared as part of the USB code?

Well, the clearing of it in the USB code would probably be too early,
so we don't really have much choice.

I suppose we can add pci_fixup_suspend_noirq for that in analogy with
pci_fixup_suspend, but I'm not sure it's worth the effort.

Bjorn, what do you think?

Rafael



> Index: usb-3.5/drivers/pci/pci-driver.c
> ===================================================================
> --- usb-3.5.orig/drivers/pci/pci-driver.c
> +++ usb-3.5/drivers/pci/pci-driver.c
> @@ -748,6 +748,18 @@ static int pci_pm_suspend_noirq(struct d
>  
>  	pci_pm_set_unknown_state(pci_dev);
>  
> +	/*
> +	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
> +	 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
> +	 * hasn't been quiesced and tries to turn it off.  If the controller
> +	 * is already in D3, this can hang or cause memory corruption.
> +	 *
> +	 * Since the value of the COMMAND register doesn't matter once the
> +	 * device has been suspended, we can safely set it to 0 here.
> +	 */
> +	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
> +		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
> +
>  	return 0;
>  }
>  
> 
> 
> 

