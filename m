Return-Path: <SRS0=Txbz=2I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3FC2D0BF
	for <linux-pci@archiver.kernel.org>; Wed, 18 Dec 2019 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6172621D7D
	for <linux-pci@archiver.kernel.org>; Wed, 18 Dec 2019 20:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Puif9Gyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLRUIt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:08:49 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39698 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfLRUIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 15:08:41 -0500
Received: by mail-qk1-f171.google.com with SMTP id c16so2658080qko.6
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2019 12:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sDlAeGFSmuOPJIdaVCheDUB1XAlsdHi/FffbCc95Ra8=;
        b=Puif9GypwrQtjbsQK8ssX/sTE88A9hLgknoNK9bE2Tr3hQlrLqrGonXSit8dxhiPQy
         URHSTVlBP20bJxzr+YVFUC1Ycyacu41JPPT9WmywVkKdSB9ILrBRNdKDnlzCRV8w3ijJ
         nyRwXgmrn7QDRn4rswxRfAYV/RiztD/ZUTMXy/wCH9K5ieT4Dyc/4vOnaeEZamC5gfQN
         ibQzgWJhdNc3LIaSx89aTtQNcJ9pxUvEiLWlACd7/J4jQtyUEBBfK822o6ldxaK9flrP
         wxSRIL6fx77pYLPEdw/fw+d5/JeBTeZvoJS7PFlYtmRQp0JewIRh2yAw9xO/ZEJ6Ugz4
         Qu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sDlAeGFSmuOPJIdaVCheDUB1XAlsdHi/FffbCc95Ra8=;
        b=N92YRP8LckEyN9/ooF5OZSeoAGQ/GVOdzHaTy4gB4gyf5NsKKZVmYq+hbXA24xzzAU
         omDPnJ4/0rVJkrvS3XhVwj4D0riyZpnG3bV1UtrUVyXcTMCHgyY9HxYRFNULBEiyEunB
         XSxNvQaMi9J9oRN8kSFhsV2oGcyeyzz8w+2FKLD3b+Sst0YQsRQxO27l6udZY/a6BAkc
         tArMGVn/z1i1BTZnG91CF7DvX4sMdgtIndx+H2YHNzUFkMC2RJMZaSbt+PMqTAe3K3tn
         Ed4FFVKm4brQfwhsye8JMMR4vPQePmAmcxbT9H/z7nJAnAjo12JHjun3tlMWCkmjT912
         XWHA==
X-Gm-Message-State: APjAAAVeNCW4ezGsZoT5GrerzIPcjmOc5+TFKwO6a6OHZfwt4oCQuNgb
        HhWXeKmbdB7e5e9G9nWV/5iKiA==
X-Google-Smtp-Source: APXvYqyKGvtJzZQjZX/PbPQ1vKT7+1e2hb7ObNbF58CYF8zFLGDBSnVcsJf5O2Hyg9ssOO21uOYolg==
X-Received: by 2002:a37:9bc2:: with SMTP id d185mr4481421qke.422.1576699720623;
        Wed, 18 Dec 2019 12:08:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 17sm1089576qtz.85.2019.12.18.12.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:08:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] pci: fix a -Wtype-limits compilation warning
Date:   Wed, 18 Dec 2019 15:08:38 -0500
Message-Id: <935EF32D-2D9C-46AD-A266-77A259DAE91F@lca.pw>
References: <20191218182412.GA115305@google.com>
Cc:     jamessewart@arista.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191218182412.GA115305@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Dec 18, 2019, at 1:24 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> Ugh, that is pretty subtle!  Would you mind if we used "unsigned int"
> instead of "u16"?  "u16" makes it look like just a mistake -- somebody
> is likely to come along and say devfn only needs "u8" and try to
> change it back.  The same might happen with "unsigned int", but at
> least it doesn't look like it was chosen specifically to fit a devfn.
> 
> Provisional patch below.

Looks good to me.
