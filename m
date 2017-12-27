Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 27 Dec 2017 19:34:15 +0000
From: Jayachandran C <jnair@caviumnetworks.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V1 0/1] Fix kernel panic caused by device ID duplication
 presented to the IOMMU
Message-ID: <20171227193414.GA17016@localhost>
References: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <7f7fca76-88f8-6ee7-c402-fe4300c62253@arm.com>
MIME-Version: 1.0
In-Reply-To: <7f7fca76-88f8-6ee7-c402-fe4300c62253@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, linux-pci@vger.kernel.org,
 joro@8bytes.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ganapatrao.Kulkarni@cavium.com,
 bhelgaas@google.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,
On Tue, Dec 19, 2017 at 04:34:46PM +0000, Robin Murphy wrote:
> Hi Tomasz,
> 
> On 19/12/17 15:13, Tomasz Nowicki wrote:
> >Here is my lspci output of ThunderX2 for which I am observing kernel panic coming from
> >SMMUv3 driver -> arm_smmu_write_strtab_ent() -> BUG_ON(ste_live):
> >
> ># lspci -vt
> >-[0000:00]-+-00.0-[01-1f]--+ [...]
> >                            + [...]
> >                            \-00.0-[1e-1f]----00.0-[1f]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
> >
> >ASP device -> 1f:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family
> >PCI-Express to PCI/PCI-X Bridge -> 1e:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
> >While setting up ASP device SID in IORT dirver:
> >iort_iommu_configure() -> pci_for_each_dma_alias()
> >we need to walk up and iterate over each device which alias transaction from
> >downstream devices.
> >
> >AST device (1f:00.0) gets BDF=0x1f00 and corresponding SID=0x1f00 from IORT.
> >Bridge (1e:00.0) is the first alias. Following PCI Express to PCI/PCI-X Bridge
> >spec: PCIe-to-PCI/X bridges alias transactions from downstream devices using
> >the subordinate bus number. For bridge (1e:00.0), the subordinate is equal
> >to 0x1f. This gives BDF=0x1f00 and SID=1f00 which is the same as downstream
> >device. So it is possible to have two identical SIDs. The question is what we
> >should do about such case. Presented patch prevents from registering the same
> >ID so that SMMUv3 is not complaining later on.
> 
> Ooh, subtle :( There is logic in arm_smmu_attach_device() to tolerate
> grouped devices aliasing to the same ID, but I guess I overlooked the
> distinction of a device sharing an alias ID with itself. I'm not sure
> I really like trying to work around this in generic code, since
> fwspec->ids is essentially opaque data in a driver-specific format - in
> theory a driver is free to encode a single logical ID into multiple
> fwspec elements (I think I did that in an early draft of SMMUv2 SMR
> support), at which point this approach might corrupt things massively.
> 
> Does the (untested) diff below suffice?
> 
> Robin.
> 
> ----->8-----diff --git a/drivers/iommu/arm-smmu-v3.c
> b/drivers/iommu/arm-smmu-v3.c
> index f122071688fd..d8a730d83401 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1731,7 +1731,7 @@ static __le64 *arm_smmu_get_step_for_sid(struct
> arm_smmu_device *smmu, u32 sid)
> 
>  static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
>  {
> -	int i;
> +	int i, j;
>  	struct arm_smmu_master_data *master = fwspec->iommu_priv;
>  	struct arm_smmu_device *smmu = master->smmu;
> 
> @@ -1739,6 +1739,13 @@ static void arm_smmu_install_ste_for_dev(struct
> iommu_fwspec *fwspec)
>  		u32 sid = fwspec->ids[i];
>  		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
> 
> +		/* Bridged PCI devices may end up with duplicated IDs */
> +		for (j = 0; j < i; j++)
> +			if (fwspec->ids[j] == sid)
> +				break;
> +		if (j < i)
> +			continue;
> +
>  		arm_smmu_write_strtab_ent(smmu, sid, step, &master->ste);
>  	}
>  }

Here is another tested by if you need one more:
Tested-by: Jayachandran C. <jnair@caviumnetworks.com>

This fixes the crash below seen in ThunderX2 boards with Aspeed BMC (when
booted without iommu.passthrough). Since this is a regression that breaks
bootup on the platform, can you consider submitting this for the 4.15 cycle?

[   84.729351] ------------[ cut here ]------------
[   84.729354] kernel BUG at /home/ubuntu/linux/drivers/iommu/arm-smmu-v3.c:1201!
[   84.729358] Internal error: Oops - BUG: 0 [#1] SMP
[   84.729360] Modules linked in: ast(+) ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops qede(+) drm q
ed bnx2x(+) mpt3sas raid_class scsi_transport_sas sdhci_acpi mdio sdhci libcrc32c gpio_xlp
[   84.729375] CPU: 190 PID: 1725 Comm: systemd-udevd Not tainted 4.15.0-rc5 #37
[   84.729376] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 11/08/2017
[   84.729379] pstate: 80400009 (Nzcv daif +PAN -UAO)
[   84.729388] pc : arm_smmu_write_strtab_ent+0x1f0/0x1f8
[   84.729391] lr : arm_smmu_install_ste_for_dev+0x70/0xc8
[   84.729392] sp : ffff00001f6e3730
[   84.729393] x29: ffff00001f6e3730 x28: ffff809ecc0d2268
[   84.729395] x27: 0000000000000018 x26: ffff00001f6e3910
[   84.729397] x25: ffff809ecc0d2238 x24: ffff809ecdc94158
[   84.729398] x23: 0000000000000018 x22: 0000000000001d00
[   84.729400] x21: ffff809ecdc90018 x20: ffff809ecb5ef288
[   84.729401] x19: ffff80beca480000 x18: ffff0000093b8c08
[   84.729402] x17: ffff000008aeab70 x16: ffff00001f6e3a20
[   84.729404] x15: 0000000000000000 x14: dead000000000100
[   84.729405] x13: dead000000000200 x12: 0000000000000020
[   84.729407] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[   84.729408] x9 : 0000000000000000 x8 : 0000000000000000
[   84.729410] x7 : 0000000000000100 x6 : 0000000000000015
[   84.729411] x5 : 0000000000000015 x4 : 0000000000000002
[   84.729413] x3 : ffff809ecb5ef288 x2 : 0000000000000001
[   84.729414] x1 : ffff000008691e30 x0 : ffff809ecc0d2238
[   84.729418] Process systemd-udevd (pid: 1725, stack limit = 0x000000002c585821)
[   84.729420] Call trace:
[   84.729423]  arm_smmu_write_strtab_ent+0x1f0/0x1f8
[   84.729425]  arm_smmu_install_ste_for_dev+0x70/0xc8
[   84.729426]  arm_smmu_attach_dev+0x100/0x2f8
[   84.729431]  __iommu_attach_device+0x54/0xe0
[   84.729433]  iommu_group_add_device+0x150/0x428
[   84.729435]  iommu_group_get_for_dev+0x84/0x180
[   84.729436]  arm_smmu_add_device+0x138/0x240
[   84.729445]  iort_iommu_configure+0x138/0x188
[   84.729452]  acpi_dma_configure+0x3c/0x80
[   84.729456]  dma_configure+0xb0/0xe0
[   84.729462]  driver_probe_device+0x1f0/0x4a8
[   84.729464]  __driver_attach+0x124/0x128
[   84.729466]  bus_for_each_dev+0x70/0xb0
[   84.729467]  driver_attach+0x30/0x40
[   84.729469]  bus_add_driver+0x248/0x2b8
[   84.729471]  driver_register+0x68/0x100
[   84.729478]  __pci_register_driver+0x5c/0x70
[   84.729488]  ast_init+0x30/0x1000 [ast]
[   84.729494]  do_one_initcall+0x5c/0x168
[   84.729501]  do_init_module+0x64/0x1f4
[   84.729502]  load_module+0x1e64/0x21e8
[   84.729503]  SyS_finit_module+0x108/0x118
[   84.729505]  el0_svc_naked+0x20/0x24
[   84.729508] Code: 34ffff82 d4210000 d2800120 17ffffd8 (d4210000)

Thanks,
JC.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
