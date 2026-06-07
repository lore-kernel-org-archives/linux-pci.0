Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFC2D9EED
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862480; cv=none; b=oVmQQqwFquAePHRQsWgWTsv5s1UUQyuKpTqs5sMfQTSTc7XZKkZjf3zzwGxXouESDIlk6gWk2eb/WFibgov5nZ/MkLQlZoHmqvKWfm9/j5NBG2idedApnYNeObSAVWpuiNBIQLwU50aaX56LTH1jhgz6fFwoTHLtB2Wc26U0W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862480; c=relaxed/simple;
	bh=52hTa5kcQvaI9pLpbWBzX3JmT1JFDfqMHf0HFsvSPaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWxm7eLPc4UOEljUEsiNOF8fQpHpfPqa/wE7nPTDHKPEmvUfD6AGaGaijHW0fjP449skgm01gWpU9iRLzoeTVds0jz018CNKdUryQqCmDJs1pPgWf4IGdb60GbCH9m0pTVgCNaJ59xdy8UtJ6U6oXcTUGYX2Hm67VHZIJe0M2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRlemeF+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEVPNQIe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRlemeF+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEVPNQIe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657HPg38759908
	for <linux-pci@vger.kernel.org>; Sun, 7 Jun 2026 20:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=swfVuia7jiOXExS+LqAUOMEp
	pKPJAifFHX+6qOB4k90=; b=YRlemeF+sEJ96lciRX9Gq5DgwWl3sPxSmLGpTGPY
	5df/XsfKLgZhs5T38MimiOImUHQvX/KO/aEi5HdktfIp009mQpgoB9ZzipYqP87+
	EZLjA3v9Gh3DRcVbScndY40URU9oEqrw4FiuYLGxj5nZp/9kpL3b5BCvbS/jXmCv
	b5EjWfgMQDRazi8rvOm2G6VvJWHs7pgKoJW+jDa3UuGsME271bytxh0O+TRj0pZy
	8/df9nOK33EAZz6RVxwz5kko9xZfCxqIxnpOrCCGrrx8ay/bxoYQblAA1YMuFMRn
	3ott3u4RIvOpzbeqoSw5hDSVDCYL0RpATf0Pual+NfBbCQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1chwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 20:01:18 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c33d75153dso1481208137.0
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2026 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780862478; x=1781467278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swfVuia7jiOXExS+LqAUOMEppKPJAifFHX+6qOB4k90=;
        b=fEVPNQIeapYdNpRO6ouUOYmknOOVcJYxHWwhhf1nWCasrMD7IT3DXDrAa0TeHjK6ml
         J9yfHAAyvXsovFYAcbvnwOQMbX11NJt4EbEAUx9CZjjEhi+ibGHsmsMyUsjYsPtxEoWb
         Py/jbV5Gqb5evzBxymy+73DfRowQV7QRVKIYXCr1An3TrxuZBvDGtTl5X9Fk9uwabujT
         SNz+Xpl7G31Eq24PhbhMRWmrDS/pBKs6nkU+BzaltvwW81QQIBqZSSgvrBDcWEf2g5qP
         pjf3MpoyuMKAseYnMkz52fOjiNrpRfIYKlLM7vtmU3nAfYf/OXMQ6D01euvNOKLAWYHD
         axiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780862478; x=1781467278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swfVuia7jiOXExS+LqAUOMEppKPJAifFHX+6qOB4k90=;
        b=PUILzvEYcHezMu96jUcTRPiJLENBLuWJhUyALZtVwIFZINEcSp18iekLZQrcwFJA6N
         aTbBBqY2wZTvW5hsjs9xzuEYZmWU6tLGAeGPQQl1skW2EnqTv6H6FxU36Oig++eMLjm5
         egDWD0Nd4f0uKHzzfqdbn8K0TszMwTdKg/92Kr4NtK1jDqdFWnZH4BadJJMzKEzJIoQC
         wQWEhBltr/eIW9W1oVNzqnWjhBRkCYfwr+r/NLM/TtkKABezlZl1UdVDNo8wdFdxc8e2
         o2s+XoWFp/eNZ4nDjdcLdYLgmIt1VWJDUtg2LQ0V/yi9G2G6+xL+Mv6v8rAESO2WpGZk
         jmxg==
X-Forwarded-Encrypted: i=1; AFNElJ+qz8MKXjrn4Vu/NXjxndui7hZyQHt4wggCHG4iKJ+MfIa2buFPY2e5mdwp1aZyQaXhr3LZWkl1czI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYGWSIgw/ip28HmuwJh6IYtBgm6nKckf1xXSQMJC/CcwPabTm
	4sMyT8tZVlzyCOAJm9SbWRl06dvOVjzS6lF+V8jUYbDNx4TVOuuvs/8nIUOxdfeTdR6gTHfwW8T
	Y41cJ6z/5KWw99A+B0k/s30Jyrf07JyKlryMV167Bn+Con1N88UW8WfWAvpzN12g=
X-Gm-Gg: Acq92OFnvxVrV8Cyo0ytKaDSoem/oPhODNjq/WSm/rvEuSDwnnDeV/9LHPYGK+L9Gw3
	tjHc7QqiVSYQqaQsnXnzZ6R0Q9EwMf6HOI8ZIqY68fRuYotP9nxt/g/ka8sLaljQDHEVZkcpK/q
	qgzHDmqaoxikAojdNDKFWlFNfRmg5o4578YC6TXxFI6nSo8K1TawooBlB0GwU1PCkvtXSgwZoEu
	EGH24iqHZrtV+3teitptkaNZ3WPW3BmkxxnLDLQZCfSKk5xSRBvGtMllSZ6GL5kun8X37VPzdpn
	de+Io4eyxeK+7G6bkwz4qgX+JkM9pPJk9qT3NhFv1ICsi1Q+0KBJTt3/g3DRyFCIiYQWFoyxbXW
	aiZDuXBH0I+cw/bYHWCtMtd05qSxYliay/eV9tOwIU+A/tV9LAUc1UreXykbVm5w5V/sxzngrjV
	3E6Iv6AwHVhIBZH5msB9HOjQFdYgqBbD5PYW312QoYJTjvCg==
X-Received: by 2002:a05:6102:1609:b0:6f0:6293:747d with SMTP id ada2fe7eead31-6fef9988a02mr5765002137.14.1780862476950;
        Sun, 07 Jun 2026 13:01:16 -0700 (PDT)
X-Received: by 2002:a05:6102:1609:b0:6f0:6293:747d with SMTP id ada2fe7eead31-6fef9988a02mr5764831137.14.1780862476161;
        Sun, 07 Jun 2026 13:01:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac091ccbsm41273641fa.14.2026.06.07.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:01:13 -0700 (PDT)
Date: Sun, 7 Jun 2026 23:01:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Message-ID: <2tenqkmwcr2gshtjwh44pvban4gtlzcgrm3iibkfrs4zh6vphb@h5losfunylr6>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260529-hawi-pcie-v2-1-de87c6cc230c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-hawi-pcie-v2-1-de87c6cc230c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIwMCBTYWx0ZWRfX/vOT5WYyNZuv
 WWxZ+ik1mEkLkBV7/15ZTikUkxVaRx8uWKij7mV16V7Gckpbk02tL83SXoGZ07K7f7+eSip3Cyg
 juuo/yv9cjm6o66AfBJNLlpK05YU44sRpD516UsqTRmLq6UITn4oU0kmJe0UVpEh49RegmbJ4gS
 yZ5a/DHE4UZaBx/Wc3Af0Y55IgeN62ATFSqd8Lvjx+YD8Ft3P9T2zssBqB4GhdyasmIPx97BE+o
 G4aw43DZf1pjZLHdUqIVxA3jIDCXPQAeEF/VkIc7r7R7Sx+DPfR9bTU2UAvPswGo8TWiA2HiZs7
 hFDJIPPff8B+D1fV7O4zf7gXqSbL3KnU1lPNpA9W13lz4sg4zSa0uDwIq+TxjoeukTBzNs3/2Ow
 MKReckB3ZIQVWJ6UXlDg16YkVWG2zLE7Os9jLtlZgFGw2CbRdd2nXpmhL5EaoGrXUBOohjurFwk
 VpDx8M1nUmNNBzPLYkw==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a25ce0e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=IAKb1KHifIJ-sTjyejYA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: Mll2888H7x1-m2tkvllBhrqRU63kRbTe
X-Proofpoint-GUID: Mll2888H7x1-m2tkvllBhrqRU63kRbTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070200

On Fri, May 29, 2026 at 01:10:08AM +0000, Matthew Leung wrote:
> Add a dedicated schema for the PCIe controllers found on the Hawi
> platform.
> 
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 204 +++++++++++++++++++++
>  1 file changed, 204 insertions(+)
> 
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>

Stop referencing clocks and interconnect header files. Replace used nocs
with ephemeral values.

> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

Not looking around should be a sin. Take a look at other Qualcomm PCIe
bindings. Compare them to yours. Then fix yours to follow.

Hint: the extra soc node is useless. This is just an example, so use the
default, 1 cells for address and size.

> +
> +        pcie@1c00000 {
> +            compatible = "qcom,hawi-pcie";
> +            reg = <0 0x01c00000 0 0x3000>,
> +                  <0 0x40000000 0 0xf1d>,
> +                  <0 0x40000f20 0 0xa8>,
> +                  <0 0x40001000 0 0x1000>,
> +                  <0 0x40100000 0 0x100000>;
> +            reg-names = "parf", "dbi", "elbi", "atu", "config";
> +            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> +                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
> +
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            linux,pci-domain = <0>;
> +            num-lanes = <2>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +
> +            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,

<&gcc_pcie_0_aux_clk>, etc.

> +                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> +                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;

-- 
With best wishes
Dmitry
