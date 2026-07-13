Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828D30ACFB;
	Mon, 13 Jul 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967585; cv=fail; b=GRCftTXV1C843BqLYE1Dd8fe1NSrQfEDxII9Mkjf5NO+9Z+QchkuLXOlilOh0Zt/05RJlWg/81ajsF4/3esyTgRcMuP+QyLoFhxI6V5MrPVAJ0/wkZNfNC7Hpgk1iTORJYCDwYS5WKc2jKmI6JZG/pe96kAOwrLTn71b/snGgKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967585; c=relaxed/simple;
	bh=X6Popnr3OTSsfB1HRbMYKZKS2Kbk11x0aklf49we+Cs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7j4NeUcEvZZvvbUp5LvzMBfCIl5zOyV1aIqnWN0oMzTaP3ErJ70EqaGbfg6tYTxu9EaJIlXyeXArjr6GT6sHRCWicIPacEbImKU8BrBko0rDe76+wo0A8j+Q9ZgAbSMEBRr9KMJhQ7CBx+ZGlEsPu/NptE7stjjDZRH1dKQej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjq5QdoC; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjq5QdoC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujzdVFnS/1h34195MmVbsxxv2ud3YUDtijjC8sK3mbz82+TdEQnjTCyNcBxJyA2w5CFXA55Qp5v0MQpfQD3QdHUINBV5ee8QhlbN7voytzgVWn7aQFL5O7XO7lsU6geL4Jv041sw88idWC0KUDWD8pTrlS7T8K30tdbBJMzbLuBhd6Yq/yrat4qaJattdBsGBjDc3SQ6SxTKt1M3DqlAbt8Y/pazAj5DMylNTpudXSxAKBaHQrCJRQtaBGxyUUngO4+ibbosN+1HicDqq6TQ7P2BlW/Xs74PxGj17FIlK8Pq84TbHkQFyg3LISobnykbRcdUZmuE+rMahS1GJthYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUqXhUeTAqWDkZBRLyaY+scKg7wDVjBfHNOGNhA0gl0=;
 b=nMxjps2DntCXWHsx38Fj+p7NZ72KL20ccoDXrEu3bJVKl1Gs21n38eeAvT2uWgsGtHMl6AitnhCZPQAkmWO4PSaZS1cD9Qhb7u2YqF6HLDy/ui913cfwI8CqBuZmqGtNHcA9GNGQ34S7Exg+wORTGE09wyV7Y4OJL+RfxM25NTeqUVjTurr0y4nBY/9FIf4bWJ/hImk2N9q/NulflUok9E1ZqSvYd1A5lHHYPMM7n0NKNugX0aeBkMqxrpFphDj69Gyo2QViGPFEc2xY8TJmVuJh9VOzTaG7mfiKcnlyMp+AqXi/4+AEUdrSNzUNqftIwr6wGFUGyLeG4QAqzUM14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUqXhUeTAqWDkZBRLyaY+scKg7wDVjBfHNOGNhA0gl0=;
 b=sjq5QdoCVbOfUTCMAECQuvXFzXHULDxbAjVnUxIEU9BFb71M+CFd9Cpta0LRnnqkyNcWWTfI0Gr9xW+FvqpjPGvwHAEfrNQ3+i1DmIBNHKIFh1HXJxgwJuOa33tmn9wbmTIba3VE8OUAm67rZYZL8IIn8Qu8p0MlCXUc4skRN4qEhYoN8BKL3nrqDq63wYOng9agC+xjYtVBuNp/LcsRQeVhFItXRU0WOl4hImwZT3dVh/JKOmOE3wMJDeQCnmPNZ7ghvG5xuWkRtnRZtw480GW5Wd8PqDxzozUlfSoWmSSimI9tKnFzXXXqPjOvgQvUWKd12arxKaGhu2J+o117xg==
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:32:58 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::62) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:32:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 13 Jul
 2026 11:32:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Jul 2026 11:32:34 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Jul 2026 11:32:32 -0700
Date: Mon, 13 Jul 2026 11:32:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, "Mostafa
 Saleh" <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 05/18] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Message-ID: <alUvPl/NtmqLMsoY@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
 <a24597bc-28ff-4b23-818c-f9126be3bbf9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a24597bc-28ff-4b23-818c-f9126be3bbf9@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e197e4-f70a-4879-d160-08dee10d2908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	zb6YxX+eLtQ1F+OhCWYWb96WVGiTS/0fPlDlG+Pe2z5HEVbgFCsNgx84wgodrwMVfAg7LA1Q/3UW41rSsvQ73/pgk/i48Pq9Gmpp9dfmk6x4wvbYyj1sk4MXHJQyqW/w9OhZhVaHUyKVIt+ZBj1JUyngmX74OK7FVGoy62Is3F/9JYt253QkfyKOi6M1xaH6PYoLsNU6BLjAgijp2/fNXoTfTVTsW8TMFLIjXh3zP/Ju0uMaCnvmWxEhZs/mzflA53s9XZMnq4xzxpHOjvKY34aT0oGhIDvNEC5qSG70EK/ppHtjBDEG+RyQgIWQzDScZjG7j8mKXh/+37C3dbYBQOtqv94Vy0HEH4CRF5H76MkXqNyoiaC4Pdke1qaFzjYsIUeVg5HeDhtc2a3FF23TG8NHUIUsCORFGR2yVbRcue/iZktcDFr9DBNUNenRqHWtT5BVFX91ICXg6//NlCGURigTLrZoatAbbqAY8ZlTL33++fuN0eAVGVBmiXNwyIsYPaF/IJa/xjWKetpEikjWuRYkMdmiPHJNP8dogeMFjSceJ6dc/aeNDJTINGr3qBcvJK/II7uO0EqBosMt0aS6F45JNEbrpICbWHYuUwtlkVMuyKMWnuC6rgq3Y4kmrFGd24mdTXlLJmr2EQ02YSrFF4UrHvtJ45mPBKOquo77khrLjMYjCxc6KKIIkQe07XrhWZn00Ac2Qwvqre+ueQMHFw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJFX9EMVAdiaH28HZQi/nhqXbPDWTFduAdZZnlrQdeG5/ehCvIACzhqBUe/zQwC2u8OgzOjDPbtyLemNB+1a/zAX1uTMwSKC6Sr00oKIxkVG4uxXws08Z3+aVRZV4bOyNyQgz9X3rwHWfT7YWZIpSjjwjhKpjGoRZ3g3gO02XDVlQTWlS6W0AwXlXRVILKaj6Ig0qRkFGsYv85VbcSL0JOj4LK4zJfumYnYvTEq8e9E3WR6nCPD3mAvwcphHUlfRuImiU9d6f5RVtxf3g+3om60lu8Jh6JfKl2ayGJpIPcxgreiWa1+TLAKP7rWM8OZEtn8izM2f0ZwUmWOG6TY4rTqjvqvX32gdN29sVwlK3JdZ/5ZY5i9LDlwuFczV1mMmjHo+G7eJFDDx2zBlMSWquiC6zxTQbyo752CMgMU40Tz+A4DG6c29u5P9PDY8ZbUr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:32:57.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e197e4-f70a-4879-d160-08dee10d2908
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

On Mon, Jul 13, 2026 at 07:48:53PM +0800, Baolu Lu wrote:
> On 7/3/2026 12:06 PM, Nicolin Chen wrote:
> > @@ -762,6 +763,9 @@ static void __iommu_group_remove_device(struct device *dev)
> >   		if (device->dev != dev)
> >   			continue;
> > +		/* Must drop the recovery_cnt when removing a blocked device */
> > +		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
> > +			group->recovery_cnt--;
> 
> I feel that the change above is unrelated to the purpose of this patch.
> It looks like an independent fix that belongs to a separate patch.

It's actually related; I had this in the commit message:
"
This introduces a new situation where a blocked device is being unplugged.
Decrement the group->recovery_cnt accordingly.
"

So, it was not needed prior to this patch: it wouldn't fix anything
if applied before, and it would be a bit odd to apply/fix after.

It's a small three-line change, so I think folding it in is okay?

Thanks
Nicolin
