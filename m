Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0519DF4F
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882545; cv=none; b=WJpRuy0BW192c83OebcPgYzWw+DfFiSlWQrKj+Saz+uHoYG6JOafnWFbNsNRIT0mw9AiIi+9ABsN9UFYEqYXt3wxJKFkUwpSmA5oX/6gBlU0E/A8nsGv47fR+JlyPDwV5gAFHJds1/oDOn7riApQUTX6VfRgWQ73SP6B60ndirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882545; c=relaxed/simple;
	bh=b5bS/XUZQqxfbtxJ0nwEBPprnZ0wRRmwWRoZ9SFI4UQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JrJqKCfmms1ab+y+ey43Cs2yqxPyvtLNIsxtGUNLc9v8JzLr+28QQFJUdk7+9+K1nykgOGn5qRu0p7umRN+4YHmt4gwg0Sp5DawaYHyDmwQ8JPiwiMIbqdmjbk9Z6WrHSyrCIieyvCLiemkfRVucNZ/YFO+H9fZeOs6oQVxlUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YNsoFjKW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzS8CZlq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNsoFjKW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzS8CZlq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tS1r3837141
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 05:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FVVOQL/lgmh0sWaPzQjFGlDDDqCURU093IoiySwnHEQ=; b=YNsoFjKWulKP/H1R
	Sq1lqLOAZ/Cj658Tv3eBbS2qTvNtiw7iwtvBoD6u3YMWyLGGniS++Ta+J1r3FelA
	cUXAAvoeqfkfDvbLzTyB3rI1FKiu6oLI5P2ONxiU4U+Qeu2rkfmdpsWJx4lloaJO
	kzoEj5HbBxyiL1a+1PCvvpOF0XA+JxG0l5xHqoCUL5izCIZX77k5tFL/Z5dD4dre
	i0TShRdp8iODJhulH5PayYCpyPfv4PJZiepaZ4Yfc4BZJgqVrkXg2cvqQzmyBu0C
	YvajW+pKjLCQrPQ2uykQDgTCj6NN87OmDq3E5BjGUdrJ72mi4JebfwS++YIFKHCE
	UhfMdw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd2sqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 05:09:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ed664e368so293700eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782882543; x=1783487343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVVOQL/lgmh0sWaPzQjFGlDDDqCURU093IoiySwnHEQ=;
        b=TzS8CZlqWdukBTWPNbDRPY2nTJhQG2tGWNKG+BkbZckhjxTu7BVyTPT4ezLd31XUYM
         3p5PnMc5Lj5U1D3Kmutm1QLKPSKX7jVQk8ov07mqz83lKFIjEqzAc9+bdcpMiOQLwZY/
         Gw5qzEVgbDBCH8aMycQibCYZELipEL0Y9TxPu0PxBZFl8HGTFDJETi374MarkZXppeGB
         S0LZQf03gXTvrj4jhmXlIRpZWiE2Db33LedShY/drcDW3wndWVpb7xQyo12+BYjEUOAM
         3/42g8dxHaTyinRxbwgYcawrfWdInXxBl4WFKe7xW4kFjp+Kl7LCZkKMnAB/KUhkSLAn
         w5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782882543; x=1783487343;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVVOQL/lgmh0sWaPzQjFGlDDDqCURU093IoiySwnHEQ=;
        b=d0oqSCw5fDCV1jYtEbpeqa9IZFC4rG4QAHy74jhHZRPkyysRCh09Cip+SfNRWjW31J
         9m2bHNoXMyAe/uDcCzMrtX4CVlL+Lndj3jDgiUmohSSFTFGHjTBn5wuS9L15GqjOgOnl
         5tUliTpYu8H1ZX3Ps/iyIJxPKjpatQB67zg0JNtAZjOW6Jh9uBk5Vo60kbpPlZRz6276
         AfFvpUvcreNDhHlLkkTGPNbYLIyX4RcL7TQlEHPeJ8MfCb5mAaOkWPq9Ki7J4Hl0n39f
         gLYhuPj9iKkHXjvzv7X5wT+xk3Z7Y5xBByhWibeVozE6mizBnI2iP9lAvFxMI9KK7pKE
         MV+g==
X-Forwarded-Encrypted: i=1; AHgh+RrDLiJ2ayIGYegmOU1S02DaJ83Xg5ivCEkAt4I2yBAX8SKRN5yr/tel7/o7zfW4Wim9/gLSgXz08u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlAMKAQPceHonc6DgKUmnBH7Vh0F7AYtclRanwId8UdWkOY5/
	fO5ly2OjFEWuK4YZnq7ztnXP35AN2zM/cbKbUAb8EfkJd6xLxwocbrqjz5wFnXGma09mkbZ+fk6
	MsnOobnRfo80wbdoqpU00RqviiTRKV6vIYRVPKLhSrkybaaRKLPpKHrM1m59i2jg=
X-Gm-Gg: AfdE7cm5UsOA/SPvKgR6wHcU9hDvbO3QWHSqZ3fzIQoDB8uQtsKImJCtC23AUFYnyFV
	JseOp4MeZlmeMCAeb8EwRKSnGDBOc+snqEg5mxFuDuT3HRh73f5JxmqKqK9GGEM8F1nSFBtuizf
	I/xvDt/y9+gax8TPKyuX54MScvEZrYYQAAm2CGVIYOxFLk68BHAeRrsXw/z+3cTP0Mp74P3ulF0
	cSbR41IdVONKf9HOxLad2nP3DaiWK5wd61yQ4qUyWMkyIt6fGHvAeLMI74KLhQ77qULLsX7SASx
	27as7m3qm4xcltyMjp/dj66JllFwfDybWUZZU9DFRwsw52ko3AcQIy66L9bz8ItIgkTTxX1Rq6P
	fohPAgc1cpn7vNVKQid+cgDjzhlf1wA==
X-Received: by 2002:a05:7300:e60e:b0:30e:fdd1:faa7 with SMTP id 5a478bee46e88-30efe947724mr250939eec.16.1782882543389;
        Tue, 30 Jun 2026 22:09:03 -0700 (PDT)
X-Received: by 2002:a05:7300:e60e:b0:30e:fdd1:faa7 with SMTP id 5a478bee46e88-30efe947724mr250883eec.16.1782882542121;
        Tue, 30 Jun 2026 22:09:02 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee326c7a7sm15553098eec.29.2026.06.30.22.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:09:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260616-pci-qcom-perst-fix-v1-1-27600d6ae357@oss.qualcomm.com>
References: <20260616-pci-qcom-perst-fix-v1-1-27600d6ae357@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Skip PERST# GPIOs provided by downstream
 PCIe devices
Message-Id: <178288253875.309343.13111797439602870400.b4-ty@b4>
Date: Wed, 01 Jul 2026 07:08:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MCBTYWx0ZWRfXxER13/9chnvX
 LvechGP1/eYkOY9yUkISzJccWzeFUuATeZ5l64a8xzd0EkOISSt2Xhy11+YkUS63R5TbinfWoEn
 1CJpx+4gNF9x7Fpo9dAY4uonTIY2x9Y=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44a0f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bqNSvqPU_hI_hxIsaqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: JG00txARLFtTjjtW4k5f3FLstzOrnuwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MCBTYWx0ZWRfXwg+g2osi8Mcu
 k5POjkhS6h2r+YKLQF2TRz8u9UfoCzG28RBEfPgJSKMrvJewjeakpgHavdG0cIOYClkODvMfG3t
 BGfOCBIDaw/H+WtbHVMU8cmUJoF5LtYZLMH+6iCTwvLvpbcdCemL5Zwq/OAAAOkt79lokZQzYj1
 WCrEYsgfrLgNcTyWqoPjrdQNOrMcPA9Hq2P1H/dB7+v7/WTJz2gB+EHGjB3vCSZt7jCACwJ/Ngv
 i31nlvt6a4IwDXBKv3/qkaDfF41vPqy8a/yQbEh0QkOckU7L9KYiGTHE61Lmwjv//HDq1HYAOJf
 4ZpriYFsonP7UYSBoqQipwO4F2S9pLRXL2aEymwxAPQRJTzhb15zC5kqB4+FDCSpo8nM2Xmwafp
 UqGRQknrXBJrOixgGbqI+Xa/uSRbS6PsJ2Hq/k/VL+P2oXAGZwL8kVsZFZibS05v7BCaVzQelQi
 QvzA6nDjOe9k7I0miEA==
X-Proofpoint-GUID: JG00txARLFtTjjtW4k5f3FLstzOrnuwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010050


On Tue, 16 Jun 2026 21:45:19 +0530, Manivannan Sadhasivam wrote:
> Currently, the pcie-qcom driver recursively parses the PERST# GPIO from all
> child nodes defined in DT and acquires them. But this creates issues with
> PERST# GPIO provided by one of the child devices like the PCIe switch port.
> In this case, the RC driver cannot acquire the PERST# GPIO since it will be
> provided by the child PCIe device which was not yet enumerated during RC
> driver probe.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Skip PERST# GPIOs provided by downstream PCIe devices
      commit: 1133089b07785841258623e6337c9d89d7913638

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


