Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012054.outbound.protection.outlook.com [52.103.43.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB53386572;
	Mon, 25 May 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716597; cv=fail; b=qD6BFRlnOERw6tpFkP0WuAl8OkY0utboU3UXuJl8txtrsUpM28ZdTOKn2A5OGySJ7G8kZ+2Tu8W7ur9RMh+4cgF46bR/5zJU5d9spg+AUzqqYHNZMWL1B+xO4nio0fAad72bXRTsbvS5Ak9PPmVc/vl7880uL1f3bwvhHh78IPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716597; c=relaxed/simple;
	bh=tTXeE+QQhY8jxw7qEhCrxPeS7oXNBISTbd4kO8Iwcok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njLXgd3761zsVq5g6je++PhQGdoMu8Ea/KJJ11sSzJbSDrHEiMD6PG/unWkO120noyhf5uxFaW3Mxxb3RzdbmgLeFWmh4iJshRmJLmnXYgiKTLhExP7MFaQD1jfWCHycuOW3+ztd0blsux2AictVKf9oy8UqZClfrVI4enoKrH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Rpy9msgd; arc=fail smtp.client-ip=52.103.43.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Rpy9msgd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe7yIM9dpZWUSMqkbQ+jNE1CSik+iIUmEAFW1ofuuwYjuZJTPxY7s6Raqe0RLAiKEWtzDdnR5ui/y7iF8jfoK11QCXonR80jspL9Ln7zVJU6dHufeWVe5/hW8fX3tTN9poeA1ex7zeu4otG0BHbhJeW/hIa7fpWhaHnVgSoP7bMjKACCWCdhZU54rZBvA4y2Osiukd7jrPEGUd8KZzmIXpt8u1Uw79PX3GQy9Qf2n0j1RONhDF/sM4KSGeHHf2p9ev9SFhGiZBjQWnfHybVPNKpPqJacwt+bYgTUxxITU+Q9eE6I71tXyJ3jhnIFh2OqYjyCyzZ4C4EeeqJ2GJA8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujLtjqKmCL4WJSOr5r7HNrz98YfQELkJjc4Itn2Ekw0=;
 b=SWf+Y/UrHkx8Wjt0bkIBB8d++v/QCzKGzHgd3oObMMcxiftIUrxIliPfKiSV2MbC64kYDCTQrJYO5IUiZsElGUUr7R2j0UDhm9L8hbu+GdJKzGGHSTAdtQWSrmvPzfwdsaKVsbkoJ+NucR1RUFy9aP34I5Jftyd5Y9xE1beeSvV9hqzHCxYbZtNrX0nZhWWpqpjeR1/1nYX4KjdVlbYIJBmLaS9sTBDtgdmKfO70vVx+KWYylePnjEDbAmRzG0ET0NAkcEs+/xEsPj3AoadxAHgVD0cSBALzK3ZQVpztbbYchp5SgV8aSOxl4ZSNAZP1ni5KZt/e6gAFIL1dp9EFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujLtjqKmCL4WJSOr5r7HNrz98YfQELkJjc4Itn2Ekw0=;
 b=Rpy9msgdBMEZ6Jxc9An3NYmfqi/TyZnbmDt6jKwwkLrz/d5mS/xUs/bW1IsGbLBhAset3keiqyiHTKOwBhTWPoWhDahK3jVPd1cWl34g/InRS1lTrPZcUe2LcrEi+YSxqDdrn25HjNgELf5Z8fwYnA3mNK63otShLqAzUwUaTBf49xLiFi/iyyoKEqeTuPHxrDscLhSjBRsyMQkSNYe8dUmHljTfmXAXSGLh8JigWFrJEKTnNgMsyaWbLQa1iM2Je7YXnB0FDnVTvPNZzCfxMAZPFSOFC2kS7PnQNYeV7Z89l7v+/yPgerI+ZFDItiw62//v9arVCAZeNgESIOGXKA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:11 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:11 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Sat, 23 May 2026 22:01:39 +0800
Message-ID:
 <SI2PR01MB439366DE71A159586C205E80DC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <b0a1c8b0f36b78fad566ae268abbf34a455dadb4.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6098c244-371f-4533-7bce-08deba638fa3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|37011999003|51005399006|5072599009|15080799012|8060799015|19110799012|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfGllanJhm3yd3o+tsPm8ie1vrXW2IYD2wQZ/l28TuC6yh+5nofk3OI16dAW?=
 =?us-ascii?Q?p2RD5j06XOkkC6ziU06sMr06aJbw+uDR7cw+XlUQu20VX+6hCyCntC+3wLx1?=
 =?us-ascii?Q?VI9HsTgd4nG1AGfDlWmhioPjq7Lt5KfOUsiETbr4i7NxrRQTGVqP8hcXtctC?=
 =?us-ascii?Q?ohNE1PP2qEDzCgOgMocVsKOUrINVmJTRCKD+FpI7HybBZ6SlwpBvxsyvOoTP?=
 =?us-ascii?Q?xYMc4xNdm/DBVEm43XLBLfQZ7I+eRCOE9wu/Eq9Fdm+Vpqgq5VSTDHFXYPSo?=
 =?us-ascii?Q?67hSryAo9UjqG/fyJFGtIf75SniRyF5vTfC3KQVaG/BCkmSP0qRI/rRK9q2b?=
 =?us-ascii?Q?0O4u/9QvhTDGwUgjsoxEfoAxOSuYmBT7psmr+MqKLlyvc75y1e8mmUIfg0Zn?=
 =?us-ascii?Q?GRaiNko0ZIwI4xrK7f7lmdvtOiYBJxDqLZZ4TwOf4KMeufqCn97soGxUQIAW?=
 =?us-ascii?Q?JNlfvkWeeTOJD5ltgIy6JANDYNXu8UJdLIzhr22jtYkaWoSblMNbNSI1XtJ4?=
 =?us-ascii?Q?R5I6BaQtYiqDDzZCGP8sryt77lkeDs9rd0pFJWQq+MlOobPQ1xFsNF7XojeS?=
 =?us-ascii?Q?cn0Uy5OT/2pndbzOfZpii6f6GXVk2PLd4DNblFpi8d21dGuJCDU6NXgBs1BU?=
 =?us-ascii?Q?aN9RX06PdynZEd58IwTiZKEyL1kRQNd9OjaeZHflUO8CJBf0eT33/XvRGU9s?=
 =?us-ascii?Q?kTOzWOfM3LvDFKGt/JkMclr5DjvC2TA1vhdCWR8zP5qJvq4Vvolmt8u7f3mq?=
 =?us-ascii?Q?2YefkgjRZaiB0oXcwMMEsW54ZkP0Co8Ou26I9nSDU6Xje0R1fvjt+FvyRPF1?=
 =?us-ascii?Q?4kdDiCWLc77M2n/daR4wzvlbC5fEQ3KmCreXQmqPL49Buy6c+KipmsjF0Rcn?=
 =?us-ascii?Q?z2JbPdL9FsZOJBxnN0j5ztTL5lvdq3evTlPOZJhQK0E0JkNdXSIZqRRkLaCi?=
 =?us-ascii?Q?wsKX2+AaHvY3nglqSEYxa17oLbttz0VssP1d5HVfvf1tLwiw9RVucku4jAc8?=
 =?us-ascii?Q?xIvQIQo7PHM/bYCDtw2Mf1mEXjb6DXsLMqCPUwvnmDN0+jhUvxUYz9WP7Iqa?=
 =?us-ascii?Q?hIDzkMHW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7xrPhMsHNw9asbzxOFCXUJyji3uxWPXyzOouDvrtXnmJzopDMMfWkr2ZAw0D?=
 =?us-ascii?Q?lMrB3GBT/bLgZk09zbjkgA3phK3IAGQKit77sMLmItPZ1pvX0o0SqjhUbkKM?=
 =?us-ascii?Q?tjcsDKPGHQ9w97xtiUD4p9u+2LvEGd4qzFLJ7Ec7KRnEEuvXhhJE/oqi9pym?=
 =?us-ascii?Q?9Bv+uQXlsS1fxgAfSQajy+/OtT3v6QgUk45ADbLZkyC1t/cqyRIX0nGdHt1t?=
 =?us-ascii?Q?gC9OC3KBnRcUiW9bRCxQ/1FIdIUf8m/5lzEQ3dFqiCosplfzDgZ9hQvigQab?=
 =?us-ascii?Q?L7IWR31XAiAC0opMFFcLJwkICfsWLBdbd1hW+Tbq2S2ScBC+kW4WMRN9/oTp?=
 =?us-ascii?Q?XMt5KXfETei8Mek3Ww1v749dyxM791Iuz3VxDlmmVwp8xJ7xWhQ4SIvT/ADd?=
 =?us-ascii?Q?crreU6fTyTIOh+C1me78tMfRDNsbZQ5bowlgMAATOIAadB336w/eoR/FJkiR?=
 =?us-ascii?Q?8tKaxA/c/ddl2HzYmZvQ08M5kG9C4sC+B6pThoB77MCmiuRwSmRYEro0PHRh?=
 =?us-ascii?Q?BIODlQFL5MvfMFDpxLH+mXM3Q7QPIHUx+6/tJccUmxMtO+x6UB5lCANG3jAv?=
 =?us-ascii?Q?BlWLq1lijW/ICCtFoHbXBt9dh1jYMELIfJ0yiatkQ66Fx3DuPTJPqB48vGXV?=
 =?us-ascii?Q?eMKMLLdhJwnJaUwDOZ6WwGieV/cg1Pu6pyik06ghz7gcnH/vLtZo8RH0cCcP?=
 =?us-ascii?Q?HeWC0AwiCTNgABOQmepg89B6UgLmWq9hpRV1dwShkSqJJDQeG4jIgk0y7OIB?=
 =?us-ascii?Q?M7vxR5KAXVumXc2HOSUg+ngOAVmqwTjvat5egGINa42CpUSJHcPx7P/+3+jL?=
 =?us-ascii?Q?AE0vTanSAQF2ltPRH0C6igycwSyI4kFpiXIUC9rOhrG86EoRDL755w5M1kdM?=
 =?us-ascii?Q?lpnrZeU2b1/F7FJGeY3AinTpo6SRnb3oWF7AaGFN1bnqPSJdnsDH5ilqdpBd?=
 =?us-ascii?Q?sm/hfwIW5V5qNU9HFATxnbvUZQewVPNMHdT1/l96nGecfptlLA47V2kHxQO7?=
 =?us-ascii?Q?fX0kIxzGiP1EDZ0mX6thcqaZPoa8KmZfmjcJ/4FIBIUUaSSbIt8yIZXSHonA?=
 =?us-ascii?Q?GMXvz5RWZHh+4P3GL/PRQ2BxaLf68eUuqZN4ldITWgLnT2F7oyw+VtP62ovw?=
 =?us-ascii?Q?as263fYYY6LDsGChgICb+YVWdYaKy+HwVxJLxriAEDp3TG9lahV0vBUifLZc?=
 =?us-ascii?Q?m+zxjbpkGsHrprDBObveCyN/p64CnnstluwENIiVM0zdgeLCJQtbUoh87MGZ?=
 =?us-ascii?Q?n0FF9JEn/6tTkMvI6MU4fmS0R1mYv4h1YmTRIDfF5pKYa0iaqRgpU3uuu6Fj?=
 =?us-ascii?Q?84XXrHVcmokGvNKxGqL01WQsPed6TAg0TUByj+c2I1Vur7627HIdjiLIWSoP?=
 =?us-ascii?Q?zHaEh3ghQKo1U8dE+fIr/ADb0coA?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6098c244-371f-4533-7bce-08deba638fa3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:11.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

The config_acs parameter allows configuring ACS settings for multiple PCI
devices by separating entries with semicolons. The current documentation
only illustrates applying one configuration pattern to all devices, but
does not show how to specify multiple devices with different ACS settings
in a single parameter. Add an example demonstrating multi-device usage
with distinct ACS configurations.

Some bootloaders interpret ';' as a command separator, which can cause
the parameter to be split as multiple commands. Document that the entire
parameter may need to be quoted to avoid bootloader parsing issues. This
avoids confusing bootloader errors such as "can't find command <BDF>"
when passing multiple device entries.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6f0910abdd25..91d2f3fbf8e7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5281,6 +5281,13 @@ Kernel parameters
 
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+
+				  "pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0"
+				configures two devices with different ACS settings.
+				Note: Some bootloaders interpret ';' as a command
+				separator. If so, quote the entire parameter to
+				ensure it is passed to the kernel unchanged.
+
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
-- 
2.51.0

