Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80782375F9E;
	Tue,  3 Mar 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522469; cv=fail; b=Uui+cfgFuDwj2EkwhCQwseUP24WXGJ/WA0rJ33NZ7WvftiLGABB68I7UByiWK/WhDs7fBxV/fkwNTu12khmZ4aBhIQZveCzKJM/XHGBva13kmV/GJN1kFBbdpEqTNi5+5+jkb4Gkm2IUAsR1a/Ff19w2LAhd+rnB66DDsYh7C/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522469; c=relaxed/simple;
	bh=BPe775gDkj4tQ+lzm4BYCS+93393ElFrx1Y+/WoCq6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4HZ+IN/jmtx9r4UPQ4Ro/cGKgGGjpzl3wA2f51bygQLZF0zgttg8uimbTpotnUVWUYTJTjb1R7+wLs5Oqg6uZcHqStVQU9vVZSbPxAVnIuyeopXTMY3mmO322U5ro48TGU+6R/CMI7C3e6mg5uXfS+R8iUGC+JWKnHiY3aqjDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDW0p3y+; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDW0p3y+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMXJOmZf0f0zJN6qHAMo7nR8DahdGc5vWRftHLSd43q28KuG8l/a8Wu009oBk9HHY0e5GKBWHCVl036l4Fh3xAY/MLQdVX21hPxc4+69m1PyN0J7qegj3TX0Rwn0/CuWrSFHfRfJeGVIx4hwlLqcg5wwbA2BJgl7RoEJmjg+2l7ROPDjFmajuAGN9GcyjJnL+aeJxHp2sG0F5wroYZ2dFp6Ug4Gr8Uhftsdn9B+XTuDZ69VCebbz0VuaN8gHlpRJz45K1crb6UOdmJ/Edhhhsj4pVCoG6JfZF3UzJDslkwzsRLSqetlGMngsrBQ7mAZzdXLIcfzoa8ZRNEimo+aWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWzdh0II39Fxm4u7J5ZZvg2HV3q/4bXgroeA9W8i9Dc=;
 b=XehStQSna9AX2RlzfonBzMr14f/xDDTrL4e9dnhZ+z8YKKuDYwrTtNI/zonWxUkFsTaa8RoMvXQLd7c1zDHYz+ewOwYWrBFKamlohGZFAUUJB9WfBoZWWGqjqzXDXoCNttduhJdw7KpjIjDNjnYqMwrumk/7nrOKr9xuvWxXrS1SFfHPQ3GqtEuzfN79YBoHIuWeaMZgFQaE7UpcJp2/+CqWhe3VVq+RZrQnxKfv1I5ZXN+jaIJPx8cUvtGvNllDcKJUQ71PrSNsZNmtO+KfXlsldaTB/lTjyEtol/GYv3yqiHKFfEM3IgE9XnAfCzDT0DA9ag/CRoyvyQ6prq/UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWzdh0II39Fxm4u7J5ZZvg2HV3q/4bXgroeA9W8i9Dc=;
 b=LDW0p3y+RltPMYoXpqsCbxsTqRc5VoLC+MhnkGjf15ZCUZYu2RmC71XZ1CAM7p5Q+e4/9f08nNqpdkVGxb8D7MHKXSkBHJSRBqqm1a5l8Aic+hMewZf9MchLuq9NThBDNVFw+pZgsmLHrzlEBqIG5oH+aGHp+n0MVCA656LDtv2T74tqXBYLRjdJSO9PsUC5aODA842daJ4/JxfXy5xA/aVm4XdHXrVKqmyxcRUKLqyo6RS1W2lZJZ68It+I2Afpube/c59M4WUDOlgIxS4gTjU7Dy2tHR2QiuyvInGFb1OLAWNnUGZ8aqwZKwj6mOingd7o7HDrnTyP0LQf8SpRIQ==
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Tue, 3 Mar
 2026 07:21:01 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f4) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 07:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 07:21:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:20:42 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:35 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v2 2/5] PCI: endpoint: Allow only_64bit on BAR_RESERVED
Date: Tue, 3 Mar 2026 12:50:01 +0530
Message-ID: <20260303072004.2384079-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a18cd8-3900-4451-8a77-08de78f56c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	WoimvbZuXyDzpcDivNQf7muS8jNC5NQQ+wH3bgs14Qf0d+2vYvjW/9BiOYuTc4VCUywg84BzSU0vP+NOmLQjTOUGOud5mv5o8lsKIUYUmzsBCjOP6D1MSMWF8qrBNX3k/Je5N6moIoSfZAJJQIYbqJqMDStZk18eRrGY/Ti8Ljb7XhPGSGiQQ8AaB/4bfwEdhvwlnhEWdte4VlJsvGnwIXvnyrv7J1HBZGqQH4k5Hyc0IWQmCTGJ+imP86vHkm9ReCdljW+GWrKTKe1gntk+CQBAtkVDjBytO6755ewhKHmQZpH0jMHiIxGu24kwbQh+yBCdziHetrdAVsV+6jEaau1xnnXrygcQQD0osF6OrLYR0N7IigcO9k6fmBBdZHHnaWOcYYlLNTgYDOOIxpaKGk4PD6Q5bOrCGrU8y0zWOqiFwIw9z8yyujtdFpM+PcuX/2GSYx80/+fbtaXH8S+0MbbgNhHUJgc6sg+rN8i5PoDw6eLdthMqqNatmdOXARkThxwB5wD+uUQSin9G6qycIB2uZAVrpqZYam8mUoUyaAmUYUsD3zmy8Sc2/boHuBcWbHm5Jx3zP7zFMwqrphXCizjkq+1xT/ja7DPwJDsogh/fcxoGuPgETQKSQyb+lFn1+EviDTaDIcLTIWqYvXVEiZuXb1N3YaFoHJK6qVPpmG/yH2bvo2kxydFjpHSRiI2L+KZx5sLFKNOOVZia5L2jbJGjUA92IhjbSpmf3c/cOCdJjlW8k9S1Tl2982CI/QbyOkyT0EMgNfi5EK9OzNiROLKxTybJWONedtPWK8Tohi4PkBNxR8vySC5+Jbxxd8Txz+BHdYqwO/TR+xnLvdpHuK1tBuPBXW3/WgMu13/WRsQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+j3VVjwUELStOvpzwxwjpL4D2Jr0Gi54tspAFMw7L5DhqGbpZkaLwPB6tRXnstW2RsZsTqmBLqoaOV/ydC52gjISA+9AjfaDkT9HHxqdfIqU7JJgENWAQ8o7pewGXxCiueEeJUSf+2R+2NQFFwKFT8GXeFVuGdEzneYayA/tE/YrLDZej2Rs66FAGwCJCAnKzHnzR2OTLv+cXtQbv0IY5lRAk7jOFMNMWHbH2Z1BKTWBYuBKXQUSMtbf41PXQ/abjwe2DXbZogQU+uciI5kATvd9Vem1G3xEhCAhqks9LLMDTTjW2mdesZVyuYbpCAKqHu3otdlsiVFGa8mS5KKLd6ctYwI81LOKgtNRnAoL1Aag3oVIpZ1lCcEPrqo2ic4rDHmSVzV+MHf6J9yH9JLDW5LuEAhHFAuktKj25TUg87KrtsljYPn8eSrnoHyobgUb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:21:01.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a18cd8-3900-4451-8a77-08de78f56c64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1

Remove the documentation that forbids setting only_64bit on a BAR of
type BAR_RESERVED.

When a reserved BAR is 64-bit by default, setting only_64bit is the
most accurate description. If we later add support to disable a
reserved BAR (e.g. disable_bar() for BARs that were never set via
set_bar()), the implementation will need to clear the adjacent BAR
(upper 32 bits) as well; having only_64bit set documents that
requirement.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
v2: New patch in v2

 include/linux/pci-epc.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index fb3f34829d2b..8ed000dbeca4 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -247,11 +247,6 @@ struct pci_epc_bar_rsvd_region {
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit. Additionally, the BAR succeeding
  *		this BAR must be set to type BAR_64BIT_UPPER.
- *
- *		only_64bit should not be set on a BAR of type BAR_RESERVED.
- *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
- *		reprogram, then both BARx and BARx+1 must be set to type
- *		BAR_RESERVED.)
  * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
  * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */
-- 
2.34.1

