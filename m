Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3685 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbaGaQko (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 12:40:44 -0400
Message-ID: <53DA718A.9040407@intel.com>
Date: Thu, 31 Jul 2014 09:40:42 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>
CC: linux-pci@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <53DA5EF4.1030500@intel.com> <53DA674A.9030305@solarflare.com>
In-Reply-To: <53DA674A.9030305@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/31/2014 08:56 AM, Edward Cree wrote:
> On 31/07/14 16:21, Alexander Duyck wrote:
>> However if you are wanting to use this as a way to disable SR-IOV for a
>> device I wouldn't recommend it.  Based on what you have described I
>> would suggest dropping the fix in drivers/pci/quirks that would clear
>> dev->is_physfn if you are in the PF-IOV mode.  That way the SR-IOV
>> functionality should be fully disabled.
> I still don't see how this can go in drivers/pci/quirks, because PF-IOV
> mode can only be detected at driver probe time.  The way we find out
> that the NIC is in PF-IOV mode is that a request to the MC (the
> Management CPU on the card) to create a vswitch fails.  But maybe I'm
> wrong about what quirks can do - is there any relevant documentation?

If this PF-IOV mode is enabled what would be the layout of the PF
devices?  It seems like you should be able to scan for multiple PFs all
showing up on the same bus with a certain stride if you wanted to detect it.

> Clearing dev->is_physfn in the driver probe routine isn't safe:
> dev->sriov memory can get leaked, for example, as sriov_init will get
> called at device add, but sriov_release won't be called at removal.

Thanks for pointing that out.  It seems like that is a bug.  We should
probably be checking for dev->sriov, not dev->is_physfn before calling
sriov_release.

I might see about submitting a patch to address that.

> I'm also unconvinced that having !(dev->is_physfn || dev->is_virtfn) is
> a valid state; but maybe I'm misunderstanding and "is_physfn" doesn't
> actually mean "is a physical function", but rather "has SR-IOV capability".

is_physfn is typically used to indicate the device is capable of acting
as a physical function.  So a non-IOV device will not set either
is_physfn or is_virtfn.

>> In addition this solution would
>> also resolve the fact that the driver wouldn't actually have to be
>> loaded for it to work so if someone were to load a driver that didn't
>> contain the fix they would be blocked from enabling SR-IOV as well.
> The current driver fails to probe the PF because it assumes the vswitch
> creation failure is fatal.  There should never be a driver that knows it
> can live without the vswitch but doesn't know that that breaks SR-IOV.
> 
> -Edward

Is the vswitch a hard requirement for something other than SR-IOV?  If
not then maybe you should consider modifying the driver so it simply
disabled SR-IOV if you cannot allocate the vswitch instead of blocking
probe.

Thanks,

Alex

P.S.  You should really consider changing your email signature.  The bit
about "you may not use, copy or disclose to anyone this message" kind of
goes against the whole point of submitting patches to an open source
project.

