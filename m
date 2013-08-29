Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27472 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab3H2IKE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 04:10:04 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSA00D3D9AVM2F0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 29 Aug 2013 17:10:02 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, linux-pci@vger.kernel.org
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001c01cea3e5$37716660$a6543320$%jun@samsung.com>
In-reply-to: <001c01cea3e5$37716660$a6543320$%jun@samsung.com>
Subject: Re: [PATCH 1/3] PCI: dw_pcie: amend I/O access functions
Date: Thu, 29 Aug 2013 17:10:01 +0900
Message-id: <001101cea48f$29417f80$7bc47e80$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 28, 2013 8:54 PM, Seungwon Jeon wrote:
> 
> This changes puts the 'dbi_base' into dw_pcie_readl_rc/
> dw_pcie_writel_rc. So usage of these funcions doesn't
> need to consider I/O base adddress anymore.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

CC'ed Pratyush Anand, Mohit KUMAR, Kishon Vijay Abraham I

Thank you for sending the patch.
It looks good. Also, I tested this patch on Exynos5440.

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c |  135 +++++++++++++++---------------------
>  1 files changed, 55 insertions(+), 80 deletions(-)
>

