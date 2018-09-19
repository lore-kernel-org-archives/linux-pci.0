Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Date: Wed, 19 Sep 2018 12:00:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919180003.GC28310@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
 <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 11:28:46AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> Since none of the service drivers can be modules, I don't think it
> buys us much to make their init functions initcalls.  Can we
> explicitly call them from the pcie_portdrv_probe() path?

It's actually during pcie_portdrv_init that the services need to be
initialized if we're going this way. Do you think the following is
better? The initialization order should be more clear to the reader at
the cost of more code than init call magic, but I'm okay having this
done either way.

---
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 68b20e667764..944047976569 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -287,7 +287,7 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 #endif	/* PM */
 };
 
-static int __init pcied_init(void)
+int __init pcie_hp_init(void)
 {
 	int retval = 0;
 
@@ -298,4 +298,3 @@ static int __init pcied_init(void)
 
 	return retval;
 }
-device_initcall(pcied_init);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180edd6ed4..637d638f73da 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1569,10 +1569,9 @@ static struct pcie_port_service_driver aerdriver = {
  *
  * Invoked when AER root service driver is loaded.
  */
-static int __init aer_service_init(void)
+int __init pcie_aer_init(void)
 {
 	if (!pci_aer_available() || aer_acpi_firmware_first())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
-device_initcall(aer_service_init);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f03279fc87cd..a1fd16bf1cab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -282,8 +282,7 @@ static struct pcie_port_service_driver dpcdriver = {
 	.reset_link	= dpc_reset_link,
 };
 
-static int __init dpc_service_init(void)
+int __init pcie_dpc_init(void)
 {
 	return pcie_port_service_register(&dpcdriver);
 }
-device_initcall(dpc_service_init);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3ed67676ea2a..1a8b85051b1b 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -446,8 +446,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 /**
  * pcie_pme_service_init - Register the PCIe PME service driver.
  */
-static int __init pcie_pme_service_init(void)
+int __init pcie_pme_init(void)
 {
 	return pcie_port_service_register(&pcie_pme_driver);
 }
-device_initcall(pcie_pme_service_init);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..2498b2d34009 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -23,6 +23,30 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   4
 
+#ifdef CONFIG_PCIEAER
+int pcie_aer_init(void);
+#else
+static inline int pcie_aer_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+int pcie_hp_init(void);
+#else
+static inline int pcie_hp_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_PCIE_PME
+int pcie_pme_init(void);
+#else
+static inline int pcie_pme_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_PCIE_DPC
+int pcie_dpc_init(void);
+#else
+static inline int pcie_dpc_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..23a5a0c2c3fe 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -226,11 +226,20 @@ static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
 	 {}
 };
 
+static void __init pcie_init_services(void)
+{
+	pcie_aer_init();
+	pcie_pme_init();
+	pcie_dpc_init();
+	pcie_hp_init();
+}
+
 static int __init pcie_portdrv_init(void)
 {
 	if (pcie_ports_disabled)
 		return -EACCES;
 
+	pcie_init_services();
 	dmi_check_system(pcie_portdrv_dmi_table);
 
 	return pci_register_driver(&pcie_portdriver);
--

> > --- 
> > diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> > index ccaf01e6eced..334044814dbe 100644
> > --- a/drivers/pci/hotplug/pciehp_core.c
> > +++ b/drivers/pci/hotplug/pciehp_core.c
> > @@ -322,4 +322,4 @@ static int __init pcied_init(void)
> >  
> >  	return retval;
> >  }
> > -device_initcall(pcied_init);
> > +subsys_initcall(pcied_init);
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 83180edd6ed4..1d2159409b01 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1575,4 +1575,4 @@ static int __init aer_service_init(void)
> >  		return -ENXIO;
> >  	return pcie_port_service_register(&aerdriver);
> >  }
> > -device_initcall(aer_service_init);
> > +subsys_initcall(aer_service_init);
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index f03279fc87cd..aacfb50eccfc 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -286,4 +286,4 @@ static int __init dpc_service_init(void)
> >  {
> >  	return pcie_port_service_register(&dpcdriver);
> >  }
> > -device_initcall(dpc_service_init);
> > +subsys_initcall(dpc_service_init);
> > diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> > index 3ed67676ea2a..cd8c1adb9b0a 100644
> > --- a/drivers/pci/pcie/pme.c
> > +++ b/drivers/pci/pcie/pme.c
> > @@ -450,4 +450,4 @@ static int __init pcie_pme_service_init(void)
> >  {
> >  	return pcie_port_service_register(&pcie_pme_driver);
> >  }
> > -device_initcall(pcie_pme_service_init);
> > +subsys_initcall(pcie_pme_service_init);
> > -- 
