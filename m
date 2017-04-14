Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 14 Apr 2017 16:44:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
Message-ID: <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org>
 <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, Myron Stowe <myron.stowe@redhat.com>,
 David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 Yinghai Lu <yinghai@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Myron, lkml]

On Fri, Apr 14, 2017 at 03:12:35PM -0400, Sinan Kaya wrote:
> Bjorn,
> =

> On 4/12/2017 3:19 PM, Rajat Jain wrote:
> > On Fri, Apr 7, 2017 at 9:55 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> >> Now that we added a hook to be called from device_add, save the
> >> default values from the HW registers early in the boot for further
> >> reuse during hot device add/remove operations.
> >>
> >> If the link is down during boot, assume that we want to enable L0s
> >> and L1 following hotplug insertion as well as L1SS if supported.
> > =

> > IIUC, so far POLICY_DEFAULT meant that we'd just use & follow what
> > BIOS has done, and play it safe (never try to be more opportunistic).
> > With this change however, we'd be slightly overstepping and giving
> > ourselves benefit of doubt if the BIOS could not enable ASPM states
> > because the link was not up. This may be good, but I think we should
> > call it out, and add some more elaborate comment on the POLICY_DEFAULT
> > description (what to, and what not to expect in different situations).
> > =

> > It is important because existing systems today, that used to boot
> > without cards and later hotplugged them, didn't have ASPM states
> > enabled. They will now suddenly start seeing all ASPM states enabled
> > including L1 substates for the first time (if supported).
> > =

> =

> Rajat has a good point here. Would you like me to update the ASPM document
> with this new behavior for hotplug?
> =

> Do you have another behavior preference when it comes this?

That *is* a very good point. =A0I think the change in behavior could be
surprising.

I wonder if we should revise our understanding of what POLICY_DEFAULT
means. =A0If we decided it means "the kernel never changes any ASPM
config", it would be clear that we keep the BIOS configuration for
everything present at boot, and we don't enable ASPM for any hot-added
devices.

I think the motivation for this series is to apply the BIOS's power
management policy to hot-added devices. =A0There's no direct way to know
the BIOS's policy, so we're trying to infer it from the boot-time link
configurations.

Should we even *try* to apply the BIOS's policy? =A0I don't know. =A0If a
platform really wanted to maintain control over ASPM and apply its policy
consistently, I think it could do that by setting ACPI_FADT_NO_ASPM and
using acpiphp instead of pciehp.  =A0Then the OS would keep its mitts off
ASPM, and the BIOS would have a chance to configure ASPM for hot-added
devices before giving them to the OS.

Here are the possibilities I see for POLICY_DEFAULT:

1) Never touch ASPM config (what we have today)

   Boot-present devices: ASPM config retained from BIOS
   Hot-added devices: ASPM disabled (poweron state)

2) Linux maintains BIOS policy (conservative)

   Boot-present devices: ASPM config retained from BIOS
   Hot-added devices (slot occupied at boot): use boot-time ASPM config
   Hot-added devices (slot empty at boot): ASPM disabled

3) Linux maintains BIOS policy (aggressive, your current patch)

   Boot-present devices: ASPM config retained from BIOS
   Hot-added devices (slot occupied at boot): use boot-time ASPM config
   Hot-added devices (slot empty at boot): ASPM enabled

I'm becoming less convinced that options 2 or 3 make sense.  For one
thing, they're both hard to describe concisely because there are too
many special cases, and that's always a red flag for me.

Even for a given BIOS power management policy, the ASPM configuration
may depend on the particular device; for example, a balanced policy
might enable ASPM for USB devices but not for NICs.  So I'm not sure
it really makes sense to remember what BIOS did for the card that was
in the slot at boot-time and apply that to a possibly different card
hot-added later.

I think there's an argument to be made that if we care about ASPM
configuration, we should be using a non-POLICY_DEFAULT setting.  And I
think there's value in having POLICY_DEFAULT be the absolute lowest-
risk setting, which I think means option 1.

What do you think?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
