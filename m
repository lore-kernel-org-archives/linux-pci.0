Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208236B920
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632082; cv=fail; b=YiyYcaprcLGfAXNpbUqeE2F4xlnE3wVB1bupfC9qMISeRqJ1zO0l31znfj4POJlIhexXCiyFPlY2c3lqtXSFDRoFL6tihm35qitB17iKKbIjtUHCJ4MENaF1/XMxGLFRH8mmkEXyJsrAFTdksRvBwdpj4pTyhS9y/r5xpIuv2o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632082; c=relaxed/simple;
	bh=BTOe3Am915BHVXg3ukWQGJbf2RonMUAlNyZzaCFwnm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8RDj4UcX62R/tKFJu93P6HKaNl1RrP5Q+2kgtJWk9yUMq0OODvEjqeurndMAi1ZXEv0b0Dl4rLx3Ca4wANTvgp8sdf3F607ZRNCgMs8QRR0iTLrAf6YpdmBFmfbviD8cpWCwUfYNS51F9ntGtm2RTCut7eGWQ82f+hZyJbhj98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kOlYqGiD; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kOlYqGiD"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTXQV650097
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 14:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=OVdNSiqQUhRQfp/JGpi7EaQ9UmFZis0CHFKmY
	zkvi1s=; b=kOlYqGiDxua0gnAE94K8BoX1NpPHaagCIF/NCVsflq+xJJtWzb0YO
	YBz6kPJxXBjaCNh3T3N0DhRurSOV0/7GVM28F/QnZ/33gICD9+BdtSZshieGanER
	vkLOi/B0XbuISnjkPoUk6rjCHlg1hWu9itC41ZN+PCfbNrj2xaueHxJIxQBEr4mX
	RYbT1AgUpkZn3AQcdT6NVr7FTzap0WZo1xshFg+qb7pA3nGyffOzxt/7/jstZw1c
	QAEC64RTXEw+vOSZeiCr82m/OtVaCK+KDEYEmzFgK2UQLd21WhAZEmuzhfp2WhSF
	CSFY0u34VEvqr/lTJHB4spcEJIIWbkwzg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gxdbjs3u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 14:48:00 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-81a9f98acfcso3608694a34.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 14:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790632079; cv=none;
        d=google.com; s=arc-20260327;
        b=D/xLWNAWJjrS2DsS8MRJMp/DYwyr/k6v2Klb4WlmzTWpE67bgXnn0RrsNLCaD/wOB/
         07gMhY7FB4BlH1XSeIwEOiVxgl267JGhWwVtU4o2jwK1Rz5TzjnhML9o47wdwon/eu7O
         eF6xGPqyQe4FQB4ldb6Uy3eDMsXik8ekbhvJii+jdBOgvWW7Y77v7z/rs1GdQbdA1ZkK
         75EpPT8l4mgxyEsW2VeQFs9f1qBMOTDTHRaewehbQP5m0lGpkkYCm/4XwZCr/3ABnJi5
         YIIBd6eb29rBNXsi1bb9jKIpsm94H46E8ePztOCfRCKrAgHMdJSDBOe0Ci0jk44JaWx/
         RvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nsM/d13GDOKofLPZVXyaTADEaxrWWppyFB4m09sEx30=;
        fh=DOg3Nl0AU0W4JdbYPqXQNuY3vW21bmnxjWxqS4dDfBQ=;
        b=PCeTuSliJqYb0aXeMU6JGtMK7BrFWsnrDiAyIya3YA1EywCYhtjWySqbGY0zEVIVUB
         4tAtknSlRNrTykCCeBYlZhX3Zg/SKnjQ+Z4N/8AqQE9mcoiGai42l3RV8Qdktr53W+14
         NLag3QhY0ph1DcT+X+FZfEnDjWeSpktqptwKMRKroSMovPkZxaWhmRVgjVav+XDCkfaK
         nlYwCNBIU7KGV19LHWeBbtcmLISJoeC3vazmJ+aX1BwgzJ1uswdA52ktH4UQoCm0UMh+
         qRWdqteaYVkI/K+Od1Ei16akxaytB064RzzhfK1Ew3h3Dtf/1t2UQi97AH4naUpsV/dd
         cXaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632079; x=1791236879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nsM/d13GDOKofLPZVXyaTADEaxrWWppyFB4m09sEx30=;
        b=DXfOGBlq+fTs0kmiIUJ4wQXjwVM8BHgJeiZuqCq+QvNuwSSo8j1v9T16H4zQ35i9zM
         FgBebIqLTwwoSpF/rv8iwbdl3Nkw0FoenQiPtRI8ZE3y2k4sShOoL+Nm/BxAVi1G4G7J
         4Gxeh6uOSY8PZ9E6P9eRg4uxW8pZhEBnePPK1k8ufIIspB3ySh8TDrMXwOLNe+Swkx0O
         ffQg3fjJGB8ZqaBPQu5zRQWPpsvp9dgVDdEwcQZ805ej/0ZAsPBUVxa+UXC8mL02V6XF
         lzGC7LGckro44TabgWJZzS0/PsnQyrUn2bHvZP4fzjhtDSj3dGrp4rJUH54eaE4HttiL
         6CVg==
X-Forwarded-Encrypted: i=1; AKwUvBwmZuExun1u29XfgAJzAKzyIuu8pGMDM2AYb2Ny6j4tetnqCq7ZVs6nN88TVS6oea9HsvBgSe/+72A=@vger.kernel.org
X-Gm-Message-State: AFuF++l4+IwYwbngePM/ElLnxY0YgSxn2DzBaKCqSXBezeaSaY+aCNK4
	Wga8Z3ctKSpI8dHLWPGMZE2+WtmO+scIeHJbayiqpIo79s6foStAxOTa0KoWaFietz+OFZvHwRc
	Iw6bGojHrpTJHHjeF/EjQ0vVo87pAQ/Rw/EffaYaeh1sZialcWd5TphbVZxaFVVb48SWUUUjQAn
	EVLh06LiW14IkUcjD9wSuGRMho7RZKHPlDdw256u+XZdoy1g==
X-Gm-Gg: AYBFou0Kn8i3iwm5zALlCt6opdlAI9JcZRNG6rA5Vg6oPOs/e4lyuYiS+T8hIba/3ZM
	OyH5FwluicEtOrhhfEsIQ2UtdEaEoUsaahAJ/zppLFp3LpCZSC7xOkJoJG7IXS1El6tHZrlcec2
	/FQaitDSTmBja7H+AP+U5KVRb6bhGR7q0MHAyUUVZA40w1bm6f+b259FwGeVi1vMhZPiDNYpOl
X-Received: by 2002:a05:6820:f012:b0:6d7:fe06:604 with SMTP id 006d021491bc7-6d7fe0607eemr5411481eaf.18.1790632079076;
        Mon, 28 Sep 2026 14:47:59 -0700 (PDT)
X-Received: by 2002:a05:6820:f012:b0:6d7:fe06:604 with SMTP id
 006d021491bc7-6d7fe0607eemr5411459eaf.18.1790632078491; Mon, 28 Sep 2026
 14:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com> <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca> <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
 <20260928172939.GK163130@ziepe.ca>
In-Reply-To: <20260928172939.GK163130@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 28 Sep 2026 14:47:46 -0700
X-Gm-Features: AclHuK-FrHEzthVV7FZ3Ls3GrwbmAQee8rpJCMTJYpOGKi1s1NipCikGQwgcBpk
Message-ID: <CAH3zFs1mCujYjB=5ywo+huAjPJZQoe9u7NM4evNRYr5_ZQbcXQ@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: n2U0YFtg0Jex42VfThds-sSjXib5Svax
X-Proofpoint-GUID: n2U0YFtg0Jex42VfThds-sSjXib5Svax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX4h04/cZpYB7T
 ejg+7cdOkdYt0GFBVp6pF0g2Nb5JL8ICXD31qtiJGJ/yiYxlR/biQlZVxmrZC8d3bbeJJp4k/Gm
 iDCfmQ2OHQt3takdBMtkaPO1LcVwst4Ae2fXtoZjN6t/HkJRmRCvndH98s8AHqgPZ0ISRKlZeaY
 AV4xrHsRkc6Jz5sxHRwJdX0EaazmYb7HFufEcP0o14aCxOfjQaZW8yvqSYKhMfiXVywOgQLxc/n
 mfQJRuroESBKWRLBcaqMowBMRoojj9jaK8dHghZwmQ+lDfkUyZKw2qEi1UofqUfrKp14xRyq9yq
 agbLm9TAFWchLzX2ear2qZHKGdkWNR/33QZXyp3mEb8XpEszz5SotJi+GFM8Ga3t2YsihRnPEUv
 kzThxCiWqXJhCdbYSMc0Qt9QaLEkvwp25/3xP1pIiZaPF5emYRq9dMTza0LUOMSqC4V8QWiFZcB
 wZaC0/RYZYT39BEkyVQ==
X-Authority-Analysis: v=2.4 cv=Vqa2kO2n c=1 sm=1 tr=0 ts=6abae090 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=l_Ha6740zCVOtLZIeloA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX69ba64SJBqX1
 3aEI/C4iOxnOdTCc+PbyipvLrBACig9Ulg7ar3X4LdyZxHTALEJYbR3kfQcdCBPIQL6qwGgfIT9
 cOtAZc+eTRS/ao1Q1RQLOvhyLMxIxok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01

On Mon, Sep 28, 2026 at 10:30=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> >
> On Thu, Sep 24, 2026 at 11:17:57PM -0700, Zhiping Zhang wrote:
> > On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > >
> > > On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > > > I don't think this belongs in the importer. Every in-tree dma-buf
> > > > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > > > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > > > habanalabs memory.c. There is no importer-side caller.
> > >
> > > Right, and they shouldn't be doing that, but it still has to be
> > > checked that the st is going directly to the peer device not the host
> > > bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> > > indication.
> > >
> > > I fear you will need some of Leon's series to make that happen.
> > >
> > > So probably the proposed change to dmabuf ops is far too simple.
> > >
> > > Jason
> >
> > Hi Jason,
> >
> > Thanks for the comments.
> >
> > Agreed -- the tag should not be handed out unless the routing is
> > PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
> > with two changes. I can fold both into patch 4.
> > ```
> > In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
> > tristate VFIO_PCI_CORE:
> >
> >     EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);
>
> No, that's been rejected several times already.
>
> > and in drivers/vfio/pci/vfio_pci_dmabuf.c,
> > vfio_pci_dma_buf_get_pci_tph() gains:
> >
> >     struct dma_buf_attachment *attach;
> >
> >     if (list_empty(&dmabuf->attachments))
> >         return -EOPNOTSUPP;
> >
> >     list_for_each_entry(attach, &dmabuf->attachments, node)
> >         if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
> >             PCI_P2PDMA_MAP_BUS_ADDR)
> >                 return -EOPNOTSUPP;
> > ```
>
> Also no, this has to be done via PCI_P2PDMA_MAP_BUS_ADDR which also
> enforces putting the determination in the right place in the code
> flow..
>
> > Two properties are worth stating explicitly:
>
> Ah! AI!
>
> Jason

Thanks Jason, I see what you meant by Leon's series now:
  https://lore.kernel.org/all/20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@n=
vidia.com/

Looking at v8, it seems patches 1-4 can stay functionally unchanged,
while patch 5 uses dma_buf_p2pdma_map_type() on its own attachment for
both the initial TPH query and revalidation. Is that what you expect?

If so, would you prefer that I wait for Leon's series and rebase the
whole stack on it, or split the series so patches 1-4 can land first
and patch 5 follows after Leon's series?

Thanks,
Zhiping
