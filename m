Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3KROnj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 09:43:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Date: Mon, 18 Nov 2013 15:43:32 +0100
Cc: Marek Vasut <marex@denx.de>, Jingoo Han <jg1.han@samsung.com>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	linux-pci@vger.kernel.org,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>
References: <52652BF1.4040507@ti.com> <201311151637.53867.marex@denx.de> <5289A9B8.3010408@ti.com>
In-Reply-To: <5289A9B8.3010408@ti.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311181543.32385.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 18 November 2013, Kishon Vijay Abraham I wrote:
> commit b91b61d594f293d994d87f10eb8a1a3b2e5f8977
> Author: Kishon Vijay Abraham I <kishon@ti.com>
> Date:   Wed Oct 30 14:51:58 2013 +0530
> 
>     pci: host: pcie-designware: Use *base-mask* for configuring the iATU
> 
>     In DRA7, the cpu sees 32bit address, but the pcie controller can see only 28bit
>     address. So whenever the cpu issues a read/write request, the 4 most
>     significant bits are used by L3 to determine the target controller.
>     For example, the cpu reserves 0x2000_0000 - 0x2FFF_FFFF for PCIe controller but
>     the PCIe controller will see only (0x000_0000 - 0xFFF_FFF). So for programming
>     the outbound translation window the base should be programmed as 0x000_0000.
>     Whenever we try to write to say 0x2000_0000, it will be translated to whatever
>     we have programmed in the translation window with base as 0x000_0000.
> 
>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Sorry I didn't see that patch earlier. Have you had a look at the definition of the
"dma-ranges" property? I think that is something we have already defined that can
handle this in a more generic way.

	Arnd
