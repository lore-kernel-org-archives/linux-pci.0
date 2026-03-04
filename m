Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222C34D3A1
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606948; cv=none; b=CRFHdbIVTLrkAxVgvcfMV3izogZHaysW5jy4EuzCOS578kY5Iczc2FS8r5pAWLHxLAcgpnOElbNn8pybmUxAY5GcH+kJJ8Y/r5lEYQKO440x/6q0/V5AJi3f0d393ALzeP868n3c+M5DDomqkl7jWkFqmvPYYDmbZ9YxY+E3PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606948; c=relaxed/simple;
	bh=j8eK1n/GZ8gOtWa4gL8kbO199EmirwP1kIvdZTa8T/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H1FIkVewozluW4nIduR0biWN+MgYGvk8kFXZ3kVkvNjyBXaIvZNGNe40BcEsI1L0C7DMQTvfhDcRGXrCCVFs6Wo4ffcDT69VXnFfukVsKVWA7dvEL9F2jSulNZOXQU8GOhxwvK9bBef4eyFMku3pjXKys44Z2eFwUlt/MwQluPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XM1dsbht; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tj5uINLk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XM1dsbht";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tj5uINLk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQ1G945105
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 06:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mICino5nH4L36s9MqQ2N08OYmrnyuBSpHkGBIndzUbc=; b=XM1dsbhtVZQz3NdC
	zO87XJXxXvS0aLlPQwjRyYfm1KNnfKiCU3C6Ge++M033q2OtHEeZT31WV8e0DLQD
	IPS11eFCoWg7kUYFM63n8a1ucUmasFgXfYlSx/UYSRIMGcsNw2SHNJl5szWEgYVk
	sapuv8Xn7YP22CB9otpwgMkqBKc3tdgIKexEx6Jwb+aIEJNObe7sTr20aTqeL/l/
	SeDgC/TNmNSamrurdWk6t9dfln2bZvDf89EVToGJ0ZTJkwyyM5wJXWpn/lp1Priw
	YAe2kaQzyKmE8o4cvmPMvsASrRZ54TL61RIlZWOwAx33ENgoa9u8ae5PRg5CMs9b
	PajDGw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxfbwns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 06:49:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c629a3276e9so25106243a12.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 22:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772606945; x=1773211745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mICino5nH4L36s9MqQ2N08OYmrnyuBSpHkGBIndzUbc=;
        b=Tj5uINLkjwqvGsDmWvtZDdb0Cv9zOXtIUnAVN4D2n5VoMMskB06sSYIrC6qmvBPwZr
         T/hLBuqkLJtSqPUZCjkc+n81MycVOmMq2PIOv+jh44yc9vZrKBkN+Scboah0pBJF3eKl
         QNWe0fX1MmA2mrsso9LBI5TYZwExmttexTSgpYwlY6rqd3jgPiUOt+BEVpSq1ycwDhXk
         Z5qZBxQgzX1gDjDSOpGU5S5RTHIT7bUH61dz4eCwnPiXzHAasVXb/LRTFBgDd1u/X1XG
         5vb6l8gmf6Je/rD5UrifraC3Jz2roR4A8c8XXs4vG9taVEOOFq2NcVKTbPbMSnGkpsgc
         65DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606945; x=1773211745;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mICino5nH4L36s9MqQ2N08OYmrnyuBSpHkGBIndzUbc=;
        b=CJW5S2oNH0uzI3yBrrrzVxYcj2KLLIPV4aGc0j4ot0M/bgHe1k/zsO/TV0iYze5r+D
         pyVHECs6xk7EID7xo7gvpHSJVlP/lzpdTt7dWRoDopQkVN12F7c9l5fF9K0yIjLv/2Lw
         GSEmzWeDcew8iOa4TezzuEGECMUXf2DaoKaXJEY1Ce9pYam8nNpzpNnylNjKecjtiRWf
         g306L70eYt9JB+qxdoU7Ks2pHLi/+RpyyvhJIjVVx5vzuSZfinzGD57BgUT3PMiMZi39
         jEoZppL65o9qK9egTQjKX3rPv7zARL9IcJrovSJ3NbdWUQ0j+l29OaKZRcVzO5MTtZFu
         ZJfw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZxJe3ulqRJpfz9ADzSw6EMagtTZaQPkSfB/KL1mBcpBcrXLKm5arZ0eHwtS0vo0Ps9pXR6lGWfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtndqDHz4Ar61qmzsMd2LqPXUE+0V5ghccKPIpJXS1XXjkVUH
	10aDWuYTEGQ9jMsEfIl3qDWdgXJNFBd2RC9gZJkvm/mT0FMJ/rVNBTOLpoVSW3cLdfIHnAhogPH
	AOKu0laontv6QGqNrp6lJV3RRCTVDFoF0exOAetneqD0GP/48x7LqfZfo/gv7o08=
X-Gm-Gg: ATEYQzxpERqoh/hqw0KcrVjRJ72/HGBV68rp6ogEbkzeT431wtEG+dnp6d+1u0TymMS
	wB59O4PIChD8KZPq1gHD3MxtVumSCrZfdckp7XzSYlN0y1ZKGxXiKzV++uA7zQd47iMS6KrhIXx
	MWw1XZM+FnGlbn8ZpoNEY4K8tkZqibVpm7+p9D017O6FtiLaEOK5r3DAfdPnMljee0KTYuMn1EV
	OGwWobOMoCHDItwkkjF2RhXdQOw/0o54KtuEAbZyPqY3w/zqytHJnyZLyG3OvlYMrtDhbeUGkeR
	uCcelmtupFQjkT3BYSSUPp6cmdDPkySA3vxADIh5yc12koF4M+1XzIJ1ertbx5mF6zkaosglft9
	HbjHoNAgTUFyyty3W0UPkkw==
X-Received: by 2002:a05:6a00:138c:b0:827:32ea:5307 with SMTP id d2e1a72fcca58-8297290ec8fmr1047524b3a.3.1772606945568;
        Tue, 03 Mar 2026 22:49:05 -0800 (PST)
X-Received: by 2002:a05:6a00:138c:b0:827:32ea:5307 with SMTP id d2e1a72fcca58-8297290ec8fmr1047501b3a.3.1772606945084;
        Tue, 03 Mar 2026 22:49:05 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:6548:57ab:a3a:47f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739dabd43sm21015522b3a.25.2026.03.03.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:49:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>,
        Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Cc: Grimmauld <grimmauld@grimmauld.de>
In-Reply-To: <20260226101032.1042-1-linux.amoon@gmail.com>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-Id: <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 12:18:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1MyBTYWx0ZWRfXyTCTf7f2sHCT
 x/zgXzaOJByNhCQBbov8oAvx5cqFMX0Flcx1Iv2IBitnfSgyLgGGtSpi3DSHqgnxEHoQAtBqb1p
 juIhqeHLe6ttYcYQ5lAmKvigoErd8SDl4Scus02fcsMkFtbk2V197sdpkxfhqhIu+uxpQ7U4/yP
 QTKVoX/bEAu/gyyqfBDJBamRTtsCgrej3pUgJ9z5x0PyQYA8Y7jyZxJQ2ky58ri3rU9F6IbTYaP
 aZjCps+OId8UEm+38qMN23YrNd11neUbM73gdLUfLtbMJGSiQ2Bk3uhFlBKZGBxf4p0RhoLNyy/
 fGTsI76JG5oIw9052VD6KlR4gNeTx4oYH0FhGPqyxKzl6PW/TqRLfxdyf3EdVQ2uCiJ/MizA+Gk
 2qSjZJ3cnWHb5P/SoNMk3ic82EgxtqMyGpSJbjf+CCoOv6Ujv6qvEzbNWcP3sH4n+uUj28CPwdq
 VlhBRJggZZbWjaYAVfA==
X-Proofpoint-ORIG-GUID: 560hNnwTRhDtmpQrQoFagvvIiAjSnF_q
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a7d5e2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=SMwnmUEIIvgHDjHqlWcA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 560hNnwTRhDtmpQrQoFagvvIiAjSnF_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040053


On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
> Rockchip DWC PCIe driver currently performs synchronous link training for
> combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> the link to be fully established, adding several milliseconds to the boot
> sequence. To optimize boot time, this change enables asynchronous probing,
> allowing link establishment to proceed in the background while the kernel
> continues probing other devices.
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Enable async probe by default
      commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

