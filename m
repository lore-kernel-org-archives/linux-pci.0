Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D919401A21;
	Tue, 21 Jul 2026 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601460; cv=fail; b=DEqwDaTe5VawscEAESfFNJEQVLB5RiGuUnev7M/J5YEHj+cfZ4SD5hBIXmXaKewS140h+J0p60EdIKZ7oUYtvdblRDlIs2TF4/a1jYT8IfkzwixolcCq/C3ZE71cte+PMfNcKU0xxunwfwlluopiSW0ltX5jZTka54QZ40eQXxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601460; c=relaxed/simple;
	bh=lAwAOLCffk1m/IKUtZiv5aU5dFquZcnTc78PJuDBx4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUNijGbONmM23j8EtlYJqM7XcUQlDx48E5KkGKp2S/tuIqOysVT+oMx1V9dLzX9cHvkPZ3gkenRPqdJAn5iNs4EhqU+jP9bhyU0uQZZOHeItS/LorviQKyFtWGVflk0yj1VD53vc/miVmj0T9Pqt7g841xA4rYBK3bILkbOCZv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaXAnHrHIEBlD+ZMvbKG6YlanGvuA8mkgiEo5bBbKkcYp7Vwm/LfUc0Z9DDf1GJE+b4B+aSYsPFKLSNY0sawCHZr9n6BqppfzXhb0b0nPwiwtO43YKj6uoao76phucLcfI+GtN7b4oIBeVd/+Npy3ViIbCcQf2cTyUSFXV2JnyXYkem7GwunotisqlftJeR9gCVb4oBjcT+KUwP944qQHRf2LJUU6qEFJZ7+4VHTBB5FO4tQdr47l+OJ6qjQVZtWbcfwQC4ZXxk0GaCd/2loIajP0X84xma32uy3SCEVv1VTNxu5aibPWgTrqjiVQQuDI7V7x1lUvZqhF2i34d302g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n720LHg24LEDHF/QvQS10Z8ubuYz+6n5w7dGMBfNziU=;
 b=oBq6d+8Nzr/BRC2IyT2o2ZlTCjgh6QKLxJetkTWokksFGQ47OkdAkaG1YNWEZCbYp7AjZ6MsmRSeDkMGUBvIJuSWPthG7Lu/shlTGYbEjtTeLRrxc3PKatO5HEg5ZLhMNhQiDItUtMpZK7M+g2jcrbsycEu4wrt31EjxAfEYX4xAe/AWfJUugXbgfBv5t//1OVNQo/rVpPSOPI60LE70++5OBuJhwdWyLcQJiAd+D0+TF9O6rBMQLzG8RbonL9KXbLxn4bjzHBsUBpQZAQzJr3Y/h6DrJ/DnFR3jJ29ya3xvalLg5AAXyvUDDLokfzaEl2y/RsjuGGtVgC07OaCNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:04:21 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.017; Tue, 21 Jul 2026 02:04:21 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
To: helgaas@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: braden_zhang@lecomputing.com,
	brett_zhou@lecomputing.com,
	jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mani@kernel.org
Subject: Re: [v3,v3] PCI: dwc: Add pci id for LECARC pcie pmu
Date: Tue, 21 Jul 2026 10:04:06 +0800
Message-ID: <20260721020406.1701864-1-braden_zhang@lecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713173805.GA1223423@bhelgaas>
References: <20260713173805.GA1223423@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::22) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1208:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cfb60f-3aed-43f2-ec45-08dee6cc60fb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|1800799024|366016|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QKb8IALHkauhU4qSC5ztljLZzDdWUpLTSTeKMyrQh2aPylrBO9hG/RApGvkpzqoqWKho0AOlIT6yfrpgYwWID+7+L1u1iaaErI/FCks6mI7rWMENMyaWJ4FOX+SlKV9aKqE/5+i2X6YcHzviHRNmhB7Wi2OZxznV3gXRyn286QaJjsaQp0R4GwPwuQe38PjDmnyY6juzhqGIrjLnrkugi5TkESfaJcOGRZWu0LSugjHyEtjZCpbhRpd/MuZJUfeZ3iE6dWVyWfA421FDsK660VJCntRliVA5dgf41pxWObBLGeq+ZIVdJmtvJnWL1q8JqGAMTp55iPIVb3db9ClvJVCkhvRwXKEF2UG/kAapi75wcc+ub+43nQJ4I0GkCdtNhyogBGmkLXlmN8IA1l7ZGPCa6sbdmkYQjdEUH8fFk45CANmwey3Wx8gNMcpT9hczCF+DzBlFj5TkobF7aY1R7Nt6ERsv8fQwx7Ngyl8AAu0sdkwlRJj8uF63iw0bvW+8PRNQE+F6LYIjTuzh1/c6njUoWWQPOMdu6UyjwttVV+PNxSnyNy4kbuKdGqV4Xb69
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0F9U+OHpmSsXg3mGxFYRBrc+qVmZqtlvnJoe7/4u9eqvf9wwHCpR7aGEJM7b?=
 =?us-ascii?Q?9Z++rCcvl462kvJz3C0c+eAvnOXrIwlqetfw+D95ut2Pvk8870BKlnBZHcZ1?=
 =?us-ascii?Q?J0vCfi3fLpDwXi+Xh30A8o7m5vIGm2/wBitfV8KRz5hwYC9wXsJ+lzjgnjGD?=
 =?us-ascii?Q?CbsRY6nsoW7N/iKFQSE2+8hU42VTL6v/JD2OK73wSNPZOjXIDKOpSIoZndxf?=
 =?us-ascii?Q?6QPkngPMPVtRTswpnKWDX/ll7/Xu+xd83Nk33gpOw95Yf4vMRe/lDHi9RptD?=
 =?us-ascii?Q?mOMAZiEvg2HgH7CT2FO3t4yv6hUtITm2wRvDGcuRJTzPwQnj3Nu4akuffbxf?=
 =?us-ascii?Q?RrPpGNzwoovhy2MouxzfymEdao5wfBFYe1YymIqombQtSfosrBtFJHT/aXcJ?=
 =?us-ascii?Q?j6hl+p5HHHx1ZomwkzRTceLHdZbDOjKkBsL93MadvIUgnpqAa9oZWNfTLD9T?=
 =?us-ascii?Q?SsnRuD9DafOs+67CoKiAHr12MO9wqsFV0Y5HS3+y06LsU+OEcAko6wcNY/tO?=
 =?us-ascii?Q?wOBTSMDiDfkEoN9iceaL+xcNziawMEQPwS1TOxV1knOnGVCzMvILNnG43+Qy?=
 =?us-ascii?Q?HE64at+fPXc4cUsYO6T9fbk7O2YnbQrm9Ts7FWahOKkDk0H74wwhhsSWowTx?=
 =?us-ascii?Q?AS/OMrhMVOE5mwqMzqz+gmOxUJE9q5yBiMlI8d0sn1YxjAkO8s4RW/WonXCi?=
 =?us-ascii?Q?EIng4pmrRend0bLCZ7gBvNxNExE167+QzuDYJA6SembXTgknD+XqqplWinez?=
 =?us-ascii?Q?HuFXntNfGaLw1jrNq6si/H40VlbtQ5E9zcSUOy2w2/z6nr5qwrxSr6233Vo1?=
 =?us-ascii?Q?UdLw9spcSPyB4Iq3Z2IuU23YWSo5ew413hyK5bkvmnR9t8L13WKcNR45blKg?=
 =?us-ascii?Q?Fp8UTrhECRCQeqYoqyjE+0QLQ2zqiOH41wdfqYpERBaHhR77nxiHUlUUDx3+?=
 =?us-ascii?Q?fZtmWW6eEhkAsPKdOtm/egZ46xDucX8/JSZthODLOaKMmDMZJdo/JoodCDiO?=
 =?us-ascii?Q?5dP0AAP9zPIrlWRZAQWqnjjb/U1j8uMMegMPYakt/voe30b8qRnb5gkJwzN6?=
 =?us-ascii?Q?vEibGnL5b5Uq97Xg0Y3ZGxJPPDiyvCmsikzAoxqagfI/vk2IcIF4KoHwhtDl?=
 =?us-ascii?Q?t6rX2zh+kMKPg8gFJwhtkPPl8XRFDp5fNPNkj887SDoSSzSEDybGGgKhfUAr?=
 =?us-ascii?Q?VcnHENKTI7kOTJ+KgOSNxRDe39S1kUFyWirIL3PyR9dxJPJIZ/l6VOI7FWjX?=
 =?us-ascii?Q?E4fxgcMCIuwkYw/NVh1p0e4iC1yZIVllp12NIIHzkMQa/kGDeL1WBPiluRhz?=
 =?us-ascii?Q?coXo3SNxnsbXD+eRYA9AEE5OfDXohMRu7MwM8/rQtl5rCRkAAjAI56grGZw4?=
 =?us-ascii?Q?Eyuz88sjp1ZJKIi1oRU0RWd6h48TVsmTbbtp/AAnwzjDF36907sNQ+ZogRh+?=
 =?us-ascii?Q?v7IWIJ+fGJSnpD5PPQefNaaIhOmPul/JVdS7BHECsUvhMuWnNCGaUHmmhWbS?=
 =?us-ascii?Q?TIX2PWuliVrv0ZuP7HvW83NeQn7fGbjzyW5roC4E8l+mti07T2BKqR/FDDwO?=
 =?us-ascii?Q?e5+NIvlBpblKDumWmokMw5eGe+4KElQeZIGfEzzXCYoGzM+ry2UF2+MsTlTu?=
 =?us-ascii?Q?95D6m8hzIQRO/eWctP9L8AYlG09MTq0Pi3wA/J6xV/HM/DF3Sc9FUN8UPkl7?=
 =?us-ascii?Q?7xyC3oL0Ual1U6rdWNaVrdGnodMANA/zp8MrvJVeTIpEs5vROh7ATR5bHl1H?=
 =?us-ascii?Q?cAhVPtsUbaTAp9FbS3XfPHVGHANjma0=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cfb60f-3aed-43f2-ec45-08dee6cc60fb
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:04:20.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RzuyB8W3HykMM5pu96QfvL6uiKpRgolq9FSVVnaK8O2KhHUq116MRyKtNrDBsvNUm+jYQDzDgEaqJCd9+O2zkXQJwohPts0uLbOatiSjj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1208

> I gave you some comments but did not provide a "Reviewed-by" tag, so
> including one here is not valid, see:

Bjorn, thanks for the review !

Sorry for mis-used the  "Reviewed-by" tag.
I'm still getting familiar with the b4 tool and the patch submission workflow.
I'll go through the documentation you referenced to make sure I get the process right going forward.

For the next version (v4), I will:

Drop the invalid Reviewed-by tag.

Reword the commit message as you suggested and wrap it to 75 columns.

Fix the capitalization in the subject line (s/pci/PCI/, etc.).

Will send out v4 shortly.

Thanks,
Braden Zhang
