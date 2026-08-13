Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF533242B8;
	Thu, 13 Aug 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620536; cv=fail; b=Pp4tFhfJXAGA0Gz4jSupVAd8q7Sshke3KE4XKu15Y7ywvNkpqPwApUb5mIxk+heD20g2023ltNS3Ao0H1aSAku0HHudko6CyTg7SsYkGWRXiFuhtAOUTie7jr7K8WUiXxmAnyw419j5ZBvdLw0+yb9+m8CCmuUT93bQLDrXOtaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620536; c=relaxed/simple;
	bh=SF25IamisJzbUhbtJmDbQVA8/Okutmy4rdsNg75vRzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=obsV+mNHb98VMI5K3Xn4wJTCP8BA0QnLadGDatF13MSUmFqrLEIfpie8FCFKkowRJpjIHVOTPQIMVSBy2AKQ7ShLyqyk3Lv7b+Vv9HOI0SX9+KvGcEjF2XamU2T0cHmk8cMrWaSceUJgwP2w1TlaXisCfij8DVLYZ1g8NATgpZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rwn6zPkN; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rwn6zPkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlcR+HI3OeFINckJt2Bv+haGrg6DsYGy1MLKM2nSyIrK2ug6uDXRNYT3ay1nRlxQSunlp+hDAy9wDZ0O7gASGmoK6gi+09tne5jcbsao7kSEh97yxIkioqJBN+RhThKBFzWrAnPf8AVvORCBf3cJ3VXFjs5ydfIDR4w/snSaD4r4tCkYdJbAVGxhl9fgXsHDih+7jYABvPl0sBK3xHI4ZoqAvXhU337zUgcFWO1Q5v6hxv+nTHCwzpHNYQgVwHOpK4a9ppbdUXIm4ziR9ANgQVjkLJuRlmAWD1KPBDdmUxgdymFeNaTfHD7SskK3gaksT4sGUNmfGUn5CP+9dfY3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufMDJaJbFXxAzyHZp1CtM51AJBUqVSe+cL2MlnZnC7c=;
 b=r/L2vuDwpHH2CVB3JCUQIblI3N5+Yh4qKoCjp6JsaX4xJhwq+Fh94OT30uz1ZMAnMg+s/fMvTCT+QRpDuQuepFDsgdrFMvK7rrRKKcp844opue7NC682Om5nJDdFz0cztB+zjuUND1REslURO84y5QLd8nRasgTAIl/v5k+zf8uvOaADhVGV1aNCT/ou+K00reTizlvYXLVQwBCpVllX2NTEW8vnElRg3ujbKIxJOWmT0QhJ98hHP7ClMhrCa1HIuLVDlUDb0gnob3TZXai4dWyCxIu+V1Ou40plcK/dkJbtXFk7RSUbvRKvW03wQj5HjPgTpFlknHMwMUEWQfiEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufMDJaJbFXxAzyHZp1CtM51AJBUqVSe+cL2MlnZnC7c=;
 b=Rwn6zPkNqK5jt8ApdpiL1Cf1+uq7QElmUOh3/5WsBHeYp0ybvlGdWM8ohIf40H79ACkmNBMKDqVufzbowWVicd0ZagEhpiJnTLIZN4h5MXK7U98jThbE1bP/mpUEgVFx/XYD+I2mzSTaaOXZ46MAQwxczqs+8NmDhXOW430yeo8=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 11:28:50 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 11:28:50 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Thread-Topic: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Thread-Index: AQHdJyQcjZj/arEQz0K0GROBFqdvhLabDK+AgADR8zA=
Date: Thu, 13 Aug 2026 11:28:50 +0000
Message-ID:
 <IA4PR12MB981037D2456B74894EDA65E5CDDB2@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
 <20260808105256.3705889-2-sai.krishna.musham@amd.com>
 <20260812225409.GA1363147-robh@kernel.org>
In-Reply-To: <20260812225409.GA1363147-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-13T11:25:47.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|CY1PR12MB9583:EE_
x-ms-office365-filtering-correlation-id: 2d9e48ba-db7f-4834-582d-08def92e0c29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|38070700021|6133799003|10067099003|4143699003;
x-microsoft-antispam-message-info:
 DSAIqCeg5U004TMhj+bFwKBakLVLf/ZJpiGtmSAIOcrAbAUIfarClb7bOGHF5TZlDRcoRCDQZAjw3Ddy+S848hL+36Z7G+A1/ctQABf1fz8+smj5BePyM5ZZmHLmfxyul28K3qknBBcoxqUAkmhzastcAng6OWc662IIDskF91VO8I9tRS6+PNOqYhNUPP9ZClvkpYKmExCGmEZFQKDAyl71JnfU2XAd1gEpVFL115N9+c3YMwURMFPpypFJNT2zg/aknQetxviEs4fYIvYXuTT51Gm3qpvO8H99o2liATbKuJo7B4gAw6bhHgiwLEtOErJdKTz0qXFkyimZ0laHjqCPiK4BIzrTX0Bd2ltWc95MWIJixrptNDcdQO05nAAUOb2ejYhZJ9iis/tJ4ABKVEbA82NPmwOAH9MvAonMGzDCjxogVwfQlgfYhx6AQecXAmZjAkB8iIgf9rr3mc51YS60Pgad7zUCpCTi6tyPcxmKSOKqqqoX4wzc5MRTDgdBRxdZ4uYFXWXzH98J2KsOOP8o9MFylYeUajrrOI7dcYsCKePVkIeR/G6Ek/QYylltqbpy8nI5v6JwSXJmYkVQo5Ap+WMPmoPtz0VRjNKaoQnBlqPayStk7qzB21SgfrzLdEkKYnMopMP+23Ssr7tkc/x4LAe3LlvYMdHM7EHnBNG6yLAlTTC4EW4JMVrsLsOLgmd9C9In1e1jSTcsKObE6OwpqvXOnKitW1bPvMSzMGk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nbPMwrNqXIM+mE7YUB+b5gQkvRtLBT8T4ySVuW7Jcrgoo7KPY849k5D3ePmr?=
 =?us-ascii?Q?CADSGV/Au7o/0/kJ1Wc40QTgKdVEhCGDyXfihzd49EhrdP4bRdhdKYBt7BF0?=
 =?us-ascii?Q?y96AAYFzhrt0FCNP+6B+HeGyknb8iaKDjsAACAfVUuO14tiKeaP6/oL0dBZ3?=
 =?us-ascii?Q?Z+/uyjgf0OFtXo9Q/xg8U7LtclSaEkFwoTJox9B1Bj44xviZCL34QdcaV22J?=
 =?us-ascii?Q?c/RrpTqlo+tDZ4JB4/pwlFocSMjjayCwwLEWFfWG0MVnDwXPCBdw2nZX9HE0?=
 =?us-ascii?Q?MwhKtiRAZYjTv1yMIxYMQd73qTK9OEGdYnNKJiat6QSwley/VsTgBQJlIjoG?=
 =?us-ascii?Q?zvaSV7v0KKlV2wS+GghNRIBTE28ksOJjX9ATk0F8I0TeSiXNjMtkeEWTYUOJ?=
 =?us-ascii?Q?xHv9kxIjbWxXRxm2luMayHub80e9o5WV1wmKuKzC85fINx7jHSZKzwBZ01P+?=
 =?us-ascii?Q?ge/hpWbKF7kJJKkBSvOYfMJ4MjwLouzEVZG3ekQ49oQDGMHwMTe9VzeEswRp?=
 =?us-ascii?Q?sVla90GMW8IDsJF6ceKta1iOb1Fk3yIurfbCI8IXACj0NCmqP55P2QOBz6bo?=
 =?us-ascii?Q?mP8T3xu0NQJUT4nwbAnCPZKOJ+Jh9wpatSUYC8wgIxOUrq5OuxMmILtRBcYH?=
 =?us-ascii?Q?aJrEkE6T/mGzwzgytntWTmtoxFIXw07d0du70/llTpRaVCL2acQUm7W/ahgX?=
 =?us-ascii?Q?+1lY4sRnZ4MjC2hUe0i6Ln8lBmrX6r496EAbyPVgmdqqP30zsxv44ieS+gry?=
 =?us-ascii?Q?hrxjOls7fMdAGQjMp8UsteJWKPnXBdDW1ktmOk7DbNj09SVMjGEfLT/CO5yX?=
 =?us-ascii?Q?3aoGKgvoChe/Z0KbRjqUmx71ab6k/9Vhw8sgGCxWoaLil8z10SJTNsCaqBgn?=
 =?us-ascii?Q?vG5IrlSVTIAZcRW9Z/cQZucZbWrduRwY5SIuJys7CtYMaBMZ8gHNlr8PTDa/?=
 =?us-ascii?Q?dbQ7JqgApo6TuXfXJN5CcTBJph44l99ffnOWI802S+26QLMUpwB5S7N1lgcu?=
 =?us-ascii?Q?DVYHI2D+Xay85lbjjm+5po+rglhH+MPt1ZzSSMw71GSUQXZXaN6QZ7VgG3Hc?=
 =?us-ascii?Q?UgpCj3/Rav/RJy8gVHBRTVFlx+xgEgHBEaTzeIXgEQCmCGunBsj3UD1JMxQQ?=
 =?us-ascii?Q?vlfEaP3Ng6DRA0zCl0BXPpPB2DjLUMfZ/abYRKpIT+lB8HFBZfdJ4HthaxB+?=
 =?us-ascii?Q?NvKtirIBVBimowhIYUpjAzVuDHTOFLaeaggZn9RlWAnKKt79T9XsJYcKDgGO?=
 =?us-ascii?Q?2yj5oxBSu+S3naDxkOziugu/MoMhfCzK61L97bhEBshRT6oDXDG1wr/SnJKX?=
 =?us-ascii?Q?Ea/UX4n1uGXrM2hwA2b8iBN+kgmFTWQAcKK6TyhDzpoEWZXISs9/Q8lcSd1h?=
 =?us-ascii?Q?hEy76UwtvN/KsW/L3bWsi8J5XR3ummXL8EMdhD3dj5lXk/KGiSs4zTttbGuA?=
 =?us-ascii?Q?N55PFu6pWhm7ch2GyslDzQx+MzelmGEJzcbbdubmuLROdjiF3+GcTRF73W/b?=
 =?us-ascii?Q?ariq0RuzaiVGF94MrsI4Zt9UdnKLaBbljhYv6sULN1bOdo04pfP+MesXSOKR?=
 =?us-ascii?Q?4booFHUYSY2kMZs4XdzYD8qUVBit2rRJ+PsFfwBNxQ/15CwD/q03B8mqbPK5?=
 =?us-ascii?Q?RcPIsNyAvGYoYqR/NrWMpL6nnLJv/TfkUgXgCFjsUTVkBEhoA+EW5nDIYEXk?=
 =?us-ascii?Q?AKC7SZ3W84LsOImT+8kgJ0lZBtl/F4CWwc+PDdDM0m01x9q5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9e48ba-db7f-4834-582d-08def92e0c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 11:28:50.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqW2S2QcoFkj8k5XAdXxXQVcSdxchf1I6peuX+0KbZyqjofvD2lE5tgQED91WZZm8gnmu9wuhyPPajwYhArGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583

Public

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, August 13, 2026 4:24 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> mani@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> cassel@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige,
> Thippeswamy <thippeswamy.havalige@amd.com>; Sanwal, Pranav
> <Pranav.sanwal@amd.com>
> Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
>
> On Sat, Aug 08, 2026 at 04:22:55PM +0530, Sai Krishna Musham wrote:
> > The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP.
> > Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> > per-controller interrupt register region used by CPM6.
> >
> > Update amd,versal2-mdb-host.yaml with separate register definitions:
> > - MDB5: 4 regions (slcr, config, dbi, atu)
> > - CPM6: 5 regions (slcr, config, dbi, atu, intr)
> >
> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v4:
> > - None
> >
> > Changes in v3:
> > - Update subject to match history.
> > - Move allOf to the end, after required block.
> > - Drop the CPM6 example.
> >
> > Changes in v2:
> > - Update the CPM6 device tree binding and example.
> >
> > v1 https://lore.kernel.org/all/20260402180006.486229-2-
> sai.krishna.musham@amd.com/
> > v2 https://lore.kernel.org/all/20260728202044.1785986-2-
> sai.krishna.musham@amd.com/
> > v3 https://lore.kernel.org/all/20260803144412.713639-2-
> sai.krishna.musham@amd.com/
> > ---
> >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 45 ++++++++++++++++---
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +
> >  2 files changed, 42 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-
> host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-
> host.yaml
> > index 406c15e1dee1..672589066854 100644
> > --- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > @@ -9,27 +9,30 @@ title: AMD Versal2 MDB(Multimedia DMA Bridge) Host
> Controller
> >  maintainers:
> >    - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> >
> > -allOf:
> > -  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > -
> >  properties:
> >    compatible:
> > -    const: amd,versal2-mdb-host
> > +    enum:
> > +      - amd,versal2-mdb-host
> > +      - amd,versal2-cpm6-host
> > +      - amd,versal2-cpm6-host1
>
> What is host and host1 difference? Please explain somewhere.
>

Thanks for the review, I will provide the difference between host and
host1 in commit message in next patch.

> >
> >    reg:
> > +    minItems: 4
> >      items:
> >        - description: MDB System Level Control and Status Register (SLC=
R) Base
> >        - description: configuration region
> >        - description: data bus interface
> >        - description: address translation unit register
> > +      - description: CPM6 PCIe error and event interrupt registers
> >
> >    reg-names:
> > +    minItems: 4
> >      items:
> >        - const: slcr
> >        - const: config
> >        - const: dbi
> >        - const: atu
> > +      - const: intr
> >
> >    ranges:
> >      maxItems: 2
> > @@ -92,6 +95,38 @@ required:
> >    - "#interrupt-cells"
> >    - interrupt-controller
> >
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: amd,versal2-mdb-host
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
>
> Drop. 4 is already the min.
>

Thanks, I will fix it.

> > +          maxItems: 4
> > +        reg-names:
> > +          minItems: 4
> > +          maxItems: 4
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - amd,versal2-cpm6-host
> > +              - amd,versal2-cpm6-host1
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 5
> > +          maxItems: 5
>
> Drop. 5 is already the max.
>

Thanks, I will fix it.

> > +        reg-names:
> > +          minItems: 5
> > +          maxItems: 5
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index b3216141881c..21f86609ddb6 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -117,6 +117,8 @@ properties:
> >                enum: [ ecam ]
> >              - description: AMD MDB PCIe SLCR region
> >                const: slcr
> > +            - description: AMD CPM6 PCIe error and event interrupt reg=
isters
> > +              const: intr
> >      allOf:
> >        - contains:
> >            enum: [ dbi, ctrl ]
> > --
> > 2.44.4
> >
