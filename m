Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64115 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbG2Oa7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 10:30:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Ray Jui <rjui@broadcom.com>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm@kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] PCI: iproc: Fix BCMA dependency in Kconfig
Date: Wed, 29 Jul 2015 16:30:21 +0200
Message-ID: <33449873.RA3z6vhrMA@wuerfel>
In-Reply-To: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
References: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 28 July 2015 11:52:13 Ray Jui wrote:
>  config PCIE_IPROC_BCMA
>         bool "Broadcom iProc PCIe BCMA bus driver"
> -       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> +       depends on ARCH_BCM_IPROC && ARM
>         select PCIE_IPROC
>         select BCMA
>         select PCI_DOMAINS
> 

How about this:

	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)

That would leave the compile test present for non-iproc
ARM platforms while preventing ARM64 and MIPS builds with
ARCH_BCM_IPROC set.

	Arnd
