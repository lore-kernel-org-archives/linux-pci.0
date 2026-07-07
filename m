Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0083876DE
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404651; cv=none; b=BfnEWxY33EUtpbWvH0m59BSnMEEOzVfOJQF2wCUl2gEDXU+JbuOdOdvACkLOlQPugBZB44sEKPPvVdrxs/nfRapIR1sbTrTrateFmhvDAjyClZRydVMb+q/pw5VyaQIj75j0f1muCIu5fYIXvcv3avb3oehS7ll22F+3Rzgvozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404651; c=relaxed/simple;
	bh=aFJ1UhCzxvcgED6g7D339QLHCZxtht43L7Jiq8v6i2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhoD+4CNyIyVm3/C/hytKilH591F/6lyXvsNzJUAkrSSaYkUadHL+TQx9ZtwiDC+gyQdn0cFDjD2tSilTdTCjrG22/PGHGUf3BaetAy0UvJc5PdooVLXKPrXF6jgG6lQGR0FdoBRAIiW000sOSU/NxWqoe0GaER+Q+mhtUItzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXrx9nDz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DkMhRuKY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXrx9nDz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DkMhRuKY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749WI02631883
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 06:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x0GnpLUCqHMPUSbU33Fj63+j
	1ve44zUEAjqkCUCuqBA=; b=QXrx9nDzXH77Iwur/NPdhfcrpFEtbsyouuKvVmt7
	8emcXKYiXTYs783bF5p81E77gcP4JwlC+AUwCM/w/JKZor+OcY1U32A50s+82XcD
	Kbk1Cq7EfN8lDZ1vs+cBRAKRIB+yKPz/4dGmsF3fPIAMqxl5hf6VnuQipeMNZHFh
	wzIr8jBoXxi+ngYH1QttqgXJACbPkgJFuOKnM6FDxTs8EWjGx0jV0BXYtYQTzbRW
	dOjZFg6MWFQxE6YG8SZbAjVtWceX5NECHg/qDl+qLtCnR8Vxd6XB8DaY3pWV49AI
	odDM02VNiJT3T+UCj4F97S9c5nJ27B3Fob5EXSPUsF6frA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h54t4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 06:10:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c890bac374eso5983286a12.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404648; x=1784009448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x0GnpLUCqHMPUSbU33Fj63+j1ve44zUEAjqkCUCuqBA=;
        b=DkMhRuKY3gj7i9qzM2GGp3MnELMKaI1uSyBvxlqWTcfMkrYv2Tb8uZaEEQqTu0mvJv
         oLTGJtBdLdjn1IDtKwqXtUvUwyglE16iV8BaG8QO6k85Bh8vtisPHHR7tb8UWHjansT5
         5W2ut9mnS7ocFBxshIjZldR6dWYSWj8TW8tpJ40eHCISGA4IhVMNPeTlTw3SpnkRiI65
         +teCzPWb3InBGnx3NYMlCEMnFB7S6jIuu8sMsSN1+ZFu505MgBwiLcFR3zPgfnM37TeW
         gpDG+AF1WyVAA3iNBE1GEaoLuf5eRK6RVvs5xjeNGGpfe483EamIxgJXBki7iDYZXshr
         1eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404648; x=1784009448;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0GnpLUCqHMPUSbU33Fj63+j1ve44zUEAjqkCUCuqBA=;
        b=LmxUVCYz9+LuEbjKmSQpOuJRGCZOt7BL3KJO0worsbfMYCdGOsqc0XzO9eZaHrvkdH
         ILY9H7fGNZXFUXV57kA9emsqQRIjTTHjyC68mJ44EDWv8qZJbsKG+yePBgwvWdgYIz3+
         MkplY1sun2a2b+exRBgkPLZIbch22zcWBXJQIJuO72DTSHzsxDDYRjixfxTFnLa3Rvy4
         Dvq7ezEyX1SffdWBFpoKYsnG5bxzM8LC96l3UD0D/a2MEqntbVvcHDZhJhsT6XNYAVSI
         +1NArY5hrcdtqjZail7GlOKBzu66ONuMwX+D6mk0WJPIWkAFluxdU3c2JdxIyuzJqoJg
         YfBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeUe4G1kX4onF07PbYmCSwAaKwg+NU8OJgqzpF6IwxZ1/BwHbx4SfESJ6wLMtGrL1EOvIkZxD3Fvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemchWSthQxuKWofcwAyljQEuy/FsR7AERf4U2eD/PA0B22EN5
	1k7ZDCLVoJuOjgLhv4vs9Wt9ZbhW+ajiS++XMvVA0gPEv3OVrbe8NRqzWc39/sRQBxuyVNuCkI7
	LCxxSgabnDG+Lrh9RtFnHmW99Xv/8KggPUtq84/Nz1A7fEe/cOMznyXeQB3kLt4U=
X-Gm-Gg: AfdE7ck9HcawKp2a9kCqm5JCoYDHcnyTiC1RhQN6oy3GfWlERjYanRXWAqOkBtp8Pia
	3QVXbcWymSGqmzW86PJYahLCqobg/7r+KDnHTA1r4hgT4mOUbb3f+yTW4T9WvaNd8eoYecUaeoQ
	lkeYx+ZrO6E7UeaoJlN/bsnIqgTmfiVJY5PaUi76jQWC/dgLfSdA4tTQACBICCiH6k3FE4W0mGX
	q2G0moEyqVZ9BPL7cuDiwL0N2B0updPkoYs6D4CdIlkdTQWD2GZNPCcg71e6+2547O6D7XCU2pw
	mWulSkJUBoCBNEwPL0iJhnfvz2BFBIPcXUKmyUvSjHTGXreawX1b11lfOuZ9tJkoB0JO3kJqYD9
	6ImXw3+alDM5iyGq5HgPdVzscTR9F3Q8kRY3e6GoJMm0ykpV7K3Xi/EAe0Wukf4TV8iLcKz8H+W
	a1emNHKLHzbap8xOvaidzqxs5x8thYH93/ZWro7Cu2
X-Received: by 2002:a05:6a20:db0a:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c08eed69dfmr4615305637.50.1783404648172;
        Mon, 06 Jul 2026 23:10:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:db0a:b0:3bf:c49d:9183 with SMTP id adf61e73a8af0-3c08eed69dfmr4615271637.50.1783404647686;
        Mon, 06 Jul 2026 23:10:47 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac0557sm5151107eec.26.2026.07.06.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:10:47 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:40:39 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Enable PCIe support
Message-ID: <akyYX9XsFTOfuzyQ@hu-varada-blr.qualcomm.com>
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
 <20260514-pci-ipq5210-v1-2-a09436200b35@oss.qualcomm.com>
 <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7cb371-e94e-4f42-87d6-70f0f94d0d49@oss.qualcomm.com>
X-Proofpoint-GUID: PDsK57wlxULQRk1f45XEoIwM4BrhW1EE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX25fGoYRKXg0d
 qnKMtmzpBeHyS10SoOQOOoGjU8FfzT2wqdsLb465onUgkBABSx/G8qkOYxUKTTmHwbwqf0Qp830
 WxtFUa9RPKKuELKXffXHyiPAf8eSiLk=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c9869 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IW_28pUNWusqPMEbcmYA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX68884JCbGYUf
 RFtM0wn5RYuEsgTclYI4rb/k3AbwDnA21n+txDmrHWjs/+ue5Q7LZE1uMJ+yH0OsKODo9qSmvmQ
 TlFUEoezxQdro/cdp8poBni3nmdwO+D9dyi/aSrNzz6IE74Bypv9XVimnacGqOJiFsLlVTka0kA
 2LW4z0wILIjJZR/Sqdcidm0YmmvZPY+L/roqSDA7kYW8fqAFQZMTNpBcZ5dTCgQT/idqM+JUREM
 jHodJt1xV0JyChIHx6rbpYtV8cpJoYwxl85qDQc89lLy3tqiBtVmMqTAwMkf7V3mD0hPWuFIcVn
 pMBtUuRzuHSUj4URZ3Dtp8WFHcY1a0F/+pj6bqd9N2YbOampHuz5uZU65ZxwFKQ3r5RrEvf5nSp
 dn2i/NRXSCUxGOiNeL5hFglT0WgKnj5PP4BV10Q/nlHNtnHaZ9bhja6slOpoe5bF/WmZp6KPPN3
 P2riY7sSBPrpc8bwJYA==
X-Proofpoint-ORIG-GUID: PDsK57wlxULQRk1f45XEoIwM4BrhW1EE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070056

Konrad,

[ . . . ]
> > +			assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
> > +			assigned-clock-rates = <20000000>;
>
> Is this clock supposed to be fixed at that rate, regardless of the link
> speed? And is the default rate incorrect?

Yes. The default rate is at xo, so need this.

Have addressed the other comments and posted DTS update patch enabling
multiple devices. Please review [1].

1 - https://lore.kernel.org/linux-arm-msm/20260707-08-dts-v1-0-fce82e14cd1d@oss.qualcomm.com/

Thanks
Varada
