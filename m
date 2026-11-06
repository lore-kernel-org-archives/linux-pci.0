Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949467;
	b=c6MiX1ulbSQD9MBsOLF9mj/ZLQZCc7pg3YR2jO/JkAo7e6rUPDKGLZLK4bGo19tLI7KB
	 dcaw+L+8aWhwhrk/ENKrwcL0EcspwZdu/b3W69hu1CJxRUYWcanopxj5ve8NloQNGGSNb
	 /Px7faLRouQjm0P5eIwrBLVkD12Ji7G5EG2Eghvmguxou+1zvmWUGuy+BrEtz0SMzB0Vt
	 aaYCpFAmtSF7YFfa4uLIC31HizbTgg9av8J9OwIjUDL8s9S3VYt3ALE+h5RUwFLtEf879
	 zt9vk8rIrxDHjkJQDCm54GiONqipsiZRjghQBKg559di22tyS7RQeEEJiGtErogwyVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949467;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ACsVNoLlR3+/MQ6WvbSmoh5iyhRE7pLOg4USzwX5KZI=;
	b=E1cHA8az7kluLTxAUXLNc8zm7yr52rY7o791z7jfFw4H0bvMA+GwZceXqvn1aye04zn1
	 3EohJngFGfgzzf1cldrQNanrMRb+KtzeFxb1EFb/P3njaRiJpY0tdtKeWTCWIPjV8IGWq
	 S7I6Gka2uQyXPIji+zMus7NhMA7OiCwRvnSRFSsKOmRXJfiWpguw3Ix8ZI6BtdHnnJxy/
	 KEgPrzBa7gkSzABxR7dwy30WrlowKpZFxDRdu90FX3b2MBi+2siL8YKPrkLBJWB2wpRS9
	 ksJ5sLfDWBZSsv6lsQRf4UwCGcc5uVY5y85fB9Ya0uxxHGQ6f9pkJMFclZZK9N3TqJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZzHOZ4Pv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BB606A326;
	Fri,  6 Nov 2026 07:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZzHOZ4Pv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793949467; x=1825485467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ACsVNoLlR3+/MQ6WvbSmoh5iyhRE7pLOg4USzwX5KZI=;
  b=ZzHOZ4PvMq1hxICmVOqG6kkMnHKz1S70pujCnzsUjB4BB9rL22/61Ho1
   j47Ii5HGIHivnmjX48SmdNDsZLldg58EthM/Vv00ThjIeGGT2PnnAaBXO
   Gf1AZfgsQ3sTmprF7FlM5B1eDH8NvAF2WiL4AW0ZZmV/gBc4+DUSuyZFJ
   n1SH0ac8oXSLjD4fOdPNReAUL0qtRpgo2GFpyA9929mzMjsMtgx/vx1PW
   8illnAleXCwFCxRfV+rRyLdrduaTCVE2kiD+9CyEhV1gVcI3UfcesQfcc
   8Ek3l0g+ebpJPDocN4ogWE9koANeA2kWN6JLNhovPFAxg5KEeQMCeRi0b
   g==;
X-CSE-ConnectionGUID: +Qn8yERtRHSgnuEb4PxLkA==
X-CSE-MsgGUID: PUlpY6BtR8O3lMDYX4fsGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2672838"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2672838"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:17:46 -0800
X-CSE-ConnectionGUID: izx0KSnYT6mtqeGJOhsL/A==
X-CSE-MsgGUID: qhndFlijRUmLyc87bwGB+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7768779"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:17:46 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:17:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:17:45 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:17:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwWpkKopWomSsn9Yfr/exX4PYCs+vN+gfY2LwjJqts6XIwrV7JYT/ulKRYdXQm0+buZK/iyMeYY7cLGZRquhlP8olZOf5rxHu/O/ujw5b4inzoy98P9jtp9w35UkXuWs8LTz1v8oI7+8GfmYCILvg4YHaZw/CIYXEwaXRFlZg35wquNFEL4mejuc02eHBNw6kF5cR8yPnuMp60EOBvLkFiAlvwziOV3/DcWkBq0TIYQBvTFdfyyOsAtdpLkmcgXMlYPvobV5y4y3VKTrX+9914mc3IkBc3qw3orMfy0MYzReNw2qY/6Zx0A9DbTHSPyX2FAVsZWYW8ajK1bDVOiG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACsVNoLlR3+/MQ6WvbSmoh5iyhRE7pLOg4USzwX5KZI=;
 b=V+JoN25iUeaNyEE7/u2lfe7kBN/2J5iGCXL6yLQuI6/z88BzvlfoDGC+EbdEAPPj/Yh3s5gqKnAXktDvliLIqSulel2sn30Vrfh0jdbk/GDL3bGWpr1MWk+hp4tYL8jgOLfrcQG8w+dJNma/W127gWRco1stx1aD57GWNMAkcgYd5Z09GlvjhEujQ3fX05kRm17B/LwSFfQYJk5KVOeql2jEU1OG4+f5m6YlcWzHDsjAfQQfAbGoYIWp581C16dLPTpDm2KPcgq9OEvcjuHUpJVG2WTQAeyCeyxnC0bVOF6tXEodr8CLDmHbCasPuYmJ7kiy9wX6RCgLkFkAdOJ2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:17:43 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 07:17:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Alex Williamson <alex@shazbot.org>, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron
	<jic23@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy
	<vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Nicolin Chen
	<nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Thierry Reding <thierry.reding@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v8 07/15] iommufd/viommu: Keep a reference to the KVM file
Thread-Topic: [PATCH v8 07/15] iommufd/viommu: Keep a reference to the KVM
 file
Thread-Index: AQHdbHgXFlI83TRk0UaeKnC5EQbCgrcgpMWg
Date: Fri, 6 Nov 2026 07:17:42 +0000
Message-ID: <CO1PR11MB4835B59E82BDBA64417A1C4E8C762@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-8-aneesh.kumar@kernel.org>
In-Reply-To: <20261104161632.3547423-8-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA0PR11MB4669:EE_
x-ms-office365-filtering-correlation-id: b8d9ca9f-9be9-4f36-40a3-08df3bd60c95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261022105027099003|261021135927099003|261021123027099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8qZh5H92EhFO5NWBptZQmRJc78oqoF1w3z1XLyrYmdceGMDx6aAOuqOup/NaiXqGs9cAm8uDdyQVi699GCHbuu6US83PWlzqW84N5GQ6e/NZNUZU7Z8yJ7DAAbYdUBFlYNaklibPgJMwy//BalA1Ri9WJz1VdOoKfibZHjLDnQDsBd6+Qe/rsHN99ziXMF4u5UXA6AHj5fo84cLvayNwuHg4E/Bi7P6G6k1geFTX7Y3egBCTIDDCt1nXXxTyrLu8IRXmhIwaJcngDqOszwsl5FQPTmhbTsNF6GlK4MrRMto8jhNchUBndKOVsfeCUazrhOGlBGe5CheISJq0XUgIGHSEfxeTWqYlKeOZDjF2ROmlIDlK247HoUUNSZAifEGWMjTuYH2OWsIwWF56fVEZquZ2bYrWgTYWDArZ2I3FO/5skOKoMGKikux7DUp26BJhEWMOzB9x5Z1iy9lLkBnu/1X7Q2A4wzToKIsoJkHFE3QVoslZpktt4PEv35UNustiwJLT97g47YqHHmnsg0IROSdJQui1pPV9L6qSkwxWvM+uvgyK44wv6CGSHtPcVfBMwceoCsq9f8BLBSF45DV49hOZmeW4poUgcFrXw07GUx216/4ObWWw4EVRXbHD8BeyhIjnnVhCElAOphq0EusiK6lwsuUODCfBOISztLqI8RTwENA0jf9r7h9PCucych8mY12ddLwguGLTvX6lpd4NHjhufQzQsTR99eXHplvabQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021135927099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WLjKATKr9iDgXB30gACaLWN/OVZkyg4tQpm0st6W4H7bETdjFMFmDGzsMmYO?=
 =?us-ascii?Q?eRsUM0NJ2ZZZ31t8B0Am8kCNiIcBoH51Tzkg6dvjsWOojYLVIC5ER1gU4ypd?=
 =?us-ascii?Q?wpKPTcNNOz64YlilBQ1mlIEfu9OmIFE02RbJ/8pKqjz370s8OO6oPCs9qceC?=
 =?us-ascii?Q?+W7p5xhC0NS/UrHBJPJ/+6zf9SoQ1RA2pbbBZwodO2AKsrRzbmjY7oHJ3ZBo?=
 =?us-ascii?Q?cymmup6zPnRHMlmP7e4RN+VbIeUlbUavXsU0S7BSMXMg3rpGbzuu/37W+CGB?=
 =?us-ascii?Q?Awa+1kSJ65+UwFSKywKXO5cR/2KGkm+gFMnZONw59ZtXqregJa3XC8h03ZMM?=
 =?us-ascii?Q?HFxsdTPgWn1Dyv8Y2RewPRuLCMfzpaiCjN79ZVyXIZJpi7296Lt21EEvQu6x?=
 =?us-ascii?Q?Vv8zLBgJcBZte40b8vHWrJGo7m2q/1CDlaphnK/rUlI1EhUXflWyIqhAAQeD?=
 =?us-ascii?Q?QU69vskoMLKGtj7FVnCE1WWXDXtzj46x5Wi9E/QPlP5o/RXrprutCevdJ569?=
 =?us-ascii?Q?Nrv6W+u82nYtGATSOMRqmzsaHRZ6qgkgjEQ0+OEuw6iduwecyTg2+7mfMSK6?=
 =?us-ascii?Q?LaLLWaCmUTQ9psifwXbw4AFv0kKXAQ84pWggzj779R9BdQHzmwUuJQuuDJpL?=
 =?us-ascii?Q?bKLvTPg+Sl6auiBIKACTkAYKhC+CJHljMy7FUYC+yPe7RKPznB1Qn4EqVH3f?=
 =?us-ascii?Q?0HW/xK3ywJdIb0W7Dq9KpDDfqpsF06+aFpfzsT3x/5oIqoFpbqyB4fSvBjYj?=
 =?us-ascii?Q?02NLgGTsy/Ugb1HC0AnYi6SCoyyJe38KtosuzEKxlOc2YtaJfBlEc2U/Gh+2?=
 =?us-ascii?Q?r7Vy21uC84StrYQ3hdZ11elLzRi1awdEus4jgATqdgmvW/z9VjgmIuZ0PT5w?=
 =?us-ascii?Q?Xsz1ppHTXc9D8Hd0BQVMVKOWC6rJaLKoYHhKVuOHnxYRrc2z/YmAJ8ysXI14?=
 =?us-ascii?Q?Cra59XmJB4mLbea2p6d6q+vSflYProuQB4KhFvVQRUO56eOqqbS+PJUEqOll?=
 =?us-ascii?Q?Z862LBDKg27VzTbWFO9VpeKIToeR7UdCBm0sCUctXjDE5nyToEchM4xQ5ELr?=
 =?us-ascii?Q?QZCnO3oOUFwqj9cmA9J1bzkx4q40YeHucFPaHbbRLvx/LqSLU+RUpYFw1K+m?=
 =?us-ascii?Q?bMt7GbUelUjODzYE+Qp1TZglHe58v7Tkr8csH5DQPYpmNtS2tOiw/S3gcbAx?=
 =?us-ascii?Q?jznqzvTA6weItdX2dPuXNnDqLNPwOh6HH/cB0VPY5dTN9KWdsMkCKddcRV3I?=
 =?us-ascii?Q?SJCPFYvwnwkdhhuQnzf/Aeuhy8qMIcGAYb5CvySrimmB3niYjk1cffuIz4Qe?=
 =?us-ascii?Q?GAnaDuBuvsqgWc1uYDVKFysc3f1uov3i9qq2RtFUCnCnS1MuazYn1vNVTT5a?=
 =?us-ascii?Q?9G6cPDie3Lju/7zj/OtfE44OA8sK6gPNxUOapGnDsv+0+vFe47lZ1Y0YSym0?=
 =?us-ascii?Q?4hSJubZp6SWWCY+BWfmHBVyeJ0yw39AWEPKixckGyWRTVD81BE/XsHiYWY33?=
 =?us-ascii?Q?1xwe+pi/ZfwXpP/NzPeamiMLkXk76Dv/wh/D4uJKovgjPaFqmOruA6xAWJr3?=
 =?us-ascii?Q?g/IIRzL3N8HaIcKWzxKJtpowz+VNCwtiYaMQFQNE64VZ2L2M0KdEhmnhTpKI?=
 =?us-ascii?Q?WUxGNi4t0v0w+rcctBnlY6Er6WHeHiEqRCdG/finGYL9sKFWvJtzkWDCkvpX?=
 =?us-ascii?Q?pfb3k37NkPeKVCLYGASieBGv2LbQmLbITvaWOJVSgqllNe8G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xbE6K2rO9vQW3G74cCWBOUtVj/CDRhpaXhjAGvX7yTDN+E9AzYcs1sjeo6arqGvUyj37TBFium9bBTMryPqGpPeh8s5xiXzpkgwiXGHZPRAloPfd7Kaddiu2tOR6aWzC9rChG3pOjEmkV8BmUyoqxjLxRCy+sbIc3tc7JfR64Vuf2OP8NdiKs6V4TruNG74HuPMTgG1K+1dtfNe3xRjtZ84DOXlIl5+nSE5mJdeX4BPgjx+OVYMLQqWJym2qqXm++8yuZ1vsMjLXvwpELQL8u4gL/jY5BVmBQ2ZThpvyqiQGK9FV+x9zO29fJRh+Rr00OPP2EY5+jxSmozX6907Jxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d9ca9f-9be9-4f36-40a3-08df3bd60c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:17:42.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRqz+OhCKGHpoP0/NVdNxNKnK5ukaEIDJsUasfGsOR/J+21fv+h/pyHH6BTfaz1b0lvze4eyWrq+C0lmVEdbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, November 5, 2026 12:16 AM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when
> the
> vIOMMU is allocated, and take a file reference so it remains valid for th=
e
> lifetime of the vIOMMU.
>=20
> Release the reference when the vIOMMU is destroyed.
>=20
> Reject vdevice allocation when the device's KVM association differs from
> the vIOMMU's, including when only one has a KVM association. Allow
> allocation when both associations are NULL.
>=20
> Based on an original patch by
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>=20
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
