Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF472133F
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1NkMX5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF472133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeK1FpH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:45:07 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39474 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeK1FpH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 00:45:07 -0500
Received: by mail-vk1-f195.google.com with SMTP id q80so5312667vka.6;
        Tue, 27 Nov 2018 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQTVYi/IX2AKLhpwGzc+W4Z78Vf1wsvfIygNygWDrpE=;
        b=O1NkMX5gSQym1ZHxSW2nPI7UUNMYYB1BcymE3f/pL/1krh9wyMNUjpCwmoboD0HNks
         kKSIspCARkYH0R6sSZfmeLToD5RK+eDRTVmHKSAGe66nEkNzSV3vcaDm4aqtCN9cHxxr
         LMW+EgdOWYAbw/t0uorblBvknJ/Pm7tGQdsCNOAwIrQmMXa4qa/yYuOjW9V8URPLtNle
         lxhlDYNkgSd9Wjx82AH8yCQ+61f2TEBtIpgwrb7lp31xi/15wxy52AYoV4pda8u6yEEt
         KZPbfTZ+4Gj9MYY9jEUkbHrKiPkDWlYdEfUI9Ls4QFvPKeS9Bq/8wWKZQR/ccfoTTLST
         c15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQTVYi/IX2AKLhpwGzc+W4Z78Vf1wsvfIygNygWDrpE=;
        b=INHh31/BHkLWKPayqvqxQS3G6P6YxTTSxMesR8x+qBw0lOGWUNl/S0CGmX3hOP8fgD
         GIBpvg3+lwI3azaB9B/vAujVfWi0CAHeBSvg43Y/CurUjEo60fZzEvRwNB75NssDPWlm
         rRL9vDrYuMGP8kh1subgTtlYT9FfkTZUdrWRmKTx23LlZjcJPpgOTLUQuZpCfd1bLBvz
         Q0IoCIlHi9LdBhR1hVqxdq25YegSZ4eR7TOtnrCaEzFev10QGEkGGQXELZ+Dm1d1Q7l8
         kDBmUmt36kr531e2qwBIaPSc7KvZe1pPtXYMXI2Wi04vn2zg+jO6JCC9MLwLf48boSbV
         wJzQ==
X-Gm-Message-State: AA+aEWZtCE7H6ACKz2Q21gsQUS1GCxvezyHGfmV2Oc+RJDjmpU4bwKUO
        a883XYPDlZemJpkHtBnBzstl5XtsrxRskMfczqU=
X-Google-Smtp-Source: AFSGD/XUyF3HxcHdb/0AOzE0E/BgNWSBqJHw7iGkDFASWxF50bPcCw2N/mStGuROZo0OBWAXAq/ka2ZjQAwqwdVa4lI=
X-Received: by 2002:a1f:eecf:: with SMTP id m198mr13521763vkh.49.1543344377798;
 Tue, 27 Nov 2018 10:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20181115231605.24352-1-mr.nuke.me@gmail.com> <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org> <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org> <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org> <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org> <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org> <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org> <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org> <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
 <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org> <336e233b1ad642dcac9638d5fb275810@ausx13mps321.AMER.DELL.COM>
 <c385770a-9eec-b040-7861-0a3d455148b9@kernel.org>
In-Reply-To: <c385770a-9eec-b040-7861-0a3d455148b9@kernel.org>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Tue, 27 Nov 2018 13:46:05 -0500
Message-ID: <CABo9ajDNECh8WNACUwTBLPF_UDvMq5XGqYF3ZT8ehnO0F3n=5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
To:     okaya@kernel.org
Cc:     Alex_Gagniuc@dellteam.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        keith.busch@intel.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        lukas@wunner.de, Bjorn Helgaas <bhelgaas@google.com>,
        rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, ruscur@russell.cc,
        sbobroff@linux.ibm.com, Oliver <oohall@gmail.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 1:32 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 11/27/2018 1:22 PM, Alex_Gagniuc@Dellteam.com wrote:
> > On 11/20/2018 04:08 PM, Sinan Kaya wrote:
> >> I followed the ASWG thread yesterday. There will be a meeting next week to
> >> discuss this.
> >
> > Any updates on the meeting?
> >
> >
>
> Tyler should be able to get an update.

As per Harb, the meetings are on Thursdays so it will be discussed this
Thursday since last week was a holiday.

Thanks,
Tyler
