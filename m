Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C40C6786F
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15112080A
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 18:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKmr9rtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15112080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJaCza (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:55:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38347 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeJaCza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2018 22:55:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so6716566wmh.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2018 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFx7yTv8wcEqbFYdEhwuimt08oxmcDITcH1OpuE7ah4=;
        b=XKmr9rtGBiM0Xk7sW3OjNvnVGRi1Xwxirlxnro1jJDEKsJRSzYHsY6O3c+UhrexH6x
         zDedscZ6yTF4rK0Bl4lGPF8xh5r8YqAWMCKyxBNqHUDR45fBZTd66aYPfiJ8R+1NQSDe
         YF693oVNEGsl+FmPwGJFZDsRs18w/pz9rud9bCXjRiqR56+rs/YZFoltck+La902L37w
         hQveOFKtdSkQ3jH6XsOAimu/3F6zDYTnlGhaGg/KtRu8xM/mw8Wt1/h5XUn4tVl74je0
         cWudZ/Xl11XL04+LpQimgYBJ1ltgCsoWW4zNavysQR3J/LW7chpf+d2QDTe/USFUILMD
         QDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFx7yTv8wcEqbFYdEhwuimt08oxmcDITcH1OpuE7ah4=;
        b=I8XUOU19DaLvVqTxZSHsmbjkJdSd2pJa0zJfLtdNCwBN1+U1nVfdGTJicn/4zAWk9R
         AYgRFxp8ogn/+DZDe07ZuOB+X9NU7LPZGBjEGTbbYZ4jgBvHP3PX394CGmGsMe0womyJ
         qNK6Xh6Zry48hRax2paGkPf5nQpVp8R4Ym0r5cKEmNbK2tfMbjrJxdPkoxqxFtPyONfv
         aZuyVniV2jHY14bUvnZGwkODF5UFhEL676CjZ21HkTqbW4fgM+jpQ7V3U9fXKA45owWK
         lwNJ7KwOLUSxtfO+xnyHWLznG9DhGCYYINeGq1TokfDkayyj/TWocfywVbp/Lh6yax4t
         OpTA==
X-Gm-Message-State: AGRZ1gKdMc0DR/6Z0guSqE2wDbLJZf2u0EMCWc3hs83GEXzjpEm/I6gp
        60Ht+jBXE3nMQPDmpkMgb0Y3gZRZMjPW6fSsgQk=
X-Google-Smtp-Source: AJdET5cqVb7WiDtxv9l/2DwrslALYpWJUTltWe/srPtGc5DDivyfonrfdZgOwO0AVKvf85Xtp0wY9s6gDj0sqJ4f4Uc=
X-Received: by 2002:a1c:607:: with SMTP id 7-v6mr2572902wmg.103.1540922459299;
 Tue, 30 Oct 2018 11:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 30 Oct 2018 14:00:45 -0400
Message-ID: <CADnq5_O5j89M=1p5-NYtRv+Sj2dpDTeAU69Mo_Qk92BQy2oJ=Q@mail.gmail.com>
Subject: Re: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
To:     mpatocka@redhat.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, talgi@mellanox.com,
        tariqt@mellanox.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 30, 2018 at 12:36 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> the register and compare it against them.
>
> This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> the slot is being incorrectly reported as PCIe-v3 capable.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> Cc: stable@vger.kernel.org      # v4.17+

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> ---
>  drivers/pci/pci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux-4.19/drivers/pci/pci.c
> ===================================================================
> --- linux-4.19.orig/drivers/pci/pci.c   2018-10-30 16:58:58.000000000 +0100
> +++ linux-4.19/drivers/pci/pci.c        2018-10-30 16:58:58.000000000 +0100
> @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
>
>         pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>         if (lnkcap) {
> -               if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> +               if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
>                         return PCIE_SPEED_16_0GT;
> -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
>                         return PCIE_SPEED_8_0GT;
> -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
>                         return PCIE_SPEED_5_0GT;
> -               else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> +               else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
>                         return PCIE_SPEED_2_5GT;
>         }
>
