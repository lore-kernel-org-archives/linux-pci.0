Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:61475 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbLNIyq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 03:54:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 03/10] drivers/pci: make host/pci-mvebu.c explicitly non-modular
Date: Mon, 14 Dec 2015 09:54:12 +0100
Message-ID: <3739759.V0MRsvH5Tk@wuerfel>
In-Reply-To: <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com> <1449970917-12633-4-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 12 December 2015 20:41:50 Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_MVEBU
> drivers/pci/host/Kconfig:       bool "Marvell EBU PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.

Here too. I think we should really try to let all PCI host drivers be
loadable modules if possible. The module unload path is currently
a bit iffy because of the way it interacts with the arch/arm PCI
infrastructure, but we are in the process of fixing it.

For now, I think allowing all PCIe host drivers for ARM to be
loadable but non-removably modules would be ideal.

	Arnd
