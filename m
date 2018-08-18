Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Message-ID: <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui
 <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas
 Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Sat, 18 Aug 2018 13:24:51 +1000
In-Reply-To: <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-2-benh@kernel.crashing.org>
	 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> 
> Just to be clear, if I understand correctly, this is a pure revert of
> 44bda4b7d26e and as such it reintroduces the problem solved by that
> commit.
> 
> If your solution turns out to be better, that's great, but it would be
> nice to avoid the bisection hole of reintroducing the problem, then
> fixing it again later.

There is no way to do that other than merging the revert and the fix
into one. That said, the race is sufficiently hard to hit that I
wouldn't worry too much about it.

> > The new pci state mutex provides a simpler way of addressing
> > this race and avoids the relative includes added to the powerpc
> > code.
