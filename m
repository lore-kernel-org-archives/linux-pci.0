Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34794 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbE0OSl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 10:18:41 -0400
Received: by pdbki1 with SMTP id ki1so17207637pdb.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2015 07:18:40 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Yijing Wang'" <wangyijing@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>, "'Daniel Axtens'" <dja@axtens.net>,
	"'Arnd Bergmann'" <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Mohit Kumar'" <mohit.kumar@st.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Lucas Stach'" <l.stach@pengutronix.de>
Subject: Re: [PATCH Part1 v11 3/5] PCI: designware: Use pci_scan_root_bus() for simplicity
Date: Wed, 27 May 2015 23:18:37 +0900
Message-ID: <000301d09888$09d01370$1d703a50$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 28 Apr 2015 15:01:37 +0800, Yijing Wang wrote:

> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> Now pci_scan_root_bus() == pci_create_root_bus() +
> pci_scan_child_bus() if busn resource is supplied.
> Designware added the busn resource to resources list
> in dw_pcie_setup(). So it should be safe to use
> pci_scan_root_bus() instead.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Mohit Kumar <mohit.kumar@st.com>
> CC: Jingoo Han <jg1.han@samsung.com>

+cc: Pratyush Anand, Lucas Stach

Acked-by: Jingoo Han <jingoohan1@gmail.com>

> ---
>  drivers/pci/host/pcie-designware.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

