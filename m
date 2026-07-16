Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2035E1A6
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227447; cv=pass; b=ppch45vsielvL+ClS8KZmOO/npfw6RfqiV31laowhNKOVv475gOqR21qOxDswVlf+CcBkW4XYoHj2+bDM+c5L4axOm1r6NOm1Z4uLUz5G1V20qldjl78GgKk7+w4upwi8W2zmhBCDQV2hO5oLZaryZ/MkUk5PTmaP9jgCCqYYpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227447; c=relaxed/simple;
	bh=B2lAv0Kke/zaTF5v6Dg4abddoHPxXuacOTWspld/Aos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCyAE+VdIAernL0zd2mn8Kew+wP+OpiWm/gDx9mstvqkCihx0fwdUPQRMJ9qmBFQzXT3wAp8SH41nrqycQB2iytdEgSrjUXHNcd52G7tO7mGuXj9YISGMG3DMGWn9RUIfZxDCJztTvfXfTI4Ub6OonVe9tts70+3hTu/FHTDKRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n0Of2kn8; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n0Of2kn8"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GGUHUU3587403
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tro2yUuohTej5GDynd1Qf3SmBPGMdcgG3ju1GffyhJ4=; b=n0Of2kn8kyXL
	4ODtaxekKt2V1jiqoP1wAYtYHiSFzPrRtxIXrNkgJ3JFUPd2F9bYVglDFCRg2vKt
	uHRh0j2ChOXBcYkrxPwS0c5XkQLYwskVTx8Z67DxOzdweLG2kVLFwWVfGSspYqu1
	8kJZE7tdRtTQ2b1k33QeEzyIFSJxlAIXKs24iNxEy3fQeFalZZtmyb6ciBZgZhxB
	bsMiq2//waTzd0k1CyrJUUQxy7H0EESCYz1yBMxtLRR3gBjys9HSOswkcnxKq7WX
	+q4vHE2spOqxvt/oLc57kNjmQW8HOMesed6hCSzGKRP1tfHAxqI7kJ+445iep1vb
	QfiIpbsSuw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fex3cjp2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:44:04 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e7624e584dso5728499a34.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784227444; cv=none;
        d=google.com; s=arc-20260327;
        b=nngd6xow6O61mPdv90cNvyqRh0Jjg1NIaLAJ1XPX0vSf8YagqxCczzyTEaA0k7dAt2
         DHUVUWC9eC+pW1cBoQmHbWLmTLAK7bXnRqs2Tt1R2cQr/+Xpt/54zS5M/x+RD9g/kWPa
         0mSoqdDKZj/RQ7+Ga5mAzk1FNK6+reO7NRFdgKbNO6vQHjS93oQ3xJ++YcOiYnk5jEDp
         sI9kw2K5088kgF8P8Pyh2jxOIknZsRryOSvp5oPih0RTjZU3X+lXKI3YzoFX09CitzV/
         Iz6qKfiPN0s5R8MFt9u/Sdg45x2LJJLCVL+9VAWlnxV6PyXgAZKVrizDEu6rsCfI1766
         LFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=tro2yUuohTej5GDynd1Qf3SmBPGMdcgG3ju1GffyhJ4=;
        fh=BY7eYBJA9TcVOY54k9NB9SWZLa3NWqUVibmrOP7dmBQ=;
        b=gf/HUH65H3OonMOGdEbnkSF/2s8gOdQ8zzgwpkYZ7zLplyyFUhc5Cqy/GDzAr8dPYZ
         vrVhbVeY8D4X2Zkw6GNmE1NXW6atx7CgtUzf5ijpWrIq5fOn/oI/NPlYv+GnNBx3Lbiq
         EZg8mXTGQdJCUhMbA/pm+c9VfLmQ4sPQQndUAWytUkS1SvZDS9Hl64/jAwfKlYc6QGF/
         4FbKFhPxhcJSvqr2qPBK/5YVtcH4/+BInfeahlsX1FSEcwxwE1ZMNbjlq6hzMTRTbaXS
         kxTmn+Wqe1L1or4GkoZDW5NqBkH1e2+2ILRvZKDvLDTRmpUNUM9/gAyIck9rR0FaCGwF
         98GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784227444; x=1784832244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tro2yUuohTej5GDynd1Qf3SmBPGMdcgG3ju1GffyhJ4=;
        b=qM4o+DSLwhAsz5h5dDWdq3zctGMbn8VvMbvwGunjzm8vvxefh2/YkjEyJQ4nt+W0Lf
         X8DIThAgbvgpkPoBK8frrvCHG73cTMhd0xOYdA46GWZp6kGhsj33BgM1SL+rp66UQM6l
         NtkQ+fBsRb7lIURR8Owdi2ED9UPqULYh/IKO2iNdsx439wHdlWeahwG/7+H68j0fJ7kd
         C2jCaaFyl3wJKYsSAOR6FF+qg1VRDuh6tLu0C90DKbfsPFk1kNspYr6DO58usp9wVmag
         22E1h8k1WewVtMw5J2jW1hEe6olFa8NTjXMl8Fz0JRAE05XeizMPztJvuOW032MyZUw7
         sFiw==
X-Forwarded-Encrypted: i=1; AHgh+RpcQLyPGlG8l/rxKpOY4vslFog/BZMgjTo+sbFDFgFS94jLQm9qrX87jdmFOgn4LGIqJObybjvVtrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy47ElWpyaYPFlSEfoWE3SayAgpm5O8bnbl1dOkeU/iWG5AiC82
	NnmSt/obU0esq+7fm4U0m34G/UCGBXGtyad7hZJlrgzPH2CZsztRMGM3/CbtoXLtYs0fdHHfDgT
	DLNrn5tLZo24H9OceGI9USAbaU+4DcVJDdTBSLA5iu030XJrRWRI0JJoLeBRLzT6803XNy6qBxG
	sOMsjYKTarMEeRSpho/iAiEVDe6K8fUpCBg6A=
X-Gm-Gg: AfdE7cny3CrfGsZNUOkOCxDmBOJLAFSmHhJuh/8Te0Gxppr8hkES/K6+JEmaw7TtLro
	AHS7S0unwsu8G1+9GeG3wo+ocVOhIjnS/+j6qjalP41tFyKYc8aCioViJTpg61zLSsCeFt8ZRNz
	ZUQm2bAAjF5t+Sh/R3zu1y18NGlnZZrzpfFX1wvpc5WC2OiKxul/xygoDT8UptjcYAxL/D/EQc
X-Received: by 2002:a05:6830:6c12:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ec9fc13f9emr564036a34.11.1784227443995;
        Thu, 16 Jul 2026 11:44:03 -0700 (PDT)
X-Received: by 2002:a05:6830:6c12:b0:7e3:d199:3164 with SMTP id
 46e09a7af769-7ec9fc13f9emr564008a34.11.1784227443523; Thu, 16 Jul 2026
 11:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715202409.3767494-1-zhipingz@meta.com> <20260715231525.GA224907@bhelgaas>
 <alhU7lktqNxAPB4E@weiserver>
In-Reply-To: <alhU7lktqNxAPB4E@weiserver>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 16 Jul 2026 11:43:52 -0700
X-Gm-Features: AUfX_mzvgf0dz1HdxSS1kkTD-1brO-RbEuUYhiitRfY9lELwvz4jPCPOlSizCr0
Message-ID: <CAH3zFs2pGMHE8xg_hqVCwp4tPEKQ3B8Ldu85kU=bsguK_MgdmA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
To: Wei Huang <wei.huang2@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5MiBTYWx0ZWRfX5oXiRLjyRnX9
 k07nL1Tljnsd2YLinKc5FItv+20G79BkgWZ0LZLnHhItK2q23ZrZIO+IUPTXmtrssOe4Nl8iAx5
 ygsWsyodAyIYNy/twWCaDRK6VK+BJuyzlhbPlZahwpY+8hg99M3mFu2s8LUM2vIyoTm55BdwvrC
 KD/qvHaOxTSPy/1iS6Ctw0YugSAZbakJzzoeNd8jnFJf7KCHBZfXiZD3lvHR3/tCBgSETeQZRSx
 9ULOFI22x1X/0QrTtGVCIbKL7B0udy0LsspcDMooQG5BBLZ7Ulr+FQHWp+8Q2M3uJsKsDaWtaqC
 vgyGUdVXa1OyZ6TFouOtduIn9Ks0QCiXATva66Dc/XBV4km3nr/1bNUoAOayT5nBuyxXmafHdP+
 9tGWczUknj2Zh9TGYSJ4EiDzHezCC3mSrW2VnwmH8UgwC0FS8b0t9dGieNjRDNobngFZ2kydl+5
 QJBN+9FxkyjEeQS+asA==
X-Authority-Analysis: v=2.4 cv=ar+CzyZV c=1 sm=1 tr=0 ts=6a592674 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=aoCffaJH-pVtSq24NWgA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: -7uMngLMvWM257gbw49daM_mgX4r8Nqy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5MiBTYWx0ZWRfX062FGaRT+kAj
 L9GLrkSeSqmeLAE5WHK+2dihKOQgQYM/aWcVZcy4U+Q0aTo2P7Dp7IZ7HchC21t43bYvIVq/vNX
 J4FdoCOOrUt4xcW1r1QiVn6GPnjdhEk=
X-Proofpoint-GUID: -7uMngLMvWM257gbw49daM_mgX4r8Nqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01

> > > -   return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
> > > +   return tph_completer_type_fold(FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP=
_MASK,
> > > +                                            reg));
> >
> > Is this just defensive programming, or is there some hardware out
> > there that uses this reserved value?  It's kind of an ugly wart to add
> > just for theoretical spec conformance testing.
>
> I=E2=80=99m not aware of any hardware that actually uses this reserved va=
lue. While
> being cautious is great, my view is that such RP is bad =E2=80=94 arguabl=
y to the
> point where writing 0b10 straight to the device might be a right response
> (kidding).
>

Thanks for confirming -- I'll frame the changelog as defensive hardening.

> >
> > If we really need it, I'd rather read something like this:
> >
> >     tph_comp =3D FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
>
> This looks reasonable to me. It might help to add a one-line comment
> explaining why tph_comp is sanitized here?
>

Yes -- v3 switches to Bjorn's inline form with:

        /*
         * 0b10 is reserved; treat it as "not supported" so only the
         * architected encodings reach the Requester Enable field.
         */

Thanks for the review,
Zhiping
