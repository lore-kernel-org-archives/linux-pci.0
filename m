Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264C78F26
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946525; cv=fail; b=niQ9VNifroPBV0F0hGqBkEdtrQGFnCA0Pi43YS0QxgSA0/C9qMOGG8e5ZW4KSi4sDVjKFQt/JIJSI1b0lIVEzSQ2MXsk13d0L3/lCiyi2icOTT2J7AZzxMRbS4k941fez78XlW6lnasyJY5SAn9gJkgbPN27cMZ2USZsL96p8AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946525; c=relaxed/simple;
	bh=EnANVMnjWO2e/TF4qUwEkpjdrKKtkAxRlIBS/3wsNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZtoe0y2ogzctvcH49AmiflOxi89aMueZwGINl7y/7CRlVkyU3flZaWZY9XRh/9YFU9FxHQrMf1GGR+xIs88NPWpu8wMcU4szeWF5anw9JCevREtIHWVkaWAYXBqKSbkXwK3Oe8NzcSXH5sznWP9YagTAIVhOZYtR2CLN1Ahg3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bg3I3NDv; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bg3I3NDv"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S3A4bF3720102
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4PCAVqJEOIY16WjmmTqer3R+L0JDJr0Ts1ek/LWm3fc=; b=bg3I3NDvy6FE
	iPpy9G16MrgkS7tjdaK4pTBSzqZEYYkSr5lSf8zBn87x/6ztIBfNAOzJnXbkITnP
	VFaM/GIefnYWYt6TOhjePYUTwpWHC8tb9G94iars8MRPC0B3+3Bv1ehGIH2uF3r9
	X+cCM1mir88Ht7erbVTrSkMQLajLsqaX4Ka+CzlrYNI/+3xJEgpfsUb0R2FOT8oP
	C+oZphQuk8kWYB+GKsZEiR3QK1YcNTIkHoPt45gLIQZGmdCOi/qzknAC5w6RIfgQ
	ucUNMGl3JC8eLuPUn4MPOudkHIaVMon2NrKpJ0qR7sanUhqV/uTqc+2Jx6QeO705
	BV/ccfW4zw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x8acd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e666c30bdeso2511874a34.3
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946521; cv=none;
        d=google.com; s=arc-20240605;
        b=j7WXoslG51qMI9R7xpYgCyWRwW3Qz7EP/jdbdmdvVB4ZanwG5M1HIzfMe5gHwQnitD
         E6PCHQ8Jac75kjMGFf3nIwfejgw1VAIfWO6FL4LQhOurPcMCd1Tu3N4RnF9barV+0MML
         sHPyti3LEZooWEqLZc0bIFb2c6V0vRSum7XHw1p4QjVr9RjMJoT2d3eECkZs77ujLV3k
         KW0XCEn87aB79CbHEqsz/ktWgUlIXpXzjDVt8oi9FDG9aLfa1e1vQZhQ32mlBNqfDbn3
         CAOQMJtw36hjTKi0RU3uwAoBHC5OKZfZPUfF3RtVmTTZD4ADaO6r5xE3OZqbNE07hKnZ
         4VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        fh=/ikTkK/T6VrvBO70BbRoXuvATrprAmYIGGs1ZJ75J74=;
        b=CsWIJhmB21iZy8QUOi8GGpRLOpfbQxtgih2Cn9wDGhGIpdSrqV2dnIScBX28BGR0QD
         T0j2wlrArWYBheifHQnaYEHGAB6cPp/0Bp9YJVmrtnFcCpoX+cNMBB6RUiRC2zUYetf0
         xXS5cjzR7WBjmU4xlU6iX4a0cwqAJ37ltZLntyTGhPYaP8zVPU36e1Q5oiqGgxUJzCg3
         siqtJ6mt4PO/ivXT7hTVBNyk68q17OGLLcyTSOXZi7t+TrwFd4Hi8sfS6nKMt3dCiaIK
         LhbuIF0IwKKy8PjdCdZWR6LQNlvganJbRxlogl8wq89F29fzAeKnoMc0xmGWecW7PD6/
         EaXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946521; x=1780551321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        b=R3ZmSzm4XDMiz2ef9bjnb2MVReY76WOT9HZhclPc1aKmKG/VkwML12NfwCAL8CBtEa
         a1bPySfnlCFVVgM7O7/89OD56blfMJEaTS4stN5JkwTcBByT+CJMPKTjI7AJ16xAVpGe
         PiT5Hp4/JYK8p4gWgKSAdRG590+bsU69fzKb+8JZNW5JFw47LCvVijGC9MXeOAPrBJlD
         M5aNVyD6DlBAUCr1JO2FoMpVzHijA5CCc1RWlErhvlrc3i1Pl0jo1r16WI6Y3cGe5gjp
         nO+LO9PF/oA37239pT5tS9R1z9BTEad22LuISzTRhSyL60by37MkBIeZw/P5/Fp3T7Ez
         9N8A==
X-Forwarded-Encrypted: i=1; AFNElJ8d5XEiRLconBKc917jg6s0qrAY9JBxq9eaIZlVMSaaGTv6momUfX0T2Vo6rakbQcFLW1HDfUugN2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJRE+XWXeHE/Bm8exmUAa00NarfweBxXjbBkeIFq11jgx+mK4
	Zjh8YqbU+Q5esQ3OZjeI9ORIgEPOeIIQ7KT+vukIpSPctRJ8+EeBTiyXQ/IXITUHHc7I2TYxpH9
	gOyYr0iJeCt6H8vLWpv8J9+bVtcnx5qifetR5CjyHbo5FsUeZZR2QOLo0jhHksYIfhK8RPIseFj
	MYLMPzLg8roD9DA5qpW2Oc8DSjAIggCZIHZTQ=
X-Gm-Gg: Acq92OEfoypH9HWHWvVNmHlUI/H9gdy5A59UkPBPDlUqPZv4HQoEmZ21eSiDwjITFsG
	X0N0DZ20UQIAnZauK682dZKa+ZoLCcGDEtUvzlBwteoPELBjtZ9YyzG9xKXHqoocvNdeOkkD0tb
	q/yO00e5yoj26162MYTIdo2+FMjkFJl5Ntx4L1vMDe+sLnw/1Y9Q3JE0ccLQvseeJF6fG0h136m
	e4Uqzp8uAywg/TtThMSp67UQtg2vBxyM1YQ8OxkId6N/HZ+T+c=
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7e5feeada60mr15174385a34.6.1779946521051;
        Wed, 27 May 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174366a34.6.1779946520637; Wed, 27 May 2026
 22:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260527145332.30412ea4@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:35:09 -0700
X-Gm-Features: AVHnY4KV2jkBImuet_2z0_HzyoNlAKuwWC1jyQGu9hjYNIH-m9ItRdizP-UfkeA
Message-ID: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a17d419 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Yn1Yo9TDUEbBsc1NC8sA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: WeHd_y_RXfE3GxmxNjKHiLfnhKvVLvjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX1HyZD6SRrE7G
 T237yR0eS4lL/ET+XzYzaPcZ38+cnQAB6vQtVyPDvuuiCjM/ggWUGB/p6yTECyQL4wIYDAozDx2
 jVPRCLFG09t2fYOwMoxNf5cgpFPaXH3zIDrogD87DoFqm36moeNA8kq0Tsc53dFudg8mhysrbim
 7WGduwRZ3YmCIk7rrRkayHwVJIPt/bhkZyX4DZLNQnPWpCLVinDzxvxcBKih2myUJN2ZngxPcIc
 d/4tSREp30cUjpNweNmqbhPv2UNGmfol3No56Mp8fU8jvEkoNXmvV8YQIBaWiMgVRv6nOXXWjRX
 zYS/KDvdXdsAg3aijK0PNoq6fJdhl6LUFP6bZ39QLeTImfkRAgdCrud5rx9yFm/Q0WX0cSMTFeP
 P0W1GDe1r6IBSkTr9dt60z5MiahSPM5OWhFMXv5Xoyz6ewQYQt5LwJgQ3be7z2kdM/BgMD+cxW5
 NugzIKpCetJ/IOVkCAw==
X-Proofpoint-GUID: WeHd_y_RXfE3GxmxNjKHiLfnhKvVLvjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01

On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 26 May 2026 07:43:53 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> > !CONFIG_PCIE_TPH stub for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 12 ++++++++++++
> >  include/linux/pci-tph.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d95..6c4492075ae9 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
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
> >  /*
> >   * Return the size of ST table. If ST table is not in TPH Requester Ex=
tended
> >   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index be68cd17f2f8..fe572737b409 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >  #else
> >  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >                                       unsigned int index, u16 tag)
> > @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev =
*dev,
> >  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >  { return -EINVAL; }
> > +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { ret=
urn 0; }
>
> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> Alex
>
ack, will do.

Thanks,
Zhiping
