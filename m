Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, patches@apm.com
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <56BB6EA0.7060706@arm.com>
Date: Wed, 10 Feb 2016 17:08:48 +0000
MIME-Version: 1.0
In-Reply-To: <1455069384-22323-1-git-send-email-dhdang@apm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/02/16 01:56, Duc Dang wrote:
> This patch makes pci-xgene-msi driver ACPI-aware and provides
> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Another nail on the ACPI "standardization" coffin, I suppose... Oh well.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
