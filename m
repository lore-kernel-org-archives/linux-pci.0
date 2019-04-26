Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A7C43218
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94720651
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTjHsDtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDZQOm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:14:42 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51766 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDZQOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 12:14:42 -0400
Received: by mail-wm1-f53.google.com with SMTP id 4so4507750wmf.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2019 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyBJ5dyxO5fS0680t4YIsahVAObLqSu0H1kG9kfEnrA=;
        b=pTjHsDtU4C/aCw4vi1k547wCjhv0z/i5YLCpZb9FOcDRk48OQxqS6IYSEuAaEaA+HU
         2N6pl9GP3a5PFHWm/S0QLQ4nE1hQiQitFsPVZtny+rPo4boj2gaSGpUI+tX9AfBoWl4R
         IHdrSNCFzkF9Af2Px6O06QuLkij8vVvvxGWw9lNlziWCn9XfvpFdUPCWGQz6SvOV0hjs
         l+kVaetzPwRrEPMprVYQdbIFR7RuXOsjad7swxE8DAUncOGqDmFfNCrcex+ReL+GoR3P
         UsqtWAMNSu1PI1yxaIOiZfrPe+Qbu8KSZyoYP6YKoDxAGEhBmm19DaeCDnYJu8NTWTf9
         niFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyBJ5dyxO5fS0680t4YIsahVAObLqSu0H1kG9kfEnrA=;
        b=CXiGVf8Mzh8qTDeKMh7Y0+pWkMPj41R8+AAx9lUPZVGu+mpFII8LIva/2njCPkIw/C
         yOu8Qa3QWj0lJWK+6dPUdVrhYn9Gffr3r4sPqIAGG/tHahlfnIGH00XEgeVZQRG2rd+m
         HgTuaIFeN0bw2Y8+HAmpHN16L+vaX+pMafxYihyWc2XWQDvXMZHaKiw+BvILY/6B6sfh
         D9d05y3yc6YyIFsyibLplH9w4NVUhtO56MXL2vlG9zJA9zBW6BvOl6MUuv88FMOkBMnQ
         wWnJHhgEbuoggdLgjQVQidVNmbquJ3kl7MD6CTZfIFT4sr7f1ojluOePjcx++BGJfifi
         s+yA==
X-Gm-Message-State: APjAAAWvkUwfEO6DVUz12copqm6QPPJ0+gKE6IbDtwHu3GC1UfFkwZpQ
        lxobEIliDvyCmtawzYQlf3wwkaV6pFpxTRQcdFGoCQg=
X-Google-Smtp-Source: APXvYqy6XVl8PWz5vgMa6s3klkrtVukYu4f0n6+Mf7IuT14g/dvXRamcKvkKWl+2U3ygos09AGP2vCYbStN5GzRN2JI=
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr8098648wmj.62.1556295280263;
 Fri, 26 Apr 2019 09:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203435-193951@https.bugzilla.kernel.org/> <CABhMZUV2bSHUeZErR8=AQrBvuJHeKEMfQJbGTVRgcxZcXp6i2g@mail.gmail.com>
 <38d59480-3057-9352-677e-a365ad526990@xilinx.com>
In-Reply-To: <38d59480-3057-9352-677e-a365ad526990@xilinx.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 26 Apr 2019 11:14:28 -0500
Message-ID: <CAErSpo5Xs1XP4i206YKgyubDtZbhY9gqoyruLr6Q9o2dVP4iFw@mail.gmail.com>
Subject: Re: [Bug 203435] New: Xilinx pcie endpoint DMA not functional for
 ZynqMP PS AXI-PXI DMA endpoint
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Linux PCI <linux-pci@vger.kernel.org>, dtyree@newagemicro.com,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 26, 2019 at 11:11 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Bjorn,
>
> On 26. 04. 19 6:21, Bjorn Helgaas wrote:
> > [+cc linux-pci, Xilinx and DMA engine folks]
> >
> > I'm not sure what to do with this report.  It mentions "vivado" and
> > xilinx_ps_pcie_platform.c, neither of which seems to be in mainline or
> > linux-next.  A Google search suggests that Vivado is a Xilinx product;
> > maybe this bug report should be directed there?
>
> vivado is xilinx design tool for programmable logic and soc setup.
>
> And this driver is not in mainline but just in xilinx git tree.
> It means you can simply close this.
> And author should contact Xilinx via forums or via git@xilinx.com if
> there is any issue with this driver.

Great, thanks!  I've closed the upstream bugzilla.
