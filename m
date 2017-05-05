Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53361 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdEEHai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 May 2017 03:30:38 -0400
Date: Fri, 5 May 2017 09:30:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
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
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
Message-ID: <20170505073035.GA3112@lst.de>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com> <CAPcyv4jzD0MEBRNTwTokVzgdDWas682ArUjRAGT1hp=QRE8Pjg@mail.gmail.com> <CAOQ4uxjha8_2_HwgdgBN=G-vNytAW5Gk155E9z8OWyFiGNEZVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOQ4uxjha8_2_HwgdgBN=G-vNytAW5Gk155E9z8OWyFiGNEZVw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 05, 2017 at 10:06:06AM +0300, Amir Goldstein wrote:
> I much rather that you sort out uuid helpers in a way that will
> satisfy the filesystem
> needs (just provide the helpers don't need to convert filesystems code).

Yeah.

> IMO, you should acknowledge that the common use case for filesystems is
> to handle an opaque char[16] which most likely holds a uuid_be and you
> should provide 'neutral' helpers to satisfy this use case.
> 
> The simplest would be to typedef uuid_t to struct uuid_be and to name 'neutral'
> helpers' uuid_cmp/uuid_copy(uuid_t *, uuid_t *), similar to my proposal.

It's not jut neutral, it's the right thing to to.  The Apollo / DCE
uuids (later also specified in RFC 4122) are big endian, so we should
use the name there.

> Christoph also suggested a similar treatment to typedef guid_t to
> struct uuid_le.

Exactly.  The whole idea of "little endian UUIDs" comes from the
Wintel world, and if you look at the relevant specs they are almost
exclusively referred to as GUIDs.

The magic XFS and AFS types for specific interpretations of one of
the RFC4122 formats don't really help, but I'll just send a patch
to kill them off for XFS ASAP to at least get that out, and we
probably should revert at least

"afs: Move UUID struct to linux/uuid.h"

That moved the AFS mess to common code as a start, and then
also clean up the way we generate random UUIDs, where we currently
have le helper, a be helper and then also generate_random_uuid
just to confuse the heck out of people.  With no description of
either of them.
