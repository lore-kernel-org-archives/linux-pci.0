Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B02C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 19:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E467321904
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549569156;
	bh=yNiMpTVg55DaX5Wf82kFMN/MvA5KnKfjzih2bD2G7iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MS3rn3Ot83i5pyQ7owI7Iv4quaYcjCBIAhQVlGk51Xb3jEnZyBCZjAQvWxRBpM22g
	 yMfHu5HD7Ygz3bOeKXIDgGYeRSFyJUbFlBF9e02Sao/C3wxuRMpBbYe23/pjfLMKpr
	 2UHxk/CK1bBKEyVtENy5Atn5QDBm2ssZOIzZb21Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBGTwf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfBGTwf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 14:52:35 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9A32147C;
        Thu,  7 Feb 2019 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549569154;
        bh=yNiMpTVg55DaX5Wf82kFMN/MvA5KnKfjzih2bD2G7iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+hYjJZdsYNknAZCPGXeN2oMMyEhTpy+RSXu9dl/HyycUAcl8E7nH471ma+Mmeymp
         GG9RLlISCngYJDib5cVcO824lVsGIaNNBSIr0N3AOYzxbkXHR5YLdzkFeHyoHSi6mw
         3UdqSqt4aB8x6fqygxfHjFJ0g5T6nEfy9CoaxMxs=
Date:   Thu, 7 Feb 2019 13:52:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com,
        poza@codeaurora.org, fred@fredlawl.com, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        jianjun.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190207195230.GJ7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
 <20190207151816.GI7268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207151816.GI7268@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 09:18:16AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> > change the class_mask values to make portdrv support this type bridge.
> 
> I assume you have a Root Port or Switch Port that supports subtractive
> decode?  I'm trying to understand how such a device would work.
> 
> Out of curiosity, can you show the "lspci -vv" output for the device
> and the downstream devices of interest?

Actually, since subtractive decode has to do with how the bridge
interacts with its *peers*, what would be interesting is the host
bridge window information from ACPI _CRS or DT and the lspci info for
everything under that host bridge.

Assuming we're talking about a Root Port, I guess that would mean
anything inside the host bridge windows but outside the positive
decode windows (the normal PCI-PCI bridge apertures in the Root Ports)
would be claimed by the subtractive decode Root Port?

I guess you would want this because this path ultimately leads to an
ISA or similar bus where you don't know what resources the device
actually consumes?

Bjorn
