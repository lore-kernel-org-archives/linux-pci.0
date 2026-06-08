Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B034F255
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898661; cv=none; b=i4Tb6WdRH9bcVvb0RQfF01TQtdiCnLzoWfjxVa8ottHN85W0gYcs/Nniyu3DOuqR9BWUDuepecWkNbTr6EP4BGrGSv5OQVyONCMvIELkDhKyB1yZo8Ze5Xyjr4aX+8PXCkChS14i0kkzIeL0kSjUzkMETlM7ONpMKfYGPTqc5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898661; c=relaxed/simple;
	bh=tQ/zYygJXIMhmnmWlkNagbooYmXGxdVLFQV+VQ4wmnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdfQpKVUzHtf5hIDIfOYgAYCYXBQZX3nBYE5K+gKakrSsv3fhNIlYWfGDPARZfUvo1OXpBhXjBQW5Ii0+I+sBmCM//mpaQ+YAvDyExlXR1qDlM6fk8Mt31jteusubFfK9i14nj8MOoMi7/ck+pQSuL8BSgqF9PDevQBMy6n07iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWNQyrMk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SE//Xm4i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWNQyrMk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SE//Xm4i"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GkMh1933573
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 06:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bL7RrCSQB6iOyve28SUhhCIRdGFRm2bK3QU0AFb5LnI=; b=IWNQyrMkOngUtDtW
	YfWDc7pO7gwTyhqdYJJtIqH983UEJSIMBKLXNp0XeZtlNNK3DLWKSFWZqxm/CTWj
	MUjCsQNxunru12y1kLnUJrb/AE0ODIOV2JegkDVQ9myiDXQi2xvad6+fMy4HW8Vz
	5KI7IVuWxEUyVxAPLimBsDsg1hDxw7S2nKLHsSK2Ga1BQefrSd0Rnm5/jxvC+HTN
	RG+BwUEK3LnrvJ11KWwCSKl+xDr1Sur4/3s4c1//XmKtpHVsWfEmzNjBCtgJlkRY
	ygSHX5UMEu7seDTN62wbWlA59KEOB4L6FLMhe/lJ6lazwbuNpWppQHeb2w6ds6b4
	nc0T1A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf69wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 06:04:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6798c46f723so2183179137.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780898658; x=1781503458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bL7RrCSQB6iOyve28SUhhCIRdGFRm2bK3QU0AFb5LnI=;
        b=SE//Xm4iLgdj8b6TETsBiqBwulka23ng0CoWs7hT9q3cCJ6Yc0p/KAUMBWMLZdPyVe
         UV3d1KywlGNITHjUMSRtdFgqpb4y+nUKOtp5Ebt4q6eM4OElqRtjQWpQpuSDszJuuNjI
         e0NcJbHsgiUHH1U4YtaukWBZLOX0OGueCjTfCYK0hprz89fraa0Ru2Y7IfaUngST6+l+
         IYHTGKW9P0eGaEz6Pe9lpMD4TH+JvJ95BUmn/RHtaD85cucVcXRgA4ijqeWtygOz+dUM
         JlcPQyHrBzudGt5UfEjvIRQ+XWiGY/036lFCX+2vRtucpfFzDmpuxPPubuojsIgLj47c
         oC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898658; x=1781503458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL7RrCSQB6iOyve28SUhhCIRdGFRm2bK3QU0AFb5LnI=;
        b=HZUIKkjAFAuNx0I6CKkWxLSYJGTx8ZYtQYiG0fTMSnD5VcFXomM/nqodGC9IfNEpEG
         xDxDcHCyGWIqlxYOlO53ALaU8coFCElGZknwTBz1zVLl41r6MH6euJnjWjuP97Q4Y/tQ
         bgHb1omVBAgFfkRavbXF17KBaKTjkPbgkq7gOW73pKq3F80GJ3E29w2KqKsV6yUL6H71
         ALPevHe41jDhpxUnPBP3fhTWhY8APZe4PoBv217+yr5yJLPRD2ELCU+TwZQSSe2wu8Jr
         0del6q3+xB5rAyvDB0hJVrnlEFb2mOFN8GqDvi/F4XvgiMthwfrwMiZy/4jpwz3VXzfX
         TLfA==
X-Forwarded-Encrypted: i=1; AFNElJ85UdGLX8snPGTFNn5/bKZ94gAQ5vMIDSzUZItH+Cr5J+1lg+AypO33GYkYXxBQaAGBT4J+S6JR8wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQk7013/3y3P//vkiYBQtNseSq2R59x7Gel4MYMsBzObiiUB00
	8qEkbD8VGqxucChUBdoeTDZ31ahRwHX76MYd61i82T9tMyLhaN2vYdulQbv7I7POlxheqZV7MOx
	vdaPOw/hb6uhjGpx1fRBYoxfGvFeexJ/YrMclfV3qZG4su71NBrWYYAcYhh9Ic66gcJSfYYc=
X-Gm-Gg: Acq92OGEcVtIGtgOJov+H6jcGWRyp1g9cCM/D+YCHmeVsIwnL/KYh1F11WIoMcpuwoj
	DtB3O6lqP5QjJ8MwZWVMKcBAp9otximZt9JVemGfZq1hZQG0Iol0FfMoWJ4ezHBp66LLcpGWTfI
	qQGxKP+75Ksdyja95zVQq5N+q55z3PSrQbnTrYp+X436x9Nm1FqkdgUU+D7wN5Q/9dJdbFlzpDo
	ofqcFy54Mh/jB36KDnJkev3yTr+R02V2rbFXWZAI1T9uB9GE3B9sr6Mts//DUqMVFvHlci6mnLB
	WRijU824kRdH4bj3kgJCzNiXd0jRxm2niNcSAXbD3bmlXgNuLqcVus0osGD5ZiI3IvOI5T1KEUl
	tR2gg5CzrijRqW/46DeTtQodZNqqs0waw+OWgfKqhvfcusiAbp297CMCrFoM9IoX/YOjPHmEL+P
	zqxPSM9efF+C+ss7mLWFbk3FYjTagaZp//gNq+FdQCjqZojQ==
X-Received: by 2002:a05:6102:809b:b0:631:28c1:154c with SMTP id ada2fe7eead31-6fef92b85dcmr5513729137.9.1780898658059;
        Sun, 07 Jun 2026 23:04:18 -0700 (PDT)
X-Received: by 2002:a05:6102:809b:b0:631:28c1:154c with SMTP id ada2fe7eead31-6fef92b85dcmr5513719137.9.1780898657668;
        Sun, 07 Jun 2026 23:04:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed2d3sm3551255e87.5.2026.06.07.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:04:16 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:04:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for
 Eliza
Message-ID: <ywabwqbgjkvurybqsc5faq5vhli262nqe5gplki5gio2w2zsve@g6h5d7tigmvc>
References: <20260601-eliza-v2-0-6b44c9c23d5e@oss.qualcomm.com>
 <20260601-eliza-v2-3-6b44c9c23d5e@oss.qualcomm.com>
 <k37nby6lnczb5qajku2shpff4rsisyynlfmzu46lhojl5eiwqo@wkpy2tbeoa3b>
 <29763928-2301-437e-8787-916930b64a88@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29763928-2301-437e-8787-916930b64a88@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a265b62 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=5G9BQlURLoUVyWWmJtQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: VvPFIAeV9TZMRe66KSo8yAT_xKvrFiMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MyBTYWx0ZWRfXxFTm+e8TJy2x
 NlXy0C/L5yHdOd8RBNOy0899BUgSkWm7gzRfUg1GYzTcplryorxsmuWHpCTqV87J41CxMMIBe67
 3wBcATjW7OlvFVf+1ObK4y3zEA3SgdH0IzppGYmksK1GTr3J/qkc5W04fAqZorUJq1HoOHo3KGQ
 tBKvvyRQG8B59HNfAN6SR2UTma63PTy/sFfMC7TdRV7s6CKYuj1m+oPYLj1wFll/KtY6pRxH/TJ
 BG0hFivf9icpg0rl96OI7HzWpS3gcBmX47D/KJx+UnHrNdCGlJWbX/EoPcady8ZLAYWt6fRBA6h
 DTmrPm5qPCmELfRtTiDK7TytswsB/vuhtARk/XW4o0PT9XgBAz9ngE8UZyH0W48i14ltDT5F4cD
 9v2wI129HvcA+O8ijNQNg4QRHJVn23u45SrFi1CdFx1fLzv/n50zo6yoNHXAsh/cX9hcqSmq0+x
 V0V6Mulq/R/Jjs7759A==
X-Proofpoint-GUID: VvPFIAeV9TZMRe66KSo8yAT_xKvrFiMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080053

On Mon, Jun 08, 2026 at 11:12:13AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/7/2026 3:59 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 01, 2026 at 10:59:46PM +0530, Krishna Chaitanya Chundru wrote:
> >> Add QMP PCIe PHY support for the Eliza SoC. Introduce a new Gen3x1 PHY
> >> configuration with Eliza-specific initialization tables, and reuse the
> >> existing sm8550 Gen3x2 configuration for the Gen3x2 PHY instance.
> >>
> >> Also add the missing QPHY_PCIE_V6_PCS_PCIE_INT_AUX_CLK_CONFIG1 register
> >> definition to the PCIe V6 PCS header.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        | 139 ++++++++++++++++++++++++
> >>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h |   1 +
> >>  2 files changed, 140 insertions(+)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> index fed2fc9bb311..257b4df965c3 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> >> @@ -198,6 +198,112 @@ static const struct qmp_phy_init_tbl msm8998_pcie_pcs_tbl[] = {
> >>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_SIGDET_CNTRL, 0x03),
> >>  };
> >>  
> >> +static const struct qmp_phy_init_tbl eliza_qmp_gen3x1_pcie_serdes_tbl[] = {
> > Thisis exactly the same as SM8550 table, except for three extra writes:
> > QSERDES_V6_COM_VCO_TUNE1_MODE0, QSERDES_V6_COM_VCO_TUNE1_MODE1 and
> > QSERDES_V6_COM_VCO_TUNE2_MODE1. What are the default values for SM8550?
> For sm8550, the default values are different than what eliza is expecting
> 
> *PCIE0_QSERDES_PLL_VCO_TUNE1_MODE1*-  0xA *PCIE0_QSERDES_PLL_VCO_TUNE1_MODE0*-
> 0x53 *PCIE0_QSERDES_PLL_VCO_TUNE2_MODE1*- 0x1


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
