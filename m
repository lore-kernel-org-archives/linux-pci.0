Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793951232;
	b=1NeN6RcLvTxW8YHYcHF0QffjTjyNorszwz++Y2UKQtvdcFRtP/EM/+ifgAWvH8fMv0x/
	 /cx/lbkHVEJB6uYNOS8zOVJ7DvGwoStJ/dgS/c7syRJDXZ9fOLUYjhsJD7j97S0Bu+zeU
	 MVx5bOcBXWB6PbW5kIs0+RC/1Ge2KlpvUW0Eq/jUD2xrQOsl0PZ9dSLp1a0U2GDGJb4P7
	 CBJUVfKAO07G+tNDDnyqCpokeQjmIzat2xJppTyspP9A3+Gso8P2Ennq4/fz+bqPv9tyj
	 4oCbwlxgI1lOXIPPmwzSdio/oq8dRslsCsQijLMthn31b3BjhC8pxZI1/0XkHFQ9oNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951232;
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
	bh=UoWGjYt0NNyKdhbIOxHyJ0tAbllUnCTjroY0QZAIAG0=;
	b=vswpb3dUel4PeK2P0GU7LvrrhKRZUQN/u/j4Hcve7UJSzzZ8EnFI9opQ0R78ibkshfNm
	 2GfN/zJT9N6K9KzisqyUiUYS2ezG5xEmaV5UUOFwp+zIGtaV8N5qflDz02puxiel84Owq
	 iFSpHaHZKDSeJe6E5+2y+AkYlVgAOoC5Qgmtq06mIwp/eumz+WgLLu51pHo4erHF/NpgS
	 X+PB9cmo02mKQvt98F3e+kvp4dv/Huqk5R2ilMMri6sSr7RV4XJCXpM0WBlI88Q7HSMhv
	 M4Xu1zt5mcePFaSOQW7QJHJ0gc+YkcSfMgybI1XT4LW5w4ma2CCPEXu2eY1Yg6pwJ7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OYqdex5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72177606A328;
	Fri,  6 Nov 2026 07:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72177606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OYqdex5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793951232; x=1825487232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cuV8VhoaVm8FQ6k6qVDg6zERPAvb+J6xoRdD1ieyTQ=;
  b=OYqdex5ELFCvyKo8IAIne4G8mrjL+wbfGqzn5mmyMMQMqGp6KGvHh8fh
   Y/dzlNKV0lXBOTjLhuUkGK3SWpTeiLvMYZ8e9vvk9pmLeUR7ywFH3p4M9
   Hgwav9OHsDheTEc0a00iLUt3w+/5NAOdKmeEGZLEEirw7NMdcA09Lg8T9
   VaF+BLJosuBTVGuNLMcfUiw/LE6HP94whrJOZeemp9el29UaMN7PMXvx7
   9/Q3WeaExCDGIqObFHbARTB59UIXb8OigYUSXCdi600QpF55wP8h3fFNP
   qY//dlE0hxpbGeNfF2wo9to6ANJSJsNG9kZcPAFeHI28TDacD7+BELqfK
   Q==;
X-CSE-ConnectionGUID: K0WKHDh4TymgPHxWK4DsWw==
X-CSE-MsgGUID: vFd01veBTM+lQ1wLlP+ptw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2798220"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2798220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:47:11 -0800
X-CSE-ConnectionGUID: cpyatyaMTE+94eZuriSp8w==
X-CSE-MsgGUID: LkDjwUfCRHCqyNXhgwxHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7199581"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:47:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:47:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 23:47:09 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 23:47:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz2lOBOSbo+Ng/JmnFNY1UaPUVZyYg+5usNx+k8OMjON0e38FZrp5ZpYt9N86OYwmq2hIJQjlmox2N5t/AHgE9t2zRO0bhauT6wmblteYDR4/GOQ/hBWtIZjw3ld0icRq5S6pAVvRHrgz76bs39e6M6WU9E+qpW88Q9GIjCkB6gCpWbOWMra3Rs5nNAW89c24MoaozdTay8pOlTFYKA/1Rd5+IdQ6CEfO3GQCyw0nANy3470Xj4gxmwFlEoyvdqdtGlitarInPjzJ6v8ZLheZ17G7v83tZ6/FjaKxYmaI321+HJo7eC9Uye8XHtgczDNTf9ORF4bFOQDhOnkYNVYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoWGjYt0NNyKdhbIOxHyJ0tAbllUnCTjroY0QZAIAG0=;
 b=jafxXtmJIrVynVRgaC/Nczkc1EoXDlNHYqUbbpM6JB2Jsrrt5JCl3aLyqRpLyOmJqEA9pD5fSNpjKOWJEwt4tbp5r9zBfJGGmS9EnBc18o3DeyefX/jsZblifiIFuQanEiONiPpnrOylW9TcNIHwA+IupuqKziO3i/MQo0O2F4r2hxJsHEFqs+lwjvjgIjdum2ykbeJisD7MJgev4FCZVZ5iGeSBicnfRP0u3IlbenTCubsA4jZSAjcyFJCBvvCrH3bp1DdCOGk9ogmsOuZ0va2s/Ogm7B/G8MMl0KeUCsylLBVGOtPcWmJDx2WvFEA77Cm4dBePzH9Dp+EcoiMVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by LV0PR11MB9792.namprd11.prod.outlook.com (2603:10b6:408:385::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 07:47:01 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%7]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 07:47:00 +0000
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
	<linux-tegra@vger.kernel.org>
Subject: RE: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before
 allocation
Thread-Topic: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before
 allocation
Thread-Index: AQHdbHg00jjL35Boy0Gcf9+/NO0e2LcgrCQg
Date: Fri, 6 Nov 2026 07:47:00 +0000
Message-ID: <SA2PR11MB4844544BB238847916EA3A038C762@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-12-aneesh.kumar@kernel.org>
In-Reply-To: <20261104161632.3547423-12-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|LV0PR11MB9792:EE_
x-ms-office365-filtering-correlation-id: 91488e30-b598-4e2b-b7a6-08df3bda2453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|38070700021|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|10063799003|6133799003;
x-microsoft-antispam-message-info: Utluv/Lc/pcI4SkQMqrjeEevBcyzDM4Tglxh/QULbQuuf8pDcajccYB2zJW/SlpzOVo8Dn5WT0B8o1pjkPIk3igGIqK1Fr5KNy/+p0sURfmj/rnU2Fkl4c1P2LDKcMvQRgc+dtxon9QKYdEtb1MLKRDv1eeatsnuatSOq3lZDBqL2CfaH0TvcdvdQ14Z1KS6C6EpYiGlZeddIH0xE518ckaAwChcmz7RQa1Vo0oWFFC+K4cSMvZewTtie2DtzlCpiVXuKFL6NSOxQWg6BbVBhg10cd0x84ds9NX8Vc8/gxpB4OE/AhzXBWpiAf0afU4xudrr6wg73gZhI8WUelSlLqUY0dGmgQGN8qcQ5FhMv1jY6fYCPdIbNiChX8TMtsXTpWBa0VD3b+qPqkSziYlGDmZLTg5iDFzquOgicN+JQbFIpmCeeTgG2oHHbcndqc53i7qXH5G4eGrfZA90iEen6iNVk1IVt79OjeoUCkxAiLX/QA9L7hyCpNGDKoSTt3tWGBxJdRfPo0cothZmA+qP0oOKBo+4gbMlFVMcHZ/HQIQeSdy6bDE6uLzHsWWWiGE1zvfiA/O4CmF+VucPKybJyg2dNjFcZ0+4gYYN88v+fufYYdINdxLu5rbgGktjmCurm5VSXZg48v4ssLjtxG5haJn+lZJJsejqw1Zn82NwPmJdElhTw7VrfpR2IlwQNVR8L9TK8l2jjDSzHA2XVEbIKwxlsmETn/8crkgkL0zhSFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4tSEFpkOM17L10KrIfIFv8T6uF97TeZ4S9TP+2E54PvUe4Zn4v/t4R/6QDsJ?=
 =?us-ascii?Q?VU+Qawin9w2aGOcPi+2nqZt/D76lN2QFWYy5R8CO2FSUoQDOt1+a16vvEyP8?=
 =?us-ascii?Q?fULRTay9+2K69lgqrJpgkfzJ8g6NChJuHcPHEnHkCL0DIOkX6V9vnYOaRN9z?=
 =?us-ascii?Q?IELlvjXTPLzP6L7EYyOErX4Wnyw8htATL7QJ0HWeZDrj2T8gUWHsOAs0+PvF?=
 =?us-ascii?Q?E2Oa6bk5j4XI+KPLoIfACAyk3c6e9DjHJ/LdsU308BO96RPYewxcRJ5CG18s?=
 =?us-ascii?Q?iJqhgxxfpTMTr2cWtH7i4eTlZkAac7UqyCtuXqWsJeZPuiTBKS3wIj+kQveA?=
 =?us-ascii?Q?JAAwEj2SrMaboTMNwxPov6J1TrisAEQ3nZEl5e8EqMfoFEow86yZmz6E3mBT?=
 =?us-ascii?Q?7PYMwuasZcSvSV950sQpljw2yixjnEGUIBpMRTympAposhwaa5u2EPFoW5fg?=
 =?us-ascii?Q?KXntfU1rvvxoqajTdTX11i+hsAfg+04dNfQYxVwbMxlXLcvZQfuMfq4wkaH0?=
 =?us-ascii?Q?YIR/BtaJKiedU/urRk5BZFtXor6z6ElJMtBavFe2kDiWONkuJ34BzS36QqUf?=
 =?us-ascii?Q?WeJKYpiTDHY3IuV30Lfvh9tRVcJd1n6REaJ+HO9GGxLJmghOYC4uihCcr3WB?=
 =?us-ascii?Q?Z+iw2DmskOG0GQH8btmtw5yoSIFuwaAixcZkWTe+p1fenK8fD6bfrxP8RI4V?=
 =?us-ascii?Q?9XDZi4OE9hKMPhoEeGM7xiEsNOAB61NxmG1z/92JXZyK31nk4SN4/PSMY12n?=
 =?us-ascii?Q?iK4iPw+/m+GYZmh33K7GPYPsFnl1DwyaLvE8NMpoU1cSiLqJsM9CU2RYhP4G?=
 =?us-ascii?Q?KrZPi8bEHQHdB7z5Xyft1lNVdHtz2RvYqcHpzdtH17YMO9DjmmPkHu8tfoEe?=
 =?us-ascii?Q?o4TfHpXgicapD0sJZhyga78Lzxq/Vj/0y2grYbYzlziwgfrD+OYa6aj0bMWb?=
 =?us-ascii?Q?hfqJWLXQaQHF1yvXlAiq5fs3oCXuzl1DGMOqOFDo8/iTuYcq0rTgBuZM2ihL?=
 =?us-ascii?Q?KnTM575jK/jxVg5BxJASNTRbs79mV6c2Mud3nXlergl9hS9xmrzhNfze4rzt?=
 =?us-ascii?Q?IxYTm6FGQ4HmcsGYCJoNn2eIqueQMaR6LhGe5oYaVS+utYqFoyV96pMo+81N?=
 =?us-ascii?Q?GONYyCtKEgNTN3CIdFUGqxXG4iAI2AxggwKY+uTKfBUMjWDoV7aUdvwu87HX?=
 =?us-ascii?Q?bZA5DtHKXi0CcHWFMRIvrEZhqn0YlpaIQyRmZlaJmI34NgRrBhFJvfvbTEem?=
 =?us-ascii?Q?12pfXspTuFA5Vyx+1oR4k1tVmkwxwvCmxbU6WNCuUWrjiJ6fMJWeEeZZ1DVy?=
 =?us-ascii?Q?DoKL8A3TfyRGQb85X6QiInEmRote49ZIgPwDr1f4iKzfPrxPBxPdn5TCv+u5?=
 =?us-ascii?Q?1VPL7oPRjd4M7KosfNNrpmh6Zar8PDo+WCVqPQXbalo2mgujCJpbk5w+qpbJ?=
 =?us-ascii?Q?Nno4eahkN3eW0Hxs1jmUbcTqb47KDvO6CN9edYJnAhs/lmx3KOuaFaB10rkC?=
 =?us-ascii?Q?NXVpGUEko9AkP4U1KXWvwGDeo9H5PP6Rwnm3IBMrmEAB7W0i18tBCSV2hJAl?=
 =?us-ascii?Q?1VKrOwZPMCMqzuZzkZM+KIuBfO6CxVUMxxRe5Lv7w/tComadF6Ql3zhAcH7N?=
 =?us-ascii?Q?j6BOU1F7jmq6XiVxxX3Cv9T7nwwjZT4oGWt+vazMWNTBOaYtqHPQDKV/SxSL?=
 =?us-ascii?Q?jNAKk8wavOVc1t//im5vSvvFuDKzIceGqWWvigrkyqUxoib2?=
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
X-Exchange-RoutingPolicyChecked: LBtfeVI2Yx3CGGJBxDLkHKlVrb5LYr9KPB/oklNgAsa838hE9+Z4kCuO2s1UPKpnCw6S3XAeVpKssxwYJXA+vrOji7QVUdfs8FoMIW7o1RfXUDYMytDtS1rRi5nemijwjBJdiTHlaHhbi+BOwencY1pn8O8aFDqYn/CpMcjPHoRjFccatgY0vRjCLJ7A+XPpg9vXvWmLVi0w7kYIt3+Nl0Jw4dNQYGHZXTK8T04SCzr7Z21YVEBKTekj/wH3tWk9wpjAIaU0qMkk83P5oNNOG6se7JHfsKuDiJXDt9s9oavA5hM2At+DNeeAGS1TP+jc0sxniriLUetIUYJJEwd02A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91488e30-b598-4e2b-b7a6-08df3bda2453
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 07:47:00.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbT1gaSA5EBv5mLXsGsLt1hVq8e14LCv9sGCaJ+jhu8pvfIa06rW7w1dmVKH+Rb+wEqgIyELvHMM5zh/dwTIIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9792
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, November 5, 2026 12:16 AM
>=20
> Physical IOMMU drivers currently provide the vIOMMU size and
> initialization callbacks through iommu_ops. The initialization callback
> then selects and installs the corresponding iommufd_viommu_ops.
>=20
> Add iommu_ops::get_viommu_ops() to select the operations from the
> physical device and requested vIOMMU type before allocation. Move the
> size and initialization callbacks into iommufd_viommu_ops. The core can
> then validate the selected operations, allocate the driver structure,
> initialize it, and install the operations.
>=20
> Convert AMD, Arm SMMUv3, Tegra CMDQV, and the selftest backend to the
> new interface.
>=20
> Selecting the operations early allows subsequent changes to use
> implementation-specific vIOMMU properties, including when validating the
> parent HWPT.

what does "implementation-specific" mean? Isn't every existing vIOMMU
type already implementation specific?

>=20
>  /*
>   * This function is assigned to struct
> iommufd_viommu_ops.alloc_domain_nested()
> - * during the call to struct iommu_ops.viommu_init().
> + * when the vIOMMU operations are selected.
>   */
>  struct iommu_domain *
>  amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32
> flags,

the comment sounds changing the semantics.

ideally it's still assigned at viommu_init(), just from iommufd_viommu_ops
instead of iommu_ops now.
