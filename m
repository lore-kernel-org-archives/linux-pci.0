Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34976 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbFYA6i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 20:58:38 -0400
MIME-Version: 1.0
In-Reply-To: <1435193521.3790.26.camel@kernel.crashing.org>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
 <1435099343.3996.13.camel@kernel.crashing.org> <20150624163821.GF11147@wotan.suse.de>
 <1435183509.3790.14.camel@kernel.crashing.org> <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
 <1435189081.3790.24.camel@kernel.crashing.org> <20150625000803.GH11147@wotan.suse.de>
 <1435193521.3790.26.camel@kernel.crashing.org>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 24 Jun 2015 17:58:17 -0700
Message-ID: <CAB=NE6VTHL1pGVMAkThx07wHNEPAGToJg5Ns_YEd6U1edb8__g@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Davidlohr Bueso <dbueso@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Borislav Petkov <bp@suse.de>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Juergen Gross <jgross@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	David Vrabel <david.vrabel@citrix.com>,
	venkatesh.pallipadi@intel.com,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 5:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2015-06-25 at 02:08 +0200, Luis R. Rodriguez wrote:
>>
>> OK thanks I'll proceed with these patches then.
>>
>> > As for user mappings,
>>
>> Which APIs were you considering in this regard BTW?
>
> mmap of the generic /sys/bus/pci/.../resource*

Like? Got a demo patch in mind ? :)

 Luis
