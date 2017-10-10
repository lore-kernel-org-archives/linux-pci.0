Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 9 Oct 2017 19:15:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Message-ID: <20171010001542.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
 <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
 <20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, gabriele.paoloni@huawei.com,
 marc.zyngier@arm.com, linux-pci@vger.kernel.org, joro@8bytes.org,
 john.garry@huawei.com, will.deacon@arm.com, linuxarm@huawei.com,
 sudeep.holla@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wangzhou1@hisilicon.com,
 guohanjun@huawei.com, bhelgaas@google.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, devel@acpica.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 06:54:52PM -0500, Bjorn Helgaas wrote:
> Please change subject line:
> 
> -  PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
> +  PCI: hisi: Blacklist hip06/hip07 controllers behind SMMUv3
> 
> On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of
> > HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> > for MSI transactions.
> 
> I don't suppose there's a URL for this erratum, is there?
> 
> > PCIe controller on these platforms has to differentiate the MSI
> > payload against other DMA payload and has to modify the MSI
> > payload. This basically makes it difficult for this platforms to
> > have a SMMU translation for MSI. In order to workaround this, ARM
> > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > Such a quirk is currently missing for DT based systems and therefore
> > we need to blacklist the hip06/hip07 PCIe controllers.
> 
> I don't understand the DT connection here.  If this is a hardware
> erratum, I assume the a quirk would be required whether the system
> uses DT, ACPI, etc.
> 
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> I assume this will go via some non-PCI tree.  If I were applying this,
> I would look for an ack from Zhou or Gabriele in addition to mine.

Never mind about this part; I see they already have acked it.  I really
need to learn to read the whole thread before responding :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
