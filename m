Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
To: Sricharan R <sricharan@codeaurora.org>, <robin.murphy@arm.com>,
 <will.deacon@arm.com>, <joro@8bytes.org>, <lorenzo.pieralisi@arm.com>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <tn@semihalf.com>,
 <hanjun.guo@linaro.org>, <okaya@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <58D49845.9060407@hisilicon.com>
Date: Fri, 24 Mar 2017 11:53:41 +0800
MIME-Version: 1.0
In-Reply-To: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/10 3:00, Sricharan R wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
> 
> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>        |                         |
> pci_bus_add_device     (device_add/driver_register)
>        |                         |
> device_attach           device_initial_probe
>        |                         |
> __device_attach_driver    __device_attach_driver
>        |
> driver_probe_device
>        |
> really_probe
>        |
> dma_configure
> 
> Similarly on the device/driver_unregister path __device_release_driver is
> called which inturn calls dma_deconfigure.
> 
> Rebased the series against mainline 4.11-rc1. Applies and builds cleanly
> against mainline and linux-next. There is a conflict with patch#9
> against iommu-next, but that should go away eventually as iommu-next
> is rebased against 4.11-rc1.
>   
> * Tested with platform and pci devices for probe deferral
>   and reprobe on arm64 based platform.

Hi Sricharan,

I applied this series on v4.11-rc1 to test PCIe pass through in HiSilicon
D05 board(with Intel 82599 networking card). It failed.

After I used:

echo vfio-pci > /sys/bus/pci/devices/0002:81:10.0/driver_override
echo 0002:81:10.0 > /sys/bus/pci/drivers/ixgbevf/unbind
echo 0002:81:10.0 > /sys/bus/pci/drivers_probe

to bind vfio-pci driver to Intel 82599 networking card VF.

I got log in host:
[...]
[  414.275818] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 3.2.2-k
[  414.275824] ixgbevf: Copyright (c) 2009 - 2015 Intel Corporation.
[  414.276647] ixgbe 0002:81:00.0 eth12: SR-IOV enabled with 1 VFs
[  414.342252] pcieport 0002:80:00.0: can't derive routing for PCI INT A
[  414.342255] ixgbe 0002:81:00.0: PCI INT A: no GSI
[  414.343348] ixgbe 0002:81:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4
[  414.448135] pci 0002:81:10.0: [8086:10ed] type 00 class 0x020000
[  414.448713] iommu: Adding device 0002:81:10.0 to group 4
[  414.449798] ixgbevf 0002:81:10.0: enabling device (0000 -> 0002)
[  414.451101] ixgbevf 0002:81:10.0: PF still in reset state.  Is the PF interface up?
[  414.451103] ixgbevf 0002:81:10.0: Assigning random MAC address
[  414.451414] ixgbevf 0002:81:10.0: be:30:8f:ed:f8:02
[  414.451417] ixgbevf 0002:81:10.0: MAC: 1
[  414.451418] ixgbevf 0002:81:10.0: Intel(R) 82599 Virtual Function
[  414.464271] VFIO - User Level meta-driver version: 0.3
[  414.570074] ixgbe 0002:81:00.0: registered PHC device on eth12
[  414.700493] specified DMA range outside IOMMU capability                                      <-- error here
[  414.700496] Failed to set up IOMMU for device 0002:81:10.0; retaining platform DMA ops        <-- error here
[  414.748043] ixgbe 0002:81:00.0 eth12: detected SFP+: 5
[  414.922277] ixgbe 0002:81:00.0 eth12: NIC Link is Up 10 Gbps, Flow Control: RX/TX

Then I tried to boot up VM using:

qemu-system-aarch64 \
-machine virt,gic-version=3 \
-enable-kvm \
-cpu host \
-m 1024 \
-kernel ./Image_vm \
-initrd ./minifs.cpio.gz \
-nographic \
-net none -device vfio-pci,host=0002:81:10.0,id=net0

I got this error:

root@ubuntu:~/scripts# ./qemu_run.sh
[  402.581445] kernel BUG at drivers/iommu/arm-smmu-v3.c:1064!
[  402.587007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  402.592479] Modules linked in: vfio_iommu_type1 vfio_pci irqbypass vfio_virqfd vfio ixgbevf ixgb                                                                                                            e mdio [last unloaded: vfio_iommu_type1]
[  402.604733] CPU: 26 PID: 4437 Comm: qemu-system-aar Not tainted 4.11.0-rc1-g4b62e7fa #21
[  402.612809] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 UEFI 16.12 Release 02/22                                                                                                            /2017
[  402.622013] task: ffff8017e2161a00 task.stack: ffff8017e5a8c000
[  402.627926] PC is at arm_smmu_write_strtab_ent+0x1b4/0x1b8
[  402.633399] LR is at arm_smmu_install_ste_for_dev+0x9c/0xc0
[  402.638957] pc : [<ffff000008542b08>] lr : [<ffff000008542ba8>] pstate: 80000145
[  402.646338] sp : ffff8017e5a8fb50
[  402.649638] x29: ffff8017e5a8fb50 x28: ffff8013d3e4e468
[  402.654938] x27: ffff00000854240c x26: 0000ffffffffffff
[  402.660237] x25: ffff8013cd0b7100 x24: ffff8013e58fc018
[  402.665536] x23: ffff8013e58f8018 x22: 0000000000000018
[  402.670835] x21: 0000000000028180 x20: ffff8013e58f8018
[  402.676134] x19: 0000000000000001 x18: 0000000000783488
[  402.681434] x17: 0000ffff967caa50 x16: ffff000008207410
[  402.686733] x15: 0000000000782a54 x14: 0000ffff9670be14
[  402.692031] x13: 0000000000783060 x12: 0000000000000012
[  402.697330] x11: 0000000000000001 x10: 0000000000000900
[  402.702629] x9 : 00000000000000ff x8 : 0000000000000000
[  402.707928] x7 : ffff80003e040190 x6 : 000bdff385002ea1
[  402.713227] x5 : 0000000000000018 x4 : 0000000000000001
[  402.718526] x3 : ffff8013cd0b7108 x2 : ffff80003e6f6000
[  402.723824] x1 : ffff000008542ab0 x0 : ffff8013d3e4fe38
[  402.729123]
[  402.730602] Process qemu-system-aar (pid: 4437, stack limit = 0xffff8017e5a8c000)
[  402.738070] Stack: (0xffff8017e5a8fb50 to 0xffff8017e5a90000)
[  402.743802] fb40:                                   ffff8017e5a8fb90 ffff000008542ba8
[  402.751617] fb60: 0000000000000002 ffff8013cd0b7200 ffff8013cd0b7108 ffff8013e58f8140
[  402.759432] fb80: ffff8013e58f8018 ffff80003e6f6000 ffff8017e5a8fbd0 ffff000008543514
[  402.767247] fba0: ffff8013d3e4fe68 ffff8013cd0b7108 0000000000000000 ffff8013e68140a0
[  402.775063] fbc0: ffff8013d3e4fe08 ffff8013d3e4fe38 ffff8017e5a8fc80 ffff00000853a840
[  402.782878] fbe0: ffff8013e432df00 ffff8013d3e4fe68 ffff8013ccb28d48 ffff8013ccb28d00
[  402.790693] fc00: ffff8017e5f69a08 ffff8017e5f69a80 ffff00000096f380 ffff8017e5f69a18
[  402.798508] fc20: ffff8013ccb28d00 ffff8017e5f69a80 0000000000000000 0000000040201000
[  402.806323] fc40: 0000002c00000030 ffff0000089efae8 ffff8013e65b8410 00000017e59d8000
[  402.814138] fc60: 0000000000000000 0000000400803510 000000000004ff44 0000000000000000
[  402.821954] fc80: ffff8017e5a8fcb0 ffff00000853a8cc ffff8013ccb28d58 ffff8013d3e4fe68
[  402.829769] fca0: ffff8017e5f69b00 ffff0000009a93c0 ffff8017e5a8fce0 ffff0000009a7970
[  402.837584] fcc0: ffff8017e5f69b80 ffff8017e5f69a98 ffff8017e5a8fce0 ffff8013ccb28d00
[  402.845399] fce0: ffff8017e5a8fd90 ffff00000096c688 ffff8013d3e7f100 ffff8013ca9e9280
[  402.853214] fd00: ffff8017e5f69a00 0000000000000003 ffff8017e5f69a08 ffff8017e5f69a80
[  402.861029] fd20: ffff00000096f380 ffff8017e5f69a18 ffffffffffffffed ffff8017e2161a00
[  402.868844] fd40: ffff8017e5f69a08 0000000000000003 ffff00000096f380 ffff8017e5f69a18
[  402.876659] fd60: ffffffffffffffed 0000400000000010 ffff8017e5a8fd90 ffff000008e492d8
[  402.884475] fd80: 0000000000003b66 ffff8013ca9e9280 ffff8017e5a8fdf0 ffff000008206d28
[  402.892290] fda0: ffff8013d3e4fd00 0000000000000003 ffff8013d43a0318 0000000000000010
[  402.900105] fdc0: 0000000000003b66 0000000000000003 0000000000000123 000000000000001d
[  402.907920] fde0: ffff000008902000 0000000000000010 ffff8017e5a8fe80 ffff000008207494
[  402.915735] fe00: 0000000000000000 ffff8013d3e4fd01 ffff8013d3e4fd00 0000000000000010
[  402.923550] fe20: 0000000000003b66 ffff0000081f2594 ffff8017e5a8fe60 ffff000008212508
[  402.931365] fe40: ffff8017e5a8fe80 ffff000008207450 0000000000000000 ffff8013d3e4fd01
[  402.939180] fe60: ffff8013d3e4fd00 0000000000000010 0000000000003b66 ffff000008207434
[  402.946995] fe80: 0000000000000000 ffff000008082f30 0000000000000000 00008017f31b0000
[  402.954810] fea0: ffffffffffffffff 0000ffff967caa5c 0000000020000000 0000000000000015
[  402.962625] fec0: 0000000000000010 0000000000003b66 0000000000000003 0000000000000003
[  402.970440] fee0: 0000000000000000 0000000000000040 000000000000003f 0000000000000000
[  402.978255] ff00: 000000000000001d 0000000000000004 0000000000000000 0000ffffe6bbe7e0
[  402.986070] ff20: ffffffffffffffff 0000000000783060 0000ffff9670be14 0000000000782a54
[  402.993885] ff40: 0000000000a74630 0000ffff967caa50 0000000000783488 000000003151e080
[  403.001700] ff60: 0000ffffe6bbe86c 0000000000000004 0000000000af7000 0000000000b15000
[  403.009515] ff80: 0000000000af8450 0000000031222c50 0000000000000001 0000000031abb800
[  403.017331] ffa0: 0000000031de2650 0000ffffe6bbe7e0 00000000004b8468 0000ffffe6bbe7e0
[  403.025146] ffc0: 0000ffff967caa5c 0000000020000000 0000000000000010 000000000000001d
[  403.032961] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  403.040775] Call trace:
[  403.043208] Exception stack(0xffff8017e5a8f980 to 0xffff8017e5a8fab0)
[  403.049635] f980: 0000000000000001 0001000000000000 ffff8017e5a8fb50 ffff000008542b08
[  403.057450] f9a0: ffff000008e1b778 0000000000000001 ffff000008f1ebb8 00000000000006fc
[  403.065265] f9c0: 0000000000000000 000000000003e6fb 0000000400000123 000000000003e800
[  403.073080] f9e0: 0000000000000000 0000000000000000 ffff8017e5a8f9f0 ffff8017e5a8f9f0
[  403.080895] fa00: ffff8017e5a8fa50 ffff00000838feb0 ffff8013e58f8030 0000005d4ebe3be6
[  403.088711] fa20: ffff8013d3e4fe38 ffff000008542ab0 ffff80003e6f6000 ffff8013cd0b7108
[  403.096526] fa40: 0000000000000001 0000000000000018 000bdff385002ea1 ffff80003e040190
[  403.104341] fa60: 0000000000000000 00000000000000ff 0000000000000900 0000000000000001
[  403.112155] fa80: 0000000000000012 0000000000783060 0000ffff9670be14 0000000000782a54
[  403.119970] faa0: ffff000008207410 0000ffff967caa50
[  403.124835] [<ffff000008542b08>] arm_smmu_write_strtab_ent+0x1b4/0x1b8
[  403.131349] [<ffff000008542ba8>] arm_smmu_install_ste_for_dev+0x9c/0xc0
[  403.137950] [<ffff000008543514>] arm_smmu_attach_dev+0x1a4/0x2c0
[  403.143942] [<ffff00000853a840>] __iommu_attach_group+0x48/0xa8
[  403.149848] [<ffff00000853a8cc>] iommu_attach_group+0x2c/0x48
[  403.155584] [<ffff0000009a7970>] vfio_iommu_type1_attach_group+0x208/0x720 [vfio_iommu_type1]
[  403.164099] [<ffff00000096c688>] vfio_fops_unl_ioctl+0x188/0x2b8 [vfio]
[  403.170701] [<ffff000008206d28>] do_vfs_ioctl+0xb4/0x79c
[  403.175998] [<ffff000008207494>] SyS_ioctl+0x84/0x98
[  403.180950] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
[  403.186249] Code: f9400860 b5fff9c0 17ffffd9 d4210000 (d4210000)
[  403.192351] ---[ end trace 0bda8b3549cfd903 ]---

Dropping this series, 82599 VF can work well in QEMU.

P.S.

To avoid some hardware bugs, I temporarily commented/added some codes in v4.11-rc1:

@@ -1104,8 +1104,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
  	arm_smmu_sync_ste_for_sid(smmu, sid);

  	/* It's likely that we'll want to use the new STE soon */
 -	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
 -		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
 +//	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
 +//		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
  }

  static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)


 @@ -664,7 +664,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
  	msg->address_hi		= upper_32_bits(addr);
  	msg->data		= its_get_event_id(d);

 -	iommu_dma_map_msi_msg(d->irq, msg);
 +	//iommu_dma_map_msi_msg(d->irq, msg);
  }

  static struct irq_chip its_irq_chip = {

@@ -4179,6 +4179,14 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
  	return ret;
  }

 +static int pci_quirk_hisi_rp_acs(struct pci_dev *dev, u16 acs_flags)
 +{
 +	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
 +	int ret = acs_flags & ~flags ? 0 : 1;
 +
 +	return ret;
 +}
 +
  /*
   * Sunrise Point PCH root ports implement ACS, but unfortunately as shown in
   * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
 @@ -4345,6 +4353,8 @@ static const struct pci_dev_acs_enabled {
  	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
  	/* Cavium ThunderX */
  	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 +	/* Hisilicon Hip05/Hip06 root ports */
 +	{ PCI_VENDOR_ID_HUAWEI,	0x1610, pci_quirk_hisi_rp_acs },
  	{ 0 }
  };

If you have time, could you please take a look at this issue?

Thanks,
Zhou

> 
> Previous post of this series [6]. 
> 
>  [V9]
>      * Rebased on top of 4.11-rc1.
> 
>      * Merged Robin's fixes for legacy binding issue,
>        pci devices with no iommu-map property.
>      
>  [V8]
>      * Picked up all the acks and tested tags from Marek and
>        Hanjun for DT and ACPI patches respectively, since
>        no functional changes was done.
> 
>      * Addressed Minor comments Sinan and Bjorn.
> 
>      * Added Robin's fix for fixing the deferencing NULL for
>        of_iommu_table after init in patch #2.
> 
>      * Rebased it on top of linux-next
> 
>  [V7]
>      * Updated the subject and commit log for patch #6 as per
>        comments from Lorenzo. No functional changes.
> 
>  [V6]
>      * Fixed a bug in dma_configure function pointed out by
>        Robin.
>      * Reordered the patches as per comments from Robin and
>        Lorenzo.
>      * Added Tags.
> 
>  [V5]
>      * Reworked the pci configuration code hanging outside and
>        pushed it to dma_configure as in PATCH#5,6,7.
>        Also added a couple of patches that Lorenzo provided for
>        correcting the Probe deferring mechanism in case of
>        ACPI devices from here [5].
> 
>  [V4]
>      * Took the reworked patches [2] from Robin's branch and
>        rebased on top of Lorenzo's ACPI IORT ARM support series [3].
> 
>      * Added the patches for moving the dma ops configuration of
>        acpi based devices to probe time as well.
>  [V3]
>      * Removed the patch to split dma_masks/dma_ops configuration
>        separately based on review comments that both masks and ops are
>        required only during the device probe time.
> 
>      * Reworked the series based on Generic DT bindings series.
> 
>      * Added call to iommu's remove_device in the cleanup path for arm and
>        arm64.
> 
>      * Removed the notifier trick in arm64 to handle early device
>        registration.
> 
>      * Added reset of dma_ops in cleanup path for arm based on comments.
> 
>      * Fixed the pci_iommu_configure path and tested with PCI device as
>        well.
>  
>      * Fixed a bug to return the correct iommu_ops from patch 7 [4] in
>        last post.
> 
>      * Fixed few other cosmetic comments.
>   
>  [V2]
>      * Updated the Initial post to call dma_configure/deconfigure from
>        generic code
>  
>      * Added iommu add_device callback from of_iommu_configure path
> 
>  [V1]
>      * Initial post from Laurent Pinchart [1]
> 
> [1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html
> [2] http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/defer
> [3] https://lkml.org/lkml/2016/11/21/141
> [4] https://www.mail-archive.com/iommu@xxxxxxxxxxxxxxxxxxxxxxxxxx/msg13940.html
> [5] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git iommu/probe-deferral
> [6] http://www.spinics.net/lists/linux-pci/msg57992.html
> [7] https://www.spinics.net/lists/arm-kernel/msg556209.html
> 
> Laurent Pinchart (3):
>   of: dma: Move range size workaround to of_dma_get_range()
>   of: dma: Make of_dma_deconfigure() public
>   iommu: of: Handle IOMMU lookup failure with deferred probing or error
> 
> Lorenzo Pieralisi (2):
>   ACPI/IORT: Add function to check SMMUs drivers presence
>   ACPI/IORT: Remove linker section for IORT entries probing
> 
> Robin Murphy (3):
>   iommu/of: Refactor of_iommu_configure() for error handling
>   iommu/of: Prepare for deferred IOMMU configuration
>   iommu/arm-smmu: Clean up early-probing workarounds
> 
> Sricharan R (3):
>   of/acpi: Configure dma operations at probe time for platform/amba/pci
>     bus devices
>   drivers: acpi: Handle IOMMU lookup failure with deferred probing or
>     error
>   arm64: dma-mapping: Remove the notifier trick to handle early setting
>     of dma_ops
> 
>  arch/arm64/mm/dma-mapping.c       | 142 +++++---------------------------------
>  drivers/acpi/arm64/iort.c         |  40 ++++++++++-
>  drivers/acpi/glue.c               |   5 --
>  drivers/acpi/scan.c               |   7 +-
>  drivers/base/dd.c                 |   9 +++
>  drivers/base/dma-mapping.c        |  41 +++++++++++
>  drivers/iommu/arm-smmu-v3.c       |  46 +-----------
>  drivers/iommu/arm-smmu.c          | 110 +++++++++++++----------------
>  drivers/iommu/of_iommu.c          | 126 ++++++++++++++++++++++++---------
>  drivers/of/address.c              |  20 +++++-
>  drivers/of/device.c               |  34 ++++-----
>  drivers/of/platform.c             |  10 +--
>  drivers/pci/probe.c               |  28 --------
>  include/acpi/acpi_bus.h           |   2 +-
>  include/asm-generic/vmlinux.lds.h |   1 -
>  include/linux/acpi.h              |   7 +-
>  include/linux/acpi_iort.h         |   3 -
>  include/linux/dma-mapping.h       |   3 +
>  include/linux/of_device.h         |  10 ++-
>  19 files changed, 308 insertions(+), 336 deletions(-)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
