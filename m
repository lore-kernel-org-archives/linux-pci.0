Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48C32C316
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763055; cv=fail; b=fykCijrs1oQN2tT2YVrlwO+qkTKkUgbl2+Q3YKxw+HEE6szMFJi/g9NSncFIm1iTruswcNaFra2/HAOCTjaLz4jh2KoR0XTl5up1MFYfo448wFroo3qyVvTw9+EZcuWX452P3rEpQz/zWzXWV2mjknJ15zqi6jurG/ewy+GZdag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763055; c=relaxed/simple;
	bh=aoNXmADJPkDhnZOjZgCi5nKSSN+hSwva5gE5EhTFdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHXSHstKJjmoVt3JRQYbdcTk2kLtkARVIYHRllppzy2Bbv7HPjlIDUzrzsyib9pVgMo1RzFEQBz8NXv8sceG5yASEijmff/T8EPhGIQQd3fOcOo3bJg1Ga3ySi+JFTscYPbPwurQ7ZViGeTlQXrmaRXU75bDB23E7jbLLCpNaRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hEbHoDIc; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hEbHoDIc"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I37g7R1867535
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g5sz6xIN2DOx/R49RD/V8A7DarhSxstt7fwwKkQBLVw=; b=hEbHoDIcNNBH
	sZQV9mk7PiiboxdNzb2rNmI7KBN6NuhX/NwRqSVyxP5vjpQuiVqvYgDlAsy9Zdkh
	Tgcyc7uRW8eAc3fozG8JcWlf9hfVD+uBtdLV8+caTR1qKSIE+88Ezoo/MJ3rmGyC
	jcejquyAHng7TfyGE3Z4rqdgnkiroTqWLpuu8qmFQoHaV8tG9ZP9WEMDZVWQKBJm
	bFqMqdhR2XWBGl2F6B6sIHCBRl+9WgPa7bchX/8lF9rfzbPAYunO2eH7BQStVytC
	3EGL5UOGoab/Pt1Tfkhveb6OOhzXos1WVdxlfCazGkh3Yrd5JWZz6c9LG9zbg7pd
	DI7ZUVO+Iw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegb1xx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6fed63fe5so894087a34.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763053; cv=none;
        d=google.com; s=arc-20240605;
        b=eeSvtcX5oDtkvUYVUOE0FgINC0otwrYhrK1igXK3sXtCD+q7NBQmDALbD6egkcv7/B
         dtYOQhD68iR7duoijOvFq9agoG1np+kuWw64K8QFj1Gyp5zq7St/2WlBKEgJPuD+CZRf
         U60iU4pxAhYKHq08F6JM+/RlVOQPdwOCYBFL8i1csmIuBD1K0+HZl32hjzMrcxVJk+yN
         UdIe0iDjElL/CHaGeP9vkOyCntGA1OEa8Ky6jJ0GBR5S7xN3eri9ctwTaJ45uxXzLF0h
         9jEp/tlESy7L/LeyOdvDqwpuS4TqVllHoP7A7ymq6HG6HNK/fCEG8b8xf1OKznN3gri3
         9Wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        fh=dg2PuoL2K/goEfdFKfvLGSlOPS0sHZSzfXPNIikVtjM=;
        b=Yd9GdRVypJu3AXoGSniZ2lBKcWw81gYXc2SACZGg4R+TzG8LK7zqLO8g1cMBldDCJd
         YKH9Yqw0l8MUAhT1CICj9YQaU0VK4ohjPUEReTSCO12R31MPnrf/CR6aH9RNErkV0+Mw
         QHfdNHwq8UoJ9VoD5PLegPcJvukfEoFVDbErtdUz607T6PEydAOZ5+wTgOpvAo0P18Zt
         FW+ppNXsC8nRRGDBBZSZGcq57sC7DF6/YGSgLP0pY4yOPPzogyTKkcK27rypXOwBj8Y6
         QGve7vpDgp3CbzY43Z7nPkLvHXOWiPpmf62rYlj/ItVkV5uNLxbbRSzj8rGq8oc4mPVG
         x9/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763053; x=1782367853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
        b=p5X40jPpRwjO4rAub3ORLtL7RPPZkdB2ZBxWQ25gVG8UTJSyl1KWRfIYwgYsKqpmDO
         zGipVVRcpRaduheqJAyu3ES78EHl29LKj5Z7ckEUFQll7bXngN+bq09ObPodKTnmcRq6
         4jnfXGihbfq3Oeu5dqSYYecBReAOtKkh2U0J0Ph0bDFZ4co6XvAbXYAbvUrlAs0lMLST
         p1FK9PBFimi6Pj6OIB0c501xpXVkPyl+bUAbYbFPsmgkfxxBlTTLlPNF2d0zU6IFo5Qc
         1Otu6B+Ez/anFyHQe9N9AL9dDIbiAGspbVomwGUJI8so8sPlIOKLtd7J0LMzzwuL+j1G
         lBqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rw6Ff+iO/s2iHnS1zMUzbNTlb/1bnI5PEOJP5P+Z0uOrIzBfdq7/vOQXl1ReCaotQett9QgY7I30=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgAO1Ay3CuKV3Ufecz2Dr9R3APsilg6pp3ytM+gHkc6xH4SIH
	mC87KPKUjfaYcCCanwCynk2r3jz6MhLfFrbx5ywE6nhpcVXIO02XtjvOcxrczeUbJZEhW/8+ZxG
	s2EVDoQEhPO56OXk4MPPklrryBf6seuSB4L488GnIUElTtv5EN6obkG4b7QfcZKHOIVWTUglp0f
	yaQB2ME74ptqJQCzWYHNPhdllThwKBkiOz9hQ=
X-Gm-Gg: Acq92OEandh+oH9/vzZMYSILAvAV+kc4LxdKAnS7Mw0haLBWN13iRIwC3zfRWf1tejV
	NnodRBsqGtZuCuHhox0tZ47ekrtp0suYL0SdpbZZzfeSHzHsqUbw2FNu0JSFyLRKpaoiHI17c4m
	loTnvmemADhG+Hx0UfQeJTQFIghGiIAbjXnCPwt7lMu7qxFRQa94UVe0d+5rkk7TtDmmclWJUeA
	rDsrrMBPE4Li7niQMO/0YrLLFlFBw==
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e91ac6d2b6mr2060572a34.8.1781763052713;
        Wed, 17 Jun 2026 23:10:52 -0700 (PDT)
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e91ac6d2b6mr2060543a34.8.1781763051390; Wed, 17 Jun 2026
 23:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-3-zhipingz@meta.com>
 <20260617094113.GU327369@unreal>
In-Reply-To: <20260617094113.GU327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:10:40 -0700
X-Gm-Features: AVVi8CdOrBaOwYRxFRdDVRsJhHRei-ObhsXGhIoQfKNO7YbBBbYe7t0f7TbFl64
Message-ID: <CAH3zFs3wBwbmvEMp498LTdbrSt4Y5w7PNpqtcN_L_vHdqsvnxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sITNF9eUzkdvlu1ox7uoy3F_uXDt8B4L
X-Proofpoint-ORIG-GUID: sITNF9eUzkdvlu1ox7uoy3F_uXDt8B4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX8OaSeK67S+MZ
 lXfHiP9UCJwnnx6XSO7aKVCHC3ZDXxdiMy+aVn45Eno6/V9m5OlT7CTu4NkZf175UhUSwUJMOMw
 3pKPyiUmIhHDvlnGg9U2lVION29eereFYwnVXcPMm80oQBQ/w6p3w9R/b+KeKvexdiE93j6kOnB
 Ex0GiH9fDNff9PewXLwcoigIIuxj+N89Quh5D9u42ed9KWVzUOJ/9cqiyKfz66dCFtOZ1Qiqp64
 qNa3BIrLj3pThZ9dDWLuTj0hDnJA1w07/u9FbAXkr1Y6Dif3qxIMEfxppzgaPzaBkRuPYWiWjmG
 4M0ZDB2SXnF5I8O3mkfOT/LiaWwABf04zl4BDFkPW/m0ZPwBdwo4bB302ETyHA5Bf41omIOSzmy
 tHINIrUy38hfA+EaXAw7F0qZT2dAMNdpLP5WXUcrrtfsSEO/A24jkkaOLEZHwNW0+TBtroQWvfF
 PLx0JF4HeA1XF/wORow==
X-Authority-Analysis: v=2.4 cv=Ca04Irrl c=1 sm=1 tr=0 ts=6a338bed cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=IaYQQxp-055UKQrtbooA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfXwxtVsCnPkK/C
 /8zLhjaJOMaCSj23E3air8UkKL6+lD/MEkehomt9ISrrkmlWlqgG59zUyPk/f7ejRyWbdSvTw6f
 Fa4UtzK9TwnlZF27nHcfHsqyniSqGcI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

On Wed, Jun 17, 2026 at 2:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:58:59PM -0700, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_pci_tph callback and a
> > DMA-buf importer wrapper, dma_buf_get_pci_tph().
> >
> > TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> > distinct PCIe TPH namespaces, so the importer requests the namespace it
> > can emit and the exporter returns the matching ST/PH tuple or
> > -EOPNOTSUPP.
> >
> > dma_buf_get_pci_tph() is the importer entry point. It requires
> > &dmabuf->resv to be held while the callback runs and returns
> > -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 16 ++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> > +                     u16 *steering_tag, u8 *ph)
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_pci_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, p=
h);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..5e7b69a40f3d 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,20 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_pci_tph:
>
> There should be a blank line after the line above, along with a clear and
> concise description of what this callback does.
>
> Thanks
>
Sure, will change!

Thanks,
Zhiping
