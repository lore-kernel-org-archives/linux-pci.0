Return-Path: <SRS0=DH7G=C6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F62C43468
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 11:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9A6218AC
	for <linux-pci@archiver.kernel.org>; Mon, 21 Sep 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ2PIn2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIUL2i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Sep 2020 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgIUL2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 07:28:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9032C061755;
        Mon, 21 Sep 2020 04:28:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so12351244wrv.1;
        Mon, 21 Sep 2020 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrB+wCY042lJLf7nGNWVAiX4/elJqpuJ2MLbBI8/1x0=;
        b=lJ2PIn2hyoicpc2UNBXM2gN4WBR9xUocX0CtaRAH1XEa1qqh0K3nyX8RXr586ComqS
         PXnrJXhtzG+wJmllnrGIUchNGpHYdFb/wX+qKb0BdbQC1EwTIjEUQiCEwt6PFomHiCux
         ncvCOwye3NFC+/iwCRVNBRzNy96hA4kSK8Hx8mxkFTHhM36udC+fFGFcuTtHk384dxzh
         X3T41btIzGWFA0tV8kaChIWjovCidbqL1YtOIIocGDPQIiXEFTSLltnzukxKavn5VUjj
         MHNAVIN4wrxH+ZpdyAV1maFMOLSSAuAqyVGdWLotwE2PRzlv+BpMN//f/gR2153lBivD
         oXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrB+wCY042lJLf7nGNWVAiX4/elJqpuJ2MLbBI8/1x0=;
        b=rJDnF0V6fRNTRMTPS8REUhqGTPLLxc7G15/bZL56RxtFRjs3/GFwCEIOYlLUQnOPgf
         lUymz8YnHz/Oj1ttb47m1WLplVb1GQaMbSeyPMnaS1qWrZpzdkrIX2nhOdBsnr+WTzRn
         NaLzHy1D44sGl9xCA8qX2kdfcvSfFy5+TG18Bm4UrCT+yB7tJbxnzZZe3yh6qBfzlj9f
         bRX9FOYmaP4UL8gDAcoDIqNNrO1gqUsBTSHVOcQtZTpywlTAo0mAH5OYTLZg3wwWyO6w
         m5weLCZkI3OWe4pb0APok9txXek34lT6VUdVr2CildmkSJU8tqM3W3RjvKUgOHd5Dpd8
         gzUQ==
X-Gm-Message-State: AOAM531+HL7FCQ6uZzVT0iMYHTLqkMyr346HB0sGrdDpsau5IzANTUq3
        nbuiHX7ME/nQ7Ip/nmhnBa2FdD+pWMVyhrAG
X-Google-Smtp-Source: ABdhPJycm9Y99RJHGX/Hg/HjpMbDZDId4vDXQhBo0nw9OZ9zQ7dzBrgjK0IcrYyHKRZb487w39n/8Q==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr52716640wrv.343.1600687715532;
        Mon, 21 Sep 2020 04:28:35 -0700 (PDT)
Received: from ubuntu-laptop.micron.com ([165.225.203.62])
        by smtp.googlemail.com with ESMTPSA id t17sm20628056wrx.82.2020.09.21.04.28.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 04:28:35 -0700 (PDT)
Message-ID: <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
Subject: Re: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't
 ready
From:   Bean Huo <huobean@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Date:   Mon, 21 Sep 2020 13:28:31 +0200
In-Reply-To: <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
References: <20200918123800.19983-1-huobean@gmail.com>
         <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-09-21 at 12:22 +0100, Lorenzo Pieralisi wrote:
> > Fix the above issue by letting kirin_pcie_probe() return
> > -EPROBE_DEFER in
> > such a case.
> > 
> > Fixes: 6e0832fa432e ("PCI: Collect all native drivers under
> > drivers/pci/controller")
> 
> This is certainly not the commit that triggered the issue so I would
> remove it. Kirin maintainers are CC'ed, waiting for their ACK.
> 
> Lorenzo

Hi Lorenzo

Thanks very much for your reply. It is true this is a bug which was
introduced by the origin commit. It is ok  for me to remove this fix
tag.

Thanks, 
Bean

