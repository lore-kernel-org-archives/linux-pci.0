Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725741AbeHSFeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Aug 2018 01:34:31 -0400
Date: Sat, 18 Aug 2018 21:24:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
Message-ID: <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org>
 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> > 
> > Just to be clear, if I understand correctly, this is a pure revert of
> > 44bda4b7d26e and as such it reintroduces the problem solved by that
> > commit.
> > 
> > If your solution turns out to be better, that's great, but it would be
> > nice to avoid the bisection hole of reintroducing the problem, then
> > fixing it again later.
> 
> There is no way to do that other than merging the revert and the fix
> into one. That said, the race is sufficiently hard to hit that I
> wouldn't worry too much about it.

OK, then at least mention that in the changelog.

> > > The new pci state mutex provides a simpler way of addressing
> > > this race and avoids the relative includes added to the powerpc
> > > code.
> 
