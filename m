Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AE2D7D47;
	Fri, 29 May 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054079; cv=fail; b=sYvQvrFhxi5LGQEmJKpgHb48guSenkkum0F4ZPdCC1n6JH3LicLU250nZTfP2WgW4ze/0BQ8qn8heWCNV3o1vTcWxq0577N5mD8D1HH4PY7qWmt9w1+MXGxt+zlGb6ZF4xBW4nO08lSOHIu/nrpy6PjE18I+9r1XEvzynCQL70g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054079; c=relaxed/simple;
	bh=9FA/V/aTqYhrrN1sKJt+vjHKV/v2YPDuuHvoWn2PVZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gqwb9w2JRdybdvDOUP00SY4jN9DNAlgVnsU1SVchCH3IsAAer9zz2P1jZiT9x0kicXGzhicC/Mx8FPO4T0oNguZw4qR16BdgC86eC/5CdM8ltWRc+E9ChUtgsyYUNoANgQ0W85lMNalZC6/kamUJ3iJofscjIPqHJdg2UmPeEH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tufcHpEO; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tufcHpEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWDCJgoVsCktJgkVaHUY41YOsaLHi9jDEbPiR1FSzB3vE/3Gcg9/RHhm31IWKFusA5TEccJd7o6Fp3WNtMJFmlMd+gtj8gM69RoQXzl65MNXQEpUiUTeTA49lFp/2fMi/IHhTecokY9FNgE8zl9xPlrQBoDTs7JV8CEqciCBOanpr8ucPE3azKGMgJE+YGDR6YKmQqDGCmkkw+yk/5cbVbzvLwUL1b3P4OhL1Kd0Uqm+hSlWnr27XH7ZKOaBPe1Ey/fXzxdzjIxzuFbMNOqMn6RGDe8y7OECxGgX9kgr3x5JXXUzurBeZq3RzySCIUQU9hxeVfAscpIyjsBusg7FcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLAAqvY7oFn/E4vWpiTaKzdModijem+IxaIgZJyhPIQ=;
 b=aS1RSpFZ7BTEz/K/lkcp9+yBu9KGOL8tFfyozsCkia/RuZS3RrflaMFa5LpExGHdnmaQWwDEbApe+cME/n3VwuBzboqhMxveq73Rypi9xw4qGBg8brEU0c2lx7mG/sWM0Mg7mPpN/5D0MBNOc0eXjbVTSVY4uZqZAQMDOrxZvb4U5Ncsk4sdE6F26zTXm5pX34rJD6bf1HL4d/xfWoXK3RuF/VN6fVkjsql55Zd+1Y38ON89p8yQZR87r9NWoSXEqz3MRtKfGHZI4U+gQuRSKz071/U2ozT5+7vle/OAHtDoYnrXda6bJioju3HTV1JHUCWMznG2vS42IEHvRTeXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLAAqvY7oFn/E4vWpiTaKzdModijem+IxaIgZJyhPIQ=;
 b=tufcHpEOcsjIp1gfDuvCBEiNep73JFRiGjOQ/UO6DAzTSGSbhn6KIR2mACjNO1L+gHIf7fOyJL10s1zdzjRTKMrb+E1nXkn2Ntn01rQd1kX8hSnklFSd8tbyuMbduTRJyDLd2QoGRqw2TGYNWBMDvoQScbEM+2Sud1uNwJM71P2rXjgnEcotPfPJPN/tfMBhr/4We+V+zvoY+U7kZMxY/WpPiipwWHRhdKFeOb5z8YhOWh3S0V9TQcKD/xXvYYj5InBGRfaKUWBw8urN79FeXY7TiDaeMgrCOz+Ct5ccoUQ/Rygvn2msEc4QcmWBVK7+0R/w+O6cxtD+WS9WgZR5Iw==
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 (2603:10b6:806:4e7::18) by IA0PR12MB9046.namprd12.prod.outlook.com
 (2603:10b6:208:405::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 11:27:50 +0000
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f]) by SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f%6]) with mapi id 15.20.9913.009; Fri, 29 May 2026
 11:27:50 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc7oXOqXIInn0s1UCYCZsiDdl347YjuX+AgAEkWeQ=
Date: Fri, 29 May 2026 11:27:49 +0000
Message-ID:
 <SAVPR12MB999121B9C79011BC27A6FAA089B0162@SAVPR12MB999121.namprd12.prod.outlook.com>
References: <20260528093840.4018-1-ankita@nvidia.com>
 <20260528115613.63f1b178@shazbot.org>
In-Reply-To: <20260528115613.63f1b178@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAVPR12MB999121:EE_|IA0PR12MB9046:EE_
x-ms-office365-filtering-correlation-id: cd61ff61-6f84-4566-079a-08debd7550f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|38070700021|56012099006|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info:
 aPZR57Ug1YLyR2FZ9HqMNcaRm+NKgWyCT7MRtq394DCg8hbgBrRA3eLleWOnEIVbevIKVwlXirzznlpWCZh3dCmaU+sCMT+waGyEYTHEAcZl1q6sORxbYHi0EMGO8+3qzFJcZ7+H5iiXtpbuyjSyHgRavkleAJDQyCGd1Jv+VUQzxBjj79sCsZPSSjfpSXvcPTkClAwVBZU+lYm810hU5imRd9M1dn6Pn3BYDT1djPP1LLN19i32cjZ9hL6jYQZDJmCpeihOcXLmyjk+cAudATA/ZIDtY5edyhvYCBRcczW+cwuWapWqmdaiAGAUfIWfy7QEHJ5jwv8PPWHlgXwCosYhJosD1kXsEDH3pzcCiHxrNQbX86euQPX+z5vvR6z1CaZKG4d0q8Y6mg25k3qFeNd3t2RshQJsqKhtOWPV0hRuEMZrv/23yXjhdD99Y5UNinsutndY4CLdwcXcp4MR/wQtroZlU6FRN94NQ/giFBbpHEEM1KipLeQ9am9C+BubcIglX5cp9Y/naPyoST0wuSTWChuUQ0Vsja2IeiLtbPC7bc0qWr+TwRNbmG1sWrvVLqR6o9Nv/hgewooHaPc5VJEQSqWYALqQ4TRh8cNB2w/9z5dn0Xd4HLD3fSbBTKlhuTY5jzUhOtS8K9cQMpUxsKjLUqXlcB40lX2Nw/YKi0rXz/EL1QOKOW1GgX+N8I274lLa6QGw3wWnL83BxZETbEzQbAlW3zfqLSNzh65a5bFco6Sk5nmoodWmElCm8VzJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAVPR12MB999121.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(56012099006)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7ZbUFl/17GFL2h2NmBi0rSAxoAllDPZIcXR0tw5LQlzM1l7qDw9Tg2nr9R?=
 =?iso-8859-1?Q?aeM3/jY9oLZ0TkNNlzAEX3SJXAk5q29NbODWB8sREoY/QltJfFuG/g356j?=
 =?iso-8859-1?Q?4O+8QGxUdPJLXzdb5RQ0CBrHb7dfqz937oo8McCiSV1Rn2k/5seGW79woS?=
 =?iso-8859-1?Q?7cGZCtgw4yS3noCyF4v2PbyIi88g1ohsV/do5V8rnn06dX5gYYM0LtwZmX?=
 =?iso-8859-1?Q?Bf/eZs7curpGVGPXHqoaF9sh6z+GtVMhEDcn/63Sl2Ce3AJ7F/rX856ogr?=
 =?iso-8859-1?Q?oD3Z8yZHydJI+MVZwjK7va1LJ+vwG15XDx5Al4KLnpstJWabcMMA6WCKEi?=
 =?iso-8859-1?Q?xmW0btRAsaSY0od6jpbBayzDoVbw2OMCXZ898GBdpGLM3PJFGMEH3WTpXu?=
 =?iso-8859-1?Q?GvqIA8NP1EYCMnBAINkDeuRHjM3YIUFeL2aN2sgoHEV2PY7sSRAbebtXFm?=
 =?iso-8859-1?Q?nNx4axMJsIVnHVE6OMDvJP+w4zgjpbxB49fIBTKItjtoKGISwNkM1XyGvU?=
 =?iso-8859-1?Q?rnITSB1OPXnVVt1WD4Qwm+jsLr8M58hyI6WFuC9KPpylWmkGVQ2Jix5VMj?=
 =?iso-8859-1?Q?vew+57kkloZF6Vu4+gR/qxRYO5ItVr9m2Zw9I1H6yRGjvyVox78OLh7a8y?=
 =?iso-8859-1?Q?jbgIVswLpJ7I69GjMvEgjOtaKAh/h3ldIC40j9GZC+h7qJCPT54RRCdbwo?=
 =?iso-8859-1?Q?RLGL/HBSG584CXl/0iQqCw5mapTH/v0cUvpeCzfiAhGEz4S4vbMdnfU/xJ?=
 =?iso-8859-1?Q?Jr5JdwD2cfWEMbROfD/1g3Oht3QpsFC6QV4qInFrlePWng5sq7aHoxlX8c?=
 =?iso-8859-1?Q?54ntuV8x/lI4sAw57FFw3w03Azcf0ZnAPHLbOTSTha5SxYzuceCxbLo27K?=
 =?iso-8859-1?Q?jp2tkaqlEWCjGJpbhV8E2z2Da+ddmPWHFkh4tFAM2WOokOHKT07StQjx7I?=
 =?iso-8859-1?Q?PwwVYYJI/lB274inOaBGBrq2g7lrV7OqgykeRlZYd3q92bVV6QxHYfdITt?=
 =?iso-8859-1?Q?VQwCzcDUNsf8NFd+fq8zG1mHV2qajEPCH5439qimIfCMIrVsMDId0TL+cp?=
 =?iso-8859-1?Q?nkfeAYXZG2svger8fiR9xJzxRdxzZ/OOW6AdvL4z86t7kAA8WwmFz5hTuK?=
 =?iso-8859-1?Q?YsufoyO/MO41SjlyagxKYEkIwr5pX2j5wi+X5qbR3eddGpA9QfcBXcPaKR?=
 =?iso-8859-1?Q?eYKI/Eh7SqScz7ld2LZ1NT8aAEJVkBPKDOMao0qcELumtcnMlth7i48ZV0?=
 =?iso-8859-1?Q?qYV/eQHbUs4SKsgB8ufv6BHm7/fuSUEsng3QRpHZNtf4TS8uaJmzX9Fl0H?=
 =?iso-8859-1?Q?c+w+Wu0DiRF9CaAZXDs4CR6VyBfQha9/Dw4FVT3AEUn+Fx20S2cMZfnQ8d?=
 =?iso-8859-1?Q?AA+acUAXIuv0/nc/v/GqAOq1Rw7Ownil7Or+a5eXUo7hZc/ise8clTIXN6?=
 =?iso-8859-1?Q?mXf8HQPhQ/Qqis09tWOU8dup32QPorbXh+SZpFvIV7/JlKLBYHheqgoSD4?=
 =?iso-8859-1?Q?0ISs9LM67TjjVyIHoEtssrc5alhUZH//JZ/gswYZOhB6jfCrN3U3nJE9UW?=
 =?iso-8859-1?Q?iiYQYKCJsXjNWu1pO0rbn9KWBsvpQSDfPa+27TMcUILaMNCO4bUXX73tWr?=
 =?iso-8859-1?Q?HPNs6K0Rwe3tiJqIRaWjieAfh0h/gKvXLOetQeePlnnR9G9/1HNirHG/sC?=
 =?iso-8859-1?Q?Wqix87QoRCRYTW8C1IFJRgL1jAFlUgktcjDg/Z8WcJjyB28kf6Of1uzfsd?=
 =?iso-8859-1?Q?boq+ORKWjcOxxGZkT9n+bO38BUO7YuyWVd9hYF8twSwg/h?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAVPR12MB999121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd61ff61-6f84-4566-079a-08debd7550f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 11:27:49.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8r6ni+jLTQN7hxAoFXneeWLLD4B6S+1APGCl8gmBFpy0GWP+t8mEpII0k9/8j2TIlX9NdOBFhwxszEJWQWcGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

> The legacy path already has this same issue, but the timeout is 30s=0A=
> rather than 256s.  Both locations could pretty trivially change to:=0A=
>     msleep_interruptible(POLL_QUANTUM_MS);=0A=
>     if (fatal_signal_pending(current))=0A=
>             return -EINTR;=0A=
=0A=
Good point, thanks. I'll fold this into both the CXL and legacy waits=0A=
for v8.=0A=
=0A=
> We could make this a bit more robust to such a race with a retry, but=0A=
> it would be contingent on the interruptible msleep above=0A=
=0A=
Sounds good, I'll add the retry in nvgrace_gpu_vfio_pci_huge_fault() as=0A=
you have it.=0A=
=0A=
> Note that the read/write paths also have this gap [...] userspace will=0A=
> already automatically handle the -EAGAIN=0A=
=0A=
Agreed.=0A=
=0A=
Thanks for the review!  I'll send v8 with both changes.=
