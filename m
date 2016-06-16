Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0099.outbound.protection.outlook.com ([157.55.234.99]:3957
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753867AbcFPMqp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2016 08:46:45 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: RE: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF device to be
 in the PFs IOMMU group
Date: Thu, 16 Jun 2016 12:46:41 +0000
Message-ID: <VI1PR0501MB19683B2502B9B5B865B121DBD4560@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
	<1465474173-53960-3-git-send-email-ilyal@mellanox.com>
	<20160609162120.43082847@ul30vt.home>
	<VI1PR0501MB1968BCE6073C3DD40C8DA2AED4530@VI1PR0501MB1968.eurprd05.prod.outlook.com>
 <20160613100041.6b6a025e@ul30vt.home>
In-Reply-To: <20160613100041.6b6a025e@ul30vt.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

You've convinced us that we should use separate groups.
But If I do that I can't think of a clean way to force the VFs to be probed by VFIO.

The ideas I have are:
	1. Add a driver_override parameter to pci_enable_sriov, sriov_enable  and virtfn_add.
	2. Register to the bus notifier of the PF's bus before calling pci_enable_sriov and then override the
	Driver in BUS_NOTIFY_ADD_DEVICE event like I did in the IOMMU group notifier when the group was shared.

Do you have a better idea? or a recommendation as to which of my ideas I should use?

Thank,
Ilya
	
> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Monday, June 13, 2016 7:01 PM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com;
> Noa Osherovich <noaos@mellanox.com>; Haggai Eran
> <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss
> <liranl@mellanox.com>
> Subject: Re: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF device to
> be in the PFs IOMMU group
> 
> On Mon, 13 Jun 2016 07:08:03 +0000
> Ilya Lesokhin <ilyal@mellanox.com> wrote:
> 
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Friday, June 10, 2016 1:21 AM
> > > To: Ilya Lesokhin <ilyal@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org;
> > > bhelgaas@google.com; Noa Osherovich <noaos@mellanox.com>; Haggai
> > > Eran <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>;
> > > Liran Liss <liranl@mellanox.com>
> > > Subject: Re: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF
> > > device to be in the PFs IOMMU group
> > ...
> > > This deserves a comment in the code as well as the commit log, but
> > > more importantly the side effect of this is that the user can't make
> > > use of separate IOMMU domains for the PF vs the VF.  I think this
> > > ends up making the entire solution incompatible with things like
> > > vIOMMU since we really need to be able to create separate address
> > > spaces per device to make that work.  What's the point of enabling
> > > SR-IOV from userspace if we can't do things like assign VFs to
> > > nested guests or userspace in the guest?  This is an incomplete feature
> with that restriction.
> >
> > I agree that this is a problem and I will mention this limitation in the commit
> log.
> > However to address this properly you need nested IOMMU group which
> don't really exist.
> > This feature is still useful, at least for us, as you can enable sriov
> > in a guest and work with probed VFs in the same guest.
> > Furthermore, if you have a real nested IOMMU you should be able to do
> > nested device assignment even though the PF and VF's belong to the same
> group.
> >
> > I think we should push this feature with the limitation and hopefully
> > it will be addressed in the future, agree?
> 
> Sorry, I don't agree, nor do I think that nested IOMMU groups are the
> solution to the problem (or even really understand what nest IOMMU
> groups are).  It seems we have an issue that an untrusted user is creating
> devices and we're trying to overload the concept of an IOMMU group to
> handle that.  An IOMMU group is meant to describe the DMA isolation of a
> set of devices, so it really has no business being overloaded to enforce
> ownership like this, nor can we assume that we can support multiple IOMMU
> contexts within a group regardless of a "real nested IOMMU".  We already
> see coming a very serious usage restriction that a user cannot create
> independent IOMMU contexts as a direct result of this hack, which severely
> limits future usefulness.  I don't know what the solution is here, but I'm
> pretty sure this is not it.  Thanks,
> 
> Alex
