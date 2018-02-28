Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Feb 2018 16:22:13 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 16/37] iommu: Add generic PASID table library
Message-ID: <0779f165-d750-f375-41cb-90663ead9300@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-17-jean-philippe.brucker@arm.com>
 <20180227105121.7c6e1110@jacob-builder>
MIME-Version: 1.0
In-Reply-To: <20180227105121.7c6e1110@jacob-builder>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 27/02/18 18:51, Jacob Pan wrote:
[...]
>> +struct iommu_pasid_table_ops *
>> +iommu_alloc_pasid_ops(enum iommu_pasid_table_fmt fmt,
>> +		      struct iommu_pasid_table_cfg *cfg, void
>> *cookie) +{
> I guess you don't need to pass in cookie here.

The cookie is stored in the table driver and passed back to the IOMMU
driver when invalidating a PASID table entry

>> +	struct iommu_pasid_table *table;
>> +	const struct iommu_pasid_init_fns *fns;
>> +
>> +	if (fmt >= PASID_TABLE_NUM_FMTS)
>> +		return NULL;
>> +
>> +	fns = pasid_table_init_fns[fmt];
>> +	if (!fns)
>> +		return NULL;
>> +
>> +	table = fns->alloc(cfg, cookie);
>> +	if (!table)
>> +		return NULL;
>> +
>> +	table->fmt = fmt;
>> +	table->cookie = cookie;
>> +	table->cfg = *cfg;
>> +
> the ops is already IOMMU model specific, why do you need to pass cfg
> back?

The table driver needs some config information at runtime. Callbacks such
as iommu_pasid_table_ops::alloc_shared_entry() receive the
iommu_pasid_table_ops instance as argument. They can then get the
iommu_pasid_table structure with container_of() and retrieve the config
stored in table->cfg.

>> +	return &table->ops;
> If there is no common code that uses these ops, I don't see the benefit
> of having these APIs. Or the plan is to consolidate even further such
> that referene to pasid table can be attached at per iommu_domain etc,
> but that would be model specific choice.

I don't plan to consolidate further. This API is for multiple IOMMU
drivers with different transports implementing the same PASID table
formats. For example my vSVA implementation uses this API in virtio-iommu
for assigning PASID tables to the guest (All fairly experimental at this
point. I initially intended to assign just the page directories, but
passing the whole PASID table seemed more popular.)

In the future there might be other vendor IOMMUs implementing the same
PASID table formats, just like there are currently 6 IOMMU drivers using
the page-table code implemented by the io-pgtable.c lib (which I copied in
this patch).

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
