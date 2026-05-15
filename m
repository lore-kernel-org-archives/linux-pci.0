Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6814CA27C
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863960; cv=none; b=sEaICmoZouzPTtv8FNpowy6z9f9rUTBKV9yZ5HRelaJIgL3U/jW8z19pY5HPGzIpq+nIzkdN7ueWTTrYoCoO3cJHToT+0dZmZu90IQrzWF8XKxl5RIh2R/+vdkrqHm+7+m9O4VMQdngYk5VIe6LLvZ0JlssZW6Koat2ZXWOIJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863960; c=relaxed/simple;
	bh=NJ6I8L6LZxyBY3lg88p1B7EVw6E27enAgwAu6REGeZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eIAG74EMs+niqqUHCN0yFjOhQ5fPflGB2W4y/bQDzi3WG4QNiCt0FsfwSzUHj5R98aKyDTIJl75mnIhRYhcQhVO/aYYENIyTuPp3Cc2sn0p7n9r4Cw2Jz9+lKAk9gOrpSKqWajolEibvmFaxsKvmXgGWqj2X2HnmaTACpl8uAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsRXQNpB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ES359tD/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsRXQNpB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ES359tD/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FGkwNO1354067
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rsUoG2d+Qp84bfDMp0bD+LvUDZuYlTNNuzwOO51dR4=; b=lsRXQNpBscCIpbWq
	NMSuzymKHlX/V4Y9ywxIx0UXG82C4NSFgwXcFrfO80ehwu7UplxEW3harOL1XVQM
	zgnbZGGtlzGH8fMXcg/7rxgeZO6bTVTWa1N+BNyNNw8yan7ir9YRyAqByS70XRVz
	bwe+1L6qsjrNuRIUDJfjfp5rT6jO+KEjK5G95MN1Gl7sTEdAsUpmZcpfcRSVrsT2
	mdFKeSyw/mtm1cTb+J7qCOwURlVO4BaMA2b67X8mWWQSsEVhfn715VrwLWcz9vUb
	uwJHFXHBgdh0a6yUmO9GlMq9naz4HT9i2BW28n87n4b6SVGSakD4iqJYDA5UC1Cc
	8IkJ8w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ac80h6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 16:52:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4678c6171so629495ad.1
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778863958; x=1779468758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rsUoG2d+Qp84bfDMp0bD+LvUDZuYlTNNuzwOO51dR4=;
        b=ES359tD/qqcZejrXAdE9T7JYCiV63BWwWq7Jv/39dk6v/927M5sSikqICzenJKi/16
         obZLLYx0T6NX1oiY2/yLaD242amg9Q+phCrg+ZXQC9gQjd8DxUNpCw++lB2nZ0RZ3s+m
         w2jQbjt+oi5N7wMShmDyCN2Dd633mXOqHkHoGh2+IgYXuw5T10Yv3qUHym6OZjwo73CQ
         Wv0jSkJhKHycgNgcaXOrA7VgZY8F/LMYKkTkMB+aoIU52VhaKnb3QKhFJoL7cpzs95qd
         TVCHbvc2cVdWm59vZ0GZhMitKsCBGn0KWqGX5C5dsTCKDlhYGJr2ywjWWAVgycgv11Te
         zHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863958; x=1779468758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rsUoG2d+Qp84bfDMp0bD+LvUDZuYlTNNuzwOO51dR4=;
        b=qHwnkGaezmV2wdIimbkNJSG5ZnkbonS8op6dMGb+agfOEY77cPpnsw/5+p69PDphYW
         1hkBLQbhZVgXjYKbcwUCT7/YJkU5hJcz1eHbD50+ZHsvgBtlNDCcMI2rpgalFYYzH9vk
         4DUUZwuxD7js+9K+CX1FtXQ3Vy7ZRRaAezndE6Eofz8TSSTGpBOdZhHX53N6eVPq30/u
         idvFd7mnPUoetvx7sBZrkoT8agJenHHGVoTvovKjdMK/GEPt4LiLBKD3W0KfJjTUkGwq
         fRJ94zvOmNQ3UWg9tyDQQ3YLDf1ydpD5ubkAhCUKqqeCHYXqEcUngM1P6dkv8rEFzPMA
         oc9w==
X-Gm-Message-State: AOJu0Yz9YBbS2IMdq3A9Fah3Lu0I+9f8BAHxSEDYN0oZeH2luhzigQ0u
	T5tOtvkCV2/JoPmwAkyag3Gaa5T+Tt6+VCA+C5zjfiwdFfmgC/Z5ncPo2UCM1C5dJdOSzc6Gi5c
	LQx6J7ZXa8sAHqXrWV6Zyo9YBVO8oEasLopAb91ZOoiAJUc+pv4PAJ88wA0ZhV0k=
X-Gm-Gg: Acq92OFm0wwJjOGtDoDPSeUYq6PWNHI83+0aRC5hVja1EKLzJEqM04N7Hg2vqHemQgd
	SvMjQob1MJzl/3eW2GjO8V1SbTBnhf5XGGvPGMH/8yGteoNl8BGxfgbEa748iXqSx1hfHgWTf2R
	gfHEcJMdwvn5aWghtn8IKULE+dxlTG9XCRkH7lnxQybAtLy5cEwQnzczPl7vTmP46cePd2G8+Ea
	gHeUWS8QEpGlVGXJquqwh7V5SZ/xcwOpyyJtTTeQNIReyS1rYM0UuQHp5La8ehMN4+mYoIDYtyy
	hcZD3Fpd/CRRK+KrcK7qZzMpIv1l6cenIfoNJk4q7cLgaicVlbbcrF/mJnkwEiCfNHTFVEpKqb/
	2zsvtu6+s99upgoRoo8tnurdqqIwljkU=
X-Received: by 2002:a17:903:3b8e:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2bd7e8056e8mr53571845ad.15.1778863957698;
        Fri, 15 May 2026 09:52:37 -0700 (PDT)
X-Received: by 2002:a17:903:3b8e:b0:2b2:4b4e:e4d2 with SMTP id d9443c01a7336-2bd7e8056e8mr53571565ad.15.1778863957114;
        Fri, 15 May 2026 09:52:37 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49a4sm58330965ad.38.2026.05.15.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:52:36 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] PCI: qcom: Program T_POWER_ON value for L1.2
 exit timing
Message-Id: <177886395239.8489.6933092111755683572.b4-ty@kernel.org>
Date: Fri, 15 May 2026 22:22:32 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: W8B63-fliuoi5JAxAh4Q281O-DiIG4Qp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MSBTYWx0ZWRfXydcuXIeE/x5A
 Bae+vtLuIyVuUbGXB9HuBddYn4rSWxyekQK21QgRIJUNSGdjREmEaZjAX4B1VrHZEVIdDC1ot7H
 wymD4MhuFe9zXqyQhoemsYj//JxOqODIacCJLj+weuShaXTEy9C6rMPLv4fm1qmJz+t+KdUNGoU
 uTpsQG6Kx13bp8Hp5RB6jFb+Hcet9c0y0BpIBriJTWMhDc1YuO6KOv8swLbTjQD494oqY+AYUj1
 QSVDnmteimxGurk7GZOy5kCqpnk3gbZLb+NHMdSmc6j4Pwk0JmDXw0hghaiYVoaKQ+ZRMWoJb48
 5t0FoJ5/vcNUAK5IheVsvJnpIetG9GLYy6GTHvT9RNgwNOm0MYSuNlVOkl+7q9ZmcZoZ2VTqm1M
 /AOTvPUf7hyRO821gvN7kqCPi7ROPBf/G2eeE3ceS4vni7r27TBsKfbBIKlCMw1YL87Squt6FoG
 xnemxu4gUwHD8ZDDZ/w==
X-Authority-Analysis: v=2.4 cv=SuWgLvO0 c=1 sm=1 tr=0 ts=6a074f56 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=ktJZ1PKzIPGet9XSW-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: W8B63-fliuoi5JAxAh4Q281O-DiIG4Qp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150171


On Tue, 28 Apr 2026 14:07:14 +0530, Krishna Chaitanya Chundru wrote:
> The T_POWER_ON indicates the time (in μs) that a Port requires the port
> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
> asserted before actively driving the interface. This value is used by
> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
> 
> Currently, qcom root port exposes T_POWER_ON value of zero in the L1SS
> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
> which can result in improper L1.2 exit behavior and can trigger AER's.
> 
> [...]

Applied, thanks!

[1/3] PCI/ASPM: Add helper to encode L1SS T_POWER_ON fields
      commit: ea803322d3a8ec4ba60699a21b4ddc8fdbc0a242
[2/3] PCI: dwc: Add helper to Program T_POWER_ON
      commit: a66a25538564850a977ee3cfc795aa05ac4f1700
[3/3] PCI: qcom: Program T_POWER_ON
      commit: fca5f83fa339b357311ed250ec8041bbae11f66d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

