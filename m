Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4571330652;
	Wed, 20 May 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779249598; cv=fail; b=CZTxKB1f6k2Ww5tIPmoizZddIxCY181mGbSLrZVgZULhU/WwIFn2pdehzUkBz83hQ8Kk4xYbEaPqg/Wb81zs0L/qPCFVBY8NlD8Smij3j+iLTxQ5VEbx1USWIBHN1w43Aon+a9orSpz5loY3xbxFcbVZJcLN143PVoBcXo4GWgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779249598; c=relaxed/simple;
	bh=9hsPqWIbOVWRKQDaB7KTOz2qu0uSCDjsJwSItchY8Ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CS1oKZq47YFdEsJetl/0b3bpE+vJOcICnr9Owvtr6EuA6E7OxZi06DGudyBjpKSpO8Q6YjygjP3wnjam7UIWji1mVlxpXrVqBf2DK0W8SoiVaQz0xMg30bRwPiRa/BnM25QJ7u9oghrig7SAXJfe9SxmA6Pepmm5vbdHp7/r8bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMrVGRw6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMrVGRw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779249596; x=1810785596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9hsPqWIbOVWRKQDaB7KTOz2qu0uSCDjsJwSItchY8Ak=;
  b=JMrVGRw6XCGr052vqmlmF9vUKayMvuVVNbb9XpiJ9grCq+4pI6qfMHSC
   gdPjFzNTgigwQUmRu4uZnpKvvK2oOh4844xFUwJq/Zu+53j9kMQq/0y+2
   whXG5FHTPiphrl1pA8/vRVQzk+Nob/BoSfqeXWgUGdQml2ndeChRUUCOn
   HSiQwzKC1/7uYIxUzEAHsrlZwpQVh8TviLPjs9bAw48/mU6p7iRaykBIH
   8rStBp5a8H0BUWDAjBWUzruAIS/fGEyugXpWoQfpyTmpa0eaLLrXKNr8p
   IJWSZusXuZ/YB2CMVHDwVg3ndLtI6HCgDEr+F5fyh/zJEo49dUXyTeNal
   Q==;
X-CSE-ConnectionGUID: 3UunxulBTR27km9vQfZrxA==
X-CSE-MsgGUID: yi/Zw6hlR+WD39P/bb4dGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82709567"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82709567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 20:59:54 -0700
X-CSE-ConnectionGUID: ZrD3DKCmRu6av2YqATfYbQ==
X-CSE-MsgGUID: +xpnAvlnR7a0VdVtvin9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237389888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 20:59:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 20:59:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 20:59:53 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 20:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu3or9ceD/A8vY+xxvvmbwcsWoTuOD6nRNktWTiy0F6Miz9UZb7naXr4uNV0PqyvvHQbO7xS82H+TltFVOl0GcYLTzuQgCx4zmM0xJ+64oTnn131OX3jQqbvQ+If7bkCbDSKdtqp3ugJRLiQqjn/XtXNTZlYf7pmLM5yfRC6/wxikBh7SEje+nkw+ujU7bzbL4japYeSyMHID4Q/L9VfJcGEAd1bROE2UxsJAtekRfo385BQRhhjfSPO46Y9ipj1acs+ctv7J02EAsF7BLHHBdP7YLfZkHEm1kQirXBO5gIxRyxTU5WL2pyBQutfOd3IpRq6WovQOe7EYw3BzkMyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A2rlMW/Zozms2Ct+ZoQx/W6FYysTN5qmYZTthdvpY8=;
 b=Y0e2L+NW8jvqY2BIBQfWOJxu9zCs+QH8UrWrQZQEZ4R00Z9+082nmmUdE0tpl+HCfFqVV+ufzKr9QWmTAkURvOArfojsIvxWDBUP4UDIGmMjGyM8KG/mPwsIRiJRkoyEUxCCGmjvmCFpR9iBYNIwmv3bqoATTTC/TGA1/iyC5pBDJqSRBGLCP+popEErtlpytTsNSDxJ0Pow1xjm7VUD0ghQfvjATPIi+GN/cXit2V976OFoCnXbBZAPfaxlIvujiHt/fh6bZQ/dlL3pBO9J/N7xAkhWMHICQE+2kBufjjLjglOYVXRiCfHj8cE46D7BIaGvFcfSIyH4Pc2LIN1wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9873.namprd11.prod.outlook.com (2603:10b6:806:4d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 03:59:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 03:59:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: RE: [PATCH v4 00/24] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Topic: [PATCH v4 00/24] iommu/arm-smmu-v3: Quarantine device upon ATC
 invalidation timeout
Thread-Index: AQHc50EqNvzduihNr06Qrajumo3F37YWSxOw
Date: Wed, 20 May 2026 03:59:43 +0000
Message-ID: <BN9PR11MB52761E126A213C6CD2CF77D68C012@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9873:EE_
x-ms-office365-filtering-correlation-id: 4d41f970-1bc5-476b-0403-08deb62439f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|38070700021|11063799006;
x-microsoft-antispam-message-info: K7WllOgBUq6fmZAPXXCXG1SoNDjUT8IpZxwIi+iujC8OZ9OJDU+mTbuLclbPw2vdRPtB+5bkI0gvhARqyM9kR01XmPGBUrhF7/HspuaJLA1mG0IeQ82fvWskvrLDOKI7mOnpHA2IV3aYd2gU5LVdEXNdWjsg43gRWjwy+6oEWZrA0KHy0Wj+2H2GH0ZSxNUF7OiHGE544SlppoXU+B8KfXK2iqFwQp0wdNX6Vgh0qlnvmiTnO67tMESphC5h04DMv8Pm00tpEnOQ0+bgPUc18huMQJyNFm+MWH/FnQEBqLjp+6ymx/2NQhVLi5p2pcgm7jGgwFnt2f+Z7IzolNV1lof2Amtcip0RW3wbBjmgMplxCwwEdlsT3CoZuuaOKvUUFxH8+mKJ1YZ8kPDiwsAQzMa35oJwzK4BRJkZs46svbUGCXulAu+lPla6jnuTTLTecvi9K/hIgffQCTSG+NT8EKjqisG9Djz02fCWQCdW1xX6tF+UmyOwDNxYdPPBODzZG2sAzAVnCsVXrdtULUpulojYNDpRInY5vAhTFzHV0wYwRrnhnq/tPtsPhCZ1v3Pds+KLQuAZLY6VWDyQx27npOVWQrDewtb9km4U/7OID11xU21275pqv68uii6TMSKE0CbAySI7deG5YWjCP+h06AL8g5NSgfLDNihTrz1uI1esqnfK6hh4OFqpdNwt1xYAYJFrZ6Ozx4y64WH88UQsnxF7RfBo4pQGG22N9+OJVtEiRU1LFSUFnVlJrqoSYmXm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zloYKJRyMVlVEGz/owtQjOcR83VkcR41nOsgDmF0C7esLCGRrHHQoUzLNc1d?=
 =?us-ascii?Q?y47Av/djXBXXMHmBp6/9kMMKaJen2TwvHScbql2+64G4edXDx1lmxBNJIBEw?=
 =?us-ascii?Q?o/kiyBrM6o3xj41LB0jEfM985BVKL2csF2qmKPrF7ciXYo2Fv0DBAZa49zxC?=
 =?us-ascii?Q?Hxc4VK8BlDI0KXE0zR/gkPZDZ7EQHwFa2j5OWK35T/8VrQQRkroyub+94QkL?=
 =?us-ascii?Q?/W8xkugk9V9cTj/CmuSjWX94sZWVSwhwUwzZbs3LFKewfgRLQkaK64FU8VTW?=
 =?us-ascii?Q?b0+yjH54icqWafKvW24xPrFovl1YBcuhFzzYxJUKoUkkGYQj7zcWSoIGnmDL?=
 =?us-ascii?Q?u7pUAX0jGPIk0cj/CBcLcufWcQteBY7csM3kdPeT72EtOMWdigDvP7Mjl0P2?=
 =?us-ascii?Q?SB2lamQSrOOwXwBwlmEJQNWypGU4Ydh0ya0xJRxYR3c+YQWwbo1E1s+JgQWx?=
 =?us-ascii?Q?PNxqzJPAtezWGFCLutK3Vc5thCkpaf78cweIt6viZrrITKpezoT1M+xOYDMu?=
 =?us-ascii?Q?x4xck6reawUQb4grUhhPTsixlz7HTxfGQqhhdBdm142i15bcvpvOt/dNnXQe?=
 =?us-ascii?Q?0iOBqBQMmy1VQRgtPnNrzICvinlhd2rqPH4GH8PRtcJoHYrWMrStiCTFu6jX?=
 =?us-ascii?Q?qldLDBUPBLNFWhu2IRX3NOUOcM9eSYOSHRKc0TuWapxEu4CNBfW1FZj4xiBt?=
 =?us-ascii?Q?hFy0va4K/xZvI/wZJBFGDpH0qydf9vhiFI93yHux0OJzKE3bOZszDpTtl2A3?=
 =?us-ascii?Q?eUbNHrO7Y/CUkxC7lOG2G8c2AtCYmDh2Hb9vnstTQsWUXe0j3L9H0OFhdaN6?=
 =?us-ascii?Q?0rrug19HZKgjP+o4LRxsN7RWoDx96nbu1F+t6TdsRQ38db2TGjlEtc31d00A?=
 =?us-ascii?Q?XCAH3fSG81dYd5PgNFobJfXRshMDRVl66AgVns/euXj/lsht24WpNdsiolhc?=
 =?us-ascii?Q?HPBuYa0kDQTLLrYjuJgCQznBEtoOtympH65lZOfEQGJTghPNIqXIrwf7ExVc?=
 =?us-ascii?Q?oaiQceWL/cNsIx+TFBsk66DGZXG8MQw46evUL/FdPEtZPNgVQtvVZKRk6eXZ?=
 =?us-ascii?Q?cCkenPCdDBZan7qn2Gs7uqv1mwesP9OL/ZFAGlIRMFaa2V7UYfVxnmaVIWMR?=
 =?us-ascii?Q?JYvTf8dldM3MbUlJuT3ypeyKoq9zORHt+Yvu5011QMVRizVaYTPrYS3dplAR?=
 =?us-ascii?Q?Ub9bBeOFb0DVcGAiuAgdLbP/rMyCE1uTYqN3w8Q2mKfqjz6xtH4CmtIjotKH?=
 =?us-ascii?Q?ML8/rW0F2Pzr63Ci6xNQSrNdVndl0AYFKq4Y/NOLI2pWqb5o4/E3BIBz4298?=
 =?us-ascii?Q?J1Oi1b9VguChQxNNd/B+9IqZgJNhyEOWR1/FgDYEdywGNuYzaGINGXJ8Ol1z?=
 =?us-ascii?Q?gWZnGXujUhuNpmoBkcjPX673BoZcolxrfTX+wVfG262CnIjuDYgOALTmu8uu?=
 =?us-ascii?Q?WOIIpVSF/8o5F23Qrrq6Dsw+iFqVVEBmXK1EA71qZgd/4GVSkKw8aJcA0i5L?=
 =?us-ascii?Q?t24NHyoEvkhVa93uvheYaFn9J39QH855bwDJYWnFk9kXjtYYKq+AdJv7r9kG?=
 =?us-ascii?Q?rarq+o1b9CcO5oCtpaFXo6GA7VcW+XYsOU8CwrNZ0zRQohI/8wDCXKTxjolf?=
 =?us-ascii?Q?Sn+KcD4nQLRm+cJC147DhZB6hVd4mBP87nome48vIZO1m8XhiGgoa/1Lk1TU?=
 =?us-ascii?Q?D+uIwKwfe8RtZvQ/R/HAgLA5R7IO3Lb2cNJVDZY/VYtdXvj6BCcOu4LxbKYh?=
 =?us-ascii?Q?Sz8kHeyMOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k+lqt6j3KAV2DbBKsbx29GKpucn+EfUoQJA8kcQ4OGL68xg4En9kvAfcr+f9bcuzIZXNV6lyE3sa7E5mo3NNq99wL4asvaJesNdk/WhndWe3rmidpIEn/RCcnGDxNBNa1lEgVShy+du/8AdmpszCLRRn4G/LgapjIWF8B1M4ONu0tcXif1exvl2UQwwnCVWM7O11r7nNLXye/rHbddqR5Vl7qAGd+FDpdWifpRNhbpseR+3qX3gUvyG+OfhCSrOPWC5i7T4jNxGq21jWyPN+LYbY19DeBver1sOf1BILfoiy9LKMBZpAt3K3jVLtqnqFQpbE/0OZFFTRkK5g9R8xrg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d41f970-1bc5-476b-0403-08deb62439f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 03:59:43.9855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpUx5ehfXL2KF3YxuPwqRtUk7D7s3TtmDweLq4ANyOR0I7557M0tFzUyPT3RsAC0YlULo9x0rmmR2Tg9nLagbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9873
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, May 19, 2026 11:39 AM
>
> Changelog
> v4:
>  * Rebase on Joerg's IOMMU "fixes" branch
>  * Rebase on Jason's SMMUv3 cmd_ent series
>    https://lore.kernel.org/all/0-v2-47b2bf710ad5+716ac-
> smmu_no_cmdq_ent_jgg@nvidia.com/
>  * [PCI] Don't suspend IOMMU in probe mode
>  * [iommu] kfree_rcu() iommu_group
>  * [iommu] Convert gdev->blocked to enum gdev_blocked
>  * [iommu] Use disable_work_sync() to fix UAF and ref leak
>  * [iommu] Gate done() transitions to preserve BLOCKED_BROKEN
>  * [iommu] Decrement recovery_cnt when unplugging a blocked gdev
>  * [iommu] Drop racy dev_has_iommu() in iommu_report_device_broken()
>  * [iommu] Add gdev->broken_pending to skip worker after racing recovery
>  * [smmuv3] Add master->ats_invs scratch
>  * [smmuv3] Add arm_smmu_cmdq_batch_issue() wrapper
>  * [smmuv3] Force per-flush sync for has_ats batches
>  * [smmuv3] Serialize STE.EATS and ats_broken updates
>  * [smmuv3] Co-clear pending CMDQ_ERR from cmdq issuer
>  * [smmuv3] Add invs and has_ats to arm_smmu_cmdq_batch
>  * [smmuv3] Move arm_smmu_invs_for_each_entry to header
>  * [smmuv3] Set master->ats_broken after clearing STE.EATS
>  * [smmuv3] Issue CFGI_STE via arm_smmu_cmdq_issue_cmd_with_sync()
>  * [smmuv3] Keep "smmu" pointer in arm_smmu_inv but add "master" for
> ATS

Not check the detail yet, but this v4 more than doubles the number of
patches in v3. Are they all necessary to be in one series? any chance to
split to ease the review...
