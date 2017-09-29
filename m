Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:7721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdI2EkO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Sep 2017 00:40:14 -0400
From: "Zheng, Lv" <lv.zheng@intel.com>
To: Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: ACPI object counter overrun on frequent nvme resets
Date: Fri, 29 Sep 2017 04:40:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6F735@SHSMSX101.ccr.corp.intel.com>
References: <20170925130729.GA14151@infradead.org>
In-Reply-To: <20170925130729.GA14151@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

I've converted this bug into a Bugzilla entry here:
https://bugzilla.kernel.org/show_bug.cgi?id=197071

Thanks
Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of
> Subject: ACPI object counter overrun on frequent nvme resets
> 
> Hi all,
> 
> when doing an error injection test with the nvme-pci driver on Linux 4.14
> almost rc2 (820bf5c419e4b85298e5c3001bd1b5be46d60765 plus a few nvme
> patches) that does a lot of nvme resets which shut down and re-enable the
> PCI device I see a flood of warnings like:
> 
> [   78.237286] ACPI Warning: Large Reference Count (0x1001) in object ffff88007d702c68, Type=0x1D
> (20170728/utdelete-473)
> 
> Throwing in a dump_stack into the path it comes from:
> 
> [   78.238387] CPU: 0 PID: 286 Comm: kworker/u8:3 Not tainted 4.14.0-rc1+ #134
> [   78.238998] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   78.239720] Workqueue: nvme-wq nvme_reset_work
> [   78.239995] Call Trace:
> [   78.239995]  dump_stack+0x63/0x83
> [   78.239995]  acpi_ut_update_ref_count+0x2f7/0x2fe
> [   78.239995]  acpi_ut_update_object_reference+0x114/0x182
> [   78.239995]  acpi_ut_add_reference+0x1b/0x1e
> [   78.239995]  acpi_ds_init_package_element+0x149/0x16e
> [   78.239995]  ? acpi_ds_build_internal_object+0xca/0x12c
> [   78.239995]  acpi_ds_build_internal_package_obj+0x1b2/0x258
> [   78.239995]  ? acpi_ds_build_internal_package_obj+0x1b2/0x258
> [   78.239995]  acpi_ds_eval_data_object_operands+0xd3/0x123
> [   78.239995]  acpi_ds_exec_end_op+0x288/0x3e1
> [   78.239995]  acpi_ps_parse_loop+0x519/0x57b
> [   78.239995]  acpi_ps_parse_aml+0x93/0x29c
> [   78.239995]  acpi_ps_execute_method+0x148/0x17f
> [   78.239995]  acpi_ns_evaluate+0x1c1/0x24d
> [   78.239995]  acpi_ut_evaluate_object+0x72/0x197
> [   78.239995]  acpi_rs_get_prt_method_data+0x21/0x45
> [   78.239995]  acpi_get_irq_routing_table+0x2c/0x30
> [   78.239995]  acpi_pci_irq_find_prt_entry+0x8e/0x2c0
> [   78.239995]  ? irq_get_irq_data+0x9/0x20
> [   78.239995]  ? mp_unmap_irq+0xf/0x70
> [   78.239995]  acpi_pci_irq_lookup+0x26/0x1a0
> [   78.239995]  acpi_pci_irq_enable+0x5b/0x1b0
> [   78.239995]  ? pci_read_config_word+0x22/0x30
> [   78.239995]  pcibios_enable_device+0x28/0x30
> [   78.239995]  do_pci_enable_device+0x5f/0xe0
> [   78.239995]  pci_enable_device_flags+0xc3/0x110
> [   78.239995]  pci_enable_device_mem+0xe/0x10
> [   78.239995]  nvme_reset_work+0x4c/0x1610
> [   78.239995]  ? sched_clock+0x9/0x10
> [   78.239995]  ? sched_clock_local+0x17/0x90
> [   78.239995]  ? _raw_spin_lock+0x9/0x10
> [   78.239995]  ? pick_next_task_fair+0x420/0x690
> [   78.239995]  ? _raw_spin_unlock_irq+0x9/0x20
> [   78.239995]  ? finish_task_switch+0x7b/0x1f0
> [   78.239995]  ? __schedule+0x2d7/0x800
> [   78.239995]  process_one_work+0x1db/0x3e0
> [   78.239995]  worker_thread+0x43/0x3f0
> [   78.239995]  kthread+0x103/0x140
> [   78.239995]  ? process_one_work+0x3e0/0x3e0
> [   78.239995]  ? kthread_create_on_node+0x40/0x40
> [   78.239995]  ret_from_fork+0x25/0x30
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
