Return-Path: <SRS0=xVOf=HX=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=xVOf=HX=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 04 May 2018 11:55:40 +0200
Message-ID: <2469353.zD9Qx4KGm6@aspire.rjw.lan>
In-Reply-To: <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <1772514.uJjIhrptf1@aspire.rjw.lan> <2A1C2E74-BC05-48B5-A4D4-DEDBFD797D53@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 4, 2018 9:36:01 AM CEST Kai Heng Feng wrote:
> Hi Rafael,
> 
> > On Apr 26, 2018, at 10:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, April 26, 2018 3:55:45 PM CEST Bjorn Helgaas wrote:
> >> On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
> >>> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> >>>> Hi Bjorn and Rafael,
> >>>>
> >>>>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng  
> >>>>> <kai.heng.feng@canonical.com>
> >>>>> wrote:
> >>>>>
> >>>>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> >>>>> core: Drop run_wake flag from struct dev_pm_info").
> >>>>>
> >>>>> The device in question is not power managed by platform firmware,
> >>>>> furthermore, it only supports PME# from D3cold:
> >>>>> Capabilities: [78] Power Management version 3
> >>>>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >>>>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >>>>>
> >>>>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> >>>>> After that commit, the device gets runtime suspended, so it does not
> >>>>> respond to any PME#.
> >>
> >> Apologies for my lack of PM expertise.  I don't think the device would
> >> *respond* to PME#, would it?  I would think the device would
> >> potentially *generate* a PME#.
> >
> 
> Do you want me to send another version with updated commit message?

Yes, please.

> I can also split it to two commits if you desire.

No, that's not necessary.

Thanks,
Rafael
