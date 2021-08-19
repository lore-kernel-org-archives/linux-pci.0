Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7BC4338F
	for <linux-pci@archiver.kernel.org>; Thu, 19 Aug 2021 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85933610FE
	for <linux-pci@archiver.kernel.org>; Thu, 19 Aug 2021 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhHSKCR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:02:17 -0400
Received: from mx.socionext.com ([202.248.49.38]:13490 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhHSKCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 06:02:16 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Aug 2021 19:01:40 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 32D9D208AE17;
        Thu, 19 Aug 2021 19:01:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Aug 2021 19:01:40 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9CB70B631E;
        Thu, 19 Aug 2021 19:01:39 +0900 (JST)
Received: from [10.212.29.66] (unknown [10.212.29.66])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 4A402A911B;
        Thu, 19 Aug 2021 19:01:39 +0900 (JST)
Subject: Re: pcie-uniphier: race condition in masking/unmasking interrupts
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210818113820.fzjeouy6tohbzuad@pali>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1328d293-7c42-b29b-9cce-507cf25de97a@socionext.com>
Date:   Thu, 19 Aug 2021 19:01:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818113820.fzjeouy6tohbzuad@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 2021/08/18 20:38, Pali Rohár wrote:
> Hello!
> 
> Marc pointed during review of pci-aardvark patches one issue which I see
> that is available also in the current pcie-uniphier.c driver.
> 
> When masking or unmasking interrupts there is read-modify-write sequence
> for PCL_RCV_INTX_MASK_SHIFT register without any locking:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-uniphier.c?h=v5.13#n171
> 
> So when trying to mask/unmask two interrupts at the same time there is
> race condition as updating that PCL_RCV_INTX_MASK_SHIFT register is not
> atomic.
> 
> Could you look at it?
Thank you for pointing out.
I'll update the mask/unmask/ack operations to avoid race condition.

Thank you,

---
Best Regards
Kunihiko Hayashi
