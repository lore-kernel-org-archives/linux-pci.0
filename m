Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dave Airlie <airlied@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
Date: Wed, 25 Feb 2015 23:42:26 +0100
Message-ID: <16779086.0bGZj9locs@vostro.rjw.lan>
In-Reply-To: <CAPM=9txFHJXbhXQsSyL=h2oG83tr5ZnJj7G6cFtVQ+EDWdXv6w@mail.gmail.com>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com> <CAErSpo4kG_RrpFtZ6QyRFkMO51Zx62q94L+r60-HfSZY3VHD1g@mail.gmail.com> <CAPM=9txFHJXbhXQsSyL=h2oG83tr5ZnJj7G6cFtVQ+EDWdXv6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, February 25, 2015 06:03:56 PM Dave Airlie wrote:
> > * v3.19 ignored [io  0x0cf8-0x0cff], but v4.0 includes it.  I think
> > it's wrong to include it because that's the configuration space
> > address/data registers, so it's consumed by the host bridge and not
> > produced on the downstream side.
> >
> > * v3.19 includes [mem 0x7ff00000-0xfebfffff], but v4.0 does not.  This
> > is what's screwing up the devices.
> >
> > I think all the windows should be marked as ACPI_PRODUCER in _CRS
> > since the space is "produced" on the downstream side of the bridge.
> > The [io  0x0cf8-0x0cff] region should probably be marked
> > ACPI_CONSUMER, and maybe that accounts for why v3.19 ignores it.  But
> > I haven't found the code that does that yet.
> >
> > I suspect this is all related to the ACPI resource parsing rework.  I
> > looked through that briefly, but no issues jumped out at me, so this
> > is just a heads-up in case it is obvious to you guys.
> >
> > Dave, it'd be useful if you could collect an acpidump so we can look
> > at the _CRS data in more detail.
> 
> acpidump fails here with a /dev/mem warning in the kernel,
> 
> now I'm not near the machine again until next week most likely, so I
> only have ssh for now,
> and the kernel it is running for which I don't have the source anymore!
> 
> is there any of tables from /sys I can grab instead?

/sys/firmware/acpi/tables/DSDT
/sys/firmware/acpi/tables/SSDT*

Also I'm wondering if reverting commit 2ea3d266bab3 (ACPI: Translate
resource into master side address for bridge window resources) makes
any difference?

Rafael

