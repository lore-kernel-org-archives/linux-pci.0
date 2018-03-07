Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180307064612.GA10926@infradead.org>
References: <20180306192423.3153.42741.stgit@localhost.localdomain> <20180307064612.GA10926@infradead.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Mar 2018 11:05:58 -0800
Message-ID: <CAKgT0UdRFxGUPu4jY0xrUuv8Um62ndPnknhHXuF4Abu6D7GEqg@mail.gmail.com>
Subject: Re: [pci PATCH v3 0/3] Add support for unmanaged SR-IOV
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2018 at 10:46 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Mar 06, 2018 at 11:29:08AM -0800, Alexander Duyck wrote:
>> This series is meant to add support for SR-IOV on devices when the VFs are
>> not managed by the kernel. Examples of recent patches attempting to do this
>> include:
>> virto - https://patchwork.kernel.org/patch/10241225/
>> pci-stub - https://patchwork.kernel.org/patch/10109935/
>> vfio - https://patchwork.kernel.org/patch/10103353/
>> uio - https://patchwork.kernel.org/patch/9974031/
>
> nvme and ema seems to be existing examples.  Care to throw in
> conversions while you're at it?

Yeah, I can do that. I assume you meant "ena" not "ema".

I'm probably looking at doing a v4 that will drop the vfio userspace
driver bits for now as it sounds like there are additional issues that
still need to be addressed.

Thanks.

- Alex
