Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56550 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbbJOUkU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 16:40:20 -0400
MIME-Version: 1.0
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2015 15:39:56 -0500
Message-ID: <CAL_Jsq+8y=rZbpVfLEX2-chR-qy30sHozZS0ACL0hu2feDXF7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] of: Handle multi-parent version of msi-parent & msi-map
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 6, 2015 at 12:03 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Now that we have a useable and documented version of msi-parent that
> can deal with multiple parenting, we can properly handle it in the
> kernel. This leads to a new OF helper, some rework in the PCI and
> platform layers, as well as a small patch for the ITS driver, which is
> the only thing in the kernel requirering this functionality so far.
>
> On top of that, the msi-map property also offers a new feature, which
> is that ability to have a per-device MSI controller (instead of having
> a global one). The last four patches enable this.
>
> These patches are on top of David Daney's series:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/373986.html
>
> (of_msi_map_rid is a dependency), and has been tested on 4.3-rc3,
> using both platform and PCI MSI devices.
>
> * From the initial version
>   - Dropped the of parsing patch
>   - Built on top of David's series to reuse of_msi_map_rid
>   - New per-device PCI/MSI domain assignment hook
>   - Parse msi-map at bus probing time and populate the msi_domain field
>
> Marc Zyngier (8):
>   of/irq: Add support code for multi-parent version of "msi-parent"
>   of/irq: Use of_msi_get_domain instead of open-coded "msi-parent"
>     parsing
>   PCI/MSI: Use of_msi_get_domain instead of open-coded "msi-parent"
>     parsing
>   irqchip/gic-v3-its: Parse new version of msi-parent property
>   of/irq: Split of_msi_map_rid to reuse msi-map lookup
>   of/irq: Use the msi-map property to provide device-specific MSI domain
>   PCI: Add per-device MSI domain hook
>   PCI/MSI: Allow the MSI domain to be device-specific

For the series:

Acked-by: Rob Herring <robh@kernel.org>

I'm assuming Thomas is taking this and the dependency. It is mostly DT
code so I'm happy take it if you want.

Rob

>
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  18 ++-
>  drivers/of/irq.c                              | 151 ++++++++++++++++++++------
>  drivers/pci/msi.c                             |  17 +++
>  drivers/pci/of.c                              |  13 +--
>  drivers/pci/probe.c                           |  43 +++++++-
>  include/linux/msi.h                           |   6 +
>  include/linux/of_irq.h                        |  16 +++
>  7 files changed, 214 insertions(+), 50 deletions(-)
>
> --
> 2.1.4
>
