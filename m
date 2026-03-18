Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BC36A02E;
	Wed, 18 Mar 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818519; cv=fail; b=Uz3+EK4lIGPAPBW7bs/X3qsTNxcbnAjgNTxJwazpSZvoJLkmmVe3f/+MD7syxrb64oauDReDNVSwrPjZwA0Cy6n4lNHCZeU306CN9Hl3Q3aXl+HkaYhAVhtMvXWbIdk7i4ZnMW+hI1NPucts2XgqitAOYv+nrlH1cByT2r8sD74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818519; c=relaxed/simple;
	bh=ogCU1A2zySKTH+80UQh7Vl7fdCidgm9ZWo/woitb4J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsZdv3yp/2wPwoEII1u2TiMeC1Z1v8Dhr2vAx9jpF9ndnOHwBYETyLLTkuVe7R0KjT5tGslnzDbec6/sB7ylPsTxCxHR3oYl0Orx6EY5Q6r7+hn71+6TlAGaR0RLF+0SipzH//3AAPvomY8fjcDA68ANB0q+gWJVRjZOgsbHQzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBZk0sP+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBZk0sP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773818517; x=1805354517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogCU1A2zySKTH+80UQh7Vl7fdCidgm9ZWo/woitb4J0=;
  b=bBZk0sP+lGp9HLyEQ+MbN4Vdr5SovyPuwaLgvz113psUZkZHGnFLyBjL
   3IxKI9UG/3LdlmEj2mH15+SR1/beN/DxuZBPOyqPbpKF1Owg1vv8wp68d
   N5O49spp4uvy7D/1nXHO+IzuPHM4R3UAt1pEAET7Fna+0ksidmBlrrWGC
   wjLUJWvzJWWge/VK8sKc+J7+OLjGLZjYJ1KcuoXi60GVio6lvYXglwj0U
   hx/1R+YpwMBiZmYCvB+7XTJoMRkCGCimKGVkXBs/uaxGIP6eclvX5CrZz
   lE/mEHqL+Awpj/RNvwFdtlsTyKRoq4FAx1lTs3eLKlDWqq+rP9Ua3NjTj
   Q==;
X-CSE-ConnectionGUID: +nNs1d0VSGCh/K3PhNTo4w==
X-CSE-MsgGUID: 6Knpkj15RXu6jtlEyKPs4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78765451"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78765451"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:21:57 -0700
X-CSE-ConnectionGUID: vptYjqxjSwuoyb4ZIgP4jg==
X-CSE-MsgGUID: jBFwcpm3Q2Kb2dDZowrTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226996364"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:21:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:21:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:21:56 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcShm6GAYMVSQ/M1Y+Ky66E34QOo/lN0VB+nJb9CDCKlAqREZXCfTJ67Yi4EQyCW+JrIFHmbtRF6B/kmTdQ+nDqekd8iMRc72iuJJ1fS7sUCw+NAQId/iGdIpLFQSVQ/m7N4I4zL7Z1K5v0Sy+0nS4hX3ycLWJkUs9nP8z4gHc6XseTsYdeOozezKhRTaa8Q/exaGA0O4TvdPHppwQqGKg1Mvo5+ZMGwitVhUOFoEA6bdxARMvG4Pz9+cRhAmOLS8jiY+gbaY30wIQRNd0G3B5pTOi4gzZAx08CawVSGX/vSJ0WVKRjj0omffrEPo6SNtO771d0buGos8vh/NApPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0GClYQYFWulxljbEjy0V/HB/s/weNWYcfoCJ2ZfWF4=;
 b=H5JTkoSl6cfGulrIUWhjUYPSrSmy6EPDg+Dep4DVcsUYpUthnP+nh+s/NWFShn0rSbsWsZxMX3V6qMmvDVSrtUlXhTIv/ylcA7vp5a1PTCW9iE4pIv+ZVuIAc81KrA0s9BY1YtWBiasNK2RoxC0HBDPJPpUVgDeAvXDzCY/nKqTMwLLfusFKKm1BVFYgopcFcHgmVKOI/PqTEX861A2/zNy/gCrw3/9q5YEsXTEN40phXckACZcRIGXHozbT626653JKLIbn53y5EHPZA4kbFOjEd1SCL2gCo5lH0fGkRoJleSlQN+9opVUfNHFUpaLrFdAp3/MPHF3l6ZFwKduSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:21:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:21:54 +0000
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
Subject: RE: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done()
 unless reset succeeds
Thread-Topic: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done()
 unless reset succeeds
Thread-Index: AQHctkKdJwzkvyecIkaSzCIJuG2yd7Wz4lOQ
Date: Wed, 18 Mar 2026 07:21:53 +0000
Message-ID: <BN9PR11MB5276706AE4E0BBE86F0F6E158C4EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
In-Reply-To: <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8145:EE_
x-ms-office365-filtering-correlation-id: 4944b17a-85c7-4c8f-f233-08de84bf07f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: D4MvNI9KdJMQYgKjw3vBlZpQz+m47WvL685l+gRGT3lu3NrPMik8Bg0TxXrimWPtmJmd/0zEdkkMA1E8wbUDFUpiXxNiB+M+2151asCeUk6mTs+3akLVmfOo3UDiqp4lMkykHz9d0S/OcvAqEPLCfBWdYChW2eakIACiDPhWiLbqULurahEevXuxXkzP0sgfVOuKhH3gxuH6sod27SAkX/d6lrz2kcYEUySp6Y4lQgmwreRczjLoPtmAgoR2mcf+JRflLnuOwlIGTORdNEGjpM6rFPAInAaEOGGyvM67UWsYYOv3bgiMCSILfy9F5XQs1+f61U55GIflnh4Cq9ShwuLZKzImcwgLf0z8sJZ9smr3OhXIrVqNYKT9swvD1v5NBuYanFw9KH+7ytasK/ddJ7WdxmKuXwW0FigpzR+f5n7zgNDwUacWzSdiwx7A9MiYNPjrhhUXle0K2sFURxOQzS4KY7Er7HwZFCCmAcuhcPlnSw/NYruaWGLpnDoIGtD1AmEAEwICGFxVn+GhCUvaUShi9zqQfwn/wCXfSjb+PLoxLBwpGttQ6QXUY6pvhldJfWZD2GxwQAxhEMCviT8litGwGFPdcJAaES5XXH3Nk/XuCwRcheW4RYgAJgSYpXpDZHoHt9Cs2WKc9Ujl1Q6tyRX6VqGYdpusR6Kb3ecW3Eim7504lJXPb3UG8JEDKSQ+zVKhmN/DRB+ujv8cuBK0ZVJZJkvIpnwJDDSBctXWKf4fbJ7B5MVtMhv2M8rTqppjRbgqc64GhIeJgemeIK3UG4qUe1CtNJ75eGk+bWgtcPc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HQS39qPufDXvSPTEVVbFwJA4yDm8alnv7Awjpd/FDMqYiqywUKFiOdMYMr7S?=
 =?us-ascii?Q?FAQkjrrrnyn9MoySM/Gmrn758vSOGW5mZyIwZA67L0416zmZ2JU9KdhdozCb?=
 =?us-ascii?Q?6zW8C6jbN6vyJhoP4a4avbBBqjJuGLa/oNYr+yKeQknVSTx14nu2cy0kD8W1?=
 =?us-ascii?Q?e1gmP3P44R0c5tYTXZaRvX5xQKry+3ACiadJF1FNcXvcZnrU+nKVwHhz1itS?=
 =?us-ascii?Q?gJHbc06h5fyhfrh+/L909WQJDK/H+e/Akzg/7dpDTZsyF2qknfriUbQwSrIl?=
 =?us-ascii?Q?kPKFdRU2ybCOO39XP/OUn+X2TXTSy4VGBz/Ajuw68xKeca36Shnv92M5HH7t?=
 =?us-ascii?Q?A840WFRRdJ7TKoLg+Jq1EarUSuR9BteetSquabxZy9v8xo3EfLpVjBfNzZv7?=
 =?us-ascii?Q?nHHF0tVuhEJuPTdrSrnzEPyUbv3mxnGj4Enoo2CX1GSERf0yuwMdr2i38W5e?=
 =?us-ascii?Q?arkM6qaWstM9ubT31Qj8zT7OP9TD5n2YsDqvYx5Lzgso3P1Rhu/V+7saN7IX?=
 =?us-ascii?Q?AlY5+Bqi/lA/cO4Rfa1r2hnLOho/GUnpOd8f/zFJVbOm/pWr/IHHPzDWomdt?=
 =?us-ascii?Q?6X5VNoxNohCN91PsMfOaWRxJiSkHGV1WWgA6teECzJo9vFWPBBqDF6bqZDOu?=
 =?us-ascii?Q?gOf9bNV1ppJnvbg0ftZH3PvXrXB2oewLGGSYHkgxMjktcNj+r5WZ134wH2A0?=
 =?us-ascii?Q?D3xs66h5nuP6cz1NXrOTSRp0iqVsxgBmcZ3kVgElFWjdsDMRnJLLWC76GgCl?=
 =?us-ascii?Q?yeW4Wcmgi7/ypWkcBB/p9s1oW0mgWH9ibFHN/jLd68v/4EtWymhfU4A3Ax5i?=
 =?us-ascii?Q?5kweH6fAiSCvL5YBmi+2NxTd75G/Iu+erpn3DDn/C56BoBIZ2XXDaOfjh4cD?=
 =?us-ascii?Q?LgfONn52ttrDdAlXL5oOCsMvbEvpbLpXzazgm1D38w0vljqRk1WacPRVg4Ba?=
 =?us-ascii?Q?bMbr4Dx1RCbAk33B7Venj2xdHKx2Z0s6Z6hhxtivPim8xB/2ZULCqw0zogi0?=
 =?us-ascii?Q?Y57FeENxjuvb6NEfJAiNviubaTjQhcXZVeQ4Mv/E0xogM8A5t9Z0PXswiHOF?=
 =?us-ascii?Q?FHoravgZs7vOcaziV9pM8CQ4ugyvsmlHkEAmNG576iqFgRXW/7QWKW3IxcwM?=
 =?us-ascii?Q?B5vENt8tVbrYh4fkJ6eKQ3WXYhMOvzOX0WQLCWDdD9IRQaeqzyLkOXkyIAGE?=
 =?us-ascii?Q?WHcXxx/Gpgn6YLOmI1r9Ao8FIbd+i5k3U2IecCr75ncg0m97lG1MG4Ow59Mw?=
 =?us-ascii?Q?be1w20Ju588QY65FS+JbbutdHvfLCUWEgiV6gFzpMQSO8exvVe3RZw5jKlOC?=
 =?us-ascii?Q?f7nfvmNfwzzPuVmJwJizmHJp4LCLvAVyCQl9JrPrXUK0RpJ5A5gVUngmiWzX?=
 =?us-ascii?Q?mAVGm7669eGSRBhpWTQj/QZX2DV3DnNeHHB7WqvGY9+iNqJdUvnlwCrrqdce?=
 =?us-ascii?Q?ORfVtcHQqj9AImtZtBmojEFNQ4rqUj/wl0ZgTMnRjcgwBTf4wvbzWptBRuLD?=
 =?us-ascii?Q?mzG7//n9Y87kBM4x79sqzgwApIkKn8/y56IiZNghkare0/6vKoU4BXHo6/XB?=
 =?us-ascii?Q?dg2zYuKg0wfEMo2CusMdEOWZxzYO6FfVcHuL0aBKYcSSheRuxjiBM+CQ/+wJ?=
 =?us-ascii?Q?r+bGBP1nT5FvEoMh1+JcisBhxyR8t7qa/I0Dvv1UpG3h12bG+fbrXUZyhqAb?=
 =?us-ascii?Q?7ixgU3hutONjUM5iwOB+Th439DZHGMd7K2NHCyf3RPwTl6JTXqt3QKomS5Ai?=
 =?us-ascii?Q?sQ3NQpIb4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z2HnnkN1ZXs09pBcJL3BpgeBbdOgkCz1EDj2EQyNhorysPgxLPHJGAtyzE0RVjbdhkKFSN2dG7g/pyE9T5bcDeKkEXLTxYNk9E3CDpRBwAsBOt3PMqsLlUW1znQWdWhCdKgsRrwh4KV+UROhL418TC4NhPyFDp1OY0O01OhrBmYlw3xXdoEbBa5a6rF7YXXJ570pfhY3EHLhKs2U5kwwk41afxNUKBHHaTzVIAHCGuz2P5/7BDrA+rcOYzHZ7/9BOvMHVgscLrsOuI+Sbex/Dr0Qir/pjvPz+H7e9YaSBdBp+mHyixdL9gwCSPwUsLv03d/BlqXq4SDxa7fIqX4tHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4944b17a-85c7-4c8f-f233-08de84bf07f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:21:53.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj7WCY604celk+ftHhOppmnhZEFLZfEePaFO8cwViz3Qe2t+2j1/MurJ7Kwcl9pT1GgB8QIgIyl8z8EpfVVjCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 18, 2026 3:16 AM
>=20
> @@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool
> probe)
>  		ret =3D -ENOTTY;
>  	}
>=20
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when
> the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!ret || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect
> memory\n");
>  	return ret;

let's pass the reset status to pci_dev_reset_iommu_done() then
put above detail inside.=20
