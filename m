Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23295C6786C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184F213A2
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyitjuZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeJLWTr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbeJLWTr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 18:19:47 -0400
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FC92098A;
        Fri, 12 Oct 2018 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539355620;
        bh=9bhyVuVvpzN51N902ngdSt4Sc3lf8CdYjUgcHhhOz84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KyitjuZ6gnwo5KTAij9AcP0jU4+B7n/N0y6uEqpbTYKzbUw9dfaIZ7lhLmEHpCrh8
         73vDQOjX+HxmWFfOlk86iL/AvP2Ftao8OkjhCKbUO1IoZX1tMh2Vd8ARo8fqdObIRJ
         ef24zRE14TqBpFheiLE3UT1hef9ha0Iw4ITgR6VA=
Subject: Re: [PATCH v5 08/11] PCI: Unify pci_reset_function_locked() and
 __pci_reset_function_locked()
To:     Christoph Hellwig <hch@infradead.org>
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
 <20181011045008.32212-8-okaya@kernel.org>
 <20181012091809.GA6669@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <9b5c0248-25e5-58d2-5729-9ae3c905e6e8@kernel.org>
Date:   Fri, 12 Oct 2018 10:46:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012091809.GA6669@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/12/2018 5:18 AM, Christoph Hellwig wrote:
> On Thu, Oct 11, 2018 at 04:50:00AM +0000, Sinan Kaya wrote:
>> The difference between pci_reset_function_locked() and
>> __pci_reset_function_locked() is the saving and restoring of the registers.
>> Unify these API by adding saverestore argument that caller passes.
> 
> Adding random boolean arguments doesn't really help the API.  Either
> make this another flag for reset_type or if there is a clear benefit
> add an additional flags parameter with well described flags.
> 

Good idea. This is the kind of feedback I was looking for. Here is what I
collected so far.

Alex doesn't like the API changes as it should be obvious that there are
differences between pci_reset_function_locked() and
__pci_reset_function_locked(). Sinan thinks that the difference is not that
obvious as some drivers implemented their own save/restore mechanism using
__pci_reset_function_locked(). Sinan would rather reduce the reset API flavors
and give a unified interface where user specifies what they are interested in.

Christoph asked for additional flags to be rolled into the reset_type argument.
Sinan thinks that this is a good idea.

Anybody else?
