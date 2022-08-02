Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF8CC19F2B
	for <linux-pci@archiver.kernel.org>; Tue,  2 Aug 2022 10:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiHBKRA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Aug 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiHBKQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 06:16:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333827146;
        Tue,  2 Aug 2022 03:16:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso18002006pjr.2;
        Tue, 02 Aug 2022 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=K3gMwnYc05dS2NdrTHN5+Ze6CUziePYd96zwweq+t0Q=;
        b=pjOQTq67jmL+zqlHUy+gwtkhHXJxXaYy6SWRs8Jxf1TcU2sZkUchzPyaBty0YWPeN1
         MrGK2QdyYSR9/b3zpNTMxPXDMQJFENkU3q7BD7TIyOGvTG7uH3cleCzCLWUE8szLKG8J
         vYcM89FvbfxU6ye+O79xDTI/4f1czm3x9KKuc8Fmc3Pwgu3i85uBJspqcO26Shhb66NX
         7xL557CHC3OT6KfCvR5lTOF1S883GGfMS50B5f/QsxMzVWfgrO+JmB8fe1tQTyVgP1aX
         zRzL9yyg+udr8w3XGP9gxVCWnqZiwgeMssdrp3/PIObahVVBiP5yYOnuIYNQqDZ+TfEf
         EHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=K3gMwnYc05dS2NdrTHN5+Ze6CUziePYd96zwweq+t0Q=;
        b=kekjNcMthtMM7oNeVZaCsuHf6S2r5oki/GaduaV339Nefo25YYz64f14pTAnlkrJuZ
         JsuyGXtK2xq9zjjsvBNiaqmDAwvsRcgzmZ+iAK8u6nE/ANnQsrcb2ShZWFbyYau9U5zB
         o2Pv08RVaLp3iHyQJEu4Fmf7162T6o+6LtIb9g/StVva27+uIDZ+aFrmr9pCOZkLRaV8
         ZbRPXOTyToDL3w0PIL3Bl+lz1wOMq0CIeiJ38hyfmzd+Gdbbc4Ts9XLx1TNljY8xPLmt
         3SPeCmfUKXQq6H3KK/nsjv6aSGm+e/uw9hP2q/8FtWCRYK5BW3cd1gaF6BmriqyxeNFF
         xpEQ==
X-Gm-Message-State: ACgBeo394tUFK27ACdMlLdYI3i3kzTVyCdoMBnKD2JSpmHBr134EkUbg
        ItCRqwiRERlKK3VCjtOqEsHDzbQeOhW7RZDgzjA=
X-Google-Smtp-Source: AA6agR4x5kL7ZKGd39BRS6Q+B0grXI4PMc7cslyieT6sDmoc7/sL0KfzJM8M9AW+kno9K0BscMror7MSWwfHs+uGBRA=
X-Received: by 2002:a17:90b:4b07:b0:1f5:37d3:fb40 with SMTP id
 lx7-20020a17090b4b0700b001f537d3fb40mr125958pjb.12.1659435417606; Tue, 02 Aug
 2022 03:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <YuenvTPwQj022P13@kili>
In-Reply-To: <YuenvTPwQj022P13@kili>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 2 Aug 2022 15:46:45 +0530
Message-ID: <CAFqt6zZPduwKr23kFzam12nEiYaVyNe2s=789V_SscDMG2WAPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] NTB: EPF: Fix error code in epf_ntb_bind()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 1, 2022 at 3:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Return an error code if pci_register_driver() fails.  Don't return
> success.
>
> Fixes: da51fd247424 ("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 111568089d45..cf338f3cf348 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1312,7 +1312,8 @@ static int epf_ntb_bind(struct pci_epf *epf)
>
>         epf_set_drvdata(epf, ntb);
>
> -       if (pci_register_driver(&vntb_pci_driver)) {
> +       ret = pci_register_driver(&vntb_pci_driver);
> +       if (ret) {
>                 dev_err(dev, "failure register vntb pci driver\n");
>                 goto err_bar_alloc;
>         }
> --
> 2.35.1
>
