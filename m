Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 3 May 2017 16:10:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
Message-ID: <20170503211050.GA9506@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
 <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
 <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
 <c0c2f48f-d725-058e-a1ad-92ab4b6e7fb3@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846676C7EF@IRSMSX101.ger.corp.intel.com>
 <CAErSpo7TO1rfG6MDYuohyXL4WbaGCJdV8y3Ke-uL6VjGRb1hvw@mail.gmail.com>
 <92EBB4272BF81E4089A7126EC1E7B284667759B1@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B284667759B1@IRSMSX101.ger.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rajat Jain <rajatxjain@gmail.com>, Myron Stowe <myron.stowe@redhat.com>,
 David Daney <david.daney@cavium.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Timur Tabi <timur@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 Yinghai Lu <yinghai@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 02, 2017 at 12:02:53PM +0000, Patel, Mayurkumar wrote:
> >On Fri, Apr 21, 2017 at 2:46 AM, Patel, Mayurkumar
> ><mayurkumar.patel@intel.com> wrote:
> >>>On 4/17/2017 12:38 PM, Bjorn Helgaas wrote:
> >>>>> Like you said, what do we do by default is the question. Should we opt
> >>>>> for safe like we are doing, or try to save some power.
> >>>> I think safety is paramount.  Every user should be able to boot safely
> >>>> without any kernel parameters.  We don't want users to have a problem
> >>>> booting and then have to search for a workaround like booting with
> >>>> "pcie_aspm=off".  Most users will never do that.
> >>>
> >>>OK, no problem with leaving the behavior as it is.
> >>>
> >>>My initial approach was #2. We knew this way that user had full control
> >>>over the ASPM policy by changing the BIOS option. Then, Mayurkumar
> >>>complained that ASPM is not enabled following a hotplug insertion to an
> >>>empty slot. That's when I switched to #3 as it sounded like a good thing
> >>>to have for us.
> >>>
> >>>> Here's a long-term strawman proposal, see what you think:
> >>>>
> >>>>   - Deprecate CONFIG_PCIEASPM_DEFAULT, CONFIG_PCIEASPM_POWERSAVE, etc.
> >>>>   - Default aspm_policy is POLICY_DEFAULT always.
> >>>>   - POLICY_DEFAULT means Linux doesn't touch anything: if BIOS enabled
> >>>> ASPM, we leave it that way; we leave ASPM disabled on hot-added
> >>>> devices.
> >>>
> >> I am also ok with leaving the same behavior as now.  But still
> >> following is something open I feel besides, Which may be there in
> >> your comments redundantly.  The current problem is,
> >> pcie_aspm_exit_link_state() disables the ASPM configuration even
> >> if POLICY_DEFAULT was set.
> >
> >We call pcie_aspm_exit_link_state() when removing an endpoint.  When
> >we remove an endpoint, I think disabling ASPM is the right thing to
> >do.  The spec (PCIe r3.1, sec 5.4.1.3) says "Software must not enable
> >L0s in either direction on a given Link unless components on both
> >sides of the Link each support L0s; otherwise, the result is
> >undefined."
> 
> Yes, you are right and per spec also it makes sense that ASPM needs
> to be disabled.  But, if POLICY_DEFAULT is set then, shouldn't BIOS
> take care of disabling ASPM?

No, I don't think so.  POLICY_DEFAULT is a Linux thing and BIOS
doesn't know anything about it.

ASPM can be configured by BIOS before handoff to Linux, but after
handoff it should be managed either entirely by BIOS or entirely by
Linux.  If BIOS wants to retain ASPM control, it would have to tell
the OS *not* to use ASPM, and it would have to use ACPI hotplug.  In
this case, POLICY_DEFAULT is irrelevant because Linux shouldn't do
anything with ASPM.

But normally BIOS allows Linux to control ASPM, and we would use
native PCIe hotplug (pciehp) instead of ACPI hotplug, and BIOS has no
opportunity to enable or disable ASPM on hotplug events.

> >> I am seeing already following problem(or may be influence) with
> >> it. The Endpoint I have does not have does not have "Presence
> >> detect change" mechanism. Hot plug is working with Link status
> >> events.  When link is in L1 or L1SS and if EP is powered off, no
> >> Link status change event are triggered (It might be the expected
> >> behavior in L1 or L1SS).  When next time EP is powered on there
> >> are link down and link up events coming one after other. BIOS
> >> enables ASPM on Root port and Endpoint, but while processing link
> >> status down, pcie_aspm_exit_link_state() clears the ASPM already
> >> which were enabled by BIOS.  If we want to follow above approach
> >> then shall we consider having something similar as following?
> >
> >The proposal was to leave ASPM disabled on hot-added devices.  If
> >the endpoint was powered off and powered back on again, I think
> >that device looks like a hot-added device, doesn't it?
> 
> Yes, it is hot-added device. Also, I understand, for POLICY_DEFAULT,
> OS would/should not touch ASPM(enable/disable), but BIOS could still
> (enable/disable), right?

Maybe I'm misunderstanding your question.  There are two questions
here:

  1) Does the BIOS allow Linux to manage ASPM?

  2) If Linux does manage ASPM, what policy does it use?

If BIOS doesn't allow Linux to manage ASPM, POLICY_DEFAULT is
irrelevant.  If BIOS does allow Linux to manage ASPM, POLICY_DEFAULT
means Linux should use the settings made by BIOS.  The user could
select a different policy, and then Linux would change the ASPM
configuration accordingly.

> Currently, what happens in my system is as following, (each 2nd
> power cycle/hotplug of Endpoint disables ASPM):
> 
> 
> First Power cycle (When ASPM L1 is already enabled): device gets
> powered off -> there are no Link status events, so no pcie hotplug
> interrupt and pcie_aspm_exit_link_state() triggered.  

If the Downstream Port leading to your Endpoint is hotplug capable,
doesn't the spec require that it can report link state changes (PCIe
r3.1, sec 7.8.6, 7.8.10, 7.8.11)?

> When the device gets powered on again -> Link down/Link up events
> are coming back to back.  First Link down is served. (BIOS checks
> for the Link status and enables ASPM already, as the device is
> actually powered back). OS calls pcie_aspm_exit_link_state() and
> ASPM gets disabled by OS.
> 
> Second Power cycle (When ASPM L1 is disabled after above): device
> gets powered off -> there are link status events, pcie hotplug
> interrupt is triggered and pcie_aspm_exit_link_state() triggered.
> OS disables ASPM. BIOS checks Link status and disables ASPM too.
> When the device gets powered on -> BIOS enables ASPM and as this is
> pcie hotplug insertion, OS does not interfere and we have ASPM
> enabled.

I don't understand this sequence.  If we're using native PCIe hotplug,
BIOS should not be involved to enable ASPM when the device is powered
on.

> The above sequence happens each 2nd power cycle of the hotplug
> device.
> 
> So One could still argue if POLICY_DEFAULT is set, then why OS
> disables ASPM if it is not meant to touch configuration.  This is
> why I proposed following kind of change, so that OS would not touch
> ASPM, if POLICY_DEFAULT is set.  Also, With the below change,
> everything relies on BIOS for ASPM when POLICY_DEFAULT is set and I
> see above problem gets resolved. Also, the existing ASPM behavior
> does not have impact, unless specific BIOS does not disable ASPM on
> Root Port when device gets removed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
