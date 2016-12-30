Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 02:40:45 +0100
Message-ID: <2678604.V2vzbbOmVS@aspire.rjw.lan>
In-Reply-To: <ee766ef2-04a0-9014-9b82-5c507665ba5a@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <2589829.sCArIQeDWm@aspire.rjw.lan> <ee766ef2-04a0-9014-9b82-5c507665ba5a@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 01:45:53 AM Kilian Singer wrote:
> The touchpad and builtin keyboard of laptop fail.
> But also connected usb keyboard and usb mouse fail.
> 
> In both cases mouse pointer is still moveable.

It may just be too late to turn the ports "on" once they have been suspended at
least once on your system.

Please check if the appended patch makes any difference.

Thanks,
Rafael


---
 drivers/pci/pcie/portdrv_pci.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-pm/drivers/pci/pcie/portdrv_pci.c
@@ -160,7 +160,6 @@ static int pcie_portdrv_probe(struct pci
 		pm_runtime_use_autosuspend(&dev->dev);
 		pm_runtime_mark_last_busy(&dev->dev);
 		pm_runtime_put_autosuspend(&dev->dev);
-		pm_runtime_allow(&dev->dev);
 	}
 
 	return 0;
@@ -169,7 +168,6 @@ static int pcie_portdrv_probe(struct pci
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
 	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
