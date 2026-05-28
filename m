Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060B3EAC82
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970956; cv=none; b=HJCiKoSaASlXM3DzeYJbaRvUIp+6nNWKImCJYgcmme6/TtsVfOBt6PWyueEt062scgBkUR7kLeUH+Lb7i4pBak79+8sIk0i5+DcAYmenS8jn3K7NzDlMHDxV971+phfnimcDxhvYBoTTr2JxczDcx7J8hLMjaAEP+mxVXQSeRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970956; c=relaxed/simple;
	bh=SvuHJyVbfp56FKFyv1W9ZIVZyBtnajAZ6S/9O91nNzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XXGiYq1G/p4zllo/d1+JgOlN0q2VdZJBQ7ib79YJOjmLK7aZ09naFBSmx1wUe7z07BK22L3GkA6fQXcP6g4Lrl59+PRFRiN6lM5j/wzJu+4e75ZzlZZvcywVQnZ5sODkvMgztFnWtN4U1nmuNYXrQWXDShLlyR8RiW1tYG9EyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGW5vihF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bpwXTA9p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGW5vihF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bpwXTA9p"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vbMx566544
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 12:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAPB2AF4c2u6iDlFfG4VjFwRrc14eX10mPOMfEjm/kg=; b=bGW5vihFvBLuUCi7
	XSF2O5TJ6G0DdFNMnxVOIC0XZATFK94pBE1PKiUdAKqLUSBA9uAZ1E3pLRtuhxRU
	LOgOWk74ypP+4ZTXl585oQYopDRbdo7bw5ywBeTu6/771DB6dy1/2283QciTQI0T
	8/ovj068fNiWkqgMQPtazMWRbcoGRY4HYtvo+E9qH3fdzCDlSwx+fF+Jex32PWpg
	AyNel46V6Um5hKoEu+Imh0WthI3MxXVxMzD1my1Ul6y3y7H+CtbQeowvNOnzfYJL
	YvNsK91F2vEe7arq4pRQdlNOIfZDVK7k9BIe4k0kKu45WifPl1JxuRISIa1ZLxhT
	whocww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjnj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 12:22:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516dd6e4ed4so125345201cf.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779970952; x=1780575752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAPB2AF4c2u6iDlFfG4VjFwRrc14eX10mPOMfEjm/kg=;
        b=bpwXTA9pEOQXNLHbXQGo9Xqzhu0XZXrF+PVSUxLuZXGncrNaksUqrLw+G8AMJ/JbAy
         myYOHmojaAHSF4y+Z56iL/yB67l7mkCDe8Vih6XseS38UfkSLBn+bM6ttRhjiIjzwz5d
         Au8vdNlPJJjtMUGnM9XhV67k1Vlp+g3F4ApBabnEPZgggiIqkJqGT+6izzbWVE0Ncomr
         axcRTgU8nZY+x7dTO4/qNUFt5MUL9znBn0HU+5RjA2PgoWRly9Mw6+Uuon0fWhwfZDoM
         hKITxV49YTwFOuHuSK9+VWNQHe/Xc39i/ErFIcipB2+IotgwTKjqByISlEnVazSAf4Qr
         lGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779970952; x=1780575752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAPB2AF4c2u6iDlFfG4VjFwRrc14eX10mPOMfEjm/kg=;
        b=meZvdrf895/o/5PG/Y4FmTT5z5OgiIHyu62OCVmvKBUu9GcYxV9KpA8KCzIvLhA6Sd
         0M9eevp6wL30sFYNYb0lks5lgK87dVvo1CUnaKC9gtkpqCPncqLc+vkiBwNSeQh6HUHg
         ci6flkaLFMs6UeP6rrkkKswDQUL+cQtT1Nr3ijvtMbli27TW9G6XrJlyac5/uajwqjxx
         NCYQ10VBShpmk3gZMtK7k//lDZx4TrvCbbmh69bF9EEe74rjm5syQctPdENP3umiF58o
         2zHO9LhNjDnlucCUut+rkg1niRBBKYe3r8JGSEvyYPT6Cq7UBEEQ021YpKqB/K2rkcnw
         VukQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aRJEYWssMD430WrwMKA2r91O9Pwx7RAzhVNg8ZJJ0QOw2kJHiBZeZYGg7WKYuy80T4JDYfrUZIcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypEiA3sCPLygNd+uOTR/zEe5UQdwZ6BNAIj47obJvWXopSK7ai
	5CNnTYQ0P/hMZ99mouh63ih7CyaCBT7WmKFw1AIq94xMTlCveuQ5xTZ9CFXu3mEYavEy2oR/GB5
	/Pbq3KIUwUrd7YCv5j6Ij/H5lZZ0t7vw65YihKiXboaSQTrsCawQS6CMUN1Xe6TE=
X-Gm-Gg: Acq92OEPQezjRN6Kl80g2SS952BV2NWN5xsKDb2VFJ4ecUR8CCesW2uNUEQ3OrQ0Gyp
	MCRGzo6WAlg60I18oE5eeC7IYWpfStoosb7FMlv4w9rsmwPx+MBbYcybbDTgjU5G7+cg/2DXfBu
	iQXCZOGwL83Oy/ygw/Moe2TDjve6WSV+v1xkftvXjIWqCQuXC5DBAFSSp5ArPlDGoNy5BriDn4J
	WDiByd8FsotzLYdZBb6fBKoGsDchF9EFkmPtgkEkk/gyuGFpS1nZFJzfIzd8fBeZniw7ljgjNfl
	SUHUCtj/jcxpqP3bmy2/nt14jKW1IUQVIdgKWV5qo7luIz3Gts9lM9HkI92mL8SXXFkIYZZSarc
	gGhivhBxDrSv5VPtFs+f3dMwGTu5cMASUk8+QXEdvcIjXRpMhA5NX0UjNXoErvnaFTG0=
X-Received: by 2002:ac8:5d04:0:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-516d42eee7fmr379459921cf.11.1779970952138;
        Thu, 28 May 2026 05:22:32 -0700 (PDT)
X-Received: by 2002:ac8:5d04:0:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-516d42eee7fmr379459601cf.11.1779970951628;
        Thu, 28 May 2026 05:22:31 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a432sm18756094f8f.3.2026.05.28.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:22:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>
References: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s for SA8775P
Message-Id: <177997095024.9920.18198713178143798584.b4-ty@b4>
Date: Thu, 28 May 2026 14:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: ceXEBP95AlJINPGjPKnlYrsSux9_x0hB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEyNSBTYWx0ZWRfXw/90NmGuTM7e
 zeYRVwqRF/UDEjQciQfpAsdE05efoBx8eiFNVN3LNE1BSX3NXjRsp3K7Gxv/GDYaR6Dbcbymo3s
 ReekkGof4hcRbIb4FLx311hgiJoswjXF70iea6OP1lGuICqyomj5BG316fru8gmFHDLigTXBJWy
 kliOIg5jrBG782/LcEVCr63+J0b033nCIk1tFe/vRjDEjLMO1n1m9dKSEFbUy+f7Qy7/bJsXooV
 ldyvz6XSxxnTCWRVVUhT/r8+fHuQnmYasRHHPKRcdBl92pU6RiHQ7jHptIE+RUDY99nblMlE7fh
 QOWCHpIxVxEZLNlZ/9bVcinkWPX1RmhPVishPXRT7uj6Sv1LDKriAlUVUSVqnUnyweyyN5BLT3Y
 OVSOnHuz/Y6QkdVfR4NMRvtstkjnCtPuG/QyZb2CoprEqowlfVeGROBkqsA7npqmvgBJTZn+GP9
 LRML2WY7qhCNirQkiWA==
X-Proofpoint-ORIG-GUID: ceXEBP95AlJINPGjPKnlYrsSux9_x0hB
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a183389 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=_8kdG1c4Wl3LSQpqaogA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280125


On Sun, 19 Apr 2026 17:39:34 +0800, Shawn Guo wrote:
> Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> if iMSI-RX is used as MSI controller") removed MSI/MSI-X capabilities
> from the Root Port on platforms using iMSI-RX (including SA8775P, which
> has no msi-parent/msi-map in DT).  This causes PME and AER service
> drivers to fall back from MSI to INTx.
> 
> With INTx-based PME active, the QCN9100 modem endpoint sends PME messages
> during D-state transitions early in boot.  The level-triggered INTx
> assertion coincides with ASPM L0s exit sequencing on SA8775P hardware,
> causing Data Link Layer Replay Timer Timeout errors on both sides of the
> link.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Disable ASPM L0s for SA8775P
      commit: 29f692985819f4089f02a86e151a72f6d4cdd90d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

