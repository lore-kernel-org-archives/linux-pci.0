Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905189;
	b=O2hw5z1I0r8nMkxacbAfMCDwa0h3s9CEiBfhFy/7V8aWyrUn1ZNC28/BROtZTuGvGrvp
	 2+K1sOY4oPE9RCY/e3duUeX80WZhAJgOwWgqiVwVTtqtNrdadE/M+mgF/kot+37u9KB1M
	 VjFhol0fkjuuhu98iXfpNXHEnDZsBQcqjgs1vL3ZiXjxMhrVAzwbMOqSF4JXpemibNiaw
	 m/cKf+lfBsbFs2g6ntCp4SMdTSBoQPwtCgqo6rmf4WBaJNhapgTM95NNeUyACcxCyvFwV
	 WNn+rFH3SN3GrKfTIUbvSOMdtFElAWHLMrxbyE8m8mRXyATaE6e6UdgPp95Z2aqC+HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905189;
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
	bh=NmtgtbpGAMwNJOLa6AYZ8XALJZx4ITXl66v7MBfWwWE=;
	b=1Z/PIHIZhDoGf0x5qPPUvMDaXx7wvcYzWOME1S+/lk2e1PWQ1+7hg8WExPw9CNIISJDg
	 NzvWXuV8Z3ibtLhW8dcYynf/CrtasbLVCRHZ0lVL0rvT6pg/dJZL7Ww8dQzL47C0ju8oA
	 sMwIu1t6vbT6s04bvpSSm0lrOOa9MU3QuEwhrT0IU2Xwc9IU0Df1Tuxzq+z80xgPCmT5c
	 4VUurdQhdK5u/vrC0I7SguygrQAmBgjkGWn45nVMZxpifFkkmxCemNXvVSNm6N/khb7lS
	 K2ISim3ReaDffZsBooTOhdMA3C88jKY/quGZUp/6ZqKtHtR4+9hJUarC1bvbGwYNe4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CUZbX+yp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7D606D828;
	Thu,  5 Nov 2026 18:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C7D606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CUZbX+yp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3JRUKWSkUXV8FhW1/iNg8FKigBSVPB6VVN4LWNhwXa9k0a4V6X1yEvke43z6NOVrQ7+CV7Auk/0MmIc3cUMi02z5ZEHkqzGtuiT3bQdAioj7938A9mPrbn4NP3mpG+4fglliRexqajeuYI+/sPCCoKfNYKGKbM95H3xuU8hxNrr/+yTDCJyh3KsdUfY5naz6P0/Vu41uYs0NImwwbrXV3WwAe6cZzxhiwBGCNTXxjgUsaBEwZB8uGMtXI2mN1gVhTbHsdAL3b/0eGhVZ4uwQ4Lsni88xvbSUwrqu32pAiWyUugHn0+du/lguVlKuVo/NhrwA7IHS7eSx07lDdGaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmtgtbpGAMwNJOLa6AYZ8XALJZx4ITXl66v7MBfWwWE=;
 b=K4QWQ3qLmV1uMzkaG0n4UDICbZ9aiByntPvJ5J251GAmLUineB7qUuj5APYcoMQsNe+o3sR1h2dutDQ5IZEuF3Nz5vQ4CJjCJhop7GtqUEoyhG/CXoCNqj0ZCQ+bHHDAYGAb8VD2WmdaQ4orzMtehDzdVRgQ/bAV1V7OLlNEl15Cvfbh78rpI5Kc+UbvBKHFhtjoObWWCPFwM7DsL2eEGi5hiI/W7jwpc3p70BDpEDqF07xtugZDF7uy1PbuSh+IMVrCx4NxrN4KJ1DLK3dafIOw/6O3Vro5ED/DhipTktZ1qSRLAr1J9+q8MdqXOudmlnwslFmWedO3A1ROeWBa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmtgtbpGAMwNJOLa6AYZ8XALJZx4ITXl66v7MBfWwWE=;
 b=CUZbX+ypNQ94RstJ6bZ4iQ2WJokBM7GNYIN891k3Kl52sBv6fvi1Iyo/CJ65fieYG2eIN3sZC6g0A6FX/qs4SgVIYtpXug8MjEwgspiMu1VPQ41NEYpiBD+TaIaxtjExoYg+49fEstch2327lsMyI0jU6DN6VWLjUkNKk4ORkQp8fchV457XO7t/8/Y1yGOw0ZNotyZ1ux/hgVNquxLbQ3kd2ENTsul2xWDgZ50w5Up8sQBPOV1rhiMmUbVTkbaBb4WJIQ0JlqPqg81be0oaTnu9DTv/eO1V6Y0HrHbrngk7KXcHJVYqL69sDCpcXRiNmd5+PujSvJenjJqY8bA4/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:42 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:42 +0000
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
Subject: [PATCH v17 09/19] cxl: Refresh cached PCI HDM decoder settings
Date: Thu,  5 Nov 2026 18:59:07 +0000
Message-ID: <20261105185917.2667656-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d95e6c43-bd3b-4f0f-f2fd-08df3b6ef361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|260925021911599003|260925022911599003|260925021311599003|56012099006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261022113327099003|261102130727099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Pfi9aHM4nif5OfkgrHAxDHoOs76B8PWB1+/WSnY8zSfDAmgPYdEiEWD5woMeJLZXO6nuvFfg9ivVfmHEoomem8qOGEk15Jbk8e0S46TeLIA9WDmLLR2jxAhCLppUjGF8iRe+5rViqr9XAzskqcRAscqXbaOUG0SA4+3LAHwZAhebxNgxmhW8nD+tJMWACKjwalxKxzIhSHEHoosgtx5shv2ZSRjN6i60BPgsAmq01F6d++28jE1d3n7SLFK/P4Wkoh1EkX0AAdRa30BSfc8CObVB7pU8shL/M1heMXb14JcnPBenJglw6EjbRkJfhslaA9nSmKPBCHcAnzWevcVTXM9NNQPCgtCskwv9cBjvXsu3FUddnFsooLNA4BtpDeDb3EUMeGriHFilsRoWOpnn0REgOmN4LcsXFumdXRqehWS1/5jbslor9OTFl5kKra345yFQlLHcfFnHMxy98YfBSfyE7hsvDjVSsABsg1kSIcgZIHn13YwJVUUxZ7cLb1kx+F//UykkxqKI6FGYaqDb8nqmFINVetOdalzifrQb8WQZ7hPJPhuW2hL2SjO/sZdXBJfhKN0S6Af/1/Q5EeXDVWp9kHGJBLD6FXCOuV7v1nIL6WjAN4iUDK1/OuezZvW0VXF9cQux+oPkiCPax1V4z2XGS6nJ239vasz9znNWmRwLn7uP28wkk6G3ajkJXP1klWuFN2+n3lBw/STgymbuyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261102130727099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1ZFCEg6NrHzwMycalW00RmR9ibi23qn3+Z9R7XR5wVlxpeSyTDZCopu/Dbf?=
 =?us-ascii?Q?7c5tUJt87M3M6MvuFImxIoYH1BpV3C79guKmi7rZ3uNrmNqLQ4n10wHh320t?=
 =?us-ascii?Q?emC29z8z2rCkHzBE+oPI1heLfWFXOnBy4m3dS7Fas/P3637N3UNIeLfgao9m?=
 =?us-ascii?Q?5oSjL5JO+5CpcsDIk+9LtQ0w6gJAyfK6rz43LHz22iuEMZEeZA3RGp015OQ+?=
 =?us-ascii?Q?SDDaazDSVAHSKyjLc5qPoR2NLq8IvNMaMiA2wsWByMzwBPGW3RVYUrm5mMIU?=
 =?us-ascii?Q?JH4MPWeRDXcQuQR2AXV6vkMA03CdlhC/DmadZuGnsky+iFuUU6C98a+17gWI?=
 =?us-ascii?Q?d+CJoXeuBNqNsNl47fhOVBKp/RckuREq2WZ9mkDpjebys/SQxa6lqjJwEeh/?=
 =?us-ascii?Q?UW37LeCNpt8TGwKZ/EPQuEfqGFmtueXRWnC9N2AoUx6B05p2NKyUA0SIXimY?=
 =?us-ascii?Q?51aOjMeC+6EJXiNoiBgW3fT7oBgduBOfo0zymNsTD7Nvpw4oulviPxo10dWS?=
 =?us-ascii?Q?QRcxpHi8x7Z53Xi8kmXovu0At5Zx4qKNuOXgNn5SG02cj+9iZYp6ToIYhsAo?=
 =?us-ascii?Q?fZ6nIkQwe3kqdfPjINrIovBEc26+3l9CcyQvdmDredcpBzPxSajnLlZcWOOj?=
 =?us-ascii?Q?ZSKnY4aVMYWJVghK5q70Czt303M1DZN1Qhva9qqIFTmvbudSiEDFSFaPmsdG?=
 =?us-ascii?Q?PF/bY5zblI1X+jX3pifnT6dwTPBO4Pb8Nk3BCgvUwjDYUDJzvZGS/5CBr50Y?=
 =?us-ascii?Q?CGcU631XcXLBJCTxFll1Y4zwuICNXy0OiOIJg9G/8aaYhig29I3RNpIiwMK7?=
 =?us-ascii?Q?WerpF5NKUuaZ5fzxAgt7ey3imA5pg8uoKCBuH8Uk0dc3Q1AtgG8A6o9DV8Xk?=
 =?us-ascii?Q?Xq+iZ1TG/b2qobb8HC5VE0cK/SKmW6mLjRxOzIQVMB+8UbcZ4i+wpAkkRTEn?=
 =?us-ascii?Q?VMSgkWuLqow6bQtoIAFLmbb6Oq4/S582UeMAsbtfr04pIViEp9q0g4iwjSLL?=
 =?us-ascii?Q?/24FK4isBYMwbJO/iWgHLkWgyDQ0vTvzJVGauDihhhGFuMXZgbrnuvrpVGTD?=
 =?us-ascii?Q?wdTi4uj+yd028c25LVeEH6oPMSsYX9NuaaoPGTnaqf9qpYq7Fj6MKp719byQ?=
 =?us-ascii?Q?2zQyuWd9EPV2WWtevdC7NmJbga7SJ2J9tNmv0tn9elyUDUtPTNH0CLKA1rhX?=
 =?us-ascii?Q?N6E/hh+NfecBZ7cinBbUe0s+3h4P6jwEPO+C01j3W2wn5yJPbgvJWyJSJ96M?=
 =?us-ascii?Q?WGtVI/wtGFYtgG9IRiyHJO0IKpvQ9YpTS6hy8HRDW/W5Vydm3UcFIwMofvQ/?=
 =?us-ascii?Q?pKHndsMGb/nJiyTdYM2gUbVnV0Q5epJBEEkZo5E9pmTbokpMPXE67VgUydtG?=
 =?us-ascii?Q?+54lKoRGM51ntIZXTQIbsIBokwTFs5HUjlyXdhF060FfhaAA79y6Od5dchXV?=
 =?us-ascii?Q?D91RXe91JTGAPB4t6UeN3Lrs1bKbXHCcCHaw1+NsrDgHBC6CSPMPCSdP4Bdm?=
 =?us-ascii?Q?8Wls7WgRRTEyx11niSu+9+PIzm3mYR5L9+VnsPF+yRbrreuTzJyDSlYgh75h?=
 =?us-ascii?Q?OsDMo/LtI14/rZIl4fQWzZLDIlf8ZTEnrmHJWW8lUPZjQg01D/QUcvoUZGl2?=
 =?us-ascii?Q?ZTRb9rzAFr/wHeAZa3VRbR02uuti5NBJZERXDsMMcVThgYMU9UcKeNVBiP/x?=
 =?us-ascii?Q?LH9mriVCwH60VoMijoHyOplobI65WsV5MYk+WReJztW2t6nX1UqcjPFnqtVs?=
 =?us-ascii?Q?XW/28Ja6+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e6c43-bd3b-4f0f-f2fd-08df3b6ef361
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:42.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUoU2fDVJDB89o6sTv3ClZzj9OqrA7PcVg/zkM11R9N0gkaxuKZjCDZaE2W12dJz87jCbKu3mw10GKMD6cN2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Early PCI discovery creates the HDM cache, while later CXL enumeration and
decoder operations provide updated programming state.

Refresh the PCI snapshot when decoders are enumerated, committed, or reset
so reset recovery need not walk the CXL topology. Keep cache access and
locking in the built-in HDM state helpers. Ignore updates when no cache
exists and reject decoder-count mismatches.

Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
require it.

Skip cache checks and updates for DVSEC-emulated decoders, which do not
use HDM registers. Keep cached global control when MMIO reads return all
ones.

Non-PCI mock ports have no upstream PCI device, so the cache helpers
ignore them. This avoids test wrappers and a circular dependency between
cxl_core and cxl_mock.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
Reviewed-by: Richard Cheng <icheng@nvidia.com>

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=50a88f5194e5df38590d413f925d8d5afa8a8488
---
 drivers/cxl/Kconfig          |  5 ++++
 drivers/cxl/core/core.h      |  1 +
 drivers/cxl/core/hdm.c       | 34 +++++++++++++++++++--
 drivers/cxl/core/hdm_state.c | 57 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c       | 24 +++++++++++++++
 include/cxl/cxl.h            |  1 +
 include/cxl/hdm.h            | 32 ++++++++++++++++++++
 include/linux/pci.h          |  6 ++++
 8 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd..8b08bfdc4982 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
 	select FW_UPLOAD
 	select PCI_DOE
 	select FIRMWARE_TABLE
+	select CXL_RESET
 	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
 	select FWCTL if CXL_FEATURES
 	help
@@ -244,3 +245,7 @@ config CXL_ATL
 	depends on ACPI_PRMT && AMD_NB
 
 endif
+
+# CXL_BUS requires the PCI HDM cache and built-in state helpers, even when modular.
+config CXL_RESET
+	bool
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ea539f00e55d..e34d574f6594 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -224,6 +224,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 
 struct cxl_hdm;
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm);
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 85f9abf58a42..ec387070d7ad 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -725,6 +725,24 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
 }
 
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+
+	if (!hdm)
+		return;
+	if (!is_endpoint_decoder(&cxld->dev))
+		return;
+
+	pdev = cxl_port_get_uport_pci_dev(cxlhdm->port);
+	if (!pdev)
+		return;
+	cxl_hdm_cache_refresh_decoder(pdev, hdm,
+				      to_cxl_endpoint_decoder(&cxld->dev));
+}
+
 static void
 cxl_endpoint_decoder_snapshot(struct cxl_endpoint_decoder *cxled,
 			      struct cxl_endpoint_decoder_settings *settings)
@@ -805,6 +823,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->config.flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -877,6 +896,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1079,13 +1099,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i;
+	/* DVSEC-emulated decoders do not describe the cached HDM registers. */
+	bool emulated = should_emulate_decoders(info);
 	u64 dpa_base = 0;
+	int i, rc;
+
+	if (is_cxl_endpoint(port) && hdm && !emulated) {
+		rc = cxl_hdm_check_decoder_count(cxlhdm);
+		if (rc)
+			return rc;
+	}
 
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		int rc, target_count = cxlhdm->target_count;
+		int target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
@@ -1120,6 +1148,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		if (!emulated)
+			cxl_hdm_refresh_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index c9cc019902ef..d4c2be1ef833 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 
 #include <cxl/hdm.h>
@@ -13,3 +15,58 @@ struct cxl_rwsem cxl_rwsem = {
 	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
 };
 EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_endpoint_decoder_settings *settings;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_hdm_info *info;
+	u32 global_ctrl;
+	int id;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	id = cxld->config.id;
+	info = pdev->hdm;
+	if (!info)
+		return;
+	if (id < 0 || id >= info->decoder_count) {
+		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
+			 id, info->decoder_count);
+		return;
+	}
+
+	/* Preserve the last good value when the device does not respond. */
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (global_ctrl != U32_MAX)
+		info->global_ctrl = global_ctrl;
+	settings = &info->settings[id];
+
+	/*
+	 * A disabled decoder's software object may retain its old range and
+	 * skip state. Leave only the decoder id in the cached settings so stale
+	 * state is not restored as an enabled decode.
+	 */
+	*settings = (struct cxl_endpoint_decoder_settings) {
+		.config.id = id,
+	};
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
+		settings->config = cxld->config;
+		settings->skip = cxled->skip;
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_refresh_decoder, "cxl_core");
+
+int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	if (pdev->hdm && pdev->hdm->decoder_count != count) {
+		pci_warn(pdev,
+			 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+			 pdev->hdm->decoder_count, count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f72cd8f50e77..5272013548c7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <cxl/hdm.h>
 #include <cxl/pci.h>
 #include <linux/aer.h>
 #include <cxlpci.h>
@@ -180,6 +181,29 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
+/**
+ * cxl_hdm_check_decoder_count() - check enumeration against the PCI HDM cache
+ * @cxlhdm: HDM capability containing the decoder count to check
+ *
+ * Take cxl_rwsem.dpa for read while comparing the cached count. Call only
+ * for hardware HDM decoders, since DVSEC-emulated ranges do not describe
+ * the HDM registers represented by the cache.
+ *
+ * Return: 0 if the counts match or no upstream PCI device or cache exists,
+ * or -ENXIO if the cached and enumerated decoder counts differ.
+ */
+int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
+{
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(cxlhdm->port);
+
+	if (!pdev)
+		return 0;
+
+	return cxl_hdm_cache_check_decoder_count(pdev, cxlhdm->decoder_count);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6d6e564be27a..341a7c52894a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct cxl_hdm_info;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 219b9bb67440..06e9aa4479c2 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <cxl/cxl.h>
 
+struct pci_dev;
+struct cxl_endpoint_decoder;
+
 /**
  * struct cxl_endpoint_decoder_settings - endpoint HDM decoder programming
  * @config: common decoder configuration
@@ -16,4 +19,33 @@ struct cxl_endpoint_decoder_settings {
 	u64 skip;
 };
 
+/**
+ * struct cxl_hdm_info - cached CXL HDM state for a PCI device
+ * @decoder_count: number of entries in @settings
+ * @hdm_bar: PCI BAR containing the HDM decoder capability
+ * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
+ * @hdm_size: size of the HDM decoder register block
+ * @global_ctrl: HDM decoder global control register
+ * @dvsec_ctrl: CXL DVSEC control register
+ * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
+ * @settings: per-endpoint-decoder programming state
+ *
+ * Publication through pci_dev.hdm and all mutable fields are protected by
+ * cxl_rwsem.dpa.
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
+};
+
+void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
+				   struct cxl_endpoint_decoder *cxled);
+int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
+
 #endif /* __CXL_HDM_H__ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7bb37fcb556d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

