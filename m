Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C43C282D7
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FABB21874
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuQtwGQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfBKUUh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:20:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56172 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBKUUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 15:20:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so561840wmh.5
        for <linux-pci@vger.kernel.org>; Mon, 11 Feb 2019 12:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAAi/4FzIf09tpkf+Zh8oYYOPEwKWoi/dcPCtlnCDtY=;
        b=nuQtwGQD0bK+Fbxw7g0Au81tIxctuq5rDA8OC+jeTqDg239gxPbSIbwXrgO4aVDUOs
         E8/QGpxawbey0NXWXuW4dapAEna7WQ7ekk1y6q200JuUebgzg8KhFgpUmXVcpIvkf2eF
         GVLr7rDfVbdfzcp88U3sv889i4+KmRL7wHJUEJRaCSbzfigBTexHY5SOpL1BUjcumqs0
         v8TqJWar4LvZPA7L7nvQNCpAvPjs/DMNUMML4oVWhR8EQhp8hUWRjO+zofYIr6YxQPlF
         SjmarQ8WTdwivapRVFBg/dQbPmDQIPeSpsEBDlMrD5dAcxu8D49lzrLUiH+UauLpHwwA
         tcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAAi/4FzIf09tpkf+Zh8oYYOPEwKWoi/dcPCtlnCDtY=;
        b=E8QHKwARsulpwBQ4eHEqgnJoYe0QG+04RcP0a6frWTDLTf29rc308PjH02/4YHP0Ro
         dymtQkV4+YwHzhYo0R7YSuZkiKWNxVkAc3b2/SsJZzNGcDpHtFZD7shutU3vPat0hR5S
         M2lz8sH8aInRYWz03XuL3FUtSTckyMCLoJ3lvAli8hF+vXcnzeQFINn8PHW7NPMkQ7MK
         /2YHUglgBhZf0E8iAnER8D1mXdPBOe4zai2LXuu83eNoZwmG/Blmb6PvGDDOVuPqllPq
         5I94CqANb80fxEVkbE4b76wycASlsrgtOx98Z4fJoQL9dMPlqy2b7LZ+ZebC3vm2rued
         J/sw==
X-Gm-Message-State: AHQUAuYRfrEOJpjlb4HZDw4Y9lv3IlzD9PqB4YXJkeaEQZ0gnVkFQrl3
        vp0blJHC2M1mF+zsGW2gXPaV1zMNRwyH19WNr7YBpbN+pQ==
X-Google-Smtp-Source: AHgI3Ian7HYTZxKIQ2xF3BDEekZH6u0k3t/n00lH2MkBt/sYKgnvgyrGeYDc+WDqLZsFUlNkZW1lucoTkLw5vLqzUMY=
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr893579wmc.123.1549916435350;
 Mon, 11 Feb 2019 12:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20190207133005.67328-1-alexander.shishkin@linux.intel.com> <20190211172611.505A2222A2@mail.kernel.org>
In-Reply-To: <20190211172611.505A2222A2@mail.kernel.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 11 Feb 2019 14:20:23 -0600
Message-ID: <CAErSpo5+vJ=zB0epJ7U9KWUCNnCH-wxyiTu022C-AaRh5R0NnA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
To:     Sasha Levin <sashal@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86@kernel.org, linux-pci@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 11:26 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: 5118ccd34780 intel_th: pci: Add Denverton SOC support.
>
> The bot has tested the following trees: v4.20.7, v4.19.20, v4.14.98.
>
> v4.20.7: Build OK!
> v4.19.20: Build OK!
> v4.14.98: Failed to apply! Possible dependencies:
>     fa564ad96366 ("x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)")
>
>
> How should we proceed with this patch?

This patch should be applied to all stable kernels.  There is no
dependency on any other patch.  There will be trivial conflicts on
kernels older than v4.15, but those are easy to resolve.

Bjorn
