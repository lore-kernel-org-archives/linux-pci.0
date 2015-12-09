Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58461 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752657AbbLIAvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2015 19:51:23 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PCI: constify pci_platform_pm_ops structure
Date: Wed, 09 Dec 2015 02:21:21 +0100
Message-ID: <11604085.iKre2i4LQp@vostro.rjw.lan>
In-Reply-To: <20151207160649.GG7994@localhost>
References: <1449419625-29045-1-git-send-email-Julia.Lawall@lip6.fr> <1556686.IXJIjFBvQx@vostro.rjw.lan> <20151207160649.GG7994@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, December 07, 2015 10:06:49 AM Bjorn Helgaas wrote:
> On Mon, Dec 07, 2015 at 02:41:34AM +0100, Rafael J. Wysocki wrote:
> > On Sunday, December 06, 2015 05:33:45 PM Julia Lawall wrote:
> > > The pci_platform_pm_ops structure is never modified, so declare it as
> > > const.
> > > 
> > > Done with the help of Coccinelle.
> > > 
> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > OK
> > 
> > Bjorn, do you want me to handle this one?
> 
> Sure, sounds good to me.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK, queued up for 4.5, thanks!

Rafael

