Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47EC43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015420892
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB92xmS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8015420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeKJKPj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeKJKPj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Nov 2018 05:15:39 -0500
Received: from [10.70.67.245] (unknown [167.220.2.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272B620883;
        Sat, 10 Nov 2018 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541809957;
        bh=2gAPdbHgLAbHbMYwP5utjVEI1/6gQgERgqgdYh3fAkU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ZB92xmS7cIgWWeztc1u1NZAEZOUP/LxsCaqJ7JsbaqJTbPlACZbOUgcOpMrZ4rkLo
         JG948aYO0MYHe/3E7oiSMj2GVicQ3WbKbQxuWL2dXCSMCx7lcd4ZpLPTEqPAkKPuTR
         RxSTPeLBo89ctb+zj6TBbmHcT+d6IDgK3004w15k=
Subject: Re: Sharing PCIe MMIO with other Drivers
To:     adanaila@ctrlinux.com, linux-pci@vger.kernel.org
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
Date:   Fri, 9 Nov 2018 16:32:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/9/2018 4:22 PM, Andrei Danaila wrote:
> A couple of questions:
> 
> 1. Is this the correct software flow for managing multiple devices exposed by a PCIe BAR0 address space?
>      If not, what is the correct flow?
>      If yes, any ideas on what may be going wrong?

General practice is to create a PCI Physical Function for each sub-functionality
(I2C/UART/DMA etc.) so that individual drivers can claim their own PCI device
and its own BAR space without sharing resources.
