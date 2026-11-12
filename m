Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453373;
	b=NyJnSv3dzLAt6AJNLzxJuTCq+MXTs2dA51mLXW+Knvi2ZMQaJX7fxkgarwFYKZyHIUyO
	 4gwsYxBWLV71EysXozjnjdpRhLBjXtEHtsdeBE2t62q0L8V19exKceVv+Wh2xF1SX3tKH
	 FsGTEkVrRjPYLK7fqeq/x3/0q6VvRtK6Qi5a2WJUGG0JeNmRIUQFLqy3XUtR5YINHiajz
	 YVg8TSUOClFr3Us9k4HqOalzU14j//yPiv701UH7Yc8/93HULgh8bDStSg0vWZcNeFAN1
	 TazBREq9SChr6W0vmXrfpHnjkZoS2+4QTG0xu9AXto+9yBj/7mQoqthUuiF54IXF3Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453373;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:user-agent:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 wdcipoutbound:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AZDnmTaawpXBOCJEuBdRcGCBT5na/vlPpsSd4JFohiE=;
	b=oa4fi25Q+iEz4VSFF4xsQVa/v/SY57hviSuyMG9Htj7bPF1k9nTDVlenEmbHoH4oamwf
	 DdzU1Yax35KMT6m4Xkl9Sn8wU9+T4X1fwHdmFqyiOa6XBNcDStjs4sgB6t6vJA2GxBOYg
	 yWQRIVcgyhpGqfhzuS78x/8PlAUS4JVlPZogHeRYGz6XQUXQ71TUhLRljAdqgmqu4syL/
	 2ed1kCScTN9zXYJWtbHLbaDo1xTca2Oh0aZlCli0WW6GUokdwMx0y3O9DobYLxYZgeRG6
	 nv7bOJlGmxem798h2ylfI7ySEgE5Hi/m8x8tzUGLZoRbp2ILrXE8nwrT6P1XE8f5+Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=U0AGP4c4;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=JunMweCK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67317606A323;
	Thu, 12 Nov 2026 03:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67317606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=U0AGP4c4;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=JunMweCK
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794453372; x=1825989372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AZDnmTaawpXBOCJEuBdRcGCBT5na/vlPpsSd4JFohiE=;
  b=U0AGP4c4gilT79n9tiXrOiY2fPhNTe6g6/3hjQQBL5Q3S5pNMuSv4VyT
   DhVuNMEqL5aVEe0BkxgJSEzbFGiaiEj9zMxKxdbqpojfafAONw9kSuh/5
   /zsAYdLR6kUn4NPHU6rbnh8XJlFZbLghq7ELsakvf6bUKUldIgZD9JCKe
   xjEhNjjRYQThvWuKX0llmXFxOeCM+lZG/NhHEwvvu5CE0K5Gl2m/DqE8y
   Pi2o7cyebcfbJURM9HSI9gkKrIW985mEKNPUQhShV8hEHveuT8xGFNtBo
   qYv73rSebn6Nuzu27q51FEmGQNgTH7RqODvTcqgJQDLEYyrzl1+Dx5FZH
   A==;
X-CSE-ConnectionGUID: YkX9Wt9PTL2r3EVdwSLlIA==
X-CSE-MsgGUID: 0JhMysW8RQCbzpEPF3XfLg==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; 
   d="scan'208";a="159083829"
Received: from mail-northcentralusazon11013020.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2026 11:16:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIl0DUNtJTHmYIq44O8eqlh5tcL1ZbQmvrFc06oSMuQ4JnVHhfflnZZwZzzXo7pcAc1LzOQit5zJUBjUeVqI871+QP9Fw7MGdAC8mggIehc3eFpZsK9jdbUhzJXnBW51c4p/k8MB4kP0hXUHi3AMxQE5CxwqQ+Htg2kwjKR3CK/1a7kMqioh8T10mQJj6mHUJBrGC0TbV6Gw4CbcX8FUw7Gk+5FHtikip8V/mzr1uJbZ5TXBaEbTk9NnfuhoEDHkgut/O4VlFk3FIfET1Dyh2rrSLGK+wHS5UC3sCB1X7OGkTWlPIwhF9Z/zp9HjclE5qc5R14mhsGlIXynnUre1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZDnmTaawpXBOCJEuBdRcGCBT5na/vlPpsSd4JFohiE=;
 b=CE4nBRxzETJ0aQHDdbFFVljrNWcb+C/szk5pJm8irjtXL1tlLhr0DGQ5C0pCru2kjGcrTn3GgP88ORpvdM9zt2Fcq7/rrb9a8Ul6jrs8pZWQAy0rFRbBE2KD1KlnpLHRi9jVJa2u5+U/AiCv3q5ZmlycKmHD8Fh+XHKYSCOc1w47y+2JQGaLBqOJYpv3FS5+tOqfEcZha8Rsn58sWkbFXm9C0uwglvhdQm70J5jmfKeRIy7UAafWtRPZrpFJ6DSYGu3YPEo5SP1DLM7XMVCJaIp9bGfqHQyaoLpnM8gyoRuVOw3HvfqoBmEBYMYZA4+Vk8wuM/83KXDB578IQjBLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZDnmTaawpXBOCJEuBdRcGCBT5na/vlPpsSd4JFohiE=;
 b=JunMweCKcsqiqdZ1XiMUsjDtYBfrIblh2ADkQuXoaMPSpiKNZzNJkmJXjJtpb7b+gbs5k53NJpZTwleRInhp/lAXZSajkOabKt2E68qrL0fckrpUkW2mW+vGBHd7n6fHwhh5Rdss7OiviYPeUBKAGIlvVi4iYn5XP23df9Q+V4M=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by CY5PR04MB994188.namprd04.prod.outlook.com (2603:10b6:930:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:16:08 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 03:16:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "alistair23@gmail.com"
	<alistair23@gmail.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "benno.lossin@proton.me"
	<benno.lossin@proton.me>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"gary@garyguo.net" <gary@garyguo.net>
Subject: Re: [PATCH v6 01/25] virt: coco: change tsm_register() to use a const
 struct
Thread-Topic: [PATCH v6 01/25] virt: coco: change tsm_register() to use a
 const struct
Thread-Index: AQHdcMqbfe7Dm6CM7EeNCBtjODz/X7cpvJUAgAAKJQA=
Date: Thu, 12 Nov 2026 03:16:07 +0000
Message-ID: <ced5751ca6fb905c73d0ec61510a65ad859cfa8c.camel@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
		<20261110041832.1730924-2-alistair.francis@wdc.com>
	 <20261112023948.75462a02@jic23-hlaptop>
In-Reply-To: <20261112023948.75462a02@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|CY5PR04MB994188:EE_
x-ms-office365-filtering-correlation-id: 2163311c-22ec-4cf0-6a13-08df406b4b31
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|10070799003|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|56012099006|10067099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 xuDzO0DwFQdUag8ctB9Le6iG4Cu/1/D/CH/MNgL/ZYDIhYGjq0IhYh9uBh7EJwkbQ+DrhIGyVsBdC+uVhm7ZCQ43j6b/yS4eUK47rgluEV7toYvN9pcnSj115jhKLVq3Jski2973uJdYAf1mSMgLmgCjFW53YDArzWVEifgBzpEaQhEWUQYofyyZ6zHwGqAmLxgVQbpX9yI5nH66AdFwhX+HtxgaRRtjHwg+dqpDEXIzBEUUL4UpI+PGBAO/sHM87mZr2t8tjt1hfrZB4OPL1pYCwHXLl9OFVX2xDoK15ZGRFjh+ppRFvI89uKhmhhk2/HRYl7c5bLzjLYFuWMrhpMNkMCgojUYUCQDry9wW4zl35vbTWyRmn0Y0yOTQUZmJq3C6hOyugDGNXsHcPhH+s4XICFNAhE8hRT4igvx3+9AH5FTFoksGbkYMvtaBm0aMT+p0z20n+2z0GMuUZZ+Fhmk9u6tlMzqO3uz8YpcPOEQQu37t3Rx8kFAShrYj/JMwcW4bqTgRIv2vPnhxR4Vr4VUsgMfTWr2sEYAxlU3dqdpIdGsoRS37VKFI7Q1WsESJad8cgSyag3/5y1QeNIXV8HStCRScdlp5TejUMAuv+C80gvRf9FdQz+OZud8k9qw6ADGmZ8EGv7XbTNE0ODkqlgV/s0boDUn0bnH/HRjHtf8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9375.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(10070799003)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(56012099006)(10067099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkNReUluVkZkN2lBMlNrbjJUQVFnZGdGektRVHprRHRpcmlsbUlQN2pmVlFK?=
 =?utf-8?B?Q0lnVXBnTE1FK2hFMDFhdTR0YVpPZmFkQklDMmpNZFVTekpQOEJ2Y2pIWjFR?=
 =?utf-8?B?bXk4SEM2WXl0QzBnVmFFdFJUTmxPNGZ0OGthVUZjLytyMkdhOWc4YTQ4d1Uw?=
 =?utf-8?B?VXRjOHd4bE1tWUlqVFVWMWF0Mnh0RjYzTUc0WVRFRStyMU14SGU5WHViOERn?=
 =?utf-8?B?RGxyMUpFNDU2dURWaWF2dWxvbklybFBkdnZGRy9NQ3BrSEhCbklTclYrdDNv?=
 =?utf-8?B?dlBOM3IzV3l1WTlnTllwNHVNT2daUHRIWDkvMVVaWXVOcW1RSjRkczJROWkx?=
 =?utf-8?B?dVFSMWl0MGVreitUTzQrSXhFZVptUWtsdkhML0UvcXVWTU9zUldQYS9hOHp2?=
 =?utf-8?B?akorMXFvZjdJYWM5Tm1XYlM2cWRQN2RDYTNhTWVjMFEvKzcvZFRQeTFqYmhp?=
 =?utf-8?B?ek5IYXBIYWkwMjNDeGEwMUZhZWYwYUFMRDdHUHlkL2hVaXdMRXFTUWtOMkww?=
 =?utf-8?B?TzJtRTl5Q3E2YjF1cHFmNmZwL05wZ3kyRTZxT2pOOXI3NWxlVytMcy9CYkQr?=
 =?utf-8?B?YkhVMWltN1BmdlpDcmM5VTdOKzR1SDFDT0FpWTdtOFFCbVN0Q0gwOUpZOThq?=
 =?utf-8?B?czR2U25nK2UxV0pUajhrTTBrd0dzZHFBUWZ2Nm92dDNaMnRBVlJ1NFhOR1hO?=
 =?utf-8?B?bkpCSmg2a3o3cnhRM0UzdVNkWHg5dEltdUw3bU1teGlpa09taDBMMzBleUov?=
 =?utf-8?B?NHJZb1FVejFvVFVnKzcyZWJzN3lETTdRSlBFR2tPZDZNbG9oQVZCNHZpQzNO?=
 =?utf-8?B?RGVFL1N3eXJxTlZJcUFjdGxTRktqL1p6R1padCsySkpXYkx5RERWWWM5em1r?=
 =?utf-8?B?Y3V6N1pIenJDRityZnEyTEpZcXBtYWRxTWYvNFFmL1hzYWgwazNHOGZjNkRw?=
 =?utf-8?B?ZkQzZDc2M2p4WDZyRHNQeHhwb25aenBFbHdNUWhZdCtmWE9tL0tmZzJzVDZr?=
 =?utf-8?B?ai9ORWRaVTVzUU9qL1VYVDNIOFRhakJWeElUVWRlNUpGZ1RKcE9OTjNZRXph?=
 =?utf-8?B?MWxJNG9nMHlsQWNYd3QxUjhrcjdiOWFpYVY5R2VVNko1YVR0UTl6dnNaYzV0?=
 =?utf-8?B?YXQ0SHFUNXdiYXppcEQ1UTl4Sm1JeTR6WFdOcERyK3pBendsU3lPckRGTys2?=
 =?utf-8?B?UnFvN3hMR2NPTU1jZnJxSCtBbGFIZ2ovQVJuak1aY0VmaGNFV3VCOWF0eDM3?=
 =?utf-8?B?VmtST2N2bEovNFdrRVpncjdjSjY5NlF0Q3lsSUhLcnQ0YzhFVERNZXZrQVBE?=
 =?utf-8?B?cm5pTElsQ1pJN1RXejhtTUpUUE9yL1ZiUW1iQk9OTzN1Y0F3cENMQzNYbHo2?=
 =?utf-8?B?Tlh2bThzOElYMXJUUDFCOERZMDFUYldyUjIwSDJqeGZxWDRGWVR1ckNlUUxO?=
 =?utf-8?B?SFhQeXFyZ3hKZmMrRURhTFhiaGpueEZ1d1lJQTE3V242TnhJMjYreGlkQzBX?=
 =?utf-8?B?VTJ4SGNjWWp3QXFDUE1tZ05qMENNM0kzY1BGalI4MkozVEEybW92b3h2c3Yx?=
 =?utf-8?B?UU1JTTJCNFVXYndmMjdhbitNRDgzbjVWWWVDOW9Xb2RCYlVmNlZabmdYU2dl?=
 =?utf-8?B?WngwN1FwRUd3QmVhbnRRWi9BRjV2VlI2OGJyVlRPYU9OOTNieGdiN2ZJUG5K?=
 =?utf-8?B?M2ladUoyUFdWemlvendvandtR2Znd1R3TUhHRzIySDFxbkhEUFk1ZUpqejhp?=
 =?utf-8?B?TTlZTEVOb0J5MnA2Ky9iaXQ0NUdIYUpMZms3YlBzeS82VVROZmtBM1dLQ0xE?=
 =?utf-8?B?M0F6dlVxWUlxNFp6V3hSQWh5dE43eWF0UHUvZmVOMitodVd5eSs4UHNRVEJ5?=
 =?utf-8?B?UFMrbUZtZnByUnBiMTFvODdZN3lKZU9nQTArdXJRK3kzTnF3Z0dKRkUweEEx?=
 =?utf-8?B?VTkxWUo5SVM2VCt6VjRZM2NnbXlaOUFCQ3k5eG5RUmF4RVNOMjFpd2tRUnRB?=
 =?utf-8?B?ZjhveE5rdmJsYzBZR1pDTHJkazhiNzE0TFdWQzFwMTYra2w1NytUdjA3SXRY?=
 =?utf-8?B?cXhNUTZFaTNlK2VieHF1OG5LR29qV0QwaGdBK3BMWHE2REkvUVg4bUd4WDA0?=
 =?utf-8?B?WmN0MTRMNTJ0N1A4QjFQc2psaUJoK3d0T0dTWlNuMHlVaDlKM0VIS2h1OHFG?=
 =?utf-8?B?UGRlOENGeTF3OG82SVQrbmI3QS9KOXc4ZTBud1JvNEVWSTRQU2Fia3VNY2t5?=
 =?utf-8?B?MlIrVTR3Um9jWXBuTUlKNVhIcGxFODBOaGswRzE5dGhEd1JOSUh6QnNXVWUz?=
 =?utf-8?B?cWVvTmw5L254SzBuVzVtQkhUZ090NlVTRW9URENqQml5cHFDSTVNMVE0dFJ3?=
 =?utf-8?Q?D8cboGoWA0AL5TjIO3pv80B1DuoO8yR6sI5z7y8uXVOee?=
x-ms-exchange-antispam-messagedata-1: OZCcQrjezY2FViA6sj+FPJkoXdNn9DJPbY4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34B22F5697D92D4D9CFF19CEC70EF46D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	T0qwQLxfzSRs3ChcBOwScfmcYZWKaVafwvnopHakLBXSJiLqG7ooe/kZjpoTyN4jjAipqdMyI4Oirpes7GTbzZAy99f6OzWiiW9JtfSfvSQ1t+RWjoqueHFPBqEUQlNaNQa/pK1pTjkOh7PjIADgtEs7EsQj8UeN9TAi2Yo7ktFlIPVS7Zoducl9EjvEgxTU32ZPS5USFhbAlnMU/nOKeJPUiEUupcncinsSh765s9D2d6QxYQD8g5SbvbI+Bf+FLaf4XVO/8UN06DNPmF9+R2A9Ysb9RuXr6+EyjaVFTv6WS5cj1OEynNMUGztNOj4a13CAbUvCrz2DnY4zE4g7/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Tsf3BDasrjkTbiq4pHgUt1of3nQqFdq1F1erMIM93Sk/2FzMTGK1sdfnCdZoCun5gtH3r/iHzuUL+BXaBqyFYaKFMFq97M7wSNUGqaOrJ6NZT8NVvxQnRQB6R6vqULdpyfcr21/hs5hO6nncLiBDDmLQmUv/IHGXrdrAQdEPyCZtDQh2EV8FDH0LUSTNEGN8ypBMTsCct7xUKmquY/2IY171GqewDOZGgL6wp3oC6jAXuxvNqBa7kKWmGwYQ72+cgA8UAgzJ6oygldOoaDgET03ff3R0KhBPBBvlD0HNYld+I76iawmXp0KjTNR2tb3JOJh+LwgdpoIirDjjqrqpi1aOa9DM3YuMUXgEC94PqtW+MAz3Fejt19yXDhwvF+HVLJ7mW/R/UqsOpXYD5rY0aBaN2P2wPH9GNNfoJR3T1nIoYDvHBKDgfEy7cnXmyqLozomRAx+1kbbTqibR9Doof7XxsK3vP8TTRlWR7tHsC1VnfM0m0MYwE/jgvXSXOXIni6jpln6WMpX0Ef+mhgiQJ3Ihpl6DHl0tZ6rKON1QhYbdfaAvhO9sGKcClqW0fJEsWQbPGFAscezQ5Y3x7Jp7h/KXyRWc2O2SoujK4g9VyVIHJ9gIvSz4Nt7+gpes7nr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2163311c-22ec-4cf0-6a13-08df406b4b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:16:07.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77hSmT9E6qck5BVeRpufTocNg2jy5SnxlU8z6Yk7gphFRSdHIsG49oBXJ3G0oGOYR51ikZFER0QdhbwMDUGVbRbZxdYtERE7uIdH8e2gc4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR04MB994188

T24gVGh1LCAyMDI2LTExLTEyIGF0IDAyOjM5ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDEwIE5vdiAyMDI2IDE0OjE4OjA4ICsxMDAwDQo+IGFsaXN0YWlyMjNAZ21h
aWwuY29twqB3cm90ZToNCj4gDQo+ID4gRnJvbTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KPiA+IA0KPiA+IFRoZSB0c21fcmVnaXN0ZXIoKSBmdW5jdGlvbiB0
YWtlcyBhIHN0cnVjdCBwY2lfdHNtX29wcyAqb3BzDQo+ID4gYXJndW1lbnQuDQo+ID4gVGhpcyBl
dmVudHVhbGx5IGlzIHN0b3JlZCBpbiBzdHJ1Y3QgdHNtX2RldiBhcyBhIGNvbnN0LCBzbyB3ZQ0K
PiA+IHNob3VsZA0KPiA+IGp1c3QgY2hhbmdlIHRoZSB0c21fcmVnaXN0ZXIoKSByZWdpc3RlciBm
dW5jdGlvbiBhcmd1bWVudCB0byBiZSBhDQo+ID4gY29uc3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiBBbiBv
cHMgc3RydWN0dXJlIHRoYXQgaXMganVzdCBmdW5jdGlvbiBwb2ludGVycyBkZWZpbml0ZWx5IHdh
bnRzIHRvDQo+IGJlIGNvbnN0IChhbmQgaXQgd291bGQgYmUgYSBsZXNzIHRoYW4gaWRlYWwgZGVz
aWduIGlmIGl0IG1peGVkDQo+IG90aGVyIHRoaW5ncyB3aXRoIHRob3NlIGZ1bmN0aW9uIHBvaW50
ZXJzISkuDQo+IA0KPiBNYWtlcyBzZW5zZSBhcyBhIHN0YW5kIGFsb25lIGNoYW5nZS7CoCBNYXli
ZSBvbmUgdGhhdCBjYW4gYmUgcGlja2VkDQo+IHVwIHNvb25lciB0aGFuIHRoZSByZXN0P8KgwqAg
DQoNCkkgc2VudCBpdCBvdXQgcHJldmlvdXNseSwgYnV0IG5vIHRyYWN0aW9uOg0KDQpodHRwczov
L3BhdGNoZXcub3JnL2xpbnV4LzIwMjYwOTExMDI0NzA3LjM0ODU5NTQtMS1hbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20vDQoNCkFsaXN0YWlyDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQG9zcy5xdWFsY29tbS5jb20+DQo+ID4gLS0tDQo+ID4g
wqBkcml2ZXJzL2NyeXB0by9jY3Avc2V2LWRldi10c20uYyB8IDIgKy0NCj4gPiDCoGRyaXZlcnMv
dmlydC9jb2NvL3RzbS1jb3JlLmPCoMKgwqDCoCB8IDQgKystLQ0KPiA+IMKgaW5jbHVkZS9saW51
eC90c20uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQ0KPiA+IMKgMyBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zZXYtZGV2LXRzbS5jDQo+ID4gYi9kcml2ZXJzL2Ny
eXB0by9jY3Avc2V2LWRldi10c20uYw0KPiA+IGluZGV4IDQ2ZjI1MzlkMmQ1YWIuLjQ4ZGY4YzU3
OWM3NGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL3Nldi1kZXYtdHNtLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2NyeXB0by9jY3Avc2V2LWRldi10c20uYw0KPiA+IEBAIC0zMzks
NyArMzM5LDcgQEAgc3RhdGljIHZvaWQgZHNtX2Rpc2Nvbm5lY3Qoc3RydWN0IHBjaV9kZXYNCj4g
PiAqcGRldikNCj4gPiDCoAlzdHJlYW1zX3RlYXJkb3duKGRldl9kYXRhLT5pZGUpOw0KPiA+IMKg
fQ0KPiA+IMKgDQo+ID4gLXN0YXRpYyBzdHJ1Y3QgcGNpX3RzbV9vcHMgc2V2X3RzbV9vcHMgPSB7
DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX3RzbV9vcHMgc2V2X3RzbV9vcHMgPSB7DQo+
ID4gwqAJLnByb2JlID0gZHNtX3Byb2JlLA0KPiA+IMKgCS5yZW1vdmUgPSBkc21fcmVtb3ZlLA0K
PiA+IMKgCS5jb25uZWN0ID0gZHNtX2Nvbm5lY3QsDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydC9jb2NvL3RzbS1jb3JlLmMgYi9kcml2ZXJzL3ZpcnQvY29jby90c20tDQo+ID4gY29yZS5j
DQo+ID4gaW5kZXggZTc4NDk5MzM1M2Q4Zi4uNmI3MzVhYzJhODE0ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnQvY29jby90c20tY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy92aXJ0L2Nv
Y28vdHNtLWNvcmUuYw0KPiA+IEBAIC01Nyw3ICs1Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHNtX2Rl
diAqYWxsb2NfdHNtX2RldihzdHJ1Y3QNCj4gPiBkZXZpY2UgKnBhcmVudCkNCj4gPiDCoH0NCj4g
PiDCoA0KPiA+IMKgc3RhdGljIHN0cnVjdCB0c21fZGV2ICp0c21fcmVnaXN0ZXJfcGNpX29yX3Jl
c2V0KHN0cnVjdCB0c21fZGV2DQo+ID4gKnRzbV9kZXYsDQo+ID4gLQkJCQkJCSBzdHJ1Y3QNCj4g
PiBwY2lfdHNtX29wcyAqcGNpX29wcykNCj4gPiArCQkJCQkJIGNvbnN0IHN0cnVjdA0KPiA+IHBj
aV90c21fb3BzICpwY2lfb3BzKQ0KPiA+IMKgew0KPiA+IMKgCWludCByYzsNCj4gPiDCoA0KPiA+
IEBAIC03OCw3ICs3OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHNtX2Rldg0KPiA+ICp0c21fcmVnaXN0
ZXJfcGNpX29yX3Jlc2V0KHN0cnVjdCB0c21fZGV2ICp0c21fZGV2LA0KPiA+IMKgCXJldHVybiB0
c21fZGV2Ow0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gLXN0cnVjdCB0c21fZGV2ICp0c21fcmVnaXN0
ZXIoc3RydWN0IGRldmljZSAqcGFyZW50LCBzdHJ1Y3QNCj4gPiBwY2lfdHNtX29wcyAqcGNpX29w
cykNCj4gPiArc3RydWN0IHRzbV9kZXYgKnRzbV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpwYXJl
bnQsIGNvbnN0IHN0cnVjdA0KPiA+IHBjaV90c21fb3BzICpwY2lfb3BzKQ0KPiA+IMKgew0KPiA+
IMKgCXN0cnVjdCB0c21fZGV2ICp0c21fZGV2IF9fZnJlZShwdXRfdHNtX2RldikgPQ0KPiA+IGFs
bG9jX3RzbV9kZXYocGFyZW50KTsNCj4gPiDCoAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdHNtLmggYi9pbmNsdWRlL2xpbnV4L3RzbS5oDQo+ID4g
aW5kZXggMzgxYzUzMjQ0YzgzNS4uNmFjMTJkZThjNGQzNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3RzbS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90c20uaA0KPiA+IEBAIC0x
MjAsNyArMTIwLDcgQEAgREVGSU5FX0ZSRUUocHV0X3RzbV9kZXYsIHN0cnVjdCB0c21fZGV2ICos
DQo+ID4gwqANCj4gPiDCoGludCB0c21fcmVwb3J0X3JlZ2lzdGVyKGNvbnN0IHN0cnVjdCB0c21f
cmVwb3J0X29wcyAqb3BzLCB2b2lkDQo+ID4gKnByaXYpOw0KPiA+IMKgaW50IHRzbV9yZXBvcnRf
dW5yZWdpc3Rlcihjb25zdCBzdHJ1Y3QgdHNtX3JlcG9ydF9vcHMgKm9wcyk7DQo+ID4gLXN0cnVj
dCB0c21fZGV2ICp0c21fcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqcGFyZW50LCBzdHJ1Y3QNCj4g
PiBwY2lfdHNtX29wcyAqb3BzKTsNCj4gPiArc3RydWN0IHRzbV9kZXYgKnRzbV9yZWdpc3Rlcihz
dHJ1Y3QgZGV2aWNlICpwYXJlbnQsIGNvbnN0IHN0cnVjdA0KPiA+IHBjaV90c21fb3BzICpvcHMp
Ow0KPiA+IMKgdm9pZCB0c21fdW5yZWdpc3RlcihzdHJ1Y3QgdHNtX2RldiAqdHNtX2Rldik7DQo+
ID4gwqBzdHJ1Y3QgdHNtX2RldiAqZmluZF90c21fZGV2KGludCBpZCk7DQo+ID4gwqAjZW5kaWYg
LyogX19UU01fSCAqLw0K
