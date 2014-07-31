Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:46403 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbaGaSZB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 14:25:01 -0400
Message-ID: <53DA89DB.8010904@solarflare.com>
Date: Thu, 31 Jul 2014 19:24:27 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: <linux-pci@vger.kernel.org>, Don Dutile <ddutile@redhat.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com> <53DA8326.1030705@intel.com>
In-Reply-To: <53DA8326.1030705@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/07/14 18:55, Alexander Duyck wrote:
> It sounds reasonable.  My only real concern is the fact that the error
> reported when attempting to enable the interface will be a ERANGE when
> really a more appropriate error return might be something like a EBUSY
> since it is the vswitch that is occupied.
>
> You might want to take a look at modifying sriov_numvfs_store so that if
> the only option is 0 you return EBUSY for all non-zero values requested.
>  This way it will be more in sync with how we handle the case of
> attempting to update the number of VFs when SR-IOV is already enabled.
Seems mostly reasonable for sfc, but I wonder if EBUSY would necessarily
be appropriate for all devices.  Other devices might have other reasons
why their driver_max_VFs is zero.
So I think it's best to leave it as ERANGE - the proximate reason why
numvfs can't be set is because totalvfs is 0; for the reason why
totalvfs is 0, user can look at the logs.
But I'm open to being persuaded otherwise.

-Edward
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
