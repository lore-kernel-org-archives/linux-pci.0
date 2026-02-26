Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BA372B49
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090567; cv=none; b=EhAWtc5IM63HHc0K1IetNah51b1KV7UdCbAzvJEvTCBg61w1DvFyUJE7egNJIyY3ngcQfzv6Du3zm8GFDDXCHWspXhEfukAvYDC65eJh7MvHqiH0dRjH/m+T89yTTemBy8QzMNEqLf/zhum1Z/nF982Nvk+faa3uUNH6ml6RO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090567; c=relaxed/simple;
	bh=OHLeAB8c55abfsmY19EJaK81xEkxjGn3FfqX9pxfCS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y2E4H1ftKR/2SYtF/OOhZ6Q+zM1wFJn+/52MsnEfoKgGqQE9flOIVXpCsYSnoimq+X/XFkrpI89H39MbIR/75hpvKXDKXGdCcHpn504XGRMgALbQJXdTzNx88lN2I7DkcEpK586nd+nXfe6IfiiJntwz4lRKIAIdFsGGhEBsY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTwcRpcr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fXTZV3RO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTwcRpcr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fXTZV3RO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4Us583225937
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WlgdZ5gwHOxelqLHqWLVClyiL1bpxNzwG7E4VVeWOKY=; b=cTwcRpcrZEGp0oce
	KFLyl73ySFlF8BEgTmvsbt6bAS1JK4vl7fRggQP260ktPSnFFtj0RZwzr4m0z/V0
	OW6eZXzFjV1Z/RZH70LZPYmWkRAPyi3p4plnPDv+Z/SpvoU9UqDjkAxrzP3POOef
	5Y6o4ApUWpjvwRhHCrhg7n0GlqIeqy/Qvpo6G4FdcxF+bNsN1WJRuTFn82G3maIu
	F3/R9ZF0C87i6R23zWZwVFM+bv93VqFlbfsQSZkIo8NfVDWly91amUvNswNis9SA
	2gvzzVjqe5mdlCHsT+tASEe4RkgosodWXmGBlozyXGVojgDvANoxxiVpWLaHAC+Q
	g6QJkw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph0ps3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:22:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so1009902a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772090564; x=1772695364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlgdZ5gwHOxelqLHqWLVClyiL1bpxNzwG7E4VVeWOKY=;
        b=fXTZV3ROG96qVAOA+MW5hHyahir4V30GKvwp/N1ycajrxmID1VTonbAValMe5GcCvI
         TLYtacEbmZsK1bFZgIEz1IihfECQR4adQZfutgbHiXgVYiEltD5MBsfJnjL0/MA6KTQk
         4gpJI6McUfwFrE+m9NfIsedcdySzM6iwb9uOGf5DIUSLCZDi7CbuYq2Q0Qzs3seuJ1EU
         TUpSnjGNEJKhRP6iRVOwK5sEbGSBWY+N+d417RQHeq0OdxhCPG5nWivIuGQLByz+G1pr
         okT6AnQrA12Itik71Fxk6WPAAoo3bS0m0OWusvCKAOfkiZs+wU4LanudNIvtDpisE4Vm
         YHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772090564; x=1772695364;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WlgdZ5gwHOxelqLHqWLVClyiL1bpxNzwG7E4VVeWOKY=;
        b=Ult4pSBaFTwpQYqUjC6w9WAZg8Cqj414bZilzzpDkdOqTSlP0dJJI9+5vf8LZoKS9M
         e1VnwvDBW4C5aDQrXhMb/NFlh707Hp3Qq7Xa5zduR12c9SaLv9vtQODPL0DdfTZ+SPHC
         tuxpyvqzUtpcTzJ+5sbiQCyy2pFWMHhQo3skdVglBpt4vVwyLCPw/VX/qUUpoBrLWPvT
         gtwlG92ow7wmQJP73lja2lJ3P26fSqUa9Cl6JwhnftiQZqYgEa3qa/7z+WvGALrJyEt1
         faENeDbvUSxbhO2PesHJiihWPpVSs5jg+lIzD0sUpekIPpMFv1xnc+UCsq/z9BFkrjNo
         sZrg==
X-Gm-Message-State: AOJu0YwgomfLdy/6dE9I8dGtxUgCm1wngjZYGUqsKPx64Ti2Skm9idjR
	/5otcAQrTX2sJqs+XuOUASn5OUEg7nqYbY805oSkRzhT+3xazIqWfJXaa1MUauGsSFaIs16lNUK
	mdmznd7Lk7qgOfonAVpKHXsMzz7T5IwL0DaQf6nRQd8NuVeQ4nknPGYK+9WPLJNI=
X-Gm-Gg: ATEYQzyAA9olplIqa6V93OYAvRBFE6W4bAjyop60HjXOdQJa5spRV64NMDHDXE5m4rs
	TU4TTP1pkVAVJcGUjj76IV0svKIx8ZS5oR8J+0L0hqIVyD3JDu/hnq3DjditpzeQc+KQZbXapT2
	ShB+XlIfouL1cuHBOA0D0LY/yhXPpuLtD4iWMVy+G3K09sqnAtnxxO5kdXddgpCuK/N4oF97W49
	+k5UuJhNZKqUftJNBhBp0ZGmwpxTITAFV6EPfywZlN1sWEj/vksPxeEbC3+P0cwj7NrDC2r4NtX
	iabcvQZDgq/+PHaB9v02u9SFIoMIgNygXnxZlNoX1TvR75rEuKyFe/UfPcsBt+ff5PZe0nTWpbn
	ukH2aBtXULlVLe6EGwQVMIC8=
X-Received: by 2002:a17:903:2ecd:b0:2aa:f43d:7c4c with SMTP id d9443c01a7336-2adf78d7941mr17686715ad.9.1772090563834;
        Wed, 25 Feb 2026 23:22:43 -0800 (PST)
X-Received: by 2002:a17:903:2ecd:b0:2aa:f43d:7c4c with SMTP id d9443c01a7336-2adf78d7941mr17686485ad.9.1772090563318;
        Wed, 25 Feb 2026 23:22:43 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:521d:50c0:367d:1d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f25esm14754535ad.47.2026.02.25.23.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:22:42 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, geert+renesas@glider.be, magnus.damm@gmail.com,
        cassel@kernel.org, Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260210160315.2272930-1-den@valinux.co.jp>
References: <20260210160315.2272930-1-den@valinux.co.jp>
Subject: Re: [PATCH v2] PCI: dwc: rcar-gen4-ep: Mark BAR0 and BAR2 as
 Resizable BARs
Message-Id: <177209055853.87053.17849057393556556577.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 12:52:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: aHXXp6yfSZxi86uj0_aD1j7O-m6nUd1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2NCBTYWx0ZWRfX/BeNftIiHVA1
 YQY3jDZriCoF3glA/90OSUbHdyUeJSABNszsP8FpH7/sQAiMDc6kaS2YZGN7Ce47HRrWU5I5NYN
 DKj/DT+ts0kLdx1eYMIV0UxdSY9pJ5djt2+neHzESYuH1e1GZ4Z/z9nfwpxt4hykbPsP8SkzVF6
 t7IglpWeHbOXZ6BkY+x0aAWQ2Bj0RuSolSNRblMvEG/KZEZk4FVBd7W/Eoa2RFc7amT8ebD3+Jl
 +L89MwKIqSBf5fSpeZaXHPyLL5Ppv47COrP+/GRkxRjjK3huKfygSURmKIbKkMh55/jbDlQKhxx
 AoHC50wAeyUbFQKtBs4aXQrUuvAMrT6XIyT3EIvq3ArsKDt8/lhuXiq4HI1oL7wwO01NWAxe9+p
 CYvpCA2ThrdY3P8ePiObFyVlnjPMTb93QK9YXFEzBcfOon4lhD07QiuZG9vvzr3pmBmflAVDLHs
 liBh9QkU6snKitXtb7g==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=699ff4c4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=-fu8A8ogDAHwY6WL0e8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: aHXXp6yfSZxi86uj0_aD1j7O-m6nUd1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260064


On Wed, 11 Feb 2026 01:03:15 +0900, Koichiro Den wrote:
> R-Car Gen4 (S4) implements the PCIe Resizable BAR capability for BAR0 and
> BAR2. Advertise them as BAR_RESIZABLE so EPF-requested BAR sizes are
> reflected to the host.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: rcar-gen4-ep: Mark BAR0 and BAR2 as Resizable BARs
      commit: 7f0031b967fd68a1805a16857f5b3b0ca2d32d42

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

