Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E13876A9;
	Thu,  9 Apr 2026 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721596; cv=fail; b=H7KLMJa1vltEWj9YzzmEWvKy8NPwr0iBiVsjT1why5WemWGMAGPn9uAqcXI1ab/zTjzi6WYyr9e+PxZMdfzjahir0+46i/EAkS63yWPBPkRgNKGhgLze8S0YSq+vpsYdugij+Cijk0GiyX4Le4pLVZ09fY4hRBnD2a0PcOLYRqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721596; c=relaxed/simple;
	bh=ppFVkY+TkA7B+fmeOYEkQWgMnYMwa2I7z6LA2MW45NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ54DHLyMEmkbKzNdtIXp2ONy/tWeE6H6ldWtxpaJboaoiYlE79o/T4lo7KpcM4VrS3aIPCA7HTxdQOf3tgmXS2/F7ydki96Ra0zITKOhUjEGVzMdu364xCj/fmXb/vcwuct6Swf53Q4GUJJ8XNF2fBYY4w9+vGSjCSSxnbpfAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBIp5UwW; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBIp5UwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775721595; x=1807257595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ppFVkY+TkA7B+fmeOYEkQWgMnYMwa2I7z6LA2MW45NY=;
  b=UBIp5UwWOfdxw24erNGS71NC0mwJROW5NBWUPw7i2aKknx3Tpee+JSIA
   O6SAI0jkhtWlQ/QntBrdisXZ4hwP4tMckisk/Aw4Mno7cNuLIM/5LHK7z
   zV0hxc8UNhlPzOyr9h7vOw3se2rPTz6gPxlO0iLT3CyA/2Ho1llmyM+Lx
   HOyNZ4+e9gff75PkT41wRIzRbkyv+l+OEeQBccVfRLjZoGCxSLIx7uhpv
   98+KMyFv7dX4tTARXKALzUqGzrJ4Kx9gsBMZvyzU7hAyQ7+SqcDJ1AjYN
   vz650jLZyChIx/7F5mQBF9dxhRwWHYW95t6+ZRlQgeHQ2Ds3KGYOtPGZc
   Q==;
X-CSE-ConnectionGUID: cfQjCsQ+S6usOQpjpDbquA==
X-CSE-MsgGUID: y37kbCC/REadMj6H8rubWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76607853"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76607853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:59:44 -0700
X-CSE-ConnectionGUID: UHSk45WHS9O32nHaQhNxPg==
X-CSE-MsgGUID: TU7Md5K/R3O7ZX+Jf1jDZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228630230"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:59:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:59:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:59:42 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3jF+rlavhGSAkhsqkI8JiF9mjF9qUBNQqDhyB0BkTLx3lWVdd2tEgLMDhSxVrwq7MR0LiKZMtFa9iOb7lJt1BSsF3dKXk2P8hPInhbxYCCNb+9QHRh/wB2pcCNCOcZMGDrDNl2xeNYpxUOxnIBisHEZIZHxavnv2sVFbXk8hWGDKFTs+yvJSqHrgtRdpcUECVtxs95n5pprvvbnMJhAl5PmrRCHZFDIAACEUKdKgSmIYmt6k8UQ/PTzXZhz1RFNh5NTRl+NnpEdgk8ip/QwLOD6S8SGTgjhHat9/1WevKMbzZLlIKsxQjAiFOa1/4X0if2R+8lt4Waqs/vf7gCfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2UttwItbklSYD+rLZowdFWs5JfC3fH6AyCgdpn4psE=;
 b=O8g3EPW4ggUSqkF84tPNG/rxBAzMfyzDqfi7H7Tp8xU2vUMIZqnlIWpbviGpRZKOFt/tL5Krj3LOGRBBThcO5nplSsFtYuUwmxRQQzsMMVHDXbNqaG7lksTG1wDegopvW4wnfr+a8N4NREh0fXMqpDsTSYftGR8ua4cQaXFmynBsLA0fOon1IlORKHoD/Qdv5dhIajf/76EzJmhkNvf2j2U33Tkua+09m1X4380otiPyJvMYy1RTV/EwJjw9YWR9zOxSGcKqQr2e60wFCJ6bU/dRjfLbM024M6IgP73RxWFHQ1cjVg6kymkPI4dkNFXzNKmKJySlySvHDbHuGR9/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9526.namprd11.prod.outlook.com (2603:10b6:806:4c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.45; Thu, 9 Apr
 2026 07:59:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 07:59:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 25/31] x86/virt/tdx: Add SEAMCALL wrappers for SPDM
 management
Thread-Topic: [PATCH v2 25/31] x86/virt/tdx: Add SEAMCALL wrappers for SPDM
 management
Thread-Index: AQHcvgjqK/341LrALUSfDiFXsSPyT7XWcPqg
Date: Thu, 9 Apr 2026 07:59:33 +0000
Message-ID: <BN9PR11MB5276DE573BCA90782AE5BA608C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-26-yilun.xu@linux.intel.com>
In-Reply-To: <20260327160132.2946114-26-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9526:EE_
x-ms-office365-filtering-correlation-id: 8d4aded8-97cf-401e-c11d-08de960def99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 14ZChkl+ppbxXRkC9K6KHd/s0IoTRZRm9oEvhF2UZ5YKCfmhqeKfsXyUq3P3OasZt7lzDedWVw9tESrXq7HeM4lnBfOuJKeekh6TyB1H3GV2Vswcby9FVrSqr/ktCQW4vsJNED/eNs9gAub0619qxfnu8RTwE0hl1PWx4VaFsPCw+sVjvIhxIqdbdvh3vIBFIqQtfeNeLGz1eB6AjgN8a+PUODJuf+MQmBJUpkC3VUIZ8XCt9zvSy/4trJqrIlVyAtnsMWyjdbjg57up7b7CDHPTOz36k9hqjs4z3T5XJzhuGgEQo8BBfvLqO5IpSTyDsNYAP2FHrmdfmxduv6O0NHc+5m5Vgh8WYpJx3xb6kEW9NfQOwbUx9aXkpGbmExbc7sKbSFddo1b6F8BWDhd2LGmXWwK9+O2YnAwAwQRegO3fU4JJzq1RHuY+WqCiFnzcl0rmGUAd69BA3MtQc/6gIg/AahpjNha5fMZJYET1N7lCMG4dgDzCv6RiadPp9LH9/FjNElVNqJbUQ4fTOMQ1jYgHnR6/8tO2ZqRkSQ7xbfEmCan03IqhUBeTRX3DBofhunr/ZlptpcgmUr6qd+Iy/ETW471OkwSal4R21hfdL44rmKZeauZdEPCyK8pzfwGNQpBDeb4ur2T8HwrDtRBHTPyWOTyN87dV2zGVYaLwarXkquXkSER07sMEjnuRQM1VNua0O8ojLI3Ey86DKTiwYxlXTOSJwn6cN0CTG/tu5dgLiY5V61HVuWUhpCU+czhSF3r7BbzFoH8Ch27evRc86HSm4sxS4lVnqH92Nb17OSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TfwIilyF1wLNRstff7i5xpmLrn4A79zTGICBYdO0AG7pT2+3AbCzf355TpcI?=
 =?us-ascii?Q?y8xdY0Ub3icHAZJStKSaV5ifpZ6c6DqJtHMEXDW8pMiC1iKKLTnPHfOLUXow?=
 =?us-ascii?Q?fRGgfX8l1yfRAL8sVKa0RdJH/Cid4sPAAaagtBkF7dNvP+CXTvytGG8ou1G3?=
 =?us-ascii?Q?ndKqnBmDBao2UxcJ0aOsMZINpTiSMk77RDoNe5ePeX73m4O/zACqh1+hpKTI?=
 =?us-ascii?Q?ACCosaa8H3IpPz1ho7/wsqZdq0bd286l/tStGnH+CTnroBV27SEzA9cbEiaj?=
 =?us-ascii?Q?APDWzPTN3mt+HxbxkqPMfEU4UfnxwEtmxul0xfrKUdVrakFjxVPWB9BDqgG1?=
 =?us-ascii?Q?TSYHCbBZMDWNCo3LwDuaayf6MZhiS3vqvOy365SsZw2OV/F9o9a1KFgSvCNg?=
 =?us-ascii?Q?jxQjTfRREOg84qx4nGaStVOi5VfcL26g5TbBBVk21F4FTVlwcDMM+T7yRXUk?=
 =?us-ascii?Q?6zdTfh0SP2ux0RhRUn9TseeqOFziogItGCSTwfjM+xrRvj1JvNvmS06o2PZO?=
 =?us-ascii?Q?xc10Lci8UrETOy/nNoVwpWjgxbVSliuxCS6lzHxmtfE4929gnWOehJ8Kq4bg?=
 =?us-ascii?Q?Nde51SCRruJcqn0aLS5POJnHv0C1aLahjFIvkxQPXSi5xMFQwAITSPTElXPK?=
 =?us-ascii?Q?9yoq7X3u6opxRjVFYCb72x0SlYPe0rM/8TRDW3HPVy/MIDvthCPHYgg2Q4HA?=
 =?us-ascii?Q?0sCMVTT4yU7TXOd76hLHKO9caogC91Eut2+yCihIHZZVRkAjoh2P5SmLBVpd?=
 =?us-ascii?Q?oHIEUM/nE4+sXRd5ignjRQgfOY+lyu4CdD8lPOq6GWsJd/YcvpsZZxzTqm4D?=
 =?us-ascii?Q?CnX+rWsc6fVzamMjHHQIqI3PfpZRKVUf3ygYnGQR0o7tdWlNyFxxGrnpubvN?=
 =?us-ascii?Q?u7mP2WxuCMqlMkpnoGzpxTN/0fBc2FBaqbFi2VexDBf9OXleZeEnF9k+tLGI?=
 =?us-ascii?Q?mRgdIwKQOegrE9+5M8n0l7U1ccIu1jKa7paXRYswYn/77TkthoXJf5anNIAd?=
 =?us-ascii?Q?w1Dano9AZZlAKizr8cAg+V5U3oCG0a85QjlkJi31d6rLzYMZXraMeNaXMfls?=
 =?us-ascii?Q?G1n5TLX9GEbf9VsI5uI2arQ61QVaGwokernZqxwrVtnzOmqSvVuWrFFpiTdO?=
 =?us-ascii?Q?RMU6y5NaBj/ipv6yB9EoKiSGicoMYsZZGC9OaUwi1vkUyxhwfcm9Z6L/ThmX?=
 =?us-ascii?Q?CFydqLwQnQb+ikHQjnAzX5a/7SnutgnTreMW2PnaMTkY2IZMqCtZMJlU2K6O?=
 =?us-ascii?Q?zvqYVqrqqx6yYl7iXmrLYLOacec1gY85tVjLOPYx5pJcXmcnXGqoVajZfmuX?=
 =?us-ascii?Q?CUmr/6sYBImCUQ7uv0vt7Bf21nOdGqtF4oaTe5p10EYTZHf15sVTY1cfGCQk?=
 =?us-ascii?Q?tcUEe+4zg30dKi5k5JyUteUG+YePrV0Bf9XGSfzPPOS9468WEEB4XKH+yGV0?=
 =?us-ascii?Q?qoRM/n49nRE4D44yA0H96WooyEbHsniDkxX5YkKnvJDxD9/0D/km4HiaJu6H?=
 =?us-ascii?Q?8T0RsY5ImYmM3sQpNLe96J3xXqk4SdCiAHXWb3v/3mZqBbFmpoxu3NBj89RG?=
 =?us-ascii?Q?aLmIIWuVbGgOZ8DeRFjjhC+VjI4qya/02yfQO/yCM/l5bVkmLokeognZyjcu?=
 =?us-ascii?Q?KYno3f7g+p4z8yqJLYKijka+tthoQQPXxUKEI/SzPqMnf4z8YQEXPatkh7C8?=
 =?us-ascii?Q?EvUzvgI/t9yFkKTKQqWz+L7odrEvFMfuETqt9xK80g8FE+NAJMN5bZgamz0s?=
 =?us-ascii?Q?sgsi6GYk6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qM3pkyTJLnp4x5Dm1b4iZInPm5fEacdtlQQcd+P4+tn9D/nADkoxZKNZCNAYhPb0iSpZB1evrJayesWQ10MUpWdk5kQoEL5KNBlnH5KPcC/H7/SSlXutDnsnSdrVE7XphvvD2xuQctLMQlq3ITQTSvJ64vZ6d9IVqfl76JX3uhU5ZIZWAgXf67fpdrEkj4l8uaQ5kzZhj6gcF4HjR7PB/4MuLd4Qv3JHZyw/KNmkFhDJ8O/8vu72I4Mqil3AJIyBBy79NLV1hsc0iYJ05q1oB8L5BxOSsdRcJESdTWAKEiKGhr6A7GP/i2wEGpYMMgLVY0/asrDn6ddCOnAanGEFGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4aded8-97cf-401e-c11d-08de960def99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 07:59:33.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcD5pdyhR59cpfsyvNWVmZLvqU60/OqnkbviJq4QZMMKqqJjFWdtoMaPuriJgzYRE0i9GW5si024FGOzR8fjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9526
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Saturday, March 28, 2026 12:01 AM
>=20

here ...

> - TDH.SPDM.MNG supports three SPDM runtime operations: HEARTBEAT,
>   KEY_UPDATE and DEV_INFO_RECOLLECTION.

... but the actual helper just pass whatever ops to TDX module=20

> +u64 tdh_exec_spdm_mng(u64 spdm_id, u64 spdm_op, struct page
> *spdm_param,
> +		      struct page *spdm_rsp, struct page *spdm_req,
> +		      struct tdx_page_array *spdm_out,
> +		      u64 *spdm_req_or_out_len)
> +{
> +	struct tdx_module_args args =3D {
> +		.rcx =3D spdm_id,
> +		.rdx =3D spdm_op,
> +		.r8 =3D spdm_param ? page_to_phys(spdm_param) : -1,
> +		.r9 =3D page_to_phys(spdm_rsp),
> +		.r10 =3D page_to_phys(spdm_req),
> +		.r11 =3D spdm_out ? hpa_array_t_assign_raw(spdm_out) : -1,
> +	};
> +	u64 r;
> +
> +	r =3D seamcall_ret_ir_exec(TDH_SPDM_MNG, &args);
> +
> +	*spdm_req_or_out_len =3D args.rcx;
> +
> +	return r;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(tdh_exec_spdm_mng, "tdx-host");
