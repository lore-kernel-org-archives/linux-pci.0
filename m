Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-13-jean-philippe.brucker@arm.com>
 <20171013191051.lgxbcobkzzj5guhv@rob-hp-laptop>
 <e7288f51-1cfa-44ce-e3ce-e9f3daf91579@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Oct 2017 21:06:20 -0500
Message-ID: <CAL_JsqLFDeNq=PoipFv4qjKKP2mhE+2Eou4dBZhfm=XuXxjHrg@mail.gmail.com>
Subject: Re: [RFCv2 PATCH 12/36] dt-bindings: document stall and PASID
 properties for IOMMU masters
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 5:23 AM, Jean-Philippe Brucker
<jean-philippe.brucker@arm.com> wrote:
> On 13/10/17 20:10, Rob Herring wrote:
>> On Fri, Oct 06, 2017 at 02:31:39PM +0100, Jean-Philippe Brucker wrote:
>>> On ARM systems, some platform devices behind an IOMMU may support stall
>>> and PASID features. Stall is the ability to recover from page faults and
>>> PASID offers multiple process address spaces to the device. Together they
>>> allow to do paging with a device. Let the firmware tell us when a device
>>> supports stall and PASID.
>>
>> Can't these be implied by the compatible string of the devices?
>
> I think that PASID capacity can be deduced from the compatible string but
> don't know how these devices will be implemented (the only known example
> being a software model for testing). In any case implementing PASID based
> on the compatible string is tricky, because the IOMMU driver needs to know
> PASID capacity before the device driver has had time to probe the device.
> Maybe we could get away with a static table associating compatible string
> to PASID capacity, but it's not very nice.
>
> For stall it's a property of the integration between device and IOMMU,
> much like the "iommus" property, so it can't be deduced only from the
> compatible string. It's crucial that the firmware validates that stalling
> is safe, because we don't have any other way to discover it.

Okay, fair enough. I'll let others comment.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
