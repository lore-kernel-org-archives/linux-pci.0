Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CD4AA584;
	Thu, 24 Sep 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271534; cv=none; b=Xy/I07BiOIDK+6pYcdRG4z0a1tyC1PRmWG2p14DFHHHgTkIPYWtk8d71Ex8kJZ1eyOdsPGeaG38OupFGjwKocAFjqAQ2OYyyYH6pBmR8llx/OC/cF2d/3TDVH8FwtUWP8OdG9SEX/jyoI5iNSv/gaUqpS25vFgQLzDgoKLdeq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271534; c=relaxed/simple;
	bh=rJGQhScDlm4viXbVZ7shrmQ3zSbjwRLrRCBRfunXrfg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJMdgnWDs/lcGAmrtDRtwagk6UXpltEuUKmZyn8yUagA6ugOZDrts/+rhXlwu9O3Dlspy5y1njA0aT3jQmA0w0DaXkArRq/HRZR03n83JVH4UXATWyIw1iJ+9D3iWOQStKbNHyyETP/i02kvYt85oM288n2KzI3D8LHQZdfF64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=gZ9ucYdQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="gZ9ucYdQ"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OHbefX4067247;
	Thu, 24 Sep 2026 10:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Sefxfty+V4i
	m33wCDgAoUq/8QqcJdthnNfNfWvLoo4E=; b=gZ9ucYdQWtAYNRopvqTwpqnLSU0
	WmEcrgSsEq/Az0a9wxHyh4xTkfsDmJsGXgLXhKBJzc5NSWTZdt0v36zl5yxsKuzH
	5Pq2jLBkZBud9aQfOMpzFhqEmie8HKD5RMmJnvzbnUHpEkVbd8kYRX1JEPt9QHm6
	MBEAqKcN8S0TOUfIUW4qC/vHY/LNUL+jZU0VWGnOK7ztO5B/g2qcqD595qQvhyzM
	R6FWZNSgrPS5MjsPfKyz3J7nD5w1HyahjAFROjpPYVGt99SEWq3lN6AVXKgYmZ5R
	bXnE83Apv1/JmSdJH4Ouu4DhOg7mH79arq/d5n67a10aSocQgVlT/7CDlxw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gw2rak5es-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Sep 2026 10:38:07 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 24 Sep 2026 17:37:00 +0000
Date: Thu, 24 Sep 2026 10:36:55 -0700
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
Message-ID: <arVft6rx/229Wpzi@devgpu015.cco6.facebook.com>
References: <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922225747.GB2545495@nvidia.com>
X-Proofpoint-GUID: 8_KIxvJ0Xh6Md9vvXsM8iI1MtB2e0u6D
X-Authority-Analysis: v=2.4 cv=RPsmjIi+ c=1 sm=1 tr=0 ts=6ab56000 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=JAa8dMmPYHYnztAqrSEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3MSBTYWx0ZWRfX3etaKYOhjUnb
 ZasjvyWE6UTsxvvjfFlXYr2xAM01fizk7c52wCw05iTDYA3kb+N43QzOlATtS2Hdm7ETaj4TqYS
 RGKrRBUTptoPenVLNhdZCqif+dSkLHuxCZxHb/auJJvnJ0/eLKoyxoDABar3MB+ZB2GscRXvYWj
 uGfBQxd16gKYZsr99ukT4l59Uj7EIERcjmyRyhI5A/O5RWJ8b9leXlpzwjjCmXoZ1v9CFk8591g
 7+Ms9RwR3SwPBTLMXushiu72eAT1lH+hAiYrarWQHf2XcJHkZSnf3lzCK3k6rfbO9n9Sqa/BXkK
 rGbJKNg5BMx/+5sEIQMZlyskUCw0D1NBMU50b1jvolLMRjFtnNBgkuRMOXlId8ELDKczizSO9Hb
 MophUmKRqh0QII6J2FQKqn91e5kZEUpFsMke4PBcS+kWRvxejFfcVAPuio0Do/vTFBNeksGoW79
 Lk48Vsyw99Z0pvTMQMw==
X-Proofpoint-ORIG-GUID: 8_KIxvJ0Xh6Md9vvXsM8iI1MtB2e0u6D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3MSBTYWx0ZWRfX7llY4wR9jH14
 s1jlQ7kO+TqzFeq9qvEhfxgQPNTEGvLAu1fEKoS3CUPDpmCsPRYLqHH395o/SyP7EtVq4t1zCq9
 NCF7AVmOZvSITRSOrwR9LWRwZ1KYyco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01

On Tue, Sep 22, 2026 at 07:57:47PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2026 at 03:31:07PM -0700, Alex Mastro wrote:
> 
> > So I empathize with Matt's contention that the _existing_ behavior that the
> > priv->revoked flag represents is actually "temporarily revoked": the importer
> > can use the same dma-buf again, later, without having to re-import
> > it!
> 
> mlx5 isn't a revoking importer, it is move capable. So the above
> sequence isn't a revoke, it is a move with an unmapped placement for a
> while.

Ok, this is the key point I was missing, thank you.

> 
> This is why "temporarily revoked" is a confusing phrase.
> 
> The API is such that move and revoke importers can co-exist like this
> but they experiance a different version of things..
> 
> We probably should not have made it have this move compatible
> restoration and had things more consistent. User space can't know if
> the importer is move capable or not so it has to assume revoke and it
> has to go and unmap things before resetting/etc.

This feels related to "vfio/pci: Handle PCI error recovery and report state to
userspace" [1]. I guess in the QEMU case, the only importer of vfio dma-buf is
iommufd, which makes the move-capable importer concerns moot there. Is there a
plan to have QEMU re-import these dma-buf into iommufd as part of some recovery
flow? (yes, we can probably move this discussion to that thread).

But outside that, I cannot imagine that we'd want move-capable importers to
resume using these dma-buf after events userspace didn't initiate, such as AER
recovery. Userspace doesn't get the chance to intervene before a reset in that
case.

[1] https://lore.kernel.org/all/20260901093217.8539-1-skolothumtho@nvidia.com/

Alex
