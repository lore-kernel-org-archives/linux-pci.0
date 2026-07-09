Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE7395AF2
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583197; cv=none; b=fZV69ZYsh7LcoaqfWFRDjB0tJHumWSjmJ9Sv2/C07DjVqqB09uxaNUcCDy0zqi/3yquMQAvDaPwo6rVwLbx7nYmiGvs+GN+eDGdbRv9hKZObkRlJ8ETDGfJAgep0Nd4oo31vCiDhbmfSGCg4g63VkzF3TAIRZR/a8RPWnAHFLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583197; c=relaxed/simple;
	bh=3yc+oFEDiae/9wo1xuCH+yHzREyAlh7cr8qgkE8f9go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzcCsoBEcLbEexgkcQxYkz0+jT1iGJeV7G1f45wPvINLa1dszilDJRzcHsWwCiO3SHihgQyb/mmeY/+Sdv8z5lO+eO91nvZolgmMbJ11ZQOuxZoBpuLLsW7hV/jqKuT7KxeDNumRzTtROz1njs450gMiu1+1JXkeeeljnNAptXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIPcs8C1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2NXVYrw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIPcs8C1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2NXVYrw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960EwE931846
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 07:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=; b=mIPcs8C147vjOBL0
	vOJhjHVmk6xoIEltH8bOkJCIy3LlG3sF+FucCI2Y5TYNHQ01MnTbUU3c3ymxz8Of
	IEMnBrgGZRxF38XJvLKlN0XeNgPE06/xvpzn9VsRJT9mrsZSGa0DOHTrXplcSnLf
	wa80tOrg84F2Y0jYvSjROXgrX+Me7zIQevm5IYi2cFLk9BWkwCpropRy+vhKEZpb
	QqX0V6/sFM+bLCeJUjC2Re1sHUnEisRbaqqQ0keyYG1EmQzzxzsSXsfMWJEoDPFY
	b+MegDojerEa/GfjS3o1XiXHVTFOWgl2ERvjVByfxtc23v9IW1nb4NOpzlH1zZd0
	Tl95WA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsb0w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:46:32 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-73760a7cd83so686284137.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583191; x=1784187991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=;
        b=O2NXVYrwRYm+gmizIBvafaFaVgo5LRxcsH9BS56282sbce6lKAZrT4nU95PF3XFQvy
         R16vzp7A6Mi6fZB2VaBvqRCaa3eD+reVhJh241K628GZHPeYRt7JPpfCSO7AXrVwmuCx
         NEiO8jtPJZ2YQ7ceG2CznbN8ZnTdJcsvzvRJ6QO2gJ3mwWS8A1LFui1RaTvsx8Vqc9l1
         QY69nT+6r24W5CRc9HRCs0Jpqwq5BjoM/nQYilcV/7Vk6JgrXQkOaeaRHedOe3+OxPNj
         E8FrMpRkc2PB6GOXWeFR6rZuL0hgXDptLsk8FwlSRLcf8G9fLMlVGVoqKLARi8AVViM6
         kBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583191; x=1784187991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=odZ3ve7vJ1rCrLXsB23lnwMfJKW7+qyBv7jEFL5Qyvc=;
        b=qlHH42IObxQkL+oFCeuOU1pEdALUaQ2apzM9vrQvxUHh686MM1bepOmzEgG+vDwQ/6
         qxcqqSjFRd+cPMNpfIgonox1z+8xNcBNaSBYjRqaP/cU4kMPQ7xwmJ0ChwiOuPKSsK1/
         JoliaQYq1quNOdI+ud/9MkYR9sdT9Gy/rdHSlFvMnmjv1SnUu5/NUPGsBmYICyRkRhUN
         agMo/XKo9106UN1/Q985KRjVBifs7MLt4x2rkHSvtePHdaO6F47i/n95aSBIE4LKDIhZ
         FFPqCJez2yZZa1CDn1GA3nTJvuuDJ+UskfBeW4T0REOkjqJE2SrV5GxhJMaKBQ7zBagr
         XtTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6tUo9fNQ1v9SoYiVfmr3OsJCiX2V+bkspO4SASazM5UEv4hn5nSH664Pfu9Es63hqMs7dEs+UiEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWgtAcEnnX4H5WoGxP9HxuI4MfAbI6VHpjBly8U2ZT3iEc3f0
	3Hc67iQX6Df1W4CEzIsMfBRu9fbkLnzyx2CxUyIa2gbm0c8Bv1xm7bd8+Kburdf9QptBNMFhm7h
	L5aZuhdNnhBdUQjQyPQ/OXro9iq1jyhU/SdHNoQXbEzKfbH+M0HNjtmtaG7jbVEc=
X-Gm-Gg: AfdE7cllIqaaW7XEWCYoB9iAnV2JAeI5M+zIZ+aFutj/bne3Vyz1dC6bdEYyH4FWbKG
	3jPLfES+kuw4XrWOiPpmTnEb7w1l2EeO83AAjAiNu6VOvPA62cMCAJJ082OdYZQOKEwGDsE1j7d
	rfuHsZPG/e8N4QsUR6FRomxcB1/JqcO4jdYhvcC0vHUg1VTz+2CeUWURWG35N5B4THblaFZg4Gr
	hTr9lGVsBw+c/jTHNe+iOrZHDIMiiiWP0zvKOK5ZoA7eAZsdfxxOauYXc35NBxT6eRDQQbPquSt
	h/CgYba5prWynrEj8Sw0taGUMnoySnMj5mPdeQc7aSo9vk7Qgbqo/Jq0B98EjaXxOblRfWI9/TH
	KNEfbYVAe39XIvw8vhOy/+JyVhIq7MjlZv1nIeossVOwPpI1Bm5bMeNTnhe8QY2VXEeYyK268bf
	PD6DUyXgPSQ4kJjbrfjydjq8Pe
X-Received: by 2002:a05:6102:3910:b0:631:2624:e5ec with SMTP id ada2fe7eead31-744e00118c8mr3853631137.16.1783583191367;
        Thu, 09 Jul 2026 00:46:31 -0700 (PDT)
X-Received: by 2002:a05:6102:3910:b0:631:2624:e5ec with SMTP id ada2fe7eead31-744e00118c8mr3853615137.16.1783583190922;
        Thu, 09 Jul 2026 00:46:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bb768sm5112907e87.52.2026.07.09.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:46:29 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:46:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 0/3] power: sequencing: pcie-m2: Enable USB/UART BT
 coexistence on Hamoa EVK
Message-ID: <drwgkj27gdstulk47cev2nxs6icienfa6vb3tu2uc2gqkbeedh@duj252fcm3bz>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfX5AK9wJIOPgh7
 sy1iiYrPC8wSPD+O5EiPPDjRkRdRnECrdVRw5tLC/JeqrCYZ5230BxXCKgg0nEBjKVZQbPsff7b
 gnhGmPnaT3SdA1k1HPUzNkxWzRnJxwI=
X-Proofpoint-GUID: Hfe4CpUPYwxIba3ZONskVbi6sULxgcA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3MiBTYWx0ZWRfX3rWXp5ApRD5W
 sE/bsRfiOIiXcy7TbkTF8V4c7LZB/iaLshbcwiU101Rjm3ZOy7HUvJsj9zglH31HrzjIiSJmaSJ
 KksKv0BZRaFNyrwQAS0CthBjNOR4vtWVG0leb5Vmf6YvvLPbj258jLBQzKptTH3usQ8gtTuTKob
 +ak8lkbb7E2Jigag2VRYb7JLK6FGPpNsbo40RTc5wFeQJF6RDIe4W+20lNDuv/KFha/Ljm2l4GM
 CcIZxnDhAQLlOJMFO613mBpACvje5beN8klY0NtCYPn9QdGjH47Jg8pd3sVyv4lId32iuRPkILg
 X31xrGvF4N2t22VJFGBj4Yj+itMMBdFwYI//XJ0V7Vblji4XX/OnTjsMuEclKXo2b1cvIQJJs51
 n94KaBZEm1K4sFofdterUiZsXBeg0mbHIy4KsNzSPRvFlWzQTYtam9qaSDMf8Ds/5Om9lYoBuKe
 y94ZFSio2CziM/nIeWQ==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f51d8 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=s4KJf74AQj_XUxSBtgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: Hfe4CpUPYwxIba3ZONskVbi6sULxgcA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090072

On Thu, Jul 09, 2026 at 12:59:39PM +0530, Wei Deng wrote:
> M.2 combo chips expose Wi-Fi over PCIe and Bluetooth over either UART
> or USB, depending on the card variant. Both variants share the same PCIe
> device ID but use different sub-system IDs. The current driver uses bare
> PCI_DEVICE() matches that cover all sub-system IDs, so both variants
> trigger UART serdev creation — wrong for USB-only BT cards.
> 
> This series fixes USB/UART BT coexistence by:
> 
> 1. Narrowing WCN6855 and WCN7851 table entries to UART-only sub-system
>    IDs so USB variants no longer trigger UART serdev creation.
> 
> 2. Deasserting W_DISABLE2# for any PCIe device detected under the
>    connector that does not match a UART BT entry, allowing the BT
>    subsystem to power up and the USB BT interface to enumerate.
> 
> 3. Describing the PCIe M.2 Key E connector on the Hamoa IoT EVK,
>    adding w-disable2-gpios for software control of W_DISABLE2#.
> 
> Validated on Hamoa IoT EVK (IQ-X7181-EVK) with multiple M.2 cards:
> UART BT (WCN6855, WCN7851, QCC2072) and USB BT (WCN6855, WCN7851)
> all work correctly.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> Wei Deng (3):
>       arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
>       power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
>       power: sequencing: pcie-m2: Deassert W_DISABLE2# when no UART serdev is created

What are the dependencies between patches?

> 
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
>  arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
>  drivers/power/sequencing/pwrseq-pcie-m2.c  |  39 ++++++---
>  3 files changed, 74 insertions(+), 95 deletions(-)
> ---
> base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
> change-id: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74
> 
> Best regards,
> -- 
> Wei Deng <wei.deng@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
