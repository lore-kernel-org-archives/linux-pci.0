Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029907;
	b=d5METa0pXRf8O5HzxIo7qrL7WlTZa1VYP/pKzKPwb7PuceHf4u5rlNf50iRQoHDwi+4m
	 yOoBi8Xp7QNdgeSJLQI8gEzMRbS00YTfuhWqxxjTRaf3jnwSD48p0+YFY5gvBTMWhjz1X
	 gxdr86jQXKWJ9WQE4c9J3CK+RgHQL3z+WtL7ey+gHRlzwNXwvHF2CQxaXN2Dcp+6W0qGh
	 rO0lQVsdhUsnOFdpH14wh7I+tI8FReeCAsri59OwGv5f93Ka3G2kz6sT9BAcGFj9eQPyA
	 bb6DX8mu4QhlkxSCWhwVky3GmZwmc0HLhOE/6ygPEtABujjBb8k1kXkOsyAmhm75CGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029907;
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
	bh=JcTok4/mS1r8EiPrD1iHcrGiorXO1Np5ls3LVz2jeEM=;
	b=vljFKtPsLfWneefINr1vWBdZ5jQ0BeslVUwYN2a9INlW29FYAdJnYRqNh1M3ywiRU+84
	 qjfZFTHgttOfxu77Svu+Luaurv9BZeIOOTvROFoH2wsmopi/QhnEF3vKQUaiQVQcqW4Yc
	 IffBK6aeFDyP019ea1vAB6Uy5RKkPkXkPzPsMrjLTuc8v01cBzfyC/fygA83zUKB39d3+
	 VP/XirqpzfLRDdQ/bFEcM7s4fvcZl0fE1AtdiuZKdkI3urD+4sBQ2FjFbJ/GlswFPCl0g
	 K+jzesQTqN6lJIftaa/G10+VK6hIAZ5lda4m10q0kelCVYH2mvM7fq8YvbS5DzEgtLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gFLusLZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915060A5BC0;
	Wed, 18 Nov 2026 19:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E915060A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gFLusLZQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqRg0RgXpAGpB6PUhmGMNgCWoNml1T/Rc4g6u+l/hX6SmGikI02btqqLFjtjpDhs6wE6HM1oH1XaJTbOiHDRQw+/Y5mJOqJI17cxNF+gwHRS90gLGsDA/jd0jhczelY9tCXRJSo0qGtiB74JaP58HxEU2UpzscctwKgYVg0zbqvombpwvCcZHEKWCjrhc23dGNvnWe5zrobIW2CDl4TBgjdYFr4AHHTIGfNcnzJQ9nlDvHhp69G9WzRJjl3YfKd0wfdIbsHt0C76dOO4oouYABCOh7qzdtG/lBHdazKG6j+0oZ4j3AVtYEJrxw3F73td3Bx4KNaNPy93yGAFaajCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcTok4/mS1r8EiPrD1iHcrGiorXO1Np5ls3LVz2jeEM=;
 b=vhHr4mzxyvpto83nMlMf/BOjez3M+rpK4hijCyPoGZPisbViqp4P77WjcC4nBIQxMCt4Z8479vUGtZh36ACrOu4hAXqARVc23X9K8DdIQSlRavndBlGWti8ka9iIgf0dDq7E1JO4CvnENOeLtw9DbAsMfs5lO+nrE7jX/XLNwYPxdbN8FESXrv56H8UVhJyShAdauf2gdcODezSoKZARJxrp/EAVG6qGGxZfilbYzdNM2PRZlpq9liweuaBPh3VoFbPXTU/6AgbJBM7otKGVTjonBdtOTDhj+HqaH574moBTAKU/nbAc8fC2/+rsRzmc/lWUV2kEaqUYpeI18kF+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcTok4/mS1r8EiPrD1iHcrGiorXO1Np5ls3LVz2jeEM=;
 b=gFLusLZQZX8EWS1EYTtkrLwNwikGXcYJlJxjmSpsRLbp+uaSmjOrCGQVgJtw+Uq+ATL/LEVkP0475FnIg9+a/HJagDtZIVvz0byFDVYnt79c3fWho6qwLwY7pvLGhASxuR9C3DlEiSur2ZKHmMRmZlJUDauegWtiaI4TGjTPRRidkFOJAAY3cfPNlyUEEWoTsEdXU310syAvDK0TU4N4ZlRmOq9Urh/7yOVgkQWxs9pJnijyvr1SHIMH7uSkN2K+mCpvwpvMMXdLPuLbTKDzGQjLFwIS6b8a6jNZ2nEnpqHgOtc9qdaExELv+JRNRdhIJaX4QGePTmgjcQAySYuq0g==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:56 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:55 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v6 03/31] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Thread-Topic: [PATCH v6 03/31] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Thread-Index: AQHdXYozg3lnUnLESEiCMrXc74qPr7cetCUAgBWidNA=
Date: Wed, 18 Nov 2026 19:24:55 +0000
Message-ID:
 <IA1PR12MB90305D1AC497D9811765D1A8BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-4-mhonap@nvidia.com>
 <20261104165256.09860477@shazbot.org>
In-Reply-To: <20261104165256.09860477@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: f9acf41d-8044-479b-c37a-08df45a9a0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261028144727099003|261026140227099003|261022105027099003|261022113327099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 FonsKeLOBbvDaSRbpLUga4jHBbAuYFuqbdMvLqHXilxgk9TLKO7zE0t1YzFtP9WuPu+UeRiuNaUfPGRd6B+6kSBgqTFtF9PsFx72+nE3JNHrWqEmFgHM80Icc0jElHi1dyP+r/vm8cjAB3csvcWcbdDiBfqIxkK8kqAYN4SefIRazdxbxCUw1erTk5xihwRkttTBM4YxwdG69/FafOMaVIHRQdzrA9DVN/jhgOxJU7z1jG3b+P1ggxg+B2LINc+04IOvsFJVo17BvCo0eeuolI/pQARhxivB+TN5L91kOTtco+PsVSEBdwY1xbNMQmdNiseghudM9fg8t/ry9ZVOTfVZDrasUkMMcR4rjMfOE5lbPxdIidX2GPypBX71pjeFR5boc/ugX2enr3AxUTqdki5bDdWp21arF9frg59sVUud7U8/zlOlkpJYHtGfIm+w+bFQG+9dywEN19HWCRUtITtFK6zx66g/4In3coHqeDzFUQ8MApLymqDacSF0PVCiojuH+3vquSFVAmhQprNS+TbislEPiLO2R3w/KRozP4kn+zszSNTm5bgiFp3uJQtsapyFkg56vgEl6rXTibPeyPlGCe5xZjgFJD9siW2gRJjscSVIf4YGqQejzkDJD+Q5SohYL8KSCT4KT+QjlA4WPvbYLY7eFqVbRjOrhgTuLdrAIP+XMTHrshVEBHMv8778U1K5s/GZjIIc3h5yvX4Awtwi/X2KCNTD2poET8HQs94=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022113327099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AzXbLUmAdN6hacKM45rOPhZDgzrfhcKl5+7h8jWuXXmg12aJYJ5knBC2dvdQ?=
 =?us-ascii?Q?zhNrymfKj0bocVwd9kck+8YvSMqeDzk6VG8/pXEYwJsEU+eBLe6Qp0tCCwYI?=
 =?us-ascii?Q?Ixg1OqJP8EQcaGSrYtIPwD2nPfburr6K/zQRD9I+IfqDSuuoSIuN0i29Chhr?=
 =?us-ascii?Q?AJ3Ev9q156LJwxvf8M2ggTEZFWI/PLfGO/vUw3VAILOYeHmCrasf6Ae/4+Xf?=
 =?us-ascii?Q?UQBQ7G6VVxkMpNy/u5q3P3JlBH+nFVDkxH1gBXIj2xLvoW158+jApJnoA3DX?=
 =?us-ascii?Q?QSHH59WF0dnFHAcUXXBFbCM9KvCpbVEkN7n469rFsD2SGxsYLARxkiPX0iPa?=
 =?us-ascii?Q?OTQQ4AzxGa1z8raMdAEjDZ0PaqXuoWE1g8669N+9uxkmeSHjCm2oWzpUthRm?=
 =?us-ascii?Q?to92/I09uEx23jcnZXzgjoKQ+i0lQVJZPHjmJ0zNm5zlrRASnDMBdU+Puf+D?=
 =?us-ascii?Q?sPIswva3OvViosa8R6ssr8H1T2o6i7bTGgpqJbkuMrXXC3Z9usrUNttVTs7h?=
 =?us-ascii?Q?jqEziDX7mKdwr9XGaQ2CVDQvP1Jj2uUvCjX3kzgczJR0mzVw1zkrG9j9+Ouy?=
 =?us-ascii?Q?sm4xpjxXXZAPDwwtu3H4zlCrGKPimKhgyuoUCMsMylhCd3TkJiUOMKWLfoew?=
 =?us-ascii?Q?k/cWLtfqGvUsYkfXPYJdPrlGsw0DZdcpcjb8Qp2dlYp7TLgssoM0QjVb2t47?=
 =?us-ascii?Q?9/DjjgKz3uJDEVo57WuzTnEEgRtSSooiNfeTK3hqYLCA8FamxhAEiaSGCdUi?=
 =?us-ascii?Q?Ilv7TmhDCIhXO+ZP09NyKhpjZkdIedtaD5ASztpTcWUEh5I/C28dKFwQVyyR?=
 =?us-ascii?Q?ZptggyDi4PKGz0kMvxIv3OHJhWOu8OJSpioaRR2RtZoG+fzSTAFM8H93Vifj?=
 =?us-ascii?Q?C87dMMCBPAr+FlMEdy5SANNN5NJaa3ietqDYJ40kePfSE+9gUlYj3rlYE+nY?=
 =?us-ascii?Q?RRGY5yJLbSJXosoDtb3C+CIVxcBJKLjaZOuvUCxi32C+V1Eke0ZBHcDUJTxi?=
 =?us-ascii?Q?exf42wKfLVUWNR9S0W+TPPj6w6UUx/4xcf69Z6q4dWf5nLS0F97QV4u0IxGk?=
 =?us-ascii?Q?t8Bjrbpoj65/wInBbBLej6+SEQf+GCTwKomWR5kmBZclM3K7VJKgJvn/F+Aq?=
 =?us-ascii?Q?NVLSDKtLm/nBKicrom5bGqDlEeIUnOuEVZKSRa/e9m2TB1BSTERDmUUVdqlA?=
 =?us-ascii?Q?wwGC0kTJERQ4L4/G9dH4QvRkULqp8Qy0Cb5Ru/yYOp57MtK8drZOGhxqbSrs?=
 =?us-ascii?Q?/5Pdc0TRABVIIZewIcBrgi2CF1xQhUxhlWmR5TwRrQm67HsY4XGDEEDQgWlA?=
 =?us-ascii?Q?LOp2sEXOWkqCtBGh8tlzSuavzqbtNu0g1QJX3R/+mDqNSEBv6gG9sHaa1Ymh?=
 =?us-ascii?Q?71ReRscJLUFXQXyX9NVkHwsfFqun3/p96QI1dZuMt1xKQwpvdZ/MIjM9w+lr?=
 =?us-ascii?Q?Qz3UB2ATm6m4kQsgeHdtSGhT9EfB5tfd/wzrhu1YYGzgMpP8DUONN5H/Wsao?=
 =?us-ascii?Q?WsKHafIqwOQTlKM4alPCvxm0IHfvtpHH+MicJaH/OFUySE8KkzVCnZZ6XHv1?=
 =?us-ascii?Q?V4jm+G9E9rlPEhUF6tgTTOm0LNGOuntw7pIw0MM2SsAaizwaWdU4zL8u7uZZ?=
 =?us-ascii?Q?BU5RShVBDO5vnKIkXuNUmknGNbBj4WtHMZl5OmCxsxog2vv1i3UcfpGpyNA6?=
 =?us-ascii?Q?WgYd9BrKoLpYBsjU1el6r/TIafz5MrwOAoX+8KfCxWggvL1q?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9acf41d-8044-479b-c37a-08df45a9a0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:55.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbLFx3US/MQ9MCQB4wOHf++u0kI3hLDdhG9dFg20JMUbFZuz5nw/a3iTqj9OOhbX17rKUZQ70Vk5MKMG15GBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, November 5, 2026 5:23 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v6 03/31] cxl: Move component register defines to
> uapi/cxl/cxl_regs.h
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:10 +0530
> <mhonap@nvidia.com> wrote:
> > diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
> > new file mode 100644 index 000000000000..276f9361c840
> > --- /dev/null
> > +++ b/include/uapi/cxl/cxl_regs.h
> > @@ -0,0 +1,56 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> > +
> > +#ifndef _UAPI_CXL_REGS_H_
> > +#define _UAPI_CXL_REGS_H_
> > +
> > +#include <linux/bits.h>
> > +#include <linux/const.h>
> > +
> > +/* CXL r4.0 sec 8.2.3 Component Register Layout and Definition */
> > +#define CXL_COMPONENT_REG_BLOCK_SIZE 0x10000
> > +
> > +/* CXL r4.0 sec 8.2.4 CXL.cache and CXL.mem Registers */ #define
> > +CXL_CM_OFFSET 0x1000 #define CXL_CM_CAP_HDR_OFFSET 0x0
> > +#define   CXL_CM_CAP_HDR_ID_MASK __GENMASK(15, 0)
>=20
> A local sashiko review asks if this new uapi header should include
> asm/bitsperlong.h since __GENMASK requires __BITS_PER_LONG.  We include
> the other two header dependencies, but not this one, so it's a bit self-
> inconsistent.
>=20

Okay, I will add it in v7.

> BTW, current guidance on the Assisted-by tag: 1e035297ffda ("docs:
> remove Assisted-by references").  Thanks,
>=20
> Alex

Okay, I will drop this in v7 and update the cover letter as per new guidanc=
e.

Thanks,
Manish
