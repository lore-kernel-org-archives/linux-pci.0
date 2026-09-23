Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5751C056
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166736; cv=none; b=AcI0C0BnyWfuDxBpON0uWm2Z6UV/g8di5OucUM0wbd3jTdDFfUDneutL8XhALYRmqEm2SGwTOuNYFaomV41m7obvR4xVG0KDMPBZzKMcPN+cYm8A7uSmKe5pwECS+QeQkPAnCZL+lzRjT2mtZfaCqm+Hh8hxKWv4h3uYsZGkkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166736; c=relaxed/simple;
	bh=U1wE6PU+rh41Cle3iFBekqUZh/m5lY7C82C6RiMSsZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx6mstM33aQ3NQLsosJVTtNXk8vdIFo40EzXrnDmjhmFHGGOEK2//Fw3V3AfeZs+WvJyGJUsCQHFNFvw6wYsSBju9rbHaJ1jr461ql6iLtSS3K4CenrBfcvwLb3nlYLX+JI2Tgs94HAl4pc7whxOj5gG3xwjdpMCybMAJsqVWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcEO1tfb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sc/P9d/4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcEO1tfb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sc/P9d/4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbSqH3295494
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdMS8+R4wHQtzwHsJlNh8jeKE2W5D1KWqQU43Szma4I=; b=mcEO1tfb4QCYZ2VO
	LmUNxsFxNIJJPSLGbez6p2cOiktCBAu0cpl/qGE6ixQj0RaQO9dHPJjlEKT6zFTM
	4A5p/Ga6PoRTkNlcRf8VzJArzqTBdMxcT+5g3ORHu8vIaLUD132W5216d9kY0SQ2
	hrJPQdYkzlCOn7eZwtyRchj8aNxzU0LYSVRu16HDD6UfXByv1xmXepMGmHyLI0Ml
	bEwUvc+j1HoHQHMCakRlpZSS4LGCBoUUcwaKEBL7rAWgYo93j52B/U+Cd24SwZT2
	OVFRPrhh6zgNqjngRSw8hNdJ+Y2GH0GnLXLzJ2z+1b5UhExFVhr8vHnU2w5sh0pl
	6lIo8g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8t0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:32:11 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c66ec39d8cso86001e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790166731; x=1790771531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wdMS8+R4wHQtzwHsJlNh8jeKE2W5D1KWqQU43Szma4I=;
        b=Sc/P9d/4R0zK5q0cVnCOo7BnedMkpf1FVR6lKNMNNwJNVfQx8n+ggYXr3jPQQRazMe
         rTqaRP3HAmdpyrXciTQYudw1NeWb6Dh9k1Lh9gaNdHLVHa0ZzOWcNVi7klB6qCop4Bas
         KKIACd6gnGYNGh9S57gLFHM6q5CZLSsSuSsfife6YnHDXCW5Wwaa52RDWHZTFH43VtA2
         f0V2dgr7vfjOWmWIjxBDBnBpCgULiBng1Gc+3JhdcUcLs1wQZ2iPfQX8hK4msj5afs/I
         e1X0cBI50fUU239Mzp332PFfkI7gnTsGLQtqo+uThcxK9IaUZIUmifmbIjrjf9WpJA4j
         gqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790166731; x=1790771531;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdMS8+R4wHQtzwHsJlNh8jeKE2W5D1KWqQU43Szma4I=;
        b=GvTfo4H3kZEAqz/R1SdJv3ECsZlV7t2Yw/7I5Y56BGuPyCcVlRFPG+vEUk7IwDDKB7
         iP1t7t2zPx05HIUTKOTXb0hw/UlykQX89NZ0Ht78gXUDSKW2/sEdfehkkpap/CZ+Spxz
         mWILi54JyJnAZOQ3ETPqmCDwqXnSY6BmYwdH6tEy/G26a+9Oo+AgNPcSR9R2wlkzNIst
         aOHU+xLkbvWI2VmnW2gsxzXVdZWWCHFKGXlNymcgpaFK5RVhDIpIwJ1wrLGZ9KapqVhM
         u/K7vGf5Beibr1cV2wy0dPviLE8MtU6dCExho1KlFDiOFwlEVmp4zvGuPyJoU0ODIkXM
         KatA==
X-Forwarded-Encrypted: i=1; AKwUvBzrhm436ywYSJwcfqIa4bfysJ8DYzRG3vnvFksrG4Gt/37qkZ1o5kn7gHaBUwGEmKDwIXqNWt3qsac=@vger.kernel.org
X-Gm-Message-State: AFuF++k8opt1qZ/YtkTpxn4ck2qioFu65aRmY/QP2ZQRvnkUGTpBLZ39
	FQlMGcd/08VfHzbhTFzTKmaWOLeMHUIcexuh1ZMSpPQtHU0Ek090i+87kr3icPnvMS1QyM6PZtd
	rmfobZ01RRaSW9HvpzKyvDVwrWnB78XU7uLakvnb9MjH0rrhFvZ5KqHOrJaZTOYM=
X-Gm-Gg: AYBFou3k5xkFK+oNhTsnQz/EEioTGSKkx2J7R3qT0OQI9Zh/PahhEz6MwT09BO8tQKq
	5dE5DLk8eeg6ZwMLatoH+J24cMIzs7+nBDc0L2VFbIyxTH21VPxZM8l+P/TfgO9k8AwQKRMz/e/
	JwCLLLrpPtXkVEPxp781cY1yQwFlhveKf+xgLFlVvxApuDZ075eWQ0sdlvAfXbHwC9Tdz7KkX2d
	ZpJYKh0cuFYOeFkkg0nm8JxoQo2KZSc2sTfHX1K4eEyCJ2lzeICNs5Y+8bon2IsjRJ8t8uXkUWj
	eWiyWK+LkxRk0nika09HXKOxWlEkVZDxPyI2vz7cPenxIBWWuPyYvP2Q8BSCkwZvQXQiB+y+8dx
	Web1rh/JAo9af52rJ/GSpng==
X-Received: by 2002:a05:6123:4214:20b0:5c9:fe51:53d5 with SMTP id 71dfb90a1353d-5ca737615b2mr333072e0c.1.1790166730807;
        Wed, 23 Sep 2026 05:32:10 -0700 (PDT)
X-Received: by 2002:a05:6123:4214:20b0:5c9:fe51:53d5 with SMTP id 71dfb90a1353d-5ca737615b2mr333039e0c.1.1790166730415;
        Wed, 23 Sep 2026 05:32:10 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab3896a53sm1485858a12.18.2026.09.23.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:32:09 -0700 (PDT)
Message-ID: <ca7cf05f-0aac-4603-a362-0bd4c3193b13@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:32:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to list
 qcs8300 first
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-5-63c5282fb0db@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-monaco_ep-v1-5-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfXyXsR5thXceKC
 ULSrJzhnB5K2kV5btRG5JDwoimD5ale10bw52HUixVkbJmOzLUYtdo7q48QPq0RBYV5Id/hugcx
 vP/kgIh+1ckzL8ciaXz2UbGQRrPKQLw=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3c6cb cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jsnCtpYymfaPz7_p4TUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: FsLVTP39D-h-GqfV8NKeE0DvyJosz--8
X-Proofpoint-ORIG-GUID: FsLVTP39D-h-GqfV8NKeE0DvyJosz--8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OSBTYWx0ZWRfX7rlo6S0RWB0z
 8tWirHNVVMot9AHQZLTeM/nj8nPP5wq2pNYX1zs1eXCm9m6q1FroK/XazgELXkQQn5rB8EYWuYh
 ffaLXuS+8hN9n0KOd5XBddSpEq39whUv5Ze90kRjZip6/6vxXy+7ShRdEEIchyodp1btIojgyTj
 vSUrRe7euyHRcLPeCug15Th3g87Kd9wzdE4LFJeMb8uggVVwbVIJF/5ZJlfzhKL/emkrNCgpavW
 M0XRblCo25yeieMpL9Bwu4whvhLADryEyQrj+qxOTClkh7aUJ+pLLfcDsZ+BfcbND37GwlMs19e
 KOrD6H9OlkFvACPGJ18stLKxqkrDWlIVKAZu2ULyvpgljhQMzDVYYCGFY4Z6KxX5uHiV71PH+f7
 AAonxlmpBliSwmfo9vYQJYT1E5Bsn2A81qheCmxfRq6c0U0r+yhoxr/Um+7sT04r3AFheCKTaAB
 E2y1TL9cRXepY6Xb8sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230049

On 9/21/26 12:58 PM, Krishna Chaitanya Chundru wrote:
> The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
> compatible, since no QCS8300-specific compatible was documented for this
> PHY at the time.
> 
> Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
> with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
> order used by the pcie0_ep and pcie1_ep nodes.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
