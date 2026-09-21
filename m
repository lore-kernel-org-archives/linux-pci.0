Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAF49DB8B
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998437; cv=none; b=PeEZQBCq6AHH3+bVLsrQq+2hoJG5XT8Uah5/OoRl9INBzBDGZfUxGbjPXPHKq16Rr3PaVG36uUPPYCfg/ZUGDlmQ9FhzpWle5aXip0+Ep5aLXSa7wBx70Q5xyNniqyaeS15IVi/7ndDwahs+gdLOhdZZM6P8kpkrxUThBbSt1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998437; c=relaxed/simple;
	bh=wExMQHi0VsEIz8YCw/Flw6gdTc2CLzrRZbI/C7wfTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAd2f+jMnzP6iZGPOruEzz94J6znRKw1YMml5UyUxgeZQ8SWkA84xGPSHZcWNDciq7L/cgwHogigvrE0G9ZqLx1dRet0jC27HdkHdL9Q4XwHG6LsxhFIl15WNLdik/XKnvntCkJYWlhzF4IV3pjoZYssQ3pI44BOWvED7xpekbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPzCIwA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JK/cbkgB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPzCIwA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JK/cbkgB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdwQt1413934
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qw3t/mWs9aOWgBnoW6d2vvKjBJYC5DsOvlhnmcywFhA=; b=cPzCIwA5jX3DywmU
	1HVITkOKj4B7k+UL3iJ5a56zVYzUB5jyFFP2+URe6bEr1JwwJoTZv0OprC65GVSe
	mMqLlBOmEJmaIIHljNf7/xpTZWoCOL5cZYrGy5/ZaQyLcP7hxqY7ZFrfILY2KqXA
	2a9SC1erMrqCXivYEsKbqjOuPHLIZADksb05nacccmkuORRKfTULMzYrerHqC0zf
	ZFwiQj932PHmfWymyjn+VH4sI77V6p/XC2XLR5kfq4myAFc4vDIiPSirk76mvA+/
	hhFDEtLgWWivC1d9STqdbOWNV5GziUPFPAn4Elb+2OG4Vox6wBTcsaiD87yAXE+3
	XAPRZQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d1h3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:47:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso42616705ad.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789998429; x=1790603229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qw3t/mWs9aOWgBnoW6d2vvKjBJYC5DsOvlhnmcywFhA=;
        b=JK/cbkgBNtCG0lPfCHrunQ+6zT4BmAZRhYaO5pjrBKlXhYzrHmzYH6pqzaiF6fwZ+A
         5w6MHGOM+CayFtGw6FS0gwcnIOugS5IMtBo7mI1aq/wljeZ8b5y8sc/7uNQpb4RWTv/I
         u2oQXwqGdMrUIQVUVX6LJPdi1dsnYvEbyeiJQd8XL8UhoBJWDxK7XpnJXhWgaHNI8BEC
         aSp2krfBMuGxrxhR0UTF2OfCppjV1+b66FsC9Ha8P5sQeXoH91BzNu8ges1E3+4DFeSj
         49ubvCyTIF3sMiqyqx6CMJRFCKpMTI8FrUR56oMiF2BiJvr2+EeTayxEcghKyDsFXgxk
         OoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998429; x=1790603229;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qw3t/mWs9aOWgBnoW6d2vvKjBJYC5DsOvlhnmcywFhA=;
        b=hLvKh3gujUF/91xMIMo+yEcfv7WFJL+KvssjCxJsuqOxUsmxaFbUPkaZV395b2gnt2
         DwITcokyKOJfoU9GeNiCviyVDOEKibt2FMmjZEvyEOOEmgn8OHBsplGCr/Ctbz/IMPJR
         VPp0p+7jPq9iZ74oxDAvjid2rGLsXbHNMa6bBs3hjkebbUbEkDKWk/AsN1TEh2sGaEE2
         P5kGFqRVd4cY003URD6/zyST4+D2Fg3e9BHma43wi7J96Af445K4+aBGhAy4kZm9xRPd
         3aR8j6JRBUGS0YUehubVWBeWgP8KBl7NtH34YmFBx/JlLOGagNazunga9/sFHuaYpdNF
         r5eg==
X-Forwarded-Encrypted: i=1; AKwUvBycpM4qOa7vrHe++mCwI+WiOsk3tAf6f36GoX1kTQpNuzjBlc8b8+RqiF9RYiys7qwDloQ3KIet6IY=@vger.kernel.org
X-Gm-Message-State: AFuF++nHRIzOovO5BOTuNj5sSPeEBK1rfS90dEw1C4o2qrrE43mL7yx5
	v5bZupjH7lQjRszaAV3hqVsA1gjz8G/x0Ofu9jPpnl4eTZjpxK7wVeQi9mGufAJkvU5UHPXQ/v+
	GQGH0wrpaaxcFwAuFTKgSit2WwQscuFjLmhAMUtQJ8oskW9VFrGWNDfTtQPDWCUU=
X-Gm-Gg: AYBFou1KfUaS8sr1CFLvpRoYs4FhY0Us+T3tSMkqLcwLcjF3VmvebWlReepYDBZboCH
	+jIwPqiZ2GzheEeSAC1G5rajE5QyRZ3FfJ21/IijxDNgIKPeTW9z73c3KyyyZYel9VW0JB2wi6J
	cYz6afZ0/TSps+cvOcGZLv2CvRMCKoqowc3QsNcPZhZukubwVFKwYdsb74ZKsEJHC5Pun205skW
	N34BwhzLDMv7S+sNzZ2U2WEIGwGk7lk5+K04cHYoL9iXhOZE7l6IZa2GkzN9S8XHo36r9n0bI4i
	B5M6Vcz9WiEggGAjy4OnSe+c252aUnLZ4u/lZuGUAy1SKpyg7SR4AxXLsqKghrbNs3Mv9maKO9d
	PnglKt+mLdM0FiHtVGPdQDUvlfORs75LVS80=
X-Received: by 2002:a17:903:2f0f:b0:2d8:d4d0:7930 with SMTP id d9443c01a7336-2ddb1b98b90mr155543965ad.20.1789998428667;
        Mon, 21 Sep 2026 06:47:08 -0700 (PDT)
X-Received: by 2002:a17:903:2f0f:b0:2d8:d4d0:7930 with SMTP id d9443c01a7336-2ddb1b98b90mr155543555ad.20.1789998428217;
        Mon, 21 Sep 2026 06:47:08 -0700 (PDT)
Received: from [192.168.29.146] ([49.43.232.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032d5sm34621395ad.83.2026.09.21.06.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:47:07 -0700 (PDT)
Message-ID: <7b5bec8a-87ed-4363-ac62-3e14f7619f13@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 19:17:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom,shikra-pcie: Document the
 Shikra PCIe Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-2-406661d75afa@oss.qualcomm.com>
 <20260901-silent-pearl-shrew-c63a16@quoll>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20260901-silent-pearl-shrew-c63a16@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bFEza3FR0ZkEzjZsJFoWfKf78VLOb1IF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfX84zNXgUi2OWT
 eS3V+dCjmbziK82LyWdvHAgHkUpdbrevEiKhq+GwPFMZEJP4GKT0Ky2r2IHAv9PPzT0lXI20Fuo
 eOm9pBiehHBDcJz2PNYv+e2AJ1HpIUw=
X-Proofpoint-GUID: bFEza3FR0ZkEzjZsJFoWfKf78VLOb1IF
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab13562 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=gjxls31er4aXgMEaaoPcOA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tLOCWTNIkaiYH31-AwAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfXxWiEClTDl18a
 hNKuzlgCqGqNao5e3vISNA2RJqKt1eMyiZfVstVOXOvWY0nPVWPSW1ZTjANGH9nXYhoKay27P9d
 ekdHDIXAKYOXp+H43NRfOhTU8rfpNySvNcHT8Zp24Wm0uYCaub1jdMKd2caLmYMkFjXYYMXVecm
 oyF9q12YHlG2sW2AaW41T5DMg5ahEejCWrcjTm3gAAI7BKVrq2DP0HMdtXq/Z1szS+qPhY+n0Gw
 UdSJwthkttznPAiW9UJFL2o9+vzOPHGKquAxG/9PfTSK4Kj8ccTMpCQZc5AlAAzkCqMOQ418lYE
 Y1dSr1FpR9ZkijUaw77HNqdPpJdLeC3NwmjWYhaYwg7MbZymbemFspKFm+FH6tMSCNaTfYMzGdj
 rcvxsyUeeBd6WiS130KgwwJABPIpoCKH4XErdHxCwhqpYOHbRYVh8DrjPZmWCkfT028fO1OVWu3
 KnZjkt+9Y+Vw+EyX4Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210200


On 9/1/2026 2:12 PM, Krzysztof Kozlowski wrote:
> On Mon, Aug 31, 2026 at 12:56:02PM +0530, Sushrut Shree Trivedi wrote:
>> Add a dedicated schema for the PCIe controller found on the Shikra
>> platform.
>>
>> Shikra controller supports upto PCIe Gen3 but the PHY is
>> only capable of Gen2, hence the max link speed  is limited
>> to Gen2 to avoid link-up failures.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 218 +++++++++++++++++++++
>>   1 file changed, 218 insertions(+)
>>
> What is the difference in the binding against Eliza? IOW, why does this
> need a separate file unlike Eliza?
Shikra does not have the Config NoC AXI clock unlike sm8550 / eliza. Apart
from that, minItems for reg  and interrupts need to be updated. I actually
didn't see any bindings with a clock constraint added for only a single 
compatible.

Do you suggest constraining shikra clock-names and other properties 
under an if
block inside sm8550 binding itself ?
>
> ...
>
>> +            reset-names = "pci";
>> +
>> +            power-domains = <&gcc GCC_PCIE_GDSC>;
>> +
>> +            max-link-speed = <2>;
>> +
>> +            operating-points-v2 = <&pcie_opp_table>;
>> +
>> +            pcie_opp_table: opp-table {
>> +                    compatible = "operating-points-v2";
> Are you sure dt-check-style does not complain?
ACK'd
>
>> +
>> +                    /* GEN 1 x1 */
>> +                    opp-2500000 {
>> +                            opp-hz = /bits/ 64 <2500000>;
>> +                            required-opps = <&rpmpd_opp_low_svs>;
>> +                            opp-peak-kBps = <250000 1>;
>> +                            opp-level = <1>;
>> +                    };
>> +
> Best regards,
> Krzysztof
