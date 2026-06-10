Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9D93EB0F0;
	Wed, 10 Jun 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086386; cv=fail; b=m8drVJ7bNEq24U5JcjD1hx/xbSvf3PIkPPC8XpC+gmb0Jm4aJv5cZgaDjx+mwwcjySaoD3El8U8yHAfLuOaySNbUAsTUHclhREZ0VZgKq0+pc7T0Qq0TUykw58t1Rm7bCL/fE1CZl/MVXw1wYso0v84I8Wq4FbMR0VvKjzk2RdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086386; c=relaxed/simple;
	bh=tgDI7+JZjo1JNjjp1TaI0VNFgb+H5anIPuXfBlgZbDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtmEjvtJZ72CY36OfWZxfL8fTfVujkDQquPCiBsHbC6bkH8BzZJ/NgfXoG2GGxMEtGw6oi0m8AVpb5VbL+oLttnnyPp1kuLjo6lW+pxzDX/IL5SVJomBf7jOPbf7u3yNEerq9Bf68x+re6+HfamrlZueW/uqH00prLfHTELc4Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=js5pVkW0; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="js5pVkW0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taF1HUmQqR1JvQJomkt3KlC/jcQXfA2bfvvKkFrpTWGq0Ql/qWSuAPm8bM/Bu1Rfy/F8QNait5Po+h4+YWY0rrmSCCNFgk7vcKzAoyFiLvBFjPUNxXOQfYWXo6swEG9oOdds/MsvAPOS77CKEowK4RvTI7/nqqgFlVIYICWHKaDXFsbIeusBVCsFiwQCHqqHJilD49iPMefxaLiMfzieq2C0Ll3fNmuqbCFrbgN4S4x2zhjVev+lsrXrX17JZPgfj6L4eyrQUA/zQbRMXejdzOsLPgfScSr+OBJTdZfeUg/ocMsO5y9z1arDFh8YA4+uzRy3VYjnRGBCn6yok8y8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgDI7+JZjo1JNjjp1TaI0VNFgb+H5anIPuXfBlgZbDE=;
 b=aAj3gvYnFdVZzeujHOTJat4iDEZV2Y3Dr1sVZoZQitxtssOgteIeq43HRUVJntTyuYTHRETMjUMyLVu7NBPFHlqVpg1hNN2c4duEs0tIhjmJaNj8hYSxWdgJwqrrrzw+mQMvMINL8xU6uBslTkFMyUXxILmBcCJy+Gwzm1t6xe01HTBOc+d0hgi9sZpddpHu6Dvzn2fBii1wsmZ3DeGKf+p/2rVZB1aRumK79YjtRGZbc+gNDuLG/G7r8GHoZTh0hFvjO+n4pMmrPfFzD8AR2Dy4TATeH1isEhKxj7LTtv4ZnCCCqyP6umgVkUmd+40LMbhr93BxpjAC1JJyYBFbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgDI7+JZjo1JNjjp1TaI0VNFgb+H5anIPuXfBlgZbDE=;
 b=js5pVkW0nMXzLiBc9ShhVMbhylXWA5V52cjtUo8wsRyPSQxG9oV34s3CsLcsIbyePwKa2WraJRVtregLlPAcSfgO0kX76ITM3hl7s3dJxr8MTOqvfBWNzNn5pmG35gN0sqnBRtxxbiY2KtxXi0C4Fbhrgh04Gi1OX2afwQALq2d7+nYqhpPXffV6/fKLwG5g5IvOrcYoCvI19rY7IkU4zFCCX4FAh0EujnTVIIt7Xf2fqjGymatOrZ8OgRSRRRbi0aBxR3s3oQ2ju9XFiWnGv+Sg+r1K6+fVD6+67sxe5FHGRymTc4kqdDk5NnmwOxpMYhLciWffj3sAaEHA8yt66A==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11905.eurprd04.prod.outlook.com
 (2603:10a6:10:628::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:13:00 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 10:13:00 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply
 support
Thread-Topic: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Thread-Index: AQHc98EqSHx96zAXkk2n7RCbK2H3mLY1lPEAgABAkQCAAaAD0IAAEgQAgAALARA=
Date: Wed, 10 Jun 2026 10:13:00 +0000
Message-ID:
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
In-Reply-To: <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|DU4PR04MB11905:EE_
x-ms-office365-filtering-correlation-id: afab2be9-4dd8-43a2-183f-08dec6d8d9d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|7416014|376014|56012099006|11063799006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 +bZcUmKnYz7JLH/6M4u10AzzTfCiRpcTylpizjfSTwwkOIoRmF9nbZKjhO9t8C6lSW15FEICOjRQ8+zSCszhG8p4RleGSq2b2JnICaSE18rDbmYLweSuaW4AJJDRO3yEYDCBr/fN1ormgGJpI5QznpbsSf4YotmBXHH/XYwIHxlQFQ6MMV5+PUOAVkMqQhVh7S3HN2AG+wzuRB9jm5l1abN258eBslTgBr9YTfEzqVlWAeWmFN5cOn7WPTpp73t3Zd6JM+8/Z3U+iFB0evDugGMRLL0su71K0KuzXhU3k/mOGX1NlHwaWbF1AlvRbZrwR20jLw+3HdZi1PgN2ZnoWL6knTZclHO9EqWVEA9MBAdU6M3Obv9rNwUxvy+Q2GDq2lMdiIQ42bDH8wIT6hiifRh0hcQ+jY48AblDJvsx2Vs55uP+w9LrGULsmRZcjObKwkYOUgLSgJS4XStsPY7RngnWP4GNl0Lm/c5U7VOdaRG08oM8f04zwlwOmt7Pdwcxg5jz3hh6umlesS8HY7LjqLHvVXMibB9rshZy4P9u/xfE/SDsxUuiQgwNru8zyqiXvq+XyOi/qSD1DNxhIZg3CdwwlAC0u29i2GnCjPvBHsyAIhlMxE1eSSdJoJ70uZTgR+p90MwGE9KEq945otYHs+Yidfdgm13Uv99uu+49dmb4fstcZX5eHy5ntW1RvHNh320eq+N/O/FHZBTtGFJGugkF71OGS9wtupQBeVGWmw2AkPmbZWUwnezK/HXPg6xt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmlLVVR2S1RKZkRFY0NZOTQ0akh4Tk54TkV4cWhtWUlFUnhmOWFuZDZiZHJS?=
 =?utf-8?B?cHYwRnlJQ0VIMEN3Y3Y4WnJOVkxOWUJORzU0elF5eDF0RUU4aG54U0xGWWxN?=
 =?utf-8?B?WmxYZldXMnB3eE9MS25HNll1NlZVcnlmanNkdml2Sno5S1dLRDR3NjJxQTNm?=
 =?utf-8?B?V3ZCcm9paVQwRzlObGdBTWl4eG15dFQybDRjRVNnKzFwRS9JdWxQT1Q5YUVZ?=
 =?utf-8?B?SDBuZHU4NjlERnJGUHJsYk1LZU9DWStSekZuaEdQc2cxUkhvYk5FM3BaV2hY?=
 =?utf-8?B?b3BheDNRUWxYemY3aS9EaS9RcHdrK0IvczNrZlVvbzZadmhZQTQvQXFLajBG?=
 =?utf-8?B?OSsxa28wTmxXUG45bGY0VTA5R3pVMEFaVE1YeHQxOUNEeC9BMHZKM3FGUnBp?=
 =?utf-8?B?OUdzMkdlWTRSSFZZc3ZOMWdGU1FqVTgrRDl6Ym1tYTFBVkovUmxsc2ljTjFO?=
 =?utf-8?B?THNoTnJoYzM2NnNEc3VMZk9wYzErUk4ycERzTksydEpheEIwQmJiQlYwWHhy?=
 =?utf-8?B?NkszUFVOaXpEU2ZDY0RKN2pjYlJYSXJBZWV1ODhQY2RoVGN6OXc1aDdRTFhs?=
 =?utf-8?B?L2tKaXJURzJEZ0s5TWZwaklLMnRpdThJMUFjd0lySW00NVFGUWRieWVNWkJJ?=
 =?utf-8?B?L2lsQi95WEI4SkVIWmt5NmxLVDVTVC9pOGtpTUFYeW9PWCtMQnp3aExvMnNo?=
 =?utf-8?B?dUdSVkIwM3lIM0x1RkRraDJoMkxWM3prNXkzdGZISUNNNU1ieWFEUXlPd29q?=
 =?utf-8?B?Q1YzMEdpVG91eExEaVhsem0zWVRwRml1SzZ5VzBxQm80RmhoR0hpdkZNZ0Vj?=
 =?utf-8?B?UTlEUWJQY1o4a3dZQXNPNFRlcTc1eEFrU3BnNEFmVE94ZjU1K1RiRHRmQzQx?=
 =?utf-8?B?V0JFWjBSUnhyVlVkUytqellZWnBlOTBiMEZNVzFvZmIvYm1iODJwYmJVamtL?=
 =?utf-8?B?cmFiSFdwZWVsdmRVMkYvOEZTRUpjUVlxY2RvY282WDBmTGRRcC9VR0FhK3pu?=
 =?utf-8?B?QU1LekxlcXl4MkxrZm1tektQcGZtUWVWaWd4MmxOTTM3UFZxUVN5b3dVSWs1?=
 =?utf-8?B?eVpCbTc3N0JybTd2UHV2R2ZJYjZYc0NyalhHMHNzRlZxWUF2UHphM2FhSlFh?=
 =?utf-8?B?OVVoTS9jZkFncEovaE1UWUU1eUtlTHV4ZWZpS0w5blhFT3RqWlltT1VsT3gr?=
 =?utf-8?B?R2ZIZGpVbHYzWU5raitSQ2NkN3djTEVKN0FOcmxSOWYxMnlOWngxaUpkd1VP?=
 =?utf-8?B?ZlFVYkl6TW9aQ0dNTUgwVEF0MlYvdlRTWFpvL2ZLN2dkOVFQWW9CVTh1cHJC?=
 =?utf-8?B?eEpXZVBXM2tRRFhLZXF1QTVOTmd1N0YwcTQ0OEU0ZUxza294Ny9GOUc1N2lZ?=
 =?utf-8?B?Nis1SjRRbzFjN3ZUSnNldVNpQkNIeHo0VVlLYjlSaGdXN2FmWkFNU0l1TUx6?=
 =?utf-8?B?eFMvdXh1ZmlKQ3F4M1FqUTNXZVEyRGZ6QUNWTXFGSVg4VENlN01TMzFPby9C?=
 =?utf-8?B?ZzdGS3pLS0dYdjdXbm52N09uMW01NTNxNzJHK282VTlMeWZqeEN3aFZTbHcz?=
 =?utf-8?B?TE1JeGFxVkplZ0xWajZjK0U3emhSZnhwcmEwOUJFTDQ1VVBjVkl0UXBKYXky?=
 =?utf-8?B?NzVUTmlwZGRNQmxHRThKbUJvWFZhdEhlUWNCQjZnYmZONUtkWWl0d3RENHd4?=
 =?utf-8?B?N2d6Z3VPT1VENmFIRmFCdVhma0s5VDB1d1krZk5lY3l3Ri80S0JuWlJZMEpo?=
 =?utf-8?B?ZHdjVktDTnU4Vi83dHlwOXlYb0ZIR2tSSFZZUE4yQkVsOEl0NGJoeHJYeXNh?=
 =?utf-8?B?ZVY5L21kaUIxcGFxMlJjNzVQYlRNTVlXOFkzNFNZVmMzSjJtZ1NjdnZOVnlw?=
 =?utf-8?B?UVZSSzJlT2dTWS9ETkEyWWtqZ1hrZlJCTVc3Nm9oeDZ1dUd5clVhRnB5SndN?=
 =?utf-8?B?a2RVUzR0MVhjN3NEQTNQczIzR1J5SEhBd1pvUUxBcHRFeWNsbmw4NE0xelJH?=
 =?utf-8?B?QWtHd3M2SmlNUEFiOTlsZ1lqM0VXbW5aMXNqN21ZdXlGaFQzcmt0WlJ2a2FK?=
 =?utf-8?B?dlF2dzF6ZWV2VVE0YU9zQUIwWmFaQzdDQVBRY0UwTFo2Z2NFRnpJNHdMSmp0?=
 =?utf-8?B?QWdzNmhVUDJySkY4U29UcnlDalpQdTRxd240bWJ4bFRYcHE1WXVqRU4xK3Bm?=
 =?utf-8?B?K1AvTGk2OFNDNVlVNXVmUXlUWVh1ZjZsNjM4Mm5FRS9aK3NqRWJqVE1XeTdR?=
 =?utf-8?B?OEJuaWRRbjRyMHJmSHdSWit2U0NIT21Vb1VDV2Npb3Y4T3AvOHJreEJXbTFm?=
 =?utf-8?Q?ExW+FqZfFSezq8XhOM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afab2be9-4dd8-43a2-183f-08dec6d8d9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:13:00.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YirI+g2z+0mPh6YSF+Sxd03PBGa6KPH23zt5M7LpghkELM11mzpZz4VoS3ZMb+vIYw2K/BVxM/0DW1F4UAwH2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11905

PiBPbiBXZWQsIEp1biAxMCwgMjAyNiBhdCAwODo0MDo1NEFNICswMDAwLCBTaGVycnkgU3VuIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBKdW4gMDksIDIwMjYgYXQgMDM6NDQ6MDhBTSArMDAwMCwgc2Fz
aGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNv
bnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMQ0KPiA+ID4gPiBwb3RlbnRpYWwN
Cj4gPiA+IGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiA+ID4gPiAtIFtNZWRpdW1dIFRoZSBgdnBj
aWUzdjNhdXgtc3VwcGx5YCBwcm9wZXJ0eSBkZXNjcmliZXMgYQ0KPiA+ID4gPiBub24tZXhpc3Rl
bnQNCj4gPiA+IGhhcmR3YXJlIGZlYXR1cmUgb24gdGhlIE0uMiBLZXkgRSBjb25uZWN0b3IgdG8g
d29yayBhcm91bmQgYQ0KPiA+ID4gc29mdHdhcmUgcG9saWN5Lg0KPiA+ID4NCj4gPiA+IEZlZWxz
IHZhbGlkLiBEZXNjcmliZSB3aGljaCBwaW4gb24gTTIgY29ubmVjdG9yIGFyZSB5b3UgcmVwcmVz
ZW50aW5nLg0KPiA+ID4NCj4gPg0KPiA+IFJlZmVyIHRvIFBDSSBFeHByZXNzIE0uMiBTcGVjaWZp
Y2F0aW9uIHI1LjEgc2VjMy4xLjEgUG93ZXIgU291cmNlcyBhbmQNCj4gPiBHcm91bmRzLg0KPiA+
DQo+ID4gUENJIEV4cHJlc3MgTS4yIFNvY2tldCAxIHV0aWxpemVzIGEgMy4zIFYgcG93ZXIgc291
cmNlLiBUaGUgdm9sdGFnZQ0KPiA+IHNvdXJjZSwgMy4zIFYsIGlzIGV4cGVjdGVkIHRvIGJlIGF2
YWlsYWJsZSBkdXJpbmcgdGhlIHN5c3RlbeKAmXMNCj4gPiBzdGFuZC1ieS9zdXNwZW5kIHN0YXRl
IHRvIHN1cHBvcnQgd2FrZSBldmVudCBwcm9jZXNzaW5nIG9uIHRoZQ0KPiA+IGNvbW11bmljYXRp
b25zIGNhcmQuDQo+ID4NCj4gPiBCdXQgdGhlIGN1cnJlbnQgdnBjaWUzdjMtc3VwcGx5IG1heSBi
ZSBnYXRlZCBvZmYgZHVyaW5nIHN5c3RlbSBzdXNwZW5kLg0KPiA+IFNvIEkgIHRyaWVkIHRvIGFk
ZCB2cGNpZTN2M2F1eC1zdXBwbHkgdG8gbGV0IHRoaXMgMy4zIFYgcG93ZXIgc291cmNlDQo+ID4g
YWx3YXlzIG9uIGZvciBQQ0llIE0uMiBLZXkgRSBjb25uZWN0b3IuIFRoYXQgbWVhbnMgdnBjaWUz
djNhdXgtc3VwcGx5DQo+ID4gYW5kIHZwY2llM3YzLXN1cHBseSBhY3R1YWxseSByZWZlciB0byB0
aGUgc2FtZSAzLjMgViBwb3dlciBzb3VyY2UuDQo+ID4NCj4gPiBATWFuaSwgZG8geW91IHRoaW5r
IHRoaXMgaXMgcmVhc29uYWJsZT8gT3IgZG8geW91IGhhdmUgYW55IG90aGVyDQo+ID4gYmV0dGVy
IHNvbHV0aW9ucz8gVGhhbmtzIQ0KPiA+DQo+IA0KPiBUaGVyZSBpcyBubyBWYXV4IGRlZmluZWQg
aW4gdGhlIE0uMiBzcGVjLiBTbyB5b3UgY2Fubm90IGRlZmluZSB0aGF0IHN1cHBseSBpbg0KPiB0
aGUgYmluZGluZy4gWW91IGNhbiBkZWZpbmUgdGhlIGN1c3RvbSBWYXV4IHN1cHBseSBhcyBhIGZp
eGVkIHJlZ3VsYXRvciBpbiBEVA0KPiBhbmQgbWFyayBpdCBhbHdheXMgb24gc28gdGhhdCBpdCBp
cyBrZWVwcyBzdXBwbHlpbmcgMy4zdiB0byB0aGUgY2FyZC4NCj4gDQoNCkhpIE1hbmksIHRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24sIGJ1dCBhZGRpbmcgYW4gYWx3YXlzIG9uIHJlZ3VsYXRvciBt
YXkNCmNhdXNlIGJvYXJkIHBvd2VyIHdhc3RlLCBjdXJyZW50IHNvbHV0aW9uIGVuc3VyZXMgdGhl
IDMuM3YgcmVndWxhdG9yIGlzDQpvbmx5IGVuYWJsZWQgd2hlbiBNLjIgY29ubmVjdG9yIG5lZWRz
IHRvIHdvcmsgLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
