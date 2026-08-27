Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B92DCF55;
	Thu, 27 Aug 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862721; cv=fail; b=tz7fjbBRYMHpd81b6jNIWP2Wu10+9Bs83TJfPza8/q1AnQvDOjppl2dglYNP1pasTNDG0jE6QdG3saiV4lNn5KDg2XFKi0FVtPfKnEpoBf3wQAiT+3S9wfHdqqTeB6cQ0b+WXf+/36ONol7lu31bHDffzTSeA1BGrwoOG/RJ+3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862721; c=relaxed/simple;
	bh=rgsMu5IQuORRG8oxI1KLexgKJXQMdKl9QpKbfoWKkQM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=grgtaOkVfgg9DFyoOyG2xaVCSSsZ8+zsbY5EJiBV58czP299XMENL+t4Y+m1FZb8A4l/1Y7Z+FzNqfUbd+UEOeyzBoJ/NDxvgXWwczlhTjo1xxP5aOrWHvIleg16hGNCMah4iyixte2zOUBwM0kK1Vkdmsr/1l32PWeWWw+Cv1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/Mq8oT2; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/Mq8oT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQwR+zZ0mOzz2zAITWXChPgi+M/k/JKUpNyECJ5MINOvBaGhxOix6kIkhrrb1iCFNdqHkgLAPeB4XahvgDCTNBxK7fOgfnZQfI+yrN4S23k+kXz5j/lAkFqM99P8/RslIaNvW77vmSYIhvlLuamxxRgFfQGEB+FKNO6HThl9kl4vGK6bYFWTnv6JbNAsfXsXyxGSeynKYZQvdrhjilOeQnpgdCd8XuICtj/tqkC6qKe0169ioMwhPa8EYl5WGbaPtgCdNowHKb1gsAIsL7QdcY9qnhcbSWmqhWgAyRiJ9Hn+5i1aGGGljgUyUu6mbpj0h7vkSQYL0/GG96ihCgDOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVWWI3igYoWt6T/X62ZyXVQzbVgx3KcXC8jQcX6dedg=;
 b=qNfXdP6X1hRjxYK7RuPPPza3A/3FazaZYQLI+sO3PLK3R6+Pq/xx/t/AFjdrDsrHSytfBcEgKvK4z1FIIkz7Dr7gtDoPR1GzBArrDkzesbhfTKmUXLpUZcwNfWvEUeAizankHnwwy46147cYwO039GJL4YQJBxFTl20e8TRULac7sR4ToRVsvT4ds2iaSOSTZVAlhfB017V7iKZCK21Vn/2CpX8tBqv86jrR6S/Sxd1Dqc9/RoZTWEP6hoONKAVEmMv2zSSWl+EiTnuHbAld0CRzsp+PYlDbk4da+hZyB32BOJAgaBT0uQB+0ha4mZA4JW3cBgfQJ5WDg4OowiiWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVWWI3igYoWt6T/X62ZyXVQzbVgx3KcXC8jQcX6dedg=;
 b=R/Mq8oT292bQToFIlu2Q2QuLv+XRJtyQSLF76w//AYee38BHu3r7jGhoYG2Ijne17QZRrZC3MweCHD3iRZwb/29Nu+qvaYC96IRcqzXZ7gcttzfFFsGSv0Y1VzUUMGG0GuprViGjqUpXkVCn3hHQWJfqiB8zPm9colPEImcie6iY0wj2CkHyNeOkDImgyxks27pY53ishxJ7AoPyK0xFAtlOUhnaVtUGuYWh/iNdsTG20NYYRyO3VY9aOs1QGsuRbhUOYNuJpOjpmeH6vn5tIUGFkinL6YbdKtaAmuORS5Fx+dthbVDOJFWDbl+c81hlXSfTqiEe+oCDEINF2t+lKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 27 Aug
 2026 20:31:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:31:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 04/18] iommu: Convert gdev->blocked from bool to
 enum gdev_blocked
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
 Mostafa Saleh <smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com, 
 Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
Date: Thu, 27 Aug 2026 17:31:31 -0300
Message-Id: <178786269178.3808739.3498566138050995773.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: f04d4cfd-ed0b-41c9-8fb5-08df047a301d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|10067099003|4143699003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	UZ6vJ/CKXL3JcZdevyaQf+IZKgliCFkW8wMvw4QBpUp903S98VNH2OOFXts3vX6fSIVfU+2kJHn/bZSSUaGzdeelJx9BnDN9fXJPjMOhpj5kgzm/bevq15MleoIdjYTlrRHbBZvIFHA2XJzPIFiKaqKXhbM63in99eCgNIreVICYmoohigMbuJjPgSYxHXTPOWzygOSO6rcLWpoftXxhXUBPnAzmeFISIng6TV4uq4gr3PSfz/s0Jt5PMqR4Ico1yEHtJ55KSwyP4Eg8hzudwzs/tR205UlwsS6z7699ZI9iGcQCrC9kCzfkCJYHDTEGwxjtnw4LAAV5KzIVo23Mf0eSHSqcvbGacmgE5Gcjjcm+2Qm1h61h0K2JQw7VjzRU7/rQlCZB2+UGgHZOg6Qlu7XsDHwnP/ildhesep9DJL6xRRdjx0Pe8wCoAQzt/aquxVTrJoo06TFCDWqfyppT7A5XejY8sBzXBEdaSrzgODYL4QXdKQJr7ZPhrQ4mqY+XDlTLdMhnfdSx/DIefj/pnHyi7F0py6zD1oRnw29R0emth2XStfbjmRb9UT6m3XH56mfKRsRt2+EBokIVL5suAt8InvPh9pwtulpaSHw5BXqm8qMmRhsdKppsAiZKOfkQ8+StnigMVx2KBFNOw1hM+N+O6C76OnPmRCy1Mg0cP5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3pKYWlkcm9RM3RtM0tGMm9ZRC9YL0cxRzBnRHoveVZ0cjdONzZyMzhDRHpZ?=
 =?utf-8?B?SzlOaFNrU0E0NU9jMTFuTzdWOW1GRjUrOHZ6NUxSSTQxVFBvcFNyV3lJTzVT?=
 =?utf-8?B?b2grMEJBb3BCSGEwSkpOSXJSSjlwSm1PQ1F6NEgzVHZTWGdDRzcyM0FuTU5W?=
 =?utf-8?B?RFFoWUdvZTVVM1NYR3NzSCtXZVNJcGs2cXdHNEFPOTZtU1JsYWIzUWxldldF?=
 =?utf-8?B?ZkVwaW9hTlBBTitjbUZBYStidXRReXdZak85QmVyKzhMeUJXVmcrZGJIemha?=
 =?utf-8?B?bk9MSDluNlV4UjFMYVl6WnBYZ09PbkpwMHJ0Vi95R3Z6WlhmSk5QUFJVWEVw?=
 =?utf-8?B?dTVOSC9CSSt3cTBiUzNJNEFKWHE2YlBHRVRBNzNMY0w1Ry8zc2FhaG9HSXBu?=
 =?utf-8?B?NHRXSDZrNGJBWW16T01rRGNha1VJUTlVc05HTzNNNURaM0EwWlY5cnlYSEgv?=
 =?utf-8?B?ZlB0RGZZaWwrNHYrQ2k0ZkpKeHo2SmdVNE0rSUU4bWZjYXpIaU83S29SRmw2?=
 =?utf-8?B?MmJwSWZHRXF0NzV2VDFKSlYwcUM3Wkd3bDBxTFdoZGE5dXJoc1FQNmhPc1ZT?=
 =?utf-8?B?SmZGbk10cVBVUWk5dTJ3SndqSWNaS1JmY095emcyRmpIbjUxM0FFYzE5dTNS?=
 =?utf-8?B?eHZYSlp6dk1nQVlPYTQ1anJJelE1TitZRldlcDBnU0JpUUxsbCtENC9vT1Zo?=
 =?utf-8?B?OEIzUzcveXJCa2lmK3BkcmVkLytlelYrTHY3NGlUamw4T1BoZlFjSzhDRVp4?=
 =?utf-8?B?KytONlc0cnd5ZGVZNXVKY2ZzbEt5R3RJVkZKRDhCYStzWFNBL3BPcGk5bnB5?=
 =?utf-8?B?YXJmRlpCbFlEdGFOQkFRQ0hDa211ZWFRNVFXbm04dTRWaXhweFZGTXBTZy9J?=
 =?utf-8?B?QVk5aVZVNVhHQmJWczJTMERWZGxpUk51bEhEK2tsUzhsTFlINnBSYjNSV01Q?=
 =?utf-8?B?YXhZaVFmcWFoNHM1c2xDUGYzbEdtSzA4cGtTblFKVENPQUN4akhFekw5VFJa?=
 =?utf-8?B?OVo1VGsyNjlzbjNLaFJDcWZrSzRjVUZiNXlsMk9xN1lPSlhlWU1ZTUVMdUJu?=
 =?utf-8?B?VnNLalBLVWlKZEFRL3BPMElPL2VlcU5kTFh1UXhuUGc3VFpWVnM5c3QrUExj?=
 =?utf-8?B?VVlsQ2Z6ZnFJMmFmdmdkdXF1Tk5OWkpMaW9DODB3c2Z2VUVXblFrZkMrckN0?=
 =?utf-8?B?dXhXTFNVbmtPRjI2MXhjdkV0ekhkU3Z6RVl6V1oxcmNlUEtKbDErN0xrSERr?=
 =?utf-8?B?MzFQdEJpUHRjakUvOVM2eXl6ZGQ5T0tvSU1wRlZzbVE5THYyNWsvSStRbzEz?=
 =?utf-8?B?ZGlIWGdQUEJON2pSZDMxYWZKTG1MaXFmZUVRbkRpbFpRdllpSVpvc3ROZE5l?=
 =?utf-8?B?b1hWYU5NWXJQc3QxSjVwaDEwUFFYdUMvYnJIUXlIRU9HR3Q1Q0t2UStsMUtk?=
 =?utf-8?B?Rng4OCtzUUEveks4Y3lZR0RGVTJSbzJIUHJFcDBxSEpjMjR2WXRGMGxYaEdU?=
 =?utf-8?B?Q1RFMjZ5dnV2blRoa1FjL2cwcko0aWtmY29QR0FRTGtoU0xTc3RYeHJMS09B?=
 =?utf-8?B?R2V6bjg0eG5GUDV0L010bDRpblhrZmVSNHAwaFppREttUVFGNXhLbTdzcmtl?=
 =?utf-8?B?ZjJtd0tyUUh4TThZaXFxMldNREdGbkQ4anh4bVVtVWhBZUxGdXlqUU9DUnhW?=
 =?utf-8?B?WjBEWC9ZTWFDaklBb3k3ZXpXTW5kNERhWTdySkV5VzZyUzRVbzZiUmJWU3V2?=
 =?utf-8?B?RC9kejlVdDg0QStpcEJTcFpuczVLckpoWGhnWEw0Mi9waktLSGlpN2hEQzdm?=
 =?utf-8?B?Z3QzQmlLVnhhMnNtVVJId3FPbjAxRU9XckkwOG9mdnlCTmlRbmN1VnpsZFRO?=
 =?utf-8?B?S2Qxa1NHTnJ2L3cxOHQySDlXZ01JS0FPOFNDMWlwaFZyM1BDZng2cmRqWWJK?=
 =?utf-8?B?QzFVaGJvcXJsd1hLNXB1VFVKODdmZU9YR1o5VTI1UGVXbzNmTkd5NUdUc01J?=
 =?utf-8?B?YytZeVlEQW9NMDVmMjdVYkt0TS9NNHVOalFRMS8weGlyNVUyNzV6a0ovV3Ba?=
 =?utf-8?B?WWdqbnUrWGVhOWNFRmRTNGtablpZczZVdjU0Wm9mT3hTOEF6NE1oRWJvY0tI?=
 =?utf-8?B?QTRKaVR2aktnc0tpWGdsVXZUZExMT1VtR0dOTnJwM3QwN01rUzBVdkx2dkFz?=
 =?utf-8?B?a1p5K01vODVIRjQ0QjRybVcwQy9LdHd3TE9RZTRUN0lXMjlMbDB3SmVSeWNl?=
 =?utf-8?B?dk1VLzlsbVJZV3MxeTdIa0FVMmpRbDBUMUpGL2tuWjg2Q3QyQ0lhWUNvYjNt?=
 =?utf-8?Q?5UY6VwHHt8IKx6vn0t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04d4cfd-ed0b-41c9-8fb5-08df047a301d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:31:35.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnfnBrDcp+S3kXZyU0eTynzBHAy6F8Q0QLqsrvxP35queJlWiu1Y0j8nI/n4gm3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

On Thu, 02 Jul 2026 21:06:29 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> The gdev->blocked flag tracks whether a device is individually being held
> in the group->blocking_domain while group->domain is retained. Up to now,
> a PCI reset in flight is the only producer, so a bool suffices.
> 
> Subsequent changes will add more reasons to keep a device blocked, e.g. a
> failed-reset case that must not auto-unblock, or a driver-side quarantine
> for a hardware fault. These reasons are cleared by different events, which
> a single bool cannot encode.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
