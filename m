Return-Path: <SRS0=Xsl3=NA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E130C67863
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA9F2159B
	for <linux-pci@archiver.kernel.org>; Sat, 20 Oct 2018 16:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1s1VEOEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA9F2159B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJUAcW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeJUAcW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 20:32:22 -0400
Received: from [192.168.0.107] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A6521550;
        Sat, 20 Oct 2018 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540052483;
        bh=TJIhZxaILhxwOPSp+8ssxgIcNcajSOg48sQLaZUEmJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1s1VEOEGAi4R/7UgEZweQaf6Z6c2e37Sqr6e+11EyBekCbEtLfyqTagGGKjUJ2OFB
         bITdUyut7qUABjAG+X8BbiAkhTTRw33q0N/+Kbpw147WHJNYjVqFT4R9BigSLQulQ3
         9vppM6IIzw5i7AxCkAN9gQZ+4NKukD6GvSPLSNBE=
Subject: Re: [PATCH v6 1/7] PCI: Expose reset_type to users of
 __pci_reset_function_locked()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181020020908.GQ5906@bhelgaas-glaptop.roam.corp.google.com>
 <8f368f0b-b9b9-54ab-bd46-88635b9a43e5@kernel.org>
 <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <df6c2825-b31f-043b-be8d-c905940e683e@kernel.org>
Date:   Sat, 20 Oct 2018 12:21:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020150353.GR5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/20/2018 11:03 AM, Bjorn Helgaas wrote:
>> We can also drop the series if we think that current API are good enough
>> and nuances are well understood.
> I don't think the current API is good enough:)   It's just a small
> matter of sorting out a better one.

I guess the next logical question is if you have any suggestion.

merge __pci_reset_function_locked() and pci_reset_function_locked().
Then save the context all the time?

What about locked vs. unlocked APIs? If there is a way to know if lock
is being held by the currently running task, we could skip the locking business
and unify these two APIs.
