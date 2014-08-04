Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51444 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbaHDQkq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Aug 2014 12:40:46 -0400
Message-ID: <53DFB78D.4080309@intel.com>
Date: Mon, 04 Aug 2014 09:40:45 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>,
	Ethan Zhao <ethan.kernel@gmail.com>
CC: linux-pci <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vasundhara Volam <vasundhara.volam@emulex.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com> <53DB84E6.1070206@solarflare.com> <107835EF-8941-4621-952F-E1583F7E3636@gmail.com> <53DFAA8C.2010602@solarflare.com>
In-Reply-To: <53DFAA8C.2010602@solarflare.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/04/2014 08:45 AM, Edward Cree wrote:
> On 02/08/14 01:25, Ethan Zhao wrote:
>> 在 2014年8月1日，下午8:15，Edward Cree <ecree@solarflare.com> 写道：
>>> On 01/08/14 04:51, Ethan Zhao wrote:
>>>> So far seems no driver call pci_sriov_set_totalvfs() with numvfs = 0
>>>> and the patch will change the behavior of the drivers, but it will
>>>> definitely change the test cases and documents related to IOV.
>>> As for test cases and documents, I can't find any in the kernel tree
>> I mean some test cases or doc that are out of kernel tree ... such as some Distro,
>> not only Hardware vendors.
> I was under the impression that we don't care about breaking out-of-tree
> code.  Distros should be (and it looks like most are) using the
> kernel-doc to generate their documentation, and the kernel-doc doesn't
> say anything about what happens when passing 0.
> 
> -Edward

Edward,

The concern isn't what is out there, but what will come of it as a
result.  The question is should we allow setting the value to 0 to
change the behavior from disabling the override to essentially disabling
SR-IOV.

If we consider it acceptable to use 0 as a disable value, and there are
several people on this thread that don't, the secondary issue of this is
the error return for sriov_numvfs_store which hasn't been addressed.
Should we still be returning ERANGE if SR-IOV has essentially been
disabled, or should we be returning some other error such as EBUSY,
ENOMEM, ENODEV, or ENOSYS to indicate that there are no resources
available for SR-IOV.

I think you would be much better off just implementing sriov_configure
for your PCI driver and placing your own error return there if you
cannot allocate a vswitch.

Thanks,

Alex



