Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905214;
	b=RiYbEbcir3DephLi2lytd+RdvulejdYolWeSr4VBtaLS6HS0rJDhS5De5e8sO8EkYrgy
	 i14ozyAgzA8RStKNlJSZHz/IvahTGMv+aWolfZCa2EcRwalvhalKq9guFHFfNIbz3WEvq
	 PXzA/5fPrdOQv5C6jKhQFotatOFuKOHvXp8mFeQS930SRqp/Fk+wQ9WfQqjBmm3Bggn0P
	 PXl631P6zgPLzBE5DgEZu5d0TU4Rv6FpvAXKAK0LKUqbq7YZr05Crz6e5sqm0BvSuJWsi
	 NX2xKySHk0tNnS3n90+gPGZAx6MkCJ13jvMweKz4VChEyRD4ritMe9HJXMpWbush/3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905214;
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
	bh=z+4H875AT86fugwA1Q/mlTJ3lawYu+VHzKVWyI4t4GA=;
	b=d9Va9Fy99ofY3ZEizRXSEcKXrjTnFWlYmpqCaekoRL6FrMuiq6y3RMCBaGCDevFYU4yp
	 C3XZbDbJ2z8DjFITt/ydrrHAGzB8cYsyM2USTLo5ANZH55lQbRrhSRsBApVmbWqjeqPKw
	 92vvSD38qbxyegjmw93ePE+aH1346Vk41K4Ix+neE0zZvK4SOO3z61Hn30FOTVNc7DsEg
	 i3GiSvrw0WjP5IKqjYhk9cE2RuyXXMVPWBhoPSHLklkkpu8cODT3Wnl4Nvi1qrf3dcyE4
	 C00Xfr+En6LCj1VynLP/ppXyC2FhdmLAnNG37hFsfCW9myE7RTNn4iPh06pQNf1dFwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0uFSbJ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF16606D81B;
	Thu,  5 Nov 2026 19:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF16606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y0uFSbJ0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQZM8yhtBUx49Tx1XO6pFIyFpimgxh4i94lfPCCVoGuoYdxrnmg9GV1vnnua/iNmbMMlWy8BAzAJK0uCxgvzFl65A5fdLwnVa0YFuHFRPDA3ggfMlWv1MUXsx/Xbl3YyUejVtMd+lQVOGmeRnKVijn0kwo3c2oVL4mmlGvN4FUrIyvVXAT4CjuUALfQNERmTgXVbQC+OSqj2ujJED7dK3R7KRLcm01EvI6ErA/w171DL6y9dj9XCv16OjtP9sExLqI4/4maRIBSuJhoMeulKzXYSgIJetTTeIwLu7XlQvKNuIIWq/17Wyeh/2vU6vNLIb1QSFxcT3lvTk6lfP5tVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+4H875AT86fugwA1Q/mlTJ3lawYu+VHzKVWyI4t4GA=;
 b=VfHdqkoUFQHch1x7dXh8e0NFMF2gbLqHumqk6pGcO08bdQhAHLM+d06ef1Q0ZlN5R9urLxXPBxEzMaPiYT9M6nyrOq5FWNy5lqqXRop6N3sS0EzksIct6gs4n+P+DVm3zALfMtnlC3HIMWntZYnHKlDnnSEJPfpTIoaRAzbCnCUb0rxH/RFlpMS8dDeBCPqyMtPxzy9l01EZsPurGnuMpbvQlhEgCn/I7gqUbEonwO3jjdpbCZGdbNu9jXndZdQNs2oKsEgwxWtJySE2M5kQl1ttycqQ8UTgkiLcRzuQiOpGHuWkUPcI4A880BjkAbc8AmWbrW3XblBJPZbyN3KD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+4H875AT86fugwA1Q/mlTJ3lawYu+VHzKVWyI4t4GA=;
 b=Y0uFSbJ0tiWrcdKWtwf4A08HS43taW2UoMSWjT+Dsr2W90Cl8Sv7ijmvmrZgvVpORleWd5x21W8y0tVKxnR+scu8fj5zSZL++NWnT8pgsV04rG13PMIqnJhQOE5eA3y59G2RTC95QeGzWDwgmBe/6VY1OuPePbXrZILAFXa3932GYYmeCM9tBEa6ksava9XIegzF531t+BpmqdnBWhnfnCb8b0BuuTSFNMTYt2LEQNv16neWqQ2QA/sWZwsH7zy63u0G+bdpWHjU17w6og1D8vGoC7C+dg5PdilQs2iL+4I70HNtN2GH4Yv+PLQeUl5WZNif9gWwI3bTHnvqrJ0tEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB733495.namprd12.prod.outlook.com
 (2603:10b6:408:423::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:00:03 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:00:03 +0000
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
Subject: [PATCH v17 16/19] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Thu,  5 Nov 2026 18:59:14 +0000
Message-ID: <20261105185917.2667656-17-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:303:86::10) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB733495:EE_
X-MS-Office365-Filtering-Correlation-Id: b7686540-7c96-401f-9c42-08df3b6eff88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261026121527099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3x0dFR2IyDAlfgpNXAiLJoNiiUz0OT6QzSCHjtaIfQgnzjfgPP4tqZoIhQEa0WGU2z+1j5cOgDBH4T+ly89ObpzKZNMIsXEqwwVqbyvzyGVqdg9Z80MxnvU/b/hUZKmtfjHq+nM5pIoj3g+xIY3P37Tz9dm2ha7O5HVAUljwfQqCoePBKFUoEEp7P62POYQ4n35KD/3wCO2py6eWCG1xvz3bpbdfPLIVYXlw8F4FfJajpg9muddayQ08HJdltIwtJGuu+ULSya+cLTFl3hjRr7mMTS4yUagcnHpPzV0O1XJFY8it8slf+tCqKk7pYXi3NmpHraJcAJYmQh9AhaPm7w6HXm68OEkCk1tmLN6ZuQv1eJtnrwH/kowKR40xx3vYTPkSYFilMhkL/VTciU7v7PVl0r7DkpfOby9VYd4vVASyLiugPiOAaIypGL9gbFAblGdVGi1ZLWDSiyYTfHxJPK3DDKNdyimiIpMfsoELN4opZHD7+zuTOx3LLpyqtDOCEIfYqb9SnFs8+TKDgdZB8sapyS8y0338DS0vQsNQnV89/DgkPNofbnp76z5Stb7JHvtNFaNPvhYmuzttIPriE67W8+fwKe9Tz2aqJYp/Ixdg2d6vi4Wd27TWYY82bCx/s/Wk5Qwaou51RC9FiASBijGLWPKFjaOezt04jr9Z8GnvF5lDE07S3wbAtqbE17ZOZi2EiRUfSs/tDzAPnY9Vzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1EKc6qIlTyeWziyR987uwwzen7kW+LtM8uwLTCTnkzDgix4kywQzHj68D6U?=
 =?us-ascii?Q?GXLPStfSExN3bZvHeDUqU65ADYnwcJ46F0+ftQciYPUhLl/0iajx1Ow7qyLq?=
 =?us-ascii?Q?L6ry8wInfkJZIeLyaXZGG89fUOHhrGk02JdnPGVfvoISEssLtENGI5uRD2Dk?=
 =?us-ascii?Q?0XXh5kV4KSWZbvDyyntXJDnEvbFPujiy9UVgpyo0L3qpQs2iLgzNbNRmTd7a?=
 =?us-ascii?Q?GLi5ieiRWqtGFC9HKoT7FpFHEF1Uq2tFj6o15vpijFXeHq/X52iczYFQPeQX?=
 =?us-ascii?Q?IsWLfIAz29GzMEbnn9L9WBT4lKL2dqOlq3Ge1bvk0ay0EwZdhXyxBklJoXW1?=
 =?us-ascii?Q?3N9pZSTBfoX+DXnfqTUD0BlkQ3rSLpGRpw9HZqKTzISmwErmuDjHnyI60EoW?=
 =?us-ascii?Q?P9P4GWu6if31EOBf+met/oo5BYGKNa2QqumkpS1rnSsQwbk3MOZmL/B2+Q4l?=
 =?us-ascii?Q?u+pnHCM0HhD1GJUs9lXLZhZnVijhWEFPtWgMGQsbkh39VKvUiEGcBzH44b6z?=
 =?us-ascii?Q?O5+HL8kyWSouJA/64oC5lqs+blmTA0GqGMLSXI6uCps4cvIiBJ7tnKR0i63T?=
 =?us-ascii?Q?Y2M8A0PEYE7Rs9A/+0Op1UHIU13OPYU6RMjEgsT8+nkZXNQ+NYSSG+95UpoO?=
 =?us-ascii?Q?F2ytNNPpCxFq61SXUNOyNFTvuxtbAx4PGLQjcTXB6Hd4eXNkIZPs6Y1UYMSl?=
 =?us-ascii?Q?K3EQOHYAwfvGyJmtBF6OBfPOQG9Tnt4JRfcGDGOm7DbxRyNPHEmZ/Djip4+r?=
 =?us-ascii?Q?Cxe/Sg+wzTFEimeXy3Qia6kAqBVnNEuBWdVPj50tMa3S710UpPZMUE/S7BzR?=
 =?us-ascii?Q?DjHQWg6VeJBPNUyFIQOfsVx6UqDzntzcPWYWOArAvwd8Hr1YS1zYgObltxh1?=
 =?us-ascii?Q?LxBCFl/J5ekbT+Zlj+CnaD1rccSpHBeJIq/BQA0hbs8WJUWI5CAqd3LnrXjL?=
 =?us-ascii?Q?N3OM1YBswyEfxITQkWMf99bavVfxEoKwCwa4BWIHxyCYBj3X697nm0uNME2q?=
 =?us-ascii?Q?OYaaRasYBqY1H9qvmTqC+M1frt3jD/C1MxEEIePRdLragAZW+WUDXJlUMPfe?=
 =?us-ascii?Q?DSLzqrTefakSw4HQfoll8kUzOCi2BR1xtUybeEMwqoKXYyyBBU3smkDcPDZc?=
 =?us-ascii?Q?EWMrpxmB8BtCyh2NiOZwAU/1aNbg2VzZ8NGMPEpBDtcVhdnn7NWgOSCnGHTU?=
 =?us-ascii?Q?M5CF5A4aE2kp5Hz5LY4A7E78RcY1W91QQyEjmfj4UHOkfhByqsnATSt4il73?=
 =?us-ascii?Q?F4PS0myMobcxavQOS1rp8NnuRVrVK9vz4kBwgKZgouRkFPOvbm8MslzZvZ/o?=
 =?us-ascii?Q?BhxyRMZ8lnnSWZIY51oLzOapiWnChPbrQ2b3n394VP5vzW6U6xO/Q+NcjoJe?=
 =?us-ascii?Q?UBY6asjp20TPNgA0oMUY1sKlvwn4YN6zIxKTxR5OkoWcZgG535tF5Vqt8B8z?=
 =?us-ascii?Q?uEc5g17B7XYw4Hho6FvdmgQtBlBYAF6gPLcN4kcdy2lgK9V6ip6edf70KZxE?=
 =?us-ascii?Q?FHLQxA1nsQi9ILJU0XH9PR/UN7xKryU3Z3OAQcmLB42O69owPqErx+PXRrU9?=
 =?us-ascii?Q?2HzfnQJKeCRLFxWZWluqiOWWDwqy/SbxWsBjq6Dt6Su/bmrARo9CO72P6gTr?=
 =?us-ascii?Q?2K+di3HuStRWFCwS2dLW72zJKg4Ml7tleuWs8e6ZngScoUckebphOCf9yNiM?=
 =?us-ascii?Q?1KnWcZrZM0RJzQAxeK7nZJlln2brbhunxEhAzxpwD4g5+srCy6tofmG/HyCL?=
 =?us-ascii?Q?22fby4h5LQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7686540-7c96-401f-9c42-08df3b6eff88
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:00:03.0154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qIKLckX7XtaX9HDxe5/JA0uozbcj0y1Y0of6kR1G08ChZJ1CnGPifaLp7WLyVW+vIPn+qGRJymLJQ+cv6ioeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB733495

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/cxl.c   | 12 +++++++++---
 drivers/pci/pci.c   |  1 +
 include/linux/pci.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 77d0e30841d9..c68b08f7f95b 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -679,7 +679,7 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
 	if (rc)
-		return rc;
+		return probe ? -ENOTTY : rc;
 	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
@@ -688,9 +688,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
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
@@ -710,5 +710,11 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
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
index aef976d0c850..426b5ee38d04 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5152,6 +5152,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
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

