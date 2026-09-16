Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C55013D4
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575219; cv=none; b=q6tt9VI0QSfZ1RKjB1Wr1lgV4OmMlSUDbZnSluxl2v6zOedCccql8XXbBCerDrPJ18P80AOIPHcBKhl0IXeKM2atG4CeVPqPDF9E+fVJvsO+Uk0pTpGiNd8u6sbtoCStXIs2cQFwm5I9e/FWQfH+78SpxYMkd770e9+sAjLV5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575219; c=relaxed/simple;
	bh=bvzruHOER+tqBVKqHVqUWmL8gkxbGAQ2vbFxKDXxPC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRa7D/4bRfoGmjq5L97kWcgVWObsJhdMfVccQGLCeBJzKybuz6Z5AHqGpuD7keCnGgVzn3nTikB8644KJYonASElbBAg8qzcP1olUbI6tY3z0rKo1AjDIIFfouicczuvIcBOVeDftMmY1F6TKZ/bNc4izm3krXosf5U/CEuo43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DHv39bTn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XX0y1Bi1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHv39bTn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XX0y1Bi1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFfOeM2602245
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7D4/ywcwxqoIaD2knicVl0ONbCnWnKh8GAaiP1pjZEw=; b=DHv39bTnzaHvBHmd
	ShUgZGfYOYR9RcSKsUy5DG0vfhX3rIv7tn8p+Wp0CQtTZMPofacDOghO0xmw9WH3
	XMF5pghRjTbOXG2TuClcGj7Gwce8bsqX8vZ2yT3kVkePGGIbxM8hTpMlNJHUnO47
	O161PPoDd//+rcxVg9mUWcIfKNLyQHYTzWoF1A2DuBeM+OSYXgzbSlBgwsJWegeR
	KhRorZ1KV+F4MHkeMX7VHnGU6NsvqlJXVZKC9SSO0Ap4W4cnXnTOaWD6/alxLI66
	uQtkLns62xgSuIAajS1pOhpd+B6IPNHLTK4sk4rocYdyJkqINTBaVrBR1CPMBL31
	6FpqGA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb0rvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 16:13:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a312222dso80215785a.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789575215; x=1790180015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7D4/ywcwxqoIaD2knicVl0ONbCnWnKh8GAaiP1pjZEw=;
        b=XX0y1Bi1m0T9UAbOKXu6dJadeUEZfAA5qxn30bW2/PHNBXKDnUV23qsG3GZIIqs9zy
         uS6m+cfYVWsG9xZv50tPcoL4d/QhfV4ataS7qJxkB+p8BThPXBFyi9awkmBPC1d1DT2X
         bZGU0f4mej4CCjUjsM+gvrP878prI+7/Hl0VSm/Z9CdHjeOyleI9Fhqa0Wtj93pSIhS4
         DX7Bg+Mh/nUgMah3Wk9dQ2+9nsRjh2x9eLdyUJ1OetmRJiHCup4nE7Ereu+oLUQFy4TZ
         VWsYXmZ92Kkvc4LX0V79R+Nm698dNqbb+GJwkpTIoUdPMchjjh8WP1p3dIgfJYGbjkFo
         2dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575215; x=1790180015;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7D4/ywcwxqoIaD2knicVl0ONbCnWnKh8GAaiP1pjZEw=;
        b=cIrvy/8Ma4LqrMHf0jHBHiqLMENppgeTKsFBdQM77dsyoPSM8kvjxmVHBgbs7d9YCT
         RK+D+eemBVIzX9thz9jlnOptiy3MbVpckdKhVtG50nKxtZmXrTGCUk+FkCmdsDy5MuE4
         Kx2nd2pIbt269Pm8KzLixdYEWXOrOV7CxE4TGxq2SMBkCAXBRxUh72CZgMqpy7jl0vST
         q/6RnxuWq8YfRmzIHReNJ0lqJtC7tILBbuBW43bECHZtMkBi3jA2sZlm0SDXkjkAKfhc
         ut+vzioEUyJibFuVVVCI5QecltoRE4GwW0HyJ6LHphqCCP8kN1jkGvxoIDUHY69iF0RN
         cT7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz8MGt8QbaqOSlIEMyNP4G2CwCZGUTMKcLgZQBJkqPq933tie6tl6U6saWWCzMYv6H51hW1QgEm2BA=@vger.kernel.org
X-Gm-Message-State: AFuF++mT2MdCn/50VLwdywQk6vYY0AlcE5dZEKV2IyR7KwaDgj/atzjO
	B95fUMVFJ6U6hgOnFAvXkIPEYZxCiPSGs3ufO5UsUX5OaRnBB+g6hzo7MYCcdIsxtlcK7jwF4dw
	48NYlUwQIL5rPXhV9kv2vgDe69FrXdXlrWFx7yX7FyE6/snRhSdMkyCQHy3F3Fw8=
X-Gm-Gg: AYBFou1Jv8REcZQSBaIOgiHi7hWVf5jbuagr0U1wCK1cORu7rNjR0+QyZ84RW6oZtZk
	c/uzjdeFWCTpTIJqVBBGYFkJWQEghmzd7swS+U4mFigS0UzYzMXibR5k4LtS93rk4rwu6iyHF5N
	k90oVaFLd0j+25Kyck62x+EmIezXPfr0oRSy8OBXrr6AvnnifH7a8gwWpXGBBJeYWEYvvOA7PE4
	XFvjK/YFp/VeHz0R5mMzHAHUBJJTfwSvutCv7RmdiDuLgdYx3VClH+kd2W3wM4mQziDXIpBe4lR
	665sI7/Kd5bYSwPyNYJcEIeUTAeVJXYb32d9kq7DXF9rIF103l/lUPC6h6mxBW6Cktg9S0Hs4fm
	cJrrhFoggsfPms+2elBSuYg==
X-Received: by 2002:a05:620a:19a0:b0:939:c8b8:4639 with SMTP id af79cd13be357-93bb7963962mr456734885a.4.1789575215399;
        Wed, 16 Sep 2026 09:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:19a0:b0:939:c8b8:4639 with SMTP id af79cd13be357-93bb7963962mr456729485a.4.1789575214958;
        Wed, 16 Sep 2026 09:13:34 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57c3600sm1021028e87.24.2026.09.16.09.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:13:32 -0700 (PDT)
Message-ID: <a4436f33-db21-489b-80b2-bf4793925cb5@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 18:13:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
 <aqq7j9L76coy65lC@ryzen>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aqq7j9L76coy65lC@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aaac030 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rHa_6ZUMNKMLsCsp4AwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6tCjGLPZtWi95CexpoAhzDaiw2bUDLhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyMCBTYWx0ZWRfX1Hlta1MpvDzE
 6FFQSufjjsQAERBe3DbBaPFETyxLuO3UotvAwHDheJwVgOXufcu3RVzR5IZqs6TGEAPMcIKb+qg
 QtkLawRo64NWCxV236VDTX41yfifFmjmNLEQ4NmOiB7iyTuOnSC/LSZLat9XBTRIGfWt5RyBisC
 q9eB7eDuJ582Uxf5FM2HpouJhTRtpY71PAqm//YsLDLGMbRusMaOWeQSeW6xNKcKUPJ5vBNkFQ5
 rQjz6aNJmO81fbDvIC/pKwNQQIvtFpuSYpyKv3heX2WPvavM2MitQ2KBOLZbXH2HNRzLks5aGmF
 AhTTQwgAhC523cKSwe/9zJQ+WSk4yRpkVfAb76azrn4HixSOFoix/njYzN4faFbTLPiit/ywHAC
 +9m0SB6/CPQPuuTIZ56NOW80Ob7XGYIefnHzwvOZYpYClcLDNKX/AH54kDpBazeuRvsWfjViyFu
 Kop1tgIq46BgJHsDjrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyMCBTYWx0ZWRfX06HmiDd3Fa2q
 t4Y63RKjbL5AY6S0vvfnxYbzjpnzPAMewgT8/UDjWuzo76zE2ZlG8adFHWGjOsfKjtdH65pOO/l
 p/SX3lyeXSBtW3QCl9DOUw92mNtOjsI=
X-Proofpoint-ORIG-GUID: 6tCjGLPZtWi95CexpoAhzDaiw2bUDLhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160220

On 9/16/26 5:53 PM, Niklas Cassel wrote:
> Hello Konrad,
> 
> On Wed, Sep 16, 2026 at 02:37:49PM +0200, Konrad Dybcio wrote:
>> Root Port recovery may race with a device hot-unplug. In that case,
>> dw_pcie_wait_for_link() returns -ENODEV because no device is detected
>> after the controller has been successfully reset.
>>
>> This is a valid outcome and should not cause Root Port recovery to
>> fail. Ignore -ENODEV while continuing to propagate other link-training
>> errors.
>>
>> Assisted-by: LLM
>> Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>>  	qcom_pcie_start_link(pci);
>>  
>>  	ret = dw_pcie_wait_for_link(pci);
>> +	/* This linkdown might have been a hot-unplug */
>> +	if (ret == -ENODEV)
>> +		ret = 0;
>>  	if (ret)
>>  		return ret;
> 
> 
> I did not know that pcie-qcom supported hotplug.
> 
> Last when I was discussing this with Mani, I'm quite sure that he said that
> it doesn't, see:
> https://lore.kernel.org/all/20251222064207.3246632-8-cassel@kernel.org/

I don't know if native ports still don't, but the ones used for USB4
tunneling certainly do

see e.g.:
65ccb2203ef8 ("PCI: qcom: Clear Attention Button Present in Slot Capabilities")

Konrad
