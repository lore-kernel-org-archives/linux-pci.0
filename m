Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6A3955F5;
	Wed, 12 Aug 2026 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510423; cv=fail; b=VwzOKAWg8VZ5HPE4DzQfEV8rUqPtOsowH+N2susr6VCXTN58DtnYF4I5Dzt86FX+yaefqyGmJXnwawFaLXo9zmYRCK1R40C/a/heM2et4w+DBRkOCg5QarPVc/utdMonGiAOiZVLUspYc1V7gHhHbK7iWMf7AegK+yBahmyT1b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510423; c=relaxed/simple;
	bh=pVHMkjGZyoUmoirGtGTRVqUOvutXJyVoW5ZXaUtjGhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qODeA7uZU4oo+Af8gVxlFaO4dyVOM6SnWew9qxztDKseCFRtbSJLrGnGOsE/FYDrehwQJs9rUaxxDP0RSQGpB2jwbhiURnoFpTbghVt5ot5PHpMmqDP08zhm+WugdgBOu6POjJG6Sh+dldoHmfg78P+PUgs+NpplzOI7jgPedMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sLC1eTDN; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sLC1eTDN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emNH/N6yBVDiH6inw8kPIIj3oOSRrxnyLrOKeetb9Muh3cK0+IppqB6ukG8XW9Q0iEAigqCCydBSZdVeRptFxDueLi9uLnrQVQ9cgr17DLMUEvmAHEfAP2HVXwhdeAB4X8o1Pd2Si458aWrIzIMDj45mL6x2oJLMop93bwE39ElEZ3m7Z6JEG7PXNqyjZlYeYnqWkCC6mkOB4YU+BPQqVxTrEJQJurZCaC4rRZ3CJXChwFpAyGp7VPXxP/+HaTLvcAsSpu58aS8s/Nw0hC3dJCXVGscTYxNswspmvb2OJ5H0iFJnKVpvXOsltX4PuHAeL50AiUarz/Zcft9wAeYVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2OKKWgOX4JOh1tLSmcmkaLZA1SbNcgSSK1scK8jBGY=;
 b=tuTXsYekG/EmxHl8cL2j60LiO67jghBAGTjA3MhIDjCeWGsFNroeGURP6AMQW0743dMir3q9ue90T1kPIqbdfmYRF4egu3JGgCK5tdohdIBRM34l8vjsg06F0qNfv5vIar6oqmgpREMF3LHBSvJd/eJc2lzL8xPAbpJXGUPn1zaeQvNfeTim6yPQ1i2hL26urGuZgKspCxsWe9LDqH9Z7NmDHf7csg7l5Ru641AgRlX5+Z+prym2LcGi18qdBiveohlbgyMMYZI2QRIdMaSEgCbhe+LFFKj56Y1RDaRPV/0jYf5TrFLTtQezW3NG0m6jMRx2SRsvLxESIwrqqfLBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2OKKWgOX4JOh1tLSmcmkaLZA1SbNcgSSK1scK8jBGY=;
 b=sLC1eTDN4nfUP8/PDLEE+l/LsUk2VPSo+5+FgL0mAr0mJLKEBOrxJZOdwSJy0dHBBaCICMrRubZD6q+Q2B9VSYHMOThjadEVKNViqLMoAF4JTWxNbHaUShHIpRc46xDju4RPQRMvc2JIK6Kj4h9YX1fCF20FR9w9z9EivMxum2pcGwdw0nZJnJasSfBzWHnovZbroQowyzn4Y1ikSALfPIZFFozUppBCD9+Xatg/AQDnAMQt7FJradGd0woN0ravjv4FqSF0gTYNbBOm+uoXFvqcz/D4Xb44MW6zcUgBy9xI30fDvYVSojIIfSZmSR2S8tccZjkIFf2qVU6Z94bulQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:31 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:31 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	skhawaja@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 4/5] PCI: Export pci_reset_supported()
Date: Tue, 11 Aug 2026 22:53:22 -0600
Message-ID: <20260812045325.2733631-5-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812045325.2733631-1-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f2c361-53f0-41e1-cc82-08def82da870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sl6C7xcgY7AagchqIQ0IigrDKByn1wH62rgcH2cXZZ+Wpt7cnKQlPiSb9ptLt0I3PqX5K/FXCQyCKIR4i/5iY7qRviP4yqJj9Y6Eg+JghtJibuA95kyWIdVgUrQ4QhDxfOVNTuWN+H9oDx5sf6mpws1ucSYZLSdkAFAfpVfn4rUPbsdnM430ApPAtmsD5DZkKux+jLd8Mb6qKuG8rhOZuKwY5egWrKS0XS4yCTwPF+QLZG2XVbzudUg+skFnWO5NmwQRbUGnWxnBguTYkfj5E6oqHKzrrZhbZmHYln2ocSEsGZHGkgxHxy3p2D3/yut+XjrW+oWq4N0qhQSBqadWLZa2CLu3D0FN8gMWvEX6VxQNf9eCQ0HUuT4AjXeU/6F2gX4i7hpjfki4/ktOTdl+YrGH9mpE+Nwuz5hqsi3XPdUGwc5uNBhrtTHKWiHilLXVeC5fQEaXs5+VykrxltHvVZKrT3W83Ta44fnY6iqzBkkBpCywuiqdRGpxJj7nUy4OltY5SdwVShycBWHCPvVSFWvVpQ1qqbTcO4PO18kIzsxhbT342GlbVyx3CnszB3B1+QHKj2/IqBD0LNxV2hha00euHeEqMPkA75Ml1xmUvIQDnaqY3s6GCKhQNVbfD4HxyvhrCrWXY8rpdKEm8Q3G7w2R2UtGmODWPOIWah4Hzgs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZkfSAlHZEB8xXbxlqPZSca3+QM5ljWHTZxI5oUt/vWR51P9iL8G02qqrTpP?=
 =?us-ascii?Q?bsyv7kPVEgndL8zzH5fYG/2bhD7EIcbIpatEQ9r7FvT42QuAzmbL9EGLfh1c?=
 =?us-ascii?Q?hIIdc1lSQLbWf788UGQzu9cIfl4zxyv8smf6kH9cXNtRrp4m9f1kuasjkuFh?=
 =?us-ascii?Q?eXxE7Fipm7swz+zJHPB3yXLqX8nXQyC7/uqPfhV6TyU+YHigWY3RozTmGIaM?=
 =?us-ascii?Q?tAefd4sEzZ9lypeSuv9vJiqUy92twjeZxn0n+I4W33uSdf2Rq+nQ5zZKR2/8?=
 =?us-ascii?Q?eDN1TvsniTQSD1uufB7auc2QLum/kWuGMfgKjvZExU+wM9bll9bFdHGgbUEH?=
 =?us-ascii?Q?cW3oAM5hy+OdCuHs2cT2N78rT+gSpOPYtrhl5IyPl62WUBB4OcC2+z2s8iWy?=
 =?us-ascii?Q?7jAZciajAuJm46hdtewbSX7wZ6bSHwkAS59BQY8VxSfhxxzK04PWRCVBQWBt?=
 =?us-ascii?Q?N3OrfUJDatqpuUB1RUfjhJSPAN0wa7iJONNmuyegRKDurpMRwo2eESq/HlgL?=
 =?us-ascii?Q?s1Kpp9r3Fd8/XBYcGI+SXxQsrlmo4MBFCC5Mx+QMemliSteUUcJ67dqta1m+?=
 =?us-ascii?Q?4ArFsA4Pvo2eJ81BjF4jGiDn7N6shdJiR370jXM/GS3ic9HbrfLe1fupgj6c?=
 =?us-ascii?Q?HNYt7fk9PqyYy2pCfWgmXHwmKT4MDerrnaWS3nU/lFep5nMtaCEZaLfCgwW/?=
 =?us-ascii?Q?Sm0ZW0OwStXz4nCWghw0zm+VyaxyQZerZbAY7DrW0lxsKoulGvjQEwPdVcv0?=
 =?us-ascii?Q?XOkMO/yJcppkg5wjBUGC8+EJklF6tjA0nu3aIA08s37gAueH0vmULLVHHwPi?=
 =?us-ascii?Q?FNviw8xEeLAqtFw/hMHkhp5NYEMOdgiPtdDRFcQM347rMJOjvuhGg1buzDGj?=
 =?us-ascii?Q?fBA7H8jgT2YsAJDtP1G61YySG+UAjyDQ3wQS32bpygU52rrRRzVaCJbHH4JQ?=
 =?us-ascii?Q?xUq9RwfSmd2aeusmHSwKamH8Br5JEIVzGYVGGp/o4Fkm2pB/LITRWkZPwo+A?=
 =?us-ascii?Q?8KXO6Kse8ySCV729pzUwhH/6oAdMh3qFKjDejN+xfEGMHOzHOG0S/UZZ92A/?=
 =?us-ascii?Q?xhuJ1V3PB51GUtTsN/w6SE6Jq4XbLxN3OpuDbxQj/SlJ8GrtjYIoNoWnX82m?=
 =?us-ascii?Q?9soQgizSGcUlmEhv/EJWMYF6h4ttaRcAiB09b6uBm/O+YV7i+w0QK6NdfcTS?=
 =?us-ascii?Q?zV1HbOPRdrpaB8OKcemlzr9zD4+0XvVfTEZL+QnrPtQLopX4bJWtx42JQOx5?=
 =?us-ascii?Q?WZicfEs6u8ivMGcDVz7zCLw0eeUIpIchYBqy7a0wiQLsm+qS8bVVELuIC8oE?=
 =?us-ascii?Q?4oxaxWiZXjL1JaLIy4t6QjP5VMH4XFjlFNRYhK/M02JdmVsi8mcXc7daPFhs?=
 =?us-ascii?Q?FSK+SvyK3vnPCi8YHmQ77VAPccyCu8rlE3oZUOdKYDX5uV5164bvPHJrq0jG?=
 =?us-ascii?Q?gsuEm3j8zrOMi1YhjslpMJYg/5UV6vlgyvLlFlcHK6wkxCrs/ssQFqneEz+P?=
 =?us-ascii?Q?mCuokazo56AqLTtVjKuYZtRrNS362LAhqr3zax3Br8FS/kBaHUSJNd9Hw+XH?=
 =?us-ascii?Q?dwf1heqhnozaMjtFMQtWbLBjHqUwNkASOyzJjw/1REHPiZJUWTDu5kFYk+VT?=
 =?us-ascii?Q?zd91DD+LUHQ0adkArr4f0Z+xB74CUV1TzZ3kEcq3y5pzDNH7kV8JV6FGKZ6h?=
 =?us-ascii?Q?yEOZWTidnaXi4sdyPSY/DeCyH6SWtGSAvuKZxxthHRxjxvAovCF7BIWQLKrp?=
 =?us-ascii?Q?4KQapb6AcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f2c361-53f0-41e1-cc82-08def82da870
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:31.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8VH8qDDR+AgC0Ug6XYc6h3teYMfcVklj4tawncoCo2NSHyVrneDsF+9Bv9HGRD98EQkqZrJVhM/ijzGHhbuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

The success or failure of pci_reset_function() is conditional on the
state of the device, ex. VFs enabled on an SR-IOV PF.  Therefore a
driver can no longer infer through executing pci_reset_function()
whether a device has supported reset methods.  The reset_methods
array indicates whether the device has any available reset mechanisms
and is not gated on dynamic blockers, like SR-IOV enablement.

Export pci_reset_supported() for drivers to use for an instant
snapshot of reset support.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/pci.c   | 1 +
 drivers/pci/pci.h   | 1 -
 include/linux/pci.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 06728137c407..0b4f13397da2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -98,6 +98,7 @@ bool pci_reset_supported(struct pci_dev *dev)
 {
 	return dev->reset_methods[0] != 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_supported);
 
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..416fd6b74abe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -230,7 +230,6 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ab41a49f4eb7..4de21e6ac538 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1474,6 +1474,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+bool pci_reset_supported(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
-- 
2.53.0

