Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60272285404;
	Wed, 18 Mar 2026 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819603; cv=fail; b=R29Te/sg0ZF0MhhcZxElGBr7ZP3MfUNsSuq5GeqFa0vT33Tvjpa9qTmjvjIy5how/Bf2jb8bGo7KaCY15++YB62rQErxKADTEmEJTjKo3jYLyAUFu9yInRiZ/m8Y3DRtl4RYFPgJ/mZMKH6dB4YJDSlGauuuw1JWZRbnI0pF77A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819603; c=relaxed/simple;
	bh=XgYHOxySvFwlzuDe4gzBtNCIZjgZGPA5jOObKYQvOsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iyv6vVsFZ/6jWoIvhXsBcrPf4qX3cJLEFfC4q5PAW/r9X12xVnBFIHtvAmJfQ03ZS8st25CptwTdgTOvDN/BzeI6WVhnZMXDLunirwf47QkzSv32CQgWLGRxyx/kuqRQUzGGkZJfloxlRxRj635Vn3R3lqVyvjTc8fPRBjWuIXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQdV5xpy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQdV5xpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773819601; x=1805355601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XgYHOxySvFwlzuDe4gzBtNCIZjgZGPA5jOObKYQvOsA=;
  b=fQdV5xpyQobxrK+F+3jpmL5/KtSeboElF3RnSHcEvK64d9YJGt56Mrp+
   ncjRPgrPivKrpDwCG3siU4BaMchUnGFMJcbO83QrByemlKWKx6pZVAf4E
   cIshwIMjHbzWFQ8uIGgPE4q7pB+5xc5I2idqPw/EK4ClX5tcxN4ISajvz
   BfjzM7WsMjq7w6wnrQb6UMyrKHtN21eGBhUYm1UZCNbS4Wtc2qVcM4q0v
   /RlUQl256JDa4W93odjIyuAMkRxH1zavD/DuF67XSAbrZoobLkJMip1kT
   hEtwobsu2w0ev4vXO49wDR03Le52LeQmFElQ6IJQjUp32Xw0IqsNOLYcP
   Q==;
X-CSE-ConnectionGUID: tM1B/WbiRVyShDvz2UezDQ==
X-CSE-MsgGUID: x3kJunFWRxqvARQirkBthA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85182176"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85182176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:40:00 -0700
X-CSE-ConnectionGUID: 3WwLGgVJR7mR/+5/UyMT/A==
X-CSE-MsgGUID: U24tmz7IR6OZKskmlhwlRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="218142139"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:39:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:39:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:39:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjuGp5XFXweb9iFYMx31w6qr8BukncXZ6iyvj3Vx9LEinNcN8rDt85v+N/OLDMKnE92MjoID2UeTH7E4OVZ/hwiXx9OR6tnXQfok0NFadAvtvDF3LL8GVtTzjGjnQiZ0vrZ8wjvk1ZVlIypiPbeC9loQSAApf5hAR7zWnLPo0i0HtnTwPmV86+8ntOPoAspEZOfTfhh7A9Tg44uY9dw3b1OGfCSxs5tq2XLyQp4ihBlCuhKv5qyypRCPqRzkKXlvBfyltt8WGLKKdu0TjkcJiWc/Y/BnvlNoybrWen/iHzw+2BgZrsIhVnQYZcjknCcsjKO82Nwc4N5KvsLcONszeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n9R2h6KPU4x3UtllZewaXLUtQt0S4hDWIUsxi2Gls0=;
 b=RyrwKb2d9ooMFcx1Yh/Sd98rq+cL1iA+fE/ebFEoCk2KQqNiQw9FpLDEvzLO82TuxP+g/48Yx9by8hLEqFWKnb0SAFl0A0xC0VLN6zRY6IZ9E/gL+JqEUw/+uamg0lHdniqvbU1P3pr2BCqET50FXHwUNSI1dNpxRCT7lwfmgk0YRW+EKhEUD1n/EDuKdpSZLuGYl09uEXRaBfgUcgw9vf7WdUx1bP8nQMiuT5uCUW4Q2QemXlx9A+Z3c0d4ZlxRpulzM8BdiT3WtjbEHbXJC7e159z1M6dfx1ezm8wZXZXJC57ZNteWxESUIBT7dcZakAGe1tXDHi0eHGCM56Of9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:39:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:39:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: RE: [PATCH v2 6/7] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Thread-Topic: [PATCH v2 6/7] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Thread-Index: AQHctkKcbgumzo/JV0KxK979OTNNZrWz561Q
Date: Wed, 18 Mar 2026 07:39:53 +0000
Message-ID: <BN9PR11MB5276CAF65238D9818D3D8BC78C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <c101108ad1e52824dbadb5d35a534584be28824b.1773774441.git.nicolinc@nvidia.com>
In-Reply-To: <c101108ad1e52824dbadb5d35a534584be28824b.1773774441.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7567:EE_
x-ms-office365-filtering-correlation-id: 9aa7453b-41bf-483b-a79b-08de84c18b66
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: n8vE8vdNX5WfGNYeA1XXf68rW7LUej3xKuAIRkN7+V+lF8g3U4JUwKV/8wiT9PoCqneGtsKb9XyGWPPzV4gkuuRva87N1gDzjddFORkeZRVuVmk/2VVZUUaGaLpKN5AWxfYLlEoCn1rV1oR2sCa5AKVc18nVpGtwtkIPJ1SSD1DNFH0M9NDQSrY85j1RX92zLN2A6OSHfXHjSqaNjeHf4ATOFm6CsuYrHxxzfLE9iGzsjAKmM6s3I9KNlaoNO2b0/N1rF7xk8RYTwcpY+rVA1QSFidJGsnkBwQOVixSVB/+wX4bdJHtXWirAjnNS0sQnCp4lMD9WX+fSypFmec3Mp0un1k+2wkaaWfdG20lGE9pQ8gq5UPKQFZ+NZPP4dcmyXcSfE27xQYFAC8VuI+3gRqld4OxzA0P0eGzuzWFREM3f1NagTordR2AscF6fFliUcTe6WGopMKssTLBIM4HP9sjpKQy6cW9S/VDFoEjVJxsxGCAkzcyZqw066WnDUXsa7jF9YXUJc+1wt3uAVLTqigdtMnABeJjh3WO/yDW2WJrkAMlaMO41m1J8CldnmoZLpaPGlEQ8MCPooSFsGwTHK3pjSOUK0Z1KJmBKZpBBaWzFOMV8JCQOBmkyLxwNbkB6zFHazrqsn7owXevoLC33fkKHyCkVAFtmzMsAxVycbsP+Ia4UqEcjMsMgv58Cqo9U3coNlc0HS8sMvhAv3cUrnrP+M9UFDBYmo58UxYKL6pSdj0mK1k5LN30qd0Uh/QrhQZaWVdIX2/YtZaWkXQUOtr19+K7n+5YkGZRhqLSHvDQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PPNxswzSNrIVv+/sXoTBWeddGiAJzvjZft1zxG1t0B//7LtOU8gxMnfw7g27?=
 =?us-ascii?Q?Sp9VF6vFBIVfGvPITQZKZ5H403LTNRMQ1tGs5lTOUoIfbFzY+bmK8Ctw13en?=
 =?us-ascii?Q?e4QkA4q2OaPhIXOXSimIdRmHXAHuL6jwlY5Sgde5JeiK+BTod5bLwE4fY6H0?=
 =?us-ascii?Q?J2kUhtz68i4dhhHm1qtFuggiLtuouUlR/4Tz9tsCdjQ3gYEQ0yHgbwx8uf0F?=
 =?us-ascii?Q?UCQ20s95BlaomopmmbeJT7im2gnk2hf/8r8/T0nprBokERWgZ+DQlavXbaX/?=
 =?us-ascii?Q?o4BNDlqcvHbC0wMvK+YoPUoOLBauTkOgeP7oEMfirrW+jr2EBDZx2q69aiuv?=
 =?us-ascii?Q?6UBCrUisb557xKDDK2dsT2LGnTW680cVF5TkTYe0UoRYc8L68L9OEQF3iU8n?=
 =?us-ascii?Q?NIGFDASES6ETcsKieAiJnUmGVqvo+qfySbOgEWq9wPO/mm8zgykhgsjRQ2/S?=
 =?us-ascii?Q?6P72nGYeUMWT4SvBvlZdltcOxU4aSTo3agSZjRmtyiizU9iO48IQvxoNNlPP?=
 =?us-ascii?Q?UoDe6qEmJKqu3oUzukrCt2R1pRR2Xx7AwIQL+dSRdYShUVyhOC7ttm/0fJ9+?=
 =?us-ascii?Q?7NGjrmaJRPAAgXIVpBJsXcVe1WgVbXVNHVMP/Ylg9cs5Z8S1ZWFAGbmIDKLk?=
 =?us-ascii?Q?NuMnkObUHUSdFeX9KXge/5XyuJYfd7V1mTow+WJfPfw4N5N+fH51fbFaBfPB?=
 =?us-ascii?Q?wn6XSKigmZjALiQeND5MMVGnBfr/a7iMflr5HkkU0OxKIEIRE5yY6mxxrAMD?=
 =?us-ascii?Q?0kCZkIdQrCFQG2xMmQMW1RUELaVlD77J76VwPaQeo3k92wwJNcKFxIoBtLSI?=
 =?us-ascii?Q?WQwiw71BJodbRWWXWDX4Sbqb+VxzufGKyP8MgbuqNA4cAOaCY2bjb0JSTxqM?=
 =?us-ascii?Q?dA/AwacTo+mpvUjq1w9rOSmHGg4gIOUmNEFW7v59muoDAWmcQgVYnLfq/T4e?=
 =?us-ascii?Q?Ge7G0Y8jjfx4WPUlk2zvaNmcPVeIrIXERPV7gDfyWuDuWGgoIG6YkMVkpAan?=
 =?us-ascii?Q?ulDZPmeJigJblh5U2g9BKfDwn7xJ7Stz1TkUpXVSxEF2ABmmYU/XbkrQ0IvP?=
 =?us-ascii?Q?Ywx+u7rXfqQTBAKFovRRA8RqAZzw0+oJRR6ILsijmkzV9X8KlywrmJ28qJhX?=
 =?us-ascii?Q?Vv/QznLhpSjH47hjLW2qpY86ZEXr6lny5AHPJcOPz3CnzoTsD5e/HFUMl6vA?=
 =?us-ascii?Q?u6DflCB0sicXO3WY2mX6uhzaPqPjFhuGNyoICpzBbbJJ4P+PzZnEEdokHJ5N?=
 =?us-ascii?Q?wS3B9GTs2/Rag8PFT2b9/tMjUwKMOLjGHgxx2jsiMoLLvhbW9k4I9aN6xaU7?=
 =?us-ascii?Q?ASG3+kywZHGKiTKy13QAjNOCD13cJjeiwJ8+mqoIBx4VIIigEvL4lZlryfGV?=
 =?us-ascii?Q?9Ic+t8gbh/bD1RB55tRC1GmjXvThmP0TqBKFYrjXU9Ty120JkRg2q85XuE2f?=
 =?us-ascii?Q?+ttAqKlRelEK/5o3rYS/j5zPiCGIXuyWStL+GCOsEP/EKtsRjLNt5dGv0aAM?=
 =?us-ascii?Q?CjIQIjdMDIN2O0yVZzbovh19TEBUk9bnOigJxhaHMmAfC7NETQMTFiX7NxuD?=
 =?us-ascii?Q?81K8TosoOteP8pLdXqfAlGO0ROMr4G4mOiI0QB8J803fVGujX1OQhs3hA/hb?=
 =?us-ascii?Q?mIDKEKAvAMqhC4b0iIxlE8uI6LLhuE6W0+sqWSj1+gJPa1SyW4QqaXHmYvZf?=
 =?us-ascii?Q?nzUI0SlgtvN0LElloAG07mxiPO7r7sY4iahP881Gne5t9o16EEu6YNjztUga?=
 =?us-ascii?Q?bObfNjzBuw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bQ+sIBOAfCs4o43w2moVnlWg8Sd5CNsHQwliyHrSAtIyZt0lUQ8qNQd3av4RG0L1R//eC88Yjtow2x8P247HyCVHHhWPN6C3JAEnk/b1xrYNPFv0Y9ExwY3HTImTbbP3p/ynaH/kkr3hv8xQ5VCDh5jz3/cSMVVDauzeOz8Y0UISRVMMmI0FAypUxKYtNZOY+y6s0NnbdRpXnBzcFfWwboYGv5xd+9n78Zqxb8j/tiMuj4r/UZfx1l6Zia/L7kqNNoATdzLPFMcE30/cJrZ0CgtzUbQg+n1Rju27hmfVP3Shdog0lcfGweTHR0658r6M/ms7cCV5vEsxl+M4cLxtYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa7453b-41bf-483b-a79b-08de84c18b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:39:53.5097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBjRZOh38oyOAUbkAoTfKHoT1kXHGQISsv8Y+g5S5g9T1U2ECdB3SBn4pmroRvY24w8g9cWaPhZA/Y4bEXIhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 18, 2026 3:16 AM
>=20
> @@ -3060,6 +3079,14 @@ static bool arm_smmu_ats_supported(struct
> arm_smmu_master *master)
>  	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
>  		return false;
>=20
> +	/*
> +	 * Reject any new ATS request because ATC invalidation was timed
> out.
> +	 * The PCI device should go through a recovery (reset) and notify the
> +	 * SMMUv3 driver via a reset_device_done callback.
> +	 */
> +	if (READ_ONCE(master->ats_broken))
> +		return false;
> +

"Reject any new ATS request" means any new request to enable ATS
on this device, instead of rejecting any new ATS translation request,
correct? next patch does the actual work to block ATS...
