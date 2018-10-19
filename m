Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD1ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D321479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2BMd72B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJSVwK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJSVwK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 17:52:10 -0400
Received: from [192.168.0.107] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6527B21476;
        Fri, 19 Oct 2018 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539956757;
        bh=WPLOG6i3VROfmKs0UnIYQQvHMsZxD2TC/rwj46NZh08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=x2BMd72BaADAJvED9vAPffZexj66cnvH+QG9xcCO1Qrs6MM7ZVGYgfrqBcxiWudGl
         Y73meI8T0tL5UlIOEAxda1d63sbypX0SbJ5+4fOY/Akc6xrT0BALPp++eewn6AyEDG
         K01uRzMOt0X4+aEU8CAFbV71whpZ7Zsj+G6joXoA=
Subject: Re: [RFC PATCH v1 3/3] PCI: Hide pci_reset_function_locked()
To:     Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
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
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20181019032345.5791-1-okaya@kernel.org>
 <20181019032345.5791-3-okaya@kernel.org>
 <ed64acac-cfc2-6b19-20c1-ce648cd7a073@suse.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1db7e078-9eb0-7282-f853-e084f4845523@kernel.org>
Date:   Fri, 19 Oct 2018 09:45:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ed64acac-cfc2-6b19-20c1-ce648cd7a073@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/19/2018 4:12 AM, Juergen Gross wrote:
> On 19/10/2018 05:23, Sinan Kaya wrote:
>> It is time to hide pci_reset_function_locked() since pci_reset_function()
>> provides the same functionality. One less API to expose to the users.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> 
> Did you try to compile that?
> 
> You are mixing use of PCI_RESET_ALREADY_LOCKED and
> PCI_RESET_ALREADYLOCKED, and I can't imagine both are valid.

You are right, I did compile. However, not all kernel options were
enabled apparently. I should have done allyesconfig.

Thanks for the heads up. I can fix it on the next rev.

> 
> 
> Juergen
> 

