Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB3313534
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488317; cv=none; b=fawL3M0DiSWhyVUPfvh5KiBNYTb8DinbHjv7/8l60CPuNaDRNmeT9W7gJw3sc27aTeOItY+Fq0wVIrvICyOCR+t/LmfSxvlEXMpLQeG3l1duVT4NuJMCaG/Q/Yj0iLlTBKSLxpWv6c/76uxey0MK84qv5LML1HWGR3/cJlDk/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488317; c=relaxed/simple;
	bh=i9tc7b3tGnPfVh4mO5DDcpk5QiiUsLZXH/ljNKWngJ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e16e8Vm674hSfsnXMYOMZyQMc6Ir4LcEQBtqo1vOD0wng1iZGqcmu5D9r9nYrmvucP6zzP1nL2yrtytGzU6CTdsiLnSNniPceKKCxAqXyjDrBiM5drYU/9XrbKefZucxyHtqEQxzLklAnFo4Ts4YmWGW4+q4UDGqVKSQwm3sUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UE1MQHTN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYv9ZYwo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UE1MQHTN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYv9ZYwo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7ALsw452887
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 08:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	liNuFjs0lWZuIiFKHVxV0Y8he+FIbK0rAFC9jD6OJfc=; b=UE1MQHTNKmIIkV/g
	IdjogApqjJzYuBNq48UcVmK9kYIH9MMqjYki3DzKkC3dqs9QepTnNfgtQaf3EqT2
	kGvD1CvhIS9/oDrzftuxekEBljeFCsiECbp4ZnaWLV1yhzQEgsAqQJ3aWjBhE/QZ
	kKz7i+fUQTumDI4sE/oGzM6LiYVoiSa9J7l70vbwvoGmXAx9KPjg9W/WqCq54Q4q
	IV3gl5iVON+Ah+cdzmtyEspmYy6RpQrs0gLwatD0GkjbdPJXIk+dP2sCPZlv5DWY
	2Z4KddSZaXmGRDYNr4twTCNWdT0dx9Ikw6UE8GP/TOZa80iEHdltoR82gKn2zpLV
	oTLX9Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6g98q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 08:31:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8397b14a689so2611761b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778488310; x=1779093110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liNuFjs0lWZuIiFKHVxV0Y8he+FIbK0rAFC9jD6OJfc=;
        b=MYv9ZYwoH5ylsBtyoBPlTnJJYdvcKcJm5PUzdyLvc9MzKerCQ7nrjJt1CtHLC0BY9R
         vQh6LXOOr801nzLuYzZ0cX+0cwdBwJKo0EH+2z5wyeSfCLDIyknsEcXKlRQ78i79AxTP
         TI/mu0stCehCA/mTGLO03X4hXztq3rLOQSXyER8fIEZqIZFZC41130GcDYXKLOpr01ix
         0FhAOArgrGP2PlSDEbU2FUG4pUJqMNEVJmqxSVD4Rj8/yeP9tChX6DLfkCK5aGeaMuyJ
         PEyQQciReV+7dRyz3DdsVQljOEOb1yTibl8PWIOFqg9rJU7CrONeRctWAyCFVMVg3Fzu
         2Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778488310; x=1779093110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=liNuFjs0lWZuIiFKHVxV0Y8he+FIbK0rAFC9jD6OJfc=;
        b=oTJe5IVPl9VyUh3xcId4y32V3S6mChaJgz7D8SfHQIfIHdGljHBLQhomWSDCjwtn4A
         wp8785vFZ3Tb56yYWKPfX1lS2m1ctuFyj9Ym84yX0DPGQv0v5vawT9lL+gC1nwc/kY+k
         lJj7jI3+CFQv0kxGVQT1VGaRQUNYofKyP3q6YSQ4dJVv/6q9JDYgbO89NvQYmHut8zVH
         VPWQtF83icXtfqYjCWTf+sajjPwIQVkj9qPcAg2EWZOFucwICa02BlIzUPs9nZ3fK+Mv
         g3YIlN3lBJykpqlj0p4ixkY0WvQghbXgD3LBrI7eVRMZkazcF2S2DxBhyr8DpB6HrYrL
         2UgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8n+PDrjXtX4GCxh70ROfaNOS6VSeEilUMOUodxU/oIJBU1GsiImQBvbTEimwN6fYXM8Og45EO5XYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp6V9EmdzF7idW13qSZBNugMXRx2O8UL/B14B101Ue1BGx6PyD
	HEVrBiUA4tjc8OSUjvxeP/BdKhCtgSLcmbXoMKcTB27X9kz0egdLX0DAODDr++ijjTWZZKl4lY+
	DlrbHZbHqj/hUg5kzFt/M4ZlTzii78gg0dXl1f9XCzKGYGx6dG62wHWg1ww34Edg=
X-Gm-Gg: Acq92OFcTc/9gSR0yzS6trHxNRlWGETLsNs8cOtnqFBB2VX0sH1Wt3Bmj8VJT50o4Az
	1/9g60g9Mnf5SKDR0ba99e625zMZMJSSCpUgOx6bfcAcyApF65VFj5UrWH8aib1R0e3rvkhlY5f
	OHctMfCTYUWCFHc/Pj+mmtb5I0Ids+2uq6FM21iUCA8sQyQR7H+XyFEb+LmLgt3jAuEcuXveq3n
	cVwSyEfMCNWrx2kMBYQh+Z+UWhKDEg3YR0EhueV3Wdihufzi9s+D8C7ttfaZM9KLWLeGGILMBbF
	YfCUD3j9GNo/j4okpIcI6fAHihqASA4KvcUHLEi4Vlmx1TGo3Tn1m4AH/jFkKV6k/7pEKG7IhCv
	Vb9Zs61cZBK2xipFN
X-Received: by 2002:a05:6a00:310:b0:83d:446c:2a8c with SMTP id d2e1a72fcca58-83d446c2bb6mr8897240b3a.25.1778488309792;
        Mon, 11 May 2026 01:31:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:310:b0:83d:446c:2a8c with SMTP id d2e1a72fcca58-83d446c2bb6mr8897201b3a.25.1778488309228;
        Mon, 11 May 2026 01:31:49 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:dc6a:a003:bc2d:d67d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f11csm24586408b3a.3.2026.05.11.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:31:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xincheng Zhang <zhangxincheng@ultrarisc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jia Wang <wangjia@ultrarisc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
References: <20260427-ultrarisc-pcie-v4-0-98935f6cdfb5@ultrarisc.com>
Subject: Re: (subset) [PATCH v4 0/3] riscv: Add PCIe support for UltraRISC
 DP1000 SoC
Message-Id: <177848830296.12802.14978169328629266559.b4-ty@b4>
Date: Mon, 11 May 2026 14:01:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a0193f6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=l0vRmO6wWID8S7eiZWwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5MyBTYWx0ZWRfX+eDQeID2DkKv
 tneTYfKiCd5EegSIY7mK4oJWN+bZV+yHghrGc5U5sQLnkY3iicdI93CnedEYmFBBg5ghq/aYJ94
 eJbKiBPIAcZaYNVXQ6QeR7VTSI/n66bBvg+UAyPzFTrHn3ggn8GQdb+S8UrZPWjllm+IAqyY1FG
 K+xzE0JBazjzOADIWDLrNwtZzvNQ006BZlcW6oQvEEQlmgnQrbLWsClGS3tUXdNATHyNa5kl6EP
 Up5zeWgjZqNjj06kCHsfphpNvnbCaGiGVCEC7sUnKFt0NeW9o54xMLr1ix/xyPzalD747/cGqz1
 7/VPNI3abksd6nq5DLA5dQdk3sD7rwWfXfZWGn60D35sjTGo7AbX4hISMqrBftN3D/7vI0gTzV1
 OsbPSL+cFjKnVBWhPJR9+QyKm/P5xlc4660Bh0OZXC7fwb0xc6gzOgn2m/YFpFSOVHMSIymXqs2
 K/xpzFWFt5/MyWzSC5w==
X-Proofpoint-GUID: GGjNSBqZEqmPrDhY_k5buqyS1xGSx5G-
X-Proofpoint-ORIG-GUID: GGjNSBqZEqmPrDhY_k5buqyS1xGSx5G-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110093


On Mon, 27 Apr 2026 09:32:09 +0800, Jia Wang wrote:
> This patch series adds PCIe controller support for the UltraRISC DP1000 SoC.
> The DP1000 is an 8-core 64-bit RISC-V SoC based on UltraRISC CP100 cores,
> supporting RV64GCBHX ISA with Hardware Virtualization and RISC-V H(v1.0)
> Extension.
> 
> The PCIe controller is based on Synopsys DesignWare PCIe IP.
> This series adds:
> - Patch 1 adds the basic SoC family Kconfig support for UltraRISC platforms.
> - Patch 2 adds the device tree bindings documentation for the PCIe controller.
> - Patch 3 introduces the PCIe host controller driver.
> 
> [...]

Applied, thanks!

[2/3] dt-bindings: PCI: Add UltraRISC DP1000 PCIe controller
      commit: 09b78d6ec24624c2f5192dbf0c6e05cad61c529d
[3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver
      commit: 34f9bebe1cf573cf9735a71c1d484b57f65e5314

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

