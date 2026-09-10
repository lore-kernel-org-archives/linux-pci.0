Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2A4718D6
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076814; cv=pass; b=Y9m60LrMV/6SVWmj1BIOa73k6I63g/SFM6Guvub/tQdjxS8MeEYLczQqNJCeyLg1JLpJD1LfrRhCJdXHQ4aw27dq1swMwHpG6KArnAThUEnabNKV5EVB/WxDBtKnU4/0VxbiUd0o3HKQeGaiTqSNPuoLqSyhC+KokHCFIxBhm18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076814; c=relaxed/simple;
	bh=NO2bgZl20DzU0Bgq7xjj2i+/SPiyMaontwQcgQjaffY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8c71MWRgXPTmwm4g/kZGEzFa3YfihoOSi4fLQAFroKo5LZ5XF8c5guMXVvPs5PNvB9XjbVoFdADhinK2wtwF1ysPHjf0MX87yAOT91Fnhty+izVeHfAwTJlDAj/+zjPPgcuoyNJoEV6KUoavFc/PQhW+c9sEBxfRADGe8QdjBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HSShwN0F; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HSShwN0F"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALUMnJ049384
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:46:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkar
	zOLMXI=; b=HSShwN0FrymjYG5qNRf0CMBfnhePNJV9y0JeJyI5jdqAaaq/PrPHB
	c1581E30p9GFnnazNniNb9sksl4p9IN6s3FpB8n7up87kzm1HdmtJNaRg7YjHZjj
	POITXyPedcLgbGod7tH/mBI19U+TksTWPmmdnJO93QYH+Nzzy9JRtgSH2+EDMTcK
	r51IwKg8yoT2rUT/JYPg4G7lZ7jYBKTSlFf0fuQj0f4G/07gH7L1PhOiSUDhnU3x
	D3n2XgY7dF2WHnVthLRlkq/9RPgJN5/Q9AJ1YHSNFDYFAt68Pt9JZkgQBY9QqBdI
	Kzgu+KX8UHDABADfyBZeLXxhMnBJUoyVA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gkcychwkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:46:51 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-80139a2495aso369477a34.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076810; cv=none;
        d=google.com; s=arc-20260327;
        b=ciAVhVVH1CWiZsrk7P8CT/pnywMqMQCRJrLZkWaNF824oK8K6Cv4tqoqnuXpLGt363
         CcorKR0ZdrpbG9Vzfht/lIOBaxeOIcyu0tVmAP0JsJjfAnQXNchkb90eAdjGVS6BlLJz
         JzrraJNhxjAxTtVUgsDp7iawQlas5GErMD12wSKBXsHCktGQvB99Gz9xysL3nFolKdlI
         XzQ84u0Ctjt0/XQxC5lZI1n6DV/FNy0tDVMjUA3VcBXJIMjEQK5cHeYgAN2G9x6lixlx
         gj1RPTKuwh0lXRLFX7yBdui+Fu5QMoiKehe5Ky51zJP4Bf7SAIeE4IWjz+6RCItMGzoY
         P3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkarzOLMXI=;
        fh=xsx2Y3wzLfTGoU7mnj/xIoNcY/UR98hJ3aidfs9hK98=;
        b=PUKw0YKK0piCBA2Z/qUK7Sj5y+OUcLQ2FAr8uEsMuM+OEysSGQd6od3wNSduitNh4X
         z8CIk5r9dUGXJuG/i3jVctBnHDTDFsv+HqY/yQdE2tdJmq7XVeJ5w/NW9OUGfDKcJ/NS
         t0ArUZL75/wuOzKhUPtndtoonKf3Wt/U6lAUSJPP7AQaJQ3Mb0lU0lVrbEWzBj4qbYlV
         wEpmXQYetItywvxDnd3eiKVSMSKSMfpQI5iJmh+BB4Est1ZyEs0v3U+k904W+pSTuBG/
         Liblu/ojdFyS910dcCBJyrZmosUe//O2BtkIASiHjCPIWxDoNUGGkCQeu6LSBtpdXLO0
         ZxQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789076810; x=1789681610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34rO3ZRR8/6lJeLn2tK/hPbU+iCzRxdjHgkarzOLMXI=;
        b=o4WyL96Bot7VyTIhoIZL8ae6+f6r3+J6CAhRWqYSYxjG8rn469998e9pDKZnlawagW
         FC0etI2/HNzMwSPa8bTt/iuWpNpklOjoZqjcJT6FoUZjoComuXQ6kp10KQ8b3uVTmcjD
         MpPLv/QKvrENO01yMwj3PfS8ZbpWjbSBAF5s8/7hlUFbvfzkAKudzUqCkS60eoSFovxT
         ZQ6vH3Cmopt4xx28+VOOYt/DMX4BBZSxuThY1hNo8eAM9b4Kl69iW9O1lXbw6rNgoaaE
         kp+SxDWevbFIX6eGnxgorpwFyf1EZYiyJOnIW+kz/RmLSdW9vP7/ekNL9Aufn87mhSAc
         hQcA==
X-Forwarded-Encrypted: i=1; AKwUvBwwCjzk63Js1yjtBRgrN3xM0lNKLFz3BItg6A3vnU3rbkFI0s3FdW+Xs02S77AqtQ0XjDpbGSO19wk=@vger.kernel.org
X-Gm-Message-State: AFuF++ne1mDqlA/DbYJdPnJsagxOnwQxV7tMdcD8Dbzkjnqsxpmc3XZ/
	iCldCRcqw3VygSR5Nt2Vr0AKK1G1za+VnCy/Rr4k8zZ0nenTx/q8ZnK7IAfBy7/8QeTjj59dm0h
	fk8XKKyWOJxb3umnnP3RcT6QYy/61MZDE9VWfunv5SDHR0dDr9mugn4LBcHZOzw/JeXeIxNRGOl
	KyYoMVpDnCmRCIipuyutdTN3RmVQHNVSRSn6ODoIj71qt39g==
X-Gm-Gg: AYBFou2pGURIUxzQnQ8HIovuAAv5X8b74+6sm0/X6aSBvKmK2dNp3Vzpn6EnMV1PaHQ
	ZKAFn6SvFP3YyGXedalV0L+3hv76W/CYGSE8/EVsfD5CWK7KaFxtNcIrhIjPomq4jfMwguzVszd
	OQd8oakz8kLx6MG2vjV9op08t7tnwfz/rX3+uGnjhtu1oj5OYZAy6+kduLklFOE3TTDHfeviLH3
	YBILaeTKrN+2s0ckb8=
X-Received: by 2002:a05:6830:4129:b0:7f3:7679:3957 with SMTP id 46e09a7af769-803ff332b68mr723753a34.10.1789076810376;
        Thu, 10 Sep 2026 14:46:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4129:b0:7f3:7679:3957 with SMTP id
 46e09a7af769-803ff332b68mr723727a34.10.1789076809796; Thu, 10 Sep 2026
 14:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
In-Reply-To: <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 10 Sep 2026 14:46:39 -0700
X-Gm-Features: AcwNN1U2vgRHKRn8sAdEsH5URCI9zdOW1d6Q2VaosXC6fruMYOU8HDIF5GUbJzY
Message-ID: <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: Christian Konig <christian.koenig@amd.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KZlHIgYD c=1 sm=1 tr=0 ts=6aa3254b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=LrQvNoTgmBG0NaGk8QkA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfXzTB4jCVyOmxp
 yFmVPTxpNwjO6QIXiekXz9TL662/jyOzEpWtySoWJ6168POp/mVBTYITojvxrBQDaOUvOaeMR5W
 K8lbIFO8jzkTjffdtjzOWjowuO+Wqug=
X-Proofpoint-ORIG-GUID: mWuRzY4mYONN21FHX2yoUzJJKEjMM2lG
X-Proofpoint-GUID: mWuRzY4mYONN21FHX2yoUzJJKEjMM2lG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfX7ZsexMIdEYjU
 M8FyojaEZkkqRtkpJq7x1y1DMrhDaYiq7+nXPIT9aoDYDSDPzhb1JTcoW3CXFTZHWFnnJOJMlnZ
 LP5IPCHQ/w972GTjuQm5/VwQpZzJI4fuQcs4rk9y4UYmJHIP28msE0NXzB/n1s0Etyt6COsbNEb
 daDn7++DVUbtRyDYPa4u2e0uNZyCSt9SbcR+j+1FIRGzxDjeMDZQyHkM3VOXEJxy5giYBQGsz5i
 wIafOeDX/tpaCKlPUzSexYIuaFfTqy0Bb/amvtrU28Qg0j7z4YdLstzFfFvXWRNQNASvL5X3Av5
 5gEvGkECWMuxzRvFIySYa644b9yDfqDtEl9BdEv0rcjQwsQp4NXKKlE8uOWBnPt7pnBaRgKMn9X
 WnVSPdbJTmSCPP0qb+uaEiH8ZDLU8VbhAcWU5MEcCGsPel03zCe6pZSyVQK17YhMujj7ztWt67U
 3g7jh117xUvNNe5hSNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01

Hi Christian,

Third ping on this series. The only patch still without review is 3/5,
which adds an optional get_pci_tph() callback to dma_buf_ops:

https://lore.kernel.org/kvm/20260731211601.3033906-4-zhipingz@meta.com/

It lets an exporter report the PCIe TPH steering tag for a
peer-to-peer mapping. The callback is optional -- exporters that don't
implement it behave exactly as today -- and nothing else in dma-buf
changes.

The rest of the series is settled: Chengwen acked patch 2, the
automated review is clean, and there are no open comments from v12.
Alex is holding his ack until the dma-buf side has been looked at, so
this one callback is gating the whole series.

If you have concerns about the API shape or the locking, I'll respin.
If someone else should review the dma-buf side, tell me who and I'll
take it there. Otherwise I'll check with Alex and Jason next week on
how to proceed, since 7.3 is in rc and the next window is about a
month out.

Thanks,
Zhiping

On Wed, Sep 2, 2026 at 1:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> wr=
ote:
>
> Hi Christian,
>
> Another ping on this series for your attention. Pls see below for more de=
tails.
>
> Thanks,
> Zhiping
>
> On Fri, Aug 14, 2026 at 11:08=E2=80=AFAM Zhiping Zhang <zhipingz@meta.com=
> wrote:
> >
> >  Hi Christian,
> >
> > A gentle ping on this series, especially patch 3, which adds the
> > optional dma-buf get_pci_tph() callback. Could you please review this
> > when you have a chance?
> >
> > https://lore.kernel.org/linux-pci/20260731211601.3033906-4-zhipingz@met=
a.com/
> >
> > Thanks,
> > Zhiping
> >
> >
> > On Fri, Jul 31, 2026 at 2:22=E2=80=AFPM Zhiping Zhang <zhipingz@meta.co=
m> wrote:
> > >
> > > This series adds TLP Processing Hints (TPH) support to the VFIO dma-b=
uf
> > > export path, allowing importing drivers (e.g. mlx5) to use the
> > > exporter's steering tag when performing peer-to-peer DMA into a
> > > VFIO-owned device.
> > >
> > > There is no separate in-tree vendor kernel driver for the target devi=
ce:
> > > vfio-pci is the in-tree driver and the targeted device is managed
> > > from userspace via VFIO passthrough. That is why the ST has to flow
> > > through a uAPI: userspace owns the device and its ST table, so it is =
the
> > > entity that can configure a meaningful value for a given dma-buf. The
> > > kernel-visible participants are still in-tree: vfio-pci exports the
> > > dma-buf and mlx5 imports it.
> > >
> > > On the effect: the endpoint's PCIe ingress block uses the ST as
> > > an in-band instruction for the incoming P2P TLP -- selecting a target
> > > cache partition and, on writes, an in-flight operation on the data
> > > before it lands. The dma-buf callback keeps this opaque to the
> > > framework -- only the producer (userspace owner of the VFIO device)
> > > and the consumer (endpoint block) need to interpret the value. The
> > > dma-buf get_pci_tph callback itself is optional, but workloads that
> > > depend on the endpoint's in-flight operation need it because fallback
> > > does not produce the same result.
> > >
> > > The dma-buf hook is intentionally generic and discoverable rather tha=
n
> > > a private side channel. The exporter owns the completing address
> > > space for the dma-buf and decides whether it can provide a meaningful
> > > ST/PH tuple for that completer; the dma-buf core keeps the tuple opaq=
ue,
> > > and importers merely request the namespace they support and place the
> > > returned value on generated TLPs. Exporters that cannot derive a
> > > meaningful tuple simply return -EOPNOTSUPP.
> > >
> > > TPH is advisory: a steering tag that is not honored on the path (for
> > > example an intermediate routing element that does not forward the TPH
> > > prefix) is ignored and the request completes as an ordinary,
> > > non-TPH transaction (PCIe Base 6.4 sec 2.2.7.1). This series therefor=
e
> > > targets the same-Root-Port / common-switch topology, where the ST
> > > reaches the completer; cross-Root-Port P2P is best-effort and is not
> > > gated in the uAPI, since supplying an unused ST is harmless and there
> > > is no discoverable "TPH routing" capability to test against.
> > >
> > > Patch 1 folds the reserved 0b10 "TPH Completer Supported" encoding in=
to
> > > "not supported" in get_rp_completer_type(), so only architected value=
s
> > > can reach the TPH Requester Enable field. It was previously posted
> > > standalone to linux-pci; per Alex Williamson's v12 review it now trav=
els
> > > with the series, which removes the cross-tree ordering dependency and
> > > lets review tooling apply the series as posted.
> > > Patch 2 adds small PCI/TPH type helpers so drivers can query the enab=
led
> > > TPH requester mode and the device's TPH Completer Supported field
> > > without reaching into pci_dev internals (and so callers in
> > > CONFIG_PCIE_TPH=3Dn builds get a clean fallback). pcie_tph_completer_=
type()
> > > applies the same reserved-encoding fold as get_rp_completer_type(),
> > > inlined locally so the helper is self-contained.
> > > Patch 3 adds the optional dma_buf_ops::get_pci_tph callback plus the
> > > dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
> > > metadata from an exporter under dmabuf->resv.
> > > Patch 4 implements get_pci_tph in vfio-pci and adds the new uAPI
> > > (VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadat=
a.
> > > Patch 5 wires up the mlx5 RDMA driver as a consumer. It also enforces=
 the
> > > dma_buf_get_pci_tph() steering-tag lifetime: the tag is only valid fo=
r the
> > > mapping it was queried against, and the mkey's TPH fields cannot be
> > > reprogrammed in place. mlx5 therefore records the registration-time t=
uple
> > > and re-queries after each dma-buf mapping is established under
> > > dmabuf->resv; unchanged tuples continue with the existing mkey, while
> > > changed or missing tuples fail the remap rather than continue with a
> > > stale hint. For vfio-pci BAR dma-bufs this is expected to be a no-op
> > > because invalidation is revoke/quiesce, not movement to a new backing
> > > placement, and the userspace-provided tuple is not changed by the
> > > revoke/un-revoke path.
> > >
> > > Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
> > > Functional validation on the target topology: PCIe analyzer captures
> > > on the P2P TLPs confirm the ST emitted by mlx5 matches the value
> > > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-en=
d
> > > P2P workload only produces results consistent with the endpoint's
> > > ST-selected in-flight operation. For example, with userspace
> > > configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer=
-to-
> > > peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
> > > ST=3DF0h PH=3D2 HV=3D1":
> > > (TLP Captures)
> > > 08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
> > > F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
> > > E0200000 -> AddrH=3D000020E0h
> > > 00080006 -> AddrL=3D06000800h
> > > 90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-
> > >
> > > The dma-buf get_pci_tph interface has also been exercised by a second=
,
> > > independent importer: a different vendor's NIC whose driver is not ye=
t
> > > upstream, locally taught to call dma_buf_get_pci_tph(). A PCIe analyz=
er
> > > confirmed the ST it placed on outbound P2P TLPs matches the value
> > > configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, the same result a=
s
> > > with mlx5. Two unrelated importer drivers exercising the callback
> > > end-to-end shows the interface is not tied to a single consumer. That
> > > importer change is out-of-tree and not part of this series. For that
> > > second importer, with userspace configuring 8-bit ST=3D0xe0 and PH=3D=
0,
> > > an analyzer capture shows:
> > > (TLP Captures)
> > > 08200260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D1 Attr=3D0 L=3D8
> > > 4E00004C -> RID=3D4Ch:0h.0h EP- Tag=3D4Eh
> > > 00170000 -> AddrH=3D00001700h
> > > 00200006 -> AddrL=3D06002000h
> > > 10E00000 -> OHC-B ST=3DE0h PH=3D0 HV=3D1 AMA=3D0 AV-
> > >
> > > Changes since v12:
> > >   Patch 1 (PCI/TPH, new to the series): the reserved-encoding fold,
> > >   previously posted standalone to linux-pci [1], is now the first pat=
ch
> > >   here (Alex Williamson). Sashiko could not apply v12 because of that
> > >   external dependency; with the fold in-series and the mlx5 leak fix =
in
> > >   linux-next, v13 has none. The code is unchanged from the standalone
> > >   v3; the Fixes: tag is dropped, since no code path can reach the
> > >   reserved encoding today and the patch is hardening rather than a fi=
x
> > >   for observed silicon.
> > >
> > >   Patch 2 (PCI/TPH): inline the reserved-encoding fold in
> > >   pcie_tph_completer_type() rather than calling the helper that earli=
er
> > >   folding revisions added; that helper was dropped in folding v3 per
> > >   Bjorn Helgaas and Wei Huang.
> > >
> > >   Patch 3 (dma-buf): no functional change.
> > >
> > >   Patch 4 (vfio/pci): also gate the DMA_BUF_TPH feature on
> > >   vdev->pci_ops->get_dmabuf_phys, matching
> > >   vfio_pci_core_feature_dma_buf(). Without it PROBE reported the feat=
ure
> > >   as supported on a device that advertises TPH Completer support but
> > >   cannot export a vfio dma-buf at all, so nothing could ever carry th=
e
> > >   metadata (Alex Williamson, who raised this to uAPI-affecting
> > >   severity).
> > >
> > >   Patch 5 (mlx5): keep the !dev->st early-out in mlx5_st_alloc_index(=
)
> > >   ahead of the pcie_tph_get_cpu_st() call, so splitting out
> > >   mlx5_st_alloc_index_by_tag() neither adds an ACPI _DSM invocation o=
n
> > >   devices without ST support nor changes the errno userspace sees whe=
n
> > >   the _DSM lookup fails (Alex Williamson). The commit message now
> > >   describes this rather than presenting the split as a pure extractio=
n.
> > >
> > > Previous link:
> > > v12: https://lore.kernel.org/linux-pci/20260715204008.3911275-1-zhipi=
ngz@meta.com/
> > > v11: https://lore.kernel.org/linux-pci/20260702181025.2694961-1-zhipi=
ngz@meta.com/
> > > v10: https://lore.kernel.org/linux-pci/20260630224328.3218796-1-zhipi=
ngz@meta.com/
> > > v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipin=
gz@meta.com/
> > > v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipin=
gz@meta.com/
> > > v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipin=
gz@meta.com/
> > > v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipin=
gz@meta.com/
> > > v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipin=
gz@meta.com/
> > > v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipin=
gz@meta.com/
> > > v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipin=
gz@meta.com/
> > > v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhiping=
z@meta.com/
> > >
> > > Zhiping Zhang (5):
> > >   PCI/TPH: treat reserved 0b10 completer encoding as unsupported
> > >   PCI/TPH: Add requester/completer type helpers
> > >   dma-buf: add optional get_pci_tph() callback
> > >   vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
> > >   RDMA/mlx5: get tph for p2p access when registering dma-buf mr
> > >
> > >  drivers/dma-buf/dma-buf.c                     |  32 ++++
> > >  drivers/infiniband/hw/mlx5/main.c             |   1 +
> > >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  11 ++
> > >  drivers/infiniband/hw/mlx5/mr.c               | 151 ++++++++++++++++=
+-
> > >  drivers/infiniband/hw/mlx5/odp.c              |   7 +
> > >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  52 +++++-
> > >  drivers/pci/tph.c                             |  55 ++++++-
> > >  drivers/vfio/pci/vfio_pci_core.c              |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c            | 120 +++++++++++++-
> > >  drivers/vfio/pci/vfio_pci_priv.h              |  13 ++
> > >  include/linux/dma-buf.h                       |  25 +++
> > >  include/linux/mlx5/driver.h                   |  15 ++
> > >  include/linux/pci-tph.h                       |   8 +
> > >  include/uapi/linux/vfio.h                     |  43 +++++
> > >  14 files changed, 517 insertions(+), 19 deletions(-)
> > >
> > > --
> > > 2.53.0-Meta
> > >
