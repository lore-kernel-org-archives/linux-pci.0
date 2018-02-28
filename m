Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci-iov: Add support for unmanaged SR-IOV
To: Alexander Duyck <alexander.duyck@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
 <20180227144015.228d4f5c@w520.home>
 <CAKgT0Ucq8vF9Kxx31QMG=OUwRr61vurHCPw5NCjxPhR_2JM5MQ@mail.gmail.com>
 <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
From: Gregory Rose <gvrose8192@gmail.com>
Message-ID: <ace79c7b-cdc7-5ebb-0175-bfa5e48eb175@gmail.com>
Date: Wed, 28 Feb 2018 14:45:07 -0800
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/28/2018 9:49 AM, Alexander Duyck wrote:
> On Tue, Feb 27, 2018 at 2:25 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> On Tue, Feb 27, 2018 at 1:40 PM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>>> On Tue, 27 Feb 2018 11:06:54 -0800
>>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>>
>>>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>>>
>>>> This patch is meant to add support for SR-IOV on devices when the VFs are
>>>> not managed by the kernel. Examples of recent patches attempting to do this
>>>> include:
>>> It appears to enable sriov when the _pf_ is not managed by the
>>> kernel, but by "managed" we mean that either there is no pf driver or
>>> the pf driver doesn't provide an sriov_configure callback,
>>> intentionally or otherwise.
>>>
>>>> virto - https://patchwork.kernel.org/patch/10241225/
>>>> pci-stub - https://patchwork.kernel.org/patch/10109935/
>>>> vfio - https://patchwork.kernel.org/patch/10103353/
>>>> uio - https://patchwork.kernel.org/patch/9974031/
>>> So is the goal to get around the issues with enabling sriov on each of
>>> the above drivers by doing it under the covers or are you really just
>>> trying to enable sriov for a truly unmanage (no pf driver) case?  For
>>> example, should a driver explicitly not wanting sriov enabled implement
>>> a dummy sriov_configure function?
>>>
>>>> Since this is quickly blowing up into a multi-driver problem it is probably
>>>> best to implement this solution in one spot.
>>>>
>>>> This patch is an attempt to do that. What we do with this patch is provide
>>>> a generic call to enable SR-IOV in the case that the PF driver is either
>>>> not present, or the PF driver doesn't support configuring SR-IOV.
>>>>
>>>> A new sysfs value called sriov_unmanaged_autoprobe has been added. This
>>>> value is used as the drivers_autoprobe setting of the VFs when they are
>>>> being managed by an external entity such as userspace or device firmware
>>>> instead of being managed by the kernel.
>>> Documentation/ABI/testing/sysfs-bus-pci update is missing.
>> I can make sure to update that in the next version.
>>
>>>> One side effect of this change is that the sriov_drivers_autoprobe and
>>>> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV is
>>>> disabled. Attempts to update them when SR-IOV is in use will only update
>>>> the local value and will not update sriov->autoprobe.
>>> And we expect users to understand when sriov_drivers_autoprobe applies
>>> vs sriov_unmanaged_autoprobe, even though they're using the same
>>> interfaces to enable sriov?  Are all combinations expected to work, ex.
>>> unmanaged sriov is enabled, a native pf driver loads, vfs work?  Not
>>> only does it seems like there's opportunity to use this incorrectly, I
>>> think maybe it might be difficult to use correctly.
>>>
>>>> I based my patch set originally on the patch by Mark Rustad but there isn't
>>>> much left after going through and cleaning out the bits that were no longer
>>>> needed, and after incorporating the feedback from David Miller.
>>>>
>>>> I have included the authors of the original 4 patches above in the Cc here.
>>>> My hope is to get feedback and/or review on if this works for their use
>>>> cases.
>>>>
>>>> Cc: Mark Rustad <mark.d.rustad@intel.com>
>>>> Cc: Maximilian Heyne <mheyne@amazon.de>
>>>> Cc: Liang-Min Wang <liang-min.wang@intel.com>
>>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>>> ---
>>>>   drivers/pci/iov.c        |   27 +++++++++++++++++++-
>>>>   drivers/pci/pci-driver.c |    2 +
>>>>   drivers/pci/pci-sysfs.c  |   62 +++++++++++++++++++++++++++++++++++++++++-----
>>>>   drivers/pci/pci.h        |    4 ++-
>>>>   include/linux/pci.h      |    1 +
>>>>   5 files changed, 86 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>> index 677924ae0350..7b8858bd8d03 100644
>>>> --- a/drivers/pci/iov.c
>>>> +++ b/drivers/pci/iov.c
>>>> @@ -446,6 +446,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>>>>        pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
>>>>        iov->pgsz = pgsz;
>>>>        iov->self = dev;
>>>> +     iov->autoprobe = true;
>>>>        iov->drivers_autoprobe = true;
>>>>        pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
>>>>        pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
>>>> @@ -643,8 +644,11 @@ void pci_restore_iov_state(struct pci_dev *dev)
>>>>    */
>>>>   void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
>>>>   {
>>>> -     if (dev->is_physfn)
>>>> +     if (dev->is_physfn) {
>>>>                dev->sriov->drivers_autoprobe = auto_probe;
>>>> +             if (!dev->sriov->num_VFs)
>>>> +                     dev->sriov->autoprobe = auto_probe;
>>> Why is dev->sriov->autoprobe set any time other than immediately prior
>>> to enabling VFs?
>> My concern here was drivers that are still floating around with the
>> old module parameter option for enabling SR-IOV. In the unlikely event
>> that somebody was to use such a driver I wanted to make certain that
>> the drivers_autoprobe state was pre-populated.
>>
>>>> +     }
>>>>   }
>>>>
>>>>   /**
>>>> @@ -703,6 +707,27 @@ void pci_disable_sriov(struct pci_dev *dev)
>>>>   EXPORT_SYMBOL_GPL(pci_disable_sriov);
>>>>
>>>>   /**
>>>> + * pci_sriov_configure_unmanaged - helper to configure unmanaged SR-IOV
>>>> + * @dev: the PCI device
>>>> + * @nr_virtfn: number of virtual functions to enable, 0 to disable
>>>> + *
>>>> + * Used to provide generic enable/disable SR-IOV option for devices
>>>> + * that do not manage the VFs generated by their driver, or have no
>>>> + * driver present.
>>>> + */
>>>> +int pci_sriov_configure_unmanaged(struct pci_dev *dev, int nr_virtfn)
>>>> +{
>>>> +     int rc = 0;
>>>> +
>>>> +     if (!nr_virtfn)
>>>> +             pci_disable_sriov(dev);
>>>> +     else
>>>> +             rc = pci_enable_sriov(dev, nr_virtfn);
>>>> +
>>>> +     return rc ? rc : nr_virtfn;
>>>> +}
>>>> +
>>>> +/**
>>>>    * pci_num_vf - return number of VFs associated with a PF device_release_driver
>>>>    * @dev: the PCI device
>>>>    *
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 3bed6beda051..2cc68dff6130 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -398,7 +398,7 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
>>>>   #ifdef CONFIG_PCI_IOV
>>>>   static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>>>   {
>>>> -     return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
>>>> +     return (!pdev->is_virtfn || pdev->physfn->sriov->autoprobe);
>>>>   }
>>>>   #else
>>>>   static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>> index eb6bee8724cc..e701b6dbc267 100644
>>>> --- a/drivers/pci/pci-sysfs.c
>>>> +++ b/drivers/pci/pci-sysfs.c
>>>> @@ -605,6 +605,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>>>>                                  struct device_attribute *attr,
>>>>                                  const char *buf, size_t count)
>>>>   {
>>>> +     int (*sriov_configure)(struct pci_dev *dev, int num_vfs);
>>>>        struct pci_dev *pdev = to_pci_dev(dev);
>>>>        int ret;
>>>>        u16 num_vfs;
>>>> @@ -622,15 +623,20 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>>>>                goto exit;
>>>>
>>>>        /* is PF driver loaded w/callback */
>>>> -     if (!pdev->driver || !pdev->driver->sriov_configure) {
>>>> -             pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
>>>> -             ret = -ENOENT;
>>>> -             goto exit;
>>>> -     }
>>>> +     if (pdev->driver && pdev->driver->sriov_configure)
>>>> +             sriov_configure = pdev->driver->sriov_configure;
>>>> +     else
>>>> +             sriov_configure = pci_sriov_configure_unmanaged;
>>> So an unwitting user is now able to enable vfs, independent of the
>>> pf... the trouble being that they're probably going to expect them to
>>> work and the more common case is that they won't.  For instance, what
>>> can you do with an igbvf when igb isn't managing the pf?
>> Well the VFs wouldn't be able to do anything. Basically they would be
>> sitting there with no driver loaded on them unless they are assigned
>> to a guest, or the root user had enabled the unmanaged option. If you
>> did load a driver on it the VF would sit there with link down unless
>> either the PF driver is loaded or some user-space entity steps in to
>> start managing the PF.
>>
>> In reality this can already happen as last I recall igb and ixgbe were
>> already capable of having the PF driver removed when SR-IOV was
>> enabled and VFs were assigned. Basically the VFs just report link down
>> and don't do anything. Reloading the PF driver would have it take over
>> in the case of igb and ixgbe since they were designed to handle that
>> type of scenario.
>>
>>> Or what happens when vfio-pci owns the pf, sriov is enabled via the
>>> unmanaged interface, and the pf user driver segfaults and gets killed,
>>> causing vfio-pci to restore the pf state, including wiping the sriov
>>> config?
>> Wiping the config shouldn't have any effect on the allocated VF pci
>> devices. It will cause the VFs to act as though they have fallen off
>> of the bus though and the guests would see a surprise remove type
>> behavior if I am not mistaken. The MMIO and config accesses would fail
>> until the SR-IOV configuration is restored. Really this shouldn't be a
>> problem as long as the SR-IOV is enabled prior to loading the vfio-pci
>> driver as I would assume it would restore the state an re-enable
>> SR-IOV.
>>
>> In the grand scheme of things how would the situation you describe be
>> any different than someone using the "reset" sysfs control on the PF
>> while using SR-IOV with driver supported SR-IOV?
>>
>> I suppose if you really wanted we could add a new call that you could
>> put into the sriov_configure pointer that would just make it always
>> return error. Then that way the configuration could be locked until
>> the driver is unloaded.
>>
>>> I guess I don't understand how vfs can operate fully independent of the
>>> pf and why vfio-pci wouldn't just implement a dummy sriov_configure to
>>> avoid contending with such issues.
>> This approach isn't without risk, but it isn't as if it is really a
>> new risk we are introducing, and we could do further work to help
>> smooth out issues like this. Much of this depends on the design of the
>> device and the drivers involved. What is happening in this case is
>> that the VFs are managed outside of the kernel itself either by some
>> user-space entity or by a firmware entity.
> So I was thinking about this some more. In the case of vfio-pci things
> are a bit different since you are essentially taking a given device
> and handing it to a VM or userspace and it doesn't guarantee a
> communication between the two.
>
> My thought is to look at making SR-IOV configuration static or treat
> it as read-only when the vfio-pci driver is loaded on a given
> interface. In addition I would set the TAINT_USER flag and add a
> warning about loading vfio-pci on an active PF, and provide the number
> of VFs that were allocated.
>
> The idea with all of this being that we would at least have a partial
> lock on all of this so that you can allocate some number of VFs, and
> then start partitioning things up where you could assign the PF and
> VFs as needed to the various interfaces. Once the PF is assigned to
> the vfio-pci driver it would be locked in terms of the number of VFs
> that are provided so there would be no need for an extra communication
> channel between the PF driver and the host to deal with changes.
>
> Thoughts?

I've been following this conversation and I think putting in some 
restrictions in order to simplify the design
is definitely worth considering.  I think there's a lot of potential for 
this but KISS still applies.

Thanks for the work on this!

- Greg
