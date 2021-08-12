Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449BC4338F
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E4460FED
	for <linux-pci@archiver.kernel.org>; Thu, 12 Aug 2021 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhHLRx7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhHLRx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 13:53:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 833BD60C3F;
        Thu, 12 Aug 2021 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628790813;
        bh=rzIen6n17XL3TXkwlUFGX5zNCj/pNZGFZZ5rqCWckSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eP/vvc2iHfScDXLb1gMzLSLRSp1ZFUrAM14CEC1mwMXjwRvmpC/Kh9nLV9hKkyLeF
         tE1hwo+OewJiKgL931jJBI3Yhj7/uo+7YTbfhi8cV/8dhmvj8gE9CrCDnm24O1eWeV
         mFnd4dkNdAWWLCTid97bLi49P9PRYN3SN6K52A9gVUk0HIpb+az9erIORcbc/kcsgb
         YX/nbM/ECQENqGPWOnDj6Pi7wOH9RGfbVqe6nHQct7nDZcFRdd/qlPag0v91Cp9x+h
         Y+POG/Huc5Q6REkvE2lawaWd832tef+pvc+D54Nr11OQHAnkVKXWCcveClz3ogyQWi
         OmszTiiWHoPbQ==
Date:   Thu, 12 Aug 2021 12:53:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/6] PCI/VPD: Further improvements
Message-ID: <20210812175332.GA2490883@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e61d5dc-824c-e855-01eb-6c7f45c55285@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 08, 2021 at 07:18:08PM +0200, Heiner Kallweit wrote:
> This series includes a number of further improvements to VPD handling.
> 
> Heiner Kallweit (6):
>   PCI/VPD: Move pci_read/write_vpd in the code
>   PCI/VPD: Remove struct pci_vpd_ops
>   PCI/VPD: Remove member valid from struct pci_vpd
>   PCI/VPD: Embed struct pci_vpd member in struct pci_dev
>   PCI/VPD: Determine VPD size in pci_vpd_init already
>   PCI/VPD: Treat invalid VPD like no VPD capability
> 
>  drivers/pci/probe.c |   1 -
>  drivers/pci/vpd.c   | 253 ++++++++++++++++----------------------------
>  include/linux/pci.h |   9 +-
>  3 files changed, 97 insertions(+), 166 deletions(-)

This looks great!

Applied to pci/vpd for v5.15, thanks!

I tweaked 2/6 to test for func0_dev being NULL in pci_read_vpd()
instead of pci_vpd_read().  Could go either way, but it's really only
relevant for the PCI_DEV_FLAGS_VPD_REF_F0 case, which is now all in
pci_read_vpd().  For the non-PCI_DEV_FLAGS_VPD_REF_F0 case, we've
already dereference dev->dev_flags, so "dev" can never be NULL in
pci_vpd_read().
