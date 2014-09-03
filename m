Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35572 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbaICSce (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 14:32:34 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so18111874pad.21
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 11:32:33 -0700 (PDT)
Date: Wed, 3 Sep 2014 12:33:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH 0/4] PCI: designware: init order/resource alloc fixes
Message-ID: <20140903183302.GA26073@google.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 07:52:37PM +0200, Lucas Stach wrote:
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
>  drivers/pci/host/pcie-designware.c                 | 29 ++++++++++++++--------
>  drivers/pci/host/pcie-designware.h                 |  1 +
>  4 files changed, 24 insertions(+), 11 deletions(-)

Applied with Mohit's acks (and Richard's for [4/4]) to pci/host-designware
for v3.18, thanks!
