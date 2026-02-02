Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF3125A0
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012293; cv=none; b=ec475x1rLHsB3b4K8g7CRe3cq/iaqTFSS/2wWxh8mb8XRsb/lzzlvl1Lo/AMVSHD9PwJfp1e5JNMaiJIbz25QcON07ZZZ8qrYuLmU23UCP33cuixyquNxG8F/seI+mp4mmlLzBAeDh7WLTvWImbjI1KYo8NzbeTti2l3XJLoGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012293; c=relaxed/simple;
	bh=GMeD70QarmTwXqRxDBxCNGZanOOroTolQwlcKSvui8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdapSuVz87wIGRmWqdPS3ByxSA5lk+xJ1JjlCEByI3X27VSHswEBOGLsjox8V5LyOyEwk2RquEqqmFISwTUATMg/0dA+jOsMwYnJvqH13tKhOaErVfQKQMt3+2akNG+C/em5mEUfVgmgqx7Rw5BbajbbocENpCPfl7u1Jjv+jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DygzPTvc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DygzPTvc"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6120d9EP2629889
	for <linux-pci@vger.kernel.org>; Sun, 1 Feb 2026 22:04:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zIFkVdfD9dwrVu/fbTRALogLFbeHpFWOAWDgm5lUUCo=; b=DygzPTvcLUyw
	cvcXSun4+AZi3YtxFyTcXLffMZlbsE+aW2uXf1oyB8ct2ePmWzrgLQl0Amqtu0Kh
	yycqWrX9caF1d3J03zKTCP0MwFlib666F70JxVAmNy6/MEwyB3KKWzxXqqfn4tnB
	I259tiUv/THemDLLFOKKEDWxsPmZZTjJZ0LufrErBf11x2bJ96Ps6qz6HHYACCnQ
	Dj2lpkIRBOlCUlGPa6o3nTyIIMRMtid7oFscQX26YwMeOStzRFTjFF/VTVZ66b9a
	KqM3ArpWheOmyIjqnEeRFPBvzq/Qxo0s7w+DMbuGBsni51A3GJITJ4RE/X3A2f6A
	GwdXq/59eQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c2hju1p2y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 01 Feb 2026 22:04:51 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 2 Feb 2026 06:04:49 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 9A6BBF963038; Sun,  1 Feb 2026 22:04:33 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen
	<yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Date: Sun, 1 Feb 2026 22:04:30 -0800
Message-ID: <20260202060433.2341252-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128165739.GQ1641016@ziepe.ca>
References: <20260128165739.GQ1641016@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA1MSBTYWx0ZWRfX7y1ze4Cjz/KM
 Qd6cw3zafqvY3TLDVnqB+04pRgqVLY6vJWuaFHYdfRvFI6MNbAzjiV3ILx4JnleBtYZblNO+a+5
 oaX9nUV/rNOSE4ZBqcm2RJH6UdwcDy76N4Vem2SOXOpQ1mTISKqQai0Jp02SM15itCotvlJnhyl
 8+5yJohrLHoxuIGlWlmVMoHgeI4Rh1J+FzcuYuWY00SlOg8ryfdoVA2GIlQ4ul19CG+vcTw+uK4
 uOut+o/0YTGdAclaMSD1aONT624mH96ROCIYwg32TUVP1FzThVCX2ULWlW/xk772g3u2VKNLa7U
 3bjTAebAM2HbpPaEn95UxtdmWbpAdjRwIzWEq97oLsY9hPbwGVl8PABGFLOYS+sXxJtJnvXPTKY
 ia+KYgr5zAgwaQ6UjSu0ieqHC/iS8xNr3r3dp9ZeIYqS1jJnMJCKG+vP9DP3seDTqAxk0jEWgxI
 XEZe+I7PV3aHPg2fY5A==
X-Proofpoint-GUID: rxqTdw7Q8n0D8mBrs0RvarYbZuU834vo
X-Authority-Analysis: v=2.4 cv=F7Jat6hN c=1 sm=1 tr=0 ts=69803e83 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=2NG-zBdR4ynPUO4DN4oA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: rxqTdw7Q8n0D8mBrs0RvarYbZuU834vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01

On Wed, 28 Jan 2026 12:57:39 -0400, Jason Gunthorpe wrote:

> > Thanks Jason.
> >
> > We already have an end-to-end workflow around dmah (perftest =E2=86=92=
 rdma-core =E2=86=92 kernel)
> > to carry the TPH hint, across multiple patch sets. References:
> >  https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a=
6d6c8124ac66ebce25
> >  https://github.com/linux-rdma/rdma-core/pull/1623/commits
> >  https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/
> >
> > Given that, I=E2=80=99d like to minimize churn and use the existing d=
mah-based flow, while
> > addressing the CPU-memory protection concern you raised. Would you be=
 open to
> > reconsidering this approach?
>
> You would need to initialize the dmah from the dmabuf and then lock it
> to only be usable with that dmabuf. It doesn't avoid any dmabuf work,
> it just makes the whole flow more convoluted.
>
> Jason

Thanks, I see your point. I=E2=80=99ll send a new revision that doesn=E2=80=
=99t use dmah.

Zhiping
