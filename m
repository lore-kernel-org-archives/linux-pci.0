Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0315C63697
	for <linux-pci@archiver.kernel.org>; Mon, 23 Nov 2020 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597BE2080A
	for <linux-pci@archiver.kernel.org>; Mon, 23 Nov 2020 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgKWOvP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:51:15 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:38948 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730644AbgKWOvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2020 09:51:14 -0500
Received: from host-92-5-241-147.as43234.net ([92.5.241.147] helo=[192.168.1.13])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1khDBN-0001yu-Fh; Mon, 23 Nov 2020 14:51:09 +0000
Subject: Re: [linux-safety] [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
References: <20201116165407.8050-1-sudipm.mukherjee@gmail.com>
 <20201116170137.GA2587640@ulmo>
From:   Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <0ef6fc37-4e91-68a1-0744-90b4093ce5ba@codethink.co.uk>
Date:   Mon, 23 Nov 2020 14:51:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201116170137.GA2587640@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 16/11/2020 17:01, Thierry Reding wrote:
> On Mon, Nov 16, 2020 at 04:54:07PM +0000, Sudip Mukherjee wrote:
>> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
>> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
>> doing 'return 0'.
>>
>> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> This has been proposed multiple times in the past and Bjorn and I have
> agreed every time that this is not an improvement, so sorry, but NAK.

Thanks Thierry and Neil. I have now added a blacklist script in our CI
so "PTR_ERR_OR_ZERO" will not be flagged for anything in drivers/pci/*
anymore in our testing.



-- 
Regards
Sudip
