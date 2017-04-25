Return-Path: <SRS0=YqD6=4B=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=YqD6=4B=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org> <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org> <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org> <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
 <c0c2f48f-d725-058e-a1ad-92ab4b6e7fb3@codeaurora.org> <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Apr 2017 13:45:13 -0500
Message-ID: <CAErSpo7TO1rfG6MDYuohyXL4WbaGCJdV8y3Ke-uL6VjGRb1hvw@mail.gmail.com>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
	David Daney <david.daney@cavium.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-arm <linux-arm-kernel@lists.infradead.org>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 21, 2017 at 2:46 AM, Patel, Mayurkumar
<mayurkumar.patel@intel.com> wrote:
> Hi Bjorn/Kaya,
>
>
>>
>>On 4/17/2017 12:38 PM, Bjorn Helgaas wrote:
>>>> Like you said, what do we do by default is the question. Should we opt
>>>> for safe like we are doing, or try to save some power.
>>> I think safety is paramount.  Every user should be able to boot safely
>>> without any kernel parameters.  We don't want users to have a problem
>>> booting and then have to search for a workaround like booting with
>>> "pcie_aspm=off".  Most users will never do that.
>>>
>>
>>OK, no problem with leaving the behavior as it is.
>>
>>My initial approach was #2. We knew this way that user had full control
>>over the ASPM policy by changing the BIOS option. Then, Mayurkumar
>>complained that ASPM is not enabled following a hotplug insertion to an
>>empty slot. That's when I switched to #3 as it sounded like a good thing
>>to have for us.
>>
>>> Here's a long-term strawman proposal, see what you think:
>>>
>>>   - Deprecate CONFIG_PCIEASPM_DEFAULT, CONFIG_PCIEASPM_POWERSAVE, etc.
>>>   - Default aspm_policy is POLICY_DEFAULT always.
>>>   - POLICY_DEFAULT means Linux doesn't touch anything: if BIOS enabled
>>> ASPM, we leave it that way; we leave ASPM disabled on hot-added
>>> devices.
>>
> I am also ok with leaving the same behavior as now.
> But still following is something open I feel besides, Which may be there in your comments redundantly.
> The current problem is, pcie_aspm_exit_link_state() disables the ASPM configuration even
> if POLICY_DEFAULT was set.

We call pcie_aspm_exit_link_state() when removing an endpoint.  When
we remove an endpoint, I think disabling ASPM is the right thing to
do.  The spec (PCIe r3.1, sec 5.4.1.3) says "Software must not enable
L0s in either direction on a given Link unless components on both
sides of the Link each support L0s; otherwise, the result is
undefined."

> I am seeing already following problem(or may be influence) with it. The Endpoint I have does not have
> does not have "Presence detect change" mechanism. Hot plug is working with Link status events.
> When link is in L1 or L1SS and if EP is powered off, no Link status change event are triggered (It might be
> the expected behavior in L1 or L1SS).  When next time EP is powered on there are link down and
> link up events coming one after other. BIOS enables ASPM on Root port and Endpoint, but while
> processing link status down, pcie_aspm_exit_link_state() clears the ASPM already which were enabled by BIOS.
> If we want to follow above approach then shall we consider having something similar as following?

The proposal was to leave ASPM disabled on hot-added devices.  If the
endpoint was powered off and powered back on again, I think that
device looks like a hot-added device, doesn't it?

Bjorn
