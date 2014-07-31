Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbaGaRx6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 13:53:58 -0400
Message-ID: <53DA82AF.7000503@redhat.com>
Date: Thu, 31 Jul 2014 13:53:51 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com> <53DA718A.9040407@intel.com> <53DA7574.4050103@solarflare.com>
In-Reply-To: <53DA7574.4050103@solarflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/31/2014 12:57 PM, Edward Cree wrote:
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
>
Ed,
It is fairly obvious that your PCIe device operates in very unexpected,
non-std modes.
Ignore twiddling total-vfs, and just have the driver fail sriov
configuration when they can operate, print a warning why, and let's not create
complicated/convoluted hacks dependent on the use of various assumptions/uses
of pdev flags.
Ideally, when the device is configured in different modes, the SRIOV cap structure
should be modified so the pci sriov code doesn't try to act or reflect the
non-reality the device is in.

>> Thanks for pointing that out.  It seems like that is a bug.  We should
>> probably be checking for dev->sriov, not dev->is_physfn before calling
>> sriov_release.
>>
>> I might see about submitting a patch to address that.
> Unfortunately, that won't work because dev->sriov is in a union with
> dev->physfn (presumably on the grounds that if you have an associated
> PF, you're a VF, so you can't have VFs of your own).
> So I think the test in pci_iov_release is correct, and anyone changing
> dev->is_physfn after the PCI device has been set up is in the wrong.
>
>>> I'm also unconvinced that having !(dev->is_physfn || dev->is_virtfn) is
>>> a valid state; but maybe I'm misunderstanding and "is_physfn" doesn't
>>> actually mean "is a physical function", but rather "has SR-IOV capability".
>> is_physfn is typically used to indicate the device is capable of acting
>> as a physical function.  So a non-IOV device will not set either
>> is_physfn or is_virtfn.
> Ok, well I think a comment to that effect in struct pci_dev might be a
> good idea.
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
>> P.S.  You should really consider changing your email signature.  The bit
>> about "you may not use, copy or disclose to anyone this message" kind of
>> goes against the whole point of submitting patches to an open source
>> project.
>>
> I know; it's automatically appended by our mail server to all outgoing
> mail.  I've already raised this with our IT department but they haven't
> answered yet :(
>
> -Edward
> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

