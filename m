Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55329 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3LKXeb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 18:34:31 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO00IPW1HI2950@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 08:34:30 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit Kumar' <mohit.kumar@st.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>, 'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	spear-devel@list.st.com, 'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
In-reply-to: <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
Subject: Re: [PATCH 08/12] pcie: designware: Fix IO transfers
Date: Thu, 12 Dec 2013 08:34:30 +0900
Message-id: <001601cef6c9$89d65eb0$9d831c10$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 6:39 PM, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> pp->io_base which is the input of the outbound IO address translation
> unit should be the cpu address, it was programmed wrongly to realio
> address.
> 
> We should pass global_io_offset rather than sys->io_offset to
> pci_ioremap_io, so we map the new window into the first available spot
> in the Linux view of the I/O space.
> 
> We must also pass cpu address instead  of realio address to
> pci_ioremap_io.
> 
> This patch fixes above issue. It has been tested with Lecroy PTC in AIC
> mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
> otherwise.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Cc: linux-pci@vger.kernel.org
> Cc: spear-devel@list.st.com

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

