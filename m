Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD01433B3
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321492; cv=none; b=ExC4FI6GSZdbau///oAiO3xqgnFQK8kZIBu4ngMWdxCM4JMq2290d2MAYgxZ4gkesrgU8kGYi07m224GEKcRMS8FMnPTmd3a3bT7LZSQ2UCAmAg1VgdXCz4Z+4bLHgzgVAl73r9L1+2zIJ8kfSoDTM5SMbb8ptQwUWlX+va0ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321492; c=relaxed/simple;
	bh=Vx8DIUs7so65W1SOJf+8EampHku6hasfNwd9/iqv0xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JryIfuszXiV8xBAs3C6WZIno1ZbOttZ/LQU3lZb3mvhxJDW7Mcr9GNpKXeWfBzG3NNuDh+Khp20cML447+8XjCEgjNc9W1wJTbxBjWlfbjGsXJoWuvPphJGX+M1ucROZOc1/hmHJSx7n8Eiv7cC1ZKtoUIYGIpi9QnEAtqYzyOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aAv9KEZY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBmgwVsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aAv9KEZY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBmgwVsp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6343dxB9097814
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 16:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OE3KlKPOy54a84VacfHvP1EMsCp8vcEdYuMA1b/mBZA=; b=aAv9KEZYGGtDdF3M
	OmfW38T63vSNQSDYWE8hzShKvMvj47K+WrQ6D9qDQDUCkhyH4GZSKpa5A9cTfbKs
	cvqJ/8fMfwjreY0AIn7E8Nkw/FS74EMNtkaxjJmGjduV87i5KkY/l81qH2+dtiiD
	C8IZ+RnwOIIWl7qz1jhTEscmQ7FOUILoERhnKa01iDc0hTOfVxOK8g085qN0QP2O
	0PYv34OzdjvBO6mDc1pxcGANn1ZOPn4p3t0Pgr94AIUWZ1qvjcWOZ8uyY9Ob20gz
	pxpcXMatO/Pd5mX7flADZLWbzexqJM0BSUKRiWnKTU+doOJQJ6llSUAN9RSalGRg
	9Ph2dg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5s9qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 16:51:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c9364612fso4152226b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775321489; x=1775926289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE3KlKPOy54a84VacfHvP1EMsCp8vcEdYuMA1b/mBZA=;
        b=JBmgwVspbfbobVw3mbGEd6KfNjKphWU4wBPmaGg7BYCLJADhL4/zzL5Yjz7Iczz7V3
         i4H8mt5cMV5elwdzXLpJsCeG3ccwCJ/PD+vH0A2RluQVIVaGjJX2U+U6kMIUzz/fGToy
         OwH0KltNg6vC+2dp9eyXKsF3JSouNmbPbdqUVBndt+sF/E2HuouNYctGa9LLlvvEcrZ0
         sh50FUCQhH6bXOd7vJS6aiBHks1mIDiZJ+iMW3Uv7NkcWDh/rx7v2qgQLwPLv0+CQgcR
         5d5Xq/wMU0I0aDEvjB5fyo7zYrts9Zjpa580VXD80AiTii8LpGyOjeKHI7PcKpBD+kFB
         lRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775321489; x=1775926289;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OE3KlKPOy54a84VacfHvP1EMsCp8vcEdYuMA1b/mBZA=;
        b=PZHHbeUUU9+rkQROxHqFVGnjbhSCK+jDm/L/iSIbtS1zRNVTNndvil5sQuHcsM08qw
         0HJc9dbfenuqZOmoTgvtG/Yq9CX5wmyxfzjJ9bUoKwXjOmxT0KjAvKsZnauDqrSmptTL
         F6yEYo5qnidlr39XxCP8xNpPPHw8ucH15IooRouyWnCCRn2l3PChOdXWptjWl5nRVmli
         aFEmJMgbOg0wzfX3xCBnAiJ3Q2zrWVvgqinpMnADV8MADWBJBelPjvcywDTg1UGpwynU
         m3XQL6XzY53KOPlCeJOIzxe/E8Dw9/LLiTkUdEkIHJT97BFuqnNIwufGAM9eHSI52L+a
         QRdw==
X-Gm-Message-State: AOJu0YxoeaSRlbeyqXrZwCvP3el4zdhPS6Xz54ZhSLI5jZ1o0jcAbPi3
	TpYPgLyisPMDZWj7gsyVLRHy5g+cRczNG9YVN4Mvgz/UprrJdY8I6MVZUgOKmyFaLMUf93pswR/
	t8algAIueJPifSYPOz5CiifnKpPECIPgenGYN+25BEvSJ97vJzukLWX9QrY1Reto=
X-Gm-Gg: AeBDies0XtX1D0qcrYLu4s8YloHG9fd80N3KbBoyEXUtRFqPfLTDSrvLnDgGlMX21WT
	Fw11s7L7uUJvVkFzlPu5mHkkcVsu75lyjLUduF2XPMWFK2iI4rH4AfjIT1CdoAEliJXbprnYdo3
	+6akgY+Ho/L7WVqJ89oY3DrMGIlJr107LZ1MbdhRDhRVlrouQzHlLasMY6DFBtX0gm3OM5BYSum
	HwOd5WEpPgXMTNQ4ZTB7c7585gRwwJQyjNJI+GzO8rCjxRJjhotkNF7Momog42VLmCSPkfEEbDT
	Nx8xmNrzfKKFOM1Y0KRLS2fOzAjpl1aLLlhTyrVgqe5MLOSLnWjWjU12AD4v+8Tpz3hHtoHgixO
	scPgUr23FyPcRzxQZawBcrr2D
X-Received: by 2002:a05:6a00:1ca5:b0:823:998:95b0 with SMTP id d2e1a72fcca58-82d0db5b2c1mr6454115b3a.35.1775321488911;
        Sat, 04 Apr 2026 09:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca5:b0:823:998:95b0 with SMTP id d2e1a72fcca58-82d0db5b2c1mr6454093b3a.35.1775321488280;
        Sat, 04 Apr 2026 09:51:28 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbdfsm11742697b3a.53.2026.04.04.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:51:27 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260324093542.18523-1-wenst@chromium.org>
References: <20260324093542.18523-1-wenst@chromium.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: prevent leaking IRQ domains when
 IRQ not found
Message-Id: <177532148383.26157.12106877313693816923.b4-ty@b4>
Date: Sat, 04 Apr 2026 22:21:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE1OCBTYWx0ZWRfX8G0jZFMdXARj
 J+LdOB3pUdwF49B9v6WMtGJ5r9I+ASjrZWfdxj4niikndKXMQgaXUMg7yqPRbE91ORpQZddWmoP
 Rfbx1BqDAZ8U75HGlPBH329aUzRprMMAtdO9JT86jHUbGHG5D2xGi+Lzo6v5AxmnXYoW7Hbc41H
 xdwueqcw6pYw8bYbJE39otRQGr4ag7Bl5/raI6j419CrTdnmSJ8bgPXSuy5ZXxhhC6aaFXHtlID
 vHmT9Y+oCW6510FW0W8DJ0SBhFVjBzkvuC4Us7XZ/hx3hu91QL8xjij8RYdNAtLUYtDdDj8S4Be
 WDqj8qmsEMkMQpx0hC7FfcVLnJdQLeKaA9su+jS0FI40KhEFhAqvrALBHRD+kXIskWjkNQf9DvS
 7qsfgbLiYzgACHns+k7EzhV5niIej8LfhBfcqWfeKnF/XK2ef6bfRhAtEZWhmWzvtisr+rQxeeZ
 yHt/eY5G/WHhG3hFrpA==
X-Proofpoint-ORIG-GUID: 2autXVYBsOGJPPQ9oEDkpSV93PoSp3Cn
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d14192 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=xYFpZzvQZLPhPvho2dYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 2autXVYBsOGJPPQ9oEDkpSV93PoSp3Cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040158


On Tue, 24 Mar 2026 17:35:41 +0800, Chen-Yu Tsai wrote:
> In mtk_pcie_setup_irq(), the IRQ domains are allocated before the
> controller's IRQ is fetched. If the latter fails the function
> directly returns an error.
> 
> Instead, reverse the order so that the IRQ domains are allocated
> after the controller's IRQ is found.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek-gen3: prevent leaking IRQ domains when IRQ not found
      commit: 5573c44cb3fd01a9f62d569ae9ac870ef5f0e0ba

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

