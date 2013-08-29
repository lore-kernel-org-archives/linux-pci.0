Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:56136 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab3H2AlT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 20:41:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so164187pab.27
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 17:41:19 -0700 (PDT)
Message-ID: <521E98AA.1090308@gmail.com>
Date: Thu, 29 Aug 2013 08:41:14 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 0/4] PCIe Capability accessor fix and cleanups
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
In-Reply-To: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/29/2013 03:26 AM, Bjorn Helgaas wrote:
> The first patch fixes a Link Control issue reported by Yuval Mintz.
> The rest simplify the code a bit.
> 
> ---
> 
> Bjorn Helgaas (4):
>       PCI: Allow PCIe Capability link-related register access for switches
>       PCI: Remove PCIe Capability version checks
>       PCI: Support PCIe Capability Slot registers only for ports with slots
>       PCI: Remove pcie_cap_has_devctl()
> 
> 
>  drivers/pci/access.c |   26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
Hi Bjorn,
	Good changes! We avoid some unnecessary hardware accesses for
unavailable registers.

Reviewed-By: Jiang Liu <jiang.liu@huawei.com>
