Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35805 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbFYPx4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 11:53:56 -0400
MIME-Version: 1.0
In-Reply-To: <20150625150918.GA4898@pd.tnic>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
 <1435195342-26879-6-git-send-email-mcgrof@do-not-panic.com> <20150625150918.GA4898@pd.tnic>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 25 Jun 2015 08:53:35 -0700
Message-ID: <CAB=NE6XJUwBg46tNOt=Y9zpuM8jZbeV-G_ndTQCC0+uO=wOgzw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] PCI: Add pci_iomap_wc() variants
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
	venkatesh.pallipadi@intel.com,
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

On Thu, Jun 25, 2015 at 8:09 AM, Borislav Petkov <bp@suse.de> wrote:
>> +void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>> +                              int bar,
>> +                              unsigned long offset,
>> +                              unsigned long maxlen)
>> +{
>> +     resource_size_t start = pci_resource_start(dev, bar);
>> +     resource_size_t len = pci_resource_len(dev, bar);
>> +     unsigned long flags = pci_resource_flags(dev, bar);
>> +
>> +     if (len <= offset || !start)
>> +             return NULL;
>> +     len -= offset;
>> +     start += offset;
>> +     if (maxlen && len > maxlen)
>> +             len = maxlen;
>> +     if (flags & IORESOURCE_IO)
>> +             return NULL;
>
> I've moved this check at the beginning of the function so that we bail
> out before doing the computations above it.

That indeed looks like a good optimization.

 Luis
