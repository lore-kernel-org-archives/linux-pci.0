Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 21 Apr 2018 09:05:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        "Daly, Dan" <dan.daly@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
        Don Dutile <ddutile@redhat.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Subject: Re: [virtio-dev] [pci PATCH v7 2/5] virtio_pci: Add support for
        unmanaged SR-IOV on virtio_pci devices
Message-ID: <20180421070516.GA24431@lst.de>
References: <20180315184132.3102.90947.stgit@localhost.localdomain> <20180316183042-mutt-send-email-mst@kernel.org> <CAKgT0UfgZ2gAdiAbCe4MTOr3o9cqq1q-mykCQsw68p2F-QEC8g@mail.gmail.com> <20180403161151-mutt-send-email-mst@kernel.org> <CAKgT0UfeSmG=xsd6sTkg4cOMnZ0QiqtCRDt4PynpF3d6nvvFCA@mail.gmail.com> <20180403212503-mutt-send-email-mst@kernel.org> <CAKgT0Ude79FYrK4qA0OKRJ1NackyqPi-hZ8Zh3WSdLDFxoOosQ@mail.gmail.com> <20180420030640-mutt-send-email-mst@kernel.org> <CAKgT0Ucpw9D1u8MYoEX5KOij6sxs-5O9gPFTmOVq=Dgt=HUJ=g@mail.gmail.com> <20180420180839-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420180839-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 20, 2018 at 06:28:50PM +0300, Michael S. Tsirkin wrote:
> But maybe it's not needed here.  I am not making the decisions myself.
> Not too late: post to the TC list and let's see what the response is.
> Without a feature bit you are making a change affecting all future
> implementations without exception so the bar is a bit higher: you need
> to actually post a spec text proposal not just a patch showing how to
> use the feature, and TC needs to vote on it. Voting takes a week,
> review a week or two depending on change complexity.

Also IFF the hardware already is out we can quirk it in the PCI ID
table to manually set the feature in the driver as a workaround.
