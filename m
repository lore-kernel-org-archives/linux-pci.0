Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF2311597;
	Tue, 28 Jul 2026 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785215246; cv=fail; b=Tmvixrm0KLk84uRsXxNb1/xQIl7BomrtQjJUPdw7oBnLQ1XUVPeoQvt9785q2U3HereZBS6QLxzCgs8WDSndGtPJNGINpLfx7MfuwvtZ4Nmb+yN4+wJCEooWCI39A9Ku09gcM/qVLDBOgqx9ul0fwD5J29kaOJi6GTZfH1rFafk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785215246; c=relaxed/simple;
	bh=JTUVqHPmBMcEyW1A4HXLgw+icgYHuKUmwhc3pLRqaJY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FU7RqfEsqg1rJVNx3kjWvs5OZnaTiyVEnql56NsltWd1IklRtgJ025YSM5q5AUHexINCaUj5O9ur+orPh/AZDdIuR47Vt4PK0mdMHKtQLZONFmfbNrVsSE4hHSUdTSpISFS2EIUT0tkbSDaRRtiOJm78dIXdYhaJCYV5O0jr4Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=naffeZxS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d9Otb+dW; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="naffeZxS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d9Otb+dW"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66S48ZtY243823;
	Tue, 28 Jul 2026 00:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CkiAQeVAKkH7hUVTEUjybYX20/aLiCXNaVwrlNfpc
	WE=; b=naffeZxS/CNWc72NBuwnRkuSFTkx2owZvYVPqtEzaaTAohGuWbGgiiXqw
	qW7fIn5hYGlT73FK9YBjjII2WXgJk99zRLShaWmJHU/iD7NO1OCZhUnvuWONLrdG
	48Ma1qjORTrqB5kVh7CoJq+fCM9avnnw9shalgX1lpeTbJFnmodShNUqHJWuVtfB
	3AvEhRPUY6wUvdCnzX3sMeq9Ds/4WPVThJm3rtVO2WbJiRiaDouGt0bEm8hRDC1s
	8zAUhru49NXVxWIOYYaHZAMvbbt4RQf+xAWbsPK3zuIJ58XZyl/KsXUXtkEQAQMd
	/0SANyX05ZJAi9ilMFlDoqjVdW19g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fpn4rg9jy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 00:06:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/2hqaHQoKWULtU26BiGYXd3fVWnHcc91iFpbbk1+Ia8oBSdX3vnLidRDRbaD/2LJffZeA10PtKjEtIjXpxD141bPUpQCSJqQJtuDhSA3oHoGRwe5mf4wN425KVm6OczG3XGFfyQR0L6IH8VuFR9d37FzD/mURNTW8JZEjZp3cxkkXBOkfPKeyinmdAeXA05avI50iZJPbpUllN04/96WbsyQq5ZNcI4sS6VNonxV188ptP2E0NENoqEiBKDY7oAqhmAe5ULYuGWBQ1IyNssYyxQuxVQJPngZ4H8WjaXlfLDnqQvdTbwc70ePucp6q5vPQ05Eh+LFE1zHFW3qlY8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkiAQeVAKkH7hUVTEUjybYX20/aLiCXNaVwrlNfpcWE=;
 b=GrXdtB59xeuAGFRWj9HP+goHNud34qrfD+sxC81IeVvzwEokornTvZ43qPmGlLaDX9TzPYQzP/w5Ehr3xBcqZ8Jf+cg3T6tLg7dpoux9suXt3+t9gvPSaFkDgtI0RnKV3c6VNZrJiu4QG6V0AHiI6pRkS8dm0Foqxzxx0QXKYSylj7ZCjnIDS1b4Gk1cTHhyYD0YILgb4G5S8EKz/WEMWhXbdNteOflBv5KZvqghJeFZlSlEvCZrwGBonq8zOXSIYryCvq0EjkfIG+KADRRWhNHFcs4lbWsirxvtGNRCYhfTyfh88ytZzuhcslSza6vH1jivn7p7xAYFEcm1DZBzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkiAQeVAKkH7hUVTEUjybYX20/aLiCXNaVwrlNfpcWE=;
 b=d9Otb+dWg9pHLmOaFjKsSdG9/N2p5X26KzcopocVpc5MxCaNxKzwbVqSwBDR824OnkiwVLpAqq0GvBxULDmWolAQlqdGUN6VI9fCooxahKfhhN7TaV8wFe9UyTt82eUqlFY8kxPddi7IzUOlOKF8lpebUCSxeGO20PeHmH/UIec=
Received: from SJ0PR13CA0156.namprd13.prod.outlook.com (2603:10b6:a03:2c7::11)
 by LV8PR10MB7966.namprd10.prod.outlook.com (2603:10b6:408:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Tue, 28 Jul
 2026 05:06:28 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::13) by SJ0PR13CA0156.outlook.office365.com
 (2603:10b6:a03:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:06:26 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:05:46 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 00:05:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 00:05:46 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S55bJ81950176;
	Tue, 28 Jul 2026 00:05:38 -0500
Message-ID: <6d12ce30-28fa-426e-9688-4c2900e63d14@ti.com>
Date: Tue, 28 Jul 2026 10:39:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Bjorn Helgaas
	<bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jesper Nilsson
	<jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>, Koichiro Den
	<den@valinux.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Magnus Damm
	<magnus.damm@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Minghuan
 Lian" <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "Nicolas
 Frattaroli" <nicolas.frattaroli@collabora.com>,
        Niklas Cassel
	<cassel@kernel.org>,
        Qianfeng Rong <rongqianfeng@vivo.com>,
        Qiang Yu
	<qiang.yu@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Roy Zang
	<roy.zang@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
        Srikanth Thokala
	<srikanth.thokala@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Yuho Choi
	<dbgh9129@gmail.com>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Handle return value from endpoint .init
 callback
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260728012548.465139-1-marek.vasut+renesas@mailbox.org>
 <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260728012548.465139-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV8PR10MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3516af2f-126a-4d67-2bfe-08deec65fa3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wR7blJv1l+z04szw72sO59iL4tY+fZYqnMXurI4a2JZfsQTs/JesYhbzDif+QIy4z2DOypH3LQ0Y0klHazK0jFrjXFZ3/8eBvVhPQSXjrx/Q/WaeLdha3X6HGrua/tNVAkkPScu5YzigvbaBa2y+5w3flwN+X2rUb03k6sDA7Vi5fybpo9qMwWfhqxmelPvjS/aw2CXf/NEPR+8eTGrO8+LM3BtK4da3vYZSRhYNPA35MzFkwrFn9kQwuvz7SeBNc14xsk1SHQD2bNKnG03OEsA+QviCNjgMO90yHeCTFM4HDdcY69eVSUAQHBlaMaMWI1p+cmUY1T46NdjokhU6OxLJLd5Pt85E16fCp3hCUvY7BfdOPIwkNYsSKkt0px4GT7r929uWtUoKA5+2BalI5e/BpHy7nht2UZtOwSNjmfDu7145/u3nc7mPwmnw7c2c3FTCe12bMQdmFsToqN3b8pgvhDEc+20/AMXpx5kHAhYqZXSRMqPDHiMhqhw9BmFw5PmH/qBPRB5pA354ZK1kdeRCmTkNukJZvuPuQjzYqam2iWvhb7BVncQc5vcAeeuJn5Pf4rBtaWS5f7Vaq77VrkrlVP8eCd8yajTlfLZz/vb4Nmbcd6t6HEEdUNtcLFQAdWKgW3PSjP3jsgtVPB/q/8QXI4nD05/i0ZszZkSSGDIxU4AOq3fik3pPHEC2+uZnkqPME56eO1ssatsfpeq73Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O0pJsjVx+g7HTcZr3jK+xTHbjFX05DiEOLUTOhy72c3gBgoTTzKTytVQWJWV8if2ut+BcvuinfZwvgrLEu+aG8+iapCdndSjuw3Lz6a2LNE4PVdyq/GZlNzIFOF5B/JSmIz4n4UBRZzDnSWbPREHg7eJfrF2+HAyh7PZclCGunfl+1cpJu1O7Gz5MYU4wsIQV7AfKqvixLLNGTVrGd0ePAN9xlji2MtM8/BpvVlvMCQppW6TuNwtzZ34hrbX/VDXWhnrYDo7ztoSWfF5hDo0bQeJTDP0wLKuAX3reI1OdFwlPpr3tZ+xv1XEWThCpXMYLuvjz7SZSaJDulTjP3jcjZX4RekwEuveEmF6rOH+WjfWanDPPYt+TKdJR1d4UGOxQ3Oe1uy4Bf1q+qqH6e6O2/tO3B/uivQ+BDzDDLXsh/o623db3QlGYSPwYWzK1oeL
X-Exchange-RoutingPolicyChecked:
	ZybAsea4fORB2R1r1EVkb2wB6qSpRWdqwWe+ab/pwjqOIkMu3v2TmckUenU/GkiXeQrnquTyo1517lst/x36MD/BG6EHDca8+iRkRut3QJhIlFP9sqlEjofNspnhekG+H9REDgWWwvToF8yA8VomO9ZEnep868kty42RJLwX1mSPTYSFP9wil58j/znfiZ/w4qGSBNrBMV7oJL/10X3kIBjFHIMFlFE+d4Z7a4bg8H6XG9qQucwZ7rURsB/zsZ5ifoWG9DnIcWbd5T9uVIS2jj8rq/DHN9tUG3mgbFozxA8kROT7lpbTjEf0LQFwusvzTtmq3D55FBsk0vhfJJ87sA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:06:26.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3516af2f-126a-4d67-2bfe-08deec65fa3c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7966
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0NCBTYWx0ZWRfX3U1Bh6rje52z
 u+H1WrFAQIHP43bfpWmzZQAnIasqN4OG5Z2ShrIV3KYxJS1s+a7YNoGeFvCqMuvIqMI1En2D0o4
 ymkplv7oucER38mHFd3goWUWp2MZ1M+91CELTQhajRDxZjxHFrXpU7o9j0DjrgwW3W5RRpJ0Xz4
 X90bfgwjxuqpZxr9ex+3xHWvcd818qosd+Iwu7VdlCIl8PWC913NfwkBTlXLREcxjLXOVLn6jJx
 YfiJ/fjEDEj+yPivCKib7mcQCjS66XRcr2TFGLNDQd/YXCUIWtlRtd0ftm2cAZ3V3aQaUc/5vw2
 h6/qyw6JDA9btee2rKu9U+cc10a7LbFjBp6lnwZf/diQO9B0uj8KgDD6qix6bZHwR+Mn4nYVCXi
 e1Kg1Uc7ehWDmNOcu4DJ1v6oXYYcGtqIjYuJimVxxJ5V4kUMdjZ5AFAkKO6pAi3NZBxloPmVpzb
 HW6mchf/vyI6BVwIwOw==
X-Authority-Analysis: v=2.4 cv=GfsnWwXL c=1 sm=1 tr=0 ts=6a6838d7 cx=c_pps
 a=qMfGPIaByV4ZnHoTJsbowg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=b3CbU_ItAAAA:8 a=sozttTNsAAAA:8
 a=5ldtadBcu8Fm5Uq-hBcA:9 a=QEXdDO2ut3YA:10 a=Rh4KQ1K2KoEA:10
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0NCBTYWx0ZWRfX4ebUiNrBeXuM
 AEr3GDC16wQXbHnsCK/ZNxdgzGPI5Z4UR4lieBTTXjpofQoxhvyon5V910l1+AEGHj68C9G1Qx5
 +j50ubt0oTEp/WARJ61BKWR1nCz3aAQ=
X-Proofpoint-GUID: xQGyWoxoUnnwaxkoaAuouPW4TP1fMDHC
X-Proofpoint-ORIG-GUID: xQGyWoxoUnnwaxkoaAuouPW4TP1fMDHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280044

On 28/07/26 06:54, Marek Vasut wrote:
> Add return value handling for struct dw_pcie_ep_ops .init callback.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
