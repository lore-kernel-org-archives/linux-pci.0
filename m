Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 17 May 2017 16:53:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 2/2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20170517215348.GI31462@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170411163313.18577-3-ard.biesheuvel@linaro.org>
 <20170412172623.GA11570@red-moon>
 <0b453fdf-8f25-8ee8-678d-996dbf2f3e48@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <0b453fdf-8f25-8ee8-678d-996dbf2f3e48@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, graeme.gregory@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, leif.lindholm@linaro.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, tn@semihalf.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 12, 2017 at 02:03:25PM -0400, Sinan Kaya wrote:
> On 4/12/2017 1:26 PM, Lorenzo Pieralisi wrote:
> >> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
> >> +		/* preserve existing resource assignment */
> >> +		pci_bus_claim_resources(bus);
> > Ok. By the PCI FW specs, we should also assign unassigned resources here
> > (ie resources that can't be claimed). Furthermore, by the PCI FW spec,
> > if !obj this is the path we should be taking (PCI firmware specification
> > Rev 3.1, 4.6.5, Description: 0:)
> > 
> > "...This situation is the same as the legacy situation where this
> > _DSM is not provided."
> > 
> > which makes me think that the PCI FW specification expects FW set-up
> > to be claimed on boot, it is my interpretation.

I read that section as saying "if the _DSM doesn't exist, or if the
_DSM returns 0, the OS must preserve any BAR and bridge window
assignments done by firmware."

I was not aware of any other statement that restricted the OS from
changing assignments done by firmware, and I've always assumed that
the OS completely owns PCI devices after handoff from firmware.  But
maybe my assumption has been wrong.  And I know there are BIOSes that
do assume the OS doesn't change things, e.g., for the HP iLO, which is
used by runtime firmware.

The _DSM is generic, not arm64-specific, so if we add support for it,
I'd like to at least evaluate the _DSM in the generic code somewhere,
e.g., in drivers/pci/pci-acpi.c where we evaluate it for other
function indices.

Maybe we will still need arch-specific code to use the generic
knowledge.  Or maybe we should add x86 code to prevent reassignment
unless this _DSM returns 1, although that might break some of the
"pci=realloc" scenarios.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
