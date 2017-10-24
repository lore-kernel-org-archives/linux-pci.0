Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdJXVtQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 17:49:16 -0400
From: "Wang, Liang-min" <liang-min.wang@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: RE: [PATCH] Enable SR-IOV instantiation through /sys file
Date: Tue, 24 Oct 2017 21:49:15 +0000
Message-ID: <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
 <20171024234351.0af0ff4a@t450s.home>
In-Reply-To: <20171024234351.0af0ff4a@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just like any PCIe devices that supports SR-IOV. There are restrictions set for VF. Also, there is a concept of trust VF now available for PF to manage certain features that only selected VF could exercise. Are you saying all the devices supporting SR-IOV all have security issue?

Larry

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, October 24, 2017 5:44 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Wang, Liang-min <liang-min.wang@intel.com>; kvm@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Duyck, Alexander H <alexander.h.duyck@intel.com>
> Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
> 
> On Tue, 24 Oct 2017 13:04:26 -0700
> Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> 
> > From: Liang-Min Wang <liang-min.wang@intel.com>
> >
> > When a SR-IOV supported device is bound with vfio-pci, the driver
> > could not create SR-IOV instance through /sys/bus/pci/devices/...
> > /sriov_numvfs. This patch re-activates this capability for a PCIe
> > device that supports SR-IOV and is bound with vfio-pci.ko.
> >
> > Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> 
> Why?  The PF bound to vfio-pci can be assigned to a user.  PFs often
> have backdoors into the VF.  Therefore this enables creation of a VF in
> the host that may be snooped or manipulated by a user.  This clearly
> seems like a security issue.  Thanks,
> 
> Alex
> 
> 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index f041b1a6cf66..8fbd362607e1 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1256,6 +1256,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
> >  	if (!vdev)
> >  		return;
> >
> > +	pci_disable_sriov(pdev);
> >  	vfio_iommu_group_put(pdev->dev.iommu_group, &pdev->dev);
> >  	kfree(vdev->region);
> >  	kfree(vdev);
> > @@ -1303,12 +1304,23 @@ static const struct pci_error_handlers
> vfio_err_handlers = {
> >  	.error_detected = vfio_pci_aer_err_detected,
> >  };
> >
> > +static int vfio_sriov_configure(struct pci_dev *pdev, int num_vfs)
> > +{
> > +	if (!num_vfs) {
> > +		pci_disable_sriov(pdev);
> > +		return 0;
> > +	}
> > +
> > +	return pci_enable_sriov(pdev, num_vfs);
> > +}
> > +
> >  static struct pci_driver vfio_pci_driver = {
> >  	.name		= "vfio-pci",
> >  	.id_table	= NULL, /* only dynamic ids */
> >  	.probe		= vfio_pci_probe,
> >  	.remove		= vfio_pci_remove,
> >  	.err_handler	= &vfio_err_handlers,
> > +	.sriov_configure = vfio_sriov_configure,
> >  };
> >
> >  struct vfio_devices {
