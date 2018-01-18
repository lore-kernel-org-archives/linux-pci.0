Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Ron Yuan <ron.yuan@memblaze.com>, "bjorn@helgaas.com" <bjorn@helgaas.com>
Cc: Bo Chen <bo.chen@memblaze.com>, William Huang
 <william.huang@memblaze.com>, Fengming Wu <fengming.wu@memblaze.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Jiang <jason.jiang@microsemi.com>,
 Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>,
 Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
 William Cheng <william.cheng@microsemi.com>,
 "Kim Helper (khelper)" <khelper@micron.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <SH2PR01MB106A1E21DEB5FE3FFB3D61C83E90@SH2PR01MB106.CHNPR01.prod.partner.outlook.cn>
 <ef16a3cc-b641-a30d-644a-7940e340eb3e@codeaurora.org>
 <SHAPR01MB173A5EA1677C2138CB528F2FEE90@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <5727b0b1-f0d5-7c78-373e-fc9d1bd662d2@codeaurora.org>
 <CABhMZUU0643U-qVc9ymA+1PMZToSLFm2dg8-cu=iQ2LGw2Pi8Q@mail.gmail.com>
 <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
Date: Thu, 18 Jan 2018 11:24:52 -0500
MIME-Version: 1.0
In-Reply-To: <SHAPR01MB173A36104635A8BFF9A83E1FEE80@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

+Linux-PCI.

Please use mailing list email syntax moving forward. (inline and 75 characters per line)

On 1/18/2018 1:21 AM, Ron Yuan wrote:
> Bjorn, 
> I believe no one in current CC list would against be cc'd in larger group. 
> 
> Sinan, 
> we do understand that BIOS have full control of MRRS. But the problem is once kernel boot with pcie_bus_perf, MRRS setting would be overwritten by the code we complained. 
> Btw, the reason we need to use pcie_bus_perf is because Intel white paper indicated system should use pcie_bus_perf to support NVMe SSD hot plug, specifically for a correct MPS to be set. 
> 
> So I think at the moment back to the code, we should 
> 1. when we don’t agree on what's the best value to set, at least remove the code MRRS=MPS, leave MRRS to default value instead of changing it incorrectly. The setting is for one device, hence the device should be responsible for itself, choosing a suitable value as default.  

As I indicated below, MRRS is not a value that a PCIe endpoint device can choose.
It depends on the root complex silicon. Some chip internal bus may handle 4k writes
poorly; whereas, another one can handle it better.

Also, according to the spec; the default value of MRRS is 512 not 4096. 

Coming back to why MRRS=MPS? I think this is because of a isochronous device statement
in the spec.

"Software must limit the Max_Payload_Size for each path that supports isochronous to meet
the isochronous latency. For example, all traffic flowing on a path from an isochronous
capable device to the Root Complex should be limited to packets that do not exceed
the Max_Payload_Size required to meet the isochronous latency requirements."

This is again a hefty price to pay for some specific PCIE endpoint type that not everybody
cares about.

> 2. try to get a common understanding what is the best performance for MRRS, maybe try largest MRRS supported by the system/device, or have additional command line input. 
> 
> Item 1 is something we should do as first step.
> For item 2, we need bigger group of experienced PCIe engineers to discuss.  

We need to understand that MPS and MRRS have much broader impact. All silicon is different.

I don't think there is a common solution to this and my preference is for these parameters
to be specified along with the perf option. Then, we can adjust things accordingly.

Let's see what others think about this.

> Here is one link for your reference:
> https://www.xilinx.com/support/documentation/white_papers/wp350.pdf 
> 

Sinan

> Thanks!
> Ron
> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas@gmail.com] 
> Sent: 2018年1月17日 22:27
> To: Sinan Kaya <okaya@codeaurora.org>
> Cc: Ron Yuan <ron.yuan@memblaze.com>; Bo Chen <bo.chen@memblaze.com>; William Huang <william.huang@memblaze.com>; Fengming Wu <fengming.wu@memblaze.com>; Bjorn Helgaas <helgaas@kernel.org>; Jason Jiang <jason.jiang@microsemi.com>; Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>; Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>; William Cheng <william.cheng@microsemi.com>; Kim Helper (khelper) <khelper@micron.com>
> Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or pcie_bus_perf On NVMe Device
> 
> I'd be happy to participate in this discussion, but I'd prefer to include the linux-pci@vger.kernel.org mailing list because that is public, archived, and searchable.  It also includes people who have worked on MPS and MRRs in the past.  If anyone doesn't want to be cc'd on that list, let me know and I'll remove you from the cc list before I respond.
> 
> On Wed, Jan 17, 2018 at 7:30 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 1/17/2018 12:04 AM, Ron Yuan wrote:
>>>
>>> The code we refer to is
>>> static void pcie_write_mrrs(struct pci_dev *dev) { ...
>>>     /* For Max performance, the MRRS must be set to the largest supported
>>>      * value.  However, it cannot be configured larger than the MPS the
>>>      * device or the bus can support.  This should already be properly
>>>      * configured by a prior call to pcie_write_mps.
>>>      */
>>>     mrrs = pcie_get_mps(dev);
>>> ...
>>> }
>>>
>>> Here the statement " However, it cannot be configured larger than the MPS the device or the bus can support." is obviously incorrect.
>>> A simple against statement is from PCIe spec, which define default MPS to 128B, and *default MRRS to 512B*.
>>> From HW understanding, MRRS is multiple of MPS in the system, it must be no less than MPS.
>>
>> Yeah, I mentioned it in my presentation too. MPS is not equal to MRRS. The only requirement is for MRRS to be a multiple of MPS.
>>
>>>
>>> Look at the code of Pcie_bus_safe/Pcie_bus_perf/Pcie_bus_peer2peer, it is not handling MRRS correctly.
>>> Peer2peer mode should actually use the smallest 128B for MRRS, which 
>>> is also discussed in https://patchwork.kernel.org/patch/8747521/
>>> Safe mode may be better match MRRS to MDS for safety reason.
>>> Perf mode should set MRRS to largest accepted value, 4k for example.
>>
>> I don't disagree.
>>
>> Choosing 4k is problematic. It could be 1k for one person and 2k for another person.We can have some configuration around this via kernel command line if Bjorn agrees.
>>
>>>
>>> Your reply says some hw logic may have poorer performance with larger MRRS sounds new to me, some HW engineer may have better look.
>>> Then in this case, "leave device recommended MRRS untouched" is more appropriate for performance purpose.
>>> Currently I can see a lot of device is using 256B MPS, and force downgrade default 4k/512B MRRS to 256B is actually getting poorer performance.
>>>
>>
>> Most BIOS allows you to choose the MPS and MRRS settings. If your BIOS does, then I recommend you to use that option at this moment for tuning your system along with the safe boot option.
>>
>>> Thanks again for your time!
>>>
>>> Ron
>>> Beijing Memblaze Technology
>>>
>>> -----Original Message-----
>>> From: Sinan Kaya [mailto:okaya@codeaurora.org]
>>> Sent: 2018年1月17日 12:21
>>> To: Bo Chen <bo.chen@memblaze.com>
>>> Cc: Ron Yuan <ron.yuan@memblaze.com>; William Huang 
>>> <william.huang@memblaze.com>; Fengming Wu <fengming.wu@memblaze.com>; 
>>> Bjorn Helgaas <helgaas@kernel.org>
>>> Subject: Re: One Question About PCIe BUS Config Type with 
>>> pcie_bus_safe or pcie_bus_perf On NVMe Device
>>>
>>> +Bjorn,
>>>
>>> Hi Bo,
>>>
>>> On 1/16/2018 9:58 PM, Bo Chen wrote:
>>>> Hi Sinan,
>>>>
>>>> We went through linux pci related code found that nvme device has different performance when kernel boot with pcie_bus_safe or pcie_bus_perf.
>>>> For details, when boot with pcie_bus_safe (eg: nvme device A: MaxPayload 128B, MaxReadReq 4096B), after pci bus init and enumerate, device A devCtl remains 128B for MaxPayload and 4096B for MaxReadReq.
>>>
>>> pcie_bus_safe option is used to balance the maximum payload size setting across the bus. The goal is to make sure that maximum payload size is consistent. That's why, it is called safe.
>>> It also honors the maximum read request size setting done by the BIOS. It does not touch the MRRS setting.
>>>
>>>> While boot with pcie_bus_perf, we found pcie_write_mrrs set the read request size to the same with MPS. For nvme device A, it means both MaxPayload and MaxReadReq are set to 128B so that we observed it has limited device performance in read req.
>>>> >From our point of view on nvme device, the setting of pcie_bus_perf has lower performance compared with setting with pcie_bus_safe.
>>>> Is there any consideration for pcie_bus_perf to set MaxReadReq the same value with pcie_bus_safe? Is there any risk when we boot with pcie_bus_perf for nvme device?
>>>> Thank you very much!
>>>>
>>>       /*
>>>        * If using the "performance" PCIe config, we clamp the
>>>        * read rq size to the max packet size to prevent the
>>>        * host bridge generating requests larger than we can
>>>        * cope with
>>>        */
>>>
>>> I found this comment in the code that seems to match the behavior you are seeing.
>>>
>>> Problem with maximum read request size is that there is no one-size-fits-all solution. It depends on the bus-fabric of the silicon you are using. An MRRS of 4k might behave slower than 1k. 1k might behave better than 512 bytes.
>>>
>>> The recommendation is for these settings to be adjustable in BIOS and tweak it according to the application.
>>>
>>> I was planning to make a change in this area but I was warned by our hardware engineers that performance does not always scale with MRRS setting.
>>>
>>> Sinan
>>>
>>
>>
>> --
>> Sinan Kaya
>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
