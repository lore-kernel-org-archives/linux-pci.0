Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306575;
	b=38FtNtxdnYquZNkPuyOU7a/hgpd2QLR6Xe/Dq6lW5NLkn+eN4xFqN9ALrHTkw4JuiUD0
	 AtnB+G/jVvB1Uk/jhvfahTClFEIQKc9+B7GZDnDqfJJOG9AOoXQLvucHpBff0XvNqv0HJ
	 rE8dTk2WvWoPxBgj0SvYuyA198cvO/WfM0Yl3ih2f5VroJijgQNPnl0ywBxNYBisqke1v
	 e4FWpIU8+bi3vl+ro/6GvG2D6N03hk5AteJpxdk0X/+wJqiZrFnrQXgrqzbyVzTpwXyF+
	 66/ZO/H2OeN4VXnSCLXxJ7DnfANW0b51ixsAa+BhyWacWkGQXtGAWzIFtWezzuzbOJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306575;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
	b=3zMArf4RPuuJXEbF52qjxA0Qqj4GxVqGO8B17LQ/nfkQP36yZ0cq8Q1fjSxyy7FMzkIP
	 MAtftA8qmJxLg+Iqje9we3v4mepLaVMNaPHP7sc/8Y/vkiOABUlp/R00S7M9AeCcUlEfV
	 /nNfw564B8xqoMf9D8Kxsrlbhw4iF527Hg+/qyHH7w69eBhnjkUJeyI/6nS2zNgusm0Tk
	 +QNaqw5KA+7vqZgArr7A9Rh8zSDVgENFiNTgj1zaKtuOMpXqMPUWQZUpx/M6KQtUJ41xG
	 y5dRw51DjAdezARm1CGVzakpiXloP7xwhEBoP7uOl6/zrUFjHX7jJ4O48E1WpPses/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="bDueU7W/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F74606A331
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F74606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDueU7W/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8W5eK2833672
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=; b=bDueU7W/JI6jwGLN
	ZOUmqB+utVWSdOUpxhz9dOE3rK7LMcX0hOIEsmN0ZZZWhHKqmBxzZZ1CNU0ltor2
	vcu9GQTbEZJXv2h2tm74wzdPrljskM2MecQnyWLKeuL1EwCbhGGp4uUaoMcKfGl0
	sP5eUDR0NNLvJa/VcMgd1RZShikqgwMRIPVjlp/eVFjf84uCnBBvnsnRfcEZ8Zbf
	22rX++tHWmyxU6PShVpwBGow3UggUQycXO5/DZxE7XAJ4fkhwGyS3uEmsDDLIGHj
	wViyKL1KC7+D+ViUb2MMKaiuGSsVyH8/STmrt4Y8EHYR3eriLYQJOq94hZOmNxUD
	oAM5GA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufre52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:29:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-943e8ff02d0so189645785a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794306573; x=1794911373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=Q+g24FZTmOYxIIE47+dlBYfIyC0J5BCPWmjo73l8rbJxOD+f9TRASBGPbq0Sy3YLxa
         dSVKMjaxmsF3+u94NHxhTA2ze2gbJaAgytsQfyMJYJKKobVJPP+hNt1jXw1zFxteqXOJ
         NWWgRPMO4EGXkPqkyQTTn/r4q/E+1qvEeecglRgGCQZWq3yhjfkJnnieYCdwBo2/JxoY
         FX5bezTlau+Y2qAEM/19Nw/wuTi1WkAfSIiPEwJegvOnVfdYJfXgphJiOFiOU6/xw7hI
         c1LIuP7EXx4VoDXg183hXpEnW6H8N2ce4eOk9LVRJCubz6FDjcPiljG3ibwUGwF0RbFo
         puRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794306573; x=1794911373;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=V8AhhGIvXNwOGU60uJMsiF+4qOhRIa9cL/gWkbTMXQfZMnD/UaBGbMLYNoUTdzqdOz
         rCZSQaFIi8ZK2ljO1R05xNACWFwb05hs8lze//36S+ef44+BzuHHUE/eutElZh1yEA5N
         vyDlfsyKMTJE2Dr8Z71Juge4xtJWuCAZF9o+BkHEaiE/GGJt3gDBO+DY9zfnIVLDUHqn
         Zz/Rxxu4EUTHMTIWTHjAUyCjz5fe0mtfNPaHCxmjXr3AKwqnmrUjnpGub+ZpyNhf6RKl
         w0vdNfldDqxQZdkA6XI8DqG1dlFg15yFIPRthCXXKHjd5/mE54TqMwOPLl6aOZs5Y4Hx
         Zx3Q==
X-Forwarded-Encrypted: i=1; AL+hErH3btsuidxu1/KQ6MWLp/CBeTpvrRicnQORH3yR5bWReApMKpf+zNU505hFDwAGRCFLzmSkrDCU1rk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fzzaZ2D8RlfjXGTHES0D+y0n4AY2CLM4I5sZ4R0CwhxbYqAO5
	dt+t8IF6GDPeHfjZerMLCaDRmAAX1hVOgt9SBUPSdXQZpR+DO+jId7nmGZTUypHirsVvEIUtwkV
	uUs2VXoc6PGdvAj6n0LYRHd4q5GDtESkGoO7w6/NYjgHcIHW/DhewW6Kb6g6BlznOiPSfNVk=
X-Gm-Gg: AYBFou395GdWGYK2vbnNhopw/UZ+T6nbcHAvI01WHInWugyvwPl16G2fb2LtjBByozb
	94I02evZeqkFGxKx+NTbPFBfCKCOKt6KlR3yCKyY3F6mcdTwlq+k/7uFePkffbvMUI4+CVWzIB2
	99aIwToFyYa5i5gvgG0g3clkMJY9YBfQGk5Mbvx1B493EgKPHrintH7h0Y7PkkKqVNck/khOdxR
	vqeXJ38QUFzZ5tRO9yqmGy1fRTk+P4dlCu74aN1ayJ58T5ODP9OpFhmSCw+WaUCcxHNuP5VvwV1
	LEo/ubxot4xAPVZMNKoWm2qBvS8VbvqUS8THWtY+at4Cxs5LEZ3dfhoTt87ir84dSfO0WYYXVSe
	c4jf4+rCu5oHQKfDKnKUO2C16Bd6FWgDGsq5ng9DmsJv+1mPIc5TkadL402ZtatbqUyC6Kluzty
	8lyrge81evpAy38gqvroDGbugy+ORKMhJYNPCbFBfGB6Fcpy5uRW18/+usU1U9Iw==
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351214185a.29.1794306572795;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351210785a.29.1794306572282;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm54994175e9.2.2026.11.10.02.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:29:31 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: fix serdev controller reference leak
Date: Tue, 10 Nov 2026 11:29:29 +0100
Message-ID: <179430656698.56244.5559839363678053917.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7KSPcXew2QF6Mz7AhE_9pOD_NmXm4Mz-
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af2f20d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=heQ8kAePCfxZzHD31_sA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 7KSPcXew2QF6Mz7AhE_9pOD_NmXm4Mz-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfX5WwrezDvOhaB
 uA0EM3RFqZhlCsdKrecK+7+I1TewFKcRpX3Uyl9Mfmfe5aKPXNMhupFKhlW8WTEHr4vCq25fnFG
 Mp9Kfzk/hQ+REHLYxOA+RLEFAvNSHSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfXyrmPvfjW9jRC
 jjb5JhOdofimbR1YrptCuypXMIb1Pc54Sz6RQ9RFOREyJ2LEQf2uhxZZPb4LzVHuCtco+5ZA93U
 CepchVgCeMFUHfTcJ0o+42Vdm/etjgCgbg2fbhNssiTSFP67mhu/YfVDNvuS+9X7XzKmK5+9/+V
 +IeNwVSy5oI5YvFAzZ+f1nXfQRw8wIsYX7oOQZ2NdYRMX0wJgmcq03v+9bQqQ7f2JtUhqYlw9Xx
 Qf4LDw52esTjaMMLGRI8SB/jAXqdWirjdPjKU19ppZVlXD7awJ2i3Ev+OAnTZDPekYWDl95QHGR
 70a7MvkrlpJVUfJ1z9SNMRlgf2RUcRaNihiynyZ10zs8hgeyPVrXtVdiP1U+kMsrmLbF1rQ+j8J
 3hdS/gd/p3Z5TbV+NBM9ObD20wmJBWZCKGKIT3pFlBqHsrqfuP0g/2KQn34Et7DlztXiMtf65xE
 AAszIPoz+nG0PPWBZBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100041


On Thu, 05 Nov 2026 16:46:45 +0100, Bartosz Golaszewski wrote:
> In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
> pdev is already tracked in ctx->pci_devices, we return early from the
> loop and skip the serdev_controller_put(), leaking the reference.
> 
> Initialize ret to 0 and jump directly to the label that ensures the
> reference is released.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: fix serdev controller reference leak
      https://git.kernel.org/brgl/c/073f01043e79fd76f4fa648e58061c80329a6eef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
