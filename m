Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51505 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbbDOKhA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 06:37:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/3] pci/designware: Add base driver for Designware PCIe
Date: Wed, 15 Apr 2015 12:36:54 +0200
Message-ID: <2123546.0rhYViPpvy@wuerfel>
In-Reply-To: <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com> <1429091315-31891-3-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 15 April 2015 17:48:34 Minghuan Lian wrote:
> The Synopsys Designware IP is shared with couples of platforms
> under multiple architectures. The patch is to provide basic
> architecture-independent Designware PCIe host driver including
> ATU initialization and PCI OPS. Currently, which supports arm
> and arm64 simultaneously.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> change log:
> v1-v2:
> 1. Get MSI chip according to dts property 'msi-parent'
> 2. Simplify platform_get_resource_byname() failure checking   
> 
>  drivers/pci/host/Kconfig                |   3 +
>  drivers/pci/host/Makefile               |   1 +
>  drivers/pci/host/pcie-designware-base.c | 293 ++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-designware-base.h |  63 +++++++
> 

I don't understand this patch at all. What is the relation between
this driver and the existing pcie-designware.c? From the description
above, they would be the same.

	Arnd
