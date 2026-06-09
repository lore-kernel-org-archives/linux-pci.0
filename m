Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338147F2F1
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023487; cv=none; b=OWJ/3Net5UWdb5JEPPX9kVUn1EgLEw/5oROXv6kIg9JI9dJOMzM5D0OJdUpifDsKdlbtjiK2puQmondDsjgZTGwx4z2d3Lyk2qK7+brlGgHe2FEacGxhsQBsFj7kJUwPcJ25iGE6noh2Ie2DGKfydRffIY9ix+yb9kKSxyAYit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023487; c=relaxed/simple;
	bh=oyC5sBnxB7lMPSD1kmVUARsAa59KUngbah9/j+wr6i8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eUMfh1WpO8JZvdfTkQeXdsVaWHNdTIoBK/EnEIqGJVvPCKB23x7amPffC6TOcjbJ4OBSsoqu0gqtm2XAqUpXVICmhu0CeD74zvdH/e2FiU0KVr9yGL6Kg+x7EDJeSKzAmrYrB++L0b9jmiVV3gNSwKpRYgXehM4c+nWVw+mSyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qs1uAAYi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHfTOgSw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qs1uAAYi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHfTOgSw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GOjU42750410
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xg4V4XVPFGl1sJFsiI9GpGRx0QGGgthYiJp8Gmdz5BE=; b=Qs1uAAYitqroo6oR
	MEex2tM+jfALsKMXl4umzN17elvz1uSM5FrlKwfR8IqOh6Ya4uxiZnSVO0tbq9Tr
	QK481/Xt0zZOHbucSbNwg/ACKwZBYUILxpCm3VtL189aNeTmat06ophQGOxKEXZa
	Gs80R+I8O+HI3tCavUrCrRhQbyEg0mUr7VR6xgOLejbs8/POqlMQyKY4OabUupcN
	qNXyFBkCCv4abVW2RcZbqDqfvjcGD1SbntKqVZSd2/ex/8+nFOxqSpbZJvyag/Dm
	2sUVmlNpVRh6pxgWa12soJ7jCMC74ByJzUr2QOJ13cAC9aX3KRyypDVgEChjNt+7
	dEO9eg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgjkxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:44:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85a2c129b3so2724151a12.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781023485; x=1781628285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg4V4XVPFGl1sJFsiI9GpGRx0QGGgthYiJp8Gmdz5BE=;
        b=MHfTOgSwCfKq+geXiqFNSisGk5SQaR+EWe3058ngnJdUYPPZjHXU4IywLaHsM9qGoh
         8MVBjM/0X8NqHMFrBh5ZaL73194hJ4eCMWKIJJlHtEG74ZvcU0eS0AHIsDZmnj1kLDsQ
         +SxOD28Cze1bSGzVTUVQd6rKXXXmn79ilvYpvX/5oJFn3fcBV+P0mEecXE9M2v2X7ttG
         vUTIHUQb4yJF4Ur1BbZ39un3FMeFOU0C1dKMRsHmEU6CBJl+KUMvUxut1nhQF1r4eSaw
         qq56FaFY3xkD8HC+ZrRAvJHhwdPV+uAkHWTauPGJl4GNjStBAWpHwjUS9NzmhyTEyn1i
         P7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023485; x=1781628285;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xg4V4XVPFGl1sJFsiI9GpGRx0QGGgthYiJp8Gmdz5BE=;
        b=NaKahnqK9vQVGubLaWhsb0XVB2BfXwxz1O8ZE128vu+S0I2kTOO2UPTqAc+24Q+VBR
         x9Ufm9z4uz8z6GXDqQhwRJsifrH+9IJx9LpkF71Wl3uXP1aKgn0zCoOhuUByzUYZcTpK
         OWKrXLD0zF9z89RMLova4w3GOw7NAeu5PD7QyM7J+e9yRupmBMlGJsJk2qRJM5051GTk
         lY0xr8WJCPdbkZNgJqtOIA+zL0J/Falfgw4y7aGiAKdNieIrUD8qckVCpWzTKaFZ4qJ7
         mKgKKH/7x9w+engl9AvCzlBClj8SL7+7Voqo4rlT46DHd8XArGnguA9BEyt5PNH7nwuj
         iDug==
X-Forwarded-Encrypted: i=1; AFNElJ9kvMSARoFCACXOlUUO8DigHVnemtNWVVFilfbNWe5F8Jpdq+5BQvJF5npu+R73oyjK5eyaSRKbqnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4DTcWIO/mXkNuR+c6g/M+gPQYCK4R78ozZ4hsYO+1ua3l7k9
	QS6V+oh7Leq4evke3RhUzOT4HtB90GYwfcdyCVWrvN+P63fnQu2tHLwJFKzv6XcFdCA4PTEeAON
	p47YO9XPg6R0gIGvrvxzMbPfInFX2Im2KTP4qwfjdHeMaYPQCGD9Lzg0yM3UAgPU=
X-Gm-Gg: Acq92OHbVs12KLJz7v/6KBNKAK5VSwOgQ/o4adxON9MoOv9KSoQs5E+h42a5oP2K8Tm
	Pp/0wkCFPWUtJg7OFf6QyF4XpCFBkEgrk0USlGURL4+io6gWzsUnk+nzmZtSu3XZZS9DMVBvFXI
	16/rFTingv30Egpbo4q2LakIrbR3PaGQx/lT9arECENFaB5Z6dl6QY6ImMlU1iWeUVy17/8IsuG
	1+RLI/Iq4AkgjiSJhf2miE1BcQG7MnER3de9T93P30mBe5sZmR3shDvR4x3Ov72hFJBHX6So7ga
	34iNcfBqUXI07xXDf36VdBRYHI3OvVrt70C/izK+wcRRK3rQ0BerusxfVQQikmhu0qW644/KBtW
	oiuP17v7vv/ASXKNPOlFI1N86MA3ACo8=
X-Received: by 2002:a05:6a20:d505:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b53bc604dcmr5305644637.14.1781023484742;
        Tue, 09 Jun 2026 09:44:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:d505:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b53bc604dcmr5305599637.14.1781023484241;
        Tue, 09 Jun 2026 09:44:44 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b374fsm18673938a12.25.2026.06.09.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:44:43 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Fan Ni <fan.ni@samsung.com>, Shradha Todi <shradha.t@samsung.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>
References: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>
Subject: Re: (subset) [PATCH 1/2] PCI: dwc: Guard RAS DES debugfs deinit
Message-Id: <178102347813.14565.586041970354711771.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 22:14:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1OSBTYWx0ZWRfX/2Q60hAe86JE
 j9yrHGapxfFDi2RTitvtcRo7S6HSjwlo96epKz9vPqkAWYi0s9BJUewvIEQG+oC+I9XHWDENWpG
 s81hxY570s02PYgxPwwBiuSMcq0fBHzrrSbQfLcwWsI5t6wJYwYEGQrroqv0dGY14wl4cKxwSMz
 mAHlm2aQVho+ZaJ/fQdXiE1DzsX/PkqySC3z7PGTR1irQWz+MKyLZSclJlYuPBAYU9V3JEG8tus
 QHuZ8GVFHD/NrDKty+wnqGqEpe2wXmtKFimFgA5h/kay5jGpfcTpjb+MXicaxv7kEq7L5Wq3eHw
 R/eJzVttaZIIGauPVuQ7Ko7fjb/8WAuUh7rFxFZu+qNUjnt8e9c7z05ZTT3BOapkYDz8c+v4eMd
 FAoaeUUtQCyfZqrRdclDK7ba+I0E5zFECXBTQp02X5VpOYtj5g3Oe7OucvnbET+d3POFccvtBRv
 lhrZHbP1SM25Om6Lltg==
X-Proofpoint-ORIG-GUID: 4x342VHIns5cmFtI9qrU3w6X5WYLIuLy
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a2842fd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=HaK6AIl19eK7yf7b4pgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 4x342VHIns5cmFtI9qrU3w6X5WYLIuLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090159


On Mon, 18 May 2026 22:44:17 +0545, Shuvam Pandey wrote:
> dwc_pcie_rasdes_debugfs_init() returns success when the controller has
> no RAS DES capability, leaving pci->debugfs->rasdes_info unset. The
> common debugfs teardown path still calls
> dwc_pcie_rasdes_debugfs_deinit(), which dereferences rasdes_info
> unconditionally.
> 
> Return early when no RAS DES state was allocated. In that case no RAS DES
> mutex was initialized, so there is nothing to destroy.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Guard RAS DES debugfs deinit
      commit: a5ee214bb36f43b4d8bb2615b30d3b5c0ea80826

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

