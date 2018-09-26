Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BFBC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AF621533
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 17:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fPrSog0S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fPrSog0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AF621533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeIZXgJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:36:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeIZXgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 19:36:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C374A605FD; Wed, 26 Sep 2018 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537982531;
        bh=b0EeMjliZXOwtqi3OL3EpVd5dzN7wH+nG5jatNJAdZU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=fPrSog0SDj6UQjPf97PNE9pB/gddvDiwDxrzGjDck+UD6wAlV5IcIXm9Uat6tT0xU
         F7UmTjrjC5DHdr8y8Wiuw49hEBK+Mys3Zc7qpJB8W2aZg4ZltmXNMKIr2t23AaXaEE
         kmwDRoRUQt5r9ltfQ0WeZSSF+mE+KmxWTr/sOJCE=
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42D5E60251;
        Wed, 26 Sep 2018 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537982531;
        bh=b0EeMjliZXOwtqi3OL3EpVd5dzN7wH+nG5jatNJAdZU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=fPrSog0SDj6UQjPf97PNE9pB/gddvDiwDxrzGjDck+UD6wAlV5IcIXm9Uat6tT0xU
         F7UmTjrjC5DHdr8y8Wiuw49hEBK+Mys3Zc7qpJB8W2aZg4ZltmXNMKIr2t23AaXaEE
         kmwDRoRUQt5r9ltfQ0WeZSSF+mE+KmxWTr/sOJCE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D5E60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
From:   Sinan Kaya <okaya@codeaurora.org>
To:     "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        IOMMU Mailing List <iommu@lists.linux-foundation.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
 <20180926162235.GA30177@araj-mobl1.jf.intel.com>
 <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
Message-ID: <ff87c6ab-fdd2-c75d-285a-e2d19c640e2b@codeaurora.org>
Date:   Wed, 26 Sep 2018 13:22:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/26/2018 1:20 PM, Sinan Kaya wrote:
> 
> This patch actually broke the integrated endpoints like you were mentioning.
> It was fixed by a follow up patch from nvidia guys.
> 
> https://github.com/torvalds/linux/commit/9d27e39d309c93025ae6aa97236af15bef2a5f1f#diff-a7f0acd715e991df5dfb450d2b9abebc 
> 

Turns out Felix works at AMD. Apologies for the name confusion.
