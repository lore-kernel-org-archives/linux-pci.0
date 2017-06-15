Return-Path: <SRS0=40ic=5U=canonical.com=kai.heng.feng@kernel.org>
Return-Path: <SRS0=40ic=5U=canonical.com=kai.heng.feng@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170613172849.GA7012@bhelgaas-glaptop.roam.corp.google.com>
References: <CAAd53p6S9NPBD=qGP419mhBgSgn-s1dc=adued8Y+Y0=GDsHKg@mail.gmail.com>
 <Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org>
 <CAAd53p580X5_G6a05aAueHVxEoy5hpQrs6s2gtJA+gPEf2PqLg@mail.gmail.com> <20170613172849.GA7012@bhelgaas-glaptop.roam.corp.google.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 15 Jun 2017 14:57:24 +0800
Message-ID: <CAAd53p4-84G=NeJMOGcL_3fd7_s6EC4udLEGTcNNSBF=4FxHyA@mail.gmail.com>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <bhelgaas@google.com>,
	gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 14, 2017 at 1:28 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> The lspci output [1] shows:
>
>   00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 39) (prog-if 20 [EHCI])
>     Capabilities: [c0] Power Management version 2
>       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>       Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>       Bridge: PM- B3+
>
> The device claims it can assert PME# from D3hot.  If it can't, that
> sounds like a hardware defect that should be addressed with a quirk.
> Ideally we would also have a pointer to the AMD hardware erratum.

Looks like it's pretty similar to "23 USB Wake on Connect/Disconnect
with Low Speed Devices" in [1].
It points to a workaround in appendix A2 from [2].
However it says this bug only effects Low Speed devices, but it
actually also happens on High Speed devices.

[1] https://support.amd.com/TechDocs/46837.pdf
[2] https://support.amd.com/TechDocs/42413.pdf

>
> Is the following path involved here?
>
>   pci_finish_runtime_suspend
>     target_state = pci_target_state()
>       if (device_may_wakup())
>         if (dev->pme_support)
>           ...
>     pci_set_power_state(..., target_state)

Yes, it's involved.

>
> If so, I would naively expect that a quirk could clear the
> PCI_PM_CAP_PME_D3 and PCI_PM_CAP_PME_D3cold bits in dev->pme_support,
> and pci_target_state() would then avoid selecting D3 or D3cold.  But
> I'm not an expert in power management.

Clearing those two bits does the trick, thanks for the tip.

>
> Bjorn
>
> [1] http://marc.info/?l=linux-usb&m=149570231732519&w=2
