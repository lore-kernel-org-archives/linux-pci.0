Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180315183449.3102.64791.stgit@localhost.localdomain>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 19 Apr 2018 15:54:49 -0700
Message-ID: <CAKgT0UdTANRo3xnr89aWdfSPmMg81-W2H-ZcJUdC=5nUkf9RAw@mail.gmail.com>
Subject: Re: [pci PATCH v7 0/5] Add support for unmanaged SR-IOV
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
        Don Dutile <ddutile@redhat.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>, dwmw@amazon.co.uk,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:40 AM, Alexander Duyck
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
> v6: Defined pci_sriov_configure_simple as NULL when SR-IOV is not enabled
>     Updated drivers to drop "#ifdef" checks for IOV
>     Added pci-pf-stub as place for PF-only drivers to add support
> v7: Dropped pci_id table explanation from pci-pf-stub driver
>     Updated pci_sriov_configure_simple to drop need for err value
>     Fixed comment explaining why pci_sriov_configure_simple is NULL
>

Just following up since this has been sitting in patchwork for just
over a month now
(https://patchwork.ozlabs.org/project/linux-pci/list/?series=34034).
I'm just wondering what the expectation is on getting these pulled
into the pci tree? I'm assuming that is the best place for these
patches. Are there any concerns I still need to address or are these
going to be pulled in at some point, and if so is there any ETA on
when that will be?

Thanks.

- Alex
