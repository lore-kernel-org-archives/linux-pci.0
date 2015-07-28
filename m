Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36221 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbbG1R6v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2015 13:58:51 -0400
Received: by ykay190 with SMTP id y190so102142944yka.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2015 10:58:51 -0700 (PDT)
Date: Tue, 28 Jul 2015 13:58:48 -0400
From: Tejun Heo <tj@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, chuansheng.liu@intel.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	mister.freeman@laposte.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
Message-ID: <20150728175848.GI5322@mtj.duckdns.org>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438047747.1856.12.camel@rzhang1-mobl4>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 09:42:27AM +0800, Zhang Rui wrote:
> From 57edba9c677e47354846db951014dc4d5b13ce54 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Sun, 26 Jul 2015 14:15:36 +0800
> Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
> 
> In https://bugzilla.kernel.org/show_bug.cgi?id=81551,
> we found that Jmicron chip 361/363 is broken after resume if async noirq
> (76569faa62 (PM / sleep: Asynchronous threads for resume_noirq)) is supported,
> thus commit e6b7e41cdd (ata: Disabling the async PM for JMicron chip 363/361)
> is introduced to fix this problem.
> But then, we found that Jmicron chip 368 also has this problem, and it is decided
> to disable the pm async feature for all the Jmicron chips.
> 
> But how to fix this was discussed in the mailing list for some time.
> After some investigation, we believe that a proper fix is to disable
> the async PM in PCI instead of ata driver, because, on this platform,
> pci_resume_noirq() of IDE controller must happen after pci_resume_noirq()
> of AHCI controller. But as .resume_noirq() of the pata_jmicron driver is
> no-op, this suggests that it is the PCI common actions, aka,
> pci_pm_default_resume_early(), have the dependency.
> To fix this, using device_pm_wait_for_dev() in pata_jmicron driver can not
> solve the dependency because pci_pm_default_resume_early() is invoked before
> driver callback being invoked, plus, as it is the PCI common actions that
> have the dependency, it is reasonable to fix it in PCI bus code,
> rather than driver code.
> 
> This patch is made based on the patch from Liu Chuansheng at
> https://lkml.org/lkml/2014/12/5/74
> it reverts commit e6b7e41cdd ("ata: Disabling the async PM for JMicron
> chip 363/361"), and introduces a PCI quirk to disable async PM for Jmicron
> chips.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81551
> Tested-by: Jay <MyMailClone@t-online.de>
> Tested-by: Barto <mister.freeman@laposte.net>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

>  /*
> + * For JMicron chips, we need to disable the async_suspend method, otherwise
> + * they will hit the power-on issue when doing device resume, add one quick
> + * solution to disable the async_suspend method.
> + */

Maybe add a link to the bug report and/or discussion thread?

Thanks.

-- 
tejun
