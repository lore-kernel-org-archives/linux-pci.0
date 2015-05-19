Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34593 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbESXPi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 19:15:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo6B3_vRq-4YTSPg4f927WChZ4MXnZRY7wWCvQgZJ=9eOQ@mail.gmail.com>
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com>
 <20150519224452.GT31666@google.com> <CAB=NE6VhdEpiTrxW=VqjsJ94pDzcL5XwEgJyJ07D3-14KAdt9g@mail.gmail.com>
 <CAErSpo6B3_vRq-4YTSPg4f927WChZ4MXnZRY7wWCvQgZJ=9eOQ@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 19 May 2015 16:15:17 -0700
Message-ID: <CAB=NE6U8Fg1TuU9ceVCBHJwR2j+DetDz+L3ZqcJzvSy3_wvPUA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
To: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@redhat.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 4:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [-cc Venkatesh (bouncing)
>
> On Tue, May 19, 2015 at 5:46 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Tue, May 19, 2015 at 3:44 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Thanks! Who's tree should this go through?
>
> I don't know.  This is the only patch that went to linux-pci, so I
> haven't seen the rest.

Oh I only rev'd a v5 for 1/5 as that's the only one that had feedback
asking for changes.

Patch v4 2/5 was for "lib: devres: add pcim_iomap_wc() variants", you
had questions about EXPORT_SYMBOL_GPL() and the fact that this is not
yet used. I replied. This patch can then be ignored but again, I'd
hate for folks to go in and try to add a non EXPORT_SYMBOL_GPL()
symbol of this.

Patches v4 3-5 remain intact, I had addressed it to you, but failed to
Cc linux-pci, I'll go ahead and bounce those now.

Just today Dave Arlie provided a Reviewed-by to some simple
framebuffer device driver changes. I wonder if these changes should go
through the framebuffer tree provided you already gave the Acked-by
for the PCI parts, or if the PCI parts should go in first and only
later (I guess we'd have to wait) then intake the driver changes that
use the symbol.

What we decide should likely also apply to the series that adds
pci_ioremap_wc_bar() and makes use of it on drivers.

Dave, Tomi, any preference?

  Luis
