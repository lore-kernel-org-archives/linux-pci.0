Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41357 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbaGWSJD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 14:09:03 -0400
From: Marek Vasut <marex@denx.de>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 0/4] PCI: designware: init order/resource alloc fixes
Date: Wed, 23 Jul 2014 20:08:56 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201407232008.56208.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 23, 2014 at 07:52:37 PM, Lucas Stach wrote:
> This series fixes a couple of issues with the initialisation
> ordering and ressource allocation handling in the designware
> driver and moves its behavior much closer to other PCI host
> controller drivers like MVEBU and Tegra.
> For more detailed explanation see the commit messages.
> 
> This effectively enables the i.MX6 pcie driver to be
> probed from module initcall level, instead of relying on
> being probed early.
> 
> Lucas Stach (4):
>   PCI: designware: start parsing bus-range
>   PCI: designware: get rid of pci_scan_root_bus
>   PCI: designware: remove pci_assign_unassigned_resources call
>   PCI: imx6: move to module_init
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |  3 +++
>  drivers/pci/host/pci-imx6.c                        |  2 +-
>  drivers/pci/host/pcie-designware.c                 | 29
> ++++++++++++++-------- drivers/pci/host/pcie-designware.h                
> |  1 +
>  4 files changed, 24 insertions(+), 11 deletions(-)

Looks reasonable, thanks

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
