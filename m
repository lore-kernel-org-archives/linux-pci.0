Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:32672 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBWKr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 05:47:27 -0500
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de>
 <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
 <9cdc8c1c-b448-b00b-d5b8-b664bd96f856@ti.com>
 <20180223093611.GA25086@e107981-ln.cambridge.arm.com>
CC: Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a7070bd0-72b7-4870-419e-7ac15c6825ae@ti.com>
Date: Fri, 23 Feb 2018 16:17:15 +0530
MIME-Version: 1.0
In-Reply-To: <20180223093611.GA25086@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Friday 23 February 2018 03:06 PM, Lorenzo Pieralisi wrote:
> On Fri, Feb 23, 2018 at 11:40:49AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On Thursday 22 February 2018 11:49 PM, Lorenzo Pieralisi wrote:
>>> On Wed, Feb 21, 2018 at 01:47:06PM +0100, Rolf Evers-Fischer wrote:
>>>> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>>>>
>>>> This commit decreases the number of jump labels and ensures
>>>> that the next commit doesn't increase the number of occurrences
>>>> of 'kfree(func_name)'.
>>>>
>>>> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
>>>> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>>>> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
>>>> ---
>>>>  drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>>>> index 766ce1dca2ec..23d0e128d1a5 100644
>>>> --- a/drivers/pci/endpoint/pci-epf-core.c
>>>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>>>> @@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
>>>>  	*buf = '\0';
>>>>  
>>>>  	epf->name = kstrdup(func_name, GFP_KERNEL);
>>>> +	kfree(func_name);
>>>
>>> I am certainly missing something but what if we reworked the code
>>> and just:
>>>
>>> kstrdup(name, GFP_KERNEL);
>>>
>>> once instead of allocating another local copy (that we then have to
>>> free) ?
>>
>> name will be something like pci_epf_test.0 and in epf->name we want to just
>> have pci_epf_test.
>>>
>>> Reworded: why
>>>
>>> epf->name = func_name;
>>
>> memory should be allocated for epf->name before it can be initialized. IMO
>> without kstrdup, there will be a null pointer exception.
> 
> I understand that but the point is that func_name *was* allocated with
> kstrdup() already I would like to understand why we need to do it twice
> (and kfree the first allocation).

func_name would be allocated for a size greater than what will be in epf->name.
It won't be significant though.

Thanks
Kishon
