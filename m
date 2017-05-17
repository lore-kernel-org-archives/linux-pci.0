Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 17 May 2017 16:56:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR
 configuration to be preserved
Message-ID: <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
 linux-pci@vger.kernel.org, will.deacon@arm.com, leif.lindholm@linaro.org,
 okaya@codeaurora.org, catalin.marinas@arm.com, bhelgaas@google.com,
 tn@semihalf.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 05:33:11PM +0100, Ard Biesheuvel wrote:
> This is a followup to the discussion regarding whether ACPI/arm64 systems
> should preserve the PCI configuration performed by the firmware, or always
> reconfigure it from scratch.
> 
> This series proposes to put it under the control of the firmware, by invoking
> the _DSM method, and preserving the firmware configuration only when it
> returns 0.
> 
> Patch #1 is a preparatory bugfix that solves the issue that I/O bridge
> windows starting at 0x0 are dismissed when looking for parent resources.
> 
> Patch #2 adds the logic to invoke the _DSM and claim the existing
> configuration rather than reallocate it from scratch if it returns '0'
> 
> Ard Biesheuvel (2):
>   drivers: pci: do not disregard parent resources starting at 0x0
>   arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup
> 
>  arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
>  drivers/pci/pci.c        |  2 +-
>  include/linux/pci-acpi.h |  7 ++++---
>  3 files changed, 23 insertions(+), 6 deletions(-)

I applied the first to pci/resource for v4.13.  I didn't do anything
with the second because I don't think we have consensus on what the
right thing to do is yet.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
