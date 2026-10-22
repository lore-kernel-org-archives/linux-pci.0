Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792686623;
	b=tmOwQl6yP6QLeDkc1fZEzkOCp6M9UPwIic+9OYP+atYQQXkb8DDbkqSteZP61fWUmGm5
	 X8H9sjXbMY3ovoY6mLiKVeAkFOa4LJMjawYNkdzDj+HthsXOJqaDdQQMb8bc3UsCS2Man
	 W1pwZ0NduNYafibDZnXTvVW5lZDqhJIJllzU9/Aca8Y9hzDIh+VvB+WwXK8p++NYOOgOF
	 O86N72oWb5rtesMcqhby/VQK2BVDxY9mxiYk2DhgL8tuNtY4HxHHhjm40Uig0sCUdk8UO
	 xoaG8j9hoFzIFxITXrN6I5R3b5iCjFL9BrxxgSTXp6SZqExoaBn9+zHgELDHGBRhAKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686623;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CwMT+VrHaSOm6RhYgZ1wrmIP2lYYLpaYBuZobeicSkM=;
	b=sFY/fYU19llGBzIKJN/anjmkmFRmCQTdZLg94Hv1de0zyqhzzJeAugKlosAEow2weUSf
	 nhLaV+yENQN+Xt2fGELzQWsdmMXsHA6HJtY6K7IipB6roai+KL5c+VleGO5pIR03s9iIR
	 OdUNaUdNF1j4xeHtuch/7qVw3CnlKHYJSXYy9D1g6JSqCSZu7wRf+0dxUevq6/5BAT0Kv
	 zckMmCBpG0hPT8QZMFV2p9y2nTp3+oCf38yr152FuEfGXE416KPpPMakgChtNMckRVpnM
	 drB4WO9evXmChBIWK5y9J/Yux9BWN7Wpa2H2i26nIAfd7Bl70JTnlV24fvz5uogVNtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pzl5jWa2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.68
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652E606A31F;
	Thu, 22 Oct 2026 16:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1652E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Pzl5jWa2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTCRqJBz8M55leACshfm0O2+GwI0i7Y4Prq9XGBwYU1bRJim07LyneTpMUrvN0vsyIp3xpm0ywUnbtIPJ+eE1Ji4aCQz3snglMklogcdPRMAcPxJSK8wdpbculm0PDSvp8s0f2h9mQnxFwSTeg4eVmO2tY+j4qOB31phsfaUTDTtUmqS4fNHSbhqARvni3ZkeAs/wz1cBY55XJqGlZDm8Zn8l7XTJw/pSqnx4IdWCG2FRAsis8vFCbZFdoSslZ/YP7pAxFmVy2JqZyzl9pxAZaiEcYhgpzNld8H0LLgl9OjkR6A4cLFyDIoBJAcv4Gr5msbjFZ8YDUsluhkAZ0bW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwMT+VrHaSOm6RhYgZ1wrmIP2lYYLpaYBuZobeicSkM=;
 b=VmqhWNGf009zMzIk00LNyUII5ONKEsyrB892IYRLzMj4/1zGG1GfoGTMyV8/HAtGUJ2xHg6pmqGR32CsIyw6RvzFJYIjE0ImpLfqe4ZTyKERGCqeCpylBrEdPatcQi2FSpP246Tu7jeQgqhYZ2owkgQ9Z/3naILvLmI2IaRLeDjlMP16l5S97vz3mX/eqz6wEFPvTjhfB4gI2gjtfF2Lq0Lin/y3ND6AIhzB87mN6q+uTLL+J15y2W1Xk4CBBIxVyTmYQHMKy+jU9OqELeoF66cQQ7lhqkqwaCh4CnrAN2jQ8YcRfzw0tEUjpXDk1qSkyigKgeh5quf6wePifu+cZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=hust.edu.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwMT+VrHaSOm6RhYgZ1wrmIP2lYYLpaYBuZobeicSkM=;
 b=Pzl5jWa2An1XhJdKxRSnbhxSgHfwMBFVsqIBkS/6eA4WnKofFlzSsKZGh4DsAS4owXyoWIdLK4d+EvfWMY+ynMjmGKjLBw3XcOZ9ARRhfZx8vKYpcjGdzs0Gg0EmAD3iWwAA13NuKobJ4S7yHZI+RZbuOwWLRAfuTydj5IVvn0wlF0yPzTN96ojZcDUKJu1tfJ+tq5CBw0+MDBC8qoDZ8BvJtN/5q6z1nNAEbWYAPbwpPwpfx0Ae+J5T4ragbxW0PCQXsV6pvor3Uuujvmh8JiXrLZrBomPR4N6q4s5djPHdK2Got98xkSeEVArmJHm7aIj8i7XNaqL7t14QOXdzPA==
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by DSVPR12MB999309.namprd12.prod.outlook.com (2603:10b6:8:41f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 16:30:17 +0000
Received: from CO1PEPF0001885B.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::95) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Thu,
 22 Oct 2026 16:30:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF0001885B.mail.protection.outlook.com (10.167.249.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 16:30:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 22 Oct
 2026 09:29:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 09:29:49 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 22 Oct 2026 09:29:48 -0700
Date: Thu, 22 Oct 2026 09:29:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: =?utf-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>
CC: <joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: iommu: PCI reset helpers' lock-free entry reads race the
 iommu_device_unregister() traversal -> group use-after-free or NULL  deref
 inside the reset path
Message-ID: <ato5+lrj843ctUE+@nvidia.com>
References: <2f9a772a.14c19.1a163edffb0.Coremail.xuhx@hust.edu.cn>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f9a772a.14c19.1a163edffb0.Coremail.xuhx@hust.edu.cn>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885B:EE_|DSVPR12MB999309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa1d4ea-3abe-4a65-ce75-08df3059c0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|5023799004|261021123027099003|261021121427099003|261021135927099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UFyX4iPWvyaU8m60fzRMONorAq3mrwiXCpqqP0etasMKIETq1tdeCqTImLdme8JfUwfFKnCGpfjUd+z/GTZgesIKfysqTfWus2/qoiTqlnO7EabniagkSz+FeExXPwI6jtuBPZsNOctWuww94oId/e6n8uJ/UkC10w9BzrP/Xb2xlDcPO+2Jw75nF55bBbOlmXOELN8PtSM17WMayb4DtnxyIOXO6cg9yhyaGE1JIhDzwSWWr9CJejUR/9PWj5PJniNir2CqDk7rp3Q+bVjKs07NqqJsqh7jDsIEqsvSFTcs/8RDYqWz9gHwlGSBNc01bfDy71zGiXlw9aQubjmeFj75yAKOppB2UUFZycd11UjQXJj5M73jFqNUnknceI0fDVktZqr+2TwpY5UfylvFb9Y4uXeldg1mtuTbyrlvNhECHN2IDUnGwTRzrXsFUq2kEQQaqytTqVQkqNdYS0tIu7zniFF6qiq99wVWuRxTW/r3OEPlO3giPClisybQBFhVnDdUVvFCUw4ltlumNNUuSlxQrYqtxWtDL0OAjyyDLoDzDmXBzsgBKdI1W8tzCiXaQwGGXz2kuYIwKSqTTFSL/mZ1j2eLvFxE8VuVOk8c/snyCC8Sc+5xD0jZ3BdzeZ4XuJaLr36ZZ439MOdSrjukjBxOIJji7KKFwXL/9SfMb/wUOmhOfJ++USJUJE2BLfygjk3t3UshbZzWyzga2rCxqA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(5023799004)(261021123027099003)(261021121427099003)(261021135927099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eTVY8hOz93NNi27aMeHpQPPp6rBfTvdLh2GlFM5m0YljGopZbjidQLFxymkYv5LiaXau1rgGBy7KxwJiiB6kL3HShaLwaljfefE9yfx7t1EzuMiBQL/4XJ7dnp+/YpX5TQ5LHTTuuQVroGREW65bWz9Oqx+fLmMTppubSsifmX5TnBgaOgfgCRHTwKjoowyMI5SBp0VtEA1dNKbAnl+2rHCjTHEK456qPr+7fSYU+KRXv3TmkQYVT5HK+MGj/T7ef3nxkcPjwzMFdU7T7OC59vTWdWupOuebUyYzkDiD67ycLkNYLGIDM3BWCkKWITmNp44z/xWqiiO43Y20edeUnqbFETxrW0Afb943WUTYJQp02zrYh8f8ZrVthk9XDcGZENfb6Ot084WFJ8SwdRoYYn+WlqDI80HkzrHpBwsYHenIIPSrIlK31rAu2vJjaiJe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:30:15.0818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1d4ea-3abe-4a65-ce75-08df3059c0a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999309

On Thu, Oct 22, 2026 at 10:05:04PM +0800, 徐晗翔 wrote:
> The PCI reset IOMMU helpers read pdev->dev.iommu_group and
> dev->iommu before taking any lock, and the whole PCI reset body
> (FLR alone sleeps 100ms) runs between their prepare and done halves
> -- meanwhile the iommu_device_unregister() traversal can tear the
> device's group away entirely, so the helper's post-reset half locks
> an already-freed group (use-after-free spinlock) or walks
> &NULL->devices (NULL deref oops).

Unplugging an IOMMU instance while a device behind it is still
alive? That doesn't sound like a reasonable use case to me.

> The kernel's own comment above
> these helpers states the contract -- "callers must ensure there will
> be no racy iommu_release_device() call, which otherwise would UAF the
> dev->iommu_group pointer" (drivers/iommu/iommu.c:4027-4032) -- but
> the unregister traversal is precisely an iommu_release_device()
> source that no reset-path caller can ensure against: it takes no
> device lock, so the device_lock the reset path holds (which does
> serialize device_del) protects nothing here.

The contract in the kdocs literally means iommu_release_device()
must not be called during a reset. So, iommu_device_unregister()
invoking iommu_release_device() violates that contract.

Nicolin
