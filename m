Return-Path: <SRS0=FCq+=C5=free-electrons.com=cyrille.pitchen@kernel.org>
Return-Path: <SRS0=FCq+=C5=free-electrons.com=cyrille.pitchen@kernel.org>
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, adouglas@cadence.com, stelford@cadence.com,
 dgary@cadence.com, kgopi@cadence.com, eandrews@cadence.com,
 thomas.petazzoni@free-electrons.com, sureshp@cadence.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <c6a0d70d-d584-2db8-f862-0c3ddbf6939d@free-electrons.com>
Date: Fri, 1 Dec 2017 11:37:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Le 28/11/2017 à 21:41, Bjorn Helgaas a écrit :
> On Thu, Nov 23, 2017 at 04:01:48PM +0100, Cyrille Pitchen wrote:
>> This patch adds support to the Cadence PCIe controller in host mode.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>> ---
>>  drivers/Makefile                        |   1 +
>>  drivers/pci/Kconfig                     |   1 +
>>  drivers/pci/cadence/Kconfig             |  24 ++
>>  drivers/pci/cadence/Makefile            |   2 +
>>  drivers/pci/cadence/pcie-cadence-host.c | 425 ++++++++++++++++++++++++++++++++
>>  drivers/pci/cadence/pcie-cadence.c      | 110 +++++++++
>>  drivers/pci/cadence/pcie-cadence.h      | 325 ++++++++++++++++++++++++
>>  7 files changed, 888 insertions(+)
>>  create mode 100644 drivers/pci/cadence/Kconfig
>>  create mode 100644 drivers/pci/cadence/Makefile
>>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>>  create mode 100644 drivers/pci/cadence/pcie-cadence.h
> 
> I prefer a single file per driver.  I assume you're anticipating
> something like dwc, where the DesignWare core is incorporated into
> several devices in slightly different ways.  But it doesn't look like
> that's here yet, and personally, I'd rather split out the required
> things when they actually become required, not ahead of time.
>

The source code in pcie-cadence.c is shared between pcie-cadence-host.c
(Root Complex mode) and pcie-cadence-ep.c (Endpoint mode), the second
driver of this series.

Taking other comments into accounts, I will move endpoint only related
stuff in the pcie-cadence.{c,h} files from this patch to the endpoint
patch.

Otherwise your right, I expect this Cadence PCIe core to be embedded inside
several vendor SoCs but I thought I could handle this as much as possible
using mainly DT properties and/or the 'struct cdns_pcie_*_data' associated
to the DT 'compatible' strings. We will have to wait for those SoCs to be
released to know whether these two solutions are  enough or if we will need
dedicated files anyway.
 
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 1d034b680431..27bdd98784d9 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -18,6 +18,7 @@ obj-y				+= pwm/
>>  
>>  obj-$(CONFIG_PCI)		+= pci/
>>  obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
>> +obj-$(CONFIG_PCI_CADENCE)	+= pci/cadence/
> 
> I can't remember why we added CONFIG_PCI_ENDPOINT here instead of in
> drivers/pci/Makefile.  Is there any way to move both CONFIG_PCI_ENDPOINT
> and CONFIG_PCI_CADENCE into drivers/pci/Makefile so this is better
> encapsulated?
>

I will work on the solution I have proposed in another reply since it seems
to be OK for you :)

>>  # PCI dwc controller drivers
>>  obj-y				+= pci/dwc/
>> ...
> 
>> + * struct cdns_pcie_rc_data - hardware specific data
> 
> "cdns" is a weird abbreviation for "Cadence", since "Cadence" doesn't
> contain an "s".
> 
>> ...
>> +static int cdns_pcie_parse_request_of_pci_ranges(struct device *dev,
>> +						 struct list_head *resources,
>> +						 struct resource **bus_range)
>> +{
>> +	int err, res_valid = 0;
>> +	struct device_node *np = dev->of_node;
>> +	resource_size_t iobase;
>> +	struct resource_entry *win, *tmp;
>> +
>> +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
>> +	if (err)
>> +		return err;
>> +
>> +	err = devm_request_pci_bus_resources(dev, resources);
>> +	if (err)
>> +		return err;
>> +
>> +	resource_list_for_each_entry_safe(win, tmp, resources) {
>> +		struct resource *res = win->res;
>> +
>> +		switch (resource_type(res)) {
>> +		case IORESOURCE_IO:
>> +			err = pci_remap_iospace(res, iobase);
>> +			if (err) {
>> +				dev_warn(dev, "error %d: failed to map resource %pR\n",
>> +					 err, res);
>> +				resource_list_destroy_entry(win);
>> +			}
>> +			break;
>> +		case IORESOURCE_MEM:
>> +			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>> +			break;
>> +		case IORESOURCE_BUS:
>> +			*bus_range = res;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (res_valid)
>> +		return 0;
>> +
>> +	dev_err(dev, "non-prefetchable memory resource required\n");
>> +	return -EINVAL;
>> +}
> 
> The code above is starting to look awfully familiar.  I wonder if it's
> time to think about some PCI-internal interface that can encapsulate
> this.  In this case, there's really nothing Cadence-specific here.
> There are other callers where there *is* vendor-specific code, but
> possibly that could be handled by returning pointers to bus number,
> I/O port, and MMIO resources so the caller could do the
> vendor-specific stuff?
> 
> Bjorn
> 

I am listing:
- gen_pci_parse_request_of_pci_ranges() [1]
- cdns_pcie_parse_request_of_pci_ranges() - same as [1]
- advk_pcie_parse_request_of_pci_ranges()
- altera_pcie_parse_request_of_pci_ranges()
- versatile_pci_parse_request_of_pci_ranges()
- rcar_pcie_parse_request_of_pci_ranges()

Then what about doing something like that:

---8<--------------------------------------------------------------------------
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 44a47d4f0b8f..2413c5d83cbd 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -24,10 +24,19 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
-		       struct list_head *resources, struct resource **bus_range)
+struct pci_host_resource_parser {
+	int	(*get_resource)(void *userdata, struct resource_entry *win,
+				resource_size_t iobase);
+	int	(*finalize)(void *userdata);
+	void	(*abort)(void *userdata);
+};
+
+int pci_host_parse_request_of_pci_ranges(struct device *dev,
+				 struct list_head *resources,
+				 const struct pci_host_resource_parser *parser,
+				 void *userdata)
 {
-	int err, res_valid = 0;
+	int err;
 	struct device_node *np = dev->of_node;
 	resource_size_t iobase;
 	struct resource_entry *win, *tmp;
@@ -40,34 +49,94 @@ static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
 	if (err)
 		return err;
 
-	resource_list_for_each_entry_safe(win, tmp, resources) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = pci_remap_iospace(res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		case IORESOURCE_BUS:
-			*bus_range = res;
-			break;
+	if (parser && parser->get_resource) {
+		resource_list_for_each_entry_safe(win, tmp, resources) {
+			err = parser->get_resource(userdata, win, iobase);
+			if (err)
+				goto do_abort;
+		}
+	}
+
+	if (parser && parser->finalize)
+		return parser->finalize(userdata);
+
+	return 0;
+
+ do_abort:
+	if (parser && parser->abort)
+		parser->abort(userdata);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pci_host_parse_request_of_pci_ranges);
+
+
+struct gen_pci_parser_context {
+	struct device	*dev;
+	struct resource	**bus_range;
+	int		res_valid;
+};
+
+static int gen_pci_resource_parser_get_resource(void *userdata,
+						struct resource_entry *win,
+						resource_size_t iobase)
+{
+	struct gen_pci_parser_context *ctx = userdata;
+	struct device *dev = ctx->dev;
+	struct resource *res = win->res;
+	int err;
+
+	switch (resource_type(res)) {
+	case IORESOURCE_IO:
+		err = pci_remap_iospace(res, iobase);
+		if (err) {
+			dev_warn(dev, "error %d: failed to map resource %pR\n",
+				 err, res);
+			resource_list_destroy_entry(win);
 		}
+		break;
+	case IORESOURCE_MEM:
+		ctx->res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+		break;
+	case IORESOURCE_BUS:
+		*ctx->bus_range = res;
+		break;
 	}
 
-	if (res_valid)
+	return 0;
+}
+
+static int gen_pci_resource_parser_finalize(void *userdata)
+{
+	struct gen_pci_parser_context *ctx = userdata;
+	struct device *dev = ctx->dev;
+
+	if (ctx->res_valid)
 		return 0;
 
 	dev_err(dev, "non-prefetchable memory resource required\n");
 	return -EINVAL;
 }
 
+static const struct pci_host_resource_parser gen_pci_resource_parser = {
+	.get_resource	= gen_pci_resource_parser_get_resource,
+	.finalize	= gen_pci_resource_parser_finalize,
+};
+
+static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
+		       struct list_head *resources, struct resource **bus_range)
+{
+	struct gen_pci_parser_context ctx;
+
+	ctx.dev = dev;
+	ctx.bus_range = bus_range;
+	ctx.res_valid = 0;
+
+	return pci_host_parse_request_of_pci_ranges(dev, resources,
+						    &gen_pci_resource_parser,
+						    &ctx);
+}
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
---8<--------------------------------------------------------------------------

Best regards,

Cyrille

-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
