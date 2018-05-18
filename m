Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 May 2018 13:53:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / PM: Do not clear state_saved for devices that
 remain suspended
Message-ID: <20180518105317.GG15419@lahna.fi.intel.com>
References: <11415287.ki0m5Bqgns@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11415287.ki0m5Bqgns@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2018 at 10:17:42AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The state_saved flag should not be cleared in pci_pm_suspend() if the
> given device is going to remain suspended, or the device's config
> space will not be restored properly during the subsequent resume.
> 
> Namely, if the device is going to stay in suspend, both the late
> and noirq callbacks return early for it, so if its state_saved flag
> is cleared in pci_pm_suspend(), it will remain unset throughout the
> remaining part of suspend and resume and pci_restore_state() called
> for the device going forward will return without doing anything.
> 
> For this reason, change pci_pm_suspend() to only clear state_saved
> if the given device is not going to remain suspended.  [This is
> analogous to what commit ae860a19f37c (PCI / PM: Do not clear
> state_saved in pci_pm_freeze() when smart suspend is set) did for
> hibernation.]
> 
> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
