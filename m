Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 5 May 2017 11:57:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20170505095739.GB6762@lst.de>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com> <CAPcyv4jzD0MEBRNTwTokVzgdDWas682ArUjRAGT1hp=QRE8Pjg@mail.gmail.com> <CAOQ4uxjha8_2_HwgdgBN=G-vNytAW5Gk155E9z8OWyFiGNEZVw@mail.gmail.com> <1493976265.30052.21.camel@linux.intel.com> <CAOQ4uxjErce01+xyDnM=nCJS+avQ4g6hQVvH3fVotj7Ws2moCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOQ4uxjErce01+xyDnM=nCJS+avQ4g6hQVvH3fVotj7Ws2moCQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 05, 2017 at 12:50:31PM +0300, Amir Goldstein wrote:
> To complete the picture for folks not cc'ed on my patches,
> xfs use case suggests there is also justification for the additional helpers:
> 
> uuid_is_null() / uuid_equal()
> guid_is_null() / guid_equal()

The is_null is useful and I bet we'll find other instances.  I'm
not sure _equals really adds much value over the existing _cmp
helpers, but on the other hand they are so trivial that we might as
well add them.

The other thing XFS has is uuid_copy.
