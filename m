Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:34712 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448AbcFIFm2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 01:42:28 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ARM: cns3xxx: pci: avoid potential stack overflow"
References: <20160531215802.30590.97398.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<m3inxt17zo.fsf@t19.piap.pl> <11128570.JeBAgI5zQr@wuerfel>
Date: Thu, 09 Jun 2016 07:42:24 +0200
In-Reply-To: <11128570.JeBAgI5zQr@wuerfel> (Arnd Bergmann's message of "Wed,
	01 Jun 2016 23:09:47 +0200")
Message-ID: <m37fdydikf.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> What exactly is the problem we are seeing, and is there a way to fix
> it on top of my patch? Are we perhaps just missing a call to
> pcie_bus_configure_settings()?

From: khalasa@piap.pl (Krzysztof Halasa)
Subject: [PATCH] Extend PCIE_BUS_PEER2PEER to set MRSS=128 to fix CNS3xxx BM DMA.
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Mar 2016 10:39:52 +0100 (11 weeks, 2 days, 19 hours ago)

The platform in question is Cavium CNS3xxx, ARMv6.

A recent patch by Arnd Bergmann (498a92d42596 "ARM: cns3xxx: pci: avoid
potential stack overflow") converted an explicit setting of
PCI_EXP_DEVCTL_READRQ = 0 (i.e., max 128 bytes for bus-mastering PCIe DMA
read request) to:
+    pcie_bus_config = PCIE_BUS_PEER2PEER;

with the following commentary:
    "The second part is how the driver sets up the Max_Read_Request_Size
    value for the first device/function on bus 1, i.e. the device
    plugged directly into the PCIe root port.
    For all I can tell, this is in fact incomplete, as it does not
    perform the same setting on devices attached to a PCIe switch,
    or multi-function devices.
    The solution for this part fortunately is even easier: if we
    just set the global pcie_bus_config variable to PCIE_BUS_PEER2PEER,
    all PCIe devices in the system are limited to 128 byte MPS, which
    in turn limits the MRRS to 128 bytes for all devices, and we
    no longer even need to touch any devices."

The problem is the MRRS setting is never written to the hardware.
I propose the following, though I'm not sure if we can do this safely,
especially given the comments in probe.c. OTOH, this change may be
required in other (all?) cases when the user requests
PCIE_BUS_PEER2PEER.

On this Laguna GW-2388 the following patch fixes BM DMA with:
0000:00:00.0 PCI bridge: Cavium Networks Device 3400 (rev 01)
0000:01:00.0 PCI bridge: Texas Instruments XIO2001 PCI Express-to-PCI Bridge
0000:02:0e.0 (PCI devices behind the bridge, these are doing actual BM xfers)
0001:00:00.0 PCI bridge: Cavium Networks Device 3400 (rev 01 - this is
	     the second lane from the CPU)

pci 0000:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
pci 0000:01:00.0: Max Payload Size set to  128/ 512 (was  128), Max Read Rq  128
pci 0001:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128

Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
Fixes: 498a92d42596 ("ARM: cns3xxx: pci: avoid potential stack overflow")

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..91713b6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1919,7 +1919,8 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 	/* In the "safe" case, do not configure the MRRS.  There appear to be
 	 * issues with setting MRRS to 0 on a number of devices.
 	 */
-	if (pcie_bus_config != PCIE_BUS_PERFORMANCE)
+	if (pcie_bus_config != PCIE_BUS_PERFORMANCE &&
+	    pcie_bus_config != PCIE_BUS_PEER2PEER)
 		return;
 
 	/* For Max performance, the MRRS must be set to the largest supported
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2771625..6f5088a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -756,7 +756,7 @@ enum pcie_bus_config_types {
 	PCIE_BUS_DEFAULT,	/* ensure MPS matches upstream bridge */
 	PCIE_BUS_SAFE,		/* use largest MPS boot-time devices support */
 	PCIE_BUS_PERFORMANCE,	/* use MPS and MRRS for best performance */
-	PCIE_BUS_PEER2PEER,	/* set MPS = 128 for all devices */
+	PCIE_BUS_PEER2PEER,	/* set MPS and MRSS to 128 for all devices */
 };
 
 extern enum pcie_bus_config_types pcie_bus_config;

> Note that cns3xxx is in a bit of an odd state, as only half of the
> platform code is even present in the kernel, and there is no effort
> to change that. As far as I know, the board that this was tested on
> is not present in the mainline kernel, and the board we support
> is a development system that few people even own at this point.

The boards I use (Gateworks Laguna) are basically equivalent to the
devel board (from the platform code POV).
The kernel lacks support for SMP and the Ethernet driver (and things
like GPIO), though there are patches available and I plan to integrate
them, when the existing issues are resolved.

Also, this is practically a non-DT arch but I guess a conversion to DT
would be a good thing as it would eliminate a need for board-specific
code. That's why there is no platform code for Laguna. Unfortunately
there is no DT file for CNS3xxx, and I'm not an DT expert.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
