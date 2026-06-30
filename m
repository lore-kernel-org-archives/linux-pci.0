Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968B45104C
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833949; cv=none; b=gCgSNq1T4LC3FvJeJ6+p4XwMdIj6ud4TxpEBsMIi06a++3Heb/UJXCn8y2H1rZsHLpQlOVJstqiVhzf+5D0M5lH6sWTLQssO7Hi5JqkD0f66RYSRtB7Q5bt9W5PUW8hW58lUqzm97iw7J07ot+dznGcojjY58Szyc5NoIThKEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833949; c=relaxed/simple;
	bh=OSbb7xN5YSikelytEh5wz4YfdTkKH7j3hgMOiOt73kw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mjb5jj+mnNImDhPXlP+hBD94AzzSSmge7iVPApsctkVgqaXbgMXdh0SP/RBbM3fDlJOPjpYAA0Arsb/rVyJA7zMr8dUyig6DDV9JU52q2IaqMsf0UocNSRDly027e3KpYGPzANaSewppMzVRgEsx1I2mUMUL9640JFgbxe7wLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RUrDQsll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POLxHsWC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RUrDQsll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POLxHsWC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDK5l2128880
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbxdBI328xfHBsRU0VHFqUdQ+8MHRSsYefbAul5Sc1U=; b=RUrDQsllXRYC+LYR
	WIy833EfD7V3NyKC3r6FmzjuFAWk6Xr1MN6crwbDiJJsjksc325S8VTUwy/rUy53
	yW5WfQaeedbK/5l2kBIQ4Cg0xSMVq8vWXpPdi5dQByCmSOD/7vA8310+x+snelYc
	qbs/JaBSHUB9SRTZLDqTrMEUwBbNvCzQCh2ubAjeotl319Rv3sqpq5fhzTQn/ctP
	N/gyk64FQW6fKPWAAt5PcN8CjW1U0vOHYhwTZty0FtK2kz9trtyl+rkwCpMA4uHg
	xQlM8ee7tSv++oGZzDKjGfGjXjeubEMN7r7XpPNGPXttYjzw43ofbqcH0KJrtrA5
	EGYL0g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw945sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:39:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30cb5001ed8so5004241eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782833946; x=1783438746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbxdBI328xfHBsRU0VHFqUdQ+8MHRSsYefbAul5Sc1U=;
        b=POLxHsWCVrLNNjHZCdcRw8onQfYKWAXimHnrmSTzdAgdj223XOsUL2wzK8c/acReWa
         BUyhdoxsnO8+WFGaVM9LuwSOFVyCMkRYVqd2Ewy/Iin0OGKGxcDwfB4YUPHzr5atJETx
         qQ4RUeTtF9mVc/SBYKCa7mRsotmSSmmr4sR0kgZ7NryDnhOrmk2sRfLIFGOSfRiAPgUd
         0YuoF4FtYqBZaB0q6o1EETFYk5iCnDdQdA2NJNdHv/eRlUqvIUzgi9ecobQJ0Jn9vO27
         YTJtRNQaBx088PHKMkkUJ140egN2b1M+l/kG2BGns0hvrRMCLmkFkqksNJaJVEM3Dx+n
         62hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833946; x=1783438746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbxdBI328xfHBsRU0VHFqUdQ+8MHRSsYefbAul5Sc1U=;
        b=OCxMt0NL19I3quv+THV1F4q4tNlaRcQrp6BHLOIFwRoR+qwfyicrc4BYuwjdop5PN0
         GUEeIZ4aJ19hEoV0Kq6T49B19u66l4KaleCUtUj46jTS9TinzA2sl/ltKXG+NYWGknaK
         0tikoV2BqJ6ASTRvlMBeB/GvFRK8lT3q9vs3yyViY7xqKTC2vXkMEFlVKitYU6PX+Dp/
         2Yxs39qhflS0POBux7/wcgv0cvIaQjGQDGBDQHhqSw+9/MQIYDLAEoXgRAfoCuxjdsSA
         rMjcDwEMNyf6C5PZIzD52AUWBDnR/OtTbW3UIBX6PZfVA4A1hVvE0XiihFR+eutBMbUE
         Mi1Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5UTcHJf1wyAWVNSJaWDHUyD7zsgcEw8Ht3vQsQ4crkt0BC1keekK2TL3YtdBk/FKM30hD7dQmfXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzNgISZ/eW7ajBvyP5uF5CaQ1TLnMUTIRGIyq1i9JlwjqDNsJ
	9k/El46wLFHSSzZW1f+welNGg96gmTSwlMTSxsqKo8uAy9awNdFE8eP7Nb0C1qTPWgTX0dkvjFU
	NUajCcJ+DUyX4l522s13FsT7tTj2pyVPWkAjzk0Wd1wFthCYRd7NMfLEH1f2iDss=
X-Gm-Gg: AfdE7cnE0iayobaveyYH8s3zzOPPN88ImrXLIhyQgUykmO/uRXhFdNJo4w1pjcwVY79
	9yeqQyRfPDcxFt1PtPXSfH3S7MnsQkNUviHIHtc23I+GUzGml5Jq51T2ra3TSwrECf8F5QZQOCX
	R/7I6UqL4ILYkj7IkV2Y2v9JJq5qMrljCV6FWiwzeWp/BleQJg/m7EjEVnoZUaBvdUrrvLDCB09
	QZBuKm+fTxjJCf4HQFycM/pr+K8O70zPJ6EKHjPnWbjusdEFFOm7zHa7TvySyRsgeIGEIb339sv
	JuQgnMfMSZ1jn1ngiIWTbf81uShMhb4grh3s25MvGjfjvs6yWRYd6cszIqkJs67QB/4eSRo7dyz
	c+1rQLHEEXTkuI5E8Xwm1I0y/02RRYA==
X-Received: by 2002:a05:7300:2151:b0:30b:ed93:5cdc with SMTP id 5a478bee46e88-30ef09e6c47mr732720eec.31.1782833945504;
        Tue, 30 Jun 2026 08:39:05 -0700 (PDT)
X-Received: by 2002:a05:7300:2151:b0:30b:ed93:5cdc with SMTP id 5a478bee46e88-30ef09e6c47mr732683eec.31.1782833944944;
        Tue, 30 Jun 2026 08:39:04 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5ed29sm10103096eec.1.2026.06.30.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:39:03 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
References: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] PCI: qcom: Add PCIe support for upcoming Hawi
 SoC
Message-Id: <178283393946.298268.1292819046120769296.b4-ty@b4>
Date: Tue, 30 Jun 2026 17:38:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE0NyBTYWx0ZWRfX4VEoXBVmFDHB
 X7hEi5I4eL/TrEEzCaTuZ2gLnaI1emYG5LH/2ZHWGdKtBAfgezU39qBlV2389Tou/RuwZ+iXUT6
 iSwcTVfXoyP5TfGIsFiYafEitFPqWX8=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43e31a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=WEtzvTudP8oR8f9B9VsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: djEAfJDj0BTBOOiI7Z7G2lOT_QgzSvXp
X-Proofpoint-ORIG-GUID: djEAfJDj0BTBOOiI7Z7G2lOT_QgzSvXp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE0NyBTYWx0ZWRfX4lWwbycz0Spq
 zHdq1Nu6aiDBqYpa09sNxc3tXQqZw3KQzixkUPXIPJyv6iRN2lS0oUB8MTIOFAZjJtupUKmnOyt
 l8Hd66N9IZoiFLTqPAbvskPfKw+oIww8tiNaQg5vQwRhwwFgYdOjc8fktvnTavPM6Z97vuvB4Rj
 oA9uKvrHrouZ0wOD3rzxa+BdHdbjnDW66y3Ykgd8iw3z7AWDNb/sHbpYG2u0QdhmrYT0yDs41S5
 gUlGsNh1lH7OBeK/lRvYG6uqsxn1cDOaakvsbjjn4IDAvkz1VEfwVJT9yXHURoN1w504Cy1DpmB
 jrbsgRrj3y95OA7IFPiShLsZ9ZI7iL/nVWnm//lBH5DmOMHJ97BsJa/KpJ9Jl9ty/E8nM0qapy5
 s0MyXTbR/67JGoYKVoa6bykrNirzqkAi3l2374S/Vzkx9LPRPwVtf9EMfiAQUYaFr6tPP3skq5g
 ev45LiBRYFGneE6MgJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300147


On Thu, 25 Jun 2026 20:38:57 +0000, Matthew Leung wrote:
> This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
> platform features two PCIe controllers: one capable of Gen3 x2 operation
> and one capable of Gen4 x1 operation. The first patch adds the device
> tree bindings documentation for the Hawi PCIe controller, and the second
> patch adds driver support by enabling the Hawi compatible string in the
> existing qcom PCIe driver.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe Controller
      commit: 6c3b60493693b7681bda206515a82cd3f99af543
[2/2] PCI: qcom: Add support for Hawi
      commit: 67db6fece5db59c5fd0d7c0a514eac5c7f37be8a

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


