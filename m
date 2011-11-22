Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab1KVSXb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Nov 2011 13:23:31 -0500
Message-ID: <1321986177.484.92.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <dwg@au1.ibm.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Tue, 22 Nov 2011 11:22:57 -0700
In-Reply-To: <20111121024742.GA6575@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <20111115063431.GA4921@truffala.fritz.box>
	 <1321380088.17169.282.camel@bling.home>
	 <20111117000218.GB5411@truffala.fritz.box>
	 <1321648376.26410.238.camel@bling.home>
	 <20111121024742.GA6575@truffala.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2011-11-21 at 13:47 +1100, David Gibson wrote:
> On Fri, Nov 18, 2011 at 01:32:56PM -0700, Alex Williamson wrote:
> > On Thu, 2011-11-17 at 11:02 +1100, David Gibson wrote:
> > > On Tue, Nov 15, 2011 at 11:01:28AM -0700, Alex Williamson wrote:
> > > > On Tue, 2011-11-15 at 17:34 +1100, David Gibson wrote:
> > > > > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
<snip> 
> > > > As we've discussed previously, configfs provides part of this, but has
> > > > no ioctl support.  It doesn't make sense to me to go play with groups in
> > > > configfs, but then still interact with them via a char dev.
> > > 
> > > Why not?  You configure, say, loopback devices with losetup, then use
> > > them as a block device.  Similar with nbd.  You can configure serial
> > > devices with setserial, then use them as a char dev.
> > > 
> > > >  It also
> > > > splits the ownership model 
> > > 
> > > I'm not even sure what that means.
> > > 
> > > > and makes it harder to enforce who gets to
> > > > interact with the devices vs who gets to manipulate groups.
> > > 
> > > How so.
> > 
> > Let's map out what a configfs interface would look like, maybe I'll
> > convince myself it's on the table.  We'd probably start with
> 
> Hrm, assumin we used configfs, which is not the only option.

I'm not writing vfiofs, configfs seems most like what we'd need.  If
there are others we should consider, please note them.

> > /config/vfio/$bus_type.name/
> > 
> > That would probably be pre-populated with a bunch of $groupid files,
> > matching /dev/vfio/$bus_type.name/$groupid char dev files (assuming
> > configfs can pre-populate files).  To make a user defined group, we
> > might then do:
> > 
> > mkdir /config/vfio/$bus_type.name/my_group
> > 
> > That would generate a /dev/vfio/$bus_type.name/my_group char dev.  To
> > add groups to the new my_group "super group", we'd need to do something
> > like:
> > 
> > ln -s /config/vfio/$bus_type.name/$groupidA /config/vfio/$bus_type.name/my_group/nic_group
> > 
> > I might then add a second group as:
> > 
> > ln -s /config/vfio/$bus_type.name/$groupidB /config/vfio/$bus_type.name/my_group/hba_group
> > 
> > Either link could fail if the target group is not viable,
> 
> The link op shouldn't fail because the subgroup isn't viable.
> Instead, the supergroup jusy won't be viable until all devices in all
> subgroups are bound to vfio.

The supergroup may already be in use if it's a hotplug.  What does it
mean to have an incompatible group linked into the supergroup?  When
does the subgroup actually become part of the supergroup?  Does the
userspace driver using the supergroup get notified somehow?  Does the
vfio driver get notified independently?  This example continues to show
what an administration nightmare it becomes when we split management
from usage.

> > the group is
> > already in use, or the second link could fail if the iommu domains were
> > incompatible.
> > 
> > Do these links cause /dev/vfio/$bus_type.name/{$groupidA,$groupidB} to
> > disappear?  If not, do we allow them to be opened?  Linking would also
> > have to fail if we later tried to link one of these groupids to a
> > different super group.
> 
> Again, I think some confusion is coming in here from calling both the
> hardware determined thing and the admin determined thing a "group".
> So for now I'm going to call the first a "group" and the second a
> "predomain" (because once it's viable and the right conditions are set
> up it will become an iommu domain).
> 
> So another option is that "groups" *only* participate in the merging
> interface; getting iommu and device handles occurs only on a
> predomain.  Therefore there would be no /dev/vfio/$group, you would
> have to configure a predomain with at least one group before you had a
> device file.

I think this actually leads to a more complicated, more difficult to use
interface that interposes an unnecessary administration layer into a
driver's decisions about how to manage the iommu.

> > Now we want to give my_group to a user, so we have to go back to /dev
> > and
> > 
> > chown $user /dev/vfio/$bus_type.name/my_group
> > 
> > At this point my_group would have the existing set of group ioctls sans
> > {UN}MERGE, of course.
> > 
> > So $user can use the super group, but not manipulate it's members.  Do
> > we then allow:
> > 
> > chown $user /config/vfio/$bus_type.name/my_group
> > 
> > If so, what does it imply about the user then doing:
> > 
> > ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/stolen_group
> > 
> > Would we instead need to chown the configfs groups as well as the super
> > group?
> > 
> > chown $user /config/vfio/$bus_type.name/my_group
> > chown $user /config/vfio/$bus_type.name/$groupidA
> > chown $user /config/vfio/$bus_type.name/$groupidB
> > 
> > ie:
> > 
> > # chown $user:$user /config/vfio/$bus_type.name/$groupC
> > $ ln -s /config/vfio/$bus_type.name/$groupidC /config/vfio/$bus_type.name/my_group/given_group
> 
> This is not the only option.  We could also do:
> 
> cd /config/vfio
> mkdir new_predomain
> echo $groupid > new_predomain/addgroup
> chown $user /dev/vfio/new_predomain

echo $groupid > new_predomain/delgroup
SEGV... Now we've included yet another admin path in the hotplug case as
the userspace driver needs to coordinate removal of groups with some
other entity.

> This is assuming that configuration of predomains is a root only
> operation, which seems reasonable to me.

I think it should be a driver decision.  Let's go back to the purpose of
this interface.  We want to give *devices* to userspace drivers.  Groups
are any unfortunate side-effect of hardware topology, so instead of
giving the user a device, we give it a group that contains the device.
It's a driver optimization that they can say "oh, I wonder if I can use
the same iommu descriptor to drive both of these, let me try to merge
them...".  That results in "worked, yay" skip initializing a new iommu
object OR "nope, oh well".  Adding an admin layer that presupposes that
they should be merged and does it adds nothing for the better.

> > (linking has to look at the permissions of the target as well as the
> > link name)
> 
> Which would be unexpected and therefore a bad idea.

Another indication that this is the wrong interface.

> > Now we've introduced that we have ownership of configfs entries, what
> > does that imply about the char dev entries?  For instance, can $userA
> > own /dev/vfio/$bus_type.name/$groupidA, but $userB own the configfs
> > file?  We also have another security consideration that an exploit on
> > the host might allow a 3rd party to insert a device into a group.
> > 
> > This is where I start to get lost in the complexity versus simply giving
> > the user permissions for the char dev and allowing them to stick groups
> > together so long as the have permissions for the group.
> > 
> > We also add an entire filesystem to the interface that already spans
> > sysfs, dev, eventfds and potentially netlink.
> > 
> > If terminology is the complaint against the {UN}MERGE ioctl interface,
> > I'm still not sold that configfs is the answer.  /me goes to the
> > thesaurus... amalgamate? blend? combine? cement? unite? join?
> 
> A thesaurus won't help, my point is you want something with a
> *different* meaning to merge, which implies a symmetry not present in
> this operation.

But there is symmetry in a merged group, let's look at the operations on
a group (note I've updated some of the ioctls since last posting):

VFIO_GROUP_GET_INFO

        This returns a structure containing flags for the group, when
        merged it represents the merged group.

VFIO_GROUP_GET_DEVICE_FD

        This returns a file descriptor for the device described by the
        given char*, when merged it operates across all groups within
        the merged set.

VFIO_GROUP_GET_IOMMU_FD

        Return a file descriptor for the iommu, when merged there's a
        single iommu across the merged group.

VFIO_GROUP_MERGE

        Pull a singleton group into a merge.  This can be called on any
        member of a merged group to pull a singleton group into the
        merged set.

VFIO_GROUP_UNMERGE

        Extract the group from the merged set.

Where is the discontinuity with calling this symmetric?  Is it simply
that we have an entry point to the supergroup at each subgroup?  Forming
a new node when groups are merged is a limitation, not a feature, and
imposes a number of administration issues (ownership, creation,
deletion, addition, subtraction, notifications, etc).  Is it that we can
only merge singletons?  This is an implementation restriction, not an
API restriction.  If you want to go to the trouble of determining that
the existing IOMMU mappings are compatible and can atomically merge
them, the singleton could instead be a member of another supergroup.  We
currently can't do this atomically, and as merging is an optimization, I
leave the burden on userspace to split supergroups if they want to merge
with another group.

I'm not sure why this is such a thorn since aiu the power iommu
topology, you're going to have IOVA windows per group that really can't
make use of the merge interface.  This is mostly useful for "MAP_ANY"
style IOMMUs.  Do you really want to impose the administrative overhead
of predomains for a feature you're not likely to use?

<snip>
> [snip]
> > > Right, but I'm not just talking about the current map/unmap calls
> > > themselves.  This infrastructure for tracking it looks like it's
> > > intended to be generic for all mapping methods.  If not, I can't see
> > > the reason for it, because I don't think the current interface
> > > requires such tracking inherently.
> > 
> > It does seem that way, but there is a purpose.  We need to unmap
> > everything on release.  It's easy to assume that iommu_domain_free()
> > will unmap everything from the IOMMU, which it does, but we've also done
> > a get_user_pages on each of those in vfio, which we need to cleanup.  We
> > can't rely on userspace to do this since they might have been SIGKILL'd.
> > Making it generic with coalescing of adjacent regions and such is
> > primarily for space efficiency.
> 
> 
> Ah, I see.  Much as generic infrastructure is nice when we can do it,
> I think this consideration will have to be pushed down to the iommu
> driver layer.  For e.g. on power, we have all the information we need
> to do the page tracking; any write to a TCE put()s the page that was
> previously in that entry (if any) as well as get()ing the one that's
> going in (if any).  It's just that we don't want to keep track in this
> generic data structure _as well as_ the one that's natural for the
> hardware.

There are few users of the IOMMU API, maybe we can negotiate this.  I
also expect as power gets added, we'll need to make the vfio_iommu layer
more modular.  It's possible you won't make use of this iommu object and
can leave page tracking to the iommu.  I think that can be done within
the existing API though.  Thanks,

Alex

