Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714546;
	b=deXDJ7oxXVpbnAWpvVt3eGtqEB9ALFLlG2U0GVnEFoAM8olElpHzzSNiSt9MUWmqlkio
	 y0bZGi3WXwZSNzAb320zXMSkTfL0eem5OhrtP1h8fqkO2+nIFJmXbtBEBvkq3jUCkpYzs
	 +qLlG+WkggQXHs1eUhqieEA42cnfY835/ArlBilcioslxw5YB5KLoE0ylXuqLVdSqiLWP
	 L5NtF/BK4BtugXeeyxHbSl/4Q3fTBTmJrCmT2ygbZPManwayq0kxRB5sofhvZDdN+BnhX
	 N+j9ItXCzzc9etihRr2rlJfieMBLg+tTNpJVHwiN9xptMt5Sckz18uoK2Iw1G5ZJcXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714546;
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
	bh=eJz6V+vCcusw8QUZN3mYCnQieV3SIdJVnZ238VfVRSI=;
	b=hFxPBgbT8iQjnx4ETRvMy1iN1bdPQtwckBNXkm71hXIWuencC8H+JHEZuYb2uiqkGxoF
	 S4rysRVKePQJ1TV6gzrvCfRlr7vGCqGDgF1IJHDSkQs3bimMvx48/ezBq8U7CVC4ooESj
	 F9Ucjb0Qht4DhxA03VvyOgdWV63xtFzk5+zVics4uX6ksq86YFmUcsUrHEmafCXAUtOKO
	 aJzBT1y78kNuVk4fxdBZL58vtrAPf25ZEy3p1uV5FjTGrjvmScaHL04mxCMC7+IMj+Cfg
	 XnHQK12I/QniEBZn5pqCjV+pjzhGOOQSRMxv4KboqfhQ9tLIDBblBqQN4efUiisBuNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HXlDXeL8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.25
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FE606EEAC;
	Tue,  3 Nov 2026 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 148FE606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HXlDXeL8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8r3OvT4SViwU9aQGybeeffre9zAO1Ai6tq0qHGgTejYZ04ohkicS6/ULf7THLpTPqlQhWf8ZGAa4R4oLk0zBFJiZ8ee7Fwfqte9t9cqfelg++pYcNPeSEXONyGqFkE2TTvG2kycySg+XfWL0LrpvEe8MEtHontsIkCfe21GGh1MrMQRj3rCxnPDLLXJySSddk/IZ3zb43JP7EjTszC5NF3tHohPKiWruvB6zewG/3D8YD2fRb84v/VOy/O5RYf5r2iqAlvdSrJpOUZ61rN8MOyxtFyqKINAcfA7v9tmi3lbgzvPXYSZtrXgZDxiXnWF+u6oMWG5Rj9vXwlznGJZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJz6V+vCcusw8QUZN3mYCnQieV3SIdJVnZ238VfVRSI=;
 b=t4h3EqjjrrtIZdOqa+NJUbPq+HnTognJYaSCSFny8Ug2HgtoQdPX+Cdf3N1kanX8gonCrPbgI4qldJJtv+9s1wJCKACOAAUAwwQQp1C3kJRJcX4n8+8XVo5DWHQL8slSN+RKQS5JnpcQPDeAIvTEVvbqFQZWKYXoqr48UvjP6aU9H5oUtmovFedXv+427KzL6AOcAqs9mb8vMHUx7n3i60wZkEamJGibjfWp8zyddLcQRmdNrNWKdey7gmEbRJs60iV9qKXNRGXNa9HHtzpdx3RU8MkzvA1vPuTESB2HViCF7Sve6Hjsld0xqWn0wvC/SKH//H5WdOHZqLE1hjDtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJz6V+vCcusw8QUZN3mYCnQieV3SIdJVnZ238VfVRSI=;
 b=HXlDXeL8YVrV5tVHyB/UxsAd1v1HjZlZKwsga1x5bbFFm0uR6/SbuuWQUW+QqID+vyUfJI6/TUgBDOvwY9Ah56QUsli9OYQQmOu0rfqopaNyBSnPtL0mgl6pDCcmMAR49LsINo48Tm3/FIIqAdYKRkFAMHzHqXac2fvusZ2AlCEz+YUKOR64svFxwLSYSe/HrekKbLyuv12LGAAg8YsggufJrgzm8jQ2n9czKSjsE+mio17Ftm5Wk4Phh6JpLBqVXCHvQzdoCOKz+/se23i78pzGSK/AorZK0siTbDOIf3G+2ykKjx5odV9zbt+RyaGUwImL80p+azn3UNduQpt5zw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by GVXPR04MB9926.eurprd04.prod.outlook.com
 (2603:10a6:150:11a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:02:22 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:02:22 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Thread-Topic: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Thread-Index: AQHdXUZ5Jq0x/e3NWkqoB83Xfg0wR7cceldQ
Date: Tue, 3 Nov 2026 14:02:22 +0000
Message-ID:
 <GV2PR04MB117408067A4647C476FAD617596692@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: =?utf-8?q?=3C2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
 <179213850739.434549.5377140925132800234@kernel.org>
In-Reply-To: <179213850739.434549.5377140925132800234@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|GVXPR04MB9926:EE_
x-ms-office365-filtering-correlation-id: 34357834-3183-4d97-d47a-08df39b31511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|38070700021|56012099006|261021123027099003|261021121427099003|11063799006|5023799004|261009223027099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|10067099003|22082099003|18002099003|261102123227099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 RKK3N3d1oEgb809/oMauMZkGDzlSGXKsYPH1XzSBUUagr9icTHK/FAZ/P25rblDdO1ZNEmGsXuv0nPUXjiuETahwoYXRmsS1+G6SAu+8HEXepXQOd5I+Wlm75YbslBo8U2VRnZpAQE+jceUnKvOlorCkFD9nOzplNdTWw4ja/ddLUHDydeEXlcoo1cQPmIGasHBjDEo7PCDTmMBkLEj2mvYlPAvlY40F2m2tzlGH/pHpufyY1xPUZWMCYSbF75xprYcvWgGfeqsjMV8CkMvDU4wwkTgqfeu9dMpWnP+2VYmikzvq9BNv6PYHVhCQJw9tGZ/bD6K4Cy61u5/ufF3ZY+eYsraKBfVBsUl2LPfvK7TOanTCIvQN+I2rsriLaZbCH95TMdSGK02qD9ujsbCH+MC7i6Z+WBV5E+cicWjJ26q5MBqH38P1BiTTtG4bFFRB0lusj1ipkIUOCLkQdT6tqeswsAT73yVhssO7/HiwKDxVn5jXoqLRC5joYoGpOQxOy3Bv22NBH7k270JJlClUOTRdPD8OTbUjkYMI447r2XKS0drLaHpBkvjIcFIfiufBnJH03YsnFIU19MaeZN9pLboqcfQMmrtmjONKq+j/OIqCIkIN8IwknkCMrhe4zJoWZZDuvCjnhDDKFRcqvdWIK6OqihGE9ov5QdSIOfX+sFBwDAORrRnSEhQ75WU6qbuE84skQaZTcErmtBwSsvkl9QjLDSplt7A1hCC6Cm6xp/Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(38070700021)(56012099006)(261021123027099003)(261021121427099003)(11063799006)(5023799004)(261009223027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r7PVW+xnD4P3w431DLx+uSfIRr3iQPsbMyUjMp85uMn4oCSQTSidVyx9Deij?=
 =?us-ascii?Q?UDIABYjfXqrRrZZ5TDTS8Gv8WdRGufs8lY62zbjun/oCi+bR4nkJIFjD9j6i?=
 =?us-ascii?Q?2s40VHiQ3HFbOloA0xWiHORrFWHo8v0P12jZn3oVvCTHFAyk0jI8jYFcYNk1?=
 =?us-ascii?Q?ShU8nNqnbBIECryzYK0MTBn8oiJDpy6+Tq2PwJRKIjyzcHYn0pL2uxhUkOP4?=
 =?us-ascii?Q?kKOtn4yQ5LqxI2OHAYWh9OvqSTwI4osLhhNaxuWRLcNBA/nxvQte8w9xfaE8?=
 =?us-ascii?Q?W1dQCXvrnjW/epUW9N1Z+cfisz0DBA6T78E6k6hBA2n8qRxcLCB1ahrD3Tyf?=
 =?us-ascii?Q?T3jlJw515CIHgfct0UrC65ULkyjBesVn5byKGjLsJ/R8Cvgxdw5QXZLCAS7/?=
 =?us-ascii?Q?9cfkpWcc248pAGBz/HH9Kf/O3nMZRXEIMiN5PBglyypu+YmbcaiGudWBf5z0?=
 =?us-ascii?Q?xwfF5L2euwjXcMp67S0SHEivtHjfX0C5NxMaRcxk9YDmv/t57gFB59GLQIbx?=
 =?us-ascii?Q?OpzDby8MLQ3ulku9ZIBPV1bqRmnTxrkSV0wKhMMxJJfU25XTIMJjuwVeM1Ib?=
 =?us-ascii?Q?7uM9U2f+TCs2/el8UbBVhyWQtuinIJhnRyjz9HfJ/lOFWKsCIpul5JSMO40x?=
 =?us-ascii?Q?bkO3wjJl1YYNKncs8ETj7XirRZtyQQ4IGoFehPZKxmcG7Mzuh7jQiu1BDnGA?=
 =?us-ascii?Q?T8ycI7eVNO7Mdfp9d1QUl9oDfyVb9dIx80ezivPlUw3Lw4HJqbdaUVXlk3Ek?=
 =?us-ascii?Q?vC2RsR7HxLO7JDGPrOswN50xp73O878eIGnwioSRKSz5+HXZ/Vu52eQwBpOD?=
 =?us-ascii?Q?UEDPE0TsILviyYZbyWdI7KeZ0hpCr4KM+g1v2zh2KGTWcgkEp6z8Sdwg8nOT?=
 =?us-ascii?Q?eSlSTQJt16aV5oau24wefRDr2gRKMScUEJ5W0S2O1yVtMlvr7fW9uskUsP6e?=
 =?us-ascii?Q?3ETzrSSJBUo4LhfFr1A8xK/GJz4ROVP5JM8NOEVnFo37spEa9zVYta84ArzS?=
 =?us-ascii?Q?FcfGQSb3Cmzrq7c9T6SPQa5z29lZQxmjj6Zv08Rij8/WiyiEx1VT+rJcZ+7S?=
 =?us-ascii?Q?kEGipR9B6emfUCk5rNhgpvrWC9I180MtS0IPyujRIAiSPobDebu0mxmUY6aj?=
 =?us-ascii?Q?FNWMuBrJc9Kuys1mFxEG1OCb8FRb0Uc99OPAIa09BHmGgpzKtOX8zSgV8Tas?=
 =?us-ascii?Q?gBiaKuuVYwB2UnpDCNxOKCxND4nxHV/Ft2e7l676b9SFtxAG4xjsiICc4c/3?=
 =?us-ascii?Q?bwLB16BPQcy3lP9u8ExBL4DLCkRv1SdD9npTHQSrW2hvVIEm2d0ms6GEoDzu?=
 =?us-ascii?Q?a6EPiFxuBcC5i7wzVFIkGo2w3Y8RCveXIur1memRhWBk4dnywyznan4ZnKXS?=
 =?us-ascii?Q?g9+awQ1xcWf9ptSnG+lafVKlxzLHm6r0yqAu/Fm0JCfNjuH44Bt2md18O54U?=
 =?us-ascii?Q?zU2AU3Wv8+Nusm1WlpxNcX6Saw5Kr6Nsbp0WYZkPYtdSlum5WH5tjg4iDY+2?=
 =?us-ascii?Q?QJuZtCT66CT2uqN3601nPGTDNuRYz7I3UjeGI/r/t8Ik+H/VSm06nyyAd1ck?=
 =?us-ascii?Q?13F7Q3JWdQ7QgkJ52wZc38Dr9Iw4kQDUpL5xsF76INaBceCiZRbaTLuAh7VD?=
 =?us-ascii?Q?ZFGyPKXOoCIwtgoblq7KVHy3H02Wy6F/3CsOjjcKKIzn/fKHQ1agHSK9gHJh?=
 =?us-ascii?Q?9QWFA9+9KxksQmkIl5NEvx8DladfcnNQ+GXk4X4MOD+dVOpknf5A8UyxLbtN?=
 =?us-ascii?Q?psXXZI/vnA=3D=3D?=
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34357834-3183-4d97-d47a-08df39b31511
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 14:02:22.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRk3ygh1rpJ8r4Qh0M+ZFoEZ5tfbRwrBTWRpqPi2QPFhtAgVQiCIe853NbAtnU4Be82iDVjj4EPMivtlb7V+sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9926

From: netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org>
Sent: Friday, October 16, 2026 11:15 AM
> To: Claudiu Manoil <claudiu.manoil@nxp.com>
[...]
> Subject: Re: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC
> pseudo-MAC functions
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 * Medium: 1 * Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] On the in-tree arm64 defconfig, the ENETCv4 pseudo-MAC (PPM)
>   ports this series adds still fail to probe.
> - [Low] `enetc4_add_ppm_fixed_link()` and its teardown helper in
>   drivers/net/ethernet/freescale/enetc/enetc4_pf.c call these changeset..=
.
>=20
> --
>=20
> PCI: Create OF node for NXP ENETC pseudo-MAC functions
>=20
> This patch registers of_pci_make_dev_node() as a final fixup for the two
> ENETC4 PCI device IDs (0xe101 and 0xe110). The PCI core can then
> synthesize an OF node for ENETCv4 pseudo-MAC ports that have no static
> DT node. The ENETC4 driver needs that node so it can attach a fixed-link
> child to it.
>=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index de9bbccda21fd..86f0a182224b2 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6391,6 +6391,8 @@
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005,
> of_pci_make_dev_node);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660,
> of_pci_make_dev_node);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101,
> of_pci_make_dev_node);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110,
> of_pci_make_dev_node);
>=20
> [Severity: Medium]
> With the in-tree arm64 defconfig, will the pseudo-MAC ports on
> S32N79-RDB still fail to probe?
>=20
> When CONFIG_PCI_DYNAMIC_OF_NODES is not set, these fixups end up
> calling the empty stub in drivers/pci/pci.h:
>=20
>     static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
>=20
> PCI_DYNAMIC_OF_NODES is a plain bool with no default, and nothing in the
> tree selects it:
>=20
>     config PCI_DYNAMIC_OF_NODES
>     	bool "Create Device tree nodes for PCI devices"
>     	depends on OF_IRQ
>     	select OF_DYNAMIC
>=20
> NXP_ENETC4 neither selects nor implies it. arch/arm64/configs/defconfig
> does not set it, but it does set CONFIG_ARCH_S32=3Dy and
> CONFIG_NXP_ENETC4=3Dm.
>=20
> The series enables &netc_iep18 in s32n79-rdb.dts. The
> netc_iep18: pcie@241200000 node in s32n79.dtsi has no child function
> nodes, so on that config each PPM PF enumerates with no OF node.
> enetc4_link_init() then calls enetc4_add_ppm_fixed_link(), which returns
> early:
>=20
>     if (!np)
>     	return dev_err_probe(priv->dev, -ENODEV,
>     			     "Missing of_node for Pseudo-MAC port\n");
>=20
> The commit message notes that the quirk "only takes effect when
> CONFIG_PCI_DYNAMIC_OF_NODES is enabled". The driver patch in this series
> also deliberately avoids a hard Kconfig dependency.
>=20
> Should the series also enable CONFIG_PCI_DYNAMIC_OF_NODES for this
> board? That could be a defconfig update, or a select/imply that does not
> break ports described by static DT.
>=20

CONFIG_PCI_DYNAMIC_OF_NODES is not a hard Kconfig dependency
because only the newly introduced S32N79 chip make use of this feature
currently. This is intentional.
