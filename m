Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347F3F074B;
	Fri, 27 Feb 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195610; cv=fail; b=Vr+/x3SAViVLPxwi6Ls4f5dWahvMXHCjA5Nnt7w/wQWpLenYHZ0km6oO83UUNMKPd0/Ba0xZ07YDSC0ilOl4kzcNqlM51TFx24IIq5jYQk5TRc08zQH03jceoiiZkX9qtWE0WJz0tUKBDvK8SHWg/XtGyuumCNS5rCmtRjj6UjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195610; c=relaxed/simple;
	bh=77QEK4mtOi68XxTiZcF5fycl/HWOnUHuQw0S1sZF16o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fa3VZDAsH7X2sYr5eAUxK93+2d9/uVtZGyKf/Ecis9/bsef2sGPfQ+NlogrCt/jpdCTaKN/OCRGnyQAPylHWJkSvaSdaAXeLRN6mp56b1zp5/aWmRJ3arVWaelnz6vEVTopUjUbycbDfy2/7H71ERv7XyBCsjOejJUT3nm5gOIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EvLcN79O; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EvLcN79O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM0p+1BkYDnfa/iEH7vsalW5BIA2LkqNof7XZBCnM9BM1b0YErYxny4KuscqIVEbLwr2hZlH1WAPdlymuZTIF+jeP23o1wnlFEmiDmd5Ta54QMIoCvDg3fy6gWZn1wU9pdDhB8oPTEebdAYEZxxyHqLl6yPcG/wiGUwvVyOSM4dQiQGhH5/OZaqkGC8jD3oMPWFgQVsIRd6xDZUI/pL1d1696ceK6Yh0pilWKLl3h6lX2unWjhWQEtfaudMRwGnLPAsZnHitE2/q9x/IT7ER3zUZwfza59JdnzSPFU20clzZic+EyA0l/LdjhG59KblsBn4T7MUycbuWARDa/m6TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77QEK4mtOi68XxTiZcF5fycl/HWOnUHuQw0S1sZF16o=;
 b=epFP2aOSFnToblitp92Ma8wuopibvoZ31zwpAOLtFcHzCOJ7jY3Fqlt+hz3BmnX7eLerH35eVUgQFwtKCl56nQJWRKbihDUnkTRi+2CqQQSTzmk6xS9HZmvSoF+6vj1ePhLWEa7yMAMhx4y475NOQ3NtVv/lPj9aB5eljExjApb/L5qRJPlsVQvj8nF6mYmSKtzkGe7EH/y4fshkBImTpu+GEa1ORStRP4/fh6/JYkOsTuJcFdHq43bjV5x9hvbnoNgv6fiDxlbAMNN9cOr/sWOQhBEjao9ePHu8TSsDPoV5QsonhOgx+MD7PH1ZjZptWHLy1/7afDM332QDzaw6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77QEK4mtOi68XxTiZcF5fycl/HWOnUHuQw0S1sZF16o=;
 b=EvLcN79OvB+P4xRXGHe/6XokrJvZ/yeZixtl+TPArJkYrXQ4rSpDrjzI9IAJPj/GuFRJkn9ZMbg50V+q1LFa7ARr7KmTdm8ctwKqUnEoWHT/CTK9EnAGeiYGNBT3jNixcUVd/MLNqz8UL60QZFv/EEp9kGuaw9R7ixpaGcxa7Md+yFQnS1sXf4eS/OQqnX2tkZCux1raeiOkwmtyqp+wHQuKDkRsWQ6mI8jSVYt0KI2tcCDyUqkvQeJmi2bg61904rvfaCgpFM5koGmB36HalWtJFIY4OKWxbXdHOgbzzU3q6046W3ctkpKErvPMBmrrOaOS5BEOPB31T5X63NK32w==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:33:24 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:33:24 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: tegra194: Use devm_gpiod_get_optional() to
 parse "nvidia,refclk-select"
Thread-Topic: [PATCH v6 05/13] PCI: tegra194: Use devm_gpiod_get_optional() to
 parse "nvidia,refclk-select"
Thread-Index: AQHcpPRM9Ul3uk5+8kCjt1BgfeTwV7WWgJ4A
Date: Fri, 27 Feb 2026 12:33:24 +0000
Message-ID: <3ffb0a04-8fb3-433e-a040-1f74774110dc@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
 <20260223184151.3083221-6-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184151.3083221-6-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|LV5PR12MB9825:EE_
x-ms-office365-filtering-correlation-id: 64c47f54-7670-40d6-7500-08de75fc667d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 L5FajXa2K0+fmX8MJYrMdNvlyNhiYqM0NaYRpz1Kh00L5exTG/euSY5FkWAWtRhzb+FfulmLdLTCOekaWJ94ZcDi+NAQMv3Jm1+enSRH7p77QiM2zHA3h1Y9lXm3SoAuwu2SpZSVO7JcF5wpeMrltp+6JH7787pWo9QEqG7TlveRdYiJFyLv0szmgql1TZZ+Rvj3uCdRCNTt8MwQDprAHRku1jUf67dm7mnd/L6d+/Te+NHstYDl/1wvaoyYhkxEw1Qh7g1UmryyHb+jgoN7lzurPV7bclFNTdsqPyq4bs3T+GWf72oXLbiH9vLiO0Ovvg5Tcl2PFJzhFkG2StIbQvp20J4pU4Ue4EXI0lt1Mbzr/E7gEmxONqwELq/7wZ714xFTuMQcR+Nt+EhzOzmNvKlnOTQHWtIexowBhMYFQmjRtrecU+laF3J8JITQJ0Z7+Oela/nsxPHTdOlGqbWb6nKF4c6UB09crJa8fcl1/ttoBnJbPDjIxqNzXmap8+rsfbgby6U2cWXXoPIwSp3z7uhr9aMkyZKHCusoN4uZfgKoyHKAwZ9SsxxcnGJ9NAG9w0d4839sCAKMJb3LLjgd/e771yfur3iJ3GQOkKbDXsll2Mej27wQPvcwfZkxMfmQwIWq9aN4rgzE8g0ELbTRpLHigz5Dno/eX30CPLu1sa8KLapzBazQaMwJClRPo4PQAtYD/kVfhJuTrGwM3fOMO7PsigIf7PsHKm1CCIIuKlkG4NDn7M7sxXgJUlh99Ual3AEPJIcUjqyBClYTAGAPfctPW/89yqQ9AZcqLGEU4HJeGRmI+ViZV59pXWuiNrnN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0NIU2JPRnQxaDRnWEZaT3RWeGRtSlUxZTRjYmNNazhQcEdqUzR4NHB0N0ow?=
 =?utf-8?B?SjBFZXd3MDg5Y25xTldXckFTdWhzc3hJTXBiSDh6ZXJiVFl5dS9FSjc5c21Y?=
 =?utf-8?B?L2N1N1AzSXhLUitWZ3IvUU0yOHVDbmRqNVhYM3RFcUlMeTZCQVd3aVR0cytm?=
 =?utf-8?B?WDFVb3ZiTHVJcjgvSWJuVlNrRUNLWGRDQ2dxVFhmVkZ1WGZhQVE1RzUraEZi?=
 =?utf-8?B?dXFHVEFHWU4wanFiUEkwUlZTR1oyRklGOGRPSHBFdUd1cUNKc0h0enBTUkRH?=
 =?utf-8?B?cGdiL1lTSWMwVmV6REJ4clRDQVAwWjFrS1k2M0w1dkFudmkwenovOVg3RGgx?=
 =?utf-8?B?Q2FNYWpaaHI5aFowamtLYWJEWC9MREJLd0ZlTDBRSU8yMkhxRXdwbjE2NnJJ?=
 =?utf-8?B?RnQ3bEdlSUVGS0pBRldQbFFHQ0I5UEtHeVNzUndvdklkcXgwbDRiWEZKcWov?=
 =?utf-8?B?QndCY3UvcmR5aGQ1NVorZ0oxYlg4ZVlpR2l5dVMvVUhxbGk4dVh5OHZZMDJm?=
 =?utf-8?B?KzhjSEVKMGhCYkJLUnZRdktmSEJHL2JOSTRSNThyUzcwUWxBNFdSb0FubU5L?=
 =?utf-8?B?amZLZFpuWEVZYnRsU1dpQmpKWEZkcmJhMmU0azI3ODNyZUZwRG03WnhLdmRG?=
 =?utf-8?B?UXdUVklvcVhYbHdSNWM3UThWbnpyUGlBb3NNaVpaMXI2bXd0STdvYWJNcmJF?=
 =?utf-8?B?WGNPUWJpZjRPZFhLOHRIZHlHNG9lS0RuZ0VoeFczbERZRHQ3OVFXbmJKekgv?=
 =?utf-8?B?aGQ2TzROcFdXeXYwM1pCR1RQT1ZWdmJMVHA3dHdEeG1SNkp2ZzFEZEhVWjdQ?=
 =?utf-8?B?Y0ppeVppanNzVkFSenllRDd6SUpWSTNzb3lEdWdzc3dsNnpaNTB1eU1oV2d4?=
 =?utf-8?B?aGRXQ2F0R2lFOHlCNmlxMElDaDVSRkYxdjRIbFdXdjB6WUtzVUg3cWllQUhP?=
 =?utf-8?B?YTV5VE0xTE9RZjZ3Q0VKQm41RTB0MXFVaHFxTzdBNEhBTnlENW5VMGlabjhj?=
 =?utf-8?B?djdjWmxVckZWS2l2amFtdnAwLzU1RUhkUVlsRW5USUh4enJIQ2E2bjJpY2c3?=
 =?utf-8?B?MmFZQ0t1VW9rSFhSTXFkR2RQR1Bya3NmT3dackVHdXJjSG1hSFBpT0NXc3A1?=
 =?utf-8?B?YTBTYSt4cnd3UUswd1daN2VrTGxFeDczekIvYVR5Zk9NTUZlVllKNTNTdmJG?=
 =?utf-8?B?ZGlsQ3hxUWpvQ0c1V0g1cSt3KzhqUzFtUmNYQ0JjTGtJb3lrYWdSWjkvMThx?=
 =?utf-8?B?V0ZtRHdWYWZHQXNCQ0h1REtQQm5rekdYNldmcm1seitNOHdDUFpDTE95czZX?=
 =?utf-8?B?M3ZIRk45QjkzSC9qM0JCRk5YODNlem1RQk5ZbXBCbnFLQzk5a056b1ZqQkE1?=
 =?utf-8?B?Z00zQ3RQM3QzR0dzb1JFcVBBa0hJTVp3bGxwV2xEY00xdUxRT016S1FDWXFn?=
 =?utf-8?B?TTN6a25Zais3cWl4dG1lY29oaERCQ0lONDYyQUZxYThhUFRjOTRQMjE4aW9H?=
 =?utf-8?B?b2pkcFg5VWw0N1AyU0lPbjdaS1pjbldPd2hncUEzanQ0WmdiOEtLSnlhb3kr?=
 =?utf-8?B?ODN1SktYQ0NwVkE3T3pCbmU5eXhmV1YxaXZRNCthN0Z3c0p6cUdXcUdPWTQ3?=
 =?utf-8?B?aWcwZ3MyajNUQWR4Z2xRVHNpNStIZnVZdkUyOUtpc1ExOW1QOGFHS29CellY?=
 =?utf-8?B?dGtVUEREZjJCSlN2MlkvMnVlTFpNVkVDb3IxZE1FUzUrR3YrcWcvaXdPbnNJ?=
 =?utf-8?B?M0cybGFtaTcwYkxSQmlMSnFnYjNLbXRYWkd2R1Z3TE9iT1M3NlNNRkdHNlVM?=
 =?utf-8?B?VTV5RlIzbFpqN1Q0dHM4Y09POXZoc3pLbE05d0loZkozZ0p4OVF4NDRlbFhi?=
 =?utf-8?B?VXZ6VWRZb0xpTGZXUlRvaUl3L0I4VTBmUGd5M0ZHbWN2dDFJZEN0WUVQc3NJ?=
 =?utf-8?B?WE00b2pHTmE1aStndzQzQVpqTUJhY0JKc1JxVFpTWU1OZmVEc3dXZ0tvZXV0?=
 =?utf-8?B?Q0VWS3REOUdnL29wbDVNRG1WTnB4M0hNNktMOWN0b2p1Y21iOGplTjVKQVg1?=
 =?utf-8?B?d1M2Um1Xd3g4aWp4T3JkY2VaWVBQLzlvaGVFUEhiUUpTQ3FxM3ZUUHNncmJB?=
 =?utf-8?B?eExJMjN3bnZDVnNmWHF6bktqd2Z6Rjl4ZjNrZWJWY3YvQ2RPS3lpeFJLM085?=
 =?utf-8?B?N0U4MkhHMHZNN1hicjFaWnhodEM4d2Nwd2t2ZVMrSWxiWUo2cEFrVlJRTjRW?=
 =?utf-8?B?ak5RemIwMlZycWliSWtPbE1CMkwwaktGQVV0cTZ2OVJ4NE1aRjVOSCsxc1Uz?=
 =?utf-8?B?NEdBaEFjYTR4dEp1MVJDaUE5NVBCQVBjT2hQK3o2M01XT1hCem9VZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74F79C774A734647808FBB92513CC477@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c47f54-7670-40d6-7500-08de75fc667d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:33:24.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZEJHBL5fFMS0EoD1432jMt/YDuIl9kjEHqZjXTqsheFTY80gmXZqYEgPoVs4MLjQbyxPOVA64CTzFDr1WENxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825

T24gMjQvMDIvMjYgMDA6MTEsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBUaGUgR1BJTyBEVCBwcm9wZXJ0
eSAibnZpZGlhLHJlZmNsay1zZWxlY3QiIHRvIHNlbGVjdCB0aGUgUENJZSByZWZlcmVuY2UNCj4g
Y2xvY2sgaXMgb3B0aW9uYWwuIFVzZSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgpIHRvIGdldCBp
dC4NCj4gDQo+IEZpeGVzOiBjNTcyNDdmOTQwZTggKCJQQ0k6IHRlZ3JhOiBBZGQgc3VwcG9ydCBm
b3IgUENJZSBlbmRwb2ludCBtb2RlIGluIFRlZ3JhMTk0IikNCj4gU2lnbmVkLW9mZi1ieTogVmlk
eWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FudGEg
TWFkZGlyZWRkeSA8bW1hZGRpcmVkZHlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgVjUg
LT4gVjY6IE5vbmUNCj4gQ2hhbmdlcyBWNCAtPiBWNTogQWRkZWQgRml4ZXMgdGFnDQo+IENoYW5n
ZXMgVjEgLT4gVjQ6IE5vbmUNCj4gDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXRlZ3JhMTk0LmMgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXRlZ3JhMTk0LmMNCj4gaW5kZXggOTQ1NTQ1NjAyOGJjLi44ZjY5YzVjNWEwOTkgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYw0KPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gQEAgLTExNzAs
OSArMTE3MCw5IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19wYXJzZV9kdChzdHJ1Y3QgdGVn
cmFfcGNpZV9kdyAqcGNpZSkNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9DQo+ICANCj4gLQlwY2ll
LT5wZXhfcmVmY2xrX3NlbF9ncGlvZCA9IGRldm1fZ3Bpb2RfZ2V0KHBjaWUtPmRldiwNCj4gLQkJ
CQkJCSAgICAibnZpZGlhLHJlZmNsay1zZWxlY3QiLA0KPiAtCQkJCQkJICAgIEdQSU9EX09VVF9I
SUdIKTsNCj4gKwlwY2llLT5wZXhfcmVmY2xrX3NlbF9ncGlvZCA9IGRldm1fZ3Bpb2RfZ2V0X29w
dGlvbmFsKHBjaWUtPmRldiwNCj4gKwkJCQkJCQkgICAgICJudmlkaWEscmVmY2xrLXNlbGVjdCIs
DQo+ICsJCQkJCQkJICAgICBHUElPRF9PVVRfSElHSCk7DQo+ICAJaWYgKElTX0VSUihwY2llLT5w
ZXhfcmVmY2xrX3NlbF9ncGlvZCkpIHsNCj4gIAkJaW50IGVyciA9IFBUUl9FUlIocGNpZS0+cGV4
X3JlZmNsa19zZWxfZ3Bpb2QpOw0KPiAgCQljb25zdCBjaGFyICpsZXZlbCA9IEtFUk5fRVJSOw0K
DQpSZXZpZXdlZC1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0K
