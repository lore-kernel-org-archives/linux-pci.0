Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62463 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbGNVBT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 17:01:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH 4/4] arm64: dts: Add Broadcom North Star 2 support
Date: Tue, 14 Jul 2015 23:01:11 +0200
Message-ID: <2107639.2a3PGefz8c@wuerfel>
In-Reply-To: <1436837955-26279-5-git-send-email-rjui@broadcom.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com> <1436837955-26279-5-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 13 July 2015 18:39:15 Ray Jui wrote:

> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x66130000";
> +	};
> +

Please remove those bootargs and just set the stdout-path to the alias
of the uart. If necessary, you can have just "earlycon" in the bootargs.

	Arnd
