Return-Path: <SRS0=jK/a=RF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FFBC43381
	for <linux-pci@archiver.kernel.org>; Sat,  2 Mar 2019 00:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B6820823
	for <linux-pci@archiver.kernel.org>; Sat,  2 Mar 2019 00:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4oW+3gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCBAL0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:11:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46424 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCBAL0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 19:11:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so27602598wrs.13
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2019 16:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf2Qd0yvBbTqTKQt7/iLAZWttPAmpnMIz9ngCRDkoq4=;
        b=d4oW+3gudsCiWfZmbRXbm4Z5boALNT2PhvAh9vt1i77yTtHtI5yWA3olQrntRi0R0B
         iYlPwF3LhfCNIm4OGrqu8U2iWNaEV8VPmOPaeZnu45oCUJfpyu6+S+2wkC7yzR7zQbKN
         jMWA1ZmB1CO8V3C7NB9nk8c9e6wi++HprTL7vs5FEPQ9KP5m36LaH4GhySu+TfMOLPNk
         btlhbPTt9NlrwXmd0soaUT8Ivhms+36qoLsi3AUGFzen4HHGLQK+vEKKDk5JAnYU+9JO
         lw0CwvhEs0Swg4Hg/+TANplJv9NXEidCvmCfp0KiovOTvHM7otWB/R6fF/18Cb49o78D
         EdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf2Qd0yvBbTqTKQt7/iLAZWttPAmpnMIz9ngCRDkoq4=;
        b=Nqn0dFsvybAmlWrIlfmjcC572if8m5XP5v8MFPCRzbGgyABen/xR0Xe5BSg3bgb9DI
         SNbi976yxQS53RChNnKV/RHVGgoQyR0GsqzZhD8OA8bz/WplVxBN86aKwSQDEPgHxO52
         a+0rAxJ+x64xOeWoQfDhFUWOsO0da27UTvAyYD5qjA0uZjCTbJ4XGjCvk8KuYYSH/88P
         LYxEXbgqyz54MpO3ILTYDOLnSK9o+QHK5hewv3NHp/0PkJjDSy0DXa4kg8LAiQ4sWoGs
         yWXmm1Xukzjwdw31F+eXf9s3ugLSvDGPDa5YmFLS00u8dM+kSTn5f2mOVlAuZ1z12f5J
         sN6A==
X-Gm-Message-State: APjAAAXPG8Ebm2R8bURL5prO9yvx08EbOcmfqTxSN2PNrgoG2FTwUUyA
        uI7xAalFM6xDsVGBwh0o3MMQDaEaJZuiasQxX4S3
X-Google-Smtp-Source: APXvYqx3KyLPxlyYFqtD4jajNGJGSwNsisDPl3MHnp5DUqLNP6BClv7RxLrkXIFLcPwxOkPRpazG2h+2acyzYAGDe0M=
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr4769718wrs.98.1551485484042;
 Fri, 01 Mar 2019 16:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20190301165419.16493-1-TheSven73@gmail.com>
In-Reply-To: <20190301165419.16493-1-TheSven73@gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 1 Mar 2019 18:11:12 -0600
Message-ID: <CAErSpo74LHWaHtjPGthyNvAgrq7wb0G0dbh9krzMQH0cK-DE9g@mail.gmail.com>
Subject: Re: [PATCH v2] PCIE/PME: fix possible use-after-free on remove
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 1, 2019 at 10:54 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> In remove(), ensure that the pme work cannot run after kfree()
> is called. Otherwise, this could result in a use-after-free.
>
> This issue was detected with the help of Coccinelle.
>
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Frederick Lawler <fred@fredlawl.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Applied to pci/pm for v5.1, thanks!

> ---
>  drivers/pci/pcie/pme.c | 1 +
>  1 file changed, 1 insertion(+)
>
> v2:
>         rebased against Bjorn Helgaas's pcm/pm branch at
>         git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index efa5b552914b..54d593d10396 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -437,6 +437,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
>
>         pcie_pme_disable_interrupt(srv->port, data);
>         free_irq(srv->irq, srv);
> +       cancel_work_sync(&data->work);
>         kfree(data);
>  }
>
> --
> 2.17.1
>
