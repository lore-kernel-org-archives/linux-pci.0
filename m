Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Ronciak, John" <john.ronciak@intel.com>,
	"Penner, Miles J" <miles.j.penner@intel.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/6] PCI: acpiphp: do not check for SLOT_ENABLED in enable_device()
Date: Tue, 02 Jul 2013 22:29:12 +0200
Message-ID: <4523014.G6VJLhZf81@vostro.rjw.lan>
In-Reply-To: <CAErSpo7P5+Yc9r9RFMJPqOzGQ-CFr8RAW7ehgumTzhdxoYCF6Q@mail.gmail.com>
References: <1372177330-28013-1-git-send-email-mika.westerberg@linux.intel.com> <3216917.m2IEX2IHod@vostro.rjw.lan> <CAErSpo7P5+Yc9r9RFMJPqOzGQ-CFr8RAW7ehgumTzhdxoYCF6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 02, 2013 10:40:39 AM Bjorn Helgaas wrote:
> On Mon, Jul 1, 2013 at 7:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, July 01, 2013 09:36:13 PM Mika Westerberg wrote:
> >> On Mon, Jul 01, 2013 at 04:01:37PM +0200, Rafael J. Wysocki wrote:
> >> > > Given the fact that SLOT_ENABLED is only checked in acpiphp_enable_slot()
> >> > > (after this patch) and that /sys/bus/pci/slots/*/power uses SLOT_POWEREDON
> >> > > anyway, should we remove the whole flag?
> >> >
> >> > Sure, if it is not necessary any more, we should remove it.
> >>
> >> Well, there is one thing that changes due that. Once the flag is gone
> >> userspace can do 'echo 1 > /sys/bus/pci/slots/*/power' several times and
> >> the slot is always re-enumerated.
> >>
> >> If that is not acceptable we should probably move the SLOT_ENABLED check
> >> closer to acpiphp_core:enable_device() and drop it from here, so that we
> >> always re-enumerate on Bus Check event but userspace can only do enable
> >> once (we still re-enumerate on Bus Check).
> >
> > Yes, that sounds like the right thing to do.
> 
> Is it actually a problem if we re-enumerate every time userspace does
> 'echo 1 > /sys/bus/pci/slots/*/power'?  I assume re-enumeration is a
> no-op if nothing has changed.

Well, if it's a no-op in that case, then re-enumerating shouldn't be a problem,
but is it a no-op?

Rafael (who's not really sure)


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
