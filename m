Return-Path: <SRS0=pUIZ=NJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8AC6786F
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 02:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6720843
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 02:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAdLBKm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB6720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJ2Kqv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:46:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41571 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeJ2Kqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2018 06:46:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id x31-v6so5896645edd.8
        for <linux-pci@vger.kernel.org>; Sun, 28 Oct 2018 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bELmzBTuMHrn1Cuixa7w+s6wYw/qxRoO5oxzq9ZUyyo=;
        b=FAdLBKm9uEQmDgHGVu+35UOdROIQiZhf0SsOTL4QuHLiKvnYdemw+0o0egBuXVNwkL
         kXwSIvVsfI8+ZpJlkXtpQdQEqCx+8oo4BYwukmw5AP8A6GU5BK7VPiJDceha4YmlcOYb
         WXEueWjYo6iKRAQH9FG7AmKHunbI1lycS/8SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bELmzBTuMHrn1Cuixa7w+s6wYw/qxRoO5oxzq9ZUyyo=;
        b=GkmjD5KnXf3FRHwi/CGxPGTh/6pVndjwE2DQ/4GNLStmez6P26J9hvrHkCsJSf2l4X
         xLcY+gUT40MjEmCdDQNDd/a5jLRA1MaHBojvMRqts+5ZEGGV18sBVl7HyHQWpUw+EjxO
         hQvBMTVKuGOgL4JMv3OizVxx4JqXRWQ09qhbOObLAeddXrjpGpUBJIkG/LU8UmRU5Rl4
         wdkvKcF1A91rJwr8HjPn3+PHV8UGvbMufJnF1hUwSUGDzetxQ7uTvcsQ+iG6rMj44lM7
         qxznDvXYG/riOXGfmug5GdUcZvTApGwmS3NDEpseeHM9OnXxykaaPOPoDI18AWC1SoLB
         0aIg==
X-Gm-Message-State: AGRZ1gLTkNWl8Yqp6dkBL7io21NRowJU3aZfSUWQaurLfdl0bFeb5eoJ
        EtH4zTBn7hXMLEenQEIskrsUoRDvUQlKDHt+uAaJ+g==
X-Google-Smtp-Source: AJdET5dCGcnpRGynoSvW6naeusxRla/vYURXk05FJu8skHbFxZgUXwrcF334wUa34SIs7djzPeDxHfuTqPUZD8M3ChU=
X-Received: by 2002:a17:906:4b57:: with SMTP id j23-v6mr2891736ejv.122.1540778420620;
 Sun, 28 Oct 2018 19:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1540665079-27788-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1540665079-27788-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 29 Oct 2018 10:00:00 +0800
Message-ID: <CAAQ0ZWRXUotcf5u3CAnic=RqKOhVy2irQQw4jZHr_L5fYDZwVg@mail.gmail.com>
Subject: Re: [PATCH] PCI: histb: constify dw_pcie_host_ops structure
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     sunjianguo1 <sunjianguo1@huawei.com>,
        kernel-janitors@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 28, 2018 at 3:06 AM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> The dw_pcie_host_ops structure is only stored in the ops field
> of a pcie_port structure, and this field is const, so make the
> dw_pcie_host_ops structure const as well.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
