Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12AC677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F702098A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Riehz9HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F702098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeJKXjC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbeJKXjC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:39:02 -0400
Received: from [10.17.91.149] (rrcs-70-63-152-218.midsouth.biz.rr.com [70.63.152.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF11204FD;
        Thu, 11 Oct 2018 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539274269;
        bh=ed6Nq93ENaynHoNyc3GbaARn3s2nbAilOB3ZVBXm/Jk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Riehz9HNAEcsFMgJs1q/FV7LTN9aub1BfMYpufxB5ZHImlUYch9Yk3y49w5sHWfti
         3ru8WX0IoMxcd6kjjFTqQ2AlCq7DQnGumILqiBdKe49pwh+VJJ7Fln+9+2mMPPNMC8
         s4XcTSlN+Nvf4jPRDSO7WG306yw+QHl7Wp5JTkNI=
Subject: Re: [PATCH v5 08/11] PCI: Unify pci_reset_function_locked() and
 __pci_reset_function_locked()
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20181011045008.32212-1-okaya@kernel.org>
 <20181011045008.32212-8-okaya@kernel.org> <20181011100241.42c10935@w520.home>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <26c2ff39-1ca7-bef5-5dc1-5bd438fd9dc0@kernel.org>
Date:   Thu, 11 Oct 2018 12:11:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011100241.42c10935@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2018 12:02 PM, Alex Williamson wrote:
>> The difference between pci_reset_function_locked() and
>> __pci_reset_function_locked() is the saving and restoring of the registers.
>> Unify these API by adding saverestore argument that caller passes.
>>
>> Signed-off-by: Sinan Kaya<okaya@kernel.org>
>> ---
>>   drivers/infiniband/hw/hfi1/pcie.c               |  2 +-
>>   drivers/net/ethernet/cavium/liquidio/lio_main.c |  2 +-
>>   drivers/pci/pci.c                               | 10 +++++++---
>>   drivers/pci/pci.h                               |  1 +
>>   drivers/xen/xen-pciback/pci_stub.c              |  6 +++---
>>   include/linux/pci.h                             |  4 ++--
>>   6 files changed, 15 insertions(+), 10 deletions(-)
> TBH, I'm not a fan of this patch or the remainder in this series.
> Having a function prefixed with underscored or specifically indicate
> locked tells callers that these are special cases and should be
> understood before using.  Adding bool parameters to the common
> functions ensures that every caller now needs to understand those
> special cases and potentially get them wrong.  Also, a string of random
> bool options to a function means that any time we want to use it we
> need to go reexamine the function definition.  It's not intuitive to
> use or review.  Thanks,

Thanks for the feedback. I wanted to get it out to gather feedback.

I think it is quite straightforward for people familiar with the existing
API to know what they are dealing with. I didn't know the difference
between

__pci_reset_function_locked() and pci_reset_function_locked()

for a long time. This was an attempt to minimize reset function flavors
and ask explicitly what user wants rather than having them use the wrong
function and suffer the consequence with random failures.
