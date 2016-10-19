Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755126AbcJSOLp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Oct 2016 10:11:45 -0400
Message-ID: <1476884558.11323.494.camel@linux.intel.com>
Subject: Re: [PATCH v2] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_state hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>
Date: Wed, 19 Oct 2016 16:42:38 +0300
In-Reply-To: <20161011083744.GA7577@gmail.com>
References: <63b7393731a5708dbbf107055e3fd9801c3c00b3.1476007467.git.lukas@wunner.de>
         <1476025280.11323.355.camel@linux.intel.com>
         <20161011083744.GA7577@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-10-11 at 10:37 +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > 
> > On Sun, 2016-10-09 at 14:46 +0200, Lukas Wunner wrote:
> > > 
> > > Commit cc7cc02bada8 ("PCI: Query platform firmware for device
> > > power
> > > state") augmented struct pci_platform_pm_ops with a ->get_state
> > > hook
> > > and
> > > implemented it for acpi_pci_platform_pm, the only
> > > pci_platform_pm_ops
> > > existing till v4.7.
> > > 
> > > However v4.8 introduced another pci_platform_pm_ops for Intel
> > > Mobile
> > > Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-
> > > mid:
> > > Add
> > > Power Management Unit driver").  It is missing the ->get_state
> > > hook,
> > > which is fatal since pci_set_platform_pm() enforces its presence.
> > > 
> > > Retrofit mid_pci_platform_pm with the missing callback to fix the
> > > breakage.
> > > 
> > 
> > +Ingo.
> > 
> > I guess it should go via tip/x86/urgent tree.
> 
> Can do, if Bjorn is fine with it as well - the patch is touching 
> drivers/pci/pci-mid.c.

Bjorn, we are at 4.9-rc1 already and it has this regression. Can you,
please, ACK it?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
