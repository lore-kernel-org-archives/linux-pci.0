Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAED2DCC13
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316539; cv=none; b=Enbnm29KjNHauZQC9Ok2F7aB6eZI0fILNFcAwc7AbvyPMRYHV1gj74SusrrZwFw+LVW+QS+KWjGkSa8We78pQFN11AkPf39U+V+J/Mb2iad0klAt0YY54fvrllBiNhYKVmA/1n16w+cCAVgiN0k824K8Sur6mGEg5C4AMQAX3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316539; c=relaxed/simple;
	bh=S4QW9JwNnjKIhH/067UcF2jxP5g4FcC51LZWvfjsWXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oMV716NXOnb4tMdRjmOQmjcyw/qhBwHzAqF/Wm1bxOwOqI2oCfJ2vY46XpbGb67ez1o/g7fZbYOaXEIhnNt2rn0a5OBz2ywFdgcv7mgFWyjTE3SJcA1xReJz+VmM6lZ+Rmm37NQeBkHZCPXZ2JjqfmU46TdVliG0/Yj+0QhWp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXjUs6n1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eleCybva; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXjUs6n1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eleCybva"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342XkRE3989221
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 15:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8n/+yrNV8tYXm3tYcNcwcM/yIwpdXJ7yevZIHqae4G0=; b=aXjUs6n1gAgSIgXa
	N6nZSGesNxhopARlV8VKi2drDnTRCDVhq7sLV7pUHLnQf4FtPcMkQvUhZZCqVlJk
	cXSyCO53oL1yYPLNW02JjPqBjMu4BWFwOIB5eL/POoVF1iOZmNbsd+UkYCqqGaHw
	k6b1oiH2+/6q8bBA0xNUGsBj1K0F3OhGGY/5COncM9aZn+d3tECtt2Vx63pQ9Hx/
	DWF6fRPCXewDLsh1HXg8iH46etBmEXvVXNwXCd7kxIf+e+QhCqL21niMMrTYDu8o
	JZhO5CesAtSOxj3Mu4/TWjiYDiaPhBVmV8mGXMgYt8Vux8igklJAT5faz0qSR2o6
	luhetQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasyfh4er-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 15:28:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso2801072a91.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775316535; x=1775921335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n/+yrNV8tYXm3tYcNcwcM/yIwpdXJ7yevZIHqae4G0=;
        b=eleCybvar2M+0+X1tSL5SPa5PFjzNzU6UYQazIXDrqNlJpIU2HNj4o8WYzWZqFOap7
         dY8oxo8CeWQVkqe39o4ttKq7wwK1ujjNG84D6+5aWPbV8yuNAdlx+fKU8kx2pxR/n/gG
         Wv9R5L+apuLvaJPU9Mm41AlnxUbMKI7+3KLCjKqvBDI2bxWKxlZxeoonNWQO0g7HInVm
         alsgm5OtEP/8q7Nuf2uZb2DJ7EqfbnFocjZadCSQ0N387ihpyP9jKOHLrwZU3S+RYjc7
         J+bQOwh5TgMu42CQw/BxsX/dvaPtXyGfykLI5HgDhzl0VefH9oQAafqnavWF7kaluCJ3
         l6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316535; x=1775921335;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8n/+yrNV8tYXm3tYcNcwcM/yIwpdXJ7yevZIHqae4G0=;
        b=EY2cuhc8A6Anmzq3rkzQ7n5nGwC3DQnjGzvzhrjIT6sGl+ykRC37UITjz/OO1J7ZPg
         5ru4SnCiEqF7TM7AmSl1edh+3e+70oxyGf1ynaMRzuAquW++Xhho3rupOo9/x5ztQTYu
         B5QIYWtXIvw08T1z1OdEkPmpL5VWutBWSCUaR8UDFW6HkhZ/fboAckns6PxW7S8+tthB
         Pqhu4atJGAyNLZiSVOoOLeVmO7TBPqLFRrRMwNtzUL0nIRF0pvdUa7Q0edTsQcxPbUud
         I1tUVJuFIZwt/KtFNiS1h/Po1KvZdABQBnlVqfLAaLIj1KuOvFQjxTfOEHulRD1VI0nQ
         4mMA==
X-Gm-Message-State: AOJu0Yz5zAvR0+Uq+o3DwBSMtyCeC5zbTwsBtoVAbFGgdqR50ZsYfG7Y
	QAhJct86LoKPIyRHoF7JBvqjoxspua+6qc6JXELCD4z6cAPP523HBh5j7p7vnkDG5KXwOm5Huh9
	0Gs7VW4JiN3oOJurtTPcV7HAdM0QeeoWG4uQcTdvbxw+nEGPAH5uTeKX0m9tvi9M=
X-Gm-Gg: AeBDietwZtaOeOLolcTGC4AEjO0lVQ/K6u2wk4yzGV0c554IYlynQrWHA2SkI0PLz+s
	n61RS6sGzirJ5/LnRoa31VAB6TZBKkH9z+VgMKILq4PRgFjGplPP0h1LLY0XS+n8wsckcY+1Vdg
	FU7Vxk9G8OGDEjl1c2RIXKA6xguiQJcHDcf97xY1Z9hVPnFCtvLYshdxb5jE+lHqRSmcWxvIx1E
	yn5sGmzmCVNC4usdUfeijpWVs4LADwNqODROENcs0gTztTu3E+xT7OU2+b4TkTm/pIS4ycsBOE3
	4nSFmKjQWOVPSXokp48sCWZX47jZD4LM0sb/cA1xr1pA4wG2zhcHp5yiCov3gvdC2rsc+/uY/xC
	6s9DPpJIhDlK6DQDASypkBGxQ
X-Received: by 2002:a17:90a:d605:b0:35b:90e7:c44f with SMTP id 98e67ed59e1d1-35de67dde6bmr6304816a91.7.1775316534824;
        Sat, 04 Apr 2026 08:28:54 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:35b:90e7:c44f with SMTP id 98e67ed59e1d1-35de67dde6bmr6304783a91.7.1775316534333;
        Sat, 04 Apr 2026 08:28:54 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e5127sm18133539a91.1.2026.04.04.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:28:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
        den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
Subject: Re: (subset) [PATCH v8 0/9] Enhancements to pcie-tegra194 driver
Message-Id: <177531652693.22567.6764547001633032582.b4-ty@b4>
Date: Sat, 04 Apr 2026 20:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE0NSBTYWx0ZWRfXxCW6xbAOviDG
 IkWHKZ8eCnWaM2HbP8O0kO/75qPCFo/VZPDOlfi/bmP0L68ou15H93d6iBCxyzTX4fffNbmrPPq
 v2eMIQLHZk+gkMtr/AfWeOcCqcQyuR4bmk0HpLFhRiQVoo/1wVx5Zd4mwVgjKDYNqIg94qevbf6
 9dNCtaXWLykz8NvKoD2wcx54/7ExM0oVQ3oNy0ku4P3oSPbhmgvEquwYShWxpviZlO39rFwFKkJ
 Ta/VaK4uD81AlvnNfPdk7iYCz6igt3ziQ/Gx7b/XNL9ESKAb5HLv6lQLmsXHPyVR/x/YGIM5s6K
 s4yp0qHyoUdrFOv5paywui4JJFqnsOYKFDIf34bm0a9nywwZNkTvcWSEAFBt5sp8DYgHIPu5A5K
 KpmzDRnQx9K2OYr/yPy+BlcX7V26uNhH43cuR5+sisa4JR22FWgcchmqsndKZJURV65lf+hGgsS
 +SFQ61ds0a0vKPvkn/g==
X-Authority-Analysis: v=2.4 cv=U5qfzOru c=1 sm=1 tr=0 ts=69d12e38 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=_6u0e06fb9dIa6sJdSAA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: k0fpRmDGwoDKFnp4o2uYIHHSu0JA9Ypj
X-Proofpoint-GUID: k0fpRmDGwoDKFnp4o2uYIHHSu0JA9Ypj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040145


On Wed, 25 Mar 2026 00:39:51 +0530, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments and split this into
> two series, one for fixes and the other is for enhancements(current).
> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
> 
> Disabling L1SS capability based on support-clkreq device tree property
> is moved to common DWC driver, so I reworked below patch to disable
> just L1.2 capability on Tegra234 SoC.
>  - PCI: tegra194: Disable L1.2 capability of Tegra234 EP
> 
> [...]

Applied, thanks!

[1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
      commit: cab9cf41c26efcb38b6a010bb47eb865d2c28b8f
[2/9] PCI: tegra194: Calibrate pipe to UPHY for Endpoint mode
      commit: 48950d06f43ae06a292dba4d36055f4b798f08dd
[3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
      commit: 255ba6db039d78c5984c0e0f5cd5f90a4665a7ef
[4/9] PCI: tegra194: Enable DMA interrupt
      commit: 7cbba5a0dc2719bd3002cc8d88f8dacd240ca4a8
[5/9] PCI: tegra194: Enable hardware hot reset mode in Endpoint
      commit: 02f546088a94726b0b1a1012a0b8d6a3ac635d2e
[6/9] dt-bindings: PCI: tegra194: Add monitor clock support
      commit: 513bafa5a569c9138849da2396227a7f5378a8dd
[7/9] PCI: tegra194: Add core monitor clock support
      commit: 8eb40477d93539505b7d8104d5cd776282eba44f
[9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
      commit: 814f4e4b6cceda9e816fbeaf2a6a0f9b50b3f23a

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

