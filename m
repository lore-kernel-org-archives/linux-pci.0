Return-Path: <andreas.noever@gmail.com>
Return-Path: <andreas.noever@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160530144445.GC1743@lahna.fi.intel.com>
References: <20160524162833.GA30762@localhost> <20160526104557.GA6816@wunner.de>
 <20160526110308.GX1789@lahna.fi.intel.com> <1576190.gfFb6HhZV6@vostro.rjw.lan>
 <20160530093326.GH1789@lahna.fi.intel.com> <20160530144445.GC1743@lahna.fi.intel.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Mon, 30 May 2016 17:19:53 +0200
Message-ID: <CAMxnaaXhapETZYMVe6EUoBGaMtxL_fP+uzc30SQpM+6EqPF3CQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Wait for 50ms after bridge is powered up
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>, Dave Airlie <airlied@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 4:44 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, May 30, 2016 at 12:33:26PM +0300, Mika Westerberg wrote:
>> I also learned that both of these can be shortened with following
>> mechanisms:
>>
>>  - PCIe readines notifications (6.23 in PCIe spec 3.1a)
>>  - ACPI _DSM method returning readines durations from  (4.6.9 in PCI
>>    firmware spec 3.2).
>
> BTW, looks like the latter is already implemented in
> pci_acpi_optimize_delay().


Hmm, Lukas's trace suggest a few independent problems (or optimisations):
1. Those devices are siblings, we should wake all of them in parallel
and then wait once instead of one by one.
2. Why are we waiting after _suspend at all? It seems we should only
wait before the next access. Sleeping after _suspend looks like a stop
gap measure to guarantee that no accesses take place?
3. The idle timeout is too low, there should be no suspend between
discovery and probing.
4. Even if the spec says 50ms, we might still want to have shorter
sleep times for known good devices. Thunderbolt can produce PCI
hierarchies which are 7 levels deep with 4 hp bridges on each level.
Waking all of that would take 50ms * 7 * 4 = 1400ms (not counting
upstream bridges which have the normal d3 delay).

Does TB support PCIe readines notifications?

Andreas
