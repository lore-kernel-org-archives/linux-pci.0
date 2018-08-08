Return-Path: <SRS0=8IOG=KX=gmail.com=marek.vasut@kernel.org>
Return-Path: <SRS0=8IOG=KX=gmail.com=marek.vasut@kernel.org>
Subject: Re: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1
 handling
To: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>,
 linux-renesas-soc@vger.kernel.org
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-5-marek.vasut+renesas@gmail.com>
 <20171117174906.GB22599@red-moon>
 <3e0bc374-d296-675c-f290-256cc530feb7@gmail.com>
 <20180611135912.GD75679@bhelgaas-glaptop.roam.corp.google.com>
 <77d1eaf8-e180-f5f5-50f0-34c45e72c553@gmail.com>
 <20180613135308.GB201807@bhelgaas-glaptop.roam.corp.google.com>
 <20180613155252.GA12210@e107981-ln.cambridge.arm.com>
 <20180613172559.GC201807@bhelgaas-glaptop.roam.corp.google.com>
 <1d543b91-ac4f-7b61-4b2c-d8865e06d31e@gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <9b91bbd9-64df-764e-e553-a37463549a92@gmail.com>
Date: Wed, 8 Aug 2018 15:29:59 +0200
MIME-Version: 1.0
In-Reply-To: <1d543b91-ac4f-7b61-4b2c-d8865e06d31e@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 07/25/2018 11:08 PM, Marek Vasut wrote:
> On 06/13/2018 07:25 PM, Bjorn Helgaas wrote:
>> On Wed, Jun 13, 2018 at 04:52:52PM +0100, Lorenzo Pieralisi wrote:
>>> On Wed, Jun 13, 2018 at 08:53:08AM -0500, Bjorn Helgaas wrote:
>>>> On Wed, Jun 13, 2018 at 01:54:51AM +0200, Marek Vasut wrote:
>>>>> On 06/11/2018 03:59 PM, Bjorn Helgaas wrote:
>>>>>> On Sun, Jun 10, 2018 at 03:57:10PM +0200, Marek Vasut wrote:
>>>>>>> On 11/17/2017 06:49 PM, Lorenzo Pieralisi wrote:
>>>>>>>> On Fri, Nov 10, 2017 at 10:58:42PM +0100, Marek Vasut wrote:
>>>>>>>>> From: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>>>>
>>>>>>>>> Most PCIe host controllers support L0s and L1 power states via ASPM.
>>>>>>>>> The R-Car hardware only supports L0s, so when the system suspends and
>>>>>>>>> resumes we have to manually handle L1.
>>>>>>>>> When the system suspends, cards can put themselves into L1 and send a
>>>>>>>>
>>>>>>>> I assumed L1 entry has to be negotiated depending upon the PCIe
>>>>>>>> hierarchy capabilities, I would appreciate if you can explain to
>>>>>>>> me what's the root cause of the issue please.
>>>>>>>
>>>>>>> You should probably ignore the suspend/resume part altogether. The issue
>>>>>>> here is that the cards can enter L1 state, while the controller won't do
>>>>>>> that automatically, it can only detect that the link went into L1 state.
>>>>>>> If that happens,the driver must manually put the controller to L1 state.
>>>>>>> The controller can transition out of L1 state automatically though.
>>>>>>
>>>>>> From earlier discussion I thought the R-Car root port did not
>>>>>> advertise L1 support.
>>>>>
>>>>> Which discussion ? This one or somewhere else ?
>>>>
>>>> https://lkml.kernel.org/r/HK2PR0601MB1393D917D343E6363484CA68F5CB0@HK2PR0601MB1393.apcprd06.prod.outlook.com
>>>>
>>>> Re-reading that, I think I see my misunderstanding.  I was only
>>>> considering L1 in the ASPM context.  I didn't realize the L1
>>>> implications of devices being in states other than D0.
>>>>
>>>> Obviously L1 support for ASPM is optional and advertised via Link
>>>> Capabilities.  But per PCIe r4.0, sec 5.2, L1 support is required for
>>>> PCI-PM compatible power management, and is entered "whenever all
>>>> Functions ... are programmed to a D-state other than D0."
>>>>
>>>> So I guess this means *every* device is supposed to support L1 when it
>>>> is in a non-D0 power state.  I think *this* is the case you're
>>>> solving.
>>>>
>>>> A little more of this detail, e.g., that this issue has nothing to do
>>>> with ASPM, it's probably an R-Car erratum that the RC can't transition
>>>> from L1 to L0, etc., in the changelog would really help clear things
>>>> up for me.
>>>
>>> I think that the issue is related to the L0->L1 transition upon system
>>> suspend (ie the kernel must force the controller into L1 when all
>>> devices are in a sleep state) and for this specific reason I still think
>>> that checking for a PM_Enter_L1 DLLP reception and doing the L0->L1
>>> transition within a config access is wrong and prone to error (what's
>>> the rationale behind that ?), this ought to be done using PM methods in
>>> the host controller driver.
>>
>> But doesn't the problem happen whenever the link goes to L1, for any
>> reason?  E.g., runtime power management might put an endpoint in D3
>> even if we're not doing a whole system suspend.  A user could even
>> force the endpoint to D3 by writing to PCI_PM_CTRL with "setpci".  If
>> that's the case, I don't think the host controller PM methods will be
>> enough to work around the issue.
> 
> I think so, it's the link that goes into L1 state and this can happen
> without any action from the controller side.
> 
>> The comment in the patch ("If we are not in L1 link state and we have
>> received PM_ENTER_L1 DLLP, transition to L1 link state") suggests that
>> the R-Car host doesn't handle step 10 in PCIe r4.0, sec 5.3.2.1
>> correctly, i.e., it doesn't complete the transition of the link to L1.
>>
>> Putting this workaround in the config accessor makes sense to me
>> because in this situation the endpoint thinks it's in L1 and it won't
>> receive TLPs for config accesses.  Apparently forcing the RP to L1
>> completes the L1 entry, and the RP correctly handles the "Exit from L1
>> State" (sec 5.3.2.2) that's required when the RP needs to send a TLP
>> to the endpoint.
>>
>> I think there's still a potential issue if the endpoint goes to a
>> non-D0 state, the link is stuck in this transitional state (endpoint
>> thinks it's L1, RP thinks it's L0), and the *endpoint* wants to exit
>> L1, e.g., so it can send a PME message for a wakeup.  I don't know
>> what happens then.
> 
> Is there some hardware which I can use to simulate this situation ?
> 
>> If there were a real erratum writeup for this, it would probably
>> discuss this situation.
> 
> I went through the latest errata sheet and don't see anything. The
> datasheet only mentions that L0/L0s/L1 is supported and L2 is not supported.
> 
> Maybe Phil can comment on this too ?

Bump ?

> [...]
> 


-- 
Best regards,
Marek Vasut
