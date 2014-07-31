Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34479 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaGaRzv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 13:55:51 -0400
Message-ID: <53DA8326.1030705@intel.com>
Date: Thu, 31 Jul 2014 10:55:50 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>
CC: linux-pci@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com>
In-Reply-To: <53DA7574.4050103@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/31/2014 09:57 AM, Edward Cree wrote:
> On 31/07/14 17:40, Alexander Duyck wrote:
>> If this PF-IOV mode is enabled what would be the layout of the PF
>> devices?  It seems like you should be able to scan for multiple PFs all
>> showing up on the same bus with a certain stride if you wanted to detect it.
> Alas, it's (once again) more complicated than that.  There's another
> mode, NIC partitioning, which has multiple PFs per port but connected
> with a VLAN aggregator rather than a v-switch, which means that each PF
> then can support VFs (the firmware limitation is that v-switches can't
> be stacked).
> So having multiple PFs on the port doesn't necessarily mean we can't do
> SR-IOV.

Okay, so this is purely a vswitch issue then.  If it is allocated for
the PF-IOV it isn't available for SR-IOV.  I think I understand now.

>>>> In addition this solution would
>>>> also resolve the fact that the driver wouldn't actually have to be
>>>> loaded for it to work so if someone were to load a driver that didn't
>>>> contain the fix they would be blocked from enabling SR-IOV as well.
>>> The current driver fails to probe the PF because it assumes the vswitch
>>> creation failure is fatal.  There should never be a driver that knows it
>>> can live without the vswitch but doesn't know that that breaks SR-IOV.
>>>
>>> -Edward
>> Is the vswitch a hard requirement for something other than SR-IOV?  If
>> not then maybe you should consider modifying the driver so it simply
>> disabled SR-IOV if you cannot allocate the vswitch instead of blocking
>> probe.
>>
> That's exactly what I'm trying to do with pci_sriov_set_totalvfs(dev,
> 0); that's the whole point.

It sounds reasonable.  My only real concern is the fact that the error
reported when attempting to enable the interface will be a ERANGE when
really a more appropriate error return might be something like a EBUSY
since it is the vswitch that is occupied.

You might want to take a look at modifying sriov_numvfs_store so that if
the only option is 0 you return EBUSY for all non-zero values requested.
 This way it will be more in sync with how we handle the case of
attempting to update the number of VFs when SR-IOV is already enabled.

Thanks,

Alex
