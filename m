Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 8 Mar 2012 07:45:25 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org,
	Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 16/23] PCI: add pci bus removal through
 /sys/.../pci_bus/.../remove
Message-ID: <20120308154525.GB5907@kroah.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
 <1331018040-30725-17-git-send-email-yinghai@kernel.org>
 <CAErSpo59kzBL1ApWuWWcymd9UR3m3vB3zkUoJezn66As+-97dQ@mail.gmail.com>
 <CAE9FiQVTng2Bi4z9YY9CustC7KkTr-6+qFaaqu8F4dd0WAKGig@mail.gmail.com>
 <CAErSpo72DxcCtMedHUu=t1-bGXp3sqa+hCgP2tNT=z6EfiHTJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo72DxcCtMedHUu=t1-bGXp3sqa+hCgP2tNT=z6EfiHTJQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 07, 2012 at 09:45:18PM -0700, Bjorn Helgaas wrote:
> >> I'm not sure it makes sense to talk about removing a "bus" and leaving
> >> the upstream bridge (either a host bridge or a P2P bridge).  I think
> >> it'd make more sense to remove the bridge itself, which would of
> >> course have the consequence of removing the secondary bus.
> >
> > for root bus, that remove pci_host_bridge and pci root bus.
> >
> > for pci bus under pci bridge, will remove that pci bus, but will still
> > keep  that pci bridge.
> > that should be ok. just like some pci bridge is there, and later can
> > not create child bus for it.
> >
> > there is one case: during test busn_alloc, i need to remove all device
> > on one bus, and
> > use setpci to change bridge bus number register. then use rescan
> > bridge to create new bus.
> >
> > with this one, I just need to remove that bus, instead of remove
> > children devices one by one.
> 
> I don't think making it convenient for manual testing is an argument
> for this interface.  For sysfs interfaces it is more important to make
> something that fits well into the grand plan of how things Should
> Work.  If you need internal helper functions for convenience, I'm OK
> with that, because it's easier to change those than to change sysfs
> interfaces.

If it's "only" for testing, then put it in debugfs, not sysfs.

thanks,

greg k-h
