Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600A9C282C2
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F491218D0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548437840;
	bh=q51w84PIZ+w17hqXg9+WrQ62H6y9cpGMH/z7oObs5s0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OmlDz7F2pm20eRPCQVBsUGV8RtznGrSlXRwVstRoOqTzQpU+fVrSiSYAGMNx/8zpW
	 5KWLWYSE+RfQzCvAxXTHttAim41DZgIEYcY0Jdb6Pi0sDqvCTZdx4tHSKJm8Y718h8
	 JA+uLBz68Bd7CuKcPoOfUugm+uElFhatrNpHrMyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAYRhS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYRhR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 12:37:17 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8D9218A6;
        Fri, 25 Jan 2019 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548437836;
        bh=q51w84PIZ+w17hqXg9+WrQ62H6y9cpGMH/z7oObs5s0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dch9IsBNGUIrsj9SYWcH5esCH0EP8UCTgx4SUUeUkM3BwvI3nldQzBetUMZ4e2D1s
         5H+ZetaUCu3qioHuUFAKpUEaesp5jSBqZCesFSPnOdHIVAj/WJQvZIz8ANICc+Xc59
         +sDdx8nBF9f/e1CEyYPQBAM18JueS3l2OsU2iLJU=
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
 <20190125171713.GB11210@localhost.localdomain>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <bbe67d36-103c-1cda-4186-128a155e8c0e@kernel.org>
Date:   Fri, 25 Jan 2019 12:37:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125171713.GB11210@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/25/2019 12:17 PM, Keith Busch wrote:
> On Fri, Jan 25, 2019 at 06:28:03AM -0800, Dongdong Liu wrote:
>> I want to fix 2 points by the patch.
>>
>> 1. For EP devices (such as multi-function EP device) under the same bus,
>> when one of the EP devices met non-fatal error, should report non-fatal
>> error only to the error endpoint device, no need to broadcast all of them.
>> That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15)
>> have done, but current code PATCH [1] broken this.
> 
> How do you know a non-fatal affects only the reporting end point? These can
> certainly be bus errors, and it's not the first to detect may be affected.
> 
> In any case, what harm does the broadcast cause?
> 

What is the PCIe spec rule about AER errors for multi-function devices?

Does it say it needs to be propagated to all functions or each function has
its own unique AER error handler?
