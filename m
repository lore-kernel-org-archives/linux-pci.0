Return-Path: <SRS0=oOo+=DP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F3C433E7
	for <linux-pci@archiver.kernel.org>; Thu,  8 Oct 2020 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A16B21531
	for <linux-pci@archiver.kernel.org>; Thu,  8 Oct 2020 08:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgJHIW4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJHIW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 04:22:56 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8931C061755;
        Thu,  8 Oct 2020 01:22:55 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EBE192FB; Thu,  8 Oct 2020 10:22:51 +0200 (CEST)
Date:   Thu, 8 Oct 2020 10:22:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 209321] DMAR: [DMA Read] Request device [03:00.0] PASID
 ffffffff fault addr fffd3000 [fault reason 06] PTE Read access is not set
Message-ID: <20201008082249.GA3107@8bytes.org>
References: <20201007154314.GA3245607@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007154314.GA3245607@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Oct 07, 2020 at 10:43:14AM -0500, Bjorn Helgaas wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=209321
> 
> Not much detail in the bugzilla yet, but apparently this started in
> v5.8.0-rc1:
> 
>   DMAR: [DMA Read] Request device [03:00.0] PASID ffffffff fault addr fffd3000 [fault reason 06] PTE Read access is not set
> 
> Currently assigned to Driver/PCI, but not clear to me yet whether PCI
> is the culprit or the victim.

Thanks for the heads-up, looks like Intel is already on it.

Regards,

	Joerg
