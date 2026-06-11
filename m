Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF841A0BD0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162461; cv=none; b=lno8pd2cnPFRmu0NdDQygfbKnPIhe68Gn6hbUmFw4U6HnPT6zhONYQVqP2SUGL+/dKkFnLGfsYk1NgCUHkqxjUjC85peArAGtVziSqeG3J3h07qkNn6lhKfC4OA9wjerZ+Y6PBTq1QJlN0ee/8i82jFXkASVnuYJi3XgDYtv3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162461; c=relaxed/simple;
	bh=iPDk8BgNmy3KCdzpupOjbsI5zhBiM1KG0P9LsvZOs5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hoIEWUU+tLb+0sUlSq3+5H8nA6BTLUdno0rNXn2WWwcHtnLOVE0VgOJHNccHmiAj21lVDdJYf1rtajI6R93JSyg5t6SdqprTSKusLzaTvUHmHc1PAB6+tLA9WeL3oNYCszH5H2wtdstXu20e5hdrW/SPI15k1kkXXa7Yc7KOWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWEHLAyd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Be2CTzDi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWEHLAyd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Be2CTzDi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GS623835182
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CQHC0MbxFBmHg37FSCWCdA81IJ9dxNyYEm4tKxmq0k=; b=dWEHLAydlOKZPGH4
	R75aAd2/WsfaXS0KPXcpfxr1DGF4+ycrKWm7jBscvhPnNK4ExYN++Df4JdgEssLX
	diuuVV6eeLQCsX+eNPQQxarbcR84yl0RSgKtBM5MDCtLL580PUOS1bQH7RGrMXXK
	KlncibcaRByBFpbA2LT9ozR57hHdWzlR0TZH79dbSsrV65VEI5MiuTfho6xX6LKr
	iJMEjFM2jlkRgSvkARWErYw29zHYnrFRigtzLl1v/ReGg0uiepjcDP7+wQXDkA8u
	Y3nQQr0QatLyVo2V7lEWShv4Q4lv5ggkQdbqMoJoNCd/cAqFc6/lPAx94HyMbE8x
	tZ4FpA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tj6vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:20:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf30576aa3so56309555ad.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 00:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781162459; x=1781767259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CQHC0MbxFBmHg37FSCWCdA81IJ9dxNyYEm4tKxmq0k=;
        b=Be2CTzDiHAi8JEz5ogDCJWHy7V1vTC4sY/hN6A9nc56h0I5p+af1a+LO5WoowkE09J
         WCyFpK+bdIYfE7DoNBYjrA5q5efzVNHJDbqEoGHPStxOVbGTNU4xgE042EhKhlrXpqZR
         zv7VwlYcJmlA8eS2WttkV56DmXA8kqQd4JWNrknR5uiJNYmTk4BVky/Sy4pw7y06TdPQ
         XpUsRzQq62XBfKmocn/yp7zGzO4ErCI+2xUX1yFKYP2a9CP9MleGGZzHyErPZhz1jPSc
         wkECqBI7bF/7PvcZKnaeTrT5YSMIXZ8eeIhNsb10Pgn29p17O18/FSEK0h6pk5vs8YNR
         SwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162459; x=1781767259;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CQHC0MbxFBmHg37FSCWCdA81IJ9dxNyYEm4tKxmq0k=;
        b=eDB8f+WvAoyo5uZbzbRKvF2rz9wUz7jJ0aYqaNVf2qkgtcJVv2GvwKE/uHdU8U7Rxo
         pKWwgH0jhp3ay3CDONQ6VFEdugQsS7MtjgMXuzajEgkoY8im8GLHrDnV+Uvf2S+/mSq/
         DGvIDQvxPSbBt7FMDXTOaOtIlF8XYL3biS61fXYQwGLWdLxZnD0flXIisrfQG3mAQjCQ
         PSMpaynGaBUZiRH1HijSMVbUB7ajkk8OhTCQlcqSB7+/g3Ibc7IRQz6ZGryRcGh/zyPQ
         wbGA8cLvJHc7vRs66t+F6+FmbWB58QqhIyxf36kOH4OpUiyNzI8Z5+bIfilbbPB7MsH0
         D+jg==
X-Gm-Message-State: AOJu0YxbvNtcz0pdO7YvulndZ7LQiSldHm38tFUK2J76yc0pZf4SD0fT
	J0VwVc65o8qtYf83Sql7lxqWp4KrZHu30yJx/yetqzbI6rfs+d85kEBUW5N8vQtZ8qIWDEvzCB4
	CF9tACkGfTz4CTr4o9bxkqBUqYSWPvQD6uGq9P7BlqO52527glBgAzh1x5ZP6xbJvKa85jdM=
X-Gm-Gg: Acq92OHLjS7+JBGOhRQ7Fns1OzZ0GUTchUhAejAjPwu4n7nbGM0b2EQh87er6La/eL+
	t0zYUAK/b/+in5QcAdiqL4gatlvAdYrK188RMSrBwgjpzQuxRgP/mG3J7aNHvaH1RVTu3Rnodaz
	nr8hc6O2cr9udtdu3jR12qEQrN5MaSaAup9ZBQgrmh1WbNOEl92j6bcz4ayKl9blWQaNfnIFzOL
	hUHvSC+RL07EEZ8I95vLk5iHuB7S1FVrZWit6VGd2JmzW15/L5KB1GWb101xBqKUrLIZdXUs+Am
	c2cHL/1Ms7YLma4LUhI/C6GgM6f55tduc9itECWn5/pEcXoxsqpKKLmkKisyy4tD1QUxx3V/lEj
	rnCiJWPHbXxCnoxLiVQThDo04WK4NG70=
X-Received: by 2002:a17:903:4b46:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c2f22a9f06mr19126365ad.25.1781162458586;
        Thu, 11 Jun 2026 00:20:58 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2c1:6259:cda8 with SMTP id d9443c01a7336-2c2f22a9f06mr19125995ad.25.1781162458087;
        Thu, 11 Jun 2026 00:20:58 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.195.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8ad7sm145922405ad.42.2026.06.11.00.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:20:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, linusw@kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260526044016.1025613-1-rosenp@gmail.com>
References: <20260526044016.1025613-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] PCI: mvebu: Use fixed-width interrupt masks
Message-Id: <178116245413.8388.17772545908959484770.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 12:50:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MSBTYWx0ZWRfX+WU+ofuTvQ+h
 OQg/7O+Bo5RxJnNqwtGEGdiiMjHYeO71KOeKrYC/jT/o3TBKLK+jPjMCpjfN34LwhzDpQ/m0njG
 YrAfriecsyL96VzoOt9tIdHsm7zGu1vqhN31RKg/3moZ9WufrYB1dDhFZq7o90sCEN0zwxtezoh
 Ck2eJqjy5vWxMWKX8rTW0dUb773P9Jy5jb7hqiqu5FeIkRRy9b7URu6jtdY7uJIu2jh/pX4fJJd
 KTw4F2OOTKOfmDA4iXt2muz74GuBPNZJ2tEad1OZpMHoaHDsAcM+QWePWuS5mQvwm4Kh3X5qaef
 BFJEnHygPnqtuFEUqoq7URXsSD8vrgAMQhmPpubBmYWEIsx8FPQQoGpQL3lAUIYo6cTknzqLKJE
 hmvW4gGe2H4ycvK7daLRcIh6cssvH9N5fwce16RrEgkz40syERPYB29Piw9mO1Rv/g/CxKrjs3s
 TRr/PoJcvAgw0IyQH8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MSBTYWx0ZWRfX4DtovSsQVCYO
 NRYOAOm8uiHWfxiQw6rAB4zDWrvlNBpqBtpr7rwO2J6E0WBkXy0/WTSlCVG0YkwijR3hvPUpTOK
 3ijl83PcswTeeYHPn7prQhJ9el+OnHc=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a61db cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=n8UK4BQKCdfH/t0JQ2luxA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=SiPLVwNLmWBdlGvAHpkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ymf7j3tLazFivNsAcFRpWxab1rO8KkOw
X-Proofpoint-GUID: ymf7j3tLazFivNsAcFRpWxab1rO8KkOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110071


On Mon, 25 May 2026 21:40:16 -0700, Rosen Penev wrote:
> Use u32-typed BIT and GENMASK helpers for PCIe interrupt register
> masks.  This keeps inverted masks in the same width as the registers
> and avoids truncation warnings on 64-bit compile-test builds.
> 
> Fixes this and similar warnings:
> 
> drivers/pci/controller/pci-mvebu.c:316:21: error: implicit conversion from
> 'unsigned long' to 'u32' (aka 'unsigned int') changes value from
> 18446744069414584320 to 0 [-Werror,-Wconstant-conversion]
>   316 |         mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> 
> [...]

Applied, thanks!

[1/1] PCI: mvebu: Use fixed-width interrupt masks
      commit: c525508c1854e72b080b49e6ff7074913dc1905d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

