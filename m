Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 4 Oct 2017 17:36:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix PCI ACS enablement
Message-ID: <20171004163647.zmgvhevi3pb4u32o@armageddon.cambridge.arm.com>
References: <1506965324-5818-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <1506965324-5818-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, linux-acpi@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 02, 2017 at 06:28:44PM +0100, Lorenzo Pieralisi wrote:
> commit f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> workarounds") removed kernel code that was allowing to initialize
> and probe the SMMU devices early (ie earlier than PCI devices, through
> linker script callback entries) in the boot process because it was not
> needed any longer in that the SMMU devices/drivers now support deferred
> probing.
> 
> Since the SMMUs probe routines are also in charge of requesting global
> PCI ACS kernel enablement, commit f6810c15cf97 ("iommu/arm-smmu: Clean
> up early-probing workarounds") also postponed PCI ACS enablement to
> SMMUs devices probe time, which is too late given that PCI devices needs
> to detect if PCI ACS is enabled to init the respective capability
> through the following call path:
> 
> pci_device_add()
>  -> pci_init_capabilities()
>   -> pci_enable_acs()
> 
> Add code in the ACPI IORT SMMU platform devices initialization path
> (that is called before ACPI PCI enumeration) to detect if there
> exists firmware mappings to map root complexes ids to SMMU ids
> and if so enable ACS for the system.
> 
> Fixes: f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> Signed-workarounds")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>

Queued for 4.14-rc4. Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
