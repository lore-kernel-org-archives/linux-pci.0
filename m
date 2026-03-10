Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023111.outbound.protection.outlook.com [52.101.127.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA43D34BA;
	Tue, 10 Mar 2026 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125628; cv=fail; b=Z0CJFKyHdX2jpral4fCjpSQ9p/HmgCs+puvL43TiAmq/68hnkvUCkJQ27X3R9Wpk6kvO5h2CwAgmu+cvV0jWFJSoqPy+7nPhitxsu5T+NjLYqXhGa2O9P9nvkN5TXkE8H512TLATfm6y+xbNE6UUVDfLoNnxW81lVPJ5TRshsuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125628; c=relaxed/simple;
	bh=hu8+CQ1YBpAw0CHEuAClgLHc/yntVywd1ryCONXkx0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSQBpHyGm2qlwmbRjjaYC0j8sGDaH96sxFYgTAbaNTeGfCbYzr7lqfy/ruX9BvqtTG+tWAOy4GH8lOob/O9TYBvmY0J5mXFDMQPAS69sNkVfUsprhvmJ/9NPVYUxgHWezEyJ5sk3pXLUo1vYRCZhj41dbL2knrFZOstHfJB1LuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ+IJJxS2vDnrAsuSYPm15+UhjfGQ7qWZgYOwVv4UZ6NDwp7wEMDuv6tjS51TnmfspGNeukTcqpBvsPll2nxs4FDnbNSq08pBeE2ZHurLeq26VAvWdM5v15jSjPANk17orWVO5HO+htDGqFHl21JjRE5cKQXl9074Bd1dC8k3XWuisjmqqz9uPDB6ImFLqjbQDraz0vQ55ywb5HMCG3lJUoyeRrL+N1q/X9Hggy6t1O3GWZOaIX7Rux+dNyDLhgmaCI7p0xiulELnBVjifBwbRL86sSotTlkjYfqLS+Sg75Aq6HhgMYM3tVdL7XLgV/ZeHw8gO5BzlYGgSxl7lUHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfPvKaAnqS8BmcFERN0vvPN2n/ae23HRb2weTAPYoYk=;
 b=SJ9XHXr1GWqqAfawAiVaQDfWzQSMoEzCrvSgBxZeo4qHgMeFH38nDRPMHH+PgMPVqBTKl8w8drdBtp2ngR5FS7zq3PxliEFDQolYTOYhtE6OHMCldAq5W2VB1hxq5wd1X22b2XEuRyrjvYNfqH1pmECCHiytyhl2tsZuJPwXSgkMpyAtEdmsB/IQKlYS+r7aFPHcaHSvlqQR5wOXg8sqeulUULIs3x0SO428YMwOO13ExHGEm5s3gjrD6hMU3ztHFOnhJmtOFyhAbzAoBClOAlM5u+QRkaO7CdSenVZCRPtRH26e1N0jXQFr1Dv5zdIUoZFmRX29DpmW4Sr4xicmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) by SEZPR06MB5811.apcprd06.prod.outlook.com
 (2603:1096:101:aa::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:53:40 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::e5) by SI2PR01CA0042.outlook.office365.com
 (2603:1096:4:193::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:53:39 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8F25041604E7;
	Tue, 10 Mar 2026 14:53:38 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.chen@cixtech.com
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v2 0/2] Add scmi powerdomain for sky1
Date: Tue, 10 Mar 2026 14:53:36 +0800
Message-ID: <20260310065338.2337761-1-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SEZPR06MB5811:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f5d507d2-2446-49c9-469c-08de7e71c2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	f3GOZDbANMrTxM5wdUneH4MIV3efd9M0DA9nbikyon+JHmZzHODNA13gNZQ//s5CrpBMbfzAquZ2F8Qh2wTs88VEL9gDQ7Atpeyw+QrpP3DFSMrLhIzp6KFJ8m5IKvDFtsZgdEutKC1XKGse89xHk21uFJQTmF+edskXJINOJ0zdYrIyrEhTueUHsAfPMJURun5Domen4blBRKJ4rQUJSYguUtQT3aZ65LBXez/yFbIS5Qr8SDvIVRW5NAHv50Wc4XwOwhnPI9RCL1l4ME9SyIQI3ZIvPGCsjr4B9kD7cycc1jL8veWdCx8MoeLbNwkmGWQypT/lwiqPrbvgIejCRvBLm51yId1n7+i4ZfbUbtCenjbs6s1tnP+VYQuEZkIEE6UIes1DOnoZjs+ZnTw/ioavCoS2tLgW3IOciqMgcaxPO//r7/0tazA+p0txWvXKoEB4JUtjnvcHP8DeGNbEivPPehhFxRe5v2HGpfOMXCdrgXVrqxOoQLQRkHiBzvrszGz+1i4AlW/POK7aUW7SRImTxd3IZ9HPaqlZJz91pMkUxlNZbf6OuIqjg+jHs6HbNqVkMeXy6u00z4ZFWAfF1QHJKX8hBxPzrERrnkbqMH69P7m0567ywBec2mzDl77ObYTl+/rXZ5d5urTsxqxQV4QTlorb8CulH8Er8291IkVVsuvfxy2+Mzj4B14M/uvkDb2ZI1u/uFYtSRQxbaoYwGw4C/K0S3IgEXvWuhgKqXrFEpvLjsn36Ap7j9gvzaXtr4TURMiCyR0diYFG63dE1w==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OCPTuF6oquXzFQSMKWCiKcbiTRtBTBwPqQ1WBiUZYkxUNT8PxVkBuuVWFoCqCTiTXjxqIyJ2apC8PjP8lL7gwRqSb8EViN8Szwh+2Uwf6Y817MD46Js0GubzMBd9KHObz0VgOzQAVa8GvWheoeTHcJEEb/9isjfVwnAOLe9EYA9qd8TG5qDjDpaPkKao2q9sThvlmsW6VWPQOGOATjjGAauhlPc8wcif1Nb+T6kgrvlGiCICTPVGkzyIXHEkNXCNazDOzNgKvzc5C7hOR3LDgJjdf7CxoE0UQkFRe/uIXG5UhBNtIF9IiymD9ahVGDPnsqgGEIiTtv5NouSM2w9RnDMkNuE+HDqnUPG8aZ+qvv5bT+DDq4HB96dTpsWpWFv6mjP5j5Ys+zP8p+YKcpuaNi+frWFdhgcVovPUUHqFHIzIHpaAHPHo//t+FQYk0+EU
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:53:39.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d507d2-2446-49c9-469c-08de7e71c2c9
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5811

v2 changes:
- Pass dts build check with below commands:
make O=$OUTKNL dt_binding_check
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=cix,sky1-pci-host.yaml
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
scripts/checkpatch.pl 000*.patch
- update dt-bindings

Gary Yang (2):
  dt-bindings: PCI: update CIX Sky1 PCIe Root Complex bindings
  arm64: dts: cix: Add scmi powerdomain nodes for sky1

 .../bindings/pci/cix,sky1-pcie-host.yaml      |  6 ++++
 arch/arm64/boot/dts/cix/sky1-power.h          | 34 +++++++++++++++++++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 22 ++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/sky1-power.h

-- 
2.49.0

