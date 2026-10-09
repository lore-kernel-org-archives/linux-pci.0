Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011028.outbound.protection.outlook.com [52.103.33.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A64C4F79;
	Fri,  9 Oct 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544901; cv=fail; b=h0amR1XlCPH1ob9GENt2gFLDoDSSqKJfbhFJWokVGBhGlGFhh3KQb9b7wcmVG/Btvut/SUNBtUaKsriK4fPDxoVwHQw4kAVIwgSdSwhdkbJjWl+iIxr7v34479jjxBZ9jQNSA1bI4t+C77gxWJDO+0km8qum4mqUFYzvhVHh8wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544901; c=relaxed/simple;
	bh=f9Kjohq4hNaSaUDvoi9jMVGVqKPb7CugVicjjPQujTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8zg6Gr/MuRvmvTyhhc9vRHIutsSrF2ensFyU8Y+9NazZ2ytzesk6Jm7lGr8Pq+woXaqWY7lwMvNJRnfprACfKAatojOXplAhMAcSTzu7KH/yh3s0KcYWGdfsn5iFro3GR8CPkSL2swg7ioYCLz7uldwk++xOk+I2YLaDjJXUlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UImEE1kQ; arc=fail smtp.client-ip=52.103.33.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UImEE1kQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaxczAjcuwJlFQHp55vG+5BNeVFDwDYyUQ8VjwJBoSER0C50O2K/o33Z/gcVRPxHH+GGZfjvPXKWHVBHFmTCWvKWlUIui01mHGrO4kJdIRBrsg3P1V+goeAFgrSdiuN8SeWNKfqDCsLuxh5YA6pDMAbx2gx02YeXtlIkLhxXzfuX7yf9PYm42Vo5ejnimaRRiqJe16ZZBHSFavoRQLFDWOP3a50Wa3RftnIPjzet+ZfRrQMhTAofHXWvAGEgrNVVU5xNnziftxv/jFTo9qMZsg2Y/Fhsmi0cafceQGL/rzYWDnSib0bQC48YYjKRqp7n0H2HFVuOTs53y9G8I4ZVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9Kjohq4hNaSaUDvoi9jMVGVqKPb7CugVicjjPQujTs=;
 b=R9BFrJwMVbmnBmq0EfhbD01oGqW2wg4jRtcWE3SB7GU8oHvkc5bi+bXy4ixC78lnUo1xy8U+tzd8rnB45JpXV5+y1dUHscS0b4zCAvXfM4v8e5WhD9tgdSWRJlVJ1mipsu13Ostoj/ikFAwP0b6wPi5mwWjD1QzTmVAkOGy5h8/Oh8cmrUX9SKpxtK8iNXc0QH4jPyfs6qU8USoepkvUAwptRP0ysi2CBwhgeiqioOqxDNRBaegpGcaBoC1+BW+wTKgrn2AfDAfP6hMOfxhsxeqDnpyhJAarScowwfbgfiubsSHG6OHH9IP933S+Amfh/2EbCY/877IRmeljaDgH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9Kjohq4hNaSaUDvoi9jMVGVqKPb7CugVicjjPQujTs=;
 b=UImEE1kQaUhrUWt9VtimCpB40bWbxudzCM7XzlyyTlsuoLrCZV1cKxVBl2t1zjnzC1gX7TDVLQ1Wp7D9ksICUMJST/V9e1lbgGHkjY2lNH5E8PVkmK3h3uJIFeZNj7nhW87jJrd/xxwmqkCmWnhk6TDRbN8+lUTi8LTLsv4jxPWm9vGPGgMT8I3H0jqAIE03J74vGRd1rhf26iL3QAckY5udbzIuFP+Rb3ikGET1lZjDySoRlupQIJc8/g+W+zelXxvQSyW3hlKIIvMOdho31SM1TjU9HVzETQe1g8dZu8yekdhxckWeTH1P5C65U9+b73TQgF/9mCjBXUBGgytXKA==
Received: from DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::aa2)
 by PAXP189MB1950.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 9 Oct
 2026 11:21:29 +0000
Received: from DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
 ([fe80::edfc:2b73:2e6b:c893]) by DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
 ([fe80::edfc:2b73:2e6b:c893%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 11:21:28 +0000
From: M M <restafvalendergelijke@outlook.com>
To: "CACKGD6t4Bz1M_-9cNJ8vuNAYnXg5abb_UxmDAoFpW36yP4DnhQ@mail.gmail.com"
	<CACKGD6t4Bz1M_-9cNJ8vuNAYnXg5abb_UxmDAoFpW36yP4DnhQ@mail.gmail.com>
CC: Andreas Wild <andiwild@gmail.com>, "blaaaat@hotmail.com"
	<blaaaat@hotmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "edwardmalik95@icloud.com"
	<edwardmalik95@icloud.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@leemhuis.info"
	<regressions@leemhuis.info>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	"d.csapak@proxmox.com" <d.csapak@proxmox.com>, "f.ebner@proxmox.com"
	<f.ebner@proxmox.com>, "f.gruenbichler@proxmox.com"
	<f.gruenbichler@proxmox.com>, "s.ivanov@proxmox.com" <s.ivanov@proxmox.com>,
	"t.lamprecht@proxmox.com" <t.lamprecht@proxmox.com>,
	"f.gruenbichler@proxmox.com" <f.gruenbichler@proxmox.com>,
	"m.maurer@proxmox.com" <m.maurer@proxmox.com>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
Thread-Topic: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
Thread-Index: AQHdV9vC8awG/tAuK0CulBv+L5Ruprb1EHmb
Date: Fri, 9 Oct 2026 11:21:28 +0000
Message-ID:
 <DU2PPFBE35756D1154B16C7170AEC95EB56AB922@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
References:
 <DU2PPFBE35756D171CD64356C8D8DF3C2F8AB922@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <DU2PPFBE35756D171CD64356C8D8DF3C2F8AB922@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PPFBE35756D1:EE_|PAXP189MB1950:EE_
x-ms-office365-filtering-correlation-id: dbe7111f-37ca-4a72-61dd-08df25f7768e
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|25010399006|4140399003|8062599012|19110799012|31061999003|15030799006|37011999003|15080799012|51005399006|8060799015|2607281247196008|440099028|102099032|40105399003|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gv6fjBCHM1NLBG6JQS4m5QxYHwVEfozeumG0OyQq8kXSgGivMZRWsC5swy?=
 =?iso-8859-1?Q?Oa2APL9cDFrj9gMzQQ8ETBebP2H+Ry5QL6WMIlNUJRLGlYjmYBlekQI08a?=
 =?iso-8859-1?Q?QCfgQ1dd+UDIXdAncTzphHpOoGukpR00vELmc/IJ8LRjIGj0mCjbToljDL?=
 =?iso-8859-1?Q?7V0hXOiczbZpg5iFGKZsHBrHF5sPWuirmIpLyM/owkA5KBylgRSx8Jliao?=
 =?iso-8859-1?Q?5FkOeI5QX6Cok5ZyhCd4EocgMWELvl0YsiZ9ZgVAnhnjBA7yerH1uTEGxB?=
 =?iso-8859-1?Q?GAmJLmo+vNIrgMwr/XZCmpCkq6AXMzb8c0AnUdl76/3JRbDcWDII7SZx07?=
 =?iso-8859-1?Q?GM0eb/oEDtb39VGR5hS8GNky0O5qZjIhTH9aQk4QVIUDRWQGT+RIF1vw8/?=
 =?iso-8859-1?Q?8ccPZ2AOYBbS79Wlgqhj3+8U1J4wchHpcXqzRy/DupfvRtBr0CsBFcTFru?=
 =?iso-8859-1?Q?PHfbUruNaD0xQjCaeoOpDZWqIgsCBRutV8gbUhzDfqFGvi+1B3v/sWzqnS?=
 =?iso-8859-1?Q?JzX3VimU5YNk8ZrXDDw0zTf41Epi4cSKqgmg8TkFKj6gSaXp1azGpLTuWO?=
 =?iso-8859-1?Q?VGzx+PDnAgSWP8lIjpSILgTF7V7cEMaGfKhynkPJZMhIa3qCcXLbbkPpkg?=
 =?iso-8859-1?Q?OEbgchHMLDOwOMsS5y3Qj6hv9jPMI9tmHoVc603KaBSODUEL+Rt/pfTaQo?=
 =?iso-8859-1?Q?ilE+lJtXvVNSk0nDVfCZWJ8d+7H1ALJaMfW7ENFsRlqqjXg3m7jFC55D4c?=
 =?iso-8859-1?Q?0WfiDcQMqAC7mBxDWi9tbMsG3a6txsiIzpU5lxJghHNJbVplAa0G4CA9yj?=
 =?iso-8859-1?Q?XUO63fhFXt2xCZJLBZUnxebhuGCSuB+Iz1A7sm4ND/Zn34euNSiOseptaI?=
 =?iso-8859-1?Q?cWeZUoEx55G35eKoFps3tWZpIUmObIY649EA2QDrOFCtEEGLvXPf5A1LcR?=
 =?iso-8859-1?Q?4YgO2JzPj/HyMdhjC1GmlfJA/8R/v9BfE3efEj7lhFN7iuowhbFZMGWKlT?=
 =?iso-8859-1?Q?RsnYba1vmJtbrX2U65rPZGsfjgLLsWDAfpCU1s?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oI0OkRPEgRY5KnjhBbIShTnMGkZYM+FZM0x9/Xp53MJwNeIhUYufMUCi4Q?=
 =?iso-8859-1?Q?j3vYyoziP8ubfQ4q9twQI1+NN3dLuBwcCeYm21W8s6NX4F7M1IzcCW4ce8?=
 =?iso-8859-1?Q?fzKQ5AtlqqplgdGr4BN5ft+4EM+PRK0NUXFfijpGeVdytODO8w9yLVHrrj?=
 =?iso-8859-1?Q?7HffpOd58wM7nT4PwMNShlsq0ENJUybQ1a/J+fniMcVA392kZ5pe21b0Y5?=
 =?iso-8859-1?Q?dT4KCm4D9KynENL+sTSYIQ1Oi8qquM+xlTZlfQJXyPCo0NZ3r/3um5D336?=
 =?iso-8859-1?Q?T7GwP0pe7q5z08N3vxCddaiEnqf93QR04Xxl5OUf9hc9yW2BiXDVZtg8m/?=
 =?iso-8859-1?Q?Vv3FJ+VCP2gFUUytYKPXaKvZ2jX5J30ly4Cw/vIR36zFMBnG2VZEff1nNd?=
 =?iso-8859-1?Q?zKK462SkoUgV2fivyULipgerKbsbL/igmpJOn3G5ECgXvQKYQjYxyDn6VI?=
 =?iso-8859-1?Q?OW1xurFFvMLahl+GcPoI4V/HXXeONUsEYbAsmcQKxuPZEITbDUuw6oSilg?=
 =?iso-8859-1?Q?6y0Ijllh/2g9gx0gEvB6otTPlVGpLqkssPfMuo6xIW8L6xyXgxhwLDkNKq?=
 =?iso-8859-1?Q?HAL3HDy7KosHJHUxmJ8VTeWhcIWmlsCx09lZUnpvpvXGsbeWpzxOUqyfl8?=
 =?iso-8859-1?Q?SWwpzgd/MWRwL+2Aqgm0NjtGqANZQdaO+Ik4qP6fEcZeZoJ2Op+erhxic2?=
 =?iso-8859-1?Q?rvqxS4DJoaEddAq/p7KRqohPazKoS8LoRxFSQB/AAw0tLEgOjm3YTH8+hi?=
 =?iso-8859-1?Q?KlvUYwgKua1n3Mh063lA6aQH//ja1wTH+bgVFKc989tx0Bv/8mnbI1aofM?=
 =?iso-8859-1?Q?XWwHNYFG6CWLr9IfdgUMHc4z6croz70TAw07cB6j6TFJ0bCHaWS2ngz3MG?=
 =?iso-8859-1?Q?/5cIArzJpXhvjNj+Q04xCPMcOacKNn425tivzjtIHn7fTpevandd19tq3a?=
 =?iso-8859-1?Q?8D1LQDKr4y4LUyx23tA12H2wNdH9DokSzvH7Z0QnmpTPsqgXolAqfHgSFK?=
 =?iso-8859-1?Q?7cfvDn3lwWSz67Akv4dy/1rHJNq63IQKeUFNQViXHExpsBqZDKrwn4m4rR?=
 =?iso-8859-1?Q?+4YCWX24oft0dtZ45djEbcSlt/CdPyoRwFZD8iOxUm6U8pfoGfcyh3Wyrs?=
 =?iso-8859-1?Q?RLOiFQYRUGDzZn1Nwx571K7hxYMeZpwM/xI2uSaDVAn/jkw/bTgGX/55Cc?=
 =?iso-8859-1?Q?Qu7O6fkqLf/6VkHGRRxXmyOou/QhnPZhttOJg4tOSpfFIQPFweJwe7o2Rn?=
 =?iso-8859-1?Q?i5mYQ+ihVBsU4iPPIHLsn74icjhiUQMwCbvU0pIhbxvIkIKpkSTgIXw67r?=
 =?iso-8859-1?Q?1nVUwyxPJQbvE5chozkmOl8q19cUkkaMAnqWXOfAPcPl1u+V2FeOqknU92?=
 =?iso-8859-1?Q?udhqJwyZYtB/Gpz1IGmOJYNqAkg6SYS8AlSEchNl2a6brXaPtFBptBfl4C?=
 =?iso-8859-1?Q?UAUUo8X+dshw0i/9myhxw9AEyYa7s/T/3W+NsoEA2plzpUcuBS2S+SzYYa?=
 =?iso-8859-1?Q?fepXiUBll8YjIBz2s1I81f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe7111f-37ca-4a72-61dd-08df25f7768e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 11:21:28.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1950

Thank you Armando for the detailed follow-up. It's "good" to see this probl=
em is still active, though Proxmox is really slow with this. In the meantim=
e we are 1,5 month ahead and without the much needed security updates relat=
ed to the kernel.=0A=
I can only hope there will be some progress soon on their behalf, but it's =
pretty much quiet at Proxmox in general.=
