Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1D3E1736
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590533; cv=none; b=XUqmv1eakL8cWQbpD1lox4G3jpEE0zBzZ9VQhRAkvjtMYfZQYfH+0Xq8tD0sUbOFbrrC69msfzwI2dGxKxl6U+9bu36XCVmtNR0H32gvebmZ8FT1Kw23bsVW6/F2RvBHgEXKz1Z+n3merX8v2YqmGGkXTmN/Mfl0RzsWGtQCufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590533; c=relaxed/simple;
	bh=XogVvcvi90AvvWQgm9fx9TiRwpye5Jkvt/Cl8lSnZfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hepl/zKXx1HE1BRwAS27Jlt2eUcpos8nHfICjF1amrqpQ6zYMcXB1ynACvghyzVgyb4v8yawTCF7X5mm2jiGNqTShBd6csH0pUbeMS8flGpqTyIo+HoBBEAqsu5fxLKKOvAwmJloQ0vUQaY6bU4OGhOCO/J8OCGn53pritVcbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TiuOlbB/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F5J0eyip; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TiuOlbB/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5J0eyip"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB5MNW591851
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wdLp6i7BNy+BYJ5K4nBEP1KKhbsqv2zxhW4M6f9mwfQ=; b=TiuOlbB/AgwHuWBW
	qs+t9ei6NI0us0ahBN/kkUaZ5BwlyLN/Jrizhtek2O1Rqn/n933rubRmaDLtGjLC
	U8MmoM45eOxUS7jyOhKa4vTvDVvGeRalV/U7j3PBqbpP230xKt3wsCYm4rGO42Js
	uO1Fl4SMQlE+y3HO9+Hr+u0JCVNW1+KjdGhkB28kaDZ8PaB/DiIKgtS7cFAa0A8w
	U3rrUsLxyk9fHTmifvFqr1hg+epkZAdZrZGUHfLL5GUtnrBd4JN5x8vyWAjbLtH8
	pGG5npPUEkY6mB1uBlgxMjs0YtvuvB1LcFxUdYhNCwqhZkyoem9005QZsUktn3GI
	Bn1qjw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319reh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:55:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so3159689a91.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778590530; x=1779195330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdLp6i7BNy+BYJ5K4nBEP1KKhbsqv2zxhW4M6f9mwfQ=;
        b=F5J0eyipDrPdb8UR/97e2kbfXUvS9ht6qRDmdfFX1C27v2jgas9KTXVTHovQQCtkVR
         RTzTpoRJNK2/ilj33L2ctLW8gEnaNlm2nW3OXnSoqU1nRuO2qNIz8/iArYOygmWA8vC4
         XeGKE78lHwhD7WSSxMacncPJZsP+gqTY8/FFE8ko6YUVaxeIrtdYFRmNFOV7qc8WJp10
         GRK64Wc/APyxScwVwvCRy2ZPbrdSpS/AKLBO0kU68KDWR2ht8Jhv+1foJpDf2Kc7Q90c
         cwfAG0gUAt5lIdJz6lo2e1dYawlOAMVptTQRpKwzE6ZHBP1ZIk7IM8yUoR/AeAU4xGyG
         2O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590530; x=1779195330;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wdLp6i7BNy+BYJ5K4nBEP1KKhbsqv2zxhW4M6f9mwfQ=;
        b=gVUQMMc3Hyz2lWrCe6ZH7jZgBX7BR8B2D63PrW2cbtGzK00cOK55N3n2KHPlFWFbr8
         xIco79heu9zXBJ9X7xoYmQgv5ylCYdJE6ZXYmIKMdjMwJNqjjWkbwev7aHO09LNjN8jV
         aQ0wL/XAu74GKbqcRHBCkfADtsxBREVg5jh11fHBx8sStM80HLLLYiW2r6f0fgjbxjfq
         fBTOb73F5kSNymVi9k64eVsLC6+OHOYJi/ZfqdqosVBP/obsGT7lDN/z+IG7G/2DfGOF
         wnknbKIvUtP6+AVOFdM97uc0v1KArc7GTVh8/5Ii65W+C5CiGuGFThUDeuP09uhc/4tY
         8Z+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+yy3xpl56VjYWzGiAWAT464uM5aGUDM/MzHv46kFeS2EUwRaeTrX8ijfjo0y69zpl//oIPP08ADIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6WX+KMbGJYLA+t76ybFHRuEOBcJ7+3y4s2m+TxkeexWPgvgz
	Kmpk2jE7NFWb2z6Pc/1DUBcGtCEoW0TglZEDulQ5z5rAv9TsYCo4x2J9grkXOPUXMbht/nu2ZZY
	j1t1AXNXHjCLNTlPfyvI9ZxULBYOnborMCgGoMq5WkuqqaNv6AdggioREOhCMz2s=
X-Gm-Gg: Acq92OHihdykjwT87PM31UP2JPvOeZvqe3Nf5MiJt7CixKuX4uEOGXUFhrY87+X2oLY
	BlZMHhgOgkFp9IZhWCE8bBH/w7ETPyPK6tTqF93YExvNCqt8sQloCYsVhdi3CWMhHjPfRD+Ly45
	0oK+/ovdv5BN1hNWCUygALzUuT2SkPKdx2bXetRwmQrhMmLtQaDyUtzTp0PUqR7MWlfoGmPcMv6
	gTuMykpr2PeF6wGKp4hqVxPSO+MlEf7Yihm9JPDy3hdK7BKBi+TW2ajvHM0KFEU5PzhXvKrX5jo
	dnEciqf8l1fTPJSFJ2XLM+XNDFXvTbw0eelEaHcCzf0/idz4O6at8iUXxY9c0EFm6YW1lz39gM+
	60Yd6fACYIqHk+kQpejBJ
X-Received: by 2002:a17:90b:4b02:b0:366:3df3:fe45 with SMTP id 98e67ed59e1d1-367d49bbdc0mr14362007a91.19.1778590530031;
        Tue, 12 May 2026 05:55:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4b02:b0:366:3df3:fe45 with SMTP id 98e67ed59e1d1-367d49bbdc0mr14361981a91.19.1778590529512;
        Tue, 12 May 2026 05:55:29 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d64de478sm11080286a91.13.2026.05.12.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:55:29 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        Sherry Sun <sherry.sun@nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Subject: Re: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing
 the reset property in new Root Port binding
Message-Id: <177859052375.25787.11297345759999790209.b4-ty@b4>
Date: Tue, 12 May 2026 18:25:23 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzMyBTYWx0ZWRfXzyo2hi7pfttK
 o/7WYBLID2i3E5DhLPKoptFgSCSxLyZxr3xYhdwHcRUTq9ApoBCkJGZTUD1Lpp+mPMJGoUDcqPb
 VMSn0PmnUgdfzI1/gHkrSEuATlNyPF02CkWPI+wwzy28wu7NPdPy02JJf0ZUNaxjXXdIh5AWzwR
 LWVlh9w72Rsk/hTjdQhlvEo4VA9SPlXGBecEJt7FnvBNkcvU6nyqbG8A+PuvYaCFYy2nKUghwEw
 Kmymjm1UmJGAj3WLxkNrdX9y4iSLm9aWVh5+6duPLCH4FFWiMXgL7nUKw607oGeRikLBXpcz4Tp
 Lv13R+rr6hxxctlOd+ksQ59G9iX5ptkVP/BEzHDYjIDLOAAsXxlHJKTjmYmIEe/shqj/0UPFgss
 hsn802xY8W+TBaBr6LlDHoo2oMVdkyPVy4UDjSB9KdDYBOuG/6a6756SuFUn1ZgoJxCEeZ0ddiL
 gTYgE+fr/kvWh77tSDw==
X-Proofpoint-GUID: pXtAOSvbbisV9-tDMkxUAOMnaCHSmUxP
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a032343 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=VUCeidzB4OgQmi4dmx4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: pXtAOSvbbisV9-tDMkxUAOMnaCHSmUxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120133


On Wed, 22 Apr 2026 17:35:37 +0800, Sherry Sun wrote:
> This patch set adds support for parsing the reset property in new Root Port
> binding in pci-imx6 driver, similar to the implementation in the qcom pcie
> driver[1].
> 
> Also introduce generic helper functions to parse Root Port device tree
> nodes and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
        commit: 556c5f7aa06d3e8119d35f40b6602d3a547cef9e
[02/12] PCI: host-generic: Add common helpers for parsing Root Port properties
        commit: 6cfd1e2fae1bbaa9258794ba9f3128afb752245c
[03/12] PCI: imx6: Assert PERST# before enabling regulators
        commit: 97eacf72d1754eeff8624114074929606fc3f2bb
[04/12] PCI: imx6: Add support for parsing the reset property in new Root Port binding
        commit: 40b7f61a1a4d7fd18188f3f87e15ff5a90ce1d31

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

