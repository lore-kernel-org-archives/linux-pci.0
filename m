Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FDEADC;
	Tue,  5 May 2026 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971429; cv=fail; b=pytFSeHsZploZz9XkE74Vocf3JJy5oI4sCOT5MfSFpf/tjj7S2WGkYZ66FBdJHoDt95uRPOse/k2ozxS/UiQXSz3R+2ZCGYpZJzrbymfxufUEjGzHpFmLsZxqB3b2MpUnoPON6eVk12R7dbt0Rf5XkbQetXooLX5jKMGaP3wOt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971429; c=relaxed/simple;
	bh=t6R2zDYGjqAqoT+IQlrQCmIRtglk7pcvTH0apnPssTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adwSaatnFnhFzg6uJeiO3Q4itGlIoatKhgQB5Sg8XgyqjyD6yddHetSAQG/fUdfbMdwJUA9FY3rszvpBp+QNgLCqefkboBxyzdSSbY6dwFM6Av1eGOGxOeAlNPmH1YQd8bpcI3CEMw+e5jMzP1vuQI5daaoM4Kl7WwLz39And2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CR6o7PzU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aLN+OY9v; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CR6o7PzU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aLN+OY9v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1777971428; x=1809507428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t6R2zDYGjqAqoT+IQlrQCmIRtglk7pcvTH0apnPssTk=;
  b=CR6o7PzUDU0EAelw2inzNw3aedRBXZDwVZjgePXLgE1ilS/IU0d9azRf
   ui2Rfb/xNFUtkBbe0lQt3Jj9rzhh+u/rC+2rw7Ee5lY6fM5SgkRBGEMU1
   MJH3GRXh/nY12lbxWYEnEL4/6pLNB76pNzelCBPoqA6vx/6+/xtwaWtGW
   hHxxyFd2RmevXR2b2TMFXz/mcjfReXX6U186I2eXEnfCuTmcAEuZiAIcZ
   AaPn52iOkhOZh3wObkVfCgOU+9VFLpPU5N5TK0Jc1acgboEYlUwc5pH+/
   8wo21AU7XUE14zmz1M55mAGsNHTXJG+Rr2zzWdzMtI4A1JN9qcT9rl3tb
   w==;
X-CSE-ConnectionGUID: 7lH/mgiPQtWS9SP29s21TA==
X-CSE-MsgGUID: oyX8ULMHQqmzKzwvsgI0rA==
X-IronPort-AV: E=Sophos;i="6.23,217,1770566400"; 
   d="scan'208";a="146314817"
Received: from mail-westus2azon11010060.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 May 2026 16:57:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQUQ0dkuXvcJDsy7YwAkSkElv+mXRZc6FZQoEjyNgLLnTla2iObpqcxO3+PAB01MR12fP+pSrwyrAySG7KXkFis3dzuMWeHROiK4xcsZfcTqG/SZV/x2cEgw+097i+rYgoCBNstgM5IMwU1SgIc7kJ0v+BiTJ2VEyhSEArprEsp3WPmpsXXm+KU+/9LyWqLzvVBlTPNM1RJlLtHWCivgxZ5XXHhXY210XVhk0xR18BMYE9Cx5ebCIB57ZlJ0p1nY9SR+YyySnm8WrpdW9HhG8O+hjs+o7cR6H8o++5hkvec70D5vimF7mkY0Pd5xMdgr6cJ+k/XJTR4VJQypA8k5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6R2zDYGjqAqoT+IQlrQCmIRtglk7pcvTH0apnPssTk=;
 b=FC/sh9KVyEiPv/efKFUimGmGti4A+/45Vs8HiigmdEp73PtK9aLKaIMzugeOvstttTEvr1BPxqdqvlgg87q8320kwoquKN8L8SnwWRbemEUj9/COb9tzLtcxbxEdcwNPg6HZcUv6j7NWDKtv87OOXq2nDBQcJszR7g875hrOvduZ0hZ3VkIacNXbyOREnbaeGWEKZytzoLOwEFtHz+1ma7eJhevZUUQggvgHJFaZc+KcQcxl9nz8mRgTrE8f7IzemcFRgkUd2MszJtgEPTQkyqN6x9MT+aTeo2Y4zBEpHhNT28IuJdPEJl6opjvuPjOC2e8QeS2yChas9P2YwuWmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6R2zDYGjqAqoT+IQlrQCmIRtglk7pcvTH0apnPssTk=;
 b=aLN+OY9v/37szm/Nv6eGlY6jNbnHEmVK4kW9jSe7xoz7AMks1UXx9izAhg840nj1EBYqK4R9jHbTsh8W9rDgrgwtDpFFh2kHI2xyZzfiDXgydtOCFYLatDp6Z3nc06owTo31d5SsPduMGN4/eGctbcrbY2g3gifGCMXY/W9q+MM=
Received: from DSWPR04MB9999.namprd04.prod.outlook.com (2603:10b6:8:361::9) by
 SJ0PR04MB7806.namprd04.prod.outlook.com (2603:10b6:a03:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:56:57 +0000
Received: from DSWPR04MB9999.namprd04.prod.outlook.com
 ([fe80::7631:33fc:5bd2:f542]) by DSWPR04MB9999.namprd04.prod.outlook.com
 ([fe80::7631:33fc:5bd2:f542%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:56:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lukas@wunner.de" <lukas@wunner.de>, "djbw@kernel.org" <djbw@kernel.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
CC: "a.hindborg@kernel.org" <a.hindborg@kernel.org>, "ojeda@kernel.org"
	<ojeda@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"benno.lossin@proton.me" <benno.lossin@proton.me>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, Wilfred
 Mallawa <wilfred.mallawa@wdc.com>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "aliceryhl@google.com" <aliceryhl@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "gary@garyguo.net"
	<gary@garyguo.net>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Thread-Topic: [RFC v3 00/27] lib: Rust implementation of SPDM
Thread-Index:
 AQHcmwavLHNBjeWXl02CEQjsHiqKXLV+kouAgFfcPACADIDzAIAAISoAgAAMwgCAF1P1AIAFMpcA
Date: Tue, 5 May 2026 08:56:57 +0000
Message-ID: <243936b6f8bc29324de0b40bd62d014aa1ad9994.camel@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
	 <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
	 <69e19c80b892b_fe0831000@djbw-dev.notmuch> <aeG4UnyYd1FKdt1D@wunner.de>
	 <CAKmqyKN3nuA_uH+1o9XPrFoi7TnBY_R92SiP1srhXFdhnngd3A@mail.gmail.com>
	 <69f554aa525ae_44a831001f@djbw-dev.notmuch>
In-Reply-To: <69f554aa525ae_44a831001f@djbw-dev.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR04MB9999:EE_|SJ0PR04MB7806:EE_
x-ms-office365-filtering-correlation-id: 4c39c62f-0803-4776-470a-08deaa844390
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|10070799003|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 ISCuLZ+Qh4k3nee9sayDgIMit9JNYCtPCpaNItA/0tZvDCBeHqwcqoXrS5VwhGhFYOfmxvM7ouOfluuY3ORscZqSUN3ebUVG1ujADuDTiUQFSNnbcyUWZ4mmwDuEU5RkwmVda8mjwS+LBpAVFpMZECCDS75UNamL/z+pcc7xfZu/byI9bPFPAkQcHOsh443pketpIKPj27JQ653caLTTZSvH6OCGuivEQ4iBWmHVYAGRzh3a8ndHo6un27L64/FkF26oTiSd0mP6moftD4cvMK7vbHYecjcQMNe+mL+jMAws04ZyVm6K70GSILx3XmWGF7nh/T2UzGt4hbIc4JIL/ObFgLsgPKp7KQ0ySlUhwtoO4afKr+KY+A/tpqCvddyepLy5aj1Rxf3V2VPgNyvif9PdLkrgTzb0lJ4JCcNrzCzFnDaY1ID3aPFKdMc0Wb9UKcFa77BL0bMVib9JB6CjqEEbU10M/DmZODXss606YqENFbCuJZjAY0PPp1sNYzx7d2WwYlkrQLg3mikfYJP1lg62nrJVqHJ+jC2WGZ8C9ozTdNtqyg3ehmN/4sGolzc2ZsZjCiMBpp4/RFDEKKfoLsEjoBOzvcaQOb89YQSGlfviyRHt9JM4Cehktdf2b8XPrhuJJrUo/tl3dZv1lcSIz3IxpJRZfnfd6jlIBpFRTmVm93QcnKc6bB4WWEY+dCg4PuJKzDIMXnKNLL+OtdB5+R7TmUzZ6OamIvbY4JT9Vao7KT8URgDJ+r5AISS7wReK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR04MB9999.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(10070799003)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkZES3dNRFQrKzcxMGZPLzF0ZGl2RlNqMnVRUTdRWExiOWNJaGw0eHpIQVJq?=
 =?utf-8?B?TkdnVEJSVmtUQ09WdjBuSUl4d0cwUXVHRzhxQnFWbzNzNHdqUHpiVGIvaGt5?=
 =?utf-8?B?bmt3UDgxci9hS1lBR2N2WTNXZDNpU3Y0a0lJeS9lT2ZwU1R4KzdJSzdCK0M4?=
 =?utf-8?B?bTBTWTJlL1AyRTJmZXFIWXBEdjFmZTFZd2pJWkllZ3FQS0l2L3g2YklvVHhz?=
 =?utf-8?B?Zks5V1ZwN1hXSVZJcDF4VHBsZm13dnBhd0Mwb0lDRkpCTVNBZzlPQlBTTXVm?=
 =?utf-8?B?ckRvSlJ4ekszcVcxZHUxNytLUkxOQzdaeHJVb1VwUVVOM3RYeXk1TVV5anJh?=
 =?utf-8?B?T1NNbU1HWUdidThwMDlyVjJObkZtZ3ZmS0dWaVI0TGM2SnhCOUZDOEJ4WVFw?=
 =?utf-8?B?R0NZdzUwYUpuV0N4eXdFWFI0VDFyWVEvQWo1dkxic2JEa3ZIUUpFaGFLTHB5?=
 =?utf-8?B?bHJHMC9FYkF2aFZpSlVGWHgvSzJNb251ZGg3YThpSVh1WHAxQmV1My9WSExu?=
 =?utf-8?B?Vks1Vjh5VzhUTXJCN2ozaHZUQUNkbkZzKzFzd0JGMVFBRGxXaDVUK25pSVRK?=
 =?utf-8?B?UDl6cGlxVlFycUp2SExKeW0zNkk5dElRT2VUemhTRjhzZFBSamE0UWdpM1hZ?=
 =?utf-8?B?ajJzbjFuNzFTQ0JUdzBtczZ3bEVyVEo5bzRZSWF5dVVBRExOZjFMUW44U3J0?=
 =?utf-8?B?M095SURvOFlHbEREOTRNQlpsNll2cjZnallMdlZ1ajBTQm1rdVl3Y3lwTkI0?=
 =?utf-8?B?ZHY5SGhqcWViVUNucTBmNjQ4MHpRUE9keW01RWxmWW1SLzUrSVo1Q2c3Sld0?=
 =?utf-8?B?NVg0RUV0K1R4ZWtScWZibmVGZDBPTjJublZUU3Y2S1Fxd2Y3QkdCQm1jNlN3?=
 =?utf-8?B?ejMwdmltTUptYnVjNlhlOWxGVjArdVlUR2tMNUpSOVdzSnRPZm1BRytjUWR5?=
 =?utf-8?B?dHBpcG5Xc2lzTGVETmhiaXloTVZSbTlhN0NEaG02K2hQd2R4MVVsakoyQisz?=
 =?utf-8?B?eXVmeGdPMWdBVERQc0c1OEVFR1puT0lkQWxhR2J1QUR0OVppMC9GdFY1Z2hC?=
 =?utf-8?B?dEcyUWxsYVBkODE1UWtoUkZWNkZteDMwRGVITkFLZU1sNDRKaWlmYmZxekVU?=
 =?utf-8?B?bkx1aXg0eEV4bEx5aTlMVk1HWU9SK01LWFkwYTJPc1p1ak5sV3c0WGlLdHor?=
 =?utf-8?B?UjVzSi9sZGs1bVFDUHJXbmpzVzFFcytFR0Fzcm5lS05LNDYyOE9sbHMzdllp?=
 =?utf-8?B?TlRvNldYQTZzMTFxMWNzRkd6QzdxVHVmYUZsdFprckRmaENzR1ZNUUprbzB4?=
 =?utf-8?B?eFZvQ1Y1cW1ibzNFN0NEalcvUHAxWHZQWUZ3aVNQTDZQTFJ6T2xVZXU0dCti?=
 =?utf-8?B?cldlVkx6NndiMzZnQWlhbkVnc2x4MDJuNWZHa0JiVmE0T1BTN0xmYlAxa3Jl?=
 =?utf-8?B?SmNqamZ5L3pJcUVrNTdod0R5VGQyYk9jNzlaakt0MEN3ZUF1Vk1sVkJINEFX?=
 =?utf-8?B?MS9XYTJpWkxPaEh1cHlnMUlOdG41cUlUekJ4a3V6OUI0bi9BSE1oVGlNNUdv?=
 =?utf-8?B?SndQZmE1QmhlOU5JQjU1Tm9xTk5EUFFBM0w2ZGlTcXdiZHUxMzhpbWMxMzVR?=
 =?utf-8?B?OG5kS1luVWlNN0Q4d2Rnb2RYNFVVa0tNbldMQkpuVHJQUkxYN1NPYmRjL1Vi?=
 =?utf-8?B?ZmNBaVFOZUhCNXFkNzBjMVJLWWtiblVZVDFhMnZKNDhjY0ZycFlWSW8raWpo?=
 =?utf-8?B?dWx3Qm92a3dra1pGdm5FMTFYN1pXRXBkSjMwVXJzNEsyREg3Z2c0V3lQdURP?=
 =?utf-8?B?UEJYa25uTWF5cDFYQS9qbHpnakRha3piblFyNFF5SFdmYUVuUHJZMXpRaXVD?=
 =?utf-8?B?WnVEUGJpTVRpRTVWSnluSExqTGo3Nk1oamlTdFg3ZFRKUWlCV3d1SlBiVWt4?=
 =?utf-8?B?Q016Ym8yTTZOY3RNdzVsaC8rVm4rRTYxemVKWWovaU9RWXBkellNUmpISnhN?=
 =?utf-8?B?enUyb1FDL0s0MmxzbWVPaS9QdFdORVhKWVJFdll5dGtmemlEWmpsVnRoNGhV?=
 =?utf-8?B?anY2NFZCSDNmTjFxL2lPdVNXb2lXcWlJTFpCRUk0R2laY3kwOTJ6cFJOQUh0?=
 =?utf-8?B?MzVGWFdQMGV2dGRhQ3QvZEY0UWRzNW4zOGVUbXZzRjVlMWt1aGcvT2lBY01L?=
 =?utf-8?B?dGR1SklPcFpuODBXTFRudFVNZTFJTVpKcmFXN2VyYjdDdHl0Nm92b1o4UDN5?=
 =?utf-8?B?dzVMenF6S2N6bkU1dTQ4SC9OVFA0OWlUTGJ4T1Z4ZWEzeUNoWmJEMEVXYmsx?=
 =?utf-8?B?ZmJIUlQ0Y2tRQkVCQS9NajdXdDd0c2lWZzVUUXlTVDBmNmFkT2dGYnk4UXda?=
 =?utf-8?Q?ywFoY2lgVKKLP5zEZwi1DKNC5izxX9UFSJ1qguGldq4Nn?=
x-ms-exchange-antispam-messagedata-1: VhzeH0xTVib81ac18lB33dL9fZjYqgl3qt8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12247A0E78956A4FBD7D391031E8D847@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KDs6hdukSG73MivKOc7Hxj/H46jdfpQuiSMCsVAyKiBKK/WekHEit3uJ6FGJqhiTnU9u9qjYBqvHeqLd/XKTHPPvkQFNOkJu74onko5T5jmkV4X0Knrl+1kuSUIRGqp5VS2KQtHfgpUI1Qnoe95YN6fEPFUZfOq01BI0DDFGWmm74PLTOEqMO1CuFOtG8cFoBnsc9dW9+V6TVIyLTjvZ+iFJps32GYzURmBKwWt1ZAAFxTjiXPKAbXx1ukJhMd0q1TJvi6+KJgmc3IaStCfHwHykyccC//LEevV94YkH+xpKfAV/nPzZrtKZGiRKa5CdW13kpqq13cWNNZpmMkuw7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g9Avpw1EivmA+iZ1akf0Mlzm5iK4DUh8T69qjFAMb27Ey4QPmI/MlumdXbf/tVn1DuNHfRF/JjT2H5zLlI+entKLVj91dfK0cXysAbvI2Zunenk+sF/i5XAfE3kaxBqFR9OXN22fFw6ZmW0WBkuIey1di/7eHKNAFk2w+gUOK66aBORp0XEKXexQPWJxaHnrr+hTUQHa0ENBhPU7bWa3Xxi6HLudKEpJvmzYl4159m9zjs2i1oEhuXazwspoUzF6YnFmggm1Jc55u0Yfy7MYNBOE0OAMKhElyhHg0ww/OHJfIlePtyJkY5CqmlWuIwhDvLzMU+04q/6gKEzDzLsaMra1kCARRmxxcuG10JtshWem+5uCwygAvnkmX4OdxAW2Nw6qtgiIi0YrlG+Hrztzpudl0DNtd6jpZLXxIqKnAjwuGddQCgMlTL5i1hjuPtYWLwBQRhr29H/8qvayYjzQKiRcAwNHgW0OLlZ9/tGZE9urplKQR8y+Us3gn4ZEr3lQnht2tsHa/VbXtQW7hOvUpzHIxyimMZ+aCBcPAGxlQpyTckLJjFpKGmEYz780v6VR6C9NIP1ZAb5OAHKt7pQ2ruzgwFxMCPO6u3Wji8oQ9QI+VVFk4UaMgU47JkqjeZ7L
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR04MB9999.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c39c62f-0803-4776-470a-08deaa844390
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:56:57.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rtZHGnDytSh2hVK7kwP7ZibO6aWf/5iR9dCuCxGKjFlV8PBD+J7YNWm8GSetGgFp87iBE3zse4bNHawD92SHwfsInpZyc+vySxgQysihD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7806

T24gRnJpLCAyMDI2LTA1LTAxIGF0IDE4OjM0IC0wNzAwLCBEYW4gV2lsbGlhbXMgKG52aWRpYSkg
d3JvdGU6DQo+IEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+ID4gT24gRnJpLCBBcHIgMTcsIDIw
MjYgYXQgMjozNOKAr1BNIEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPg0KPiA+IHdyb3Rl
Og0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIEFwciAxNiwgMjAyNiBhdCAwNzozNTo0NFBNIC0wNzAw
LCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+ID4gPiA+IExhdGVyIGluIHRoZSB0aHJlYWQgSSBwcm9w
b3NlZCBhbiBhbHRlcm5hdGl2ZSB0aGF0IGluc3RlYWQgb2YNCj4gPiA+ID4gc3VwcG9ydGluZw0K
PiA+ID4gPiAyIGZsYXZvcnMgb2YgdWFwaSB0aHJvdWdoICJhdXRoZW50aWNhdGVkIiwgaW5zdGVh
ZCBpbXBsZW1lbnQNCj4gPiA+ID4gQ01BIGFzDQo+ID4gPiA+IGFub3RoZXIgVFNNIGRyaXZlciBb
MV0uDQo+ID4gPiA+IA0KPiA+ID4gPiBbMV06DQo+ID4gPiA+IGh0dHA6Ly9sb3JlLmtlcm5lbC5v
cmcvNjk5NzZkN2QzOWM2MF8yZjRhMTAwOUBkd2lsbGlhMi1tb2JsNC5ub3RtdWNoDQo+ID4gPiAN
Cj4gPiA+IFBsZWFzZSBrZWVwIGluIG1pbmQgdGhvdWdoIHRoYXQgQ01BIGlzIGp1c3QgdGhlIFBD
SWUgYWRhcHRpb24gb2YNCj4gPiA+IFNQRE0sDQo+ID4gPiBTUERNIGlzIG5vdCBvbmx5IG5lZWRl
ZCBmb3IgUENJZSBidXQgYWxzbyBTQ1NJLCBBVEEgYW5kIHBvc3NpYmx5DQo+ID4gPiBvdGhlcnMN
Cj4gPiA+IGFuZCBzbyBpbXBsZW1lbnRpbmcgQ01BIGFzIGEgVFNNIGRyaXZlciBtdXN0IG5vdCBw
cmVjbHVkZSB1c2Ugb2YNCj4gPiA+IFNQRE0NCj4gPiA+IGluIG90aGVyIHN1YnN5c3RlbXMuDQo+
ID4gDQo+ID4gVGhhdCBzaG91bGQgYmUgZmluZSBhcyB0aGUgY3VycmVudCBTUERNIGltcGxlbWVu
dGF0aW9uIGlzDQo+ID4gc2VsZi1jb250YWluZWQsIGJ1dCB0aGFua3MgZm9yIHJhaXNpbmcgdGhh
dC4NCj4gPiANCj4gPiBKdXN0IHRvIG1ha2Ugc3VyZSBJJ20gbm90IGdvaW5nIGluIHRoZSB3cm9u
ZyBkaXJlY3Rpb24sIHRoZSBpZGVhDQo+ID4gd291bGQNCj4gPiBiZSB0byBidWlsZCBvbg0KPiA+
IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDMwMzAwMDIwNy4xODM2NTg2
LTktZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tLw0KPiA+IA0KPiA+IGFuZCBhZGQgc29tZXRoaW5n
IGxpa2UgdGhpcz8NCj4gPiANCj4gPiBgYGANCj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV90
c21fb3BzIHBjaV9jbWFfdHNtX29wcyA9IHsNCj4gPiDCoMKgwqAgLmxpbmtfb3BzID0gew0KPiA+
IMKgwqDCoMKgwqDCoMKgIC5wcm9iZcKgwqDCoMKgwqDCoMKgID0gcGNpX2NtYV90c21fcHJvYmUs
DQo+ID4gwqDCoMKgwqDCoMKgwqAgLnJlbW92ZcKgwqDCoMKgwqDCoMKgID0gcGNpX2NtYV90c21f
cmVtb3ZlLA0KPiA+IMKgwqDCoMKgwqDCoMKgIC5jb25uZWN0wqDCoMKgID0gcGNpX2NtYV90c21f
Y29ubmVjdCwNCj4gPiDCoMKgwqDCoMKgwqDCoCAuZGlzY29ubmVjdMKgwqDCoCA9IHBjaV9jbWFf
dHNtX2Rpc2Nvbm5lY3QsDQo+ID4gwqDCoMKgIH0sDQo+ID4gwqDCoMKgIC5yZWZyZXNoX2V2aWRl
bmNlwqDCoMKgID0gcGNpX2NtYV90c21fcmVmcmVzaCwNCj4gPiB9Ow0KPiA+IGBgYA0KPiA+IA0K
PiA+IFRoZSBkb2NzIGZvciBgc3RydWN0IHBjaV90c21fb3BzYCBzZWVtIHByZXR0eSBUU00gc3Bl
Y2lmaWMsIHNvIEkNCj4gPiBqdXN0DQo+ID4gd2FudGVkIHRvIGRvdWJsZSBjaGVjayBiZWZvcmUg
Z29pbmcgYWhlYWQuDQo+ID4gDQo+ID4gVGhhdCBtZWFucyBhbGwgb2YgdGhlIG5ldGxpbmsgc3R1
ZmYgaW4gdGhpcyBzZXJpZXMgY2FuIGJlIGRyb3BwZWQNCj4gPiBhbmQNCj4gPiB3ZSBqdXN0IHVz
ZSB0aGUgVFNNIG5ldGxpbmsgKHdoaWNoIG1pZ2h0IG5lZWQgc29tZSBhZGp1c3RtZW50cw0KPiA+
IHRoZW4sDQo+ID4gSSdsbCBoYXZlIHRvIGRvdWJsZSBjaGVjaykNCj4gDQo+IFJpZ2h0LCB0aGUg
YWJvdmUgbG9va3Mgd2hhdCBJIHdhcyBleHBlY3RpbmcuDQoNCkdyZWF0IQ0KDQo+IA0KPiBBcyBm
b3IgbmV0bGluaywgTHVrYXMgaXMgcmlnaHQgYWJvdXQgbm9uIENNQSB1c2UgY2FzZXMuIFRoZSBu
ZXRsaW5rDQo+IGludGVyZmFjZSB3aWxsIGVpdGhlciBuZWVkIHRvIG1vdmUgdG8gYmUgYSBnZW5l
cmljICJkZXZpY2UgZXZpZGVuY2UiDQo+IGZhY2lsaXR5LCBub3Qgc2NvcGVkIHRvIFBDSS9UU00s
IG9yIGl0c2VsZiBiZWNvbWUgYSBsaWJyYXJ5IHRoYXQNCj4gZGlmZmVyZW50IHByb2R1Y2VycyBv
ZiBTUERNIG1hdGVyaWFsIGNhbiB1c2UgdG8gZXhwb3J0IGl0IHRvDQo+IHVzZXJzcGFjZS4NCg0K
WWVwLCBJIHRoaW5rIHdlIGhhdmUgdHdvIG9wdGlvbnMNCg0KDQoxLiBUaGlzIHNlcmllcyBhcHBy
b2FjaCwgd2hlcmUgU1BETSBtZWFzdXJlbWVudHMgdXNlIHRoZWlyIG93biBuZXRsaW5rDQppbnRl
cmZhY2UgYW5kIGVhY2ggdHJhbnNwb3J0IG1lY2hhbmlzbSBsb29rcyBleGFjdGx5IHRoZSBzYW1l
IHRvDQp1c2Vyc3BhY2UuIFdoaWNoIG1lYW5zIHdlIGRvbid0IGxldmVyYWdlIFRTTS4NCg0KVGhl
IG9idmlvdXMgYWR2YW50YWdlIGlzIHRoYXQgZWFjaCB0cmFuc3BvcnQgaXMgbW9yZSBvciBsZXNz
IGludmlzaWJsZQ0KdG8gdXNlcnNwYWNlLCBidXQgd2UgZG9uJ3QgdGlnaHRseSBpbnRlZ3JhdGUg
d2l0aCB0aGUgdHJhbnNwb3J0DQpwcm90b2NvbC4NCg0KMi4gVGhlIFBDSSBUU00gYXBwcm9hY2gs
IHdoZXJlIGVhY2ggU1BETSB0cmFuc3BvcnQgbWVjaGFuaXNtIGhhcyBpdCdzDQpvd24gdHJhbnNw
b3J0IGRlcGVuZGVudCB3YXkgdG8gcHJvdmlkZSB0aGUgaW5mb3JtYXRpb24gdG8gdXNlcnNwYWNl
Lg0KUENJIHVzZXMgVFNNLCBBVEEvU0NTSSB1c2UgdGhlaXIgb3duIHRoaW5nIGVjdC4NCg0KVGhl
IGFkdmFudGFnZSBoZXJlIGlzIHdlIGNhbiBtb3JlIHRpZ2h0bHkgaW50ZWdyYXRlIHdpdGggdGhl
IGV4aXN0aW5nDQppbmZyYXN0cnVjdHVyZS4NCg0KSSdtIG9wZW4gdG8gZWl0aGVyIGFwcHJvYWNo
DQoNCkFsaXN0YWlyDQo=
