Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F21C84DC
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730940; cv=pass; b=C4pf2KbseTAxd5A/bFB5Sfr3CAwQnsVhGyGKxa/klJuohRorpC7DzQFq6Fiy8hjjOGjad1so9YM0gcsD1ZioqCg8Rl0tUr49X3jfcYLtiNw+23Hf0eXCjQMxGhTsBXdatAaATuQF1lqYVSlB6nQC4NpHXFzZdj6WSE2tLFfU/OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730940; c=relaxed/simple;
	bh=mrrvnHCJv/Eee+3bkg+S5wjiInjePvrAVjhSY2rehs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBeS33iGxKfblMIWROaLDucmlxUSJWfI6zhsLVWO1dyVNu5hxYK2s8DGuLW0LYrgWqvBHtVkYGulI086058VAhy8GxhK3hRrdtVRv8Jov4ZKm210/kWq8RK2YU9gHiZ4DCXUO3d7LOzeU6BIRfLwRJQ1ApWQ5JwWiBdzBmnr/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d6xYEaQm; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d6xYEaQm"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EGj4r74041700
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 11:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx
	+L/D38=; b=d6xYEaQmpmHsPwXDpM7XK27KiFnHnsIokOzJfYh6cGJbio2XJKBjX
	/h3xhpzsDh8tbWTJT583gLI/yDX4cGZvVEPaKUbZyRzZCpnCgKhQCp38vM1VEiCz
	Zy1qm06P9t9bUeLt+bXfuQqvdKaZRw7mNMaCnaHXWqb/kgDvUEykX1fHs8uYCdrd
	SzBlzNwulpc4kZwEe497bGS790kfW9lcIHzn0mAuyBy0CRu+Yne4+W7CsuwGCJBY
	iyG1+EoeB4iFke/eE7qg6DvHcPrrHipwl/RjJLvIjQwHpXDN5t31d/0lsGT98ou1
	BXPD+YVxkJrKvZfX+cvxntAkQu6GfzwTw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g1as0jbp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 11:08:57 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7eb6a8c61deso1014563a34.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 11:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786730936; cv=none;
        d=google.com; s=arc-20260327;
        b=MjjB93Yxk7FL1RXzeHS5p1GJ1OzLa123BKWpvWCjQI7K+IfDjpll1UJEQSZtNTqhy3
         +obrAa2xn38dRP8Wkq23/m/OzOUuwb7dgCCh+PKm3UHYEG4pMF7IvEzrLwziIa4wY+xG
         5DmLyEjf8ZmWZNKiKEe8iOXugZ8wJP8NTBTvmFSOe777qNSllZy/RH7E4hUWu1Y1xDvQ
         CvWSDk+DaClg9ClxT+dP4a/fyLmHjNmASqlOi4/fMv3y31a4joGbxH/cjiJp9TuBEBQK
         I0Rev56P77dW40RAYB7I2n4tdWDd6qIsZfDgrv6SyHKYLHARoW3zvq8oR1e8NnzhkBRg
         Djiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx+L/D38=;
        fh=O9WDn2y6j1j8SHA0Mxn9W+XuGV9y86AqTE/Ndfgbirw=;
        b=guJUgExIZ7HSjvewdHO8Y5zzuIgAV6odDiGpyYHRLZWgFDU3z5FvPYGvC8FoaLZtUK
         mXU1omMgSfxP2Lm1SqR3Kk296ZkjEc41ODyqLEuldnK3LscT4FiH1KhX1qQt9yiK0NG2
         VFYTXXYan/gePjlhQXQpdno7nAfUl/kONolLgtOrCTSm9ZmzJVsLsGEpTkFvifWel4PH
         j0LG5yptx1OnnmU7N0ppQ81S+tYBdOysEK4N3k9rydjziNScOS4/GzBiozC43h3olBJ5
         khiTedjvp/AsXlQbIHVylHuyYDHj86CeE5qVu6x4ST84/Y0nOwXRukBSghIL6D1l2wfG
         hClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730936; x=1787335736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/wc9xo4pjSkf0rMp8r6iOmUU+t5ZmWTQnIQx+L/D38=;
        b=kXc/wUXv70T/o/Uj4Bj+K3h06k256S0AYoHPdwfM4n60phg4HxfVrZhmsV+PgQC06C
         xnpuPGrFY6JZAclhn2SskD27bzbjEEuGtAcKCpqzk9JLFk1fbN99fs2HfHncC1mf3jyx
         oxhnVkrrMi1w8pGxPlnJi81RW72ZtUgr4kCa7t73dKEWnTsiuy9ZuuHSEk+kCaFbvxsS
         46Xdu0VE5DVtxyTTzUvtY4WL79EU0Spk2GyL/k2DdYWuzFfNgBRafbXX64xbrVarhoF6
         3Wi+1tSK/1+TRh8FnGUqpPX1iD5FMP840fIcfC+oOVkhalndTtf7B9g6dSinPuJrR5zF
         jvNw==
X-Forwarded-Encrypted: i=1; AHgh+RqjzTafxRbHNrAOhhKI9XTyy0tNO+x0RFdrDZbztnBXkfrPimjqSlsKwYsrE8RQOqnm13BL01YqVDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqCn3hWUruBmUUCIBwPkKNHepvVTtsXq70eeoqmVh/76Tszob
	R2VXDBngEngQ8IpgE+aN4glIwZEk3rdztAwTNIZqTHb+bo2VU5SjZQmqrDj/UD+VtGujjXCF7hP
	RDxUOEpzrucjV9hLaVQ2KhDzxTuJMauXmbsjDfzLTDf2T+2hnvRK33ixnHNojNptSlPcYYHhEG0
	W8lNwTzjcAwikLRt7x8ydNVI0/iPeHKKIiWvc=
X-Gm-Gg: AR+sD12RWFrK1o7la2TizTcznCNoTkO0jeoeNg/1vXRxMPZQNBcv3We9OSwRbjY8N9t
	7GmtaQluHBZnbMh/OTMVCJQOp4vtxdsGKywdoSdwaX+yd4VxRyhPHiRxl+/tHP1eG4Ydn4YE1WY
	vJnAsOSOG9nwFBuvrJLbTFht1D6dj++f3KLNMCw2GC++p2OplSooEKlGitb6C6TdjxuYVY0gDw
X-Received: by 2002:a05:6830:2b11:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f3de6b701emr7076896a34.15.1786730936267;
        Fri, 14 Aug 2026 11:08:56 -0700 (PDT)
X-Received: by 2002:a05:6830:2b11:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7f3de6b701emr7076829a34.15.1786730935638; Fri, 14 Aug 2026
 11:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
In-Reply-To: <20260731211601.3033906-1-zhipingz@meta.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 14 Aug 2026 11:08:44 -0700
X-Gm-Features: AUfX_mwlB-c_b12QUk9Eql1rFFrxjUSfBybDtwz-Rrjnzx4bowh7ua1IH4K-wTM
Message-ID: <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer access
To: Christian Konig <christian.koenig@amd.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEzOSBTYWx0ZWRfX7qutNDQSJgyJ
 vuYJiCzxi8TUj01UBNp973QsrJeeUFc5khD/PUsa0F3nYoMH6hh0fjcRVlRDxfp/x1seakx6XgH
 k3gtk7O/e+c2AhR9hRMxFo/xV9yPHqk=
X-Authority-Analysis: v=2.4 cv=GvVyPE1C c=1 sm=1 tr=0 ts=6a7f59b9 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=SJExgD-b2JMLU6q38FQA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: wPy6BF_0l61DCaPSukHJU_CssHJULDPg
X-Proofpoint-ORIG-GUID: wPy6BF_0l61DCaPSukHJU_CssHJULDPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEzOSBTYWx0ZWRfXxAYhblfYLp+R
 y7JlLtKPux8iveK6DfF227GJbd2iDZEWWgdqRRLxO7/OTTzoi5wYB5toF/rV3svP+pqXANN0l0q
 pRW65+SkhhlyZZvzXUNhwsnZGi2dolq+8eWl3h+HTOpWr0hg5HE5D6JCn6w2/W9n0oLJEscWZZv
 L4N+b6LUOEa5eBpBU/QM28JBleg4ilhrweHLQzpnYIL/zaZNpOhFFXwY8e1Oy9JNrFfoJ44Vo5/
 sZwyVXWK41eRnBFnaHbwfl0pSWkk2mle35Ykltsuwv3LHyX36p7eqXVKDLnJKc3TYYjG1umYfAS
 l6amKcOLYtyG7th/kQZYqCivRdXBTl1Ckz5lfmWIQOhJ189ffTq2AZAsLnfRF/Au00CD5W71rOa
 QUwy1Jcdn9yKGCg+0TzQZCXShXTbM87LYyMVKO+lHKBnxwZHEC3k6zP5JFZ1PWk9DQoWoOxfafS
 wXBCBJWKuojU/aqdhfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01

 Hi Christian,

A gentle ping on this series, especially patch 3, which adds the
optional dma-buf get_pci_tph() callback. Could you please review this
when you have a chance?

https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@meta.co=
m/

Thanks,
Zhiping


On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> export path, allowing importing drivers (e.g. mlx5) to use the
> exporter's steering tag when performing peer-to-peer DMA into a
> VFIO-owned device.
>
> There is no separate in-tree vendor kernel driver for the target device:
> vfio-pci is the in-tree driver and the targeted device is managed
> from userspace via VFIO passthrough. That is why the ST has to flow
> through a uAPI: userspace owns the device and its ST table, so it is the
> entity that can configure a meaningful value for a given dma-buf. The
> kernel-visible participants are still in-tree: vfio-pci exports the
> dma-buf and mlx5 imports it.
>
> On the effect: the endpoint's PCIe ingress block uses the ST as
> an in-band instruction for the incoming P2P TLP -- selecting a target
> cache partition and, on writes, an in-flight operation on the data
> before it lands. The dma-buf callback keeps this opaque to the
> framework -- only the producer (userspace owner of the VFIO device)
> and the consumer (endpoint block) need to interpret the value. The
> dma-buf get_pci_tph callback itself is optional, but workloads that
> depend on the endpoint's in-flight operation need it because fallback
> does not produce the same result.
>
> The dma-buf hook is intentionally generic and discoverable rather than
> a private side channel. The exporter owns the completing address
> space for the dma-buf and decides whether it can provide a meaningful
> ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
> and importers merely request the namespace they support and place the
> returned value on generated TLPs. Exporters that cannot derive a
> meaningful tuple simply return -EOPNOTSUPP.
>
> TPH is advisory: a steering tag that is not honored on the path (for
> example an intermediate routing element that does not forward the TPH
> prefix) is ignored and the request completes as an ordinary,
> non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefore
> targets the same-Root-Port / common-switch topology, where the ST
> reaches the completer; cross-Root-Port P2P is best-effort and is not
> gated in the uAPI, since supplying an unused ST is harmless and there
> is no discoverable "TPH routing" capability to test against.
>
> Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding into
> "not supported" in get_rp_completer_type(), so only architected values
> can reach the TPH Requester Enable field. It was previously posted
> standalone to linux-pci; per Alex Williamson's v12 review it now travels
> with the series, which removes the cross-tree ordering dependency and
> lets review tooling apply the series as posted.
> Patch 2 adds small PCI/TPH type helpers so drivers can query the enabled
> TPH requester mode and the device's TPH Completer Supported field
> without reaching into pci_dev internals (and so callers in
> CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_type=
()
> applies the same reserved-encoding fold as get_rp_completer_type(),
> inlined locally so the helper is self-contained.
> Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> metadata from an exporter under dmabuf->resv.
> Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
> Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces the
> dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid for th=
e
> mapping it was queried against, and the mkey's TPH fields cannot be
> reprogrammed in place. mlx5 therefore records the registration-time tuple
> and re-queries after each dma-buf mapping is established under
> dmabuf->resv; unchanged tuples continue with the existing mkey, while
> changed or missing tuples fail the remap rather than continue with a
> stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> because invalidation is revoke/quiesce, not movement to a new backing
> placement, and the userspace-provided tuple is not changed by the
> revoke/un-revoke path.
>
> Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> Functional validation on the target topology: PCIe analyzer captures
> on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
> P2P workload only produces results consistent with the endpoint's
> ST-selected in-flight operation. For example, with userspace
> configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
> peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> ST=3DF0h PH=3D2 HV=3D1":
> (TLP Captures)
> 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> E0200000 -> AddrH=3D000020E0h
> 00080006 -> AddrL=3D06000800h
> 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
>
> The dma-buf get_pci_tph interface has also been exercised by a second,
> independent importer: a different vendor's NIC whose driver is not yet
> upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyzer
> confirmed the ST it placed on outbound P2P TLPs matches the value
> configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result as
> with mlx5. Two unrelated importer drivers exercising the callback
> end-to-end shows the interface is not tied to a single consumer. That
> importer change is out-of-tree and not part of this series. For that
> second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D0,
> an analyzer capture shows:
> (TLP Captures)
> 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> 00170000 -> AddrH=3D00001700h
> 00200006 -> AddrL=3D06002000h
> 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
>
> Changes since v12:
>   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
>   previously posted standalone to linux-pci [1], is now the first patch
>   here (Alex Williamson). Sashiko could not apply v12 because of that
>   external dependency; with the fold in-series and the mlx5 leak fix in
>   linux-next, v13 has none. The code is unchanged from the standalone
>   v3; the Fixes: tag is dropped, since no code path can reach the
>   reserved encoding today and the patch is hardening rather than a fix
>   for observed silicon.
>
>   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
>   pcie_tph_completer_type() rather than calling the helper that earlier
>   folding revisions added; that helper was dropped in folding v3 per
>   Bjorn Helgaas and Wei Huang.
>
>   Patch 3 (dma-buf): no functional change.
>
>   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
>   vdev->pci_ops->get_dmabuf_phys, matching
>   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the feature
>   as supported on a device that advertises TPH Completer support but
>   cannot export a vfio dma-buf at all, so nothing could ever carry the
>   metadata (Alex Williamson, who raised this to uAPI-affecting
>   severity).
>
>   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index()
>   ahead of the pcie_tph_get_cpu_st() call, so splitting out
>   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation on
>   devices without ST support nor changes the errno userspace sees when
>   the _DSM lookup fails (Alex Williamson). The commit message now
>   describes this rather than presenting the split as a pure extraction.
>
> Previous link:
> v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhipingz@=
meta.com/
> v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipingz@=
meta.com/
> v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipingz@=
meta.com/
> v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz@m=
eta.com/
> v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz@m=
eta.com/
> v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz@m=
eta.com/
> v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
> v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
> v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
> v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
> v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/
>
> Zhiping Zhang (5):
>   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
>   PCI/TPH: Add requester/completer type helpers
>   dma-buf: add optional get_pci_tph() callback
>   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
>   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
>
>  drivers/dma-buf/dma-buf.c                     |  32 ++++
>  drivers/infiniband/hw/mlx5/main.c             |   1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 151 +++++++++++++++++-
>  drivers/infiniband/hw/mlx5/odp.c              |   7 +
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
>  drivers/pci/tph.c                             |  55 ++++++-
>  drivers/vfio/pci/vfio_pci_core.c              |   3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
>  include/linux/dma-buf.h                       |  25 +++
>  include/linux/mlx5/driver.h                   |  15 ++
>  include/linux/pci-tph.h                       |   8 +
>  include/uapi/linux/vfio.h                     |  43 +++++
>  14 files changed, 517 insertions(+), 19 deletions(-)
>
> --
> 2.53.0-Meta
>
