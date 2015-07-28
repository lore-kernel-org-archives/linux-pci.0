Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46775 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbbG1CFb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 22:05:31 -0400
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Zhang Rui <rui.zhang@intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
Cc: chuansheng.liu@intel.com, Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	MyMailClone@t-online.de, mister.freeman@laposte.net,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Aaron Lu <aaron.lu@intel.com>
Message-ID: <55B6E3BD.6040101@intel.com>
Date: Tue, 28 Jul 2015 10:06:53 +0800
MIME-Version: 1.0
In-Reply-To: <1438047747.1856.12.camel@rzhang1-mobl4>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/28/2015 09:42 AM, Zhang Rui wrote:
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

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
