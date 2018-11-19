Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532FC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FB2146D
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elBeBSBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8FB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbeKTDRd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:33 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44743 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403869AbeKTDRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 22:17:32 -0500
Received: by mail-vk1-f193.google.com with SMTP id h128so6924021vkg.11;
        Mon, 19 Nov 2018 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2utPuwtZaCV/BmH5oamaY9JFsO2JnKsPFc89xDdn59s=;
        b=elBeBSBf3Zl0/mRynD7UsrBRw6KfrNqMca2tnv/vVJsRzHdSBUQhSf/NkBafIpUsJO
         fvMMHRTPh+UFjBgBKxIJkRzLeWbPBzkw+4nOVhNbcC8EIsebSPiNJ//RCBLjfiv1ooEx
         s5OjIVB+wkryf1qO4UFtnEfVEBhn6SKZCxc2sq4A4HS/6pLaCW34sFtBO3978QPn5f/n
         jrXv6FKEfB49BggqUaPqTtb6hWBt0xOEeGSL49+GIk/gNG4Z9rOivy780SXsSGCBAG7J
         AYt4JojfY8z4Pvh6Mpt6OCJ+WM6/lSv9tWGdzE1sd73pfupkKkV1Quc6LhWttFIqVhWU
         WqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2utPuwtZaCV/BmH5oamaY9JFsO2JnKsPFc89xDdn59s=;
        b=rZTRikSP+j24uKklt9efSBg7gLCKUEy8jcWW3Jx21/Co77mYHndprs45xATvDT2t/D
         KcbChqjQkEUU6QpJE4QO25sDY3vmdB8s0NRJdNcDoFVsjsh/yuBJnx+NvkJ4o8dMClcF
         03lL0RrxdMsvXLuroSrd2m6FtFQNqTOeYba/Oaz0M3fPJ2vGoh6i0tH2EIYgsASCLPXT
         zW5U9gBIDYmTq68zAW9c77g+VIFQSJOVpB/rGgmiaOp+cek/StdIK/oNjfrobR4Yh8wa
         /rzgBhS/jiujk8yyuvPmKuncZgVYyd07dQrPrRrpx7YhOX54oNgm/C5m00x6eyIa9fLh
         oqEA==
X-Gm-Message-State: AGRZ1gJjJNpNZqZ2O5eydPBJR+y8+TcV+cf7NKbfkRYqW2TTarwxb+5f
        PDROdUKIILpOKAvDBnqBk9vLBFS3UHHs25DMYro=
X-Google-Smtp-Source: AJdET5dZ7CQPQ4KJW9mM/hQray2H4bTnuMC33GiMtLZADf9s5aJqFPlWISsy5TPD8/16LMLyGPJLrj1LZw9ptDHFTSU=
X-Received: by 2002:a1f:ac4:: with SMTP id 187mr9150831vkk.31.1542646398411;
 Mon, 19 Nov 2018 08:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20181115231605.24352-1-mr.nuke.me@gmail.com> <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
In-Reply-To: <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Mon, 19 Nov 2018 11:53:05 -0500
Message-ID: <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
To:     okaya@kernel.org
Cc:     mr.nuke.me@gmail.com, helgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc,
        sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 8:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 11/15/2018 3:16 PM, Alexandru Gagniuc wrote:
> > I've asked around a few people at Dell and they unanimously agree that
> > _OSC is the correct way to determine ownership of AER. In linux, we
> > use the result of _OSC to enable AER services, but we use HEST to
> > determine AER ownership. That's inconsistent. This series drops the
> > use of HEST in favor of _OSC.
> >
> > [1]https://lkml.org/lkml/2018/11/15/62
>
> This change breaks the existing systems that rely on the HEST table
> telling the operating system about firmware first presence.
>
> Besides, HEST table has much more granularity about which PCI component
> needs firmware such as global/device/switch.
>
> You should probably circulate these ideas for wider consumption in UEFI
> forum as UEFI owns the HEST table definition.

I agree with Sinan, this will break existing systems, and the granularity of the
HEST definition is more useful than the single bit in _OSC.
