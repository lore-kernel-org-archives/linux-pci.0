Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633E2E717B;
	Thu, 27 Aug 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808925; cv=fail; b=h7LdUqy9a0jRc6UIhrMJm5gpMyYfgOFVRPYY9Nkl4VLkEBgrpMO8fTSWcYlsFfjTyvUTniJZ0O6ink1k0D2Q8DsG+I6O+Xf8HlvlhxPGwJlRmJhUJNuq2jpHf462phgtv+wjuzkIIgUqFMg+HQ5gQU7rFO7CVv0wt2/hkLxaKBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808925; c=relaxed/simple;
	bh=HdMa/ySno9f7Pw/D/h1nlza2i6Ex+iFb5HQUwdX6omA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOcY+JDmvDEIMl/6KJPcZbqNZ9yQcMohGcXKgRjOsbMBKH5GB1jW2RsT5q3lrD2+3ojWLLgDjFwQ1rbGeE936bFdLnz5Kzdd9F6rLrLfUAXQmeavfNs+xFBsVqlxvwszaQNh7dkp5l/1sUhVBPXceZ8+NBiwzfteEMfiureGdnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym7VMOI9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym7VMOI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787808923; x=1819344923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HdMa/ySno9f7Pw/D/h1nlza2i6Ex+iFb5HQUwdX6omA=;
  b=Ym7VMOI9doN/tzBThQK/9kCFzA8EOc+W2Tov/laKck5aD3KBdb9W6/uu
   RNuDq2xq0cnnQe0x65Z0Bq97pLqP3GP27fMd0ErEs11JK6HwDg/+c1GCY
   LMLmIRYpPbHUhsH5Td2k7fKwLYaj8xy8y3ZdHD+a/JXMxyLL7Nmypod6C
   hUMhxbJWpUgFJ731Qxv9FIKXvBuPo8PU9oLGI+flcXk5CVNclTFerQfUx
   ov8/q5RONb5CC1/UF9Un5iSGEuDGvB69m2YGrcLImtdLee4N1x6vYs5R5
   cjox4ufofK94/BRdtY5nnm/EHyvkg1mwWm7Qgpn9ymEjBLN5UVppfn83p
   Q==;
X-CSE-ConnectionGUID: gmhRJaKVQCqC1irI4EQkMw==
X-CSE-MsgGUID: 1Z1v9UPtShWVacCpu54zpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92117949"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="92117949"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 22:35:22 -0700
X-CSE-ConnectionGUID: n0duSjuMRa2HAiANmHZgpg==
X-CSE-MsgGUID: 0gLEJz+JTAqux8B8NMqKtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="263491539"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 22:35:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 22:35:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 22:35:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 22:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5PtcJnyOLX3pP9MliuX2rnn/WH4puXo/GSq8F6O8QrC3ZwpR/SyS9MUqvtk2v+//mMzRNKA8DIBDlX3ijK/mehbDTZmPdtf6G2dCKqg8+snvkAYnShFpfWx6NV7YHmF47ZOeL2OlHSDGderrESznzjGhetueyve37PYg85UHjgVTz9UEwSTsPNevO+fdQ5NgByvGCw3VFe/fv7krB0ZzbL+RmBomdh63Fo19YvV1aBT6Sjueu7hwA86lquUqmlHegiJM4LmbutNZvYl8uDKCu7S5y+1DfCEY25rb1wrmFionoAyaT+bwcyjJnnrRjOqI4XxYYMeZhY8blCoWRNtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKLWTWfsBzJpXvaxhTjKdYmOdWctz4in5QccCKDVwfQ=;
 b=URD9FInKvbHMM9CY7Nb6zBupkMajvFIrl01TqLGjpE7yJIA6efAPt1RfMGrcRsKIgTmIUgyNxi+sRRcTSBwf7j2NTfvh7RBqwwnoaw8sDaT3zesk0WkrlgwX+LMK/aiyHyihQwkqpjqRwaB2D/5PNXSmacVdCxRl0ALNoTdU4IFFqxNG+/qkMOLlxRabdER97Ao+8lbf7L8MvQleBoYzBYN6cK5Rr+kKcvTJfwc/Pi0MF5+NraYcGbVcgKL0AvbFuRwdj+mFxJywGbUcfu2/S2jS6ZZYBkmQ3XZd7BLAi0aeILBc3nWC1ttRYzrw+uDVqEUBYB6enGRYttDOisazhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 27 Aug
 2026 05:35:18 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 05:35:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
CC: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci
	<linux-pci@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Thread-Topic: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Thread-Index: AQHdKhaLIPqzZKXYkk25YA55eR/alLacoQ+AgAD/qoCABJAJAIABKvgQgACEqwCAAG6nAIANIhnw
Date: Thu, 27 Aug 2026 05:35:17 +0000
Message-ID: <CO1PR11MB4835146C50242D76568724DE8CAD2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
	<20260812045325.2733631-2-alex.williamson@nvidia.com>
	<an5JbIzz40svS3xe@google.com>	<20260814083737.66bb83fb@nvidia.com>
	<20260817121810.GC933791@ziepe.ca>
	<CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
	<20260818140304.GC5482@ziepe.ca> <20260818143906.1f58aecb@nvidia.com>
In-Reply-To: <20260818143906.1f58aecb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|MN2PR11MB4584:EE_
x-ms-office365-filtering-correlation-id: 48d6b7cd-be9e-4275-d0cc-08df03fcfa6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|38070700021|6133799003|4143699003|56012099006|18002099003|10067099003|11063799006|22082099003;
x-microsoft-antispam-message-info: 86t0dPYcD7ZwR19hNdtOOoSQQQ9gfa3/71NNkKOmMx2qzM0FUWF5JeIYn1R2vg0ka/CUvpsLiEUuqfndNsLlWPah8Lk8OVT5epZnKakIIrfZzQQgyOooLmnU+x/5wrRXPWGGA10hhb1a1WA/O1kwrhnX1sgxoH5T/xcFc9idMWK0QaM8+WmaTNfiC2tqEnudvUVE6aX658Q65QnoPDZHU7PR+kdMHUNKirlkJ/2QWHtpQjgGrUuE3ogspLhKNPEasZ960JFmdCzR/lfrR7wMdhfWW4lVGoZsalQ6W5Vo5zeQzoy5VuQ1MOqeB+PG2/2Gj9T1UhVNWkF3jn6cTkOJcl72N8gL3Xd3Cqq2KMu1syxVUxJs++a22zXOLzmcDpsEFPCcEX1FpjrQII4yf8DhjQPhg2EQ6rquPZqjAIv3yiBNGNCFxk7Ifo5bokRM2P6KaeV23LUOpEJyUZfKyQJzQ+Nn4SkI3YonWeRXJC1/xyi+VdKqWVNEEYHI2lxyAcg2Us5i/MW1bCzV9YbqYLpW+p00V2mFZS+wuLn0QhTC0wVHV+VcFPV7oYD7TKEEWVLYG2KCJOn5XR7vLBEXEa5PJk1U3lIi0q0hko9sT5Fj36xmcUlu8MIjttLbhXAmfJmagsI/dCOW9kGlkbjc2/ihaucvtvE47R26/M+vzX6I8osDw+Cjo4zoHiL09+8C2TujFJzQ1Ztwc8orAnywaxl6UIyJTJOyWxvDe0pNgdt8Ddo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(4143699003)(56012099006)(18002099003)(10067099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T5L6jgftYzvKFN2PMD2bEOqFqX+TR1fiFUWJ+A1hFMIqJc1gQgGJzzTPeQ64?=
 =?us-ascii?Q?xpHZ23Aco8DJfQ7N9u2EmVlvJ4kDLMmRZgCyiq6qawGCshfYx0ZH95qOWt3k?=
 =?us-ascii?Q?so6lB1I+vzS2i739iws4qeBjJnwBp8tgcC/3mP5s5P07onP4ea0UwbGxFnkJ?=
 =?us-ascii?Q?+ttMJwDAr7N4I9gZrEAV3jNp1Sp6SJSSxHwJto7SezeNxTWsXgyIU7jxK7aM?=
 =?us-ascii?Q?lVxvc7g9dg54BhW8kKh+xPXtIrpdfE079OqVqgO1sHDxopOIWbBUC3Dky16Z?=
 =?us-ascii?Q?0DoYcdLt4Z1q7YZqIlrxKbSRWySlKwVYbTeEpqVvKPF2Z5ZNDJpy10xVI8UF?=
 =?us-ascii?Q?uR+vPI/so8yVqd8qpUgR408PRDrxnELpZkwkwDt1iAGBLx3GmOwRMd2IBNxi?=
 =?us-ascii?Q?MskBrNcRkruf9T6zVmuSveTRwQtXm17aisXHA6+IR0ajiVjgxrP2S+AMAhOi?=
 =?us-ascii?Q?ynRQhyYf3QdJVJA0jBfUkjQg6vzBalGBEU2Q7rlQUTiq6thY2qPmje4gusJS?=
 =?us-ascii?Q?8h+60FfLBaS76uUGDDadTyoeahhoF1x0hiaWOHe2sfdBV+t2rOgTo0Q3u0Gk?=
 =?us-ascii?Q?0ZTvRSAjwnjBQk6vTDlgpTCKT8IzeToyJGvW+6idFYF4VAe4zdRnHvyvWB4e?=
 =?us-ascii?Q?z9guIxoAx/kIEId8DXxmBrhy/rHFC8cufiqBdGuY2Tl/y9tAK0UjRh29bABI?=
 =?us-ascii?Q?uH/KN6spRhdsR8r0RUZ68QZvf8pEF4pu1UX63wRKarTMMzHRKY5AlD0JlJyW?=
 =?us-ascii?Q?E04cH6+pQ9bgKWpkYp94VOwfXWiOiR1cu1S1oLZaSlJX/3KZr632rBf6g1s3?=
 =?us-ascii?Q?CnolL714T18PloEaUO5UP+gi332YrV7O8jIIaQedMeqJjdqUFwBM3RdfZ62T?=
 =?us-ascii?Q?7mG6w5Xm0P/W5VBYw+xYjEKMo72J+/SQVOVa5EiBM4HV3Gghlxcpy9E0K08f?=
 =?us-ascii?Q?pBbBLOevFX2G3Vpw6JqwQ8r4MGkQdOid9MZh50ARaAuEc5wbr8NUZwPmfzTf?=
 =?us-ascii?Q?90OODuZfB6sVNLToPRYS/hZZuJABp6ScnG2+MYKpf25s0i4KlSpikMVNYOfr?=
 =?us-ascii?Q?Sd8uTXRvbjYmVFLR6o1ODfZeluo1NqwrqrHSGcmsOvkdPIZMdAlCjfObSnfL?=
 =?us-ascii?Q?uVfju8iOHAsDfybflKnwzWuYlQrDM34Tvh71nXGDgS31RBwhta7a9VlAkRUj?=
 =?us-ascii?Q?6pgXpBenq1EKbcx9Nj7FwaeZ/gBPShnQFRnC9FcyKvMathmZbe849wABDcUB?=
 =?us-ascii?Q?rPpZt4xvibsHuAOFtT2FdbY3MloW3IhoMcbSdcBM1uy1sOSGLrbIVi7SKRYx?=
 =?us-ascii?Q?HXtcunqB2LC5k7Q/RmLEN4N/Jn/rPfNterbHmnGUY+dmruMqr91bvgdZ7Eva?=
 =?us-ascii?Q?8VLWyteQiQxwT0JXXtgvgIobXKpDDSbIycQAa4KRJCZ2T18V5+/iB4kIKLGi?=
 =?us-ascii?Q?UxWr0C9r8iiq4OKGMXaehL8czIoIS3UdA8bB8ZCSOPw3ckwEjb0bCZXHXTJ2?=
 =?us-ascii?Q?7r0taoTDZ/yO4vSMakGsiKUt26j98MgL/JguGuqsOYxTVPpWzp7uZBrqo1pQ?=
 =?us-ascii?Q?Ma1qXikdFsdFZkxgCBWgK1N/30JStLw0e9Sl7w7TjTdY34RPqtHInd//uBmm?=
 =?us-ascii?Q?55opKWl/lC6a3g6AQkmZ92u8RASNpEsa5MUMaZDmHIUom6/cpbnCpbACk2ty?=
 =?us-ascii?Q?sq6vTqjqFI1fDqsJ1JLoakXjSylc8VLVY5Cp8DDTaKgN9ltY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XNa8VcPmpKt9FHlS4ynhpQ1+VToLk/8JpXQV5utpTZY0o5KejIizlE10lIOyru0C6U2yJqUIBYHGOI6riQD0+nOM+Qj2y0PfzJt8OdZxfCB/Kix5LZo7NH2B/aqsSEY52JgC+BWUVdpPLgmreJqsytR0YED9aMjF4nXTWeq6OMoVPMmssfC+qzpay0JvPHXqkEXL4rGQ8YhKO8gZY8lXu2V5yHoNjQOzNkhJyII516NAs67F3k9C7g224vJMJG/okIVMvnxH0b1yZ+rH6+HOyYxlcyCR3B/YL42NuQ8JVy6suu7PuoBbgfuqz5lk9Phke8vTMy/HeLP0Gs+wyEndRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d6b7cd-be9e-4275-d0cc-08df03fcfa6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 05:35:17.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/TSe5pYkSswcW5ju8BNyuMvT2/S/oTkg/+NgADk58UWWxyEFtbFgrGEMdmi/fKvSsebTBCy+S+BmsRMQX3cyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex.williamson@nvidia.com>
> Sent: Wednesday, August 19, 2026 4:39 AM
>=20
> On Tue, 18 Aug 2026 11:03:04 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> > On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
> > > 3) resetting a PF due to ad-hoc FW error
> > >
> > > e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
> > > reports broken PCI. Sounds a similar condition to AER.
> > >
> > > but as it calls pci_reset_function() this series causes a regression
> > > in case of active VFs. Is it desired?
> >
> > mlx5 does something similar. RAS flows require detecting the PF has
> > blown up and resetting it to bring it back.
> >
> > This has to work while VFs exist and bound to kernel drivers or vfio.
> >
> > In the VFIO KVM case I would expect the VM to experiance a RAS error
> > on its vPCI device and trigger a VF flr
>=20
> This would need to be a device level RAS flow as we're sorely lacking
> on forwarding reset notification to VF drivers or providing any
> mechanism for recovery from the vfio error eventfd.
>=20
> > But we have to sort all this out through the hypervisor to not crash
> > the machine or otherwise :)
>=20
> In general guarding the high level pci_reset_function() family on
> (pci_num_vfs() =3D=3D 0) seems to have more pros than cons and the
> restriction matches the scoped intent of the interface.
>=20
> The low level __pci_reset_function_locked() interface remains
> untouched, and as the prefix implies, relies on the caller to do
> necessary verification and preparation.  A "reset the PF regardless of
> VFs" seems like an underscore prefix sort of operation.  We'll need to
> export the pci_dev_save_and_disable() and pci_dev_restore() functions
> to provide handlers the full suite of tools they need to replace the
> existing function and port those we find (maybe also questioning the
> author's intent on VF reset and recovery).
>=20
> Of course making the guard parameterized with wrappers to expand this
> family of calls is also an option,
> pci_reset_function_locked_with_vfs()...

+1 for wrappers. Maybe call it pci_force_reset_function_locked() which
is slightly forward-looking if in future other conditions may reject the
reset request using the base function.

>=20
> The mlx5 driver doesn't actually seem to be affected by these changes,
> doing its own link toggle or a PCI bus reset, not a
> pci_reset_function() call.
>=20
> On the other improvements, triggering a pci_reset_function_locked() on
> unbind after SR-IOV is disabled, when needs_reset is indicated, looks
> pretty trivial.
>=20
> The blocking domain operation looks like it might be simplest to
> implement in the IOMMU core.  We can set a flag for a default blocking
> domain on the IOMMU group when we take_dma_ownership of the group.
> Then
> release_dma_ownership picks the blocking rather than default domain.

IMHO we should change release_dma_ownership() to always picks the
blocking. No new flag.

this take/release interfaces are invented for drivers which manage dma
on their own, so it sounds reasonable to not assume the operated device
is in a good shape after the ownership is released.

Then only a clean reset can unwind it.

>=20
> This is then unwound in use_default_domain, called via dma_configure,
> attaching the device to the default domain in probe of the next driver.
> Therefore until probe by another driver, a device used by vfio would
> remain in a blocking domain even while unused and unbound.
>=20

so unwinding it blindly at dma_configure time is also problematic, as the
device may still have a bad state to hurt the kernel.

Instead use_default_domain should fail in such case (in blocked with
owner_cnt being '0') then a reset is expected to unwind it (Nicolin's
work will carry the resetting status to pci_dev_reset_iommu_done())

Once we follow Jason's suggestion to do reset on vfio unbind, user vfio
experience is intact across binding/unbinding drivers.

Then when a 2nd driver claiming dma comes but it forgets to do reset
on unbind, only manual reset can unblock the device to bind to a new
driver.
