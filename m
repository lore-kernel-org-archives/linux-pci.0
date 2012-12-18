Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH rev.2 1/6] ACPI: Separate adding ACPI device objects from probing ACPI drivers
Date: Tue, 18 Dec 2012 23:05:49 +0100
Message-ID: <3573149.O0Vu1dNrT9@vostro.rjw.lan>
In-Reply-To: <CAE9FiQV-GDRd1iapMwy4j4mBChRpEm-9ANHg6BTdyiTd-5Bf8A@mail.gmail.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <1355847041.18964.369.camel@misato.fc.hp.com> <CAE9FiQV-GDRd1iapMwy4j4mBChRpEm-9ANHg6BTdyiTd-5Bf8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 18, 2012 10:59:46 AM Yinghai Lu wrote:
> On Tue, Dec 18, 2012 at 8:10 AM, Toshi Kani <toshi.kani@hp.com> wrote:
> > On Tue, 2012-12-18 at 02:48 +0100, Rafael J. Wysocki wrote:
> >
> > So, I would propose the following changes.
> >
> >  - Move the acpi_hot_add_bind() call back to the original place after
> > the device_attach() call.
> >  - Rename the name of acpi_hot_add_bind() to something like
> > acpi_bind_adr_device() since it is no longer hot-add only (and is
> > specific to _ADR devices).
> >  - Create its pair function, acpi_unbind_adr_device(), which is called
> > from acpi_bus_remove().  When a constructor interface is introduced, its
> > destructor should be introduced as well.
> >  - Remove the binding procedure from acpi_pci_root_add().  This should
> > be done in patch [2/6].
> 
> i think we should put jiang four patches before Rafael's patches.
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-jiang-hotplug

Actually, I have something more radical than that in mind. :-)

Namely, we don't need to call the wakeup-related stuff from acpi_pci_bind() and
acpi_pci_unbind().  It's only there, because I did't find a better place for it
when I added it.

If we can set the ACPI handles of PCI devices in pci_scan_device(), which isn't
too difficult to do (I actually have a patch for that and it's not too invasive),
we can easily move the wakeup enabling stuff to pci_pm_init() and wakeup
disabling somewhere near pci_release_capabilities().

Then we are only left with the _PRT setup in there, but that could be done
as soon as in pci_scan_device() too, if I'm not mistaken.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
