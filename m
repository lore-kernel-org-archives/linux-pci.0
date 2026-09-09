Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7F5592FD
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958517; cv=none; b=BQb4RDprXA4zBObgqU+rM8YS6/GD7BMnACBRf7CpXrgvs28xxIFPkF6rkCBB0pFRnWf5IVkAsJymLP0mabFo6TKL/qgUavkvax5odTYfvdGfBS1Lv+ZlRD65cZdKQm4HjJQ7w/1S5MfBjVFXj6dRyhpj7z9i4Z7eDUD/8P0LZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958517; c=relaxed/simple;
	bh=7TBSuHy5oRrJQVVuqdv6lsELHPKVcaY4yxj5xAtDUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acHaGq3tXaDcYFjWD73LZf9ET4Yp+vzun3Ja7lMhpjCV8lYDi+X1PYdKy0VhdfkNC7suoi/nc0B0kK73F8NYx1JtLDVDljDujqdMSc0wgEKq0fjf8qQLpFxj/5mkn2p/bluBnZjP4D1TW4/hClyK6g0G0SEPM4a0EAF1Tm4SKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWF2Q6pF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XXU3gHTV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWF2Q6pF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXU3gHTV"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU1xB1809999
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 12:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=; b=XWF2Q6pFiI8nVG/b
	zSHzCWhm2p7A0JOkmKiYSs/ozFkb2G8Y3EWVn3DbKxhL57A+J/QLKXTZ0qWwsaD1
	PFZa7b1p8Iqo9agHznTq3UzrGIuDMFGRtdtCB8JPeVCgqhahWJ+ZknLGguAU4lOD
	cTrbgXHj57W8BuT2hMhyO6gHaEBsdKcjcnzQTv+8OxJ1ba9fBYLqEaBwGiQL6W5v
	Oai3mhzJDli9cV9nyAxepgEkEZDY+m9bpOxOxtd3v/XSnyt7I5yUwBSdcFZNhdz7
	i6yUJaHvvyYpM0RiyVEeUCiH7Ag8FqRFNbRLrV4ID0cTfpf47s6mGzU5iBAcO1Bn
	1QS2nw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj0q8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 12:55:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98087b0c5deso3766948241.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788958513; x=1789563313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=;
        b=XXU3gHTVicE2VP1Qv6AeXzbayoN9zca3/X3TZoqLWzV1eq6rVYvRLzjAGfpDE46AyU
         YfYlFY+gLEyd4Qbq99UXozK6es6o9MketAgt2ZQtbRKyKlK4qIyquvayV6QpG1ZfZwWP
         imrvUFd7dAHO0s3EfmoBL8FoVkT+d3YoxnuQ1Gaqfy0M2QkWNXXHbkXZSC60FLB6P2Yf
         7FjCx4GvziuuyNXbAvWn+Of4th5DMwg5lohEeCNUdJJ7a28TOsrdWNBn91jqUkZD3wG3
         WZfN0Up6O3Z5j3AOb51qOGCXVOcHynVM5xEhklQJU0K7CDHIUP6DMWElSIcxtAJEwFws
         1fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958513; x=1789563313;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=;
        b=RD6jNyKEnSAE06lVyuYOZ4wNM9zPUsRbEBf2G6F0iLJkhcSlzU1U380R6qv+zKYe+u
         kcXPQ7Qvqy8QIN/AF93IT/lbtsbT2mjzBySobcj71Gn14Dw5kQVMX4GdfU917fWjgGQA
         g3WH5M2dZbId5eUVtSGW/ibnn0irCHCdLtx8csoCJ4XdnF4WSkt9MiQkTh6ymAtYeLjp
         AO9KtaWWwc6njkdCXPNP3EiFF9iLhpx7ajTiuDQPEeaN8R0sdCUTo3EJPmMvIPjxA+Lv
         6+Q+MDvgMOOQ1Zj8KJMJ035Cr3S4C3OmXF8cRv1U8jIyuQWD/2yH24LTxBRVqtP6xGgl
         la6Q==
X-Forwarded-Encrypted: i=1; AKwUvByWA01r8qU+4Aaz8J0iM71MJZW1O+yJyudenfS6zaXXkTIjQuU3pMZEMB+YJ0PEPt4361gZJirW8yo=@vger.kernel.org
X-Gm-Message-State: AFuF++lWtpwKAiulnJdxL+Ld2rrxXfm6o2WG+b31DxUMjEVIGCLuch/0
	Ld+n1KDFE12omrWjWZlgh842ppLjVl/bOvVTC6xOky5ORMsDoJ+8bcJQu/EyueDapZFlcm2B3aU
	HuiNbNquPC/FubTArgzXRoyVTNaqH/7Uq0+c9eXdDlLLMqIDGTkpEHD/lmM0byDs=
X-Gm-Gg: AYBFou1F9O/yjMfCzdYWZgfYX/V4u68JSq7vGPaRokcwnNyz/hUaea0CE/Dvp/uzg7x
	mQHidV52/190OeQ0Xg3yUX9Xa/Mp9egfRsNoYwDZ7EdJhzwQITN7UNhkuXi7qn5EUPn+Rt3WLAS
	aYjsaY97k8gBikJCM8713Q+9ZTNZgLCqRyvGugVAvJu5l7WWHxbabLpxI1JFnGRIWimQJFxZplF
	za6uOujd4p3YtQIKRNawq2+PypI3L4/q9DrmkIQWfFrWamNrWvXmclN1NEEfCXrchss6OHmUiun
	TuySWs3pyyevZjxXa+5XzMVLcb2R5ULbnUBZMG91HtVdHSvkQHUGtOSP+h3K2/zo+05VWBvM7T2
	Q8E/DyWud9S40gwZM3kO4yUXRo7Q=
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr17098748137.6.1788958513386;
        Wed, 09 Sep 2026 05:55:13 -0700 (PDT)
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr17098714137.6.1788958512927;
        Wed, 09 Sep 2026 05:55:12 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm43616140f8f.14.2026.09.09.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:55:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Support PCIe switch topologies
Date: Wed,  9 Sep 2026 14:55:09 +0200
Message-ID: <178895850666.30743.6753366946500476857.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
References: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NCBTYWx0ZWRfX0h7F5XDg/oI6
 /YTycFXORQLedU+M38lhmMqWhG7aKynGehPQ0c+oJ0OPvO97VGAivUBRXglXjc6M9y71F6PpoXC
 cU3j+9/o/Rn/mvqJteZwq/Wvn/b0V0o=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa15732 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iDry_tSsOD4vq6Ch1OYA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: kTQv_No9EXWRJqPyMz1wbMZG-so-5EY5
X-Proofpoint-GUID: kTQv_No9EXWRJqPyMz1wbMZG-so-5EY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NCBTYWx0ZWRfX3f5c1Au6BTVi
 xODdvf/o7kQXWM7te5P45c49494CVkljDB2FHRPxtnPaR7aW1ZXjIZMffb/OEOXi0+epM0kfNBT
 ehXRoB3M+23joYkGl6rIp9NRphIUxGQ7Vp7CYrdiAi1amd4c59sgcrPkjX5DUq9xTQ8t2u5v1r2
 P0M5Pf/IA23rJpIeFm9ETLFsuXgCoasskMlte+ZXECUzgGBRkkci9/Z7Ig3aE69zyxyeMWfI/QZ
 /h3HlnOLej9id1bMMUwsx/tcCBteqvrz6tf/rAgX4QWIFkA2yXgMTI5wMFfBU2hKztD3LpIzAqv
 o0atvNQ9uBgUqBGMA3C8CKM+JcEVWXwkTXe53ob61xIfJtg1yid61w2JtC/bCSsoxiwasajgokN
 yHUNiRIrOpdfaOAMNTA9BlFODsIxTi7q/wRpgm0LDJphMHy7/Kl8Jb370PILu3IMG1mdpFN8MZP
 MCRbjE1aj+aBvDMusaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090144


On Mon, 07 Sep 2026 17:51:29 +0530, Wei Deng wrote:
> The PCI parent OF node check in pwrseq_pcie_m2_notify() and
> pwrseq_pcie_m2_create_serdev() only looks at the immediate parent of the
> PCI endpoint device. This fails when a PCIe switch inserts one or more
> intermediate bridges between the root port and the endpoint.
> 
> For example, on lemans-evk with IFP Mezzanine board, the Toshiba TC9562
> PCIe switch creates two bridge devices (upstream and downstream ports)
> without OF nodes, so the WCN6855 BT device appears at depth 3 and its
> immediate parent has of_node=NULL.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pwrseq-pcie-m2: Support PCIe switch topologies
      https://git.kernel.org/brgl/c/935ecc5c86c5ae2693b2fbff83fc1bd086a9c915

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
