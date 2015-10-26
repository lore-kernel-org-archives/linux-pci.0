Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:43053 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJZDRt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2015 23:17:49 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 26 Oct 2015 08:47:46 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id D4341E0054
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9Q3Hg4r1507658
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:42 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9Q3HfXN011045
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:41 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V10 00/12] VF EEH on Power8
Date: Mon, 26 Oct 2015 11:15:50 +0800
Message-Id: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset enables EEH on SRIOV VFs. The general idea is to create proper
VF edev and VF PE and handle them properly.

Different from the Bus PE, VF PE just contain one VF. This introduces the
difference of EEH error handling on a VF PE. Generally, it has several
differences.

First, the VF's removal and re-enumerate rely on its PF. VF has a tight
relationship between its PF. This is not proper to enumerate a VF by usual
scan procedure. That's why virtfn_add/virtfn_remove are exported in this patch
set.

Second, the reset/restore of a VF is done in kernel space. FW is not aware of
the VF, this means the usual reset function done in FW will not work. One of
the patch will imitate the reset/restore function in kernel space.

Third, the VF may be removed during the PF's error_detected function. In this
case, the original error_detected->slot_reset->resume sequence is not proper
to those removed VFs, since they are re-created by PF in a fresh state. A flag
in eeh_dev is introduce to mark the eeh_dev is in error state. By doing so, we
track whether this device needs to be reset or not.

This has been tested both on host and in guest on Power8 with latest kernel
version.

v10:
   * delete the last patch "powerpc/powernv: compound PE for VFs" since after
     redesign of SRIOV, there is no compound PE for VFs now.
   * add two patches which fix problems found during tests
     powerpc/eeh: Support error recovery for VF PE                                 
     powerpc/eeh: Handle hot removed VF when PF is EEH aware
v9:
   * split pcibios_bus_add_device() into a separate patch
   * Bjorn acked the PCI part and agreed this patch set to be merged from ppc
     tree
   * rebased on mpe/linux.git next branch
v8:
   * fix on checking the return value of pnv_eeh_do_flr()
   * introduced a weak function pcibios_bus_add_device() to create PE for VFs
v7:
   * fix compile error when PCI_IOV is not set
v6:
   * code / commit log refactor by Gavin
v5:
   * remove the compound field, iterate on Master VF PE instead
   * some code refine on PCI config restore and reset on VF
     the wait time for assert and deassert
     PCI device address format
     check on edev->pcie_cap and edev->aer_cap before access them
v4:
   * refine the change logs, comment and code style
   * change pnv_pci_fixup_vf_eeh() to pnv_eeh_vf_final_fixup() and remove the
     CONFIG_PCI_IOV macro
   * reorder patch 5/6 to make the logic more reasonable
   * remove remove_dev_pci_data()
   * remove the EEH_DEV_VF flag, use edev->physfn to identify a VF EEH DEV and
     remove related CONFIG_PCI_IOV macro
   * add the option for VF reset
   * fix the pnv_eeh_cfg_blocked() logic
   * replace pnv_pci_cfg_{read,write} with eeh_ops->{read,write}_config in
     pnv_eeh_vf_restore_config()
   * rename pnv_eeh_vf_restore_config() to pnv_eeh_restore_vf_config()
   * rename pnv_pci_fixup_vf_caps() to pnv_pci_vf_header_fixup() and move it
     to arch/powerpc/platforms/powernv/pci.c
   * add a field compound in pnv_ioda_pe to link compound PEs
   * handle compound PE for VF PEs
v3:
   * add back vf_index in pci_dn to track the VF's index
   * rename ppdev in eeh_dev to physfn for consistency
   * move edev->physfn assignment before dev->dev.archdata.edev is set
   * move pnv_pci_fixup_vf_eeh() and pnv_pci_fixup_vf_caps() to eeh-powernv.c
   * more clear and detail in commit log and comment in code
   * merge eeh_rmv_virt_device() with eeh_rmv_device()
   * move the cfg_blocked check logic from pnv_eeh_read/write_config() to
     pnv_eeh_cfg_blocked()
   * move the vf reset/restore logic into its own patch, two patches are
     created.
     powerpc/powernv: Support PCI config restore for VFs
     powerpc/powernv: Support EEH reset for VFs
   * simplify the vf reset logic
v2:
   * add prefix pci_iov_ to virtfn_add/virtfn_remove
   * use EEH_DEV_VF as a flag for a VF's eeh_dev
   * use eeh_dev instead of edev in change log
   * remove vf_index in eeh_dev, calculate it from pdn->busno and devfn
   * do eeh_add_device_late() and eeh_sysfs_add_device() both after pci_dev is
     well initialized
   * do FLR to reset a VF PE
   * imitate the restore function in FW for VF
   * remove the reverse order patch, since it is still under discussion

Gavin Shan (1):
  powerpc/eeh: Don't block PCI config on resetting VF PE

Wei Yang (11):
  PCI/IOV: Rename and export virtfn_add/virtfn_remove
  PCI: Add pcibios_bus_add_device() weak function
  powerpc/pci: Cache VF index in pci_dn
  powerpc/pci: Remove VFs prior to PF
  powerpc/eeh: Cache only BARs, not windows or IOV BARs
  powerpc/powernv: EEH device for VF
  powerpc/eeh: Create PE for VFs
  powerpc/powernv: Support EEH reset for VF PE
  powerpc/powernv: Support PCI config restore for VFs
  powerpc/eeh: Support error recovery for VF PE
  powerpc/eeh: Handle hot removed VF when PF is EEH aware

 arch/powerpc/include/asm/eeh.h               |  10 ++
 arch/powerpc/include/asm/pci-bridge.h        |   2 +
 arch/powerpc/kernel/eeh.c                    |  17 ++-
 arch/powerpc/kernel/eeh_cache.c              |   6 +-
 arch/powerpc/kernel/eeh_dev.c                |   1 +
 arch/powerpc/kernel/eeh_driver.c             | 130 ++++++++++++----
 arch/powerpc/kernel/eeh_pe.c                 |  13 +-
 arch/powerpc/kernel/pci-hotplug.c            |   2 +-
 arch/powerpc/kernel/pci_dn.c                 |  16 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 220 ++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c         |  18 +++
 drivers/pci/bus.c                            |   3 +
 drivers/pci/iov.c                            |  10 +-
 include/linux/pci.h                          |   8 +
 14 files changed, 408 insertions(+), 48 deletions(-)

-- 
2.5.0

