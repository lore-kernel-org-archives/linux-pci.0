Return-Path: <SRS0=/pen=DD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B77C2D0A8
	for <linux-pci@archiver.kernel.org>; Sat, 26 Sep 2020 07:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C45A2080A
	for <linux-pci@archiver.kernel.org>; Sat, 26 Sep 2020 07:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4wmkPfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZHuB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Sep 2020 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZHuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Sep 2020 03:50:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D15C0613CE;
        Sat, 26 Sep 2020 00:50:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so4810893edb.8;
        Sat, 26 Sep 2020 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrAfMnN1cDVaMgoAsNfzzlqzPewf+U+U/Sjm7fSeqNs=;
        b=O4wmkPfXCecoN5FIWCHYSlxfWMvhXCKD1C8ypWpVKcWOHlrpNJD2QOPuD5VScGwNFI
         x5gT5ck5NDes3Wt6P3trkdluUur8rZc8o5Z+fkxZVHf8fTSL9IKtd/WgN+jM/3VCS185
         PleEjvyhP4GtHlgnW9cVV6Klztu5k+MAk7ixl/uTxbFptTTEwPx3GISZh10xcDbhfGoH
         COk1jYShjG0kz+zk6xyv3/6ZNYRalazfV79zILZbkp0pomAb51NSZG2nmVyORe8p4y/Q
         ACfgU6J53D7zpR7Cr0bkBFzrgEJllUp5GCYzTJdFtqHTYd5mU8znAZlOU4hZ1lqIaOAG
         pddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrAfMnN1cDVaMgoAsNfzzlqzPewf+U+U/Sjm7fSeqNs=;
        b=osn0D3DUUgASPxe7a/dNFbbkCRZqY1uYNHZE0K/PekDN1e5nFdthPCMH0f2A8510qa
         1w/w7To8AmcLJuIumhO/MMAUCM0qmwIw+iJ7VSp7rdRd/WzCyrEwfMljSjJSqHuUdJFN
         8D9HzZsxRajN0A52i0XL/Eklwo7YNHWdYlfBBYf3gCT8bV6ge5T4pEboE0LBCtW0im/p
         T0n94GVVpztNb/DhinOVXHBC14TymHmw7/4Aw3/GsiQtKB8xGwmasQAmpkP7qccbN6Ek
         uVawdY56uZH53uRquo6eH8hetXrvw1KyvQgANy9pE9n6iU64LdQQabh7xTSVkN9jbOF9
         xnfg==
X-Gm-Message-State: AOAM533Oob6nL1PHhSidCwKjxc7BO8kEcxjpAi5qdGcoCJqmwldkXseQ
        mDLbnjrupmkQeAAdmfYq1hQ=
X-Google-Smtp-Source: ABdhPJwuExWLiVytMZwBjaDi0kpbv0Acdl+GRGEp/9DK+txT0NXtCVnJKwqq37z4dEKjTUi5Rk7rZg==
X-Received: by 2002:a50:a694:: with SMTP id e20mr5424804edc.114.1601106599202;
        Sat, 26 Sep 2020 00:49:59 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bee54.dynamic.kabel-deutschland.de. [95.91.238.84])
        by smtp.googlemail.com with ESMTPSA id z16sm3597662edr.56.2020.09.26.00.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 00:49:58 -0700 (PDT)
Message-ID: <9f5d395618ebd435a573527137370937ae3ef723.camel@gmail.com>
Subject: Re: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't
 ready
From:   Bean Huo <huobean@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Date:   Sat, 26 Sep 2020 09:49:56 +0200
In-Reply-To: <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
References: <20200918123800.19983-1-huobean@gmail.com>
         <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
         <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

seems the Hisilicon PCI driver maintainers are absent, however, we are
still using their old platform based on Kirin.

hi, Lorenzo
is it possible to take this patch without Hisilicon maintainter's ACK?

Thanks,
Bean

