Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CFC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 17:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B22B2152F
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cq64IF7o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cq64IF7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B22B2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIZXe4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:34:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIZXe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 19:34:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2B56602BA; Wed, 26 Sep 2018 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537982459;
        bh=G5buBSmXP1KIWsv4KgYY6iFdssumMb/bK21SBHoiRxI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cq64IF7oZtz6179iPI4x3/6+GPrHlTOlvyu3edZbIiYJOiU2GROwaRFR/bAuN22ho
         PCHSPUBMDWvhrwS0XVw5Wmqdt2GhmyfjVH7WeiMg9uvYG/oY37Xa/LvzCRUOaUe9Vx
         1maSNbjFWD0QPTYxaqLZhTwttrDE9rzva+9erkjY=
Received: from [10.80.45.152] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3709E6029D;
        Wed, 26 Sep 2018 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537982459;
        bh=G5buBSmXP1KIWsv4KgYY6iFdssumMb/bK21SBHoiRxI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cq64IF7oZtz6179iPI4x3/6+GPrHlTOlvyu3edZbIiYJOiU2GROwaRFR/bAuN22ho
         PCHSPUBMDWvhrwS0XVw5Wmqdt2GhmyfjVH7WeiMg9uvYG/oY37Xa/LvzCRUOaUe9Vx
         1maSNbjFWD0QPTYxaqLZhTwttrDE9rzva+9erkjY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3709E6029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
To:     "Raj, Ashok" <ashok.raj@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        IOMMU Mailing List <iommu@lists.linux-foundation.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
 <20180926162235.GA30177@araj-mobl1.jf.intel.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
Date:   Wed, 26 Sep 2018 13:20:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926162235.GA30177@araj-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/26/2018 12:22 PM, Raj, Ashok wrote:
>> pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
>> +		return;
> Forgot to notice this.. I'm not sure if the same enforcement is
> required for devices that are RCIEP. The spec isn't clear about calling
> any excemption. Although it should be simple for devices to expose
> e2etlp support, but if they don't that should be ok, since there are
> nothing between itself and the root port.
> 
> We are seeking help from our SIG reps, but thought I'll ask here as well
> if there are other opinions.
> 

This patch actually broke the integrated endpoints like you were mentioning.
It was fixed by a follow up patch from nvidia guys.

https://github.com/torvalds/linux/commit/9d27e39d309c93025ae6aa97236af15bef2a5f1f#diff-a7f0acd715e991df5dfb450d2b9abebc

