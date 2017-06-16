Return-Path: <SRS0=Od1n=5V=rowland.harvard.edu=stern+5952b05e@kernel.org>
Return-Path: <SRS0=Od1n=5V=rowland.harvard.edu=stern+5952b05e@kernel.org>
Date: Fri, 16 Jun 2017 13:30:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
     <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
     <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
In-Reply-To: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Sat, 17 Jun 2017, Kai-Heng Feng wrote:

> On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Those documents refer to a hardware bug with a workaround in the BIOS.
> >> Have you checked to see if your BIOS is up to date?
> >
> > Yes, it's up to date.
> >
> 
> Alan, I re-sent a patch but I forgot to add you to CC list:
> http://marc.info/?l=linux-pci&m=149760607914628&w=2

Thanks for letting me know.  The patch seems reasonable.

Have you tested it with system suspend?  That is, if you suspend the 
whole computer, does plugging or unplugging a USB device cause the 
system to wake up?

Alan Stern
