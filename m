Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEE3A6B77
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495356; cv=none; b=rwfOj88/KUy6AJwPftoclvmneGDaz8C0zTosDTEgg0apQknA/aulLD/aZ90nggajc3b4265uG6PuI1qRygG9tjzq1hVUXu210HTWdLfAbkAIzblL6VNNr5Gqu8HegZlhIK+rv5TlJWfIsvGmpj/RxxQImIvsLcTf/8EZMX6huw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495356; c=relaxed/simple;
	bh=BWsV/v8dAleHt6SPohPfZYmWWFCts14SYtui33lnaxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfoBx7/ridjKAl1122hH6uDzzlsQtHCgfOlPPExIGhphdXphsKRlG0JLbPlRO0Te5VyKobU8yRy66JqtN7aG6W8TuWooVsdkgzLHzutxXn7vsXOWT++FdkrA2wOBEZmu5wij6d+u3dOq15/40vZxTTxYabKSKzGud2/4h8Q1nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ciT4VGOm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RLNUwFye; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ciT4VGOm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RLNUwFye"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7ALEL452887
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 10:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8S/IcUZ9Xk1TBMi6yw1AkVZsDtOla0MSA2CupxfF81s=; b=ciT4VGOmgd1qvD9I
	8VOuMFxPfyyIB0+lpeLNPd4binf+UXTi/HEK31I3hFMIaqI7TdNspA8QIM2ELwWE
	FG5Ni5lUKhRb4So92ZfLkCPDQsZs2lBZiA1Dukt1CcwJ3u9oEGlIpyREckrcT4zs
	5mSlWc9bABA8UPIC7d4luI9qs0J6rNg1dmaJ0zmtiI/gPgxjy2iE7VNFOew+sfT6
	wFa9xE1P8KSLh6o+KsAZv/BB5DfMb9a5uWb0TMT4nigs7iOPz698QigEN+j+lNuj
	aY3VWSeXB96A1AFX1wQo5fIxZDOAPE+HrC1uuqS2fDQK2vsvfX+4xLLGUICMJrcw
	u55wVg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6gqfn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 10:29:14 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5752affb36bso407547e0c.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778495354; x=1779100154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8S/IcUZ9Xk1TBMi6yw1AkVZsDtOla0MSA2CupxfF81s=;
        b=RLNUwFyeBlbyyxaVzI7S9GqzDmoJ9tKRu80tV7p2kzKiu4JWtMj54Pb6Qrwgf8vB/U
         gaguN8/hy8XArpvLMrHg3SY2ELZsI800UaQ1IKLvZqItvBjARHY63sywx5qgprfoGuXR
         8gAWpJHUKpXNYIPx0jVE2LPCdCxYN17qiORd1UsH5LUGoLBjdHMQnQnlwQ5lX1FOMpBD
         VJTZ3TYXm1rVV9gqubqfTcVEaRvEp2wRL3Qbe7/UxEmfmV29KNxbI2pWz71+6q0pF3gX
         ecaXDDZ0zGl3+1OIeiIvmuRGQKSmUkluMu+VFkHKxvbtKT3T0+FuyXyjvzPg8zLTwBrx
         NMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778495354; x=1779100154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8S/IcUZ9Xk1TBMi6yw1AkVZsDtOla0MSA2CupxfF81s=;
        b=f4jykBPyMAbeREfHG3XY15ny9GijBmD/PP71So7l+x0f4QGAaj+X4i+jabxV/9RIwr
         DANVrYjialIhXPMKGwxp3DcxSYroG4PaQnkky3Wb3gCaXDwRcn+ef1fv0ZuV3Gr+B2/R
         PwQ9++YSiSkXePHqzIdxLcrtRDLrgh8p0gY6ThHSmA0bmgpppbvMCRgaA3aXtQ7/gUvC
         2Vy/qi8m4l9hrCKW2bDfksBk4sKQ31Jm7vglH0Mhu8Xxh+JY3TOqwGgFZXORWXBumKEq
         BneGggW9NSK5wTE/J9aqTHaGyhssmii9KzxYHEtfX6lomMeCTjWUOjqfd7lBXlkW7mR5
         /DAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mpkHX1LVAnWsq1JdP/rKC1OSETSUBBYRQa13ho1q+V+9qNHsopYsn37S53OWIa0+OqVOlLo45Kec=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMHcvUprHHJPRhsxFGNOgI6j8rrXo8/8tjFvBK2gjZEcLtwMu
	GSGbYmgIQfINy2thXGFxEKAF8Z0JMZOa1AfY44eKz1jAcZT4fCqVBj2Z6rrsh072VuWFZf+E4zT
	GpFmQxXiGdW/CxcRrKRiu/WWS+WCh5fPnx0TA2uMFqirjJ53yQEzlR6UzEP2oUiQ=
X-Gm-Gg: Acq92OELtSpLfOVWrmDxCQRKJZzQ982ubvzsh+dB6IPRdU1TcaQl3WEwnX+69GnNoPt
	FzwrLoSIqRvvX1Rw0NlHl8tcV8HZxVXlyXa4tjByKXKfUQhHNIL+wOn9WzlpFIk8qoKEkdGkbVP
	4bAPn+hX/pi8sZUQdKah/KvtGP6cizDhY0GmyJyMDQWUgb3KFqfFBK6mNIO2ooUXWiZ3wj7sIN3
	ip1rkGnpQdEohhCu+Y4K3+3//wiA4HCGhB7Lo6Wsst0Qk/UrhUeL/9hWaSj9atxXRZ+WSDKgb33
	w4ZQZpQMturwCRVrRkFg9r6jSRxIB4eHzi8A/E5QOR0mdcMRN3VihB3//ZoCz4QNCUnkuXvvk/S
	TJTeZys/Zo46N2g3zkQrwgN/PcrixoNg+NeApQoN5YXzISRWHh4JzzwIC6Ef/eraRNgkir/pAei
	7zuqNzfIneYcJKmg==
X-Received: by 2002:ac5:cd48:0:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-5755b4af80emr3879724e0c.3.1778495353707;
        Mon, 11 May 2026 03:29:13 -0700 (PDT)
X-Received: by 2002:ac5:cd48:0:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-5755b4af80emr3879714e0c.3.1778495353219;
        Mon, 11 May 2026 03:29:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd9decf173sm244707866b.43.2026.05.11.03.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:29:12 -0700 (PDT)
Message-ID: <d5539f0c-1072-41bf-add9-3c1da49e9244@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:29:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01af7a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-fIsIiFNM88_Lyffzp4A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExNSBTYWx0ZWRfX5iT7lLTCd1Kq
 sJ+gm4ifLYjb7XQQAps3Gwyg6hh9CEeysIgij3sHYPO/AbREhjb3i0EYFjiMsW4ga6ekbxZVZdM
 zrrK507i/f/TiJX2UIgJ4zaSBIZDTqBMC4KfBYaXZA6To0ByOnxYrNVkiXhoBsKxoGy87NBAijA
 Syyn+rzuN7ocHo4PO1FLeQ+DK/iEYbPUkQVlqrU12k5vJFTSWCtgGfDmDo0iPgqc3nYhQ39OQbP
 lQuJ+WdOYdl4oj3mKDGAR+MklUkxX2YA1U3wiA+7URK3A/Q9KpPtMB5+q/Fsc0j1M7gx/GMCM/Y
 tjQgibXJ+h+DhB196b9kbn6pCRk8cBB5FMsHbJL8QvK2KNrNUUTOKRgMXSgVgQWHDvtIIxG6dlC
 1nhJxpBeGM16YLhHyBL7qjG5YR86OjdlSEqpZdMwjTJlQZKsgk/Yz2Yri8Q0WgRckZGfGTmr7me
 GlqRBDZHLawOIoV+6xg==
X-Proofpoint-GUID: g5eIFt9Vw9dVL-AazJp6akSphJNzjDSN
X-Proofpoint-ORIG-GUID: g5eIFt9Vw9dVL-AazJp6akSphJNzjDSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110115

On 5/8/26 11:54 AM, Qiang Yu wrote:
> The driver currently supports two PERST# and PHY DT configuration. In one
> case, PHY, PERST#, are described in the RC node. In the other case, they
> are described in the RP node.
> 
> A mixed setup is not supported. One common example is PHY on the RP node
> while PERST# remains on the RC node. In that case the driver goes through
> the RP parse path, does not find PERST# on RP, and does not report an
> error because PERST# is optional. Probe can then succeed silently while
> PERST# is left uncontrolled, and PCIe endpoints fails to work later. This
> silent probe success makes debugging difficult.
> 
> Handle this mixed case in the RP parse path by checking whether PERST# is
> present on RC and, if so, using the RC PERST# GPIO for RP ports while
> keeping RP parsing for PHY. Emit a warning to indicate mixed DT content so
> it can be fixed.
> 
> This keeps mixed systems functional and makes the configuration issue
> visible instead of failing later at endpoint bring-up.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 9fdfc88ac151..8235961d692f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -282,6 +282,7 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	struct list_head ports;
> +	struct gpio_desc *reset;

I'd rename this to make it more obvious it's at the RC node.. but
rc_reset doesn't really sound great..

otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
