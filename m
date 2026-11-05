Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920955;
	b=TXo3PgkbkaUMznJPMx5GafpV9sWsI4QwLopISvNLJsdHOSk3gjuHjHs1QYHan74U1R+5
	 57thUy3yGp4PnfxWAU08t8bT6aZya4hS/zygqkdJgFlcGdvnKI0tfSdPj4THVnjANtAYi
	 aMS9f79jc33wJiU6Lv9JAZYXCkHiylChL1UdgYrzMebIotIKUoAcceV6k7aep3vnD83N9
	 2tkpEUwZkuOmE0HNpp3i5JDX+FOmNW8XGzvHvOnS9ZogDWJPc7pRiyxv7cAUlJAYv29jr
	 PoyHV+wDZZbEJOaj+lS/mA9LcliybFiYfztBnyTEK+RgPXohAhLatxhHfmZ3f1WX1kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:CC:Subject:In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-FB-Internal:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=F+KcKhR5CnH65kxRNvl8LH+QFZdieMym2Jst7zi2+xw=;
	b=5bgdC0nuljmfd7U4cFNnPeRU66AhYaVE55wH2vAO04MFV+Lq6DbgBNPELB42AkMNR1dJ
	 fgaCHRRfeBady6Tn0FjZsScN4vbRi2CVIVyUbwBObslhN4TEzQew+eBth0gOzxAvwI2yA
	 vj2TM1XJXOz36IIxRKuupjLKLkFiI3nNOHj5Qhv5649IcaOxBbRmVqyHrCV2+Ib//VOp9
	 v6ztipNO8l60xuGFX9RTPQb6Ydr4SecMDMyNtDG7D2NhLDhMqwm20TMy6qG1NsE/+03XC
	 OabxVSR6nti5SNZIxmBCc8+DJR84NfKeQ3I1hiTgIJn+gJTgn7/1u1Seksx4F3K46mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ORyJur++;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D8606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 23:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA5D8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ORyJur++
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5N3Hbk1244789
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 15:22:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=F+KcKhR5CnH65kxRNvl8LH+QFZdieMym2Jst7
	zi2+xw=; b=ORyJur++WYpP5A8LFnqWIwPQpzCvgVbRDMbbdRfItLuC+pvEjEx2d
	1UFJ2BhiFf7YTmqkq+8oEwAtgYESHPE5VVK3z4aC7JTNYR/1kjwnOq485x7agFgf
	TXcKrb3rMQuzQCa0VgztXqUtcbXQjHiudQqa0tBF3UthgToh/mnTOZyjy7UACd5l
	gW65iQ2eMoTd8G6XQWOqdeLqCCkU0VVCj2JWdQvDKZuaO1BDdshzsiiygSJPDHJ+
	mmXMBgdUOOpjlL+R6H8zJJxwyhcv6pq6bNopJrAkhwXTXXtq8a7ywd9MiqbFRO/S
	sDxd5xfUevvYvK25BD3+RrktkH0SMEsTA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrbcj27dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 15:22:33 -0800 (PST)
Received: from twshared14956.51.prn1.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 23:22:32 +0000
Received: by devvm9890.eag0.facebook.com (Postfix, from userid 139328)
	id A434B55781A3; Thu,  5 Nov 2026 15:22:19 -0800 (PST)
From: Jennifer Chan <jenniferchan@meta.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Lukas Wunner
	<lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
In-Reply-To: <20261105215148.GA1566818@bhelgaas>
References: <20261105201010.2297078-1-jenniferchan@meta.com>
 <20261105215148.GA1566818@bhelgaas>
Date: Thu, 5 Nov 2026 15:21:33 -0800
Message-ID: <179392089371.3269676.8761425999098988375@meta.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=PYtqFShd c=1 sm=1 tr=0 ts=6aed0fb9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=6_OcV_819t3UPtOCXZEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 19pwHGdPBsIsbAiAjE60cAaIDvNVqcsB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX1hFcZbO/D85E
 FRQmAa4DXWsv1t3+McD9uBwOgm7jlaa4TUhMyTpJdP8vjK28s8PPGdpW6e7rb1MUCRX1BtJHvbZ
 //DtAymDbwrEzMuygTQ4WsofckZ9avA=
X-Proofpoint-ORIG-GUID: 19pwHGdPBsIsbAiAjE60cAaIDvNVqcsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA5MiBTYWx0ZWRfX1AQzMEeSqlIV
 vZ1i5SC+JGtpRx/OcOFG9MFcrq4pdxnHEwfIFiwHgRf7KL1dxkkmzCTAnDao51AkGhRCrl4RtvL
 1YUEEFMojWN8dvqpAN/dG74qV9tKBw+tvF6VlIoDOht5vL5/XVZ0dIy3cxPuQrXyIqyFBpOp015
 5+263Dh+95u0sVUcsK2GyAIvG7ND75zersesruFgW+ck//dmt76W7Cv9RaaBimPf76tQEHX87Jq
 g2ZbFIFV8uXdLc6CHruAahX35pQaxqbNA0Jb5GXGQS1g8g7ovnMjWMUwyEBUGAYSAaJXL4ShkUD
 5VIk7y4I9MbbzVmqu09wfDr78u+U063ChNKUt57YrjbX6lu+bTFqjFyyUaSEpY91Dg+I8kP3InJ
 zDCqyOVObPfhtVVQ3HOFXOCp3KlFMmMZkCRF7WR412/vhIKpFZhjO2dP8Fp665jPxfrDejXfPNk
 8bu7WXAa4WjIFBXmlVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01

On Thu, Nov 05, 2026, Bjorn Helgaas wrote:
> Do you know where the -EIO is from?

My mistake in the changelog, sorry: it isn't -EIO.  The four switches
fail in nvidia-nvswitch chip init, which logs "Failed to initialize
device : -5".  That -5 is the driver's own status code
(NVL_INITIALIZATION_TOTAL_FAILURE), not an errno, and probe then returns
-ENODEV.  Before that the driver warns while reading its engine
discovery table from BAR0, which looks like MMIO not returning real data
yet.  My logs cut off the driver's error text, so I can't say which
access failed.

> Ugh, a second is a long time to wait.  Does the kernel you're testing
> include e8df1d194c39 ("PCI: Don't treat ~0 as ready in pci_dev_wait()
> with RRS SV"), by chance?  It only appeared in v7.3, so it's pretty
> new.

No, both kernels are v7.1-based without it.  The fifth switch fails
because PM_CTRL reads ~0 in pci_power_up(), so the device may well be
returning ~0 after pci_dev_wait() declares it ready.  I haven't yet
checked whether the Root Port has RRS SV enabled.  I'll check that and
test v7.1 with e8df1d194c39 backported and without this quirk, logging
what pci_dev_wait() reads.  If that fixes it, I'll drop this patch.

Thanks,
Jennifer
