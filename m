Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42392 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S376437AbdD2K2P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2017 06:28:15 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Imre Deak <imre.deak@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Sat, 29 Apr 2017 12:21:57 +0200
Message-ID: <23725356.i2L37sn5oF@aspire.rjw.lan>
In-Reply-To: <4849096.yzbfqj2AUz@aspire.rjw.lan>
References: <1493388963-5278-1-git-send-email-imre.deak@intel.com> <4849096.yzbfqj2AUz@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 28, 2017 11:33:02 PM Rafael J. Wysocki wrote:
> On Friday, April 28, 2017 05:16:02 PM Imre Deak wrote:
> > Some drivers - like i915 - may not support the system suspend direct
> > complete optimization due to differences in their runtime and system
> > suspend sequence. Add a flag that when set resumes the device before
> > calling the driver's system suspend handlers which effectively disables
> > the optimization.
> > 
> > Needed by the next patch fixing suspend/resume on i915.
> > 
> > Suggested by Rafael.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The reason why the opt-out flag was not added on day one was because we were
> not sure whether or not it would be necessary at all.
> 
> Quite evidently, it is needed.

But that said, it actually can be implemented as a flag in dev_flags too, say
PCI_DEV_FLAGS_NEEDS_RESUME, in analogy with PCI_DEV_FLAGS_NO_D3 that's
already there.

The struct size would not need to grow then which I guess would be better?

Thanks,
Rafael
