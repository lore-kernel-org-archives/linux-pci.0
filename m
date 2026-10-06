Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010018.outbound.protection.outlook.com [52.103.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44F1AC44D;
	Tue,  6 Oct 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320668; cv=fail; b=hYuy2IRhz27iGBO/33HC9nue+t4Yu3S5pNRvuzsc+jWAgMS85CXAfUVQOm356FdJ3Lv8+fD6j+olRLwgF6rg6hk0e8XovdiN5SPgSDmjHjauZfhU8G5q4P08dcZi2nB8mnxtQ0cbaufSHVNfwv/gpbFNcxegerR/EzJt6DwqAz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320668; c=relaxed/simple;
	bh=iUdFWfn9bP7CNPS1sU6Qkcr0ElzAIUl9sfTxo9aG8TY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXLAiEP7vca4kvrWn6r8dgWc9rrficD6tdLxJcTcNy7u4o7QrHz+30SPMCWnJ9OIBL4sKigbE6cj+BDKByMG2HlOC+/NgBTVbI1ZBP8ZidZ9aoVih1zaUnFqrVPrnqEMLq+4Oso8SLcssn2QnlkKAMpNj6t7gXRsgiM4avQGFxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rZ0OUPAP; arc=fail smtp.client-ip=52.103.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rZ0OUPAP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVVp0GDQrhfixE65N+O6qNldgBII7XoIliBTCEf3o6nONId5tzJCf19Tl+Qw7RN1TapwJDNx1TOJCIiySOrfkiAiOxo6csP2H5dU6nXmU4ZmG3VADiq5TmqP9oDaAxgYaN40N3EmVHe6o6s14yWdGATbl0EJeQHciF29rc8bzwVLEkJ+qmNrHM+EWTykdD8GkuKfQWavNiylmabsZla41rG5SnXOb4yZVAV8HmM7ojwkScr1+7mY3oPROt5YSeoePzMLQqjY2fEGUw9+IARdkspj204fwhOemMA2sruUgFXzBaqERWYfFmegYLuCSkzt2/firBzpZ6Dc2bWgRGJpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQu7/Oh5QAEOwtRrCogQoH8hzCLgDGXuEGIXHERWvnQ=;
 b=y0VeQHfcb/GKTuJ3z1tZvXQw0IbrLOYIicyWS33rlWsXbkI8jafWjvlwPoivH8jiy0GTKdwWtuBmxC2vzTV4TeDmHx7OrXMaZP0Q+kApTGyK5TT5J+wrHuFrAhSAHE1EYJ2OcyXxrK61py5dcQzlkKw3pP/aY7jU1FL84GjOlNoQMNim0ziBQtTjmdOdfKdBvdSKY3UBGI8NuInhucypIPL4A8V0KHK0L3J4A49ly2389JcM7KcHcXEuqJxfhpFkBZjuz0T/K3xmO2ciSj6ZplMaH+qYRtbETVj4DjXWRl3HGOi2gaGk6lld9kZutj2I5fI600GmngdDqjg7/mcM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQu7/Oh5QAEOwtRrCogQoH8hzCLgDGXuEGIXHERWvnQ=;
 b=rZ0OUPAP/geXyf0BjvU0XUhSewhURAqk6iCexM5QujA4hBuyJtaJx3UexXcEDOW1NnhoWF8WlioaSet5ea5en1jo5hnnBNeK4W3I/mbdA/T89vVxhMLeLFUvKJQ+5LCA4bzO1ciM3eo8kEMWCCAva0/tpYlSdLx1r+liIt9dpDT92fsJl/WqVkiLbsIQKF9CChUpU4p5fQDXTum//25lFgSNoz5e8GzX8fa31x7/0Uu8Kg4nU2q3MQNqD4hWrxU6lXOB++Fw01SpCjKOFXx8VBT6tlBhl4xPH9eOwuq5A+/+diCyUnEvYd9MYiSg4iZswJHo0rEMLAXgNd3R80gJHA==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYCPR01MB8628.jpnprd01.prod.outlook.com
 (2603:1096:400:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 21:04:19 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 21:04:19 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>, "Natikar, Basavaraj"
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJ4AADMmAgAAJ34CAAA64Zg==
Date: Tue, 6 Oct 2026 21:04:19 +0000
Message-ID:
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYCPR01MB8628:EE_
x-ms-office365-filtering-correlation-id: a1e66ee1-f3dd-4064-1330-08df23ed635b
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|24021099003|12121999013|51005399006|25010399006|41001999006|13031999006|6092099016|260826193500599007|15080799012|15030799006|40105399003|18061999006|2607281247196008|102099032|26104999009|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GarrCdsJBn9CVN+ACk6kcwWim6ravt8Xr0nV0UfVbZGMcmAYJSzLAsE8Be?=
 =?iso-8859-1?Q?wGEzNSBNZuzfeytkVXjnNxPbRLMYMWxdSYWiL23ZToy/PRFyYcm3sRR3Ad?=
 =?iso-8859-1?Q?7akDhi2fChtTwW3aGOR1r/gyST1trb83nu3wfEPZ7N1lcqQF6tZyEDwUnA?=
 =?iso-8859-1?Q?+OlckbzqF6/9j2nIhuQ/NoPFPu3OznOxAjd7twBBA7/Xp9JynMKwCAvQPO?=
 =?iso-8859-1?Q?czKKoEHAMsLKGc2Upp6b+QoOBoJyduV5eV1o1Tz8s4x1oTJWJTGErZE0ZF?=
 =?iso-8859-1?Q?Es8AZz37WrgUsU6i3lPURsqvAhdpAIOpDFy15Wxug23//bWiBdFcQ6tC43?=
 =?iso-8859-1?Q?vMBE7uzQBs+Za0qLFt4nIZPRlG2SUG5GraBFktriRYH9npsL648s04+gSi?=
 =?iso-8859-1?Q?qdKUGUcnTBj1M66HaoOIrRLzk3O69l/+d764gMzcsCAcDJ+79v/0MEgAuz?=
 =?iso-8859-1?Q?j/Sf1bo7iHjBpvFW2knUNCJhaDNrfo1f0VQRth3X0xaBT83xF2+SAByfrJ?=
 =?iso-8859-1?Q?7nDfw/ZyoQy4Eq9hbJHNc7GKJ6qaBJe/q36A+NMl/cGQQZGiUvVX1buXOV?=
 =?iso-8859-1?Q?uJsE5q6MtLpNXQ1aXxfftZzNbhwEQiO3dMZC+Gfe9X7V7P6JJUBBYoB3qQ?=
 =?iso-8859-1?Q?xCPyUnceiXn4TWpizJDBBKem53pZ1qkm0LVj30EwSf8LMbKlD5Tqoh0ENZ?=
 =?iso-8859-1?Q?wl5JbWvF6c2fB8HwADrNfVz14OSTeaTVOoLOxegkfKFf29wyIakp5B0X6n?=
 =?iso-8859-1?Q?M8JwHlcs1NJjnbg5B4BlUwOBD1l4ZK9lUktC+sZHwgW0KeNtzgXxzWtHem?=
 =?iso-8859-1?Q?bsaHeUG1y6sOmdCiZieTqdpdZVkN5krYTgXycakmg6qISwbuB6sNoQCALJ?=
 =?iso-8859-1?Q?esC3mJe9MIIBJxK0+Kgboqj7nj/tSe3uFELgPFlQHQbLZuQNRHS/DFVWhg?=
 =?iso-8859-1?Q?nAIZfgLdUJIwZVNVYetPCjgAr/dEs3Sin57s9CAFeq16V17e8oqaAssNEK?=
 =?iso-8859-1?Q?wpVQscUm0mxhjfYJDylBHAjrSAAE3VY9TCTCc09vHOhB9GFq3qAo13BsVd?=
 =?iso-8859-1?Q?ieAcc9fo5+F1yH0acdmlFKJJnZcxdC5Q676wjN5OSMdOodobHInXgxPBwm?=
 =?iso-8859-1?Q?jHdIDA1QZbeKOhAilczF7RoSeglFHCwyNuUb5QzJFUOgMS8Pe/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dS4S4JonIGQ3cqfVKnaUmffLuxzcBNZPUKE1CKbTnl9wUYp1auODNeM4gi?=
 =?iso-8859-1?Q?LQqF0XVXO3W9YXEMKECiIlPqPEdzZvZ5EeGV5rT6x8eyScxZrZ7OwmDq25?=
 =?iso-8859-1?Q?I+b1LYLAYXAZMuJIn/umaBmWFFiktDuabbkerzj79kRF6WE4ZxkdlYe9rL?=
 =?iso-8859-1?Q?JS+H5yAajFDR9m/qmXR//g/vE9AdOAv36appbx5pmK/YizWHwqP/VztvBb?=
 =?iso-8859-1?Q?AZjWESA8NCPP/DYqXUaet5kgcSyv+k8beSz98T2S6wuNsgOrTsSswhiTfJ?=
 =?iso-8859-1?Q?jv20I+MsFJJ1fxaKYaVHzLXf4c+4sDh0BWIg72uuLDShcIrHKlLS4PCEa8?=
 =?iso-8859-1?Q?pyp3qMHhexmUuL1xvBFxEAvKjl+8fccEsL9Mz1neENhTiW6hpkncz7CmpA?=
 =?iso-8859-1?Q?6W/CKCH5vmI4jwA7t+1NxoWXhW/KUP98WlScL19efWOTFtxWB/sq4Wmw8/?=
 =?iso-8859-1?Q?l+d00uCH6n9383ox+Xane1yK5KZljblQHqlxiW6Z/OMhyZxTL5KojzQ17k?=
 =?iso-8859-1?Q?2uIYO4H7pHcr2FTNB6yqzBIXQ8EgGJw+vpc48M3byN9RFgcKE96qsG0LWy?=
 =?iso-8859-1?Q?qF2QrWqGA85yzKvXAH0hLNz2liBNSE+0UtC1Obsp2B7kfQD/BkLL/wHoG4?=
 =?iso-8859-1?Q?0nk5pu2lkBJI8o2ce3KMV13y08jEobpkYaJJ/qkpTBgRCGvB+p6v1hDoii?=
 =?iso-8859-1?Q?k7XcEQtVVREtm1uq9/c7avXgUYgT2z5bLuHj0EqBHFMWgxffCINwErGKH8?=
 =?iso-8859-1?Q?WE6xc5ggIoMYuZm49+KT2LwlsucjeAs7K2bM87r4B6WeXUyIgqTh7Fe4LM?=
 =?iso-8859-1?Q?0R0pLZPhAlgPrlRqGztJUGgNdlvYAMIV644RmaHp9PW3Rpu8UJYc2qmGOn?=
 =?iso-8859-1?Q?k4Dux50uTJ3t3GR+KLE4xTOQfNeamLLMGoa0UuidizLdaKwF/Wvz6ZoMvQ?=
 =?iso-8859-1?Q?BtXB4IEPwhW6b5jdjWZ3ZhZSpPhE+mptDRa+Fdww9eT21HA+G57Ka21GJ0?=
 =?iso-8859-1?Q?5bRPfZJBQ642YuJUW4wiNHZE4kB58qJgRTTk2HCw9aO+tF+gggdpBNkrp6?=
 =?iso-8859-1?Q?CmtZLKo4m8qJehzQonx3EDpW0CeUPRuVob7BgzpNB6nZ2UFLzGBU4tSd2X?=
 =?iso-8859-1?Q?YQVQiSTaeFN1pV+y+Xx1CiZoHSWQTTtB/hQ6bI3i6HxHAKiwb33UktOyQF?=
 =?iso-8859-1?Q?Nkhy4M0rvS031/ppBhFwejD8SEbpgYWm3WRhn2aisj71KL45nrtaIXDbKm?=
 =?iso-8859-1?Q?zLQb0CB4DDd2+9Ew66VrtXUwwxTx7cLEeVteryVHzkYch42emQ706pqqYY?=
 =?iso-8859-1?Q?4yE8TLYXDB//z68pL7YlXR7s2YtiGfEB/+ZaAqo6Ka8BnHm2lmGSu6Hi44?=
 =?iso-8859-1?Q?pMrLYCtVO+CXPPU28vUczvy1sI192omN8OcFQtu19c1LZFFc4uKkTubT8u?=
 =?iso-8859-1?Q?IUj1iUhFbqx7nFdxr9LPhVTan6wwSgOkw+eJrgFzD/LXNS8H7q7rHFGJvx?=
 =?iso-8859-1?Q?I=3D?=
Content-Type: multipart/mixed;
	boundary="_003_TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952TYCPR01MB10927jp_"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e66ee1-f3dd-4064-1330-08df23ed635b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 21:04:19.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8628

--_003_TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952TYCPR01MB10927jp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=0A=
=0A=
Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.=0A=
Logs for both cases are attached. Each was taken in its own cold boot =0A=
with the dock unplugged at boot and the workaround disabled.=0A=
=0A=
  d3cold_allowed=3D0:=0A=
    before hot-plug:=0A=
      00:04.1 =3D suspended/D3hot=0A=
      NHI      =3D suspended/D3cold=0A=
      09:00.0  =3D absent=0A=
=0A=
    result:=0A=
      PASS - 09:00.0 enumerated naturally=0A=
=0A=
  d3cold_allowed=3D1:=0A=
    before hot-plug:=0A=
      00:04.1 =3D suspended/D3cold=0A=
      NHI      =3D suspended/D3cold=0A=
      09:00.0  =3D absent=0A=
=0A=
    result:=0A=
      FAIL - 00:04.1 remained suspended/D3cold and=0A=
             09:00.0 never appeared=0A=
=0A=
With d3cold_allowed=3D0:=0A=
=0A=
  gpe10: 27 -> 29 -> 31=0A=
  gpe1A: remained 0=0A=
=0A=
With d3cold_allowed=3D1:=0A=
=0A=
  gpe10: 23 -> 25 -> 27=0A=
  gpe1A: remained 0=0A=
=0A=
GPE10 incremented by four in both cases.=0A=
=0A=
In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an=0A=
runtime-resume request shortly afterwards. It reaches D0, pciehp=0A=
immediately reports Card present / Link Up, and 09:00.0 then enumerates.=0A=
=0A=
In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no=0A=
runtime-resume event for 00:04.1 after the hot-plug. It remains in=0A=
D3cold for the rest of the capture and 09:00.0 remains absent.=0A=
=0A=
IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.=0A=
=0A=
SHA256:=0A=
=0A=
  d3cold-allowed-0-20261007-041520.tar.gz=0A=
  5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292=0A=
=0A=
  d3cold-allowed-1-20261007-041802.tar.gz=0A=
  3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 3:53=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=A0=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
Thanks for the update. BTW can you try:=0A=
=0A=
BEFORE plugging the dock=0A=
=0A=
echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=0A=
=0A=
to see if the devices enumerate properly without the lspci. If they do can =
I get a log of the fail with echo 1 > /sys/bus/pci/devices/0000:00:04.1/d3c=
old_allowed=0A=
and the pass with echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=
=A0=A0 ?=0A=
=0A=
thanks!=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Kovacs, Alexander=0A=
Sent: Tuesday, October 6, 2026 2:18 PM=0A=
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Freeman,=0A=
=0A=
I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?=
=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 1:46 PM=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.=0A=
=0A=
I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:=0A=
=0A=
=A0 01:54:51.116=0A=
=A0=A0=A0 NHI:=A0=A0=A0=A0=A0 D3cold -> D0=0A=
=A0=A0=A0 sci_not:=A0 8 -> 9=0A=
=A0=A0=A0 gpe10:=A0=A0=A0 unchanged at 27=0A=
=0A=
Then:=0A=
=0A=
=A0 01:54:54.083=A0 gpe10/gpe_all/sci: 27 -> 29=0A=
=A0 01:54:55.152=A0 gpe10/gpe_all/sci: 29 -> 31=0A=
=0A=
Despite those GPE10 events, 00:04.1 remained suspended/D3cold and=0A=
09:00.0 remained absent through the end of the capture. IRQ 35 for=0A=
00:04.1 also remained at zero.=0A=
=0A=
I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.=0A=
=0A=
In SSDT17, GP12._PRW returns:=0A=
=0A=
=A0 { 0x1A, 0x04 }=0A=
=0A=
and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.=0A=
=0A=
GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.=0A=
For GP12 it does:=0A=
=0A=
=A0 If (\_GPE.ET12 !=3D 0xFF)=0A=
=A0 {=0A=
=A0=A0=A0=A0=A0 \_GPE.ET12 =3D=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x=
10)=0A=
=0A=
=A0=A0=A0=A0=A0 if ET12 is 1 or 3:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Notify (\_SB.PCI0.GP12, 0x02)=0A=
=A0 }=0A=
=0A=
For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).=0A=
=0A=
A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.=0A=
=0A=
In the earlier full capture, GPE 0x1A remained at zero in all three=0A=
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.=0A=
=0A=
GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Wednesday, October 7, 2026 1:12=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
AMD General=0A=
=0A=
Freeman,=0A=
=0A=
Great, thanks for the confirmation...=0A=
=0A=
Can you try:=0A=
=0A=
get the 00:04.1 into a suspended state=0A=
Run:=0A=
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10=0A=
Perform hotplug of dock=0A=
=A0 If gpe10 does not increment when the dock is plugged into the suspended=
 port, that's proof the wake never fired - and it's likely the GPE-0x10 _E1=
0 path. If it does tick but nothing enumerates, the miss is likely downstre=
am (native/pciehp=0A=
=A0 side).=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 11:33 AM=0A=
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Alex,=0A=
=0A=
Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.=0A=
=0A=
That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.=0A=
=0A=
Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:=0A=
=0A=
=A0 1. Cold boot with the dock disconnected.=0A=
=0A=
=A0 2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI=0A=
=A0=A0=A0=A0 (6b:00.6) runtime-suspended in D3cold before the dock is plugg=
ed in.=0A=
=0A=
=A0 3. No PCI config-space access to the root port before the hot-plug.=0A=
=A0=A0=A0=A0 A config-space access wakes 00:04.1; both the targeted 4-byte =
config=0A=
=A0=A0=A0=A0 read in this capture and plain lspci in earlier tests caused=
=0A=
=A0=A0=A0=A0 enumeration to proceed normally.=0A=
=0A=
I captured a failing hot-plug under these conditions using:=0A=
=0A=
=A0 kernel: 7.2.9-1-cachyos=0A=
=A0 BIOS:=A0=A0 319=0A=
=0A=
The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.=0A=
=0A=
A redacted archive is attached.=0A=
=0A=
SHA256:=0A=
=A0 4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065=0A=
=0A=
The relevant timeline from kernel.log is:=0A=
=0A=
=A0 98.774=0A=
=A0=A0=A0 First observable hot-plug effect. The NHI begins resuming from=0A=
=A0=A0=A0 D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one=0A=
=A0=A0=A0 between the snapshots, which is consistent with a PME wake throug=
h=0A=
=A0=A0=A0 the bridge hosting the NHI.=0A=
=0A=
=A0 101.015 - 101.017=0A=
=A0=A0=A0 Thunderbolt PCIe Down and Up tunnel paths are activated.=0A=
=0A=
=A0 101.017 - 135.664=0A=
=A0=A0=A0 00:04.1 remains suspended / D3cold.=0A=
=A0=A0=A0 The NHI remains active / D0.=0A=
=A0=A0=A0 09:00.0 remains absent.=0A=
=0A=
=A0=A0=A0 No runtime-PM activity is recorded for 00:04.1.=0A=
=A0=A0=A0 IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.=0A=
=A0=A0=A0 None of the counted ACPI GPEs change.=0A=
=0A=
=A0 135.664=0A=
=A0=A0=A0 The script performs only a 4-byte read from:=0A=
=0A=
=A0=A0=A0=A0=A0 /sys/bus/pci/devices/0000:00:04.1/config=0A=
=0A=
=A0 135.668=0A=
=A0=A0=A0 GP12 transitions from D3cold to D0.=0A=
=0A=
=A0 135.681=0A=
=A0=A0=A0 pciehp reports:=0A=
=0A=
=A0=A0=A0=A0=A0 Card present=0A=
=A0=A0=A0=A0=A0 Link Up=0A=
=0A=
=A0=A0=A0 Its first link check after resume reports:=0A=
=0A=
=A0=A0=A0=A0=A0 lnk_status =3D 0x3011=0A=
=0A=
=A0=A0=A0 This has DLL Link Active set and no Link Training bit set.=0A=
=0A=
=A0 135.808=0A=
=A0=A0=A0 09:00.0 [8086:5786] begins enumerating.=0A=
=0A=
A full lspci scan was not needed.=0A=
=0A=
So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.=0A=
=0A=
No wake of 00:04.1 was observed during the hot-plug window.=0A=
=0A=
The kernel also logs:=0A=
=0A=
=A0 Wakeup disabled by ACPI=0A=
=0A=
for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.=0A=
=0A=
There are two observations I cannot explain yet:=0A=
=0A=
=A0 1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci=0A=
=A0=A0=A0=A0 remained unchanged. The snapshots do not timestamp that increm=
ent,=0A=
=A0=A0=A0=A0 so it cannot yet be tied to the dock insertion.=0A=
=0A=
=A0 2. The final Root Status of 00:04.1, read after recovery, shows:=0A=
=0A=
=A0=A0=A0=A0=A0=A0 PME ReqID 0021, PMEStatus+ PMEPending+=0A=
=0A=
=A0=A0=A0=A0 0021 decodes to 00:04.1.=0A=
=0A=
=A0=A0=A0=A0 IRQ 35 was zero in all three interrupt snapshots. Since Root S=
tatus=0A=
=A0=A0=A0=A0 was read only after recovery, I do not know when these PME bit=
s=0A=
=A0=A0=A0=A0 became set.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Mario Limonciello <mario.limonciello@amd.com>=0A=
Sent: Tuesday, October 6, 2026 22:37=0A=
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
On 10/6/26 09:33, Kovacs, Alexander wrote:=0A=
> AMD General=0A=
>=0A=
> Freeman,=0A=
>=0A=
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.=0A=
>=0A=
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`=0A=
> (00:03.1 / NHI0 path)=0A=
>=0A=
> But that more than like does not have any bearing on the root dock enumer=
ation issue...=0A=
>=0A=
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.=0A=
>=0A=
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.=
=0A=
=0A=
I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.=

--_003_TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952TYCPR01MB10927jp_
Content-Type: application/gzip; name="d3cold-allowed-0-20261007-041520.tar.gz"
Content-Description: d3cold-allowed-0-20261007-041520.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-0-20261007-041520.tar.gz"; size=19350;
	creation-date="Tue, 06 Oct 2026 20:47:21 GMT";
	modification-date="Tue, 06 Oct 2026 20:47:21 GMT"
Content-Transfer-Encoding: base64

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
0HSLegv+Id+AJkddhnLyMrTF/b0igmlWrIt4s0hSGLd5BrME8yHTzf8fVFICPfxvU0QubKbbOS7J
3zuYaB8mizSTp2fLvQno7PotWqzQr++Pd5hyE7yJrGrX9gwTIeuoWTCrWbDc3u4aS3Bq8sq5/JbM
4oLGryfAmOw6XeWbe74Aa+QtjjC5lteOIqpMtBhB4Jel67UcbozSJcLPAZjM9qP1AhFPUYgbi6t7
KsT2UEgYJy7LkAx2c76v3wnYxFKzM/jBEcxYR+TVER2LV+jy+EqRFWqXUjRlNULrIkKvJATYWCxV
Jdj9HhcUayVS3YauV+l9upIh2hMEhU+bJ3Rx9LY4Eg7uCUn3lCki9fei6CLfLtfTJ6DBehXNMxBe
SGNMQLJBsSZSaKccK+/epRYftngzHgZ6Vg/qRlLniMjfqPyNqQ9o50305h2v19K5JOjm9OZCJgG7
URNyw5shAjBGw2UjylB4JVf4RvH9Q5bOwKsuVjuZEHwZubTrIKdPwkL1SQTMsBZVQFAkFDSm7d22
oQ01NwCyrAbUbO3d21fo7ZurC2D46fnFH+fvFBlCu7SsJqMRGN+8v7mtbAwe9y1xtdPABPf0hG46
X27WOyhdd/Rb+q1Y2IoydFR0Yna0jKflXu0jdc/2kbql+kjdu3ykbrs7knu4jkDro1zzo1L/7Z+T
8vtsgk+wmJDj03N55+/JUa5r8bug21Z5hJmnwbKc0ylRhdDfbJOQiGDtWODjNBk9lAt/Bj3LTn0J
X1tFX0lZh3p9cYa+QJJBqh790NrrH9Finqf4areVvZQLx4qCeq7kHNQfOZbEMJantbFkSmOEFi3a
e/u00duk2dtvFpss3aeriaKdF2o1R6t2Z/kXoKdh4t1qSJsaFn5tHxUrYxCGnNTJhtPFXL5rfLXd
wPdD6cEM9Div0YNvWwfxLtYuc3e27uYbTGJPf9G2CbVt2trEX8qO3Y3x1MZoedl/WGN8tTHarP0f
1phAaQzRYgC7DztXPGzuycjWk7HDezKmKKrfJgJP/l9717qjKBKF/e1T1AM0CMhFTcjEVjvprN2a
FjM/JhNSDThNBoHhsk5nd999zykQFXBGZyc7uzP1JY20yKlziqpzq6IKiiYHycHncaI8cDFS3vgh
OClhwWwRwSV5fAj+Ksr4elpLGHtZCvhzFHqCG4UfAu9AsN/qRR97IFfG4aqnn5u2oIsDXG23XjUN
f/wk8sIdjLNvy7EMVHjiXxi4+47JZyiquctgraiTiHacu350dHdzb6na3af+dTl5qyKgt+x1XXb0
/TyvqtR/32jKvUqQw9lx75+OR+pM17DP3p30/mEloaE3Jby46bMmVpEaKK1zZy4j5biO7WUvXnIg
p7Uk068hFzrbA7GWKQZXEdu5B2JDuXWs/XJi22e/oobz+BpJjrNt7D/bpHTpWKDGivQtBuWYUt2g
KHuDop4zKI2qOW9IUJZTUzI0cD2GNn15rCOhxsBUxLKSSrmcq/iHjzek2/22ONBgS7ENtu5X2zSA
y1pFGroCMk8P+ssQ+9ADGiOKR+amGj9gA1d4wd5mhm7j0KhNXRd0PKrc8YSU/1QJAAG/DKLoY0rS
PI19x4eYSATFlTPGPD+DW2gM52+I9UIzsqWv5NlDi4qZF7CmDig73wXOY3z1DqxEBGIk8I29pY6J
SVCX7Q4V+E6ZZI2wd6cgPk2eX5mIsiSqut5vDMxd9iQcCuUBA+U8NiRmKFIjHb2Lko+fci/3ilOy
yUOnqKuiEu2Y+mic7NQBV+Hd0RXcKYXd6WLTcr048Rw2NleRFMkaIsmUhRP2H2BKnTj/090Ef9m7
T/CM4WtaDkrLsmgoLYPS79Z3b8ntfDH57T25fzRrQpLF2jLxAZpk9TQxN94Ae7l0fNhonjGCZ6WN
qKzTER3SIZmuLHOzkZT6b08OMh76ZD57NPUhsSamBJwt5/cP95apaBq5my/ezm/npiprui6R5dPC
Wpjr6ZKslpap9eEX0/0J0lCGZC/oQNWaNuXnE1QRZezyv4KguM52Y03SqwSVh1Bd+kCE42DAxFEU
VQQNLSrQ1bE4FVherEx83RhYm02KM8uaM97vp6aiDuX+NVwPwK1v5AF/ANeqfDnXfWhU+Kr1j+Za
AwN5MdeKgZlkrVqLxWX7xAk0CKKd5wqZl2IOfLZazy1w18er1ehkpQ1Qs+g2M9UaUvDE4cbXwmYU
lOySkil1Oxy/CmqtSBIUSdHB8zYE8Jc1Reo9zcbTh5mYfc6+uQxshrqqsk9A/ROXb+tAWbqsaH2w
ah2Ie3VV6xDpO8p5Fnma0YSQThJFX5Twa9f/pxg/TGv9n4x7t+D2xRisd7sWqBXyOw3Qs2voiScv
zYPsn2qbrvXip4Qmzgs46ejyZhS8OvAG4Q7wZsGrdylOBS71tBhEH0QCDrNH8rB2rQvXyA7CN3T9
Q3ztgZUbeJuMRHmGvjQjuS+MZqMuIT18tr2v9QShKEKAgAlZ6HYfIxKkEB7esEWjijkMAltqnU0t
wQkm6O3e4PwR3MQVXPdXAt5qzDgEP3YTJVu2HWc3wxpIncSPs1K0HcU9rFGclG5jXGh9PFliKSx2
SIE4nPhbT1g+AE2o55tDwi3GtFOIo7c0dNlLRVmU0SAlHmMBLBRJRa7kOTg4ODg4ODg4ODg4ODg4
ODg4ODg4ODg4ODg4ODg4fhr8Db8b4t8AgAIA

--_003_TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952TYCPR01MB10927jp_
Content-Type: application/gzip; name="d3cold-allowed-1-20261007-041802.tar.gz"
Content-Description: d3cold-allowed-1-20261007-041802.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-1-20261007-041802.tar.gz"; size=12946;
	creation-date="Tue, 06 Oct 2026 20:47:22 GMT";
	modification-date="Tue, 06 Oct 2026 20:47:22 GMT"
Content-Transfer-Encoding: base64

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
WqPeAOABAA==

--_003_TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952TYCPR01MB10927jp_--
