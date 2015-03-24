Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55117FD6.5090903@intel.com>
Date: Tue, 24 Mar 2015 23:16:38 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI / ACPI: PCI delay optimization from ACPI
References: <54FD4FB9.2060802@intel.com> <5222588.FaRe37n2T1@vostro.rjw.lan> <54FE93A4.9040908@intel.com> <20150320210354.GK26935@google.com> <550FDA38.2090505@intel.com> <20150323150955.GR26935@google.com> <551128BA.7070508@intel.com> <20150324140812.GB2495@google.com>
In-Reply-To: <20150324140812.GB2495@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/24/2015 10:08 PM, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2015 at 05:04:58PM +0800, Aaron Lu wrote:
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index e0afc94aca01..220371c2def4 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -537,11 +537,24 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
>>  
>>  void acpi_pci_add_bus(struct pci_bus *bus)
>>  {
>> +	union acpi_object *obj;
>> +
>>  	if (acpi_pci_disabled || !bus->bridge)
>>  		return;
>>  
>>  	acpi_pci_slot_enumerate(bus);
>>  	acpiphp_enumerate_slots(bus);
>> +
>> +	/*
>> +	 * For a host bridge, check its _DSM for function 8 and if
>> +	 * that is available, mark it in the corresponding pci_bus.
>> +	 */
>> +	if (bus->bridge->parent)
>> +		return;
> 
> This is not really an obvious way of testing for a host bridge.  I think
> pci_is_root_bus() would be a better way, but I'm still hoping for something
> in pci_root.c instead.  There is find_pci_host_bridge(), which might be
> useful (it's currently static but we might want to rename and export it for
> this and other reasons).

I agree that pci_root.c is the proper place for a property of the PCI host
bridge, but since it only calls:
	root->bus = pci_acpi_scan_root(root);
and when it returns, eveything is already properly initialized. To pass
the ignore_reset_delay information from there, we probably need to add a
field ignore_reset_delay to struct acpi_pci_root and then pass that
information to pci_root_info and then pass the pointer of pci_root_info
to pci_create_root_bus where we use that information to set the field in
the pci_host_bridge. Intead of doing it this way, hook the
acpi_pci_add_bus to set the ignore_reset_delay bit of the PCI host
bridge seems to be cheap and easier.

> 
>> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
>> +				RESET_DELAY_DSM, NULL);
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1)
>> +		bus->ignore_reset_delay = 1;
> 
> I think you need to free "obj" here.  Other acpi_evaluate_dsm() callers use
> ACPI_FREE().

Oops yes.

> 
>>  }
>>  
>>  void acpi_pci_remove_bus(struct pci_bus *bus)
>> @@ -567,6 +580,55 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>>  				      check_children);
>>  }
>>  
>> +/**
>> + * pci_acpi_delay_optimize - optimize PCI D3 and D3cold delay from ACPI
>> + * @pdev: the PCI device whose delay is to be updated
>> + * @adev: the companion ACPI device of this PCI device
>> + *
>> + * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
>> + * control method of either its own or its parent bridge.
>> + *
>> + * The UUID of the _DSM control method, together with other information like
>> + * which delay values can be optimized, etc. is defined in a ECN available on
>> + * PCIsig.com titled as: ACPI additions for FW latency optimizations.
>> + * Function 9 of the ACPI _DSM control method, if available for a specific PCI
>> + * device, provides various possible delay values that are less than what the
>> + * SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
>> + * can be added later.
>> + * Function 8 of the ACPI _DSM control method, if available for the PCI host
>> + * bridge(reflected by the bus' ignore_reset_delay filed), means all its
>> + * children devices do not need the reset delay when leaving from D3cold state.
>> + */
>> +static void pci_acpi_delay_optimize(struct pci_dev *pdev,
>> +				    acpi_handle handle)
>> +{
>> +	int value;
>> +	union acpi_object *obj, *elements;
>> +
>> +	if (pdev->bus->ignore_reset_delay)
>> +		pdev->d3cold_delay = 0;
> 
> I think this only propagates the function 8 result to the immediate
> children of the host bridge, i.e., devices on the root bus.  But the ECN
> says it affects the entire hierarchy.  Can you put the ignore_reset_delay
> bit in the struct pci_host_bridge instead?

No problem.

> 
>> +
>> +	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 3,
>> +				FUNCTION_DELAY_DSM, NULL);
>> +	if (!obj)
>> +		return;
>> +
>> +	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
>> +		elements = obj->package.elements;
>> +		if (elements[0].type == ACPI_TYPE_INTEGER) {
>> +			value = (int)elements[0].integer.value / 1000;
>> +			if (value < PCI_PM_D3COLD_WAIT)
>> +				pdev->d3cold_delay = value;
>> +		}
>> +		if (elements[3].type == ACPI_TYPE_INTEGER) {
>> +			value = (int)elements[3].integer.value / 1000;
>> +			if (value < PCI_PM_D3_WAIT)
>> +				pdev->d3_delay = value;
>> +		}
>> +	}
>> +	kfree(obj);
>> +}
>> +
>>  static void pci_acpi_setup(struct device *dev)
>>  {
>>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>> @@ -575,6 +637,9 @@ static void pci_acpi_setup(struct device *dev)
>>  	if (!adev)
>>  		return;
>>  
>> +	if (pci_dev->pm_cap)
>> +		pci_acpi_delay_optimize(pci_dev, adev->handle);
> 
> Is the "pm_cap" test really necessary?  If we do it this way, we then have
> to convince ourselves that pdev->d3cold_delay and pdev->d3_delay are only
> needed when pdev has a pm_cap.
> 
> If we *always* fill in the delay values, it's possible they won't be used,
> but we don't have to prove any connection between them and a pm_cap, so
> the code is easier to analyze.

Brilliant.

Here is an updat, kind of a proof of concept one, to see if it goes the
right way:

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 3e5bbf9e8889..e40512d3f373 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -16,7 +16,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e0afc94aca01..04d5b5befbe9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -537,11 +537,32 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
 
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
+	union acpi_object *obj;
+	struct pci_host_bridge *bridge;
+
 	if (acpi_pci_disabled || !bus->bridge)
 		return;
 
 	acpi_pci_slot_enumerate(bus);
 	acpiphp_enumerate_slots(bus);
+
+	/*
+	 * For a host bridge, check its _DSM for function 8 and if
+	 * that is available, mark it in pci_host_bridge.
+	 */
+	if (!pci_is_root_bus(bus))
+		return;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
+				RESET_DELAY_DSM, NULL);
+	if (obj) {
+		if (obj->type == ACPI_TYPE_INTEGER &&
+		    obj->integer.value == 1) {
+			bridge = find_pci_host_bridge(bus);
+			bridge->ignore_reset_delay = true;
+		}
+		ACPI_FREE(obj);
+	}
 }
 
 void acpi_pci_remove_bus(struct pci_bus *bus)
@@ -567,6 +588,56 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 				      check_children);
 }
 
+/**
+ * pci_acpi_delay_optimize - optimize PCI D3 and D3cold delay from ACPI
+ * @pdev: the PCI device whose delay is to be updated
+ * @adev: the companion ACPI device of this PCI device
+ *
+ * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
+ * control method of either its own or its parent bridge.
+ *
+ * The UUID of the _DSM control method, together with other information like
+ * which delay values can be optimized, etc. is defined in a ECN available on
+ * PCIsig.com titled as: ACPI additions for FW latency optimizations.
+ * Function 9 of the ACPI _DSM control method, if available for a specific PCI
+ * device, provides various possible delay values that are less than what the
+ * SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
+ * can be added later.
+ * Function 8 of the ACPI _DSM control method, if available for the PCI host
+ * bridge(reflected by the bus' ignore_reset_delay filed), means all its
+ * children devices do not need the reset delay when leaving from D3cold state.
+ */
+static void pci_acpi_delay_optimize(struct pci_dev *pdev,
+				    acpi_handle handle)
+{
+	struct pci_host_bridge *bridge = find_pci_host_bridge(pdev->bus);
+	int value;
+	union acpi_object *obj, *elements;
+
+	if (bridge->ignore_reset_delay)
+		pdev->d3cold_delay = 0;
+
+	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 3,
+				FUNCTION_DELAY_DSM, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
+		elements = obj->package.elements;
+		if (elements[0].type == ACPI_TYPE_INTEGER) {
+			value = (int)elements[0].integer.value / 1000;
+			if (value < PCI_PM_D3COLD_WAIT)
+				pdev->d3cold_delay = value;
+		}
+		if (elements[3].type == ACPI_TYPE_INTEGER) {
+			value = (int)elements[3].integer.value / 1000;
+			if (value < PCI_PM_D3_WAIT)
+				pdev->d3_delay = value;
+		}
+	}
+	ACPI_FREE(obj);
+}
+
 static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -575,6 +646,8 @@ static void pci_acpi_setup(struct device *dev)
 	if (!adev)
 		return;
 
+	pci_acpi_delay_optimize(pci_dev, adev->handle);
+
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
 		return;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82239cd..802e7c0c7f9f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -321,4 +321,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 3801c704a945..a965efa52152 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -79,6 +79,8 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 
 extern const u8 pci_acpi_dsm_uuid[];
 #define DEVICE_LABEL_DSM	0x07
+#define RESET_DELAY_DSM		0x08
+#define FUNCTION_DELAY_DSM	0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a379513bddef..e587832885e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,6 +406,7 @@ struct pci_host_bridge {
 	struct list_head windows;	/* resource_entry */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
+	bool ignore_reset_delay;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
-- 
2.1.0

