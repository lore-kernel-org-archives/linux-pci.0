Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE997403136
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866519; cv=none; b=bWbZDCAmty7RNBXMnOeCUnS+TKpEujcpD3d5klY7phmFMYdH1d8pxLBSrVDoCXMCrOdOKrnXJIVlt7LwSMubVR+0A43iFVtkcuTq83tyuLdn4KhpF5TglPV20zf98M9RUgVuK6pNQXokW1AXj+JxrCYPex/BJH5ryeZ974U3VAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866519; c=relaxed/simple;
	bh=2Ms9LKBYlkLnR1V6x6N/rtohrsuCHkzR5zq3JPtxcMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nJck4kpY2AtzQAWrZpm9CHZfRpLNpZhMP/kzRDM0cthLJXGBIdribNf9a8QO3ipsriL/AsDPADB9aJkOmA6eXBrh6r9ALHCwUPi/R49cf3KsNROOen8+XrzhEEaK609es9NyKv/478HX/WQB+RkFxwDUo/AT7xSCZg/d1fFQsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0WMHqfm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IY10G1Rx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0WMHqfm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IY10G1Rx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBcTIU3512994
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=; b=R0WMHqfmaRzS+/FZ
	QQMKxbLgvEpAC9YN4flY7ZOCYcRtv+9opi4/1D8gXPORin8KBYmRgxijNNWl5UPX
	oXxboF9sptvRFRYGfLu1BBJdkdGuFSV166mz29gFHhgJLtlxjjsHapwqF9BsZnSI
	DMR9JFkVdz9O21euSHgXu93tGSNAVkC/FFeG3FsIEys1IBV2RBoeTuXQqayC/Hfa
	TWczXQzTzvghA+XvSoRTmnpeiE2BS6/vsDd/mcrYRgubOl2DCdH+6m4AHQhNR+7D
	1Je+9Gt2Vy8naJzYWspokzLrf6DtYUWRR3ldQB0wukBYE64/2RpLULSygTXQDclt
	SnnVeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vc8xb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:35:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so2373095ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778866515; x=1779471315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=;
        b=IY10G1RxDBFNW9ocOwK1gRHPJdFyHz5iNC6I6Tpdq4PMwuMgqi/QtVQPjQpKE2z4xh
         tGljccQQqHQ2BWONcvY/WthpnevDDeOgyEAHfKFDlhVI/+RNSwTOgYlydsNivguJePXg
         j/y+WHaw/myIiA7Q4MryF6JxRiSqMPnf82Q/0ArtziESvIKVttDl/ddXqlTRPsmCwndc
         dQZ18lWw1hlYrP+IiwMpqHxFlXIgWp30tbXg3uexHqU2Y+IXujLiw/rebD9iXw+A9wjC
         xLFSIFhqTUSfdnNsJn13H5ie5CsW7+A4NIMQlLCPiVSTQ7Nqyk9Oc2tJvRnipAAJ7rqS
         gp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866515; x=1779471315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=;
        b=BGUHCx00iaOOxY/WO04Qw7kdp8kvFU2vU4/5owPWWRpJiYqDlM6sAKjaKTplTIRD+6
         m2q8Y8CAlPhJFFKvfFfgmCKgTwAcbzMkiR6YEfYaBW16RqElfMHKL/Fx6QbGWRi/T3gX
         VjzBZq7/YlVBcIVUmBFC0GUUTTCXfKPo5YZ1R1OG9CT+SGAZfys1mnX22K5nWhdQbcNk
         VNqJAzF4pCCGkZrHWr5lrwmwJ9tQ5d88LJMO5b4qlL75ASvB4GN5rUuOvdsrlC0QUgkI
         sly8SWtGWvxO+NESUkUIB4EoUHIAUEEjaix+4oJl96ytV3zF7EI4PXcudyNb3QS23qcC
         Ywbg==
X-Gm-Message-State: AOJu0YxJMo/ZPGJM8xqy5Zq99sqqhs9/vYS71gPdcfkBmD4f4iNnZW8B
	dklnIH65IOvWR+gTsg5R8+kytgkSBGol3IhHEYO7IpEEYcnYVA/W8uDYyibaUcFlroq/sRl2Yj5
	za6gg7HOkkxX9MxVisIr3M8fzqNAmQdITYr9AlIE+q4bqPmj7Zl0NTOUovOdpncw=
X-Gm-Gg: Acq92OFcXcBaHmJzhQHGzbuML7Rw5RxF5LqFTvTRw2zrlmZdEYTgmv8xqi0J9pI3Y6u
	wckzP+pM5PJ+04bm8U98Hbp3aRN+qcYAFwvFIQCdAZQDzS4Fb1Rl7cX0zFWyCtQ8MWWE9Ei6c45
	KNhrf9KeKuUcbOerjbYppLpK9OkNBBbsR4d9K+xWMe3hPVbqMYt38qGnaqoWyPkRsQ4qBa87KOP
	xVDDWbksj7RZ1pZzijkDJpC4AzFKrNu+io4fVC5YvrRNWCED0vPkq21FRx6Mg8GzOq75DH7VJNR
	0/tc+C0Zk6YmMXJ04AbKU5ITsub3pXv33dTxicpTgi0niN3TfNJinWAw63IrFyerw2eA4c6puFh
	aX5zOqGt/VzvpdEmUm3XE
X-Received: by 2002:a17:903:3c6e:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2bd8c9aa6famr36789975ad.4.1778866515376;
        Fri, 15 May 2026 10:35:15 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2bd8c9aa6famr36789675ad.4.1778866514870;
        Fri, 15 May 2026 10:35:14 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600b4sm67266915ad.28.2026.05.15.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:35:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com, ley.foon.tan@intel.com,
        dinguyen@kernel.org, Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        subhransu.sekhar.prusty@altera.com, preetam.narayan@altera.com,
        cheryl.bansal@altera.com, stable@vger.kernel.org
In-Reply-To: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
References: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
Subject: Re: [PATCH v2 0/2] PCI: altera: Fix IRQ cleanup on probe failure
Message-Id: <177886651035.12875.14264722458696413101.b4-ty@kernel.org>
Date: Fri, 15 May 2026 23:05:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3OSBTYWx0ZWRfXxK2bayzimbx1
 V+UCHuN16B/DczBdQiSmmzzUDAQLcSdaN4V3Mn49Gnbl72lZIVPF6J3TK+9I8Jp4hODlbglsICq
 7H/6oHrVlWyLs+z+WzWHy+0SqC7RHvMYfpehjyAk/zyj4PkPaDffL07w7q0RjRzNbF73BgoTQkG
 zYtfAWPubzaw0xRxkXT6ea69q63NYn/DMa15Y3iQ1lCJt3UNTsGhGYFqpLWiqcFq3eZ/eKj8UMA
 ytm5SEuvGDhQnLUJmDIfZU6Ca+OAwMr4czrgzqFzggjCB1CrJGJ4ffPMOqdei2i1rI0aQnwIPJD
 tbjqqgIuUTCVfE4h9GF60N0Awy7yRaYSm6bRyO91lqZCnDkTJQh9FPySpaDlKX7YwZZA7Or9/es
 v5CID1FIjGE0uicm7A6hB3ag9lK3UDilN8li+FGonjZF6lAv/bgnTaCBnGs+libFb9HM9zfdddW
 wVre7/K0sbgWkb79WrA==
X-Proofpoint-GUID: mHqWvTZzSsLTFnmyWA4uf3gcNAUAp8rm
X-Proofpoint-ORIG-GUID: mHqWvTZzSsLTFnmyWA4uf3gcNAUAp8rm
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a075954 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Kp4qGauEggbYy1kLNhMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150179


On Thu, 30 Apr 2026 13:43:28 -0700, Mahesh Vaidya wrote:
> This series addresses review feedback from v1 of the Altera PCIe probe
> failure cleanup fix.
> 
> Patch 1 removes irq_dispose_mapping(pcie->irq) from the IRQ teardown
> path. pcie->irq is the parent IRQ returned by platform_get_irq(), not an
> IRQ created by the Altera INTx irq_domain, so the driver should detach
> the chained handler but not dispose the parent IRQ mapping.
> 
> [...]

Applied, thanks!

[1/2] PCI: altera: Do not dispose parent IRQ mapping
      commit: 5ef4bac02189bee0b7c170e352d7a38e13fe9678
[2/2] PCI: altera: Fix resource leaks on probe failure
      commit: 7a94138caeb27f3c49c1dbd93bf422098925bb28

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

