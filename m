Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDAFC43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CAD21726
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546986629;
	bh=hXnMppBc3pgIEOn2BXm63YNiYbwzeHEpcsiQ/uzH2Vo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TsNSAG3RJzqC0h9rw4yGIBDCq5TpZ+00JLGGOZkCloTpOpkOqgi0h2lFSuM+frt8N
	 bt9yfnOuT9QO8mIf/VnSc7Sd/Zuvql+m0IsNwqccmU+bOYbn39MZn1gjr7gQ4mG7YK
	 kFcu8JuiSH4CcIgMGofuMiLblXmHK633aQPhwjyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfAHWa2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbfAHWa2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 17:30:28 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5171A20665;
        Tue,  8 Jan 2019 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546986627;
        bh=hXnMppBc3pgIEOn2BXm63YNiYbwzeHEpcsiQ/uzH2Vo=;
        h=Date:From:To:Cc:Subject:From;
        b=d0tFW0jR/zJ+oALZ7m+kmx7JDFbj56gT9DSOEyAOFtVIgHdRbs6E623oevDaD3oPV
         WkylKhjBM6wLu3nfjjb8r6wTPvVn5vX8AKIPBPKMtBj0lUFYH0Xf78VcSTJuEQLL0q
         T9uepaluzZlPF4O20miGOQvdPlplfzrYtmseR34s=
Date:   Tue, 8 Jan 2019 16:30:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kconfig label updates
Message-ID: <20190108223024.GA147017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I want to update the PCI Kconfig labels so they're more consistent and
useful to users, something like the patch below.  IIUC, the items
below are all IBM-related; please correct me if not.

I'd also like to expand (or remove) "RPA" because Google doesn't find
anything about "IBM RPA", except Robotic Process Automation, which I
think must be something else.

Is there some text expansion of RPA that we could use that would be
meaningful to a user, i.e., something he/she might find on a nameplate
or in a user manual?

Ideally the PCI Kconfig labels would match the terms used in
arch/.../Kconfig, e.g.,

  config PPC_POWERNV
    bool "IBM PowerNV (Non-Virtualized) platform support"

  config PPC_PSERIES
    bool "IBM pSeries & new (POWER5-based) iSeries"

  config MARCH_Z900
    bool "IBM zSeries model z800 and z900"

  config MARCH_Z9_109
    bool "IBM System z9"

Bjorn


diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e9f78eb390d2..1c1d145bfd84 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_POWERNV
-	tristate "PowerPC PowerNV PCI Hotplug driver"
+	tristate "IBM PowerNV PCI Hotplug driver"
 	depends on PPC_POWERNV && EEH
 	select OF_DYNAMIC
 	help
@@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA
-	tristate "RPA PCI Hotplug driver"
+	tristate "IBM Power Systems RPA PCI Hotplug driver"
 	depends on PPC_PSERIES && EEH
 	help
 	  Say Y here if you have a RPA system that supports PCI Hotplug.
+	  This includes the earlier pSeries and iSeries.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpaphp.
@@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_RPA_DLPAR
-	tristate "RPA Dynamic Logical Partitioning for I/O slots"
+	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
 	depends on HOTPLUG_PCI_RPA
 	help
 	  Say Y here if your system supports Dynamic Logical Partitioning
@@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
 	  When in doubt, say N.
 
 config HOTPLUG_PCI_S390
-	bool "System z PCI Hotplug Support"
+	bool "IBM System z PCI Hotplug Support"
 	depends on S390 && 64BIT
 	help
 	  Say Y here if you want to use the System z PCI Hotplug
