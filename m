Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753359AbeE3RPp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:15:45 -0400
Date: Wed, 30 May 2018 20:15:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Cc: "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Message-ID: <20180530201034-mutt-send-email-mst@kernel.org>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
 <CAKgT0UcRZd5ajpTyC3KMvNFACVAb6D8A9Tss3m0r+UdamvVeRA@mail.gmail.com>
 <20180530192215-mutt-send-email-mst@kernel.org>
 <1527697588.16245.136.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527697588.16245.136.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 04:26:30PM +0000, Duyck, Alexander H wrote:
> On Wed, 2018-05-30 at 19:22 +0300, Michael S. Tsirkin wrote:
> > On Wed, May 30, 2018 at 09:10:57AM -0700, Alexander Duyck wrote:
> > > On Wed, May 30, 2018 at 1:55 AM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > > > There is a new feature bit allocated in virtio spec to
> > > > support SR-IOV (Single Root I/O Virtualization):
> > > > 
> > > > https://github.com/oasis-tcs/virtio-spec/issues/11
> > > > 
> > > > This patch enables the support for this feature bit in
> > > > virtio driver.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > 
> > > So from a quick glance it looks like we are leaving SR-IOV enabled if
> > > the driver is removed. Do we want to have that behavior or should we
> > > be adding the code to disable SR-IOV and free the VFs on driver
> > > removal?
> > 
> > Could pci core handle it for us somehow?
> 
> Maybe, but it would require changes to the pci core to do it.
> 
> The problem is some drivers want to leave the VFs there since the PF
> doesn't really do anything, or they have the option of essentially
> putting the VFs into a standby state when the PF is gone.
> 
> My main concern is do we care if VFs are allocated and then somebody
> removes the driver and binds a different driver to the interface? If
> not then this code and be left as is, but I just wanted to be certain
> since I know this isn't just enabling SR-IOV we are having to do a
> number of other checks against the virtio device.

Well the spec says features have to be negotiated, and since we reset
the device when we unbind from it I think it's a given we should keep a
driver bound to the PF.

IOW until we are sure we need the capability to keep it enabled, let's
disable it to be safe.

-- 
MST
