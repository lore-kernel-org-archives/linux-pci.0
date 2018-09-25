Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850FEC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D920896
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHciWuW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5D920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZDQs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbeIZDQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 23:16:48 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF5320842;
        Tue, 25 Sep 2018 21:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537909640;
        bh=0D1rcyvlDBlVeEJWp+BHT/rh9U98bk3caH2UYod+MPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BHciWuW6RmerlZZrCHVJXgjzLDm6kfnT/z3zHz77n/1do+4OWqTxZ8ORbeCrxI8Bo
         SPs0SCr5bkj9LvAom0UIS4feiV5AIhRxM0u+3vvB+lqtUQjuvHTW6wQiEN56GkrbHI
         /sT1pzB6Z/wvfsaTjyxBJfveyWAKQLxbrVSBAlkA=
Subject: Re: [PATCH v4 1/6] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-2-okaya@kernel.org>
 <20180925204546.GB80129@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2fa71177-8672-7bea-3657-7017182ff665@kernel.org>
Date:   Tue, 25 Sep 2018 17:07:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925204546.GB80129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/25/2018 4:45 PM, Bjorn Helgaas wrote:
>> We need a contract between the reset API users and the PCI core about the
>> types of reset that a user needs vs. what PCI core can do internally.
>> If a platform supports hotplug, we need to do hotplug reset as an example.
>>
>> Expose the reset types to the drivers and try different reset types based
>> on the new reset_type parameter.
>>
>> Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
>> PCI_RESET_LINK parameters.
> I understand the words above, but I don't really understand the
> motivation behind this.  Can you help flesh that out a bit?
> 
> I guess there's a problem being solved by these patches, and it would
> help a lot to have some details about what it is.
> 
> It would be ideal if we could offer some guidance, probably as code
> comments, to help driver writers choose the correct reset type.
> 

Alex and I discussed this here:

https://www.spinics.net/lists/linux-pci/msg75828.html
