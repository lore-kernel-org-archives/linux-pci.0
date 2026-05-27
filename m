Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC863955C8
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872951; cv=none; b=bWyzAY6/qQs1Vu1yltFv93LbagY2zq7NOt5iMjA7KCEPvIDD4NR6/A8R/CpKdN4lZU3pjbAtkVoJjvebzeazYT99FGqXMq8g6e+MP+s9ukUbrB1xGMyfJi8dKJBUylIyEiAAvU3D7Waefxr1oyQxY7p3/xYN4B3zxHfKTPYbHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872951; c=relaxed/simple;
	bh=uk+Y9McimyRzOsd0YhEs83MD/E5PV+dINoRYf5IqMR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9/KZUEctHZ5J5cmJ9bJ2qVupDu4QmmZhcht41DSr6HQnSioZbyKd5oYkYMESlFY2qLLaH9fYuqVgqSmnYEsj/K8B+MDjOJeCAtTU04rGc5J0bxkbnR2yAGf+0aX0J8vpvCizAW51xRJwfNJgaZpydJUNOvtMMwcsXEEwFv5bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK9OuhMD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSC76nnW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK9OuhMD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSC76nnW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mQK7871123
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 09:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=; b=JK9OuhMDf1owPTVW
	rjFYWFnUlb0QxBTrdBd0pqcAwMBJYT+PDjkBVUp9H4Ua3bDzFCBvyzNW1NzXR4YU
	6i9PZ2XSNIDo3SpHtd1RC2qitRp1Mkt6Y5W1y93gpY4aYKujjZSHA060wt9FrcqI
	qHbrP+gtasUGC6gNPyd8DQdZZy371Mo0nLobYww0mEyQS8j3KlZJpDQA1tnQWy96
	692odr1gNiTTBNoH7NJEBFLg8TlmJthdh73cZ/HUFnAo+qSevQXNn1iFIBtBGDHX
	Pv97r6fIIAEnswhVQadGuu9SmIN8vwAeZVK7GGDAkozUkKF7cQp5fUbyEc0U2X0w
	w3J4zw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eduru8g8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 09:09:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5104b861649so23724601cf.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779872948; x=1780477748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=;
        b=FSC76nnWG6IptUrir2agAOxUiBw3sBFgKDnAnAJRQ61RzBSqAX21sdDazuq/ZbaeQ2
         4UzQiMkRsKH9+RKdqX4VQe7RSIFO0WZNGF81rSV9/UYTNLE/Ui5W9M9n3cW2D5pbwyZY
         Wq/MmnpvssEWfnaw7R1D45HWlMXFja2173q19SqQmzAYfKMcBZo1CWV36cgaldE+8s8+
         8u27LM/biHFCM2EIxqzGa3Cr+k59GF9ORSZKP9kpFFORGRijeNaU0GX22wTVZS/UGOfa
         M3aMWeG5Jxpf9qRLcPUJ9rE5sQ8mAvVB27JuLXi5r9wNC6T/oC3CDoAX4v1wzOo0qRhv
         MKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872948; x=1780477748;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=;
        b=QxjaDa+5RdcQ9yQSw6S+cBJs6BbWbWCoc9Vokwh+j1IAlwozLPh4vGF1TqFw7syzoa
         idCPLw862I+WBA0AzW03mwCMAtRVovNKz9BVStYG9lD1J+ggi1lSzgyW3HUR8il0ADdn
         Lw2S1xyXOvcEOTQyFXT17d2EIeOqCNax8X3TMYibs8Pv4G0JhSNRvqJMlm0Tm/pPBWu2
         SPT3iNWgc/fT61kUrmG3E975GpxSbLeglJdHX/akuoxfat1xhEKwmAyVrBYdJ6N/F6hB
         H9XOP9xJn3Lz8rkRn+iePj6jaJo+/UXWL3FWUmNDbt9T9SjdqcEuEqOrdnQGTDGYLzTG
         GYPA==
X-Forwarded-Encrypted: i=1; AFNElJ+OEkylox72mH9fRd7Hz7pFgvL4mgOS+mEQiVl4XyJOfUha6oyXoIQdka65df1Xzcz2C+kOZ/x2Wqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhoksvkztI9olOr/kgmKOxEOFfPs2xNlAlUoeDAe22aLoyni5
	fxIlqTl6E58YvLLw73F9NyX6K5IRRhMmbqLM040wtW7p2EJzuFSnqbox+2UA35kMawDW2P4Xqnm
	pIeFPqFUVXTXFjdRGgWvlyaPOy5Kb489pCVRvvI4nPgQayvKUtW4GtW024YdIoO4=
X-Gm-Gg: Acq92OH8YghpB/0AOJTuFH8DW0LEXlApIlL5Fi64rWe8TLSqAJtaPGEiKgKlQeXbLeV
	EJuqMwUhi7us2p3wFndWvpGNOzwHxMVtRKscYClYmXzg/Ovc6LFn1YA9IN5f6T8RWsO+Sg5gQxG
	RKCnjKXJXssBWy9D/U5VMGxLEBir99U8fijHIqbrV+DvG2MU2uzmahsmBPf+cmoKTfms1zoKzuI
	L/APT4bl15FKGbRGuqNNwNnGmEqhhWU8UT8wgA2MRHZQF+6VD1cGxxYBS+HO5QIPxzjq6jyQXxl
	l5a4eFZ1/CUccmtsAW4G0LPgWAeXiIuAabsCLPGVP5ZKqaSIiglsfs9zdq/eeqmraj+PZzpivLz
	fqPUntoqlWY7Spdpf0e47VynZUMT2+/fGwcDrZ8fVDgY1lkov6jSAZ64d
X-Received: by 2002:a05:622a:2445:b0:516:dfc9:8449 with SMTP id d75a77b69052e-516dfc99abamr269163171cf.59.1779872947860;
        Wed, 27 May 2026 02:09:07 -0700 (PDT)
X-Received: by 2002:a05:622a:2445:b0:516:dfc9:8449 with SMTP id d75a77b69052e-516dfc99abamr269162621cf.59.1779872947099;
        Wed, 27 May 2026 02:09:07 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2908sm4525082f8f.18.2026.05.27.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:09:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Subject: Re: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf:
 Enable per-doorbell bit handling
Message-Id: <177987294527.16042.10832046004394503042.b4-ty@b4>
Date: Wed, 27 May 2026 11:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=VY3H+lp9 c=1 sm=1 tr=0 ts=6a16b4b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=F3aNAmEVrqB_ix-ASpUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: qHFxngiwtE8ShfsvmMYYNapKwfft4yDK
X-Proofpoint-GUID: qHFxngiwtE8ShfsvmMYYNapKwfft4yDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4NyBTYWx0ZWRfX64QC09l0M7KY
 /T4Hcmz1v6Yksz6CsamsIetVdcZhjAFZPObtPLduHMEltCVn0tVnN5hHWwEphrvafw84TyBOh+k
 XEiIVgHr2qsCLZK4fqRnpkQInT7hyizZ7TNrM0RkxJytaa83j5TTlKvGfU1BOFNOmj8aiKfn7me
 nNFJyVWrT+OdkUQNa52gc56BJIVCbd+Yet7ytvp6awOf3rsxouZD4/0e5kqAbtCDnnEE7o5/wkN
 FBU56tGUfOw8IQHlE8Hn5dVCkywTyzl+fYfHxM6qi3b69cU56CDgNc3QOGvl1GvSBSq5TngYqnE
 E2rRlD3I59BZxOiac4kO+Kjyr0aQdq84Ni7/RSrt1vkYvN6t0z1WMN69kgJCqULuRjqlpTK3yJz
 ZKCojDrRmjHPq7gDLqryh7KrTfgVaF6WlNOhqSkhn85ugLCFSmIVOCtlEmEKCQRso0iqpdMoKzw
 5I9OK15IoqUh7wvUz1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270087


On Wed, 13 May 2026 11:49:11 +0900, Koichiro Den wrote:
> This series fixes doorbell bit/vector handling for the EPF-based NTB
> pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> without changing the on-the-wire doorbell mapping.
> 
> 
> Background / problem
> ====================
> 
> [...]

Applied, thanks!

[01/12] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
        commit: 683f8a747ab35886cc9bef96025712011309eae5
[02/12] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
        commit: 84dd5950df2f540e52bd6cbcb5682cb4dff5f2a5
[03/12] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
        commit: 7c54a7152588e8892a7f7f2c69117f00c1bf24f4
[04/12] PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
        commit: 86b48f07a5a398ce1cd88e2f06ddab52c2181df0
[05/12] PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
        commit: 9da8fecbe9173cc1d48667b2b821e4d1f383edbb
[06/12] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
        commit: 12f666206720cb462ac4eaeb61a03e492737e1ef
[07/12] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
        commit: d7eacad42e2d812872fc7da83466657b7759dde1
[08/12] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
        commit: d3de5eb64ecd836160afad84aa3ff639acb489cb
[09/12] NTB: epf: Make db_valid_mask cover only real doorbell bits
        commit: 615dc10082a96423743d3a7b8b90eed80580916d
[10/12] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
        commit: c8220ccb30e8c092db9b6fa7dcb06dfd5340457d
[11/12] NTB: epf: Fix doorbell bitmask and IRQ vector handling
        commit: 1c981bf355e8ab78c45717fbd322bd67fafa8082
[12/12] NTB: epf: Implement db_vector_count/mask for doorbells
        commit: e6ff30150738af5c7aa20fad08b74cbf9b86d3a2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

