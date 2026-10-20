Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792488942;
	b=xrK9ZBuc81FLoix/eTa6c6B3pddpwHDRoUsMjfP5rAveFHInCJTfZ0taEdHTpSItcgMa
	 HPRAgvE4biQ+hTRQbVCzmloSJJWPhT/b4ro2BDhONCM+65Kd9ZO3/K3NYTly7GPKloeGm
	 UkuHwtXwP61HgumeY8TYk6DcBy7ozjX7/OFliQhcZg3SfLbcyoX157TQWBzu481yRbbzR
	 ruiTB9FM/phDNGbyasSWClIUzFY8RCU2PjM7hBES+IAEzuyZ6Sn6FNb/NOlRRjZZUXNKC
	 XOWMmvg58EhkJn3RfwRvEq/HYW5puHhKmUXbFX70AxSvkhBjRRvJhd0brndGQT76WUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488942;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=1rQBNjAVPGa12lTnSt/tvf5U3QbHInM4HrkkieldpvA=;
	b=R6/elwfY4zS2E2ml7OggHJqN04DkZs6RSU3t95BDMOMl1uO74KDwqbHH6qdcpkc26LDk
	 uScST/KNiIDdWwzTfhtZX6uuhA3z0GzDgyXpE66+SxJtK7I7yUsDIVLvdPfQKps0Fwja3
	 1l1DPKHhOBfhzc0hYI18lDHaAh+KDqMTqTo2DkKQhCFN7UOv1VoKZxDsB1xLazskSoxQP
	 q+WFjkDS+ayi64BFxisayHM1t0wRJCegilKP8avAjf07BeJqInUArqAVQMwWfIX5Egfft
	 N/g9Kffb41LvqU+IJ+Tfn94KZobra6YBgkxN6gecHgIuQS6dKE4+BFKet+BftchQzhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="UkM/rDch";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02524606A31B;
	Tue, 20 Oct 2026 09:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02524606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UkM/rDch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEB+HmomlunTenEC86XWGP37aQEQsbfYViO8WY2tMeqncLosGntey4M1BhAfdvjIigZc/lA50UKyaMcrtPMsoFGGJ7HHFv2DVGPbQTQClkrhJ+qLI2OjY7eKVO/0v5MScmvWNmuwPShrdJEIF7tg4V0eJVZPRQm+IJlKAuUGFp+cn7uon5Kl93l7eSv3AfHAVfmPlaJPRlmWhyi9v3MG7Q2puteScX/wUoqz2go5B6Dg1IRJ4Z0jnhRyRyUmDYDNVpvunZAMx8gdktf9qww5fH5czkow1w0FR3WlkVw0dCH5ldsKBVJ4N4RzkdsQzlV6bzBprQsdL13zSKAs1yRppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rQBNjAVPGa12lTnSt/tvf5U3QbHInM4HrkkieldpvA=;
 b=MNEjNJ1OVrJ4zJekiOmyMWrUOQqtMsqzspJtiASzTTM080I7qn8MhKvKNjscmOFp3s5l7rsJ4LiE3qGP/TpOPjMH8q1brB6vcUUmW3uSS9W/XTvq70C4QswfVtQqoGmjLBfUDqsa0WSABFVUjH8dCKBRo8d5W2bEHnLS48PtMA/QCE1Z1GljYgu6zTr0As7XLuOsY1BFekVLvtvzNSpheH/w8p1XEpKFfKoEwIgLryXmAEXJAv1SZhLnrBc6kFgSHZrGNRMrBWRb5RAZHlmgSyHjz0h9gBFmNWoZeVeLweTh2DbJw7BYLaGN/x+lHKB0SFVQCbIRA6raAdPHJ1nUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rQBNjAVPGa12lTnSt/tvf5U3QbHInM4HrkkieldpvA=;
 b=UkM/rDchvNiK+hV6ZApAlMNkmnMDmynKqx3dLTzSjuwxVPYh0stFuRwbL5hSueKdZbeCUM7o5jTP3USucZorb603kP1QAMItqUqFKbrEZmxZm4bgIxeoDsPuosP5K+w7mS2GsxuFaKxPuSL+OO0BBWYzdLMPTXU2NHYJz8vgF8z+zOn35G/kNKbKsa0yU8qNUK57iBIrY7L1z1JscJ/QMHWF4iHcHlPf9hCVIvNgId+MuSHr9xSS2XohyJNDRfkuT9Nq8YKSGhlxFhhsACfsrrutCgCn0ra8tFrEuschBkokjI709YyfHPPgWNh9Bve7IT100RF5CJTaYgZDa0OumQ==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS0PR12MB8220.namprd12.prod.outlook.com
 (2603:10b6:8:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 09:35:36 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:35:36 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Topic: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Index: AQHdVJeqGblX8LB8bEWpiS6+ofq1VLb6VKKAgAvmsR+AAAbVAIAAAQaz
Date: Tue, 20 Oct 2026 09:35:36 +0000
Message-ID:
 <SAWPR12MB9992676FD2035EF0F7211C90FEB0672@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-4-ankita@nvidia.com>
 <as0zRXh5f5kjULVI@ashevche-desk.local>
 <SAWPR12MB9992673082391212DC2F41A6E2B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
 <atc0wO3ZYGg2WUXc@ashevche-desk.local>
In-Reply-To: <atc0wO3ZYGg2WUXc@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS0PR12MB8220:EE_
x-ms-office365-filtering-correlation-id: 8bc5a453-6708-4d20-3da1-08df2e8d7ecf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|20052099010;
x-microsoft-antispam-message-info:
 FiI2/fzIGO1fvHf5efrvV9G+jppb25wmJZt1g3WcoO6egJCWzA2r3sf0BDRmMPqkcYtidvgtqdgyAnOwLuTgq8g3HUMwjTGCJzIbhoT90eyzFEnm9aM2vs9MFXAJTGtJo5ZI5jYKb3BuviYVRSEoEKzUZPlIth0UnFiJi8OvAuh20cF8ZRqrhsYEZb4OJ0blryzxS2BPCs70Sodu5NAiNxwqeJXVtxhkV8NAlEUKZxJ1WV6DJiz30Imu/RydOYeuY7XvWFeq6mN9Op1McNq612sv2I3RlVHxHZdtLooYiByzRhg8+I2gnqjIEF4c70W57eeP2kSb3Q89C8pwHqkKDwVybs6Yp5/KzFq4YqukSTSxoqCRzMAVepKiyvcYyXgKpX8XlZlwnrp3O5VpaQGtrk+K+fIhGGQYmW6Fdko2iRp/byWqBcZKYSW2b3eArF5bFrDlevc7btfcBnbFqykdAcB4gSpOUsAstvLZloXnehMYQvbAmvwHmnQWqaK3X093Nku0YZFfb2vY6MFfDB39ElTO+wxqhT7JVx858QiTgTm5We1ijEFyEWW6eyKE1J3FaENtoHneh3L/QjLd1bG383q/Q15rI4vVX+BLUpA1E/Os6ZacA4XHuuBfMki6jh5QcYOLkMRW7qJweE1BCmCqN4Pk2h5SuBeKaa1femr4FvFaqpXAqoZYwcMNG4ppwcm8GY90qBt/aCpxaY3xLq8C05S1S3Oc8T+xilbD2wLT+/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(20052099010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?f8c3zGd3klCedp0noisHKsYHBeDLWGENac7/amBH7Z5sHmma4n1STFONRv?=
 =?iso-8859-1?Q?TDetXmBiTB4PBzOOd7toDAkVX8bMsN8Pv+OITH1i+1FF1MS1mwVraSUeCY?=
 =?iso-8859-1?Q?y5tjvJlcaNVjto2uVf+FoTFyVcamSq4gqncj6iqdTV4oAGA1krEhK7pam0?=
 =?iso-8859-1?Q?VucBCDezTuER8++c+haCUaRrJveLeUYcZhLKPqqWuwxSU6eiB6fUZdWo0R?=
 =?iso-8859-1?Q?V39iB7EkEh+VGPK7QV8fIEfZEU6HhMHC+2fDHU0lhFtGh/IoqwCyN3nHFQ?=
 =?iso-8859-1?Q?GLoOQpaTVLUOfFrVASxRwkmle0he0ZI2kGEDnun+cGmlc/MnHcKdKmRRt8?=
 =?iso-8859-1?Q?668n5MRvIdhgbrKkUj1Iy93K+Nni9uTzGO/DEOvekgE/cqkOLDo/6kHaR2?=
 =?iso-8859-1?Q?pgM+nK853qAdiCmVjj92LhxwA4CeTqcBG3WE1JHvzHIg3QIW4jXDv3tGVm?=
 =?iso-8859-1?Q?lodQ8aps0mboTUgTEjDk3SRDJw7kyf20FPwTFhohDt1Bs2yY1pNPNhq2zi?=
 =?iso-8859-1?Q?R9igVFVeh5/GI/hqfK1olaUoSPB9U8bdNgSOwJ1VSJAmamZB8SonbKEgIo?=
 =?iso-8859-1?Q?5el9+ZY94Rk6KCmWJrDUsZxBxhEOPYyzB00P/O+LNK9ixxSeg/fd3akFVp?=
 =?iso-8859-1?Q?LVv+gmNksHhUzQg4t9vsuQZ4MQgHBTRxBm84kiC/RITdW+5+0PbmezVjvC?=
 =?iso-8859-1?Q?y7JN2NV25jTdHg3GUZKApvTAkV3wjybpVZRun5TjuppbjE/32KNUlpCDH4?=
 =?iso-8859-1?Q?mdU/FkKh4MBvJAbV7CqVhMjp5Q/R4jIPRoKDOaP3rBx+YErx5wMf5+3TEd?=
 =?iso-8859-1?Q?VbaXLdvSiDEFYAFzHI9XdY7dVZXdntmS2RDfPbE4uY1SXFw+HiN4sfovHW?=
 =?iso-8859-1?Q?sdscQ9GckR7MbnCNwXWIto2VGqAgkjiq80QFD/MG/TEwKwOWH+oAKbDMgj?=
 =?iso-8859-1?Q?8R7rt5ipkZQvh2oTJaGJEp+gFij8vKpGaaaO/ilKGYlB2i/Ag30b8Q6gCZ?=
 =?iso-8859-1?Q?eD8oSolbur2StEGJwZhiytPSYwMvI1hoOa+EO4mG7hxV566QyoxMHv0jZd?=
 =?iso-8859-1?Q?Grv/vLfJj2BTXQp2aWCCvqk0lbBJO7MdCrbzqwV3JHPDKDohp/i/m2hHQS?=
 =?iso-8859-1?Q?eFjpmB3yLsBcaWlJtf4/8idVDxIBfbVKOTrxUSvjcnsey+jeRTtjtUuYFp?=
 =?iso-8859-1?Q?fTFRi6pfOTa4zFeMjZC85h5WozbQv1aW/kFUPHBTEvpbpeyHIP7iI7fX1l?=
 =?iso-8859-1?Q?OwsHxeSDZhS48Zb4wa+ZJ7SL+kCG/lPyebJ0P3QJouCRhfeteNw6dw/2N4?=
 =?iso-8859-1?Q?3ggbHPlJcnmWhmyWR8ZGH7DkyX3GvpUbPkEkjpiQUmyprfO7k1zuW6z7ed?=
 =?iso-8859-1?Q?3wtbPH5y5jjuKuRGpekYyneotklxnYlj0812o0UB9tgdEvKZNN/+q2BIMs?=
 =?iso-8859-1?Q?LnVnhflGvpS7vaZRkKTxmgLXZIYlMv1FO4tfGmoKWcv8Smys8UBGkXnawA?=
 =?iso-8859-1?Q?JXAQeZ0NDkaxaiI4x76FczNDkAHOD4Vf0KIgcrdnfZzZ/XW/PJRBgRpmZi?=
 =?iso-8859-1?Q?N9fImc28ni3eJYVGhthWCrB2Tcokg6Ha7kMWvvl1WRKlRIbKW1wwEfqcAx?=
 =?iso-8859-1?Q?zqDA32cKM7/uFqfx5ovQ/LwaN44s0p+IxRf66j1fPhBTOi6Blp8ZMcFUqu?=
 =?iso-8859-1?Q?v8SIInIovKVDK+QotjWDXVIwf+VVP65p+NbYEwEQ4Safi1MSr9x5lN5Zk/?=
 =?iso-8859-1?Q?OOpNO9dIVIfeX/3nRCc0iI3tv+O01ZM8I1PujF9MWr3+stPrFE8no3yUoR?=
 =?iso-8859-1?Q?MTtQEKZgRn+c+9wJsweJAEu5eK1i4Qd7/sEiXN8NzlnbE9UdYTJG?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc5a453-6708-4d20-3da1-08df2e8d7ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 09:35:36.2337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bQwzutZ/SwqKH0YRA2DP3POl4v/weOHNdukcAVvNptqLGbBH8h7eykLUBrm5MMue3r9WcjNxY1watcvkyQeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

>> >> Assisted-by: Claude:sonnet-5=0A=
>> >=0A=
>> > Assisted-by: LLM=0A=
>> =0A=
>> Do you want the model dropped from the tag, or is this about=0A=
>> format? I followed Documentation/process/coding-assistants.rst=0A=
>> Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]=0A=
>=0A=
> Do you have old documentation?=0A=
> It even got a new development, please drop that tag for good.=0A=
>=0A=
> 1e035297ffda ("docs: remove Assisted-by references")=0A=
=0A=
Ah yes. Will fix it, thanks!=0A=
=0A=
> -- =0A=
> With Best Regards,=0A=
> Andy Shevchenko=0A=
=0A=
=0A=
=0A=
=0A=
