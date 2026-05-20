Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1D3ECBED
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287790; cv=none; b=ATtit4cpss67mG96IcuEIyTj6R+DJtrjZKTqGws1xODTJcqAkzJIr67v9tO1FF4ZmlN25UirRhPyTKybBMNHPXbshxzn7Gq+ut+vYCQDhxPwEadGH+bknSUC8Fuyu6639gk5RHtaPgniurR1kglWBfqW5/7DmviYMsDHIu2F2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287790; c=relaxed/simple;
	bh=cPmuwVqznc5L0WBYFdwF0Sj9CvdUrSUKSPo3xBN8Qcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY8NpOnxW23cq7T7n9IrRkU8UFKUS4BJrdsgr30kUnAGtVfXOCWSnTzAZngX/07OuwOyKCtWXKsJ5bWFVmtiPuWYEBkKAhhSKz3LTmTWYaVdSOUOr+RN/z7nebOBG6B7OVWj1joulfKCS8w5n98lSV7HBeGoxTZILg22CtGXoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgCLQf8R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeQauusM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgCLQf8R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CeQauusM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE6a3s119115
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	izvR5YXQt3nXClCS8EaCPJiS7TFOXJQaH/qr0kj9l4E=; b=RgCLQf8RTLGeb0bn
	Qc6+nZozCm4wBf+yitO8Ek/+qxE0HiNUMqGMYUZYPmhGZ4xE+YLYBIw5mFIS3aUF
	TcexxuvcpOo6ZPvMGheDQqRGuVCGoUqdTO7BM5WsIfeT3xttU4CtPJuyrg9J4zKG
	71UjbJEY9MhbUylKOWYtpk7dQRysbx5fTWwDo/h10ud8F+DVRerJ7P3fXXLpUUoY
	VKtOhz0FFpOuNj1IRHe5lIIoeRdX+R+FYFU8FdR9qJRvCSO35wXScRGKX3XZNU7t
	zQ/tMh4mG1Mw9mZZckVBbChVO8qoyBlMqBJyTO6AaH6ZxsCbyH5lV4tgEtoneECO
	N3hTPw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8840f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 14:36:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5760d43e659so11823051e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287785; x=1779892585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izvR5YXQt3nXClCS8EaCPJiS7TFOXJQaH/qr0kj9l4E=;
        b=CeQauusMW/JteBYXz662Fty+I4C93L2QIM3hsYx9KIxtBBWX+lJNtfpGWzI65PZmxn
         tQyFgerqm+nrEUlmGWooAz3Fmxm0LeFMcbJFKbJu3IllABZxl1hUNFRPvBVPR10LjrZF
         DsiMpoK4GF7evOyAMDBr0thDgXN8TeknSGPnbKlnoEDGVnW//0EzNvtuYpAbrHBsZLlv
         v5t4OajigZFFKF+KOKr/jYlMkx3i7y/oFHA+MVTFNMvcr0mAGH12GUsbm6jt0Ke51DsP
         OXSmylVuHop6A9LaWCNJLm2CAbCsAnO2hDwsjK5wvQUVt271lMMKVCOwME+SaHqbk2Mx
         dFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287785; x=1779892585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izvR5YXQt3nXClCS8EaCPJiS7TFOXJQaH/qr0kj9l4E=;
        b=UXTn98kJA252dL5SxTyQIB2mWOurYOR11r1liIkP97O3lCZIJi8rrONnfDUVa4FqDm
         Im5WaCT3vlPI0Y9GukUvypA6rbNz0HxGw4ZjU+oymbALrvUZGpZ6N02bxVyFpwgN28g9
         eKv0x7huKsOZEeje+gl8gc2c1TG9NIoW6eyVns522LYEByKYzSA5+dOB1EjQmNGx2+fk
         I32a3QrWIV5C+X29gJw+j+RHFxfUE7lgnMt9TjIksKniFkC5awSRjRgCP4oB6oKAMyMS
         gCMc98nQOjrcK+k/wuxZYDcNpi8cApcNq4oHVzW2AYSdZSZpi36drcUhDmQzbGiSH1Qj
         q37Q==
X-Forwarded-Encrypted: i=1; AFNElJ+O+0ewM/aQt+ZpWUX9lb/O4WeoNGXr0nANJqeTXOYGXRA8KzR0F5a6N2voPacr8ReJpmI9rIkuyv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrNLckTzBj3Kd+1SN6+wCaq/1rtd731kgoYTtYIAfDIxb80ia
	zWDIRnq3r1bRe255q4nrDQWiLe7C8EtsaxiyttpO8iybckaytP43Lwt0YzoNqmqsJGoX/vNuAs+
	rTevXr+YjeiVWqgBs5vJEFcpZBAhDv1WET8tNhMMgcAjf8IX5i3ok03cPw4rkihN4AE0ZihM=
X-Gm-Gg: Acq92OGFClOjhnmdqPIvn5UZu8mOaxK/bUa/tImRGqlbxXe9nuD8jzqPrlNsKwdhm7E
	gLhqviTqTJ+KVx7kge+mP7yR1vrqyZXNOk/+ad5mGnQhwvmkLE2WhSNowxo6r5L95aETdWAFEzc
	wLDL4YZfz+LG9MnKTXfaB4o/i7gyp6nhXFbR5CfSPM316hvJC1NtzrTMKBEES1cASEQxEzYA2BZ
	fzM4xXqqa8kIpcGCTqwPUnmVe8D2YMRckz42d3ZsMDDIetYJuzoZHY/WodoCxqJu4gLE4PlxXCt
	cMVcGZL10j1Jfa/qvXMAlBICpCgQrAHXXrgTkee+3Q1lBHRTqk9HPfTJIYWjOeMhFrHHN6WBFeF
	UHdD9JAtdBSApGfs3LFHEErfZcv8YcIRT3DzGU9GzGL07oyh8bivrwUZMQak5MLBNnDi3op3/Y1
	gg6DwAQNf70cuMdrqA6WGGSP63O7X7YXkKH6Y=
X-Received: by 2002:a05:6123:143:b0:56f:a329:6859 with SMTP id 71dfb90a1353d-5760bfc62f5mr14265382e0c.7.1779287785393;
        Wed, 20 May 2026 07:36:25 -0700 (PDT)
X-Received: by 2002:a05:6123:143:b0:56f:a329:6859 with SMTP id 71dfb90a1353d-5760bfc62f5mr14265326e0c.7.1779287784906;
        Wed, 20 May 2026 07:36:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c797sm4998411e87.8.2026.05.20.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:36:23 -0700 (PDT)
Date: Wed, 20 May 2026 17:36:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Message-ID: <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: NDliL0gZSDTtn8_HSODCGXZQ6WPi2mnb
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dc6ea cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=wMYjVwqzuYsVbry3en0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX+yAuY1gaJfeM
 0ySybQR0/YMWZRkYqtTto/fDwvFOF8sXM8auex/aVIVeYf1yTZF+UfC5oM4tszr4LZ4dMQjZFuI
 Ef8iwGTxrC2nSC3G8bj2PbeBll/mzwuONLQEAH0ypNZOeo8AWh6bLLjTsKFZTdPmqZo+p6wzpIh
 g3DpCLLhck737KFBEZ8n1wVRkHbA/xx57uyvpQwoFqq082KXaoWDkBrzofwu8CYE2jE9w/cOuwd
 c9H/b5ipBBMVa63tXgcemK1ADR6OuIbZtjmsWD/aYbT/6kagwbUDbbdGxDfxDyhJ7xLzHbTUh8x
 hzj5/j3ML9sk6htJvpPGJllcnqGT8XLRGQfZIFbrOQoWFjCP+0fNq99xgNHUvUQz5wwVnT6F0fK
 GFj0hFaLKq8FfTtF8mPEnG1wPX5hOz9Kidf4ZQ3ovYGvRIYOeQJAzzXe50fVaoQeaxbi5BffmxC
 RsPaxKlXS3pLKYb5qbg==
X-Proofpoint-GUID: NDliL0gZSDTtn8_HSODCGXZQ6WPi2mnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200142

On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
> On Wed, May 20, 2026 at 2:34 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > > compatible with the M.2 Key E.
> > >
> > > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > > the Bluetooth interface.
> > >
> > > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > > the pci-pwrctrl driver can acquire the power sequencer and enable
> > > the M.2 slot before PCIe enumeration.
> > >
> > > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > > (gpio56/gpio55) used by the power sequencer.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
> > > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> > >               enable-active-high;
> > >               startup-delay-us = <20000>;
> > >       };
> > > +
> > > +     wireless-lga-connector {
> > > +             compatible = "pcie-m2-e-connector";
> >
> > I think it was discussed that LGA can't be an actual M.2 E-key
> > connector.
> 
> I am not sure I followed this discussion. Do you mean that I should
> introduce a dedicated LGA/vendor-compatible string in the compatible
> list of the pcie-m2-e-connector binding, or that LGA-based designs
> should not be described using the pcie-m2-e-connector binding (graph
> representation)?

I think, it should be a separate, vendor-specific compat (maybe using
m2-e as a fallback).

> 
> 
> >
> > > +             vpcie3v3-supply = <&vdc_3v3>;
> > > +             vpcie1v8-supply = <&vdc_1v8>;
> > > +             w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> > > +             w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
> > > +             pinctrl-0 = <&nfa725b_default_state>;
> > > +             pinctrl-names = "default";
> > > +
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
