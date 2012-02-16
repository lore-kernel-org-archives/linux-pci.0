Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:53163 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab2BPRsJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2012 12:48:09 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Date: Thu, 16 Feb 2012 18:50:38 +0100
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
References: <20120209150823.GA5232@xanatos> <201202161548.53556.oliver@neukum.org> <20120216165424.GA4703@xanatos>
In-Reply-To: <20120216165424.GA4703@xanatos>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201202161850.38426.oliver@neukum.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, 16. Februar 2012, 17:54:24 schrieb Sarah Sharp:
> When the driver is unloaded, usb_hcd_pci_remove() is called, which will
> call pci_disable_device().  If the ref counts were balanced (and I
> believe they are), then the PCI device would have been disabled before
> S3 for distros that unloaded the USB drivers on suspend.  So the BIOS
> would have seen a disabled PCI device for these distros, just like it
> would with my patch if the driver never got loaded.
> 
> I don't think this is an issue.

OK, I am convinced.

	Regards
		Oliver
