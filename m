Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 21/40] iommu/arm-smmu-v3: Add support for Substream IDs
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-22-jean-philippe.brucker@arm.com>
 <BLUPR0201MB1505AA55707BE2E13392FFAFA5630@BLUPR0201MB1505.namprd02.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <be58739e-ed03-396f-c7ac-19a3195aef87@arm.com>
Date: Fri, 1 Jun 2018 11:46:07 +0100
MIME-Version: 1.0
In-Reply-To: <BLUPR0201MB1505AA55707BE2E13392FFAFA5630@BLUPR0201MB1505.namprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 Ravikiran Gummaluri <rgummal@xilinx.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 Robin Murphy <Robin.Murphy@arm.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 31/05/18 12:01, Bharat Kumar Gogada wrote:
>>  static void arm_smmu_sync_cd(void *cookie, int ssid, bool leaf)  {
>> +	struct arm_smmu_cmdq_ent cmd = {
>> +		.opcode	= CMDQ_OP_CFGI_CD_ALL,
> 
> Hi Jean, here CMDQ_OP_CFGI_CD opcode 0x5. 

Woops, nice catch!

I pushed fixes for all comments so far to branch sva/current

Thanks,
Jean


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
