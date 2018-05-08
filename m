Return-Path: <SRS0=vvZa=H3=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=vvZa=H3=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com, rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Wed, 09 May 2018 00:14:22 +0200
Message-ID: <11148593.jpbL9ipGSX@aspire.rjw.lan>
In-Reply-To: <20180507214817.GC133147@bhelgaas-glaptop.roam.corp.google.com>
References: <20180507061120.3683-1-kai.heng.feng@canonical.com> <20180507214817.GC133147@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, May 7, 2018 11:48:17 PM CEST Bjorn Helgaas wrote:
> On Mon, May 07, 2018 at 02:11:20PM +0800, Kai-Heng Feng wrote:
> > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > core: Drop run_wake flag from struct dev_pm_info").
> > 
> > The device in question is not power managed by platform firmware,
> > furthermore, it only supports PME# from D3cold:
> > Capabilities: [78] Power Management version 3
> >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > 
> > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > After that commit, the device gets runtime suspended to D3hot, which can
> > not generate any PME#.
> > 
> > usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
> > device_can_wakeup() in pci_dev_run_wake() always returns true.
> > 
> > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > condition.
> > 
> > In addition, change wakeup flag passed to pci_target_state() from false
> > to true, because we want to find the deepest state that the device can
> > still generate PME#. In this case, it's D0 for the device in question.
> > 
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rafael, can you queue this up?  de3ef1eb1cd0 went through your tree,
> and I don't really understand the patch, so I'll rely on your review.

I will, thanks!
