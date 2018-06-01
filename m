Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeFABVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 21:21:04 -0400
Date: Fri, 1 Jun 2018 04:21:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Message-ID: <20180601042004-mutt-send-email-mst@kernel.org>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
 <D7004E41-C23D-48B7-94A4-ACBBA06B021D@intel.com>
 <20180530190819-mutt-send-email-mst@kernel.org>
 <20180531025502.GA15516@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180531025502.GA15516@debian>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 31, 2018 at 10:55:02AM +0800, Tiwei Bie wrote:
> On Wed, May 30, 2018 at 07:09:37PM +0300, Michael S. Tsirkin wrote:
> > On Wed, May 30, 2018 at 04:03:37PM +0000, Rustad, Mark D wrote:
> > > On May 30, 2018, at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > 
> > > > There is a new feature bit allocated in virtio spec to
> > > > support SR-IOV (Single Root I/O Virtualization):
> > > > 
> > > > https://github.com/oasis-tcs/virtio-spec/issues/11
> > > > 
> > > > This patch enables the support for this feature bit in
> > > > virtio driver.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > ---
> > > > This patch depends on below proposal:
> > > > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html
> > > > 
> > > > This patch depends on below patch:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8effc395c2097e258fcedfc02ed4a66d45fb4238
> > > > 
> > > >  drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
> > > >  drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
> > > >  include/uapi/linux/virtio_config.h |  7 ++++++-
> > > >  3 files changed, 40 insertions(+), 1 deletion(-)
> > > > 
> > > 
> > > <snip>
> > > 
> > > > diff --git a/include/uapi/linux/virtio_config.h
> > > > b/include/uapi/linux/virtio_config.h
> > > > index 308e2096291f..b7c1f4e7d59e 100644
> > > > --- a/include/uapi/linux/virtio_config.h
> > > > +++ b/include/uapi/linux/virtio_config.h
> > > > @@ -49,7 +49,7 @@
> > > 
> > > There is a value in the comment directly before this that should
> > > be updated as well to be consistent with the new value for
> > > VIRTIO_TRANSPORT_F_END below.
> > 
> > It hasn't been updated to 34 yet.
> > I suggest a separate patch to replace the numbers with
> > VIRTIO_TRANSPORT_F_START and VIRTIO_TRANSPORT_F_END
> > in the comment.
> > Maybe replace "e.g. virtio_ring" with "e.g. virtio_ring,
> > virtio_pci etc." as well.
> 
> Good idea! Thanks for the suggestion! I'll do it.
> 
> Best regards,
> Tiwei Bie

Or just focus on the new feature, tweak start/end
as a separate patch. Up to you, the important thing
is to have a ready to roll patch before the merge
window.

> 
> > 
> > > >   * transport being used (eg. virtio_ring), the rest are per-device feature
> > > >   * bits. */
> > > >  #define VIRTIO_TRANSPORT_F_START	28
> > > > -#define VIRTIO_TRANSPORT_F_END		34
> > > > +#define VIRTIO_TRANSPORT_F_END		38
> > > > 
> > > >  #ifndef VIRTIO_CONFIG_NO_LEGACY
> > > >  /* Do we get callbacks when the ring is completely used, even if we've
> > > 
> > > <snip>
> > > 
> > > --
> > > Mark Rustad, Networking Division, Intel Corporation
> > 
> > 
