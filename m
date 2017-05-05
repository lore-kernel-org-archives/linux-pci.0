Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50382 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdEEJYf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 May 2017 05:24:35 -0400
Message-ID: <1493976265.30052.21.camel@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amir Goldstein <amir73il@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        tpmdd-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-input@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
Date: Fri, 05 May 2017 12:24:25 +0300
In-Reply-To: <CAOQ4uxjha8_2_HwgdgBN=G-vNytAW5Gk155E9z8OWyFiGNEZVw@mail.gmail.com>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
         <CAPcyv4jzD0MEBRNTwTokVzgdDWas682ArUjRAGT1hp=QRE8Pjg@mail.gmail.com>
         <CAOQ4uxjha8_2_HwgdgBN=G-vNytAW5Gk155E9z8OWyFiGNEZVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-05-05 at 10:06 +0300, Amir Goldstein wrote:
> On Fri, May 5, 2017 at 9:20 AM, Dan Williams <dan.j.williams@intel.com
> > wrote:
> > On Thu, May 4, 2017 at 2:21 AM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:


> > >         for (i = 0; i < NFIT_UUID_MAX; i++)
> > > -               if (memcmp(to_nfit_uuid(i), spa->range_guid, 16)
> > > == 0)
> > > +               if (!uuid_le_cmp_pp(to_nfit_uuid(i), (uuid_le
> > > *)spa->range_guid))
> > 
> > What is _cmp_pp? Why not _compare?

Dan, it's a typo. In this patch it should be just ..._cmp(), which is
already a part of API.

> > 
> 
> I second that.
> 
> Andy,

Amir, just to be clear. This patch can be applied without any addons to
an existing API. Above is just a typo due to rebase in my tree. I will
replace it to just uuid_le_cmp().

> I much rather that you sort out uuid helpers in a way that will
> satisfy the filesystem
> needs (just provide the helpers don't need to convert filesystems
> code).

> The only reason I took a swing at hoisting the xfs uuid helpers is
> because it didn't
> seem like your proposal was going to be posted soon or wasn't going to
> satisfy
> the filesystems use case.

> 
> My opinion now, is that your suggestion is probably much closer to the
> real deal
> than mine.
> 
> IMO, you should acknowledge that the common use case for filesystems
> is
> to handle an opaque char[16] which most likely holds a uuid_be and you
> should provide 'neutral' helpers to satisfy this use case.
> 
> The simplest would be to typedef uuid_t to struct uuid_be and to name
> 'neutral'
> helpers' uuid_cmp/uuid_copy(uuid_t *, uuid_t *), similar to my
> proposal.

> I think with this semantic change, our proposals can reach common
> grounds
> and satisfy a wider group of users (i.e. filesystem developers).
> 
> Christoph also suggested a similar treatment to typedef guid_t to
> struct uuid_le.
> I don't know the use cases enough to comment on that.

We may go this way. But I wouldn't prevent current users of uuid_le to
continue using it without conversion (it may be done case by case after
we settle an API)

So, summarize what Christoph said it will look like

typedef uuid_be uuid_t;
typedef uuid_le guid_t

uuid_cmp() / uuid_copy() / uuid_to_bin() / etc
guid_cmp() / guid_copy() / guid_to_bin() / etc

Correct? Christoph?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
