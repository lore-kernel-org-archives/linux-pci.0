Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012050.outbound.protection.outlook.com [52.103.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BA382F08;
	Thu,  3 Sep 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407212; cv=fail; b=V2ZoLfQKK37sd+i4HMwmP3Guw4XebDr1tlmweoSbrwmDqpYutQp56PwLNzph0Lit+IsNLH1NuFYjA4VvfPmjjKN3PQOXONY3yctGdHac4VPFP/KSqxq0dCVnSeY8PBKjBIt2xGW7pFiFMl4POEJ5F0BYYnQcrU8AXK2PfQgg5K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407212; c=relaxed/simple;
	bh=gOB2hlgGiC9YV7SkB7N6wuV+p4TniHHae7xUAZjwFOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOFB6SOkuShCRZCMdFNxO6y1EJwKNfhD8qDhg50gIfCnazCcsJqmlrqbM+JLtxY/q12a0ZucpfSn8kvpbiGTB2D4G7xjEWdvmIC7TRnQhtO2HlCO4HQJD5R+uSG0Q/jP5Rnl7WB4dOfc64d7F1637ZgZ4dqHqCEw082Nmxs3D1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GgyTEJxO; arc=fail smtp.client-ip=52.103.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GgyTEJxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woJCobOmkJ11gDdw/d2DR5IBEOgi2XyEPV6qk1bobWQDccy8nJENIpA5IZkekZN8X0FvAMBPauokdImaYwm10GGBo963u+BhscwCKSBQ7eM2O9esUyv+YGI03dcDvlg5LPcM3OGmuKxMnZRNmG8Lgt4krT5Vhs0J0IoRnf7FW5sgkpopuMfFX/ArnbQmHSfVV3B7HLd8+2fSKBKy//84xj7waUfrAJKxwAuJrwW2EakRajMZd8FsVGVy00Y1OxGMFpTv3wp6v4Np+Xq5Wd9i12gptSw3V9madjSntqPUcVkwDrPIoO1vDEHifEEe9HovzKCGZzGd+5sOQHX9H+nN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzEt2RtPYD3TvvDC/E42PvyXIU4V4kp0oGpqT5CamPY=;
 b=geuTlmFkAsRa3DcKTHnR/j6Ac0GTyWz0RVE9evKfHQmB17eTMhZRr2dQ1+vApXhqV24MdAI/EIyIHGk4pZy1Z9vd1Um1tsU49oSOSSl+QuPhhw8O+Rm3YwZKnBxbZdCR81WVijE9DH5xtQBTiF+AT1auEMt2qCm6LZ3FxvDmztt+glkhtC4hf/jR7YGr9b/m0yiTH5Zn+MGN1q+bZAbiZbiUZUk22+1gccUHg9pcrvQwFBdfBBD/Dk8yarfAKVmlUKw+CKqRu3xKZ9AUd1GGjd1sJmigo+69S03B6JpKwnrjYf7cIF0dO4qphIE7FWr2jw4i4VRNlI/Dhj5IgvmB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzEt2RtPYD3TvvDC/E42PvyXIU4V4kp0oGpqT5CamPY=;
 b=GgyTEJxOOIqb/M8Kqackz3ix4XtyiuVH6pHnZ7yr7StzcsKdHHutQlCt7N78IcugTfmufNt20ECUOsvfm7Msdmel1H/TuUHKCryTR3E9TtNxy/pyzFrAxu1ADsGLEgRTT8QC7WNBAftzWCGoUSXrqasP1m5RpIlk4g2SleXXkfSvtJvir5NgTYeBrDF4/y4e6pM+/ISmoeMonEiS2yvZJETeOOlOuUrAM3DHkCfSYXPOsXrfbCKL2IxLnlYEViQPUVO7nduTFqbpl5fhNfu4aIecPfTICwLcqXt8Vov0Nbat0Ct8GBdken5RB8aqz6lAjyuItiTNtOYkdmPYXUO8TQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4733.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:46:43 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:43 +0000
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
Subject: [PATCH v9 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Thu,  3 Sep 2026 11:46:14 +0800
Message-ID:
 <SI2PR01MB439342D6BDCFD10A2B6207B9DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc8d4d6-2198-4f71-e3c8-08df096df837
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOIGbsM2YkM/0KWVoI7OPJch97BO9k14RMvIiBD7YF8Og4YAr+0GvbCBWR90Tv7thZZGKtXBoZDvYYrvDKaH1G5+KJcQQiYgqmR85v+51cKRvyWPIjdnDDm5P3Xm0YgUk2xhHMQfNlY525GpkOijhvdz6JZWSk2A+RXCu8VjX7OJmAmwJx5u92KGsW8DD+a5awDd+yvo9iVi4y10XYC64s6RCUwVZlmZL6VEbmXdGzp6sy+RtZDpDk+M0JaOBMBP/aybL3+5fBbuzuOTiqOOZ+R+0lHhrN8uIVEPiozfzuaAGG1YAIWP5dCqLfPtG3uoGsjSUZdeo6ckSYjCZCtznLHS6eW9kxr54pEey8VoByIvfKXpslpA6Uye4oyVkvkBxYuas/HYVijl1CUTNB3a7Ux0UnYBGHQ08ZlqQUDbo6MxHDkvLyYeWWKdO5WzpT7ZQBHdtYVHPj4TuTVZGAO2oahUkNRNykmyfdjkSExW76vbWuBMFCBpnh6ARr6Tc7oV0ZF+qFRSj11L3fnHtDZaQDbgM+o7W0+m9qzUcpj/Ds6fSBSBzaY2mLiqe6NQKkJeC8BBp0pxaefaMfSdowYoc6SICccBjQ3G5sGBmsU+5lTxOwG782hm2LuyppDvmfUzpCqaTBqkCnrjceXMXdpnvZkr2pREOs+TQ7uvt5nuiAO0kM2XpeyGa7t8YesGc1zRHvsEV4cvEs1lw9hiTkrVcL7kjs/BCSXOOoytJj+N3nr10=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|25010399006|23021999003|8060799015|37011999003|45011099003|15080799012|51005399006|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtxnHZ3r4a3gNJFNJlIcuQ/OEMxpUfKCBP1mzxz2Fno+R8oP34+2OJ0kGqA1?=
 =?us-ascii?Q?jh135f8L139g2GjChiYg4VxlmJjHPHp4DU2VBvgHR7NIxE5XEJst9QYTbKQV?=
 =?us-ascii?Q?nXfsVt+2uXvGnJqBv/HizQn4sn4zb48GQTQaM0wY0vQA7odLp749Z2BUNx56?=
 =?us-ascii?Q?Rbwu+v0op2U4inDLVI9H/nE1iCjcEwnRAF3ztEy2AdqjBBcGd1UPU8rDpZSE?=
 =?us-ascii?Q?wUmtTEggLAJcKOnx2MWTX2JNe2Pvbpugz5Hbm28awOBxo/2mSyFVGtoPLscz?=
 =?us-ascii?Q?L6bajfp+KrvVrefY1NWPOCtGMdD7KSFOrazL7auWziLhlWZx+qZSS8AqDeik?=
 =?us-ascii?Q?lLSCv+xyXlY1VhADYyGOCtxRnT+UOzs4wg0KXTlwecVGOfjOgDRzSuM/CdY8?=
 =?us-ascii?Q?AV5sZMqd0mIw/JpliwvtvlEJVImFxYxeuNtKT6gyOIjr8Q5i6wVrbRAdfi2s?=
 =?us-ascii?Q?4dyLKkp9WTbvMHOOY5MiJmUagsMYAnO0SJORMnTTZLYywWGoeon5ud7nR28a?=
 =?us-ascii?Q?ssgcnLCOfAlEPBGoLldBjTwmtG/Gh2vtRS1NJEb8ap7kPYLwz8MBU1zhlnz7?=
 =?us-ascii?Q?wGn7IZK6iEl3Ojsywz2U8R25s8nGVJUx93smNyJFNgTTiyi7clBwvFMgaHWI?=
 =?us-ascii?Q?AfX4ZWfAarASPptzkYsoKhSjs9+w30NL8PKgMWQw7XQ3WLWNF3mhUtIwmACf?=
 =?us-ascii?Q?lYoYsH1ZVzlvYXy4OYeKxhKZq6nykl7DRUVVMSh+NxHhR04GQdH3fJKEJpEV?=
 =?us-ascii?Q?+taDY0GOc0X1vj4CjjNVrxZhXctLQf0HTPDIRlqo1gseM1ZYqpm4R4U3u+89?=
 =?us-ascii?Q?WT8HlcEu7XT2ItmRK8RlDkBwD/ywfQm39k7hYQYBsa5LghM37cxijXpv6k68?=
 =?us-ascii?Q?GqZ9quZytAwZIrmpBUJdI+Y9mUuLKs6YCeftomGPAIYmdWYNr8xUW9UiQcZP?=
 =?us-ascii?Q?DxXxHSnzNSU/ALlI8B6X0TgGxLEoCllbX/4qZ+bF4TK8h2m6QK2u+fcMICav?=
 =?us-ascii?Q?IIx8?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bXGxYwnba+mvdlpRohUf64dYanKCReKeV0HMG4CKPteBbnp2mDzJV992fvh?=
 =?us-ascii?Q?2DsZLPQ069H+Km9zjWpflkgujCB1BmtqW4SBjKoHrZFEcTukkrAOPc3UyzHS?=
 =?us-ascii?Q?60uE18b6iegu2PbULUuMxGUCThDD8Y5ue/EJ0zjpHj/3/phJ6d6fJRqRXh0e?=
 =?us-ascii?Q?OUjP146f0OFSrtWpllobwLSBXfPx+pGQIqdlADjobwGuUzmAvOe5rAJZ/I37?=
 =?us-ascii?Q?O/82FpB/kgaIu5N1Uvm9df4INhDKxjscyjCzqqH86wcBpNgkFXt0ZYOLrv6v?=
 =?us-ascii?Q?n9hKakUo6nB0T4Cjm4wqjulwHVchT6UyDt3QAzyZz/m7dJGRtWPXV8/4pmxQ?=
 =?us-ascii?Q?qwD9+FOjw9iZbq5nMknhopNSDu5i3xoJvErdQKaucjnHjvkw2oEBApaO4KDA?=
 =?us-ascii?Q?Yfs9kl7ys4qRfMxMZqDcESs3W5H9t+rI0ScU3yJCQghsihbSVnhxGhC2nWQU?=
 =?us-ascii?Q?Mv3tBAjVK326BGeZaPiMqx312jBblciJQICQThNP9jLWpGh1JDVCF0cAKTLk?=
 =?us-ascii?Q?STpFbt4mvMNNQ8177QSmG6c4LjdHjXSzNp1ipL/bbu4pJVhsJCUsrBgXlF+h?=
 =?us-ascii?Q?HkyfvrP1S2p6Tf59ds7kslVk1H7kXUPSLIqoeNEsor5geEl5v7CA15vOXRSn?=
 =?us-ascii?Q?saY9a8cYJpWGPNDfUEWq4nPkt+8Tf0gg8IbDCRwJg/YjZNtOUh5XTt50A2VP?=
 =?us-ascii?Q?XcxEOLUTqjTqmBo3YVOIhV8nzGi0V/FTAw9T2xOl+G/S8IMKO65XeE+M7hKx?=
 =?us-ascii?Q?BE0CmdtsQR5N1FCZJmxFxJqeWfPLqdhY58HzLXCN4sTVahX+vpGENfXiIubj?=
 =?us-ascii?Q?ml30wk0vZpY7DW9FQ0lHfb7ZMsrlm1geWqTzMNSyExQJCdT9bn7HyqsNwzqT?=
 =?us-ascii?Q?XoTb+8BS8N83P+hDZusXfGXBOJTrnFtKBxYCMVUo4U++TyUK0cwT2bp8+s01?=
 =?us-ascii?Q?uidIA151ITdkg0gwp6JzZCWNHUyEIM2htZgkll5KraRv4efXN11CUzoKLfmO?=
 =?us-ascii?Q?px2kVfz2KiHJXsm3xu8B/64ui2RFhkyQkxn5YdAMGU9+9nKrUHIncilRA8BF?=
 =?us-ascii?Q?HsX5KIodN0oi67c7hRUGhHZd1tjJO5TK4T3wuABzDqrU441KMr+K+HH7bLw1?=
 =?us-ascii?Q?GrzvRHg9WbxMbIuKbLrVgc1DtprurWVrJhLGRFlP0uYH+NI22eQM/I1bM1cI?=
 =?us-ascii?Q?Wxz5SVaateZsIzdX9vANm106AIYEN7N1t70DEa2fcSE+V4uBVz9JF/IAuvu7?=
 =?us-ascii?Q?7bDq1cFjQYY21WQiuluSDYp+ukrgZftdv4auwXkEkJtGTVRn5gQf9cdN9oOv?=
 =?us-ascii?Q?dc8duW/lDSevm/TLw50tQ4XLi2Q8120btmknyVTAuiBS+Jjl+vNoTAe+C3Qd?=
 =?us-ascii?Q?feOzdfLxvOGM2ydA42Ymki5NVCPx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc8d4d6-2198-4f71-e3c8-08df096df837
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:43.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4733

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
index 63f0c66c9123..a2563ff69f51 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5345,6 +5345,13 @@ Kernel parameters
 
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

