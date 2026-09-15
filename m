Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A414756A3
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514870; cv=fail; b=mkZioPFV3aqbpqCZbeLqR206LxdL+PeCULSw+qLx1Hvl7ztYyLAn8U9pNx1ouu/vrA7qrY/Sv+8hN6XoENLBPApZmRuRgJDLi6e8EMI79+UePbNVNCxlzEPddDG73YU6D4NjVcwrvVqBq5X1arv/TxNebWfZW8iZtRJMOCmKgTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514870; c=relaxed/simple;
	bh=660xTiVCFMGhryydhz3t8ZyEjYsku0AbA68go+LIyfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glEKlXCmPz0Xpb0tZAr52Wyf8/gTGGxdRCorYfMHsXyGUVh5lJEhOjXKdDbSO1QiY6+TjUWidFtC7pQIOB7TlEv5bPhFl7MSjlEmpjH/ZZDTtFlbq/lnSlls02Ubc9mEc4x8OWVlyUlyE5/d89BDsatswJzN3ARfzByEY38BKOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=P7LdrCN5; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="P7LdrCN5"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOVnh1502664
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:27:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=puTYzaznhw4+fIfX1uaMmGMJC1CZW9OyuJIqa
	VoOjFA=; b=P7LdrCN5RlHrQAwR3lh1Sw42HEUBPv6LyCl+r8hwB62t5uwriMQbD
	rm3NHwvD0PaefgR6OLHyroy5wHF4NVm+G4W63yP3NyZYHZWKoV3mbJ6JwD/WzgDa
	RCeXKORnF3xngXyoH0nHuBfJCW8zHXhDCn33h+JKiHawytHEapppS8dI22J6V2E6
	w+wP3sWCpYGwv46N0moEuenEzZJXV3cz3DJ4nWBpzrkR/rAXp/InbRpHQnm4a4Mq
	Krw1zm+PNYoHvCoper3L8ztW3x3PaHAyJrFmTd5OAYW7ZeVhs4ef8tPXRuwdBjYQ
	kousKyfTwk1c3s9n+5u7EB3H7XOriOxrw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gqbx8hnta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:27:47 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-80621874eb7so4772296a34.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789514866; cv=none;
        d=google.com; s=arc-20260327;
        b=GUcMeti7r2cmOODG8jO15FPYLOBA633J4EhZaH4v7Zo+utyhyPM6ZHAx5D5uTCgtfC
         Om/saiUnUCvFrTnH82fOBvPQRQpuD1xiMdxNoNKL157tc/G48l7AJks10ocaAX3aSqgx
         NK4a5f/cIjry5ZDVnkxpSlwKQHwfrNbaOTmcQfGypfRMZytKXNM+jxKOU45w9Fc3YeMs
         l6HR4kvLtiaWDp5JZdFWAsT2dTOO5OjdVJp6fQByKbrGS+W/lKelaOF2hKA0sQDttKXr
         5yh6NTXw62ZQF+DFpeavp1biZesc/r9Ld5cK2ilLHdly6uqHPvEvADM1GkxboPad6KkM
         Ia4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
        fh=Fdg1/zjA1XiCizpa3Jd86oa4aukZpjlvYiQ7XoYDW3Q=;
        b=YCzBEFXagSoj1psX8EvuwV2vlQVxgF4rFJTRhPJD3MNs04zGnyQVKDf2jKUr1yedEd
         J2Spgd1z0H3/9TjkHNPTs3sPCHQPwafajQLk1OubwPcd5o0fN/13qGJXlGuWsihH+k4X
         3CDGu+7Z0qDw4q+n9QzGWrv9NiJSs28CrV/qRAhmefQ4y+N4exX7ahchy2mJQQFgbx3m
         pKQDfsPVQVlp0NvYPygJqoEZWWrXNvG45JKbFk/u+4zcVfpNzs7Zfrugz7KEDMMTIg9K
         S0VpA8P1qoyAVXyDQmv4m+8mDYUyRnKr/+gkWytnDai6whks82j8NY0YDqqTkKMfJGXK
         9/yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789514866; x=1790119666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJKC0cK2PwsxosA12SybEYsbNkrOGaDMLHL+9hzWLps=;
        b=EW58/TeYFDiwpcwvC//W+kFj9PNpkgkj4elilpPUGURXSH7VZtKiyZaMSTBwP98XqW
         YBN15U49P0ufppo1b4AL4Zs8QdZrx3aPHIdVjj+rfEuL7ousjIGf95hEt/uKv6dyVe2h
         nk8vtzt7/Gxp/Os6xcwl6F+x3B8Bn1+ejwJKymNzc71vLaFtsMXSqRCp6B03zcgSnh0K
         qlDgQekiJZM06RUETnz9Zl1vbiM87zGAazcvYrmgja+DOA3hP6LsMumBRrZ8BqE5ftB/
         P3VMpPXNLYkUZcDN5KV/iobxHFiGTEEe1xGow/5Jlx6KV6t0y0AbafFvlqJheQqbgtab
         ZecA==
X-Forwarded-Encrypted: i=1; AKwUvBxqi2IlhSl2C21+c6gC9JoKaPphqlfmz4YCgOjlWqon+eF7iTp3QBwAPC4Y3nsGK9eg2OCvMGPlXZE=@vger.kernel.org
X-Gm-Message-State: AFuF++n2c+uR2JyjSdvzcpiDh4WZaP9xTNUhrd4xzrsZvt5daWDk1+3x
	X7R0svYQ5v0gygB0HWrwxHhLEYeiCdBVBY98OVsLzEgC+fm0tAm/aXcE0K/4cbffNPGJ+lLmc+5
	hwYig1Clc9WBQ1hnRbN5et5e5sSUd11UcIBEtueHrTzc1Y4qYu/xs4QmsRl1+RJCPcusnhWzX78
	IysC6ih7nZklqFod8ssr/f7jFP8nNIE6bX/Cc=
X-Gm-Gg: AYBFou1qyMe5nHAMKdsjl+lEGmN/O8SIp57DvcoVCxQsd3YQJm6+ksSK1YMkf2VygrK
	QstpiicOK/NqgBSn/ON4rTWknQvZrd1XrXTdP5Cs6+u+pmA/lStExnpfKEvn+eFS/ms7oly4Y0i
	C+8j2VrsCYs2/YdEk8UxFpaqys/V57CKtpnoNxiJuNCX+2iZwCgOK+NQE68U3c2pyLG3XEfg7h
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id 46e09a7af769-80b2df3d962mr1439118a34.9.1789514866366;
        Tue, 15 Sep 2026 16:27:46 -0700 (PDT)
X-Received: by 2002:a05:6830:6602:b0:806:75db:bb32 with SMTP id
 46e09a7af769-80b2df3d962mr1439055a34.9.1789514865867; Tue, 15 Sep 2026
 16:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-3-zhipingz@meta.com> <20260915222303.GA877199@bhelgaas>
In-Reply-To: <20260915222303.GA877199@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 16:27:34 -0700
X-Gm-Features: AcwNN1Ur2HGTwLfzS3v5GCfBM43O6loZu_h11eJ9ffO6Ol-LlJuiRokJ9Mq3XW4
Message-ID: <CAH3zFs1hpotRvvTziNhSSNR1fLiFekSAMCA7oKsNJbobgeckRw@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7265tVzqXWDOvvoxEokjfis_l_NeNL5j
X-Authority-Analysis: v=2.4 cv=NKlAaE6g c=1 sm=1 tr=0 ts=6aa9d473 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=B6l6obb3YNMg1WPjzLYA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfXz/IErNtcxDFr
 KrvE3DrdwG6XGw2CMqAGsruVu0BF1ZPBZRd5ZfRzzo8IlifPlOnAfuVuiDsHoduAfsrmHkicSQt
 4zASDd3KdZv7cJFBQOeJ66Yqim26AEo=
X-Proofpoint-ORIG-GUID: 7265tVzqXWDOvvoxEokjfis_l_NeNL5j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0MyBTYWx0ZWRfX4ntzxRLuX+wV
 uIlm8Vj5xQohR3pIJrQs9jCVT3RGT2VEVP35Y/aBYrFv/rmbVOAHLVWg7YrQo8M1er+shHf8NQy
 ppCZ//qqseLnJyBItwzTTUVGlzqTU1CJSF0f9kHZ8xOXZi2qH/pfPZkiUWKJO3LmK2YQhUVf7+Y
 8yCQ7UuTb1mlwRkSAoXMZQIoYvuOJSUX84KdkdfCKGQ9T62RancSbd9QkwUiyLvId4cQtILSo92
 vbVMdquYhD5siFAUzo3QlvodzL5cQhTc38wLHG36pid1v6+JlAjKZ545Y+8ITO0CtdWN8OJEW7G
 s7qO5/bmKmZto4z9P1A+UmFII1L7yyw031kz0kYVpVTxzT1G9LTZxGbn0kI//0+/Xyt/hwESrFw
 yYw2oLDbXhprTjsuL0Ps8d9ShxMekWNN1A7X705uBsEOY4Fj2zGNP/9q37Ae9AMhOntRopzvYAa
 PL1BaODzpZJqHtn1vHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 3:23=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Fri, Jul 31, 2026 at 02:15:49PM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
> > device acting as a completer can gate on the "TPH Completer Supported"
> > field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MA=
SK)
> > rather than reusing requester-side state. It applies the same reserved-
> > encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
> > value never reaches callers.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > ---
> >  drivers/pci/tph.c       | 44 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-tph.h |  8 ++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 5cbb381e2a02..d0202ff7a1b2 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -223,6 +223,50 @@ static u8 get_rp_completer_type(struct pci_dev *pd=
ev)
> >       return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> >  }
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> > +/**
> > + * pcie_tph_completer_type - Return the device's TPH Completer support
> > + * @pdev: PCI device to query
> > + *
> > + * Reads the "TPH Completer Supported" field (bits 13:12) of Device
>
> s/Reads/Read/ to match other doc ("Return ... type" above, "Write tag" be=
low)
>
> > + * Capabilities 2. The reserved 0b10 encoding is folded into
> > + * "not supported" so callers only need to compare against the three
> > + * defined values.
>
> s/The reserved 0b10 encoding is folded/Fold reserved 0b10 encoding/
>

Thanks Bjorn for the ack. I'll incorporate both wording fixes in v14.
The kernel-doc becomes:

/**
 * pcie_tph_completer_type - Return the device's TPH Completer support
 * @pdev: PCI device to query
 *
 * Read the "TPH Completer Supported" field (bits 13:12) of Device
 * Capabilities 2. Fold reserved 0b10 encoding into "not supported" so
 * callers only need to compare against the three defined values.
 *
 * Return: one of %PCI_EXP_DEVCAP2_TPH_COMP_NONE,
 *         %PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY or
 *         %PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH.
 */

  Thanks,
  Zhiping
