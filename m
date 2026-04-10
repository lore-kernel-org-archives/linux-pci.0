Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C3284B3B;
	Fri, 10 Apr 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796016; cv=fail; b=dw3kUMGCr6TDsvh89+tCrnxIu+B6M9qLtN9KsTvP/FmZofMhTRPNcVervtRA2L+7d9kuxkLbZ250s7D2dJfEao9gwI76k0Mgthn2PBAVBIewM9r28+xMBySE/AHFm9QWgDvPweaSoF8GQ5LcGVn7dFCr1yJfAvXidC5mDdltufA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796016; c=relaxed/simple;
	bh=5KVuA9WSDRysi6mIn/voZCxiY8Vjv7TekzA/djiYI6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RISxNfn1sWSn2g2lTehJJi03UpM5aLjUPJzUfnTas556uEPv5ZIor423JJaA0xMKLlyAjlbMDj57nOtoIXtKaQl3q7OazMClIQLLdZHaHrJivlA5pDoXSUXB/J/kwS2HTQnp1p/CYTrT9z1CeO2P5iWX1Y+ytGjeqL1Ne72IaKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYXN37Hx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYXN37Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775796016; x=1807332016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KVuA9WSDRysi6mIn/voZCxiY8Vjv7TekzA/djiYI6g=;
  b=TYXN37HxvG3th0TdzqmXVy68DfKwqVATZnT4EbyrN5nMr2igRN7hN2t3
   1wjIdCOZ6JhrXmU3a4nKZtAYa3jUoMQkcY5xXu5JVgRLkB2hd/D1ZewLS
   ntzHxnFl7UEk7e1x5BuisnormaRkJrG/scs+30b330TmGf3iQrOS9XjCR
   zmoq48unOY6zFRV77ttkII3hwDufLD4pWdmYypbhgwOUi/icVIM6Wwr6G
   qcL6OKpgTReSXE+qm0SOHHP/WCO6o2R+f7JCWKH/513a3g8lKLGtCJ6Hc
   oiZ8E0KbVdDJzlYgrMiO+JifVDxaPnv+K3vmSGTFtlesFK3xqNvY684vJ
   A==;
X-CSE-ConnectionGUID: IwVts1QSRxup3RZtZrmVSQ==
X-CSE-MsgGUID: qAi3pXijTJyEIORI0IIATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76719517"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76719517"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:40:15 -0700
X-CSE-ConnectionGUID: QakLyckcSO++POReHSnmQA==
X-CSE-MsgGUID: zsJvgMEWQAWom6mvViIcSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="227976095"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:40:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 21:40:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 21:40:13 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 21:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXX6l7f0NItyyJQDcm5richEPEwHw2XtpbB9xDqlv2gz3IOQ1Wtr7r9FasLTwcDZVRfVHCqSwNlzE7Ab4tJFJa4JwtFJXWN9KZBg31CG1FzmjQr8OgbVPa4QOmTCP/g1mnk/mtKJcYgn/1bpRTTRXONvByjeWiF0zsIue64Ibv8/eb9z92TIo2oUC9+jDTM8kaWlvcilaQm2gulyRj2HaRUunulPSCANCVpNNlE+kM4FUaxs274iMF1iU7G67dORKbRn70OVPwRe61pgc02AvjOGriODU3q79qiz4ZF+ysbDtt8ahfJxjFAPSUYKEClQmhuWvCXsA9OGdIQUVwiROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JloAsr6FvFO+kAYc6FfW9ZQZInWNLPgtAqeBpeXzVp8=;
 b=MRG9pxeBsVC8Uu6Mla1V8Pb8RDORx5QnnZ18XyYsTmk3VWSLxG6+V54qriOIwnwqnkMLfgZhiNMb7ELraMABwCZSjDDC+aN7p1YlEvkZ3GHuw8/GryNqKsnwdaibwzBTGUfzXKT+F0zSHoWLSLSSsdbyUI3dy1OJukQBp9D2SytTj4phbI8izIx0XVL2dZ1My45mIjPQ+L1H11iCIIm1YqqiRzjdDzVAYRS8FiBYGLOwRsTsgA4/Lifu/L9wVsANcV7NKVCkfdkcqS6jGAcZCWKAT0bRho+N6wEwi41M5ATA8KPhpkrH2zGYoGgDzjHLwLBUTrscvk7GhbqsSz1gJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 04:40:11 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 04:40:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ankit Agrawal <ankita@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
	"skolothumtho@nvidia.com" <skolothumtho@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHcyCYFHW10aCFGdEmZwDMHoeRi8bXXtgNg
Date: Fri, 10 Apr 2026 04:40:11 +0000
Message-ID: <BL1PR11MB5271507CC920E4F039A350E78C592@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260409133651.92580-1-ankita@nvidia.com>
In-Reply-To: <20260409133651.92580-1-ankita@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH7PR11MB7988:EE_
x-ms-office365-filtering-correlation-id: d8d93201-dde9-4f23-98fe-08de96bb404b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: A8nn22I62pohFcmMOM5/L9hiTCn0F54HgCWOyWdAn5frumqPrCumNOJeVaza/tH4mecT1u1z8lfjNKbkDKBAFfXC/yKYBM5fDBDXJL9MfUTDljuOV5GJ1a6bNB3FQdg0K0CKegoKIlM3h3aIdJcJU32QmJIIYpi/66MKe0oyjoCJUDAa5RRQQNTb/4HgXuyHVNJNnurcntaMNTpF2RZNBSQQVXq6Qn+8kN24pm+8Dbh4oL4SXWyGZ9i4ceJiODhToZACY49iR2RFslKYeZYSTA3C+urVnw5wK7H1dbkTb3hUcDSk8pA9FqKXIk9ghVfg3+oy2/7bEtxDmYuRsrh0N5yM2l9vPbsSix37d1bGQpytZKLyfc4qnae7h9mRlvOFQK2XrSgKY9fwYIroBVIpAFofWqueBTLcotA9xpI1YfXa1CKEAPzMqnmhsqWw2ZjTBifJcqk5hu3VngUtEuaGAa5WGr/8KhGX0vJ9rr0HONAOoqyvZmgAbqvAUP/uo+NFb+yPsh6YlMQb4pCWJ0RlABtWECQnt98+pVsUOJuu6syECWLFNTKiZsxlgvNlA4uRyBiYXS/0YWaKalYqpNUc9F4y/TL+LGWQvLAhiq9LlQhF6+hg6lAilnSZ4tqYSpGT8F9kRnRKbOPnmME/UNCrqq+L2QRsiHYrllwXG8Wt8QY0ebd+2M7Hjklw375lI65MSIZqk5QG43KUDUdlcmK/8+6LN9F/3ZiPvZtWqz+FBvhYDUNqpQZJfeGhcKqgTAqei+BiNQikQONkrXOptUtB1iti2VeQB6p9yF28vHZrk9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oQ0gUOACfQbwTIDmpHLNWDBGoYIzuUDfcGbnktdXCigCvhbtFCA0fT2/pAgQ?=
 =?us-ascii?Q?3aXC/BpnY0N8R7NjVY3E6OlzPAwdcq3WBAo3nJiYVxKJQ0jgP00dVShoSfkD?=
 =?us-ascii?Q?hK+yWyS8Y/TLlW54nRN6G4DKYYcWWaRsjo4x4YmgMHsIsdT9ZJW4D9cYR7GX?=
 =?us-ascii?Q?iWxEdkYxBmYTLbzwPPAC4nQUeYiTCBEGZx2uzhPDW9y/mysHJwwXdK1t998Z?=
 =?us-ascii?Q?CX89o+IvSs98U1OOxLwljSwla3ZDEkLhlPhxttE6qtDKZPHLeGEmbznPKnlw?=
 =?us-ascii?Q?CnoipCuKQLrhaFUz98KOw+lOtpl7ZZat5fxb/ZS2vG+mLZWe4Bg6b2TUyDuh?=
 =?us-ascii?Q?t1lGmxrnRVB4QqY/OXJhSGdu/ys/ir1fxdlhFeMgwu/Lz+0yGJL1Hj81Iogd?=
 =?us-ascii?Q?+BNeqJmN+c7CVhx4hhMuyykN9MnOmgvhzwfI1dYY1d62bziNeiaLQgMMuUwh?=
 =?us-ascii?Q?Bwp2Vm5MZs7ZLKsxr+b8864j5+su21soIWVccP2g3ZkRYWsk4de7AtQkps3d?=
 =?us-ascii?Q?gpax8XQfa+eKTqGj3VSUYxdT1O3DQo7akUQwSIIe4wajEXbXKCUwSu719q6g?=
 =?us-ascii?Q?ya0vhEyhvL9raZ6EJnqUzToXL/TWMdOupBhjxd4+G19OReFgZYduG1KuCMgu?=
 =?us-ascii?Q?kKyLXzxtBPW0Pc0uVdi5oMPgZP7+wlZEIz64mbbC4Iaa9+168EIKJ1vjEEtn?=
 =?us-ascii?Q?+08NmNY99nVHhID5Vs/MkKlSQgCXLxp4UlSS24o8b0RtkZUOX8iG2lm4qH9B?=
 =?us-ascii?Q?rzHvvlQeP1Uct3A/8C++UGxZgyGLnKkM9uRz4/XztE5dXigrdKq8S45NtaTX?=
 =?us-ascii?Q?7tZ02d+IoNkeS9ESUsWJBviKzN3D2izaclK8qHs+BdKzCX0zxakt8nCJBNal?=
 =?us-ascii?Q?n2XFI7i/BBx4B8wnnmZ+6XbP/T6GWEbjbSpnOaqebmkB9hw7D9eJmrnve7Tg?=
 =?us-ascii?Q?2hHKiO1B8zyxLbeX5JrwrLNJW7PbvIAg6YxG6tZCEdeInEr9Pg241nWPr+/h?=
 =?us-ascii?Q?tN2CTMMEl/WLXJ7Olj7yA2C3L/6HLSjeXp8q2nC/qVxQ8mc4ZfQvHcZmgWOv?=
 =?us-ascii?Q?TkLFXY5tjrZLCUhSswULjQj1VCmzujoO+5frF2WGRJvc7julIdlGAMpkDd0t?=
 =?us-ascii?Q?OQR+tb9d6ol4Nvqy6SUsj1XQXUwJzLbLslqTm8khzZlR0YsFk3u1FoBmk1Hi?=
 =?us-ascii?Q?4Xdoxj3dPhQmXxZ7OT3IwG+m6Y2kCYYljDUD9XqJu7XSrHeTkKf9G6BLJAlB?=
 =?us-ascii?Q?TuV3Y7rHKTywXnVcN02x31GbK+55hKbuKx2s0xV2XwPG2UjjFW6q5uicesYo?=
 =?us-ascii?Q?Kkpt6oscaAAFXl1VphYDst57Q0B/2VZ+lB5NlhYm5wKCyjAePGeBgtPAUBM7?=
 =?us-ascii?Q?HudU9cBKBl22ESlklWxB5xvf8f3MijN7oUdhQMd+cYI02aYBbDG44MQ/Yofa?=
 =?us-ascii?Q?chJiffJG8b/GH6XnrMn+7J6++5TNVCNdIRlZfAWQVDFVsKOCp3GT8UkFaFTf?=
 =?us-ascii?Q?4QAGJWXAkhSLZI5kS7fN4q2kqW47GX/FII7IixNFAun2uVyq2pbP3rHUYEX4?=
 =?us-ascii?Q?I5ReFht7C5G/H0T3aMfH0g7zgZxIgVtkNHNtVOkOyg7xZrrdenFmPCSItxOW?=
 =?us-ascii?Q?W6DTeVJ2e0s2Vy6SFglA4XLF58o/yDrqyzr19Jwjbg6p957VWIAZ0P85ZNdX?=
 =?us-ascii?Q?/XTxsfrxuAev3vbZey8meLOh56NnB8qZYYLxSPEAkqrQLoB9nngfnB7BWpfC?=
 =?us-ascii?Q?8CxmFwYPug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TUMYhw1U/6EMEjl6ucZGsaYWq6QZ7Y/geUByBCQDPc9BXT9PriLiz02Q9ixO9o9Whu8BeprVZajRLZq3JvRIqOdfPOdnUbRbhUMkvvSPKONnTCn7BlL2cW9HX+jwHNn7PTNuj5xkcNPoNJUA9xjCvu86NMRHhRbs62X4IMVhJ8p77MOOBtIYzLn4M8BeLxEWo7Oq6uVfPQf+/p9EVRBe3UkP+dTprBfqUOn7BrIbcsYIrWJeUl1pln2EHSebi4J47BW7SHadEvU4wXu5zqBKeigwQuFDr+zlmhYjKeit/HzY3ll4Wl3Hj4MWLlX2obDP696ucj3187uzWsndtVrhyw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d93201-dde9-4f23-98fe-08de96bb404b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 04:40:11.4414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTymxXew7RUL0031hkcO/+lTi6LVvbZZO46QEikq1VNpkS0yneKG/tWFg+suPXCYgokuVBJCaviTJrDVzvL/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com

> From: Ankit Agrawal <ankita@nvidia.com>
> Sent: Thursday, April 9, 2026 9:37 PM
>=20
> +static inline unsigned long nvgrace_gpu_cxl_mem_active_timeout_ms(u8
> timeout)
> +{
> +	return 1000UL << (2 * min_t(u8, timeout, 4));
> +}

this is local to this file and simple. it's ok to remove the 'nvgrace_gpu_'
prefix so the caller line is shorter. Later it may be moved to cxl header
file if other callers exist.

> +
> +static int nvgrace_gpu_wait_device_ready_bw_next(struct
> nvgrace_gpu_pci_core_device *nvdev)

it's a new method in Blackwell-Next, but the mechanism is CXL standard.

call it nvgrace_gpu_wait_device_ready_cxl()?

> +{
> +	struct pci_dev *pdev =3D nvdev->core_device.pdev;
> +	int pcie_dvsec =3D nvdev->cxl_dvsec;

s/pcie_dvsec/cxl_dvsec/

> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct
> nvgrace_gpu_pci_core_device *nvdev)
>  {
> +	struct pci_dev *pdev =3D nvdev->core_device.pdev;
>  	void __iomem *io;
>  	int ret;
>=20
> @@ -1165,7 +1221,7 @@ static int
> nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
>  		goto iomap_exit;
>  	}
>=20
> -	ret =3D nvgrace_gpu_wait_device_ready(io);
> +	ret =3D nvgrace_gpu_wait_device_ready(nvdev, io);
>=20
>  	pci_iounmap(pdev, io);

bar0 mapping is not required in the new method.

