Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD94BCAC6
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200843; cv=none; b=eKrkV9ZLxfOyMKcTaOKwbL7CE8BRuET1uofJRA7KtgIccbNDksNTJOHbWTQjiUZeL2WR/MG5ko8vZAxJnBicm3WiGXORi/YCUdLlUJgPmqfX3E31lbK0AT3sggS6Yz/XgMZgx7nUQ3ouxBrrig0edsnPo+b4iGjHmwclja/celE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200843; c=relaxed/simple;
	bh=J1fIsSHzHA0cszZYZdv5tqXM8txWfOWm6rrYcIkswk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bvt1hmnKL4gM2GPPq1bJK6j61U90eQUgHR9glh72ZK2rNf/o1EIhbLTo3iY4N62voAO2HIf3IGjUNhVUmzPEv4GWTTMS+MBVE3bx/vC3qeiBEWkIMKEz24xM1bO/nq/S2pzb4CBTkv/P4ud/hhwa7toS/YD4rEyP0oR+/oJZEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c1Xj7Qj+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL8BltYS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c1Xj7Qj+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL8BltYS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCTJ651737169
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zEjqKkH3DhRxJE8KbXYEAt37DhNV09bfllpxwdO6tRQ=; b=c1Xj7Qj+y951pKcH
	uJ+Yl/3DY/8BXEx+ZlTKrXTGbbvrzmwMIyoBGeH3lFeMseGuIZS0/wiGe+r6J/X6
	ilx6hDAzNUbj7AjoUK9VnoQ6PX6yhMU3S1RzzEfs2Y0AXYRiRA8T4bC9eG/UgVxw
	/VfBzwmDKSM6DdE1WQtv2a1+mUYBouFwKHWY2n+2NHp/PDYjD6nRzGctUjCQf9Ip
	I/erEXcBAXT5nI64Zio4hTX0y3pyxfcfswOrUMl2FczqNb4yle30+FbL47UfcePA
	YjwqMYYVUdk4vV3H2W3unntEOlO8KaN1y7NpyJoaacoEcNTw3b8YLdjZLQ2YXhqn
	RD5gYg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91vkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:27:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8397b14a689so2511313b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779200841; x=1779805641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEjqKkH3DhRxJE8KbXYEAt37DhNV09bfllpxwdO6tRQ=;
        b=fL8BltYSasUtctsJmpu76QICz+0UmEy4fgZ5DeA+waavv79vNSnXxfogWCZqpnUgwx
         opnAVbF2m/NEVUmQq7WlOBBIEVSOQW6FXQLyVjYS4W4qhkubX2Y7BBQ3CegWXEWj4ke5
         jQLGL9vKZbhppsyQatzc1OUM852X16vAG+ULtk2UHDdno1ELeTPRbGdq/8r89DUfnA25
         geZUiW3A89yvaSzo4UxlWyw62FYrksjKtHoXqB8c726WfYHioP6yTjfcA6e9IgG42qlH
         O6k1WUBKDTzwOXUs/zVY/zq/GIyS7UP772iXeyFlviMp4Odk7Ya44QxtO+TNhUnwpXw2
         E6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200841; x=1779805641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEjqKkH3DhRxJE8KbXYEAt37DhNV09bfllpxwdO6tRQ=;
        b=HpM0OOUBGFtu4s3c+4TBQACsO8Hn0a5a781qpeD4c5o/pJGWlCpYuty9l0SPX6WF/J
         tcC6BbTtcbT+MIor9Xs1HWzmiJNS8tVAPpAXsvJ6DH1fVd96UVQS+KQ92kToxbQcIvTc
         LNYlbX5iNBO6lVY4TuHJa0xst068LDL+5TNwwJklIRaLHTGudas4itStEBt4kFk8afUk
         RGO3sjyjwOMYx/gm2n1lFfkeIsKiNXkryYh0UO8wbIw7A8R1KicmPJYhk8jy9YLJxpho
         LmZETIi+5CeI9dcasfi7vfdOxnEZE96wtOmZWUdZlWoew4pOMwACWUDefC73UWyl8pCM
         jXbw==
X-Forwarded-Encrypted: i=1; AFNElJ8NzhSSMkmPxOORBujpIC1ISHyOkbDmyT1Mr7BIZL5t6LYQ6NA1Hl8pn72XVoiiAe/r/owaWggFA3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwLivLCeSaUj+SU4zqrW005aw4NPRGYS6JVLx9t3Jvme1msEW
	A8O8MtFDcu9WHgCvTl5K6Br7G1E9K2k3mrPgV6UNHMytOvA2uWIni0BFj7JA298g27qoe7ksS6l
	XcIfTcfckylKwJHgIko6x5RdJg+Dk3Y1/ee09aYIRQ+yBO+HMRqsNO6LN2KPT960=
X-Gm-Gg: Acq92OHCpUDe98YWUl1RZUj//guLlUUc/HAgcQTWBGIckUMYRRMXQ0ayghZgzHcjOy0
	orQ9X8N+JSi5JJcVe5L4uEUkzDbKs12i6vB3s06u2zAlx+LQrM/wMCoW27WTZU1RYSr9teRC1A6
	rDtwwD77gceZ2ZC4MtPjPguEEWNcM4CHpnnrH+5oK+oil8F0jTko5ENGIm7SEGPNuLvLGITOtQQ
	fZNZgT/MEN3VrcCNhRwLWFLVWjIVlm+nBU/psi/3dsadNejnav8jVuB28qwGVrUqcQBmIUMpbTg
	QjogjjBcRs7l9YKmYqhb8YVUn/kDtmw5ND6EBeRsIRrAHL+Eh2baMPLkCkt+QStcRtulr4AklCN
	+QagTMxs7Yf2nAuoig8Wh
X-Received: by 2002:a05:6a00:2e89:b0:837:80a:5ac7 with SMTP id d2e1a72fcca58-83f33f0fde7mr20707751b3a.45.1779200840899;
        Tue, 19 May 2026 07:27:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e89:b0:837:80a:5ac7 with SMTP id d2e1a72fcca58-83f33f0fde7mr20707691b3a.45.1779200840172;
        Tue, 19 May 2026 07:27:20 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.207.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f67eff284sm7640033b3a.8.2026.05.19.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:27:19 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
In-Reply-To: <20260512103347.1751080-1-wenst@chromium.org>
References: <20260512103347.1751080-1-wenst@chromium.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: fix incorrectly skipped pwrctrl
 error message
Message-Id: <177920083522.97175.591150691760691771.b4-ty@kernel.org>
Date: Tue, 19 May 2026 19:57:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: als-Akl-J96ovQQIhwr1d-8n5AO5jhCx
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c7349 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=1gRTTRxgmbTSdBvl+srOOw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=bpYmCipijB_Evp6s3csA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MyBTYWx0ZWRfX6M1sSX4elbrB
 VEZ54D1vTxYyFWpE7rUYC2IvCYu2vj0ZEPJLnB21sczxWURVL1/wKObIdpoka/lUAsQdPozD4CY
 GaLbTRC/MBIbLPkqIIGCkxafwXCdJ0zRPpzvhESR+zSXHs4MOVpZHO1sADlZYJ7AtWOOiagazYr
 SzSLArZEKz+nKrlC3DNn0VjWRtWfqp21o6eXFYDSPbeYyc9cs7HFtWkqwVlmh6z4YoAnvhqppyK
 xdcgz1D1xr8HQt8AltFfzo6odY8sqtKJAg6ePffaVwiuFW3uqXLZBentYM4ThCsb3t3gon4+8s6
 HM9xqWBYhjsu4PJoHsOkZsjnnlkbcwRmD0QAJGkvKw2PAc6X6HhNIozJedoIKNdpBXQKmhazHlQ
 5KXETrDpvLtnXyzYrjpEw0/Q1As6/gt7arb3ki+NOHu4fuagBEaeBB1ZW8WL8CBn/sSWOYxYAlY
 tBZVJiCLkEkTeQr6oVQ==
X-Proofpoint-ORIG-GUID: als-Akl-J96ovQQIhwr1d-8n5AO5jhCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190143


On Tue, 12 May 2026 18:33:45 +0800, Chen-Yu Tsai wrote:
> When pwrctrl integration was added, the error message for when
> pci_pwrctrl_create_devices() fails was incorrectly put after the error
> goto statement, causing it to be skipped.
> 
> Move the goto statement after the dev_err_probe() call so that the
> error message actually gets printed (or saved if probe is deferred).
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek-gen3: fix incorrectly skipped pwrctrl error message
      commit: 8ba433753d9b131c2e43b1ff7ba8c5730cef8231

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

