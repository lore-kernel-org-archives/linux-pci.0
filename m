Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 4 Jul 2017 15:24:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
Message-ID: <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: DT <devicetree@vger.kernel.org>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 10:12:57AM +0200, Marc Gonzalez wrote:
> Marc Z pointed out that posting partial series is not ideal.
> Collect last-minute fixups into a single patch series.
> 
> - Bump series to v9 to avoid any ambiguity
> - Add Rob's Ack on patch 1
> 
> Marc Gonzalez (3):
>   PCI: Add DT binding for tango PCIe controller
>   PCI: Add tango PCIe host bridge support
>   PCI: Add tango MSI controller support
> 
>  .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
>  drivers/pci/host/Kconfig                           |   8 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++++++
>  include/linux/pci_ids.h                            |   2 +
>  5 files changed, 430 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-tango.c

I made the trivial changes I mentioned, added a dependency on
CONFIG_BROKEN (for the config/MMIO muxing issue), and put these on
pci/host-tango.  I can't build or test this, so I probably broke
something in the process.  I think the combination of the boot-time
warning, the taint, and CONFIG_BROKEN is a reasonable amount of
warning that a user should expect issues.

Can you take a look and see if it works for you?

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-tango

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
