Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF78282F3A
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863955; cv=none; b=DvPmT/9auw717/l4uT29uY5jfSgtaoA46QRZXqzy1rl7X2hApNup5M9L0MIgjGD3B5oQAZksLJpeOxBnSDMPBn76Fz8Nw2UW8dVg7i8MW2xSY7j3XL31+eUapalbtc6lw8S0QUvq+XUkHgicIOvUQglvs+8NjahaXLf8/JjT03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863955; c=relaxed/simple;
	bh=T3GjOTpYeHPz53pVwWaV3M8mUgMyc/KwFdDndBzPMLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aU2OzRpFuqk3UfGrjUxCSGqt7WZvqXCUmsNSnWtrml5deD5lJEpoaxig6wCTAY91CKesVbFoSOB7Ga0fA0Q2aaBnecy92RBy/INjXagpEw4oJwRd9o2YM6rqt4gf/l5VT4zUaYG3rqOYRZlPunYz984afufCwCGrN05lNQiRTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+KT3E+8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BfcwHV0X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+KT3E+8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BfcwHV0X"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB6WtV4020724
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/E17C5QueuzhDFwixsSiDn3qQUgxnX0ykvGt2FzYvao=; b=X+KT3E+834oakU/J
	eVSbdNhZYzTmaAMsh5iuoaPwLN9ekmHaPUFkui8Ht7UfHp6aeV/hbyxtCwK9UAkT
	3jKs2oLBbDMjDgdOWxpk7KsX/oM7/XhPmuRnQG0w1rG2AIo9TN+AUi6TH35bfaCo
	T19xt2PwsmiIcq3uCTQEd9Oo/YLDa3Hj5VNCllWaat0JqL7oixEB8HMP/KjK/AoF
	ahmnjI03WXkF7ZHoj5vdE8dtUJJzjxgYLcvKy1bhjDDFgyrNB7DibaTfCOSicmxI
	Q8bNQty3wWLT5xJfsofZihrnYT9bkZ5rhR5pEdCn9NNnr+6JzCCu6gTuaWf1V+g8
	A1mx+g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rv3ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba5f794825so572895ad.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778863953; x=1779468753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E17C5QueuzhDFwixsSiDn3qQUgxnX0ykvGt2FzYvao=;
        b=BfcwHV0XAZ7TVFWp778rjjb/WSNtwZOOSg9lt0d9LF2NV1UIGJXQCys6nnSfpEMKEw
         Jaz5LEzvnp8guXoZYzsga64f1aWPpzSfn6u4fSnDhKRXQshDBCJBxK4AHhodvvN1RcDP
         nNIfFw7cvH28Rj3hCgvqJfqm7edD4e4YrK5nI1TkAz080DUd+YykyjgEaR+Y7umBoAvU
         ARa5hs7mC2O1oY106tk6fUO9G30DXDHaqrVEk1xQtg979TOa6b2p3VX+yul6s6nnKWg3
         51Fo707m699tjoecl424wlWXKaXzVInVxVH1MATSiXVUTKOY5rMTI7qII/RnbHj0QwZo
         3Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863953; x=1779468753;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/E17C5QueuzhDFwixsSiDn3qQUgxnX0ykvGt2FzYvao=;
        b=DsaFYXWUukz6A+P21ctzismRLbvVUtp2yFqXyWjqpYeb8zESaGb/XsEHtnxkWnHfrx
         cwT0g7ZkYITXoDhMyVMqeC1pYJeaVFHb9K4kFMAa9iXd4ewO7WcexOLwjf7LYLfj06Nl
         PEK3CjetXQz36Pe45MUme9JReCR4dlGjL+9ZszbiCN8aWdNzIcEhnE7U3PEfwKEw0VWN
         ews8wWshj5uZFxhZTi6yGjOqiMKzN/1ZYwC7QRX/rkBSXxiEFwVbkulGR0QEj99+dYRK
         +jyg+0zjbVQvdBjsUnaO9nU21UD+emGa+ANqQgr1Xxhu0DVTJ4vT1uiTdVmUWlqj2Jp3
         rWdw==
X-Forwarded-Encrypted: i=1; AFNElJ9OHBSZiI9PVwBKMW5XQ5xZJMRVTWwYg0+CFzsrwgtxsjISbk9lSKWMtofChUoJG+Ws9xIwsJdKu6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oDvVtXVxWYp9nIcdncQGAHzo/pN265oUOlC1SPMM8UaG1TUe
	ExU7LNMhEK6LlJFfX3yEyPPCrP9rERgDKYPNaMQgP80Vs2RzdJSzgbgW0p21pEmNfHfoya3kUk+
	JbGj5UWXoP87yKqIB2ceQPTZMZ4xn8VfiVO2tJntVDaQNBGcRqugaX5iKfr2PRxY=
X-Gm-Gg: Acq92OEssFDhhIbG1YL0m0HEsDUbzWu6maoE8Yz/BwDbWQkMyweXrV2lRlNmp0Eq3Ef
	ygWqiohqk58fWTc6zz3I/tta5mvSqGtDJ45DslbmiTpbkoBzLHQ9UNOv8u6CRU5UKpd0IWo6/18
	11mn5mGewSFLoKvv2Hz78aMjb2n0LUR9B++ym+WIlhOW0aRRSbLItMtylMHUiIpiQ6q2ctxsl35
	El/SqNQbIQ3bANpXptLZRgh/fl9sIXeRwdmTTkZyAu2p8TIwqrpn66ETYdfRHI5RR4O0m5Z3wpo
	thQ76xXdeqSBVpWVroOloq0I+IVyVG4s+wCxH4pihNrK46dOU+sek3pHS50to64m93dB3Rnj3bI
	30TPYwoDaPLYuf883pyOa
X-Received: by 2002:a17:902:8689:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2bd7e7dcb05mr39484375ad.14.1778863952712;
        Fri, 15 May 2026 09:52:32 -0700 (PDT)
X-Received: by 2002:a17:902:8689:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2bd7e7dcb05mr39484065ad.14.1778863952139;
        Fri, 15 May 2026 09:52:32 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm58330965ad.38.2026.05.15.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:52:31 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
Message-Id: <177886394865.8489.5707435379388898546.b4-ty@kernel.org>
Date: Fri, 15 May 2026 22:22:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 79REveAPZPvwvoOh7_pQsqMEL9dgvaW-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MSBTYWx0ZWRfX1XKMQZyVL1bW
 9HwdK5pUBfSRSWs8WS3AqvCklsoUrU7mkhgSyN7+uOdb/keYdZJPZUIZ8g+4bDS2XIN2CqbMt02
 jDrLDqGaeTriMRkwgM83ABLgxoFvIztqZEfMiYFhWBur8l1Y1nhP+dAvGD8UUJjJM7dzXcCc2up
 Dg8ZViHMgHeTnoZ8fPuBO9uf6DBpXAi5dIDaxLVIBG+JSf2mDdojIEvqT031iwIIwZ3VaYq31c3
 j/d/3Un/TTuZddxqygMpdrezlgZw7dW3S9qvoVlQqBjyDQ5eX4VdP3aUrfQ3vcHYuUf/e8htQkN
 MsjCjWcX2E+AoAveFrHSJ5uNFIPFnZN1cBqx8dQ5xkA1cJYjdZ8y7iYBwJR5fvNfaLHLfLSF4n0
 jMTlaLFoNNySd7kibs95jN2oNRq3OeFGJ4AuR0HICdJxRshaDiPFpaF4C8u46KGQWWfeiYLicrs
 SQnsxM/91pQ2lvBJJqA==
X-Proofpoint-ORIG-GUID: 79REveAPZPvwvoOh7_pQsqMEL9dgvaW-
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a074f51 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=JucjwYXNH_3_nybdtf0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150171


On Fri, 08 May 2026 02:54:19 -0700, Qiang Yu wrote:
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
> [...]

Applied, thanks!

[1/1] PCI: qcom: Handle mixed PERST#/PHY DT configuration
      commit: d160e4d32a8b94e534f7c491374b99cf44baa4e0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

