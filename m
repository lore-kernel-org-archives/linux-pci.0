Return-Path: <SRS0=ua9z=JO=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=ua9z=JO=netronome.com=jakub.kicinski@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180628135623.GE90450@bhelgaas-glaptop.roam.corp.google.com>
References: <20180618220142.16527-1-jakub.kicinski@netronome.com>
 <20180626094002.7bf0ca16@cakuba.netronome.com> <20180628135623.GE90450@bhelgaas-glaptop.roam.corp.google.com>
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 28 Jun 2018 09:17:09 -0700
Message-ID: <CAJpBn1weH828hgog5ZeBC+tAsWC54qoTtC2eLf6iF=+Gx0kmtw@mail.gmail.com>
Subject: Re: [PATCH] PCI: reset driver SR-IOV state after remove
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>, oss-drivers@netronome.com,
	Christoph Hellwig <hch@infradead.org>, Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 28, 2018 at 6:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 09:40:02AM -0700, Jakub Kicinski wrote:
>> On Mon, 18 Jun 2018 15:01:42 -0700, Jakub Kicinski wrote:
>> > Bjorn points out that currently core and most of the drivers don't
>> > clean up dev->sriov->driver_max_VFs settings on .remove().  This
>> > means that if a different driver is bound afterwards it will
>> > inherit the old setting:
>> >
>> >   - load PF driver 1
>> >   - driver 1 calls pci_sriov_set_totalvfs() to reduce driver_max_VFs
>> >   - unload PF driver 1
>> >   - load PF driver 2
>> >   # driver 2 does not know to call pci_sriov_set_totalvfs()
>> >
>> > Some drivers (e.g. nfp) used to do the clean up by calling
>> > pci_sriov_set_totalvfs(dev, 0), since 0 was equivalent to no driver
>> > limit set.  After commit 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers
>> > to limit total_VFs to 0") 0 no longer has this special meaning.
>> >
>> > The need to reset driver_max_VFs comes from the fact that old FW
>> > builds may not expose its VF limits to the drivers, and depend on
>> > the ability to reject the configuration change when driver notifies
>> > the FW as part of struct pci_driver->sriov_configure() callback.
>> > Therefore if there is no information on VF count limits we should
>> > use the PCI capability max, and not the last value set by
>> > pci_sriov_set_totalvfs().
>> >
>> > Reset driver_max_VFs back to total_VFs after device remove.  If
>> > drivers want to reload FW/reconfigure the device while driver is
>> > bound we may add an explicit pci_sriov_reset_totalvfs(), but for
>> > now no driver is doing that.
>> >
>> > Fixes: 8d85a7a4f2c9 ("PCI/IOV: Allow PF drivers to limit total_VFs to 0")
>> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>>
>> Any comments? :(  Could this still make it into 4.18?
>
> Is this a fix for something we broke during the v4.18 merge window?
> Or does it fix something that's been broken for a long time?  I think
> the latter, but haven't looked carefully yet.

This is half of a fix, really.  NFP driver does
pci_sriov_set_totalvfs(pdev, 0) to clear the limit.  Now it will
disable SR-IOV completely.  If this patch gets applied I will drop
those pci_sriov_set_totalvfs(pdev, 0) calls from the driver and the
regression will be solved.

>> >  drivers/pci/iov.c        | 16 ++++++++++++++++
>> >  drivers/pci/pci-driver.c |  1 +
>> >  drivers/pci/pci.h        |  4 ++++
>> >  3 files changed, 21 insertions(+)
>> >
>> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> > index d0d73dbbd5ca..cbbe6d8fab0c 100644
>> > --- a/drivers/pci/iov.c
>> > +++ b/drivers/pci/iov.c
>> > @@ -574,6 +574,22 @@ void pci_iov_release(struct pci_dev *dev)
>> >             sriov_release(dev);
>> >  }
>> >
>> > +/**
>> > + * pci_iov_device_removed - clean up SR-IOV state after PF driver is detached
>> > + * @dev: the PCI device
>> > + */
>> > +void pci_iov_device_removed(struct pci_dev *dev)
>> > +{
>> > +   struct pci_sriov *iov = dev->sriov;
>> > +
>> > +   if (!dev->is_physfn)
>> > +           return;
>> > +   iov->driver_max_VFs = iov->total_VFs;
>> > +   if (iov->num_VFs)
>> > +           dev_warn(&dev->dev,
>> > +                    "driver left SR-IOV enabled after remove\n");
>> > +}
>> > +
>> >  /**
>> >   * pci_iov_update_resource - update a VF BAR
>> >   * @dev: the PCI device
>> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> > index c125d53033c6..80a281cf5d21 100644
>> > --- a/drivers/pci/pci-driver.c
>> > +++ b/drivers/pci/pci-driver.c
>> > @@ -445,6 +445,7 @@ static int pci_device_remove(struct device *dev)
>> >             }
>> >             pcibios_free_irq(pci_dev);
>> >             pci_dev->driver = NULL;
>> > +           pci_iov_device_removed(pci_dev);
>> >     }
>> >
>> >     /* Undo the runtime PM settings in local_pci_probe() */
>> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> > index c358e7a07f3f..fc8bd4fdfb95 100644
>> > --- a/drivers/pci/pci.h
>> > +++ b/drivers/pci/pci.h
>> > @@ -311,6 +311,7 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
>> >  #ifdef CONFIG_PCI_IOV
>> >  int pci_iov_init(struct pci_dev *dev);
>> >  void pci_iov_release(struct pci_dev *dev);
>> > +void pci_iov_device_removed(struct pci_dev *dev);
>> >  void pci_iov_update_resource(struct pci_dev *dev, int resno);
>> >  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>> >  void pci_restore_iov_state(struct pci_dev *dev);
>> > @@ -323,6 +324,9 @@ static inline int pci_iov_init(struct pci_dev *dev)
>> >  }
>> >  static inline void pci_iov_release(struct pci_dev *dev)
>> >
>> > +{
>> > +}
>> > +static inline void pci_iov_device_removed(struct pci_dev *dev)
>> >  {
>> >  }
>> >  static inline void pci_restore_iov_state(struct pci_dev *dev)
>>
