Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33295 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbG1K4H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2015 06:56:07 -0400
Received: by lbbyj8 with SMTP id yj8so71957610lbb.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2015 03:56:06 -0700 (PDT)
Date: Tue, 28 Jul 2015 12:55:56 +0200
From: Olof Johansson <olof@lixom.net>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, arm@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add Broadcom North Star 2 support
Message-ID: <20150728105556.GA16025@localhost>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 03:42:17PM -0700, Ray Jui wrote:
> This patch series adds Broadcom North Star 2 (NS2) SoC support. NS2 is an ARMv8
> based SoC and under the Broadcom iProc family.
> 
> Sorry for tying this with the Broadcom iProc PCIe driver fixes for ARM64. I
> have to tie them together because iProc PCIe support is enabled by default
> when ARCH_BCM_IPROC is enabled. Without the fixes in the iProc PCIe driver,
> enabling CONFIG_ARCH_BCM_IPROC would break the build for arm64 defconfig. Let
> me know if there's a better way to handle this.

One common way to handle it is that instead of sitting on the patch to fix PCI
for months, you post that early such that when the rest is posted, it's been in
the kernel for a long time.

In practice, that's sometimes hard to do, but it's the ideal situation.

Anyway, I've queued up these patches for 4.3. Thanks!


-Olof

