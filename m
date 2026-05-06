Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252147DD50
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088209; cv=none; b=UlnD1R6QQv5H00ULG7SHwL49l6jIooKEd51qYq4bG/k/Kuv0jzKLDTB22qAspuc5mQb9wXuDUPf7PtJgi1bIcPPRb9mUhJt6IjkiF3oaUi0XcrrCH77C4/VBXzvvjjZR9YaemWVAXjM4ikE4s0XlO5eCK4AEC9O4AF4BwbRhW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088209; c=relaxed/simple;
	bh=3VKmVGaAxK8GzyesSkTFp6Ratt7sOXqo9tEHlFMyMes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r9LEDzJ1DypgjCiZW20D3iCkn4kbAPxJpZtkKpw3lT2jSTHzoYZAwOmepzLwTd0UMBEiA85LH0a2FKFYqessC/QlGXneHwpWAu/NUvhGsx3f/nOQuw/aEDeMG3vVsRrL+xDKe/eMS4iUCtpXw+lV5Roz/bSlcSn9jFd1aqQtIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dtKfYPND; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ODPsYMS8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dtKfYPND";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ODPsYMS8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646D8YTb1527956
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2026 17:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B04ufWVqQY+6LmdWlDuU/yPADhaacVQQXruDPNi3DH4=; b=dtKfYPNDgtiz/Ojf
	jslK1RXwmB0+n4brSNcJYr4NLTQN09qgPBG1K/yMJb8Ra0tP/RBkBssiIBeKA5Rz
	avobxVVZ+UkS+HT1vsxFTPF1oDcvWchN0aFFJmAgyXYzDwLy6//byia3pPitWL8x
	P0Fme9PnmtRr9WpPcLUY9YhxhFjhq04FFDqECZSG7lwdQentgVV2y+iMJ254DbrW
	89OIMVxNyKhbVeBqL1A2V7x0PTc6C3oQZ0/v8vmW1NghzxOJulUoZz00dntROLMC
	RlLKE3LKXRwYIakQ8091SYmok0lBFYMmguwpxdMOCtGwlFEzd1TRYe9nOAUYta8m
	vlRywA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128acef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 17:23:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f85179263so7399583b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088205; x=1778693005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B04ufWVqQY+6LmdWlDuU/yPADhaacVQQXruDPNi3DH4=;
        b=ODPsYMS8DZIzIhsQS/2vUZztRqrlcUQlZxglkaDZKhaBumkgOtEtOh3XlHdlDlM6RR
         wY3WC2PCpiw4b3nLFJBxRn4nopWH7VixeEUTFH+M3kelPrcYHYSH52yY5SCO2dZGAGWB
         wWRrcpxtFIURzUhFWpvxpfBA2KNnOV84PV5jMnfvj9bXFAToVbMAJhp963zkt7j+4CEN
         3D02HKG5CbxIGSX4AzFhu5z9vYdw1yNfPLA+iZczRcHW9SLWwRSIIH2W7LfkzkLtUoTm
         kOnw6h7HllKMS7vIbWci2RM7DLdrnPEgSaaNjAYBZYmov6pth8PHtFadPXRoJFGPNZNt
         /nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088205; x=1778693005;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B04ufWVqQY+6LmdWlDuU/yPADhaacVQQXruDPNi3DH4=;
        b=cGSjjOKuwPEF3EzjDauotMZ1gs4YbCd2ZA5ERHpjoLFK7YCYF9Ann21/UtBevntTkJ
         0OM5GHsKYHrXtjY2/vzmr8CQ3W+L/Mm7XUOKlZGRT7T5MiOGj6BDbIBmO+CWkuLnPISN
         BZ2dsflFEqxaPvgLamZjtXgz8WZH4SIYFheba5musQ/810JVNUizuLgJiQUEVk0qQsbq
         MZdAZhz3AxdaEZ/3sRRJlWXSHLNqQIq1Gd145eKx8dHx4hVRsQif/ZSxX2FP8SlUoKAb
         A8etkJSga5Nw2dooboaZSXvMPCORd++0vRa3f3VVqBPUET13w2MC/SDtnz8ySxzc9+am
         oEHA==
X-Forwarded-Encrypted: i=1; AFNElJ/j9g89+vvxTe/M7ArqxfSF6x1TQNktzlsMFHcw+GKbkvWod1D2Ew8PxaGdNDDRP/xyd7wtjAxH8K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzxCKFbJ5hI8sfqhBRglGJ2n2Fn0ZbbfyEeMyKwLvhWQQ6dTeY
	0JK3sVJMX5GbWPPNlqnnHwrgoNnsjTc16uwRypWHpBEk8owLfndJsSqVJADl52tBO+bhqe0aOvx
	qrNgp8w9b17ChUgT1CiMzpKvofkTSgsVYyfK0BPAnsPseBg8aAvPgiRUwvXv1xSA=
X-Gm-Gg: AeBDiesVAHW/1ZQBW2UuII9F3j7UDZtkKNrK2+YPQfkp1CkDWlMU+QWFsmq55HWFSG8
	j4H5BUlEgNgQzXjW8i17QF7G4BLF1fzeaBg3HsLEYD7jEGYDt4bLW7pAagwW99VYN4m114syv7y
	MJ8sHlIMTSO83hTeCP/AbXBX70OSURc9Ig/G28odr+4UOrESm5xFaT3O2UzEbIX0dpcqmBQ+JsX
	H/Sw6srw8RWirNRWVwdsOnUlikvDeMz9keLlogzX0OW6VzflUm+2T/6G2hWiIs3uM+UkJmHPWoA
	HW0igIURxS2QRJMe8SunDA7qu8BCtA7t8Oe141BMsi/imQk2034AKEYq71V2e6bFD3IaLF6d7F6
	bwixzdKjKRtAd75gaH54DtYMzKA7xUGs=
X-Received: by 2002:a05:6a00:a84:b0:838:ff63:2fe2 with SMTP id d2e1a72fcca58-83a5bada1c2mr4397785b3a.5.1778088204482;
        Wed, 06 May 2026 10:23:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:a84:b0:838:ff63:2fe2 with SMTP id d2e1a72fcca58-83a5bada1c2mr4397719b3a.5.1778088203868;
        Wed, 06 May 2026 10:23:23 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.67.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm7878077b3a.46.2026.05.06.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:23:23 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>,
        Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
In-Reply-To: <20260506084858.867884-1-andriy.shevchenko@linux.intel.com>
References: <20260506084858.867884-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] PCI: dwc: Drop or replace unused linux/gpio.h
Message-Id: <177808819839.13723.13307063547924502417.b4-ty@b4>
Date: Wed, 06 May 2026 22:53:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: 4wL1spk65YmKRaGaXOtie__hRTrEEp29
X-Proofpoint-ORIG-GUID: 4wL1spk65YmKRaGaXOtie__hRTrEEp29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OSBTYWx0ZWRfX/I8d4LS65mCn
 czCKf8nsC7qjtAGJ5d8WlMv8iumJcZOeoSNFiMMOwHDAC5/zKBKRr5WYSp1gEcx+6QJPxH5/67+
 dzFPpZLWSScQsnyNar2wDisjYNkiTI0hGDtuHaZa4ePaLM0DQTm0VUgrATV5SjqSUKmfPV3G1na
 Dhy84NQAYh5NQA8z/PhBgMI9gFwRddm/3BS5mmci6k74j9fqkS10jl41Yl9+cxfYwfkii71mV4c
 KlHe4MS7HR7+Z7PBSRHBUKEH1DLKBqcV2N+vKEuUpmD/Oxw6hdTCYnYX55OktEHpcv1zCLhAvl4
 yZQiQkWa6pX41owSrR4dWPP3D5DHZVZmTzc55F14OAQze5vlf3wVk384+MZkBFaKnQ1PnMBfl4v
 63cDfRrW5r+HYWHHNQ01k0GQZRLw0uEaDhOd0C1FwTgVyTepyiQzxFaSo+ilQVGaIVoFZBvvA/2
 FAT5siI0fGgVvEAVUUA==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fb790d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=SQtj7D3ryojUavkWoQJ0Rg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=qQCpgmiq-wZ1PIn7dQoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060169


On Wed, 06 May 2026 10:47:23 +0200, Andy Shevchenko wrote:
> The <linux/gpio.h> is a legacy header that is going to die.
> Make sure that PCI DesignWare drivers do not include it.
> 
> Compile tested on x86_64.
> 
> Andy Shevchenko (4):
>   PCI: amd-mdb: Use the right GPIO header
>   PCI: designware-plat: Drop unused include
>   PCI: fu740: Drop unused include
>   PCI: visconti: Drop unused include
> 
> [...]

Applied, thanks!

[1/4] PCI: amd-mdb: Use the right GPIO header
      commit: 8d846a0a6f95cd717df892b077a1c990a86b29fa
[2/4] PCI: designware-plat: Drop unused include
      commit: 800c861cfcbedd033bdffa65c00188fefdcf0767
[3/4] PCI: fu740: Drop unused include
      commit: 71d007f6fb17f519c2fe51d35e0bee5f602169e6
[4/4] PCI: visconti: Drop unused include
      commit: 7cc21269ef74269e423d64defc940808ccbf9774

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

