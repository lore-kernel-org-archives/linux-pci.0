Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980953242BC
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023776; cv=pass; b=biLngkEvaKUv8MJjVfW0DQCUD1EtX3XYDKhoI50cO1hwVsuabRKClCKX/SQugRIDu8M1AZYyuhpx+D+i/9dctbfefRfihvROZnehtDgavDFVrHeLDbPQEozyqvYqz1ptDYpWH4Lkbu58EK2sPmPHg5zw5ase7d9EG9gITvKEX9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023776; c=relaxed/simple;
	bh=brs/IW8jvQhz2euoahw2Ycm486qIh48n1gK215W4gaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsGCNgCOs8aT+xkLQiPXzk8HkVQkByG7RKJ0q2NDskxWP/3ED+LEO/6sGeJqsXaLxq08NVZW/X+pT4xxe7kZtEcy5vkHXNjkejoxfvfV1mY2cIJEADW2P7FOCh5N+FaiSEVCkxaCCVX/+x6RlMIO59kUy3jS5YZlxuybAdgqyjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kkn1rlP/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+FgbfRY; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkn1rlP/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+FgbfRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769023771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+QAAZ0MJIFCYGS3HSwE6MQbpAi4/wGiI4tY4FFvMOs=;
	b=Kkn1rlP/9an71/kwxYt2sMN5dZMqoJG9bQph0UKdKYABvEdWjMP4AgU7jL3BAXOzTYPOWr
	ivgge4iyN/Xs4Wq7/CEWIkkRK/cXU6xY5ncE/7tAIfK56wB3KY36dXInnKbUw4zz5NxtU6
	zBbu6t/8MKXYZ+0C5V2XSnpJSd6xhZw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-hFAJQ4VyPNu1A1ZScgAw3g-1; Wed, 21 Jan 2026 14:29:30 -0500
X-MC-Unique: hFAJQ4VyPNu1A1ZScgAw3g-1
X-Mimecast-MFC-AGG-ID: hFAJQ4VyPNu1A1ZScgAw3g_1769023769
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-947fea2fb14so91394241.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 11:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769023769; cv=none;
        d=google.com; s=arc-20240605;
        b=O5RxCYj/npkeihMMMUpkLdJj+t2PcsQPM8owFDjgVV/Wqyi1W500qJwMh9Bff8GSjR
         5b+lIznr8w+yNay0DCuRpDzilpmRQ2tZxK8DWi1muZ1QW3k9i0u1tCiZFdlXVbApDVte
         FhaY7iRU9qCb0Y19cwry3oLB4LUoeZnOdLyLWztFIewSIxXuCCQ1svMx7PBSqH3BP42J
         UbPkggLPDhZ355RBhNSzmJ7NMaoOXXqBkPpmdm5nVAx+Shjab0xKQYqWaln1OCbPvRyQ
         g7eKhI0iagc2Gh5EZyD4TjL3A8M96rqACu8uUekhgsBLSemc2JX6nOq2JvjLwOeUygqK
         UamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+QAAZ0MJIFCYGS3HSwE6MQbpAi4/wGiI4tY4FFvMOs=;
        fh=uddDN3v+vyYU/A21a6SWvYukSqyHwlaFl0oeC0ck098=;
        b=ItrfUTBBaeM+tDyFN9u8foZsIITE/WMhsy6XNOhu3TuTkbn5NuqnKyTN+7d1BdihfM
         9aUjevW/N6YKW0b2157Nqm+Io2pGe46ClgLSXfa2gOQRmXiHyRc2amlwW7z3ed3o5fuA
         2eTvek0iBcCV+BXrmvDeiwLhzeAsxINkMlUZqQFaB7PUs4p67m3ws/1rnaPAvym3tQi6
         LTonrJodOuVy0CvGWMocrb7Siwdjxhl8hK8g7HSV2F/JkZAhqLw5gEWVPCfnFilFVqtK
         zLVe7oVirv2y3midwxdhWJZf72co8qShaER2PSLQMQ8drFZ+FYAckWTCydHfCFFVdc+o
         NwMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769023769; x=1769628569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+QAAZ0MJIFCYGS3HSwE6MQbpAi4/wGiI4tY4FFvMOs=;
        b=i+FgbfRYUM3rK+E+qBjLsIwICIG6SiHZ870Tfpt41xGzCF3HazmNQfBWJuMYuAiQAo
         iptoCCFBqDU+Kcvdhau8NZksn4IqCZXrGHYe8XAPK6hVkf8i+kIKSoHxMhKXuBYxeJOO
         POH+ibjvs4AOudnaX21Q66jpZQ7SAwx3cCDye4mQZaGhAROaA85787JlbZNuvdgoLnri
         nSUio03Et3Rs4zjwwD/qgI0h9ERNNHGAuUvEhFf7r+nDLRj1kXlZgfB/95r6QZgfKfmm
         zz/pWmSLOq8dXTKpvr0i6mD+tAMLwBolXB2xJsBHcLEh66OuzsbyoVNdOJCmk/10rp+h
         Ihdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769023769; x=1769628569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+QAAZ0MJIFCYGS3HSwE6MQbpAi4/wGiI4tY4FFvMOs=;
        b=EI9Ou9wDzBDxSxRfgnrhCQLSE/7ebZO2TCdf3sA8UBYIOWT1gpEGP37dl3GGWy6h5k
         m8wOpCjYMdG5m/ExIKhYNfoy9Eh2hK4zUHN/kLoDduxwx1XWHowCKBXuHcX146+a2g9l
         ZddEYHI1YroWS6YibImS92FaInnnj8QP5XnziByPAuTcjZoukM3Z47K3oOPFXQs9Ew75
         ljcfsKoGy9NkLK/JdMlpgrqo7ZEIc1fA8rWU+p7+pFBJhDKIjti9RY+7DJ0aLsqE0lwv
         24+BPqWFugnAx/h8qg3blMsFKv5xrsOrG2ApgwhGMTn1kcRQgklt7xMRgQz5VmorW6nI
         O83w==
X-Forwarded-Encrypted: i=1; AJvYcCVOaPKLIk+gez/BhnLE+XPQf5Ad0embU3V7Da0AarDlLQu8c7aLqZTRyXSGPdVF2kLc2qiniz52Y7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0W/Scwisbj5X082RTiKybXmh/Too1PZyehpkFQTpw5urY+wXs
	6JcZfJhyGZ0Ufs1XiM7Aa4OkdNIUdorkE1PW70GuAVJ5ODUl+qLysnl38+daQ0F7hiW6zVDkEDz
	iJE1Pockmo7a/xI/NzGHWOz/Q3AxpFzKArmF9g+IVb2JyvPvEcoh+BKI7fRPbmRFHZeTPnvtwgr
	8Kid3X2N2D7AnRoIWmqSwvsqbIHkGYhb8RT5s6
X-Gm-Gg: AZuq6aJmZp/qkYW7xjbISBctuyGel765dhQuTnfALFIHBa+6eRiujL+mREwNWBoDCiC
	HBR5K1uPxQqLe/EzHMBASLV9liaSQzxJDyCpEHVG/fHFV1oRLYC42dz7CiWeh56SXGNVcs7lrZX
	XbMWq6neYei7JF9tppCHTSt0RWYH7qVlaXVs596RmMuUfRD2iZcTxQuT4Gr285RhMJPsDtsoz8q
	d4=
X-Received: by 2002:a05:6122:1da4:b0:563:71e1:c884 with SMTP id 71dfb90a1353d-563b72e0017mr4623469e0c.5.1769023769469;
        Wed, 21 Jan 2026 11:29:29 -0800 (PST)
X-Received: by 2002:a05:6122:1da4:b0:563:71e1:c884 with SMTP id
 71dfb90a1353d-563b72e0017mr4623456e0c.5.1769023767606; Wed, 21 Jan 2026
 11:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109113430.2767264-1-randolph@andestech.com>
In-Reply-To: <20260109113430.2767264-1-randolph@andestech.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Wed, 21 Jan 2026 14:29:16 -0500
X-Gm-Features: AZwV_QjjfM8sbLVcaSRcAyiQsj15KqcE1hxLI7TKrZr-5JdYqtBOY1NwuO2pGoU
Message-ID: <CABe3_aFQo0c+RUP8FsAGucU7Abovv0HzmDNz6w9FXiFPt4RPyA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Use multiple ATU regions for large bridge windows
To: Randolph <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, robh@kernel.org, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	samuel.holland@sifive.com, Frank.Li@nxp.com, randolph.sklin@gmail.com, 
	tim609@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randolph=E2=80=94

Thanks for sending this again!

On Fri, Jan 9, 2026 at 6:43=E2=80=AFAM Randolph <randolph@andestech.com> wr=
ote:
>
> From: Samuel Holland <samuel.holland@sifive.com>
>
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Co-developed-by: Randolph Lin <randolph@andestech.com>
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
> Since our changes depend on the original patch and no updated revision
> has been posted by the original author, we reached out to Samuel Holland
> directly and received his approval.I have consolidated the required
> changes and am resending them as v2.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 72 ++++++++++++++-----
>  1 file changed, 55 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 372207c33a85..771e71b40f76 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -903,29 +903,49 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp=
)
>
>         i =3D 0;
>         resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +               resource_size_t res_size;
> +
>                 if (resource_type(entry->res) !=3D IORESOURCE_MEM)
>                         continue;
>
> -               if (pci->num_ob_windows <=3D ++i)
> +               if (pci->num_ob_windows <=3D i + 1)
>                         break;
>
> -               atu.index =3D i;
>                 atu.type =3D PCIE_ATU_TYPE_MEM;
>                 atu.parent_bus_addr =3D entry->res->start - pci->parent_b=
us_offset;
>                 atu.pci_addr =3D entry->res->start - entry->offset;
>
>                 /* Adjust iATU size if MSG TLP region was allocated befor=
e */
>                 if (pp->msg_res && pp->msg_res->parent =3D=3D entry->res)
> -                       atu.size =3D resource_size(entry->res) -
> +                       res_size =3D resource_size(entry->res) -
>                                         resource_size(pp->msg_res);
>                 else
> -                       atu.size =3D resource_size(entry->res);
> +                       res_size =3D resource_size(entry->res);
> +
> +               while (res_size > 0) {
> +                       /*
> +                        * Make sure to fail probe if we run out of windo=
ws
> +                        * in the middle and we would end up only partial=
ly
> +                        * mapping a single resource
> +                        */
> +                       if (pci->num_ob_windows <=3D ++i) {
> +                               dev_err(pci->dev, "Exhausted outbound win=
dows mapping %pr\n",
> +                                       entry->res);
> +                               return -ENOMEM;
> +                       }
> +                       atu.index =3D i;
> +                       atu.size =3D MIN(pci->region_limit + 1, res_size)=
;
>
> -               ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> -               if (ret) {
> -                       dev_err(pci->dev, "Failed to set MEM range %pr\n"=
,
> -                               entry->res);
> -                       return ret;
> +                       ret =3D dw_pcie_prog_outbound_atu(pci, &atu);
> +                       if (ret) {
> +                               dev_err(pci->dev, "Failed to set MEM rang=
e %pr\n",
> +                                       entry->res);
> +                               return ret;
> +                       }
> +
> +                       atu.parent_bus_addr +=3D atu.size;
> +                       atu.pci_addr +=3D atu.size;
> +                       res_size -=3D atu.size;
>                 }
>         }
>
> @@ -956,20 +976,38 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp=
)
>
>         i =3D 0;
>         resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> +               resource_size_t res_start, res_size, window_size;
> +
>                 if (resource_type(entry->res) !=3D IORESOURCE_MEM)
>                         continue;
>
>                 if (pci->num_ib_windows <=3D i)
>                         break;
>
> -               ret =3D dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_=
MEM,
> -                                              entry->res->start,
> -                                              entry->res->start - entry-=
>offset,
> -                                              resource_size(entry->res))=
;
> -               if (ret) {
> -                       dev_err(pci->dev, "Failed to set DMA range %pr\n"=
,
> -                               entry->res);
> -                       return ret;
> +               res_size =3D resource_size(entry->res);
> +               res_start =3D entry->res->start;
> +               while (res_size >=3D 0) {

I think this should be `> 0` instead of `>=3D 0` like the loop from the
outbound window. Looking back it is actually my own mistake from the
reply I sent to v1 that you faithfully replicated. One of those times
you wish for git blame-someone-else :^)

Hopefully this can just get folded in as the patch is taken to avoid a v3.

> +                       /*
> +                        * Make sure to fail probe if we run out of windo=
ws
> +                        * in the middle and we would end up only partial=
ly
> +                        * mapping a single resource
> +                        */
> +                       if (pci->num_ib_windows <=3D i) {
> +                               dev_err(pci->dev, "Exhausted inbound wind=
ows mapping %pr\n",
> +                                       entry->res);
> +                               return -ENOMEM;
> +                       }
> +                       window_size =3D MIN(pci->region_limit + 1, res_si=
ze);
> +                       ret =3D dw_pcie_prog_inbound_atu(pci, i++, PCIE_A=
TU_TYPE_MEM, res_start,
> +                                                      res_start - entry-=
>offset, window_size);
> +                       if (ret) {
> +                               dev_err(pci->dev, "Failed to set DMA rang=
e %pr\n",
> +                                       entry->res);
> +                               return ret;
> +                       }
> +
> +                       res_start +=3D window_size;
> +                       res_size -=3D window_size;
>                 }
>         }
>
> --
> 2.34.1
>

Best=E2=80=94Charlie

