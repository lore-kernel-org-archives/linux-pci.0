Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab1KIXlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Nov 2011 18:41:03 -0500
Message-ID: <1320882039.2682.68.camel@bling.home>
Subject: RE: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: "Christian Benvenuti (benve)" <benve@cisco.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	"Aaron Fabbri (aafabbri)" <aafabbri@cisco.com>,
	B08248@freescale.com, B07421@freescale.com, avi@redhat.com,
	konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Wed, 09 Nov 2011 16:40:39 -0700
In-Reply-To: <184D23435BECB444AB6B9D4630C8EC8302D5FD6F@XMB-RCD-303.cisco.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D5FAFB@XMB-RCD-303.cisco.com>
	 <1320861775.4514.103.camel@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D5FD6F@XMB-RCD-303.cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2011-11-09 at 15:08 -0600, Christian Benvenuti (benve) wrote:
<snip>
> > > > +
> > > > +struct vfio_group {
> > > > +	dev_t			devt;
> > > > +	unsigned int		groupid;
> > >
> > > This groupid is returned by the device_group callback you recently
> > added
> > > with a separate (not yet in tree) IOMMU patch.
> > > Is it correct to say that the scope of this ID is the bus the iommu
> > > belongs too (but you use it as if it was global)?
> > > I believe there is nothing right now to ensure the uniqueness of such
> > > ID across bus types (assuming there will be other bus drivers in the
> > > future besides vfio-pci).
> > > If that's the case, the vfio.group_list global list and the
> > __vfio_lookup_dev
> > > routine should be changed to account for the bus too?
> > > Ops, I just saw the error msg in vfio_group_add_dev about the group
> > id conflict.
> > > Is that warning related to what I mentioned above?
> > 
> > Yeah, this is a concern, but I can't think of a system where we would
> > manifest a collision.  The IOMMU driver is expected to provide unique
> > groupids for all devices below them, but we could imagine a system that
> > implements two different bus_types, each with a different IOMMU driver
> > and we have no coordination between them.  Perhaps since we have
> > iommu_ops per bus, we should also expose the bus in the vfio group
> > path,
> > ie. /dev/vfio/%s/%u, dev->bus->name, iommu_device_group(dev,..).  This
> > means userspace would need to do a readlink of the subsystem entry
> > where
> > it finds the iommu_group to find the vfio group.  Reasonable?
> 
> Most probably we won't see use cases with multiple buses anytime soon, but
> this scheme you proposed (with the per-bus subdir) looks good to me. 

Ok, I think that's easier than any scheme of trying to organize globally
unique groupids instead of just bus_type unique.  That makes group
objects internally matched by the {groupid, bus} pair.

<snip>
> > >
> > > I looked at how you take care of ref counts ...
> > >
> > > This is how the tree of vfio_iommu/vfio_group/vfio_device data
> > > Structures is organized (I'll use just iommu/group/dev to make
> > > the graph smaller):
> > >
> > >             iommu
> > >            /     \
> > >           /       \
> > >     group   ...     group
> > >     /  \           /  \
> > >    /    \         /    \
> > > dev  ..  dev   dev  ..  dev
> > >
> > > This is how you get a file descriptor for the three kind of objects:
> > >
> > > - group : open /dev/vfio/xxx for group xxx
> > > - iommu : group ioctl VFIO_GROUP_GET_IOMMU_FD
> > > - device: group ioctl VFIO_GROUP_GET_DEVICE_FD
> > >
> > > Given the above topology, I would assume that:
> > >
> > > (1) an iommu is 'inuse' if : a) iommu refcnt > 0, or
> > >                              b) any of its groups is 'inuse'
> > >
> > > (2) a  group is 'inuse' if : a) group refcnt > 0, or
> > >                              b) any of its devices is 'inuse'
> > >
> > > (3) a device is 'inuse' if : a) device refcnt > 0
> > 
> > (2) is a bit debatable.  I've wrestled with this one for a while.  The
> > vfio_iommu serves two purposes.  First, it is the object we use for
> > managing iommu domains, which includes allocating domains and attaching
> > devices to domains.  Groups objects aren't involved here, they just
> > manage the set of devices.  The second role is to manage merged groups,
> > because whether or not groups can be merged is a function of iommu
> > domain compatibility.
> > 
> > So if we look at "is the iommu in use?" ie. can I destroy the mapping
> > context, detach devices and free the domain, the reference count on the
> > group is irrelevant.  The user has to have a device or iommu file
> > descriptor opened somewhere, across the group or merged group, for that
> > context to be maintained.  A reasonable requirement, I think.
> 
> OK, then if you close all devices and the iommu, keeping the group open
> Would not protect the iommu domain mapping. This means that if you (or
> A management application) need to close all devices+iommu and reopen
> right away again the same devices+iommu you may get a failure on the
> iommu domain creation (supposing the system goes out of resources).
> Is this just a very unlikely scenario? 

Can you think of a use case that would require such?  I can't.

> I guess in this case you would simply have to avoid releasing the iommu
> fd, right?

Right.  We could also debate whether we should drop all iommu mappings
when the iommu refcnt goes to zero.  We don't currently do that, but it
might make sense.

> 
> > However, if we ask "is the group in use?" ie. can I not only destroy
> > the
> > mappings above, but also automatically tear apart merged groups, then I
> > think we need to look at the group refcnt.
> 
> Correct.
> 
> > There's also a symmetry factor, the group is a benign entry point to
> > device access.  It's only when device or iommu access is granted that
> > the group gains any real power.  Therefore, shouldn't that power also
> > be
> > removed when those access points are closed?
> > 
> > > You have coded the 'inuse' logic with these three routines:
> > >
> > >     __vfio_iommu_inuse, which implements (1) above
> > >
> > > and
> > >     __vfio_iommu_groups_inuse
> > 
> > Implements (2.a)
> 
> Yes, but for al groups at once.

Right

> > >     __vfio_group_devs_inuse
> > 
> > Implements (2.b)
> 
> Yes
> 
> > > which are used by __vfio_iommu_inuse.
> > > Why don't you check the group refcnt in __vfio_iommu_groups_inuse?
> > 
> > Hopefully explained above, but open for discussion.
> > 
> > > Would it make sense (and the code more readable) to structure the
> > > nested refcnt/inuse check like this?
> > > (The numbers (1)(2)(3) refer to the three 'inuse' conditions above)
> > >
> > >    (1)__vfio_iommu_inuse
> > >    |
> > >    +-> check iommu refcnt
> > >    +-> __vfio_iommu_groups_inuse
> > >        |
> > >        +->LOOP: (2)__vfio_iommu_group_inuse<--MISSING
> > >                 |
> > >                 +-> check group refcnt<--MISSING
> > >                 +-> __vfio_group_devs_inuse()
> > >                     |
> > >                     +-> LOOP: (3)__vfio_group_dev_inuse<--MISSING
> > >                               |
> > >                               +-> check device refcnt
> > 
> > We currently do:
> > 
> >    (1)__vfio_iommu_inuse
> >     |
> >     +-> check iommu refcnt
> >     +-> __vfio_group_devs_inuse
> >         |
> >         +->LOOP: (2.b)__vfio_group_devs_inuse
> >                   |
> >                   +-> LOOP: (3) check device refcnt
> > 
> > If that passes, the iommu context can be dissolved and we follow up
> > with:
> > 
> >     __vfio_iommu_groups_inuse
> >     |
> >     +-> LOOP: (2.a)__vfio_iommu_groups_inuse
> >                |
> >                +-> check group refcnt
> > 
> > If that passes, groups can also be umerged.
> > 
> > Is this right?
> 
> Yes, assuming we stick to the "benign" role of groups you
> described above.

Ok, no change then.  Thanks for looking at that so closely.

<snip>
> > > > +static int vfio_group_merge(struct vfio_group *group, int fd)
> > >
> > > The documentation in vfio.txt explains clearly the logic implemented
> > by
> > > the merge/unmerge group ioctls.
> > > However, what you are doing is not merging groups, but rather
> > adding/removing
> > > groups to/from iommus (and creating flat lists of groups).
> > > For example, when you do
> > >
> > >   merge(A,B)
> > >
> > > you actually mean to say "merge B to the list of groups assigned to
> > the
> > > same iommu as group A".
> > 
> > It's actually a little more than that.  After you've merged B into A,
> > you can close the file descriptor for B and access all of the devices
> > for the merged group from A.
> 
> It is actually more...
> 
> Scenario 1:
> 
>   create_grp(A)
>   create_grp(B)
>   ...
>   merge_grp(A,B)
>   create_grp(C)
>   merge_grp(C,B) ... this works, right?

No, but merge_grp(B,C) does.  I currently require that the incoming
group has no open device or iommu file descriptors and is a singular
group.  The device/iommu is a hard requirement since we'll be changing
the iommu context and can't leave an attack window.  The singular group
is an implementation detail.  Given the iommu/device requirement, it's
just as easy for userspace to tear apart the group and pass each
individually.

> Scenario 2:
> 
>   create_grp(A)
>   create_grp(B)
>   fd_x = get_dev_fd(B,x)
>   ...
>   merge_grp(A,B)

NAK, fails no open device test.  Again, merge_grp(B,A) is supported.

>   create_grp(C)
>   merge_grp(A,C)

Yep, this works.

>   fd_x = get_dev_fd(C,x) 

Yep, and if x is they same in both cases, you'll get 2 different file
descriptors backed by the same device.

> Those two examples seems to suggest me more of a list-abstraction than a merge abstraction.
> However, if it fits into the agreed syntax/logic it is ok, as long as we document it
> properly.

Can you suggest documentation changes that would make this more clear?

> > > For the same reason, you do not really need to provide the group you
> > want
> > > to unmerge from, which means that instead of
> > >
> > >   unmerge(A,B)
> > >
> > > you would just need
> > >
> > >   unmerge(B)
> > 
> > Good point, we can avoid the awkward reference via file descriptor for
> > the unmerge.
> > 
> > > I understand the reason why it is not a real merge/unmerge (ie, to
> > keep the
> > > original groups so that you can unmerge later)
> > 
> > Right, we still need to have visibility of the groups comprising the
> > merged group, but the abstraction provided to the user seems to be
> > deeper than you're thinking.
> > 
> > >  ... however I just wonder if
> > > it wouldn't be more natural to implement the
> > VFIO_IOMMU_ADD_GROUP/DEL_GROUP
> > > iommu ioctls instead? (the relationships between the data structure
> > would
> > > remain the same)
> > > I guess you already discarded this option for some reasons, right?
> > What was
> > > the reason?
> > 
> > It's a possibility, I'm not sure it was discussed or really what
> > advantage it provides.  It seems like we'd logically lose the ability
> > to
> > access devices from other groups,
> 
> What is the real (immediate) benefit of this capability?

Mostly convenience, but also promotes the peer idea where merged groups
simply create a "super" group that can access the iommu and all the
devices of the member groups.  On x86 we expect that merging groups will
always succeed and groups will typically have a single device, so a
driver could merge them all together, throw away all the extra group
file descriptors and manage the whole super group via a single group fd.

> > whether that's good or bad, I don't know.  I think the notion of "merge"
> > promotes the idea that the groups
> > are peers and an iommu_add/del feels a bit more hierarchical.
> 
> I agree. 
<snip>
> > > > +	if (!device) {
> > > > +		if (__vfio_group_devs_inuse(group) ||
> > > > +		    (group->iommu && group->iommu->refcnt)) {
> > > > +			printk(KERN_WARNING
> > > > +			       "Adding device %s to group %u while group is
> > > > already in use!!\n",
> > > > +			       dev_name(dev), group->groupid);
> > > > +			/* XXX How to prevent other drivers from claiming? */
> > >
> > > Here we are adding a device (not yet assigned to a vfio bus) to a
> > group
> > > that is already in use.
> > > Given that it would not be acceptable for this device to get assigned
> > > to a non vfio driver, why not forcing such assignment here then?
> > 
> > Exactly, I just don't know the mechanics of how to make that happen and
> > was hoping for suggestions...
> > 
> > > I am not sure though what the best way to do it would be.
> > > What about something like this:
> > >
> > > - when the bus vfio-pci processes the BUS_NOTIFY_ADD_DEVICE
> > >   notification it assigns to the device a PCI ID that will make sure
> > >   the vfio-pci's probe routine will be invoked (and no other driver
> > can
> > >   therefore claim the device). That PCI ID would have to be added
> > >   to the vfio_pci_driver's id_table (it would be the exception to the
> > >   "only dynamic IDs" rule). Too hackish?
> > 
> > Presumably some other driver also has the ID in it's id_table, how do
> > we make sure we win?
> 
> By mangling such ID (when processing the BUS_NOTIFY_ADD_DEVICE notification) to
> match against a 'fake' ID registered in the vfio-pci table (it would be like a
> sort of driver redirect/divert). The vfio-pci's probe routine would restore
> the original ID (we do not want to confuse userspace). This is hackish, I agree.
> 
> What about this:
> - When vfio-pci processes the BUS_NOTIFY_ADD_DEVICE notification it can
>   pre-initialize the driver pointer (via an API). We would then need to change
>   the match/probe PCI mechanism too: for example, the PCI core will have to check
>   and honor such pre-driver-initialization when present (and give it higher
>   priority over the match callbacks).
>   How to do this? For example, when vfio_group_add_dev is invoked, it checks
>   whether the device is getting added to an already existent group where
>   the other devices (well, you would need to check just one of the devices in
>   the group) are already assigned to vfio-pci, and in such a case it
>   pre-initialize the driver to vfio-pci.

It's ok to make a group "non-viable", we only want to intervene if the
iommu is inuse (iommu or device refcnt > 0).

> 
> NOTE: By "preinit" I mean "save into the device a reference to a driver before
>       the 'match' callbacks".
> 
> This would be the timeline:
> 
> |
> +-> new device gets added to (PCI) bus
> |
> +-> PCI: send BUS_NOTIFIER_ADD_DEVICE notification
> |
> +-> VFIO:vfio_pci_device_notifier
> |        |
> |        +-> BUS_NOTIFIER_ADD_DEVICE: vfio_group_add_dev
> |            |
> |            +->iommu_device_group(dev,&groupid)
> |            +->group = <search groupid in vfio.group_list>
> |            +->if (group && group_is_vfio(group))
> |            |        <preinit device driver to vfio-pci>
> |            ...
> |
> +-> PCI: xxx
> |        |
> |        +-> if (!device_driver_is_preinit(dev))
> |        |       probe=<search driver's probe callback using 'match'>
> |        |   else 
> |        |       probe=<get it from preint driver config>
> |        |       (+fallback to 'match' if preinit driver disappeared?)
> |        |   
> |        +-> rc = probe(...)
> |        |
> |        ...
> v
> ...
> 
> Of course, what if multiple drivers decide to preinit the device ?

Yep, we'd have to have a policy to BUG_ON if the preinit driver is
already set.

> One way to make it cleaner would be to:
> - have the PCI layer export an API that allows (for example) the bus
>   notification callbacks (like vfio_pci_device_notifier) to preinit a driver
> - make such API reject calls on devices that already have a preinit
>   driver.
> - make VFIO detect the case where vfio_pci_device_notifier can not
>   preinit the driver (to vfio-pci) for the new device (because already
>   preinited) and raise an error/warning.
> 
> Would this look a bit cleaner?

It looks like there might already be infrastructure that we can set
dev->driver and call the driver probe() function, so maybe we're only in
trouble if dev->driver is already set when we get the bus add
notification.  I just wasn't sure if that was entirely kosher.  I'll
have to try that and figure out how to test it; fake hotplug maybe.

<snip>
> > > This fn below does not return any error code. Ok ...
> > > However, there are a number of errors case that you test, for example
> > > - device that does not belong to any group (according to iommu API)
> > > - device that belongs to a group but that does not appear in the list
> > >   of devices of the vfio_group structure.
> > > Are the above two errors checks just paranoia or are those errors
> > actually possible?
> > > If they were possible, shouldn't we generate a warning (most probably
> > > it would be a bug in the code)?
> > 
> > They're all vfio-bus driver bugs of some sort, so it's just a matter of
> > how much we want to scream about them.  I'll comments on each below.
> > 
> > > > +void vfio_group_del_dev(struct device *dev)
> > > > +{
> > > > +	struct list_head *pos;
> > > > +	struct vfio_group *group = NULL;
> > > > +	struct vfio_device *device = NULL;
> > > > +	unsigned int groupid;
> > > > +
> > > > +	if (iommu_device_group(dev, &groupid))
> > > > +		return;
> > 
> > Here the bus driver is probably just sitting on a notifier list for
> > their bus_type and a device is getting removed.  Unless we want to
> > require the bus driver to track everything it's attempted to add and
> > whether it worked, we can just ignore this.
> 
> OK, I see what you mean. If vfio_group_add_dev fails for some reasons we
> do not keep track of it. Right?

The primary thing I'm thinking of here is not vfio_group_add_dev()
failing for "some reason", but specifically failing because the device
doesn't have a groupid, ie. it's not behind an iommu.  In that case it's
just a random device that can't be used by vfio.

> Would it make sense to add one special group to vfio.group_list (or better
> On a separate field of the vfio structure) whose goal
> would be just that: keep track of those devices that failed to be added
> to the VFIO framework (can it help for debugging too?)?

For the above case, no, we shouldn't need to track those.  But it does
seem like there's a gap for devices that fail vfio_group_add_dev() for
other reasons.  I don't think we want a special group for them, because
that isolates them from other devices that are potentially in the same
group.  I think instead what we want to do is set a taint flag on the
group.  We can do a BUG_ON not being able to allocate a group, then a
WARN_ON if we fail elsewhere and mark the group tainted so it's
effectively never viable.

<snip>
> > > > +	if (!vfio_device_removeable(device)) {
> > > > +		/* XXX signal for all devices in group to be removed or
> > > > +		 * resort to killing the process holding the device fds.
> > > > +		 * For now just block waiting for releases to wake us. */
> > > > +		wait_event(vfio.release_q, vfio_device_removeable(device));
> > >
> > > Any new idea/proposal on how to handle this situation?
> > > The last one I remember was to leave the soft/hard/etc timeout
> > handling in
> > > userspace and implement it as a sort of policy. Is that one still the
> > most
> > > likely candidate solution to handle this situation?
> > 
> > I haven't heard any new proposals.  I think we need the hard timeout
> > handling in the kernel.  We can't leave it to userspace to decide they
> > get to keep the device.  We could have this tunable via an ioctl, but I
> > don't see how we wouldn't require CAP_SYS_ADMIN (or similar) to tweak
> > it.  I was intending to re-implement the netlink interface to signal
> > the
> > removal, but expect to get allergic reactions to that.
> 
> (I personally like the async netlink signaling, but I am OK with an ioctl based
> mechanism if it provides the same flexibility)
> 
> What would be a reasonable hard timeout?

I think we were looking at 10s of seconds in the old vfio code.  Tough
call though.  Could potentially provide a module_param override so an
admin that trusts their users could set long/infinite timeout.  Thanks,

Alex

