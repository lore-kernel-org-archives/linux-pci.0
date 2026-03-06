Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3D36D4F9
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825639; cv=none; b=lG+5Ci27xbOCPQEn4r/XrUtqhx1iPPairN3KHuwidrlC8fhs67pQIBLapQzD7UKg69c31pqCyUv/HT+NL6OihrDhwDtsaia6z7/4SyFn6j6iqPFNv9OubSjBDWt0ALj3mPWBoqdw9mi3MFSDzHTZbJlVrkstV9syM1ndm4ZZ8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825639; c=relaxed/simple;
	bh=2Ri7B64hX2crhvJ+3cRKRgEfLRGSSXKNETH8TmvfS+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE8j78qUHhgRuwEFki6LCgbxcbR0+Q90kSkzsfQaQBHsPBWuYo8PvX4qMc3NmJf7iRjuKKXf64qOgPGnJdHkEGy/yHurnX3hdwINjaz6KKqQWfc+caZF0nj24FbP78feq+EylLCk+F+RZ7jiU8nuMmPlhkDaoLmt1kBXqojKGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lAQtG2f1; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lAQtG2f1"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626IwWUp1880896
	for <linux-pci@vger.kernel.org>; Fri, 6 Mar 2026 11:33:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Fsto2bYwR+ti6PcdpnLAZ8WgpkSbDqRu1vLh7+qCvp0=; b=lAQtG2f1cYKB
	CMenZmgF1mN6BzQuvQNceqCAksQNcRbOIMYgHvJBnXCyNz/9BFVibDWgt9YqTeI4
	Rzvf15wDDn4BYjb+DwZR3LRZ3WSSgGAmsU92JQ93NEPDKcombFHYkrlPbkghDKLY
	s/MAxLfwuew2hMjapyMhU/j7my/sxMoVXIvnIw+AuGI6UqV+LPyjH1q49fNvhatr
	museB50kmxTJg8NoSg8y/xl5ZncT4grWff7iyznukaV+WzD9n7ohx00Xror+Ddva
	G6NakstPGPlhQhdqEGvPK0vUWPYPFAHWjzDT6l+XkLDHbZG6RblSS9kCNqfeYZnM
	9MkqIvK6uA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cqrh7fyuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 11:33:56 -0800 (PST)
Received: from twshared10186.03.snb1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 6 Mar 2026 19:33:55 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id AEFC812CCCB13; Fri,  6 Mar 2026 11:27:53 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen
	<yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Zhiping Zhang
	<zhipingz@meta.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 1/2] Vfio: add callback to get tph info for dmabuf
Date: Fri, 6 Mar 2026 11:27:49 -0800
Message-ID: <20260306192753.3245649-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aaDrp7teQoutU79s@kbusch-mbp>
References: <aaDrp7teQoutU79s@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tmhjxToOvqKYFpJ9kiOD1BNrwBZIC9eB
X-Authority-Analysis: v=2.4 cv=LOlrgZW9 c=1 sm=1 tr=0 ts=69ab2c24 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=l2nmrgH_Uvo59uWC4d4A:9
X-Proofpoint-GUID: tmhjxToOvqKYFpJ9kiOD1BNrwBZIC9eB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4NSBTYWx0ZWRfX1Kl55bIv8afA
 fjuDTQzZqRvjKopIUaRiHJbtWAedpYAVkyEYqNgTNCePdouZj/b3qnUgyKX/xsSX3geuNLx6HV3
 QX3ySknkoKir7MrKGjLAW7x/tetnGMOf+F+J6xymK4/4ySdEzZcSU07UjSyN7A3zTS12hEOdBBR
 XvGnodDSmrU4+K2Q/o1vNTJDjJPwV8ub87Yl0cVzfoA8rTXsqHZm2NAUnWjGQgplM5tRDwHWwnb
 0HUX14IDuv7nLPX07h5LmujZ475L5V5e4bBOcR4nKhgiMXjAgU9gCppls82wDW6DW1jKmfZfVrz
 ZKwKIVwb2G3trNstZDzfFwnm6HueylucB/hzs4K2TV1n3IGYgs3xuEXt7iebOcIMc8QOVQ0mDpT
 WMMEJfZXI0Zdh4e9NhTphkJ4YmzY/VzRNLmCYQQ7wo0Xts843HQcWFaYSDWARYfBVXd0hEUBIVj
 97w95nOUIt8yuJ75e7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01

On Thu, 26 Feb 2026 17:56:07 -0700, Keith Busch wrote:

> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index ac2329f24141..bff2f5f7e38d 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1501,6 +1501,8 @@ struct vfio_region_dma_range {
> > struct vfio_device_feature_dma_buf {
> >		__u32	region_index;
> >		__u32	open_flags;
> > +		__u16   steering_tag;
> > +		__u8    ph;
> >		__u32   flags;
> >		__u32   nr_ranges;
> >		struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>
> I don't think you can add fields to a uapi struct like this since it
> breaks comptibility. Instead, I think you may be able to carve it out o=
f
> the "flags" field since it's currently reserved to be 0, so I guess it'=
s
> potentially available to define a new feature.

Sure, thanks for the suggestion, yes I can also use the 'flags' field
for this.

Zhiping


