Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DE36F8EA
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022855; cv=none; b=oOmqDFIZsOaTlz4X24gCNibPaYQqKS0HpfHG9QcJpfuGFdVg6NnHZHmKliELiVrdSeVHu0L+mD+lnWQla1LNAGJtJjxe/DLyhSNYpNgn/GDEOXKNT3CSgudZyHcw0SUvF/r8lR/WQLsIzvAZcgeI7ZIb7VOaBC9HoLVUVy4vtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022855; c=relaxed/simple;
	bh=DxoTJMN/+LqAjPVtnWiKH/bCmxKlerXb11PgAdqBhaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJHq2Wy01VPnLgA1Op2Mtv8CkmsPmaVrvxWxgqRq4+vpr8lwJK3rmRsRJgN6zAulGGoQwpr5a8xUBaptm+mz0H4qLyarjunv74wt6mKvbq9Q64cGzDxTF/Ec972lvb5DZJDcZ71PqfAknFAP4WCiW4yoFD7pl5H3X43DsTQbfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETH+St8D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sd7FK2uR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETH+St8D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sd7FK2uR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gbw71108047
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YFPGqIoHsHzOQ/AB7GpsF1lM
	lefggCSvMh3OTOdNvHE=; b=ETH+St8DBeVm5VrpEeOhD9UdiWWjSt3eN1NMZpCE
	yNowZjNgaDUR9XltGCKhPsLZhsNYSU7HYlE+Z1dRVTBp/90tBYeXGr6ZPBkZKD94
	V+QVJD3QTWoPxhdrDsSSPbf9SDdyw8QoCYZBdMM6swuVcKLJziYkzO9eW6lWJ8Gm
	hhaArxqZGQyi8MzbdC/02+oZ3q3wJ3nMoDXfcpsE0jyGPK3qj/GKUCei/tiRPQ2w
	GwX6qhSSmNM4t8f3zE1tQRKhcISaUO12rTh7UPBUQyWMzIMJVkGyHotBFqAw/KHn
	EYstR7gSaxEgQ7fqKN7GoxOQhcgscBZpSmsbQSQkrrp2jg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyhaeav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:47:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so824346a91.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789022852; x=1789627652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFPGqIoHsHzOQ/AB7GpsF1lMlefggCSvMh3OTOdNvHE=;
        b=Sd7FK2uRA5lOnndneZA+n5H0eWXn5zLS9QxQmhtkLSGEaB57m/SRgBge5vsOJab6a5
         sIOkzdEM2vQSL+0wf2vv+306DTa5+wvf1MklNzunwKpqtysL57zpUvHgwrl56kucp7kZ
         /EyeqtyAV/XfvlDG5MLp1WIbUDT+NffDdkg0CWu3WEBnJLQFg7zNNlZJV5aKxgabvDQS
         7qasiR7rLDVlkFQB18voYUe+usemG1KL4MdOzdH98yWMoRWefeRBYNnbG6hgM+FRLdpM
         3oQFohgiGjOfreBAoRbil4F1sJK7BnpyiKY9/Q2cEZ7D7o3vUKT4EsTBrvOhD3qBZmSF
         ZOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022852; x=1789627652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFPGqIoHsHzOQ/AB7GpsF1lMlefggCSvMh3OTOdNvHE=;
        b=MElWX5ni/2rAVPvJaDdLoM1jgteGbU4DlTLQS+4EbAwnQDXUUPQA+BCYuZ72d9/bAp
         2hTPE7oFXC0nHiA9JsivegFyRV6Mu7S8VJtKPQp/7E3/EQRLbxqKgdLAZjzmPrdewJUP
         PFviMSmWrZFQ8iowTLPq0mpk8jgp73Pl7Xk4BdcCa8ZRqv/nmjhXOqMhBxZZ2PInS5uN
         FlgKgW0N0ncictp05S512M1N0zvpW/SDbl8Ae974D8DDKDDZLuw2Q5nDSTirRpeBYKrI
         RfdjoAfDtVEhCTztmxMwmUOemxb1+eJYPPyZWkUvYSzSYQVMxq8ue777U9QwyQT8hMEm
         MT1w==
X-Forwarded-Encrypted: i=1; AKwUvBxYJKdmAf+gnqdbExS6UbUFkeoDiqSkrCaXWbaBqNb2FgBfEAgziCKqY91ld/ldJOfLzIR8OuLtdBg=@vger.kernel.org
X-Gm-Message-State: AFuF++nLrOfAuA/oRjC8qhUtHeYCvXh4WyQus7wSeL58bfT/dvW6PmQv
	kvv6fWGH/Vpw/WZanFYJt0SQND8pf0zjLADuDJirPd7jBx2l2bz8DD7LB4cTVGB6NvzHs3hXpi/
	dzK+FKYfe9BoHjYAtPIJC2ckqKF615P7tfC5KzYXxgL+xuunomK/qYrvefW5EJn4=
X-Gm-Gg: AYBFou1xZSqZXiXPia84vVBM8I5lcvkW7vtIH8UXK3cjk9cMRD8DxMYEa1xfAXHZ7Ox
	sI/KwREllIbUw5QoA+K3bonbDNBiwwzg1mQl27cJEolknhoHLlZdd3qzZAWAJ/WZYeoKrPkWkOM
	ZD+B2ppzs3apuU0QEcF2YPl7G5hDy+mFhJG5/nrA5+LQUAgLU9YocG+2sIdxzkP/O9MINbal5YQ
	WAGKKHiQiFPxpFQIVgGZ8xhgWqOnqE3cxwZzw7gCV+7Hs2/W4AHu3Z5F4IFg9EpD7czGPXWUNZg
	Rz9Dd11VzLM+SIQBVeHqZ6nVGS9+acOrKGeg6+Dvtb1m9d3ltKPQmrZiYaO4BHKziooV5rPT7+b
	miwJ15rEzjeDcREh3Z1wKqeb9a1yJYAvkqsrh+ysr08A=
X-Received: by 2002:a17:90b:4fc5:b0:398:ceed:b903 with SMTP id 98e67ed59e1d1-39d77962e6fmr4114549a91.11.1789022852334;
        Wed, 09 Sep 2026 23:47:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc5:b0:398:ceed:b903 with SMTP id 98e67ed59e1d1-39d77962e6fmr4114497a91.11.1789022851799;
        Wed, 09 Sep 2026 23:47:31 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm42950318eec.11.2026.09.09.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:47:31 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:47:24 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/5] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
Message-ID: <aqJSfG1Mj314rbEU@QCOM-aGQu4IUr3Y>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfXxO+D2usvEjhS
 vBxeJIeMWnlkGSqjm3HTZQ7gkC2KapBLTc/LvDptX5GmDyMhxMiwuEDxfGBN6kWFDYM8WJb0L/W
 hm5QZcJ4lcYOuSMOZDZZZ/YqIGs5voAOn/qmjExBbnsaf/dO3oIgJ8zGACbZJ8GBkYFwx0poSdx
 qDZ9PJ5z2rUtUduikuIohpaInNyvQhsVqn96ss8zjT1y61AORVtP8Hr1UOPb4oFUghcPmsRalHn
 zKwVLjwJ2tyrahH+v5MAaCP+MyqiEN33M4xp7BzX52v5xRxAceIO8tCeIlFAiduO3vN84b78nCC
 NTL476ke67DTEnV9xJ7P3cSHuiF3ST+Grji9kwjJwSXEM9fkUC+APXs7UUfLrRuCH99Iax4DRXJ
 RgSKPO+omZ6h4ss4u0SPATqVo5gZN7YaWA2E7elLje+HL4FaUrRmGAfT5PaIOSAbLBPY7UO8Exp
 KutDV6N56PuSD+plh8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfX+V3Pit92Oppy
 lLY0boBLKyM47Vh9PnFuy4QoBNwDctwjc66DKuxRNPN0KqOVy0Oz82c4NHehfwVjKXPHVcsBmIR
 HVpWAPP9d4fViOyF81r7F39rP3dm72c=
X-Authority-Analysis: v=2.4 cv=YKgKWhGx c=1 sm=1 tr=0 ts=6aa25285 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Y4sVft1UDeOkrP7wHAgA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: vaLNM9V8bUivADOzZdYdVKQmBb3EDcSg
X-Proofpoint-GUID: vaLNM9V8bUivADOzZdYdVKQmBb3EDcSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100071

On Wed, Sep 09, 2026 at 05:18:18PM +0530, Krishna Chaitanya Chundru wrote:
> Nord requires a workaround to address a timing convergence issue in the
> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> 
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
> change adds the remaining required settings as documented in
> QCTDD11972446.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
