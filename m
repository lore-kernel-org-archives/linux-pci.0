Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9305BC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 00:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E18364E3E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 00:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBJAFU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234696AbhBIXRJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 18:17:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C85FB64E3C;
        Tue,  9 Feb 2021 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612911976;
        bh=3hA4LAECNcxRvS/teZ3WBA7MKSKusBqEX4w/4TJMfpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QwLINPBew5K6IV/G6DKAsJKTQLcRmNleHhsKCl/0PJFSuXgjMjj/ZEPjw1F04UpQo
         kIO8VK9A7Et05moThAy8w+m6RpvEAGMgKPDvMQ4IuEdByD889D5CqH+WJj+4K2EjmK
         J0Yq4HML02dWQIsi7C5D8N0Pu9XBz1VPxdG01g9K4z3KQV3/drSzbS5sa+ZjQKG/Nn
         1EZug2IO6N8IZSydjgU5s5dUSKqofu4UjYf2q2Cvjs8hpn/A4+LU1mfoRV1Msa5Mmg
         Hf05Vswv/eXqp5PFt5BnLEBhZZR827De+inX+0gOavxncz8GNEpjTRrdWYl12PwVMH
         yczpJjW6VlmQw==
Date:   Tue, 9 Feb 2021 17:06:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210209230614.GA523701@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Hinko]

On Mon, Jan 04, 2021 at 03:02:55PM -0800, Keith Busch wrote:
> Changes from v1:
> 
>   Added received Acks
> 
>   Split the kernel print identifying the port type being reset.
> 
>   Added a patch for the portdrv to ensure the slot_reset happens without
>   relying on a downstream device driver..
> 
> Keith Busch (5):
>   PCI/ERR: Clear status of the reporting device
>   PCI/AER: Actually get the root port
>   PCI/ERR: Retain status from error notification
>   PCI/AER: Specify the type of port that was reset
>   PCI/portdrv: Report reset for frozen channel
> 
>  drivers/pci/pcie/aer.c         |  5 +++--
>  drivers/pci/pcie/err.c         | 16 +++++++---------
>  drivers/pci/pcie/portdrv_pci.c |  3 ++-
>  3 files changed, 12 insertions(+), 12 deletions(-)

I applied these to pci/error for v5.12, thanks!

I *am* a little concerned about the issues Hinko saw because it
doesn't look we found a root cause.  I didn't spend any time looking
into it, but even if it only shows up on his specific platform or with
some weird config combination, it's a problem.  But I guess we'll see
if anybody else trips over it.

Bjorn
