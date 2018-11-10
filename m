Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571FC43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6A20858
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbq007io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD6A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeKJKcC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeKJKcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Nov 2018 05:32:02 -0500
Received: from [10.70.67.245] (unknown [167.220.2.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F17A2081C;
        Sat, 10 Nov 2018 00:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541810936;
        bh=s+kG1kZCADDqDqoa81ApMsPURM6t9hoP15z4fsabsZk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=hbq007ioIVOm1xhFPhF3B2p2T4VM92ojrck0UvSPh07Y4d4n4NEIfxEQDr5tW7CIt
         V//uw9p0XF79FjTo4awOxHWjIJSuJrJjPe6AvqJxyUK+xBaM5o3hp78kj1rfRrSk1U
         fvq2dFtI7kSUdZGTqtaJ823qPQUlv3yy3lakFvGM=
Subject: Re: Sharing PCIe MMIO with other Drivers
To:     adanaila@ctrlinux.com, linux-pci@vger.kernel.org
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
 <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
 <1541810592.1176760.1571963216.0765E640@webmail.messagingengine.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <2209a758-fa3a-ba92-a0f0-4cf2d704c10d@kernel.org>
Date:   Fri, 9 Nov 2018 16:48:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541810592.1176760.1571963216.0765E640@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/9/2018 4:43 PM, Andrei Danaila wrote:
> Thanks Sinan,
> 
> I thought of that as well, unfortunately that it is not possible since the FPGA IP block is proprietary from a 3P vendor and lumps everything under one function with no option of adding additional functions.

How about adding multiple BARs and then give each BAR to a children driver?
