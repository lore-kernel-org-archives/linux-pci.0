Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88962E06ED
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747973; cv=none; b=SwKax9uOHd8C+EWeo8Q5riRDoOIw7Xa622WpWa2hX3pIX5B8SYh2iZMJCp+WBSVIAvLcGiQM+8XVjuYGpEQH/jLyBkCV7swUCXwDWA5aeAIMy/b42xcicaBXWUcMsNP9hy1FhsLEcjFr4UTlzEP/kDzaBW/Eg19sP7VBAXBPXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747973; c=relaxed/simple;
	bh=SqngItBzZRRemQ7Z7f4iOSqEU5Kl028KrDmgh47NvwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llG8Ye+ZGk568UBAwNXl0YgCjCd2y28p04X2LGPEY9I45JaXABQbadNS9o8tuKubD9veS8JYSV5DcjiNxdRuxjjYjJ6FtDqypzNs3b5k5VGmbFg3aRq5OdCzwrBecDvyKYR4uYm3xmy8DGz7RFdbvzax83gIn60zLKC6DJ8aiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YcdFf4wH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjwktwRU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YcdFf4wH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjwktwRU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6872O2T52725215
	for <linux-pci@vger.kernel.org>; Mon, 7 Sep 2026 02:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n0jUTNNzExuLuTq0dCzLcka2
	2DJ7rjiceOe/URuM9WY=; b=YcdFf4wHGK9LHBWgjYX3BMyydcOUxhu32MqWOv22
	iOKFSgTSTQCWH3YTlOduJREptzNaFQAO6+x7KF16tVBEFORC7+qU9X5DLtbTqjW3
	bJ3XeqHrYqBOSs+qj2tQr3/n5BwhRAPZCYMgXpYw/2MPPgxVoIAxdjWwpeq5aOls
	+Dym7x9+W1ndeo7PN41gqnjR8QESG5pgrO7CBuFHbwvriTdbJdfZ5skC62F3yfuq
	1tjJHPXnqN/zUCGFLmTpPUnujJCUSkqn88ZLzgJRgD07AnJLhtsXUvDXYj+qVVBJ
	097VYMPrgBX2aMBCkOi6QGhX8CWc2nOcdZ+aLQeZT9Ovsw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8eq55t5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 02:26:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39af92138f9so4715890a91.0
        for <linux-pci@vger.kernel.org>; Sun, 06 Sep 2026 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788747970; x=1789352770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n0jUTNNzExuLuTq0dCzLcka22DJ7rjiceOe/URuM9WY=;
        b=IjwktwRUeXrTbfWCVQXg4PzvXDC9LLPbGV0/x0bPeuPmMAJ6qvQu52DEvw/2PeNtnB
         kpaSYV1fK+6KqrhcRDNHv2TEwneji5XoEYeAG5b3F4nPX573iFLZyObQbygs9TP6/W21
         8e/4hfpHlY9E+5mVw4aTZF2TrThrHKeivdVQBkheyZTGat299eWGdJX73DesH4aVz69P
         81eUDPEU4D5ILXKjTyBBc/JCAGrdQgRHChiq720j+tSD+s2DCIcmSQGLbH/BFArKTvz9
         LaFE8E/Cep/lh47pxpj1L2QH4U6elcPMGG75KHcm1bElUeI/dDeV5Vmc9hW2BeS2a6l8
         7Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747970; x=1789352770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n0jUTNNzExuLuTq0dCzLcka22DJ7rjiceOe/URuM9WY=;
        b=YrQaqDk/H+ZQQog8F1q2u4lz6oeNfNqulcLmlB60GArFS4sAeKbRLGY6Uo4sP6BDI+
         MbaTU4Gw64zCvoqeKMpyYc+IZjrVyWF18L/pN7Pa3hT7oCI6ByqNAkX8jaYVe3cLBoTY
         4XUJpvJF8pXTC/rqWD3yZ+JpgaXKZ+Vht8MM8RtJHcgVqX1pEspLwGbEFcqWLGKZHDpk
         kMQKZqncsI+SN+c065AkLwIWZwASN0A/KVvSSD8hHvOnZXS4YrwxT60/9LPmnfleAOpa
         7ytJA+vn0yCLziY9GDDIFZgQ2aEFsGObheO0ipxbLdlp9cTXTAyM73UzGe4Ws/5OUzb6
         voEA==
X-Forwarded-Encrypted: i=1; AKwUvBz/q1YMVoXSB962CuBNs4d5jC/N4X4+1AeMkCW6TIhNOG4BooJjBNudDQWWNKBx6TTBoa57+32s3Eg=@vger.kernel.org
X-Gm-Message-State: AFuF++kyOU6c0tBX8k1kUKTdRzfRp9WGGd7RnNvNQz2mnwS7HRqb4HpV
	hHjOLcUQaXojb93X+Gtkzc6seiATo6dLGoKe/uT5LxfMyAJCmtnyhvmtktkfgIg3sSIOylN1mn3
	y23zbKaDV0mogWjV3fovSyU403f1J5HLOTK10jxFcj7KRGE+m/yxJT96lbl8ex+I=
X-Gm-Gg: AYBFou3yNqx3B9gYyuqoTqQPIIeMEEbwBDljj6kItr1lPyBh4dDvv9RVpBPq2eBFdq5
	c8RTixUaQaOfT0SZ4p/KS8WyTUcZEZcxZnLASxuBAvdkhL4YARTGxa7FNG4TzeAOt2y75OQjw4J
	Jxkf2Jp+ZrITCpMsbKqB8MlIkhhwD0e3/J65W5pzMOv5Z9wpIoix1utW0RK8nzzhCfmjBBdAxlo
	B0prk+xv5Xidfg+3MzrIvi3DSEAsqoW7ZCknVgvwU5D2hY+Cd7IxuZ3mltI0PF70+XrNik4A0KU
	0ssBmCpxZ45nKAncTVSxVqSFmq2gPeVpQZZ2fq1oUi34Xi167GV2dNClPhWniW1bwXXIOo14qNq
	t4tMfgVjwh8WzcIiRpKQSLkN2Nk/CGN5HJv4zLKxf/EDyQ0E=
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39b0803accdmr28515625a91.12.1788747969559;
        Sun, 06 Sep 2026 19:26:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39b0803accdmr28515586a91.12.1788747969120;
        Sun, 06 Sep 2026 19:26:09 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm33810559c88.4.2026.09.06.19.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 19:26:08 -0700 (PDT)
Date: Sun, 6 Sep 2026 19:26:06 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Message-ID: <ap4gvmokukHV1RHT@hu-qianyu-lv.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-1-18bf59d19d6f@oss.qualcomm.com>
 <aabdae7c-5294-4789-b123-4fcff8a733e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabdae7c-5294-4789-b123-4fcff8a733e0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=F61nsKhN c=1 sm=1 tr=0 ts=6a9e20c2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=MuNgaGKqo7zVGC3JrMAA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAyMSBTYWx0ZWRfX8KSI97gJB8pW
 qbSbV/UIaHv3OHggiMPNmYosOkWxUsX11CP+ui63LjUHMZfDjQzu5eeAHPep3O5hmOpZbLbnI99
 ExESblxKJ2glEQpUAwbKdGqcB/kA8E0=
X-Proofpoint-ORIG-GUID: CsIDSyN5gcUtO7LaViqVfbUu_T5niX0u
X-Proofpoint-GUID: CsIDSyN5gcUtO7LaViqVfbUu_T5niX0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAyMSBTYWx0ZWRfX56k+BNaJ8zqb
 ibFNgE6LBVvziW3WdLmK50WhLHN6vgKr+W4fpp6XKv2kLws4IATRweXGf+JtLkkWW6gfwx31dul
 nSbxJWpRgLWmB0TR4pgSx2K4m9Yf2GmcFC0SunVWRaQ4HJbpZ7/sxV6kK9mlSVmO9xx5fS+TOEv
 93CFq44ZijNvvcsaUy0UJApFTm3l6P6zBbcNn/2MJx9ZCCcVXLygaEZFvziJsZ232IcaVP3JpwI
 ssAuR1gX56PGwvn2Xqazg/FY91QhKUSgX/YKdv6N3uSDdSPwOHm7R2/BDW7nCY9wIOyvLC8Sbml
 Sl5jXcNbV5j1rf44zGQ3rb49peIYZb9pPhd4kiByPx33ARNC1Mz/pq9OY7cAXKg9JZhQ3CBBX+s
 pmjSAmNTTUJzDYDUaVuNBOWLfiMCBNDJuhOkvWUgYIdYXkyiwNk7jJs8hWeiIGv3OHlucYiThU4
 npALZcBqaxJmwX9NAxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070021

On Mon, Aug 31, 2026 at 09:54:40AM +0200, Konrad Dybcio wrote:
> On 8/28/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> > Document the PCIe PHY found on the Qualcomm Nord platform.
> > 
> > Nord has a Gen5-capable QMP PCIe PHY that can operate in multiple
> > lane configurations using four PHY segments (A/B/C/D). The active
> > topology is selected by firmware through a TCSR configuration
> > register and may be configured as x16, x8+x8, x8+x4+x4, or
> > x8+x4+x2+x2.
> > 
> > The binding describes the register regions, clocks, resets, power
> > domains, regulators, PHY provider interface, clock provider interface,
> > and the qcom,link-mode property used by the driver to discover the
> > active lane configuration programmed by firmware.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  .../phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml        | 276 +++++++++++++++++++++
> >  1 file changed, 276 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> > new file mode 100644
> > index 000000000000..37198f82c611
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> > @@ -0,0 +1,276 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Nord QMP Bifurcated PCIe PHY
> 
> Quadfurcated, perhaps? Is there a word in the spec that doesn't get too
> detailed about the number of effective slots that the PHY is divided into?
>

What about multiple link-mode PHY?

- Qiang Yu

> [...]
> 
> > +  vdda-phy-a-supply: true
> > +
> > +  vdda-phy-b-supply: true
> > +
> > +  vdda-phy-c-supply: true
> > +
> > +  vdda-phy-d-supply: true
> > +
> > +  vdda-pll-a-supply: true
> > +
> > +  vdda-pll-b-supply: true
> > +
> > +  vdda-pll-c-supply: true
> > +
> > +  vdda-pll-d-supply: true
> 
> I'm really surprised they aren't all connected to the same pair but oh well
> 
> Konrad
> 
