Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3B3101B9
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944137; cv=fail; b=DiXOYDw9FZrlEF6NOiGReim/K5AEt4ZWhKJhbOmbaFVo4ceHjddBncj+15PFISVSM4zxNVVTIAOZdMj5Iuvf5dWWuZtbaJha+9908qUFYVpSVA+SyRRKYbDjMd+vj2b3uhwScssZcQn+8gUZso/m3IFnbDXFRjoS51nH0ZblBXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944137; c=relaxed/simple;
	bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO3bEtNoz6OmBqNGe9HNbYV3eatnpcYVjNMyIGKMw6XmdqmWOYYGUjaO7nBNypLz2zCldt4+qC1tFlgMtNPESXUhJ39LDuV6CXcch9iNTByImzZbx6IsBa1pMoJ5BOeVKbdS/wPsiZNb28X2bX4AuTcs5xQF5HYsTuCNF4NxgUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AIyX69k6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AIyX69k6"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKlro93164927
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=; b=AIyX69k6A+c9
	mM1a5KjBZFSdIajJE7N6M+mQ7sGkngpIAcWIEq6pqulW9U5nSY+gI6sFNht86O+Z
	2D6jvDhopxPYZ1YE7naoN5Kloh1FC7xqcci30zbsC9zqOK5hXC7sYrpQFtCwvBAF
	CM6JDW47bs/SUBHJiMz/+G0F/SU/VgcW4J5HaITGfovQtixxblrvL48RNOE4hkl4
	QSltZkNb8/8gzsiQJteEhsP1K0aDt00kHUNwGqFqoNzF4bdIzG4nAfjSr3a8Np3W
	FHPEHYqrWlMwWuCKKAYylzQAXpY1Mcpxe88gvgN6QcAwDuFO547/X8h14sWFBIaG
	Xo82qWEcqw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7y42678-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e4026a2524so6075726a34.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779944135; cv=none;
        d=google.com; s=arc-20240605;
        b=BD5skQ3j2rjeG27PLbOu8tbYT1W7CRuZKfeE6xZmxHqKKovFCOy5fHj58CBREq2HPK
         xI/txMKwdHe8mgTfV8XaPA72UJaz/AwO1wMmjUo8eXtv9lCI1ghGra9TeCwupSHjACJH
         pxzgxJScz4QhY/HUgSzfejhnBOggzwVNdPxkAsFva6jItM6rOpKi4Cxd7OkI0RzAiZy3
         26hTBtyy2/126nJwhTTKzU/mowFQy+jtoNeZQhp1lu54vjsKl//dxDrFhUBBcn77mY/e
         EByTUv2BTOzhucoYdfHTtOK8EUgKruYb1gwN8nbUJs7+Q5KomT9cEb/iY9soDoaH9Sp+
         wlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        fh=QncW2O3a9tGkIjiwBfSusg340H0KrPOnI88oX2Uv8oI=;
        b=S5Jzlj3WUnYKMfKntghVRmyk2HmnCwj2+f5PwS0pJCPDobXr8Or383NRGMZkP37WQx
         64o9ce0PEdeaOPPDQDPwmfl3wS9CZTI/7FLsiVii0SJdn6Px/MwWZ84QGybNl/72dI5G
         eBJtMsapONWaeZUaUmwZ0BTHvhI/GKfD0k/ODTFh/2x7/5iap/ncVLqywS5nuAO5hXAW
         hMp3wzB+5TFjFT8MTYwaiwWE1pzsw4Ms1sJnYE+CPQfFYV7om3vFvf9VWV741xbPEZTG
         eqR/CDKfzBUHV1pltM12dYQFjeJ0QRvHBqTPQyNF/qW1u4Ep2/vgwBRiNXjZuQxEPYeb
         mBxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779944135; x=1780548935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        b=hC0jmgoZLfuWxyvuyUoQb2t713IMO3Ugf3C3QiF69zM7IDjEpFtvCStILB7RyN7djO
         JDMahy3V4rKotL5njBbxbGUJH9A134Z0bYu+m9IREsfWdhKPRXJShOvyBXqvFp9rBWsl
         QpE6K7VbdS9QyOVNcSQQz0CEa0xMyvAKueTJQzwFFU8O/N5OEqqdca0RCGW22W+nUcX5
         xuvGL8Z/F7Y+dqGIhSSCK9TFL+F3Yyf14uH/K6JqslsgZrCLqch783Hqp4VPtIUlOAda
         KNSJbXnbfg6wzgkuP8zjUdDsNihlQxlDZCIFbOW4gAD9hPONzvTw0LgKQs3iewkVTWqw
         pKrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/V0GPHwis+cdG7Cuypkv9FWCnve4LvRrPF/qNvRuQIG8eLwRBVcFNmAxLQ7Wbw3QRM/PNfcX5Y278=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCdUBKiKPuU0EadM5oVC+AC072ZaAfoTB9FdyXmWGTWBKyMYf
	Mybu194u6nuRxWmD5CnUNxraOvEQPPzc8gRC6/ixy12q5/Cxsm4IS+GMhroxSqyDJFs4ccphZWe
	zpJPG0T8qwZQAuyw4Xk2QxpVz3/RXjeN6w+xRY47QTSARDAMXVLBN4cBsJf9YzzTxzyvVcM6ewP
	0a5T/+jhHBKz+QJ2yqg9zIl4f2fm6MFgTM2aw=
X-Gm-Gg: Acq92OGT0NgMTMtEQt45amwz8u3HLyuCKxzU3TCWAI5tb93MXcsvgwaLHYlJ6hMnVdK
	p/iVivzW/RjdERCboxfUR9Ifz4JTmjewDkQURktFTSdqKimdFgm4RuXS/1/KTAlE6z++bmMPSzN
	D9y+YFAfBGTVaptTlb8azNyWkSjKym+ZYwXMeHKzUEasAJgwFIiy6BeVE5uoreUqTK28DV5xODD
	4NBW9NjufZuZtJM8rIzVKdpwuZrKfT3xXvoyst+rUR0p+6F1V4=
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7e5fee23f0bmr17184414a34.17.1779944134699;
        Wed, 27 May 2026 21:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184388a34.17.1779944134274; Wed, 27 May 2026
 21:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
In-Reply-To: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 21:55:23 -0700
X-Gm-Features: AVHnY4KjB7ggvEym3yYxunms23zRrE8n2XXaWHSRU_rJj67WeYLMsK98_vs1TJk
Message-ID: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: cDZjgVv342QgcCvDBr_9F6FQWoni5HgS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0NSBTYWx0ZWRfXzCFeOmwp6TOX
 3bzuTtcpTCuuQfJcs0YNitanx8pbs4FqbB4ivZZ6s7JaTQ5TDtYT1gU2VZIUzs+6t1Ao7bX2EwY
 4eDIAe4GskiHQv3r+6YuWfChZ7+zledysjKtjH0yy6+sxOwRl6MyRB2G0lQ59xxIiInyUavldsh
 rGcA14jmeBEB3X6zf4aSjwlkkRx7M5SFRwEDkuR10sWoStxR6dmz25z9agUv0D+eHgymX6332ty
 DbQW01vc9hzZohL/f0S/78hWqQX1s/c1L02oPkO6FhcEks3/TOxqjt2v0ri0V+V0DDN7/L//UGg
 8+t3HCTaq9eWW3+11z5IbWsvIb3CHbmNVLKqLJCemq1mR2WfbisyBO2PdWS540Sq5sOZI5uxJEt
 sloPJTw7o5knLEqCI4MGy00RiUfQwhtyuyp/k3ewEejhc/3sE+Mwos98Kzu/CCfKuKuxIowK+Av
 vza7/wt4BgsUlcQcRNA==
X-Authority-Analysis: v=2.4 cv=Xci5Co55 c=1 sm=1 tr=0 ts=6a17cac7 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=zd2uoN0lAAAA:8 a=Vls0teBZlVDq3xJ5GeUA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: cDZjgVv342QgcCvDBr_9F6FQWoni5HgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/27/26 14:36, Jason Gunthorpe wrote:
> > On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >
> >> Yeah that's a good point, I should probably rephrase the question.
> >>
> >> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>
> >> But my question is how is that useful to a PCIe endpoint? What is the =
effect of the ST here?
> >
> > TBH I've never heard Meta explain what their device is doing with
> > it. At least it seems to be super important to their device..
>
> Yeah I think at least a brief description of what is going on here would =
be necessary for the review.
>
> Otherwise we have only the info that the exporter wants to give an opaque=
 ST for the importer to use and no technical description what that is good =
for, how to test it etc...
>
> Regards,
> Christian.
>
> >
> > Jason
>

Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover letter=
 and the
patch's changelog as well.

The short version: in this series the vfio-pci device is the completer
of the P2P
writes and mlx5 is the requester. As Jason noted, ST semantics on the compl=
eter
are implementation-defined, so only the driver that owns the completer (her=
e,
vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
importer treats it as opaque and just places it on the TLP.

Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
 end-to-end P2P workload yields only expected results.

Thanks,
Zhiping
