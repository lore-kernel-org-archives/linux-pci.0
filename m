Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61231 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbaLLRdx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Dec 2014 12:33:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
Date: Fri, 12 Dec 2014 18:33:14 +0100
Message-ID: <1671186.DiHNtkP1SP@wuerfel>
In-Reply-To: <1418404441-5518-6-git-send-email-svarbanov@mm-sol.com>
References: <1418404441-5518-1-git-send-email-svarbanov@mm-sol.com> <1418404441-5518-6-git-send-email-svarbanov@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 12 December 2014 19:14:01 Stanimir Varbanov wrote:
> +config ARCH_APQ8084
> +       bool "Enable support for APQ8084"
> +       select HAVE_ARM_ARCH_TIMER
> +       select PCI
> +       select PCI_DOMAINS
> +       select PCI_MSI
> +

I would prefer not to see 'select PCI' here. Also the driver is written
to work without PCI_MSI, so I'd be much happier with just

config ARCH_APQ8084
	bool "Enable support for APQ8084"
	select HAVE_ARM_ARCH_TIMER
	select PCI_DOMAINS if PCI

but you could even drop the last line if it's possible that some machines
enable only one host bridge.

	Arnd
