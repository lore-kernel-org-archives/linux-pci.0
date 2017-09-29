Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 29 Sep 2017 17:08:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] ACPI/IORT: Fix PCI ACS enablement
Message-ID: <20170929160850.GA31394@red-moon>
References: <20170919170539.6265-1-lorenzo.pieralisi@arm.com>
 <59C3A36A.2060202@hisilicon.com> <20170922094546.GE1523@red-moon>
 <59C5C655.8030607@hisilicon.com> <20170928154625.GA25853@red-moon>
 <59CDCAB6.3000906@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <59CDCAB6.3000906@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-acpi@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 12:23:18PM +0800, Zhou Wang wrote:
> On 2017/9/28 23:46, Lorenzo Pieralisi wrote:
> > On Sat, Sep 23, 2017 at 10:26:29AM +0800, Zhou Wang wrote:
> >> On 2017/9/22 17:45, Lorenzo Pieralisi wrote:
> >>> On Thu, Sep 21, 2017 at 07:32:58PM +0800, Zhou Wang wrote:
> >>>> On 2017/9/20 1:05, Lorenzo Pieralisi wrote:
> >>>>> commit f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> >>>>> workarounds") removed kernel code that was allowing to initialize
> >>>>> and probe the SMMU devices early (ie earlier than PCI devices through
> >>>>> linker script callback entries) in the boot process because it was not
> >>>>> needed any longer in that the SMMU devices/drivers now support deferred
> >>>>> probing.
> >>>>>
> >>>>> Since the SMMUs probe routines are also in charge of requesting global
> >>>>> PCI ACS kernel enablement, commit f6810c15cf97 ("iommu/arm-smmu: Clean
> >>>>> up early-probing workarounds") also postponed PCI ACS enablement to
> >>>>> SMMUs devices probe time, which may be too late given that PCI devices
> >>>>> needs to detect if PCI ACS is enabled to init the respective capability
> >>>>> through the following call path:
> >>>>>
> >>>>> pci_device_add()
> >>>>>  -> pci_init_capabilities()
> >>>>>   -> pci_enable_acs()
> >>>>>
> >>>>> Add code in the ACPI IORT SMMU platform devices initialization path
> >>>>> (that is called before ACPI PCI enumeration) to detect if an SMMU is
> >>>>> present in HW and enable PCI ACS if it actually is, restoring the
> >>>>> correct PCI ACS enablement sequencing.
> >>>>>
> >>>>> Fixes: f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> >>>>> Signed-workarounds")
> >>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> >>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>>>> ---
> >>>>>  drivers/acpi/arm64/iort.c | 11 +++++++++++
> >>>>>  1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>>>> index 9565d57..71a7694 100644
> >>>>> --- a/drivers/acpi/arm64/iort.c
> >>>>> +++ b/drivers/acpi/arm64/iort.c
> >>>>> @@ -1184,6 +1184,7 @@ static void __init iort_init_platform_devices(void)
> >>>>>  	struct acpi_table_iort *iort;
> >>>>>  	struct fwnode_handle *fwnode;
> >>>>>  	int i, ret;
> >>>>> +	bool smmu_detected = false;
> >>>>>  
> >>>>>  	/*
> >>>>>  	 * iort_table and iort both point to the start of IORT table, but
> >>>>> @@ -1218,11 +1219,21 @@ static void __init iort_init_platform_devices(void)
> >>>>>  				acpi_free_fwnode_static(fwnode);
> >>>>>  				return;
> >>>>>  			}
> >>>>> +
> >>>>> +			smmu_detected = true;
> >>>>>  		}
> >>>>>  
> >>>>>  		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> >>>>>  					 iort_node->length);
> >>>>>  	}
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * If IORT reports an SMMU component make sure PCI ACS is
> >>>>> +	 * requested so that PCI devices can enable it in their
> >>>>> +	 * capabilities.
> >>>>> +	 */
> >>>>> +	if (smmu_detected)
> >>>>> +		pci_request_acs();
> >>>>>  }
> >>>>>  
> >>>>>  void __init acpi_iort_init(void)
> >>>>>
> >>>>
> >>>> Hi Lorenzo,
> >>>>
> >>>> I tested this patch, it works well in my HiSilicon Hip08 based system.
> >>>> However, setting ACS flag at the stage of SMMU device init seems not good,
> >>>> I mean what if in one system there are only platform devices connected to
> >>>> SMMU device.
> >>>
> >>> That's a fair point if you explain to me how current pci_request_acs()
> >>> usage copes with your remark above.
> >>
> >> The current pci_request_acs usage for ARM SMMU-V3 sets ACS flags under CONFIG_PCI.
> >> However, as mentioned in your commit message, this setting is too late.
> >>
> >> For the usage of X86 and AMD, as I am not familiar with the devices used in these
> >> two platforms, maybe the default devices in these platforms are PCIe based :)
> > 
> > I do not understand what your point is. ACS enablement is a global flag,
> > that is currently set whenever an x86/AMD/ARM IOMMU is detected/probed
> > AFAICS.
> 
> There are named devices(platform devices) and/or PCI devices connected to SMMU.
> However, ACS flags is only for PCI devices. So setting this flag in SMMU device init
> maybe need check if there are PCIe devices connected to SMMU, as maybe devices connected
> to SMMU are all named devices.

Understood but that's a problem that exists in the current kernel,
what I am saying is that's not what I am fixing with this patch.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
