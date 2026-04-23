Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649C1EE7B7;
	Thu, 23 Apr 2026 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776904158; cv=fail; b=C69z71cvbT0wZT0iHsCGiF+20PhwquV+RUgfYauFlZiHuMvi38iK1+nH9izMFVIUofOxJWRfITkFtUWqDK5j5EhO5IOwxwI7qKDqry9FFD0t2m2jhjmjL/6sB0pokvOVL2htoH5BDZBw3o32bzX2oGuLpOv54rfo99il88+lCeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776904158; c=relaxed/simple;
	bh=M3w6Zj69Q+8hHGrjCerrnqd6MrPUXNaGUPiXSdjkswQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rb1flESSiJg9CmB52Lz949ndKryPAI65BbTynNfKGPTS0jTRjt6D14hFWVFqxPHXm/n9F+jjNICLFM7LYdun3QaHvlGWUQfDvhtG2FU7/dljvaiPLtWQTqDyzgjPPdNL4EU221kWCT+uI/g5LPspO3LPtiaEp8EcjUh5jU5LBz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQ6AAgqN; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQ6AAgqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776904158; x=1808440158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M3w6Zj69Q+8hHGrjCerrnqd6MrPUXNaGUPiXSdjkswQ=;
  b=QQ6AAgqNrwroFBQQ9caRY7k+PRX9dAgen882ZhfKV1IQI+dqjNPejcri
   m1Z5HNTXGq2RjBW/+tdMOu8MzEaaIJaYbs5RJ0EC8G6TTNN8s9ILAGk1b
   aaav5jjJJPXE79KlJme91NXWO2m/cjkhN4WIrNNcDTc+IHrZgncwVvqRx
   poZ8+4fsn/8a8tMGHxkiKd21SKfGkAcEa9vmyenA+JZmrv7BVZ5L0TuAZ
   kB8flqaL/vyKJjn39/0cO9PQXy/YvO1hvG7jlBRnjY7OikjWdhpuIIYKv
   t/CKy3v71W4OXHHKtF6t16ksn3NNcJIwY3DeYXEf6J/V7toQaHlDxglWV
   g==;
X-CSE-ConnectionGUID: HCQzVzf0So+rqxX2SQtuZg==
X-CSE-MsgGUID: XnFOQS5sTaiwpfJQy0pEOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88566684"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88566684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 17:29:17 -0700
X-CSE-ConnectionGUID: rAEos5nzSX64oAnXpCbpAg==
X-CSE-MsgGUID: G3mv1YNqQ2KM4wXRd3d2Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="234288268"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 17:29:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 17:29:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 17:29:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 17:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUi24HW6CiYcFeenIinsSTMzLPZHB3W2mtDQ17H+Ag7hWxzc9LQdMIffkK8kz8Zh/dUHHufVR//RPNiH69CDkDszMb/pM9tw6lzVogobaAqW9b399yl9yiQmTwb5cv3iFifoLOVOZVRATUir9WXE0UJN6ZUK0j7wkCuR2AckPdBM0DRhej6/SEVPwwNcck3JSz9C1VuilbE05c9xbMl2Nr0pVxgm8tJLn1YOSH5DAnvpABnd6+Re8c+CEtQi4ZIX6AfwIfERHPWS+QVmM19YNsIenNUiNlJIwNK5sQGzupES+zoriaSTd6f0tfGMX2XQH7y0PpkRzOyzSmIcRviS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3w6Zj69Q+8hHGrjCerrnqd6MrPUXNaGUPiXSdjkswQ=;
 b=Twf3GlZYQWw8KClcSUqwQ2rzS8gQ8+/sLENuuJjFdBEd7jMe+1fH7QFqtiHm9FyRBGNJ5FS0qX6ZJ+B7eDnZYHgQo93GnMskqn6feEi5DF2vjUt7Dlu4AfXBniOrg+maohyQvl5pAWGxz6zuN+8u5WuvPhWaJ3+7C8l7+zB06Ag6o2zpufNkIviumIHzxXh8VrM20zju4BtWm1bC53FeHdZ84NQQOdTWtMxa6ckdeOc/+3AfqisXgnWY6iFkyGZHgMY0B4+dD6eSlHHnvHrzgsiCjZMPaMxJHysfAI+fugJ/jn0e03ePDWQa2LSIFr8JRtGdOpML8SNENIbA6n/tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 00:29:12 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 00:29:12 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Topic: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on
 TDX_INTERRUPTED_RESUMABLE
Thread-Index: AQHcvggx+s9lwQwUZkS72O0QahrEZLXr9FAA
Date: Thu, 23 Apr 2026 00:29:12 +0000
Message-ID: <4f4506d1e0a48e3300dc1a10e1abb75d33604140.camel@intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
	 <20260327160132.2946114-21-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-21-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|BL3PR11MB6339:EE_
x-ms-office365-filtering-correlation-id: 89f5c7a7-d64a-403f-3458-08dea0cf579f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: eN1jDwk2y7HngSQb1M0nrs8qSUtZMoxE5cWth8Unl5iilL1YLUaHsRNNQ4FQ394pK+/0d+Zge4MMzk8JsB4iIjwMMZQP/dFTaz7jAZeuIijSlDvnCPHw29LhFHS202/jBldzci1qVJPl9PZ+rlZ6nNbOkB/Fs+bSO6DOBi+hb7c1I5HUf9Hm+ukQNkzZeY2SPLSgphBvwq/66EgQegjE1PDIDBl2Scx83miAMDh6cCRdFrredb7wlI7Eorw83F4hotr5dJRBrVJj766kZMMtQw5Mi9UYXF1H2qRL41RvWw1FWevw3VpIHCvtTlaTAGVfbVJrs2AwXFu1jPyiPNFOlC1EWhp5sY4j1NW1Zzq8FRSC4XCG6dDTzll3OlvoX7o8Lcs0LGUFQeytoDkyj6LfoYWDJD71NdScjuCP/cVIWgj94DaGyOuZLxyMyXOqjWP+gk9gEPVtwjueTV8jUw8NHD9JlUw7kRg7NwrcfPd0Z09zsy59okhdMdQUjaD6gjNDZzEx5POEIBEx1s7krMPHh7MBZhIMSRMNaNhUC98THpRMzCD60MaQHqFdWAPc/wbDWHAU4y5mu4lOaSBDd9qPX/lN5UanSVdylA6w3dd+S4MtUsDof0PttiNAaNz0GBYOtQ4CDtM2T5In1bgNyBs1+g5Y/GZvC9tbfy9Cj+6HDt033pqK09RJN4SGdb8zfuXA5t39azTG9XkHqUwGSoZrRz6Pusxtmt7Bb5HM1vVcCOznn56GkM01EG+4Issuw/y6Tj+1oszrCtOOeAyCzjJi9s0x8Od91U9QeYZnJ+to1Qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjVnTEpiSGI0SktWcFZLTDFXcmRrNEpKalFTNDVTSTFXcUs2anA1b2laS1ln?=
 =?utf-8?B?M2ZDM1ZGeDBZei8zcVE1UG16OXR3Y1R0OWJ1WXdVaU4zQU1wTkZKOGZaMlJj?=
 =?utf-8?B?OFlCMVh2YlVsSlJkU2g0Q1ZvUktCMlpHNnRBazBPTTZLYWNvN2oybUN1VVZ0?=
 =?utf-8?B?alZqS2gzRTZIQU9kQUZTcmN4a25wbzFtMW5uY2Uwb282OW1ZRW5RMVBmRkFM?=
 =?utf-8?B?eWt2eXVwZExuRnVlem1tbW1VcmNNVTBLUlFOR1FFL1ZBeURidnd4cVY4bklF?=
 =?utf-8?B?Y3oyNWtYbVJLZ2M3M3hQNlFMVGJwaXBvUmYzS0FhY05ZM1FvVHozSFRObFRG?=
 =?utf-8?B?TlN3U1pJOExZVjVEMm8xTU10L1l4cWVQeGc4M0xsUEdIRUxscGhDSXQ0aEhl?=
 =?utf-8?B?eVhnV2FyZjVWRGhkREg2ZFdTT1I4RUJHaEIySlY0VkRRNEI3aEUzcGxyOG5X?=
 =?utf-8?B?K01JQWpEWWttOGpnYU5pT1FyRm9VM2dtWWUvbGlUZ3RNY1Q0Q01SdkZXMXE2?=
 =?utf-8?B?VS9VNlFNc1RuREpDVTd0d0hzNnlienBoWWh4anZkUkFPOWdzYTgrRGVPUWFF?=
 =?utf-8?B?QzFFLzdKNmJ0TXh6UW44S3IvdWRoQmlPa25jUmVIZzB5RE5oOHJlRGIxNTFz?=
 =?utf-8?B?SUgxaHM2eUVXckdJNTFVb3lVVkJIN1FGeU1QUjUyOHdYdVB6dEhyazc2VGM2?=
 =?utf-8?B?VS9iUndPYzNVOTB1bnJZM3JlYnZtVW45RnlBeVhGTmVDMGNBbENiMUE5ckZl?=
 =?utf-8?B?QmFqYU9RVkcvbTA0N3FDQmJQNXJBVFhvZk5veHFLYUxKVXNTOXA1dEQyOUpM?=
 =?utf-8?B?MGxNSHcwMDA1c291ZWFWTXczS0lkYlJaeitJbUZuK1J0ZFBjaUtKVXFiNXNu?=
 =?utf-8?B?bWMwWGVic21TMysxc2ozNlh4a2ZSS0JTblJvL1ZacG9TNFFKN0JHR2hCWkwx?=
 =?utf-8?B?NnN0OGt3bUdMNzg3K2hhSml6RHkxVXBpYVdYcEVxLzZRaUdZMVFTWjZmcUM3?=
 =?utf-8?B?VjJoLzR6YlUyTUR4SHNmSFVBcU9CMk1EUHlWQi9MMS9Ka29EZW51anR1N1Z3?=
 =?utf-8?B?OFlZNGFVUmtzZ082Q1FKanlZQWxBMU5UN0tnRlhNUkhYb1BXM3hjUi9KWkYy?=
 =?utf-8?B?Mis5aWpHT1JTSDNTandtczdMTFM1QlBoK2JPWjdVZExVS3MzeFIrSjl4VG9X?=
 =?utf-8?B?anNoajEyQjRHcTFFYnhtSklVYnQ3NERGMWN1Rzc1WDFqRHNwU205VGl0NkFo?=
 =?utf-8?B?cko2cHcwSDFKNEtETGNsUWV5bXRGMnJ0Q3NJekZFd2RhVTNRVUlqRlliL25k?=
 =?utf-8?B?UGhkSk8zYVJpdkZNUW5jYVJaUzlGcnFwQmhyWTBsZzk1WXJyM3dCV0NVZE1X?=
 =?utf-8?B?WngzRDR1c3N2YlBZdmpOellTbGlEc0pVVU9vTERIaXpBTEN6WmhOVlVoV3Nv?=
 =?utf-8?B?WGhiUXV5RUVYaEt2L2p0bU1rZ1VTKzd2WkY5QW1lY3daZHhmbVA0cTFFR0dZ?=
 =?utf-8?B?MVZQaDBnS2p4bU5wUGU4M2swU0hWTElESnZyM1E2Y2Q5eXVPU2hlNVc5QU84?=
 =?utf-8?B?b0JjbVVjQ3ZpWmZWdXpFSmFTS3diUzNmb094MTQ0bFZuWVoxcUdYVWd5M01U?=
 =?utf-8?B?VmgvVUluZEZlamRWUjNrNzREdWl2TExzVDNQWEFBVG5RNmVpN2lUR3RHOGtp?=
 =?utf-8?B?WFU1WmVEa0dScVNRczdqU3IySGVRNFRCaHova2N0SjlBUGFuN2xPQnZxRmc3?=
 =?utf-8?B?b3NVa1dnQ0lhNnFwQ1FLclhVNjJFS3cyZXh4TDN6VUtVQTIwbkl2TjQ2UEZp?=
 =?utf-8?B?SURUWWNSZk1iZS80K2xHNnZMRlhqV3AyK3BkL2Ztekh2ZzZzSmlMK1BBKzFH?=
 =?utf-8?B?U0lNcjM5MUxlUDFGUDVtWDFIc1lYU0p5NU5WSlZqRW1IWHZUVUNSM1RoSW1r?=
 =?utf-8?B?d0FLWHFUWVlrcDdvR0JDTlRzZUJBNk1HTkVZNEdGMTJPRkdia3BmU05lMU90?=
 =?utf-8?B?WjNwMEp6K2d4QlNKQTRxeWJUaytnd3h3Uk1SVFh0WThaMmlCRHRzZkpiaWlD?=
 =?utf-8?B?TTNqTmNHdU5hS2ZoR3p3YVJ1TXQ0TlJpNGg0V3ZhYklLV3RCQjJyODZMWU1o?=
 =?utf-8?B?N2dhNUsxNVJFOFV4KzVhT0tGd3U0ZUk0N1dGQlFjTVNZbWVyL3JCSHdXVjE4?=
 =?utf-8?B?T1VkTGExTmZzSEM0eHN0V0Vqbm5DL3RtVFo4d3ZBN2Z5VWprZUhqMFpRMFVx?=
 =?utf-8?B?anVkT01MWHc0OHVwbysrVU1ZdHVlVVN4SmRZTGZHRWl2eUhKYW1wd2xiMkxn?=
 =?utf-8?B?L25nclFhbzJybGZ6Ui84UEtIeGRramV2OHpDaUVMcXhKajY0Ymd5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2095BAF456674468050C35B02814531@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dI69bLlFUbHodSvCx4qo4bCOXMZDFxk+wUZMDG4mAYHv6wrOVj6ad73xqrqtlgPtQBMm7bAgGG0USUH5nIcpOaAOTrzqvyDlTdNW+aRWdiLEGmz6h7KtHUhyBPno7MQk1qtsFMewhStqD/JFdATgVBHa/KIgxN4ySwFnS8eJtP12LC+xOeUc4h+xxGu8mRcjZTHhv2P+EjLeTG3rvHa1Ymv2ZsjRnq9CQTztd4bovWHfKmIF2Kl2mkQLUISthwgkGHkM7rBktKs1Sntb5oL1Xq3ni3B4lJ0oxjBVo9ELrOQ+pCkizChdlbz36it/2f91QxESMzxxkne65mioz9hTMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f5c7a7-d64a-403f-3458-08dea0cf579f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 00:29:12.1503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YUC63FPePLdjW/RE2fiULycBEWQIFmB7tSZTEbz0+GBu1aPfCSX7eiAlFy1PzeVWmbAq8Bc1wcWnqy/t4nK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTI4IGF0IDAwOjAxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3N0
YXRpYyB1NjQgX19tYXliZV91bnVzZWQgX19zZWFtY2FsbF9pcl9yZXNjaGVkKHNjX2Z1bmNfdCBz
Y19mdW5jLCB1NjQgZm4sDQo+ICsJCQkJCQlzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzICphcmdzKQ0K
PiArew0KPiArCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgX2FyZ3M7DQo+ICsJdTY0IHI7DQo+ICsN
Cj4gKwl3aGlsZSAoMSkgew0KPiArCQlfYXJncyA9ICooYXJncyk7DQo+ICsJCXIgPSBzY19yZXRy
eShzY19mdW5jLCBmbiwgJl9hcmdzKTsNCj4gKwkJaWYgKHIgIT0gVERYX0lOVEVSUlVQVEVEX1JF
U1VNQUJMRSkNCj4gKwkJCWJyZWFrOw0KPiArDQo+ICsJCWNvbmRfcmVzY2hlZCgpOw0KPiArCX0N
Cj4gKw0KPiArCSphcmdzID0gX2FyZ3M7DQo+ICsNCj4gKwlyZXR1cm4gcjsNCj4gK30NCg0KU2lu
Y2UgY29tbWl0IDdkYWRlYWE2ZTg1MWUgKCJzY2hlZDogRnVydGhlciByZXN0cmljdCB0aGUgcHJl
ZW1wdGlvbiBtb2RlcyIpDQpmb3IgeDg2IG9ubHkgUFJFRU1QVCAoZnVsbCkgYW5kIFBSRUVNUFRf
TEFaWSBhcmUgcG9zc2libGUsIGV2ZW4gd2hlbg0KUFJFRU1QVF9EWU5BTUlDIGlzIG9uLg0KDQpj
b25kX3Jlc2NoZWQoKSBpcyB1c2VmdWwgaW4gUFJFRU1QVF9OT05FIGFuZCBQUkVFTVBUX1ZPTFVO
VEFSWSwgYnV0IGl0IGlzDQpiYXNpY2FsbHkgYSBSRVQwIGluIGJvdGggUFJFRU1QVF9MQVpZIGFu
ZCBQUkVFTVBULiAgTXkgdW5kZXJzdGFuZGluZyBpcyB3ZQ0Kc2hvdWxkbid0IGFkZCBhbnkgbW9y
ZSBjb25kX3Jlc2NoZWQoKSBmb3IgeDg2IG5vdyAoc2VlIHRoZSBhZm9yZW1lbnRpb25lZA0KY29t
bWl0IGNoYW5nZWxvZyBmb3IgbW9yZSBpbmZvKS4NCg==
