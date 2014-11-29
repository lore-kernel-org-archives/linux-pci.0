Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/4] PM: Use CONFIG_PM instead of CONFIG_PM_RUNTIME in core code
Date: Sat, 29 Nov 2014 01:50:12 +0100
Message-ID: <2549404.ZIjrAGNJPJ@vostro.rjw.lan>
In-Reply-To: <CAPDyKFpcHawZ8F+2QdDYO=+qbh=uQb+A+2Rq_M7g9VqMnFtM1A@mail.gmail.com>
References: <Pine.LNX.4.44L0.1411271216470.8104-100000@netrider.rowland.org> <1803282.Wzz7IausxS@vostro.rjw.lan> <CAPDyKFpcHawZ8F+2QdDYO=+qbh=uQb+A+2Rq_M7g9VqMnFtM1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 27, 2014 11:34:03 PM Ulf Hansson wrote:
> [...]
> 
> > That said whether or not it is ever useful to set PM_RUNTIME alone is a good
> > question.  In my opinion it is useful today, at least on some platforms that
> > don't really support system suspend or hibernation in any form.  However, it
> > may not be the case any more when suspend-to-idle becomes mature enough,
> > because that should just work for any platform without any kind of special
> > support.  We're still missing some timekeeping bits there, but once that
> > gap has been covered, we may just eliminate PM_SLEEP as well if there's a
> > broad consensus on that.
> 
> That's sounds like a good approach, thanks for sharing your ideas and plans.
> 
> Feel free to add my reviewed-by tag to this patchset as well.

I'll do that, thanks!

