Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Mar 2018 10:25:52 -0700
Message-ID: <CAKgT0Uc3xzQn5-0xw4y=2SixZpucaevAodM3NLUOn4W06UbQ3Q@mail.gmail.com>
Subject: Re: [pci PATCH v5 0/4] Add support for unmanaged SR-IOV (was: Series
 short description)
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        netanel@amazon.com, Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:20 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> This series is meant to add support for SR-IOV on devices when the VFs are
> not managed by the kernel. Examples of recent patches attempting to do this
> include:
> virto - https://patchwork.kernel.org/patch/10241225/
> pci-stub - https://patchwork.kernel.org/patch/10109935/
> vfio - https://patchwork.kernel.org/patch/10103353/
> uio - https://patchwork.kernel.org/patch/9974031/
>
> Since this is quickly blowing up into a multi-driver problem it is probably
> best to implement this solution as generically as possible.
>
> This series is an attempt to do that. What we do with this patch set is
> provide a generic framework to enable SR-IOV in the case that the PF driver
> doesn't support managing the VFs itself.
>
> I based my patch set originally on the patch by Mark Rustad but there isn't
> much left after going through and cleaning out the bits that were no longer
> needed, and after incorporating the feedback from David Miller. At this point
> the only items to be fully reused was his patch description which is now
> present in patch 3 of the set.
>
> This solution is limited in scope to just adding support for devices that
> provide no functionality for SR-IOV other than allocating the VFs by
> calling pci_enable_sriov. Previous sets had included patches for VFIO, but
> for now I am dropping that as the scope of that work is larger then I
> think I can take on at this time.
>
> v2: Reduced scope back to just virtio_pci and vfio-pci
>     Broke into 3 patch set from single patch
>     Changed autoprobe behavior to always set when num_vfs is set non-zero
> v3: Updated Documentation to clarify when sriov_unmanaged_autoprobe is used
>     Wrapped vfio_pci_sriov_configure to fix build errors w/o SR-IOV in kernel
> v4: Dropped vfio-pci patch
>     Added ena and nvme to drivers now using pci_sriov_configure_unmanaged
>     Dropped pci_disable_sriov call in virtio_pci to be consistent with ena
> v5: Dropped sriov_unmanaged_autoprobe and pci_sriov_conifgure_unmanaged
>     Added new patch that enables pci_sriov_configure_simple
>     Updated drivers to use pci_sriov_configure_simple
>
> Cc: Mark Rustad <mark.d.rustad@intel.com>
> Cc: Maximilian Heyne <mheyne@amazon.de>
> Cc: Liang-Min Wang <liang-min.wang@intel.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>

Ugh. Just realized I forgot to post the correct subject line in the cover page.

I needed I can resubmit the series, will just leave it for now in case
there are any other review comments.

Thanks.

- Alex
