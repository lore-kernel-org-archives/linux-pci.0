Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD1CC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B222084C
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5NKlV/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfA2T4y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:56:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53537 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2T4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 14:56:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so19212530wmb.3;
        Tue, 29 Jan 2019 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DbE1GrRmgpsPkMb62kQRgfWSg0dLU9+SDcD6byWUaX4=;
        b=m5NKlV/dlJdtECUzkiGCYY9gRyekiXv+dVEOYxQq18wuAaE3Om/1m+T04tVbdZQwod
         fyQxO6w+Fvpcp1gDkG/ee+h/mMu9zmZU8uEpucCEKMBVZWkRd+QYu28jAUmL94H9xpVd
         zFuL9ORWYfV9HxA81s3uQigQw1RkT3960FlX30SQOtSJPesSr8de9IJHqeWTYWUFhQwi
         Eo6liZ4HFhKSDXZOkGF2n1nF/IuoU+czgnAUWbkvgDZ0KYVumZDidPEpBl5KViJQ+dM+
         X2jDfIF4A1h6ZQQF2z0oLs/KQ33CoIJqDHDxopqg5CCtmRNacwtQYK4fUyuyd930nyVQ
         S5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DbE1GrRmgpsPkMb62kQRgfWSg0dLU9+SDcD6byWUaX4=;
        b=labQHZu9jQkAKFipP6JUgkit/ukDq/qC3yqUKhBVRE5rHD1UE9eAuJdFHmXO5uVqg5
         uRTLsp9sGdCSNKDQEQuebMkOfVAUGI1jZjJJuXEE9mktdnTuOYjSjpUAkRlBfoPS8N/D
         9z7O1MZL2TPV/7Ob4XtYvWIaezkhWXwVCyAz8eM9XPidp9MVcdI0/UHRf18Oem/6HsJ7
         T5i7PI230Xv1NqjMEAORypNgmdGKvoRXOkRbIihuM+FBaGSDtOMf06MKiiriB/jQAZ/E
         HJeEjo7rt5YhZAYiAtYpfQ+1/D6o+/dUDx5klJlYq7Sakixj8emZcDAPKVgNQN5DKoCm
         SI7Q==
X-Gm-Message-State: AJcUukfWnzDPE5oZYUtY1hRWEGPxPuqPjk5wQ4XJ0g1av4LwXTiE+pVG
        8f0xFLGSURiC8eT/WkGgOrDd030/rlWIBsfY5fI=
X-Google-Smtp-Source: ALg8bN5FtxNkNjW599qrUzEnetIRTAX187hhjUN5bTMbybWCmuHZS8mhBUhWb+uBJPDX1krcjBMM/76FizLN9vWBbTg=
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr22060809wml.121.1548791811117;
 Tue, 29 Jan 2019 11:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129174728.6430-1-jglisse@redhat.com> <20190129174728.6430-2-jglisse@redhat.com>
In-Reply-To: <20190129174728.6430-2-jglisse@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jan 2019 14:56:38 -0500
Message-ID: <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer capability
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, Joerg Roedel <jroedel@suse.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 12:47 PM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> device_test_p2p() return true if two devices can peer to peer to
> each other. We add a generic function as different inter-connect
> can support peer to peer and we want to genericaly test this no
> matter what the inter-connect might be. However this version only
> support PCIE for now.
>

What about something like these patches:
https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=3Dp2p&id=3D4fab9f=
f69cb968183f717551441b475fabce6c1c
https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=3Dp2p&id=3Df90b12=
d41c277335d08c9dab62433f27c0fadbe5
They are a bit more thorough.

Alex

> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/pci/p2pdma.c       | 27 +++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h |  6 ++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c52298d76e64..620ac60babb5 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -797,3 +797,30 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pc=
i_dev *p2p_dev,
>         return sprintf(page, "%s\n", pci_name(p2p_dev));
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
> +
> +bool pci_test_p2p(struct device *devA, struct device *devB)
> +{
> +       struct pci_dev *pciA, *pciB;
> +       bool ret;
> +       int tmp;
> +
> +       /*
> +        * For now we only support PCIE peer to peer but other inter-conn=
ect
> +        * can be added.
> +        */
> +       pciA =3D find_parent_pci_dev(devA);
> +       pciB =3D find_parent_pci_dev(devB);
> +       if (pciA =3D=3D NULL || pciB =3D=3D NULL) {
> +               ret =3D false;
> +               goto out;
> +       }
> +
> +       tmp =3D upstream_bridge_distance(pciA, pciB, NULL);
> +       ret =3D tmp < 0 ? false : true;
> +
> +out:
> +       pci_dev_put(pciB);
> +       pci_dev_put(pciA);
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_test_p2p);
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index bca9bc3e5be7..7671cc499a08 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -36,6 +36,7 @@ int pci_p2pdma_enable_store(const char *page, struct pc=
i_dev **p2p_dev,
>                             bool *use_p2pdma);
>  ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
>                                bool use_p2pdma);
> +bool pci_test_p2p(struct device *devA, struct device *devB);
>  #else /* CONFIG_PCI_P2PDMA */
>  static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
>                 size_t size, u64 offset)
> @@ -97,6 +98,11 @@ static inline ssize_t pci_p2pdma_enable_show(char *pag=
e,
>  {
>         return sprintf(page, "none\n");
>  }
> +
> +static inline bool pci_test_p2p(struct device *devA, struct device *devB=
)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_PCI_P2PDMA */
>
>
> --
> 2.17.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
