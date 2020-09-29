Return-Path: <SRS0=Yaiz=DG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D7AC2D0A8
	for <linux-pci@archiver.kernel.org>; Tue, 29 Sep 2020 02:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FEB21531
	for <linux-pci@archiver.kernel.org>; Tue, 29 Sep 2020 02:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRMH+Mok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgI2Ccu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Sep 2020 22:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgI2Cct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 22:32:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B761C061755;
        Mon, 28 Sep 2020 19:32:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so12670201ejm.7;
        Mon, 28 Sep 2020 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nFlIsB4GESJdOkUx69zEcDDOqVB4l0gvS9twPgreSA=;
        b=vRMH+MokrPwXWhbeU7cKcfPB4Sqpm2NglnjYJwpD4svuEO7ylGHVrassEcFDxjKRwc
         HNYSNESEnWrd3zlmho1CBQkIpGc0farrNkTcxq5s3WkTakz7UJ/1p+Fbzb1odgV1hGZR
         nSW7bPbI2WisIHdYzr9gLGPu6rc4UVd2jjf3YSSpkjZ01WW1Ngzrhq8OH2RaN64Y1dPz
         a0roil8uH9PniZf6KkJ8qLyUfgVyl9EgAaybHWUBPw61uTcceZlYRl+vJT5tR/PKn77d
         U2i8b9vTmyodvcm4wavl3OYFXC57t/fjjtV1HXFTSn2bhwq87sh8cvp9eCqplNNd74WD
         cTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nFlIsB4GESJdOkUx69zEcDDOqVB4l0gvS9twPgreSA=;
        b=bm5q+s1lQrRIFqmmA/1fP3omY0K9WwOJku5C7vp4hvb9czJeCXnxk/yc83+Q8mL85d
         zIvHSlIqOlNiFO1MUEt6dMcHcD8ZeQiNTZN8r8VuSBDCeBOqgw3uKVyRH1/vyXsepQq9
         6HZ1UIMtQxnnbCVuAh+tpulrkRDbT/0GiBIgHTUY3jySB1MSm5Lgexs6PD/mrxK4SpIm
         7YoldRueN8TmIwhYN3qQO3+95Ukn70j0L85Ne0y9342dItNpw8OEcEvlY+qgrDgz4N7l
         VyVgM8E3TPxl+CdBHu0OJ+onTqYhQ/OGywkvgtsn3WVXeSudGKj3hePqOuDV3CzHGJ+A
         Wtog==
X-Gm-Message-State: AOAM532LdDceZUuGQxxQd9/LN6/npiVHlq2yk2qxWio0oPFzIHUDCkCU
        OyDcdQvT075WLC5Nc8PvvF4AsCTZTFcZv546sNI=
X-Google-Smtp-Source: ABdhPJwRfTy7g6qwbOFcPc7j5O0NPP9zelvfniUFw8ShhQbdGq4igwNqE+eAwXqAveu2scwhXZqtMpxKAi8hJTm4B08=
X-Received: by 2002:a17:906:5008:: with SMTP id s8mr1772423ejj.408.1601346765902;
 Mon, 28 Sep 2020 19:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-2-haifeng.zhao@intel.com> <20200927062359.GA23452@infradead.org>
In-Reply-To: <20200927062359.GA23452@infradead.org>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 10:32:34 +0800
Message-ID: <CAKF3qh3gVoSfCg+83Kgrq4Pu4f6pSd2TUo+5XwTRZW4qTrkN2A@mail.gmail.com>
Subject: Re: [PATCH 1/5 V2] PCI: define a function to check and wait till port
 finish DPC handling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixed this concern by moving the function to DPC driver and its
declaration to pci.h.  see v5

Thanks,
Ethan

On Sun, Sep 27, 2020 at 2:27 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#ifdef CONFIG_PCIE_DPC
> > +static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
> > +{
> > +     u16 cap = pdev->dpc_cap, status;
> > +     u16 loop = 0;
> > +
> > +     if (!cap) {
> > +             pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");
> > +             return false;
> > +     }
> > +     pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> > +     pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
> > +     while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
> > +             msleep(10);
> > +             loop++;
> > +             pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> > +     }
> > +     if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> > +             pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
> > +             return true;
> > +     }
> > +     pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
> > +     return false;
> > +}
>
> I don't think that there is any good reason to have this as an
> inline function.
