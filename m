Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5B1FE44A;
	Mon, 12 Oct 2026 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791776297; cv=none; b=Bno1d9d2NYkO0UkTa+sVrwU71m6wzRcnc+1CnvcEJAA0O04NKQRftJpUrNu8O2s/0IzesbMPuacquszvbJ2qCbIUOysd+Vx4sN/FElBKRgGqycIZF+2jRoYmthgznuoQlLuwhUZiijAzSx06p3YJW/faW6TqcmgXaTLNrOHEc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791776297; c=relaxed/simple;
	bh=Q/ZntsoyiUl5NAlZg3yKNvPVzUJ2o9Hmh3mDzMZtxFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpm3/kWzEe5unFH9Dsvxxv07TyaGTvMIqs0JiFO01A5LOOKUsRjAkpLwKQXRkJtDC6tPSGqVIsAJl6GK6NVe76O6sJZg8mKl9TayeaLjhC3rjeD7CNPqlQ1gplnny8YIIYFd5byYnfeiBtGFIvH+r3DAngnV6qv9Ivhm4SDAvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz10t1791776244td9fa7646
X-QQ-Originating-IP: MR/FYUQhdzrCy4c41JyPnhRsY7QqiN4XYNkmggF2M08=
Received: from [127.0.0.1] ( [180.159.160.209])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Oct 2026 11:37:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3249404130733337182
EX-QQ-RecipientCnt: 10
Message-ID: <F11D76974BFAD981+e2472997-2f7e-4a8c-8c82-c7371b554bd2@radxa.com>
Date: Mon, 12 Oct 2026 11:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sophon@radxa.com
Subject: Re: [PATCH] PCI: qcom: Disable halting feature
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dragon <dragon@radxa.com>
References: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M75I2DDAzREFkXxLjHqDfXEfd8HDkL1OuFR+HjlvPJdArDfbEFlmlp5a
	TP/A/5MK6mp950LdaMzsjLvnk18fPSPOCRvtURkXYyCghswlPHs8T2Y0SRbwZhRgJYoYNjV
	lv9Ysc0k8nkoW3CWxz19o1NaAPFpNivz89rx0ZijN9sGbiYwdDdFVuStscDor2EtSvAD9FL
	tkoH4pbeOuHqb6GMZ8yZL8Tj43kG61I30WMrbGKsu7p/QjG00sEWbMEKVJC/aBLBejmUJKT
	F9VS+t5ELHuhL9grE1VcvA+vxjUUXMAJrWyvPp8YXxZZvSVC58jELJUNBxwQFpeYepU4QU5
	ZU1MXSPUjjPx/JOfkz1fL/BUTh914a9ELKUWBBkwClTm1JONZOB22urYVsOr1TeZ14oXbnx
	TZzpdtxaUuJVRP8wt6NAnw7HgODtxJlDsxuHdFjn73SyKs3lCqBs1Sooc6zzd4KOgZRPoqk
	JFggTsis8kDrIiS4vhpKctnulmrLf0GOBGKU1wOsMZGlbnJBHEGyuRGd24s8L7GZv79MWXI
	zVC5M1ex/5H3NEFox91BpIaE1QrhX0/L/7kLbj2wI0GSpZc2ZVcQuUbLMTxwsaEmPyIaB+8
	vI6mWhJyKm4YHZRxXOnVxCAYazn/Pzy8hPCaTl+pSmXabXN+kvffqi9/Cr5Gu126+IPvWEK
	73Rtc651+mv7l8c4Xk0wanorBbAveud8xiMV+cGZg0Rydy9oZMNaWQlype+k6LlPpz4seo+
	Y0QHVqCrvzb5aItp75rhexRqPWG5H0YCyDLeVgtCLpO4LD4ZiR1Km5YXTnYNzynWiTEvx/W
	H9QWjSis6yKyHN/nuAAhnv7wH4umNuNNcvMLAblgp6u+HUdzMU7aiLUKjRNYb1rc6RNPnZs
	s3IShrmjICwa8RSvO3/1oyECkrurDZynzgiwBtbYSMsASaKo6LpQbM4Bn339hBstEJTZdOi
	ceC3gKRo/G3O02QGboSiuAXSpzUsdNjLkDvuTexcDNq8zsubOmncKBqgn
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On 10/9/2026 8:55 PM, Krishna Chaitanya Chundru wrote:
> The PARF write, read and BDF halt features make the controller wait
> for earlier AXI transactions to complete before issuing new ones. This
> is needed on SoCs whose NoC cannot preserve the ordering of inbound
> transactions from the controller.
> 
> On newer SoCs, the NoC preserves this ordering on its own. Halting at
> the controller adds no correctness benefit and reduces inbound DMA
> bandwidth.
> 
> Add a noc_ensures_ordering flag to struct qcom_pcie_cfg. Clear all
> three halt features on SoCs that set it. Other SoCs keep enabling
> write halt as before.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> On shikra we should not disable this feature, when respining the shikra
> we need to make sure this is not getting disabled.
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 37 +++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 

Thanks for the patch. It helps to increase NVMe read speed from 2855MB/s 
to 3106MB/s on SC8280XP.

Tested-by: Xilin Wu <sophon@radxa.com>

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
