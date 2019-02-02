Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD10C282D7
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 16:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B2520857
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfBBQZN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:25:13 -0500
Received: from mail-oln040092254099.outbound.protection.outlook.com ([40.92.254.99]:44138
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727856AbfBBQZM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Feb 2019 11:25:12 -0500
Received: from PU1APC01FT058.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT209.eop-APC01.prod.protection.outlook.com
 (10.152.253.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sat, 2 Feb
 2019 16:25:03 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT058.mail.protection.outlook.com (10.152.253.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sat, 2 Feb 2019 16:25:03 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::cc10:24a5:4249:7da%2]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 16:25:03 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHUuxPZgXPVUi9piEKy1z1nwrPCMA==
Date:   Sat, 2 Feb 2019 16:25:02 +0000
Message-ID: <PS2P216MB0642603E54D081F0DB349F5280930@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:F91656496917A52FE17F603F67AF3AA70A4FD9B0FBD9FEDD147C6A0B809E4BAD;UpperCasedChecksum:F8FEE7FA46A942DDC376D6CC46FF2526E0AA5192BD92D773BC818681C2C576F2;SizeAsReceived:8815;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [OqTNzReUyFMk2oojKnMFw2ACbwZjwWZzfT/Q/GFlK69Qw0n0OeW2RpP33G9d7DrD]
x-microsoft-original-message-id: <20190202162451.3849-1-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1APC01HT209;6:V+p7ystXf5Oyi//RFzgiY1FeIK4ZiZw6bRWwo7NExKsSvrj4Nc8Dz3TD37RT2ZMnBVluxnslYNcxic3E1SNryH6mIrzzLlRxthlQadT2DEYbFs2nzRNJsb/W0sTnK9GLhtzgudNahhq3Xvhz2q90pyLzGRP55DGp2AnDdP8fQXZr7ufLq8BrWsv5HASsJ92QPqMO/JwF2PymrcFFkK800lMzPDslvPx4FQYtcRVSg5KpgIrqRtpPnJrAUypSpCHFVspZ8BmMYp1wqgvKgVBaMmhNcnlgf/MbXymlPZqQ6PApDIyP6SPgvz54AcUgOVjhjpmanHk3Be1n/xmMvy/aRa+yxLKluMkcES3iDCVirrVaOz7V2yYWb0kTPksn6qLZYxg8q6lD8XJXEgoVIiRqHNSA02JN/Y1mmiXXxzks82s+ijw/HPB5Q5pplsQ5UkFZN30SWBYmLsmdH7qNIjMoOw==;5:V3o6FD41nflMvQ3SNRzQCp+fSuWe9uiTRlECIu/ZKaJRzNMT3g8T0CRATKnQu73vFG+ZX1ajvfPAEL5jqaIp8YAsTqBKDQizZE69rXwWquqbqXPmh3rh07vfNMHqPfzwfWmPuZTrAh24NRMhX7TxVPyqe+TcQaRTY2hBW9CBBjWrI2GRza3afs8dFKL/H/vzyx32tVC1UvLT3bKoTJlmSA==;7:modvoapjeWdcwuDUSEnxbk0WO7Q+wWyt5fiI5ARLxGqTlQxQLb9NCXzBsPOP2OcwKsvukMxKHe80u6kOjvYxOH5Qr1staU/vl3G2ypQXdX8VmLpozynEe1EV9/7T/wik+QqBxGLxUDQ4AJ8OIyUJKA==
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: pt8ZUcDWjMXqixvzS0Peru3RBeUDIkjZD/33jNdcs43NB1mvdeVX9Uam++PUiHIbFkPivVigAX5DmD6/qDJGE4vi63Z267WIoHkUX84bA+S1mMHDqz2zZdKyJk1kpmBihWKjLQCD7kFIv7GoI73dMViAfqD+Lfsq8U2zFy1mXjpsuaCU8vpQGdVmde5lkSIj9lldCLgGs0ofbGtUK9ZlQToX/NobcvRDmk+pAnszCiCI17Jo2Vtbj87byTpv+7zZjR2YHUjesorervHaHCd0QLtsLjHEizoyk6gjkoQFRw9Lp+9/DT5W2AWvrVJJFyMx09csIn7yYcydkgv2eY7fCY9to8Xkf7wFKz4Mene6JUqvkAgxgDRttbQlhpR3ysjrNxqNlgjBbx2dCS1Yiqml3ejyA0cMu56KkZ4s8itRF/Bb2nBPScx3OG1Zvz0D00U19eR64zl/KpIS+F/cLnU62Agasdf8fLxpk62Dz2VSv+WVsx+oI68kp5LEHZF2v9ZSyce7l2OhfgXOchkVdrsWzFcme3UFg6aSxKcUE3pB8YZNk1r0WgAxEzCUMBJ8X3dYFlnAbreK0nMG3I/V8qZZNssYRCFbFziqxNDnnP56hyDWUUFHz70r9gDqxt8X7WHIQ+TBJyCIpx9qAO9L0hORlv5M3K7LmV3FmBjWt3nbT5tAu5SVNfLow4qqxyJx5fhtjtnOTX16HxkB6E1sOn8k/yUH/xFr4F0fDJb7o9uckQQgZ/1uXCGQTp303XX/dvnLuH4EtV2eXhQXFVxoy+tTEmNuoZZL7L5beRvQFj5CGm5rrG8DL7VbOhxxHiepz0V/D2VJxOU0wqBDyZ/UzoStix8hlELpd2X06VVgK27zbKxxc97qNLQqu5E7Xru2jFXEd5QiUJOLRzFBV+4whGK8oQ3kqjepnuPEQDJgW/JbuEUQ9Hlv9ZWyXtLM8za/kARg
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT209;
x-ms-traffictypediagnostic: PU1APC01HT209:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:PU1APC01HT209;BCL:0;PCL:0;RULEID:;SRVR:PU1APC01HT209;
x-microsoft-antispam-message-info: ngwRxwNbgW8Ce5KT62IwcvXoITzcI4ozxFOsr1KvRb3Q9QILFzdYQQ3RKgd4d896
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-Network-Message-Id: 210d7456-6dec-46cb-df3d-08d6892afbb8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 16:25:02.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT209
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

New systems with Thunderbolt are starting to use native PCI enumeration.
Mika Westerberg's patch "PCI: Distribute available resources to hotplug
capable PCIe downstream ports"
(https://patchwork.kernel.org/patch/9972155/) adds code to expand
downstream PCI hotplug bridges to consume all remaining resource space
in the parent bridge. It is a crucial patch for supporting Thunderbolt
native enumeration on Linux.

However, it does not consider bridge alignment in all cases, which rules
out hot-adding an external graphics processor at the end of a
Thunderbolt daisy chain. Hot-adding such a device will likely fail to
work with the existing code. It also might disrupt the operation of
existing devices or prevent the subsequent hot-plugging of lower aligned
devices if the kernel frees and reallocates upstream resources to
attempt assign the resources that failed to assign in the first pass. By
Intel's ruling, Thunderbolt external graphics processors are generally
meant to function only as the first and only device in the chain.
However, there is no technical reason that prevents it from being
possible if sufficient resources are available, and people are likely to
attempt such configurations with Thunderbolt devices if they own such
hardware. Hence, I argue that we should improve the user experience and
reduce the number of constraints placed on the user by always
considering resource alignment, which will make such configurations
possible.

The other problem with the patch is that it is incompatible with
resources allocated by "pci=hpmemsize=nnM" due to a check which does not
allow for dev_res->add_size to be reduced. This check also makes a big
assumption that the hpmemsize is small but non-zero, and no action has
been taken to ensure that. In the current state, any bridge smaller than
hpmemsize will likely fail to size correctly, which will cause major
issues if the default were to change, or if the user also wants to
configure non-Thunderbolt hotplug bridges simultaneously. I argue that
if assumptions and limitations can be removed with no risks and adverse
effects, then it should be done.

The former problem is solved by rewriting the
pci_bus_distribute_available_resources() function with more information
passed in the arguments, eliminating assumptions about the initial
bridge alignment. My patch makes no assumptions about the alignment of
hot-added bridges, allowing for any device to be hot-added, given
sufficient resources are available.

The latter problem is solved by removing the check preventing the
shrinking of dev_res->add_size, which allows for the distribution of
resources if hpmemsize is non-zero. It can be made to work with zero
hpmemsize with two-line patches in pbus_size_mem() and pbus_size_io(),
or by modifying extend_bridge_window() to add a new entry to the
additional resource list if one does not exist. In theory, and by my
testing, the removal of this check does not affect the functionality of
the resource distribution with firmware-allocated resources. But it does
enable the same functionality when using pci=hpmemsize=nnM, which was
not possible prior. This may be one piece of the puzzle needed to
support Thunderbolt add-in cards that support native PCI enumeration,
without any platform dependencies.

I have tested this proposed patch extensively. Using Linux-allocated
resources, it works perfectly. I have two Gigabyte GC-TITAN RIDGE
Thunderbolt 3 add-in cards in my desktop, and a Dell XPS 9370 with the
Dell XPS 9380 Thunderbolt NVM40 firmware flashed. My peripherals are
three HP ZBook Thunderbolt 3 docks, two external graphics enclosures
with AMD Fiji XT in both, a Promise SANLink3 N1 (AQC107S), and a Dell
Thunderbolt 3 NVMe SSD. All configurations of these devices worked well,
and I can no longer make it fail if I try to. My testing with
firmware-allocated resources is limited due to using computers with
Alpine Ridge BIOS support. However, I did get manage to test the patch
with firmware-allocated resources by enabling the Alpine Ridge BIOS
support and forcing pcie_ports=native, and the results were perfect.

Mika Westerberg has agreed to test this on an official platform with
native enumeration firmware support to be sure that it works in this
situation. It is also appropriate that he reviews these changes as he
wrote the original code and any changes made to Thunderbolt-critical
code cannot be allowed to break any of the base requirements for
Thunderbolt. I would like to thank him for putting up with my emails and
trying to help where he can, and for the great work he has done on
Thunderbolt in Linux.

I have more patches in the pipeline to further improve the Thunderbolt
experience on Linux on platforms without BIOS support. This is the most
technical but least user-facing one planned. The most exciting changes
are yet to come.

Edits:

I have made code styling changes as suggested by Mika Westerberg.

I have been testing Thunderbolt devices with my other host card which
happens to be in SL0 mode. This means that devices are discovered much
more quickly. I noticed that multiple devices can be enumerated
together, rather than each getting enumerated before the next appears.
It turns out that this can break the allocation, but I have absolutely
no idea why. I have modified the patch to solve this problem. Before,
extend_bridge_window() used add_size to change the resource size. Now it
simply changes the size of the actual resource, and clears the add_size
to zero if a list entry exists. That solves the issue, and proves that
the calculated resource sizes are not at fault (the algorithm is sound).
Hence, I recommend this version with the modification be applied.

I have removed Mika Westerberg's "Tested-By" line to allow him to give
his approval for this new change.

Observation: the fact that a single Thunderbolt dock can consume 1/4 of
the total IO space (16-bit, 0xffff) is evidence that the depreciated IO
bars need to be dropped from the kernel at some point. The docks have
four bridges each, with 4096-byte alignment. The IO BARs do not do
anything, crash the system if not claimed and spam dmesg when not
assigned.

Signed-off-by: Nicholas-Johnson-opensource <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 188 +++++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 89 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436df5e..09310b6fcdb3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1859,27 +1859,34 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 	if (res->parent)
 		return;
 
-	if (resource_size(res) >= available)
-		return;
+	/*
+	 * Hot-adding multiple Thunderbolt devices in SL0 might result in
+	 * multiple devices being enumerated together. This can break the
+	 * resource allocation if the resource sizes are specified with
+	 * add_size instead of simply changing the resource size.
+	*/
+	pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
+		available - resource_size(res));
+	res->end = res->start + available - 1;
 
+	/*
+	 * If a list entry exists, we need to remove any additional size
+	 * requested because that could interfere with the alignment and
+	 * sizing done when distributing resources, causing resources to
+	 * fail to allocate later on.
+	 */
 	dev_res = res_to_dev_res(add_list, res);
 	if (!dev_res)
 		return;
 
-	/* Is there room to extend the window? */
-	if (available - resource_size(res) <= dev_res->add_size)
-		return;
-
-	dev_res->add_size = available - resource_size(res);
-	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
-		&dev_res->add_size);
+	dev_res->add_size = 0;
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
-	struct list_head *add_list, resource_size_t available_io,
-	resource_size_t available_mmio, resource_size_t available_mmio_pref)
+	struct list_head *add_list, struct resource io,
+	struct resource mmio, struct resource mmio_pref)
 {
-	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1889,25 +1896,32 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
 	/*
-	 * Update additional resource list (add_list) to fill all the
-	 * extra resource space available for this port except the space
-	 * calculated in __pci_bus_size_bridges() which covers all the
-	 * devices currently connected to the port and below.
+	 * The alignment of this bridge is yet to be considered, hence it must
+	 * be done now before extending its bridge window. A single bridge
+	 * might not be able to occupy the whole parent region if the alignment
+	 * differs - for example, an external GPU at the end of a Thunderbolt
+	 * daisy chain.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, available_io);
-	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
-	extend_bridge_window(bridge, mmio_pref_res, add_list,
-			     available_mmio_pref);
+	align = pci_resource_alignment(bridge, io_res);
+	if (!io_res->parent && align)
+		io.start = ALIGN(io.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_res);
+	if (!mmio_res->parent && align)
+		mmio.start = ALIGN(mmio.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_pref_res);
+	if (!mmio_pref_res->parent && align)
+		mmio_pref.start = ALIGN(mmio_pref.start, align);
 
 	/*
-	 * Calculate the total amount of extra resource space we can
-	 * pass to bridges below this one. This is basically the
-	 * extra space reduced by the minimal required space for the
-	 * non-hotplug bridges.
+	 * Update the resources to fill as much remaining resource space in the
+	 * parent bridge as possible, while considering alignment.
 	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
+	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
+	extend_bridge_window(bridge, mmio_pref_res, add_list,
+		resource_size(&mmio_pref));
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -1921,80 +1935,79 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			normal_bridges++;
 	}
 
+	/*
+	 * There is only one bridge on the bus so it gets all possible
+	 * resources which it can then distribute to the possible
+	 * hotplug bridges below.
+	 */
+	if (hotplug_bridges + normal_bridges == 1) {
+		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (dev->subordinate)
+			pci_bus_distribute_available_resources(dev->subordinate,
+				add_list, io, mmio, mmio_pref);
+		return;
+	}
+
+	/*
+	 * Reduce the available resource space by what the
+	 * bridge and devices below it occupy.
+	 */
 	for_each_pci_bridge(dev, bus) {
-		const struct resource *res;
+		struct resource *res;
+		resource_size_t used_size;
 
 		if (dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Reduce the available resource space by what the
-		 * bridge and devices below it occupy.
-		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && available_io > resource_size(res))
-			remaining_io -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(io.start, align) - io.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&io))
+			io.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && available_mmio > resource_size(res))
-			remaining_mmio -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio))
+			mmio.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && available_mmio_pref > resource_size(res))
-			remaining_mmio_pref -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio_pref.start, align) -
+				mmio_pref.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio_pref))
+			mmio_pref.start += used_size;
 	}
 
-	/*
-	 * There is only one bridge on the bus so it gets all available
-	 * resources which it can then distribute to the possible
-	 * hotplug bridges below.
-	 */
-	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
-		}
+	if (!hotplug_bridges)
 		return;
-	}
 
 	/*
-	 * Go over devices on this bus and distribute the remaining
-	 * resource space between hotplug bridges.
+	 * Distribute any remaining resources equally between
+	 * the hotplug-capable downstream ports.
 	 */
-	for_each_pci_bridge(dev, bus) {
-		resource_size_t align, io, mmio, mmio_pref;
-		struct pci_bus *b;
+	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
+	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
+	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
+		hotplug_bridges);
 
-		b = dev->subordinate;
-		if (!b || !dev->is_hotplug_bridge)
+	for_each_pci_bridge(dev, bus) {
+		if (!dev->subordinate || !dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Distribute available extra resources equally between
-		 * hotplug-capable downstream ports taking alignment into
-		 * account.
-		 *
-		 * Here hotplug_bridges is always != 0.
-		 */
-		align = pci_resource_alignment(bridge, io_res);
-		io = div64_ul(available_io, hotplug_bridges);
-		io = min(ALIGN(io, align), remaining_io);
-		remaining_io -= io;
+		io.end = io.start + io_per_hp - 1;
+		mmio.end = mmio.start + mmio_per_hp - 1;
+		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
 
-		align = pci_resource_alignment(bridge, mmio_res);
-		mmio = div64_ul(available_mmio, hotplug_bridges);
-		mmio = min(ALIGN(mmio, align), remaining_mmio);
-		remaining_mmio -= mmio;
+		pci_bus_distribute_available_resources(dev->subordinate,
+			add_list, io, mmio, mmio_pref);
 
-		align = pci_resource_alignment(bridge, mmio_pref_res);
-		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
-		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
-		remaining_mmio_pref -= mmio_pref;
-
-		pci_bus_distribute_available_resources(b, add_list, io, mmio,
-						       mmio_pref);
+		io.start = io.end + 1;
+		mmio.start = mmio.end + 1;
+		mmio_pref.start = mmio_pref.end + 1;
 	}
 }
 
@@ -2002,22 +2015,19 @@ static void
 pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					  struct list_head *add_list)
 {
-	resource_size_t available_io, available_mmio, available_mmio_pref;
-	const struct resource *res;
+	struct resource io_res, mmio_res, mmio_pref_res;
 
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	io_res = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	mmio_res = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	mmio_pref_res = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
+
 	/* Take the initial extra resources from the hotplug port */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	available_io = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	available_mmio = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
-	available_mmio_pref = resource_size(res);
 
 	pci_bus_distribute_available_resources(bridge->subordinate,
-		add_list, available_io, available_mmio, available_mmio_pref);
+		add_list, io_res, mmio_res, mmio_pref_res);
 }
 
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
-- 
2.19.1

