Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48822A4EE
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929522; cv=none; b=tZO7h94HMsxgFfJjR5waZBnfq2+PJSMWN7jRGSdcqc+zbYKCfKy99vxe3VDB27l9N6vqHu9xI4NNzyRuBnMxw+p3xWSS57TjiPdfhB0yyqmVyISCtj+T59i5KkamS6BebsbJa6kuTwOdraiWzzRsDvESTtmmqo9yXWSBh7fY/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929522; c=relaxed/simple;
	bh=wqltIsdFaOf9X0eJjSHnBAk8HWpHNil9D7cznVbEyzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XI0yFw/B2CT2X6iR5FelsgL5hIuHoZC2DJzmtAW6qiAIp7beRY1E6mzPQxDfSZIoBHg3oDerZCFC4I6j70T7yLpSha+NBRAcA4f2BuTciPJI9UqXPlZLVeU3pQkHYR4/Cfqylw0zUv+Da8zgUNU3of2zQAEEMRXT7D+NK+XlDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpH0uGgQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nn0Goa20; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpH0uGgQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nn0Goa20"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFWFH2774596
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=; b=VpH0uGgQG8VDvrqI
	+lPx4y9ZiZLYk22XFR0CQ3LvrFeKjbrBRlX13Oy8aNtOWG5tOXziYYMlCqIydMqg
	tTTxNM7t/RnjuN7Xrrk/6R8FB3esxqzQ4RCTNStRyJA4Kq6NJQLw3gUOvXaYzAbn
	sbzZ3drZLnETaP0IM4duv9F23aaScWWKyJgYYcE9/G8HEQquUrBXxhi5hN8sghG7
	lEewZHBwqoVY7be0IX8cDIPS7DAiA/nBR2nqmQpB4b+zf+RaY5Cl36bv8Xy7ZMVI
	hqlaSFBk/mx7tZ91uwD/wX8sKyVOAZdDv/HZDCeBXsFFXQrnjHL6zJ+4rQyTXbUS
	Xa/TxQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69kc9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:38:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8243a06b397so2542193b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929520; x=1772534320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=;
        b=Nn0Goa20bkuY8KZsmxd/1shpeCWP5ppMyse8zymkdlQIWOK0DyU0ZYV0tzPVFu5lQ7
         is1dR8xbdq3vWIm4FlI5MSBcKs2k5b6AigU5wzkSVfn8hKnmbzNJfygd0OtlGwa/HzbR
         5N83CVxKb5RBpn3NaTqbScqIk7KPel1l4NJxbqd/yqtVBv39Q2rZUBg5uf5Mf9L14AIF
         m64bkZsBd4VWmHG48GWdutatYj+r00ihuzsZiWLQnXvxyBeG7p16nixN3qwaNM27uDJc
         UdNI3f9vEKMjzMhBAZTyJFv48PA1RZyX7jCbTkopoBxrAqpiK8wgRziQs3JuIpaCbTt7
         73vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929520; x=1772534320;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=;
        b=aGSIOz1ym1rgwEAdhXQRbkIQmNinHbqEQdNb0v3NviP7CGOEEkSOUEPtzXx7U3RoRY
         mSiVfYN4rlSaGQ8WBYtLMdupOqnpHqhKkVlwSsM9Rrc2X041mye0rA0xhVPedRjYRNrp
         /T2FNmp5oQ+PbJM6oh8dCLtssumpaUBmjkknEteNl3ChO7CHnr0DEZe5qfS62ZxmTYfy
         z3zWFS/T3rybv9mALbZzH0yXeOjqhRiHFDstzD3JfLWZZxCJSJF8JKpg6oSuys6VYy4z
         dPH4vCOBX8ZANixjDFPteUiTvObrs1zqhDO97npSlgYjrxtlxzdh5+PNFtvTxeZ5Aq+X
         Ucow==
X-Forwarded-Encrypted: i=1; AJvYcCWAk4L0KP2SAyzRMF+vgbszl0ODz291qzHd4gY2resxZpzLnBk8sFRWmN1qmEt/fxRzOR+eyj1QYFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrYg0NTN6s/UNDO+WGSVJjl2eNCK7lMnogZG4IKAA7+dgmkqF
	LIDUZ6XQudkTzFU8EZ3GBCFCmksej7gDk16Bk/J/2mZ3bfhln9W6m5bJwZ7yHILIRmCWvgjSPw7
	HkpOs0fh0XBljlYPMYPKBQ+lwIfHiokdaYWOsUqMZ4GOxBOt9WyXy7qGb/99+xr8=
X-Gm-Gg: ATEYQzwh7Dj9nljZOlPN7txKI+LFca3oe8maAiByU0vSJNRkqOe+C5S/Hu6eUxCH/PB
	MsT+2jgeFaO9prSL5WANLCYYKkfQXEfOtt3X4gyN/QJj2rOjqomjezNfQLmNSTviyjtASh8FE8r
	lNO5MJ/9L6O1byWQeuIVMrX2zu/jzLD0/rLBcr8zg3P9pzG2LNOC4kwhRefY7NPLstvRI2TJyii
	7Pvyf8yUqfAuD5oJciWnRU3UzQcpykBAUynYzwiYGDPSF9DyQuzEB5fXVWKtRjpfsM/UrOl5MoM
	PQHEUMrvVRFgFdy4V96hA0z7JmglvpQUVpVnn+O7VEc/ToXjkb4v2u+d0JXbbaOqcgV0dh9jSDC
	gDqrpFy79I6odX6fakNBGzJs=
X-Received: by 2002:a05:6a00:2d21:b0:81e:5a6e:340 with SMTP id d2e1a72fcca58-826da903848mr8964236b3a.26.1771929519596;
        Tue, 24 Feb 2026 02:38:39 -0800 (PST)
X-Received: by 2002:a05:6a00:2d21:b0:81e:5a6e:340 with SMTP id d2e1a72fcca58-826da903848mr8964212b3a.26.1771929519031;
        Tue, 24 Feb 2026 02:38:39 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ce4dasm10401746b3a.58.2026.02.24.02.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:38:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260219145633.4191325-1-den@valinux.co.jp>
References: <20260219145633.4191325-1-den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Return -ERANGE for
 out-of-range MW index
Message-Id: <177192951496.13238.2336315326171774130.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:08:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699d7fb0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=Ow_fN1IBQddsNOZG27QA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: aj6wclaggv1dcLcKK5umFCp9ouQQqTcV
X-Proofpoint-GUID: aj6wclaggv1dcLcKK5umFCp9ouQQqTcV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX3IhpoUQi4T3U
 qKSzP4NYgHB27hd1SB7l43Nyp92Kn2cIghGOWj7hdelTreVDBcYvISemqbglHu/zw5pnP2xsnmE
 p14+wgnnPpRQi/g163kQGgyXVpEnYVHxzkVJmva32I6S0hCpNAFAv2x8FyvlpaIfFxzPXqjIoWU
 oCjfhlfp3xHnHVpxxSgtrmV7eyjLwMaLCmrZaPtJpAdt3eDzP5pM9Yp90FwaB1wgb24Huxu1SuW
 jH4RKdEovwqzPikKtsvl4mnOkMSTUyNp3OQ2BEq0Q1HydM/mVZWx4fR9HT8lnyalDFE+ZkKPVKZ
 uCfLD2g3j2YGk0Omnfpx7wFq2k3cWzjkewaD8YPVcLnjTo5jdLa83Py4dalPg3dVm3YOCIWHLFN
 l5AsnwzxjyFEJk4OUTIoyGzW104hMNaTzBkBqXnMvDpJaY6w6VeJtJBb8d/SJAEnNjxDjHXHAjg
 h7N+je3ZdcvqOIpbXHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087


On Thu, 19 Feb 2026 23:56:33 +0900, Koichiro Den wrote:
> The mw1..mw4 configfs attributes are only valid when the MW index is
> within the configured num_mws range. Return -ERANGE instead of -EINVAL
> when a configfs MW size attribute is accessed with an out-of-range MW
> index.
> 
> 

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: Return -ERANGE for out-of-range MW index
      commit: 8eaff52fc101c1f6b3215db93bba02c815155806

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

