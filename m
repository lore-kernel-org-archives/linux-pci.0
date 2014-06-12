Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45636 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932784AbaFLJ4s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jun 2014 05:56:48 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N71003V6VMLEF00@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Jun 2014 18:56:46 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Cc: 'Jason Cooper' <jason@lakedaemon.net>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH 0/4] proper multi MSI handling for designware host
Date: Thu, 12 Jun 2014 18:56:45 +0900
Message-id: <000101cf8624$9ea82cc0$dbf88640$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 05, 2014 11:46 PM, Lucas Stach wrote:
> 
> This series implements multiple MSI setup and teardown in terms
> of the msichip infrastructure for the designware host controller.
> It removes quite a bit of homegrown multi MSI handling from the
> driver, which I suspect wasn't really tested before.
> 
> The series is currently based on pci/next.
> 
> Functionality was tested with an FPGA connected to an i.MX6 SoC.
> I have verified that the FPGA is able to trigger the second MSI
> and the irq is properly routed into the driver.

(+cc Marek Vasut, Richard Zhu, Kishon Vijay Abraham I, Pratyush Anand)

Hi Lucas Stach,

As usual, this is a good job! :-)
I tested these patches on Exynos5440 platform with 2 LAN cards.
It works properly. I have no objection about these patches.
However, I hope that others will test with their platform.
I will review your patches. Thank you.

Best regards,
Jingoo Han
> 
> Lucas Stach (4):
>   PCI: allow MSI chip providers to implement their own multiple MSI
>     setup
>   PCI: designware: remove bogus multiple MSI setup
>   PCI: designware: remove open-coded bitmap operations
>   PCI: designware: implement multiple MSI irq setup
> 
>  drivers/pci/host/pcie-designware.c | 141 +++++++++++++++----------------------
>  drivers/pci/msi.c                  |   3 +
>  include/linux/msi.h                |   2 +
>  3 files changed, 63 insertions(+), 83 deletions(-)
> 
> --
> 2.0.0.rc2

