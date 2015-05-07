Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:11184
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751025AbbEGDsx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 May 2015 23:48:53 -0400
Message-ID: <554ADCE0.8020603@amd.com>
Date: Wed, 6 May 2015 22:32:48 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Liviu Dudau" <Liviu.Dudau@arm.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150505155346.GJ1550@arm.com> <20150506141859.GC26028@red-moon>
 <CAErSpo7z_Sf5QvMa8MBY0f7DQOmwhcpUnCFG=ZsmHuwT2HouQw@mail.gmail.com>
In-Reply-To: <CAErSpo7z_Sf5QvMa8MBY0f7DQOmwhcpUnCFG=ZsmHuwT2HouQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/6/2015 10:18 AM, Bjorn Helgaas wrote:
> On Wed, May 6, 2015 at 9:18 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Tue, May 05, 2015 at 04:53:46PM +0100, Will Deacon wrote:
>>> On Tue, May 05, 2015 at 03:02:12AM +0100, Jayachandran C wrote:
>>>> The current code in pci-host-generic.c uses pci_common_init_dev()
>>>> from the arch/arm/ to do a part of the PCI initialization, and this
>>>> prevents it from being used on arm64.
>>>>
>>>> The initialization done by pci_common_init_dev() that is really
>>>> needed by pci-host-generic.c can be done in the same file without
>>>> using the hw_pci API of ARM.
>>>>
>>>> The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
>>>> this is be handled by setting up 'struct gen_pci' to embed a
>>>> pci_sys_data variable as the first element on the ARM platform.
>>>>
>>>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>>>> ---
>>>> Here's v2 of the patches, this enables use of pci-host-generic on
>>>> arm64.
>>>>
>>>> This has been tested on both qemu and fast model for arm64, and on
>>>> qemu for arm32.
>>>>
>>>> v1->v2
>>>>   - Address comments from Arnd Bergmann and Lorenzo Pieralisi
>>>>      - move contents of gen_pci_init to gen_pci_probe
>>>>      - assign resources only when !probe_only
>>>>   - tested on ARM32 with qemu option -M virt
>>>
>>> I tried this with an arm64 kernel running under kvmtool, but I get the
>>> following errors (a 32-bit ARM kernel does seem to work):
>>>
>>>    PCI host bridge /pci ranges:
>>>       IO 0x00000000..0x0000ffff -> 0x00000000
>>>      MEM 0x41000000..0x7fffffff -> 0x41000000
>>>    pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
>>>    pci_bus 0000:00: root bus resource [bus 00-01]
>>>    pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>>>    pci_bus 0000:00: root bus resource [mem 0x41000000-0x7fffffff]
>>>    pci_bus 0000:00: scanning bus
>>>    pci 0000:00:00.0: [1af4:1009] type 00 class 0xff0000
>>>    pci 0000:00:00.0: reg 0x10: [mem 0x41000000-0x410003ff]
>>>    pci 0000:00:00.0: reg 0x14: [io  0x6200-0x65ff]
>>>    pci 0000:00:00.0: reg 0x18: [mem 0x41000400-0x410005ff]
>>>    pci 0000:00:01.0: [1af4:1009] type 00 class 0xff0000
>>>    pci 0000:00:01.0: reg 0x10: [mem 0x41000800-0x41000bff]
>>>    pci 0000:00:01.0: reg 0x14: [io  0x6600-0x69ff]
>>>    pci 0000:00:01.0: reg 0x18: [mem 0x41000c00-0x41000dff]
>>>    pci_bus 0000:00: fixups for bus
>>>    pci_bus 0000:00: bus scan returning with max=00
>>>    pci 0000:00:00.0: fixup irq: got 10
>>>    pci 0000:00:00.0: assigning IRQ 10
>>>    pci 0000:00:01.0: fixup irq: got 11
>>>    pci 0000:00:01.0: assigning IRQ 11
>>>    virtio-pci 0000:00:00.0: can't enable device: BAR 0 [mem 0x41000000-0x410003ff] not claimed
>>>    virtio-pci: probe of 0000:00:00.0 failed with error -22
>>>    virtio-pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x41000800-0x41000bff] not claimed
>>>    virtio-pci: probe of 0000:00:01.0 failed with error -22
>>
>> Ok, had a further look.
>>
>> Referring to this thread:
>>
>> https://lkml.org/lkml/2014/9/29/557
>>
>> By looking at other architectures code, resources should be claimed
>> (ie requested) even when PCI_PROBE_ONLY is set. Alpha, Sparc and PowerPC
>> seem to do that, in slightly different fashions.
>>
>> I do not think, as Bjorn mentioned, that PCI_PROBE_ONLY should be used
>> to prevent enabling resources through a PCI command, which is what
>> pci_enable_resources does.
>>
>> What we can do, is providing a generic PCI layer API that allows claiming
>> resources for a specific PCI bus, something similar if not identical
>> to what is done on alpha:
>>
>> arch/alpha/kernel/pci.c pcibios_claim_one_bus()
>>
>> that is not alpha specific at all. That way, we can use the API to claim
>> bus resources instead of assigning them on PCI_PROBE_ONLY (I *think*
>> that alpha calls pci_assign_unassigned_resources() even if
>> PCI_PROBE_ONLY is set, it should be safe since resources are claimed
>> first so IIUC the PCI layer would revert to FW BAR configuration on
>> assignment failure).
>>
>> Bjorn, any opinion on this ? Putting together a patch is easy when
>> we agree on the solution.
>
> I would like claiming resources, i.e., pci_claim_resource(), to happen
> in the core instead of in arch code because it's not inherently
> arch-specific.  I don't think it should depend on PCI_PROBE_ONLY.
>
> Bjorn
>

Hi All,

I tested this patch series on the AMD Seattle w/o PCI_PROBE_ONLY mode 
and that works fine. However, w/ PCI_PROBE_ONLY, I also run into the 
resource not claimed issue (no surprise here).

So, I tried porting the pcibios_claim_one_bus() from 
arch/alpha/kernel/pci.c as Lorenzo suggested, plus the a small change in 
pci_claim_resource(), and it seems to work w/ PCI_PROBE_ONLY. (Please 
see example patch below.)

The additional while loop is needed in the pci_claim_resource() since I 
need to reference back to the resource in the root bus, which are 
defined from the DT node. Does this sounds like a reasonable approach?

diff --git a/drivers/pci/host/pci-host-generic.c 
b/drivers/pci/host/pci-host-generic.c
index e9cc559..0dfa23d 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -261,7 +261,10 @@ static int gen_pci_probe(struct platform_device *pdev)
  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
  		pci_bus_size_bridges(bus);
  		pci_bus_assign_resources(bus);
+	} else {
+		pci_claim_one_bus(bus);
  	}
+
  	pci_bus_add_devices(bus);

  	/* Configure PCI Express settings */
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..d4b43b3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -109,6 +109,7 @@ int pci_claim_resource(struct pci_dev *dev, int 
resource)
  {
  	struct resource *res = &dev->resource[resource];
  	struct resource *root, *conflict;
+	struct pci_dev *pdev = dev;

  	if (res->flags & IORESOURCE_UNSET) {
  		dev_info(&dev->dev, "can't claim BAR %d %pR: no address assigned\n",
@@ -116,7 +117,18 @@ int pci_claim_resource(struct pci_dev *dev, int 
resource)
  		return -EINVAL;
  	}

-	root = pci_find_parent_resource(dev, res);
+	while (pdev) {
+		root = pci_find_parent_resource(pdev, res);
+		if (root)
+			break;
+
+		if (pci_has_flag(PCI_PROBE_ONLY) &&
+		    !pci_is_root_bus(pdev->bus))
+			pdev = pdev->bus->self;
+		else
+			break;
+	}
+
  	if (!root) {
  		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge 
window\n",
  			 resource, res);
@@ -136,6 +148,36 @@ int pci_claim_resource(struct pci_dev *dev, int 
resource)
  }
  EXPORT_SYMBOL(pci_claim_resource);

+void pci_claim_one_bus(struct pci_bus *b)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *child_bus;
+
+	list_for_each_entry(pdev, &b->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &pdev->resource[i];
+
+			if (r->parent || !r->start || !r->flags)
+				continue;
+
+			if (pci_has_flag(PCI_PROBE_ONLY) ||
+			    (r->flags & IORESOURCE_PCI_FIXED)) {
+				if (pci_claim_resource(pdev, i) == 0)
+					continue;
+
+				pci_claim_bridge_resource(pdev, i);
+			}
+		}
+	}
+
+	list_for_each_entry(child_bus, &b->children, node) {
+		pci_claim_one_bus(child_bus);
+	}
+}
+EXPORT_SYMBOL(pci_claim_one_bus);
+
  void pci_disable_bridge_window(struct pci_dev *dev)
  {
  	dev_info(&dev->dev, "disabling bridge mem windows\n");
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..b59ad4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1085,6 +1085,7 @@ void pci_assign_unassigned_bridge_resources(struct 
pci_dev *bridge);
  void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
  void pdev_enable_device(struct pci_dev *);
+void pci_claim_one_bus(struct pci_bus *b);
  int pci_enable_resources(struct pci_dev *, int mask);
  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
  		    int (*)(const struct pci_dev *, u8, u8));
-------- END PATCH ----

Thanks,

Suravee

