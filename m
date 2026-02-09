Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59630C348
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679726; cv=none; b=W50D11VPqV0y6zE9q3Y7KunlBNINYeP2BrwSGJ1k7WZQHuEzKuJUP6bHMeSS5jhKCa3CF2B7L6zt+7558B0z9bGl1J9iqXwBR+5x8eZFgpxC7b2NU104ppcArOnNRx/Vhc6LAliqzZHh63M58oyepdx6R27KptWYKq6x6QCBl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679726; c=relaxed/simple;
	bh=4NQ3u7S2HVKAQx7TWVmyCHklXZFGVPOW8H6mAomwl90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXExFk8z9CkX+bNzXdaBdtb/riTVw+XRWmQAG1nZzZfOdLs+nONxG8ovvTagha1ricf6xVxpSuyCCrGWh6cT3sw3wrqFvHLDW02hlDvsVv1jMd4FzwlZVqEzgfnJGp/Ia33nHUpAG1mGaBFIvpKFLt/8NW/tCRxwLQV9cLUKUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fYocgLEN; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fYocgLEN"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619LEHNh2432515
	for <linux-pci@vger.kernel.org>; Mon, 9 Feb 2026 15:28:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4NQ3u7S2HVKAQx7TWVmyCHklXZFGVPOW8H6mAomwl90=; b=fYocgLENwgUg
	uq6TnsOJzeVCiR69fRm/WdNoar89z9uTDBMT6uwqfYQ0TbU+IO4XFq/PR16A/oWU
	wzdqXBncuPtYnh7LyXhRCLfpfvc9l9SisqJ8R9xc5MFZo18du1c2Yp95emYgODsZ
	wq0rs6tZtvc+Gkr/wMELArLvWzmnQC/1ldIsoA81uQNVaeXimF0GQys0KybstbLB
	NcNPTPqBByykiibLadkPPztjoiAX52Z6rZu8JR2w/mYThbGutge/k4LMdWOWrCo8
	ZvYoes1Gehx/2YlaMtvGwq08yLSz+TfzV6WS6m65bN2U3C6LG2V+uSe4o++y0kWM
	B7F1iTjhFw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c7qat1ep9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 15:28:44 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 23:28:43 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 2ECB11011CDA2; Mon,  9 Feb 2026 15:28:26 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Mon, 9 Feb 2026 15:28:24 -0800
Message-ID: <20260209232826.3567769-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209181303.GB943673@ziepe.ca>
References: <20260209181303.GB943673@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE5OCBTYWx0ZWRfX+4GX5qOHozyW
 TC8hzhK/HEwGGGJTf9pj2RqojxvlqfDJW1nTZlX7r3MKv/a71s5YFj4caql0hqavnirRL7GPNQF
 ngrPnUmHvs3FZoo/AaYQ71/iki59RpwDJ1j5TadGyudqJ0VBJK+2GRQktOYx/R9npVHt+wOkA/l
 uGxlhJ8/1TjmhhZ83cetMJX2Bq758H22xyiZF4abPaxWRy8NgTu9yOPPINjh632N9HDF/SqNNEe
 HnSmxF7ltJDJ/bXDWlaIw/aY9HgaGsg90ysRI7KVB60mU7YZ1wIiZc0b9uaX5F1Yidqpop2/E6J
 wuT7CS8MGqmkk/JP8BFNPl5C7dsqeCcV1QwS5eGG65Rn6crapjU2rzoTQGXiANFUZkMHOXt1mt4
 QjeDz+RpKUn2oLUMq6SK+cS47nhRbo92ufgU5B94a2Wu6oqoZLzyoLjobd4UFgWuxVDSSSKNPxe
 Tf7/GL+tsU3GA7ype8w==
X-Authority-Analysis: v=2.4 cv=fsDRpV4f c=1 sm=1 tr=0 ts=698a6dac cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=e5mUnYsNAAAA:8 a=P0N4maTJ8gqIai-TwVIA:9
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: BFAhlmEualCoSz7M3FZHuZ8LXPvn7gZD
X-Proofpoint-ORIG-GUID: BFAhlmEualCoSz7M3FZHuZ8LXPvn7gZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01

On Mon, Feb 08, 2026 at 10:13:00AM -0800, Jason Gunthor write:

> On Mon, Feb 09, 2026 at 09:53:10AM -0800, Zhiping Zhang wrote:
> > Currently, the steering tag can be used for a CPU on the motherboard;=
 the
> > ACPI check is in place to query and obtain the supported tph settings=
. Here
> > we intend to use the tph info to improve RDMA NIC memory access on a =
vfio-based
> > accelerator device via PCIe peer-to-peer. When an applicantion regist=
er a
> > RDMA memory region with DMABUF for the RDMA NIC to access the device =
memory,
> > the tph associated with the memory region can be retrieved and used t=
o set the
> > steering tag / process hint (ph). The tph contains additional instruc=
tions
> > or hints to the GPU or accelerator device for advanced memory operati=
ons,
> > such as, read cache selection.
> >
> > Note this RFC is for the discussion on the direction and is not inten=
ded to be
> > a complete implementation. Once the direction is agreed on, we will w=
ork on the
> > implementation or a real patch set.
>
> you didn't cc the DRM people who really need to look at any changes to
> the dmabuf contract.
>
> Jason

Thanks, let me submit again including the DRM people via the mailing list
dri-devel@lists.freedesktop.org.

Zhiping


