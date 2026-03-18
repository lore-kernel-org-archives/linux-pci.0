Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489A345751;
	Wed, 18 Mar 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862017; cv=fail; b=XBXxQL0MLmyBSN9He+gZ3qyPcxvsyE1sr/nh/BGDxzq39M2HUhqRllI7waAKOpSSQLkAVuWs50/MuDhqqmxSBtU+cO8N2egRqB9cJwMuSclY0bqUkdT7sYpFUvXJcK1QJQ9F1XIqoPKe5upcRBnK/enLK9Lx/qtmJrWH4drZuys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862017; c=relaxed/simple;
	bh=lpM4Z/vOyTpUw84N9FD9LM/8BrfGf5PLTjTVlVoUlDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFo8+7rL06e48mvQQP4lfeonxG8AR2EZndFaRa2Qf1UC6RWbSqP+kRVrghXtiarFDg0affv+QvBWukUYYJjpt1JAsDlqf84mIMFWfrKJshrSrMvsIsXFoUIumKqIpr1IsCMgdbDuy1uvonYesW29I5A8dUaaUdcsHtcm2ADr2HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lv806NN8; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lv806NN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTjKAs1V22LBeWtWBgk7/9ExWDHe8CuWxhuCKKjJOM7VXN27vzwuHUm8KZPHtsxVKSYgvgCMru9Z2FHTIFQFiuwz1zKQ5CT8p//7hierGOPA5jCUfgkzsi/CNqi6h85G3duvoVoJ1JYkS4MwnppB/HnfA+q7hHBLoapUfJvaQDsKBxwme58CMcA3D5VDN0LmuZmGPZmhWvFMrFoBvoXO9S6r4nUbQ9iTAa5ISJiiq6P8JU6Fxmuvow9EPD5zRxV/dB3YDOw7fJPGOA6ySKXqvnIM8ZFTZXDqXEU2TEdpQ0CUg687epN3SbuuHAKqV1SH2YMp5dKWU1F82yrbFbKoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg5GbH3n2Vmnnt6PhKArTvR2qXfFTlX8WywQsdyUHJ0=;
 b=sR3lNSO+h6+2ZWkkC1hB0MX3upPwWNmHMo/m1Rcc8IB2rqGrBDH5Pw/FFIzU+w10stw+/Ced0LaJ0KK1houjNIj+Ht6ofhRgfVjjdq92WES5qskc3Gfgz3hdD23Bbj7LqXo7/dUFbsudrvwdoQw0YQVkr1eg1RVhi62+gS5OtneMDQkkfr6IzTLKcTSyfu/krwwjWERgsfd12G2wzcR3emn6VbaVE5aXoL+epSr/YH13xKNaUJPExNg5uafNJQ3G3AGxKUYENI4Lct2VoH0EpmOMkyh+vvqx42fqxQCDCsoBf/WoE6eS5BjptUG2Eb5QlByoyzrhgq4MZx/rvTHGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg5GbH3n2Vmnnt6PhKArTvR2qXfFTlX8WywQsdyUHJ0=;
 b=lv806NN8SQtoJEYIAsrvUn9cyaAnj7Kl15n5uXlUjeVP6syJGzvZrjtROVB5YfcKGiW06IH5buqF+yTrQXaoHJ74kGvX++cF6ObCNeDfjW511nEgaO8oRfIhpE0/lyvy6gqBhZLd2YYZ48/NUuItCajnvnOsJhpLyBFMe5GT9MUuEAIU1f1dltKbegWaNUQivv8nbqZg6bGoCoc2oK8xp5+79ZvNkMh6ZyriM6aHKB+YMAoGnS9D2YoN44RfRG7mItXHKOV41SIjmdYt014hJzmgmira2udOBVSIZWahns9JJbWEC8CHF3rv/fHL+DJ4CMPQpcylkJyS0XjRu1NflQ==
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 19:26:50 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::4d) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 19:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 19:26:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 12:26:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 18 Mar 2026 12:26:35 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 12:26:34 -0700
Date: Wed, 18 Mar 2026 12:26:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abr8aS/MDU9aeKu9@Asurada-Nvidia>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763AB181F5213FAAB4F4F08C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e883f9f-3ee2-4691-b448-08de85244d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kxpN4jvbP1F1FdEsTM+pvhF4zB8AY6CJHwbIQ+cEX2MBykdV4L8MPeHH9iBD7amj0T+l75ru1YsnO9HlndQgJFgEsg7rHb1xUj6XlLAVk+oHodrjjPIwz6cN2HvJaOJf6I8q8+vu81CCAe9oO+uFtlhJ5+u0RLxRL1YmCOzwOzUkHQqHmGd2cTqdh1HLBYBcftl8/g/A1SoaLFhxcm3VtCM/C3Y6ZLP4UvQaVJn0VRZ/W8gHfEhNyNDC16cxaAa6QvUVvjP0BTtfV84NESOa9w9O/8RE9ntkrXsChBAT3UmvKHePdcmkdtu8HIbcO533W6AimTyuGZZjv7VMAwWYPCbppKatlJtOt9Igb1tWHDLAhqedy8cph/VSDKIWtWXg3ukK8ZBmh5sqWMTmUkgSo0mM72ovwqNFzpf76h1st83tBC/oRV0B56QmM2St+MqBEeYXBlr6cohAbX0yBoKlnJgy4UMLEuF34PSVW/T8hjWrWsdZoIetoINbllDlZFzAIOD88lNWKiq9FOBTXaWuaO7pQMfcrq5Ujrz/SziQPZHFCsMMcQKoZkaKq5kkmP7cZX+rvNafzEBJd7ek2o/xQ0cGCNOv1KW4ADQHWxDGQ6WWdMh7LuHW4c42iY8ZjK7DwxQNie4W6S0HqBiw34f6qYZIKBa9R2fANmN9rQiKj2ty0zFpFd/v3L0i24DPKWCp0a6DzmNKccechR4IOw5S6+7l9ZwWkI32tT++Dx64skjauzbUG3SeOoMgEEsH4GmOoAMgiSGVq7PRJhZMt9tSsw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YYlLSu6Ay2AZCfHdpZjmCPd1LRUdoerWDCwvm7yMnHXz8YM7yECpr0ABychwB1LO9HZBoHPmp/7557T6jNVT9di+LHO2/Fr8xqaHXv528CAmg0AV3HeaCz/AtPpfMBarSrRs0+8jsMazmfUu4l5jufe4fub1GqlUFprmehdNzaRNJkaOnv7ef8D9C/HYQzZ1xUCCk1XLKdUfPB8YruRtgHDp2FAd39jc785e5Mqq4ZvI8AHG3jGFFm6M858tlifsouCl9B4ikzNcEMnEucLNo/ToM1wzuydBfhuNmDokQPC555twsAgVjP1V/ny2HVsZrmLtMlGG4FnxVp2u7cg3ZmrnDj2eH4Pba91ZoYShfx9kA3073o8GYbV/4MBeg7IMYV9lFSBCJhTjEum9wsrNXQHpS+4W2jjscAqfNffIsB05oV0LuwxFd2Tc+/hY8HyO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 19:26:49.9538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e883f9f-3ee2-4691-b448-08de85244d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348

On Wed, Mar 18, 2026 at 07:36:20AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 18, 2026 3:16 AM
> > 
> > An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
> > aware of the timeout via a GERROR interrupt, the driver thread issuing the
> > commands lacks a direct mechanism to verify whether its specific batch was
> > the cause or not, as polling the CMD_SYNC status doesn't natively return a
> > failure code, making it very difficult to coordinate per-device recovery.
> > 
> > Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
> > gap. When the ISR detects an ATC timeout, set the bit corresponding to the
> > physical CMDQ index of the faulting CMD_SYNC command.
> > 
> 
> It's nice to see the ability of allowing sw to identify the faulting sync command
> upon an ATC timeout! On VT-d it's not feasible when multiple wait descriptors
> (similar to CMD_SYNC) are in-fly... :/

Actually SMMU doesn't know which device is faulting when CMD_SYNC
follows ATC_INV commands for multiple devices. The commit message
in PATCH-7 describes this in the end. So Jason suggested to retry
those ATC_INV commands by bisecting them per-device, which allows
us to pinpoint which device.

Could VT-d do the same?

Nicolin
