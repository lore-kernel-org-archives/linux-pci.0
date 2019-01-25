Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0503FC282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66A3218F0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548436202;
	bh=oNV2pUPoz6XHfOznR1800H4A+EdIqQtopurS6/eB/KQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=r3RXDvFXEZfnXwP/n99VrLzFKRD6uRnCzjcHM42a1Vbl+zeMRDrEEYBY7waQzVqiD
	 ZrkbyoOUnR00euO+KoURM0/9h33DTd/rvKjxAc8FE4pxS37JGNa9qZ/uydfHvdNVHA
	 SigD7+z7BRx+USVW/6ZxZ+mGvJgs0RmSG3rOVyZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAYRKC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfAYRKC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 12:10:02 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0ED218A2;
        Fri, 25 Jan 2019 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548436201;
        bh=oNV2pUPoz6XHfOznR1800H4A+EdIqQtopurS6/eB/KQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h2FYGKhGXu1jW5ERKJsUDR0x+GkixQ1dkJrc7Yba5IvNjCNL+EEdWX6ihD1qvX50D
         2KVMSfj/1RoLdEO6jSyEn6ZSo5JAjENX/CMgfFUsze7MXx1ZU5VT2LhHxJtt4T8/zB
         5iO4+0ACram9B4tgNJAABr1fU8fe5L2j93V14mf0=
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <7b515af9-b119-bf33-f774-3e091ca30483@kernel.org>
Date:   Fri, 25 Jan 2019 12:09:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/25/2019 9:28 AM, Dongdong Liu wrote:
> I want to fix 2 points by the patch.
> 
> 1. For EP devices (such as multi-function EP device) under the same bus,
> when one of the EP devices met non-fatal error, should report non-fatal
> error only to the error endpoint device, no need to broadcast all of them.
> That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15) 
> 
> have done, but current code PATCH [1] broken this.
> 
> 2. We found a NULL pointer dereference issue for 74:02.0 device
> when the device met a non-fatal error (firmware-first) after 4.19.
> The topology is as below.

Is it possible to split the patches into two to address these two different
issues?

I can understand the first one but second one seems some mystery that needs
to be explored in detail.
