Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905195;
	b=AKNAxlU4n6sJ8GxUVfogNBCVjTG6HPJ9rin3T2s+LLmE9yDPhpItVg+mpqzIgUgqKRf0
	 nwdiBD5pc0mZkTjDht325Ka0iByD3Q/3rwblnvmrapg+AcVls9Z47BbwIlNhRewaPZbXs
	 KvLiGhIleG9hG+lzlds+vkpOc8LJbqn0WkM0ZkwgogrWJEvJd5wcAdAWfwkde1EjlI/fw
	 HghMWpLK47EA2bnA7y/Gh4c+Df4i4j1vkPjftUR//F4Pl0NO0w58lFExdwPz090CVtJbC
	 1xW5VHwVQvAcZH6GbbVS81FL88dZ3rHA4C8r+pcjGBWOz21E6HFMgBmrfTVMgg6NuEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905195;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KknOinz6OHJBtqf0/BMIY5UQTAcNKq1x4QTo74dZoGU=;
	b=I4MNpLr9TAJ8gob+W8O32/oc0MvTNZs7AHeVsqV/pl3PY7QWS4zRT/ih/AXETBEYywGi
	 O+yhgTn0m1DFLSsSO+IP9z3f5P1uhS/gSDZhy1XAnlfn0E7ZpKppcJGavRYj+lUe4M64v
	 rlAcjKccMYapDa0mYumEFTYcEYoB7EHWnZ2AY19OnwjhcWKl9Z7NvC2DPzVgS+PvM27i7
	 NKyxSISbFU5yNS0NJMQR+Xk9Ef5cMU0IQBxayXRZBgkLn7iTCEGyAGH5zzIVktumKVeAg
	 F8BwHOcC6+iPjwBwvIiU7ovONw++k06MLD4lQphAliSsZBvFUGfVd5PXdSFI7SaEejw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mT4XzBUM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.62
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B6606D82E;
	Thu,  5 Nov 2026 18:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4B6606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mT4XzBUM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vExcIEQWgVSkofe9KA3jXN9BjeKsc9a8iCEtFyRA+WT/g0RbP5gUbQIuHDDV/ZPrzfqddBKC2BevsbRKJPQrqsfd2FLdPTpqpu6ce2ssXruyLUdnw1eKMfj9vUTDrraOBMQLfeJHuV33QDlUVbZcqpw5gc2bPajOEaGt7pREElXJpKAYz3jpQQpRpiQP7Ktp689LDrcw6+mA+tp1x4bnQURpeAN4sK7MWUsXEGH+ljzizgesRNjUqPCF0w3e28/cWtVkO+o2qofpAVfv2UswKhMAxpwKRSAVkbsliLuaRlxUDyMkgGxAX46oE1wPvh8WA/gJJKPhmibFvGSON/WMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KknOinz6OHJBtqf0/BMIY5UQTAcNKq1x4QTo74dZoGU=;
 b=D3QafnNzA+Q31nWMlu2nzQ+BTybbTyy58GxcldiAxgjVYcJfH6XJ7D8hdUzWkkRmJCqDJgSl2i+PQiI75rUSlFym+fx0nubG8ei5YKS5Vhf7r+L755LoyQYim6dPvyf0/7222hx/fUmmfRDJbavkPeZNzW0Khf/bG1zhxeaTYwLleMSwKr7NZ/otP/TFmUoJPmFjDiCz/gBJvDo2vQv1dPHdniwjZBQs3aX3+OA3rCYxtxzg+iJbMoVZO8IZt3YfxcxQxq+efPSnguW86qFVi5lirMiTU7OaWtIhIpHaebaMJngc+m4OlXPeY7nb2f9U3lrN3ZDMohNtjelXNMELfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KknOinz6OHJBtqf0/BMIY5UQTAcNKq1x4QTo74dZoGU=;
 b=mT4XzBUM+ogKKWctYBFR8vvE2KhuRBcJ+q5eUvXgDGbM7tfYJRY9VHH73jH6AJ216Fz0BUQzyICTH2nK+An3fIlmGgXy7/hVN8lAxniKHqejHaeJVFgqMzRsTzsB5Yi+CnE0Q8Z6icNI2xLpPVIVBp/z5pwAgp7zr0Y21+G/ntIP9E7EtzSquceo6PUtnqbywV+ZCGnWnzNY4ShYXuFQMPTfDlg/B5uWakkuT7eg9zMqXwsN/MBV5wTLFoy8LxX5h5+8J9eT0d06zQWjwMGSE6D5Q8ROyb8vhZ+ZYGMfTDFIBUOOyqiQYM6tJXDbuJ3e/pdHbqv1H9tiF/alHoJFsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:48 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:48 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI enumeration
Date: Thu,  5 Nov 2026 18:59:09 +0000
Message-ID: <20261105185917.2667656-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ff3fad-dd15-4f10-9620-08df3b6ef717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|260925021911599003|260925022911599003|260925021311599003|5023799004|56012099006|261102123227099003|261009221727099003|261021123027099003|261009223327099003|261022105027099003|261021121427099003|261022075727099003|261022113327099003|261009220027099003|261102130727099003|261009221227099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ta74q9O1h7c/ftb8YupUk6FFvdz46wPwJNeo61JtCfQPGVwIjqDUKOG3IeNon9ePB4bwG8GDyrne/Eia6M64rZIIQf5XRZpQwH7nh7bsbJnb7DSVsw4xSpdxxNKlV0EfJjxii2oGr5lhbQYv78g10ZKHQlAxftEyZl2ZBEGXpWdXtG3hI4DyutfjjEfMo3vn+dJWpsu6+pr9dtMGUhEgBULwci7Fw6jRjRmuOAKT5wWSyhLZknxQn9gEEG6P7BeuOMEOtx6Xpai6iD8fFS2QCKPxw6Ryq4ZhNkjr1r65/8RQBRReDPJ3nkZgS/Z/GsPZROADO+lPH87phdZ5p0eHINB7cBoxfjteryguGXQ2KfhGsqLQ6Zo/ff4A/JB/LnGPTp01V0bQx1ey7r/aGyRTz8D122C9U0F5uO4ziXElL5ym0ZyGRYS0WkseI4tIja5qVpMbVv9jcxIJDPkNUNVgl4Pb0Kn2hC3TNPeTBXsPy2KIqm6cWoaaRHnbGJ/+q8o/S632Tmvvu4E7JYJK5Jpmj6Oavf1VFot7Uq4t6/5WKc/c/snTeHaUoJBVp7qbzwhvKp/8mIZnaNLYDhRz5FQLIJjKL0+NV3SK4ZYN5K0oP6JeFaSGeUsPhbVGBHI+EQuCqAN1cKE138ygAzjpNB5zevu3kIi1KsWjiT5i0mfgFxvhAMs2HFhm878zBdOAKAN+Kqugd6mHAbMmZli7DVIiTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(260925021911599003)(260925022911599003)(260925021311599003)(5023799004)(56012099006)(261102123227099003)(261009221727099003)(261021123027099003)(261009223327099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261009220027099003)(261102130727099003)(261009221227099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nW2b/X50CSIxVYQrJlyCAKnsYB7M1wahRLQ9U4r93A9JFZgiaTfR93Ayt/Hi?=
 =?us-ascii?Q?BzByVRxrW7TBnvPFSOzLxjEWoi0F8J5ppTmlyKmVH3xMIcG8SMe/f2dKbYZL?=
 =?us-ascii?Q?8IvN10n/XUegd1qXfRGH6wD6OMVOGX1qguGMaa1Hk0P80kvUJH9w4o8v4NZK?=
 =?us-ascii?Q?WYwGy2JPd4WJqctVRgcsc2Q3unuU7DtSmkhJK7DFSi1RejaCSYHbw+HEQoc+?=
 =?us-ascii?Q?fc8BJ8yjKNzK/CgGaENeSUcW6Vej5gQ0Mw1+GaX6ytm0FOrFO4eHfihKDya9?=
 =?us-ascii?Q?4paNAZh2Q5vkB1CW47QcBd3DPzkGqhmNAWYn63L4GkFlDYo91Dmd9TvFE8xv?=
 =?us-ascii?Q?NuEKj826s1HMT5K4Ld/8RNeRkMkjUKFyfNKGGOUa5bpeMG0RwEkHAjG/ofJz?=
 =?us-ascii?Q?7h1zZpiw10zekFWgvtIaDhPIv4VuBZmFbw4XbAWH2KGNITuJQUbYaDK5PtDE?=
 =?us-ascii?Q?w5AJSE883oXyd876ILj2jPGLITcZy2cEUl8nkQoutpdCyjmqhpVI2Bd2bI4E?=
 =?us-ascii?Q?y4oMRGvCKoxh+22MWSUwEmxHhkVSyI3t6/hH1l+vJq8FGdVBFA9xyyiU0N8A?=
 =?us-ascii?Q?QuAMyCE9BE4hLkuR8jAUUtIanwQ81VoUYZOIqWez3c1QCHVRR+npY4H6EtE3?=
 =?us-ascii?Q?ftuGtPtwPgaZMqJzyffEaxc5Jn5io0yJSUKKW/suoNDpttcND9PHg7wzi3Ob?=
 =?us-ascii?Q?BxY5wvwy2SlC6OkfdmzWqVCbhLmJIlobQgFzjyQXYySb+LNzkcxaqV7G7JWp?=
 =?us-ascii?Q?fWnC7QdIUjUZWyCv5N4wDMhOE4GYMHz/6W6SiXcq3izoUwz3q9vmJ9RJtPZW?=
 =?us-ascii?Q?dCcb+abImK/V85woRaGTRLrt5DgBeyZlCvmZV04s5XgDGi0qOeQZisu0ArAn?=
 =?us-ascii?Q?JBAl1/8Yi/5BGRGEEGTz09+DZlGn3zRQmB7yfp0bYTSebOyEgMePAS96oAPB?=
 =?us-ascii?Q?2h3PSB16UFPWaY1xAb0ZENtfb1awWrxkAtPv24O/8vRQAJl5DWeh0Abfrjxs?=
 =?us-ascii?Q?KGDKhNBp3PlBxH5a1ZDfqZmPirUjuURo62rqc/oTq3NsTBQylAtrFeLU+eZS?=
 =?us-ascii?Q?fHL2o9jRyWM44z1NKnl8sPEVBfu3nntIeSlTqPQyR5ZUzm49/Ts0yZKol3/s?=
 =?us-ascii?Q?3KznqJkdakrKeZTuNnKFp3OgzK1CN+nhzRZr0LCJA0+2x0Sm+kNTCv5/NKEG?=
 =?us-ascii?Q?F0ryYVLvGDRozyBKCkZwrjR8YNhaSuUAtrH8tISPjpjTZnDLqYoxDg+vksey?=
 =?us-ascii?Q?5Ys5PflrZYO2sN/+cEiArM9eBzar7860HyhapD7QqPPph9s2OyxxIcfJT7jU?=
 =?us-ascii?Q?5OuZQwb3QBP9ilHp8OCbKnmqNBtTAZ2Zxi7WZ0E4M/RVOcrTTGLuSLNED6a2?=
 =?us-ascii?Q?k8Rm8pj+B0ujSupdLR6Xyed54SU0tGVgp5Vb8c7ETMd9vk2ZGAI1Jw4jHy8k?=
 =?us-ascii?Q?GhlH3Jj8qPQkVGBav338L+jhZxOzKUpbNZveXDUDMSpKVMLta+8rW/Owj5RI?=
 =?us-ascii?Q?DuDDLqi8W49/Cy1kIcfx9bJFcNDY0ANTkVlYujwJ4rtlDjL2+ube1XDuT146?=
 =?us-ascii?Q?XStETQnHwn2dkpUBcAGGKEQXviisTH7G30MsMMHfw6otnYvWpI0gZehYlYCo?=
 =?us-ascii?Q?YSQWyNoGrmPKR1bqRce2CrwFrQ6RALGKcB6nWO3masdDjAICbHlWQyPuBKsf?=
 =?us-ascii?Q?uYPa86p+NUkQxlNDTShMmJBmbNKsdzwtUs+atrWkYRAxi+81KjfKPyF6EVft?=
 =?us-ascii?Q?i8ji2/Dusg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ff3fad-dd15-4f10-9620-08df3b6ef717
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:48.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axpksl6SFE0XPwC5226EMFaf1Sd6Su/hIkce3vhgjeHFqupagXD8wjJtDG8LbggbcnGuwCuXtGp9Z8jZqGEmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
binding, so reset can restore it without a bound CXL driver.

Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
and Reset Memory Clear. Save their HDM register location, decoder
settings, and Device DVSEC state.

Validate capability reads and decoder counts, and restore PCI_COMMAND
after temporary MMIO access, reporting restoration failures. Publish the
cache under the PCI device lock and protect later updates with the DPA
lock.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM

---
Changes in v17:
- Publish the cache under the PCI device lock without taking
  cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
  cxl_hdm_cache_publish() helpers (Li Ming)
  https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
- Reject an all-ones DVSEC Control read in cxl_set_mem_enable() before
  it is written back or cached (Sashiko)
  https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=11
- Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control
  when MEM_ENABLE already matches (Richard)
  https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/

Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
---
 MAINTAINERS                   |   1 +
 drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
 drivers/cxl/core/hdm_state.c  |  37 +++++-
 drivers/cxl/core/pci.c        |  29 +++--
 drivers/pci/Makefile          |   1 +
 drivers/pci/bus.c             |   1 +
 drivers/pci/cxl.c             | 225 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |   8 ++
 drivers/pci/probe.c           |   1 +
 include/cxl/hdm.h             |   9 ++
 include/uapi/linux/pci_regs.h |   2 +
 11 files changed, 399 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c..b874340b0265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6572,6 +6572,7 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/cxl.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index cc5d77c4abf5..c92dbb017162 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
 	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
+
+/**
+ * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
+ * @dev: device for error reporting
+ * @hdm: mapped HDM decoder capability
+ * @size: size of the mapping
+ *
+ * Return: the decoder count, or a negative errno if the count is reserved or
+ * the mapping cannot hold every decoder.
+ */
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size)
+{
+	int count;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count < 0)
+		return count;
+
+	/* The last decoder's target-list high register must fit in the mapping. */
+	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
+		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
+		return -ENXIO;
+	}
+
+	return count;
+}
+
+/* Read one endpoint decoder; a disabled decoder keeps only its id. */
+static int cxl_hdm_read_decoder_settings(struct device *dev,
+					 struct cxl_endpoint_decoder_settings *settings,
+					 void __iomem *hdm, int id)
+{
+	u64 lo, hi;
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
+	if (rc) {
+		dev_err(dev,
+			"CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+
+	if (!(settings->config.flags & CXL_DECODER_F_ENABLE)) {
+		*settings = (struct cxl_endpoint_decoder_settings) {
+			.config.id = id,
+		};
+	} else {
+		lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+		hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
+		settings->skip = (hi << 32) | lo;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_read_state() - read endpoint HDM decoder state
+ * @dev: device for error messages
+ * @hdm: mapped HDM decoder capability
+ * @info: state to fill; @info->decoder_count must be set
+ *
+ * Return: 0 on success, or a negative errno if a decoder holds an invalid
+ * configuration or the decoder count changed while reading.
+ */
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info)
+{
+	int count;
+	int rc;
+
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
+						   hdm, i);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * A changed decoder count means the snapshot no longer describes the
+	 * complete hardware state. Reject it rather than publish a partial cache.
+	 */
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != info->decoder_count) {
+		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
+			info->decoder_count, count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index d4c2be1ef833..9def4a7439c9 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,21 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 
 #include <cxl/hdm.h>
-
 #include "cxl.h"
 #include "core.h"
 
+/*
+ * CXL state that must stay available while no CXL driver is bound: the CXL
+ * locks and the per-device HDM cache filled during PCI enumeration.
+ */
 struct cxl_rwsem cxl_rwsem = {
 	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
 EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
 
+void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (!pdev->hdm)
+		return;
+
+	pdev->hdm->dvsec_ctrl = ctrl;
+	pdev->hdm->dvsec_ctrl_valid = true;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_dvsec_ctrl, "cxl_core");
+
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled)
 {
@@ -70,3 +86,22 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
+
+/**
+ * cxl_hdm_cache_release() - unpublish and free cached HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Take the DPA write lock to exclude readers while clearing @slot, then
+ * free the unpublished cache after releasing the lock.
+ */
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = *slot;
+		/* Unpublish before freeing so readers cannot see stale state. */
+		*slot = NULL;
+	}
+	kfree(info);
+}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5272013548c7..ea5327cd627f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -209,22 +209,31 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	u16 ctrl;
-	int rc;
+	int rc, ret = 1;
 
 	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
 		return pcibios_err_to_errno(rc);
+	/* An all-ones read must not be written back or cached. */
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
-		return 1;
-	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
-	ctrl |= val;
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) != val) {
+		ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
+		ctrl |= val;
 
-	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
-	if (rc)
-		return pcibios_err_to_errno(rc);
+		rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		ret = 0;
+	}
 
-	return 0;
+	/*
+	 * Refresh the PCI-core cache from the live register even when
+	 * MEM_ENABLE already matched: a reset restores the cached value.
+	 */
+	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
+	return ret;
 }
 
 static void clear_mem_enable(void *cxlds)
@@ -314,7 +323,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
 	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
-	if (!hdm_count || hdm_count > 2)
+	if (!cxl_dvsec_hdm_count_valid(hdm_count))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..7a5d9f7297e9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_CXL_RESET)		+= cxl.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..aad567fb7c56 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_cache_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
new file mode 100644
index 000000000000..a0d20f4210a5
--- /dev/null
+++ b/drivers/pci/cxl.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+/*
+ * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
+ * memory device at enumeration, so it can be restored after a reset without
+ * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ */
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxl/hdm.h>
+#include <cxl/pci.h>
+
+#include "pci.h"
+
+/* Find the CXL Device DVSEC and read its capability register. */
+static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
+{
+	int rc;
+
+	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!*dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(*cap))
+		return -ENODEV;
+
+	return 0;
+}
+
+static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
+{
+	struct resource *res = &pdev->resource[bar];
+
+	return pci_resource_len(pdev, bar) &&
+	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
+	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
+}
+
+static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
+					  struct cxl_register_map *map,
+					  resource_size_t *hdm_offset,
+					  int *decoder_count)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	void __iomem *hdm;
+	int rc;
+
+	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return ERR_PTR(rc);
+	if (!hdm_map->valid)
+		return ERR_PTR(-ENODEV);
+	if (hdm_map->offset > map->max_size ||
+	    hdm_map->size > map->max_size - hdm_map->offset)
+		return ERR_PTR(-ENXIO);
+	if (check_add_overflow(map->bar_offset,
+			       (resource_size_t)hdm_map->offset, hdm_offset))
+		return ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
+	if (!hdm)
+		return ERR_PTR(-ENOMEM);
+
+	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
+						      hdm_map->size);
+	if (*decoder_count < 0) {
+		iounmap(hdm);
+		return ERR_PTR(*decoder_count);
+	}
+
+	return hdm;
+}
+
+static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						    struct cxl_register_map *map,
+						    int dvsec)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	struct cxl_hdm_info *info;
+	resource_size_t hdm_offset;
+	void __iomem *hdm;
+	int decoder_count;
+	u16 dvsec_ctrl;
+	int rc;
+
+	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
+	if (IS_ERR(hdm))
+		return ERR_CAST(hdm);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out_unmap;
+	}
+
+	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto out_unmap;
+	}
+
+	info->decoder_count = decoder_count;
+	info->hdm_bar = map->bar;
+	info->hdm_offset = hdm_offset;
+	info->hdm_size = hdm_map->size;
+	info->dvsec = dvsec;
+	info->dvsec_ctrl = dvsec_ctrl;
+	info->dvsec_ctrl_valid = true;
+
+	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
+	if (rc)
+		goto out_free;
+
+	iounmap(hdm);
+	return info;
+
+out_free:
+	kfree(info);
+out_unmap:
+	iounmap(hdm);
+	return ERR_PTR(rc);
+}
+
+static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						  struct cxl_register_map *map,
+						  int dvsec)
+{
+	struct cxl_hdm_info *info;
+	u16 command;
+	int rc;
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return ERR_PTR(pcibios_err_to_errno(rc));
+
+	if (!(command & PCI_COMMAND_MEMORY)) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc)
+			return ERR_PTR(pcibios_err_to_errno(rc));
+	}
+
+	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
+	if (!(command & PCI_COMMAND_MEMORY)) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+		if (rc)
+			pci_err(pdev,
+				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+				pcibios_err_to_errno(rc));
+	}
+	return info;
+}
+
+static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { };
+	struct cxl_hdm_info *read_info;
+	u16 dvsec, cap;
+	int rc;
+
+	guard(pci_dev)(pdev);
+
+	/* Avoid duplicate MMIO reads when the cache is already present. */
+	if (pdev->hdm)
+		return 0;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc == -ENOTTY)
+		return 0;
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) ||
+	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
+		return 0;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
+	    !cxl_pci_bar_assigned(pdev, map.bar))
+		return -ENODEV;
+
+	read_info = cxl_pci_hdm_read_info(pdev, &map, dvsec);
+	if (IS_ERR(read_info))
+		return PTR_ERR(read_info);
+
+	/*
+	 * The PCI device lock held since the cache check excludes other
+	 * initializers. CXL drivers bind only after enumeration, so no cache
+	 * mutator can run yet and cxl_rwsem.dpa is not needed to publish.
+	 */
+	pdev->hdm = read_info;
+
+	return 0;
+}
+
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = __pci_cxl_hdm_cache_init(pdev);
+	if (rc)
+		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
+}
+
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
+{
+	cxl_hdm_cache_release(&pdev->hdm);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..9e218f236e66 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
+static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..cb52357344ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_cache_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 06e9aa4479c2..0604dcc439c9 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -26,6 +26,7 @@ struct cxl_endpoint_decoder_settings {
  * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
  * @hdm_size: size of the HDM decoder register block
  * @global_ctrl: HDM decoder global control register
+ * @dvsec: config space offset of the CXL Device DVSEC
  * @dvsec_ctrl: CXL DVSEC control register
  * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
  * @settings: per-endpoint-decoder programming state
@@ -39,13 +40,21 @@ struct cxl_hdm_info {
 	resource_size_t hdm_offset;
 	resource_size_t hdm_size;
 	u32 global_ctrl;
+	u16 dvsec;
 	u16 dvsec_ctrl;
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
+struct device;
 
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size);
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info);
+void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
 void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
 				   struct cxl_endpoint_decoder *cxled);
 int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 
 #endif /* __CXL_HDM_H__ */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..ca3e77b72d87 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,6 +1352,8 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
-- 
2.43.0

