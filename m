Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C1C67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746F121476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXREp/i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746F121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJSLc6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSLc6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 07:32:58 -0400
Received: from [192.168.0.107] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD9B2145D;
        Fri, 19 Oct 2018 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539919730;
        bh=OB62rxdxQm0Y7Ofds9NeFMQmZBpbtEoN/rn5SDJS2iw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mXREp/i1gHf9g0Yo0ZIvck6kddxIcOHVZqIxv0bM13DhKUgbi5oRsErmQpBBjACUM
         ZCrQ9ncvvcuU2HOHRbr2/etGtYZh7kNMHN4KjSYVJOT9YO8YCmzODxEhCjkogy7GQ9
         4OIhn+teiDU9IpQXSKZPmiKOB/KcKChtubkU45qo=
Subject: Re: [RFC PATCH v1 2/3] PCI: Add options to pci_reset_function
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
References: <20181019032345.5791-1-okaya@kernel.org>
 <20181019032345.5791-2-okaya@kernel.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <c2cb7954-5647-1659-b2d4-5015066d815c@kernel.org>
Date:   Thu, 18 Oct 2018 23:28:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019032345.5791-2-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/18/2018 11:23 PM, Sinan Kaya wrote:
> Getting ready to deprecate pci_reset_function_locked(). Add
> saverestore and locked parameters to pci_reset_function() function
> and add saverestore = true and locked = false to all existing
> callers.

I realized that I forgot to update the commit text but this is a follow up
to this conversation per Christoph's request.

https://patchwork.kernel.org/patch/10636071/

Since Alex didn't like the idea much, I also split the API reduction work
out of the original reset API refactoring work and sent as an RFC.
