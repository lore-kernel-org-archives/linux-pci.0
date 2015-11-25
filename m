Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Bugfix] x86/PCI: Fix regression caused by commit 4d6b4e69a245
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
References: <1447648057-13644-1-git-send-email-jiang.liu@linux.intel.com>
 <20151124164907.GA24819@localhost>
 <CAJZ5v0irOUq6C9eSfCfmzyOiY1n1rUSxyUeUbvS9Nj0jNT2JrQ@mail.gmail.com>
 <20151124230413.GA11608@localhost.localdomain>
 <5655019C.7070700@internode.on.net> <565570E5.5080906@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	x86@kernel.org
From: Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <565589A7.50104@internode.on.net>
Date: Wed, 25 Nov 2015 20:42:55 +1030
MIME-Version: 1.0
In-Reply-To: <565570E5.5080906@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Jiang Liu wrote on 25/11/15 18:57:

> Hi Arthur,
> 	Thanks for reminder again!
> It's a little strange, the formal patch "[Bugfix] x86/PCI: Fix
> regression caused by commit 4d6b4e69a245" is based on the debug patch
> I sent to you at 9 November 2015.
> 	Could you please help to try the attached patch again?
> Thanks,
> Gerry

OK, I'm booting alright now with git diff reporting the following (just 
the patch that Jiang Liu posted in the parent):

diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 7bcf06a..6eb3c8a 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -50,18 +50,9 @@ void x86_pci_root_bus_resources(int bus, struct 
list_head *resources)
  	if (!found)
  		pci_add_resource(resources, &info->busn);

-	list_for_each_entry(root_res, &info->resources, list) {
-		struct resource *res;
-		struct resource *root;
+	list_for_each_entry(root_res, &info->resources, list)
+		pci_add_resource(resources, &root_res->res);

-		res = &root_res->res;
-		pci_add_resource(resources, res);
-		if (res->flags & IORESOURCE_IO)
-			root = &ioport_resource;
-		else
-			root = &iomem_resource;
-		insert_resource(root, res);
-	}
  	return;

  default_resources:
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 850d7bf..ae3fe4e 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -768,6 +768,13 @@ static void pci_acpi_root_add_resources(struct 
acpi_pci_root_info *info)
  		else
  			continue;

+		/*
+		 * Some legacy x86 host bridge drivers use iomem_resource and
+		 * ioport_resource as default resource pool, skip it.
+		 */
+		if (res == root)
+			continue;
+
  		conflict = insert_resource_conflict(root, res);
  		if (conflict) {
  			dev_info(&info->bridge->dev,
####


There have been at least two gcc-5 updates on this machine since 
originally reporting the problem so that may have affected results.

Thanks to all for help with this.

Arthur.
