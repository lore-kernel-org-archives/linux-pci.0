Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64004 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab3LPAyI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 19:54:08 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXV002GYJU6MP70@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 16 Dec 2013 09:54:06 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Harro Haan' <hrhaan@gmail.com>, 'Mohit Kumar' <mohit.kumar@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <hong-xing.zhu@freescale.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Juergen Beisert' <jbe@pengutronix.de>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Sean Cross' <xobs@kosagi.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131212182903.409515738@gmail.com>
In-reply-to: <20131212182903.409515738@gmail.com>
Subject: Re: [PATCH] pci: designware: fix missing msi irqs
Date: Mon, 16 Dec 2013 09:54:05 +0900
Message-id: <005b01cef9f9$52022bd0$f6068370$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 13, 2013 3:29 AM, Harro Haan wrote:
> 
> The interrupts were cleared after the irq handler was called.
> This means that new interrupts that occur after the handler handled
> the previous irq but before the interrupt is cleared will be missed.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <hong-xing.zhu@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

I was not able to reproduce the problem, however it looks
good. Also, there is no side effect on Exynos platform.

Mohit,
If you have some comments, please let us know.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

