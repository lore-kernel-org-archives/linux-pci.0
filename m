Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/8] PCI, ACPI, x86: Reserve fw allocated resource for hot-add root bus
Date: Wed, 09 Jan 2013 21:10:56 +0100
Message-ID: <5274779.gJQ3WSr6QB@vostro.rjw.lan>
In-Reply-To: <CAE9FiQWm6=1JXA7EB-a0aqgTFQ5ZeCxz_gAU+ABUce1Ovn1Siw@mail.gmail.com>
References: <20121030040237.GA10472@google.com> <CAErSpo6qX3ih9DXLqxqJw141OAeTFu0YfSih6LyD0sd2gS-Vyg@mail.gmail.com> <CAE9FiQWm6=1JXA7EB-a0aqgTFQ5ZeCxz_gAU+ABUce1Ovn1Siw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 09, 2013 11:01:39 AM Yinghai Lu wrote:
> On Wed, Jan 9, 2013 at 10:39 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> the reason why we need to change those codes for x86, we want to make it support
> >> pci root bus hotplug. So it would be reasonable for us to align other
> >> platform to x86
> >> changes after pci root bus hotplug change is completely done.
> >
> > OK, I opened https://bugzilla.kernel.org/show_bug.cgi?id=52531 as a
> > way to keep track of this consistency issue and merged
> > pci/yinghai-survey-resources to my -next branch.
> 
> Thanks a lot. will send other pci root bus hotplug out.
> 
> question: now Rafael's tree has acpi-scan branch and it touches pci-root.c.
> 
> so is it ok for me to base patches on your pci/next and his pm/acpi-scan?
> how?
> can you two have some arrangement like you pulling Rafael's branch?

My acpi-scan branch is not going to be rebased going forward, so it can be
pulled from safely if that helps.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
