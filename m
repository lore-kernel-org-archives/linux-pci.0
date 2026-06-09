Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF333B19AE
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023834; cv=none; b=hdGwnyVWLRHkO+v3C0/4vAbZuTL/JJXDgc7B0fwK11jlvSizvAaImEhnxoEmhvFWxyeAbNLn2Dgq/aPmvr1ECkeyQqliNwzGQ8DOkCLbwr5UI1nl+3be15h7eVTQnvF7BnXx+N3KufRRjO+xn1tw4Tsw+T6NhQD3Mw3Kd5AmUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023834; c=relaxed/simple;
	bh=m5K55rZTH6dKovu1gmAY39GkI5KStW8T7WINe/+PX7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FFRwSOLYlN9I2tz4XxJlDFduXb7PEN2VNa6cxPcO9EYwoEtFGRmJPqlG5up1tYCroUcGycehlOjXmYDFIqyJJiouNfkWf60yyt+4Q5eYgQZkHRxZ5dbIOkvs+V8R1Lk9P3shGSkm/T9nGlUDTHZqOpO74dXyaNu8cB/ILQQ000k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OpWHOwpr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBOzTHhB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpWHOwpr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBOzTHhB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GOWEI2746154
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=; b=OpWHOwprrxOj/oee
	8Qtn8B4DU1eBMJYuAEIiW7HH1wyUIRFdyOaNO/gikX2O72Pa7EjGWJ/2uQKy0OF3
	+NbwjZMvptK04gRgGNXa5YvQKBfHdi/cufxLt5yn/8MvjA9M6ij1tckjo/k9Ljn0
	qylcGNBetW6FOErjXMEfz8XrPOJUsdoXvHLocUKd5Yp3NtRHnZ2JRVfZFhXg/0kr
	pE/YihJ6NVN9v9oP79Vp5dMJPreioHYv/4RYSvIKQ2binsYtzbSBNtd01A8lKaF2
	xXVIrzm80qFNEhqn2QAxjYHVpDWVydRF3FZdHnCVRzCxRx6HXxHKJYUmp8U18dgh
	AhhwIQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wj5tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:50:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85dcdbe502so3804762a12.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781023832; x=1781628632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=;
        b=LBOzTHhB7FCPqo0S99nunZglSY+Zfqh2ML2GSZXfDG0Hw6zefZWpZyJ4iotjS7yL2n
         kB4NMnwlJKFgJYlIYFTIq/NP7uGYjtyb2x3drVFt+diu9c78Rpw0pdLqATIKfRP7h6Vk
         vdS+v8SkXFXHHKUjWTft/0rXvgBRKAqNxnq9eN9KdXB39I5s6yeN02Hp+iKDKOa+tcJH
         dGYjQXclSkn1vnpZqkkFKc9TwupkqFaU/H1XpKSmgqqHff9LhCZFO0WmmGI2TF8px7rl
         HVZMveC2PeJsV1wA1qcDPBu78mOVuTFNFuDXY+MHDtUU9I9jufWYfXL/sobqQRPN+L9o
         RaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023832; x=1781628632;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4APQVPv5UexJleRwUKeTyD/FNVUJhVermq4vMsM+NpE=;
        b=SWEM54fPvWoUB+NAmhQSR1I1zA496whuRP5lQ59iY1d8nP+cfJ8fC2BDGBJN720V2B
         V2XSIon/Awxdkuj2Yp7Z3nG13mxy/FFC9f/0uSYYPKEtPWP0obbm3jJvcFJ6y+V9sDXt
         4QFl5ESiPhqyq+0rYm5J4/TrFlYszEdbnv8f9HM3lNtf/rm+jAGgsc4QgnrjeAfM6/GQ
         lc8AtTpbSpJPFJ4r5/S+KuSQWwvkvNkNcYFb5XEfaEgoUpELlNg8/4UjTTSsyNNzVDgj
         BYf6KBuhLjTOJ7KL/2B9WPtL9xMunQBi/r8myYs+79Ir3gUjVQw3MkzP0j+2WHVui6hl
         Kf9w==
X-Forwarded-Encrypted: i=1; AFNElJ9m8y2FeGWeP/D7/3ZSZCIQFkykFQ7z855OqgueVyN3Aa9xYQAWUYrfnhpOwRaI5KbvjDAOLBEciYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ZBe6KkbQucn80aCu0s3I5LUX+p3yUSVE07vj3AomdZQJMH59
	lVM20m16wBo/CiSzDfFzD2W/ZY3zxWAYl6rtw3tPWw2BsHxfJgNNJQq5rkoEWTxyTWhDUQyvjhd
	si/KMETJtRYWXopOoButzVs75tRwxlC+DrMGiv8D0HSWjY100/WmsJZ0lF9BWHrk=
X-Gm-Gg: Acq92OGRC2zZjj88ZgWEm6D5NTTJLPPANOTWOvkojM3EPc/183mgo7/VGJlmr98gW6o
	GqlmqWG8gKoCzIZ4Bb31vqtYxASDEv79l57fyG+okR6HtZyDlg8DG4WobnlfvFlkvJaTUz7W0JX
	gmTDNDpt/YCgyhmn+729Oq4BOAaErXkqyC9B0x5uiNRK/2YWuBV7ZJ7iSB1ATWp0zDmkSvMJsK3
	m4LQWEzLy6cB9HeyBX/263ofd79xGUNxgig0a2r6vHkGMUNPiZKLw1oqVrdlHoYXzGM3TEFHuWq
	huOg2Y2QMTa3y4UklTaX9QeKm/7unLThUzUVVZhcEHvpSosQywiyjELaVLGKe9CyRYyr7ibTGqE
	JYkzK7LPqUEsFuZjS7MI8eQhz0q/qFNw=
X-Received: by 2002:a05:6a00:1ad1:b0:842:4387:34c0 with SMTP id d2e1a72fcca58-842b0f1e8abmr22235198b3a.5.1781023831661;
        Tue, 09 Jun 2026 09:50:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ad1:b0:842:4387:34c0 with SMTP id d2e1a72fcca58-842b0f1e8abmr22235170b3a.5.1781023831127;
        Tue, 09 Jun 2026 09:50:31 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm21310593b3a.33.2026.06.09.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:50:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20260521174617.17692-1-mani@kernel.org>
References: <20260521174617.17692-1-mani@kernel.org>
Subject: Re: [PATCH v2] PCI: mediatek: Fix IRQ domain leak when port fails
 to enable
Message-Id: <178102382633.15301.10190757934266235538.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 22:20:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1OSBTYWx0ZWRfX1HIQlgtj/Y2w
 X2WnohULVfj6RMGl2j6P4576xHkDeUFiO0wS9AxyF0c+dojcdjD5BOJHO4sDQfuPJtEb0ESnuPL
 wP2Lu0+5eIjdUkNjqwJe98hYMjpjlJ9h1FfPLII8OcUcOhrxa52qz1BJXcm90Qq9X+CS7/t7J6i
 jJ0lUFaS54ndUPa8botIJyqHdtyAI+YckSBu4i76yqyw9BsqPOCSPiZgteBSeqgHOLmZIqhpM5B
 YeRCq1fVxq2HnL4wmv3AN+yrF7ug9muv/21fmkmAMAJfOr533YvBs4d3A/MDmb+vaTlvMyCGGfc
 XwzBZrbrehysmrXF/dLuz05qfUWFS6GqZBTKEnJbvyiw4Lkx3AxDCx9Ilb68o0WV2EjrlP1a9OF
 vbdXZ3HQz7qRm3TagzHg0+oZHb5pTe7GxCCamkZs/9EwrbeDrcd4VhVPlmT0daaRnA5JVbc5Erj
 JHVdnYfQYmyoFkgR2/w==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a284458 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=mJkhQync_lts4CGhekwA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: O0NChzYwst5QkgL56RgOmQkRVz57KKoU
X-Proofpoint-ORIG-GUID: O0NChzYwst5QkgL56RgOmQkRVz57KKoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090159


On Thu, 21 May 2026 23:16:17 +0530, Manivannan Sadhasivam wrote:
> When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
> from pcie->ports and frees the port structure. However, the IRQ domains set
> up earlier by mtk_pcie_init_irq_domain() are never freed.
> 
> Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
> mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
> mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
> the probe error path (during resume, child devices may have active MSI
> mappings and the NOIRQ context prohibits sleeping locks),
> mtk_pcie_enable_port() is changed to return an error code so callers can
> distinguish the two paths and act accordingly.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek: Fix IRQ domain leak when port fails to enable
      commit: f865a57896bd92d7662eb2818d8f48872e2cbbc7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

