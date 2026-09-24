Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AE39D6FC
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231111; cv=fail; b=W3axfNZVpldwMnu1zCWH4i547sOH3aLSQ7MI6q8T6Rj1HdQMpRJP22dBFoAJSuGXmQXf7VUrjnZ7eYwYbQHsYdqqQjT4yghb6hWrHRAA2Yc1ef3NIHZLn/knXuFQ4IyPvBJMPI+omuN03QkxnLsYjOfGUmotfjZFHqcs9f1T0uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231111; c=relaxed/simple;
	bh=dumiTwGbMEgraHXzScODaqcrl57xN/pkOOLYCcmVuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdTJqd63ypd92AUMPqHg8UvjBOi8r0HDoTdvJYfGqSTtEYgOqRV6lG5A2cE2iKlIgoTbfDbVTBmlTip44RhkJ6zadyYi9+9aROGDCb6WP+5uvFkKoM4u0bRAQ2mn8Ohfa/CXdKZgd5nA18870FwY9drKiVDO3q78szrqGPfWWMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kVpR4J2c; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kVpR4J2c"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5eKaW3994961
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 23:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=dumiTwGbMEgraHXzScODaqcrl57xN/pkOOLYC
	cmVuK0=; b=kVpR4J2cMlHzqIDDgIwDNRJKn8dds0XKZoAj3OuhpAobjcceNl0Bu
	lbg5D+lbA8CbPmTwKFk7+P9ILanDRGAi05aIxnTFuZ43UVMM/4+qDIBkN6C9YRFG
	IHueetZOt54ETnH+qsE4FIKotfPKQDH8rt4NVkm1+3IL6jolTyEOLLwJmpBn0uju
	gZkmJJjhBdcR/w50XWF7pn04IJiaJvS+3p3s6euzs154NtYbjvGfGPrlSbJ7kNRv
	rLyGbzA42lxnnIsp7gJ8tDUTh1gq3l85Sch1Tuo75/IOWkwLClaKgleRjE3hVug1
	TUvXeAqjqctf8mUTc4IxwuMOWegiHDbEw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gv48buhca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6c2d5235ac3so880568eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790231108; cv=none;
        d=google.com; s=arc-20260327;
        b=GRtJqu7GgghNVids2NxTLiISDq8o3IiNWv8nBzUSjT0tEmZukWYgxP9v6Q2FdkeVo3
         4Z43OHmMTGA/Om+pD7EFmqFycMLMxKDltWx1rptRiAEP06ISsuhp7qN39zLLxZUrlOwX
         Vuu75RiU3vGT6cjVjbhVxZ4ensEpclbyvW+n8y59pErVsxsne43pWegLn9fy9YicjDgg
         rVXT729dSGr6rkYHHn5YCoyvADrRH0VTGuFFI9wjF8iT7+1HY84eIpiKZ/Bc/njt06va
         gH/NxYnRIMoNpDrwcdrOfIk3niktQlC9OGt7qkGFyIwYH6di2Y1QzN5QlmIYNHm3OpD3
         p1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
        fh=FLoHY1sYc7Kz5X1Kg9czKGKDYshg+WLWFBSEaH1dUco=;
        b=OTvwBTZhsI1ooYqHbJTCy5YiAlsuGNtWEg6QNO9q+b+UbLNEru9EixW7cOCZCgJpSV
         nSbpSD91cLfuQAPoUQVB6ojNP5Yu8a+XXwBewq5QcIf4EgMsCLiZpMwkkE24MFz9dPx8
         BoOdg4FoYy2F12ZnS1I7HWQYCWvJNho59mDBsQnz0glODtBDLuAsEz2YD2kdQ/g+H5XB
         xgfQEGy0ZuKEyM7N5QB5CO1Mb9e8fiir2PBcluF12Go+xfO/Y70ygU+6Sf5rczcZCcs2
         F7BaCfL4WqtTfq5Vr0VVxjE/3iEBJ9naRI0r14FOE6FytrGu0owKoITRFVSWuWCTbpPF
         7zFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790231108; x=1790835908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
        b=oWzL1BCCyK8DZmZGV2ShpkJc1vO77J+g5WEhFQmeH6I+99Flv9PsloZur9X/05diRM
         QRD5SOdAUhbu6MA9WJFJTNrIniKlVi7uZvAtQWx609lpylYM26rLWVyRl4b8nuw9M2yo
         YH2IxtPrUzSJPigfEe9ipujJQtcMyRPhq8co+pdDItIgAFJ6/h0K9tE8Xfjtlt4mTSCc
         7thqVA/Yb5fyfK4+wcGderr7hJ2TI7hCHVOfNPRmWp+xW3P4E9qtx8cGMBZvqUZT0HzA
         xsKGLnveYMwuhJIIdEj60o4n5HsX/jMZWQmZOY03Mu+xLN2HE8OWyxSQCD9krWP/h3xC
         06Ag==
X-Forwarded-Encrypted: i=1; AKwUvBxab4x52PDpyvAhgbN3QKJ105M5NuRoBMBzAGat8DuW8XjVh/HxkO9NHthmln98vwUeBgGMGBnAp90=@vger.kernel.org
X-Gm-Message-State: AFuF++lHPEUjvyyQAcM6aXoZYaflZm/wb98F6h3AF6o8evhnZ+80CVSb
	fKF8S9yJnRGUeM7E0CoUhedXgaXOy9JsGA8mBfFzhHzxumef5AB+X0wShcl+7Yd2LP93j5wcCbC
	6Aac7O5jJKXnREEpG4tvP8ddGbCtgPjdezU1r2y4cImHleptrv37AG0mFytw7utyZvFbHTyma43
	vizN+Y6Y8gonaXobET3LnavZtWkKNEeKEsVwU=
X-Gm-Gg: AYBFou314Va1ZrkANmyL+qOEP06bhZap8ZxVmKIGfrOUDEkf/m19ITGXKH6gGgChed6
	Ay6m+FVAOboW2Gk38rWAlyyMx8ihQqMCdI6kiI0Z+YeOsPGZ9U1Bc1yizp0rqLEQSATPfIA3edl
	hc8tM03rc9pAP/IqOcQqaJjM9rYKcFLN8S2iEOyPmPPQZWxaJLaQepUWnIZbCUXjQA8d0iRSgvr
	2yiJC1Ff9TyAvYbS7g=
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id 006d021491bc7-6d43f4b92f1mr1105071eaf.23.1790231108072;
        Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id
 006d021491bc7-6d43f4b92f1mr1105058eaf.23.1790231107597; Wed, 23 Sep 2026
 23:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
In-Reply-To: <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 23 Sep 2026 23:24:56 -0700
X-Gm-Features: AclHuK8ihUvHi9sCYY6U80mehJKIocBbXx4TYk849EeeC-OYipx5xqfc_idP75U
Message-ID: <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: iS10C6FUjyLS_l8yPk2q5QQOSlV_K0Za
X-Proofpoint-ORIG-GUID: iS10C6FUjyLS_l8yPk2q5QQOSlV_K0Za
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX8TYskLXK47m2
 2jIMR91kzBUeUEbL1l/O5MZy8eIMv61OYgnGDU3QLpbs1/2xL+4VyZ+6EKB44KdfVzl8RiiPARw
 Oat7dn+NreEt+Kh8z1d7A7IwfBkH0LTIFcSFPxrCtKH/2TXDLDgBbCPviMYfHUjYOjxD2v4Ee2F
 EEP9PyPtOh2aoBQY0MVul838HZv4Fb3/nobU5DiDluiSZDIb1NhXZc+HjW37udJ9gq7CSdpACVT
 Pjg7yu1P66Pycw4xzpRXEwb13cxQKcYZnPLjKU2FO+zrj+8XmIA4UGJVTxDssDFyXngOzILU+P0
 KjM6h9o4XFqosjxMSCKVlQVvoTLpjkhru68CsLRTZ7LgxfcUOUXqISJYv3kr636voY1RlSL/a17
 7rDSgNrnPB5rmpjajCqk+jEsWuk1CVM/egCVceS+qAh9y714bVJzFbMhxg6gvaAM/ljSV4dsI4Z
 5aNdguwqfvjIsW9xyfQ==
X-Authority-Analysis: v=2.4 cv=MtzHeGae c=1 sm=1 tr=0 ts=6ab4c244 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=i0EeH86SAAAA:8 a=L1Z5B5hNzKdfmK81vbcA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX8qvRccwHtCwM
 xe3DM6ldiWwtMXmcKWZbTdenOBg8xLusDxLiRScCdudN/x6KhFSB9Dr339uocYBCGsnDemB0NCZ
 ktLcn45n2Gxdx0hCQkitt7Wv7BWz7t4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

On Wed, Sep 23, 2026 at 6:13=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 8/1/2026 5:15 AM, Zhiping Zhang wrote:
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
>
>
> While working on v21 of the VFIO PCIe TPH series, we got review
> feedback that importers must add pci_p2pdma_distance() validation
> before retrieving ST values from a dma-buf.
>
> Your mlx5 patch follows the same importer pattern =E2=80=93 it consumes
> dma-buf TPH metadata. I think this patch should also include the
> same distance check.
>
> Thanks,
> Chengwen
>

Hi Chengwen,

I don't think this belongs in the importer. Every in-tree dma-buf
caller of pci_p2pdma_distance() is the exporter, in its .attach,
clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
habanalabs memory.c. There is no importer-side caller.

mlx5 also can't be one: pci_p2pdma_distance() takes the exporter's
struct pci_dev, and an importer only has a struct dma_buf. Reaching it
would mean introducing PCI types into the dma-buf core, which is what
Christian's ack on patch 3 rules out.

The routing check is already enforced by the core before any p2p DMA
can happen: vfio_pci_dma_buf_map() goes through
dma_buf_phys_vec_to_sgt(), which switches on
pci_p2pdma_map_type(provider, attach->dev) and fails -EINVAL on
PCI_P2PDMA_MAP_NOT_SUPPORTED -- the same calc_map_type_and_dist()
computation pci_p2pdma_distance() performs. An ST that mlx5 programmed
into the mkey cannot reach the wire unless that mapping has succeeded.

Thanks,
Zhiping
