Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Use pci_enable_msix_exact() instead of pci_enable_msix()
In-Reply-To: <20140222211824.GA9777@redhat.com>
References: <1392804931-30671-9-git-send-email-agordeev@redhat.com> <87eh2yblsk.fsf@rustcorp.com.au> <20140221165946.GJ17353@dhcp-26-207.brq.redhat.com> <20140221170128.GK17353@dhcp-26-207.brq.redhat.com> <20140222211824.GA9777@redhat.com>
Date: Mon, 24 Feb 2014 12:13:45 +1030
Message-ID: <87ppmd70a6.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Fri, Feb 21, 2014 at 06:01:28PM +0100, Alexander Gordeev wrote:
>> As result of deprecation of MSI-X/MSI enablement functions
>> pci_enable_msix() and pci_enable_msi_block() all drivers
>> using these two interfaces need to be updated to use the
>> new pci_enable_msi_range()  or pci_enable_msi_exact()
>> and pci_enable_msix_range() or pci_enable_msix_exact()
>> interfaces.
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, applied.

Cheers,
Rusty.
