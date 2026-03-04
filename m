Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66381946DA
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659129; cv=none; b=bkaOZYaAKy10EMLo4UisvpZ0DRowqomxXdU51UQTd46b+DPoXyClVRtT4E5xfsSlAQGh/cIkeUkN7kHIvpZo3E9iv0jRwtOFrldM9My6HBy1nKDIy/AgwycFWuydwAUM2M2wtVE7HVbXfRTmbNFdnAxCHk6dFP+qf0rdDwDBOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659129; c=relaxed/simple;
	bh=BWpyPY8xNNR1DebVzk79xtMYqs7eXVmirltGPb7Lq3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uBv5mTXve/00rcGby+tEvJJn/2MSjN2yk+avYsItSHyBdF6eiwvafRiX5XdikDyRIevCmTw8q9vo//DxeLMB1kCiVFGQ3pu68FLEN99GQUSjylBTFy+6F3r3Oht3+/mmUQibO7W6DZM7xUxJ3bWcOPWJsd/eOe/Lmy12hkYUGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjMADfqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjMADfqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB4C4CEF7;
	Wed,  4 Mar 2026 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772659129;
	bh=BWpyPY8xNNR1DebVzk79xtMYqs7eXVmirltGPb7Lq3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mjMADfqM6tp1mG1yFtXEy/Hu+jnjndJtbeXsESk8Xiza+MNL0Cn4eDNeVNWTWpL5H
	 +1eW+1QYDoW/xvmYyKnexyrh/FWCWyqTvjfWD4H5/g2W0LSiZdI2rBCnmpD/e39ehn
	 4bo55iRirvyQUF5gVSEdjk2G2odlZ2GtW5N4K1BYH/GmHbVWEFv5yAS6xAvt25RBgn
	 Klb7dANUf1a80qoUBE3zhp3071s+ATBHzW5F9V4Z5KZCswnDSiAASY7EeJMQxXdMkX
	 2i6JiXEY46z69p82x8cbb4PUS6a41Qh/PYuQewUI6v1uBPuK+sccPAjC+fviZHDCrk
	 am7ixIM6pdlnA==
Date: Wed, 4 Mar 2026 15:18:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Message-ID: <20260304211847.GA36447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35698a4-4ac0-4db4-86a0-db794047e7c4@huawei.com>

On Wed, Mar 04, 2026 at 09:34:48AM +0800, Yunsheng Lin wrote:
> On 2026/3/4 5:55, Bjorn Helgaas wrote:
> > [+cc Yunsheng, author of ad5086108b9f,
> > +bcc commenters on https://bugzilla.kernel.org/show_bug.cgi?id=218951,
> > see the email thread at
> > https://lore.kernel.org/all/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]
> > 
> > On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
> >> Dear Linux folks,
> >>
> >> On the servers below Linux warns:
> >>
> >>      Unknown NUMA node; performance will be reduced
> >>
> >> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0
> >> 05/14/2021
> >> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5
> >> 09/06/2016
> >> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4
> >> 11/08/2016
> >> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0
> >> 08/29/2013
> >> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1
> >> 01/02/2020
> >> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4
> >> 08/17/2017
> >> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4
> >> 10/04/2015
> >> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0
> >> 12/23/2019
> >> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5
> >> 04/13/2016
> >> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022
> > 
> > Similar reports in the bugzilla for:
> > 
> >   Host: VMware VM Ubuntu 24.04.1
> >   CPU: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz
> >   Kernel: 6.11.0-rc6
> > 
> > and 
> > 
> >   Lenovo P700 workstation
> >   6.19.5 kernel
> > 
> > ad5086108b9f ("PCI: Warn if no host bridge NUMA node info") added this
> > "Unknown NUMA node; performance will be reduced" warning.
> > 
> > The problem is that firmware didn't tell us anything about which CPUs
> > are closest to this PCI host bridge, so we can't try to optimize by
> > running the driver on a CPU that's close to the device.
> > 
> > The kernel can't figure out this locality information itself, so
> > there's nothing we can really do in the kernel, and there's nothing
> > users can do either other than check for BIOS updates.
> > 
> > What if we just downgraded the message to "info"?  And/or we could
> > reword this to be less alarming.
> 
> If I recalled it correctly, the purpose of the above warning is about
> having some kind of pressure for vendor to update the BIOS and fix
> that, perhaps the warning can be reworded to something like below
> so that users can know where they get the help to fix that?
> 
> "Unknown NUMA node; performance will be reduced, please check it with
> the BIOS vendor."

Right.  I'm just not sure that kind of pressure on vendors is
effective, and I'm tired of fielding reports of things we can't fix
and likely aren't even problems at all.

In Paul's Dell T630 case, where we have the dmesg in email and the
acpidump in https://bugzilla.kernel.org/show_bug.cgi?id=218951, there
are four host bridges and two supply _PXM and two don't:

  ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
  pci_bus 0000:ff: Unknown NUMA node; performance will be reduced
  ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
  pci_bus 0000:7f: Unknown NUMA node; performance will be reduced
  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])

I decoded the acpidump Paul attached; it has _PXM for PCI0 and PCI1.
UNC0 and UNC1 don't have any I/O or memory windows at all, so they
look like they're for internal "devices" that only have config space.  

Since Dell *did* supply _PXM for PCI0 and PCI1, my guess is that
there's no real reason to supply it for UNC0 and UNC1.

I think we should do something like the patch below, so the dmesg
would look like this instead -- we log the NUMA node when we know it
and skip it otherwise:

  ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
  PCI host bridge to bus 0000:ff
  ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
  PCI host bridge to bus 0000:7f
  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
  PCI host bridge to bus 0000:00 NUMA node 0
  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
  PCI host bridge to bus 0000:80 NUMA node 1

Bjorn


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..e3e81926a6f3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -993,9 +993,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
 	bool bus_registered = false;
-	char addr[64], *fmt;
+	char numa[32], addr[64], *fmt;
 	const char *name;
-	int err;
+	int err, node;
 
 	bus = pci_alloc_bus(NULL);
 	if (!bus)
@@ -1071,13 +1071,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
+	numa[0] = '\0';
+	if (nr_node_ids > 1) {
+		node = pcibus_to_node(bus);
+		if (node != NUMA_NO_NODE)
+			snprintf(numa, sizeof(numa), " on NUMA node %u", node);
+	}
+
 	if (parent)
-		dev_info(parent, "PCI host bridge to bus %s\n", name);
+		dev_info(parent, "PCI host bridge to bus %s%s\n", name, numa);
 	else
-		pr_info("PCI host bridge to bus %s\n", name);
-
-	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
-		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
+		pr_info("PCI host bridge to bus %s%s\n", name, numa);
 
 	/* Check if the boot configuration by FW needs to be preserved */
 	bridge->preserve_config = pci_preserve_config(bridge);
