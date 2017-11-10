Return-Path: <SRS0=7UtZ=CI=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=7UtZ=CI=nvidia.com=vidyas@kernel.org>
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
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c387c65f-6e87-639e-0bf5-2324a745ba5a@nvidia.com>
Date: Fri, 10 Nov 2017 15:37:10 +0530
MIME-Version: 1.0
In-Reply-To: <20171108174829.GE28427@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 08 November 2017 11:18 PM, Bjorn Helgaas wrote:
> On Wed, Nov 08, 2017 at 02:15:05PM +0530, Vidya Sagar wrote:
>> On Wednesday 08 November 2017 04:20 AM, Bjorn Helgaas wrote:
>>> On Tue, Oct 31, 2017 at 09:52:48AM +0530, Vidya Sagar wrote:
>>>> Programs T_cmrt (Commmon Mode Restore Time) and T_pwr_on (Power On)
>>>> values to get them reflected in ASPM-L1 Sub-States capability register=
s
>>>> Also adjusts internal counter values according to 19.2 MHz clk_m value
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ...
>>>> +u32 pcie_aspm_get_ltr_l_1_2_threshold(void)
>>>> +{
>>>> +	/* LTR L1.2 Threshold =3D 55us for all ports */
>>>> +	return ((0x37 << 16) | (0x02 << 29));
>>> I know you've already worked through this, but let me think out loud
>>> to try to figure this out myself.
>>>
>>> ASPM defines Link power states L0, L0s, and L1.  L1 PM Substates
>>> extend that by adding L1.1 and L1.2.  L1.2 presumably uses less power
>>> and has a longer exit delay than L1.1 [sec 5.5].
>>>
>>> Ports that support L1.2 must support Latency Tolerance Reporting (LTR)
>>> [sec 6.18].  When LTR is enabled, a device periodically sends LTR
>>> messages.
>>>
>>> When ASPM puts a Link into L1, it chooses either L1.1 or L1.2 based on
>>> LTR_L1.2_THRESHOLD and recent LTR messages.  If there's no LTR
>>> information it looks like LTR_L1.2_THRESHOLD doesn't matter and it
>>> always chooses L1.2 [sec 5.5.1].
>>>
>>> I don't see anything that writes PCI_EXP_DEVCTL2_LTR_EN, so I don't
>>> think Linux ever enables LTR.  Some BIOSes apparently enable it
>>> (Google for "LTR enabled").
>> I think this needs to be done in aspm.c file. i.e. whenever
>> sub-system enables L1.2, it should enable
>> LTR_EN also.
> That probably makes sense.
>
>>> 1) It seems like the LTR_L1.2_THRESHOLD value should be computed based
>>>     on the latency requirements of downstream devices.  How did you
>>>     come up with 55us?
>> This is given by Tegra hardware folks.
> I do not understand why this value should be dependent on the host
> bridge.  Can your hardware folks give more insight into this and how
> they derived 55us?
>
> I'm repeating myself, but the threshold (in combination with LTR
> information) affects whether we enter L1.1 or L1.2.  If I understand
> correctly, this is all about the downstream devices and not at all
> about the host bridge.
LTR_L1.2_THRESHOLD time is for the device to enter into and exit from=20
L1.2 state.
55us in case of Tegra is calculated based on the circuit design and=20
different latencies
involved in putting link through L1.2 entry-exit cycle.
Spec says in 5.5.4 that , quote "When programming LTR_L1.2_THRESHOLD=20
Value and Scale fields,
identical values must be programmed in both Ports" and my understanding=20
behind spec saying it explicitly
is that the end point should be made aware of what is the latency=20
requirement for=C2=A0 L1.2 from root port,
just like the way end point makes root port aware of its L1.2 latency=20
requirement by sending an LTR message
upstream. By this, both root port and end point come to the same page=20
while taking a decision
to keep the link in L1.2 (or L1.1). Otherwise it may so happen that Tx=20
would be in L1.2 and Rx would be in L1.1.
Also, my understanding is that it is bound to be different on different=20
platforms as it comes from the way hardware
is designed.
>> ...
>>> 3) We must support kernels with multiple host bridge drivers compiled
>>>     in, and the weak/strong symbol approach doesn't support using the
>>>     correct version, e.g., if we merge this patch, every system
>>>     containing the tegra driver would use this function, even if the
>>>     hardware had a different host bridge.  Also, if another driver
>>>     implemented its own version, we'd have duplicate symbols.
>> Yes. Agree with this too.
>> How about using quirks framework for this?
> If my assumption that "the threshold should be based on (a) the
> latency requirements of downstream devices and (b) perhaps some global
> power vs performance tradeoff" is correct, this doesn't really fit
> into any kind of quirks or static computation, including the current
> LTR_L1_2_THRESHOLD_BITS.
>
> What happens if you keep all the Tegra-specific parts of this series,
> i.e., you program the T_cmrt, T_pwr_on, and CLKREQ values, and enable
> advertising of ASPM L1 capability, but leave out the
> pcie_aspm_get_ltr_l_1_2_threshold() parts?  (BTW, I think you should
> reorder the series so you fix up all the delay values *before* you
> advertise ASPM L1.)
>
> I expect that to be functionally equivalent, but it would change the
> L1.1 vs L1.2 tradeoff, so it might have some performance impact,
> depending on what the downstream devices are.
>
> Bjorn
