Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49902 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbcBBIce (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 03:32:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Minghuan Lian <Minghuan.Lian@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
Date: Tue, 02 Feb 2016 09:32:05 +0100
Message-ID: <1640613.2DY3gpScUX@wuerfel>
In-Reply-To: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 02 February 2016 16:30:07 Minghuan Lian wrote:
> LS1021a contains two PCIe controllers. The patch adds their node to
> dts file.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

Looks ok to me, please submit to the ARM imx maintainers for merging.

	Arnd
