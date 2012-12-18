Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1355863696.18964.378.camel@misato.fc.hp.com>
Subject: Re: [PATCH rev.2 1/6] ACPI: Separate adding ACPI device objects
 from probing ACPI drivers
From: Toshi Kani <toshi.kani@hp.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Date: Tue, 18 Dec 2012 13:48:16 -0700
In-Reply-To: <CAE9FiQV-GDRd1iapMwy4j4mBChRpEm-9ANHg6BTdyiTd-5Bf8A@mail.gmail.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan>
	 <1525730.exQ7msTINR@vostro.rjw.lan>
	 <1355789297.18964.334.camel@misato.fc.hp.com>
	 <4082842.31rfDviYHK@vostro.rjw.lan>
	 <1355847041.18964.369.camel@misato.fc.hp.com>
	 <CAE9FiQV-GDRd1iapMwy4j4mBChRpEm-9ANHg6BTdyiTd-5Bf8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-12-18 at 10:59 -0800, Yinghai Lu wrote:
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

Thanks for the pointer!  Oh, I did not know that pci_dev gets removed
before acpi_bus_trim() is called...  I looked at Jiang's last two
patches for the bind update, and they look good to me.  

Thanks,
-Toshi

