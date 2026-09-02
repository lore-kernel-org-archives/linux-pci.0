Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3133AEF2A
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382446; cv=pass; b=KUogVpR8dVC+xpe/4pwS1o7P+IS6yaPLbPRmH86lhmEN8sa2KpuqDTZ07F0eTZT4T45j59Ji3dKlkUsi0aMTaZiZYQ2t/tZwVvauEsHC5NUCw/I1RUTvaXHC8bIQ5Ci+FH0RfVJU/jbB8cARcRn9/mOFwWtoeIHAFHV+T033/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382446; c=relaxed/simple;
	bh=UyfVQsMxJuVHDr9tnaZqx4XeRllFUZGvJm2XPpQicuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvqEWlVUPoSzrMfmO0YQIZ82z8N5fN+a0FeFj1meaHDo4BvJ3ZRXMKCx3xQkNucK7AiZ4uQk84ZkM81w/dLoLGIU3X904VB8ox8z9wyP+cON41qncIYRU18Ew42pFUQnLUmuwikwLERr4OOpZwlvWYA8tYY7NBSdwKOXClDRG1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=E1BnX78Q; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="E1BnX78Q"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KHvmh2582309
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 13:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=slP6R/eaA5o7SI2c2fvL5HowCLSeF5yWKjN3z
	D5fFhc=; b=E1BnX78QMPOajuTpKiFcgnyOA637N6mEbVYBap7iq3JFNa20fU1yk
	7cYBnwisH6q1ygtZ2lRFyza9f5+R3zeypp0Z6N//luTubwhqvthDfKEtHBDG91p2
	KIv6N+01vZyHWwGg2HhXwQ3EkUlbDcLvtsVioORnzBblxazv+DqDq9thZ1somu0i
	H6FCuK7vJCntpe7f568BAufpH0KR9XgsPL/Iixe/1SRJAD9fChVpFj/Ew5goBYER
	XbfDIJnH+lGkvHzzT74WvPSAXKEuOeP/4MfqT2aVrkOUu2fus6j2nCYcy5xk+LFo
	j49p983gU7k9YS3S61lgqyC0tONksP2og==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gdvpxv9vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 13:53:59 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fc6dc091so1065122a34.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 13:53:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788382439; cv=none;
        d=google.com; s=arc-20260327;
        b=FOJ/2KuoFbK8oKSfm3iuvDVv7xIyxd1vOQ4PRe8jsxk3MMSDRoVCtda3vhTo1Dwtbs
         a9yT4Lw16mtpazYyHpt/Fw7QHMm01lOuhahzLW3t8IPvwLAAOZI8Fk5kuS9fPfKSsLYm
         1GnHCRQGsAFeADVhxbiRRBrnpQjxNSf94lbIs/mlEqAushgopKnyzft4fAqu0AZNNvxl
         0wNj97R3W1AZXDtbIwBAjuCbA6Li0GN7R9+PKO837mrlUdHjg/6jZmO2SLXxcT2B7XR8
         PQxsdsTnpx98rstYD77CnamWimbQAsX6ZrnTFXEnJOuYcVuy6hCCXuisxE16HiVJOHql
         3zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=slP6R/eaA5o7SI2c2fvL5HowCLSeF5yWKjN3zD5fFhc=;
        fh=YZwVCM3xh9GAfEFKgvG8SF5PzCr1dQN6nMxtFfzQI8c=;
        b=GHARcDHPPtX1jXTc5qawRjQIg8YQqxl3Vl6uf67MFqCE40UnVSeQbYHcdQAMW+8hIs
         kNlcygTVdF9nX7lpHy+lzU7UcM/NxrrfrLADBbb5I1o3OAJX0sQ6k3vlyCRwBGkOguFs
         9Ltc2U1+OPXjLc1ZZtKuUxPGqrTVeDIv9h8wnzC925rpPWc7nnLWvHDf6Zp02FoeRI/h
         wiXPbyOV3LQkb3WGwGUX0akTVZimlmiOF09/xQYOFl6lx5IHoPBkLEUowVnqw4X4b1B8
         MYxi9KpOfFsnGXhojeoSaOattesw1qlCcg5+Kwh1/mIXnVD53RkM64yGPH/cZHIPhXKW
         S3lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382439; x=1788987239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slP6R/eaA5o7SI2c2fvL5HowCLSeF5yWKjN3zD5fFhc=;
        b=Py2Ss9dC9fSMN2NtIvmc3eL8TsMSGzHbBDS3sa5UwPtBs2iJ+orx2g5Mq4v83+RVF8
         3YkLi3omTm88eQ7FevqyGyjVr31h+o+Tfiga4V+odEQJ2olxWcpju7W4CSyjyEbyi9fF
         LM3WUXO7YE77Zi4e2w5VlbEW7bBQjtyO5ibbzwv9jzeXuWorj8jdS06K/fYWkDLoKVGm
         B6tqriR5/hCjE74Z2en/VzKlTZEOluDHbSrc6mOaSo0ysctTadZafuIAfZq9zChv+qdc
         HIy3dHhk5LO7A7mU/sA6EdhIx/azxyU5HDwBrlAc3WgVdR+lA+jAxk1BA8m3i7OT/Psy
         sF7A==
X-Forwarded-Encrypted: i=1; AHgh+RoPV5HKYLrTWm4Fjnj0dis1inkJ28vSCEurCI0Dl8CzpCv2VssThO7yd6jPdo/WmJXRUzut1I3kbiU=@vger.kernel.org
X-Gm-Message-State: AFuF++nfviYPXwrUsBgslWwJoYg31dQiMzslNs4fI4UiDEX2aogL98S3
	eDn8TWaTdZQ57O71IdS0J33IQvbOavaxdDPTY4yuTJMxj5SK9RbQY7D9od8tr+2AQ6W1WFLgCTY
	2zuxF/OjlHL+XYniSRiq1SQyyMSllUBdUQp1Ww//4iBHwJ/5XdLWLb6Hi1IAoRL5t7Y8NiqyMa6
	4YMHoSxxtbB22g1LfjsXcHzo6XWKm1Geas09I=
X-Gm-Gg: AR+sD13z4CIezGQBbECXjsnwbqfhCD+Rkd2ENm5V80Fk1+MhM88c43WBa0ponGPMx4J
	xqUqDqndU/cxl3dNkOtvHnk44/CO61Xw+lwNEJ6OF1Ne+bYQ7PQN3fstSrr28UT9GKFBuNHTs0x
	7A/KUif8+JzxKXdwlCIS0SB8YNBeT7pvA1yusolqg90yB1HKYfu2wUMYKYWOeJvkLQ+8XxDRGB
X-Received: by 2002:a05:6830:2318:b0:7dc:e336:c828 with SMTP id 46e09a7af769-7f78118c5bfmr7645629a34.10.1788382438956;
        Wed, 02 Sep 2026 13:53:58 -0700 (PDT)
X-Received: by 2002:a05:6830:2318:b0:7dc:e336:c828 with SMTP id
 46e09a7af769-7f78118c5bfmr7645573a34.10.1788382438385; Wed, 02 Sep 2026
 13:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
In-Reply-To: <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 2 Sep 2026 13:53:47 -0700
X-Gm-Features: AcwNN1XXj8kbotAle5RRTxM4j9lLg4IWUd1UaMxGDPIdO-M5-6hRyJEApT1F7Gg
Message-ID: <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer access
To: Christian Konig <christian.koenig@amd.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 6uZisTgFpFSvmizK6YjeGKv2i1VGKZSO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE4NCBTYWx0ZWRfX7t2l5OAY1RNC
 LxZRiVJE9l936pk0mxqg1cHih0sL2UmFpcTNfOMtsM55wY0S5QhaVRrtpXRBeUeIce4FYfNq21r
 xLwYr2USjOrvfmYz3os4FPoPi/AMe4I=
X-Proofpoint-GUID: 6uZisTgFpFSvmizK6YjeGKv2i1VGKZSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE4NCBTYWx0ZWRfX45g0q6TDR4ox
 RAQPjBHcFt+PJrUQOcfeg3uZWBeajO//ZlQad+l6/niRMs9888Qg8XrMlezCNtXQDtOQOmkYfhX
 3bHuQaXiBd3xNPHMrAAGvN2Rv74oc0EqaaJ6MuiLL2ht2QF/RdVERoUY3vXytCc8yIoE6JN56ta
 D2qlUut19DhYWSnboNYgOUgXjJG3Y9qmn2fOFEyVeBBP/5uk+bz770wlghb5Z5aZkGxm743O9rH
 oSUPhTJrEzGOrLwMVfZaVewnV1dbB8OH0Z3qvWyu8QC9SC9bW/dhPYWsm2HQH9lcu9Sy8SHUVH7
 j5mPLoh9SwWtExl4ZNPvEK3JgOxbu9nEDoX9p1nnGn8e8Aqq9fdjbMy7GQ2NVs4fS1QQSLsqAhO
 4ZYf3KoI7AIrZI9ERZv/RKBjvIMpP/++z3JNz+Y/JaLmo7mvAowdPutzY0QT1BaW+pd+oT7cl4I
 EVzYOfiEzCc4Lqn9FKg==
X-Authority-Analysis: v=2.4 cv=dKyWXuZb c=1 sm=1 tr=0 ts=6a988ce7 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=Tz3jYIXQlW6mLFCxu40A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01

Hi Christian,

Another ping on this series for your attention. Pls see below for more deta=
ils.

Thanks,
Zhiping

On Fri, Aug 14, 2026 at 11:08=E2=80=AFAM Zhiping Zhang <zhipingz@meta.com> =
wrote:
>
>  Hi Christian,
>
> A gentle ping on this series, especially patch 3, which adds the
> optional dma-buf get_pci_tph() callback. Could you please review this
> when you have a chance?
>
> https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@meta.=
com/
>
> Thanks,
> Zhiping
>
>
> On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com>=
 wrote:
> >
> > This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> > export path, allowing importing drivers (e.g. mlx5) to use the
> > exporter's steering tag when performing peer-to-peer DMA into a
> > VFIO-owned device.
> >
> > There is no separate in-tree vendor kernel driver for the target device=
:
> > vfio-pci is the in-tree driver and the targeted device is managed
> > from userspace via VFIO passthrough. That is why the ST has to flow
> > through a uAPI: userspace owns the device and its ST table, so it is th=
e
> > entity that can configure a meaningful value for a given dma-buf. The
> > kernel-visible participants are still in-tree: vfio-pci exports the
> > dma-buf and mlx5 imports it.
> >
> > On the effect: the endpoint's PCIe ingress block uses the ST as
> > an in-band instruction for the incoming P2P TLP -- selecting a target
> > cache partition and, on writes, an in-flight operation on the data
> > before it lands. The dma-buf callback keeps this opaque to the
> > framework -- only the producer (userspace owner of the VFIO device)
> > and the consumer (endpoint block) need to interpret the value. The
> > dma-buf get_pci_tph callback itself is optional, but workloads that
> > depend on the endpoint's in-flight operation need it because fallback
> > does not produce the same result.
> >
> > The dma-buf hook is intentionally generic and discoverable rather than
> > a private side channel. The exporter owns the completing address
> > space for the dma-buf and decides whether it can provide a meaningful
> > ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque=
,
> > and importers merely request the namespace they support and place the
> > returned value on generated TLPs. Exporters that cannot derive a
> > meaningful tuple simply return -EOPNOTSUPP.
> >
> > TPH is advisory: a steering tag that is not honored on the path (for
> > example an intermediate routing element that does not forward the TPH
> > prefix) is ignored and the request completes as an ordinary,
> > non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefore
> > targets the same-Root-Port / common-switch topology, where the ST
> > reaches the completer; cross-Root-Port P2P is best-effort and is not
> > gated in the uAPI, since supplying an unused ST is harmless and there
> > is no discoverable "TPH routing" capability to test against.
> >
> > Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding into
> > "not supported" in get_rp_completer_type(), so only architected values
> > can reach the TPH Requester Enable field. It was previously posted
> > standalone to linux-pci; per Alex Williamson's v12 review it now travel=
s
> > with the series, which removes the cross-tree ordering dependency and
> > lets review tooling apply the series as posted.
> > Patch 2 adds small PCI/TPH type helpers so drivers can query the enable=
d
> > TPH requester mode and the device's TPH Completer Supported field
> > without reaching into pci_dev internals (and so callers in
> > CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_ty=
pe()
> > applies the same reserved-encoding fold as get_rp_completer_type(),
> > inlined locally so the helper is self-contained.
> > Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> > dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> > metadata from an exporter under dmabuf->resv.
> > Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> > (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
> > Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces t=
he
> > dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid for =
the
> > mapping it was queried against, and the mkey's TPH fields cannot be
> > reprogrammed in place. mlx5 therefore records the registration-time tup=
le
> > and re-queries after each dma-buf mapping is established under
> > dmabuf->resv; unchanged tuples continue with the existing mkey, while
> > changed or missing tuples fail the remap rather than continue with a
> > stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> > because invalidation is revoke/quiesce, not movement to a new backing
> > placement, and the userspace-provided tuple is not changed by the
> > revoke/un-revoke path.
> >
> > Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> > Functional validation on the target topology: PCIe analyzer captures
> > on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
> > P2P workload only produces results consistent with the endpoint's
> > ST-selected in-flight operation. For example, with userspace
> > configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-t=
o-
> > peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> > ST=3DF0h PH=3D2 HV=3D1":
> > (TLP Captures)
> > 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> > F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> > E0200000 -> AddrH=3D000020E0h
> > 00080006 -> AddrL=3D06000800h
> > 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
> >
> > The dma-buf get_pci_tph interface has also been exercised by a second,
> > independent importer: a different vendor's NIC whose driver is not yet
> > upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyzer
> > confirmed the ST it placed on outbound P2P TLPs matches the value
> > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result as
> > with mlx5. Two unrelated importer drivers exercising the callback
> > end-to-end shows the interface is not tied to a single consumer. That
> > importer change is out-of-tree and not part of this series. For that
> > second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D0,
> > an analyzer capture shows:
> > (TLP Captures)
> > 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> > 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> > 00170000 -> AddrH=3D00001700h
> > 00200006 -> AddrL=3D06002000h
> > 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
> >
> > Changes since v12:
> >   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
> >   previously posted standalone to linux-pci [1], is now the first patch
> >   here (Alex Williamson). Sashiko could not apply v12 because of that
> >   external dependency; with the fold in-series and the mlx5 leak fix in
> >   linux-next, v13 has none. The code is unchanged from the standalone
> >   v3; the Fixes: tag is dropped, since no code path can reach the
> >   reserved encoding today and the patch is hardening rather than a fix
> >   for observed silicon.
> >
> >   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
> >   pcie_tph_completer_type() rather than calling the helper that earlier
> >   folding revisions added; that helper was dropped in folding v3 per
> >   Bjorn Helgaas and Wei Huang.
> >
> >   Patch 3 (dma-buf): no functional change.
> >
> >   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
> >   vdev->pci_ops->get_dmabuf_phys, matching
> >   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the featur=
e
> >   as supported on a device that advertises TPH Completer support but
> >   cannot export a vfio dma-buf at all, so nothing could ever carry the
> >   metadata (Alex Williamson, who raised this to uAPI-affecting
> >   severity).
> >
> >   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index()
> >   ahead of the pcie_tph_get_cpu_st() call, so splitting out
> >   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation on
> >   devices without ST support nor changes the errno userspace sees when
> >   the _DSM lookup fails (Alex Williamson). The commit message now
> >   describes this rather than presenting the split as a pure extraction.
> >
> > Previous link:
> > v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhiping=
z@meta.com/
> > v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhiping=
z@meta.com/
> > v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhiping=
z@meta.com/
> > v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz=
@meta.com/
> > v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz=
@meta.com/
> > v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz=
@meta.com/
> > v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz=
@meta.com/
> > v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz=
@meta.com/
> > v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz=
@meta.com/
> > v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz=
@meta.com/
> > v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@=
meta.com/
> >
> > Zhiping Zhang (5):
> >   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
> >   PCI/TPH: Add requester/completer type helpers
> >   dma-buf: add optional get_pci_tph() callback
> >   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
> >   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
> >
> >  drivers/dma-buf/dma-buf.c                     |  32 ++++
> >  drivers/infiniband/hw/mlx5/main.c             |   1 +
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
> >  drivers/infiniband/hw/mlx5/odp.c              |   7 +
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
> >  drivers/pci/tph.c                             |  55 ++++++-
> >  drivers/vfio/pci/vfio_pci_core.c              |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
> >  include/linux/dma-buf.h                       |  25 +++
> >  include/linux/mlx5/driver.h                   |  15 ++
> >  include/linux/pci-tph.h                       |   8 +
> >  include/uapi/linux/vfio.h                     |  43 +++++
> >  14 files changed, 517 insertions(+), 19 deletions(-)
> >
> > --
> > 2.53.0-Meta
> >
