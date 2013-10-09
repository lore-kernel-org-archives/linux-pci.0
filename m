Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52683 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab3JIHun (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 03:50:43 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUE002IV5RXSWK0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 09 Oct 2013 16:50:37 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-reply-to: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
Date: Wed, 09 Oct 2013 16:50:36 +0900
Message-id: <000301cec4c4$3dc751f0$b955f5d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 08, 2013 9:05 AM, Bjorn Helgaas wrote:
> 
> The following variables and functions are used only in pcie-designware.c,
> so make them static:
> 
>   global_io_offset
>   dw_pcie_rd_own_conf()
>   dw_pcie_wr_own_conf()
>   dw_pcie_setup()
>   dw_pcie_scan_bus()
>   dw_pcie_map_irq()
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good.
Also I tested this patch on Exynos5440. It works properly.
Thank you for sending the patch.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c |   16 ++++++++--------
>  drivers/pci/host/pcie-designware.h |    7 -------
>  2 files changed, 8 insertions(+), 15 deletions(-)

