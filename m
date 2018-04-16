Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Apr 2018 09:01:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180416140106.GB28657@bhelgaas-glaptop.roam.corp.google.com>
References: <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
 <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
 <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
 <da626c40564276097ab7380ead5f0238@codeaurora.org>
 <a903dd90b53f018945d790b78e9572b9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a903dd90b53f018945d790b78e9572b9@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:21:15AM +0530, poza@codeaurora.org wrote:
> On 2018-04-16 11:03, poza@codeaurora.org wrote:
> > On 2018-04-16 08:47, Bjorn Helgaas wrote:
> > > On Sat, Apr 14, 2018 at 11:53:17AM -0400, Sinan Kaya wrote:
> > > 
> > > > You indicated that you want to unify the AER and DPC behavior. Let's
> > > > settle on what we want to do one more time. We have been going forth
> > > > and back on the direction.
> > > 
> > > My thinking is that as much as possible, similar events should be
> > > handled similarly, whether the mechanism is AER, DPC, EEH, etc.
> > > Ideally, drivers shouldn't have to be aware of which mechanism is in
> > > use.
> > > 
> > > Error recovery includes conventional PCI as well, but right now I
> > > think we're only concerned with PCIe.  The following error types are
> > > from PCIe r4.0, sec 6.2.2:
> > > 
> > >   ERR_COR
> > >     Corrected by hardware with no software intervention.  Software
> > >     involved for logging only.
> > > 
> > >     Handled by AER via pci_error_handlers; DPC is never involved.
> > > 
> > >     Link is unaffected.
> > > 
> > >   ERR_NONFATAL
> > >     A transaction is unreliable but the link is fully functional.
> > > 
> > >     If DPC is not supported, handled by AER via pci_error_handlers and
> > >     the link is unaffected.
> > > 
> > >     If DPC supported, handled by DPC (because we set
> > >     PCI_EXP_DPC_CTL_EN_NONFATAL) via remove/re-enumerate.
> > > 
> > >   ERR_FATAL
> > >     The link is unreliable.
> > > 
> > >     If DPC is not supported, handled by AER via pci_error_handlers and
> > >     the link is reset.
> > > 
> > >     If DPC supported, handled by DPC via remove/re-enumerate.
> > > 
> > > It doesn't seem right to me that we handle both ERR_NONFATAL and
> > > ERR_FATAL events differently if we happen to have DPC support in a
> > > switch.
> > > 
> > > Maybe we should consider triggering DPC only on ERR_FATAL?  That would
> > > keep DPC out of the ERR_NONFATAL cases.
> > > 
> > > For ERR_FATAL, maybe we should bite the bullet and use
> > > remove/re-enumerate for AER as well as for DPC.  That would be painful
> > > for higher-level software, but if we're willing to accept that pain
> > > for new systems that support DPC, maybe life would be better overall
> > > if it worked the same way on systems without DPC?
> > > 
> > > Bjorn
> > 
> > This had crossed my mind when I first looked at the code.
> > DPC is getting triggered for both ERR_NONFATAL and ERR_FATAL case.
> > I thought the primary purpose of DPC to recover fatal errors, by
> > triggering HW recovery.
> > but what if some platform wants to handle both FATAL and NON_FATAL
> > with DPC ?

AER usage is coordinated between the platform and the OS via _OSC (PCI
Firmware spec r3.2, sec 4.5.1) My understanding is that if the
platform grants the OS permission to control AER, the OS is free to
set the AER control registers however it wishes.  If the platform
depends on certain AER control settings, it must decline to grant AER
control to the OS.

As far as I know, there's nothing new in _OSC related to DPC, but
based on the implementation note in PCIe r4.0, sec 6.2.10, we
currently assume the OS controls DPC if and only if it controls AER.

Therefore, if a platform depends on certain DPC control settings,
e.g., if it wants to handle both ERR_FATAL and ERR_NONFATAL with DPC,
I would argue that the platform needs to retain control over AER.

If the platform grants AER control to the OS, I think the OS is free
to set both AER and DPC control registers as it desires.

> > As you said AER FATAL cases and DPC FATAL cases should be handled
> > similarly.  e.g. remove/re-enumerate the devices.
> > 
> > while NON_FATAL case; only AER would come into picture.  if some
> > platform would like to handle DPC NON_FATAL then it should follow
> > AER NON_FATAL path  (where it does not do remove/re-enumerate)
> > 
> > And the case where hotplug is enabled, remove/re-enumerate more
> > sense in case of ERR_FATAL.  And the case where hotplug is
> > disabled, only re-enumeration is required. (no need to remove the
> > devices) but then do we need to handle this case specifically,
> > what is the harm in removing the devices in all the cases followed
> > by re-enumerate ?
> 
> To Clarify the last line, what I meant here was, in case of
> ERR_FATAL we can always remove/re-enumerate the devices irrespective
> of hotplug is enabled or not.

ERR_FATAL means the link is unreliable.  A hotplug event may have
occurred.  In this case, I think remove/re-enumerate is a safe option.
It might be more than is needed in some cases, but I'm not sure we can
reliably determine when we don't need it, and if we
remove/re-enumerate for some ERR_FATAL errors but not others, I think
it complicates the situation for drivers and other higher-level
software.

> and in case of ERR_NONFATAL, DPC will follow AER path (where it just
> tries to recover) although I am not very sure that how to handle
> ERR_NONFATAL case if hotplug is enabled. Because as Keith suggested
> device might have been changed run-time.

ERR_NONFATAL means a particular transaction might be unreliable but
the link itself is fully functional.  No hotplug is possible if the
link has stayed fully functional.

Bjorn
