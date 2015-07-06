Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34107 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbbGFX3N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2015 19:29:13 -0400
Received: by obbkm3 with SMTP id km3so117528920obb.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2015 16:29:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1435688121.git.dhdang@apm.com>
References: <46305464.n5SOjGAhJb@wuerfel> <cover.1435688121.git.dhdang@apm.com>
From: Duc Dang <dhdang@apm.com>
Date: Mon, 6 Jul 2015 16:28:43 -0700
Message-ID: <CADaLNDmpkdHT7B1fSEu9qtoVcj4ookvxh=BA4EUCvG=pp80s=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pci: xgene: Add multiple memory ranges support
To: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches <patches@apm.com>, Duc Dang <dhdang@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 30, 2015 at 11:22 AM, Duc Dang <dhdang@apm.com> wrote:
> This patch set adds 1 large (up to 64GB) memory window for each PCIe
> controller nodes in X-Gene device tree and fix PCIe controller driver
> to handle multiple memory ranges correctly. These changes are required
> to support PCIe devices that has huge BAR.
>
> v2 changes:
>         1. Separate device-tree changes and driver changes into different
>         patches
>         2. Explicitly define new large window as 64-bit prefetchable in dts
>         3. Use IORESOURCE_PREFETCH flag to determine which PCIe controller
>         register to be used to configure the memory ranges.
>
>  arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
>  drivers/pci/host/pci-xgene.c           | 12 ++++++++++--
>  2 files changed, 24 insertions(+), 11 deletions(-)

Hi Arnd, Bjorn,

Do you have additional comment on this v2 patch set?

>
> --
> 1.9.1
>

-- 
Regards,
Duc Dang.
