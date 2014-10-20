Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0131.outbound.protection.outlook.com ([157.56.110.131]:14656
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751544AbaJTC4i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Oct 2014 22:56:38 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Richard Zhu <richard.zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Shengchao Guo <Shawn.Guo@freescale.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH v7]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl
 sabreauto.
Date: Mon, 20 Oct 2014 02:56:34 +0000
Message-ID: <44da9c35cc5c4bebbe2b917aaef63a0a@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413771556-32212-1-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just received and saw the patch-01 and patch-02 review comment marked by Lucas.
Please ignore this serial patch, since the patch-01 and patch-02 review-comments are
not added into.

Best Regards
Richard Zhu


> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Richard Zhu
> Sent: Monday, October 20, 2014 10:19 AM
> To: linux-pci@vger.kernel.org
> Cc: Guo Shawn-R65073; festevam@gmail.com; l.stach@pengutronix.de;
> tharvey@gateworks.com
> Subject: [PATCH v7]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabreauto.
> 
> Main changes since the v6:
> 1. Regarding to Lucas' suggestion, assert per-reset in suspend, and de-assert
> it in resume. Thanks Lucas.
> 
> [PATCH v7 01/13] PCI: designware: Refine setup_rc and add msi data [PATCH v7
> 02/13] PCI: designware: Set func type of host init to int [PATCH v7 03/13] PCI:
> dra7xx: Change the func type of host init [PATCH v7 04/13] PCI: exynos: Change
> the func type of host init [PATCH v7 05/13] PCI: spear: Change the func type
> of host init [PATCH v7 06/13] PCI: designware: Fix one potential assignment
> error [PATCH v7 07/13] ARM: imx6sx: Add imx6sx pcie related gpr bits [PATCH v7
> 08/13] PCI: imx6: Wait the clocks to stabilize after ref_en [PATCH v7 09/13]
> PCI: imx6: Add imx6sx pcie support [PATCH v7 10/13] ARM: imx6qdl: Enable pcie
> on imx6qdl sabreauto [PATCH v7 11/13] ARM: imx6: Update dts and binding for
> imx6sx pcie [PATCH v7 12/13] ARM: imx6sx: Add syscon into gpc dts [PATCH v7
> 13/13] ARM: imx6sx: Enable pcie on imx6sx sdb board
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
