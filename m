Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 12 Jan 2017 09:03:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: CONFIG_PCIEASPM breaks PCIe on Marvell Armada 385 machine
Message-ID: <20170112150310.GA5746@bhelgaas-glaptop.roam.corp.google.com>
References: <20170111194942.q5rdma2es6hkmxfe@perseus.defre.kleine-koenig.org>
 <20170111220235.GP14532@bhelgaas-glaptop.roam.corp.google.com>
 <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
MIME-Version: 1.0
In-Reply-To: <9f48e2a8-e1e0-e3db-af48-12297f8521f2@kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-pci@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:18:46PM +0100, Uwe Kleine-K=F6nig wrote:
> On 01/11/2017 11:02 PM, Bjorn Helgaas wrote:
> > Hi Uwe,
> > =

> > On Wed, Jan 11, 2017 at 08:49:46PM +0100, Uwe Kleine-K=F6nig wrote:
> >> Hello,
> >>
> >> on an Marvell Armada 385 based machine (Turris Omnia) with 4.9 the
> >> ath10k driver fails to bind to the matching hardware if CONFIG_PCIEASPM
> >> is enabled:
> >>
> >> [...]
> > We have several open issues related to ASPM:
> > =

> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D102311 ASPM: ASMEDA asm=
1062 not working
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D187731 Null pointer der=
eference in ASPM
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D189951 Enabling ASPM ca=
uses NIC performance issue
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D60111 NULL pointer dere=
f in ASPM alloc_pcie_link_state()
> > =

> > I don't recognize yours as being one of these.  Can you open a new
> > issue and attach the complete dmesg log and "lspci -vv" output?
> =

> Done: https://bugzilla.kernel.org/show_bug.cgi?id=3D192441

Thanks!  Can you attach a dmesg with CONFIG_PCIEASPM turned off, too?

There are several interesting things going on with that ath10k device,
and not all of them seem ASPM-related:

  pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
  pci 0000:02:00.0: reg 0x10: [mem 0xe8000000-0xe81fffff 64bit]
  pci 0000:02:00.0: reg 0x30: [mem 0xe8200000-0xe820ffff pref]
  pci 0000:02:00.0: of_irq_parse_pci() failed with rc=3D134
  pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff 64bit]
  pci 0000:02:00.0: BAR 0: error updating (0xe0000004 !=3D 0xffffffff)
  pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D 0xffffffff)

1) We found BAR 0 (reg 0x10) with 0xe8000000, so firmware probably
   programmed it, and it probably works there.

2) The host bridge window doesn't include that BAR 0 space.
   Unfortunately I don't think we print the initial 00:02.0 bridge
   window leading to bus 02; we only print the new window we assign to
   it.

3) No idea what the of_irq_parse_pci() issue is.

4) No idea why the BAR 0 update failed.  Maybe a Marvell config
   accessor problem?

I don't see any connection between these and ASPM, so I'm curious why
things work with CONFIG_PCIEASPM turned off.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
