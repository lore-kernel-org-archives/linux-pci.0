Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdBMW5h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Feb 2017 17:57:37 -0500
Date: Mon, 13 Feb 2017 16:57:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 7/8] thunderbolt: Power down controller when idle
Message-ID: <20170213225732.GB8080@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <153c459627143d2a071344567367032afa4eadef.1484486499.git.lukas@wunner.de>
 <20170128233237.GQ20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170212163130.GA2769@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170212163130.GA2769@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 12, 2017 at 05:31:30PM +0100, Lukas Wunner wrote:
> On Sat, Jan 28, 2017 at 05:32:37PM -0600, Bjorn Helgaas wrote:
> > On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:

> > > +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
> [...]
> > > +	/* prevent interrupts during system sleep transition */
> > > +	if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
> > > +		pr_err("cannot disable wake GPE, resuming\n");
> > 
> > Can you use dev_err() here and below?  This is related to a specific
> > device, and it'd be nice to know which one.
> 
> See above, the device name is included in pr_fmt.  The reason to use
> pr_err() instead of dev_err() is to get the error message prefixed
> with "thunderbolt" instead of "pcieport".  Recall that this function
> is executed in the context of the upstream bridge, whose driver name
> is pcieport.  I would like to prevent people from grepping the portdrv
> code for the error message.  You're the second person to raise this
> question (Andy Shevchenko made the same comment on an earlier version
> of this patch), so I've now added a comment to explain it.

Oh, right, I missed the sneaky dev_name(dev) in pr_fmt().  I guess we
may have a mix of "pcieport" and "thunderbolt" messages related to
the same device, which is sort of sub-optimal, but maybe the best we
can do for now.

Bjorn
