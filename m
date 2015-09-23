Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35542 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbbIWSkH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 14:40:07 -0400
Date: Wed, 23 Sep 2015 19:40:05 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] arm64/pci: Add quirks for Cavium Thunder PCI bridges.
Message-ID: <20150923184005.GX7356@arm.com>
References: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442966996-13419-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 01:09:56AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The Cavium ThunderX SoC needs a PCI quirk for its on-chip bridges.
> Since it is arm64, create a new quirks.c file there to contain arm64
> related quirks.  Add the ThunderX bridge quirk, gated by a new config
> variable, so that it can be disabled for kernels that aren't expected
> to be used on ThunderX.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/Kconfig         | 11 +++++++++++
>  arch/arm64/kernel/Makefile |  2 +-
>  arch/arm64/kernel/quirks.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/quirks.c

Why does this have to live in the arch/arm64/ directory? The quirks have
nothing to do with the architecture code.

Will
