Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:30886
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753257AbaFXTtG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 15:49:06 -0400
Message-ID: <53A98687.7090408@amd.com>
Date: Tue, 24 Jun 2014 09:09:11 -0500
From: Joel Schopp <joel.schopp@amd.com>
MIME-Version: 1.0
To: <suravee.suthikulpanit@amd.com>, <marc.zyngier@arm.com>,
	<Catalin.Marinas@arm.com>, <Will.Deacon@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've been running and doing development on top of these patches.  I 
found a problem in an earlier version that i can confirm is now fixed in 
this current version.

Reviewed-by: Joel Schopp <joel.schopp@amd.com>

On 06/23/2014 07:32 PM, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>
> This patch set introduces support for MSI(-X) in GICv2m specification,
> which is implemented in some variation of GIC400.
>
> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
> (https://lkml.org/lkml/2014/3/14/320).
>
> Suravee Suthikulpanit (2):
>    arm/gic: Add binding probe for GIC400
>    arm/gic: Add supports for GICv2m MSI(-X)
>
>   Documentation/devicetree/bindings/arm/gic.txt |  18 +-
>   drivers/irqchip/Kconfig                       |   6 +
>   drivers/irqchip/Makefile                      |   1 +
>   drivers/irqchip/gic-msi-v2m.c                 | 249 ++++++++++++++++++++++++++
>   drivers/irqchip/gic-msi-v2m.h                 |  20 +++
>   drivers/irqchip/irq-gic.c                     |  23 ++-
>   6 files changed, 313 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/irqchip/gic-msi-v2m.c
>   create mode 100644 drivers/irqchip/gic-msi-v2m.h
>

