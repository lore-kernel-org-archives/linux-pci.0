Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02BA288AD
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573038; cv=none; b=GTZ+by1C7Dsb8nemJM5aaQLCNp/yf8Z8GYmKSl5qiPgdCloKa1t2tc7+7xj8XFOuAtCe1WYysCDMLP+WPIcFaLCY9vGPwGyLE4F1dVIPSB0OaPT2vWNrVqSD1wbZ0+lBHpkMyW/ZwFs0aKmQ6uFk7Sanirc+fhB+6rVMgTGBeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573038; c=relaxed/simple;
	bh=Rg2L4nRM/rmCCsatjSqa4HCUG4hnfLEj0hiBmiJumio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eAQXPUeBezeWzX045kiJVx1rTKmpXq3CiE5czW3npC+usBEQQo8n2HxZnpmHKNyys73rDPV91V0PdaPYg0+Jw+hXi1FFzyGxeCqqDJOc4SOdepNOp7BMquvafsrt++w7jDhN59AZ+Hs5QNhRhm35Z2v8s791MBw1s5Ml3PkaKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntLJzeLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OG+wUWl/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntLJzeLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OG+wUWl/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637C52Ao1405865
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 14:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=; b=ntLJzeLGPTvhrN8A
	KfnK88vXvr4V3kMaUnRyELTWksVqxFt3EwUdwALIin+rSWejoZTnq95Sx4yZFyXX
	cpaOAmTHXlUI6WnREw9WNERNS6Z/NMAk84stup2KAm/HLTkv89nJbeWFmm9nUgh2
	OCW1iKOpd/CkrbJMUDLUCXiisI/H19Yoi0vUWIIgJTwU1An1p16OWXWIjBMBlX9p
	QiqUwtilSvDjBiZ7PjFfSd5q12dWeWm/uEUDUkRO2YiC9LSXhlAs7Kisuky5hgFi
	Ybqq1YH/EgHwBTfKZNXxN0E2thJkfaPDC1UyWZNZNjlY7uxFJ7MshuAVhLhawdFH
	EBXfYQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrau6fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 14:43:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5404148a91.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775573036; x=1776177836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=;
        b=OG+wUWl/LLYgLglPLVNXvR0S0f3p78TPPVyq2GdlDCoMkUXEb1Ao6Ls/Bk1SFkg+yA
         ydoZ7irvihVDgj7A5PdEdbCPYE8GQ6+iSenQYrpZZ+ju4bFfnEsoVLxZTXHfpfLq1wX8
         8QCu6220ZoUr+OPqAff34b3GDKqcDe0/jCaUf8vYJItkka3LfY2RmhY9ld/jOPI5v+vq
         BdbBh8y7eVe2eQJQcWhF91gUaJwNMtNCMutepoIrZyamwRh25UCfLQXiR+CTF3To/E7V
         lVFCQkYFxpVlhzStejCrouALOzr2InWnLEuPvmM+laVfOcMV1z5zojWtHBYJJD8LVpOg
         ZAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573036; x=1776177836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=00NWTnAGV7yhJd8/Q9KklSPqk81RRr1EXW2S+gNTCtk=;
        b=AHLIyIwS2mTcUkWy5cv5Z/PmS4ICTYf1Qvjsl9daPV7x+/FGtSIXCpJFgwh++BnUmP
         N2V7l0faxDmCTQdEFK0MUkjEty/GDegZF+7jfbL6ZctBSM7UDWj4XGGaMj22Rda8KL1Z
         P7VrV+KYtmlSyJvEVHl8a3T75/24viyWzsV+e6xhaKPyswf6Cz4XSzQLqT2TypULEvI0
         MDYtz7hWvA5uLFFAG9R/1AxWsHTPKHUICdY4zWLu7ct+eCv2lJhgwjXiMmBghj1Y3Kjy
         E0dUCLJF1NpQJskJcgQ/Wv9auFYwdodod7rq18F4REeB30n46t9Hj3Y1BIBnJP2eDMYb
         3/9w==
X-Forwarded-Encrypted: i=1; AJvYcCVgDHaDJiZpt48/LV7ccFRqF/DpklYg3SVt1E8Anu0ypYTNIEpGgoTHwMYA17kyCxCdaaJrN/84cFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynaOuHGxHU1Sppaz5wBjpRBSuhPMxUJxqMSFj0fJ0NLva05TB/
	k3C/hfOj1zhY5gy3IKj06QlnhGqWYRfVdrWyi2hcfxYC7u3B94w+MiEdE8V6zX3a31LCJiTPqUz
	RS/NF7/9Hpu1aezeaMUN8gaw6+g6PUr7TVVFuyfJslQqlhFFF1gICk9xe4LFInhU=
X-Gm-Gg: AeBDievJgd9cxWHQBo2Hh+VcJkm2sw6vKFgrFa5WC46XftBo1q+0u/On+c+RSD6MtTY
	qYT/tQmxzAa86aBYd8bTk64gPTrpVjnc3C3jHyllLeG2o0CgSUGQOZArLkVC+9nJgsBhK40sJbn
	Izg/SqCMzllkUXgXMHcHii+xuWgDsIwyhmjkdxjfan/IUm1QBoC61sPDNZR40bYiiItOUF0Nn3N
	4UeAaQcZlzhTIFPRrucbQDdpX3j4p0jOwVw/GN+eqhS48coTd2B1KIWHoV9ZvgMNpCiUN6USjeB
	4/bO+60V/sbpqTJnbHVObz2Ww30s6P2AXcL/qgIOYfvz7Iknyd9TyYzaXoXcuEzM7028fMnlZ32
	SW//dfPQQrLmX+hScGUe1
X-Received: by 2002:a17:90b:2b50:b0:35d:a559:5c1c with SMTP id 98e67ed59e1d1-35de660a07fmr15496010a91.0.1775573036241;
        Tue, 07 Apr 2026 07:43:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2b50:b0:35d:a559:5c1c with SMTP id 98e67ed59e1d1-35de660a07fmr15495973a91.0.1775573035680;
        Tue, 07 Apr 2026 07:43:55 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm17067098a91.1.2026.04.07.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:43:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 0/3] PCI Controller event and LTSSM tracepoint
 support
Message-Id: <177557303192.289344.2616682402332241807.b4-ty@b4>
Date: Tue, 07 Apr 2026 20:13:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: 2Qbt3PjwPYkqhKII1LsE9FVSraCLg24g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNCBTYWx0ZWRfX13MMURUtxe6y
 Xn9E3mxNi+eBpvm9MvAJSipv+9Vlhd+o3lByWhYhVSKA6U45zM1SW2lIKmL2hskn11OcTX61nJc
 poz0Q0/YKc51LPytIjJTrSU1l96JjJcnkXolv52imiQAx9bqRxkR5p7gdUiVxcQpWRpuF68eMzf
 XzE6Ch/2bPcHIRqF+ppkjm31nipKB4M+7y3azROV1Fo4yLhUu+CKtdqon3llMCOmi6yBWkKsl1A
 KcVbxYVn163vcUwGO+fX6LPo59go8K47VEsmLMz23ohW8Wfrm4FH6LRDDfKyE1qP7NlSum3Ha0T
 J9Jl+OJRzIkNL/rnwJa7Y1y8eZzwjqc1I8W9GsQSUe8pOQGQMifIyo/2OucrC7PfxMkIqUIYfU1
 Lr8QDiatXNVXHpUeI1kQF6BSMGrqXq+uXHSYUZXZo3xEO6oaFwmUEcBYGCZsnC1U4ldXiRgNHbV
 2IfpiqL+1NnsNM3r6qA==
X-Proofpoint-GUID: 2Qbt3PjwPYkqhKII1LsE9FVSraCLg24g
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d5182c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=QCXkDXtUJjd1gO50qw4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070134


On Wed, 25 Mar 2026 09:58:29 +0800, Shawn Lin wrote:
> This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> Bytes FIFO for recording LTSSM transition.
> 
> Testing
> =========
> 
> [...]

Applied, thanks!

[1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
      commit: d1b7add89c004295cd48d7cd49946ed5cb5cbb55
[2/3] Documentation: tracing: Add PCI controller event documentation
      commit: a3966a6f915ea7d1af0941ea26848d921e574c45
[3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
      commit: a276c0d802d8d2a22088b7919d9e82e936995cf4

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

