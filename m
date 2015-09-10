Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbbIJN5S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 09:57:18 -0400
Message-ID: <1441893436.7900.10.camel@pengutronix.de>
Subject: Re: Multiple MSIs on ARM imx6q
From: Lucas Stach <l.stach@pengutronix.de>
To: Frank Jenner <faj6816@rit.edu>
Cc: linux-pci@vger.kernel.org
Date: Thu, 10 Sep 2015 15:57:16 +0200
In-Reply-To: <loom.20150910T144529-230@post.gmane.org>
References: <loom.20150910T144529-230@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Frank,

Am Donnerstag, den 10.09.2015, 12:55 +0000 schrieb Frank Jenner:
> Hello,
> 
> I'm trying to develop a driver for a PCIe device which utilizes multiple
> MSIs (up to the full 32 allowable), but I cannot seem to enable more than
> one when calling pci_enable_msi_range(). The host platform uses a Freescale
> i.MX 6Quad ARM SoC and is running the "linux-fslc_4.1" kernel (from the
> Yocto project).
> 
> With some investigation, I believe that this limitation is stemming from
> arch_setup_msi_irqs() in drivers/pci/msi.c where there is an early return
> with the comment "If an architecture wants to support multiple MSI, it needs
> to override arch_setup_msi_irqs()". There appears to be no such override for
> ARM.
> 
> My first question then, is:
> 
> 1.) Are multiple MSIs simply not yet supported on ARM as of 4.1?
> 
Right, multivector MSI is not supported for any ARM host bridge on any
released kernel version.

> Both MSIs and ARM have been around for a while, and I doubt I'm the only
> person who ever wanted to use multiple MSIs on ARM, so I can't help but
> think maybe I'm overlooking something. I ran into a similar question
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/016858.html), but
> as that was 5+ years ago, I'm wondering whether the situation has since changed.
> 
Multivector MSI is a rarely used feature on endpoints. Most devices
either do single vector MSI or full blown MSI-X. It's mostly FPGA
devices preferring the simplicity of multivector MSI over MSI-X.

An implementation for the i.MX6 is already sitting in Bjorns PCI
maintainer tree and is expected to be merged in kernel 4.4.

> Unfortunately, even if I work around the arch_setup_msi_irqs() limitation
> (which I've done by trying out patches 448141 and 448142 from
> http://patchwork.ozlabs.org/project/linux-pci/list/) and break through to
> the assign_irq() function in drivers/pci/host/pcie-designware.c, I still
> cannot allocate all 32 MSIs that my device reports.
> 
> It appears that one of the bits in the msi_irq_in_use bitmap is already set
> prior to my driver requesting any MSIs, meaning there aren't enough free
> slots for the 32 MSIs I am requesting, and causing the function to fail with
> -ENOSPC. Based on the output from /proc/interrupts, I believe that the PCIe
> PME service driver is consuming one of the 32 available MSI slots. Thus, my
> second question is:
> 
> 2.) Is it possible to leverage all 32 MSIs while still using PCIe PME?
> 
> I tried using the kernel command line argument pcie_pme=nomsi, but that
> appeared to disable all MSIs for the device rather than just making the PME
> service driver use some other mechanism.
> 
It should be possible to make PME use a legacy INT, but I would have to
look this up in the code.

Another alternative is to extend the i.MX6 driver. It should be able to
provide up to 256 MSI interrupt vectors. But I have no way to test that,
so if you could help with testing I can certainly come up with a patch
for that.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

