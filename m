Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A5282F3D
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315455; cv=none; b=G1Fpxkuy/PK7uHJeq46TrSv9VdPFbQf99lTB76q0hoDH0Shkx+ZfT+62IUkt4Teo2StLE3r/4r4HLwePU43WAGV99eD10Q4RMtwz6miCXpvUq0k9mod7xi1LXQNiOGAHOybk2GRpy7j+U3rCVr8nx7R7343gw4DOVYOALUJBk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315455; c=relaxed/simple;
	bh=BPM5wF4iF3aEeIAWUCdAJdhgX5s3txVIU6V7Id5Des4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BEfRIz1WQhnoFoN1ogdIqRJplQ/eU+EpExWhhwZs4Zy1Vki2vacPXlgzTHjmREHaCKNmWit2Wo9FBB65fH6T65wDPDdiOdvzmDch91eiPfImdaN6u2QfSfBwmlNHLrTdvGGqu/gj61IPEpMh8fKaQwKH/4Y5k5gBZ/dFN4+oikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QhnmcqO4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lh3gjUT4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QhnmcqO4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lh3gjUT4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344e9km2973517
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 15:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bBGJSQnWiUchmorQvtlWdbS88dtxB2MRA3kIrXW1Q/4=; b=QhnmcqO4Lw1NZNNH
	hn6/ZMGgszKbZD8DBQcAHBY+7Cpofx23yseqKgHx0aL0QiBrV91WWK8pD+bGdWdk
	tDRItP7u01U3ILZoXvXn5KIAxgI5Ag5in3W8z+hQG9eT7U97Rb7XL6m5LX1I+7cq
	CStiTZI8TsGvWmNRH6oa73H/wRTHPlXnXu7uLL/qP+JWWVZHWg2slL3Oi8KkTrpf
	a125O37x702GHylbHEkNF42OFmpECqiRpj4ZPwVr9IniW8qUj9XDKCj2OGsdsxeY
	MwX+b682Q8KENInWPFUGBuF51Yv3NCtf9yr/h4B9rE0NXPQdXaZdJrnePfu0rdIm
	CaH5oQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth8xcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 15:10:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82ce0c07d0cso1867131b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775315453; x=1775920253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBGJSQnWiUchmorQvtlWdbS88dtxB2MRA3kIrXW1Q/4=;
        b=Lh3gjUT4ibELundGK1TymBOI2ntW9w113e2Pfk7nvHfoMCN2SiF58TqvHsGOAdyLuD
         GItIIHwAVEZLJkTkWHShRhNKUXHNLYgihlO6tE+0ke289FPqi+unjmSwXpkIYn1b8PjZ
         YcYELnRVLYfBJE0x4yHyRxT6vTiJzN8a9KALJiuXbMyW5pnkve+SvOCD2CvezzuON1Cc
         ppUwvGS9SmLRnt2clQ5HlopRpcLgwtgAJmWpGuzAg5Ly3i1zT92xlT+2GbvDwmey9aEk
         9YI75Relb4ZRgbz/Gi5z9vMarB7I+NMEahuaTi/nf71Rs/uRuvNiwnO8T2GrVvuIvdWA
         jZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315453; x=1775920253;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBGJSQnWiUchmorQvtlWdbS88dtxB2MRA3kIrXW1Q/4=;
        b=FKNTok8HUrrMnQSdU9wuoh8Vy481Dvgc45s75esUMPv/ffH35KV7QiR8i0+YDnNA8G
         7i9I9oKBaK5fOr6yRNYhQEdHe18i6HkClga+KfO21eeFwh2o55OqN2yR5i2iRVY4Nq2K
         8J0apdQYsrKywHlBFsybvo/vDopA0Raxhcibcjzn8X3pE5nDcEpmXH0LOlwi7Kuos4j5
         4ijmPqb39nYwEK0WX/VnVKbIVT6qR1u/vdlIXc9serQPfFL9jsGu08KnYUkxPg6Pd6EW
         kIcZnFn4NXE7L/uyPWFypK4i3dUAAYMKNLbm+U3aEhJOuFDIkS0vf7r/gkNndj7TWAKG
         vc8Q==
X-Gm-Message-State: AOJu0YydluiiBtiI/p8J6eNnq7oEbHP9xmprDA2tUzbFbxB+pBRv2+2U
	rKzDdA9pvVa+p6iTrbtBTfzsEPa3Q3oq0a7KIFaK/B4VWH4wMb1yquhTJGvxBbaF9C9xgyauoPj
	3xUjxLjpW7G9V03romy/JQ41OI1cIkN1qkyw3j0KOAsHGRTMtylJREC+x0lfkzOU=
X-Gm-Gg: AeBDieuVE9cz9QtQlRep1dbuTp4X+6dATkttvu6I0iW4XLlfcak1KdCYl5ETHZrxNbF
	LyIdrjnFCXb98lUaEtk1nu2ThgumR8azFluj2KrNQakKYhaYHfXe09cBAXcAWe+MqSDNuwLZ1II
	VPesYivofmNHsAmmzs2KSGD2bxnmaE8+zm0QW852Zn2qU2OqE3BFnYbTJ8urlGjXCbV7F0spfbJ
	tgUwF8Sw/3ZQ89zvNaRt4c76Qvp2P1JK4MH+0zvGNeMyf6YDG04kxIsFnswz203WTVZD7+nYD8E
	V5u5ai5vx3PTcYpjeCyCvvbo0G1GcVQwKyH+ovwGW1LGvc3LgTRajb0ZCQ9AKR9ImqAWoPjI2TN
	Oq8iK97wcpVhHJLdQdQP7ApwR
X-Received: by 2002:a05:6a00:2998:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-82d0dba28c4mr6272140b3a.44.1775315453044;
        Sat, 04 Apr 2026 08:10:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2998:b0:82a:1529:2b4f with SMTP id d2e1a72fcca58-82d0dba28c4mr6272093b3a.44.1775315452477;
        Sat, 04 Apr 2026 08:10:52 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11f76c09sm4894335b3a.55.2026.04.04.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:10:51 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
        den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
Subject: Re: [PATCH v8 00/14] Fixes to pcie-tegra194 driver
Message-Id: <177531544428.21053.931772756422646129.b4-ty@b4>
Date: Sat, 04 Apr 2026 20:40:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE0MiBTYWx0ZWRfX1yJ9efVs7Slh
 wSqkXbHJvF8ACi2kHqGuPzGSn062lKzSKMO3XsLBx76wybhHItbXpQaqEUfYCMlhvez2mUAxYPt
 GKcPNlPO1YVNiB5y8pEcmpsy0N7dQi8gVD5hStUZ6P4L0bVH1G2fNaXLpEb/aARdOSv90He5BOh
 H8N1pFpmKhJN+p2H4/IIOqsCATuzSube81nScVXl134iYDqCdJ+jyd0JSurCitCEeohQWStWtDM
 RINkj+e4qa1BwGk2yhpagZqrctfwSjEpkF+SpXdOeWWgiYx4OJ7q2c4LFeQo5wUO4GATKZbBOpM
 FNo/nQ/oNMKq/AfrMeLeevos2twQdU3fgwFTIA4Ld66SHB02efXTPxAlDQxT/iP99afNOsErkR+
 3Kl5sJDuusgX4jjDeoeX7+LPDgjgjnKbianvxOB8ZQtEfDdg4mcbrKYHWDagruPPkJrRj0KQHcm
 fH/S72GJhqkdvsriq+g==
X-Proofpoint-GUID: CIruzjfPKlupjmbt896V4JQ2SdKEhzJa
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d129fd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=eF7Vt0sX8hFhN2V_yjAA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: CIruzjfPKlupjmbt896V4JQ2SdKEhzJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040142


On Wed, 25 Mar 2026 00:37:41 +0530, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments and split this into
> two series, one for fixes(current) and the other is for enhancements.
> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
> 
> I added below four new patches to fix bugs, commit message of each
> patch has the details on the bug and fix.
>  - PCI: tegra194: Use HW version number
>  - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>  - PCI: tegra194: Disable PERST IRQ only in Endpoint mode
> 
> [...]

Applied, thanks!

[01/14] PCI: tegra194: Fix polling delay for L2 state
        commit: 368e83ebef4527fa5dae9074e9e8086bb8f8c15f
[02/14] PCI: tegra194: Increase LTSSM poll time on surprise down
        commit: 592dd01fa4bed72b1b523e48a8e0336002169e98
[03/14] PCI: tegra194: Disable LTSSM after transition to detect on surprise down
        commit: 5b2322bd2b0a3d3d98dc1e27ec372221faa98140
[04/14] PCI: tegra194: Don't force the device into the D0 state before L2
        commit: 7049b21df37359e2da77e1c553062d60bd175f4f
[05/14] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
        commit: 5e05484b857981bdf7ad247d8bd9e1733edebe9b
[06/14] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
        commit: 4ee540f02d5de5ccabcfee266f12e8bec960564b
[07/14] PCI: tegra194: Disable direct speed change for Endpoint
        commit: 431451cf9acdec5df2210d6a4139a0f8678fc6bd
[08/14] PCI: tegra194: Set LTR message request before PCIe link up
        commit: 24fa3bae1337e91eafdcd6f45dc89edbff4a8e71
[09/14] PCI: tegra194: Allow system suspend when the Endpoint link is not up
        commit: f6faa564bd25742d814382de582a5069b9a48f57
[10/14] PCI: tegra194: Free up EP resources during remove()
        commit: 33d10df4c93fc8dc455275ee704157a1b4b3f60d
[11/14] PCI: tegra194: Use DWC IP core version
        commit: 645e07639d6bdfaf1836b73fbf5547bb054d225f
[12/14] PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
        commit: b210b15956061e27f2bbb7a740792227c34ee338
[13/14] PCI: tegra194: Disable L1.2 capability of Tegra234 EP
        commit: 1443e9be158dc199b279a7fd26fa960b1833b9c2
[14/14] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
        commit: 93d2f203b330f3f487a3786fe19dc84c618f2b3e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

