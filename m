Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58191 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753725AbbBZPVs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 10:21:48 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Joachim Nilsson <troglobit@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] pci-versatile.c: Update for API change in list_for_each_entry()
Date: Thu, 26 Feb 2015 16:45:15 +0100
Message-ID: <1908959.51iYpqoucA@vostro.rjw.lan>
In-Reply-To: <CACRpkdbBsLQ_RSrDHBTZJVKoq33ySF9Eo4Bp9R=-Ak2ek-7GKA@mail.gmail.com>
References: <5150533.nuGgOOyLIn@wuerfel> <CACRpkdbBsLQ_RSrDHBTZJVKoq33ySF9Eo4Bp9R=-Ak2ek-7GKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 26, 2015 08:41:37 AM Linus Walleij wrote:
> On Wed, Feb 25, 2015 at 4:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > From: Joachim Nilsson <troglobit@gmail.com>
> >
> > In Linux 4.0-rc1 ARM Versatile PCI build fails to build due to what
> > appears to be an API update.  This patch is a very simple correction,
> > merely posted as a heads-up to the maintainers.  Hopefully a better
> > fix can be forwarded to Linus.
> >
> > [arnd: the patch actually looks correct, so let's take this version]
> >
> > Signed-off-by: Joachim Nilsson <troglobit@gmail.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >
> > Joachim reported the bug, and I independently found the same problem.
> > The patch he sent to the list did not apply for me for an unknown reason,
> > but I fixed it up and forward it now to the right list of recipients.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Do I need to take this one?  Bjorn?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
