Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208372D1F7B
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074576; cv=none; b=OhrnTqi9oEFFP0QvyrT6HK+RK5RAIiy+fpA6h65iEPU4PPDNH98mvHKRns3u3Xf09wuVmc2wF5p1VrK2Z1Hu4DIVtolyTJInK2AhQlZCfyfuZnwW274gT0hNSRfxLulpV4KtNMt6kZzWdWXfJi98fu7xmb/gBV50SrNCJAMb0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074576; c=relaxed/simple;
	bh=j/SOqMXHs99wO9P1dq1fwdD7FQ0ZDP4KdF14fQqeFv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lMDPhe7qF14jPOhR8hh5U/Emxm8wszSNiqOJPIgSveb8HclYK5v0xR+qyc8xZe75Wmdm+NjIYnblMEMaL233yvvQGTTmiPq8ALHI7otAio8y3ivCbPH9i+BLEpC9Rpso42Bj6qfpDoPbEdNUA4vIidDi2r0vtpMOhGL1g+K2OEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyvngqIv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ivucx66g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyvngqIv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ivucx66g"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M76qIi816110
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ihLzwTckr3lOaK/ezZ8ZcsATNzh4ftFAljUNOy6zj1Y=; b=lyvngqIvY5l2Qakp
	mxayy3gHyOGbWemr2cPE1TQxeOcqUsQXIKAKd7Ph+ubelVjpGpdqePLWU2hi1MfO
	HSzrubF0sNL1Y0krThTILTJLa/07vGuvwVpnkUPuwnuh4ybEvid2J7J0xzp8oB9+
	XwT1rWAdyOooKNbN7zdjju7W+v+5aJLRne1JsSxCdBSjpAD3E9Vd0BWgcGCdkOYX
	hAJjqR8U/ppu1hd165qROphy2w+m4dskOOaLnMirXio8lcBiqg1HawjEaNpMc8AV
	oOuOsl/AmBi6vwJKBIOWSaZdnRBg10U6KEJrxpU+pnNlW23y+Kq0tTQ2+DJcOQco
	iWpRtg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu65v1yca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:36:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7d7b87977so5563365ad.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769074572; x=1769679372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihLzwTckr3lOaK/ezZ8ZcsATNzh4ftFAljUNOy6zj1Y=;
        b=ivucx66ga/8g0ui/UM2drRCSEIAZJYEFEqXhU3hsBq6y2AJQufLZojdu2c2258rgn6
         waLL8R80hwnN+5Vvm0mgSpG0jYc5kMgSKA6CY2GdyG2tO7GIKkAT4eP07CErbB1oMK8v
         6i+2eZcT1C/5GscfC4JmKx/o7ynunURlowQa0puZBJltJiZ/4VklG18j+PNjlVFDjiS3
         l0u5OkEEZK0wQwlwBadmZlWGm+lMNmgxXLSTmKf+Od7aC+dH4XiSpODjwEQMaA/fsrVb
         pYO487TaZgMhPxkjOkJqa5nWvQZMFW2iegL7GxgpdhW2MNteFbZIrw4RQOFQPfKbov6o
         AvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074572; x=1769679372;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihLzwTckr3lOaK/ezZ8ZcsATNzh4ftFAljUNOy6zj1Y=;
        b=ejOLBbLTyj0JSs0mnJ2uchcQLKNMP2BGD5sR3uU+Br0GccP8yg5pLS5b9SoIIi2QZJ
         bZ/QbnUaWBPuatnLIIet7fU2WqT1Zbq416QnV4EcBvm9QDO50FJn/taqblu9kblEOHVp
         8QysO/DmUIqi8OwoxIxwoE03tG7AUwxSvJRrDrqxhEu0kP/49vxx2D1p+LWswcs+6ins
         78jcEGd44oGbwtEBtorpMeGyVySM5N0KXPXu46Ed/0yCp8B+G9dsiF/pLMLtI4s9XStj
         UF4L4BO0r4UmLYmZghYW8frPdjFoNkBehqHRyRjr76rsa8uu7Ni6q0MsVUIflPM1GkSy
         GZzA==
X-Gm-Message-State: AOJu0YynzWkeDMZlSDBWGJzNay8mu1ihTzFnJKVT437hBikR+CxYY4K+
	1qmQ6wgEyOkVLCqyfB6Gd5EcZl7hREafnNBm2pXd+YdEKC9RvP/uLCAyXXl2vHm5ZWS9NWeyEw9
	UKHtHYhdpt+0I5xg7xQhptMszrSWmouMD7l8y6G1EZ9IfqcJfTj5135FTDDuwVZM=
X-Gm-Gg: AZuq6aJtLRzWduj7Bl9Xidz4E/UKNFvqIcJmDQmNOHm2ZPTHeKJwAFF7vOi3UrYCfbq
	1P3mwAUGHpcfTkCthgdaJ9LC8HbX8LG+8q7gSaDMeCRQu4eP5yOCyTphUvkpQk246mDLN3xe61a
	FeKlMB6nfIZF/V2df66GwJuDObl6LK46+Y6e8x89QUApYTcQD7oquMISKJjwa769Xn0U7W3QHKj
	zCyhJXf5P14X3p7hHgh6C0lOEXvQKjqEgF4Dc9tQKfz0Oiyyd9FZdaOlj3OaAv+ufPb+0mlpNSN
	E+BPaMulTKoc9xd+xtg2U+eMQz5PlZ0yrh3MqoOE9A5KDg9IH9HQCDqHnttKjzmGw9uieuE3eOZ
	VIi9ktw==
X-Received: by 2002:a17:902:cf41:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a76b16a396mr75437425ad.52.1769074571507;
        Thu, 22 Jan 2026 01:36:11 -0800 (PST)
X-Received: by 2002:a17:902:cf41:b0:29e:c283:39fb with SMTP id d9443c01a7336-2a76b16a396mr75437185ad.52.1769074571020;
        Thu, 22 Jan 2026 01:36:11 -0800 (PST)
Received: from [192.168.1.102] ([120.60.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190e7860sm111867225ad.41.2026.01.22.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 01:36:10 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, Randolph <randolph@andestech.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        kwilczynski@kernel.org, lpieralisi@kernel.org, jingoohan1@gmail.com,
        samuel.holland@sifive.com, Frank.Li@nxp.com, cmirabil@redhat.com,
        randolph.sklin@gmail.com, tim609@andestech.com
In-Reply-To: <20260109113430.2767264-1-randolph@andestech.com>
References: <20260109113430.2767264-1-randolph@andestech.com>
Subject: Re: [PATCH v2] PCI: dwc: Use multiple ATU regions for large bridge
 windows
Message-Id: <176907456657.75296.14064668565506074059.b4-ty@kernel.org>
Date: Thu, 22 Jan 2026 15:06:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: LaaxDhDzTeG87vzLGJob2d9mpjzqjYmZ
X-Proofpoint-ORIG-GUID: LaaxDhDzTeG87vzLGJob2d9mpjzqjYmZ
X-Authority-Analysis: v=2.4 cv=J8qnLQnS c=1 sm=1 tr=0 ts=6971ef8c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=VEjJ2An1Fh3c/6mcm1S2Ig==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Bxlfni229r9SUCX-Zw0A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA2NiBTYWx0ZWRfX2oHG+mCIcOTv
 wC3nbv4/Sh5wbgBIs9DZvCgny+NgeFYx8uw7bB3N9LPJL03Chn0/N/gQ27RowR72zWLmVHXPMql
 lB9+KAPAIEUpsv8Q6iQe3/DW45MiAq0oXPDkbKdQz1ZJCzIjNpiUqTLhwjJCzEntWaaEaAj9gWZ
 kJiE5/yb/oPu6EROjM0eyYEIRK1EQPSLjqcX0D1yH2Zx+dvivox1ZuMnapKbfWwxMElopLBYElu
 isT1aXdCcJZPbN3WK2mChpWTDRrUr8V+kR6IH5lSR3epE7ZkxLfOTUsU/wWWB60pabNa5uLGRad
 v3NVmJTlfgbMch5HtbcIOE5XS3As/n/xjhpcWoZDfZdAHQdsHKj4YitDXqJDnzRfJ29bouifZZy
 EnQHcxlJ6CgmItGsfbPEtmRFoFsdEqZsq/wa0cvtGE5GM5odiAfgK7Xv8CxfmSfVDmlbnjZmp02
 y2RZsHODznDR3WM6LpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220066


On Fri, 09 Jan 2026 19:34:30 +0800, Randolph wrote:
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.
> 
> 

Applied, thanks!

[1/1] PCI: dwc: Use multiple ATU regions for large bridge windows
      commit: e9a5415adb209f86a05e55b850127ada82e070f1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

