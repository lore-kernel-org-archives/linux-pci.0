Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64656 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaDVOLp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Apr 2014 10:11:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [RFC PATCH 2/2] PCI: exynos: Add PCIe support for Samsung GH7 SoC
Date: Tue, 22 Apr 2014 16:11:39 +0200
Cc: "'linux-pci'" <linux-pci@vger.kernel.org>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org,
	"'Liviu Dudau'" <Liviu.Dudau@arm.com>,
	"'Kukjin Kim'" <kgene.kim@samsung.com>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com> <000a01cf592e$67e592e0$37b0b8a0$%han@samsung.com>
In-Reply-To: <000a01cf592e$67e592e0$37b0b8a0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201404221611.40087.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 16 April 2014, Jingoo Han wrote:
> Samsung GH7 has four PCIe controllers which can be used as root
> complex for PCIe interface.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/Kconfig      |    2 +-
>  drivers/pci/host/pci-exynos.c |  135 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 126 insertions(+), 11 deletions(-)

Can you explain how much the GH7 and Exynos front-ends actually have in
common? Would it make sense to have a separate driver for gh7?

Also, if gh7 is expected to run a full firmware, I think you should
do all the setup in the firmware before booting Linux, and just
do the required run-time operations in the driver itself.

	Arnd
