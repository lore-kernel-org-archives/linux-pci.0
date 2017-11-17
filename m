Return-Path: <SRS0=bAUk=CP=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=bAUk=CP=nvidia.com=vidyas@kernel.org>
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
 <7b61f849-2a0a-528e-aa6f-b259fda2294b@nvidia.com>
 <20171114231307.GA13646@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f8024b01-74de-7610-53ab-f5be30077de5@nvidia.com>
Date: Fri, 17 Nov 2017 19:35:21 +0530
MIME-Version: 1.0
In-Reply-To: <20171114231307.GA13646@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 15 November 2017 04:43 AM, Bjorn Helgaas wrote:
> On Sun, Nov 12, 2017 at 05:21:47PM +0530, Vidya Sagar wrote:
>> On Saturday 11 November 2017 02:59 AM, Bjorn Helgaas wrote:
>>> On Fri, Nov 10, 2017 at 03:37:10PM +0530, Vidya Sagar wrote:
>>>> LTR_L1.2_THRESHOLD time is for the device to enter into and exit
>>> >from L1.2 state.
>>> That doesn't feel right to me.  Device characteristics are normally
>>> communicated via "capabilities" registers, not programmed by the OS in
>>> "control" registers.  The OS needs to be able to configure arbitrary
>>> plug-in devices without having device-specific details built into it.
>> But there is no capability register/field for LTR_L1.2_THRESHOLD either =
for
>> root ports or end points
> Sorry, I didn't state that clearly.  I agree that LTR_L1.2_THRESHOLD
> should be the time required to enter and exit the L1.2 state.
>
> What doesn't make sense to me is that the OS would have to have
> device-specific quirks built into it instead of being able to discover
> what it needs via "capabilities" registers.  If it did, we would have
> no way to configure a plug-in switch unless we added a quirk for every
> device.  That would be a serious design error in the L1 Substates
> feature.
>
> Assume we have an Endpoint connected to a Root Port.  We should set
> LTR_L1.2_THRESHOLD to the time it takes to transition the Link from L0
> to L1.2 and back to L0.  Then we will enter L1.2 only if the Endpoint
> has reported that it can tolerate at least that much latency.
>
>  From sec 5.5.3.3.1, Figures 5-16 and 5-17, it looks like the latency
> to go from L1.0 to L1.2 and back to L0 should be at least the sum of:
>
>    T(POWER_OFF)       max 2us (from Table 5-11)
>    T(L1.2)            min 4us (from Table 5-11)
>    T(POWER_ON)        from L1 PM Substates Control 2 register
>    T(COMMONMODE)      from L1 PM Substates Control 1 register
>
> This doesn't include (a) the time from L0 to L1.0 and (b) the gap
> between T(POWER_ON) and T(COMMONMODE).  I don't know how to learn
> those.  But I think we know how to compute T(POWER_ON) and
> T(COMMONMODE) by taking the max of Port T_POWER_ON and Port
> Common_Mode_Restore_Time for the two ends of the Link.
>
> Your lspci output (below) shows:
>
>    Root Port: Port T_POWER_ON =3D 70us
>    Root Port: Port Common_Mode_Restore_Time =3D 30us
>    Endpoint:  Port T_POWER_ON =3D 10us
>    Endpoint:  Port Common_Mode_Restore_Time =3D 10us
>
> That would make T(POWER_ON) =3D max(70us, 10us) =3D 70us
> and T(COMMONMODE) =3D max(30us, 10us) =3D 30us.
>
> So I would think the LTR_L1.2_THRESHOLD should be at least
>
>    2us + 4us + 70us + 30us =3D 106us
>
> Your hardware folks came up with 55us, but I don't know how.  I guess
> they're using information not visible to the OS?
>
> Can you explain where I'm going wrong in my calculations?  I think we
> should be able to relate the values from the L1 PM Substates
> Capabilities register to the timing diagrams in sec 5.5.3.3.1 somehow.

Your calculations are correct. This is in fact the value we used=20
initially, but, later on Tegra hardware is tweaked
by which T_POWER_ON is brought down to 35us and T_cmrt to 14us (to=20
achieve better power savings for a
specific endpoint) thereby arriving at 55us of LTR_L1.2_THRESHOLD value.
Its my mistake that I didn't update these new values for T_PowerOn and=20
T_cmrt.
Also, I got the confirmation from our hardware folks that, it is better=20
to go with 70us and 30us for T_PowerOn and
T_cmrt respectively and stick to 106us of LTR_L1.2_THRESHOLD to be able=20
to work with variety of end points.
Now that, having a strong API implementation to supply=20
LTR_L1.2_THRESHOLD from host controller driver (and weak
API implementation in aspm sub-system) doesn't seem correct, do you=20
suggest to derive LTR_L1.2_THRESHOLD value
(like you mentioned above) and then update it in both RP and EP L1SS=20
control registers? Though it doesn't include gaps (a) and (b) above,
I think it is still the best way to come up a suitable=20
LTR_L1.2_THRESHOLD value without having to be supplied by host=20
controller drivers.

>> Here is the L1 SS registers dumps for both root port and end point
>> 00:01.0 PCI bridge: NVIDIA Corporation Device 0fae (rev a1) (prog-if
>> 00 [Normal decode])
>>  =C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] L1 PM Substates
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.=
1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 PortCom=
monModeRestoreTime=3D30us PortTPowerOnTime=3D70us
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1=
.1+ ASPM_L1.2+ ASPM_L1.1+
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 T=
_CommonMode=3D30us LTR1.2_Threshold=3D56320ns
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D70us
>>
>> 01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5001
>> (prog-if 02 [NVM Express])
>>  =C2=A0=C2=A0=C2=A0 Capabilities: [2c0 v1] L1 PM Substates
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.=
1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 PortCom=
monModeRestoreTime=3D10us PortTPowerOnTime=3D10us
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1=
.1+ ASPM_L1.2+ ASPM_L1.1+
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 T=
_CommonMode=3D0us LTR1.2_Threshold=3D56320ns
>>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 L1SubCtl2: T_PwrOn=3D70us
> Bjorn
