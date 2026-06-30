Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46004374A07
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829677; cv=none; b=PooEkMuZ3jgK1/k4glAK9Oud784rgwD0iylf/ogDKA4wTbNeP1A8nIf+gpneWPTkGtLUsOeLD347a0DbxP7rLtRcRJO3zwfFj09OPfFLeHEhGgdgJAnJtgiZN1Az9Z+B4z5HCljJpTcZIbxvBSy5PnF+vu6x/HsFb/8y+oc/wnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829677; c=relaxed/simple;
	bh=ohIgmR0mYCbPCube/lf9WDIrNuXt9646cuatsuA7c2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TLza2sG5ADJMgaqZqU2G3lcMpPnRV3RdSPHDxCEg4q2WgLJ0pJSB7CtEJoGfY0FNBY8faaaLIWNNczYJ2LZJZUXoW0YAQwhUUvyg7tzQ02XtbZpWGCVE5pVvnn9OiiHGBJAPSnoodwx3yUc+KeUiz6osBO/zuAR/k8FIplFBbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBOFsgGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WFTMIDzl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBOFsgGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WFTMIDzl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDKWp2128871
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZPoDywCNwFTIMKzJKOShHepkzGRvIYESnrp+JhqWPI=; b=IBOFsgGby1XPNUw5
	aIBeHGXi4nZ4B+FVFabNOqgQTa4DacN8dpLt0jt2VYxB1479UQVDeUUbNBM0S8++
	YdNMzPaDnn4uql5GH+RgKyQJx/RVua8RlfjgiymwEc4kWbF7pNBs1ybE/Zuh7NdR
	yjEmyF5IeJRACj05///WHX87JA+BQ3hUr/FI5CaBkCfVtlaitumDg5e0JPd8mdUB
	NS7XxTpDwhQNgxHUhOLO4y2dnjqHuFKpI5DFDu9OzMo7qK5UN8DxmW5sQiOWGkcP
	nZU3dABPM10ymllGskdlawUAJRZeHUIXB1M8EA+V/gj0Fyi5afFFDEl2PVfRLAsM
	Stq0cg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw93um6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 14:27:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30ed53abff8so2155534eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782829674; x=1783434474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sZPoDywCNwFTIMKzJKOShHepkzGRvIYESnrp+JhqWPI=;
        b=WFTMIDzlLjWgIFoWGq/GXwfs0nDYRlWrIthQftNlkXZIOk/TGXnjC7JSL3ZUk1XvuU
         PgwsqvegTaCAUZCvR+JEXhEOCiKO1/a8Ycx4H2FnRTQPLIw3PuHOmYNU4Xcwyu2VKOmN
         J9wWnZgjU/UCBI8ZYVWNis+6ru/rM95aGM93uOv1k1RkdB8d49B/pPWEQB0OYfvri943
         ZhUYoYup5fsV5cKPnU/2toN+3OwrBpvAfODToUk1arbQs5PINKnF1YmQfxQ5v09GhHfZ
         kcYVyq25mMZlabG5NixYbzVDj+fI22h7TQxVGXD4buoibQahm9IKEaSLWX2MiZt7kcvC
         +74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782829674; x=1783434474;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZPoDywCNwFTIMKzJKOShHepkzGRvIYESnrp+JhqWPI=;
        b=eoNz0tVcWLHssO+6QRLP0wojUoJtZk99Otmz1s9ympRqmZZAu9bSBaOy9qtbDxhLYL
         GK/SEu2O4DlF9d/7UHLnCMwjMiXB2Vbou5gu48jlR8gqh4RKMnZn269RZ8dNlvgxh3tY
         LiPkENd+32JU07GbKBdMau0gepR6Frtqq/d9L9C9gAXY48guRKNU3WpqgoxVFnPlfR+G
         t1zfSH4it7bYAbq3s/IsiZ+Yti0VriFMGt6fTh6xLlYQvtrcP7to+ccEtJJSuj6JZON3
         KJ39XjI+gP+2t+KtxR0gzWBnYsXL9HN4j1E2cWJQnZjdWqrJjuEvK9Kgf1SwO0nWq22p
         h65A==
X-Forwarded-Encrypted: i=1; AHgh+RqhhTVDXo+OTgP42Ia6kdJginVKq5Z95iUm535Lv+Gl39PXYGvjLkY0twdrjPBK45M+8BEXXre9/BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCvCMJEeJNCG6Q7A4GhGQnOwHAGJuP7//X1p+G7MvCzXSu/ID
	vCT89ejMDinOTHA8yjceZFeSGi1zOi3so5TbdJqYgDnEafZ3Ip85VTvEpHflOHy9LcHiibOfaeo
	7NAOU99J76ApV6tgc8D/T7Q4W7TnlBcC2mGMVRQH2xQiv/afjZ1AoUiYiVNQ0vRs=
X-Gm-Gg: AfdE7ckdZQdXz0ceAZ5wg1eynKj040ipbkdsAMk7mWtsZ87CXkpT3CmVLhlqn8fM75W
	n5ZhDZxz7ZNe24eZ13KTny9doPzDU/E3wlrnbBT/43Yc+zJB/J4wf0VYRM1hYGsJDxiMyLnzX63
	7tkF9gR5RxJz42GFt/TX3qDCr9dZ0M+fcR2PyI+VhMNQEJHRwS7i4soapbZ2x8S/VOoxwkFzYvw
	uhYcanjL3zPij9dwN9FK6Xpp5UP5lzZY1Z9FSfwOWLEnj4HT+EdNfx9xBjBtp1vCYehr+7nGsBZ
	W5TRv9pGkcQiYnOlm6dfZus0Ghwx9tJ/JMbsaiXii3+b5LiP/c5xvr+qVu2YPE6kqr0ouAOkB0E
	nXWQYq9i7z2KPBllwzHugPVg1CbbR1w==
X-Received: by 2002:a05:7300:50a:b0:30e:d8ae:3077 with SMTP id 5a478bee46e88-30ee10177edmr2858171eec.0.1782829673993;
        Tue, 30 Jun 2026 07:27:53 -0700 (PDT)
X-Received: by 2002:a05:7300:50a:b0:30e:d8ae:3077 with SMTP id 5a478bee46e88-30ee10177edmr2858091eec.0.1782829672762;
        Tue, 30 Jun 2026 07:27:52 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3170ef9sm13992508eec.16.2026.06.30.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:27:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg+renesas@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/4] Add PCIe support for RZ/V2H(P) SoC
Message-Id: <178282966564.295664.9943371162356556784.b4-ty@b4>
Date: Tue, 30 Jun 2026 16:27:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNiBTYWx0ZWRfX78W1+XtvQxE9
 S/UK3AKcX6Y6rYOT5FCGG7VqfDxtX/bjJvCK48SyenwjxRehA8X7O5J/Zu97BKE6J5+ATrlNpgX
 yyGEiRS0QhigmZWtLZTOFr9kj0n8YzY=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43d26b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=yC-0_ovQAAAA:8 a=7o43ttlTypSgoYAFp-oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 0LlZ3GGZv-5hvzuV1-NT-K0x6iRVshFh
X-Proofpoint-ORIG-GUID: 0LlZ3GGZv-5hvzuV1-NT-K0x6iRVshFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNiBTYWx0ZWRfX1F4KRXT1xTK6
 aI/ROXmRboGJUnsvJJnS7SamPYYswRPdPEnHwJ4gFKaVJnwg8SOa01MfZyPwDx/kXJK0LetF1ad
 C3mcqzAyNzMCP5CrLOpGbiKLiVfZonHrzozZNcrYhIHzabHwxd0S4XLqMWWKSbrWBwFvYk21rJT
 qO3LKcmHcOGv4Xa/VMtC139vcRhQnZ8ZwuezfUhxqK3BaUK4hQpUxSdo46xA+UBdE4ZPfULRcz1
 +zHBnaI9EUedgNoZY8U/Tt1FtN1o/D8A1a0CRWqyojDmvk/bAoesMfjKA/UoNM5SEcMpIqO5Egh
 SDyoCPt8iiRTSmtt/1uSRhCqCIvamDxcYH1WZkQS1nh6OofhIDMXHM1cU9tpAHCOD+8gmah/YxK
 QBM1Tsqe+uNeTTy458l2QXuM5F/4Rnftl+AK/RL+xD3zv9zXnyq/5is1+jOirvB3QYtawhrIki6
 UuGUTyi5OFimPZGBgdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300136


On Mon, 29 Jun 2026 23:09:28 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This series adds support for the PCIe host controllers found on the
> Renesas RZ/V2H(P) SoCs. The RZ/V2H(P) controller includes additional
> features for PCIe lane control and supports multilink operation with
> two independent controllers.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
      commit: a61588a75d923c5935180e746bfe5f32d7467c5f
[2/4] PCI: rzg3s-host: Use shared reset controls for power domain resets
      commit: e2260454946d4624d4e0f8b55378398c7c6ebf55
[3/4] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
      commit: 9f2ed7c3de5dc4ccd223784d8ad80909a7bae884
[4/4] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
      commit: 007c7304d80f1462b98a36284f45adcc1eb8adec

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


