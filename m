Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 30 May 2017 11:47:26 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/1] ARM64/PCI: Set root bus NUMA node on ACPI systems
Message-ID: <20170530104725.GB32289@arm.com>
References: <20170524172219.5689-1-lorenzo.pieralisi@arm.com>
 <20170524172219.5689-2-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170524172219.5689-2-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
 Robert Richter <robert.richter@cavium.com>, Sinan Kaya <okaya@codeaurora.org>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 06:22:19PM +0100, Lorenzo Pieralisi wrote:
> PCI core requires the NUMA node for the struct pci_host_bridge.dev to
> be set by using the pcibus_to_node(struct pci_bus*) API, that on ARM64
> systems relies on the struct pci_host_bridge->bus.dev NUMA node.
> 
> The struct pci_host_bridge.dev NUMA node is then propagated through
> the PCI device hierarchy as PCI devices (and bridges) are enumerated
> under it.
> 
> Therefore, in order to set-up the PCI NUMA hierarchy appropriately, the
> struct pci_host_bridge->bus.dev NUMA node must be set before core
> code calls pcibus_to_node(struct pci_bus*) on it so that PCI core can
> retrieve the NUMA node for the struct pci_host_bridge.dev device and can
> propagate it through the PCI bus tree.
> 
> On ARM64 ACPI based systems the struct pci_host_bridge->bus.dev NUMA
> node can be set-up in pcibios_root_bridge_prepare() by parsing the root
> bridge ACPI device firmware binding.
> 
> Add code to the pcibios_root_bridge_prepare() that, when booting with
> ACPI, parse the root bridge ACPI device companion NUMA binding and set
> the corresponding struct pci_host_bridge->bus.dev NUMA node
> appropriately.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/pci.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, I'll queue this with Robert's tags.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
