Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2618C933
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846482; cv=none; b=K/Le0DLfKS8DpF4nT6Z3JzctNv1PxN6bMNrPBmxhWqP1zApLEaNLmRvy8CvSpvOFf2FlAHHRE1l3Js4AU3RYnEEqUhIkXdBwACWII5uL/mdBNKjmMvRe/D+l79dvb+vA+EjwkdtWeYHG0sI4nIM1PkOgW58dkE+IBmFASMF7fzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846482; c=relaxed/simple;
	bh=1npm1MrjLfeZbecaMsTDG/Zavi097seNdP7kx0bwRaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILn8mZqWXiyZQE2XYV94LaJadaYMFVgArUhq4e09YRj/CtwqSl9/XbjjJBnsE99FwdjIlWqU/HBCXn/1ugqh3OTiMKS3pFPAp7DXr/CHkEk8VdriikfRfEBGP4TszzgecMd2B02HyK4k0Ph335vkKY5xhB3X8azZlSSfSpwHmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRp+RjBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXE2LWmv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRp+RjBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXE2LWmv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FNl9tv1076136
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 02:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sxe5cNoePwMBN1usknUDWML/
	DJByEQLRgYkJt2qIwb4=; b=mRp+RjBbzR3Ix9nRuIWZK1d19awMlvxktAwdxEM1
	e13cJM1tAR3YyV3srvMbTVKmnk7CA891XlUM4SxCIutfjxE1xWlfNzNf1gGx3blY
	sDE0NMfW8iuRBPTPBw/Ik+v9FyyF/aSYeHJReASSwFighdPaYfKoXTWGs38p17Ny
	hAt4p6AdfDjb0FKUeyKAzTpVidTpHTZrcDvqGSrExDfXPk8VJ7B5SJjiB6IjyK8j
	1XrxPjp77VC3gLrubIkxuyQzj15dflnmH24JTXXxgkDdn7H/7+gORZNeCar5JdSS
	oCOiw33LoEFa/ZOVrQpsrRvTGMbMjRXo1ok/9/0Kiq3hTA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gjeue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 02:14:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so1902524a91.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 19:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786846480; x=1787451280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sxe5cNoePwMBN1usknUDWML/DJByEQLRgYkJt2qIwb4=;
        b=LXE2LWmv9QZ3x4I8B8QX9VCFhgISYpz1KY3o4GXaxbSgcstSzJCs0Qng9cXm+SKzl8
         RSzr1OiMhAGKFILAflUlRUj+FrnwT5VWuHl/JSuEDEXlLR8rg+jexzJbK9ilW6Wpd++p
         zYcQw+d5OhG1nVe6FRJ3RTGXyRiHJ8bAFoarpL2dQWLXjKFUb4oGzrKqVrgj7Yh4jsxe
         mQAHrfKpiMAT3urnJ89z73Lx+CCqTUgHnJ+momefqSxloQ1t+bjxK8y4ckb4qzjHJ0yn
         L6BmbEzF7I4YT0h+xOozTxsn5mhsGwKHgoh1bWKucfeEFn8cTZcHRyHhqXPwq0XkfblS
         6GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846480; x=1787451280;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sxe5cNoePwMBN1usknUDWML/DJByEQLRgYkJt2qIwb4=;
        b=bIwFAR32ANlDHGv2tNuMDFFn3PDzbK/+dl8fsNe1jHWDdqawFpP4xAnirPgSbERrgq
         eOVRIqUPPk8Ts3KdHwG9Af7GL8pVCsz5m/5/kqN7aR0vCMy7V4xPA6exXvBA11v0qppY
         kZvaVIZAC2f3jeARatYiBnB1AbBPcvkgyyzaDOW1SV+UFVvikc0JW+u/vOsJbNQXia/N
         f93rZndCtZrkzsQDfgUdyp/wOZfT4xyC7YD+w27au6ErE8dX+BlEzoTa9gXfyRh/OiMV
         GhZbNebeH1Q7Xmc570qpdldHlLz1E+biCJlfMaqOmtJoMCkpnkjaEXaDWH9kqcgLO6hD
         pU5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8u0Uwad441PXunxG0sj/fpftUICsh0Y0ak+YhUPP2nxYRKUDNbWYUn4TGFzjWFGWSjOUweuc0TpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyK7iKYcslIO9fe0JeO1iuYkR8zdf2vdDWgAq5t68pl3WnSkF
	tKcTTuSO7DceFieuwTe3Mk+MSNR+UAVmLJ1X6DYuI8Mf+RvGFF2NrdghghBnDvEGnP3UJWwZWAw
	czmcl8Wj/H9wdWU3EymcvvmMn83HyB92rq0OKbLITKnXTYdsGfcbep0TBTaltPzY=
X-Gm-Gg: AR+sD108ELrx9EHgY5YqQNiLw/j8eGClnGibGlOJ0MQO00qRhpGsQimiGIX7RPMss2U
	cefeR6y/Mx9FnxZvDFjDQCcLeJCa4ghq+llXjAIxdUJEkTV6/KAXULJ9OAJqoaMnh7Fh3qVMeXv
	t6KVmoof41HhAxZet/FGmzQWSgZbBaozV1cIbDzqsLq6gApswQabuGB+opceunA/KqnIkB2ncrK
	guWhwE9VXASfaQ2Xpex8Bm2yCIq8QtzD0CV8/3R0O+T30f97/53a3QDqj9uCRzWHFyRk+gvckQ5
	YKpqEWXaMXym1ya6ZzLZZ0Xkh/8WwXztjJJbW1ZV8V7B6g0lvS6rWnAH4hIhonfGfO8/3IXB0ol
	vmfynWqJRDIm++Q==
X-Received: by 2002:a17:90b:1b43:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3933af8b5d7mr11568721a91.5.1786846479878;
        Sat, 15 Aug 2026 19:14:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1b43:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3933af8b5d7mr11568690a91.5.1786846479105;
        Sat, 15 Aug 2026 19:14:39 -0700 (PDT)
Received: from localhost ([4.43.230.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31b8fsm153243a91.3.2026.08.15.19.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:14:38 -0700 (PDT)
Date: Sun, 16 Aug 2026 04:14:37 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] Rely on regmap APIs in tc9563 PCI/pwrctrl driver
Message-ID: <aoEdDEz8_VPCczW4@lore-qca>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <CAMRc=McNXg3tVQq1JOFAzO5V91Ue_jhBQK-CbbiSXeHzgAyBNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/zL0p0al5wWh9RQb"
Content-Disposition: inline
In-Reply-To: <CAMRc=McNXg3tVQq1JOFAzO5V91Ue_jhBQK-CbbiSXeHzgAyBNA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: jC_k2KO2tCyv25FfHouauaEIa1Uh8AFC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDAxNCBTYWx0ZWRfX385Of6hhaEqk
 JPnCt0Kw7Bei6mnEJy7QgiwIuNkPsffUmmZ2IXwsBiY07SNedPrh6iVYddopd9grsbtASDE1TB0
 iIE3jganLEKgLf4P1dfZekdEsL59Z8I=
X-Proofpoint-GUID: jC_k2KO2tCyv25FfHouauaEIa1Uh8AFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDAxNCBTYWx0ZWRfX010VwHan/EXf
 vq6/iGq+I0MnnEGsMHKFah9fniKB5KXt054UQUQvxYf2r9WZ9tPdFkaHa55b8v72BqHMOi81gSz
 8K1RY1rId5Bm+oliFyZ7XRNmJ/aG3cWaOBrViUSEHMhWSyFcmURP6TBEf1oynMc/dC2wj+u2i6y
 Xil5izjIxzjnQixYse7SoSPzSZL6PllQgchpsFce9cqdS1kgm3l9PliOb3vVCnoK/t3R96X+bYt
 N4YkWq4yj89sRG2tu1zJBw6MCclbslQ6CSCFFY5mjPATqBEh+aT9FvcS6/y9rzBAY/2IajEfk2A
 Sj+ZoOPjKXDGBgJNyks76mB11QcdG8CGZnplQoVeud03e/PEAEqTHzM+D+Q7WtJDUIHP9j54Ueg
 IMuyKVvtJMKHRW2wuoCdq5wZamsGqjOHGzTtxliQ0Qrqhrh3YHOvjIxilALfsfxDZyRPcYiUfJp
 oOaU4e4pFODBp6sWE5g==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a811d10 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=y9u56/S6JbnHW3dtX7SsYA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Mu7M5eG-7JTITHDiEaAA:9 a=CjuIK1q_8ugA:10 a=1h0BlC46_OUpijxAeGQA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160014

--/zL0p0al5wWh9RQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 29 Jul 2026 15:34:24 +0200, Lorenzo Bianconi
> <lorenzo.bianconi@oss.qualcomm.com> said:
> >
> > ---
> > Lorenzo Bianconi (2):
> >       PCI/pwrctrl: tc9563: rely on regmap APIs
> >       PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation
> >
> >  drivers/pci/pwrctrl/Kconfig              |   1 +
> >  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 164 +++++++++--------------=
--------
> >  2 files changed, 48 insertions(+), 117 deletions(-)
> > ---
> > base-commit: b9851611bad7cb227c93c1401dca48995a815d94
> > change-id: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7
> >
> > Best regards,
> > --
> > Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> >
> >
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Hi all,

Do you have any update about this series? Am I suppose to resend it?
Thanks in advance.

Regards,
Lorenzo

--/zL0p0al5wWh9RQb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaoEdDAAKCRA6cBh0uS2t
rPXgAQDBe186D9OeIM7NhrOrkR1xUB7rrU5PqXL3onvUlWOFYAEAoU5GGV3DRDJp
f9+7iFVlZFjZPHWHOBGINt4JO3IPQQQ=
=m5PR
-----END PGP SIGNATURE-----

--/zL0p0al5wWh9RQb--
