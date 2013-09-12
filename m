Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13938 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3ILK0A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 06:26:00 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <002801ce8376$a807dbf0$f81793d0$@samsung.com>
 <51ED49D6.9050209@ti.com> <000701ce8741$fe47deb0$fad79c10$@samsung.com>
 <51EE22DF.6090902@ti.com> <001301ce8772$522dfc50$f689f4f0$@samsung.com>
 <5231607C.10702@ti.com> <003501ceaf87$cda45db0$68ed1910$%han@samsung.com>
 <20130912093018.GA2124@pratyush-vbox> <52318CCC.4040604@ti.com>
In-reply-to: <52318CCC.4040604@ti.com>
Subject: Re: [PATCH V3] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Thu, 12 Sep 2013 19:25:59 +0900
Message-id: <000701ceafa2$792d7cb0$6b887610$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 12, 2013 6:44 PM, Kishon Vijay Abraham I wrote:
> On Thursday 12 September 2013 03:00 PM, Pratyush Anand wrote:
> >
> > From this conversation, It seems that you
> > have tested this driver and it works fine without inbound translation
> > function. I am sure that you would have tested a PCIe card with DMA
> > capability such as PCIe2USB or PCIe2Ethernet. Since it worked, it
> > means that by default your controller is supporting one to one mapping
> > in case of inbound transaction even when address translation is enabled.
> 
> btw, I'm testing Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168B PCI Express Gigabit Ethernet controller.
> 
> when I do ifconfig eth0 up, I get *r8169 0000:01:00.0 eth0: link up.*
> But I dont receive any packets and ping also fails and the tx and rx packet
> count is also 0. Could it be related to inbound translation?
> 

Hi Kishon,

I have tested Ethernet controller: Intel Corporation 82574L PCI Express
Gigabit Ethernet controller.

Without inbound translation, it works properly with both legacy interrupt
mode and MSI mode.

Best regards,
Jingoo Han


