Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0071.outbound.protection.outlook.com ([157.55.234.71]:40211
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030181AbcFMHiU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2016 03:38:20 -0400
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Haggai Eran <haggaie@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Liran Liss <liranl@mellanox.com>
Subject: RE: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF device to be
 in the PFs IOMMU group
Date: Mon, 13 Jun 2016 07:08:03 +0000
Message-ID: <VI1PR0501MB1968BCE6073C3DD40C8DA2AED4530@VI1PR0501MB1968.eurprd05.prod.outlook.com>
References: <1465474173-53960-1-git-send-email-ilyal@mellanox.com>
	<1465474173-53960-3-git-send-email-ilyal@mellanox.com>
 <20160609162120.43082847@ul30vt.home>
In-Reply-To: <20160609162120.43082847@ul30vt.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, June 10, 2016 1:21 AM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; bhelgaas@google.com;
> Noa Osherovich <noaos@mellanox.com>; Haggai Eran
> <haggaie@mellanox.com>; Or Gerlitz <ogerlitz@mellanox.com>; Liran Liss
> <liranl@mellanox.com>
> Subject: Re: [PATCH 2/4] IOMMU: Force the VFs of an untrusted PF device to
> be in the PFs IOMMU group
...
> This deserves a comment in the code as well as the commit log, but more
> importantly the side effect of this is that the user can't make use of separate
> IOMMU domains for the PF vs the VF.  I think this ends up making the entire
> solution incompatible with things like vIOMMU since we really need to be
> able to create separate address spaces per device to make that work.  What's
> the point of enabling SR-IOV from userspace if we can't do things like assign
> VFs to nested guests or userspace in the guest?  This is an incomplete
> feature with that restriction.

I agree that this is a problem and I will mention this limitation in the commit log.
However to address this properly you need nested IOMMU group which don't really exist.
This feature is still useful, at least for us, as you can enable sriov in a guest and work with
probed VFs in the same guest.
Furthermore, if you have a real nested IOMMU you should be able to do nested device 
assignment even though the PF and VF's belong to the same group.

I think we should push this feature with the limitation and hopefully
it will be addressed in the future, agree?

Thanks,
Ilya
