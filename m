Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9F1A5B8A;
	Fri, 10 Apr 2026 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795601; cv=fail; b=REHB52vn1EpHCf7GjXbfrGwd51HZuHCbTWt679YmvxGT8wUSp43lT+AxqF570UkovxI5qvo9QtaaW1iPtAZ+tyzIP+Mgc5cawOHLKNFhrDdk2TQNZIbUONshchrGdiE67X9cpPPZ2jcd8DjoxT6Jr74ZKlfIeHVAVW09pijY/0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795601; c=relaxed/simple;
	bh=O041K6Uds06DPii+qhLXKjjBCSJI/CYNxoFRrFUuCGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDQPwX5Hl9HYke85eKAIzRFD6Fka7IF0EYxFbGAVjSmWtNJZTJEBwkmolgC2AzwGz+z4a/FO0qClBwyGI5W/cCgXlc0RGLvupPF6bQTW73ShFaW+Gq/FFaZZUxWeMl4hGaXIK1VFhnxSOhRqj2i9nXz7xpZgf2FL7WVSmOOJ/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEIweGfQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEIweGfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775795600; x=1807331600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O041K6Uds06DPii+qhLXKjjBCSJI/CYNxoFRrFUuCGo=;
  b=nEIweGfQtTBhnwGta3M5T/Il5bE6ouaAqLjUJCWXkgJFkMNMtxSftAkr
   ih4kEb675ol8UurjIooewSK7MixaP691Mwzl61W1nx5fJgLMXv4ivHHYD
   vdYyYOwQsy+GUzzPzVJbAQ7uHPvgYfSWDHkotDCr89SCwGfx1fbUwazT7
   KsNKW47eGVtTB55w2lo2Nm9XyxFTY29SahJ59mbSZ9UvtEudUkhxZvcJZ
   TXsq4XUylQAqVUkyzED6180vofuwAV5Pvm7NVD4KtGvcs3hpfmomcMa1p
   aIjjyY1+oqnSB3P7alATbq9+c0iUmkMeF3h1c9ShzAHWHeUgff1rBhxjp
   g==;
X-CSE-ConnectionGUID: glEVr1lrS7WnR2iroaOiig==
X-CSE-MsgGUID: Ar5dBpqXQtKRmxoVZvDoTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76689551"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76689551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:33:20 -0700
X-CSE-ConnectionGUID: KkDVfdIHTdmp4DV2trQAMw==
X-CSE-MsgGUID: Z/Z+Pv50QBaElOtx7SwD6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="259448139"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:33:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 21:33:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 21:33:18 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 21:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWaMc3s8Vh6OyzcnolRZ7YdFLf+1v+2pRlTOFO4IIIPqgVVCCyNkMFljo6fRKRfC57KcZTnKHU4EBaYCi7/mcU/yo6LTf2q2lb+sDqsTIC57WifSs27g5+3EZvAnrP29bRfFB9YfpXMZBKl3AaDWYQAS+KzMBHWVOPt7vWz8LE3KumnMPTYRRTW1r1vnDx1153RgNON6pW5Z2a1+0KyXYQEtHFZCa0eqa5f0S4QLWxNIilxpx8fFMxhEJp/CacUxU4cuNzvaY0wl4tLqeUIixFHvPNrF0KFL7QumLbMGNYPVrfSsX1YpfnkSUJxXolrnhjO+fvSOxiOtLBoR6jz8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgvfSptZMAcJfNU8UT5Bq6RQIsQSt0C+K6XDzAnzQx0=;
 b=ks24MzWPEz1YTTQOLRvQJdrBDKbp5h5ZSQVwjZPFNY6dZP0oLP3cCT7ydlP3uYZ5K9D8rUmKci1XUMRh+1wdA5El4KXjYI0sQO3Xf8NFPquxAzkUJOORf0ZJZaVWZuZIDoVFjtXRIfCh1tQfiYgFKqLwhSUWKN7rcb0zmDcXAgEFWXMRnfl+muYoCUyJJaIOj0g0bmWKRzYR6bjw7b7rHgGUn1UZ1YqV8cXrEJybKxr7jXqJNGzVlaOO/ooDceixassHn54ck+Kyn88VY+daN6GOGHOu9zAxuRDejwA3oqQMvNNzJO2DPmj0cnv6mSu9OjsT+faaUSXYZk1aXDJ1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH7PR11MB7988.namprd11.prod.outlook.com (2603:10b6:510:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 04:33:15 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 04:33:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
	"skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHcyCYFHW10aCFGdEmZwDMHoeRi8bXXDbKAgACnwOA=
Date: Fri, 10 Apr 2026 04:33:14 +0000
Message-ID: <BL1PR11MB52712F8C8D1DC4FCB88C0D188C592@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260409133651.92580-1-ankita@nvidia.com>
 <20260409123053.55c407fd@shazbot.org>
In-Reply-To: <20260409123053.55c407fd@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH7PR11MB7988:EE_
x-ms-office365-filtering-correlation-id: 99f1e918-990d-4bac-9a41-08de96ba47ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 3PljqReqw9xlHPZuWAYIxnzGGAYGEyPzayLZecfD5UigTG0aTwLG1hjp7QN6eWwbdZyYOWFzpA65V1IuDF2iK9ylSQjYjQTVc1V+7ydqFAWnaXLD+cJHz4yq4A0Pv+2xWckpF0hZeMYoKntLCcdYWM61ZTTfXxth1GW2fsXAkLN2E0bu8jK/v+/o5Nvu9Pozh/c5SuyGunOMOpoG/R/qPp6mgCblvehOkGi2yxhnF4uPpy7Bc4Ge3C3jU80ttfPIZs8rBeLZ3L9awMnrQPsoDfTvODeGRbjsMYYNa0fkBFIKFqPBDGiwhzCx8fQm4WiCBJM+Q4vzY3P1M5DtvZMJ8II5VGwrDJQ9opzVksEI/95tI9Eo7FyTqrr/Eeq7KsQbvudY6oFIRWLvWH1a+kJyqPKJwQcXGlc65zu+1ynUzoCG9MZ6RBVHKgtQ45vR+XAyFdjsk49BsrECKfA7NHnaMeuzrNs0+Rjtg6XQtEna2SNGNIm7d6QJpOfNa4xgftFuoi0ld4fAmAwJFK7NPJrTS77CSLvOmYkICqicsnnKAqtkhjPmFAUj1eaW3g8/R2zrPR38d6uJijIkduqIiqXf/Jv8iQ6Bw77BobQgF0go2k8ttvJnh7Zg4aVVgHCAE3sxmQEVF6+R/VaX7Zdo7HcymTPuHzxX3n1/4xIgSKCMFjCXl80NjoqgLrd/S/WLfqI9vk+fREPi/F8yvf7X2nCMd7NAYUOmVkViXJ8HEEKsEuv65YAZaEmdyGnQzOryjMQfqvPN5qeU+QRuVF+Y3FPi8AIATNZtF+gdPSUUcMtvRaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CM3b//+35QTAAt25ivXRmiBa+CtFv2DIth78dPbRHcOlRN2MJbgq3w3qKbLi?=
 =?us-ascii?Q?23kXUrpN65efNzmFxp0oiymG1TrAmFLw9w9pf7KoQxxu28gCLPFoJ4UIQGtB?=
 =?us-ascii?Q?4Miub6L4ajvi08iwb2E7Yf9J7TbJRq9bvCI/QjympgbjKJP9QSDXiYQAdg4J?=
 =?us-ascii?Q?oDHXBxAxyU6Uv23jcYUQNweNzYTj1tLZp5EI/e7H3ci3SFBqcqvroVJn98dG?=
 =?us-ascii?Q?Hw1RZ3BDOkeEjmAy+qLVmLX6qNKB4KaWyI+CUvyk1Gv1KgA5Qxaw1JGxy8ov?=
 =?us-ascii?Q?Z3OY6a1H/g24QJ3KdCVig5CDfYaQdDY/NgIr2pvspFzhwNNRfSOTPIqbNrrt?=
 =?us-ascii?Q?dgsMsFQ01k2A3MXxwl+VzMCLjiKiRzpUOpI0mP0NOUcetF/MyTe3Ztnl0u1K?=
 =?us-ascii?Q?HmCb/4jCYOgz2pFd6fzBBvyF+NaXzt1f6TXjUBN//27JRsU+w26FRqwysywF?=
 =?us-ascii?Q?yE5luka1+7BwSVFYlomCkrP3fZhdlzaDCiv/vQF2e3FM2OKqOovGXupgkTNU?=
 =?us-ascii?Q?ilkM3oojcDlWbfghLdSapKydmknnBhjayY/xsCyLDW051De3+qDcTzprb8pN?=
 =?us-ascii?Q?OiDvgf8MZDvxsNN62KyrRzCUK/5LxzLoWpURg6LVtL4Clrlj2uOeb2+wXWBk?=
 =?us-ascii?Q?52RXgV3IQQeX+CGtz1Y+KC7BjCdtN7UUhAtm2qPVG7yFGhXcIBoqpimmIKw9?=
 =?us-ascii?Q?GUzyix9IDC6ulUZYoy9mYI3Bsx+h5XMySW+tLl37/1tZ0As6YdBvlF4FAU+r?=
 =?us-ascii?Q?l1kM1hD2EZzHrZcMEKrRy3IZfjWlYyz0c8iquodaQYL8WoDEXpZrvViQVFdX?=
 =?us-ascii?Q?vDR1bNqL4hQovJHFyRFpWsAp/GuzZ/Qnqk1uWLLtEkGPfkDk58lmCmVy7KJK?=
 =?us-ascii?Q?z2UEOYhROVaVOd1UoaCjjmvxSzHs9KZ1YOxLsQwZKygQIqU9g7DAW+/5ycob?=
 =?us-ascii?Q?9JbR8NRkS39cGYAOkQwfx6T7M2N00unxmMom6Q/qF1Cv8HivC7vTG0Uvr6pq?=
 =?us-ascii?Q?ZOo/H1F69btQIbpU121XnZ70joxlp4MVQEoAU7UTqF1FaIM8FOMjQeIZCNk+?=
 =?us-ascii?Q?iTuXgas+gxzeYVlB41PGNDkbEBp08XcKcs8rWipaV6/hHs1d6bKk3cUto0N5?=
 =?us-ascii?Q?j/dTZjToEB39H8Y6NO33TO2JSd75+YtyZJ8UA6t1Uow+61YMiRvQBjPGp5hW?=
 =?us-ascii?Q?x7N3thHjEFegyKunUUN3TWIR1sU9zRZyylftoI+ypICMokX3B6pfoAfGJiT5?=
 =?us-ascii?Q?Dy8c7+suOvmRakAOowAejlVlFsKXVEzP4mTZtRizyW94N0luTPKrh3sqRlT4?=
 =?us-ascii?Q?89IcbE1CcFjgnZ39L+C527WStF1WiubFx4QfFxR1Sfr0rE5vtpYFLi1SvdUx?=
 =?us-ascii?Q?44gVJrWovaVJOMicgWPZeydiUJYm/8Ugr4/dGMLAQ19p04W2nIMg/oEtUkxc?=
 =?us-ascii?Q?xfSw/oj6NSp6FScBxZmuhiF4oDTC6jWD3IwkRAln1gm7kZSiHw+dy+KauVf+?=
 =?us-ascii?Q?xWWs6JACON15P7zxeGXlPMx98MqAR30oOU2D7Dn5onPamEiiPjH+kmA0EeU+?=
 =?us-ascii?Q?5JFDDpLDAp/dDGvy5KeKaf3m3oVpi5ZIIEt8XinyrsVAQ9GHwi/Z8kECQS94?=
 =?us-ascii?Q?onYfDA/56IbwVVR3yxYy5rRXxE4zqEUysMun9CDRqdPdoNmk04lObnt3DdYv?=
 =?us-ascii?Q?oFkjuMaDb/FAhvKGfFCBnyrVwSbeAovVpiXpg86lyyWKOqvrm1r9JHzipFNi?=
 =?us-ascii?Q?15nmVx9CQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: btKKcvyMrQqn7Zog0XLRTTh3cnsXqLeiPjQDFsiVKyz10jRcI9uh+j1lXFOMibHI6Hj2BupFCGj4vaYdFGeEVh+eZGVuFc2k6By2suO2mkwJzmdPBWKnTE5VOLUwMMFODy1xveC8Nm4t/AnUhNpYnDzUBDQ8aHuvklXxepb709rq2wC5zndY8LhgpgXTsDv4GXw5/GEX0CL1lRZZ1MncJicre1SpbPTDmh/cnN6iOR4uT75CimzwHOnB0o8y0QxyZkGRuIfnPCCONffxLEOr7fWTXzbEzEO3M3w9HeNe9IS7+VznTkqyXqAF2mxzAn5rbsKnlvSmN5HWkQIvynG7og==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f1e918-990d-4bac-9a41-08de96ba47ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 04:33:14.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pH7UGmfLFpnaPUDg1+2pgDZ5EuZtjmnkQ5mPHgFF2B0FkKrzvixV81LwhQBstswfDwKeL1hKqtu7JUWrgWZ0Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7988
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, April 10, 2026 2:31 AM
>=20
> On Thu, 9 Apr 2026 13:36:51 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
> > +
> > +	do {
> > +		pci_read_config_dword(pdev,
> > +				      pcie_dvsec +
> PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> > +				      &dvsec_memory_status);
> > +
> > +		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_ACTIVE)
> > +			return 0;
>=20
> Do we need to monitor PCI_DVSEC_CXL_MEM_INFO_VALID in the loop too?
>=20

is that bit static or dynamic? If static, better to check it one-off in
probe instead of doing it in every wait.
