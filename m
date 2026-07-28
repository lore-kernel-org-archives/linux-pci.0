Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C93B8D78
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220189; cv=none; b=D8hrls1T241qo1sr/w0kEKBJ7OKaIbhiM+YFpjaTdQI85IH5Q5EpmG9p07sdCaoKN17G9HkY5NRJtLSVMGyik+OeFpr+2Q7BudO9GTv4AqejtTdMXcChr4unkdydrUzTY0iAlsQkSLronzz9zuKxMieJOBZbGyYiDgPgptju/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220189; c=relaxed/simple;
	bh=oWTrgw2+xrfm/slKCNW9ibJEwJpUcJYQbtbrwcMPRUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB7fii21ayZ/WgKlKVAO4r1s5xFU8wROSBZtuZa2FkzAD9QTuErTg6L0si48znqdpJKxD1OEG2YlRvL7BuGNkVtoaH4/gQJjOHM5hYbR4zwH7J2aMRFZM6YF7HHEW15XjNmBb+6BmCAlaDRfXGe3Yo/eP9gGCRv6qDeQwYXeyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lw6aNC6o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+OnVDVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lw6aNC6o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+OnVDVp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3ar1u1701602
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ElPf8a6niFpR9VyWE5K88kAbHmmM11rpy3xejveZiY=; b=Lw6aNC6oJsGJ22zP
	wH0FGSxU/BAaA0jgrP9qG+uuz6T3VP3jrW9hpgxhaqjS45Wf5T/agkULeMe63V9P
	pVz7r6I+RWTigja4ZCxY0xKuzvYtBl9Lff2hCk4i3WxI9jLUSChxQtR91qNGuNd5
	rvbmfSd91E+s/db55LGKMHwjfu6qjDglMHNdgTdQTHeFKu/7g660raFRbu2EOqH9
	j95VAi4gt+HVR6vWejRnb/cO+8xt0AxAqBQFefewHnJ162iwevXRJ9WJrcagjcF3
	eOuxWdAZ3TMxKsWoclW1MNTvEmu6mMo5SNyqMo5FXVQSnWMaEQH72xNxo/kYmeNf
	dQE+TQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7h96c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:29:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee894b3d8so43603725ad.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785220183; x=1785824983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ElPf8a6niFpR9VyWE5K88kAbHmmM11rpy3xejveZiY=;
        b=H+OnVDVpteVcuxTzshSkMeQ+mr6TV7mHQJjyX+M0ZgmneElY1w3nhD2xOCkidqOQwM
         CIwsqkb0clIynFB1tFVuiGzPRTiknceHcddOgzTLu9ojaJyilblRMadPrYfC6L7ximo1
         2lKnI+novotnsIpEVI5gZhxLrQntXHCRwcDmfGpdNTdDBAckRTXz7n8G78fPNmEdjmv2
         pj0cEUm9vKFSbvtlYGqHFiFqDoS82m87GTS8J5dJRW5lc54fICAr9kpZPCh4s7xy8hx+
         8GJqntYlPmC9pukwmKw4RrX+v4ZZQBw6iDh4mBb9bwhP6e0y+JMcPYku4GMHh18kaovy
         GD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785220183; x=1785824983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ElPf8a6niFpR9VyWE5K88kAbHmmM11rpy3xejveZiY=;
        b=lO/+LpurRivOGQFQyNjLl88AZYwt6XNf95m9t/VTuzaDClAlthg7HDovmM2tBYEmuA
         NSRkDlL9QVvCaYzNxenlRq9czu+NMD3gAEPeUQHLgtg13LsNJQfSyE6z50ltC/GprVk/
         aLidxLMCOJcbelMCertHi01Qkg3xgKiQsIexeiRdKQXksbVSUHEH1Ug9nlc87ojh3WsM
         wQutXUAk7/cHs15PxW5IUyawKG7EpAqT2LboBZ6WSiFT3FZG4yVWC0kGPw0IIZ0/ruaT
         a0rUnkRsrUyJO+6+vjjmtuFhwlGIXJOpDRWhL3UbSFVgAR/cIxTu1h2WTIepWtFLUZxH
         GT9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqzCg6Xm/2tm1EwRxiAMkCD6+kOXZv0KG0TZniqlBFAX9RfevSs4nfZi65MruZ/aEG2zzqZhGVOj94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuvsjn6Uj+/dtSQ/j6Yd04jTm3AUsdmZ3UAWn0eK9Ps65kUGPL
	EZqVHDuBHXGS0FDbWb8FWMj4A+XzOm/g3vkdLoKO4m0vxGsZiAGadybUERsRLMHb8tr0lp+yjmL
	9P+TAakSz6XGuyxBXf/DXCZ26m22jUBCK9zayxdieVVYLU6EAI0L195xqvUuGcTM=
X-Gm-Gg: AR+sD10E2fQwZh/ctUX+jmIZmEYp4Q+XQpBb/HvVSQz9PxaCdkkGquVdrdZYyJv8V15
	h4dkkLl6a0KGn+QWvL5KT7O84UFPSmJ37KzmOB3T7Aiz0mSvSgnLPEuU2p/4WUMXReP7vxJgtec
	xanqUKkts0aRd6M/Vq5h3jJiy4dAUm/kVmLqDXn7sAkxzVAvwJPaqYHj84mQ6Gu1HSAC4OhluUf
	r5OoHSRmukD4V/VXeTrF/urAeCafMhT1oAZz/BkvR6oa4YAKlSsbnCQ6V0CovWGqCw9l3U1sS/z
	9yno/zCgjvQ/yyEvf+SSwn3tNgwJ1GlM62tHgNaCePYbqcMdoyymfQA2C3528D1NJmcSG5mGbDx
	Mgt84NmDV2jcTqyZ12i2ZLzjpxcnOdND+//Y=
X-Received: by 2002:a17:903:fb0:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d015c91d62mr12700105ad.10.1785220183510;
        Mon, 27 Jul 2026 23:29:43 -0700 (PDT)
X-Received: by 2002:a17:903:fb0:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d015c91d62mr12699815ad.10.1785220183074;
        Mon, 27 Jul 2026 23:29:43 -0700 (PDT)
Received: from [10.218.37.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81cd32sm45706925ad.78.2026.07.27.23.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:29:42 -0700 (PDT)
Message-ID: <e5516c61-44ea-4224-9da2-1694eac10fec@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 11:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Maili PCIe PHY compatibles
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20260703-vdev_maili_dt_bindings-v1-0-c9df0916cd5e@oss.qualcomm.com>
 <20260703-vdev_maili_dt_bindings-v1-2-c9df0916cd5e@oss.qualcomm.com>
Content-Language: en-US
From: vivek pernamitta <vivek.pernamitta@oss.qualcomm.com>
In-Reply-To: <20260703-vdev_maili_dt_bindings-v1-2-c9df0916cd5e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1NyBTYWx0ZWRfX3eenremuPqJV
 hpss4AdKLnrpD1Vqq8i+CPOJC03AR00JDAljtxD2KeEUT6KNt47duOAqVpPliPe7r3lUXxwjXPd
 uA8UbXbDEd0Zah6C9d3+U3Utz3Fxi3MzDA6ja7YNdahRtB8iJr75xtZEK44wFP4gkELPiHM0TEg
 55AH6XIupMH4PN9gnkofE5CNIUDgrTuN+SC/s8CumaYCf3kk/BaHYBVMcqNQ5+29jPOt0/TXSAa
 uQo/odEKeAB9H74Jprqkal8KUbRalYoQB/B8q7852Hgsy67baRGkDL9yUyTi0XBmKFtLnfrdj8A
 hQ12H+LEhkw8K9khKDGz+RcpX7/qvQAq00B3ixDGVhrL0wlPZx1XGa8HKMe+E7i6sgf3+fjfEeh
 98aTFeS1h5d7xbDQ5CIwj3wDNES0maaOZTHdne70NHU0H3wBgZM4Cr6EXwUb46b41/7gkaDtRV/
 8Z5AYbsrXFF1m2JHPqA==
X-Proofpoint-ORIG-GUID: kT-nahZiQVE6gZtFIRPYV719u6zPsgJ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1NyBTYWx0ZWRfX5ToAva/7DAzA
 oFe/lUew06xkMH+5lNsV5FDAJpOVetWArZFgoYvnsRSwgpuNSvvIWEIKqcSPctH8XtcngbWUENe
 pZM5Nzl9Q+PAhaZfAL4V+Qrbj0Wt+d0=
X-Proofpoint-GUID: kT-nahZiQVE6gZtFIRPYV719u6zPsgJ-
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a684c58 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4DM8Ldo2K2qSuXsH2HoA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280057

Gentle reminder

On 7/3/2026 5:38 PM, Vivek Pernamitta wrote:
> Add qcom,maili-qmp-gen3x2-pcie-phy and qcom,maili-qmp-gen4x1-pcie-phy
> compatible strings for the Maili SoC PCIe QMP PHY.
> 
> The Maili SoC is a derivative of Hawi and shares the same PCIe QMP PHY
> architecture, allowing reuse of the existing Hawi PCIe PHY DT bindings.
> 
> Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
> ---
> Dependencies:
> - phy: qcom: qmp-pcie: Add PCIe PHY support for Hawi
>    https://lore.kernel.org/all/20260618-hawi-phy-pcie-v3-0-3fa42ca45ea4@oss.qualcomm.com/
> ---
>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml         | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 259ed9678393f12c03535389b972fed0c7e36517..971474526cf97cf333a80a31e8fb13abcb995e97 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -23,6 +23,8 @@ properties:
>         - qcom,hawi-qmp-gen3x2-pcie-phy
>         - qcom,hawi-qmp-gen4x1-pcie-phy
>         - qcom,kaanapali-qmp-gen3x2-pcie-phy
> +      - qcom,maili-qmp-gen3x2-pcie-phy
> +      - qcom,maili-qmp-gen4x1-pcie-phy
>         - qcom,qcs615-qmp-gen3x1-pcie-phy
>         - qcom,qcs8300-qmp-gen4x2-pcie-phy
>         - qcom,sa8775p-qmp-gen4x2-pcie-phy
> @@ -200,6 +202,8 @@ allOf:
>                 - qcom,glymur-qmp-gen5x4-pcie-phy
>                 - qcom,hawi-qmp-gen3x2-pcie-phy
>                 - qcom,hawi-qmp-gen4x1-pcie-phy
> +              - qcom,maili-qmp-gen3x2-pcie-phy
> +              - qcom,maili-qmp-gen4x1-pcie-phy
>                 - qcom,qcs8300-qmp-gen4x2-pcie-phy
>                 - qcom,sa8775p-qmp-gen4x2-pcie-phy
>                 - qcom,sa8775p-qmp-gen4x4-pcie-phy
> @@ -230,6 +234,8 @@ allOf:
>                 - qcom,hawi-qmp-gen3x2-pcie-phy
>                 - qcom,hawi-qmp-gen4x1-pcie-phy
>                 - qcom,kaanapali-qmp-gen3x2-pcie-phy
> +              - qcom,maili-qmp-gen3x2-pcie-phy
> +              - qcom,maili-qmp-gen4x1-pcie-phy
>                 - qcom,sm8550-qmp-gen4x2-pcie-phy
>                 - qcom,sm8650-qmp-gen4x2-pcie-phy
>                 - qcom,x1e80100-qmp-gen3x2-pcie-phy
> 

