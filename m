Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36132 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbFYPwR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 11:52:17 -0400
MIME-Version: 1.0
In-Reply-To: <20150625154031.GB4898@pd.tnic>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
 <1435195342-26879-7-git-send-email-mcgrof@do-not-panic.com> <20150625154031.GB4898@pd.tnic>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 25 Jun 2015 08:51:57 -0700
Message-ID: <CAB=NE6X35Bw8PEs9b7rwtMakTkHXFr4rmsBPBFEfK-0oT83T6A@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] lib: devres: add pcim_iomap_wc() variants
To: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Toshi Kani <toshi.kani@hp.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 25, 2015 at 8:40 AM, Borislav Petkov <bp@suse.de> wrote:
> On Wed, Jun 24, 2015 at 06:22:19PM -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>
>> Now that we have pci_iomap_wc() add the respective
>> devres helpers. These go unexported for now but
>> note that should they later be exported this
>> must go with EXPORT_SYMBOL_GPL().
>
> Do I see it correctly, those are not used in this patchset?

That's correct. It was a preemptive implementation of devres pci wc APIs.

> If so, then let's keep this patch in the bag and pick it up only when
> those functions have users.

OK!

 Luis
