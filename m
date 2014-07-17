Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 Jul 2014 09:12:40 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: suravee.suthikulpanit@amd.com
Cc: marc.zyngier@arm.com, mark.rutland@arm.com, pawel.moll@arm.com,
	Catalin.Marinas@arm.com, Will.Deacon@arm.com, tglx@linutronix.de,
	Harish.Kasiviswanathan@amd.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4 V3] irqchip: gic: Restructuring ARM GIC code
Message-ID: <20140717131240.GL13108@titan.lakedaemon.net>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1404947104-21345-3-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404947104-21345-3-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 09, 2014 at 06:05:02PM -0500, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch restructures the code to prepare for future MSI support.
> It moves the declaration of structures and functions into the header file,
> and omit the static prefix.
> 
> Since we are planing to have different irq_chip for GICv2m, the patch adds
> irq_chip pointer in the gic_chip_data which is initialized during probing phase.
> 
> This should not have any functional changes.
> 
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  drivers/irqchip/irq-gic.c | 65 +++++++++++++++++++++--------------------------
>  drivers/irqchip/irq-gic.h | 52 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic.h

Applied to irqchip/gic.  With a dependency on irqchip/urgent for

  144cb08864ed irqchip: gic: Add binding probe for ARM GIC400

As a result, I had to hand-jam the last hunk for irq-gic.c.  Please
double-check my work.

thx,

Jason.
