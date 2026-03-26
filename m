Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C3233ED
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549886; cv=fail; b=mBsVPWDKAOIRp8VFX/xeC/BaEwq8DVWV8zNKyJ9urB+muZ1iSC+ksMsuUljHH67lh4/M37ODqUQVkIAZ9kg5OyPdxOaxts+HNIXeYYrGa1O/Qc8P3ee/ZvsCi50eUxYnBPHISbC4GBkqG5X/vT920vmjDzS24dJxQsZDmks6bEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549886; c=relaxed/simple;
	bh=axXYgFcbD9BBlD3oh6CknCv3x4cSOLdJZDdXI4jqS7Q=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hKMUrYX7GtpTZ+7RsIKzC0cuZpf+PWZSgewKVzDRX/074/9EEEPfsQ6uhOt0ZUg+q30wMUeKCsXqc2lp/jfOYl1lqfxfrfo/yhoKcSdiqMUn9I4JuSH+p9iI2aJN3CwyH3xgRllb/XkwFwANQF83tuvc1LisrhGb65rEWmVYJ0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgM5zB9j; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgM5zB9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774549885; x=1806085885;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=axXYgFcbD9BBlD3oh6CknCv3x4cSOLdJZDdXI4jqS7Q=;
  b=bgM5zB9jFXnWKAOVcbychiPlL0B+LfpRw5IgwZhaQDd8CdD2W/JnFsNI
   041SqZwczGSeEruwuzhv7A+2KpGi3rFY6DBoEWg2fS1s47LG4lk0/kkmZ
   2rlvksmnhefnqstZHACXf4m3t0RVl0FtlRcJpRvSiYBsuPknN3+gkAmlT
   +80crAncFmhJqjHp814LMQI2a/amfzUiiw6kXQ1cT6UdIF8+U/BxeW6gI
   L/wWaxCoN181N+dFSiXtbyGOr9RWwUJ1KyShJ4uVt7exgssOPwMyuDLnV
   fSj9yjHHrTNOc5+6cttFB3VXKC7tSlXgTyx6EYIjdj4vsEPzhzgFUC5yc
   A==;
X-CSE-ConnectionGUID: RYqGjbkfRDyap4QcdaPoUA==
X-CSE-MsgGUID: cKyjSK1cRLaDnC2DbYXFBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75512109"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75512109"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:31:25 -0700
X-CSE-ConnectionGUID: RgGa7IQ4TsOtFKmf/2Mrag==
X-CSE-MsgGUID: hwAwUI38Taypdle90ZYb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255580727"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:31:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 11:31:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 11:31:23 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 11:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGMHgIusr3sAtsOoZ5OWf8FwuSHDs3oBm1oj6a56dEyTIw+RnkXUqB8y7RrI25A/oltuyFtAwo2Q7rRLY5/ZDHOx8+4ML+Ez40rzvZNDu6wqBwxMxoiYUOucstVFi9bhwlW3W8YJIw7MBLcIaC+M0Cov7t4VExU7t1PJ9QKJ9Bq7xRoh/0JHmVb+Hkk07HWqir1BHB5RpmjGAwus4cqwDAO3fOwgJ1fWkx1i7igeXxzJW1yGQ3Xy4oOxdUBeTS1dW/2ptoMSKcBGYsyjDr01LxXaaVeH595KR82PkWsQCbAuk8UI4uZAiVaNIIJ+4pDvHCXt13AXxDOTGZm3pKc8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv+I7Kw/EwwpTGwHa7ikqEOy/dI19zeKhAonmPTJng4=;
 b=WF0Hlk+3cXzUhFcdOEHX3fo8PIch+hTVHpiIWAqtVx6/V7CzHnB5FSW1c04DSnbHQuv+xFHzaDTyYAEt8tBCv8fXYZvDmiaZ7QW+hW9Mww9bvaol1UpOgl2b+amqI5vznDqWVO5mPz9rFGxBV0yPjZvtJ31vWW09osD17SSWMxTICCabCHr7JyxCLvnl1VZIbO5IPzsWmBFJ+8A51CdBVMktuH1VvX/UMMz3L3mmlI3IcJpWKlFf2xXli4qxCy/z039D5BIbw/GsWtf7TxhK2ySCsY6W8g4OsZmcORdeGAzXtqbGr1blHV+KpKYAlRzb3HqW5nkTb08HEevK8U/MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF37A184CA6.namprd11.prod.outlook.com (2603:10b6:518:1::d15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 18:31:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 18:31:19 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 26 Mar 2026 11:31:16 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Greg KH <gregkh@linuxfoundation.org>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>, Samuel Ortiz <sameo@rivosinc.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Message-ID: <69c57b745af0f_7ee31003@dwillia2-mobl4.notmuch>
In-Reply-To: <20260326120046.GG67624@nvidia.com>
References: <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
 <20260325115607.GB67624@nvidia.com>
 <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
 <20260326120046.GG67624@nvidia.com>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF37A184CA6:EE_
X-MS-Office365-Filtering-Correlation-Id: cc950c18-a8e6-4f1c-ad6b-08de8b65df90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kg57n8dEb0sNvUAfYeAo2tR72KEDWX8PrYlJSRKAN8nz/CSAsRJJyVgf4bQlilrVS392/OT1b33QpznKQKyTrWvi/O1h/mbpwF5ETe9wQlK39bTR4EMmB0nWhCXnoUJ2NVkP0TPWYOp/uUq80/Ja9smdqre8OT9Ff/mHaQWlidZ1WiCpoKNlXBOgcHzzB2dEB5BtBzQz4hGSG1017sNymBoJiQCGVYyQ6v3pmwDTULkkjTY6HvPvvHIVNY4uj2MxzXWj0EXtYCOIDCDnYPF9/ttxXQTxdhElYquhsM3E4sMcmgVx9wOfICrgAsTk89RRMuzZh/I7HYXmTLAWi0tiOCFisfU28wFPc+WpawGNxdLnbqtVK7kG4pZu1MHr74Ik/MUFQkcvZMvoj3BCzTnK+FNlWsZzA1zwgQac3R+kmYVBLgiQp9JlHM43cFJnDaYMCTPxIELmHzI4oDTCruP5B1LEoZeqD+CfBoxnW6jr4jzfE6/a8awIuaqC763zPWgfZmIT/RfF4j2YuEO3ZOUrSDFJjyf7J3LYnI6YFBWlIdGbR+cZQ3JnQHKhK5+SVsEVnwKJbuVxWxB6hgFGLR59mTAhZNtwBYY+I59hVDU3Bglta+gJvazCmIPXKyrOZfCb7umm52/lTE0rYVzKPhjlpBXF1odk0JEQJP1LOr3fthu2mzdLDQjv8AOkmHZXyZUQ5jdk575+fXjDf85oiwfFHnLPobZ2hIb1c39g02YoiHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRwMTBiZnl6T2lSNXpCejd6L0plKzNlTVhKOXppY1hEaHgxUG52QmJUQXQz?=
 =?utf-8?B?Q2NjN2hHSHM0OWVpaUhNWlh6RFdXZDMzRzBNeGloU0Vud211bDR3THFSL1pJ?=
 =?utf-8?B?T1BxUjcyZGl3RExOUEhLLzdxOXN4VWVweUZFSGNvOVd4bzVKM1M2TjNyZk4x?=
 =?utf-8?B?MU1LeGhQT3NGZmprSXpJbi9zMmZmMGMvdlpFUzBKb2U2K0NyUXlqL2h3aGpM?=
 =?utf-8?B?Uyt6dHo1U2dHZ0ZUWmNCZVJNdnpFRlBiMUdtK2dyU1hIN1l0cjdzamVEbmtz?=
 =?utf-8?B?T2g3NzZJTEhOd3F2Z3NrY3pFbEZPalZCa2VhcC9IVUxkeWQ0NzNkZzhkK2d3?=
 =?utf-8?B?MnZpcUw1ZnlRZTd0YzlkMWtmYlJiNG0wNlVYdWs4dmovMVFwYnk5azRUaytF?=
 =?utf-8?B?TTdpOGZLOVFPdVRoOXlrdFBZZHBkdlRBNDBCTms0S3pwOUlsNUhCcm1pckdk?=
 =?utf-8?B?VVhlWG1QTlB3S1RRQzBodlladFo2Q1F0SExLNnhUTnlHanZvdk8wR2JDRUxH?=
 =?utf-8?B?Q2NTL0kwYVdNRkVhb0tQN3ZSSmFMWkFvL2c2aFRmcnBJSTY4TFRUM1lVbTI0?=
 =?utf-8?B?bmhBVGI4QVRkTUxheTJ2UWRBeHIrOTQ3N3pTbTBjSGVvMkRpcUQ5dG1nRUhx?=
 =?utf-8?B?cDhsT3hWc1pEVDd4M0MvQlM5QzUra2RPT1oyRU9zZkRaWEc4cStxdXFtUEZF?=
 =?utf-8?B?akV1d3I5cE9sTzVaN250RkE3NGM5M3RmMlM3L0VsakZuMkdKcnJmS3BtZEJ3?=
 =?utf-8?B?eFc5czQ3ZlhXdXg1VTlabXI5a2hIcTRGVXVpa3JtYUo3d3N0aGhjWWdiNiti?=
 =?utf-8?B?Z2RReUtVZnFNWWZ3OEdNNzI4ZnZmSk0zWVlFN2dMSG42SjVydVAvTFZaQ2J0?=
 =?utf-8?B?ZUQ3dEdmeUJpUGVBYXZUNnMrZVIrMHNmZWhFZzQ2T0xUZHdlMURuRnFCQzYx?=
 =?utf-8?B?a29GbFBvblNsdFlUUkVTTjRJY1FGcmdxZEpjVGEyMUxQZ2lyYk5MOTRPOVJl?=
 =?utf-8?B?eC96QVVVdksvYy9YMVBIWmtPdEUzeXlPY1kwQWpsa1FQdFNmRityN2FxL3RT?=
 =?utf-8?B?RXdKNG93ZDJYWkhYQmRHaG1TS00yUmhSZ2ZoVm5oTXVkcnMrL1kwWEtHZGpV?=
 =?utf-8?B?VVB5L3doOGxvQlVJbkw4eDlLQlh0NXUrTUg0VHRmc1Q1ZDJyK1FwUFRKRG93?=
 =?utf-8?B?NllKaFFqbWtmMUZmSlRMQTdJYi9JakJNZ3pQRWlSSDBxcGhqa3lqN3JqaG1z?=
 =?utf-8?B?TlNVWlJVQ2NBK1ZZRUxQMUoyTWZnZzkwUnMvekxhSUpueWd6cWNPRXhxR1lD?=
 =?utf-8?B?aDlRcHBPdXMra0d6akxMK2wxd0hnY1d4TFlyU1ltK01reVpoakNyeFVxL1Ni?=
 =?utf-8?B?QzZ1WUJaaUQvUDU0NGJkUGxHZmppaGU3ZnFWOU1WbHJSbFRiZS84MmdZdFhZ?=
 =?utf-8?B?TTE1V05VdElLc0ZFTlYrUXRWT1N2MWNZWTlobGh2K0hSMi9rcnR6SGs2ZHlV?=
 =?utf-8?B?YTIwSitMc0kvWFFOWGdpN0k1NTZXUUNjQll5RWtGSC9abUFvemV2R0FuTy92?=
 =?utf-8?B?eVhYcHpKaEwvcFNQRXNEaUZidGNjcWdlbTIzYTNzWWhQSHRMeHJZMmZCN3JT?=
 =?utf-8?B?d01nTUFTcVNDWXo1MFp3MTRsMFI0b1VyZXRpaGFDVmhsYVFpMzVhQzRXTFNY?=
 =?utf-8?B?cytONS9DMkxaYkJLdndEdWxjeVMxT3Fsa05jU0l5QWpETGNNZHNYQk91cnla?=
 =?utf-8?B?M2Z0SXlNTDhaRUhqaVJhU2R6TGVwODRmSXp1WGlETFc2R0JoYktzeTREcmpZ?=
 =?utf-8?B?VjJqclVHMzBhajk5MlFSa1hVbmJOcXJVYVFYT1l3VFIvWTV4ZWZ3NmRCSEZ1?=
 =?utf-8?B?YU1tTG1WUURCQ3hWSk9VcW1LMElwblR5b29aVWtzZHR4V1BlWEM0NlFkdEkz?=
 =?utf-8?B?R3FPZTZHbGhHenVHMHlPajhVT3BWY2R3aE9pVHUrMnROVjZqV09xOHZMeWVW?=
 =?utf-8?B?eWxCRk00M1YxVTFPTUd6bW5DUUdwMHREQzUxeThza2ZiYUMwc1VQODZHM3hx?=
 =?utf-8?B?TG5vRFk1SktmZE9nb2NwWmgrWUxCSFZGL0o3dFdjbmFrU1UweTdYT0FiQzhv?=
 =?utf-8?B?dDdTVlpUc1ZmZzk4YkhKM0I0WmNjWVZUU05IenhXM0tIekhKNkxteVVlbTN4?=
 =?utf-8?B?YllzN1ZSTzBXK1E2ckxwNFgxWFlIb09kNlhMeCtaWFJTK1R1b21oY0pZSnRB?=
 =?utf-8?B?N01MbDRpQ0VvYllYdjRORm5RQU5NYjZrQ1VEUjl3R1R5czNzOWZleFJ0dThk?=
 =?utf-8?B?K2kvY3RSYkZFZjUzYUVwbFFCamI4dFc3Q1dWb0pidDlIVWpIYzNsdkY4TWdL?=
 =?utf-8?Q?Rj7LGvwMlze85/BM=3D?=
X-Exchange-RoutingPolicyChecked: RtdfIhyxpsL5dsdIKySLEA/jmii+/3//9DjYoKzZ/4sYya1zxA4olEUb3LeIlkAMokfchsaTeK+CtscGPzg8ZI/+WaTGaNs1SS9ZGCxV0DONOqy5qijlxbYBXR5JpRxkdjFG/nBjjB870iH32SrYCjJE7/F0H9b4OHt2LNq9WzBd7O0UGwIyCemT8KSaqSOKdXMKL/76KpkhEF5e+4vf8k+ViWniWWZCkJc5PcW/I6SlwKnnA/4C2HB/yr0Uxv8FhwF/XcNSH6yZ1EqB+7rXssnpJaPhPLFNBGInbrCNXehnMD50UBqQx6GkAMLcHbPuz3KQUYAM1dE+D1+5NXcsOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc950c18-a8e6-4f1c-ad6b-08de8b65df90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:31:19.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv+qeBcqQQViVHYPHT7tL80YFsjKPipPx3l3eyJM4PNNGWHOevoGhDzFI8O7nEuTl71dggZZtWIdKoPaxAHrGregXYysaDqEJ8MVdkVAT+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37A184CA6
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > I assume this would also expect that encrypted MMIO mappings are also
> > not established while trust is less than "TCB"? That would require some
> > additional enabling to catch attempts to establish an encrypted mapping
> > that the hardware is prepared for, but dev->trust is not, all without
> > needing to modify the driver to worry about this difference. Drivers
> > would just see ioremap() failure in this case.
> 
> Hmm.. I don't know if this matters. Once we decide to use the device
> the MMIO should be mapped in the correct way, whatever that is.
> 
> If we decide to eventually allow a lower trust while T=1 then that
> should be taken to mean the user wants all the features protecting the
> communication channel but also all the IOMMU features restricting what
> memory the device can access.

The question is whether any part of the kernel would ever track that
secrets in MMIO writes should not be written to TCB-external devices...
but that is probably a "trust=0" situation. "trust=1" means "be careful
what you send to this device whether the transport is protected or not".

> Remember there are two parallel things here, one is T=1 which is
> designed to protect against hypervisor and physical attacks, the other
> is the trust level and iommu which would be able to protect against
> attacks from an attested device itself.
> 
> Even if you are in a T=1 environment you may still decide you don't
> really trust the device firmware that much and would prefer to have it
> more restricted.
> 
> For example, if you have a system with a NVMe drive then all the data
> on the drive is probably still encrypted and has be CPU-decrypted
> before it can be used. It would be reasonable to run in T=1 and attest
> the drive to limit attack surface but also use the IOMMU to limit NVMe
> access to only the memory used to bounce to the CPU decryption as an
> additional fortification.
> 
> This is why I am tending to prefer that the kernel's view of trust
> level and the physical HW capability are somewhat orthogonal
> things. Even if the HW has high security the user may still prefer
> that the kernel distrust.

Sounds workable to me.
