Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeIOEOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Sep 2018 00:14:24 -0400
Subject: Re: [PATCH v2 1/6] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20180914211808.2564-1-okaya@kernel.org>
 <20180914211808.2564-2-okaya@kernel.org> <20180914162714.59b3837e@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3c55b92a-500c-9f53-84ed-0a5827f78066@kernel.org>
Date: Fri, 14 Sep 2018 18:57:49 -0400
MIME-Version: 1.0
In-Reply-To: <20180914162714.59b3837e@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/14/2018 6:27 PM, Alex Williamson wrote:
>> +int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
>>   {
>> -	int rc;
>> +	int rc = 0;
> What's the proper return value when a user passes zero for reset_type?
> It seems to currently be: user provided no options, therefore we tried
> none, therefore success.  I'm torn whether that's entirely bogus to the
> point of that we should WARN_ON (ie. caller bug), or simply return
> -EINVAL, which the caller can ignore, or if there's some value to allow
> the behavior here. Thanks,

Yeah, even I'm inconsistent in this series. I return -EINVAL on pci_reset_bus()
as an example. Maybe, I'll just return -EINVAL here too.

WARN_ON would be too much IMO.
