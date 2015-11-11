Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58248 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbKKIx5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2015 03:53:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
	linux@arm.linux.org.uk, xuwei5@hisilicon.com,
	wangzhou1@hisilicon.com, bhelgaas@google.com,
	liguozhu@hisilicon.com
Subject: Re: [PATCH] ARM/PCI: move align_resource function pointer into pci_host_bridge structure
Date: Wed, 11 Nov 2015 09:47:38 +0100
Message-ID: <5509277.PRqCf43vDc@wuerfel>
In-Reply-To: <1447204345-143793-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1447204345-143793-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 11 November 2015 09:12:25 Gabriele Paoloni wrote:
> From: gabpao01 <gabriele.paoloni@huawei.com>

Regardless of this patch, you might want to update your global git config
to use the proper name for your commits.

> commit b3a72384fe29 ("ARM/PCI: Replace
> pci_sys_data->align_resource with global function pointer") has
> introduced a global function pointer that makes the ARM specific
> code not portable and broken in case any platform have a two
> different HW IPs for the PCIe host bridge controller.
> This patch moves align_resource function pointer into
> pci_host_bridge structure so that the code is now suitable to be
> reworked as we want to get rid of hw_pci structure (the host bridge
> drivers can just set the align function pointer in the
> pci_host_bridge structure) and there is no more broken code for a
> SoC with two HW IPs.
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Thanks for doing this, that addresses my main concerns, and is probably
small enough to still get it into 4.4 if Bjorn agrees with the general
idea of putting more function pointers into struct pci_host_bridge.

As a follow-on to this, we can now try to get rid of pcibios_align_resource
by moving the existing per-architecture implementations in there as well,
with a reasonable default for the common case.

	Arnd
