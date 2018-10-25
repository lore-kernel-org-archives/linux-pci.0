Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4144CC46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CFD20824
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 05:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd7ixMhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CFD20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeJYOLY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:11:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55296 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeJYOLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2018 10:11:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so147842wmc.5;
        Wed, 24 Oct 2018 22:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+bLT3fIPKhqWO7xUh+hzxzAin5FMHbuAN0zrznYnV8=;
        b=Wd7ixMhLdrILA2zNr3cmdn2L/5T6eBZJl+heEZmjelG+Upp1K/c5ubfBurkjhLvtWI
         ReAss10rXghWdjzqGHQhA3CBvromIg3KJ6m6HFjirdelFxo2/RFcAGaqjxqys2OTbZcz
         5x009nDAXtOUwXXeXBHRtK+4vJ0VLSnGuHIz5b0dY0NwloIxV0ho9TdyFYx1Nqcm8i54
         m6MIywG7jUYhufpBMlSbCecQQwVltTN2IgZQFWxC39VVzghhhz9sjxUpXig0HZc9SruH
         jdFg/bgrfOAJOmMy+LyHlSgcXEexJQoW5m/VJ4OOZwkDE8odCxcGNcEY2Z/cWu6MApZu
         jCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+bLT3fIPKhqWO7xUh+hzxzAin5FMHbuAN0zrznYnV8=;
        b=KI36+fBSd12wWkPYQ3HBq0NN7PiYY7IFgd09D17UhwSq7nyxLakZZjwvC7ZwEe+1j6
         /qasgodRH5lGCbuzKhYO+Gk8zaA++7cs3GuPkf6cbhSK7sezBr2/hFdE7q5IPO7z5eRz
         v6UuQVq1BoORjn2iQjtHNGMZXtdfxFKfgxLhZ2IvlOFgfSvLofOLxNzw7LjzjJw/INm6
         2KmpeSC+Fy9LI/5SnJ0owH3NDrN5+LwzqGLPDrQyATB0DDpwA1nv6Hddzi1NB2oStRiY
         TMM7Dr/gfROLSvoWFbA2a7tBT54s8dlHfYyKtSk0XATORGAto3px7Bbp/9Foev8QVoUr
         XZww==
X-Gm-Message-State: AGRZ1gJCUeId4sCZMafUw9z6AJvnj90pQpBaOQS0owCQ6STmtUUZCSXU
        pEYEUE4+U+3t7Zs2Hx7Cyvc=
X-Google-Smtp-Source: AJdET5ftELGcQLGWcfokWOm6MQs2tofxC6053yflvrf7/V1l9BZ9bsRhl19nTWvWJ4c9/xK0BVJAzQ==
X-Received: by 2002:a1c:5d54:: with SMTP id r81-v6mr241384wmb.88.1540446014793;
        Wed, 24 Oct 2018 22:40:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x8-v6sm15254814wrd.54.2018.10.24.22.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:40:13 -0700 (PDT)
Date:   Thu, 25 Oct 2018 07:40:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add x86 early-quirks.c file pattern to PCI
 subsystem
Message-ID: <20181025054011.GA55187@gmail.com>
References: <154041923937.26247.17083948926896599419.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154041923937.26247.17083948926896599419.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> arch/x86/kernel/early-quirks.c contains special PCI quirks that need to
> run even before the usual DECLARE_PCI_FIXUP_EARLY() quirks.  These have
> typically been merged by the x86 maintainers, which is fine, but PCI folks
> should at least see what's happening, so add a file pattern to the PCI
> subsystem entry.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..63cb7f3dbbb4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11249,6 +11249,7 @@ F:	include/uapi/linux/pci*
>  F:	lib/pci*
>  F:	arch/x86/pci/
>  F:	arch/x86/kernel/quirks.c
> +F:	arch/x86/kernel/early-quirks.c

Good idea!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
