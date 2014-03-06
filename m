Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47352 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbaCFPdi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 10:33:38 -0500
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when possible
Date: Thu, 6 Mar 2014 16:33:31 +0100
Cc: "'Lucas Stach'" <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Simon Horman'" <horms@verge.net.au>,
	"'Shawn Guo'" <shawn.guo@linaro.org>,
	"'Stephen Warren'" <swarren@wwwdotorg.org>,
	"'Ben Dooks'" <ben-linux@fluff.org>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>,
	"'Thierry Reding'" <thierry.reding@gmail.com>,
	"'Arnd Bergmann'" <arnd@arndb.de>, kernel@pengutronix.de,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Richard Zhu'" <r65037@freescale.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de> <1394025951-32438-7-git-send-email-l.stach@pengutronix.de> <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
In-Reply-To: <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201403061633.31260.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, March 06, 2014 at 03:47:03 AM, Jingoo Han wrote:
> On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> (+cc Mohit KUMAR, Richard Zhu, Pratyush Anand, Marek Vasut,
>        Kishon Vijay Abraham I)
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> It works properly on Exynos platform.
> Thank you.

Looks reasonable,

Reviewed-by: Marek Vasut <marex@denx.de>

+CC Troy if he wants to test it on SL/N6X .

Best regards,
Marek Vasut
