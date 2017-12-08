Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbdLHXfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 18:35:00 -0500
Date: Fri, 8 Dec 2017 16:34:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Liang-Min Wang <liang-min.wang@intel.com>, kvm@vger.kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Subject: Re: [PATCH v2] Enable SR-IOV instantiation through /sys file
Message-ID: <20171208163459.00fc5b20@t450s.home>
In-Reply-To: <CAKgT0Ue=Wa-gamGoJFnHigqh+g4L9BRFE7c4RtG5nug-4HtZSA@mail.gmail.com>
References: <20171208214758.6959-1-jeffrey.t.kirsher@intel.com>
        <20171208155802.4d1159c5@t450s.home>
        <CAKgT0Ue=Wa-gamGoJFnHigqh+g4L9BRFE7c4RtG5nug-4HtZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 8 Dec 2017 15:19:18 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Fri, Dec 8, 2017 at 2:58 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Fri,  8 Dec 2017 13:47:58 -0800
> > Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> >  
> >> From: Liang-Min Wang <liang-min.wang@intel.com>
> >>
> >> When a SR-IOV capable device is bound with vfio-pci, the
> >> device loses capability of creating SR-IOV instances through /sy/bus/
> >> pci/devices/.../sriov_numvfs. This patch re-activates this capability
> >> for a PCIe device that is SR-IOV capable and is bound with vfio-pci.ko.
> >> This patch also disables drivers_autoprobe attribute of SR-IOV devices
> >> created from vfio-pci bound device by default, so user-space PF device
> >> can coordinate the bring-up of SR-IOV devices
> >>
> >> Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> >> ---
> >>  drivers/pci/pci-driver.c    | 12 ++++++++++++
> >>  drivers/vfio/pci/vfio_pci.c | 22 ++++++++++++++++++++++
> >>  include/linux/pci.h         |  1 +
> >>  3 files changed, 35 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 7f47bb7..19522fe 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -1467,6 +1467,18 @@ void pci_dev_put(struct pci_dev *dev)
> >>  }
> >>  EXPORT_SYMBOL(pci_dev_put);
> >>
> >> +/**
> >> + * pci_dev_sriov_autoprobe_set - set device sriov driver autoprobe
> >> + * @dev: device with which sriov autoprobe will be set
> >> + *
> >> + */
> >> +void pci_dev_sriov_autoprobe_set(struct pci_dev *dev, bool autoprobe)
> >> +{
> >> +     if (dev && dev->sriov)
> >> +             dev->sriov->drivers_autoprobe = autoprobe;
> >> +}
> >> +EXPORT_SYMBOL(pci_dev_sriov_autoprobe_set);  
> >
> > _GPL?
> >
> > It'd also be best to separate the pci and vfio changes into different
> > patches.  Bjorn would need to at least ack this PCI interface.
> >  
> >> +
> >>  static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>  {
> >>       struct pci_dev *pdev;
> >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >> index f041b1a..004836c 100644
> >> --- a/drivers/vfio/pci/vfio_pci.c
> >> +++ b/drivers/vfio/pci/vfio_pci.c
> >> @@ -1213,6 +1213,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>               return -ENOMEM;
> >>       }
> >>
> >> +     /* disable sriov automatic driver attachment */
> >> +     pci_dev_sriov_autoprobe_set(pdev, false);  
> >
> > This looks stateful, VF autoprobe is not restored on release.  Also,
> > how would we know the initial state to restore it to?  
> 
> The initial state is whatever the user set it to. It is something that
> can be toggled on and off via sysfs, and it defaults to true at
> initialization. In this case we are opting to toggle it off when VFIO
> is attached to the device. Restoring it after unloading the driver
> might be even more confusing since it is something the user could
> toggle at any time so a restore would end up overwriting that.

I'm not really willing to sign up for the inevitable bug reports when
users can't figure out how to make their VFs work again in the host
after they've used the PF for userspace drivers with vfio-pci.  I
agree, both options are confusing, how do we make it not confusing?
Can PCI core reset the autoprobe attribute to the default at some
obvious point?  Thanks,

Alex
