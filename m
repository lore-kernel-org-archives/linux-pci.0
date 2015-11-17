Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37386 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbbKQTdy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Nov 2015 14:33:54 -0500
Message-ID: <564B811D.4000401@hauke-m.de>
Date: Tue, 17 Nov 2015 20:33:49 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com.com>,
	zajec5@gmail.com
Subject: Re: [PATCH] PCI: iproc: hide CONFIG_PCIE_IPROC
References: <11420214.lrdhuUq0ZO@wuerfel>
In-Reply-To: <11420214.lrdhuUq0ZO@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2015 05:08 PM, Arnd Bergmann wrote:
> PCIE_IPROC_BCMA does not require CONFIG_OF in Kconfig, but
> CONFIG_PCIE_IPROC does, so we can get a warning when building
> for an ARM platform without DT support:
> 
> warning: (PCIE_IPROC_PLATFORM && PCIE_IPROC_BCMA) selects PCIE_IPROC which has unmet direct dependencies (PCI && OF && (ARM || ARM64))
> 
> It turns out that CONFIG_PCIE_IPROC never needs to be enabled
> by a user anyway, we can simply rely on it being selected
> implictly through either PCIE_IPROC_PLATFORM or PCIE_IPROC_BCMA.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4785ffbdc9b5 ("PCI: iproc: Add BCMA PCIe driver")
> 

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks for spotting and fixing this.

hauke
