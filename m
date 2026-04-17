Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B2317163
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413933; cv=none; b=Lrve/Dzv2yTarfrG4IQ7yk7dQDunOD5OZnNBwjGUYp3ACYMZavqbGjd2ZUQYzHW5Ww/hV1DvCozVwGTHZ1eh6+zEDnrGNqXCJ7Q3TxahymrNCBHYHn16JRKRYISGC7Z54EEXdS44z+tJQ+ML1oMKlxMVIX9MztDQggIHrM0vqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413933; c=relaxed/simple;
	bh=W4914ijaHtsGuoHjyImIfudn9Ri8THvzUCwLWPpH4Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYcqvW/xjltn1rHileg8EPer5y+CKPx+oOMomM0JcWQru12xjnF0Bjx0t3WqYM+RhKJQYnS/MxwgG6jZhSlX7tyPKa9rTo73I3UPcIeAYmzeUTfOGY9brrXckgEqWXCLhbkaQZUqE1zsGCnSWXMqlEWMtt3u19Bsf0Oam7FEPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jx8CbxBe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDLvoHm9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jx8CbxBe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDLvoHm9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H44FUA1323229
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 08:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OEJHzpxMYyDj5Jhz11ilEri4H4j79upCGVF2YTnnQAU=; b=jx8CbxBegB94t0x6
	yWX2tBQ337wcaXkrH+wP+NTqWMbbdMM5Maxiqv+3EJ/ZmYPNd4eoKzH3qkMnrAy/
	MasjB+2PIlrLPqpHYUJf5UYWSYulLwxvwIazN5tOgDcy96NyUjY7pIsNdwCGXuUh
	uxnPMHFUkOxhn5wJLUkzqjGcL2FiBQsouES4Sjmu0e2V0VdT7n/6CMc1a5hxafB5
	16b5dJK0vDz/F+L2S1jO81tg2Hq1g66O1qlWgmm8eK9nXmk9TAkfXl/I46nQ88CT
	wK2+S2XNgmMLmhL/TzV2vKi+CTy6DsNzy0G3jKdRFJZGAFCVmmNNlc9/0qJB/M7d
	LX7Hvw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy0t00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 08:18:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b32feb719so856631cf.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776413930; x=1777018730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEJHzpxMYyDj5Jhz11ilEri4H4j79upCGVF2YTnnQAU=;
        b=dDLvoHm9f42D2GfAAgflYhmjvedR+hV1Jk9rKHoSJeLDjiv/ydRsrz6hwtifuQzLwC
         K92AVzHKRRN++RTT6dvBiJtJiGtA4Jh/aj803Q1DDc9dLnLMgOWSjgReZuoiqw6xi134
         +F6JOSaMdq1KX8BFuVvEm2T2wPcxW9f8DNQQWG3Ix5dIrCawxhxAOxmC5uehmDltoW0h
         p62/mjPPpwVYB8Dt+7smEznpk7YJvjXs+dB5yMXuamZa4D81n2igjA5FSN4oZ1a7OCfK
         QmZr+EUBRW0MwrM21qMHeI2g6xBnL07Qvm+QgRUPN23u3D9zDFAAXEEAYQwbxWx8CPRe
         aBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413930; x=1777018730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEJHzpxMYyDj5Jhz11ilEri4H4j79upCGVF2YTnnQAU=;
        b=ozf/5CykYtVd5CIfVLVgOTav4WTi0HKFJIohl4ajAz7hhVUrqYam7ykWieyTAyb4qw
         IDcdqdn9VupYCPXiZY6yP/KW9VBnlHpsL2wpfCIHz4bgBotf9CXukgyAtdrBCUr1pxAL
         FbMbiMY0fmxLP+hsXdo3gLaOBNsfDpvRWf5yMF5iSQxytIrYi71nT0Kp0KBlvBuFfVyJ
         uNH2Xjs6PyMXtvs0Zcw8r1rLSUcHaez1GSp7z/btRaZaJMrK39N3V1GPWA2JBA0cX6GN
         6oIHMXk/0ypt12+hzxbMLJIgmIJtvzjRf/8JrLcrwpDBYvznoTEUg4T4p824JarxwHUv
         +0pQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qB3z/6BbbrYo2gE6rmkCzEdNzeaiWqL8QG0mQm7nb5btY5B7wmKwCCT9QabYqMWnYbC16XX838JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkl6wkrgtktBHG3tCi7z0wf0JLq0YuP0RWQx/e+JEIU3ZNOtZ
	TtRuCgrB62WdxPJsZCTE59oEdpAU6LpIodrb+Fj6bacz5vmym9Wioy2UOgUWo3567bg0y5SZBQ4
	bAu2K/qxMXzzVmBz+yE089rBSzjXnaxW+XDj4+j0VZAQ1D72pRkK8n1Yv727oW0k=
X-Gm-Gg: AeBDiesv5Rzdg+hMoizHVwHLrf2DJyYU7ZCcoY5KmVrhwl1WTFIEZAfFX9D3ppYueDJ
	ElsIW0u3veCZVanrqxOHf2j3c9GiSTkpzjx1fGdXWmH8bdaqhCAGfwfdHeCjrZp7NVB9ZQCHIXr
	yDj92pG/89EWy06wFfSq4saj1Nx8+ERxo/d3xMPjncLeROWtB8o1juhhafJgY+zuTwQ/Lym26aj
	NN1n/HOl4R+wxUhkBhUD1uKS+2+k7500/Pcc6NFNMRbHqUb5qp1Ne+ZWX3cusUGJgDEuem/wl7q
	+S53oaQ3hq1dgvTuL4wIN512Jz3yhuj5Or7fTV3guRnRizQX7Ma5Y/BnDL479A5NQws6hsYmcX4
	KiR88jPoJ26/1C5faAn51nmo7b5e0HBjZjU3fSTwx2rrSJRfZpXwwKqkmVsp2ZXONk/NHGJkhTZ
	LLD11uaqbA9RhjzA==
X-Received: by 2002:ac8:7f46:0:b0:50d:c190:9059 with SMTP id d75a77b69052e-50e36825b01mr18548761cf.2.1776413930403;
        Fri, 17 Apr 2026 01:18:50 -0700 (PDT)
X-Received: by 2002:ac8:7f46:0:b0:50d:c190:9059 with SMTP id d75a77b69052e-50e36825b01mr18548621cf.2.1776413929900;
        Fri, 17 Apr 2026 01:18:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe951sm187255a12.2.2026.04.17.01.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 01:18:48 -0700 (PDT)
Message-ID: <23078bf0-838f-4a57-be8b-6ba2dd0a27d5@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:18:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Set max OPP before DBI access during resume
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260416-setmaxopp-v1-1-6a74e2d945a0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260416-setmaxopp-v1-1-6a74e2d945a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7HrJooB0nrnYSDTmFO6M0MOGk88pA1Ut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4MiBTYWx0ZWRfX+qqclGAe7u+v
 BzFBWC8VOVBmnUj0J6G3cmAWjls6pi1PRzqgphpQbOv9iELcT52tgKW4EO2Fko5wJlOM2VUF+g3
 tsi6k3tJlmiR1HxeP7vAlATND+IRtOLYgxpVDSCtz+Xosnh1kKjqPKUn1SWe6xOpp+I5AcRgWWj
 4EK7FunpCmD2w9ZhZU4hZTGgOCFg2GA3kmERLdmrPHxSf90+gHcxqD9q+rQIoli2UI4WI9ntkbM
 FTxB9D+wA+tt8RzzSYxSZVfbdG1KlZ/GpULSFMNYky0mBuX/tNsFGMv8iSuTqwQdGrSOglOnBBQ
 4eKUjuj6TMHMfHUPl2rR0bvf45GJBASb9iIojm3LZ3C+eh3knCKF3fAqkfKNWcrPnD6xpPOUHFL
 3mItnJqXHfS5OowAptRHPdseIPmLCLpc+uWShhJtliex0YohfOUmcq2lOW9/vMX0lJUN3PNrUXJ
 KVSA31m1H8kWrLp/0cA==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e1eceb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Zbnenumca3Z4N3844nAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 7HrJooB0nrnYSDTmFO6M0MOGk88pA1Ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170082

On 4/17/26 6:16 AM, Qiang Yu wrote:
> During resume, qcom_pcie_icc_opp_update() may access DBI registers before
> the OPP votes are restored, which can trigger NoC errors.
> 
> Set the PCIe controller to the maximum OPP first in resume_noirq(), then
> proceed with link/DBI accesses. The OPP is later updated again based on
> the actual link bandwidth requirements.
> 
> Also introduce a small helper to reuse the max-OPP setup path shared with
> probe.
> 
> Fixes: 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 42 +++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 9fdfc88ac15120b2b01cad746772ae612a2c9690..c9b201a1c033a9849e97db9ee4d07d26655d5a6c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1613,6 +1613,22 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  	}
>  }
>  
> +static int qcom_pcie_set_max_opp(struct device *dev)

Can this be a small non-zero vote instead?

Konrad
