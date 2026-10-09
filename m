Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020085.outbound.protection.outlook.com [52.101.228.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCE3DD87F;
	Fri,  9 Oct 2026 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521712; cv=fail; b=RFZoeRQt2hcYRyrGStAriOZggbia0gMeZKtLqoEiMXq/NJNNskkrq1UWbXYaD2dHiuG5pbnmaumV1hkSZxttPhPtnDKyANGbaFgnLlSJN9hMld0tfjx4vJHQq8i4x3H0bvItLDixH/fJ+C+WAlIcMM+qKY3r0ovvNZfyoN9gX9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521712; c=relaxed/simple;
	bh=Tx2j8J4YCaf19OuI80Ow7sKj3dW/RLlpaVycxoujwoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fimTt/mUEZ9RttnUawAaYF0ty+CyNMYZ/R3WJkmjjqF2e7DkjfiSH47pbh+oTufgcvDribLf2DNxIfD+fgZOrQhgc+NB85PY+lg3dfZrvOFJaAe4AqKvaLJgUkpsCpRqOhDrNxRfn+ymDcO0NDaR7WR3f1ED6jZKymN9T3cHmnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=byNTItp4; arc=fail smtp.client-ip=52.101.228.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="byNTItp4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opDwyZLiidB4S13zIyEy3YFb1M8CtXLNgQaNdSO0rNI8CFqnZ/WAjmKAiSXX9dUfDFCus20QJzGf2p2VnmjlKL89I0ZtuPKrVgHq/RGKK3fhbEC47ULYrwruQEaV5QV7C4Vek1rQmbZxvf4i7w14yeQO4dSdeCTC6cesUMf4o3VcqJFX0K6T8DI29Rnzt5/rSRCvit+OgLdKdiBlwQNkFiH5t1Gy0CVOgWZ2SlafLFsZF9RiGKb6VkIOFwnfNW6QIBMLNsT88J+QsCPWyK7SDKLbRr96/yTXgLmMAqoQRjgRTZ2dhEm8lshAlbNzfV5D1KtPoNixGPZECd/goph/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM7LTXGAqUZ0PVLTVAKu4TM9eNyoBkchxEh5fhRoxaw=;
 b=inHjEUuN+KbSE+Rf83g5ljXcKUXuwXDhLX5Wl0POvcoyJLU57/Mj1GriL+d+yWQ71u6rl+jiR3vUo4nwtk59CRaVE92qhG0hifxzYZGrSrrjYI0RdlL20RP48jDrOVGYXmdCkGE4x9kBLAqGGO3SxCQlMfGsozwcNktK5vxaTse+fCgzn8LdyhugrXLdw6g2XAWeacl0F4J0IGz+CD7P9V0wKOWHijsmBwt61Vh+OmETp7iyOvoGeAYv3yBEAEtDpfJ0vVNEmHekGw4PvHzZ1078P2vkk/pttmV0V1AQgYTms3ehyS3/RoDoLxIqdz+HTdVna51Q2D1s1uy12yfFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM7LTXGAqUZ0PVLTVAKu4TM9eNyoBkchxEh5fhRoxaw=;
 b=byNTItp4SK42JopxmOIJOArE6lmXLWTLL2m2piQMQjmXFPI94HEe+XaRtJXST8aAxbmSU8iHLNCNU3cEw4WlVwZR0W3cp79XnbaBDt0dqjeNbaTGypBZA2Pv4Q8WxgLbPCTjsU+DauT/E6WTC0kvUeZbkkpgL37+8sxetlFlzks=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3079.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:55:05 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 04:55:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/3] cxl/acpi: Convert QTG _DSM latencies to picoseconds
Date: Fri,  9 Oct 2026 13:54:52 +0900
Message-ID: <20261009045452.1107921-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045452.1107921-1-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3079:EE_
X-MS-Office365-Filtering-Correlation-Id: 30920a87-a088-4af0-ee42-08df25c17c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AIOfABNb6K19iTPGzY9f0AZTjHmRCi7zRyAwll/5XTMMr3Ut4viSc686aagY3I+8ZQPdjKTWUEEN0M46OJXkEZA5Nl9NPaJM1aSSEI6gOBELaIr6Twudq+NyTxmwur2cCf3cJxLMI/NAh8yZEm7E5FLnntYl7vN79nMNlIdd6ryGyS6yEm0ps2DfA1nbatIaQQKDUHjef7u0iomi9qPs82bfCnkLinz6SRiKxj2/vIKKvy/WNdiVSg929rp88oRbvlIWflIS9NAQ1VGw4JtgyV9pOIkSqDN4ma/5u6JNGAh3pXMQPDHbd/z7pYgeEErEYJGCE4PrYO0UmpMcDFMmGTEIYi/SRtuaq1YH5pn0JawqLwIawCk+o4+AQvEhH3bv1oxZ1UYtADDKof+MVAKwTBpZZsUWerT7hqqZwLorQlr/trZBSYugGzWG9sfA/yeFO1nDwoKtmSIoZVALL4lKkDhetJ5Tw3eVJxr8ocH3nh2UsU+sNUrxAQyWmZXONx28h5hNzQH3ffR02Zm54OOtbxzKPwr8doO+UtTk3WhVqtdNOdMD/oFA/iU7pAkYlZWZ3fU0D6AGaeYdLY9KZjxqh7lcIfkwRQqxPJ6q4o6vF4amlHGCHCbc9H8jYTt/8J2Qobp+rnvMA8ofKABYMk78oDhM47jMnzz0/9jAa1uunUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aZX248dNL3JL+O1hSUD/CAgOXgqmKaWWw8IivWP/FTqoV7zX0qblMRKLZMjZ?=
 =?us-ascii?Q?ARU7pwXMb49V0Qmj7pN08InJI+K1ahmR0XVYJJ3SOaKCgete6ZWhVRpJSMMX?=
 =?us-ascii?Q?/Ehl/at0+jA6oNm91Wxb/AdiXsvKy6fPKQQKNeKGpImO9f6yLIuXbAtThLZz?=
 =?us-ascii?Q?xlecqASxjmYL8wNaGGaFW+iLMHrrfAyDcese0MsgxLU8zvD7vE3dqwtV39V4?=
 =?us-ascii?Q?uvti6rSfo8YyT2oWsqXh+9OqvcSKZG1CTxi1/8ne/LAxMKMUfqrxuL2r2MyS?=
 =?us-ascii?Q?pdQPjOXOePYwAjhJANTHVtScBTLTEd0HlHUWH/hQyanIH2jjUt4AX+oWedEK?=
 =?us-ascii?Q?IgJ7ycY5JH/IiWFx9HTHxY08EyDbAuFFQelXdvno4L8+vlb7KZm6Qdx88cvv?=
 =?us-ascii?Q?+cmyIKNOmc+5O1znSM5pRDF293aDRU6tp8duRf2FDllQLi8r+o8JBMKGEf5e?=
 =?us-ascii?Q?GErnCTKa8XocLa+GGULbu2+Rv07yLUPQRM2UnH0TSfFnMISJdU/zbdaI6ZCm?=
 =?us-ascii?Q?HTVlkKSe6PPcEIlJDry56cGGM+JoIoajxSNWBYKEXHD6TsMNnS9ULrMWb6Rl?=
 =?us-ascii?Q?BJD+OLGPAfHGrzQgeeltLMATM+6oe+Ze4R/CfaT8SFcdfCymOiIb6WFGbnWx?=
 =?us-ascii?Q?X3mVuw5eoy214DW6gmevCAk6REAOYPBk7IoKah3bJTU370eWZoXrNdlvOkZG?=
 =?us-ascii?Q?xDxlnLeS/VhLbPkEQvIs2Xb873fmYB3/hdIstVtBH4JIKMiLPZt8LIlFal3Y?=
 =?us-ascii?Q?CkSrUQcBphBeFNzpnnGizrQP35alG9Oyy2QsHZsPlsAi6FBcNcy0CdWF0q9N?=
 =?us-ascii?Q?lRS3eLfouNdhvtdKECpZVaRJg7QdbmFSPmUbbtyAfAJHyuZvGG+f/sG1E3Hz?=
 =?us-ascii?Q?lSqrn2nkujeSTHN6z8uQflOnDLEJ2wWG3RJJh/2MwRpJkFUQV0yGOHaTLEn6?=
 =?us-ascii?Q?1kn2jDpPPLgVzFsmwCS0HD6nKJO0O2v5zLKETVrsdDbbfdOULe8B4YqTIiBv?=
 =?us-ascii?Q?Z66UvM3YknPMNXCfAPZemMHjbUBKJmSSO762wvOCjS9Gkf5UweLsII+j6X80?=
 =?us-ascii?Q?T5CTr8BI4//wUGNwlEn8Om9fr2Kx9GjJOFqGLZ/LaRMYfcDPnaYP8gbCxiEj?=
 =?us-ascii?Q?nylx/sBjun1RnBY5PPwJWn2CyHVlWZQGRvnxLgHSz4savfGCQeHCEw8scHVH?=
 =?us-ascii?Q?JgKNYXQzC8aReiv7F/8Gu2fNRR2CmXS88fpVLbUlPX37tMOfbZCl7Xy15fws?=
 =?us-ascii?Q?27D4LSO0xHhlaUZhNK+wBuobnSFeKkCYD7MlLRG6O6XjPwnlwiWzl1L3MQNG?=
 =?us-ascii?Q?9cAFFMmWYy9r6WMgCGLR21gmpdElCSWXJ2D27BoCxk3gLv7dcSdrmTPZ/HMp?=
 =?us-ascii?Q?ZpHwoDZzk44k3CcIw8dWqC4rzsGCBlGMVrbn13CMhDJ31jnpEhB1HrAKTRRa?=
 =?us-ascii?Q?K9p2FPVMhzC4dUtb29fOUQGtEnj7iF94GKgYl/bM6pT39niPp7opOUh3WYd/?=
 =?us-ascii?Q?D3y1u16ctfsWnQzeKvAmHmjoOrxoDzMQQYnbQIcIdGrNX3WOQ8Xr23y2Hryn?=
 =?us-ascii?Q?Am5Y20vdDXj/J0pZFFjWq7vQqdREp1HtBap4QUkMo3tqMAWe9DKH0wX9SUrx?=
 =?us-ascii?Q?tJBRUS9Ag15cUNiLvbekoB9NjvRDmk5S/P5McL8uInVkff79uEPdCbaUthOL?=
 =?us-ascii?Q?lZiQ/A7TV8hRxS5JT3XNwjYUVH5l0PTtqfjL6EQoZqSuGnCy7jxxZqv6cZRR?=
 =?us-ascii?Q?DweNO+fJQgMoau8AqmS1yJOcU/8F4VH1oWcHsOSyJqi8p8CWgzuR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 30920a87-a088-4af0-ee42-08df25c17c6a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 04:55:05.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KLY9LieJvNfhTPDbEO8ONz8MsPLt7NwS+AxeeNIwqp8aFGzMvytmJHdGj0agjErPkkMZ9nlOHH9y0OtVVkpzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3079

The QTG _DSM expects read and write latencies in picoseconds, as
specified in CXL 3.0, Table 9-30.

The code base originally kept the latencies passed to the QTG _DSM in
picoseconds in effect. Commit 51293c565cf4 ("cxl: Fix incorrect region
perf data calculation") normalized CDAT and host bridge latencies to
nanoseconds, but did not add a conversion back to picoseconds when
constructing the _DSM input. Firmware can therefore select QTG IDs using
understated latencies.

Convert the latencies to picoseconds when constructing the _DSM input
package. Multiply in 64 bits and reject latencies that cannot fit in the
DWORD inputs defined by the specification.

Fixes: 51293c565cf4 ("cxl: Fix incorrect region perf data calculation")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/cxl/acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb09a5ff48c1..b7ce6b59c680 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -231,9 +231,10 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
 			  int entries, int *qos_class)
 {
 	union acpi_object *out_obj, *out_buf, *obj;
+	/* QTG _DSM expects latencies in picoseconds. */
 	union acpi_object in_array[4] = {
-		[0].integer = { ACPI_TYPE_INTEGER, coord->read_latency },
-		[1].integer = { ACPI_TYPE_INTEGER, coord->write_latency },
+		[0].integer = { ACPI_TYPE_INTEGER, coord->read_latency * 1000ULL },
+		[1].integer = { ACPI_TYPE_INTEGER, coord->write_latency * 1000ULL },
 		[2].integer = { ACPI_TYPE_INTEGER, coord->read_bandwidth },
 		[3].integer = { ACPI_TYPE_INTEGER, coord->write_bandwidth },
 	};
@@ -251,6 +252,11 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
 	if (!entries)
 		return -EINVAL;
 
+	/* Latency inputs must fit in the DWORD fields defined by the spec. */
+	if (coord->read_latency > U32_MAX / 1000 ||
+	    coord->write_latency > U32_MAX / 1000)
+		return -ERANGE;
+
 	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
 	if (!out_obj)
 		return -ENXIO;
-- 
2.51.0

