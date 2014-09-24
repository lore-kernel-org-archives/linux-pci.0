Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55741 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaIXQOo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 12:14:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Richter <rric@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sunil Goutham <sgoutham@cavium.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>
Subject: Re: [PATCH 5/6] arm64, defconfig: Enable PCI
Date: Wed, 24 Sep 2014 18:14:11 +0200
Message-ID: <7901403.qjKNmO519a@wuerfel>
In-Reply-To: <1411573068-12952-6-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org> <1411573068-12952-6-git-send-email-rric@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 24 September 2014 17:37:47 Robert Richter wrote:
>  config PCI
>         bool "PCI support"
> +       default y
>         help
>           This feature enables support for PCIe bus system. If you say Y
>           here, the kernel will include drivers and infrastructure code
>           to support PCIe bus devices.
>  
> +config PCI_MSI
> +       def_bool PCI
> +
>  config PCI_DOMAINS
>         def_bool PCI

There is already a PCI_MSI symbol in drivers/pci/Kconfig. Just select that
from the PCI symbol above rather than defining a second one.

	Arnd
