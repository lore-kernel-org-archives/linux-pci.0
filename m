Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC423392C
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288093; cv=pass; b=mGdcr8JYOepzK7Qe0u0I3Ts6aceqqqOx0a4DCKIellwq77oQNruLjFyXexTqrwS9YdKyr4HwhJhkxW4jO6PNjxDgxratZGLekk3OYLLtqz8ajXxHkNmjT7YDEUQ+FlsWiHp9aTdXSrBWW9HZXGYQQZ6URK+ckdGrqx0wKL/oWKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288093; c=relaxed/simple;
	bh=xbUg8Tez49Qym/fFbF+EEOQeWpWM0YvZSTU0Ng9IgYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuB0x4R90933Hr0atm27YwQckYd+9HXwaJMW45b3Syv67+idJLB5ObQmJ8Q/0XisbMhNheJkAGNedfzfA1VMM9FDgTtXEiH/7y6YkIwl/XI8buOFgSngHhKTNkJzj86rmB4BboZZoF0GsldH/QH6Qo0a/HH4juTxbyyqE+SAS+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx9EpT+x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+upmF5H; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx9EpT+x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+upmF5H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDXvET1798612
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=; b=Gx9EpT+xa8pxdOq0
	XNYzY8kOQM/Hr7PLVClI3TM+OYCo0nTMERSQDLo1l0XIQ5UtfJCa9gm5SY8Y/toD
	GJf01zTFg7pUDWODu/rb3SNSx94qWl4lvo6jSUNerqpbaunNf/SZaPd+nDYOcS1X
	GEXzuRAith+p5H1MSibwmmth5SpzYTLEEjrlfrEU7DdncBJ7wyM8L2Lic0+MZq6E
	CLMVnqOsRNHgkveL8IzMTePUzoFN5jt+izlZdzmb3RNJV1+swrowgRodrpcq1Vmu
	nMyAxF2xMLnQCG5Du+CNzVR90Xcc3Is3KADZK1SOH2BznSu2S6oOHJVvboRkd+is
	XoPjZQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu08ac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:41:31 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-43a356e0119so14055034fac.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288091; cv=none;
        d=google.com; s=arc-20240605;
        b=E/yv61yDSSWXXwQ/YpNLxkD+W5krQSND9qGAIWNzUO6jb2z9pzGJoae7tS8Lg4rht4
         /XDoKTdbjIbOT5y37SqI+t/9mh/d0nh0Bg4ljGldB7fa2d6AoNooCisRZEvOPE6D6mVu
         isdyaG6QGflGPFMg8yHGqzbCv9NLjXBNOTFLNzEH3H+sdgEfPL9RLG/4guvVgLdQ1mpf
         pyzxspO4Xdn6jiW7yuAJht0Q/GroQ0Bn/T64/0IPD31qyYmCuzhVEsPhQkLB9Jb0hIuK
         nikycwrXRuv5wY4VYaLC9NLVZDBd0evrfFzXFwqI7g1VmlxcMfjrq4+6ObbVNwxemj5d
         3w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        fh=24zYT9dhn6W8LS1gldVaOKX8R0hbn0E/EYgBuP51K8Y=;
        b=alVnhLLN1LEQzalxce8PItaigAZke+/lXsnrMUVg1TWAbDSUE4QHdFB2vt+SpmWJEg
         hbragb9BfSXpiJ4WOzPrGH4H9RkX8EbPZk77zCo75I5zjhHlHiJmRE5vaVALwRJ68CXI
         ULsFo7FNkNctl+EJ5reLNS0wdzl3GLx3Xw1AkBg+InpE9godjGLyjRb4ljnDfcRSxCDs
         DiwaHO+SED/dnigE2l9mUvoygj84akOyqOiABVRRmkQiB6/ikPZndKtEGK95vxK5pVmb
         mBwLXA/CkQJPjeDWKn7QRjWBSQPmMzsiFjZttioJ0GmGMODsVr2XAyiccDjfQHwN32LX
         f6rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779288091; x=1779892891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=C+upmF5HsRq0cE+0KO8ZioGMSW4S9IVDtTUGzIAf4rCG20ipjBP+gjvObtW5VLZ3US
         RBf4UmQ2MnFgCZDQJRJO7OP1aTaEHO8PbpOFTC6fkW2m3EgD/AYG0H+c2/J2H5MJTkOy
         uT9Mn2mao2yyae5E7e5J8O+yqumrVBpzckZ5j+vHPALrdnStgyNeeJlApKMdUmW2NqIl
         /5s49xjgaIuTaNNym0QoN9Zu7wjKiJDvpI4NLfBupSqiTAUc2U7Lqw+7fHF8OTBb9OuC
         Qw9mbGoM527Ry6lecomVoErt7LMN74vNaUdrISWXEbYYWae/TLDsTVAiBfI70mZCnYlM
         iIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288091; x=1779892891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=XFre3hakHjImGOSI1ry0Fe/tfXsPqrE0ZdPNx9TRmcQXFnKqcwQvCaAwajsNL6lQob
         UtOeY6sIf8n2o8NeiKkuhdbVM2Q/9ssU28oQ1Br+MypqlNniv5i7eygW9c0AxZs+cQ1j
         xDNmVPiLcBMX6rBlCSUHqr197mPJQFxeMGHUyOWZAlRImBtS0qn4UEeCVjl/06ER7g9A
         N+HIXHBHEpMH1Cj1MRIUR/evoDiIwjqp+vh0SUsEdE59vQshcA2cHvc5kVmImMk0Z/+Z
         Toj66CHK0XKV/vybN8k8V2kGUwdqYajr1wn6UdZnYbYX0TSr+eQuu+YMKPJQG/3YEnSi
         FxNg==
X-Forwarded-Encrypted: i=1; AFNElJ9JnrBQypHkakdOAzf26hTM6TTEtqfGsq6/x7opLAzSHv1G5pFBUjw5GZEmLjTLxCdVxgkN/UkGxao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoS85WfeMQVCogo+FnbiMgNIxhqMxS2fzsoi7exG0LkpRHP27
	xPnMcyvPyk+JIdO2YAPrV+53DiDvGY2hQdO5vftGMIzp/krC/QMS2cgNycRNSuW+NB85vnG+MxI
	hmPeiR0jNEoVt0mqwknmvZuMz1X+Hsn8uDexIePa7akmFy/y5qDDXa3rYhdR0CFDfVkMOT29WMf
	KHXWP0ypK5JtqPxQl4MaEu7BRo87XGZ6CQiUsYhQ==
X-Gm-Gg: Acq92OHmIH8U3PFpFR+Lpq71Y9+k+Di+No6Urt8gGQw0AVKw/w6bmswdrZr5RKWLZ3V
	hCoUiNrkL0+HgcYxCtamP3tN/+xCFxfhPiZHNfeK3Ot1he9gI0gkYqcPzTiqd95RknYa0lATUcP
	iIB9Glrxa1PaUsDHzhVglR7/MzHKy37BEqp+um6QtqMCcFOEsjryE1pxU84IPSp7WigxQNGo5yu
	IcHbQRzMm2+nqprI/Egr/1HROX1Z4dY4pZ4lhM=
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id 006d021491bc7-69b884ac83amr13326880eaf.33.1779288090706;
        Wed, 20 May 2026 07:41:30 -0700 (PDT)
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69b884ac83amr13326862eaf.33.1779288090260; Wed, 20 May 2026
 07:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com> <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
In-Reply-To: <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:41:18 +0200
X-Gm-Features: AVHnY4KjiuGhKKWHmCXQOioTVfBJ-iXDUnzJmiSH1aWxruwXcP1EGQFS7-tjBSA
Message-ID: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX24AhjFW7Ma8a
 Cgids1EVs+PBSKr2HYSMAVefQ/tOc6c5RaNtUSrBZcwI3LXqjczThuEMXCl0Cgln3gG7QMagwsg
 56zd0SuuHBcip3P0gI5Qj62zEFmqAcas2z5RHn47fkcgVeCDk3d+IZssfxU9O7P9ODw84v8Gr9q
 ccV14Su9nZj7T9bDL7s7cSLyKI0RXbFnGTO+sy7cEll4dJO7pIh+oJAnT4bIC0M3leFjWTXU6Eb
 rmtS1lnOvfZOCG/kQZIeUSVOuHx4UCDG9OAzBIToY1sY26n0S0b8GnXZRo0lX400TAYC4kcP0QA
 pjOSxgPMVbzTLYCMDaLpg7SAQMO+E9hAqrmbUbB+IfumFypbUhbLs3njWzaA0FkJljlbk+qkptq
 AqI7E6Rz19ztdfrQLwF8K75dXoIdC+SHBkODcXxfBxmwnSyV2heacXXHIxw/wGVzSUXn3opzowz
 aViaw/akiGEQpo6GiOA==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dc81b cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=QwjQxBKOi-_Ocnt6GWoA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-GUID: jc6TLsJ1pEExb4AQyPJmOUW5hprHFUlX
X-Proofpoint-ORIG-GUID: jc6TLsJ1pEExb4AQyPJmOUW5hprHFUlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200142

On Wed, May 20, 2026 at 4:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
> > On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > > > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > > > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > > > compatible with the M.2 Key E.
> > > >
> > > > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > > > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > > > the Bluetooth interface.
> > > >
> > > > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > > > the pci-pwrctrl driver can acquire the power sequencer and enable
> > > > the M.2 slot before PCIe enumeration.
> > > >
> > > > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > > > (gpio56/gpio55) used by the power sequencer.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++=
++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/ar=
ch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb=
6f07244d185abfb1976d9 100644
> > > > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> > > >               enable-active-high;
> > > >               startup-delay-us =3D <20000>;
> > > >       };
> > > > +
> > > > +     wireless-lga-connector {
> > > > +             compatible =3D "pcie-m2-e-connector";
> > >
> > > I think it was discussed that LGA can't be an actual M.2 E-key
> > > connector.
> >
> > I am not sure I followed this discussion. Do you mean that I should
> > introduce a dedicated LGA/vendor-compatible string in the compatible
> > list of the pcie-m2-e-connector binding, or that LGA-based designs
> > should not be described using the pcie-m2-e-connector binding (graph
> > representation)?
>
> I think, it should be a separate, vendor-specific compat (maybe using
> m2-e as a fallback).

ok, understood.

>
> >
> >
> > >
> > > > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > > > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > > > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > > > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > > > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > > > +             pinctrl-names =3D "default";
> > > > +
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry
