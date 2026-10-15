Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D28472;
	Thu, 15 Oct 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028659; cv=fail; b=HQMX+zwjt4V0xY+WTVDcdZJr2oommeMetoLHn8qtMWT6+XQdHjArWD5jwQCdKp+sSXe3wvzmvD3ys1Z9KGVUWmoohz2Wz6ojukTjoRDnrtvZvuvaRt38Ad4D4ZM7qjMP1M1rQ8YQc2IM0t7vN794FGKjqc6kdU3s0W/bgj8xTMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028659; c=relaxed/simple;
	bh=3TIZm4ELyhMihelvEgmi4G14Dxf5XNiybVFq8kUgL5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TjrXCLLr7FVaJWuzEs8cTfInICbV/lnXPA32iVGYRprYyW1+Le4xhLlwNGMpSzPU+vxJUeiRgg8lpO14VMFoQP0yurMQfY7MOUU9D2Mg7unvUkdfb2omMxzT2wkUPCInHUssvWNL6xg5ybRT5xJmH3XTPvH+YV8Ii2H3iRkCK64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ua/9v5IW; arc=fail smtp.client-ip=52.101.125.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ua/9v5IW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6oIwLOURRV/s5FlrkSs05E/s95SOzDi2cYBfCVgAP746OYL1BatsJIiwZ2ks+YWMSkjVuocRuXfVdzLBrZg4G9RZ5cFQ9KXIz4d332IgWvxMj525bTfPuqSPyCfa8L8GSYRef8LO7XVPjUEIJKZWBKgn/wDI1vGIh589MF2i5e+g0FefWiH6azZo7Tg0sDo43UMtkB3t28eAvj5OvNn2qG8PEpuIs2GiM5drcIudbddOWsjAiRxngmXW9gQ3KR+5o63BZMWY2LOiI7oL9c6R5JAF+Hw0yiyC1mpTJxnWUAZ2Rg/jdbUmPmb+0Kqwj+fPGjCL5IKFAJsTbg/qmgsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD+e4J/UApIBfA6rxJbWvVUmedqVC8WX/39iA11O17k=;
 b=b4qM0RnayaDHJmo2+V8xPLauG0Ltmv3bzmG5jvp4HxfYua9odqh3wTKYoICN2Hi9tBHiMipg2UDHp7f6pPG1amrpdRbPLIUqkHBgeZbmmRuiguDPJluvi9lR9hJ3KswbIcvteJ2fmgk3f+3tUfvItZSynRA5TMiX+ojtvyY9PvUWNsLOJ3SBsXFHslUrljp/O1mozp2ZwWgBB9lGW6bjtZrkDJWquwf4AcEdy9mDhMN3jnBCGcid1mdRJuKIlTfBJa1iJ8npH1YYkyr/yQgM0Tu4PG/aL1twyWqFal+kb47gJCQLgmBUjS+tb074IxawAfLAX84E+q1JhrQcd+FNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD+e4J/UApIBfA6rxJbWvVUmedqVC8WX/39iA11O17k=;
 b=Ua/9v5IWAQB3pe7T0eIx9beMkuGs8WUsjxGFMlhAf9lnS865v8wRlVvVBZrvC8r9YUyNg3pHroGy7KD+fvWGmFxs2jhmMVvHwwAOoyR/v5Z2X1F4wQdgD962uFnax9UPhGbjDFXdWdWKprUt6LVfUKrECnhu//Yp1GrCOsIMgP4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB1961.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:44:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:44:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Date: Thu, 15 Oct 2026 10:44:00 +0900
Message-ID: <20261015014402.2976188-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ba5895-f543-45fd-5905-08df2a5dcde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|23010399003|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QkqP5zfmddDz89d53OnThGf1a0f+fV7o7vQj3IAYMVqTVVm8u+hhS9QePzqS6wwQrYAq0b2Qka9F7Wljo9Nghv5dqQbMMYZQS70oxYuI4OVKGL1CzWIl1VPKVa7whccBiO/s10WtgP/QbtR6kN8JgERjEXiSDOuNSxt3rK6YbKeXMdzLAX45OcVRZRiwGKFr2bJQinAksTNlaAKQjAY4pzxs7Ht3uP2ESbNcMj5fLl5ly7ZvL7acvMfUwgxQi3J4njIvAajkLv0z/n22DKyAYdmynLpW66IXvcgAYeNtneFFF0TmTsGryykc3hjD3FHWdWXT6PHqSiVSjlH7QACBCSueWVtRfLvsFk+q+ax4WBJUyWxS/2aVkR0FXJcRuyuLnuZm5MR8uPtaHBDDFWxdhMdlS/Ji1LZ5ImKy99/l68Za1fK1xD8w5zhc/yPQDDYspsxw0zSJqBROUpkHnBnJzQ1+3vlCGVIhkgX1KbiYTgmyCOubnTDo71iFdY6Jd8CApKJ2ZWYHZU7yFiGF8YJBH/uJstsxJpP4vw8CqCIc9ZLaH8dMgASGEoDt9Cl+dG+KV9v8Bwa/GAJcrbkRap3FgOvmKmeTpk85B2rSlPgZS0TA/TbuItMPay6NRZEw+5aG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G0DFYPMhmIoL6KNR1V1uZmhjHKeytQa9e0La1EBISfj7Gf1cBQs8OWVTwXgI?=
 =?us-ascii?Q?3YS9Mcp7FEymSfzJhZfOowIjmkmGtleywCqXFfeYCnI8KiBu4Vej+DySEb5S?=
 =?us-ascii?Q?5uLw1ZTwArUPUninXHmRmznZ3dt5DWmansKLN4cFZGJlLUMu5sXTI1FlNyfv?=
 =?us-ascii?Q?CRNzGhb0GgDiID01X32+cvXZsOUppI2NPe3Z6PYhLMc/iQEyrNsPGBZqP6v+?=
 =?us-ascii?Q?Z07+uov3dLG1+t1a0v3qvI/5HTE+ADa1sDiqKxqKe+Ecvqzft3jGYyyDg13E?=
 =?us-ascii?Q?Kp2W+X+hwZK8xL/hNbL5fDQwvVlU+UjVXEOcC0djgEvEYogFgnUzCzv75g5q?=
 =?us-ascii?Q?yjYWkyQdiJ9Gerf/tj1CfKf9l8r2EVZmQkf99RLYD9fZVZlMAwDIhzO+7AUx?=
 =?us-ascii?Q?RuRis6HvjICL8VU0eBYT02/EouJ79ivem6EPoQD8fUNRpEpZHMilExiZeYqX?=
 =?us-ascii?Q?0KW1Iyw0wSUbag79Jpdew1LqKddxQmpeRr/lCQTsXiiOBiSZ4iCO9T13CINn?=
 =?us-ascii?Q?xPEQc2FNnKdIFIDoM6XqHJRoazxQPXdhRvPt7dhomNNLpmkKAM+QC8k+1rTj?=
 =?us-ascii?Q?vx5DqVD2QrrxyIZcy8YTyYa4Y5rOeZWE9gsjaL+Ty5FhIg11Hp4R+C13qibN?=
 =?us-ascii?Q?f4mUDD87/4bcNzHdZSo43iUxeWohlIAKSCl20lYQzSmE7mupbjlDz0/9qt63?=
 =?us-ascii?Q?jdYmavp4GbloKk227b0RPtifwt/4EIXdKJYzOdWsaKIwn0L1kZxpmH0gcwRU?=
 =?us-ascii?Q?oaLo8x6XHVx/FADrsckfJSCgYcrWSQOxKNZ5yT2d8vCVQd0J5FGeDhKfEMzO?=
 =?us-ascii?Q?pjYBYt1fiuY0ksdwz67MZX48ikrG3aEOz2T48hs6CANM/NseRJxdwEgq2mFT?=
 =?us-ascii?Q?Rg8iztaG3E3fAAN29DImDqRPdaKSIoa1fuAQY7WnOJZvksxf8NBjECLPN3xy?=
 =?us-ascii?Q?+0QAZdSvN1Kh+RNZrLGnrH6wzEJYvgj2cgLnd71dtPPZYNFsTaz7P6ntwQCs?=
 =?us-ascii?Q?F1U93WImzLVYECMKZ2mxeX0upz8pCRnFQWDUOllROHF2ApS/K7afFf3S92SV?=
 =?us-ascii?Q?x8anmkeEyqN1li8qANWD1aJvSIEzidtzvQd8CNdJs9DElWYM+pTO3ukydkyE?=
 =?us-ascii?Q?/wDUBh9V+Bk6fzQnRzqoWsnmo2232XHQn9vmYQKAjL5ADqpS8cDYMy+6xPrx?=
 =?us-ascii?Q?/9fkGaKtx9g9qNEJEYgH3KmgSeS3nq2wUA9Y+r4Rqz8rHWAuh914IzG+3IsE?=
 =?us-ascii?Q?DyiFItrm2f1zmKDE474rDX4tb2k6GRAP6NcDfSrE6nmr/+pM8uYynOEknYoz?=
 =?us-ascii?Q?QqMmESmp5fm4rSWNUEQu6hWZJqg5GU2ypn2YrFUrR7Y2fduhxz2jzL9To6ZV?=
 =?us-ascii?Q?E3bd6VtyWqaumCi+MPrvxHRQT9Vzm3txYIVB01pCtFrTvSCT3/X7m5LRxn8W?=
 =?us-ascii?Q?cqT3y5NYjMpFVCCQ3SQTBd41dOrFVFZYh3Ku+OAnhxWWSfPfSZ9Zy9a382SR?=
 =?us-ascii?Q?OxkhFn45M/dSifw1CFD0d2xIsn7896GBHs2PLz+0m0hVSan6u0JZnp8BaTBv?=
 =?us-ascii?Q?3rlJN6Bggg36P/zNqiXDvAmr9tyShgehkAfqBK690KDA0HSbN1cHjMA0BvCL?=
 =?us-ascii?Q?QJCkUg91BSmL18Ir/Y/CCBwOfDLTwiA6OGafynlDgspwP8DIRnEdJl1Xgz2J?=
 =?us-ascii?Q?40lySmBNUX/7L0wyoURwa1kOJGsaeMi5nMGtauG1cHlzm9lYof7i75pX2Huq?=
 =?us-ascii?Q?EybpyBlQDLXYH3BOsBVsCmGbGo8nYhw4veuxtPXNRZ153vPhBSPt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba5895-f543-45fd-5905-08df2a5dcde5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:44:08.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awMJ98RnY1eYBMcepL29m91XXaVVEz5PByZuocjuhaW4HtspSrfoakwtYq+rqv9xuFZG1KoNZc+RVPp2+hYRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1961

Hi,

This small patch set fixes vNTB ignoring the host's MSI-X selection. On
endpoint controllers that expose an MSI-X capability, such as RK3588,
ntb_hw_epf can select MSI-X, but pci-epf-vntb still configures and
raises MSI. When MSI-X is selected, doorbell interrupts are not
delivered, and the host may report IOMMU faults if it's enabled.

The fix allocates space for the MSI-X Table and PBA in a BAR, using an
EPF-owned layout. This brings vNTB in line with other EPF
implementations, such as pci-epf-test and nvmet-pci-epf.

This series is based on pci/endpoint plus:
https://lore.kernel.org/r/20261014071448.2473208-1-den@valinux.co.jp/
Although the changes are logically independent, this avoids conflicts
when applying the two patches after it.

Side note: I initially planned to have vNTB make use of the pre-mapped
	   MSI-X Table/PBA regions when available [1]. That work is on
	   hold because of an unresolved issue on RK3588 [2]: host
	   writes to the Message Address field (the 1st eight bytes) of
	   table entry #0 did not seem to reach the internal Table RAM.

[1] In the earlier series, I called this a "hardware-owned" layout to
    distinguish it from an "EPF-owned" layout. In hindsight,
    "hardware-owned" might sound a bit awkward.
[2] https://lore.kernel.org/r/sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd/

Best regards,
Koichiro Den
---
Changes since v4:
  - Split out the local epf cleanup into a prep patch. (Frank)
    Now that there are two patches, I've resurrected the cover letter.
  - Minimize the diff by not updating the MSI labels in the
    interrupt-numbering comment. (Frank)

v4: https://lore.kernel.org/r/20261014053256.2378817-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260919172021.1055451-1-den@valinux.co.jp/

The earlier series also tried to use the fixed MSI-X Table/PBA regions,
but ran into the RK3588 issue mentioned above:
(v2: https://lore.kernel.org/r/20260830151948.3547577-1-den@valinux.co.jp/)
(v1: https://lore.kernel.org/r/20260827182012.1984960-1-den@valinux.co.jp/)


Koichiro Den (2):
  PCI: endpoint: pci-epf-vntb: Use a local epf pointer in interrupt
    setup
  PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 58 +++++++++++++++----
 1 file changed, 46 insertions(+), 12 deletions(-)


base-commit: 5cdbd6d3a3a147fa9975e35f2602cbec9a72a932
prerequisite-patch-id: 77967f15b7e75c72ca5f9b236d16c2866e3c6e1c
-- 
2.54.0

