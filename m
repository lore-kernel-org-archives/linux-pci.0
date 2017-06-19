Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Jun 2017 12:45:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI
 controller
Message-ID: <20170619174533.GA20550@bhelgaas-glaptop.roam.corp.google.com>
References: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
 <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
 <CAAd53p6iH=T+ynpsdmQVeexOXRdwdiznLiRGM40Q88__r1s7QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAd53p6iH=T+ynpsdmQVeexOXRdwdiznLiRGM40Q88__r1s7QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 11:30:18AM +0800, Kai-Heng Feng wrote:
> On Sat, Jun 17, 2017 at 1:30 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sat, 17 Jun 2017, Kai-Heng Feng wrote:
> >
> >> On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
> >> <kai.heng.feng@canonical.com> wrote:
> >> > On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> >> Those documents refer to a hardware bug with a workaround in the BIOS.
> >> >> Have you checked to see if your BIOS is up to date?
> >> >
> >> > Yes, it's up to date.
> >> >
> >>
> >> Alan, I re-sent a patch but I forgot to add you to CC list:
> >> http://marc.info/?l=linux-pci&m=149760607914628&w=2
> >
> > Thanks for letting me know.  The patch seems reasonable.
> >
> > Have you tested it with system suspend?  That is, if you suspend the
> > whole computer, does plugging or unplugging a USB device cause the
> > system to wake up?
> 
> No, the system will not wake up when plugging or unplugging.
> Tried several times, nether runtime PM enabled nor runtime PM disabled
> will wake up the system under S3, when (un)plugging USB devices.

Alan, I don't know what this test means for the patch
(http://marc.info/?l=linux-pci&m=149760607914628&w=2).

pci_target_state() is documented as "return the deepest state from
which the device can generate wake events."  For this device, I guess
that means D2, and the patch should accomplish that.

I don't know what's supposed to happen to this device when the system
is in S3.  I assume that if the system is in S3, most devices are in
D3.  If this device is in D3, we won't get PMEs, which I guess is what
Kai-Heng is seeing.  Is that the desired behavior?  Or do we want the
PMEs enough that we should leave the device in D2 (if that's even
possible)?

Bjorn
