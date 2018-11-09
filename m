Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55390C43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 00:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27C20892
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 00:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xKDwz3N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B27C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeKIJlB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbeKIJlA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 04:41:00 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634B320855;
        Fri,  9 Nov 2018 00:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541721780;
        bh=AU7s0hxISLbndazbOtKy7OKnOr7YO4cmUQe6Dacb/FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKDwz3N2/dDsLRBAZ4uPsJqofibLchVA2GaMjuGZW9FnOq2Zo8aM15K9II0B8Y+Pi
         hTsKzWD/SFAJVh/CfJje28OHDfRpxHyuhdSVRu1em+wqBteUdTYBJEQGP82pvCqreD
         xkQmFGSCXFhJXz00nK8XAAoNqL9qhYoz9SCDNxUw=
Date:   Thu, 8 Nov 2018 18:02:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Fix Broadcom CNB20LE unintended sign extension
 (redux)
Message-ID: <20181109000258.GJ41183@google.com>
References: <20181025135231.27817-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025135231.27817-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 25, 2018 at 02:52:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the expression "word1 << 16", word1 starts as u16, but is promoted to
> a signed int, then sign-extended to resource_size_t, which is probably
> not what was intended.  Cast to resource_size_t to avoid the sign
> extension.
> 
> This fixes an identical issue as fixed by commit 0b2d70764bb3
> ("x86/PCI: Fix Broadcom CNB20LE unintended sign extension") back in 2014.
> 
> Detected by CoverityScan, CID#138749, 138750 ("Unintended sign extension")
> 
> Fixes: 3f6ea84a3035 ("PCI: read memory ranges out of Broadcom CNB20LE host bridge")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

How lame that I fixed one but not both with 0b2d70764bb3, sorry about
that!

Applied to pci/enumeration for v4.21, thanks!

> ---
>  arch/x86/pci/broadcom_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
> index 526536c81ddc..d09c401a300d 100644
> --- a/arch/x86/pci/broadcom_bus.c
> +++ b/arch/x86/pci/broadcom_bus.c
> @@ -50,8 +50,8 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
>  	word1 = read_pci_config_16(bus, slot, func, 0xc0);
>  	word2 = read_pci_config_16(bus, slot, func, 0xc2);
>  	if (word1 != word2) {
> -		res.start = (word1 << 16) | 0x0000;
> -		res.end   = (word2 << 16) | 0xffff;
> +		res.start = ((resource_size_t) word1 << 16) | 0x0000;
> +		res.end   = ((resource_size_t) word2 << 16) | 0xffff;
>  		res.flags = IORESOURCE_MEM;
>  		update_res(info, res.start, res.end, res.flags, 0);
>  	}
> -- 
> 2.19.1
> 
