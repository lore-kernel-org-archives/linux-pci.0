Return-Path: <SRS0=t7Ec=3Z=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=t7Ec=3Z=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
 <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
 <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>,
 "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Timur Tabi <timur@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Yinghai Lu <yinghai@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Myron Stowe <myron.stowe@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c0c2f48f-d725-058e-a1ad-92ab4b6e7fb3@codeaurora.org>
Date: Mon, 17 Apr 2017 13:50:01 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/17/2017 12:38 PM, Bjorn Helgaas wrote:
>> Like you said, what do we do by default is the question. Should we opt
>> for safe like we are doing, or try to save some power.
> I think safety is paramount.  Every user should be able to boot safely
> without any kernel parameters.  We don't want users to have a problem
> booting and then have to search for a workaround like booting with
> "pcie_aspm=off".  Most users will never do that.
> 

OK, no problem with leaving the behavior as it is.

My initial approach was #2. We knew this way that user had full control
over the ASPM policy by changing the BIOS option. Then, Mayurkumar
complained that ASPM is not enabled following a hotplug insertion to an
empty slot. That's when I switched to #3 as it sounded like a good thing
to have for us.

> Here's a long-term strawman proposal, see what you think:
> 
>   - Deprecate CONFIG_PCIEASPM_DEFAULT, CONFIG_PCIEASPM_POWERSAVE, etc.
>   - Default aspm_policy is POLICY_DEFAULT always.
>   - POLICY_DEFAULT means Linux doesn't touch anything: if BIOS enabled
> ASPM, we leave it that way; we leave ASPM disabled on hot-added
> devices.

I can easily see people complaining the other way around. There
could be some boot FW that doesn't know what ASPM is and this particular
system could rely on the compile time option for enabling power options.
Maybe, a command line option will be required for them to keep the existing
behavior.

>   - Deprecate kernel boot parameters (possibly keep pcie_aspm=off for
> debugging use).
>   - Use /sys/module/pcie_aspm/parameters/policy for run-time
> system-wide  control, including for future hot-added devices.
>   - Remove CONFIG_PCIEASPM_DEBUG and enable that code always, so we
> have fine-grained run-time control.
> 

Runtime control sounds like a better plan. We need hooks into the system
power management policy.

>> Maybe, we are missing a HPP option from the PCI spec.
> That's an interesting idea.  _HPX does have provision for manipulating
> Link Control bits (see ACPI r5.0, sec 6.2.8.3), but I don't think very
> many systems implement it.  And there's currently no connection
> between program_hpp_type2() and aspm.c, so I'm a little worried that
> we might have issues if a system did implement an _HPX that sets any
> of the ASPM bits.

I looked at the spec some more. These are there to restore the register
settings following hotplug insertion. I agree it won't play nice with ASPM
as the control bits need to be enabled in coordination with the upstream
device.

I think the right approach is to let the userspace feed the required
policy to the kernel like you suggested. Then, it needs to be per port
via link_state to have the most flexibility. 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
