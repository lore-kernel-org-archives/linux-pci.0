Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20161026110459.GA15276@red-moon>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
 <20161026110459.GA15276@red-moon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Oct 2016 12:24:48 +0200
Message-ID: <CAJZ5v0i=ZZDwnAU_=cAW5NR5M7EAOVPmpdqfMhf_jGmeZoHLVQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] ACPI IORT ARM SMMU support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Eric Auger <eric.auger@redhat.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Dennis Chen <dennis.chen@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 26, 2016 at 1:04 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Rafael, Joerg (and anyone else CC'ed),
>
> On Tue, Oct 18, 2016 at 05:03:58PM +0100, Lorenzo Pieralisi wrote:
>> This patch series is v6 of a previous posting:
>>
>> https://lkml.org/lkml/2016/9/9/418
>>
>> v5 -> v6
>>       - Rebased against v4.9-rc1
>>       - Changed FWNODE_IOMMU to FWNODE_ACPI_STATIC
>>       - Moved platform devices creation into IORT code
>>       - Updated fwnode handling
>>       - Added default dma masks initialization
>
> Any comments on v6 ? Patches touching generic ACPI code
> are {1, 2, 7}, patch 4 updates the IOMMU of_iommu_{set/get}_ops()
> API to make it work on ACPI systems too, by replacing the
> device_node with a fwnode_handle pointer as look-up token;
> the remainder of patches are ARM specific and creates the
> infrastructure to probe ARM SMMU devices through ACPI,
> ARM IORT table in particular. Given the generic bits changes
> above I would not leave it to late -rc to reach an agreement
> please, thank you.

I'll do my best to look at these in the next few days, but please also
note what I wrote before:

http://marc.info/?l=linux-acpi&m=147744344531599&w=2

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
