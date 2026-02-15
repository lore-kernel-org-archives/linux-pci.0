Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184D293C42;
	Sun, 15 Feb 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168169; cv=fail; b=jOLeFKrU6QojqVMSvNkkDfznhuAm1gaDUFg6xcJVDjgKuTQrp1U1oTCycGXn3WQUp4H4Jsr6Vi5aOtwYGidGgKJ/uGZ80ZIlEDOjvLeL/66TCSK79Ycwyfy1ONF7pWfyAKQJD7PsAT808UGeLJzpoEi/Z25Dos1+FpzJ367wNoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168169; c=relaxed/simple;
	bh=xnB5Ku/LEAFniPo6vCa8HxiwtWymLhoNASAipX/3e44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zs/tjLh7J/VAWWaG4JQRxoibnD27BjfhNeBcKR+oVnIPKb+Iw0TObErNLc31/htt6msYOPTYHxK3L1zO5I8k/l+Yk+7hwvEUmPbnYQguYX+zAsiP0JGArDu6X6dE+sk8EsZquLYWHDwy1uZjnloBid8WZWeuwBWzxSBzPZzGbPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QC0T3bc0; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QC0T3bc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIy61Mrybc+Pzrkl7Jkwjd2FP5gSX4GohOUD9VjPulOuFDDilxH2sTCMirW1X2GEL6sIbB3MMV4qz9gBrjxCAzEbLJ/f62Ypq79mB8FUoFep/ybKJJRnTXJIFYK4mcTMTRKyOkVo14pgAFD3PowE/HnVw9aPMzKrsKYrFFxUJNXFaPcWuiEpM5CLtINa9L5ZMNkmce7aau5XalNdBzdiDHZwFe1oYd1hXzCPhUTPGlvYgJTFpUHPeVBLvSVSpwjPiDZjiEHEqKcy3nIeykb+do3sNQ2Gg8H8UXbrdcuOjiO0jCz4r0XqrHzwkhHxDLoPlNR+0+mRuMIAF5upkTOMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaNT/K8Bu+5dsmgy5J5VDejhoWbhamkxVcQb+JdoEwM=;
 b=hV81ScasamP09lecLxhXURCFPEMsUrM2Se7Ghs2Ao20+doBKbM2RQUm6vvSmN141gLdV+htuz7QViXJwlAJXlq6FuvRxMD8+fDHb108jIVk9OsSllvDUi2bUwewODEizXRG/KP76g71TeswOlFwV4WMCeh6dnUuksK2uq/bSoHHzB8fZgE3Oz8aFq9caa4zqPG2MFfMBIuUTwutBqi4mPzj7E28Ud9HbDOA5LB/jrQ0R7SX+Xpi2UaijosJDyPKrK6ivtmhyQ9sxE4KvL5RMDT95Yq0QdBefxKOmQp3sypff//0jLnC+4vRlF53ppF4kQgYxoS/5TM3x1wSS0mr3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaNT/K8Bu+5dsmgy5J5VDejhoWbhamkxVcQb+JdoEwM=;
 b=QC0T3bc0vQUUg8F3G2kfxODYrsR3W7YtyImdbd/gV2Mjb64EKuSohff9IbUBMxCDbyrNAq58I5VEBWtZG5Cp+aAvnHVoqy2D9lddGjXLQe7oUBkNLEEY6zCK9YVRHuLn/JRklL3YliFdnO1raODBqkWfgjuAPxS4qpPkhRWC/bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7240.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:367::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:09:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:09:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 4/4] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
Date: Mon, 16 Feb 2026 00:09:14 +0900
Message-ID: <20260215150914.3392479-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215150914.3392479-1-den@valinux.co.jp>
References: <20260215150914.3392479-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5e629f-536c-48e5-c23b-08de6ca43401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DqD7H66lQaLGKNErLmJGfmNMJOQcryf6dbSyojqPZw7QPZRBhIGMxhxAbFVc?=
 =?us-ascii?Q?BL2xFsN4UH3d7fywOsvFWZ01kb1ql6CzTyajNZl+NVxSOneQSUhsdWn4ijfp?=
 =?us-ascii?Q?G5hXpNdbVWwClNs2SIAS1eUYf3zPs0oqh3+k1DUYi+K9vFRSRNoJgCwbqu4y?=
 =?us-ascii?Q?9725dqNPWLrVmTvb/KtTAORizvyUNG9X4lffQzpywIBPiT/vVVQOrvi6oSj9?=
 =?us-ascii?Q?CbD8VfFVoV4RcfMJBfgUuLHX7JqLIg/bQh3Ah0uBMlOY3Bv6xAAJPAgiPoxr?=
 =?us-ascii?Q?KF21SIos0C/E7OnsPfQ2lE9NnNWyxm/+rvu3YhRyysYlhri3gs9En8mTTtBI?=
 =?us-ascii?Q?Iq4dc7ddk2fI5tegUHwslgeEpsA6aMncjIoQ6iw55gQSulgwqRszo8LYBgf4?=
 =?us-ascii?Q?nXDR2dk7gNS+CAo+xEn7gRnESR+r+2XCQwxh9HCPtk8A7ncetNXnK6uXzoqq?=
 =?us-ascii?Q?gwvmrW0sZQWOLKVLUlvlFjxdKXyMtjz/9UO99XCcUuZdvFEAe3yh/lihDigy?=
 =?us-ascii?Q?r3+FV//KCl9HmWLQPALmq3rpSQ63qOW9n9PNffXQO/+LrEwagH+w76ncW8PJ?=
 =?us-ascii?Q?qJkVDScEnawQUU+VVhGvDssRJ4n3cWx9TJv/3VKneA9C0Q6uTh//izBTpUsx?=
 =?us-ascii?Q?XMSXmrNYgi8cRNmrHmjAt/k59I4nHX7NbOT3MHq/oUOBEm9USlbtOWcw+Fn3?=
 =?us-ascii?Q?0M6d+f5EjeQNZ9BuKNEF6OY17WftsoU2a3evm5eZmz7xdlw+SgXjp9kTiHAU?=
 =?us-ascii?Q?vv7/NJ9DWTXLP+v8uQoPoheKT9T3oRm5D8FvbbJW0jBIXMyz/aZ++q4lv50G?=
 =?us-ascii?Q?xnOHv1NCnZFqEWT2OqQOgvPD+7sWjPQfKaA/FqbjArojrVZcP+Ieauu5mwC3?=
 =?us-ascii?Q?cS+3qs/TR4m8092zGccx76x3KkZvARx/aM5xxSrxCtHquYDUaURbYs9Rb5Bg?=
 =?us-ascii?Q?gi0uJXCYlZVnca9BcJx+4Kt7dygNqS/uSdmht90kNUN0swCw3pJokIz2QZ2r?=
 =?us-ascii?Q?9oVVRZDx1NDFuhOZ1o7vbPcdeYh0RX9Xb0F+pVRJn0JVO7O1/kup28zIXjMJ?=
 =?us-ascii?Q?BxtRk79ayeeC7CjIAZft3NDmwz/4/TwVaOSVEbrH4VTUn3ajBjXrqXf9lWR1?=
 =?us-ascii?Q?yWgEYir6pqIfpj6a8yzXq6NgNBM8ZpRHPrqHBt4I5ORDX6jdFsTcTmA52NZp?=
 =?us-ascii?Q?DDgrJ1wDJvEi/YJzhLvW+3dT/5ZWVW5lgYvb2bKX3um5+uTjtUN0io3I1hls?=
 =?us-ascii?Q?EZ/5DJnIChUBz/PIjD/vwfSFlH3J4Y0VQRyW+IwcJ5rqvyP0rWmPAlwEVQMv?=
 =?us-ascii?Q?SR5l/C7fVz0JgXaTW3U1T5b3ZQUi8HPQuXVFtHEyEC0qQW9AYXvDPnWIRiHO?=
 =?us-ascii?Q?JP9x6cusDGzPGf3cGVKk3Vam7xaGA91bZLPzb8Udk0EaElKD37B26WX3Hv46?=
 =?us-ascii?Q?KoOIzYqCHGNcoDugbXb+7vCg4gK1suLlQeZj1C3sAGjSeGo+o5BmiHO7V7J+?=
 =?us-ascii?Q?Q59r4ASANkgfX02E/7JAYIaPb7b7BwHtOSBDRhNlOTyPN4FQRo58quYrMCWa?=
 =?us-ascii?Q?T4NsPenWaacHQ23KJLk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWDD5nw/7BSB7nd17D+csLNHCoFeA+lUJfdCBVtIRURu1SapMQRRLOH0rJi3?=
 =?us-ascii?Q?5lsoNg8cgIqnXbwphykh+ic6LEV3XVyjCGBQeROn7xm1jWA/iX+ILtL+5Bc1?=
 =?us-ascii?Q?0+xoIQ6Nt5dN83eDpLKr6O2eEmBjJ/VKGkNhe4UnS9c7iyeASmI8i9Ag3AjJ?=
 =?us-ascii?Q?vmNfK0Lx9g6hxpOQeBZAp2ojSGniFq9R0SN3X0o82D37+ewI+HCECDwvHq8b?=
 =?us-ascii?Q?xaEqu1bwsGWILbAfKmww9Tz/LZofORKhs9ZcMsoqMn0e+hYIbkeSVbuk38ZT?=
 =?us-ascii?Q?efVAd7xWEURhv3xDZ6Oq10ZaZaEoGfBgGzecijnOxkRlQvtTX4jgsIuPlWQb?=
 =?us-ascii?Q?+uZjNSkDAuvbjPtb5O/ub3YuIAfIJfyassjkGgTdn8Ve5CJQfk2hhawj20KX?=
 =?us-ascii?Q?UAjd/Nzt40yIvuPU8//zZtJM2FZ38e7jy50reXpZsC5KkreeItZoh5HOkjXz?=
 =?us-ascii?Q?BcPFz//Uv9/8YqjmaYyW4AOAz26gvamQhF0z4omX3VeAtEOa8NKXW/bklOtO?=
 =?us-ascii?Q?MHLq/E7FTuaBOJMvLCxvSHPvDJolrc3Ibsr2pPLL112keP+aCzRJ+VX67T8Y?=
 =?us-ascii?Q?TlsZPtGexruqqq70wpeyLNKR4TtWsSVRJ3pm72CtOsIJPQHQEJqenX2ZxpgI?=
 =?us-ascii?Q?V6ZG1kHmGIkd51/uK+CrDD3ZZ6IaUQfTVn8BPypTzTcUpzgFEjWIoXQvOeCE?=
 =?us-ascii?Q?yPbhkOvzM1mxczzFtc6hprSZFIZP3psfI2p9BfArjRQpXGUQGykb15piXyx8?=
 =?us-ascii?Q?deanpTH8iJLxW1x69yboMe1strqUuiqyERwmHfM4QFyqMfK9om2CkxqsK7tH?=
 =?us-ascii?Q?mi75z0EuO+eC9YW0kO2009YvyX/bJJNAORzhsP2SSTyFXsStlJRd/l9bO2hP?=
 =?us-ascii?Q?0ScGlESzT1OiRH2W7A1EK/Wxyv4IecEVu1AR3fYVs8seJ5Ce0qb1K3v1y2fj?=
 =?us-ascii?Q?8r5094WAl8yip9T0u+XZCD71DGDvcwV+SIT3PpWYRrBPt829AEHFU7+DWeUp?=
 =?us-ascii?Q?MQg/0Bu5KWAynu+gBJMsUVeQxfsIoYQn3/xCJ78IGm781it52JNAqCtrfXkl?=
 =?us-ascii?Q?br+r6Y/piSyuzYIHBhwKtgO4uftAlvj2ruB4rI0fU9SOBPOx/ANunsvXnly+?=
 =?us-ascii?Q?ATxyXdRVZ4BPoqzOT6LHzGVZsoWPJqggodh4hOtExaA2ogxnf79l11Fpgn90?=
 =?us-ascii?Q?Cfi0c1HuDQowqJLxpZQgxF3SzcYdkE8s9FNTZzLwbv3MEdJVTZMEqY15QQA+?=
 =?us-ascii?Q?o9keKQcqDoac7YsCcxfzHhGNEfNZ/9UuykWJukwYjXjIBxZep8GmIawwKNLT?=
 =?us-ascii?Q?/Ejoo0rGj/slyg94bVF8uf+hX5ULBqcLJ/yH72WuutRDZWE6cqQfwaoZJQ9l?=
 =?us-ascii?Q?kmKeAzZ62I/s2eVm/0NuH9NhBWeN9nlst7sOTBnGyDq6iwVv/mFdYQkwH6u+?=
 =?us-ascii?Q?OS6QzyDmUzC0YHUHd+DQ2c4uldM2GZNMTnxTX1H9NLkJqQKd4cMfafDHOHd7?=
 =?us-ascii?Q?O0FsKktev3+mC3RH8/wCfQev0RWymFtBNrgFx9b2ygn0AAXMWIwZV71T2bBv?=
 =?us-ascii?Q?A1BWH2GyGbQ9Y6nx2NISnqU/Gpf1V5o9ZNDHyQWqfNkaw/189StWrkATzYph?=
 =?us-ascii?Q?e0JFI2z/IOqpE9uH2tXGkYn/ToTSTNDqvgir5puOR5zrjwfu110GicRIhW+f?=
 =?us-ascii?Q?qIt84kVt/V7IKm4tqGLRVFJI01AuGxKIGIwzWGOt6G9j1kjU91TvXBya146j?=
 =?us-ascii?Q?Y/5mCHs8J9h/AjaP69J7bea1xCI3kvCKBiwmT23R7C9NH/jbHAT3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e629f-536c-48e5-c23b-08de6ca43401
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:09:23.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+gVGnhBfi1tHM9f9WBu6A1M1tqNWDrZCvWaAnyzXa40ELmyG0wAMKAyaqUDWnCN1MbKb42YV0RIFKcLla2NPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7240

pci_epf_alloc_doorbell() stores the allocated doorbell message array in
epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
fails, the array is freed but the EPF state may still point to freed
memory.

Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
that later cleanup cannot double-free the array and callers can retry
allocation.

Also return -EBUSY when doorbells have already been allocated to prevent
leaking or overwriting an existing allocation.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-ep-msi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 1b58357b905f..ad8a81d6ad77 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -50,6 +50,9 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 		return -EINVAL;
 	}
 
+	if (epf->db_msg)
+		return -EBUSY;
+
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
 	if (!domain) {
@@ -79,6 +82,8 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (ret) {
 		dev_err(dev, "Failed to allocate MSI\n");
 		kfree(msg);
+		epf->db_msg = NULL;
+		epf->num_db = 0;
 		return ret;
 	}
 
-- 
2.51.0

