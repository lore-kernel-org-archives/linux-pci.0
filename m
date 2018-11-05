Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF30C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312772085A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 23:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAvqSoLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312772085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725760AbeKFIek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725733AbeKFIek (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 03:34:40 -0500
Received: from [10.70.68.164] (unknown [131.107.174.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8326620825;
        Mon,  5 Nov 2018 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541459554;
        bh=kzaDJLVKs8zzzT2vWUyObMa/PcnRRkLDpbZFLBxNXhY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mAvqSoLaR8pkaMqZ+IghAsaNoX3I6HCm0CVuk9gEcfL4AafXCEpDUBOW56TOsf54z
         oTW9oD6t2tmX0L9FIu4fNUuOU/GjhIWvQrHOqCVC76ryjdgcOR9j/cplj+4gh2d63N
         QPlLhsY/2Kaby2SKMT3ggAKxN7LcKpKeIbV92ru4=
Subject: Re: [PATCH] PCI: Add HXT vendor ID and ACS quirk
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        okaya@codeaurora.org, Joey Zheng <yu.zheng@hxt-semitech.com>
References: <1541387759-2336-1-git-send-email-shunyong.yang@hxt-semitech.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
Date:   Mon, 5 Nov 2018 15:12:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541387759-2336-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/4/2018 7:15 PM, Shunyong Yang wrote:
> Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
> design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
> pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.
> 
> Cc: Joey Zheng<yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang<shunyong.yang@hxt-semitech.com>

There is also a couple of hotplug quirks for QDF2400. You should
probably take care of those as well.

Assuming your PCI IDs are correct:

Reviewed-by: Sinan Kaya <okaya@kernel.org>
