Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52861 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaKEJZE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Nov 2014 04:25:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v6] PCI: Layerscape: Add Layerscape PCIe driver
Date: Wed, 05 Nov 2014 10:24:56 +0100
Message-ID: <13483534.gsaDiXRS9D@wuerfel>
In-Reply-To: <1415177111-28730-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1415177111-28730-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 05 November 2014 16:45:11 Minghuan Lian wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
