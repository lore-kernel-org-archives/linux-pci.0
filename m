Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033205AbdEXVyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 17:54:03 -0400
Received: from [10.228.68.174] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 856A1608C5
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2017 21:54:01 +0000 (UTC)
To: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Subject: PCI Secondary Bus Reset Analysis
Message-ID: <a6d9150a-d975-36d7-fffc-8b16c52c0f20@codeaurora.org>
Date: Wed, 24 May 2017 17:54:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have been surveying the code path to see if we are saving and restoring the
device settings following secondary bus reset. I have done this work before. 
I wanted to have some fresh eyes on this problem. 

Here is what I found:

handle_error_source()
	do_recovery()
		reset_link()
			default_reset_link()
				pci_reset_bridge_secondary_bus
handle_error_source()
	do_recovery()
		reset_link()
			aer_root_reset()
				Disable Root's interrupt in response to error messages (ROOT_PORT_INTR_ON_MESG_MASK)
				pci_reset_bridge_secondary_bus()
				Clear Root Error Status
				Enable Root Port's interrupt in response to error messages	(ROOT_PORT_INTR_ON_MESG_MASK)

vfio_pci_disable()
	vfio_pci_try_bus_reset()
		pci_try_reset_bus()
			pci_bus_save_and_disable()
				pci_set_power_state(D0)
				pci_save_state()
					Save the first 64 bytes
					pci_save_pcie_state()
					        pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_RTCTL,  &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
						pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
					pci_save_vc_state()
				pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
			pci_reset_bridge_secondary_bus()
			pci_bus_restore()
				pci_restore_pcie_state()
				pci_restore_ats_state()
				pci_restore_vc_state()
				pci_cleanup_aer_error_status_regs()
				pci_restore_config_space()
				pci_restore_msi_state()
				pci_enable_acs()
				pci_restore_iov_state()

vfio_pci_ioctl()
	pci_try_reset_bus()
		pci_bus_save_and_disable()
		pci_reset_bridge_secondary_bus()
		pci_bus_restore()

pci_reset_bus()
	pci_bus_save_and_disable()
	pci_bus_reset()
		pci_reset_bridge_secondary_bus()
	pci_bus_restore()

pci_reset_function()
	pci_dev_save_and_disable()
	pci_dev_reset()
		__pci_dev_reset()
			pci_parent_bus_reset()
				pci_reset_bridge_secondary_bus()
	pci_dev_restore()

pcistub_device_release()
	__pci_reset_function_locked()
		__pci_dev_reset()
			pci_parent_bus_reset()
				pci_reset_bridge_secondary_bus()
	pci_restore_state(dev)

pci_try_reset_function()
	pci_dev_save_and_disable()
	__pci_dev_reset()
		pci_parent_bus_reset()
			pci_reset_bridge_secondary_bus()
	pci_dev_restore()

pci_reset_slot()
	pci_slot_save_and_disable()
	pci_slot_reset()
		pci_reset_hotplug_slot()
			reset_slot()
				pciehp_reset_slot()
					pci_reset_bridge_secondary_bus()
	pci_slot_restore()

pci_try_reset_slot()
	pci_slot_save_and_disable()
	pci_reset_hotplug_slot()
		reset_slot()
			pciehp_reset_slot()
				pci_reset_bridge_secondary_bus()
	pci_slot_restore()

trigger_sbr()
	pci_reset_bridge_secondary_bus()


The summary is:
1. AER doesn't save and restore the bus state. 
2. pci_reset_function() and pci_try_reset_function() saves and restores
device state but it can actually reset the bus without restoring other device states.
3. trigger_sbr() doesn't save anything. 

I can submit some patches to pick up from where I left but I wanted to hear other's opinion
on what the behavior should be and if I missed something.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
