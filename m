Return-Path: <SRS0=3Aw/=HG=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=3Aw/=HG=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180416213536.GC28657@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
 <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com>
 <20180414160918.GA158153@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T5Qzm1uSSZJH38pgYrSuhxo1W-EJK-LU+NpWBgvoehm2w@mail.gmail.com> <20180416213536.GC28657@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Tue, 17 Apr 2018 14:33:52 +0530
Message-ID: <CABe79T630o8cHkLZDZ8N+8f6MjsS7JE2ggLAv5Z0XuM9Eqsa7Q@mail.gmail.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
	Rajat Jain <rajatja@google.com>, Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you for more insight you have given about the problem.

For us the issue comes before we disable apst feature.
on APST quirk set, NVMe driver disable apst by send a command to NVMe
controller.
We see issue at the time of NVMe initialization only.

So APST quirk did not helped.



On Tue, Apr 17, 2018 at 3:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Keith, linux-nvme, LKML; another possible ASPM issue with Samsung
> NVMe SSD 960 EVO]
>
> On Mon, Apr 16, 2018 at 09:03:33PM +0530, Srinath Mannam wrote:
>> On Sat, Apr 14, 2018 at 9:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Sat, Apr 14, 2018 at 09:04:05AM +0530, Srinath Mannam wrote:
>> >> I am sorry, in previous mail by mistake I have written L1.s support is
>> >> not there, Actually I wanted to write L0s support is not there.
>> >> L1 and L1ss support is there.
>> >
>> > If your endpoint (and everything in the path) advertise both LTR and
>> > L1ss support, that patch probably won't make a difference.
>> >
>> > It *might* make a difference if only part of the path supports both,
>> > because my reading of the spec is that L1ss requires LTR and LTR
>> > requires the entire path to support LTR, and we currently don't
>> > enforce that "entire path" part before enabling L1ss.
>> >
>> Yes, this patch did not work.
>
> OK, thanks for checking.  Since there's only one link in the path and
> both ends advertise L1SS and LTR support, I wouldn't expect it to make
> a difference.
>
>> >> But In our platform we required to disable ASPM.
>>
>> > We're trying to figure out exactly *why* you must disable ASPM.  If
>> > it's because of a hardware defect, e.g., the device advertises ASPM
>> > support but it's actually broken, we probably need to add a quirk.
>> > Given the complexity of ASPM, it's surprising we don't have similar
>> > quirks already.
>>
>> We see issues with ASPM enabled. Some link issues observed so for
>> time being we are using with aspm disabled until we fix that issue.
>
> I see other reports of ASPM issues with that Samsung 960 PRO NVMe SSD.
> Maybe they're related?
>
>   https://lkml.kernel.org/r/20171214184701.GA6322@libmpq.org
>   https://forums.lenovo.com/t5/ThinkCentre-A-E-M-S-Series/M900-Tiny-UEFI-Bug-M-2-NVMe-SSD-amp-8260-WiFi-ASPM-disabled-Much/td-p/3570469
>
> You might try setting NVME_QUIRK_NO_APST to see if that's related.
> There are some quirks that sound similar:
>
>   8427bbc22486 ("nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A")
>   467c77d4cbef ("nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A")
>
> Keith, et al, here's the relevant part of Srinath's lspci.  Both ends
> of the link claim to support ASPM including L1SS and LTR, but Srinath
> has to disable ASPM to get the SSD to work reliably.  Just FYI.
>
>> 0000:00:00.0 PCI bridge: Broadcom Limited Device d714 (prog-if 00 [Normal decode])
>>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>        Capabilities: [ac] Express (v2) Root Port (Slot-), MSI 00
>>                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <1us, L1 <2us
>>                        ClockPM+ Surprise- LLActRep- BwNot+ ASPMOptComp+
>>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via WAKE# ARIFwd+
>>                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>>                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
>>                         AtomicOpsCtl: ReqEn- EgressBlck-
>>        Capabilities: [240 v1] L1 PM Substates
>>                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>                          PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
>>                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                           T_CommonMode=1us LTR1.2_Threshold=0ns
>
>> 0000:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961 (prog-if 02 [NVM Express])
>>        Capabilities: [70] Express (v2) Endpoint, MSI 00
>>                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>>                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
>>                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>>                         AtomicOpsCtl: ReqEn-
>>        Capabilities: [190 v1] L1 PM Substates
>>                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>                          PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>>                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                           T_CommonMode=0us LTR1.2_Threshold=0ns
>
>
>> with LTR enabled also we observed some problem, that after LTR
>> messages received from EP, we see completion timeout with config
>> write.
>
>> So I thought If LTR configuration function also part of aspm file,
>> as it was under CONFIG_ASPM.  using pcie_aspm boot arg I can disable
>> both ASPM and LTR.
>
>> If this is not possible, then I will go for alternative solution of
>> quirk implementation as you suggest.
>
> Is this platform a lab prototype or is it already shipping?  If it's
> already shipping, you probably need some sort of upstream solution
> like an NVMe or PCIe quirk, but if not, maybe you can just hack your
> bringup kernel to disable ASPM and LTR until you fix the root cause.
>
we are at evolution stage so we need to fix this ASAP.
As you said earlier, Can I add sysfs interface to enable LTR same as
we do L1SS or in the part of aspm cap init function.

> Bjorn

Regards,
Srinath.
