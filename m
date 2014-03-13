Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:47604 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaCMRlq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 13:41:46 -0400
Received: by mail-wi0-f169.google.com with SMTP id hm4so3890628wib.4
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 10:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201403061633.31260.marex@denx.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
	<1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
	<000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
	<201403061633.31260.marex@denx.de>
Date: Thu, 13 Mar 2014 10:41:45 -0700
Message-ID: <CAJ+vNU2XrAL+BTTB8i4hQhkZ_NfcS0VrWuHUjeFfU9hhGjNXbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when possible
From: Tim Harvey <tharvey@gateworks.com>
To: Marek Vasut <marex@denx.de>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-sh <linux-sh@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-tegra <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sascha Hauer <kernel@pengutronix.de>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 6, 2014 at 7:33 AM, Marek Vasut <marex@denx.de> wrote:
> On Thursday, March 06, 2014 at 03:47:03 AM, Jingoo Han wrote:
>> On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
>> > This is the recommended method of doing the IRQ
>> > mapping. For old devicetrees we fall back to the
>> > previous practice.
>> >
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> (+cc Mohit KUMAR, Richard Zhu, Pratyush Anand, Marek Vasut,
>>        Kishon Vijay Abraham I)
>>
>> Acked-by: Jingoo Han <jg1.han@samsung.com>
>>
>> It works properly on Exynos platform.
>> Thank you.
>
> Looks reasonable,
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>

I've tested this on the Gateworks Ventana products with P2P bridges
and with the patch I just submitted here:
http://thread.gmane.org/gmane.linux.kernel.pci/30017

Tested-by: Tim Harvey <tharvey@gateworks.com>

Tim
