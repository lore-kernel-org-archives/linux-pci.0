Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D934A795
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584818; cv=none; b=VloZzfDwe0HM33wXJMVYfvIUBBgGW0tL7YcW6zfFF0qeEk8gxPip9BlsZKGL5OJBRLBPL3DoEfaTlGOfhiQ2iJHIwnAsGssr8AGNN/HdqkDgSvnb9vgkV8esNtIjhBYMA/STNRG8dh5RyYjAzbsB3HvublkFyLj9iwWAmMUziDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584818; c=relaxed/simple;
	bh=2p+lNICb9cWfaeqzZv2pgYPaDmTz4es/bzDHy35iR4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V0OpN+VFwuXm/6KAO7gPQLsQxKZfx24oQNq183nZQvUBya7dpyj7wgCIGiCXNgGOQuwvSVenAapRNP0kw/QrAujEe2bDHyRvYjJp6+x9yXPTUo5LtW3m5QO1aJeEI4lyJN35eW3NMvrVfamF9LY6BJF9YgUeu6r+h57Vk88q+/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmMXd897; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DnrVzCNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmMXd897";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DnrVzCNL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB28Yq2186598
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NJbIF9+SuZ3GL14xJaxGIOFdDBHJdVFEIgFFkSn2788=; b=gmMXd897x1jIorbf
	dUHWp6M/MMuyaT0uJJxCsKmpuLRhP3qjnFVafvpSsCILY13VJYzkwQC5KNuTeQnT
	akDeIAFXULAVeC3Nry9CsKT080tbZxEJoDPNgepxQRd3AxSZfKUQ4pXutor9iGog
	IDXF7oGDY/tCvWI5B6Kcy8c8cAFFNudwBQVa3b9qlx9r60qt+jiUM+DNG+JmteDz
	rMSKLrUI52HCUknO1TNsC6WWjNxcjUsTOCi6rqCbzO5AqWmt6ufqf9PaIQDgDGA/
	i4AufnT6xOY6zA4sWuB+1YVgrvqr7Joxz4LUwIAmkcDVlsef13ZNZds3vYVRAL3G
	iJfwfA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0tw5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:20:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c829366cf25so2109718a12.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778584816; x=1779189616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJbIF9+SuZ3GL14xJaxGIOFdDBHJdVFEIgFFkSn2788=;
        b=DnrVzCNLcr6jyU5+0wXV7g0NoGM1aPd25GaqIeCUCehKXhO0afQhmwkZ3RDFC3Ieq1
         e8VYuRrVqTl2Eq5H1wjpRxmWAxyH05D0DYfrDdS+n4SoPrRA5oyrXDkFe46a/7+pYeYv
         PX6F0cIPSlAjQXZHZJeYCMdrCNg/mFYPcydgkbjbnxIKpEkK/0jTIUUUUxujrxV5H6Wh
         ybZgrw7ptWo6ErQ5QN/FnSg6+O7PyhZBAySy+Q3pnIuxlXQ5tlxIDqvjz0X89xoyV96v
         D4CHLzDvplmimWiQDFIIwC3SVC+eCpQbDTobQi098gCCQFLNvLvCa/exQPvGjgCMMcDB
         2GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584816; x=1779189616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJbIF9+SuZ3GL14xJaxGIOFdDBHJdVFEIgFFkSn2788=;
        b=jxbeFSQT3HMoOK4NmPueR+V/l1HospPTypH5mSa6WmyCQzuH0dnH7kTRm0xeBZppJI
         PL+mO9W88W+tXk9j5dHLihzS/63Ql6pzeEWGQi3rx3VJhR5moMiXz/GzmDdygou/0nit
         +ZeVE81PvsT0CznAUhMwRCk2hJX8vSkvALXmHpZ6OtYfXHR8m+tvzIhgXU1S4a913zon
         TgD6UTH+lhlJWs+9JNcXr3DcIpZ7XR5SBqKd32hmjnlDR0QJe2MwSXNWh9+dP4cOzq+u
         7GbawMZkQzI6oycRyPPPGjMBYLRKbmkAAUR9wu7uqcmZUcLfYTKjR+CxwVg1rhTrXs46
         M4ug==
X-Gm-Message-State: AOJu0YxNWjLMoCWSImrfWCpuirE2C0XzdsTCmvooBla4VHCc1zjXgU5y
	c0ntxkm7oyC46It+ToPcOCEpgjQOSyfA16X0KypEY7jNDccnFdq+4dWfPJdAq65SASGFqSd3Kue
	4IlzDuEgLcW6KYHA0NN2A4sNNpoFwJoaR6Jc7VwvFIjqhYLzP5uNC5+mfNT61z1Y=
X-Gm-Gg: Acq92OGMM+r/zVx/6w+yMSTYWYdmJgsNLSO7bBNVHPFm+pv9puOvYM8/TkDcuO32mBe
	knM3efbg/LbxYQh8jlFiLmee9KdBRWOJa05ROkB10knRz0l6PL7uvZTC7Hwh4wHWOsG/IeZ5KSj
	nThI82s2TA4Lqr+KQ5CySPPaeohIJ04v0Bo3+Ou7t9bZMkZFIwE0QjvZifFzNzNSzfs6tihZwf5
	SyxG6Ma7/qv78Egd7ljQc7R3X+VmSx3yFCdUNcKdmS967yUS3Q8LObeRLpxPYX9OCphX4IbKN+g
	OC/Q3ALiY6osYmEQt02gPvTu7FCsmLqOuBxlLBfFAj74nEpjNek2eAOY5wXc3z/6kZYc9Mo9uWB
	42dS5wC3Hqdwq/km0eKlD
X-Received: by 2002:a05:6a00:2e87:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-83a5c4be2eemr28652198b3a.21.1778584816301;
        Tue, 12 May 2026 04:20:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e87:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-83a5c4be2eemr28652147b3a.21.1778584815690;
        Tue, 12 May 2026 04:20:15 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965b333f2sm28587654b3a.20.2026.05.12.04.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:20:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jian Yang <jian.yang@mediatek.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chuanjia.liu@mediatek.com, yonglong.wu@mediatek.com
In-Reply-To: <20260413071401.1151-1-jian.yang@mediatek.com>
References: <20260413071401.1151-1-jian.yang@mediatek.com>
Subject: Re: [PATCH 0/2] PCI: mediatek-gen3: Fix the control timing of
 PERST#
Message-Id: <177858481069.17084.1434409769087889023.b4-ty@b4>
Date: Tue, 12 May 2026 16:50:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDExNyBTYWx0ZWRfX7j0BsYlk1yem
 LXBdhm7kyAoDv3jhGClyjuUjLYd6rSUPAvkxnlWwnIC12/84/YZ9fHfEJx2xVJi9AxCCZG29ozI
 QMSmtIX1TCAfIaPLKphVutr6lcxPxHN4iGLlmR6hG8/j0dFGvUdq6olpioePXoeGgD33Jm5c/2A
 qh5LojDa36eTdreFKmXSjwBf/Bf8IFcUHvsngBEMl52fcmrgoJuGb21Io+Ap1dSj3Xa/7LFzVj7
 dB8BeIkK8GgEEHwffa5LVVl5gcSyowSfUA73Ns692QtBaWEDFknSgy64qgwjZrFd0EtCY5irf4V
 qPhPjvfTBNEWRVXflb1aMkopRwfm91DBna6nTAcsgjGtL1ETZdgfxPhxhOMmfK1Z3zMtGVY+9zK
 a3qFhLr1P4XqB4bFjz/r5NeN5QOEbthDcfPs3ysfKcjIBBoLHRUKxhswKwP89Wc1DcdKAJapa3A
 XSWbLxiJNwGAZ+ZgjcQ==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a030cf1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=bPlxViFAvYB88tiJ6gEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: HL3IH7-LTgL3SHC3bVbxBSSUV5IcprhV
X-Proofpoint-ORIG-GUID: HL3IH7-LTgL3SHC3bVbxBSSUV5IcprhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120117


On Mon, 13 Apr 2026 15:13:54 +0800, Jian Yang wrote:
> The purpose of this patch series is to fix the PERST# control timing
> in the MediaTek PCIe Gen3 controller driver so that it complies with
> the PCIe CEM specification.
> 
> In the current MediaTek PCIe Gen3 controller driver, there are two
> issues with PERST# timing:
> 1. During the power-up phase (i.e., before PCIe link-up), on some
> MediaTek SoCs PERST# is de-asserted before the REFCLK becomes stable;
> 2. During system shutdown, PERST# is not asserted before power is
> removed.
> 
> [...]

Applied, thanks!

[1/2] PCI: mediatek-gen3: Fix PERST# control timing during system startup
      commit: bcc32882066156029e1e9ea16a3c3b8f3100cc3d
[2/2] PCI: mediatek-gen3: Add a shutdown callback to cotnrol PERST# signal
      commit: c019c3ad821ec38ee158cda4be5ab8e39d2d5c6b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

