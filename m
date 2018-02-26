Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V4] pci: virtio_pci: Add SR-IOV support for
 virtio_pci devices
Date: Mon, 26 Feb 2018 17:48:15 +0000
Message-ID: <E8D91EBA-F75D-4FF9-BDE8-FCE3A4B4B007@intel.com>
References: <20180226044837.19543.12267.stgit@mdrustad-mac04.local>
 <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
In-Reply-To: <CAKgT0UcMth9Jxovoj7xo0q2t+MuY0K1Upf+Mqs3zgXdriui-tA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex,

> On Feb 26, 2018, at 7:26 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> Mark,
> 
> In the future please don't put my "Reviewed-by" on a patch that I
> haven't reviewed. I believe I reviewed one of the earlier patches, but
> I hadn't reviewed this version.

I'm very sorry. I completely spaced doing something about that. I think yours was the first Reviewed-by I ever had in this way. In the future I will remove such things from my changelog right after sending. Thanks for alerting me to what I had failed to do.

> Also, after thinking about it over the weekend we may want to look at
> just coming up with a truly "generic" solution that is applied to
> SR-IOV capable devices that don't have a SR-IOV capable driver loaded
> on them. That would allow us to handle the uio, vfio, pci-stub, and
> virtio cases all in one fell swoop. I think us going though and
> modifying one patch at a time to do this kind of thing isn't going to
> scale.

The notion of that kind of troubles me - at least pci-stub does. Having worked on ixgbe a bit, I have to wonder what kind of havoc would ensue if an ixgbe device were assigned to a guest, and an attempt was made to allocate VFs by the pci-stub. The guest could be running any version of the ixgbe driver, possibly even an old one that didn't support SR-IOV. Even if it did support SR-IOV, I don't know how it would respond to mailbox messages when it doesn't think it has VFs.

> I'll try to do some digging and find the VFIO approach we had been
> working on. I think with a couple tweaks we can probably make that
> truly generic and ready for submission.

I'd like to know more about you are thinking about.

-- 
Mark Rustad, Networking Division, Intel Corporation
