Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 22 Jan 2016 11:25:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V3 13/21] pci, acpi: Provide generic way to assign bus
 domain number.
Message-ID: <20160122112536.GA2610@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-14-git-send-email-tn@semihalf.com>
 <20160121182218.GA21175@red-moon>
 <56A125BB.9040109@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A125BB.9040109@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 21, 2016 at 07:38:51PM +0100, Tomasz Nowicki wrote:

[...]

> >I think you can reshuffle a bit the code to make it easier to follow.
> >
> >How about this ? (on top of mainline, I just compiled it do not
> >take it verbatim):
> >
> >-- >8 --
> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >index d1a7105..467a316 100644
> >--- a/drivers/pci/pci.c
> >+++ b/drivers/pci/pci.c
> >@@ -7,6 +7,7 @@
> >   *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
> >   */
> >
> >+#include <linux/acpi.h>
> >  #include <linux/kernel.h>
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >@@ -4769,7 +4770,27 @@ int pci_get_new_domain_nr(void)
> >  }
> >
> >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> >-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >+/* Feel free to add this to drivers/acpi as a helper */
> >+#ifdef CONFIG_ACPI
> >+int pci_bus_acpi_domain_nr(struct device *parent)
> >+{
> >+	struct acpi_device *acpi_dev = to_acpi_device(parent);
> >+	unsigned long long segment = 0;
> >+	acpi_status status;
> >+
> >+	status = acpi_evaluate_integer(acpi_dev->handle,
> >+				       METHOD_NAME__SEG, NULL,
> >+				       &segment);
> >+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> >+		dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
> >+
> >+	return segment;
> >+}
> >+#else
> >+int pci_bus_acpi_domain_nr(struct device *parent) { return -1; }
> >+#endif
> >+
> >+int pci_bus_of_domain_nr(struct device *parent)
> >  {
> >  	static int use_dt_domains = -1;
> >  	int domain = of_get_pci_domain_nr(parent->of_node);
> >@@ -4811,7 +4832,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >  		domain = -1;
> >  	}
> >
> >-	bus->domain_nr = domain;
> >+	return domain;
> >+}
> >+
> >+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >+{
> >+	bus->domain_nr = acpi_disabled ? pci_bus_of_domain_nr(parent) :
> >+					 pci_bus_acpi_domain_nr(parent);
> >  }
> >  #endif
> >  #endif
> >
> 
> It looks nice, I will integrate your patch. Thanks!

While at it, as I mentioned, please move the ACPI helper function to
drivers/acpi, thanks.

Lorenzo
