Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62502 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3LLBFk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 20:05:40 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO003985P9BGD0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 10:05:33 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	spear-devel@list.st.com, 'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
In-reply-to: <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
Subject: Re: [PATCH 07/12] pcie: designware: add dw_pcie prefix before
 cfg_read/write
Date: Thu, 12 Dec 2013 10:05:33 +0900
Message-id: <002001cef6d6$423d7040$c6b850c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 6:39 PM, Mohit Kumar wrote:
> 
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> cfg_read/write function are designware pcie specific. Add dw_pcie prefix
> to avoid collision in global name space.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: spear-devel@list.st.com
> Cc: linux-pci@vger.kernel.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good. Also, I tested this patch on Exynos platform.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-exynos.c      |    5 +++--
>  drivers/pci/host/pcie-designware.c |   23 ++++++++++++++---------
>  drivers/pci/host/pcie-designware.h |    4 ++--
>  3 files changed, 19 insertions(+), 13 deletions(-)

