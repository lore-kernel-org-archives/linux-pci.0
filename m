Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:47256 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab1KUCsC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2011 21:48:02 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <dwg@au1.ibm.com>;
	Mon, 21 Nov 2011 02:42:56 +1000
Date: Mon, 21 Nov 2011 13:47:42 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111121024742.GA6575@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
 <20111115063431.GA4921@truffala.fritz.box>
 <1321380088.17169.282.camel@bling.home>
 <20111117000218.GB5411@truffala.fritz.box>
 <1321648376.26410.238.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321648376.26410.238.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2011 at 01:32:56PM -0700, Alex Williamson wrote:
> On Thu, 2011-11-17 at 11:02 +1100, David Gibson wrote:
> > On Tue, Nov 15, 2011 at 11:01:28AM -0700, Alex Williamson wrote:
> > > On Tue, 2011-11-15 at 17:34 +1100, David Gibson wrote:
> > > > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
> <snip>
> > > > > +Groups, Devices, IOMMUs, oh my
> > > > > +-------------------------------------------------------------------------------
> > > > > +
> > > > > +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> > > > > +can't always distinguish transactions from each individual device in
> > > > > +the system.  Sometimes this is because of the IOMMU design, such as with
> > > > > +PEs, other times it's caused by the I/O topology, for instance a
> > > > > +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> > > > > +devices created by these restictions IOMMU groups (or just "groups" for
> > > > > +this document).
> > > > > +
> > > > > +The IOMMU cannot distiguish transactions between the individual devices
> > > > > +within the group, therefore the group is the basic unit of ownership for
> > > > > +a userspace process.  Because of this, groups are also the primary
> > > > > +interface to both devices and IOMMU domains in VFIO.
> > > > > +
> > > > > +The VFIO representation of groups is created as devices are added into
> > > > > +the framework by a VFIO bus driver.  The vfio-pci module is an example
> > > > > +of a bus driver.  This module registers devices along with a set of bus
> > > > > +specific callbacks with the VFIO core.  These callbacks provide the
> > > > > +interfaces later used for device access.  As each new group is created,
> > > > > +as determined by iommu_device_group(), VFIO creates a /dev/vfio/$GROUP
> > > > > +character device.
> > > > 
> > > > Ok.. so, the fact that it's called "vfio-pci" suggests that the VFIO
> > > > bus driver is per bus type, not per bus instance.   But grouping
> > > > constraints could be per bus instance, if you have a couple of
> > > > different models of PCI host bridge with IOMMUs of different
> > > > capabilities built in, for example.
> > > 
> > > Yes, vfio-pci manages devices on the pci_bus_type; per type, not per bus
> > > instance.
> > 
> > Ok, how can that work.  vfio-pci is responsible for generating the
> > groupings, yes?  For which it needs to know the iommu/host bridge's
> > isolation capabilities, which vary depending on the type of host
> > bridge.
> 
> No, grouping is done at the iommu driver level.  vfio gets groupings via
> iomm_device_group(), which uses the iommu_ops for the bus_type of the
> requested device.  I'll attempt to clarify where groups come from in the
> documentation.

Hrm, but still per bus type, not bus instance.  Hrm.  Yeah, I need to
look at the earlier iommu patches in more detail.

[snip]
> > Yeah, I'm starting to get my head around the model, but the current
> > description of it doesn't help very much.  In particular the terms
> > "merge" and "unmerge" lead one to the wrong mental model, I think.
> > 
> > > > The semantics of "merge" and "unmerge" under those names are really
> > > > non-obvious.  Merge kind of has to merge two whole metagroups, but
> > > > it's unclear if unmerge reverses one merge, or just takes out one
> > > > (atom) group.  These operations need better names, at least.
> > > 
> > > Christian suggested a change to UNMERGE that we do not need to
> > > specify a group to unmerge "from".  This makes it more like a list
> > > implementation except there's no defined list_head.  Any member of the
> > > list can pull in a new entry.  Calling UNMERGE on any member extracts
> > > that member.
> > 
> > I think that's a good idea, but "unmerge" is not a good word for it.
> 
> I can't think of better, if you can, please suggest.

Well, I think addgroup and removegroup would be better than merge and
unmerge, although they have their own problems.

> > > > Then it's unclear what order you can do various operations, and which
> > > > order you can open and close various things.  You can kind of figure
> > > > it out but it takes far more thinking than it should.
> > > > 
> > > > 
> > > > So at the _very_ least, we need to invent new terminology and find a
> > > > much better way of describing this API's semantics.  I still think an
> > > > entirely different interface, where metagroups are created from
> > > > outside with a lifetime that's not tied to an fd would be a better
> > > > idea.
> > > 
> > > As we've discussed previously, configfs provides part of this, but has
> > > no ioctl support.  It doesn't make sense to me to go play with groups in
> > > configfs, but then still interact with them via a char dev.
> > 
> > Why not?  You configure, say, loopback devices with losetup, then use
> > them as a block device.  Similar with nbd.  You can configure serial
> > devices with setserial, then use them as a char dev.
> > 
> > >  It also
> > > splits the ownership model 
> > 
> > I'm not even sure what that means.
> > 
> > > and makes it harder to enforce who gets to
> > > interact with the devices vs who gets to manipulate groups.
> > 
> > How so.
> 
> Let's map out what a configfs interface would look like, maybe I'll
> convince myself it's on the table.  We'd probably start with

Hrm, assumin we used configfs, which is not the only option.

> /config/vfio/$bus_type.name/
> 
> That would probably be pre-populated with a bunch of $groupid files,
> matching /dev/vfio/$bus_type.name/$groupid char dev files (assuming
> configfs can pre-populate files).  To make a user defined group, we
> might then do:
> 
> mkdir /config/vfio/$bus_type.name/my_group
> 
> That would generate a /dev/vfio/$bus_type.name/my_group char dev.  To
> add groups to the new my_group "super group", we'd need to do something
> like:
> 
> ln -s /config/vfio/$bus_type.name/$groupidA /config/vfio/$bus_type.name/my_group/nic_group
> 
> I might then add a second group as:
> 
> ln -s /config/vfio/$bus_type.name/$groupidB /config/vfio/$bus_type.name/my_group/hba_group
> 
> Either link could fail if the target group is not viable,

The link op shouldn't fail because the subgroup isn't viable.
Instead, the supergroup jusy won't be viable until all devices in all
subgroups are bound to vfio.

> the group is
> already in use, or the second link could fail if the iommu domains were
> incompatible.
> 
> Do these links cause /dev/vfio/$bus_type.name/{$groupidA,$groupidB} to
> disappear?  If not, do we allow them to be opened?  Linking would also
> have to fail if we later tried to link one of these groupids to a
> different super group.

Again, I think some confusion is coming in here from calling both the
hardware determined thing and the admin determined thing a "group".
So for now I'm going to call the first a "group" and the second a
"predomain" (because once it's viable and the right conditions are set
up it will become an iommu domain).

So another option is that "groups" *only* participate in the merging
interface; getting iommu and device handles occurs only on a
predomain.  Therefore there would be no /dev/vfio/$group, you would
have to configure a predomain with at least one group before you had a
device file.

> Now we want to give my_group to a user, so we have to go back to /dev
> and
> 
> chown $user /dev/vfio/$bus_type.name/my_group
> 
> At this point my_group would have the existing set of group ioctls sans
> {UN}MERGE, of course.
> 
> So $user can use the super group, but not manipulate it's members.  Do
> we then allow:
> 
> chown $user /config/vfio/$bus_type.name/my_group
> 
> If so, what does it imply about the user then doing:
> 
> ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/stolen_group
> 
> Would we instead need to chown the configfs groups as well as the super
> group?
> 
> chown $user /config/vfio/$bus_type.name/my_group
> chown $user /config/vfio/$bus_type.name/$groupidA
> chown $user /config/vfio/$bus_type.name/$groupidB
> 
> ie:
> 
> # chown $user:$user /config/vfio/$bus_type.name/$groupC
> $ ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/given_group

This is not the only option.  We could also do:

cd /config/vfio
mkdir new_predomain
echo $groupid > new_predomain/addgroup
chown $user /dev/vfio/new_predomain

This is assuming that configuration of predomains is a root only
operation, which seems reasonable to me.

> (linking has to look at the permissions of the target as well as the
> link name)

Which would be unexpected and therefore a bad idea.

> Now we've introduced that we have ownership of configfs entries, what
> does that imply about the char dev entries?  For instance, can $userA
> own /dev/vfio/$bus_type.name/$groupidA, but $userB own the configfs
> file?  We also have another security consideration that an exploit on
> the host might allow a 3rd party to insert a device into a group.
> 
> This is where I start to get lost in the complexity versus simply giving
> the user permissions for the char dev and allowing them to stick groups
> together so long as the have permissions for the group.
> 
> We also add an entire filesystem to the interface that already spans
> sysfs, dev, eventfds and potentially netlink.
> 
> If terminology is the complaint against the {UN}MERGE ioctl interface,
> I'm still not sold that configfs is the answer.  /me goes to the
> thesaurus... amalgamate? blend? combine? cement? unite? join?

A thesaurus won't help, my point is you want something with a
*different* meaning to merge, which implies a symmetry not present in
this operation.

[snip]
> > Hrm.  "ANY" just really bothers me because "any iova" is not as clear
> > a concept as it first appears.  For starters it's actually "any page
> > aligned" at the very least.  But then it's only any 64-bit address for
> > busses which have full 64-bit addressing (and I do wonder if there are
> > any north bridges out there that forgot to implement some of the upper
> > PCI address bits properly, given that 64-bit CPUs rarely actually
> > implement more than 40-something physical address bits in practice).
> > 
> > I'd prefer to see at least something to advertise min and max IOVA and
> > IOVA alignment.  That's enough to cover x86 and POWER, including
> > possible variants with an IOMMU page size different to the system page
> > size (note that POWER kernels can have 64k pages as a config option,
> > which means a TCE page size different to the system page size is quite
> > common).
> > 
> > Obviously there could be more complex constraints that we would need
> > to advertise with option bits.
> 
> x86 has limitations as well.   I don't think most x86 IOMMUs support a
> full 64bit IOVA space, so point take.
> 
> struct vfio_iommu_info {
> 	__u64	len;	/* or structlen/arglen */
> 	__u64	flags;	/* replaces VFIO_IOMMU_GET_FLAGS, none defined yet */
> 	__u64	iova_max;
> 	__u64	iova_min;
> 	__u64	granularity;
> };
> 	
> #define VFIO_IOMMU_GET_INFO              _IOR(';', xxx, struct vfio_iommu_info)

Yeah, this looks like what I was after.

> Is granularity the minimum granularity, typically PAGE_SIZE barring
> special configurations noted above, or is it a bitmap of supported
> granularities?  Ex. If we support 4k normal pages and 2M large pages, we
> might set bits 12 and 21.

Just minimum, I think.  I'd prefer 'alignment' to 'granularity' I
think, but I don't care that much.

> > > > > +
> > > > > +The (UN)MAP_DMA commands make use of struct vfio_dma_map for mapping
> > > > > +and unmapping IOVAs to process virtual addresses:
> > > > > +
> > > > > +struct vfio_dma_map {
> > > > > +        __u64   len;            /* length of structure */
> > > > 
> > > > Thanks for adding these structure length fields.  But I think they
> > > > should be called something other than 'len', which is likely to be
> > > > confused with size (or some other length that's actually related to
> > > > the operation's parameters).  Better to call it 'structlen' or
> > > > 'argslen' or something.
> > > 
> > > Ok.  As Scott noted, I've failed to implement these in a way that
> > > actually allows extension, but I'll work on it.
> > 
> > Right.  I had failed to realise quite how the encoding of structure
> > size into the ioctl worked.  With that in place, arguably we don't
> > really need the size in the structure itself, because we can still
> > have multiple sized versions of the ioctl.  Still, whichever.
> 
> Hmm, that might be cleaner than eliminating the size with just using
> _IO().  So we might have something like:
> 
> #define VFIO_IOMMU_MAP_DMA              _IOWR(';', 106, struct vfio_dma_map)
> #define VFIO_IOMMU_MAP_DMA_V2           _IOWR(';', 106, struct vfio_dma_map_v2)
> 
> For which the driver might do:
> 
> case VFIO_IOMMU_MAP_DMA:
> case VFIO_IOMMU_MAP_DMA_V2:
> {
> 	struct vfio_dma_map map;
> 
> 	/* We don't care about the extra v2 bits */
> 	if (copy_from_user(&map, (void __user *)arg, sizeof map))
> 		return -EFAULT;
> ...
> 
> That presumes v2 is compatible other than extra fields.

Right, as does having the length in the structure itself.

> Any objections
> (this gets rid of length from all ioctl passed structs)?

Not from here.

[snip]
> > No, my concept was that NONE would be used for the indexes where there
> > is no valid BAR.  I'll buy your argument on why not to include the PCI
> > (or whatever) address space type here.
> > 
> > What I'm just a bit concerned by is whether we could have a case (not
> > for PCI) of a real resource that still has size 0 - e.g. maybe some
> > sort of doorbell that can't be read or written, but can be triggered
> > some other way.  I guess that's probably unlikely though.
> 
> Right, and if somehow you had such a region where the size is zero, but
> allowed some kind of operation on it, we could define a flag for it.

Hrm, I guess.

[snip]
> > > Other devices could certainly have multiple level interrupts, and if
> > > grouping them as we do with MSI on PCI makes sense, please let me know.
> > > I just didn't see the value in making the unmask operations handle
> > > sub-indexes if it's not needed.
> > 
> > I don't know of anything off hand.  But I can't see any consideration
> > that would make it unlikely either.  I generally don't trust anything
> > *not* to exist in embedded space.
> 
> Fair enough.  Level IRQs are still triggered individually, so unmasking
> is too, which means UNMASK_IRQ takes something like { int index; int
> subindex }.
> 
> SET_UNMASK_IRQ_EVENTFDS should follow SET_IRQ_EVENTFDS and take { int
> index; int count; int fds[] }.

Ok.

[snip]
> > > > Use of "read" and "write" in DMA can often be confusing, since it's
> > > > not always clear if you're talking from the perspective of the CPU or
> > > > the device (_writing_ data to a device will usually involve it doing
> > > > DMA _reads_ from memory).  It's often best to express things as DMA
> > > > direction, 'to device', and 'from device' instead.
> > > 
> > > Good point.
> > 
> > This, of course, potentially affects many areas of the code and doco.
> 
> I've changed vfio_iommu to use <linux/dma-direction.h> definitions
> internally.  For the ioctl I've so far simply included WRITE and READ
> flags, which I can clarify are from the device perspective.  Flags like
> VFIO_DMA_MAP_FLAG_TO_DEVICE/FROM_DEVICE are actually more confusing to
> me at this interface level.  We also have IOMMU_READ/IOMMU_WRITE which
> makes me question using dma-direction.h and if we shouldn't just define
> everything as from the device perspective.

Ok, sounds like a good start.  In some contexts read/write are clear,
in others they're not.  Just something to keep in mind.

[snip]
> > Right, but I'm not just talking about the current map/unmap calls
> > themselves.  This infrastructure for tracking it looks like it's
> > intended to be generic for all mapping methods.  If not, I can't see
> > the reason for it, because I don't think the current interface
> > requires such tracking inherently.
> 
> It does seem that way, but there is a purpose.  We need to unmap
> everything on release.  It's easy to assume that iommu_domain_free()
> will unmap everything from the IOMMU, which it does, but we've also done
> a get_user_pages on each of those in vfio, which we need to cleanup.  We
> can't rely on userspace to do this since they might have been SIGKILL'd.
> Making it generic with coalescing of adjacent regions and such is
> primarily for space efficiency.


Ah, I see.  Much as generic infrastructure is nice when we can do it,
I think this consideration will have to be pushed down to the iommu
driver layer.  For e.g. on power, we have all the information we need
to do the page tracking; any write to a TCE put()s the page that was
previously in that entry (if any) as well as get()ing the one that's
going in (if any).  It's just that we don't want to keep track in this
generic data structure _as well as_ the one that's natural for the
hardware.

> <snip>
> > > > > +#ifdef CONFIG_COMPAT
> > > > > +static long vfio_iommu_compat_ioctl(struct file *filep,
> > > > > +				    unsigned int cmd, unsigned long arg)
> > > > > +{
> > > > > +	arg = (unsigned long)compat_ptr(arg);
> > > > > +	return vfio_iommu_unl_ioctl(filep, cmd, arg);
> > > > 
> > > > Um, this only works if the structures are exactly compatible between
> > > > 32-bit and 64-bit ABIs.  I don't think that is always true.
> > > 
> > > I think all our structure sizes are independent of host width.  If I'm
> > > missing something, let me know.
> > 
> > Ah, for structures, that might be true.  I was seeing the bunch of
> > ioctl()s that take ints.
> 
> Ugh, I suppose you're thinking of an ILP64 platform with ILP32 compat
> mode.  Darn it, guess we need to make everything 64bit, including file
> descriptors.

Well, we don't _have_ to, but if we don't then we have to implement
compat wrappers for every non explicit width thing we pass through.

> <snip>
> > > > > +
> > > > > +/* Get a new iommu file descriptor.  This will open the iommu, setting
> > > > > + * the current->mm ownership if it's not already set. */
> > > > 
> > > > I know I've had this explained to me several times before, but I've
> > > > forgotten again.  Why do we need to wire the iommu to an mm?
> > > 
> > > We're mapping process virtual addresses into the IOMMU, so it makes
> > > sense to restrict ourselves to a single virtual address space.  It also
> > > enforces the ownership, that only a single mm is in control of the
> > > group.
> > 
> > Neither of those seems conclusive to me, but I remember that I saw a
> > strong reason earlier, even if I can't remember it now.
> 
> The point of the group is to provide a unit of ownership.  We can't let
> $userA open $groupid and fetch a device, then have $userB do the same,
> grabbing a different device.  The mappings will step on each other and
> the devices have no isolation.  We can't restrict that purely by file
> permissions or we'll have the same problem with sudo.  At one point we
> discussed a single open instance, but that unnecessarily limits the
> user, so we settled on the mm.  Thanks,

Hm, ok.

Fyi, I'll be kind of slow in responses for the next while.  I broke a
bone in my hand on Friday :(.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

