Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCD380FFA
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219379; cv=fail; b=dPbzWhmQ8gc2xG1iXlsMLeabAlddczXqmHUO2Zf8KtKZEdkzoxb/xOpPQ8xt7s3Td3iJg7c9FrMZVLjhsPOK+a3qm2qcYsx7bGHW1oqWHIL0iv1cy7oiwabpL/msWHL8QtpsrkFX65LoL+wYO7CLa8a0IDbOwlpLoiSbN06t8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219379; c=relaxed/simple;
	bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDIa1zl8pVts2jKbOz/847V3RODuOaCn4SmOzCfPRDPABNH646way2rx+a5HFy/XdOBTV4Z57zVVYJJoTWuWwR5OH3W9nXes80fghXB6JHsnS0sB4QXu/O5QfU5nFwJbBQGBNvaXaMQSMIlIV079fhGcUFCX0+uveBc848P6cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=USTVjs2G; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="USTVjs2G"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BAifiL3021395
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=; b=USTVjs2GSY6c
	zWNomSf5E8qjahkAqgjmiQDPFbjEPZsjQeJ/b94zb0GF9NeM8mlmXX9Gk+kwYdrj
	cTftYVPuOSFB/1Nr+8gqaK6p3IfQ3KYjnHVtCfJwHBjSmm33QENUybqoFyJiQ/fu
	n4EJcipp1CqI7B0zNUDMYv+OiLaw5YrOS8y/AuI2CPHIovD+hq3X3/vXm3tTqiTy
	HHxPhprLBQNWDBST0hkTSIsZqY1y3fvMFa5eDd8O3gaW+GcwgHrjI92X6wE8vhNV
	AHzq3kcWmOiBGIroHAC2qW3JwOJCgC75sMNCqZsKh1VQyolLrORLN0mB76o4eHEv
	+bQz7LwmGQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a9mrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e71e43e89bso596051a34.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219376; cv=none;
        d=google.com; s=arc-20240605;
        b=cjVXAX+O46tF/tgQ69MXrWQf6AZIScMo8L3KtwucKoxjZEIZnDrgE7TJWDDVYVuwl+
         Q04PoQ868BJ9vL5O8Q5lGkPE2jkxx+ahOGVmOvyOkpv5gD3el8ouPFQ7urnXypXoXnG3
         VuQ+yS0W3J/6GqxS9vr3GqcaA3A6pKhyGidfcZtSB7XPMxkhyPMYfh1RoN3PxGk39Z1p
         7VllcGB2vdcKsp5CJabZ0Kwl50dZkrl6hunN4yf8ynWKLPlZ59hACA4cRtdZpHYBGMD1
         FV0c2GL2COoHKsqlnwFEGXYnmbCNXZUv1MEZlI3LTadvj3FFKMLRvmzWTboj012XIjTM
         YV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        fh=1l9FPoid9rMIRd5PQegr2HcB4E9gzkpOnlIRsF+37oI=;
        b=VY87C+tJHyVI2+cepxazxgS/WisXGivD1unFrRoWgkrpdg4ppTS9q5YF+0ZroJnsfP
         U2ZYuRF7kDq1r0AEtbMA/xemltXWisqqxSTIP53DcEmsvHh+kzdm2t9sc5a3Zmy2+Tz0
         mYK7tuur0nmq5BbljGcGOEAEKcXbXhHNy7eXx1CnCRMJBMeOjf8XCS7/6YdWU+FW1tyT
         pgoiVOqswlfNmA3b74q4z0JWGTyU8RTudLWGVagRGk44ii39uen4mFM3O/BOXyW4cEra
         r0y853k0J/Lrg4BaUYeuScuXOGMxbH6WpnAxOkw0pDFVTfmz5HyWEVvJgDnEbjgYGsVt
         UmqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219376; x=1781824176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        b=JpAk5dtlcPYXqg5bj8UCCuRqWMOBqYQc4ICKaR0ilPHC5KTSs8iSuTA9LiMIRdEq8p
         jy/X8k7x4amct1VQGA8hUhGpeHf3ibtjC0S+SUQSUx4VIINT2tVYNIjROxs0icHaWSyS
         tWLNP0Kll8TgpBXStnvnEa32oY19/FRDH8eztH0X2ZVCfBA32GEu7FP+2sE7Mr+3OcPn
         pgwSo/TXB7OIorU68vHO+wucFbfUxCCauTCmef/IpW9x6QF5W4Yo1iWIiHfI2XjoJAf1
         vmYA2nYwZhV67QQ/v3wecV5RzweBvK86Pso0f90LbzXm1KGUTqCJgiqqLJdIwN6hOjQB
         KUwg==
X-Forwarded-Encrypted: i=1; AFNElJ8AgoZ+A8jeMJ1aAl/S/GZvveZLe8n+VBjeDDnNZVfMmYVDC8FNbpKv5h5/LStgdCyJ9aWaBOvIH1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOkxG10kzOXp3QizPVEFjj+AXCDaQGLBHyZO8ls5dxVR39owx
	04Km49+OWsaGORGwsqjlHayEj84nuc7HmF2L7kOaUCE2iwMBuCuebIK1y5RGsXFUyVfUvWHUxr1
	PdaX7g1wgNgksoZCRs0mx3CzwRDkQcPhbhGmbh89ftg/DkJvwfX42tgEX4ibEh5M61wQFE7Mof9
	Alscc7coel9FcAQdW/QbKcFBelAWDe552zHKY=
X-Gm-Gg: Acq92OFfFT2ctYb6CCKb0qKgj+PaNIaMgA/aSghSMz9Ys4ZMQ0DFx26I2cYg3uWY0eG
	GBm5KM1Okam3yYxam1zYTutT9iMIsxRnK1jYhhaCghNrF/YxUYJ9m66F1wGVKW2N9XauIS0Mcs6
	8S+gUhV/M4kEnNUpDB4NL2LHfuFro5XMM0hutIRTW053djLwJ/QhR+swIiTtacnndgi443kbTwm
	BYHz4oy1LRAtjnKg1Ea3g==
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e78473ec89mr120379a34.16.1781219376589;
        Thu, 11 Jun 2026 16:09:36 -0700 (PDT)
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120344a34.16.1781219376083; Thu, 11 Jun 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-6-zhipingz@meta.com>
 <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
In-Reply-To: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:09:25 -0700
X-Gm-Features: AVVi8CeB8nmACAn2v-1nCwadZsgAxPl-ide5TeaDE88hJZn8TEKcdfaG5LmdPSE
Message-ID: <CAH3zFs3ngOXvA5DRzur-_gQ2e0N+-3Az2KmwxZTYczqw34n_Xw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX/iJmXE7DXq/r
 FzDAgS8aV/o6cz5vAglMNHOWRkDrodz0v8U6y8RG+IsUDxuNlvqiKo3M0ZQN9wiM+Sf0O1B8vQw
 AlNc/x4V0Nr6pwf+2xNSSS6nwb2SM56xe6zqSZV1bvFm3rOjXpvLgeb+FYOXnnbTxoqjWUx2Pxl
 dwt+JEB045URtnbKnoGWC90WM6Wegq1W/FHRgcU4c1JaENcuLAcTwUyr89/BjgpTJqiRVJ2O3Dp
 smO3b83atF5wW6ltYEd4W61osM4QlVkib7w2N0QvX1oDMNHAjQq5YNS4zFuhhcDLSWsNFd9bgNh
 K07HhUHXm+trGzY0OlmXG65u6bWHUmczTCpaIR4lV4YjZnTthUcZfvYrjowkMU9CThotft/JHl3
 kxEm787KJ8o9T8KXcqO6rmBeymDsn6CUMfBH2LQjoPjDiFOXvcsz1DzbEXBZrsSTiejGo30Qtek
 Heg4/eZZ15M86YJ1rDw==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2b4031 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=Ikd4Dj_1AAAA:8 a=G2Tmg7Ww-o-apaxFWtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W_e-Fj12guf9FrIdx0OEH7FQR6m_ywNR
X-Proofpoint-ORIG-GUID: W_e-Fj12guf9FrIdx0OEH7FQR6m_ywNR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX/UtXp0ojAAxa
 CfSQVQku2bP3YbJ0yusynYdo9jium23qq/aRpdV8gOdlweoZT/M3MWADoRaBo+raz0KQSbzWINf
 oIN/7P3w6cn1DHLYcxBQmW+bcdxGxa0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 5:44=E2=80=AFAM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access to a PCIe endpoint and use it to program requester-side TPH
> > on the outbound mkey. If the exporter has no metadata, fall back to the
> > existing no-TPH path.
> >
> > For TPH-backed FRMRs, make the extra ST-table reference belong to the
> > hardware mkey handle rather than the transient MR object. Extend the
> > FRMR pool API so reuse and final destroy can transfer and drop that ref
> > at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> > a ref on an already-known ST index.
> I'd keep the ST reference tied to MRs, where the ST is actually in use.
> There's no functional need to couple ST refcounting to mkey lifetime.
> Once an MR is destroyed and its mkey revoked, the mkey can no longer
> generate traffic, it's just an idle entry in the FRMR pool waiting to be
> aged out or reused.
> This lets us drop all FRMR pool changes from this patch and keep a
> simple flow of 'acquire on MR create, release on MR destroy'.
> > Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> > the requester hint matches the pool key.
> I've fixed that in a series I've sent earlier this week, please rebase
> next version on top of it.
>
> Thanks,
> Michael

ack, thanks!
