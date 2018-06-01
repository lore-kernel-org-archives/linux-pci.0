Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64187 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeFAD7y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 23:59:54 -0400
Date: Fri, 1 Jun 2018 12:00:07 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com
Cc: bhelgaas@google.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        linux-pci@vger.kernel.org, dan.daly@intel.com,
        mark.d.rustad@intel.com, alexander.h.duyck@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH v2] virtio_pci: support enabling VFs
Message-ID: <20180601040007.GA32070@debian>
References: <20180601020921.30957-1-tiwei.bie@intel.com>
 <20180601063224-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180601063224-mutt-send-email-mst@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 01, 2018 at 06:47:01AM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 01, 2018 at 10:09:21AM +0800, Tiwei Bie wrote:
> > There is a new feature bit allocated in virtio spec to
> > support SR-IOV (Single Root I/O Virtualization):
> > 
> > https://github.com/oasis-tcs/virtio-spec/issues/11
> > 
> > This patch enables the support for this feature bit in
> > virtio driver.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> Generally you aren't supposed to carry forward acks
> when you make major changes.

Got it! Thank you very much!

> 
> In this case I'm fine with the patch, so never mind.

Thank you so much! Anyway, it's my fault.
I'll send a new version dropping all acks.

> 
[...]
> >  
> > +static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
> > +{
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > +	struct virtio_device *vdev = &vp_dev->vdev;
> > +	int ret;
> > +
> > +	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +		return -EBUSY;
> > +
> > +	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
> > +		return -EINVAL;
> > +
> > +	if (pci_vfs_assigned(pci_dev))
> > +		return -EPERM;
> 
> Not a comment on this patch - existing code has the
> same race - but generally
> 
> 1. this seems racy since assigning vfs does not seem
>    to take device lock
> 2. does this work correctly for kvm at all?
>    pci_set_dev_assigned seems to be only called by xen.
> 
> Can you look at addressing this pls?

Sure! I'll do it!

Best regards,
Tiwei Bie
