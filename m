Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17947 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbaG3VOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Jul 2014 17:14:20 -0400
Message-ID: <53D9602A.4010406@intel.com>
Date: Wed, 30 Jul 2014 14:14:18 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>, Don Dutile <ddutile@redhat.com>
CC: linux-pci@vger.kernel.org
Subject: Re: pci_sriov_set_totalvfs again
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com>
In-Reply-To: <53D93848.7070203@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/30/2014 11:24 AM, Edward Cree wrote:
> On 30/07/14 19:05, Don Dutile wrote:
>> On 07/30/2014 01:16 PM, Edward Cree wrote:
>>> Calling pci_sriov_set_totalvfs(dev, 0) has no effect, because
>>> pci_sriov_get_totalvfs ignores dev->sriov->driver_max_VFs if it's 0,
>>> as that is used as the 'not set' value.
>>> So, three questions:
>>> a) is this a bug?
>>> b) if not, should the comment on pci_sriov_set_totalvfs mention that
>>> passing numvfs=0 will be interpreted as numvfs=dev->sriov->total_VFs?
>>> c) is there a better way of indicating "current configuration doesn't
>>> support VFs" rather than calling set_totalvfs(0)?
>>>
>>> Thanks,
>>> -Edward
>>
>> The file shouldn't exist if the device doesn't provide an SRIOV
>> capability.
>> If it does, and it's not supported, then add a patch in quirks.c.
>>
>>
> I don't know much about quirks, but I'm not sure they're the answer
> here, as it's not quite as simple as "driver doesn't support it".
> It's a firmware / configuration issue, that if the device (it's a NIC)
> is configured a certain way [1], the VFs - while appearing fine from a
> PCI perspective - don't actually work (they can't pass traffic).
> We can't detect this misconfiguration until PF probe time, and we need a
> way to report that the VFs aren't usable.
> 
> Can quirks handle this?
> 
> -Edward
> 
> [1] SFC9120-based NICs support multiple PFs per port and these can be
> used as a kind of "poor-man's SR-IOV" (we're calling it 'PF-IOV') by
> placing the firmware v-switch below the PFs. However, this then
> precludes adding a v-switch above the PF to direct VF traffic, meaning
> that VFs are useless in this configuration. Consequently, our
> configuration tools won't allow VFs and PF-IOV to be enabled
> simultaneously, but bugs or corruption could cause this to happen.

My $.02 on the issue would be to simply have sriov_configure return an
error indicating the resources are not available if you have the PF-IOV
mode enabled it is consuming the VF v-switch resources.

Thanks,

Alex

