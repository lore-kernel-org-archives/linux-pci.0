Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59880 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030412AbcBQR0k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 12:26:40 -0500
Date: Wed, 17 Feb 2016 11:26:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: jakeo@microsoft.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	haddenh@microsoft.com
Subject: Re: [PATCH RESEND v3 0/3] PCI: hv: New paravirtual PCI front-end
 driver
Message-ID: <20160217172634.GA26372@localhost>
References: <1455659783-20036-1-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455659783-20036-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 09:56:20PM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This version incorporates more feedback from Bjorn Helgaas.  Most notably,
> I removed some debugging code and I consistently used architectural
> means for getting the PCI domain instead of just reaching into the sysdata.
> 
> This is a resend of patches that enable PCI pass-through within Hyper-V
> VMs.  This patch series only includes those which were deemed appropriate
> for being incorportated via the PCI tree.  All other patches in previous
> patch series have gone through other trees and are now in mainline.
> 
> The first two patches modify PCI so that new root PCI buses can be marked with
> an associated fwnode_handle, and so that root PCI buses can look up their
> associated IRQ domain by that handle.
> 
> The last patch, introduces a new driver, hv_pcifront, which exposes root PCI
> buses in a Hyper-V VM.  These root PCI buses expose real PCIe devices, or PCI
> Virtual Functions.
> 
> Jake Oshins (3):
>   PCI: Add fwnode_handle to pci_sysdata
>   PCI: irqdomain: Look up IRQ domain by fwnode_handle
>   PCI: hv: New paravirtual PCI front-end for Hyper-V VMs
> 
>  MAINTAINERS                   |    1 +
>  arch/x86/include/asm/pci.h    |   15 +
>  drivers/pci/Kconfig           |    7 +
>  drivers/pci/host/Makefile     |    1 +
>  drivers/pci/host/pci-hyperv.c | 2359 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |   15 +
>  include/linux/pci.h           |    4 +
>  7 files changed, 2402 insertions(+)
>  create mode 100644 drivers/pci/host/pci-hyperv.c

Applied to pci/host-hv, thanks, Jake!

This is a new driver, and I don't think there's any risk of breaking
anything, so I think we should still be able to merge this for v4.5.

Bjorn
