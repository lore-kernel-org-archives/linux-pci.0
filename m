Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C960397686;
	Mon, 13 Apr 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066110; cv=fail; b=mnWWevW3kSxPhTvPDHnDY26TUNGLKp027nbMgImE1+Z/+L7Xwg36IUBS5pxfbYXf5cFsR5lUY5RHrYruUy22svYeHRKalHYPacT5318BO7K1qI+msh+H5vAkWu9LCdePzR+2rr14IUFYupddR3QAv1TTUnwJXH5Et6RjS20kjFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066110; c=relaxed/simple;
	bh=7F76wLXO0PugNCbAOB2IB7vEHXC2D0pi1MiK6ISOaSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6ELUZokp+mOmVf/9FT2L36Gw5fTcVK/YGhUMKthjKYAxyL82V577Vk+WaNN351/fd/NIZ3Jfp2s/MaJP0/u+jZOisa/b+9Idv2r3omZxmpIt8hnLYdnczs8nolp0ihhlBJB0FEzD8HtOSzjdQCYc90TIXGn+f7ocpQJZsSEPMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZhj56nh; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZhj56nh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYMoXTMjg2P5DPzgoSytR5D1er5/r/A6MYv+TIKfpxNFfa4XaDT4BROdBav9OZpFoCXGDLLoAuf7gErn1kXcGQxvRMlihrW+oaHC4H8rk6utou4fjlJg7D6LDAHVme0kzzJXydlJZbbLWIH817WN1DRog3+FET2XGlPmfOkpBe9OcqYf7r3/cHO68uEQm2aW7UmV8Qvd08yddPYRnxNO+CZsaf/8OzRUfnpvI2P87cclKcSooG6l1uH6or48Ws1WYciP6u75XNx078nvcAhFlRjJhJX0eCn3e8fySRPD4QGgugiUEkCM/oZZ0+Vmfw95vfuSZnsTmhozZ9Q9wfGYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F76wLXO0PugNCbAOB2IB7vEHXC2D0pi1MiK6ISOaSE=;
 b=MzzXYcqZms+OJ9eJdytfgClj103Oe0HqoFJfnECfxuih152nBgQi2uPVDTgxG26xAmGhlhKfkNw4PTVGMwiJqfDn0fZ2c3hg+2fv5Eet0O7Q/coiZG+wfoGbtcH+f+LjOk5zdW8FJjHhIkJlcCDaafGTZv9H+VvLupXvBnIxXdCYe3y0HXSFuuqXMy/CbvIhRc9tltwsOXWSbehbTvkiwGeS4EE1AgWTOLWbURg0oBqASD04SihpkpFYHQ0T6UesXkSboTyJTE91Yu2N7v6mA+zXeaeYzIrBIPcExOg2WSpYohHuZOik6Fdc61EBnFTex+G/ot+jzk8MGy+x5DuTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7F76wLXO0PugNCbAOB2IB7vEHXC2D0pi1MiK6ISOaSE=;
 b=BZhj56nhNfTQC+sNAdN4syA+E8sQKHNZn2HRVqXtL3r51ygnakBPsoWpSxc9itqYN5FJqeUfsQAdXEV51lx+q/Cp3/giS9Cgh6E/eLAw1osoGhwqOGrtROTz5jz6MnhtUvudEojBsMvdjsbiV+BB0e4FK5l7MygH+R+D6cyRGAAeVkR+003O6u2BIV6Uee4rkP14fUGgls0AjyA9DuCM5LCNB5+pSclk9EWWKtddYJkMhT/tOHulyeE09sjVL1j/1dMyuUAA4hRha1Iaq6bubZz3QF1oEHrxAswzE1wLq6hgloAA/evXCQ+uIXnYukRecvVbibcO/06KqXUGTyoMYA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 07:41:46 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:41:46 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v2 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHcyCX5R9EjDesPzEu4UOJxNZ8MubXXDbKAgACoTACABOJH/w==
Date: Mon, 13 Apr 2026 07:41:46 +0000
Message-ID:
 <SA1PR12MB719958C0338BA4C678D74CC3B0242@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260409133651.92580-1-ankita@nvidia.com>
 <20260409123053.55c407fd@shazbot.org>
 <BL1PR11MB52712F8C8D1DC4FCB88C0D188C592@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To:
 <BL1PR11MB52712F8C8D1DC4FCB88C0D188C592@BL1PR11MB5271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SN7PR12MB6789:EE_
x-ms-office365-filtering-correlation-id: dbf9e7d0-1b9e-4282-732e-08de99301d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 nLCi8pYWgRyY9845NBN5OhYd3Zz5W3MM8amWBEd+cHKYaRqWOMTI623fdLHUf+hBzWXh/AeB+pgxUt/UqLmuZ4K1eo31rqTvmYcIL8tXSTBsZEc4V2UaCKi11vKahDLav8Et3Hj+GuH3rXHdYXtKZ1xf3W0DDfPd41gCwErhxAz57gtkM7ps0NfJ/u8KVzcdbyAxCJgE1wVle3FnsjmYccU+fh2FXqoinoikWvVOqJhpz2Cibpa2uk5aQ1gZvIWfyHW0Pzce0MEuXARbGKV2xIiJSBwxnSCeLwu6cGMYTLpjKoCPCy19sVWi1h/SBlMpRx7nOv80cHPiZUUelXn0O+DL0Mdx0IeRfi9G1D2mLU61eHmMo0cCDaom7aJAnhzwDMbGtpeAolSY5DYee37wn3AQLd22muO2yfIuxKMU5sTV+Mrvdzfttd94qg02dXpxJVDTcjXfUH0UDV1OXQu5rAp3doCyzJCtR9ZwkFExpHMgh+dqKbY9Cn/YyC6BECAEk7g1CrBKIaCa5cVAJhc3d3nNgQIybQl8a2N1hBanAXs1wQPLOIusfSN/tJB9kwbYThNWFklY5/ULB9NPYhH/DHF1txDf/xT7936jYeBtoXtDQlUui2+edOtl9Ndhkye5PHQd67wWLLz/h8/8F8aaOD2d+CNnnFSlKTEnR6rO5KjDoKIdFyV7wYcOOWvQHtlY+7kAq9y0gdV8ktrKyqBcVxkiEirJp+Pq6DkmmQk21YwPY2bNjd4R6Vs9gANdvki9+cnUA2sP3avVPlq9UqwuKF5pLUyLlF0y65ro+OuTjLI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fg0+Src0Um11nj1r7FOimJsNGk5+20kp1CHYEKF9EcGgubkJc2mXN3nf8I?=
 =?iso-8859-1?Q?UVA7Vx2634bmGXNXNFKLoCEtQ+zTzkJwpAr34NzNuJvtEvWVByPiohR50F?=
 =?iso-8859-1?Q?lVkvEnu/tgjodRgV/42zPkNMgkhbqN4vslM/TtsZy49Rejy7hVP5d8vMqr?=
 =?iso-8859-1?Q?srv/6AtJrSJZIhcjp6NVzglNxwzFiSn8Sa8kfKxeaDFTUARN1HR5bAY5f1?=
 =?iso-8859-1?Q?BNm1+KQ13qUzVE/fiUVNDz+zDIuQQp1jON86P685/7YfAF+YZKZXwBnRKA?=
 =?iso-8859-1?Q?vSZbThtBflq4ob2kmOlH+w8pB8CIZ65J7EB/Q6BsjfJOdZPK8iDeIdZq3N?=
 =?iso-8859-1?Q?ZVYEULJ4YyzXMPh+lYMkunLIVFUYxETbqv9Ze5su6aUWKQIyYUOdIe/lr8?=
 =?iso-8859-1?Q?HyBvvgvHB5Thlm3b6QSRmpZnuwz/GVQAgeBGhEw2IRqYmG3LVYQu+hMr94?=
 =?iso-8859-1?Q?iiV4DJNFNFY8bGqO/VlSuTIctA3AgW0cNtpgltLLR721B0x8UBUe9Y/Sti?=
 =?iso-8859-1?Q?KErNfQNHevChtGgcWcwfrc9kuJHuH36GsYMy+b5kfvW+UTM0v4HROK4pDd?=
 =?iso-8859-1?Q?kc/CIgm4hPMXJuqE/GAcnTeftI0Ho9CHHL/0qha7YWLPYJjtZHppmRWiPl?=
 =?iso-8859-1?Q?Z54y0TOHBAoHKNAlPN6F3Z+3FP05VCbCUqjQCGQXPSbETJ8RoqFjzUFK8o?=
 =?iso-8859-1?Q?0go4lrl+XJgc9Lim4OfZQgwJvfnkVBg7SrodTxuGcKMypm1LTeloS9smoc?=
 =?iso-8859-1?Q?8nJ8ytppx+dxnm9bH1nxX4yFLIWMjMu7/cHzYdSP40EijB27SOdKBmXbfz?=
 =?iso-8859-1?Q?UgGWflDvp/3lTB7LrWpGewx2WsmzQ2wnC1DJTjZOpg4hSrl/L7Gf36h0/i?=
 =?iso-8859-1?Q?3oeKNXRhYTAYcKQPlRM1jxbLTsdKZ03qpEQwdaciE3KHx5GLpajRM2ZoDY?=
 =?iso-8859-1?Q?KMjALQTE9Xg/AcxT49wYDe2ANjV9Lhf6PBFYBO1IIhrtkzb35XlQ+tvqgk?=
 =?iso-8859-1?Q?5wa8N5r5sSpkv/g8yfBreQXRVQ+SHLq7BJaI+8E67dHVwRheM+cPSjhu/q?=
 =?iso-8859-1?Q?oeIYFyNCR1KLUNhsNv274awvRNHltDfbTWYsuda48vz3zTqRLDpEjv7IOl?=
 =?iso-8859-1?Q?WRiV/4I3sTfOV28/nnVXrkiV2TKNZabllv5kPQ1wdvShm5jRlbTJgJ3kzl?=
 =?iso-8859-1?Q?bXGS798IeY/6edQjVgVssTEQs+I50Y/wDUytfKi3hytF+S8F7qk+ciO0H5?=
 =?iso-8859-1?Q?yIWASXYJy41Qnw34u5rWja8oEVTBIAWWDpHtHzrGI6xgACKlJlkhUoT8Cz?=
 =?iso-8859-1?Q?XIaLFskTXJoMwHuUda/4ciEXnltYhfgIKlVlg6jaHQh8yffIsVpRl8sJCu?=
 =?iso-8859-1?Q?PgzUo6nDEkeJKC4tRCR0RrUiYTcYSdsqgFz7ASKwvaYDE5GivSL8XKlAol?=
 =?iso-8859-1?Q?3kjn4JZgerVp8XSUK78Fo720D9aV2RnpLIyvKBDm04ciC8OJS604I4s5LR?=
 =?iso-8859-1?Q?pboay55S/4RKYxU3DMmv1nVWjJTwtpXTAbDItw2MtpfSE7zdRzwL/zSC2h?=
 =?iso-8859-1?Q?3TZ78ZNCDhpzRl98C23oYi6zbnAqBR50uhPm11IRTb9VIx+jwj1l6fILXu?=
 =?iso-8859-1?Q?U6OyRD9XgkX+h7SK627gUDinAw+bN/PKNyRWM5t2b6mrK4Z76py/2D8cR7?=
 =?iso-8859-1?Q?vyOL9LLGwxbLO6NJahzKm/WASkFeg/yUw9wcED3krTg/FGRpR8C0dte8kN?=
 =?iso-8859-1?Q?jdclLeFd2m5ykAGR1GQzDTxUH9AgqoWqY3DUBo6FxX9Jme7l8wAqAC0Alz?=
 =?iso-8859-1?Q?+1RAlM3u6Ovdz1m7PpwNeoRurBZdnEmRQ0fwM3inS3scobL54C9K?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf9e7d0-1b9e-4282-732e-08de99301d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 07:41:46.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlb1vPjJWigWPbXzLzb23hQM0AEz8tn5hX0YXv4HvAYlCcONb/A6PwTFQZCu33VNBFU81FF9h8Xxj46uHITeqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

Thanks Alex and Kevin for the valuable comments!=0A=
=0A=
> > +=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dvsec_memory_status & PCI_DVSEC_CXL=
_MEM_ACTIVE)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> =0A=
> Do we need to monitor PCI_DVSEC_CXL_MEM_INFO_VALID in the loop too?=0A=
=0A=
I think you are making a very valid point. The CXL spec 4.0 in Tables 8-13 =
states=0A=
Memory_Info_Valid: "Must be set within 1 second of reset deassertion.". So=
=0A=
it is possible that the Memory_Info_Valid may not be set when the software=
=0A=
is making this check until 1 sec. So yes, we would have to check for that a=
s well.=0A=
=0A=
> is that bit static or dynamic? If static, better to check it one-off in=
=0A=
> probe instead of doing it in every wait.=0A=
=0A=
It is dynamic per the language on the same table 8-13 on Memory_Info_Valid=
=0A=
that Memory_Info_Valid: ... "Must be set within 1 second of reset deasserti=
on."=0A=
