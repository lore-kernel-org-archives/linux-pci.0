Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17390 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753908AbcGEAD5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 20:03:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u64NxLNo065390
	for <linux-pci@vger.kernel.org>; Mon, 4 Jul 2016 20:03:56 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23yfe8y6mm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2016 20:03:56 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 5 Jul 2016 10:03:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id A496E357805A
	for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2016 10:03:49 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6503nXO24182932
	for <linux-pci@vger.kernel.org>; Tue, 5 Jul 2016 10:03:49 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6503m18013450
	for <linux-pci@vger.kernel.org>; Tue, 5 Jul 2016 10:03:49 +1000
Date: Tue, 5 Jul 2016 10:03:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Michael Neuling <mikey@neuling.org>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 12/14] PCI/hotplug: pnv_php: export symbols and move
 struct types needed by cxl
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-13-git-send-email-imunsie@au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467638532-9250-13-git-send-email-imunsie@au.ibm.com>
Message-Id: <20160705000347.GA6557@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 04, 2016 at 11:22:10PM +1000, Ian Munsie wrote:
>From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
>The cxl driver will use infrastructure from pnv_php to handle device tree
>updates when switching bi-modal CAPI cards into CAPI mode.
>
>To enable this, export pnv_php_find_slot() and
>pnv_php_set_slot_power_state(), and add corresponding declarations, as well
>as the definition of struct pnv_php_slot, to asm/pnv-pci.h.
>
>Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Cc: linux-pci@vger.kernel.org
>Cc: Bjorn Helgaas <bhelgaas@google.com>
>Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---

.../...

>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>index aadce45..b719a72 100644
>--- a/drivers/pci/hotplug/Kconfig
>+++ b/drivers/pci/hotplug/Kconfig
>@@ -117,6 +117,7 @@ config HOTPLUG_PCI_POWERNV
> 	tristate "PowerPC PowerNV PCI Hotplug driver"
> 	depends on PPC_POWERNV && EEH
> 	select OF_DYNAMIC
>+	select HOTPLUG_PCI_POWERNV_BASE
> 	help
> 	  Say Y here if you run PowerPC PowerNV platform that supports
> 	  PCI Hotplug

Andrew/Ian, it seems HOTPLUG_PCI_POWERNV_BASE isn't defined and we needn't it.

Thanks,
Gavin

