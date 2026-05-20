Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3F3EA979
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287396; cv=pass; b=eQuCMhXKjIskJuTFzXiQSU7VrQKm3BzpQL5SaQCwKH00k3v3Jjfi80a0Cmazat94ORbUHROd11f5WhgQEIOY8y8qdHNv9xSu61zZK6mF/amkdvCnMPfQbYaXjd/J0CYM0CUMCabFF7LWEuoj59AMfjlTbCM72zWbgn2us5HtUR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287396; c=relaxed/simple;
	bh=uJ6ceiQOgOhCZfY1iBogXOpFqQfDep+SLyd7qBiSXHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RREG+ElIEy9dI6YEQJp6EoY2E0uaPcSvtV4EyHlofTNei4QCwQTMJiJB2O4Vx5fZntgbjeI5JHHQkXUdwwluM8bUZyRfSopOS5+hAd5UHUifsQeoHKzMS1htnXbWv+K718GWoF7UhrQbysoezpiRvTo0RijFacw/LwjYplwRb/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=luJfri1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsLs4rV4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="luJfri1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsLs4rV4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBZhFN3085238
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=; b=luJfri1qCnaB0Kjj
	UWrcYoJTqlDFRc/7zTCpwCArKH9okmWvuSK2c3PJRGBpIdrHd3rUxBmvOG/DGM1N
	ZBZKzqGrmZykPnePYtJOf95m835cGrX9v3dp2ciKbJL1DYyphm/I1TcWQV1dAWKg
	SFuI9sLqPCFZpWzHKEz67xtpSqtKFXaB7KJLONUUVg6eRRxIgFO/8q5TcaGdThhN
	/BqkBeHGsbQgjjKxQ5XzXIvtn8h+OjaGx3ses14mebDDvOELLFMr1rbOi8F0UC9g
	i0E+iX+TJFBeHtkr9cSTbQCcTjHAcBuOWTeX2CE6UIyQHzsgwjSMS/3hqFD+Uclf
	F9wiNw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f0mnw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:29:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ca1295e3a9so61815116d6.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287393; cv=none;
        d=google.com; s=arc-20240605;
        b=irpouPvLHz7lpp29+WsjWfEXNMmgeldq9BjN21+kGnbQzycB85AUPHuvVTSDSIrrTa
         fm0yftQ3cymn+SHUXQ8hrFAaQD0MUp3DCl/RSI7ia1SqiBstxvLb/FhOQwezQkdP5l1v
         akpeK33iiXrm21MdRDpshE4A6f/50/cZ3v+dAI4EHiPPdH4UexdNdcVGJp+hXmdV+Ynj
         jMZf1aaD8pcl64m4L7TYZY0+ftBIcE3g/DbrS6ATrCknkjOsCQL9dAu4c4riH36XodES
         W0YLptzkXvkHi6g8mub7m+xB3hY5GaiYmePlxVgpEcRJgOCqEO5w5Td5fEOw5PqaRgrO
         x6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        fh=yK0dB4h4WXybHOonVRPDjZYL7MaSsPccZzBsCWy/6mM=;
        b=cf0+Lko1PQvdlVGW0u3438t0aUbo/StcQmCA+yBoAJYnYBhqC5BzDRDoNPWVQVCyyx
         l71+FN19mOyIsfnvBUGS0lhq77LKlADWZXklwdAFIsJ/tFxWezhSy994omXf44lpmsSA
         MXiRvfjsy+qFVqZP8dsuVCQtowggIVWwZ7rO2Cd7HLm+ZeoEu0dVHx/g47b5xOP/JC5O
         fAP/UXx8OAcNudNYAJbxvoHTuJUknYM7uGAsIRjFoONIlJ97dpgGvb0PreR2/CBF/q9k
         21b6DQ3vagst5XC/o85TKhSxa7V81otHLrAcRI7c3i+fPC9l8Q+kX6heDvtfSwWo8ji7
         JUHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287393; x=1779892193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=OsLs4rV496AdoRsCxEjSxv7ldhYiiUwF0T4Dt1BANAFnOW5C8fKTAwGoMIs2Sxre8e
         PK0MOerharEiXS+SHvQgBjlilne6DUNq2ZW2aSeAoDrTUyogHNnAKXl7WuellmtS3IDZ
         M7ObPeskTWj6FlcDI7SyfkuvVI0hHxvrA4NPKkXRoN3KY3WHpAhp3QJ/56oH7D06uGNi
         Y64nRR/cyFWu+i231++xMtVgABhpHH8cDs5hnAleGnU6GHCqvkOzVDZNZVL/17/gQ/49
         Aa/7hJ307BJstxSzIkGsgXQv3JqjWHnAbhroG7Dp6tufsOfrRLV3QdDC3R5o0OjTUV1W
         peZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287393; x=1779892193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=i+2tq25m159Zntr7HjlMen1n+yKoodv1OgUypUrhR5g2AqU2dJLAZgcW21M2wUgWLV
         RHRuryU+zmaD8cpHy1h+zYU+0sjlr0Oz4GJkYTTPzEXeu60Q5J5LgRHuHsnh/zAIcdP5
         wjxItkmEmH7YZfgQpwHlbVqJIRkAgL0eXuKRgqti6Bt2gBgX4l5C45AmhnHgynzXzdPP
         AzfoqHrO+SYqDrn6n59h+5y2numgUvVatHMcnKS8QQWcuPTPhjRiXufGJX3xG18CJIFV
         6NuyL3Pem6DIi9wVON+Esn6IgqHf3YPtsWmyADiQdTQ5Wl/ZyIb9oUmZ7yEAjq8b4SVp
         UWCw==
X-Forwarded-Encrypted: i=1; AFNElJ9v/pBnld3yaWd7NVfCJBSfGTcVPxolc0DiFN8rfTDqdzhDt3kudqIyO7fW1ooAqguo4BrCgRMYSJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgH7E71MougCQz1cl0JU45kNMiIjzZo/fv04GYI51sfOPXCXw
	aGDo9Yg85XrCUNt2oEysJf/k+B61ZFwJlQNqBbLw08O6rSFz9gyxVuFRaGxBFtDehhPRWZLEh6I
	mL7s/ORjPeb26vud1S00v6TLmqq8XMQ38YSV7EFvM6e0DtqkVHtaw3YDORlLS4zCvDRb6C1H9g1
	WUIFw4S9AML58EA9pfAveW+gQRN0ztulcGhVLe2g==
X-Gm-Gg: Acq92OG4R0Dck5r9Ys2czlPNzI6ME2Sbja+uz9KwUQtwW9A2YIHs/IpDt+RwKeq9zeL
	2v6jBGJad4CSfxHO/8X3ocYTlYMSV0cmhqqaWXOZlwekjNTLP4zdDm2ZoQDG4pklONQ6wx0Fjyo
	ovbSg4lnmKJo29HdVr4h9LV2hq1RHPvTM/D/6yfSbEPtNZYaN3KpJA/ra9udMZSLc0L9wy1Bj08
	lUlSRL4gNoPM9poOI92G9UEMe4cCRApbwsXQUo=
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id af79cd13be357-911cf3f7626mr3622213485a.38.1779287392530;
        Wed, 20 May 2026 07:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id
 af79cd13be357-911cf3f7626mr3622205485a.38.1779287391929; Wed, 20 May 2026
 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com> <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
In-Reply-To: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:29:40 +0200
X-Gm-Features: AVHnY4L4rWNphXQmeHCOQKyuxZcVbSpk2c2jukIzCXfC1OBduPiOmLNzgTemvps
Message-ID: <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0dc561 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=ncdiEfFe64kH1Y8Ome4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 0AYO2zzgXea08G6e_a8l5lj0w_4HiE_P
X-Proofpoint-ORIG-GUID: 0AYO2zzgXea08G6e_a8l5lj0w_4HiE_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX8a+2mWODC5Fe
 gbueH9nDv2C+ZbdLRoL6pspdbZsz1MCAqk+/B6Uu81H5WXy08d/6+0SNzty7OkUiEPLmC2Y58yt
 1mxrJtbT4DMQkb/1FSxFZgLZOBIeS5VYrHR/tJREYxAO04Kb1P7EbjYBtH1UC3v8S43P+PrX0B4
 DQUYrfHPHBYqmp5aPUddwBv+v/pivfkFUJC1ooNT3bbb4Ujrwk28d4fI5fPj3lYBIPsjgJor600
 o1jz+fnRHCKzi3vG8NJ5728rM+jlyVVxlrkPVRlxhctrgI8GSjXi8JO7trgCCNmuwz8eKpmKNY6
 gSHR3aJoYem0EygWt/VUuCr4PhsOsJYwflUmGdkBMJc7GK8IuwgaLq98gZgCIrbCyyxM5MaJFhe
 RJsd5sZgRkeaUQZeICzRS/clOG9v42lhZTlZzNFFZt623mzQJftJS+U4+om2YdVhjulgdO3/Etg
 63HNj2Lfmpi5BiLiOOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141

On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > compatible with the M.2 Key E.
> >
> > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > the Bluetooth interface.
> >
> > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > the pci-pwrctrl driver can acquire the power sequencer and enable
> > the M.2 slot before PCIe enumeration.
> >
> > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > (gpio56/gpio55) used by the power sequencer.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++=
++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/a=
rm64/boot/dts/qcom/monaco-arduino-monza.dts
> > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07=
244d185abfb1976d9 100644
> > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> >               enable-active-high;
> >               startup-delay-us =3D <20000>;
> >       };
> > +
> > +     wireless-lga-connector {
> > +             compatible =3D "pcie-m2-e-connector";
>
> I think it was discussed that LGA can't be an actual M.2 E-key
> connector.

I am not sure I followed this discussion. Do you mean that I should
introduce a dedicated LGA/vendor-compatible string in the compatible
list of the pcie-m2-e-connector binding, or that LGA-based designs
should not be described using the pcie-m2-e-connector binding (graph
representation)?


>
> > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > +             pinctrl-names =3D "default";
> > +
>
> --
> With best wishes
> Dmitry
