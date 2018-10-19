Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A1ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 22:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B421476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 22:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtRcitnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6B421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeJTG0f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJTG0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Oct 2018 02:26:35 -0400
Received: from [192.168.0.107] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626AB21470;
        Fri, 19 Oct 2018 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539987518;
        bh=aPX7RujrvnBgREXg6x4urcIiuZQ5aWYMKNlWXdrreTw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NtRcitnXu3qk4hHu8hey+P4is9SaDnsEXIIzRUGSbhI8Tzzg+FijGzcNOPALrvOmw
         9cqdrLtW3eSVb+NKPelNvKJx6bzDGYdFxg/JvGB1EML+2LhCx7OW7hP9hbEdkWHHov
         8a6nJoJQMTxiiXcdANEhjCYx0ePIBEX6817gR3bo=
Subject: Re: [PATCH v6 3/7] PCI: Expose reset_type to users of
 pci_reset_function_locked()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20181019021132.14743-1-okaya@kernel.org>
 <20181019021132.14743-3-okaya@kernel.org>
 <20181019202028.GB105697@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <f430e49e-7008-4320-f967-5078616a04b8@kernel.org>
Date:   Fri, 19 Oct 2018 18:18:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019202028.GB105697@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/19/2018 4:20 PM, Bjorn Helgaas wrote:
>> +int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
> There are no callers of this.  Why are we updating it rather than
> removing it?
> 

I'll remove this function on another patch.

I transition all __pci_reset_function_locked users
to pci_reset_function_locked()  first.

Then all pci_reset_function_locked() users to pci_reset_function().

Then, git rid of pci_reset_function_locked() at last step.
