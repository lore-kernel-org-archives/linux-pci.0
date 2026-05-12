Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDD3AB474
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591707; cv=none; b=q7Zc53YGVSLVEvAlN2oDwpg4hl8l5QCpqRWmbcZukA3ILfxyScAEFZzoiXu+zBfePqtt4p28XZbP4PpJOxqmZSd9+v2eF1vC94X23uPRqhkJcom3ThXqufhtGm2Qh5+ZkLQP22jcM4yrHqSMVhlZQ5TuWYsMMv/PKyvZgbAg3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591707; c=relaxed/simple;
	bh=UdhDF60W7OlDKgfHvYMjS058aTau6Jx57vQPbBGMicE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SP895jWdl1DOdSKs2Xdx8IqSWjTY/pFx2BYZIdRk3W4+2hDuVfbxfLizhebIy2vZ5uZiiUeW8WEicQGTA43ppkMKl+xWLbRa9ZUQQG5pyXbVju+bj0/B87OvXWGffDxlhgozkJ3BcKF1pk7c3gV+j4Dy8UTLTsRnBsE9eQ+UjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXav6Ief; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNmy3ZFk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXav6Ief";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNmy3ZFk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCA2UV144489
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gviVp5L7af/O+n1zHDTS+kpbHcxMBQWZhNHMsNPUGw4=; b=nXav6IefheO4lxx/
	4F5ZNslR/5lY+HGOtjLltipoLGnNLnnpF5bpjMK4wajefMXpNtZCvt9+2Evt2YwM
	+fubakTlYHKWjHkAkjTWx3laszbcdR+DRK20HaBwSI09pc6rg/Lc6C93gaSVAErP
	06K9jgvsDYgC1B9qAR1ru7KEy9t5M16wrYhZyOG4k7dtYnns1BFXZLT9SZw0y2Pm
	visPTG0JB55kY6xOdeo6lVMf9o2C/WX2P6lC/HHGD9cPISxbu1Vcsdf0gbdwmUOW
	PyL//jmaDbGuN3dqheGZbHOoyR+6SH7LgzO8SIB3UtAvWeouVh93xqJeH+MQaqQ9
	e60dHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp86g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:15:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba718173d1so97019525ad.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778591704; x=1779196504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gviVp5L7af/O+n1zHDTS+kpbHcxMBQWZhNHMsNPUGw4=;
        b=MNmy3ZFkPKtsFaiE0FGnfOhwZqQHfwdScLPmW3vsoB68t4bwWhscKYQ9m2NJ0jAYyV
         5RgT/BSyra1k89k3vdLb7PT8TRccNtaninu7kgvcr9WUTAxyzkmalFkVfiLAGJUhUSIF
         cfTAXJy11L8oH1y6JyUCmRA33XhElfLxcGLA1eGFY18sp/LEVB9BXVaU1FS/NXV1Eg/T
         nSWuuZlntFJo39MrLMoIeT6hIgcHxCYNEXIupEiBW92A2kNDYMie89z1bqVRWqcmshcM
         x7cOkVo+Fqq5N5+wrKFuv0ayYoFYnNwmo2+GmSJpkn2v2x8ZJic0MD04tJNL5bGdHUiz
         3v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591704; x=1779196504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gviVp5L7af/O+n1zHDTS+kpbHcxMBQWZhNHMsNPUGw4=;
        b=mnQi0gL+o9TnyR9f/bKDGS6ZrX8yTv6JT4q+i2Z0S7BWAL8nHQGbMBygJEXFwZhx1n
         ykM0kolFZBM5jr7w2GBY0OZ0SuKSF8wjSt4hDytlYGrYRC9nH0FB2EW7IdXOYRMACW4c
         HSmz10rIqCPs5EZ86WIp/KQLgqvEyGWmYRqxRDEJYKRXjO6blQyGvCqY+ujsJ1GBuJQw
         +lR4b9/9RMMNJDjWWT0/cgLEsrQczJWcV6Fvupv4bP2dGQVX5rM39wG6pQlSSHgqviiy
         z7Mi0RJVzI/0WznQn5twiia0fubgMhQ5pPTIW/+eQPwfYeCj5jcmGC0SVsq+xK0Xds1M
         +ehQ==
X-Gm-Message-State: AOJu0YyMWgsNiifKVqsS9oQujOfmKDSKR5IW8uruBas3/kDGGff454mM
	MIWjIhotp3eVvbh7a9MZodYqgtZLEpWL7060c9tNfEkAu0+0I5qPA7yLEZGyCkxwZhYqN1AXGsY
	PG1Q3JHsRgHlQImdc6qpYGoU49AWcy2YZ8zrqlQkcQIrl7RNLfnUBHBpkDFtKvWs=
X-Gm-Gg: Acq92OGbDU/McPyv7UW6/Oo5B6uRkH/3NZA83TJMZFQEp58OeH+bOBPYskMy9qgcO5O
	BD+UzdSSp+xhs1Sr7Acp2x/+bCwmVpJW/5Xwz7iulSSnwaiDsbl1BjKTwD+tlEyUZiKWpovL/7M
	YXmpObHEd8N4IfTvRjTqfCrzXprdCkEmGAtTjQnmpZI4REZA10qq9C+ZnP2NUb3VJULgJ9nyOn+
	0hAqa0r3euYIdspH6b4biWVbgxEk9cCThb3YmyjjhrsJEWqIVe0ERKngpzfIUQA0vEh+QC/W53M
	EAAt7rQfPZ67+Bl/coDKnNbcDac2N7Zdh3qU7QleXGpx9VwdTEGfX2MPWNFZ5NVcdGYm8C2PjW+
	DoT+BB9RHvGI/U8pfkn95
X-Received: by 2002:a05:6a20:a106:b0:3a8:21e0:1ffa with SMTP id adf61e73a8af0-3aa5aadcc7amr31859441637.27.1778591703958;
        Tue, 12 May 2026 06:15:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:a106:b0:3a8:21e0:1ffa with SMTP id adf61e73a8af0-3aa5aadcc7amr31859283637.27.1778591702425;
        Tue, 12 May 2026 06:15:02 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267726df6sm11812694a12.28.2026.05.12.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:15:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
In-Reply-To: <20260427121227.290604-1-sai.krishna.musham@amd.com>
References: <20260427121227.290604-1-sai.krishna.musham@amd.com>
Subject: Re: [PATCH RESEND] PCI: amd-mdb: Assert PERST# on shutdown
Message-Id: <177859169720.27951.14088072881655680010.b4-ty@b4>
Date: Tue, 12 May 2026 18:44:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: rNUAcPwCDzsOw54ahq1Bp7S0vJF8E-HT
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0327d9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Qp5ySmTnbtObmzP82KMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzNiBTYWx0ZWRfX139eK9isco8L
 O8B1Wb5u4oaqgCTuxVD2FBvIoa1N78ACnFAUPWx/+Igy2efFsL/tubTkl5vmuliDbzTbWEbVDJa
 C0QGiR6ekeGEz1kmDljXbjkUSOKlK80m6DRqr8YZwNVBIPhjVCWJh8h5+gPIHLrDD9sVVn82qkZ
 yctokEIh1qx1AgE8L8G7t0UhfZruRRUTb4tN9Z0or5Jb66ZNIVhrE6z/Oi5/KkH3tGVwKYFr6Be
 fNpcE9FS7oPFaktVz78bXuwtnWuDCx6Bq5Cyxy2Tjk7wHStlrVeR2SzFRZqAlskP3eyVe91aKpw
 1cdLrwlVO/C+RpQkYCPIxynzQU5JZLnvQBmdV4x5TaQafuCaunIz8fAXxzP2mMNETivjrqrwODb
 laNFSnxhucFguW429lYyiR0jePjt9PsHmRyJPNHmDgxCLjI5CcS8cNrv3U/iVXLXCTOBrvABuqb
 PCXwovWODAWv8CMVDBQ==
X-Proofpoint-GUID: rNUAcPwCDzsOw54ahq1Bp7S0vJF8E-HT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120136


On Mon, 27 Apr 2026 17:42:27 +0530, Sai Krishna Musham wrote:
> Add a shutdown handler for the AMD MDB PCIe host controller that
> asserts the PERST# signal via GPIO before the system powers off or
> reboots. This ensures the connected PCIe endpoint is held in reset
> during shutdown.

Applied, thanks!

[1/1] PCI: amd-mdb: Assert PERST# on shutdown
      commit: 0492461a0508d88f2b63de4f7f4e71b38078de20

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

