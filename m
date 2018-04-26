Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:58737 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeDZG6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 02:58:44 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Thu, 26 Apr 2018 08:58:32 +0200
Message-ID: <190600314.NA7iiQVSFY@aspire.rjw.lan>
In-Reply-To: <C07517A2-0AE5-4EE2-AB64-7F0767C988DF@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <10732937.eAR6mAEfiz@aspire.rjw.lan> <C07517A2-0AE5-4EE2-AB64-7F0767C988DF@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, April 26, 2018 8:54:14 AM CEST Kai Heng Feng wrote:
> 
> > On Apr 13, 2018, at 3:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> >> Hi Bjorn and Rafael,
> >>
> >>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> wrote:
> >>>
> >>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> >>> core: Drop run_wake flag from struct dev_pm_info").
> >>>
> >>> The device in question is not power managed by platform firmware,
> >>> furthermore, it only supports PME# from D3cold:
> >>> Capabilities: [78] Power Management version 3
> >>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >>>
> >>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> >>> After that commit, the device gets runtime suspended, so it does not
> >>> respond to any PME#.
> >>>
> >>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> >>> device_can_wakeup() in pci_dev_run_wake() always returns true.
> >>>
> >>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> >>> condition.
> >>>
> >>> In addition, change wakeup flag passed to pci_target_state() from false
> >>> to true, because we want to find the deepest state that the device can
> >>> still generate PME#.
> >>>
> >>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
> >>> dev_pm_info")
> >>> Cc: stable@vger.kernel.org # 4.13+
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>> v3: State the reason why the wakeup flag gets changed.
> >>>
> >>> v2: Explicitly check dev->pme_support.
> >>
> >> If this patch is good enough, I am hoping it can get merged in v4.17.
> >
> > OK
> >
> > Bjorn, if you want to take this:
> >
> >  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Otherwise please let me know and I'll queue it up.
> 
> Hi, Rafael,
> Can this patch be merged into your tree?

If Bjorn tells me to do that, then yes, it can.

Thanks,
Rafael
