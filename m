Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39428C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 22:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B89020880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555366810;
	bh=kLj6wpbb7vDHRaZbRPhsXOZhxjEdDfzHs6TA1bTC1Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jsn0jULAceYYXRdbkgmdoTqnNT+CA4koCquZAx3vnpCTF8WWAGeyYMB3xw1CsoyLL
	 b54TNs4CRazMVGJyKp3pccl7SBdJgKBdD2pUGBRoL8iHsow+Y3bqJlUHHfcnJk8b06
	 RHtpPBaOkO8Qn1ZnSGdJlDkUX0atQdB2BxV0k6pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfDOWUF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfDOWUF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 18:20:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7F620880;
        Mon, 15 Apr 2019 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555366803;
        bh=kLj6wpbb7vDHRaZbRPhsXOZhxjEdDfzHs6TA1bTC1Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xIYTht5TEGNclQblk9u5VtYfFxaLdB/EmW1oW3+e0gegJfmKxrrAPQcYaEwUbQgEU
         +9uaBkjdN5pD/gQdGf+U5O1XyXwlw6vdd2aEOgg2G7DGy+pfCTU3jaM1QTKrhfzHZu
         YXoDzd51SLvEK94+siJFiRFgbtFQvE6YvUr3irfM=
Date:   Mon, 15 Apr 2019 17:20:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v3 0/5] PCI: Patch series to support Thunderbolt without
 any BIOS support
Message-ID: <20190415222001.GN126710@google.com>
References: <PS2P216MB06429DB03193EF6635554275802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB06429DB03193EF6635554275802B0@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 05:08:41PM +0000, Nicholas Johnson wrote:
> I have split the last patch into the two patches as suggested. One to 
> add the new parameter and another to rename them nicely.
> 
> There is no longer depreciation of the old kernel parameters - they are 
> simply dropped, as suggested.

I did not actually suggest dropping the old parameters.  I said I
wasn't sure the user confusion of deprecating the old names in favor
of new names was worth the trouble.  I suspect we should just *add*
one new parameter and leave the old ones unchanged.

> I would find it cleaner to just do a single patch without the 
> depreciation, as both patches change the same things, doubling up on the 
> number of patch lines. I can still do this if requested.
> 
> Bjorn has fixed a trivial problem with the second patch in the series 
> not applying cleanly due to changes since I first sent it. He said not 
> to bother fixing it.

What I actually meant was "you correctly posted v2 based on my master
branch at the time, and since my master branch has moved from v5.0-rc1
to v5.1-rc1 since your v2 post, I'll do trivial fixes for that."

But since you're posting v3 *today*, and my master branch has been at
v5.1-rc1 since March 18, you should rebase your patches on top of that
branch first.

> Nicholas Johnson (5):
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
>   PCI: Cleanup comments in setup-bus.c to meet kernel coding style
>     guidelines

We also talked about moving trivial cleanups to be at the end.  The
important things should be first in the series, with cleanups at the
end.  That way backporting is easier, since people may want to
backport only the real fixes, ignoring things like typo fixes.

>   PCI: Fix serious bug when sizing bridges with additional size
>   PCI: modify kernel parameters to differentiate between MMIO and
>     MMIO_PREF sizes
>   PCI: Rename pci=hpiosize,hpmemsize,hpmemprefsize to be more readable
> 
>  .../admin-guide/kernel-parameters.txt         |   7 +-
>  drivers/pci/pci.c                             |  18 +-
>  drivers/pci/setup-bus.c                       | 512 +++++++++---------
>  include/linux/pci.h                           |   3 +-
>  4 files changed, 287 insertions(+), 253 deletions(-)
> 
> -- 
> 2.20.1
> 
