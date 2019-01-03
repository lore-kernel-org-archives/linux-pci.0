Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD29C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EED4217F5
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 17:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDcqMCQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfACRfW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:35:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37445 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbfACRfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2019 12:35:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so37690754qtt.4;
        Thu, 03 Jan 2019 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m0Kdi7xBjgPQg1KD4ifF0vqMDBe5DwAExOchMlsKCrU=;
        b=SDcqMCQRNX1PTTYu4g+6kWJInLw3cZ6KGstUtioosQ8sIZ0LT5i1uina6WB3asRReK
         F9+izMdXdlL4ppxbYfoaoMdZ2KQqhGV8wh4NuyNkgwt3RqgF1ZwsUsD1EWrLAqo+ScbB
         kk0dDX0CVHZQV5/Ghryuw89vKWSnJyvsasBYXHyapc6fqvB1UEn2ETFHT2gwplOoOswF
         1P5dwtOiDv1nR8YV5/BNEL4yCIUKvGnx1KiIYqHNCpDM1l4DQEjjTSoMs84mQPcACOAe
         L7RV0Ui3qSigDY++Zs4tEIKhlM7cx4V4bvO2WeyFTgVcnxDIp/xGUdTEpDhN0uw6rLtk
         UJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m0Kdi7xBjgPQg1KD4ifF0vqMDBe5DwAExOchMlsKCrU=;
        b=MT6NzIYkw+t6I5j6VvZ52jWLcBgDKsiAeIpvUx8fJN4l7rqgUCbxszz+17S53Zekr5
         S0vAfmnAmbR5/5vgHTKb2MKpXOf22ylR7YInaDaaldrihdcXatV1Wg0a2w0O2Odxzyct
         7rjcAC1GnjRXSemJ15b19/TB5btihCGN6GEL3bcbzPgRDzSwZ5DuO/cEIl9iC0llkbjq
         0iwtMAJOj4Lnf+YbQx+xdUmTDJq1PN72e9LGVvE1p5aPkX6SJYyBHFDgQg5iQbRRZkHy
         oINxnzuwrQJeSxtYMElLUy05WjOIDk4UgxWk0DlIqPdF9L6l1UI8aM/dW0/PoK4VUC5U
         KywQ==
X-Gm-Message-State: AJcUukeXOWmoXq6uwUBf1zDabgQIeFkiP851DRKlcyQEK+94w31DtUra
        H2NmFlRS8KQ+r7phS/6uUzgXUsf+lbaV6lytGSo=
X-Google-Smtp-Source: AFSGD/XnJxO4NlcralXln8fOwuDG3rBEcH+iCSOoRmt35AbwvTII1lcqTDMKnV5oji7UfDuBkhvI32phyph+FXu+ub8=
X-Received: by 2002:ac8:164a:: with SMTP id x10mr47624276qtk.67.1546536920554;
 Thu, 03 Jan 2019 09:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20181207190720.18517-1-hch@lst.de> <20181207190720.18517-3-hch@lst.de>
 <CA+8MBb+9prWYSmp25K-LMUv1_0eekvFqXhoj87CV9zcaXfMDGg@mail.gmail.com> <20190103072356.GA24163@lst.de>
In-Reply-To: <20190103072356.GA24163@lst.de>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Thu, 3 Jan 2019 09:35:08 -0800
Message-ID: <CA+8MBbKXTRGLn1Wvpp1avQCZ186i5Cbo0puvSoNNuKO7_AcwZg@mail.gmail.com>
Subject: Re: [PATCH 02/15] swiotlb: remove dma_mark_clean
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        X86-ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 2, 2019 at 11:23 PM Christoph Hellwig <hch@lst.de> wrote:
> I think something like the patch below should fix it:
>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index ccd56f5df8cd..8d7396bd1790 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -31,7 +31,7 @@ config IA64
>         select HAVE_MEMBLOCK_NODE_MAP
>         select HAVE_VIRT_CPU_ACCOUNTING
>         select ARCH_HAS_DMA_COHERENT_TO_PFN if SWIOTLB
> -       select ARCH_HAS_SYNC_DMA_FOR_CPU
> +       select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB

Close. But no cigar. Now I get:

  CC      arch/ia64/mm/init.o
arch/ia64/mm/init.c:75:6: error: redefinition of =E2=80=98arch_sync_dma_for=
_cpu=E2=80=99
./include/linux/dma-noncoherent.h:61:20: note: previous definition of
=E2=80=98arch_sync_dma_for_cpu=E2=80=99 was here
make[1]: *** [arch/ia64/mm/init.o] Error 1
make: *** [arch/ia64/mm/init.o] Error 2


-Tony
