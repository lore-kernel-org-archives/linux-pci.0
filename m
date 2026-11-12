Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493588;
	b=qr1po1xeZnp1Dvku0qqYhrZk84+BjOPpcSXHwet6fXqdxgCxGLwZDyvaGtwrpvL8ttlv
	 9BqOJ256jBOzmpAQHzlIxlotvCSlgftFajCsuvuemtK1k54cAk2BimbPl61pcnync+G1U
	 UelprTgb/uKEfZsCukGX+IarYwl+WofNcg307Nb4tukwrMK7a49LVLGfs0T8u4vZ/4Lnu
	 XesXda+RWKr2uSe0NspJAk9GRkw17PpGlD60d/0P7QHHX9ysp9pIAAT5VIGYaUZDen80C
	 Bqqibw7QYtz6/dv6Mg/yaMX66JnIhcTX0KoMDMhF+tFMYB1coxEADiXiy06SxTdZ5sA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493588;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=habjPIGyp0HPSihZEv/bCCfXrEmiZJCFXNeNpXTs2nU=;
	b=FV1qLDZ1BbfHpa7yxT6OJbEyCPUwkSOgGr6Bs0F6lJvcNbUWPKcJO94Q4gjY/3gjsuxe
	 g36Dsr75lPnvzQCfm+dD95CYe1v4IyqtwJ13Jg8Dz6clpk0s7eTLTzLngNteF0KFnDKgl
	 voJxDTKo0YIsZNy150XpVfzNS1pC7YPdFSCb7vW/PwYlTJEWL0uGSwyvr9bujAuDhrwSS
	 doKZDyMqMbdzF2dLeQOjUpbnj+FrjQBrZQga8YVQbiIJ7LiYFmPbSlqFUOBnl+PuC5/t1
	 zpYl9L0nGJVnFOKt6ogaRTmyrIlFEaIjBUEO+RWwi1jMviTbdZwtmqAOPiKzFUsmOjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gr4dclfI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.37
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A537606B2C0;
	Thu, 12 Nov 2026 14:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A537606B2C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gr4dclfI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUpAYRmGB8ZWjBCbHcdujnL7ICVhzIyPSX26rShu/qVZvSHD6WlphImE8Z6sWEHxwHd0kEP1iwABYC0vcLqRrF8Ba+LPsPb1qG1F+6BZ/nga4CO2+KHD/rRlAreGzELEpSChrVeR/D0nCivv4k81u8l+YWqOJpjP/fXh8RI4wCWkDp0+AI+QXBVUM4zrWj9YCgK9KWcrDsrMSSo4x4gaoRTSxLR+CESnAUVPbMjwNJMIrul8A4KwVRmQtnuR/e3yFSFf0ckW5wAP9MxGltALIF6rh6Y4sVaqI0rrgRS5X+xY/lyMVo6d6FCteypTiXEaHZl8PUQjAYrdkUZKEJJdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=habjPIGyp0HPSihZEv/bCCfXrEmiZJCFXNeNpXTs2nU=;
 b=qpahWmx4qK3dsr4fS46uX8pguZLaWXS75SxwcDHkfGeHMMOvSJ9u5fXDXyJ0o3Z69Wk2s6XAA0vZOG37888B8kfOav46hdotk7/Csx/dC9Dy6ATZyVqlPO6tV6s4EUcm6JAg5/ofNNoDJwaGn7VvmrzF1yLTXHJeMiriWxdrhSpoGD51ZxGZ2+PE9+gW7HjB0leOGgtpQ41rl5+bTYGZxBVS38ANR5VmXMCNVIv2KHVkVrojQWUQ7tTGCAlxveyxSqWjgb//2l8fQyvEaPNyf2YeHokAtOf173F/KO1K4p2v71pxb5jjCSQV1Msuy7PXeclBRoTMo+znqk5M80qXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=habjPIGyp0HPSihZEv/bCCfXrEmiZJCFXNeNpXTs2nU=;
 b=Gr4dclfIU4d1qDSOtFo29iVXdtuZ0rG0OxA0i98mwvQxpHzsDZzj3nKIk+w/W46eSHDZ+77MJ/xv/rusZvWECHMIT+d9N1M/yWBJYCevJ5vjVIvea5C6o8lOwXoDulYdIzYW/hyGpUMMABmfMeOfw9JXR7vqog1g/FZB/cOjXKYI+lK8yO3LNJDDG/lln+l5CRXgh1aXlHfRqnY6wYU9M824q+6dYzE55n8MEG2bujeKLNytxBLtxm8BlgIEocZfRAv8J4WaI5tihsCmQ6tqsBfjpNKmmdInb0JGoDlQGfMFFesTbwTV6jIx4N8H1uHkG5/60c3E8O2NRmG/MCovNA==
Received: from PH9PR12MB252631.namprd12.prod.outlook.com
 (2603:10b6:510:42d::23) by DM4PR12MB6303.namprd12.prod.outlook.com
 (2603:10b6:8:a3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:26:21 +0000
Received: from PH9PR12MB252631.namprd12.prod.outlook.com
 ([fe80::44ef:d404:34a7:4a]) by PH9PR12MB252631.namprd12.prod.outlook.com
 ([fe80::44ef:d404:34a7:4a%3]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 14:26:21 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alex@shazbot.org" <alex@shazbot.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"kbusch@meta.com" <kbusch@meta.com>, "michal.winiarski@intel.com"
	<michal.winiarski@intel.com>, "satyanarayana.k.v.p@intel.com"
	<satyanarayana.k.v.p@intel.com>, Sonang Patel <sonangp@nvidia.com>, Ankit
 Agrawal <ankita@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>
Subject: RE: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and
 report state to userspace
Thread-Topic: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and
 report state to userspace
Thread-Index: AQHdUDizqfEnaJ2PVkymlz3AjIHjGLchfysAgAlDZuA=
Date: Thu, 12 Nov 2026 14:26:21 +0000
Message-ID:
 <PH9PR12MB2526314C74224B9D064F0A7EA3AB702@PH9PR12MB252631.namprd12.prod.outlook.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <au4GznJ7p1k0kdcD@kbusch-mbp>
In-Reply-To: <au4GznJ7p1k0kdcD@kbusch-mbp>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH9PR12MB252631:EE_|DM4PR12MB6303:EE_
x-ms-office365-filtering-correlation-id: 1289208c-832b-4c5c-9e04-08df40c8ec91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|38070700021|261026140227099003|11063799006|10067099003|56012099006|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 xx8TXtV4KJWCJGaMzLumdzkS44wqNU10uy0kX4Mh2wu/6eAw6pkqMXIT2zsOEbbBKe+hnJ93nR/peAv5BQTeZKAAr/RZaYPZNVKMadPR7iuIZirYsTmA6R8e32CoCFG1GDAhoT3Pu1NZURXSiE3q7M0qzyiveDGmF4kLMrqqYHcx/KXXVD8hZH00LUaa3YdJXy6ezDr1mVs47RYcImsbthVBRD1HfCr2nWlhBgQB2augUNtdBQo4b5kD9rwmJFJQW4TSSxCHujpbmSiKZANF83Fft3oIXGtgZiI50BCX44T4i3kdPll24hOs7zWdm1mV5sT9KDH+hCTdxOw56pGMqZjCuGG8K3CrUglU8rVsGx2zJOEK9BxsxqgwSinFsM2IMhHUDSZKQ2/uS9fgqUTTJEYBVVcBiuL4doiAwyPijhOJxM45faV9UE4msE0G/PdRs8VckOB9HrdnBrqHUpzCfXq3Jr4cFCR1uitWRdKMGIXPkSg/Ux4JFKlFfeJeFQRIr3N8U7QK4zcU/tMiOZmdDXAHjH1H+mQjH8JIa5/b3BswXJXllMzzm4X/ylr4V/jUJTejjcXI0SzFwJTST6tTOSo5ZRxxZaUNvXlNO69WnBqCU8NREN67qNxAWvuCoSIBYTmhPKDs2Q5BFuaCHGC+TyGbbMzPKX4xSebmG5qnkKjVASHl+56AMtXutkLJbSUpyUlPiG9ME0A4y2fujoS33aFmuQc2d7CkBhnSC+u4bqI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH9PR12MB252631.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(38070700021)(261026140227099003)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?36bS0ihfVKUh8R5StnPtsWz1TeUPQeEfIiemkCBZR3VBdQ7p0XAx6KUWHZQc?=
 =?us-ascii?Q?1GcUSBSY9ydB3c5zstlnf8Xce8mQ6EMO+nfAzB7ZDuH0iCqap9TBt744O9fG?=
 =?us-ascii?Q?eaMD1f4dOQ2MuHqo7tRVXgQ8VgAtrAQaxVESkTCCLnHRFkpOANDHCPtoGtn7?=
 =?us-ascii?Q?usA3mai5kIBPQagfgZ/DdOPewhtxy2F7QGMajJOP17V070mc41U5jRTWQ+LA?=
 =?us-ascii?Q?6uH3J/GOxkIXN778e5wFu9wtW3bEHJkoVojS6JlXfVNwpUwsf8L+7H0fzLK3?=
 =?us-ascii?Q?r3g3yKLIxMPCV3BsblkZ3iWxGNaz8Ao2pgKygNn9YZnGKZK1Pl2czAeWDnHd?=
 =?us-ascii?Q?40LoEs+8P8lTnda1M2devoHD5dle/Kc9OFkMkRT/hDGmEfZp9QgWD7KQaIrG?=
 =?us-ascii?Q?Km1qdQR6LVjeuC4fsNFJSixVCCNTDkJ5zb43bjBVVGpqUcfA7+3xY81zYqLh?=
 =?us-ascii?Q?fya2mQ101ZD2PdEBo+DXUj+MX6IwRqi6BSP10/nr0A8NKgHggP92fONxze6U?=
 =?us-ascii?Q?VWbzapXIAovZikoSWH9QTrX9e9s0d2n7ATF6ZUd4iNUPbd70syMtJxrlVwzk?=
 =?us-ascii?Q?b4Gnu52MFWYM4T+9cZRMki2kqGQDcpmBM/rF13rG68z9u6zrU4dKuDdO+y5b?=
 =?us-ascii?Q?IG8jZsTUjRVIvKPq0OxDkW1SxaFlk+biwsRzZn/u312LLEpkaoSqmZ1RAE2e?=
 =?us-ascii?Q?B83hd/31fRujUvmzXAvYoMiTh3moH7ZkHDR2IO/nXGzAjoewy0yP4Oq+MBu9?=
 =?us-ascii?Q?H12u0Ek23HO+wYyz/AiCxXk62Hnx67MsaTpS901mEr8mrowR1H0kaK7joAtF?=
 =?us-ascii?Q?Zem/BcMsN497H5CaiH3wrrhci7tvhhMeuc56iqj8s4/GvWA2Hxrwmd9fahyZ?=
 =?us-ascii?Q?s7Hh9McCkWBeMpAQeS2BWuKYz3u4LZSPKrg8+xa+6mQ7UF1T/23+70aLy7V/?=
 =?us-ascii?Q?lRIwEJjiLN5LzGTO2N2pA9YHJknO5EtKczDm12BDvsCUf5x7fudebtX9/KJA?=
 =?us-ascii?Q?lPl26owHXd3xmV9CRT+5ph8FeIjdo48MBQzeqoLoGq8iR+lTgbJhu8TzHc9w?=
 =?us-ascii?Q?c56cFyf1og4AwkG7lnXUrViKEYrV5JAY0yJlgtUQfRDdaqME2x+k6l13SQ/i?=
 =?us-ascii?Q?xEL/7y2MiDKEJEXe5BCpeOGGhi94+xV9OEYo3EWqL0mLf/3cKKp/JfwDx1F8?=
 =?us-ascii?Q?vC73bQqNJchhqnIdqL2dV5BbFgzOwcIaptcGIIGikLKPCM5A5DkDRFj35yu7?=
 =?us-ascii?Q?t3rbHIq6RGGPLsNTkia6GaFTBeyruL4Q7BZwfcfs11bLHRGTT83g9LfPGCsb?=
 =?us-ascii?Q?X6GigKvFpEn6PDe9DNejZ1HWNxZAIsJXATboTutlZXAbEXGz5obfZbbscCXu?=
 =?us-ascii?Q?dE/pLbVt7gFU1FpyLN3UpME9mU85mDOYxk9Oz1ZSdPt87MnlpOGe3aE2oYk1?=
 =?us-ascii?Q?Zn6GOk9ul578+G8GpPq/6acq+24KyZLp/WBTXM0PF4MfJAMRrzcjhacm0U1S?=
 =?us-ascii?Q?bObR2jTMQKKxoAaMe1mZ4rQ69BE/k5myLQsp9AEhJ8qTvHB7hEBM23Y38ZYc?=
 =?us-ascii?Q?k2y9hJfm3vbxZTYJ00pvkVMe6XB2+kG7Tllgswjf0VXeCFPGYfiUpiB/3eZK?=
 =?us-ascii?Q?ARFPp6I8AqmgIpI7qn1cX950WkBDasq2QzulUyKqF+hGDyfzNDB2IIXHijAI?=
 =?us-ascii?Q?bK3wtwUoejpxt0JYMo6ESxg1GHMeDwhE1uvHyqvCKehajhbU54Rg5kTmt+T1?=
 =?us-ascii?Q?UyOGQrzPOw=3D=3D?=
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH9PR12MB252631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1289208c-832b-4c5c-9e04-08df40c8ec91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 14:26:21.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qCCPSlLvgpYk0T5OzzzKHuOpdPrzVOTwk2CVhvqLVEwWQXSVRO21TPSqyfAfttcK6QOd1Y0FY6yL2L6/gbB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303



> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: 06 November 2026 16:57
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; alex@shazbot.org; jgg@ziepe.ca;
> kevin.tian@intel.com; kbusch@meta.com; michal.winiarski@intel.com;
> satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>; Ankit
> Agrawal <ankita@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
> Ochs <mochs@nvidia.com>
> Subject: Re: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and
> report state to userspace
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Sep 29, 2026 at 06:32:49PM +0100, Shameer Kolothum wrote:
> > Hi,
> >
> > Currently, vfio-pci signals the error eventfd from error_detected() and
> > returns PCI_ERS_RESULT_CAN_RECOVER, including for permanent failure. It
> > has no slot_reset() or resume() callback, so userspace is not notified
> > when host recovery completes or whether the device was reset.
> >
> > This series adds opt-in host PCI error recovery for vfio-pci. It blocks
> > device access during recovery, restores device state after a host reset=
,
> > and reports recovery status to userspace. The kernel runs host recovery
> > and the VMM decides how to recover the guest.
>=20
> We've been experiementating with this recently. It turns out that doing
> a meaningful recovery on the user space side is a bit more difficult
> than initially thought, but we can at least get more deterministic
> behavior with these notifications and gracefully stop affected
> processes. I don't think there is much else the kernel side can do to
> make this go any better, so this series looks good to us.
>=20
> Acked-by: Keith Busch <kbusch@kernel.org>

Hi Keith,

Thanks for that. I have posted an RFC v3 here [0]. The overall design
and UAPI remain the same, but access serialization and power-state
locking have changed enough that I haven't carried your Acked-by=20
forward.

Please take a look at v3 and let me know whether your ack still
applies.

Thanks,
Shameer

[0] https://lore.kernel.org/kvm/20261112141632.918954-1-skolothumtho@nvidia=
.com/
