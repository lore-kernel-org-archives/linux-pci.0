Return-Path: <SRS0=MVLW=ZM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13372C432C0
	for <linux-pci@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61892251F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256196;
	bh=uYy9gLdFES2Nr8qdLHqGdYuL8mGK/ZNWP6mAo5p8ID4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=scPzJ5ZIDZgStN8wG+3BcAv7gUe9L8H89mrGhkg/WxZP7LhL+i1wQ1TnabX7GEyxO
	 hqU2irN77bhZmOhjr60v9E8Tg4/p8vqlFcQReBWikl9E7KYJEslJW/B9mbei3i0nvS
	 bBxn7ZbDLj+GcmvkZREnKdd0H9Nnwe03jyWJWH9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfKTNXQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfKTNXP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 08:23:15 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E5422521;
        Wed, 20 Nov 2019 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256194;
        bh=uYy9gLdFES2Nr8qdLHqGdYuL8mGK/ZNWP6mAo5p8ID4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zjg14zxk6OdJvEH8K7aBq16aqxr+CyRg5EAjpKosJly0pR/RGIv8mmMym+ucN6J2G
         BSYAALkbLmG0Hoh9vDk+4n1s+pD5FiXG5LGyUENl+E2Mm55OuA3djfIedvBa0+kFnM
         ZM7H4BGWd+Ojv85gd8455UrbZJLxRCAhsbeH8D1s=
Date:   Wed, 20 Nov 2019 07:23:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     George Cherian <george.cherian@marvell.com>,
        Robert Richter <rrichter@marvell.com>, Feng Kan <fkan@apm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>
Subject: Re: [PATCH 0/2] PCI: Unify ACS quirks
Message-ID: <20191120132312.GA87386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114220601.261647-1-helgaas@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 14, 2019 at 04:05:59PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> These are pretty trivial and not intended to fix anything, but just to
> remove unnecessary differences of implementation from the ACS quirks.
> 
> Bjorn Helgaas (2):
>   PCI: Make ACS quirk implementations more uniform
>   PCI: Unify ACS quirk desired vs provided checking
> 
>  drivers/pci/quirks.c | 96 ++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 38 deletions(-)

Applied with reviewed-by from Alex and Logan to pci/virtualization for
v5.5.
