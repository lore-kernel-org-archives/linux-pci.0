Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50671 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751606AbbCLAxd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 20:53:33 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "Zheng, Lv" <lv.zheng@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: Fully disable devices before releasing IRQ resource
Date: Thu, 12 Mar 2015 02:17:15 +0100
Message-ID: <6862626.yP8c2o2fAj@vostro.rjw.lan>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32A0E2E2@ORSMSX113.amr.corp.intel.com>
References: <20150305210529.6393.29546.stgit@gimli.home> <2139068.CEUJTvBkYG@vostro.rjw.lan> <3908561D78D1C84285E8C5FCA982C28F32A0E2E2@ORSMSX113.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 11, 2015 10:04:42 PM Luck, Tony wrote:
> >> Unfortunately there's a long standing comment in pci_device_remove():
> >> 
> >>         /*
> >>          * We would love to complain here if pci_dev->is_enabled is set, that
> >>          * the driver should have called pci_disable_device(), but the
> >>          * unfortunate fact is there are too many odd BIOS and bridge setups
> >>          * that don't like drivers doing that all of the time.
> >>          * Oh well, we can dream of sane hardware when we sleep, no matter how
> >>          * horrible the crap we have to deal with is when we are awake...
> >>          */
> >> 
> >> So, unless we can somehow ignore that comment, I suspect forcing the
> >> device to be disabled on driver remove, whether done from pci-core or
> >> from x86/pci, is going to cause all sorts of breakage.  Are the
> >> expectations set by b4b55cda5874 really valid?  It seems like something
> >> needs to be done to allow the IRQ to be automatically re-established on
> >> x86 regardless of the driver doing the right thing when releasing the
> >> device.  We're still looking at a regression for v4.0 as a result of
> >> b4b55cda5874.
> >
> > In which case we probably should revert commit b4b55cda5874 for the time being.
> >
> > At least I'd be very nervous about any ad-hoc fixes at this stage of the cycle.
> 
> The comment goes back to the dawn of "git" time ... not sure how much further
> back.
> 
> Is this actually still an issue on modern systems?  Maybe we need a black list
> or white list to separate the good from bad systems?

The answer to that is "We don't know" and in my not so humble opinion it is too
risky to try to find out at the end of the cycle.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
