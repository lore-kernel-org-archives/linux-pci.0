Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 21 Jan 2016 18:22:18 +0000
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
Message-ID: <20160121182218.GA21175@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-14-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452691267-32240-14-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On Wed, Jan 13, 2016 at 02:20:59PM +0100, Tomasz Nowicki wrote:

[...]

> @@ -4796,14 +4797,34 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
>  	 * API and update the use_dt_domains value to keep track of method we
>  	 * are using to assign domain numbers (use_dt_domains = 0).
>  	 *
> +	 * IF ACPI, we expect non-DT method (use_dt_domains == -1)
> +	 * and call _SEG method for corresponding host bridge device.
> +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
> +	 * all PCI buses belong to domain 0.
> +	 *
>  	 * All other combinations imply we have a platform that is trying
> -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> -	 * which is a recipe for domain mishandling and it is prevented by
> -	 * invalidating the domain value (domain = -1) and printing a
> -	 * corresponding error.
> +	 * to mix domain numbers obtained from DT, ACPI and
> +	 * pci_get_new_domain_nr(), which is a recipe for domain mishandling and
> +	 * it is prevented by invalidating the domain value (domain = -1) and
> +	 * printing a corresponding error.
>  	 */
> +
>  	if (domain >= 0 && use_dt_domains) {
>  		use_dt_domains = 1;
> +#ifdef CONFIG_ACPI
> +	} else if (!acpi_disabled && use_dt_domains == -1) {
> +		struct acpi_device *acpi_dev = to_acpi_device(parent);
> +		unsigned long long segment = 0;
> +		acpi_status status;
> +
> +		status = acpi_evaluate_integer(acpi_dev->handle,
> +					       METHOD_NAME__SEG, NULL,
> +					       &segment);
> +		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> +			dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
> +
> +		domain = segment;
> +#endif

I think you can reshuffle a bit the code to make it easier to follow.

How about this ? (on top of mainline, I just compiled it do not
take it verbatim):

-- >8 --
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1a7105..467a316 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -7,6 +7,7 @@
  *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -4769,7 +4770,27 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+/* Feel free to add this to drivers/acpi as a helper */
+#ifdef CONFIG_ACPI
+int pci_bus_acpi_domain_nr(struct device *parent)
+{
+	struct acpi_device *acpi_dev = to_acpi_device(parent);
+	unsigned long long segment = 0;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(acpi_dev->handle,
+				       METHOD_NAME__SEG, NULL,
+				       &segment);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		dev_err(&acpi_dev->dev,  "can't evaluate _SEG\n");
+
+	return segment;
+}
+#else
+int pci_bus_acpi_domain_nr(struct device *parent) { return -1; }
+#endif
+
+int pci_bus_of_domain_nr(struct device *parent)
 {
 	static int use_dt_domains = -1;
 	int domain = of_get_pci_domain_nr(parent->of_node);
@@ -4811,7 +4832,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = acpi_disabled ? pci_bus_of_domain_nr(parent) :
+					 pci_bus_acpi_domain_nr(parent);
 }
 #endif
 #endif
