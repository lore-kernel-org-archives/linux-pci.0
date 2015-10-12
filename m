Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60361 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbbJLHPr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 03:15:47 -0400
Date: Mon, 12 Oct 2015 09:15:44 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Li Yang <leoli@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v2] PCI: layerscape: Add PCIe support for LS1043a and
 LS2080a
Message-ID: <20151012091544.7dbbe330@free-electrons.com>
In-Reply-To: <20151011191027.GA29221@localhost>
References: <1442481219-28299-1-git-send-email-Minghuan.Lian@freescale.com>
	<20151007175725.GC27633@localhost>
	<20151011191027.GA29221@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Sun, 11 Oct 2015 14:10:27 -0500, Bjorn Helgaas wrote:

> > driver/of/irq.c  void of_msi_configure(struct device *dev, struct
> > device_node *np) will bind "msi-parent" to each device if there is
> > "msi-parent" handler. The PCIe driver do not need to do anything. If
> > we do not check "msi-parent" here, we will have no chance to check it.
> > The common code of 'of' and 'pci' bus driver will not complain,
> > because the msi controller may be found by other way.
> 
> Hmm.   In mvebu_pcie_msi_enable() and xgene_pcie_msi_enable(), we
> also look for "msi-parent".  If that fails, mvebu continues silently
> and xgene complains (but only if CONFIG_PCI_MSI=y).

I don't really have the context of the discussion here. But the reason
why the mvebu pcie driver silently continues if msi-parent is missing
is because we initially introduced the PCIe mvebu Device Tree binding
without MSI support. When we later added MSI support thanks to the
msi-parent property, we wanted to preserve backward compatibility with
old DTs that didn't had the msi-parent property. Such DTs would
continue to work, albeit without the MSI functionality obviously.

Other drivers that had the MSI functionality from day 1 may want to
make such a property mandatory rather than optional.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
