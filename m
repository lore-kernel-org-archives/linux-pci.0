Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 22/25] PCI: tegra: Remove top-level resource from
 hierarchy
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-arm-kernel@lists.infradead.org
Date: Mon, 06 Jun 2016 18:07:28 -0500
Message-ID: <20160606230728.20936.53648.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

41534e53786d ("PCI: tegra: Implement a proper resource hierarchy") did two
things:

  1) It added a top-level resource that encloses all resources declared in
     the DT description, including registers and bridge apertures, and

  2) It requested the bridge apertures, which means the PCI core can track
     the resources used by PCI devices below the bridge.

The latter is necessary, but the former is questionable because there's no
guarantee that the bridge registers and the apertures are contiguous.  In
this example:

  # cat /proc/iomem
  00000000-3fffffff : /pcie-controller@00003000
    00000000-00000fff : /pcie-controller@00003000/pci@1,0
    00003000-000037ff : pads
    00003800-000039ff : afi
    10000000-1fffffff : cs

the resource tree claims that [mem 0x00003a00-0x0fffffff] is consumed by
/pcie-controller@00003000, but it's not mentioned in the DT, and it might
actually be used by other devices.

Remove the top-level resource so we don't claim more than the device
actually consumes.

This reintroduces the problem that we can't match the resources, e.g.,
"pads", "afi", "cs", etc., to the DT device.  I think this should be solved
by having the DT core request all resources of all devices in the DT (it
does not do that today).  If a driver claims the device, it can request the
resources it uses.  For example:

  # cat /proc/iomem
  00000000-00000fff : /pcie-controller@00003000
    00000000-00000fff : /pcie-controller@00003000/pci@1,0
  00003000-000037ff : /pcie-controller@00003000
    00003000-000037ff : pads
  00003800-000039ff : /pcie-controller@00003000
    00003800-000039ff : afi
  10000000-1fffffff : /pcie-controller@00003000
    10000000-1fffffff : cs
  ...

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index c388468..920a899 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -274,7 +274,6 @@ struct tegra_pcie {
 	struct list_head buses;
 	struct resource *cs;
 
-	struct resource all;
 	struct resource io;
 	struct resource pio;
 	struct resource mem;
@@ -623,7 +622,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	sys->mem_offset = pcie->offset.mem;
 	sys->io_offset = pcie->offset.io;
 
-	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->io);
+	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->io);
 	if (err < 0)
 		return err;
 
@@ -631,11 +630,11 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err < 0)
 		return err;
 
-	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->mem);
+	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->mem);
 	if (err < 0)
 		return err;
 
-	err = devm_request_resource(pcie->dev, &pcie->all, &pcie->prefetch);
+	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->prefetch);
 	if (err)
 		return err;
 
@@ -1822,12 +1821,6 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 	struct resource res;
 	int err;
 
-	memset(&pcie->all, 0, sizeof(pcie->all));
-	pcie->all.flags = IORESOURCE_MEM;
-	pcie->all.name = np->full_name;
-	pcie->all.start = ~0;
-	pcie->all.end = 0;
-
 	if (of_pci_range_parser_init(&parser, np)) {
 		dev_err(pcie->dev, "missing \"ranges\" property\n");
 		return -EINVAL;
@@ -1880,18 +1873,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			}
 			break;
 		}
-
-		if (res.start <= pcie->all.start)
-			pcie->all.start = res.start;
-
-		if (res.end >= pcie->all.end)
-			pcie->all.end = res.end;
 	}
 
-	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->all);
-	if (err < 0)
-		return err;
-
 	err = of_pci_parse_bus_range(np, &pcie->busn);
 	if (err < 0) {
 		dev_err(pcie->dev, "failed to parse ranges property: %d\n",
