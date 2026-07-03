Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675035E1B6
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068094; cv=pass; b=hwE4hji/QO+DKvleR3zkcN0501K9EX4qzEsy/QCl2cJsq5eBun1QdPTmYbtpmqZLiE5iS/gBlCipdNy4idXOFICtbIj0AyQY0EWHqYXtJPvJC6CdBn5rrMQfk86QuBPNj8h5mMziSCHsgHPWYsTssee9AWSPteIt8Ru+TuVcCmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068094; c=relaxed/simple;
	bh=A24/IDMt0yFcSCd3f2pMjBY2SE2mBp+L+hitnBhNtNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODSldf4T6ehm3AvKv289nDkcY2CTrJJq/2nwjmjWhB7r3u8tpjHpWpYAMu4g3iP8v0eOjfb30RsPKOHUcO0cFmD4HCj5SBp1eD02cCP2ujGXjnAjoUuMCxxWlF2sZIXxkp2/qHQ+4IJm4CI4Q1ifI/bES0sotvrHlhtU+2Qx0oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdcfxvmx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PXAuTFe4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdcfxvmx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PXAuTFe4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rfLl2994867
	for <linux-pci@vger.kernel.org>; Fri, 3 Jul 2026 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=; b=cdcfxvmxsBih+A/j
	fvtwurcdg/gJYSyu5Uig5Gq8wCquo8jNytqD0uu9juFEOtQSfXwjZjtxdQrrTK+s
	M1rWwC22btRXLZcoCOv6/JNy7ImMEvu6mU7onpE62ujvdfACdBmudXFKzXSKk0H3
	SRGOYvTginR0FO2EcdZBohFlBq0WCl7hXURvzCfC05PT+3yBMkMSZ1ylo6orLhcJ
	58m2OMcgctIMwGlXT68/VUkLd9dYqAk7+52jct0dOMaEj7SLsyVye4xcu8vTLW4U
	lCFoR5+AaxXvqlXDqntxmIUnNPAiC8eByWfbz3AwQmww8JOSrqIxfs+yMHpQLRlu
	hpuaWA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n1gb0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 08:41:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so31862785a.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068090; cv=none;
        d=google.com; s=arc-20260327;
        b=OXTB+rD5MYxKZn1DTUdfSj5lfoerIyc+eKH4xoxTDAr+NEpI4PVwx9c/3a6XA/clen
         pdBT2GupvyJ1D05RayMMTKkCxBmbFrog3QF217HCMp/ZVv4O7BUx6D3BdW/BWHDv40Fb
         yMlsix8AFqI88o3XILTG2C1P13x8uDTDyhvX/Bsjug1sGcwDEuL2wayamyZ94j9usPkj
         0BEPMJXWN4ZHEHIjco0fH0gNolZCzEtT4t8TNsIZYqz5w09Ulc9Q7Kd/blrku7aa1NUl
         h6RWLZV6kbuCsCpQRCAjSP1xH8hQQ7Su3tKqSwgIm6xFRcJj9R+crJeMPXXNInqg9V5A
         dqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        fh=I3oIJag9TboLNh8DFTLyonolJzc+Xv+KhzkUmBCPAqw=;
        b=kmIHBwFmhshNjfDYvQQ4abmN6vmBYAfUGbnWHlow0aX1HtoJX2zq9hC8duBHfiaw6m
         u6j7xpVh4C8KDrjB/HWBGta2kZWsG5vsOWsSD6sHAZhNaODADslIFNfJN21s8W0xdqke
         EoXOyS9du6LVX3Hz4v5Daok1Urp2W887DizhZbF46+fK654xtaXB/7gdtxNY6LiBiDJy
         b6QsRH1kizRcmVb+UEtbnWS1m6A+TN1s+q8A5CR15Ac7sFbzfN2Hl1rUbY7NxIwXV25k
         XOBG4nq4D9S9A1rRRQ9LVkmx7rCQCMeYLqZIYn9knm+OJuYXL8vygHwV8w1pnadYyxMX
         PhXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783068090; x=1783672890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=PXAuTFe4Ojw62j6tAUNP9wnN5lQXZDTel/ZAAICYjrRowiZ5eEmVWyayjZMGqtxl8+
         atLp5BsxEKfO7vxs72gziDQC1lz9G8yVkpKHBUAr/GbDu+tVZmDLNCGV0zrXH/oOq9OG
         jyip9EUMelvPSLjC7CrDNIn3mDEkHKapHvEqiHzzt8nsZeCNURY0CynBJguhLpiveQAP
         Iia7zmCqcD8H9uM1yISwaQLUmWjM+YXk5tnYNqPtb9HiR4hv45//C+ZUdvE3GyUwDleK
         709raCFVUcVRCv8v+l75ETeQ/lBce8WfzSoORZDomGpatyxkXOn7k0g93bzH/8MxKXEb
         dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068090; x=1783672890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=R1Hv9ZbnR1Q664F/LaQmt5CJHEiaQFFBvrFfj7qY7U6Nx1b0blWZkPLlDHbyY8pDgc
         NTZaQRxhfk3zxPFBDyGHBYr2AH6ZZWCE8IOvSvg+cBw3Bizk+ejW5CAa0MWykauiV93Q
         xGQ4Cfi0AHwaprfXpQiTJPucpap2CfdThVStwC0/A763V31xku+JO7S9bhV+G6ENV6wh
         B3zE+YAg0q4BbGNiBInKWCfYUPcd9gJu/IZTo1FXStcsvCEvQ3t+3Sn3nrD8V+x3XIYq
         YyryTl4aIwcebv6QQLtZ9kGEhpR9uAHRYnpwSShsFnBDvGjE2N498LwrOJJnkfYnjyb7
         KzpA==
X-Forwarded-Encrypted: i=1; AFNElJ/9rS6Fb4uC4pChsEgdflZP0pmNbwHzEWKHGcKQcIucYv8IXhC5SU/G4Nff1shd+Gtiv86Mo4cQPkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybkKjLPVFEQlgvBcfvVMCizzBsH6t+EpjoPbynCo7e/6Je7k7W
	HLd6ML5DizKfl5z2eBMHVoDILGq/qukHgISDUwjbPJB6AyVsdlMByH201CxdsxA3tj10qhCXA/N
	uI8lbNUQb9SxQZjkOHccGuI3MNU20P0Mznj9qKIVm2/k833ZR4uDOx5ZMsB+j+lYJOxpmfzhoTg
	VS8t5QJ14Ene5FomJ69jwvB0mymH2uCAwKLg++bg==
X-Gm-Gg: AfdE7ckgTSd+JMHuLtLPmPoux9DJGCVbH1mIwEsi6OTlM5W/NusRBM5WFthWUsKWuAx
	gsYFsbGNRnKd+mCREadpP76oHFuYeYU23Om5bfyH8ZnHG/ioEv9ysgC2NapGyCEQGmsF/8Xuj3L
	txCFR3+JHAs6/hLIsYqRI4lTyvNCXU7v27LQHzN7pmyBiTGBd241Z4L4E6Fv1sh4TaR1qjnhRTB
	KdZfZ9VJ9YuhTtwdbptyQJ1irNSoCDjOnEc34+sEUFrh8D1KlR+Vys+P2VSh4oR+zgik01NVnDM
	94AMod5DFg==
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id af79cd13be357-92e782c94ddmr1287061585a.36.1783068090229;
        Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id
 af79cd13be357-92e782c94ddmr1287058985a.36.1783068089796; Fri, 03 Jul 2026
 01:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com> <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
In-Reply-To: <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:41:17 +0200
X-Gm-Features: AVVi8CcGrmUi3s72gNEg9Nxjar9xvqGK0gTiAF8t-61zW6VTlFRO9OOYGSuluUs
Message-ID: <CAFEp6-3BptG=S+NutQpvuS2oe+kjJW6N4u0YjVP=T+tbX8PBPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfXyMF718tJ+XsT
 nkgs9gdLLH7hrqoMWda/q10NkoNFMIDejL4BPdG10t/D9L3ACLxxwv8E/fFjSnEPpWFfUjtFO5Y
 /D2eN31Xg6ZdNT/CCjWtTsr1/z7z5Wo=
X-Proofpoint-ORIG-GUID: 18yvwd3KYJsG1034xmrHr0-ZtNjQV2YG
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a4775ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=qB6sUIZWhqFJcRNk-TYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 18yvwd3KYJsG1034xmrHr0-ZtNjQV2YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX93ywtzga5LPK
 RCSVCDZRfMp0CSl6xJ80OJD2ZL9vwzM2dgmevE5iL4HU58f7vVy3cpL/yRV/gukncvGd1aep7ZO
 5Qhcj9BLBiae4uV5kDMgHgMxnOs4pQoYYFhpZUWCIExe/BrirAR0AUpgK77STvgFlwPDlM2GZzo
 u4yH3EX3c4reGXL3OiYzrMKjbTK4MfQ3PmAi1jOyaNOk6T2wb58vpHdM0y5r+A40bKmA+LWKGnH
 kKnM+j9iw6FNvIExP5f66TbP8UiOCrxMsgVuPvQA0M20sXpgsu5mmPbnyPahIkHV+oA7H1FWjZF
 U7oCATs6Wv2lRLUZGvW9d6M668SIi8p0fH6zhGiZBTIhZe7lVNfBPZoYabphe1NXiSknOwRlaFF
 zh2JYwJ8CZ6p6wJV616OiEKVYX9rJ8xXdVQG/ZsN1TLvWfQeoTEAFQwuCUC89VBObHJDUHSx12J
 uyp+/FcG8Xo8mULL9lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030081

On Fri, Jul 3, 2026 at 9:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Jul 02, 2026 at 12:46:13PM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
>
> Why do we need device nodes for soldered connectors? Soldered stuff is
> afixed one, not connectable connector, thus it has no point in DT
> representation.

The LGA module is soldered, yes, but the node here isn't really
modeling a mateable/removable connector, it's the DT description of
the M.2 Key E electrical interface that the module exposes: the
W_DISABLE1 and #/W_DISABLE2# enable signals, the shared PCIe/UART
regulators, and the graph routing PCIe->WiFi and UART->BT. The
pwrseq-pcie-m2 driver and the graph binding rely on exactly this
description to sequence PCIe and UART bring-up, and that's independent
of whether the module is socketed or soldered.

Electrically the QCA2066 LGA on that  part is an M.2 Key E design,
only the physical attachment differs. That's what the vendor-specific
qcom,pcie-m2-1418-lga-connector compatible is meant to capture, the
soldered/LGA variant of that interface. So reusing the connector
binding is a pragmatic way to model and drive it.

It also keeps the enumerable-slot semantics: since M.2 devices are
discovered via PCIe IDs, a board variant with a different chipset
soldered to the same LGA grid would be handled automatically, without
DT changes, exactly as it would be for a physical M.2 slot.

If the concern is purely the "connector" naming for a soldered part, I
can reframe the binding.

Regards,
Loic
