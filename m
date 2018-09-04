Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEBnK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 21:43:10 -0400
Subject: Re: [PATCH for-rc 1/2] PCI: Fix faulty logic in pci_reset_bus()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        bhelgaas@google.com, dledford@redhat.com,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
 <20180831173359.21741.61944.stgit@scvm10.sc.intel.com>
 <590c7cc7-b6e7-5ac6-9f4d-5b4b1fbc1e29@codeaurora.org>
 <20180904205956.GA14349@ziepe.ca>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0658445a-5c73-1aba-31f9-6162fc69d5cc@codeaurora.org>
Date: Tue, 4 Sep 2018 14:16:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180904205956.GA14349@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 1:59 PM, Jason Gunthorpe wrote:
> On Fri, Aug 31, 2018 at 10:58:32AM -0700, Sinan Kaya wrote:
>> On 8/31/2018 10:34 AM, Dennis Dalessandro wrote:
>>> The pci_rest_bus() function calls into pci_probe_reset_slot() to determine
>>> whether to call the slot or bus reset. The check has faulty logic in that
>>> it does not account for pci_probe_reset_slot() being able to return an
>>> errno. Fix by only calling the slot reset when the function returns 0.
>>> Treat < 1 and > 1 the same.
>>>
>>> Cc: Sinan Kaya<okaya@codeaurora.org>
>>> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
>>> Reviewed-by: Michael J. Ruhl<michael.j.ruhl@intel.com>
>>> Signed-off-by: Dennis Dalessandro<dennis.dalessandro@intel.com>
>>
>> Nit. Small typo on the first sentence (pci_rest_bus()).
>>
>> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> 
> Bjorn,
> 
> Are you OK to apply this series through the RDMA tree (for rc3), or do
> you want to take it through PCI?
> 
> https://patchwork.kernel.org/patch/10584277/

Please don't apply the entire series yet. First patch is good to go.

Second one is a hack. We are trying to find a better solution for the second
patch.

https://bugzilla.kernel.org/show_bug.cgi?id=200985


> 
> Thanks,
> Jason
> 
