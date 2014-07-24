Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56974 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933524AbaGXKEm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 06:04:42 -0400
Message-ID: <1406196163.4590.21.camel@weser.hi.pengutronix.de>
Subject: Re: [RFC] PCI: pcie-designware: allow drivers as loadable modules
From: Lucas Stach <l.stach@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 24 Jul 2014 12:02:43 +0200
In-Reply-To: <5303286.K45Li7B92z@wuerfel>
References: <5303286.K45Li7B92z@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 24.07.2014, 11:17 +0200 schrieb Arnd Bergmann:
> From 0ee79c7451851a34e5a7c33eb6020befcdcb2b24 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 24 Jul 2014 11:12:48 +0200
> Subject: [PATCH] PCI: pcie-designware: allow drivers as loadable modules
> 
> The new pcie-spear13xx driver uses the pcie-designware library
> and in the current form it can be built as a loadable module.
> However, the functions it uses from the base driver are not exported,
> so this results in a build failure and a module that can never
> be loaded:
> 
> ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> 
> If we want to allow loadable pcie-designware drivers, we have to
> export all those symbols and ensure none of them are marked as __init.
> This also requires making pci_assign_unassigned_resources available
> after boot.

My series "PCI: designware: init order/resource alloc fixes" removes
this function call from pcie-designware, so if it get's accepted this
should not be necessary.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

