Return-Path: <SRS0=O8kv=CK=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=O8kv=CK=nvidia.com=vidyas@kernel.org>
Subject: Re: [PATCH V2 3/4] PCI: tegra: Apply sw fixups to support ASPM-L1
 Sub-States
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
	<yinghai@kernel.org>, <david.daney@cavium.com>, <Julia.Lawall@lip6.fr>,
	<linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>
References: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
 <1509423769-10522-4-git-send-email-vidyas@nvidia.com>
 <20171107225007.GA22847@bhelgaas-glaptop.roam.corp.google.com>
 <ef7d193c-c114-d0c6-e450-c00ae3ab2d51@nvidia.com>
 <20171108174829.GE28427@bhelgaas-glaptop.roam.corp.google.com>
 <c387c65f-6e87-639e-0bf5-2324a745ba5a@nvidia.com>
 <20171110212900.GB19895@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7b61f849-2a0a-528e-aa6f-b259fda2294b@nvidia.com>
Date: Sun, 12 Nov 2017 17:21:47 +0530
MIME-Version: 1.0
In-Reply-To: <20171110212900.GB19895@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On Saturday 11 November 2017 02:59 AM, Bjorn Helgaas wrote:
> On Fri, Nov 10, 2017 at 03:37:10PM +0530, Vidya Sagar wrote:
>>
>> On Wednesday 08 November 2017 11:18 PM, Bjorn Helgaas wrote:
>>> On Wed, Nov 08, 2017 at 02:15:05PM +0530, Vidya Sagar wrote:
>>>> On Wednesday 08 November 2017 04:20 AM, Bjorn Helgaas wrote:
>>>>> On Tue, Oct 31, 2017 at 09:52:48AM +0530, Vidya Sagar wrote:
>>>>>> Programs T_cmrt (Commmon Mode Restore Time) and T_pwr_on (Power On)
>>>>>> values to get them reflected in ASPM-L1 Sub-States capability regist=
ers
>>>>>> Also adjusts internal counter values according to 19.2 MHz clk_m val=
ue
>>>>>>
>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ...
>>>>>> +u32 pcie_aspm_get_ltr_l_1_2_threshold(void)
>>>>>> +{
>>>>>> +	/* LTR L1.2 Threshold =3D 55us for all ports */
>>>>>> +	return ((0x37 << 16) | (0x02 << 29));
>>>>> I know you've already worked through this, but let me think out loud
>>>>> to try to figure this out myself.
>>>>>
>>>>> ASPM defines Link power states L0, L0s, and L1.  L1 PM Substates
>>>>> extend that by adding L1.1 and L1.2.  L1.2 presumably uses less power
>>>>> and has a longer exit delay than L1.1 [sec 5.5].
>>>>>
>>>>> Ports that support L1.2 must support Latency Tolerance Reporting (LTR=
)
>>>>> [sec 6.18].  When LTR is enabled, a device periodically sends LTR
>>>>> messages.
>>>>>
>>>>> When ASPM puts a Link into L1, it chooses either L1.1 or L1.2 based o=
n
>>>>> LTR_L1.2_THRESHOLD and recent LTR messages.  If there's no LTR
>>>>> information it looks like LTR_L1.2_THRESHOLD doesn't matter and it
>>>>> always chooses L1.2 [sec 5.5.1].
>>>>>
>>>>> I don't see anything that writes PCI_EXP_DEVCTL2_LTR_EN, so I don't
>>>>> think Linux ever enables LTR.  Some BIOSes apparently enable it
>>>>> (Google for "LTR enabled").
>>>> I think this needs to be done in aspm.c file. i.e. whenever
>>>> sub-system enables L1.2, it should enable
>>>> LTR_EN also.
>>> That probably makes sense.
>>>
>>>>> 1) It seems like the LTR_L1.2_THRESHOLD value should be computed base=
d
>>>>>     on the latency requirements of downstream devices.  How did you
>>>>>     come up with 55us?
>>>> This is given by Tegra hardware folks.
>>> I do not understand why this value should be dependent on the host
>>> bridge.  Can your hardware folks give more insight into this and how
>>> they derived 55us?
>>>
>>> I'm repeating myself, but the threshold (in combination with LTR
>>> information) affects whether we enter L1.1 or L1.2.  If I understand
>>> correctly, this is all about the downstream devices and not at all
>>> about the host bridge.
>> LTR_L1.2_THRESHOLD time is for the device to enter into and exit
>> from L1.2 state.
> That doesn't feel right to me.  Device characteristics are normally
> communicated via "capabilities" registers, not programmed by the OS in
> "control" registers.  The OS needs to be able to configure arbitrary
> plug-in devices without having device-specific details built into it.
But there is no capability register/field for LTR_L1.2_THRESHOLD either for
root ports or end points
>
> Sec 7.33.3 says:
>
>    LTR_L1.2_THRESHOLD_Value =E2=80=93 Along with the LTR_L1.2_THRESHOLD_S=
cale,
>    this field indicates the LTR threshold used to determine if entry
>    into L1 results in L1.1 (if enabled) or L1.2 (if enabled).  The
>    default value for this field is 00 0000 0000b.
>
> which does not actually say anything about the L1.2 entry/exit time.
>
> The L0s and L1 exit latencies are read-only fields in the Link
> Capabilities register.  I don't completely understand how they work,
> but I think corresponding L1.2 exit latency information is reported
> via the "Port T(POWER_ON)" and "Port T(COMMON_MODE)" fields in the L1
> PM Substates Capabilities register.  These are HwInit fields and sec
> 5.5.4 says they depend on circuit components and AC coupling
> capacitors.
IMHO, I don't think that is the case, because, otherwise, there is no=20
need for
an end point to send LTR messages to control link's entry into L1.2 right?
and I have seen some WiFi chips sending different LTR messages depending
on whether WiFi is connected to any Access Point (AP) or not.
>
>> 55us in case of Tegra is calculated based on the circuit design and
>> different latencies involved in putting link through L1.2 entry-exit
>> cycle.
> What does Tegra report for Port T(POWER_ON) and Port T(COMMON_MODE)?
> It looks like the current lspci should decode everything in the L1 PM
> Substates capability:
> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/ls-ecaps.=
c#n584
> Can you collect that output?
Here is the L1 SS registers dumps for both root port and end point
00:01.0 PCI bridge: NVIDIA Corporation Device 0fae (rev a1) (prog-if 00=20
[Normal decode])
 =C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] L1 PM Substates
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ =
ASPM_L1.2+ ASPM_L1.1+=20
L1_PM_Substates+
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 PortCommon=
ModeRestoreTime=3D30us PortTPowerOnTime=3D70us
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+=
 ASPM_L1.2+ ASPM_L1.1+
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 T_Co=
mmonMode=3D30us LTR1.2_Threshold=3D56320ns
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D70us

01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5001=20
(prog-if 02 [NVM Express])
 =C2=A0=C2=A0=C2=A0 Capabilities: [2c0 v1] L1 PM Substates
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ =
ASPM_L1.2+ ASPM_L1.1+=20
L1_PM_Substates+
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 PortCommon=
ModeRestoreTime=3D10us PortTPowerOnTime=3D10us
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+=
 ASPM_L1.2+ ASPM_L1.1+
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 T_Co=
mmonMode=3D0us LTR1.2_Threshold=3D56320ns
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D70us

> I notice that the L1 PM SS Capabilities register contains "Port
> T(POWER_ON)" and the Control 2 register contains the "T(POWER_ON)".
> The spec says "Port T(POWER_ON)" is what this port requires of the
> opposite end of the link, so apparently we should be configuring
> "T(POWER_ON)".  We don't touch that, which looks like a hole in the
> current code.
I see that T (POWER_ON) present in capability registers of both upstream=20
and downstream ports
are compared (=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/pci/pcie/aspm.c?h=3Dv4.14-rc8#n467=20
)
and the maximum of these two is written to control registers of both=20
upstream and downstream ports
(=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/pci/pcie/aspm.c?h=3Dv4.14-rc8#n650=20
)
>> Spec says in 5.5.4 that, quote "When programming LTR_L1.2_THRESHOLD
>> Value and Scale fields, identical values must be programmed in both
>> Ports" and my understanding behind spec saying it explicitly is that
>> the end point should be made aware of what is the latency
>> requirement for L1.2 from root port, just like the way end point
>> makes root port aware of its L1.2 latency requirement by sending an
>> LTR message upstream.  By this, both root port and end point come to
>> the same page while taking a decision to keep the link in L1.2 (or
>> L1.1).
> I don't think the root port itself has a latency requirement.  The
> *endpoints* provide functionality that may be latency sensitive.  The
> OS needs to configure the path between the root port and the endpoint
> in such a way that we can satisfy the endpoint's requirements.
But, if that is the case, it doesn't make sense spec asking us to write
the same value to both ports. Or is there a different way to interpret it??
>
>> Otherwise it may so happen that Tx would be in L1.2 and Rx would be
>> in L1.1.  Also, my understanding is that it is bound to be different
>> on different platforms as it comes from the way hardware is
>> designed.
>>> What happens if you keep all the Tegra-specific parts of this series,
>>> i.e., you program the T_cmrt, T_pwr_on, and CLKREQ values, and enable
>>> advertising of ASPM L1 capability, but leave out the
>>> pcie_aspm_get_ltr_l_1_2_threshold() parts?  (BTW, I think you should
>>> reorder the series so you fix up all the delay values *before* you
>>> advertise ASPM L1.)
>>>
>>> I expect that to be functionally equivalent, but it would change the
>>> L1.1 vs L1.2 tradeoff, so it might have some performance impact,
>>> depending on what the downstream devices are.
> I'm still interested in this part of my question.  I'm willing
> to apply patches 2, 3, 4 (in the order 4, 3, 2 and omitting the
> pcie_aspm_get_ltr_l_1_2_threshold() part of patch 3) even if we
> haven't figured out patch 1.
>
> If we did this much, we should be able to use lspci to manually
> compute what we think *should* happen and use setpci to set the
> LTR_L1.2_THRESHOLD and see if it works as expected.
I'll work on this.
>
> Bjorn
