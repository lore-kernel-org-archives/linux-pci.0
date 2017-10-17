Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 17 Oct 2017 12:05:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Khuong Dinh <kdinh@apm.com>
Subject: Re: [PATCH v4 pci 0/2] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
Message-ID: <20171017170529.GC5641@bhelgaas-glaptop.roam.corp.google.com>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
MIME-Version: 1.0
In-Reply-To: <1506448161-30961-1-git-send-email-kdinh@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, linux-pci@vger.kernel.org,
 msalter@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 patches@apm.com, jcm@redhat.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 11:49:19AM -0600, Khuong Dinh wrote:
> This patch set enables ACPI MSI support for X-Gene PCIe v1 hardware
> and provides the proper MSI driver initialization ordering.
> 
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> ---
> v4:
>  - Remove Marc Zyngier ACK in v2
>  - Use acpi_bus_scan on MSI controller handle when MSI device is found
>  - Register ACPI MSI driver when MSI device is found instead of using
>  subsys_initcall
>  - Split ACPI MSI driver support into two patches - one to enable MSI
> support for X-Gene PCIe v1 hardware, one to enforce MSI driver loaded
> before PCIe controller driver in ACPI boot mode
> v3:
>  - Input X-Gene MSI base address for irq_domain_alloc_fwnode
>  - Add a hook to enforce X-Gene MSI be probed prior acpi_bus_scan happens
> v2:
>  - Verify with BIOS version 3.06.25 and 3.07.09
> v1:
>  - Initial version
> ---
> 
> Khuong Dinh (2):
>   PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot for X-Gene v1
>   PCI/MSI: Enforce MSI driver loaded before PCIe in ACPI boot
> 
>  drivers/acpi/Makefile            |    2 +-
>  drivers/acpi/acpi_msi.c          |   86 ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/acpi_platform.c     |    3 +-
>  drivers/acpi/internal.h          |    1 +
>  drivers/acpi/scan.c              |    1 +
>  drivers/pci/host/pci-xgene-msi.c |   60 ++++++++++++++++++++++++--
>  include/linux/acpi_msi.h         |   37 ++++++++++++++++
>  7 files changed, 183 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/acpi/acpi_msi.c
>  create mode 100644 include/linux/acpi_msi.h

The changelogs don't really give the nitty-gritty details of the
problem, e.g., apparently the host bridge and the MSI controller are
enumerated as two separate devices and there's an ordering issue with
binding drivers to them.

They should also contrast the X-Gene situation with other systems so we
can see why X-Gene has this problem when other systems don't.

I'm not thrilled about all the ACPI code this adds, but I'm guessing
there'll be some better solution eventually.

I'm going to mark these as "changes requested" even though I haven't
asked for anything specific to be changed because it sounds like
Lorenzo et al. may have more concrete proposals soon.

Are there currently systems that do not work and need to be fixed
ASAP?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
