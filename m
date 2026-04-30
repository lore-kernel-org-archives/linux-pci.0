Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6081ACA;
	Thu, 30 Apr 2026 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591735; cv=fail; b=SU/ntVzSKYU2006Ij+kzh1Bc87MtkKqBva3/s/fXY5+xsUFL2ijXudTGKkPRqP1BaFapzNtcwx95tcjK0W83wTI0u4lFpHMSlSQnvhJdDLboTzYnnO7WtfdMy6xcU1MOF9spndyyJSorwoKq/jpNa2SMpTLbhpNmWbx59zIh8+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591735; c=relaxed/simple;
	bh=6b9Vd6TlijgcvXMNJ8qFtyei7G88cZrT4mbPgr3T/SU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEFkSY+hni7Nh1RSfOj6Qs2E/bd5+fjR0VYnlcKhMdEgUBDYlas5+Hj/hoM2HOXu765UNv7CaJOmzSZJ6kZomJtflD4vWzMP5tu36AelZv4i4yKXu7jgyehzRUw+UhRr++DilZKahpCPbKjNYgtvZcEOFc7n89DdlNDMMMLyPuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMLBm6kV; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMLBm6kV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRUBYmhAuYfAijpbVwQQ6MbIu/KB1LGUpheZWgJwUvzR0y0XF0IJMzOo+d2CfeCNOEcgi4eCHrqKv1DRwveKSSQ22X2Iia5GQcw/dFy+VL5wGVfiGB6owb8a3fqvxmIdOyvSHrxRdQMaCdmzLWj360QBs4szUiP8pylJFIXWO8anTE4nbGn/IJ5AmSd3j35Hk69ubIhyV0w3ADKyAWGyny7Asq+8NeBvAowCQcp4trrpfJbD6zAzlk/xtETLlWUKGdfDun0JR53REdOrQamzXCtPXL9UmbH2Z2D5GOCh+MxYMleIMI6nSY7zuITQTQ28z8KrsebbHBV0zMIE9fIx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5eETolv2CRJ+KGuzqHXNWHz75SkAhmrcTAnZvVauEE=;
 b=DcEBcN4HBFB8NWFbLvBWERyOGFPSntjOFSqRbi0GMnmezSqbxkTA+ehmkCGBQrPRj1c3HtOcoFPwBaDuK0DCHoJA89sEoEO0sOGlA5J6nojLKvgDKaCVi6ymK5+NXw8KGoifvj+7Y+KERpXkiMybXtfyR9apmccjBlXK8P23Ijx8uoHAivTItFD6Z6wqiNu3RzkDO61xi48aTpolc6IjsJcwNTuHsVSvQP4Z87obrTjMOrZbUd0DmOi8gRNvfnMjD0qRso+vi1OGvi7KTWaWDJeTLgYZxJ/BW6i1mi6+/5HXco0To9G6e3y2AsdHFzdp+wHB2tp0cfkvI2346cY4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5eETolv2CRJ+KGuzqHXNWHz75SkAhmrcTAnZvVauEE=;
 b=mMLBm6kV3YOXYYJRO8e/70BpjU0vtzzslFfTmDnSUjzo0eu4teU98t91S7Zuhi2jYjJZ75CdkSXrA+ebqHf4wcc/bHafQBH905u8wKDSpG4veX7yExnCUY5Xz2/XnjyNmSYrWYXVWjKJZx3nbcH9jW7iZQPltdEg9LlmQrjMx4YKhfjIWxEWHjWvbLNxCx669JFcue4suZSgwJrExaE7p8LKG2zAyTDgbuVz0xa+OlWpUHaO6xWUkd4UFcXtSjJlhe13oLDjXL8FSEAHMZsKnAH1uzL/E3gnFg1OxHL0/v+iHN5KUv8aLQ2OfVcK21bISyOcGu2B7xNOm9BKs3al2g==
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 23:28:41 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::e1) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.16 via Frontend Transport; Thu,
 30 Apr 2026 23:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 23:28:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 16:28:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 16:28:19 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 16:28:18 -0700
Date: Thu, 30 Apr 2026 16:28:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <afPlkW5zlTSHwQCT@Asurada-Nvidia>
References: <cover.1777269009.git.nicolinc@nvidia.com>
 <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>
 <69f3cc82926_3291a910039@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69f3cc82926_3291a910039@djbw-dev.notmuch>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c0172c-c533-40ce-6828-08dea710366b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Pa5XL9cSlKqDuP7K5er0RtlkfJlY6adNW4aBqIePvmlGlf2io5JMLUpDrZMmdQCur3kdjKuKsbw+2PBDs+vWOXxC7HDq6oqqUdS5Zf4lsh9yCoL1tgkKZ0Zk+CfpKPzqNYFkzrq2xjVgHcBbquKg3o8QJuKC7d5Pce/b5InXoVQ7UUw58WAVmGFA1j1KMC3fD/Sg9twNxRIf+5jgXNx4xq7ot/gEgiidMJwMmcMKrjhSuABFeCwkHSY5rbP3LZrxEUaEsKY/swl/TBkd9VJgoBKwutwRHBEMMr4hh6jw3NCPSQ0MP279pS+hbV67Tjc/6uzTB7dFchhVPoFJ7mLuyhLtlpFd7gGgZC32H36FKdTOYr/s9vW8VCf0K+q5E3M26QDnEqL5Zrbyt1u1eM3Xlzgwg/SalaFaO5A8feXpVicq18t9kRy5W7sXYkQShKQOCQw8VXqrFQu6MkFVbbVqaQZ3gbdxG6p9SppQdg+Ce9AgX7Ax+PuIgH7LzQaCgBmBpZZk3mr4PBcfze4eTUdhAJfMHFJUgN85lL7kO17xprhTqPKI9oagtLzBE81dJR+7NxosDbKEH1Cnb4CuskLgpEduiwXIHObnCBmR88VGCgSAQRkl6uqpv1MebVQBU/3uPJuxYXlC7QsTcrRex+XSdgssRX5RVRYkrc3ncp55Nh/hryWNXxV+mnoqzN9SC0NfIYbsFk4zSWuSqV+fCf4S/WD3DVhHFz5ZCnLog8eFES8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5QRvdu2tsMZaZN6LaVF5mfJKTnQpODLoriiYBkjWTsLktvO7JrdjeDySsyOcq+ZSbIbea/2/wMMiUp3qI/TmGNNtk0phWymDrrdWo4AJpPyKM5Mi1oZRe16vqbQ1AIOzxtEfhN+IOcZAwsqQ5M9Ka6FjB5Ddy+i7rreix7amE3EoJQywtaWvJGx5ZoGzAdgmpDcMZBAaRHGfpFPFAA0Aag5WcwpfPpElHrg6+viV9PBu7bskH2EXw3+rOuwHFDQ+p7so24CPzX2Jc8bGmEtGw/dFSMtvw3dX/jos/Ra2Ad4ncIv5ILL8egmbbzTOh/e367j/Bj500kSv7oSlgcRlcIcHTZVtwNBDBM82yNmqjrekRkbYDYO1mcOtL9tzY5HKdNU0z7ti4PE0fcjbuapGKbdA6cagOm54xxrC0Q4opB8n7e2kdOpNIl4pPvil7MNL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 23:28:40.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0172c-c533-40ce-6828-08dea710366b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

On Thu, Apr 30, 2026 at 02:41:22PM -0700, Dan Williams (nvidia) wrote:
> > +static bool pci_cxl_ats_always_on(struct pci_dev *pdev)
> > +{
> > +	int offset;
> > +	u16 cap;
> > +
> > +	offset = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +					   PCI_DVSEC_CXL_DEVICE);
> > +	if (!offset)
> > +		return false;
> > +
> > +	if (pci_read_config_word(pdev, offset + PCI_DVSEC_CXL_CAP, &cap))
> > +		return false;
> > +
> > +	return cap & PCI_DVSEC_CXL_CACHE_CAPABLE;
[...]
> Apologies for coming to this late and forgive me if the following has
> already been asked and answered. Why not check for actual CXL.cache
> protocol on the wire being present?

Actually it would make the patch smaller. The thing is that this
is_cxl property wasn't added when I started the series. So, it's
not using it. :)

> @@ -1733,9 +1733,8 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  	pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS,
>  			     &cap);
>  
> -	dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap) ||
> -		FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);
> -
> +	dev->is_cxl_cache = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap);
> +	dev->is_cxl_mem = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);

One caveat is that:

Here it checks the cap from:
	PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS (0xE) via
		PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS (0x7)

On the other hand, mine checks from:
	PCI_DVSEC_CXL_CAP (0xA) via
		PCI_DVSEC_CXL_DEVICE (0x0)

The spec mentions in 8.2.1.3.1 DVSEC Flex Bus Port Capability: "
  Note: The Mem_Capable, IO_Capable, and Cache_Capable fields are
  also present in the DVSEC Flex Bus for the device [which is the
  legacy name for DVSEC 0x0]. This allows for future scalability
  where multiple devices, each with potentially different
  capabilities, may be populated behind a single Port.
"

Not arguing that set_pcie_cxl() is wrong, but I am not sure if there
would be any side effect to rely on the "legacy name" over DVSEC 0x0.

Is there any CXL expert who can help confirm?

Thanks!
Nicolin
