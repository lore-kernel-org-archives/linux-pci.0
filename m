Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
To: Yisheng Xie <xieyisheng1@huawei.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <9c364147-12c4-5a8a-9cd9-0642a6b92555@huawei.com>
 <3338635f-f2ba-4b78-a72b-2568645f7df3@arm.com>
 <7ba3d70a-2364-2a92-39a8-ed112807b83c@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c4ba0a3d-ef11-6e1a-9c47-7c574233d4fb@arm.com>
Date: Thu, 30 Nov 2017 13:39:31 +0000
MIME-Version: 1.0
In-Reply-To: <7ba3d70a-2364-2a92-39a8-ed112807b83c@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 30/11/17 01:11, Yisheng Xie wrote:
> Hi, Jean,
> 
> On 2017/11/29 23:01, Jean-Philippe Brucker wrote:
>> On 29/11/17 06:08, Yisheng Xie wrote:
>>>
>>>
>>> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>>>> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
>>>> +			      int *pasid, int flags)
>>>> +{
>>> [..]
>>>> +			err = iommu_process_attach_locked(context, dev);
>>>> +			if (err)
>>>> +				iommu_process_put_locked(process);
>>> one ref for a context is enough right? so also need call iommu_process_put_locked()
>>> if attach ok, or will be leak if user call bind twice for the same device and task.
>>
>> I wasn't sure, I think I prefer taking one ref for each bind. If user
>> calls bind twice, it should call unbind twice as well (in case of leak we
>> free the context on process exit).
>>
>> Also with this implementation, user can call bind for two devices in the
>> same domain, which will share the same context structure. So we have to
>> take as many refs as bind() calls.
> 
> 
> hmm, it has two ref, one for _context_ and the other for *process* (or maybe mm for
> your next version), right? For each bind it will take a ref of context as present
> design. but why also process ref need be taken for each bind? I mean it seems does
> not break _user can call bind for two devices in the same domain_.
> 
> And if you really want to take a ref of *process* for echo bind, you should put it when
> unbind, right? I just not find where you put the ref of process when unbind. But just put
> the process ref when free context.
> 
> Maybe I just miss something.

No you're right I misunderstood, sorry about that. Each context has a
single ref to a process, so we do need to drop the process ref here as you
pointed out.

I thought I exercised this path though, I'll update my test suite. Also
attach_locked shouldn't take a context ref if attach fails...

Thanks a lot,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
