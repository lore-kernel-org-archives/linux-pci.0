Return-Path: <SRS0=kfIp=BG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D464BC433E4
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAAC20792
	for <linux-pci@archiver.kernel.org>; Mon, 27 Jul 2020 21:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXKRCCzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgG0VRs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0VRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 17:17:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC8C061794
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 14:17:47 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id a19so2185792qvy.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pKArutiGe7jj4mj6RmCQjYpYxaXVDrpcmCYcwBdJLbQ=;
        b=kXKRCCzDYN2ooH/QE7ZbQcaIP8GjAoT1lbf6QD8ORLiPFgFQ2CWBwpzDB8s61IgHga
         5FruRgXDSqUD5iVPqFss2zJqCydnon9WoOK0E2T0DFbDZjQFN1MNUe3UpJS8x6aJce5Q
         n4MlJaatzI4B0EsOPdjhczqR6uBo7KbZbZ6xO2qa4m5yQss4eEjEwEXjDlL/uI7l82m6
         jgNuN1J9a9UhHO2wk68E09kIZZhCDmzCs/WgY0wpVykd9CFdUTa1gwLSUbI/9xYefOfM
         7Wx4QwxJcLEOMmxD7Ss3/2oxEZThPd6mueSlZUbqkWgKc8yCOTMUcIN0M5LW/neAY34s
         tJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pKArutiGe7jj4mj6RmCQjYpYxaXVDrpcmCYcwBdJLbQ=;
        b=d315UAZ6Ux+pXlE9Z83JQGd3jjpCYPWQfHL7cbI2tIWCPPDS5NUVpnF1zdtuIEhvN8
         3E0s3RVRrKsc09KgCuEWeR80m2ccvL0eE7S+N7HDBtFdU1gSQIdbmLFXf3VUKFEOpbhn
         /PfAR8AXNf6UjXkS5o5LRno+1RxgHzUFXVCIhVZcpyr8mZYKXmRQ8aPGbUi14oym45nC
         Bw2cQVxuZcjbDDf88o4HWDblW/+jLYNzPwRIPg2JSeyWSZZs2MmdM8k19c0E+i77gVlj
         Nt7V9Sza6U/AwW18dwAOdhZeXElb9NrQo63DbPf1Rm82DucPHExU/NpKVnQCDQkOcKg/
         4V+g==
X-Gm-Message-State: AOAM533Xmjgf6Xug8nq8ly7EaENUs9MgXSEoBpk24ozfL+sP9NFFca06
        K5fGDjDeBABH3XClNDqMctWCbSYInLRrgRHX5rxQS9R6
X-Google-Smtp-Source: ABdhPJxmAXUFGeRNjGSy/yhZNOWmqLbetWTkoPc8BBZlr663M2RTHZ5cGB8w8LBEjJioVHjkpELhe/ajX+SUbvKSgvE=
X-Received: by 2002:a0c:b665:: with SMTP id q37mr21220293qvf.75.1595884666710;
 Mon, 27 Jul 2020 14:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220653.635852-1-ian.kumlien@gmail.com> <20200726220653.635852-2-ian.kumlien@gmail.com>
In-Reply-To: <20200726220653.635852-2-ian.kumlien@gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 27 Jul 2020 23:17:35 +0200
Message-ID: <CAA85sZv8y9WLwtqimkVw9dFWubYiV0=HmZQ49cKCTJYm8f+k2Q@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, the changelog is broken -- Will resend...

That'll teach me for thinking after working out... =)

On Mon, Jul 27, 2020 at 12:07 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> The current solution verifies per "hop" but doesn't
> check the maximum latency, instead it checks the
> current "hops" max latency for upstream and downstrea,
>
> This would work if all "hops" have the same latency, but:
>
> root -> a -> b -> c -> endpoint
>
> If c or b has the higest latency, it might not register
>
> Fix this by maintaining a maximum value for comparison
>
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..bd53fba7f382 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency = 0;
> +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
>
> @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>                  * substate latencies (and hence do not do any check).
>                  */
>                 latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +               l1_max_latency = max_t(u32, latency, l1_max_latency);
>                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> +                   (l1_max_latency + l1_switch_latency > acceptable->l1))
>                         link->aspm_capable &= ~ASPM_STATE_L1;
>                 l1_switch_latency += 1000;
>
> --
> 2.27.0
>
