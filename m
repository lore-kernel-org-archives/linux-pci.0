Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161109141948.19244-2-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-2-lorenzo.pieralisi@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Nov 2016 00:37:04 +0100
Message-ID: <CAJZ5v0iRwh3T8U6JeDgWSMX4hbuvo21KGh7MV__=DCVMMefsTQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/16] drivers: acpi: add FWNODE_ACPI_STATIC fwnode type
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Eric Auger <eric.auger@redhat.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Dennis Chen <dennis.chen@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On systems booting with a device tree, every struct device is associated
> with a struct device_node, that provides its DT firmware representation.
> The device node can be used in generic kernel contexts (eg IRQ
> translation, IOMMU streamid mapping), to retrieve the properties
> associated with the device and carry out kernel operations accordingly.
> Owing to the 1:1 relationship between the device and its device_node,
> the device_node can also be used as a look-up token for the device (eg
> looking up a device through its device_node), to retrieve the device in
> kernel paths where the device_node is available.
>
> On systems booting with ACPI, the same abstraction provided by
> the device_node is required to provide look-up functionality.
>
> The struct acpi_device, that represents firmware objects in the
> ACPI namespace already includes a struct fwnode_handle of
> type FWNODE_ACPI as their member; the same abstraction is missing
> though for devices that are instantiated out of static ACPI tables
> entries (eg ARM SMMU devices).
>
> Add a new fwnode_handle type to associate devices created out
> of static ACPI table entries to the respective firmware components
> and create a simple ACPI core layer interface to dynamically allocate
> and free the corresponding firmware nodes so that kernel subsystems
> can use it to instantiate the nodes and associate them with the
> respective devices.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
