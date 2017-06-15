Return-Path: <SRS0=YF1/=5U=rowland.harvard.edu=stern+5952b05e@kernel.org>
Return-Path: <SRS0=YF1/=5U=rowland.harvard.edu=stern+5952b05e@kernel.org>
Date: Thu, 15 Jun 2017 10:12:15 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
     <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>,
     <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
     <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
In-Reply-To: <CAAd53p4-84G=NeJMOGcL_3fd7_s6EC4udLEGTcNNSBF=4FxHyA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1706151008380.1573-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 15 Jun 2017, Kai-Heng Feng wrote:

> On Wed, Jun 14, 2017 at 1:28 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > The lspci output [1] shows:
> >
> >   00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 39) (prog-if 20 [EHCI])
> >     Capabilities: [c0] Power Management version 2
> >       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> >       Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
> >       Bridge: PM- B3+
> >
> > The device claims it can assert PME# from D3hot.  If it can't, that
> > sounds like a hardware defect that should be addressed with a quirk.
> > Ideally we would also have a pointer to the AMD hardware erratum.
> 
> Looks like it's pretty similar to "23 USB Wake on Connect/Disconnect
> with Low Speed Devices" in [1].
> It points to a workaround in appendix A2 from [2].
> However it says this bug only effects Low Speed devices, but it
> actually also happens on High Speed devices.
> 
> [1] https://support.amd.com/TechDocs/46837.pdf
> [2] https://support.amd.com/TechDocs/42413.pdf

Those documents refer to a hardware bug with a workaround in the BIOS.  
Have you checked to see if your BIOS is up to date?

Alan Stern
