Return-Path: <SRS0=guer=7F=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=guer=7F=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Improve MSI alias detection
To: Robin Murphy <robin.murphy@arm.com>, helgaas@kernel.org
References: <63f5b8eef3c6d903bf97ca7fea0daa2e832be02f.1501610322.git.robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.daney@cavium.com, alex.williamson@redhat.com
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <f3e7a67e-9857-d75d-e06f-ba9de9935d59@arm.com>
Date: Thu, 3 Aug 2017 10:55:52 +0100
MIME-Version: 1.0
In-Reply-To: <63f5b8eef3c6d903bf97ca7fea0daa2e832be02f.1501610322.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 01/08/17 18:59, Robin Murphy wrote:
> Currently, we handle all DMA aliases equally when calculating MSI
> requester IDs for the generic infrastructure. This turns out to be the
> wrong thing to do in the face of pure DMA quirks like those of Marvell
> SATA cards, where in the usual case the last thing seen in the alias
> walk is the DMA phantom function: we end up configuring the MSI
> doorbell to expect that alias, then find we have no interrupts since
> the MSI writes still come from the 'real' RID, thus get filtered out
> and ignored.
> 
> Improve the alias walk to only account for the topological aliases that
> matter, based on the logic from the Intel IRQ remapping code.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
