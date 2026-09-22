Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E451617D;
	Tue, 22 Sep 2026 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116345; cv=none; b=UVUgMOGxPFUyFAh1BtivZDGtt3T6ZN0mYqqOoPXrEOD8/AyumSwpDz92VrmHAj/Oh8efw1PkqDUu/cVha/BwYxA5iX2W75NltV1+ziRVLfB7VEsE1W7mFCU9gjlr8k36Nhczwf2iLzFvUywF5TrWEihig9g9RgZK1PogpGZdzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116345; c=relaxed/simple;
	bh=sfneKrQhaHxNg8WZvcEcZG+ZMFrl0h5LMA/trrtb8B0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNnCpREKu1BtYqdABNWWu/M88NetgEuesk+KKxccODd9rphPL94fyPg7NomheGvcIQ8sm3u+509r2dTPlwcRrUaOnQtk13xozwhp7cjLLKmCakL309oEXtZs/q1PvH4kDWtblWQygEylQS/QSRKoSHBN4fr9y6zCrM0aXw6kDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=seaPKjeh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="seaPKjeh"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68MKGo4V3257133;
	Tue, 22 Sep 2026 15:31:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=rUhSNgh6xkKzXRfnZvkgqfgLgmgpRqFkkByHS
	L6xMEI=; b=seaPKjehH1RDWeePDVQJYK6wLy6QHRZgifY6NHGbTUGRubuNZP/V8
	s7AShxnO4HGnk6fpqhLevZ6qA/L3GGZyMAbhUcXmsU3RNTpmQUs5NUuN1zmEOhCZ
	CMWMkIHRpM4SRYu8hoYRxBoXhZTvqT+3mAe2YEQyoP/ek5SDnjAS3bQ9M/cbIygB
	5VpJb88J+zhgQS5XSgULrWCeJY2/TfqRIuWau3b1R2eqr5rWnNpIOhZSOpMf5gUZ
	yk6rtg8IvZLUTuNAqspoag4cFm35jBaGayo4PCSbMFgqgEVIh3PHqUpQVh4zeB6Y
	kLObp6tTde3zWy2hzFktu6KeyrlW4lA4Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4gv0ju8y7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Sep 2026 15:31:15 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 22 Sep 2026 22:31:12 +0000
Date: Tue, 22 Sep 2026 15:31:07 -0700
From: Alex Mastro <amastro@fb.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>,
        Matt Evans <matt@ozlabs.org>, Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe
	<logang@deltatee.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Pranjal Shrivastava
	<praan@google.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Mahmoud Adam
	<mngyadam@amazon.de>,
        David Matlack <dmatlack@google.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Sumit Semwal
	<sumit.semwal@linaro.org>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple
	<apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
References: <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922125421.GE1507824@nvidia.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMiBTYWx0ZWRfXzPLaS+iN4E2w
 QW6c6EwXWytTAhiErmyUqlGtHjZg5ZdIGlcmGWYZZIaTVuUhwB6VQJoqghSJ/UZbyfo3bAf/0J3
 ZAO+/0ziTQ27AfdCYPj19uTXwA/Zau8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMiBTYWx0ZWRfX2afZujD+u/e9
 cIsEbY+FF7vFGgU3AzwIxbf6qiDAiDFmdWVp7nKUi1thq66Sk6frp3ZWI7drWX3jnGpg33SSz9H
 HJ24rffthstCHVGzgQ0aus8P1XGRjZ0WQA3Yj/cw8Dd17S777ubA8MOIuLG9/vVrtF4XQsyd9zL
 SNScG//fTzXlVN3yAmLZ1MKTqykzTJiHxiG6UtI/wIemZ6IoMDd1CZNATO0XvxZYqoCYE1LCaUW
 6BPsokPPvH/OXBL5pVRQp3WLEuM7pkna86h1S0Gf7GUAngqPSDonj0OwgJusFJl9GQh/7CdgXyI
 Ou9baaLG6m3BNHLI+n/WgoUeBkLIlEwAoVSo/4+hqN0tKsUKvhn72vvj3ae2xB4dlGJO3eLxfA8
 6xnSE42Vxyw8T/pBeohgAUeZfzMPOvDbiBiqy7hCAbGJbxyrdUOuBbrgVgZCTQd55o2CB/+GIg1
 6oWEKbCfVKNORGfGeeA==
X-Proofpoint-ORIG-GUID: j5N__OZvBdBCOoLpPpSZEXOVCzD292Fn
X-Authority-Analysis: v=2.4 cv=Is2L47/g c=1 sm=1 tr=0 ts=6ab301b3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=wdxqxBYYAAAA:20
 a=9ZocRCB3nw8SPkWSbdcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=O8hF6Hzn-FEA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: j5N__OZvBdBCOoLpPpSZEXOVCzD292Fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01

Hello!

On Mon, Sep 21, 2026 at 10:22:08AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 21, 2026 at 02:08:47PM +0100, Matt Evans wrote:
>
> > Not quite; the priv->revoked flag tracks temporary periods of
> > inaccessibility.  An example is VFIO resetting a function; the BAR
> > mappings as seen by the CPU and DMABUFs made from the BARs are all made
> > inaccessible before the reset, and made accessible again after the
> > reset.
>
> From the importer perspective this is a permanent revoke.
...
> From an importer perspective it sees the revoke happen and then that's
> it, the dmabuf never does anything further. The importer has to unmap
> and start from scratch, get a FD and map it.

That may be true for iommufd, but from what I can tell, already-imported
vfio-pci dma-buf can be resurrected after VFIO_DEVICE_RESET by other dynamic
importers (e.g. mlx5). That seems to be the case today, without this series. I
clanked together a toy program and accompanying bpftrace script demonstrating
this [1][2].

The program
1. exports a vfio-pci dma-buf
2. imports the dma-buf with ibv_reg_dmabuf_mr()
3. VFIO_DEVICE_RESET
4. ibv_advise_mr(PREFETCH|FLUSH) on the original MR. It succeeds, triggering
	mlx5_ib_advise_mr_prefetch
	 -> pagefault_dmabuf_mr
	 -> ib_umem_dmabuf_map_pages
	 -> dma_buf_map_attachment
	 -> vfio_pci_dma_buf_map
5. re-importing the original dma-buf fd to create a new MR also succeeds.

So I empathize with Matt's contention that the _existing_ behavior that the
priv->revoked flag represents is actually "temporarily revoked": the importer
can use the same dma-buf again, later, without having to re-import it!

What are we missing?

On Tue, Sep 22, 2026 at 09:54:21AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2026 at 03:46:37PM +0300, Leon Romanovsky wrote:
> > On Tue, Sep 22, 2026 at 09:41:37AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 21, 2026 at 04:09:18PM +0200, Christian König wrote:
> > > > >> I would avoid that and just re-create the DMA-buf fd from
> > > > >> scratch. The extra overhead is negligible and one way state
> > > > >> transmissions are usually much easier to handle.
> > > > > 
> > > > > Yeah, maybe we should have done that. Might be too late now.
> > > > 
> > > > It's already uAPI? 
> > > 
> > > Yeah, but Matt is making some changes here so maybe new stuff can
> > > avoid this. I'm not sure.
> > 
> > Jason, the proposed semantics is not UAPI yet.
> 
> What I'm talking about is, the revoke/unrevoke flow for a single FD
> was added from the start. For example vfio_pci_ioctl_reset() does it:
> 
> +       vfio_pci_dma_buf_move(vdev, true);
>         ret = pci_try_reset_function(vdev->pdev);
> +       if (__vfio_pci_memory_enabled(vdev))
> +               vfio_pci_dma_buf_move(vdev, false);
>         up_write(&vdev->memory_lock);
> 
> The false restores the exsting dmabuf fds back to normal operation.

The toy progam sequence above shows that both of the following are the case
today before this series:
- an already-imported dma-buf fd can come back to life after a reset.
- an already-exported dma-buf fd can be re-imported after a reset.

This series doesn't intend to change the behavior of either. Is the confusion
about whether the current behavior is intentional and/or desirable? If the
answer to both is "no", then IMO this series paves the way nicely towards making
PERM_REVOKED the only supported semantic later.

[1] https://github.com/opsound/vfio-tools/blob/9744d0f17edd67ad8eb21134ff75cdc2d0678bbc/vfio_dmabuf_reset.c
[2] https://github.com/opsound/vfio-tools/blob/9744d0f17edd67ad8eb21134ff75cdc2d0678bbc/vfio_dmabuf_reset.bt

Alex
