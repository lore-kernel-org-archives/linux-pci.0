Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 0/3] PCI: Configure PCIe MPS settings
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 08 Feb 2017 16:08:46 -0600
Message-ID: <20170208215558.8352.90635.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jon.mason@broadcom.com>,
 Ray Jui <ray.jui@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 devel@linuxdriverproject.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core doesn't configure the PCIe MPS settings by itself.  Each host
bridge driver has to call pcie_bus_configure_settings() to make this
happen.

Jon fixed this for pcie-iproc.c.  I propose these similar patches for other
drivers.   

HV guys, I included you because create_root_hv_pci_bus() is one place that
calls pci_scan_child_bus() but does not call pcie_bus_configure_settings().
I know you probably don't strictly *need* to configure MPS settings in a
paravirtual front-end, but the PCI core does other device configuration in
this path:

  pci_scan_child_bus
    pci_scan_slot
      pci_scan_single_device
        pci_device_add
	  pci_configure_device
	  pci_init_capabilities

and I would like to eventually migrate the MPS configuration into that same
path.  Since we do this other configuration for HV devices already, I think
pcie_bus_configure_settings() should also work (even if it ends up not
doing anything to real devices).

It would make that eventual migration easier if all the
pci_scan_child_bus() callers had the same pattern of calling
pcie_bus_configure_settings().

So would it make sense to make a similar patch for HV?  It looks easy to
add it to create_root_hv_pci_bus(), but I don't know exactly what to do
about pci_devices_present_work().

---

Bjorn Helgaas (3):
      PCI: xilinx: Configure PCIe MPS settings
      PCI: versatile: Configure PCIe MPS settings
      PCI: xgene: Configure PCIe MPS settings


 drivers/pci/host/pci-versatile.c |    4 +++-
 drivers/pci/host/pci-xgene.c     |    4 +++-
 drivers/pci/host/pcie-xilinx.c   |    4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
