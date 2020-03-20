Return-Path: <SRS0=KiQH=5F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A9C4332D
	for <linux-pci@archiver.kernel.org>; Fri, 20 Mar 2020 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8612076E
	for <linux-pci@archiver.kernel.org>; Fri, 20 Mar 2020 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584715695;
	bh=8ee3apyY9f15XKmg0lQC4W2452wF8Tr4Iwe6FmBANyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=rjbMeyrGojVyMTxbhCKYu8lw6eH5GbIfPY2C+7G/eUtoxee0u7Xtn9PR2Nng2Iq5M
	 II7kyzSlNmjKg5sipFPvnwdqVjaWnorSxMxhJFzd4+s/j7gNZAhtJaTNda1S+snfDM
	 qqfOBrTsGGCAJeEVOixIQMU+BO+fVkRHrI6NQZF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTOsP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTOsP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 10:48:15 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5710F20714;
        Fri, 20 Mar 2020 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584715694;
        bh=8ee3apyY9f15XKmg0lQC4W2452wF8Tr4Iwe6FmBANyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OTckOWgVWO46uhJlgXW0pMnLp95OYH7ZUxh8Ue25YE2OW180DgpbrW2VaUR+j1tGi
         JbpXK1s56NzRSO/wpMSvIfPfOynJw1N+APefY2aUN8ApcFblrncma5mAy2Rygjx9G+
         pN+LKTv4cPaL+0PtEStvklUuly4ZrkHQK1hNDMzU=
Date:   Fri, 20 Mar 2020 09:48:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Microchip: Add host driver for Microchip PCIe
 controller
Message-ID: <20200320144812.GA194257@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319154917.GA1232@IRE-LT-TRAIN04.mchp-main.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 19, 2020 at 03:49:18PM +0000, Daire McNamara wrote:
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> --
> This v5 patch series adds support for PCIe IP block on Microchip PolarFire SoC.
> 
> Updates since v4:
> * Fix compile issues

Hi Daire,

I gave you a few comments on v4:
https://lore.kernel.org/r/20200226172422.GA120511@google.com
but I didn't hear anything, and most of the comments still apply here.

Bjorn
