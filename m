Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58344 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab3LLBzC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 20:55:02 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO0036B7ZPH580@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 10:55:01 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
In-reply-to: <0f924b2ad771dd5c3486c81ed524a3f6e7d813b9.1386752447.git.mohit.kumar@st.com>
Subject: Re: [PATCH 11/12] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Thu, 12 Dec 2013 10:55:00 +0900
Message-id: <002601cef6dd$2adbdb60$80939220$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 6:39 PM, Mohit Kumar wrote:
> 
> Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8285ed4..fd03da6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6462,6 +6462,12 @@ L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/host/pci-exynos.c
> 
> +PCIE DRIVER FOR ST SPEAR13XX
> +M:	Mohit Kumar <mohit.kumar@st.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/pcie-spear13xx.c
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia@lists.infradead.org
> --
> 1.7.0.1

