Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A914346A10;
	Fri, 17 Apr 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410166; cv=fail; b=fBxrnK8jTRzv4Pw4bnz0lpwfLlLlWV3EBErL0ufdw3YsKU9Lle7UObzgrQ86cl5O19hAxFHgncgQSNYb2PRHckW1DB3OWeqtmHZptWrSXYsfhtGsq3cYfz3X1k96IubpqVym376PUgO2tamQmINRiwW1RPsyrU/+LuJsi+383mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410166; c=relaxed/simple;
	bh=X4ga7xgZ5enWpd0MR/kuj1IBnmLJi/JU5geAjb9mkUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PdX97kl0z0nvSJSOiYDKc9waIReD07PfGnTWVX0S+e7Pwx+KKmOsHMRQCeJ11UTvxrhyp4ju/s0cJhFeWYHlQg1LVcYjqhiWF7u72GuMal3DhpUGfPZpsw7y+kBml5rU1VhfAiLJMgbtXOdVnMzg9mHVzanggJJiUGGlwLr9rt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeiDjVin; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeiDjVin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776410166; x=1807946166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X4ga7xgZ5enWpd0MR/kuj1IBnmLJi/JU5geAjb9mkUk=;
  b=BeiDjVin6w1+Ljw+94Hb14YcDGk5YF07fswRxr2dSjIoskfdhLbGrAer
   RB2MH5T8y1RJggCLqqu7DlLVbYZlQCLqTpRktW9qBCj94yi8iGqr4UUVw
   Lt181xXZpKGTSzth3u8CRDK72bAMquun5O3vkziaPPwZ8yP5s+4soCG6I
   QkzuBuXlnDEj4aMnOmfgaLuFy8Uv3l5AB0nFZI57Rwkw6rh1u0MkqFOM4
   4kzZlcHE5V1P0kzpTasU+JpLJhZyhsm0W41JW1gKID++G1dgv0rzD2jw+
   amFbM4ZR/NZhroz1ja+4VJyuI8LtarMU0bdDqNh4J+Ps3ngK3E+dMY+yT
   Q==;
X-CSE-ConnectionGUID: Vhqgzzp1SC+myUuSqLusbw==
X-CSE-MsgGUID: 8LFNke54Siq7P+iZEW4YlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94825447"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94825447"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:16:06 -0700
X-CSE-ConnectionGUID: o84kJJEBSC6sMskjYZ2fzA==
X-CSE-MsgGUID: 6oOUKSwYRuulELU/qWIEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235339243"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:16:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 00:16:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 00:16:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 00:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1l2ojCsrc2B6mJxar8ZC4fVGg4a9n4XLCCA9TmCj5tncD/9UrvX16SqFl7NAUXeyGbhXXP/Br6QwDGOfUCoN3VdT7kSV+DWtYwWN+GyeCbaN3pPAF9LJdD1x19ctMjq6ghGRJnxNDuKt56eg4S0iZRybXjzG9XMD8K/PJOSlAdJgWsAvx85iAfYvs7SGaiprcm3xxljWUs1fiRJeZuw9yCfWWH7ZYUPN5zBHLu/kmTrwChrgAmUKnl8V96PIVvn36OmkCiUB/oAPEwofcAlhkiyLy2zbuH8gM2CX/n5JnhZOHEAfzLdT9t4a0/DeG/5v4s6eDYvSLn4w7hJmw2DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KINzr1kygS3BzGFWICuVeQGZk9/ibknn55Vd211vVis=;
 b=dWkSd5Eg5vxPKm5Wy9zcPRDwYJ25ktkoPUcETL0JCkd2P0/P+4vu6F5fp/LFYr8NtPbKcttn2Bvuhenb3DwYSSGMmZ3VXagDgHSVBzLDfZibhs7Aiacf01pOu74htzSVbDybGnp5qGwq1SX+V/YQ+mwwSTbWeOxx3GLXXcKuLCDbAGvE0zNEqvhC39s8Bi6g6IS5K6O//sV8E2XAlTeilek6/FcRZYV4IR7buAA6/QXz7Sj/78ZAf7l0KeQ7sU2DS87HfcG922kzT19W0gkSqYLAiF2vk8oMij9RbV/olmaY4GMFiDS9VSz9ugf2zUR8tz6eL5KYeV0XuteHz4j7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DSSPR11MB9665.namprd11.prod.outlook.com (2603:10b6:8:377::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:16:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:16:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ankit Agrawal <ankita@nvidia.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "yishaih@nvidia.com" <yishaih@nvidia.com>,
	"skolothumtho@nvidia.com" <skolothumtho@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v3 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHczULBRDpxt6EPl0SQXWXMF888C7Xi2NBQ
Date: Fri, 17 Apr 2026 07:16:02 +0000
Message-ID: <BN9PR11MB5276004A82F75505C81EF94D8C202@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260416014504.63067-1-ankita@nvidia.com>
In-Reply-To: <20260416014504.63067-1-ankita@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DSSPR11MB9665:EE_
x-ms-office365-filtering-correlation-id: e9bba4c4-a821-4ff6-40ba-08de9c512ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: mlJRGEJqG1uqO0siMLd+twpvFqvL/rhO5jS6RBo/7eQvO5V78jQLRASabwgS/WupFkVWgFm0rW+jW7JY8RHr3MOiOlSL2F153/EJY4MEAyGDfx8eJEJO48eB786Apjz8KbZtvE/v+73jSPxfzV7d44jZh9Gvyz3csvPe2rLkMHlsZj36TvCiCQ62gTmOkvf3SjJUhR61T1W/zwcWCENGKxvx2sEUe9IxHvA28c+24W/Ue+i4hAkfHMlRuEcRtHEzlNLW8Im6nrw80P9Ls8lJxbCfCb82QYYbbP+/Jd3+jvd6JBchkiZ3xqKfWVpLGpjDz7aTMKwxiB70L8OajgPvSbfU7c1fERjyiNK1/vTsoMjegeXYt0S64m+JEWYAe9kPFiN8SgiKo4XyRgWlA9IV/jGaphoUYFDIZS3ALu6LP9bppjkaeXwiYhFTS2/8YQnOkth7V9XydpJABgPYkoE2r/00RiV0ABDygMv7exlAl1DOt5QJ1+SWxPQ60IRABPzuzIsuvi6YeLU4JjJTwHJbsHs9lB75mvgnWxEBmlPE3lq/KacD6m02okCRMpki/Q0M0IZ45vzgEpa3AHaush/x4TRCg28FSEMeJYJNvqtwwe0WmV/pss2zyVOK6QVxMBQ5duyNdvvzBlpa/SMENY2fytxjS2EZ8s+rpWPonJ/iOnM4KyICU//N+r4CWKR599kwUUtHDrmTre7LFLD65D+Mzqrku6fNLCyh/8WM3Xs33p8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81h6woBPnmHgneonBcO4fLGL5i3/fFRO6E6kCW3E6Kkx/1z14X4bpHoQDfYd?=
 =?us-ascii?Q?X7TY4PKkZ/PisEIvQ+AtfEY+QDhBL2+DLVy6CW4+/wM1KzoBtA0GM326cejr?=
 =?us-ascii?Q?81uSbsflCyxqHNo6MtppyuMq5/2H/qCxcl1cRSujHL9zFmvg5ebNK9CbYiUp?=
 =?us-ascii?Q?Do6Vbpj7gRN5bn4KNYUaRsTRyAtweoykBLMY17QXeSaiLJz01XaYFe+w4hJe?=
 =?us-ascii?Q?3Z6NxIhozbN8aOcpTH0V6lB3ahJ329RPCqlXkNe+r4+U7h0tsnCogbLpPQ4j?=
 =?us-ascii?Q?gSRVduu4xtTUWMTtE/Mdbj28vBLv2pSLweQnWavhOhmdLDHml1+bg9OhTl7L?=
 =?us-ascii?Q?J+mUVhzxeIgXoU2YnEfBDbzWpdWqAe/Ba/F1914IEHMGWJf3T7tp48v9hjp3?=
 =?us-ascii?Q?d9ZkpyyMld58V6oaymFG8BtABedEDnvCpA170pRvcyoVbd7soX6mO7Y9g84B?=
 =?us-ascii?Q?dEKgDAY48o+oSwIuLhj5ftDfbKNEHnFbKEBYVg5VCCDLOc4rwt80HHG9RteW?=
 =?us-ascii?Q?dPClH3BPRC/G7IZ95ruo8FZw/ZWKZPHqB9Px6gkttSIoXDBEDzD+vl97Tl79?=
 =?us-ascii?Q?sI/k4/JlEmXVBWOFQklg7T1qyD3lh/BYCTfinOrAToePDr1PJAip3AoHKHiE?=
 =?us-ascii?Q?3zGNFpNaSDrp0l/zJSmzYZE2OAdTLtsTpBnt74d/A4GxSRAQc3Q0/ZsLIVvM?=
 =?us-ascii?Q?7QLsj6CI0lijXy2OiSPPcMoVwmQalZGy2R/MQke5FIdc+hyDX6XAt4N50mwI?=
 =?us-ascii?Q?8B11MQNVyaUCiAg1V76+R9b1hyXBefngseTJ0176Oqz20EF9umjeyTQgSaeg?=
 =?us-ascii?Q?iOmVS7bqjG5IYlFFdCOJ9dhyl/ajYDPj175NHFDpUt7cc2FCTHB1Pj1BGvjE?=
 =?us-ascii?Q?bJJqzGjsqbORxpss6SjRgHjcsu1+xJWJgFTG0l6+joE+l0uCE0QaVkaD+j/P?=
 =?us-ascii?Q?V/T3XAsi7iD72bfrzTrIoqKAh8iqYZtOtKSNrWgnUSwBldJ07y49o9Fu9W48?=
 =?us-ascii?Q?4hcdrotF0Pax4hFAHr1czBJHdXMJAp/dNGIsiw9i0x+ad4sXoX6ZwTFqqE1/?=
 =?us-ascii?Q?2rMw7T9dkgkR5cxad69NVNXjRoyqcB2iFMiz8WwI+7gNRdFTjWqSdKUjfo8z?=
 =?us-ascii?Q?UxsWM9jE496fDSbnzu+zlSnANyNXGZ4+zIRFAjR19W8/KE1SnJ1SMhpnVdx3?=
 =?us-ascii?Q?Sl0DuHO04E/Bw/3xe9l+CvXNfnLxLFpdpd3wYEfZqrtSdqZxmT74Mab/1XL5?=
 =?us-ascii?Q?Gb8v+bUxZzrx195zCtxf0HtumhJB2W5/KspCEpoZRLqHiEzjA6gkXgtNPfk8?=
 =?us-ascii?Q?ZTUttzm4nhZk3SPaaZslQBRH3aLk4TkEcCvk0KcsP9hc4eGgLEgi2WGD4u0e?=
 =?us-ascii?Q?mFcf/NbcF6OB9eSugybgF59Q1CpkfbVAv6RySuZu62Rp8VWrq6djINULZYGm?=
 =?us-ascii?Q?dVQaJCS1AjKD37t/vje95wlM8nuwgQHgHq3fLTWfTPD8MPZZursYfd0Z21wn?=
 =?us-ascii?Q?BMMdTgt9mUYrjfW0tm4L1qdnUXNZBPY9lrnp4paax+SX+mFH+CJNsljNoli4?=
 =?us-ascii?Q?bmGCsXy3b8572MTTsQDTFnX/D9MwtabpKHSRGFV4nfBYWNCndLLtW8VSjjKk?=
 =?us-ascii?Q?yNawWR43GPk00MGOcdENIZr8DAXipBpDZ1dV0eYgi3mhP8+Zi447pXVpBfns?=
 =?us-ascii?Q?7aonlzc332dCOV2nHrZIuJxfoqf+4ZubSowZ75b66BFz4dXq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QH4tLbfE00Mp1/Fh0knUW372Hjr4KMDRWaZ/xYvxKq530Xc87hdJQIx9ISRpkEZ4GRm/psNdHEfyEBC1UYGNNTtKw7evn77Px0amAkc+jEjEudr4gqc/eigdJgIUoHy52X59j1WJ405TcXAiC0crx9s80hG5dLQofB8IF/k6ase/V67C+ZUziFlmkO6l+84p3VciCzdBCAUASXy9Exsvw7SNgFlDN/1CXnKWry9KnU9sFwCE9+bvSY00RA3JALkgZKZy0h7LxY9g4QXDvhB05/VPSiPPqaNGSM7AJmnxIl/dOnniP0Cnpjjrb5Dx7nU8CDwg0sOQA3mMZ5nPPv9CyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bba4c4-a821-4ff6-40ba-08de9c512ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 07:16:02.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtscV1X9+h9+qDGVe4MfYilMmpvXGrVpvK8pJtcZ5w2E/yEioLgp+dFBHj8ygaJb6Kg5os0d2U1O3Ya/OP2M8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9665
X-OriginatorOrg: intel.com

> From: Ankit Agrawal <ankita@nvidia.com>
> Sent: Thursday, April 16, 2026 9:45 AM
>=20
> +
> +static int nvgrace_gpu_wait_device_ready_cxl(struct
> nvgrace_gpu_pci_core_device *nvdev)
> +{
> +	struct pci_dev *pdev =3D nvdev->core_device.pdev;
> +	int cxl_dvsec =3D nvdev->cxl_dvsec;
> +	unsigned long mem_info_valid_deadline;
> +	unsigned long timeout;
> +	u32 dvsec_memory_status;
> +	u8 mem_active_timeout;
> +
> +	pci_read_config_dword(pdev, cxl_dvsec +
> PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +			      &dvsec_memory_status);
> +
> +	if (cxl_dvsec_mem_is_active(dvsec_memory_status))
> +		return 0;
> +
> +	mem_active_timeout =3D
> FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
> +				       dvsec_memory_status);

Sashiko pointed out that " the Memory_Active_Timeout field is
only valid when the Memory_Info_Valid bit is set ". If it's true
then blindly reading it here is incorrect.

https://sashiko.dev/#/patchset/20260416014504.63067-1-ankita%40nvidia.com

> @@ -1146,11 +1218,16 @@ static bool
> nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
>   * Ensure that the BAR0 region is enabled before accessing the
>   * registers.
>   */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct
> nvgrace_gpu_pci_core_device *nvdev)

the comment above should be updated too.
