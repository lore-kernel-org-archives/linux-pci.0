Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285879;
	b=xBcCt1gMuwBgYPyxmtV+IxKlUzEhVJ/ivHeJP7uIAlOu9gCXsIZnTER5C+YrE3PbbBQ/
	 BCOBfTKe5jspOVnadW8SQwsIG/PaRUurBCXANJcHnQnSkk727e5q/BL6TNO6wIAzg3iXm
	 1XCOo1EJ3gkkHL4MDaI8awAumcBZQxQ+U6Bju/B/h7w6V+sldNF4UL2SaMaX1z9aLgu+G
	 yPS82zcQuZjDZZFdH4ucmkqsqGyNAQ6xwFXJstAVkC84DOKNRqOVZAkjfufJtm6imMRse
	 nc57Du7/ekbSIH80LtU2NzfIeHHhStRbrEUdYEUc+corxerGyhay7Mx146m2hqI4y1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285879;
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
	bh=7Ojl1K1wmh8aMY5WhvA1YeKNUn+x5yAZBdgheJZa86g=;
	b=uDyWr4fixP6kn7eowvMDlHWGotl/QwdVPo+cjV5oHkfusTY8uFhGMQjjOKhJew/y5NC6
	 AYuDinKsfqqBNNTpnJURH1G79mRgghlFZITEWBdqo586Nz+ykANgHVeRUgD6+eFtbq0vx
	 /3LzWufCHKDADBxF4GRAAk0zZWugng7SGo7xnS77O500gbeg5fGEJmVqSJ1MgW2ek3/12
	 NEgne/QXWu072hqBYF9Oq8UrcGJMl7/0/eVBfrAM2PtBVJrYU0qtIaoJ82LlOHYqXOr/S
	 uBgcdppNQVydjTlFhMfbWAh/0HV+YAlvWX9TSxkp9XncaicJ+A84O1YZnr53GppfEQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="ZB/5aiat";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54B60A2630;
	Thu, 29 Oct 2026 14:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C54B60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZB/5aiat
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQVlJtXaPGbVQShEqlzMcHV5sXdAlpW5jtnjTZwERqhZuZEz0Oo+zdX3Yw6QMR94qVm3j79dCp1xbMx6ZG5JjaWCDm7rTjeMijAqmMBPVC6pF+Mr5rBwr+Q7XGBuMDqhzsLENL+5h792z363Vk1Xti59rfZXK6wnPE2OarW7FMwADjmejnBcsfcqiWt3zyffdLLlMnCxaSfUf2ALM6gw4QL7anyy3huKlDO6K119B35F4rbLdFS6rlJMQsCoUr6lCIQTkzVIdzAZHsMxPGkCwI67Km9OwcJ1LHX0ryXXDq/bZ6pskswcjA6r6RtSSziMX+ikioOyBjFj7r6NDAvzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ojl1K1wmh8aMY5WhvA1YeKNUn+x5yAZBdgheJZa86g=;
 b=uXO/Des2GQ6Shehi6XunZ4nM+0j1u+xYYJCpE+NUWTX1RDikj0iuRFFbGIQj3+CgjA/pVWc7bdX9mdLpfcvp5XKUb6y4dEp/YIiBKjBBBCrfb2jPwcFQPB+P/4qVOIFSxV35VHRvOiyMxSKmlh2wdEYdCTLJQQLyRhO54bj2gdfnj0MPTX+t6bbG/8tDnzmIsfY00JuXo5F29RA8JaII2Hv6Tlh1loicY/hZOZSnf92DcDEg6Cx4jbL057MAyros4YjlQU2dL/yPz/t2qJvRgWcvIejG1lKS6qVjZp4SbmVN1TaVgWnfKkCUHfeDiEoNbRPqLuycaPebCqPPkN8ngQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ojl1K1wmh8aMY5WhvA1YeKNUn+x5yAZBdgheJZa86g=;
 b=ZB/5aiatTOayFRRTKcvipsbSVPuGMEQtwcccLQCDMa+pWpXhzf4LGwZP+1paHC/0GCIAfxUfloLRXiyJNn0t2LULvlN0gkAG5CtTsBDhgQ00vU8pJkCcUGfmyHSxNKB07ISd6+4VPgZxVDwZdeni0BzjABRZke9toh+ombeOInG3umNLnirvHkW8NYQLWlrcbAG4691cBTHqc+RCk2PMSLQgkzkAwhD46X2Qv08dn7ak3Is+s9OhvM0EBTxuRX2XurueBRCOnOR8oLIvKq+xGKAJdq9m5mJRJcNfuRHBHK+8ZHSzyILvfRC0fnvxOYHSjk7BcSGf1V1eOvLWFFsDjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by PH0PR12MB7905.namprd12.prod.outlook.com
 (2603:10b6:510:28b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 14:57:56 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:55 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
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
Subject: [PATCH v16 16/18] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Thu, 29 Oct 2026 14:57:01 +0000
Message-ID: <20261029145703.2185231-17-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::22) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be42701-0b6a-45b5-ea2f-08df35cd0387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|921020|260925021911599003|260925021311599003|260925022911599003|11063799006|5023799004|56012099006|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IOwM4t03R/Rrpr/LqZdF1MdA9krLdShMmdTIgOxNALelSOwzv7d/Kicy86anUMBZgpTtGMrffs8hlWCYw/2fLUv+hgWTmqK5xzq0vp5jmS7PvLt6U1YByVZkqsfS058SK+5H2aTZJTAJRZ9qtcPa/D3gwpBlmYSwHUFL0o8d/eNiMOFo6Ohc0k4DSR08C/I4+8Q4uQD+aEtYtkMtIgxHATzNI2LmvTSvCMK/SFe8L4WtgveajVjJoYp3XnaLW3aC7YKbbiNfRRNbD+JVmI0hec3svpq/g+bQWMJM0XMk1NO+kQrwuqwQOWH7vtGsrRwdS7313d2sNeVSGW4NP82zqLHNml2kRxwXjWdXvZd6Id/N8KPwqmp/rgJYPvUfTkkpCvP+eXWpJHIQiCsQWBy/t80ClL0Qe+9r+1t5BbwAEGbeUtmYWsaM74VkThenyW1BWHwZkrzJdZ8KRk0Y5iXKimmRnR8HdHsY2JiQBn+eTeqaW40dqGCWh4vCRPtX/acBx+6feTq33i/R4Kqd12VI6cUbMozyp25LEWRfY9KSzu49ABaKYARqUsoGAfyzXHW+5HKjkiDDgHJJUzOjW5vsuWMxsZdueudtg6Edcfwe32fshSP8dXrwKM8KdlObKfr9JDK3M6IXmDzJD3R9kWIRRlD+pNYOVgGL1E7zqSow8kszixhHTZnFCvyLsP7tfn3LubFJ1CjWngny7Azyb/I88A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(921020)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZcKuvnWEgL4zr1lvXcWxpH4leoB04rVKaZmDElqQ12iT1bdPU0Y02wW0SnW?=
 =?us-ascii?Q?IjfhKtqJcoR7tPdg6YMtrCT6FCKh9mP4LSa2U4x98WEKL7OGFcSjXaDVCisX?=
 =?us-ascii?Q?JSXRQXPOYqzJjEENkkKyAtg3G10leNwkW9ADyhjuAjzKc2TDvw2enthbJs3a?=
 =?us-ascii?Q?26a+RAa35yeAP5FZH772AcJyOk/mls+e4XogIEQyzEGDmY5VGXsQHy1E+6n1?=
 =?us-ascii?Q?zCzL5oP0q0pXctKvsXWmm1wYKtTbBmWgbOaLoj6UZVbJH9gUXxZBnty+mi6Q?=
 =?us-ascii?Q?qs5TK5/73+JIqSvVUb7K7uMuhtrYg0ajtT91tIUcXjUCUk0nk2hTcYEXyKnW?=
 =?us-ascii?Q?woJkhi8rqU8YnY/dENFloBnJ2sVhA5EFcKlVxheypMJIwr428Sh+yeUjJySN?=
 =?us-ascii?Q?dQ73iMtQRcKRxXfjcAqBziRKub3YZd5IWEMl950I7ou5BiUE+vfTsKVTru1A?=
 =?us-ascii?Q?321OplrskrSJT2ZKAGFKrdpno3lN/ZP1c9voDNvIJ4gtUA1/7OOLfQ8rhcZX?=
 =?us-ascii?Q?wfiwaiOWkkYUugHyxQXpHqyMeeVmYI0rvSr3QWNdUJ4inQumJpCKOWySJnJV?=
 =?us-ascii?Q?F29g8SAL7k0Nr1Gjap9JyYQ8lBozYRIHDAz1X3GIJv0+kYtuQOamRfFH7tmz?=
 =?us-ascii?Q?1ydXCoSwPCIcS6S+iIenh2iaIAVHLzIiAUTdCo3xMZtkQ4LtBzZGUxKWTDGm?=
 =?us-ascii?Q?PoEDPNMOwrZ24mg8VZsLYjamV6cA3chGDsIRe7GNEjUBiA7wIOW1bfym3dE+?=
 =?us-ascii?Q?V2QtHlt2ciRE2xyncZdeFIxqnbGcDH8MCMHQ9ha/x+jS0u3VWS2xU8XwzQK7?=
 =?us-ascii?Q?MHnU91o3gLYMec2A4GTM09wvUyMa3zaebaEKm/C3BQ/ymZzbmTVyLh/8UQKH?=
 =?us-ascii?Q?7nQQipDaYRdGDeRxgo1votoj+X3YHTiHEcgpokaLUzjzhwjHdSyVTBYRuOaS?=
 =?us-ascii?Q?UCgV6j2HkRlAKbJwfudVUzuzBcQIMV7uINFUzi4MSoTa9XtcbVxVzd4BlzSc?=
 =?us-ascii?Q?p+nRTemTx4GA2O7vUo7yVM2IeWBQsp/G0ZFbtCMzfCCL868DZtjzUfSwQS3X?=
 =?us-ascii?Q?sXxX0q7P7RfuMFeZ30dWl3ligH2e1Ou9Pz2HsTMoLhwc8DbDsUbPyFUfHFuG?=
 =?us-ascii?Q?1J9RoTlT6TMg3lGIUmJmVmTvcUS8sPs7HV4ogEbM0I8cnpuAEKxBWQLe8Lx5?=
 =?us-ascii?Q?gdzqh4eszj7umEo9udmpROu3+sS4d72H4NDkxHS/RESiv4nfidsEo/AEgKQP?=
 =?us-ascii?Q?bX10lgr8K0f2A+nTn8oJ/avzDpVCjzpRYpKuQbBmXB/LoNy533jZgxmVsICY?=
 =?us-ascii?Q?DZxsOv5d/E+Ox19hEHBobTxt/ic26qWBim15WP5LdwYtkCPe8A5uBMMlR5Ij?=
 =?us-ascii?Q?X52ePHyqX0U7Qj9yBVqHjpS8nPJy69mHAyn4MqVCWE9DCg+DxzW/E19VAR6y?=
 =?us-ascii?Q?mJCgacMP0bL/OQxcn4M0Rn36Py6ydpEBOiY/lL+4xkuAAWNkh3z+SES/mUUh?=
 =?us-ascii?Q?dFrAyLx3pDeHMsCv8Os+6d13Luex4u9SsRARCR6NBcTv37HeMh3r41rcmABn?=
 =?us-ascii?Q?KFn7vo+DOjVzUZfKoN/8LFP47FmwkHqvfmx1ErmHlaCSzP64eN2G+7LiHeNf?=
 =?us-ascii?Q?RPQ/pRCRFOsg2GurZqGTbh3XpqECcqjOdEUWO5mPM4eSOMc3+v5yHCaPgwRX?=
 =?us-ascii?Q?rioeCGCrhCB5ZFhOni97GGxlh4ZFG5DFzssKW6q83vT6O5lFSgtE+jnEVF+F?=
 =?us-ascii?Q?u66+ADgdiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be42701-0b6a-45b5-ea2f-08df35cd0387
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:55.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iklf5bDPJFWjkT4E3zJTgcILEBE1JBBDhFlTpgOEuSuejKC46UyUYZ7tcIGJ6BB/waAikMToqmITgxGjVk7+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/cxl.c   | 12 +++++++++---
 drivers/pci/pci.c   |  1 +
 include/linux/pci.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 58bbd5b47539..0c4ac0832b34 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -672,7 +672,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
 	if (rc)
-		return rc;
+		return probe ? -ENOTTY : rc;
 	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
@@ -681,9 +681,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(ctrl))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
@@ -706,5 +706,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
 		return -ENOTTY;
 
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (!pdev->state_saved) {
+		pci_err(pdev, "CXL reset requires saved PCI state\n");
+		return -EINVAL;
+	}
+
 	return cxl_reset_execute(pdev, dvsec, cap);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9031060423cc..f5990d6cc51b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5148,6 +5148,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7bb37fcb556d..743b57ff885a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

