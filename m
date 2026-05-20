Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D757250BEC;
	Wed, 20 May 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308490; cv=fail; b=TtnJIyr8NUOuipCJh+0KKmlcOHDbiYVIPIF2WB/F3DqUY3hjRdydL6hlyEUitdTQO3YxV3qWaC7ZwcmRShkDPKqwIB8PY/NUYflt7LKNpndbSCf3ukFddZLOrG5KAYDkgIkpMKg8fM/XccRsSIDwXzhpt49sLCifPiQ850LLhV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308490; c=relaxed/simple;
	bh=xyMgvDvh5NuEEdGDNzjdwCFyMhz5vOfYwyE3vkulTu4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSRGYNRMjwHPypso2+IrJuP8MUWAKo6yDUpE27reDYRm4sLrvQRf2LGR+Q4UIM7eSy+8MkuD7nwlEasa4UhHfkl/OcUMR5icShL62NJZsoXiYHHXl1YJzeBh1Omw1PcspJGLoy3ht8vPo3Avxl92t1i/xH0uf57+LLkFmcGMTCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/b2Yidf; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/b2Yidf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc0G7RbraxCVCalnFezqK80yZzhXVSvQKDYHwPAfURGStdULFAtU0E4V4L1nl0nVu6skbnfbkuRrHvyhcw8jRnHxZtDxQ47+l+/savdcitdh9DuPcbvtT7VM0+5Lr4umXo8rOeO361GACqo5Pl6o3y/K1pKKhqkuayIOl5CyNlcRHZuuMoNVdxJin2UpIaKWuSMC+fjjpOdS9WjiCQSMQaezg2ouns0d0hcTfuYFW3zp+kx3jczSyYEiGrPvfXquzKK3K0b7numtm9dXezMBB2geVMncrXf3rnqSgFEI7gMkz9xpYEh59/jp/B1R2rRYbceMYzuWipOP53NReYWpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RH5zBbrHey7ErpAuSOg8WE/nVbhSTHW02XjRi3wR/4=;
 b=T5Vv0dpIV2hEc1tVmybxAKmguBdiXnzbusLD0xFB37fVX1TV6CB5NgjHTwYymLMgfP0lu6gShRF4ULo1zLbIFNwImXWC4N5DAgDEvkOVhULl8ErEbUO0Ah2HSwwfYLJWA9ujDDkZlsM8SJx5/A2+p3I9l+5WXMfRMT9wUiTqJXwPnQqyaMrPhUUJxTTqa1bIRAgg0CAgOcVtlHqbhDirg19R0cKFWkSr2isNVAuruBblzAIoFrhmqkeUxtD9IAbLrzttNjVdiu+VivSEqex6Z2lBR86Wfd+7Od0r0aLoibEnM9JrPPw9l81rr4633JT9UiFtYNY0oaBSeOq/x3iayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RH5zBbrHey7ErpAuSOg8WE/nVbhSTHW02XjRi3wR/4=;
 b=p/b2Yidf7ZP9fc6bupkLqCkdU9wAziOIvXqGc2ZPR8jszl6JCzUwBe/mXl/eO+MDXVOQddfCxfmw0AW1MyiS0nJQIGrsN4GOE+/HYIhvbuaNoACemu3pn6sytM0enBEcvLF9+MsOaMAqYuLME1f+8cLgZ0XyqMLQuOeob5wdE1wNblp3zO0jsqgNuhuQTG7vtugoS4E66qpQ4zOXl5iV55KOm1REnSbQlp1A4nBlIsbDJt/6Oeh6yqOjN3sCgBXNdyarH4pNhr/7luwGvba/8KYTX/bPOk/08eH2gHGcJyaOeR7KkGLlybJRy6Qj87badwdoyqTxnKuUPBX9XAy7Kg==
Received: from DS1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::13) by
 BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 20:21:21 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:453:cafe::93) by DS1P223CA0005.outlook.office365.com
 (2603:10b6:8:453::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:21:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 13:20:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 13:20:58 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 13:20:57 -0700
Date: Wed, 20 May 2026 13:20:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <robin.murphy@arm.com>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v5 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
Message-ID: <ag4XqCJ/HW0IZ4BI@Asurada-Nvidia>
References: <9e01e6d39deff2bf751da3e1abb43f35a9169194.1779304390.git.nicolinc@nvidia.com>
 <20260520200327.GA88349@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520200327.GA88349@bhelgaas>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e7a6f2-4b0a-4b31-6f71-08deb6ad5b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|4143699003|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PchQzq3qE5Dd/GhetMUBW+Z//GcEPPmJVhvJbRiy/INE3jCg7kMNb1vr4LAQ3fMSTuc67vDQlBfymX0tcodQiRqCreV+gWxKebAxESxkFHXayodVa2J2X09hP9fj2BzzSsdm3AeY+TMBmawgXwf2gDKhr4kkDHmmR4nc+/U+qELEtOQaLigTzm0XjckbxjRgjOExLyx0E0igj5JBE2/JDrSG8LURgNi9PVwrCFQb3wSGPoRRS32Bq5CI5sj/Rff9WJmCmR7iLUwQ6SeySfKDqlu/X0kxSSQdB2Jrs3oHblT7/iwO22otoIFa6kG58rTUlkK9rmwbqasr412u33RWxbRRHEAi8wHaBmG8RerNpXT/hWjrdhm9o/wlZur6rSAEZBglxRDw1j3tEXLJevjhrvNsdAepbYiAAK+SX/rTXGkBitcSHYiWEgDbXh8G/QS5POkHAMZF31VD9AmBfdU7iYCE0TPmAFRCHXektb14cM7gH1t6iP7aQo9QjWQJoFIVBzAWjMIhAy3WHcEayLyn1ABuaD8nBTSErav5MfABqF9czfjXk9JWfYVTkCKsb0yUho06znIBfFj7tsoZB/JI0yf3WBUsvnZb92FuXCSpWxtsh7ILyhCx6tAxQGzmWzHIyH4yngqX+F1oUrdaXUYQgJUVNwLgoIEFZWEmKS3RipeClo/L4WjiVIlEyGgh66Tj4AAxMRhN3VmGy+CbKn1x7Zruj+oCnhwyVqtFKOiPuaU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(4143699003)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sy/Am6Rc2e0ig+G37KAzR4v8CiN8SCT59b/zu+CmXroCcFUg9Su0Y8Pr+S0XqLGzPIp84pMdo08H0eVMGlYtD8xFVRLkmJG9cbValxeriW9Tc1hynf7qbrfs/vFwJSBmGIWfNcfl5fltD/GZ4sP0mlsnmVxFpvLiz/TlkeJ6B2RZmk6sRrdyp3w6aqgdmT+NGjZxViYYOxQ0hnQA/9qi4ZLBXJP0q6U/84+gMyz66s6PKfOstoauIx65gNpN2Kxxx4bHfRqbHlUDU44MJIz95p8S2x6OGQdP+yXz9gWu8tKVjPtd92ZdYoZN5D5FHvqpVShYaopnenZ4vEtVpG8bfhg+UpemVFsvkK8ffhTmBB7r2MA3T7r64cpoJh+cXB0O7AQ0CS6LlLlWs9ZsNHFo4+X2Q/CHter5GRMhq6XYxODmGfXGSUXydpApIlJR8BCQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:21:21.0462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e7a6f2-4b0a-4b31-6f71-08deb6ad5b62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

On Wed, May 20, 2026 at 03:03:27PM -0500, Bjorn Helgaas wrote:
> On Wed, May 20, 2026 at 12:46:08PM -0700, Nicolin Chen wrote:
> > +bool pci_ats_required(struct pci_dev *pdev)
> > +{
> > +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> > +		return false;
> 
> I still have the question about whether it's necessary to test
> pci_ats_disabled() here.  I think pci_ats_supported() should return
> false if pci_ats_disabled() returns true.

Sorry, it fell through the crack.

And you are right that. pci_ats_disabled() seems redundant.

I can respin a v6.

Thanks
Nicolin
