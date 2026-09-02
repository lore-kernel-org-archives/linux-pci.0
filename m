Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FF4AC144;
	Wed,  2 Sep 2026 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376246; cv=fail; b=SmRBb8ZTAf3nzDqlGF0vCZtJYgCYHGnnuObvP1AHEK8LtNda7f6OGP+NXvc2uZFaS7hDPYJCG/k+cjnxGwyBEPp8vJjcGGDY3bSbW+jFsKF3aaNbaEkLB9Nscins3lLcEvFvFnNPmby2r7SnhOfNTJhMFV/uSptwvE/71ePKN3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376246; c=relaxed/simple;
	bh=M0zunlwlTFeo+etMq6PrnhDZsmRoJAByUaE682GKRJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw+TbCZPQzDNkrrwk0GGvHad1Lb+AnR9vmvp7mZx3VSDyj1HQUqS7grhMRABO72ICrQ1JlnqAMoavzqNq9QvsAqCWiVKB9WdByn33/l+vl5duY4W73nbPRcn0wUMrSrIkgjg97d50dZcJBlLYtzW8eRqfswiGjIBKW9haXfZTB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auxQtPOb; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auxQtPOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVaehO0YCBE5szqjKF6tYeHK2b/YqO5o5lEIQzPjZ+zsctVDgYptu6AbpOCcTg8crBg69HG8IZEt7W/I3wNwlABueI98VRHTtqrZybeSG1skfY8Scv39VyoZDlF2b224hP9OyYqUc8lNWK8W5SYOonxaMTcE2iViAjaqs9NJ7yvFJO48Q3w+fjjIr+iXpGYBc3/I5iuKvfdAmSI23KkUngo8brNCg7E7pzR7gjmjgRVsN/EYs6D/DRV0id/eJ7PBRLAxdlDGVkYwIlgriKII6GLmHWaphHF4E6NgRBs+FmL3WocxhZM5xJ0IOCIE0Rd637Iz6WnVfFtPT5wTLB9IPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0zunlwlTFeo+etMq6PrnhDZsmRoJAByUaE682GKRJk=;
 b=VI09WJvmnyuMjOJDOcTR4PIg3KqNnq34tGNkA8pfRfhdIKHXlBxmUz1+skVbl96ytAwLmZ5TfmUBO5Mql3PZ1KUVvvhmId+OLztFiJWFii5RLpld2666wwKC38ECbvEYPhDs/WqDrGic+fn5QTaKIx+0Kr1z4XTyq8U8/ZxInMhUkJjs+Z/wiFugBpAWVYuu2sfLE7PlIpge8yP6sDGqHYSQwBKCTNK3TUcNJRhn5znC5GtUb90Zw0D6B065hthBkzk5+XH6GG1xdpOPA43muHIwxl8QDH2f6vODAP0+5GMc9JuxPjaYFy8e6t80xHq+XDKndFeE2e5qqSR1+aeMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=diodes.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0zunlwlTFeo+etMq6PrnhDZsmRoJAByUaE682GKRJk=;
 b=auxQtPObtFJJHSubTJXxN3VUyKZ2m6Tk9L+2qIGfSZYbUJa8/MNqwe09EKHofOYDbc2AIx3gA/11jXz3rXqe/dBSBu1WWjzXMYbVFt3jNVIZp/wpfKTiUFoXKvQGJYqlT6VUpmoAxLtcuVH6LmLrgoifTYiy9VdtSFURIKLlA7iApOi+Fy92FaawWU22paq761vnqjZZ5Aof/P3tlW60hphBxRaXwd43xwhSkOOV2BAU6VxCO7pTsFA5sXwVWRnrx1lctmmvtbbzdbtdO/xRipaDdNTxFpFGAd5g+oNa9xm7EtQlgAUj6GJUHgYyHoxSjGhGCg9ZZz4gn9L79wXNng==
Received: from BN9PR03CA0301.namprd03.prod.outlook.com (2603:10b6:408:112::6)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 19:09:24 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::11) by BN9PR03CA0301.outlook.office365.com
 (2603:10b6:408:112::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 19:09:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 12:08:53 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 12:08:52 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: JC Chen <jc_chen@diodes.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
CC: Nirmoy Das <nirmoyd@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum
Date: Wed, 2 Sep 2026 12:08:28 -0700
Message-ID: <20260902190832.1615829-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <SI6PR02MB8471ACB5D861E670331B2F47F3A82@SI6PR02MB8471.apcprd02.prod.outlook.com>
References:
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 213364dd-7c78-422c-e475-08df0925b369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tX3XP+iPSFYU2oANlIZ9xOn+ttKm+Iy5YcNjR5FEH6kt6Pe/J764hUS2j4Kbl1e1Tl3RxomaMQSyYhLIwEL/j/Rzqp49ioECcvdKc6pa/IiUDI1fe/BAkagPWaDibxpalfLE1SF1aXYnq9BD/X3nvc9Lh0lI564IbhO2Dz1rTzmgKLTAw7I/6gOsnymQCFykizVbKArkztpGaYsAKiU+cWHe4BveFQQ4A8yYCul7wYaT3JNYGaO7EvbCv9OK/BJQ3ige/TAsW8PJCh0bVhzccD+nq1QW6HKiohU9sVpcYZbziRYh+TaTJI8sPSa5WsLz3N1yB7cnnabcvMTx5hTh+M0kbnWAIwAEVUjWwD34Wzx8eXOUJ6Yq2rXugC/Bnx6q9FTXmyQ0o2VT6kuIsFrZlkcxVUpCgZwl5ahv39cYpyvPajNDnyzcSoCoyh4P2CiLCD69XC7wUKLCXprgwxuHIWZ1CwuXHpRETSZ2oTac+TGhHxmQ6m0zCwXtzUvIOysZ6dFfjOnXBcPytTMbi/XpW1hv0CxyUrUxnAJolEKfjIcuKt7/FJuMyBzjLO5+WPlnY1WH85PboOIQd5f97KnTNXOpg2MRwC1Uv538EX2i3g8AZCMqVXA9YPfOrL/XBpBJCt4BMg4fvvgBhUMaMTnkd40TUEyQt9QlyiVOBOyS+Nkc0IkKUg7eG69B9Gg8Wvk9+ZtJu6oLf0EQUtwtP5fywg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oEaNYFawuuHSd+dmVwVTRqt6S+swQQ7R7jsHLVl4Vq6bUbi0j5T1tn58ZgKpKh3aiFvEtCXcd5sdGUUUu4Qjd8Oo/rYChS9/LRrPN/NGniw/q9OA47vYicZTLVrpGVEsGFqhHXPRKwQLgWIYl2wZb1k0MDA2qu/v/2AjsJhrBiOWfvPmrwftZxZHd943A6m17XMOzKhu4PJgElHDJ1npWCXTFTkON+Mk5qF0MlGzrSlUWcNBOAj5aQKryWWfwkVSdzHWy/qYwEIpXGCiBK1/6HdKRMmIolYw5Co5Jbyoki/Cio5ZwthtYc9sQX3cgvMXZ8H3rUNAyYPFCqShTP7dJyNZ7EkWVOnj+KrCcDsGYuLt87cLLHB6NLuqCDnYNYHlxXe6k9ZjFm37J1vO7wDQHBB4HfbTgXMiQ/I0IjYxy+v+83IRieWOdop0MJrjELOM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 19:09:23.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213364dd-7c78-422c-e475-08df0925b369
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452

Hi JC,

On 01.09.26 04:51, JC Chen[陳饒靜] wrote:
> => P4 has BAR0 and MSI-X capability when CDEP function is enabled. If
> the CDEP function is disabled, Port 4 is no BAR0 and no MSI-X
> capability. However, in our design, even CDEP function is disabled, we
> still check whether the memory address "hit" P4's MSI-X tables or not.
[...]

Thanks for the confirmation.

I will send a v2 with a commit log that describes the mechanism and the
affected topology.

Regards,
Nirmoy
