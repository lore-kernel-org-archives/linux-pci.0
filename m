Return-Path: <SRS0=uqDf=HX=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=uqDf=HX=canonical.com=kai.heng.feng@kernel.org>
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1772514.uJjIhrptf1@aspire.rjw.lan>
Date: Fri, 4 May 2018 15:36:01 +0800
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 bhelgaas@google.com,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Message-Id: <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
 <10732937.eAR6mAEfiz@aspire.rjw.lan>
 <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
 <1772514.uJjIhrptf1@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

> On Apr 26, 2018, at 10:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, April 26, 2018 3:55:45 PM CEST Bjorn Helgaas wrote:
>> On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
>>> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
>>>> Hi Bjorn and Rafael,
>>>>
>>>>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng  
>>>>> <kai.heng.feng@canonical.com>
>>>>> wrote:
>>>>>
>>>>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
>>>>> core: Drop run_wake flag from struct dev_pm_info").
>>>>>
>>>>> The device in question is not power managed by platform firmware,
>>>>> furthermore, it only supports PME# from D3cold:
>>>>> Capabilities: [78] Power Management version 3
>>>>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>>>>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>>>
>>>>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
>>>>> After that commit, the device gets runtime suspended, so it does not
>>>>> respond to any PME#.
>>
>> Apologies for my lack of PM expertise.  I don't think the device would
>> *respond* to PME#, would it?  I would think the device would
>> potentially *generate* a PME#.
>

Do you want me to send another version with updated commit message?

I can also split it to two commits if you desire.

Kai-Heng

> Right.
>
>> And I guess since this device can generate PME# only from D3cold, the
>> implication is that runtime suspending the device may put it into D1,
>> D2, or D3hot, but not D3cold?  Is that an axiom of the runtime suspend
>> design?
>
> No, it isn't.
>
> Runtime PM is expected to only put devices into D-states from where they
> can generate PME.
>
> Before the problematic change it would just hold the device in question  
> in D0,
> but after that change the device will be suspended (in which case it will  
> end
> up in D3hot which is incorrect).
>
>>>>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
>>>>> device_can_wakeup() in pci_dev_run_wake() always returns true.
>>
>> I think "mandatorily" means "always" or "unconditionally", right?
>>
>>>>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
>>>>> condition.
>>>>>
>>>>> In addition, change wakeup flag passed to pci_target_state() from false
>>>>> to true, because we want to find the deepest state that the device can
>>>>> still generate PME#.
>>
>> Is this a separate bug fix?  I don't understand how it fits in here
>> because the wakeup flag means "Whether or not wakeup functionality
>> will be enabled for the device", and you're not changing anything
>> about whether wakeup functionality will be enabled.
>
> For runtime PM the "wakeup" argument of pci_target_state() should always be
> "true", so technically this may be regarded as a separate issue, but this
> change is needed as a functional fix for the device in question along with
> the reordering.
>
> Since technically there is a state from which the device can signal PME,
> device_can_wakeup() returns "true" for it, but this isn't sufficient for
> pci_dev_run_wake() to return "true" (because that state is D3cold and
> the platform cannot power-manage the device, so the device cannot be put
> into D3cold directly).  That's the first thing that needs to be changed.
>
> On top of that, we need to look for a state from which the device can
> generate PME.
>
>>>>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
>>>>> dev_pm_info")
>>>>> Cc: stable@vger.kernel.org # 4.13+
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>> v3: State the reason why the wakeup flag gets changed.
>>>>>
>>>>> v2: Explicitly check dev->pme_support.
>>>>
>>>> If this patch is good enough, I am hoping it can get merged in v4.17.
>>>
>>> OK
>>>
>>> Bjorn, if you want to take this:
>>>
>>>  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Otherwise please let me know and I'll queue it up.
>>
>> de3ef1eb1cd0 went through your tree, so I think this fix should go
>> through your tree, too.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> OK
>
>> Not directly related to this patch, but I think these comments in
>> pci_target_state() are slightly misleading:
>>
>>    * Call the platform to choose the target state of the device
>>    * and enable wake-up from this state if supported.
>>
>>    * Find the deepest state from which the device can generate
>>    * wake-up events, make it the target state and enable device
>>    * to generate PME#.
>>
>> AFAICT, pci_target_state() does not actually "enable wake-up from this
>> state" or "enable device to generate PME#".
>
> Right, the comments appear to be stale, I'll send a patch to update them.
>
> Thanks,
> Rafael
