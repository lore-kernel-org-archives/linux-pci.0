Received: from esa1.hc1676-28.eu.iphmx.com (esa1.hc1676-28.eu.iphmx.com [207.54.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189E3451C6
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=207.54.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598370; cv=fail; b=MZhOa/+SmkiZ+0R/Z9ADB46n0ddMrGW1EyhWy/8TJGrDOZE7pnFH0Ti0QiRC9pHIoJwGPho4PR0h57/8cp2eQ/QMkK9FH42qvEVy5Ty44hFKX1+pvUsObWOeFEV2OOGGQoyu/xvImkcmjxoLgWqxnFNHIohkdyQ6ukSqHa6687U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598370; c=relaxed/simple;
	bh=z28/sQPUUkp7R124R36YhyH3JU6zM9ZGslAPdCtpdVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kiLUO7HEgQzfmNrze6E5+sBwM50VjPH8cO4uGNeinRPpRlUJoAeekeCB6O0MdQdgknGjH6qNr/jB2bc712/cdrEsNCMb+SzRLo0aKNstk+3+YXDW96C7mfX6ewvSdnF2UNFfOYhE/8E+o9LW8dLcruTINjbVIafmKLYMTfIjDI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=greennet.ua; spf=pass smtp.mailfrom=greennet.ua; dkim=pass (2048-bit key) header.d=greennet.ua header.i=@greennet.ua header.b=Qbl3hXm8; arc=fail smtp.client-ip=207.54.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=greennet.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=greennet.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=greennet.ua header.i=@greennet.ua header.b="Qbl3hXm8"
X-CSE-ConnectionGUID: oItTHI7zTAioZdP6PfDxxA==
X-CSE-MsgGUID: hvt1qBklRUaElW4RrAkREA==
Received: from mail-northeuropeazon11020121.outbound.protection.outlook.com (HELO DB3PR0202CU003.outbound.protection.outlook.com) ([52.101.84.121])
  by ob1.hc1676-28.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 12:24:58 +0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7+8k1MhPe7rrl04GQT7VrSJwGpT3wNz8K5h5ZtVvnIZ/mbEPdXUssAny3s8ecGW+k3QYdyrkASnOkawADzv5G29JSNqIQn7UBvDdd9dPfiChNgfOYB2SrP0JVmyDCWMDi0QIK86AXWfA7A5Ug9+e9ChUK4qEau5A1Px7OSqErGCKgzKUYtDEw86WDNoEJm754p8YMYpBMdtX5u10x383rtE0GmhzDk6LosC2KHhjsjBULbCEUnrXHvvvrTX4kclQ0gFu7FC9YX/+Jp0VU0V2wbrttsIG9nf6pzoZ15YtvzifJFuzMNhheRzXLzvjiFa0NYPsEPrHs92ReiUZMNOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z28/sQPUUkp7R124R36YhyH3JU6zM9ZGslAPdCtpdVs=;
 b=M8MsjJAKcSGgM4YAMOkQUsphHBPaajZRGB9pfh3dmlRiFB+lpifY7olQDSMXcf9CU7Ti3/Mt7oYaSkA6vq+jmawNXr6H6gI7uvH3I/lJBTUquD+oP7c6/xqyv2YFNDefhbREMXUjJdrMx5Zc6g6GLXMwSJe6e+Og1vkeqcmF6vnHHQdS4GbiGwv8URFii2NZCx88iR4wz65jTlTUjr/xYZw8Z3pl3niO+0FBvZZqG6IzECNcUhYiprfFn6fAe9g/MUi66/KMPKCmAu/w1aqQmYEswSTVO0ExjVeRzR6Tnt0B/tG7sX804F6SMlRJyCpTBt+EDf7BS72FIX7g3wmK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=greennet.ua; dmarc=pass action=none header.from=greennet.ua;
 dkim=pass header.d=greennet.ua; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greennet.ua;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z28/sQPUUkp7R124R36YhyH3JU6zM9ZGslAPdCtpdVs=;
 b=Qbl3hXm8t82PXIce6x9cxEA0KI4ZPHH/WsyxSZF0/k71M82/Nut42QI/2mkEkxVhvVjs674rt0ggYi9OsSyRKp9yqgG/eoXvve4pSzlag02Xowh1lVpdpYHXX/HAAOIoj9M6RXv7UMXfB58xNMxh1qotIgYUnFRsW35TGTP2Knv+TVYlqiLqEiD5P34e/4/R2aZCBTvDae70i7n6GAy8Rb6yhF/TM8rzWGZqs+q1iReAhpzoOG+G5VsIsxNsVwqS+hECitmQOm1F2YyeYPe6vLDVF7DmS33kCuAbCF/qfVYU4lWp3uyygSCBjc8siSsbmbt8bKt8ZFdfQRiAaRpkHg==
Received: from FRZP190MB2216.EURP190.PROD.OUTLOOK.COM (2603:10a6:d10:13b::16)
 by PA1P190MB2767.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:567::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 08:24:54 +0000
Received: from FRZP190MB2216.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b5e:d5de:9694:8f86]) by FRZP190MB2216.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b5e:d5de:9694:8f86%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:24:53 +0000
From: Filippe Duke <fduke@greennet.ua>
To: "regressions@leemhuis.info" <regressions@leemhuis.info>, "lukas@wunner.de"
	<lukas@wunner.de>, "superm1@kernel.org" <superm1@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Thread-Topic: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Thread-Index:
 AQHc75i6snC5+m26YUKcDxLv2DMMqrYoIYKAgABsngCAABBrAIAACYcAgACqxoCAF53SgIAAA1kA
Date: Tue, 16 Jun 2026 08:24:53 +0000
Message-ID: <4d89d115fc8db4360d7a22aee5a82b011c01e418.camel@greennet.ua>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
	 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
	 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
	 <ahyerEqlBdIbQN9u@wunner.de>
	 <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>
	 <ah016_TukXkcqnyQ@wunner.de>
	 <ba4a8fa6-1786-4fca-a6e1-c203d6b6bc0c@leemhuis.info>
In-Reply-To: <ba4a8fa6-1786-4fca-a6e1-c203d6b6bc0c@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=greennet.ua;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRZP190MB2216:EE_|PA1P190MB2767:EE_
x-ms-office365-filtering-correlation-id: fd0f49f5-1a55-4a07-c752-08decb80bd9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|9063799003|56012099006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info:
 DU+QvZB8hl2S+d3vEgrubZ4HMFlSb51frSdUWyq/RJs5pC8zJCuJWFvijK3QWvdRyN2DLHwTevg1rHlanq4HJ+WM7o/ugvdmeHDzpeVNpJAYb18+1xIBkEN7RuA3IW0mwfHoyYCgnE+THKrbySp30oA6pJ7+nD0z4BAB5HQg7cIMjFkumEAvLs4VAGCOhib/FdgemctawRamj05t5T7lDyI+516d35jnjBg+H4RKiXULKA94aZy9q2m7CpLw/A339ZKyxCuGWrHY/bqlK72+2M7lha7e2AP7tAlQ4iFdR9ZAvJD2r2/g6lNdKsrjqj2G6mwKheFDyrk4fb5aW5/FufkQd0KCRhissKkWZ35TjO57dTDsBnIUjcyprTWi4IHjwX4SgYuABpapztZVWClIvwMZ+4vXz6ZEPIFv2Fm+UyzYs/N1Vd4MGgVELqioiMcxSKTEfdGSIL64HT6c4acXLDCypet61TX7TuOjWGQezGZr1M/EtkEU1Fw1wpye9fxL5Grpr7vAYGPjgUpQvdLt81f8oQrPzf/yxH82ipp4kEsgf+5Gl6lt/HIRmKcCVI/QkbF+3syT1aTKKqkbEjnXx1yzfqzGdkxwxsYRTBg9mA4EYnxZFJo0n4aiDTchzmzv5zOUKsgoUh2TzgcSxNre9WxsOWeBBgJjs1Y3xTDOWqpTC/LhC2wGWe9N+1gryYAZMaHkIORWPrgrFi7y7I3vExm4vZB3jgsW4aMfvTvxkTelsmMPYPrENolBx92YYTkV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRZP190MB2216.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(9063799003)(56012099006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3p1RHlaektyaXowcXYzQXJHMXZaTkhqejcwZTVHYVBTcTNFYkZGMW5sTWZU?=
 =?utf-8?B?cCtkbG1hWTFjNjZlTjROSGFOVVpDU3VEVFFvZ1h1WmpHZWtLNFY3cWk1OUJF?=
 =?utf-8?B?TFphblZWVllOZFdOWkR1cVlRK3F5eXU5SGFBeGk0ay82WnN6SXMxMXhJM3M4?=
 =?utf-8?B?SDRoTlNxemdZTks5M29UTW05QzdOb2JwUWN5NTdPVlAxVklOOXFGRUtIdU1w?=
 =?utf-8?B?MGMyZHZQWGZwY0tBVXZ5eHBDb1BlK1NMalJ6MndXU280V0JFaS9yOTFJL0hI?=
 =?utf-8?B?eWJiNE5STndGdUFOQ25FN1lxQkROcGQyTEt5cWxoR2owU0FoMER5OWRwVndq?=
 =?utf-8?B?RDA0NnNBRmRLR1NNbk9RTDVsczh0UWpIQm83cUlsQ2h5bytYN0RtbWFrcXI2?=
 =?utf-8?B?Y2NpQWduZjMzc0ZRQ2tBQ0YrUUFqdDRndG5VNWdHbk1oMGgweGtLNVdsMjMz?=
 =?utf-8?B?TGQwZE1FRlFCUzFJVDBYSUJLdy9NSXlXYlA5QVFWRjh5aVg5RFYzV1RaMTlz?=
 =?utf-8?B?SzV6YUJNMEt0ekhGaVo2Y3RkRUMxRUVGdGtlNmIwNUJjcFh1RStITW5tVWJt?=
 =?utf-8?B?ak00WURZb0dlck44UGdJZnkyWVJBaEVIQkR6dFN4dHhENlN5emlrQW1SMkl5?=
 =?utf-8?B?MnN4WmZXMzVqdDJBZlEyMW1iMGk5VjlaTmlCUnRWVEJTWlZEdTlmSVpYT29V?=
 =?utf-8?B?L3B4L0FhWitUb2dKcVhpU1FKS1VJVktIVHNMTWJ1VzZIZDZVNXByR3VZVWNm?=
 =?utf-8?B?bmUxTTJVd3ZaTUE2YVloQnp2VWpIRGJwNW9DOWt2RnFyMVM2SFJtVk1uTC9y?=
 =?utf-8?B?UWtEdWJkWG9SOEp2V3lMZWsyTDNqempjRmt2QXJZY2RRblVVdytxRFJBVlps?=
 =?utf-8?B?blBxbHN2czlVdU5MZFdRTXViR3BybmNHb0ZTL1NGQklzcVJXOUVmUzlDeDBa?=
 =?utf-8?B?WHcrME83RnZSZ3Z3WHFFc2NKNXNNTTdjMmUyTkdubko4T04yUjk4Y0dPSXk2?=
 =?utf-8?B?ZVFxTGVxRlZVY2lObSt2UzR5cnFmTlZoSnlQWWJrZ1RGVU5xdUxNRjMvMlZU?=
 =?utf-8?B?U3N5TEpWNnhGaU9iTVFtSzdUQkoySVdjV1diaUJXaE5IZWpZMHdIajVMZ0dK?=
 =?utf-8?B?dW1wRnVOVmJ6SFdvaWZtM2pVdStVc0FmSGFmTndQQnhzcnVNQ0JtRmRGazd2?=
 =?utf-8?B?VHNKRlNzWDNjQmsrdnZ6L2JielJyZFdhOVFvN0l0bHR1dVk3VWNvOUdLWWRr?=
 =?utf-8?B?UTBJaUZVMXp4U3dGSzdyTTljTUgyaXFXZ1FKa0VtbUh5akExNmpaUk43S0N6?=
 =?utf-8?B?VG1ocFhDUSs3dzJTZ2tndm0yTThFYVloU3pHNXlhVm9RWWhDNDVpc255eC9D?=
 =?utf-8?B?cFlyOE5xb25Cd3o0dVh0VFhmWlZrcHFXdFdiTE0xeEJuZjhXUGZ5K2xaVW9I?=
 =?utf-8?B?U3hYNE1QSjZTOVVFcklvVGxSS0RyM0FFK0RqZWt5U0RUdk9VMXRqU3ZWOS8w?=
 =?utf-8?B?eGZ6V0JFSWk2LzNUYklMRjg3YVRYWGVxYzMvRlZ6YmM1M3VXV0FoNTJtU3ZM?=
 =?utf-8?B?aDJuQy9YWk9vVzV0eFdxS2pZK1J3VzhpemgzbWF3bXhSWTZoaW5DamlZcEM0?=
 =?utf-8?B?azVXVGk2aSs3WVJFMVlmVmhrUFZIZjc5VHpjd1Vvem1PdlNBRTJlOHMremtT?=
 =?utf-8?B?dEZlMGxUT0p1dUVYVkxHekhHK1ZIcld1MTUvNm5YUC84TWVSOGVSdStvQVhL?=
 =?utf-8?B?V2llSHZYVVArRHFJUHBXY0JQbFZEL0QzaFMyYm9oMjRCRnhDOG9rdmtNRDQ2?=
 =?utf-8?B?T0tITDVIeHBhUWcvU2NXUzl1TEl2bnpDZ1U5Zlg4bVlOSG9CSzM3ell0U0N4?=
 =?utf-8?B?NTNrdXVwcCs4SXJVWFFCbjV3dmNzc1A2dXV1eUlKTzVvSkxBYWtHN2JOZldY?=
 =?utf-8?B?THpoY2xBQ2d3ZnlGVTBYV2M2azY0am9DQjYrK0g2YVYxNDNQOUJyWnRvajRI?=
 =?utf-8?B?SXhVUC9VUXNEWFV1ME1FRXJ5eHdxVTZ3NUNCVVRTR0hScW5xcFB1Myt4Y2Ry?=
 =?utf-8?B?TkFLc1JlT0d5YTVUcVY3MFA5WDVRUE50RzBJdkM1R3Z2aUNRTWVOWFhYNUFu?=
 =?utf-8?B?dnNyOWtiR0YxNVlFTm10Tlh0aEJ2d1FKM3hlUk81Y0RZOWtYU2pETzNHaGkr?=
 =?utf-8?B?bzcxY3JIbnV5OUgwbnFKRUxLOHhydWtqSTI4K2Z3QnRLdlFpYUtaREF0U2tv?=
 =?utf-8?B?U2pkVHE1WkJvTEgrczVKaitYTlhEekUwdE44bjZ2dlBhYWlVMEFDemt0S2pB?=
 =?utf-8?B?NDQvbndYYVFGZTF2R3Fnc2lBd3FITzlibEhPNmlHc3BvdE9iajU3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCE1EBB94D1BB54E8C2911740949DDE4@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j6mLoqKnQ0W+TPS8UmRsAyId7PeskjDBc8layH0TuRWezo3zzjjKJa2xPCOzlwRK6JVlYEQSKcLP9nfB4YSkAyItKg3n1k/8DabQ2T+tFmHqOmH/Hw7VYF+cve62P5UFt8mOk6RZtZNMT9ilbHUVBSYBEkJRLMdbyV7HNzmjZgCG4kg5Pkwqyg43GLn1OVvKkNeAOz1HsbLjMp2eF3YEl4fDWI6k5h/C0ybumvsrkDsgi5rSSSxGf2LbRlwdH7JnGYclxWgPVw0y15nE6rdZBJituFPvIhTL5W/qe1EWVIA8xw0A/py2cpgE6ygU1D4Gh6i1XZekwfVz9+Yq84VSlA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHJYCZUitYjKzk0TRJvtfgzYK6XxFFGEwQQFQMCRHw3BDeiAs55rglK+kRsZS3VHrgaIJUkL0a82pN3cHPi0ijgw8qCpkexv+eO5V/dXyv2NGDlj3RVPxA6PWFUqGTPxwQ9cXN3XiN73IqefumIjzRUFayiJkGHd7qgeijeTQePTOqjtxfVBqqwjdc6BWpKYPC2O1nWbwoZtz5C1PPlRDT8rfIKmde7U0WKXcQ3VO35h7d3TIAXrqXG9GR9lPdoawf1//F0fTnI25q/CGxbuVBJd6pvgeJJhcqpXwUxfvhaviJpNbE85eH/lmkVJoFS78CAjvhkrZuypzvJTK5Mgq96x3jVoFCP74cPI8C8GnhMZOssbweapFz0Rw/RHjRf+2J/+REB0LLbRec4a+u5JRegEVU3gofYjR78YsAbf5ZnkP7R6GCK238AGlpgHpgBKHaTiN2qplzIyrB9KTo8a7NE05M4fwcuF+ljpTwQYFpjc/tKF+6sL1X8mUCSedWEw/jIVDxxnflQE+gZCViXhDcIUzTcWX4l5pk1Ls9kd/ydqPeR38+OKUOMniwTgxLkhffci+GYjuwX+aXgrGuEUuVy7p1S8SVgQgpRJliTLUy1ntGrP0bKW8OloFjRpJQd+
X-OriginatorOrg: greennet.ua
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRZP190MB2216.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0f49f5-1a55-4a07-c752-08decb80bd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 08:24:53.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 93d4616f-e331-4774-8e77-16a5d6706819
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YubUNp7oghxs006G25K7EP5stPk00GpkljL7mCl9YGfCGTnloYk3jQV03Sq3X8I+0Gcgyirqa0FwR5CDFkbGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2767

SGVsbG8gYmFjaywNCg0KLUNDOiBhbHNhLWRldmVsDQoNClNvcnJ5LCBJIHdhcyBidXN5IGZvciBh
IHRpbWUgYW5kIGFjY2lkZW50YWx5IHNlbnQgcHJldiBtc2cgaW4gSFRNTC4NCg0KSSdsbCBnaXZl
IGRldiBpbml0IHRyYWNlIHRvIEx1a2FzIGEgbGl0dGxlIGJpdCBsYXRlciBvbmNlIEkgZmluZCBh
DQp0aW1lIHRvIGluc3RydW1lbnQgaXQgd2l0aCBwcmludGsuDQoNClRoZSBpc3N1ZSBzZWVtcyB0
byBiZSBxdWl0ZSBpbnRlcmVzdGluZy4NCg0KQmVzdCByZWdhcmRzIQ0KLS0gDQpGaWxpcHBlIER1
a2UNClN5c3RlbSBFbmdpbmVlcg0KDQpHUkVFTk5FVA0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFRob3JzdGVuIExlZW1odWlzIDxyZWdyZXNzaW9uc0BsZWVtaHVpcy5p
bmZvPg0KVG86IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPiwgc3VwZXJtMUBrZXJuZWwu
b3JnDQo8c3VwZXJtMUBrZXJuZWwub3JnPg0KQ2M6IEZpbGlwcGUgRHVrZSA8ZmR1a2VAZ3JlZW5u
ZXQudWE+LCByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYNCjxyZWdyZXNzaW9uc0BsaXN0cy5s
aW51eC5kZXY+LCBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo8bGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZz4sIGJoZWxnYWFzQGdvb2dsZS5jb20NCjxiaGVsZ2Fhc0Bnb29nbGUuY29tPiwgYWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnDQo8YWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnPiwg
dGl3YWlAc3VzZS5jb20gPHRpd2FpQHN1c2UuY29tPg0KU3ViamVjdDogUmU6IFtSRUdSRVNTSU9O
XVtCSVNFQ1RFRF0gSERBIGNvbnRyb2xsZXIgTU1JTyB1bnJlYWRhYmxlIG9uDQpJbnRlbCA1LXNl
cmllcyBQQ0ggKEliZXggUGVhaykgc2luY2UgdjYuMTYNCkRhdGU6IDA2LzE2LzIwMjYgMTA6MTI6
NTMgQU0NCg0KT24gNi8xLzI2IDA5OjM0LCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+IE9uIFN1biwg
TWF5IDMxLCAyMDI2IGF0IDA5OjIyOjUyUE0gKzAwMDAsIEZpbGlwcGUgRHVrZSB3cm90ZToNCj4g
PiBBIHdvcmtpbmcgTFRTIGtlcm5lbCB2ZXJzaW9uIHRlbGxzIGNvbXBsZXRlbHkgZGlmZmVyZW50
IHN0b3J5Lg0KPiANCj4gUmlnaHQ6DQo+IA0KPiAgMDA6MWIuMCBBdWRpbyBkZXZpY2U6IEludGVs
IENvcnBvcmF0aW9uIDUgU2VyaWVzLzM0MDAgU2VyaWVzIENoaXBzZXQNCj4gWy4uLl0NCj4gLSAg
ICAgICBJbnRlcnJ1cHRzOiBwaW4gQiBkaXNhYmxlZCwgTVNJKFgpIHJvdXRlZCB0byBJUlEgMzQN
Cj4gKyAgICAgICBJbnRlcnJ1cHRzOiBwaW4gQiBkaXNhYmxlZCwgTVNJKFgpIHJvdXRlZCB0byBJ
UlEgMjgNCj4gWy4uLl0NCj4gLSAgICAgICAgICAgICAgIEFkZHJlc3M6IDAwMDAwMDAwMDAwMDAw
MDAgIERhdGE6IDAwMDANCj4gKyAgICAgICAgICAgICAgIEFkZHJlc3M6IDAwMDAwMDAwZmVlMDAw
MDAgIERhdGE6IDAwMjINCj4gDQo+IFRoYXQncyB0aGUgb25seSBkaWZmZXJlbmNlLiAgU2VlbXMg
cGxhdXNpYmxlIHRoYXQgaXQgY2F1c2VzDQo+IGNvbW11bmljYXRpb24gZmFpbHVyZSB3aXRoIHRo
ZSBIREEgY29udHJvbGxlci4NCj4gDQo+IFRoZSBvZmZlbmRpbmcgY29tbWl0DQoNClJlbWluZGVy
LCB0aGF0IHdhcyA0ZDRjMTBmNzYzZDc4MCAoIlBDSTogRXhwbGljaXRseSBwdXQgZGV2aWNlcyBp
bnRvIEQwDQp3aGVuIGluaXRpYWxpemluZyIpIFt2Ni4xNi1yYzFdIGZyb20gTWFyaW8uDQoNClRo
aXMgdGhyZWFkIHN0YWxsZWQgYW5kIElzZWUgbm8gcGF0Y2ggc3VibWlzc2lvbnMgcmVmZXJyaW5n
IHRvIHRoYXQNCmNoYW5nZSwgd2hpY2ggbWFrZXMgbWUgd29uZGVyOg0KDQpJcyBhbnlib2R5IHN0
aWxsIGxvb2tpbmcgaW50byB0aGlzLCBvciBkaWQgdGhpcyBmZWxsIHRocm91Z2ggdGhlIGNyYWNr
cz8NCg0KU2lkZSBub3RlLCBmb3IgY29tcGxldGVuZXNzOiBKb3NoIFBlcnJ5IHJlY2VudGx5IHJl
cG9ydGVkIHByb2JsZW1zIHdpdGgNCmEgIFJUTDgxNjhoLzgxMTFoIE5JQ3MgZHVlIHRvIHRoZSBz
YW1lIGNoYW5nZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9kNGFhYTVlOC03MzY2
LTQ2MWMtOTRiMS1jY2YzNjMxYzhiZjlANmJpdC5jb20vDQoNCkNpYW8sIFRob3JzdGVuDQoNCj4g
Y2F1c2VzIGN1cnJlbnRfc3RhdGUgdG8gYmUgUENJX0QwIGluc3RlYWQgb2YNCj4gUENJX1VOS05P
V04gYXQgYm9vdCB0aW1lIGVudW1lcmF0aW9uIGFuZCB0aGlzIHJlc3VsdHMgaW4gZGlmZmVyZW50
DQo+IGNvZGUgcGF0aHMgYmVpbmcgdGFrZW4uDQo+IA0KPiBJIG5vdGUgdGhhdCBjdXJyZW50X3N0
YXRlIGlzIHF1ZXJpZWQgaW4gdGhyZWUgcGxhY2VzIGluDQo+IGRyaXZlcnMvcGNpL21zaS9tc2ku
Yywgc28gSSdkIHN0YXJ0IGJ5IGluc3RydW1lbnRpbmcgdGhlbSB3aXRoDQo+IHByaW50aygpJ3Mg
dG8gc2VlIHdoeSB0aGUgYmVoYXZpb3IgaXMgZGlmZmVyZW50Lg0KPiANCj4gRS5nLiBfX3BjaV93
cml0ZV9tc2lfbXNnKCkgYmFpbHMgb3V0IGlmIGN1cnJlbnRfc3RhdGUgaXMgbm90IFBDSV9EMC4N
Cj4gUGVyaGFwcyBpdCB1c2VkIHRvIGRvIHRoYXQgb24gYSB3b3JraW5nIGtlcm5lbCBhbmQgbm93
IGl0IGRvZXNuJ3QuDQoNCg==
