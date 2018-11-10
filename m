Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA69AC43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 01:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAE320858
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 01:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OolPtjit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAE320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeKJKqB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeKJKqB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Nov 2018 05:46:01 -0500
Received: from [10.70.67.245] (unknown [167.220.2.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351F020840;
        Sat, 10 Nov 2018 01:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541811773;
        bh=h8vKEH0bbilYDBVz1RVKm6ztG9R6EDyMeJZ9cwUBBQI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=OolPtjitHdvFXrrcm/mmFdUzBjPR+ELns7bosbLoRdKrdipLBLsnjvolij9Ji3yuL
         or8wJqoyO6OvYei1teXpCvOe3L/Z0h8MLi0EckhGH/XAcL5JJG1yc4EBXMB/0c88k5
         HpmWRD2RVz4JTkidP0M0IO7vdbCYVBPtczwMd+mg=
Subject: Re: Sharing PCIe MMIO with other Drivers
To:     adanaila@ctrlinux.com, linux-pci@vger.kernel.org
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
 <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
 <1541810592.1176760.1571963216.0765E640@webmail.messagingengine.com>
 <2209a758-fa3a-ba92-a0f0-4cf2d704c10d@kernel.org>
 <1541811433.2126862.1571973360.5D0EF5E6@webmail.messagingengine.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1e1534d9-bd1f-98ba-1e33-948d81fc6d30@kernel.org>
Date:   Fri, 9 Nov 2018 17:02:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541811433.2126862.1571973360.5D0EF5E6@webmail.messagingengine.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/9/2018 4:57 PM, Andrei Danaila wrote:
> Unfortunately, I cannot change the IP on the FPGA to add more BARs either, the whole thing is locked down.

Not the best hardware.
OK. I am running out of ideas. It doesn't play nice with the driver development
model.

One idea is to have a parent PCI driver to allocate BAR space and have children
platform devices that you create at runtime. You can point to arbitrary address
in the system memory map and an IRQ using the platform devices. Though, it might
have some alignment requirement in order to be able to make MMU mappings.
