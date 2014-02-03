Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22849 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbaBCAJA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2014 19:09:00 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0E00J6D8EYSN90@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 03 Feb 2014 09:08:58 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>, arnd@arndb.de
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <839dacd5c1f0ea125d2f243968783a4c7a66c881.1391077731.git.mohit.kumar@st.com>
In-reply-to: <839dacd5c1f0ea125d2f243968783a4c7a66c881.1391077731.git.mohit.kumar@st.com>
Subject: Re: [PATCH V3 8/8] MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
Date: Mon, 03 Feb 2014 09:08:58 +0900
Message-id: <000401cf2074$226f2c00$674d8400$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 30, 2014 7:49 PM, Mohit Kumar wrote:
> 
> Add Mohit Kumar as maintainer for ST SPEAr13xx PCIe driver.
> 
> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> Cc: linux-pci@vger.kernel.org
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

