Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbaIWJSl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 05:18:41 -0400
Message-ID: <1411463916.3256.4.camel@pengutronix.de>
Subject: Re: [PATCH v2]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl
 sabreauto.
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Tue, 23 Sep 2014 11:18:36 +0200
In-Reply-To: <1411445498-20250-1-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

Am Dienstag, den 23.09.2014, 12:11 +0800 schrieb Richard Zhu:
> Hi Tim:
> After I changed the wait clocks stabilize delay after pcie_ref_en is set
> in this patch-set.
> Can you help to make a double check whether it's ok or not at your side?
> 
> Thanks in advanced.
> 
I'll go through this series today. Please give me some time to properly
comment on every patch before posting a new version of the series.
Thanks.

> Main changes since the v1:
> 1. Regarding to Lucas' comments, seperated the enalbe pcie on
> imx6qdl sabreauto patch.
> 2. Add the description why the wait clock stabilize delay should
> be run after pcie_ref_en is set.
> 3. Return 0 directly in suspend call back.
> 
> Main changes since the RFC:
> Thanks for quick review from Lucas.
> 1. seperate the smashed patch-set.
> 2. remove the "power-on-gpio".
> 3. add/update the pcie-supply of the dts and binding.
> 4. 
> 
> [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
> [PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after ref_en
> [PATCH v2 3/5] PCI: imx6: update dts and binding for imx6sx pcie
> [PATCH v2 4/5] PCI: imx6: add imx6sx pcie related gpr bits
> [PATCH v2 5/5] PCI: imx6: add imx6sx pcie support

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

