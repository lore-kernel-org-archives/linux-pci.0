Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44024 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeCEVlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Mar 2018 16:41:24 -0500
MIME-Version: 1.0
In-Reply-To: <a4d6447d-b67e-8705-31a2-79bde44c75d1@redhat.com>
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
 <20180227144015.228d4f5c@w520.home> <CAKgT0Ucq8vF9Kxx31QMG=OUwRr61vurHCPw5NCjxPhR_2JM5MQ@mail.gmail.com>
 <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
 <20180228155949.00fde8ae@w520.home> <CAKgT0UeVZUB7h6g=Eqppt-6VP=X4=Ko3=kB_rh_1JanFJXZF9g@mail.gmail.com>
 <20180301132224.1ca06949@w520.home> <a4d6447d-b67e-8705-31a2-79bde44c75d1@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 5 Mar 2018 13:41:22 -0800
Message-ID: <CAKgT0UcMpCcqtYWUonW8D=msqWAmCxPqcobgUchKpF421X_kJA@mail.gmail.com>
Subject: Re: [PATCH] pci-iov: Add support for unmanaged SR-IOV
To: Don Dutile <ddutile@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 5, 2018 at 12:57 PM, Don Dutile <ddutile@redhat.com> wrote:
> On 03/01/2018 03:22 PM, Alex Williamson wrote:
>>
>> On Wed, 28 Feb 2018 16:36:38 -0800
>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>
>>> On Wed, Feb 28, 2018 at 2:59 PM, Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>>>
>>>> On Wed, 28 Feb 2018 09:49:21 -0800
>>>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>>>
>>>>>
>>>>> On Tue, Feb 27, 2018 at 2:25 PM, Alexander Duyck
>>>>> <alexander.duyck@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Feb 27, 2018 at 1:40 PM, Alex Williamson
>>>>>> <alex.williamson@redhat.com> wrote:
>>>>>>>
>>>>>>> On Tue, 27 Feb 2018 11:06:54 -0800
>>>>>>> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>>>>>>
>>>>>>>>
>>>>>>>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>>>>>>>
>>>>>>>> This patch is meant to add support for SR-IOV on devices when the
>>>>>>>> VFs are
>>>>>>>> not managed by the kernel. Examples of recent patches attempting to
>>>>>>>> do this
>>>>>>>> include:
>>>>>>>
>>>>>>>
>>>>>>> It appears to enable sriov when the _pf_ is not managed by the
>>>>>>> kernel, but by "managed" we mean that either there is no pf driver or
>>>>>>> the pf driver doesn't provide an sriov_configure callback,
>>>>>>> intentionally or otherwise.
>>>>>>>
>>>>>>>>
>>>>>>>> virto - https://patchwork.kernel.org/patch/10241225/
>>>>>>>> pci-stub - https://patchwork.kernel.org/patch/10109935/
>>>>>>>> vfio - https://patchwork.kernel.org/patch/10103353/
>>>>>>>> uio - https://patchwork.kernel.org/patch/9974031/
>>>>>>>
>>>>>>>
>>>>>>> So is the goal to get around the issues with enabling sriov on each
>>>>>>> of
>>>>>>> the above drivers by doing it under the covers or are you really just
>>>>>>> trying to enable sriov for a truly unmanage (no pf driver) case?  For
>>>>>>> example, should a driver explicitly not wanting sriov enabled
>>>>>>> implement
>>>>>>> a dummy sriov_configure function?
>>>>>>>
>>>>>>>>
>>>>>>>> Since this is quickly blowing up into a multi-driver problem it is
>>>>>>>> probably
>>>>>>>> best to implement this solution in one spot.
>>>>>>>>
>>>>>>>> This patch is an attempt to do that. What we do with this patch is
>>>>>>>> provide
>>>>>>>> a generic call to enable SR-IOV in the case that the PF driver is
>>>>>>>> either
>>>>>>>> not present, or the PF driver doesn't support configuring SR-IOV.
>>>>>>>>
>>>>>>>> A new sysfs value called sriov_unmanaged_autoprobe has been added.
>>>>>>>> This
>>>>>>>> value is used as the drivers_autoprobe setting of the VFs when they
>>>>>>>> are
>>>>>>>> being managed by an external entity such as userspace or device
>>>>>>>> firmware
>>>>>>>> instead of being managed by the kernel.
>>>>>>>
>>>>>>>
>>>>>>> Documentation/ABI/testing/sysfs-bus-pci update is missing.
>>>>>>
>>>>>>
>>>>>> I can make sure to update that in the next version.
>>>>>>
>>>>>>>>
>>>>>>>> One side effect of this change is that the sriov_drivers_autoprobe
>>>>>>>> and
>>>>>>>> sriov_unmanaged_autoprobe will only apply their updates when SR-IOV
>>>>>>>> is
>>>>>>>> disabled. Attempts to update them when SR-IOV is in use will only
>>>>>>>> update
>>>>>>>> the local value and will not update sriov->autoprobe.
>>>>>>>
>>>>>>>
>>>>>>> And we expect users to understand when sriov_drivers_autoprobe
>>>>>>> applies
>>>>>>> vs sriov_unmanaged_autoprobe, even though they're using the same
>>>>>>> interfaces to enable sriov?  Are all combinations expected to work,
>>>>>>> ex.
>>>>>>> unmanaged sriov is enabled, a native pf driver loads, vfs work?  Not
>>>>>>> only does it seems like there's opportunity to use this incorrectly,
>>>>>>> I
>>>>>>> think maybe it might be difficult to use correctly.
>>>>>>>
>>>>>>>>
>>>>>>>> I based my patch set originally on the patch by Mark Rustad but
>>>>>>>> there isn't
>>>>>>>> much left after going through and cleaning out the bits that were no
>>>>>>>> longer
>>>>>>>> needed, and after incorporating the feedback from David Miller.
>>>>>>>>
>>>>>>>> I have included the authors of the original 4 patches above in the
>>>>>>>> Cc here.
>>>>>>>> My hope is to get feedback and/or review on if this works for their
>>>>>>>> use
>>>>>>>> cases.
>>>>>>>>
>>>>>>>> Cc: Mark Rustad <mark.d.rustad@intel.com>
>>>>>>>> Cc: Maximilian Heyne <mheyne@amazon.de>
>>>>>>>> Cc: Liang-Min Wang <liang-min.wang@intel.com>
>>>>>>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>>>>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>>>>>>> ---
>>>>>>>>   drivers/pci/iov.c        |   27 +++++++++++++++++++-
>>>>>>>>   drivers/pci/pci-driver.c |    2 +
>>>>>>>>   drivers/pci/pci-sysfs.c  |   62
>>>>>>>> +++++++++++++++++++++++++++++++++++++++++-----
>>>>>>>>   drivers/pci/pci.h        |    4 ++-
>>>>>>>>   include/linux/pci.h      |    1 +
>>>>>>>>   5 files changed, 86 insertions(+), 10 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>>> index 677924ae0350..7b8858bd8d03 100644
>>>>>>>> --- a/drivers/pci/iov.c
>>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>>> @@ -446,6 +446,7 @@ static int sriov_init(struct pci_dev *dev, int
>>>>>>>> pos)
>>>>>>>>        pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID,
>>>>>>>> &iov->vf_device);
>>>>>>>>        iov->pgsz = pgsz;
>>>>>>>>        iov->self = dev;
>>>>>>>> +     iov->autoprobe = true;
>>>>>>>>        iov->drivers_autoprobe = true;
>>>>>>>>        pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
>>>>>>>>        pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK,
>>>>>>>> &iov->link);
>>>>>>>> @@ -643,8 +644,11 @@ void pci_restore_iov_state(struct pci_dev *dev)
>>>>>>>>    */
>>>>>>>>   void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
>>>>>>>> auto_probe)
>>>>>>>>   {
>>>>>>>> -     if (dev->is_physfn)
>>>>>>>> +     if (dev->is_physfn) {
>>>>>>>>                dev->sriov->drivers_autoprobe = auto_probe;
>>>>>>>> +             if (!dev->sriov->num_VFs)
>>>>>>>> +                     dev->sriov->autoprobe = auto_probe;
>>>>>>>
>>>>>>>
>>>>>>> Why is dev->sriov->autoprobe set any time other than immediately
>>>>>>> prior
>>>>>>> to enabling VFs?
>>>>>>
>>>>>>
>>>>>> My concern here was drivers that are still floating around with the
>>>>>> old module parameter option for enabling SR-IOV. In the unlikely event
>>>>>> that somebody was to use such a driver I wanted to make certain that
>>>>>> the drivers_autoprobe state was pre-populated.
>>>>
>>>>
>>>> Good point, but maybe that just means we should be setting it in
>>>> sriov_enable()?
>>>
>>>
>>> I suppose we could. I would just have to check and see if we have any
>>> drivers lurking out there that are supporting SR-IOV without
>>> supporting the sysfs approach. As long as that is the case we could
>>> probably put it there.
>>>
>>>>>>>> +     }
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   /**
>>>>>>>> @@ -703,6 +707,27 @@ void pci_disable_sriov(struct pci_dev *dev)
>>>>>>>>   EXPORT_SYMBOL_GPL(pci_disable_sriov);
>>>>>>>>
>>>>>>>>   /**
>>>>>>>> + * pci_sriov_configure_unmanaged - helper to configure unmanaged
>>>>>>>> SR-IOV
>>>>>>>> + * @dev: the PCI device
>>>>>>>> + * @nr_virtfn: number of virtual functions to enable, 0 to disable
>>>>>>>> + *
>>>>>>>> + * Used to provide generic enable/disable SR-IOV option for devices
>>>>>>>> + * that do not manage the VFs generated by their driver, or have no
>>>>>>>> + * driver present.
>>>>>>>> + */
>>>>>>>> +int pci_sriov_configure_unmanaged(struct pci_dev *dev, int
>>>>>>>> nr_virtfn)
>>>>>>>> +{
>>>>>>>> +     int rc = 0;
>>>>>>>> +
>>>>>>>> +     if (!nr_virtfn)
>>>>>>>> +             pci_disable_sriov(dev);
>>>>>>>> +     else
>>>>>>>> +             rc = pci_enable_sriov(dev, nr_virtfn);
>>>>>>>> +
>>>>>>>> +     return rc ? rc : nr_virtfn;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>>    * pci_num_vf - return number of VFs associated with a PF
>>>>>>>> device_release_driver
>>>>>>>>    * @dev: the PCI device
>>>>>>>>    *
>>>>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>>>>> index 3bed6beda051..2cc68dff6130 100644
>>>>>>>> --- a/drivers/pci/pci-driver.c
>>>>>>>> +++ b/drivers/pci/pci-driver.c
>>>>>>>> @@ -398,7 +398,7 @@ void __weak pcibios_free_irq(struct pci_dev
>>>>>>>> *dev)
>>>>>>>>   #ifdef CONFIG_PCI_IOV
>>>>>>>>   static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>>>>>>>   {
>>>>>>>> -     return (!pdev->is_virtfn ||
>>>>>>>> pdev->physfn->sriov->drivers_autoprobe);
>>>>>>>> +     return (!pdev->is_virtfn || pdev->physfn->sriov->autoprobe);
>>>>>>>>   }
>>>>>>>>   #else
>>>>>>>>   static inline bool pci_device_can_probe(struct pci_dev *pdev)
>>>>>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>>>>>> index eb6bee8724cc..e701b6dbc267 100644
>>>>>>>> --- a/drivers/pci/pci-sysfs.c
>>>>>>>> +++ b/drivers/pci/pci-sysfs.c
>>>>>>>> @@ -605,6 +605,7 @@ static ssize_t sriov_numvfs_store(struct device
>>>>>>>> *dev,
>>>>>>>>                                  struct device_attribute *attr,
>>>>>>>>                                  const char *buf, size_t count)
>>>>>>>>   {
>>>>>>>> +     int (*sriov_configure)(struct pci_dev *dev, int num_vfs);
>>>>>>>>        struct pci_dev *pdev = to_pci_dev(dev);
>>>>>>>>        int ret;
>>>>>>>>        u16 num_vfs;
>>>>>>>> @@ -622,15 +623,20 @@ static ssize_t sriov_numvfs_store(struct
>>>>>>>> device *dev,
>>>>>>>>                goto exit;
>>>>>>>>
>>>>>>>>        /* is PF driver loaded w/callback */
>>>>>>>> -     if (!pdev->driver || !pdev->driver->sriov_configure) {
>>>>>>>> -             pci_info(pdev, "Driver doesn't support SRIOV
>>>>>>>> configuration via sysfs\n");
>>>>>>>> -             ret = -ENOENT;
>>>>>>>> -             goto exit;
>>>>>>>> -     }
>>>>>>>> +     if (pdev->driver && pdev->driver->sriov_configure)
>>>>>>>> +             sriov_configure = pdev->driver->sriov_configure;
>>>>>>>> +     else
>>>>>>>> +             sriov_configure = pci_sriov_configure_unmanaged;
>>>>>>>
>>>>>>>
>>>>>>> So an unwitting user is now able to enable vfs, independent of the
>>>>>>> pf... the trouble being that they're probably going to expect them to
>>>>>>> work and the more common case is that they won't.  For instance, what
>>>>>>> can you do with an igbvf when igb isn't managing the pf?
>>>>>>
>>>>>>
>>>>>> Well the VFs wouldn't be able to do anything. Basically they would be
>>>>>> sitting there with no driver loaded on them unless they are assigned
>>>>>> to a guest, or the root user had enabled the unmanaged option. If you
>>>>>> did load a driver on it the VF would sit there with link down unless
>>>>>> either the PF driver is loaded or some user-space entity steps in to
>>>>>> start managing the PF.
>>>>>>
>>>>>> In reality this can already happen as last I recall igb and ixgbe were
>>>>>> already capable of having the PF driver removed when SR-IOV was
>>>>>> enabled and VFs were assigned. Basically the VFs just report link down
>>>>>> and don't do anything. Reloading the PF driver would have it take over
>>>>>> in the case of igb and ixgbe since they were designed to handle that
>>>>>> type of scenario.
>>>>
>>>>
>>>> I think only ixgbe behaves this way between the two, igb disables sriov
>>>> in its remove function unless we're hung up by that silly
>>>> pci_vfs_assigned() check, which doesn't apply to vfio assignment.
>>>> Regardless, yes, some pf drivers do leave sriov enabled on remove,
>>>> whether that's useful or reasonable is another question.
>>>
>>>
>>> Right. We can argue that another day. I was just sighting the igb
>>> behavior.
>>>
>>>>>>> Or what happens when vfio-pci owns the pf, sriov is enabled via the
>>>>>>> unmanaged interface, and the pf user driver segfaults and gets
>>>>>>> killed,
>>>>>>> causing vfio-pci to restore the pf state, including wiping the sriov
>>>>>>> config?
>>>>>>
>>>>>>
>>>>>> Wiping the config shouldn't have any effect on the allocated VF pci
>>>>>> devices. It will cause the VFs to act as though they have fallen off
>>>>>> of the bus though and the guests would see a surprise remove type
>>>>>> behavior if I am not mistaken. The MMIO and config accesses would fail
>>>>>> until the SR-IOV configuration is restored. Really this shouldn't be a
>>>>>> problem as long as the SR-IOV is enabled prior to loading the vfio-pci
>>>>>> driver as I would assume it would restore the state an re-enable
>>>>>> SR-IOV.
>>>>
>>>>
>>>> Nope, sriov does not appear to be part of the device state saved and
>>>> restored around reset, so I think we just end up in an inconsistent
>>>> state.  Also, vfio-pci stores a copy of the saved state of a device
>>>> prior to giving the user access to the device and tries to restore that
>>>> copy when released by the user, so anything that's part of the save
>>>> state and modified via side-channels while the device is opened, would
>>>> still be lost.
>>>
>>>
>>> Well it is but it isn't. The pci_restore_state will call
>>> pci_restore_iov_state which will just repopulate the data straight out
>>> of the pdev->sriov structure. I think the assumption is we were
>>> already carrying enough information that there wasn't any point in
>>> saving the state since we could just restore it from that structure
>>> anyway.
>>
>>
>> Ah, right, I remember that now.
>>
>>>
>>> I've been chasing it down and can verify that much this morning after
>>> testing. A regular hit of the sysfs reset control will not erase the
>>> state.
>>
>>
>> Perhaps long term, but momentarily the vf disappears and that could
>> imply data loss, no?
>>
>>> One issue that I think I found that may be a bug though is if I
>>> load the vfio-pci driver on an interface and unbind it I am seeing the
>>> port state reset. I have it chased down to the idle D3 code. It looks
>>> like going from vfio_pci_probe to vfio_pci_remove is triggering the
>>> equivilent of the pci_pm_reset since it is cycling me through
>>> D0->D3->D0 without restoring state after the fact. I also verified
>>> that setting disable_idle_d3 resolves the issue. Would you have any
>>> complaints about me doing a save_state in the probe call, and a
>>> restore_state in the remove? It seems like that should probably be the
>>> easiest fix.
>>
>>
>> Hmm, perhaps I had assumed that pci_set_power_state() would handle such
>> things, but indeed I do see other drivers calling pci_save_state()
>> prior and pci_restore_state() after.  I think we'd need to audit all of
>> vfio-pci's calls to pci_set_power_state(), not just probe and remove.
>>
>>>>>> In the grand scheme of things how would the situation you describe be
>>>>>> any different than someone using the "reset" sysfs control on the PF
>>>>>> while using SR-IOV with driver supported SR-IOV?
>>>>
>>>>
>>>> Similar, but the pf driver has enabled sriov and can register the
>>>> reset_done error handler to be notified to re-enable sriov or perform
>>>> other cleanup.  If the pf driver is not participating in sriov, it
>>>> would seem exceptional to support this.  Triggering reset via sysfs
>>>> also falls more closely to shooting yourself in the foot than I think
>>>> we want to design into driver/subsystem APIs.
>>>
>>>
>>> To some extent I agree with the shooting yourself in the foot. At the
>>> same time there isn't actually all that much to re-enable SR-IOV.
>>> Restoring the PCI SR-IOV configuration space and re-enabling the bus
>>> master enable.
>>
>>
>> Bus master is a pretty interesting example of the trivial control a pf
>> driver can exert on the vfs though.
>>
>>> The Amazon guys would probably know better than I since I haven't
>>> really worked much with one of these parts yet. Actually the virtio
>>> that Mark pushed may behave the same way too. As far as I know in
>>> these firmware cases the hardware itself has everything
>>> pre-partitioned and set to re-enable as soon as the SR-IOV bits are
>>> set. I think all they need is a few bits toggled and they are pretty
>>> much good to go.
>>
>>
>> Are they just looking for an sriov capable stub driver?  With
>> increasing vf counts, being able to use something like vfio-pci on the
>> pf seems like all risk with statistically insignificant increase in
>> density.  On the other hand, if there's a userspace pf management
>> driver, why not just make it trusted by adding it as a native host
>> kernel driver?  If we're talking about tainting the host kernel to
>> enable this interaction, maybe it should just be tainted by an out of
>> tree, possibly non-gpl host pf driver anyway.  There can't really be a
>> case where the pf would be used by an average user without some degree
>> of privilege or cooperation, right?
>>
>>>>>>
>>>>>> I suppose if you really wanted we could add a new call that you could
>>>>>> put into the sriov_configure pointer that would just make it always
>>>>>> return error. Then that way the configuration could be locked until
>>>>>> the driver is unloaded.
>>>>>>
>>>>>>>
>>>>>>> I guess I don't understand how vfs can operate fully independent of
>>>>>>> the
>>>>>>> pf and why vfio-pci wouldn't just implement a dummy sriov_configure
>>>>>>> to
>>>>>>> avoid contending with such issues.
>>>>>>
>>>>>>
>>>>>> This approach isn't without risk, but it isn't as if it is really a
>>>>>> new risk we are introducing, and we could do further work to help
>>>>>> smooth out issues like this. Much of this depends on the design of the
>>>>>> device and the drivers involved. What is happening in this case is
>>>>>> that the VFs are managed outside of the kernel itself either by some
>>>>>> user-space entity or by a firmware entity.
>>>>
>>>>
>>>> But we can't simply split vfs and pfs as separate resources, the vf is
>>>> dependent on the pf and that implies a privilege hierarchy, if not at
>>>> least cooperation.  The pf driver can intentionally or unintentionally
>>>> disconnect the vfs at any point in time, possibly leading to data loss
>>>> or at least denial of service for the vf consumer.  I also don't trust
>>>> that there aren't numerous sriov implementations where the pf isn't
>>>> privileged to the point of being able to snoop data from the vf.  So
>>>> what sort of usage models are we enabling for the vf?  A firmware owned
>>>> vf subject to these conditions seems mostly pointless.
>>>
>>>
>>> In the case of these sort of parts the PF isn't really all that
>>> privileged. Usually the PF is just a VF with the SR-IOV capability
>>> hanging off of it. I suspect the only thing that might outright
>>> control anything would be the bus master enable bit. Everything else
>>> could be independent. The PF driver in such cases doesn't do much. It
>>> is basically just the host for the configuration space.
>>
>>
>> This is sounding more like an sriov capable stub driver.  Certainly not
>> all pfs behave the way you describe above, many are significantly more
>> privileged and even if not, bus master is a pretty trivial control
>> point.  So we probably need a driver that claims devices known to
>> behave this way, or a meta driver that bind via dynamic IDs or
>> driver_override.  The proposal here sort of covertly turns anything
>> that's not an sriov driver into that stub driver with no guarantee that
>> the subverted driver is a willing or safe participant.
>>
>>>>> So I was thinking about this some more. In the case of vfio-pci things
>>>>> are a bit different since you are essentially taking a given device
>>>>> and handing it to a VM or userspace and it doesn't guarantee a
>>>>> communication between the two.
>>>>
>>>>
>>>> Doesn't guarantee communication or cooperation or even trust.
>>>
>>>
>>> Right, but at the same time I consider this to be a shoot yourself in
>>> the foot type scenario. If you are going to hand off your PF while VFs
>>> are active then you are asking for whatever repercussions you end up
>>> getting. I've added a warning and a TAINT_USER flag to my code at this
>>> point if you load an active PF in vfio, and I have added a function
>>> that locks the setting so it cannot be changed once we place a PF in
>>> the control of vfio-pci.
>>>
>>> The way I see it there are two scenarios. One where the PF is just a
>>> VF with an extra bit of SR-IOV configuration space floating off of it.
>>> The other is where we want to have SR-IOV enabled and have some third
>>> party managing the PF.  The first one doesn't really care about the
>>> communication and would prefer that whatever owns the driver on the PF
>>> just ignore the SR-IOV portion of the configuration space. The second
>>> one actually cares and would want some sort of
>>> communication/cooperation but for now I don't see that as being the
>>> easiest thing to do so it might be best to just let it see a fixed
>>> number of VFs it just has to work with that.
>>
>>
>> There's no such thing as a read-only sriov capability in the spec,
>> which is a problem we ran into a while ago, vfio-pci exposes the
>> capability, but protects it as read-only so the user cannot create
>> devices on the host.  QEMU passed this through to the guest, but that
>> failed as soon as OVMF started supporting sriov as it's unable to size
>> the VF BAR resources.  Now QEMU drops the sriov capability from the
>> guest capability chain.  So it's not clear how this fixed number of vfs
>> plan works.  Are we inventing our own capability for this?  If the pf
>> driver is just a userspace driver and not a VM, maybe what we do now is
>> sufficient, otherwise there's no standard for exposing fixed vfs.
>>
>>>>> My thought is to look at making SR-IOV configuration static or treat
>>>>> it as read-only when the vfio-pci driver is loaded on a given
>>>>> interface. In addition I would set the TAINT_USER flag and add a
>>>>> warning about loading vfio-pci on an active PF, and provide the number
>>>>> of VFs that were allocated.
>>>>>
>>>>> The idea with all of this being that we would at least have a partial
>>>>> lock on all of this so that you can allocate some number of VFs, and
>>>>> then start partitioning things up where you could assign the PF and
>>>>> VFs as needed to the various interfaces. Once the PF is assigned to
>>>>> the vfio-pci driver it would be locked in terms of the number of VFs
>>>>> that are provided so there would be no need for an extra communication
>>>>> channel between the PF driver and the host to deal with changes.
>>>>>
>>>>> Thoughts?
>>>>
>>>>
>>>> Is an sriov configuration ever static?  vfio is the most prolific user
>>>> of the pci reset interfaces, AFAIK.  Even if we add support for
>>>> restoring the sriov configuration and even if the pf user isn't trying
>>>> to be malicious, vf users would need to be prepared for their device
>>>> arbitrarily dropping off the bus, mmio randomly (from their
>>>> perspective) being disabled, and maybe other side-effects of the user
>>>> just trying to use the pf device.  Is there even any guarantee that a
>>>> pf driver can operate identically, regardless of the state of sriov on
>>>> the pf?  It seems like the pf driver needs to be aware of which queues
>>>> are available for itself vs the vfs in some designs.  Is there still
>>>> long term value in a solution for this if the kernel is tainted?
>>>
>>>
>>> As far as the device randomly resetting I don't really see how that is
>>> any different from what we already have in terms of solutions
>>> including stuff supported by in-driver SR-IOV. The Intel drivers are
>>> notorious for resetting for any little thing like an MTU change. Us
>>> resetting due to someone calling open/release on an interface wouldn't
>>> be anything new. In addition AER can always hit us too. Yes we don't
>>> have the same recovery mechanisms in place, but in the case of
>>> something such as this we probably don't need that complex of a
>>> recovery setup.
>>
>>
>> [I think below paragraph is specifically answering last question above,
>> still long term value in kernel tainting solution]
>>
>>> I would think there probably is. If not we wouldn't have gotten the
>>> patches earlier that were still doing the tainting and warning and
>>> making use of the vfio-pci driver to enable SR-IOV. I suspect the use
>>> case for all this is to enable SR-IOV, setup the PF in vfio-pci, and
>>> then assign VFs into and out of guests. I don't see the PF doing a lot
>>> of moving after it is setup. The taint flag only really applies if
>>> someone is looking for support and quite honestly I figure for now the
>>> USER flag is appropriate for this kind of thing since we are deferring
>>> all the networking control to the PF which is managed by userspace.
>>
>>
>> If we're going to throw up our hands and taint the kernel, then maybe
>> we could entertain the idea of doing that in a trivial vfio-pci
>> sriov_configure function.  But does that really meet all the use cases
>> and what's the advantage of that vs Amazon (I guess they're the driver
>> here) tainting the kernel with their own driver?  Mellanox has tried to
>> enable sriov in vfio-pci in the past, Cc Ilya.
>>
>>>> Minimally, it seems like the pf driver (the user driver, not vfio-pci)
>>>> needs to be a cooperating party in this exchange.  How do we determine
>>>> that and what QoS guarantees are they providing by agreeing to it?
>>>
>>>
>>> I think the general idea here is that the user has already tested this
>>> out and determined for themselves that the user driver does what they
>>> want/need. If it didn't they wouldn't be going to all these lengths to
>>> set this up.
>>>
>>>> Otherwise it doesn't seem like sriov provides the sort of static, hard
>>>> partitioning of the device that you're asking for.  A vf is a piece of
>>>> the pf and we've released ownership and control of the pf to a user.
>>>> Thanks,
>>>>
>>>> Alex
>>>
>>>
>>> I am pretty sure that you are describing is true of some, but not for
>>> all. I think the Amazon solutions and the virtio solution are doing
>>> hard partitioning of the part. I will leave it to those guys to speak
>>> for themselves since I don't know anything about the hardware design
>>> of those parts.
>>
>>
>> I think we'd need device specific knowledge and enablement to be able
>> to take advantage of any hardware partitioning, otherwise we need to
>> assume the pf is privileged, as implemented in other sriov devices.
>>
>> I'm also trying to imagine whether there's a solution via the new
>> vfio/mdev interface, where the mdev vendor driver would bind to the pf
>> and effectively present itself as the mdev device.  The vendor driver
>> could provide sriov capabilities and bear the burden of ensuring that
>> the pf is used cooperatively.  The only existing mdev vendor drivers are
>> vGPUs and rely on on-device DMA translation and isolation, such as
>> through GTTs, but there have been some thoughts on providing IOMMU based
>> isolation of mdev/sriov mixed devices (assuming DMA is even required
>> for userspace management of the pf in this use case).  [Cc Kirti]
>> Thanks,
>>
>> Alex
>>
> Apologies for getting to this party late.
>
> My 2 cents:
>
> I think a stub driver is needed for security reasons.
> Multiple reasons/cases stated in the thread to (continue to) follow that
> model.
>    ... and wondering why pci-stub isn't enhanced to do just that, since
>        it's already used in device-assignment tasks (VM or DPDK).

There was an attempt to update pci-stub:
https://patchwork.kernel.org/patch/10109935/

One issue with using pci-stub is it doesn't address the security
issues needed if an IOMMU is enabled. For that reason I think vfio-pci
might be a better choice, and that is why my v2 is based around it.

For my v2 of this patch set I dropped the pure generic solution and
instead just updated virtio and vfio-pci in order to meet the needs as
called out in the previous patch sets.

>   -- pf devices that have drivers that coordinate don't need pci-stub;
>      pf devices w/no drivers get assigned to pci-stub, then VF's are
>       enabled/disabled/tracked/managed....

Yeah, my first attempt at this was to avoid doing what I consider to
be somewhat ridiculous things like adding SR-IOV support to
virtio_net. It didn't seem right to me but in the grand scheme of
things that ends up kind of being the way we have to go in order to
put some boundaries on when/where SR-IOV can be enabled.

> mdev wrapping of VFs doesn't (re)solve device-specific needs/extensions
> for VF migration either.
> PF-device-specific needs should be handled by a PF driver;
> if no PF driver, then assuming no device-specific need exists, and using
> non-device-specific, common pci-stub VF handling

The issue here is how do you classify that there is no common PF
driver, or is this something that would be decided by the user?

Also I don't know if this addresses the needs fro the DPDK crowd to
enable a userspace PF driver?

> -- even w/pci-quirk hooks/workarounds if they need to be added.
> Finally, if an ah-ha moment is reached that concludes with the
> need for a PF driver to handle device-specific issues, the pci-stub VF
> functions may provide the guide/framework for such hastily put together PF
> drivers,
> minimizing PF driver variances for sriov handling.

I'm not sure I followed this part. Are you saying the pci-stub driver
gets used as a template essentially for creating a PF driver if
needed?

> Although a temporary disconnect is handled/emulated well in the (e)net
> space,
> I also don't think it's an issue for storage, as I would expect two
> situations to occur
> wrt data-loss scenarios:
> a) a PF device has a kernel driver, and it has to handle the up/down of a VF
> b) the PF is quiesced -- no device-specific kernel driver --
>    and there is no VF loss due to PF resetting b/c there
>    is no need to reset PF -- pci-stub providing stable, kernel config.
>    Per VF data loss is always an issue for storage interconnects
>     (unless they are net-based, like iSCSI, RDMA, etc.) which is handled
>     at the VF driver or layer above it.
>
> - Don

My concern is we are starting to see a third option here. A PF that
has a kernel driver, but knows nothing of SR-IOV as it is completely
managed by firmware. An example being the virtio_net that somehow
knows how to do SR-IOV (https://patchwork.kernel.org/patch/10241225/).
My understanding is that the part in question is providing a
lightweight PF that is essentially just another VF, but has some extra
PCIe configuration space to it allowing for SR-IOV and AER
functionality.

In addition we are also seeing customer scenarios where things like
DPDK are running as the PF with kernel VFs. Ideally we want to contain
that as much as possible and my understanding is that igb_uio
currently isn't really providing much in the way of containment.

- Alex
