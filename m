Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40DC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 23:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DF320830
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 23:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCDX61 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:58:27 -0500
Received: from ale.deltatee.com ([207.54.116.67]:51350 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDX61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 18:58:27 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h0xTU-0006O5-QA; Mon, 04 Mar 2019 16:58:25 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
References: <20190214170028.27862-1-logang@deltatee.com>
 <20190304002351.GA26569@google.com>
 <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
Message-ID: <de3e34d8-2ac3-e89b-30f1-a18826ce5d7d@deltatee.com>
Date:   Mon, 4 Mar 2019 16:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yinghai@kernel.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-04 12:21 p.m., Logan Gunthorpe wrote:
> The system we hit this bug on is quite large and complex with multiple
> layers of switches though I suspect I might have seen it on a completely
> different system but never had time to dig into it. I guess I could try
> to find a case in which qemu can hit it.

Ok, I was able to hit this bug with QEMU and I found out a bunch of
minutiae about this bug.

For starters pci=realloc is not really what I (or others) had expected:
it really just tries *harder* to re-assign any resources the bios failed
to assign. So really all this mess in setup-bus is strictly there to
work around bios issues. I was also expecting it to be able to insert
gaps for hotplug with the hpmemsize parameter, but if the bios assigns
all the devices correctly, adding parameters such as
pci=realloc,hpmemsize=8M" will actually do nothing, on x86 at least.

So to hit this bug in real life the bios has to fail to assign a large
64-bit BAR as well as somehow have 32-bit non-prefetchable resources
need to be re-allocated (possibly as a result of other failed
assignments). So I suspect on the system we hit this bug on, the bios
failed to allocate a bunch of resources, which pci=realloc was *mostly*
able to fix up; but this bug caused it to "ignore" a bunch of unrelated
resources.

As QEMU does not have a broken bios, and always seems to do sensible
things, reproducing the bug is a bit difficult. To hit the bug, I had to
apply the hack patch given at the end of the email to release a large
BAR as well as the 32-bit non-prefetchable memory for the entire bus
before executing the rest of the code in
pci_assign_unassigned_root_bus_resources().

Using the following QEMU command:

  qemu-system-x86_64 -enable-kvm -s -m 2048 $IMAGE \
    -device pcie-root-port,id=root_port1,chassis=1,slot=1 \
    -device x3130-upstream,id=upstream_port1,bus=root_port1 \
    -device
xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=2,slot=1 \
    -device
xio3130-downstream,id=downstream_port2,bus=upstream_port1,chassis=2,slot=2 \
    -drive file=${IMGDIR}/nvme.qcow2,if=none,id=nvme1,snapshot=on \
    -device
nvme,drive=nvme1,serial=nvme1,cmb_size_mb=2048,bus=downstream_port1 \
    -drive file=${IMGDIR}/nvme2.qcow2,if=none,id=nvme2,snapshot=on \
    -device nvme,drive=nvme2,serial=nvme1,bus=downstream_port2 \
    -virtfs local,id=home,path=/home/,security_model=mapped,mount_tag=home \
    -nographic \
    -serial mon:stdio \
    -kernel $KERNEL \
    -append "root=/dev/sda2 rootfstype=ext4 console=ttyS0,38400n8"

we can emulate an NVMe device with a 2GB CMB BAR underneath a PCIe
switch with a sibling basic NVMe device for demonstration purposes. The
hack releases the 2GB BAR and all the 32-bit resources in the bus which
*should* be easily reassigned correctly by the code in setup-bus.c
because QEMU had originally found addresses for them. (Note: we do not
even need "pci=realloc" on the command line to hit the bug with this setup.)

When booted, lspci for the NVMe devices shows that all non-prefetchable
resources under the switch were now ignored, but the large 2GB bar was
able to be correctly re-assigned:

  03:00.0 Non-Volatile memory controller: Intel Corporation QEMU NVM
Express Controller (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Flags: fast devsel, IRQ 11
	Memory at <ignored> (64-bit, non-prefetchable)
	Memory at 100000000 (64-bit, prefetchable) [size=2G]
	Memory at <ignored> (32-bit, non-prefetchable)
	Capabilities: [40] MSI-X: Enable- Count=64 Masked-
	Capabilities: [80] Express Endpoint, MSI 00

  04:00.0 Non-Volatile memory controller: Intel Corporation QEMU NVM
Express Controller (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Flags: fast devsel, IRQ 10
	Memory at <ignored> (64-bit, non-prefetchable)
	Memory at <ignored> (32-bit, non-prefetchable)
	Capabilities: [40] MSI-X: Enable- Count=64 Masked-
	Capabilities: [80] Express Endpoint, MSI 00

After applying patch 1 in this series, the same setup correctly assigns
all resources:

  03:00.0 Non-Volatile memory controller: Intel Corporation QEMU NVM
Express Controller (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at 80000000 (64-bit, non-prefetchable) [size=8K]
	Memory at 100000000 (64-bit, prefetchable) [size=2G]
	Memory at 80002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] MSI-X: Enable+ Count=64 Masked-
	Capabilities: [80] Express Endpoint, MSI 00
	Kernel driver in use: nvme

  04:00.0 Non-Volatile memory controller: Intel Corporation QEMU NVM
Express Controller (rev 02) (prog-if 02 [NVM Express])
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Flags: fast devsel, IRQ 10
	Memory at 80200000 (64-bit, non-prefetchable) [size=8K]
	Memory at 80202000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] MSI-X: Enable- Count=64 Masked-
	Capabilities: [80] Express Endpoint, MSI 00


Logan

--

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436df5e..3ab1b9f9df49 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1744,6 +1744,24 @@ static enum enable_type pci_realloc_detect(struct
pci_bus *bus,
 }
 #endif

+static void unassign_qemu_device_hack(struct pci_bus *bus)
+{
+       struct device *dev;
+       struct pci_dev *pdev;
+
+       dev = bus_find_device_by_name(&pci_bus_type, NULL, "0000:03:00.0");
+       if (!dev)
+               return;
+
+       pdev = to_pci_dev(dev);
+
+       pci_info(pdev, "---Releasing BAR 2\n");
+       release_resource(&pdev->resource[2]);
+
+       pci_bus_release_bridge_resources(bus, IORESOURCE_PREFETCH,
+                                        whole_subtree);
+}
+
 /*
  * first try will not touch pci bridge res
  * second and later try will clear small leaf bridge res
@@ -1761,6 +1779,8 @@ void
pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
        int pci_try_num = 1;
        enum enable_type enable_local;

+       unassign_qemu_device_hack(bus);
+
        /* don't realloc if asked to do so */
        enable_local = pci_realloc_detect(bus, pci_realloc_enable);
        if (pci_realloc_enabled(enable_local)) {
