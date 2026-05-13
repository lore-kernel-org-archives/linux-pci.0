Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8F3D45E9
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654271; cv=fail; b=rOSdnzv2FT/h8AHNQ9lSEutqN9CilBwtD2kWZzwoMzELxtMw10ZlO55Ko/K0ruRyt0WAP2bx4mPhTrfbnPYKqIv4THbKifh20r4E4VmKOXxHHmFgnHWPrgfgudqijdhuMHhtEq5QC3s5Art5vN0txNx34odLoiIoXDas9eIFYYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654271; c=relaxed/simple;
	bh=ldUUL5LvKKg8pO0Cs/L34kXovzIocX5yA8E+TJKLni0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk2AtVdccZERNT7nRIYBlouOzIKvBuuqHqO66OXkehdSDnORcv6c70ap7MSZYeOn/SfAfzlfvsyjIv55sVEy1ABCYL52q6amOiZgDKBKGYwr9DlJaBYUyEsZLF0XVbojvadOfeLf8DZUt4RQyFjl75uk77OKowgqREO8r7RbVDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vpMyG/0T; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vpMyG/0T"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CMePWH3658772
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=LAM65dsmKstrNrOI5lpRjp6+6YUiNRddRB1paFn5Tj4=; b=vpMyG/0TqYlK
	FWur0gKHVAvJLoyN0BSGdH/as0387H96++tNCUt3QXLPzIH8p4iQVhoAWfqG5rIL
	PJ8R14LbD6TgPnBJVBKbPpbdVILQkJgwZKS+0j92/oMcMMWJ6YSQw55sVRvWsjnv
	BK/NZREMWIfqkQkozj9BcGNXRWm9pg4/DgAPmrQfwhM3YcV7+5PrtgRlcs0tQ6Iv
	2sv9r9VJfHH/yIJi1TSk1Tg8YBNDS6675+5PvwhHEKsVCveXe4BTBOJndjzhI9G3
	GBkVoYXXxprMnmmG/IdN4YW+qAjnw0hImptu3z2Tk3hWF9aSB5AQvuc7ytezl1l/
	OsvLiBRgJQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvrx78y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40f25e55f20so8891969fac.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654268; cv=none;
        d=google.com; s=arc-20240605;
        b=LSBuI/LpORrlcjATtLTT74g8+XnQjyBFqT8RWlW2KRJtXaPhwABtwDVBDAlzBNUKl6
         ctdp2aEEYFMA3WBSWsXYv9bCp6QmYr2NKbAXd+SDk7EpPNsbpaOY0RfVkhNPfHJf4ctU
         vqtfXmbj87n9l+dSd2lgkwSc9jLAXrKjb9k8Nagx+gv70+r38Xq3C1rUtavyot/qafMi
         2m/8l2+L8MIHNXlXVbCYRAJCWvL0/nLYayaosYra7b4OF0IZKTMlchuD1Hxoo83i8vM+
         X4C42VKz9qyLfchye0AQ0Tb9OUfNPfPHJPTu+DCyQvwHa8c0xvFmHeeW5IPCLsWaHX2n
         Dffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
        fh=rV64QSXpflMLaKP4TKqwJtz0YuE/9Wnf86zLJ+6AD2c=;
        b=Ao7ycBZC4rqwv7maWdmekf178oT7d38oevvikfbb10VzvnxPuqjczOdUHSK2gImqRS
         sTNCSYdJoHwjfOluhx8wP5M3ijfjPbdwuukVaCjZxHEwk6y1tEn0sYP28gVVeAHDMsoM
         LVqvGe1S7JIOrcVCWRxwTuktpsZdfIicK8pfPyibvSWDWqPGrLlU8bDGbGrX30mX3uMA
         3qRuRhYHSTDTXQE892495ukEBetul3jrkois1VWeFfjJCpjJtAQd27LHCalDN2Er31ce
         RHgVoSxm12xIOT3msCFONdalI4NdhJGCzQxVtjfmTPIg6+g9XsEpvu933DRAz16NtC7z
         Y+QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654268; x=1779259068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
        b=RzaQC2Bs6m5XXv8uWG7Enq2VmDHONA+u5ACHNBwU0KoZRUCG9dzAXs7zYoLYn05sbq
         VbAkVW4Ox5vwn8lCFCNsgh0yQbOhssPDw3Q2Xbzdm0L5cWv6lRn/3JJD1AGNmxn7/5xT
         vCTXk+/eLnrt3ea6U9uktRJDiWwrO7GDpXibm04wnmd4VmkbiMk8bgEBrBf7F01xSY14
         ARL4G+0Xwu3yrNgdyK+DHqPpABPnLOJk+Q0aZPbsN1QlH06DQy7gOssOQ76XpQXwoUrU
         i++XAgYUrk+QJebXOPAv5LfMd6BtsieLlFBU5cL3bn/kY63RMb8TjSRasEF3DRAkmXGD
         08xg==
X-Forwarded-Encrypted: i=1; AFNElJ9strRYIXJK/f0b+kl6rn7PAWYxMkGFV+/bTJxPrI0v+Be/44EY42GzViViyoXCqgEt/WQDlhu5C6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjVasoEJJ5AlZRCkp9PKtcrbYGm4c0dv0dkiOm8CSAj9cl/hg
	/5p4A/a699+GTmEAakst65tEIpWZJPJc3b441ZcQ9VU+jtNgev/9BcpR1Ww1tRNChznSvR3k/RK
	WehLQcmDG17LVpBC/KJZ18R/2mu6MoJgVeFUdTahBp1QogyJhacmA6GLyGboyzLoFsQLgbqnA6C
	yPVVdeH4GjI9Gx4XpKdCelOBntrhKNHdlPij8=
X-Gm-Gg: Acq92OFgXFOF+KIuXiLQvI4ysB1dPH8ocrEQGE4mbvZR7fTFrwORgHTk4RvXEU8sKEk
	RYnzKgZvKt4tKMLXujUun1DUdBBNKxVMDzQpIabtYBXoMrmUxNBbQ9M5qi8ZELSRN5/m6gISyHv
	ji+Pbe34PniFBgKGeMQrYy6jk0Ma65lx3vW4YXHTCaVb7l9gL1btKOwqTEjGApaJlNQznuRM+Pt
	m8bItArcU/24u9toiyBNHW20SHAxszQWUARbiPi
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id 5614622812f47-482b28c375cmr1554311b6e.7.1778654267561;
        Tue, 12 May 2026 23:37:47 -0700 (PDT)
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-482b28c375cmr1554304b6e.7.1778654267114; Tue, 12 May 2026
 23:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com> <20260512184755.4137227-3-zhipingz@meta.com>
 <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
In-Reply-To: <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 12 May 2026 23:37:36 -0700
X-Gm-Features: AVHnY4KQd48YcOfbXPjFCGlTijSz26BhC9fVFq41RkqL4K2-2maS91GmCZxuWQI
Message-ID: <CAH3zFs2V_EENYzq+MRbSV_XPqz99xzA1V=Yc_GpgjGxxt41quw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a041c3c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=xwbcgjOLmlna_7dmNJkA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: f5zdCu4svZB_aDb2iJgUVrM4EJVs28nC
X-Proofpoint-ORIG-GUID: f5zdCu4svZB_aDb2iJgUVrM4EJVs28nC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2NiBTYWx0ZWRfX9LHzKcqDTpLz
 4PRTdZdp6RKxWs4Q+tykeQGIvatlB5Tk5BpVJ8TXXjRDBlnsrglRFz+kvoTKIYh/n6nuf7jDOe3
 6MWVQQr+w81dzCtqquascMowIQBCsIBy/aVGOziR+XlXEPf7Gu0edXstIG1lTTi/QGoE0giiGs5
 NP+hVSsArkrZmF3IW/sBSLGzOOzVv8gty3yUB3C5kpEqzgRYf5V/aAh06DVv52VVgIK9BY66wA8
 xz+VNBgK6CbOX2NNdfbK+7hdhA9yxP6k7SQjPRlskS4ZxTGDFrxYy2DELH0VVBvWCaI35RIYhxo
 qJ6cJdxIz67CmFo3fhF7SBYh2UYlgH1lNOxMoOPky4wd3wsUNKj9INXxAggAPY9phTvYmAsTmdC
 DeGXCkUkks34oQPIOmeu1csKzIJpl35tFgVycZQlTB7eiaLgze2braFhAkS6bK3M6Vyzyon3SDW
 HCJmCWYqfgr4PoP7bEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01

On Tue, May 12, 2026 at 6:49=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering
> > tag index. Factor mlx5_st_alloc_index() so callers that already have a
> > raw steering tag can allocate the corresponding mlx5 index directly.
> > Keep the DMAH path as the first priority and only fall back to dma-buf
> > metadata when no DMAH is supplied.
> >
> > Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
> > device's negotiated ST width without poking pci_dev::tph_req_type
> > directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
> > break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
> > get_tph() callback so the exporter can return the value that matches
> > the consumer's capability.
>
> 1\ Recommend the PCI/TPH modification be committed separately.
> 2\ How about rename it to pcie_tph_enabled_req_type() ? so we could
>    use already defined macro:
> #define   PCI_TPH_REQ_DISABLE           0x0 /* No TPH requests allowed */
> #define   PCI_TPH_REQ_TPH_ONLY          0x1 /* TPH only requests allowed =
*/
> #define   PCI_TPH_REQ_EXT_TPH           0x3 /* Extended TPH requests allo=
wed */
>

Hi Chengwen,
  Thanks for the great suggestions.
  1. Splitting the PCI/TPH helper change into a separate prep patch
sounds reasonable.
  2. I see your point about exposing the enabled TPH request type! I
want to take one
      more pass over the overall flow and switch to that if I don=E2=80=99t
find any issues.

  Zhiping

> >
> > Pass the dma_buf pointer that the umem already resolved into
> > get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
> > Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
> > different dma_buf between umem creation and TPH lookup.
> >
> > Track the per-MR ownership of the allocated mlx5 ST index on
> > mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
> > firmware mkey no longer references it. Both the cached path
> > (mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
> > destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
> > not leak when the MR is reused from the FRMR pool.
> >
> > Initialize ret in mlx5_st_create() so the cached steering-tag path
> > returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
> >  drivers/pci/tph.c                             | 20 ++++++
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  include/linux/pci-tph.h                       |  2 +
> >  6 files changed, 124 insertions(+), 10 deletions(-)
> >
>
> ...
