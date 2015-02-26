Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35341 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbBZXfL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Feb 2015 18:35:11 -0500
Received: by iecrl12 with SMTP id rl12so22911455iec.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2015 15:35:10 -0800 (PST)
Date: Thu, 26 Feb 2015 17:35:07 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Joachim Nilsson <troglobit@gmail.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] pci-versatile.c: Update for API change in
 list_for_each_entry()
Message-ID: <20150226233507.GD25765@google.com>
References: <5150533.nuGgOOyLIn@wuerfel>
 <CACRpkdbBsLQ_RSrDHBTZJVKoq33ySF9Eo4Bp9R=-Ak2ek-7GKA@mail.gmail.com>
 <1908959.51iYpqoucA@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1908959.51iYpqoucA@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 04:45:15PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 26, 2015 08:41:37 AM Linus Walleij wrote:
> > On Wed, Feb 25, 2015 at 4:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > From: Joachim Nilsson <troglobit@gmail.com>
> > >
> > > In Linux 4.0-rc1 ARM Versatile PCI build fails to build due to what
> > > appears to be an API update.  This patch is a very simple correction,
> > > merely posted as a heads-up to the maintainers.  Hopefully a better
> > > fix can be forwarded to Linus.
> > >
> > > [arnd: the patch actually looks correct, so let's take this version]
> > >
> > > Signed-off-by: Joachim Nilsson <troglobit@gmail.com>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >
> > > Joachim reported the bug, and I independently found the same problem.
> > > The patch he sent to the list did not apply for me for an unknown reason,
> > > but I fixed it up and forward it now to the right list of recipients.
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Do I need to take this one?  Bjorn?

Yeah, if you don't mind, why don't you take it, Rafael.  I think it was
introduced by 872912352c5b ("Merge tag 'pm+acpi-3.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").  I don't
really understand that commit, but it looks like this part of it is the
problem:

  -       list_for_each_entry(win, res, list) {
  ++      resource_list_for_each_entry(win, res, list) {

If you do, would you mind updating the subject line and adding these acks?

  PCI: versatile: Update for list_for_each_entry() API change

  Acked-by: Linus Walleij <linus.walleij@linaro.org>
  Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn
