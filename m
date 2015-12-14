Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:60623 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbbLNIxV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 03:53:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 01/10] drivers/pci: make host/pci-imx6.c driver explicitly non-modular
Date: Mon, 14 Dec 2015 09:52:33 +0100
Message-ID: <1618604.7V7xXEyj55@wuerfel>
In-Reply-To: <1449970917-12633-2-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com> <1449970917-12633-2-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 12 December 2015 20:41:48 Paul Gortmaker wrote:
> The Kconfig for this option is currently:
> 
> config PCI_IMX6
>         bool "Freescale i.MX6 PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> Lets remove the couple traces of modularity, so that when reading the
> driver there is no doubt it is builtin-only.

Can you fix Kconfig instead?

	Arnd
