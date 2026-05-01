Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3293E2770
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654200; cv=none; b=joM4HmgRBLeID93JJhtPep4+qkqrWnoqoDzKJz3wxQHDBjAzDKMWPZaC4ikdW6yifrNp+MLD3hSxhWLh5tb/HB3JrvdNGiK12bMaps0jVwYXciOZSbUot35rBdN1y6UETdv6T1A/EnzvUs9f86U+UQCYrB3KbDDDfFf34G2ZuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654200; c=relaxed/simple;
	bh=AeFj9RlfcVtNzkLfxECuvl65xXkTuveJF7S801IXsoM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DNoocE4gJqf0VtDVk6ZJJ0gzKlQXD4J0CtVEV8/DXddVWdAKggKAl1siYfWAaZyybf4r+txVtXxYId9Ck80ogNLtpLozFt36NoDnOyU3Qri+TIY4DuxGEayP65P7QTfZdRXuhWG4KIwIvDtmY3Dpm81mPDq6h9cIvMtzuYDyryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4Lm8/SK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IK06EA2i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4Lm8/SK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IK06EA2i"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641GLSgS4047633
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2026 16:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	feFL0BYgyPheoYTLYTI9tk0q8RVVFngbLeFU5p1oZJE=; b=E4Lm8/SKwdvLwwUO
	R14AGeyRZT3l4cApH32rC5V17GsWufgh8yroUBXezusJNnmOg1FQ41yUCPvTgXM9
	NsKEFQ/kIfgPHK1eEjAEkKQzPhIqs6QFmLM7kfiA1cg2Dua1VdfUKfsftft53Z3e
	pgIAiBoljAiTJOpike+ssSj7akRC+lDgSLg8/Urv5J1T2wrDRPo57JpvUxT+o/j7
	7phFoVywUDNIo6wY9n8L2WdmK/AOUbmBQUX+1qWU24b0CSv3sm+knXBZdGp3+ni6
	kHj0JzQsAyA3aBnJ9PKH2r813YKZ2JVYlB0yWadj/zIOd++SAiWFHqqVup+OybTO
	jfDq+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7wuvvtg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 16:49:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso3354733a91.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777654192; x=1778258992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feFL0BYgyPheoYTLYTI9tk0q8RVVFngbLeFU5p1oZJE=;
        b=IK06EA2iupC13ngOSt84eEq58OCOJy2iTA0IpFAsBDLKabIaK4/IjRy8xfQY3CcWHd
         r+ddii8w5eiR6ACliY6PKT4le/YcIlozrqb51DPG67f7cj3F/VWdHCZjkc4MTMd4GVCJ
         XGa415NiGVttSRNKY8tzRP//P5sa57q3ALREJ1ddNkDUzD4a19+KialQA7Pf1syB+g65
         JZGqLx1MqMtqyydOf6mhKzPnwRtbOS8zuuAw9pwEEOMyCvwse7ZN2w7tDI/TsBIeitZr
         cZnLUsKnvjsseAC6atiuTrhHM8rpeNgt3Le1uwtLQzrbR/m+qkBrV9XX8dck1xpJcS4M
         FgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654192; x=1778258992;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feFL0BYgyPheoYTLYTI9tk0q8RVVFngbLeFU5p1oZJE=;
        b=JxhNtcEPB48nGAdz4jB+oJLogawiMPq34jHjhViGLdvZizeZN4/dAAgv47/FfNaipX
         hlFQFDQq3RFkBCdOp3EIie/tRIGHjg5W25AgbQdxzE5NGGfIya4WImS3H4GeYj0ex1xz
         l42405SRlVjGDgZPdomQmsOblkHQ/mY5p/z/Lf87S3apYVA4hglq2l2Bwlfn7h+BMTZ3
         VutQB7LuIZncoLlIW4bIXp/5RTZmF5LMK6dM3biV7CtuzKd1jprUSDfrM8/tZkyfW6oO
         Y36N6HKqRr43McaJFw+70mXEJb7svnen50eaFemxa9/TFlWZGDKH49rX6IGO3Qdh/gv1
         NBZg==
X-Gm-Message-State: AOJu0YyVkd0VHYe3qajbUWlvQgKq6rozg3iyffRD9PXSyC9jyjjNNbdS
	VK7R5PhHBUlsMOkNit7XV88lcd6XQ6Q4uuSg12Hgghv7+lNTPNLHSbA3klKJ6W/6CWi4NvIlQSW
	KN+hKwlWHMykFZ4fllMpVjI0oE0TQyx5nLopiKtlHZbVI9Q6aXUr+kEIXDJvJdSw=
X-Gm-Gg: AeBDietje7cOJywPei6kF6XwnaBLIjibefhTYLbP2Qyp6MkyRRsDLmBrdbn1GLnmxKB
	GI17eZey3cxA3JWRs4y43aqNbuAS25YaTZbtFkpCsThEdF9BGuX0mzaHvYrVlpP02Lg+bQz05Z8
	wpXqpXSuYeie9tVjql4R2JUYpq9wGmeprH71sSIz1vFeRei9mLP9eG1DFJhejazrbLXQHqM5+Lp
	T+4d2jbwE+fMNyYpVE2CLkWcpZJV4NQXO14Q4n6oZ6XQ5gJMu+kZ7OzhaEkQN8Ej+blLswKV6uu
	eRDzvzXc04BQvoO04N+KhcAXh4CphyltrOjnw6IHbS4FBQY1QFnzRzhp1LV20J8/hmvTXZJYFpt
	I1OO9auRHn3zf71TKsbflqQgXxrS3A9U=
X-Received: by 2002:a17:90b:3a83:b0:35a:10b6:1208 with SMTP id 98e67ed59e1d1-364c49df0c5mr7425638a91.14.1777654191470;
        Fri, 01 May 2026 09:49:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3a83:b0:35a:10b6:1208 with SMTP id 98e67ed59e1d1-364c49df0c5mr7425620a91.14.1777654190849;
        Fri, 01 May 2026 09:49:50 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.59.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364dbeb2db0sm4926163a91.10.2026.05.01.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:49:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Zixian Zeng <sycamoremoon376@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>
In-Reply-To: <20260331171248.973014-1-gaohan@iscas.ac.cn>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
Subject: Re: (subset) [PATCH 0/2] riscv: sophgo: sg2042: Enable PCIe DMA
 coherence
Message-Id: <177765418359.12199.18149733582970959715.b4-ty@b4>
Date: Fri, 01 May 2026 22:19:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2NCBTYWx0ZWRfX4iqfhqpmRnI7
 68BQMnmN3j4i1ysov8O08fqitGQ/WysSk9/QsvadUgSm3Azf+AYa4kwkAmFX74dfVN/LvykE1vY
 Nd53bz8t4wu56z7EmWe5ZRNVcPafB/1SKnZGxN9vgod/RDFfbusAUxlvMIUNc+v6tXM2f3OeRHa
 IIMwf4SLAFTg+IoXvz4kM10hwGY1S8RA0v8Yi4mz69ec89agyyu5/3e6AncOW1ppLC+g8LjH0Xg
 PfMfCU5EljXtN4+UJf+Rk428uuFix6S4UStywrpGRiwIwt7Pl473FqLPHEihyQuZ3Irwie3qivP
 T82x5ZvMUjjmuRjzI/uv3bohUE7fhGQFN4CvNC01w3jyFUvH3KgOW08YmU18X3HR7fIpVxbxXZ8
 nGzZ4s9q7WUNAixqbd4otYBeEj6OLEE+zq9XcudPQ8aQ0UazNfQ3Lx7O+UIJxsWtoz6RiJuiwi+
 bJwhYpIvWYsQ5F3JhNw==
X-Proofpoint-ORIG-GUID: hMfzxNYy_5IlzmOWsQX9RlPt5pKpotmc
X-Proofpoint-GUID: hMfzxNYy_5IlzmOWsQX9RlPt5pKpotmc
X-Authority-Analysis: v=2.4 cv=GMk41ONK c=1 sm=1 tr=0 ts=69f4d9b0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=VvXziC1WMG9Np/cC0Lm1wA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=J_SPmUf-aNex6p-r11IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010164


On Wed, 01 Apr 2026 01:12:46 +0800, Han Gao wrote:
> The SG2042 hardware design supports cache-coherent PCIe.
> 
> With recent firmware updates [1], it allows to use DMA coherent.
> 
> [1] https://github.com/sophgo/edk2-non-osi/commit/017a5aea26a066fd2bf501b7893937183165af36
> 
> Han Gao (2):
>   dt-bindings: pci: sophgo: Add dma-coherent property for SG2042
>   riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pci: sophgo: Add dma-coherent property for SG2042
      commit: 50c94a2351458ee6cb6e52c5678f099534366830

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

