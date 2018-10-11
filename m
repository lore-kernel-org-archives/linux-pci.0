Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680DC677FE
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D86221470
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="POLZpIho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D86221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJKXIq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbeJKXIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:46 -0400
Received: from [10.17.91.149] (rrcs-70-63-152-218.midsouth.biz.rr.com [70.63.152.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E08A21477;
        Thu, 11 Oct 2018 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272462;
        bh=nJoFpNjFnLM0A1CTIGjCqxfM+hB0Hev+sKTwFQ80WD4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=POLZpIhoIcbaapIFl7lEY7YoUgiAVbf0hMfRYd8JoI+lDsBGI6ZwVrvuov54KkNI0
         4LC6cWR7E2Toh+/gf0wcg70W95/80A307CCHMAH30qQDPtvdKaYSFVjSYuFqIISuCh
         CrZEtqUiVYc7IP72DubPixm5ateWjkL0mH6mWeuo=
Subject: Re: [PATCH v5 11/11] PCI: Hide pcie_flr() in favor of
 pci_reset_function()
To:     linux-pci@vger.kernel.org
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20181011045008.32212-1-okaya@kernel.org>
 <20181011045008.32212-11-okaya@kernel.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ff639aab-63e2-fe7e-ca09-b82d47f25734@kernel.org>
Date:   Thu, 11 Oct 2018 11:41:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011045008.32212-11-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/11/2018 12:50 AM, Sinan Kaya wrote:
> Now that we have a unified API for device reset, let's eliminate
> one duplication by hiding pcie_flr().
> 
> Signed-off-by: Sinan Kaya<okaya@kernel.org>

This patch might have gone too far. I'm willing to drop it.
