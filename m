Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1723C4B81
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611590; cv=none; b=DfNsVabX9THdbdW+lsOOW5hIHkdIbNwwWRb3OzQB4EPqDfxu3UAL46RS/QpeIaQ6wcxDOebnD3h0oZ8PcPtrS0g/g/mUOqOAzFAyAjwOXNXwrqWMDpCRy7q4WyF+pJl18lPVEcZIk4O6uGWz7+lHeeDDcSOJSPrLx0x0jmIFKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611590; c=relaxed/simple;
	bh=LANuCJkB6nXzMBBjiSyLvoxsquUOuL54/jiE6FqHLOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwFdim2YU2lrzV74g9xfYaLnSB4TAG1Fc2uAWojFyXW0DsV38GEMUJBou5hENUDswQwhDrc8+Rnb3ySn3bA+AxfjbiUPsdK2s3ax71A/p5y1Uk82LwoAy51ICQlcgJH798KfxAg52sMTTAzNgopcSkxzC/LReXFTSBfUXzH9hgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XexN0C7L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlWAvdtE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XexN0C7L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlWAvdtE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCrRP3978765
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=; b=XexN0C7Lrij6xWQV
	MbbvwH6jE8ckCVIjfwyVPt/k3+AetSZ3YOWR7N9K9W6M/3x1GfVdZIoaVpRv8aoP
	qUc0RqD1X8SFypXFqJyAHrm66PNvvIMZU3I3ZAEzNYi5e7ELiZEEDtANq705JSjT
	GnuUrL/WwXccJmP92qwwstypoG6SujTnv2wL/FKe3a5ghvLlUxpSP6ydaGyt8DMP
	BfK5xp1hBE2hmnmzwbbhOExWBaOBMeshlWbUc9OKgyTcHmkgzKbmFG8Lh13SjIQH
	Nqm6/bVnURd+onH3b+BSl3E9rJ0jwF3smL/tJvgjm9H4ku0kU9j1dasxR04e8ELx
	Wa+qBw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv42h9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:26:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848662cd2a1so8078063b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784611587; x=1785216387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=;
        b=PlWAvdtEZayOS2Uz3cQQQw/pYmCFHl1OmMkrxX87w1vHGQlWDvDf99rMOjZqoeFree
         H9e9H8pIn7CH2y/yOtngnCjnVryVplmzLPxjvaCzJBhNz0PvhPIEoNjAm8txwFyoNRIA
         3GuEQf1DPdmXAI4au6ek8TsM7ITzog+mgAhiK5j9dwu724O1KbXFY/Z5ihia76Q965Zs
         vk4vlUUISaoP3dCV8DB0E2StV96neaBmFcTvVBtI9PaR2o4EzY1drPBFLT5WcBWxgZy3
         Y5eGAARkXAu6zz4jghQcg55Xso4663cccdBMWH9k8pRR3Tj8KAPbISovU887llMDMfMY
         AP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784611587; x=1785216387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=;
        b=GG4J1ENB5b8baCcSOyzzdg7eFqPiDwyYgTK9+fD1fzw97hj29ph1P1/47swGzGlpTa
         M1kbywJXZ4M50wi+BKpud09tWyVk8f2ou6h9hTlaCnACNv5j8rX08YCaDFoATI17+DrD
         ox+K37q5V/v8NSqnYc+xHhNpo2qm4nmhmjWNogElWN9GLwbwkPZl0YCnrt4m+HYuRwEU
         9DKAeZK58WUGlu4vCR129unEOoD9cF8J3PgFz7BZxg3i5fsMFIJZQxisRlFK6rnOX0Eq
         v3IL3NVOiQfWB95LUPHXaKb40Csm1fQVAnU/x+qHMwxQ983poyRWGwdRrhZemAPUrA7i
         Ydcw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7QR8YAAYxr3pvyH23TGlmdFk0K+8iTI5drMzfhxrBcZhpaTg9r58YfqxYvTFUCnyqPhHVKa46xrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlr6NV/caon7ZLah99N7PVur2MMLen5ejJTYA2HgqTO8XG4AOb
	uDrvyw4Kg3WjajZ3w3hrOixbbIo4lPkSHOSbCwyja+bmEjzUHXZhZ60C5qP7NtXrb7bIskkWja+
	99lwg3dLe/d3y3WSuF4F602/bSWLyTTswmE9YmsGG9wxou0Ac92dyq/ngCZivb4E=
X-Gm-Gg: AR+sD11BuCc9cB3qiIrCxdbzEtYz4zjvqqn585h71YgWp6VvH/lDbApEbupnRVwrBF2
	v7TS3Vrr5hlaPwD2EQw6mjSG3P67vIggAaplGnuaNi8TeifBp33OUJbYbYOCoYNP8TmJgurm4ah
	AZEitkJFn7B/v/jzil0xSE6mMalJdTsEOojLfXiemcOTDIKSTiPy3zBvpqtojMg34JblYKHDL2e
	n2nhUnbfhNQoaEI9+febQmSmOH6Z49Pims5djb4f1YJ/98heTXzTRYSJNvhxSk9PQDBjXm4ywme
	Se9dlnY6J3YZiQYVe3uu1rv7JD/TpIAEhhDtinCbKWTNeSkI/OmHqEMZI33e2E5kkuQVTdI6NFs
	3NuTMdWaNVUFjNxt9Jv2sOXEOBcTVr0CF
X-Received: by 2002:a05:6a00:3e26:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-84c294c870bmr15377098b3a.75.1784611586675;
        Mon, 20 Jul 2026 22:26:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e26:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-84c294c870bmr15377086b3a.75.1784611586174;
        Mon, 20 Jul 2026 22:26:26 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e401sm6649207b3a.48.2026.07.20.22.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 22:26:25 -0700 (PDT)
Message-ID: <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 10:56:20 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
 <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WKE5wJ5Hjf3tPU2DtaWOd9qPKh-XgV6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1MyBTYWx0ZWRfXx9bBe8el8FJk
 4wLLIfLXYSxiwINzarugGw8qiQr6YV0LclSCKq2XCAHU7gM8CxRDkwKe0T1Xhb/LdS7KnxiJnwZ
 Ko6wSGHgYNjavYIR9i2XQhERLmLCfodcoCDNEgo3zRew/QN+vBNUClwoRKvDZ3by/idL9a/WTW/
 kFoqgsA1PipEJjFZfDVxPHFSPIMnizDSSxG3F/BiKkQvLBXYtWWnA3uEY74REMxMqB+sjRAocy7
 EBVZxFUGNgYeWqXkSzcMhFkkbC9rcrhftyFSMeGe3wpfBj94khSDksisD0AsefM68Wbth98i51v
 qT5WoyzRdbjLchAT0Y04mfawCWOfFMhjwAEuMvQolYB1Gu5pmf7qqnmlMRFm9sa7j+QqlqR6BE/
 PspuSKEh3+LnHJ22/N1WVBVuRgvl9bP/3Ng5OxyVJcHxldeerVdk+PCs6ZarBPMA1EkIWT4Lka2
 LYTP0U9hFsEiPHqbWvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1MyBTYWx0ZWRfXzxUD5R8VAdes
 LRmjTdFXYJSiFiTDEf1VxGOOMHVVYWMta8iDDuvNp2/PtupErTj2WMsWAu6V5q57lSmwtfNuCy5
 v4aMHhh5tzY90gPEIkFPzMt2qwpPgvw=
X-Authority-Analysis: v=2.4 cv=daawG3Xe c=1 sm=1 tr=0 ts=6a5f0303 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WptVsyCosi7Mub_EgEwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: WKE5wJ5Hjf3tPU2DtaWOd9qPKh-XgV6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210053



On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>
>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>
>> Override the base iommu-map with the expanded set covering all the
>> switch's downstream ports (0x1400-0x1408 SID range).
>>
>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>> from the PCIe controller.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
>>  2 files changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> index 6d76715ccffb..e099b7c8c371 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> @@ -12,6 +12,26 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	vreg_0p9: regulator-0v9 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VREG_0P9";
>> +
>> +		regulator-min-microvolt = <900000>;
>> +		regulator-max-microvolt = <900000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vreg_1p8: regulator-1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VREG_1P8";
>> +
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>>  	vreg_pcie_m_3p3: regulator-3p3 {
>>  		compatible = "regulator-fixed";
>>  
>> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
>>  	};
>>  };
>>  
>> +&pcie1 {
>> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
>> +		    <0x100 &apps_smmu 0x1401 0x1>,
>> +		    <0x208 &apps_smmu 0x1402 0x1>,
>> +		    <0x210 &apps_smmu 0x1403 0x1>,
>> +		    <0x218 &apps_smmu 0x1404 0x1>,
>> +		    <0x300 &apps_smmu 0x1405 0x1>,
>> +		    <0x400 &apps_smmu 0x1406 0x1>,
>> +		    <0x500 &apps_smmu 0x1407 0x1>,
>> +		    <0x501 &apps_smmu 0x1408 0x1>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +	vdda-phy-supply = <&vreg_l1k>;
>> +	vdda-pll-supply = <&vreg_l3k>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1port0 {
>> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> No reset-gpios?
RESX & PERST are ORed in this platform, as we can declare at only
one place we declared it in the tc9563 node as resx-gpios

- Krishna Chaitanya.
> - Mani
>
>> +
>> +	tc9563: pcie@0,0 {
>> +		compatible = "pci1179,0623";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +		bus-range = <0x2 0xff>;
>> +
>> +		vddc-supply = <&vreg_0p9>;
>> +		vdd18-supply = <&vreg_1p8>;
>> +		vdd09-supply = <&vreg_0p9>;
>> +		vddio1-supply = <&vreg_1p8>;
>> +		vddio2-supply = <&vreg_1p8>;
>> +		vddio18-supply = <&vreg_1p8>;
>> +
>> +		i2c-parent = <&i2c4 0x77>;
>> +
>> +		resx-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
>> +
>> +		pcie@1,0 {
>> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x3 0xff>;
>> +		};
>> +
>> +		pcie@2,0 {
>> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x4 0xff>;
>> +		};
>> +
>> +		pcie@3,0 {
>> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x5 0xff>;
>> +
>> +			pci@0,0 {
>> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +
>> +			pci@0,1 {
>> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &uart13 {
>>  	compatible = "qcom,geni-debug-uart";
>>  
>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> index cce65e18f979..363cabc5f55c 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> @@ -2102,6 +2102,7 @@ opp-16000000-3 {
>>  
>>  			};
>>  			pcie1port0: pcie@0 {
>> +				compatible = "pciclass,0604";
>>  				device_type = "pci";
>>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>>  				bus-range = <0x01 0xff>;
>>
>> -- 
>> 2.34.1
>>

