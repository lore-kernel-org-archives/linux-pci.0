Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35648415F36
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375814; cv=pass; b=XPO/OybqNty174HEWHRatOQ4N+8ZDohLyElnZ+YQkylHTrasaFizPOnANc0CN8Rm6mVaxr+fsk1iYn8qMoN3Lu/oUkrKMlgYEZwp0eDDhaJ/mzfEoZWd6IOWVHX1PWT0dOv3U19ZoBp6psQW8SRr1el2kecIDTFHNgGtc+d0sUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375814; c=relaxed/simple;
	bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSb8gluZSeYQMPFBl6qGS3sE5qDmgySX1jJFN1MTcCYhHAxPBeSSmqsOt+PPZeg3gRvl4mFyNVip1jfEYGz/t05vsC5d1EBXVVyh8p/Tw1FG+lo7iSNDF42eWbSQ9EH3eo9sWSO3dv78ajVuiRG/J0y5bsPmW9MCkAQAEyp3Nvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVcAMdwb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gIGQvN00; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVcAMdwb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIGQvN00"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jAtg543533
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=; b=UVcAMdwbCwVGAbCV
	C+sUaDdDX+wSQ71/mmFXzE/+9fIcAZHzaY3fc/XfdVRB0NaaSP0FTc/4MgstqM9i
	si3Mf9Gz0rfrpoHnnL29Lxvcxul1FW2q/LrvaZU72WTE22DOmEuQqcE7sXLJ4nql
	RysRQcME7N72Fq8zodzLw0YqGXZ2HPtP4KN3XlDFAS4oTAGE27DHd+3Q0Sk2mdgr
	HcDGrJUw0yKoh4BLXGkfEu+jYFQpdNDIpOFZbGCEpjO/fzR/N9wHNjb1GT2HOSFM
	EAD5UqdxyBLXVJwigrgEiRRIaaseVJ8EKkFKtcsk1jj/AXalu8ePqYGRZ5iV3fBL
	YOVQAw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k09n7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936708f129aso451306585a.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 01:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375805; cv=none;
        d=google.com; s=arc-20260327;
        b=JUHwrNF2Umf6RA2JdfbMLYCinA4DTsLLTkStM0A5PjasVuIZ6dc5hT00f9Q/iT4Fey
         udi3FNKwpBM6CpYkUr6XBLCU9ThL521n/qX+oRgCTbmIxYoy3duCWG2valCY5dQxvitz
         X5/SUU6p86sYCOAd6DiX+EcAcdMr8vp2NpYxmD5xEIVsPw/QGFHlq1oooSnjmGEjD4aZ
         qdv70Lxi8FkjcRjE8OkCvAzTRCoOAODQVjn+fSpUBaR2faM6ia5obh6JToy8CRAbJytm
         DA+ByEcGCYQmu8CLLnBju9vTMhq0e5NlCp4nmQw/KaYbqId6MHnJbi5U9MZSl3Iq5XOl
         8sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        fh=i1Pg9ExjRQASJuyWXFrOOFPWcmgajx++wUecZPtr+pQ=;
        b=TbfZKXgBc5dDsLx4qsdxi6EU77m17eon0DrCCUGAbEEbRZmPutyrPegczZzbtpoHgG
         xACCBQ0JKBou8EfLAhajM0eaS+MIK/MoC3IDPvGMCshn/u6e9GJWieNCEcopYlM0Fjk0
         T5DU7OocuavDtLQRyx9f28Q0JE28jOnjAQXRU1f3ehFktCpFHRhBCHF0Y4RyNWNMKiID
         JeHmxVX5dLra1Adss5e97+Sf8xEhb1MwC9Ig/r8AzFpznifUQumWkYV0IvEIi3Ppx0Qp
         /QAkTO6qm9r1iDo2qS0pl0p38MieyagXM/ECk8l7SgTdR0qMpd6dpKVrGS3i+AYj9pfK
         1PTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789375805; x=1789980605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=gIGQvN00XlJLIlrGcPqcLt7HHVIulIL64nwmJTXgneCQNFjmVn2g7wEZ0fzrW/2l6z
         kWff8ehsldkj4SlnTEFMq4A2Y5khFOk243AzI1o32GikMfmaI/v6Wr4i8ucNS7hfqi+K
         XrfUGRYWYxejsZnUTEfYZts/yvygqON7vSF1pCF1ecI5d0Q6V+uBcZ/4n1roS1CunWDa
         Kfc3IVJj8wuY0YvJbSaJdKqNedCMlP+fyzM5eKJNF860nauB7TM7Q8MxFXGuC598OGP6
         DUmtJfSQSwmIZE6QMQ1wXQ1UdFUVYgcUh+bZ9CYZO9oF0PkUTGcxCJ9nmimt1Y9mksjF
         PFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375805; x=1789980605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=AGdCbATBFjmq/KTdH5NQwlGn+9/fD3jf7gaGZYpyu3pDhDoHNYe8CuA2j+GDgR5GDW
         4Q2isfcSeRXQpTTvGl9C0wlwQ6oj5xVdq/xNoVBEbfDRBv6Oehx0Y60rskS2Q1zT1BYV
         qvIw3kEHcx5fSBqpzJtDMtg210IfqpP9HRpxlHXaUrZvkPWsSSoxzwm2W/4sqEhPEdvh
         RxfkDPg6RlihdDI0cfhlrB+utS74fOmPf3SrNLUYLRsMvKHKBzMMGOG0dHm0CTigTP75
         yKKQxGL0RO9MJk/e6uECeOcB9c57aEom2eSC6mJzrSRNZdKojJdQ7/tlXTccgXsAT4Ta
         MgnA==
X-Gm-Message-State: AFuF++lB25gIgaRUc4KRmBGCIaLPbHk5+Yy53X9Ipd1jfKhZrUmQfek2
	XBCa0hHIIm4deIGVoPamztqz1iiTCLYYNi7dOqz5ElwKYPAAHJn0I/lMrTS1Nf2E5NWhSlamYH5
	4pdXIdCuNKlS4aHK5+Wl4OC3O+w68LNcJ0PwAbAlqZXNBpCtUMczeoShTTWzJkCIQ5HwUrT/iL5
	f+l1oRHBP1bFI6w2vY/ZnwFHc3p33xoir+t4iO3Q==
X-Gm-Gg: AYBFou0ER2QQ7u9JhLvLYj80cVnrmKX7tsFk/GwbocKDs/MFYP7Fkebx82hJNQatYQN
	6mzdlaZmV8vygmaqMkCP4EM2UT+2ZOikf4bkkTvHxnF8yiL2WVaYGDcplz8QGQfFmKxo3OlRmLu
	8FVylH0WuYk3UQRqqB9OGHWSWEdLqKXBpWCY5BbqwZEKj6QFbQZlD+1xmmhW+Bt9cFYdIzt6CpF
	HVJOLh0KcG+c57hCyP4qYJsHxJEZzsyG9vWU6W4FzDmiiyuuhxg5U0BdIRm+Y26eCyypoWOtQw=
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id af79cd13be357-93a2981322bmr224907085a.18.1789375805387;
        Mon, 14 Sep 2026 01:50:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id
 af79cd13be357-93a2981322bmr224901585a.18.1789375804889; Mon, 14 Sep 2026
 01:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com> <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
In-Reply-To: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:49:54 +0200
X-Gm-Features: AcwNN1VznECsrEJUnLcouEQxxRZWOhGsAh6qOvyElwlmFiNZH_egy-fEq4m3Sig
Message-ID: <CAFEp6-3gD0xBJZOOmTw1MBex-DYo99MXHsQr_=uLABMHdSjaVQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfX+dqBbZuF3bIN
 l33gSel0yyxVsYWpmBliwAEts1lhkB4tJYruAYBqI/krwg8euu407WtMvMA6eW1xufQpm3jvJWe
 KWiEFbGSgJjVH/FHtxJ6KXbZWpo0Gyk=
X-Proofpoint-GUID: OkLqj_ThHXujPLTqHUtTZ27o9M1Zn3a0
X-Proofpoint-ORIG-GUID: OkLqj_ThHXujPLTqHUtTZ27o9M1Zn3a0
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa7b53e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=et7816VZQgabzuuDM88A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfXwMagiq2gcb25
 XxDpUrqHnb5bBqQJ9nwgKh3oBpwXXKLMc4ZeUbLaKsZkt9Oh0jP1u3PgXLpE+YgVxVV8VOX9FrZ
 /OL/zadMkmoqoPMZLGKoqm0kehHHdmpWiUHRISuBaOhoX7mJiAaIh8QlpT0bcxa586nk6IFm/Ev
 Nnc8qH5lay+LYQhJwuvNyhgATtRBzeYOTklDBKCDUoD+uiJ3uA8o4RknhJsfM6bc+O+Brt6D2y8
 9iDN6hYtxQtX+LetzfrjviZqy2yt+oAW4KFejDOqqyRlaEpY5N+e/BFlbmDX9l0Mt2mTZUO/DLy
 RpieT2LJUL1Zrmbrv2FZLa0RhDdHGkpzAXWwXwDjWPwbLDZQBmdToLuujaQH4RoOzc9BiDDRnr8
 S3jBmEWafC0gMfIA7J86nrnf8oyVI2HHwEatNm2IKiaWKu9aYrmCrGhjnUmWeacboBefil+pD0B
 OaRh8nqapYBM/9zIEAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140125

Hi Luiz,

On Mon, Sep 7, 2026 at 2:50=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Bartosz,
>
> On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> > <loic.poulain@oss.qualcomm.com> said:
> > > This series describes support for the onboard WiFi/Bluetooth module
> > > present on the Arduino VENTUNO Q (monaco) platform.
> > >
> > > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > > these pads are populated with an NFA725B module featuring the
> > > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > > the design is functionally compatible with the M.2 Key E.
> > >
> > > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > > signals, as defined by the M.2 specification and handled here via
> > > the pcie-m2 power sequencer.
> > >
> > > This series models the hardware using the existing pwrseq framework
> > > and connector bindings, allowing coordinated PCIe and UART bring-up.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > What is the merge strategy? Do the pwrseq changes depend on first two b=
luetooth
> > patches (I don't think so)? Can they go onto an immutable branch shared=
 with
> > the BT tree?
>
> The pwrseq changes are only a dependency for the Bluetooth changes,
> not the other way around. So yes, they can potentially go separately.

Does the above work for you? Would you prefer to take the Bluetooth
change separately, or would you or Bartosz rather pick up the full
series?

Regards,
Loic
