Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933861AbcIUMP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2016 08:15:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8LCDLJA004252
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:27 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0b-001b2d01.pphosted.com with ESMTP id 25kjkx36k0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 08:15:27 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 21 Sep 2016 22:15:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 33E7A2CE8056
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:21 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8LCFLpB62128164
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:21 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8LCFK9g015768
        for <linux-pci@vger.kernel.org>; Wed, 21 Sep 2016 22:15:21 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] powerpc/powernv: PCI Surprise Hotplug Support
Date: Wed, 21 Sep 2016 22:15:26 +1000
Message-Id: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series of patches supports PCI surprise hotplug on PowerNV platform.
Without the corresponding skiboot patches, this feature won't be enabled
and workable.

   * The skiboot patches can be found in below link (PATCH[01/16):
     https://patchwork.ozlabs.org/project/skiboot/list/?submitter=63923
   * This newly added functionality depends on skiboot's changes. However,
     the functionality is disabled simply when skiboot doesn't support it.
     For one specific slot, property "ibm,slot-surprise-pluggable" of the
     slot's device node is set to 1 when surprise hotplug is claimed by
     skiboot. 
   * The interrupts because of presence and link state change are enabled
     in order to support PCI surprise hotplug. The surprise hotplug events
     are queued to the PCI slot and they're picked up for further processing
     in serialized fashion. The surprise and managed hotplug share same code
     flow except: the affected PEs are put into frozen state to avoid unexpected
     EEH error reporting in surprise hot remove path.

PATCH[1/4] and PATCH[2/4] allows to freeze PEs to avoid unexpected EEH error
reporting in PCI surprise hot remove path. PATCH[3/4] clears PE's frozen state
on initializing it because the PE might have been put into frozen state in last
PCI surprise hot remove. PATCH[4/4] supports PCI surprise hotplug in the PowerNV
PCI hotplug driver.

Gavin Shan (4):
  powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
  powerpc/eeh: Export eeh_pe_state_mark()
  powerpc/powernv: Unfreeze PE on allocation
  drivers/pci/hotplug: Support surprise hotplug

 arch/powerpc/include/asm/pnv-pci.h        |   9 ++
 arch/powerpc/kernel/eeh.c                 |   1 +
 arch/powerpc/kernel/eeh_pe.c              |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  12 ++
 drivers/pci/hotplug/pnv_php.c             | 219 ++++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+)

-- 
2.1.0

