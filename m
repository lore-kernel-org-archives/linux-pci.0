Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010019.outbound.protection.outlook.com [52.103.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748844A72C;
	Thu,  1 Oct 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879299; cv=fail; b=okkHnbgELB/x+A1Eoj+7mTvi2ViG311o9cp08iS+/DzOsv+NI7Wg9wej7HsmWgBonqSnS2MfaBZjWoO0M2cDa9k7B3vmM81u9NSCl6xN2ijZJ2gj6Y7vw1PakxiIOOZieAC3M/jdtAKWb2XfUs1fnhmxSgP9CftW+NI2lupxNXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879299; c=relaxed/simple;
	bh=uLFUiCnFFBGGU5sN3OQxLlFF8t6B+zxJFzy6qIHzEOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThnGcEpHDCvgzOXFGShuW1ulEcxdyRIfbl1yDNA7FYdljutGwt8FII75dqZgGTZfu9b9+/l2nzk+lKzjoj9ThTPG3mvMrN/jzsDYY0P66Z8aE4m4OOGclCqNHQ8Y/H3vagcd4zGV7eza7KqIxmzZhxCQZo5R9iUQSZwq2aDGx3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BKKZCeBO; arc=fail smtp.client-ip=52.103.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BKKZCeBO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwWgYSHR+ShU4QYJYt/exxpBYkVJg71eS/Iwi1/9mmgxlAwk+Kl9qrttUF0BswIxQrc2OAZ9bvfWr4ZG25Kijy6lqg6vv+Ef37JqlrEdewnCEqay/Bp6veabFi3s2wOkQBk6OqMHjYW26H2cq2Z6z441LwmCUBcDhNKpbjvQAgf51kzSMJe12LfKkuO3fFcphNr2KtUt0/8RNL08qQL/iG53y/bxxedmJk7JBkraLBqnlpXrjRMZa5NIUdx/csDr3V/c93sVpDsVeSNnRsyZfKcpfGF1VmdwTcH5LCbYNu13gugyx+7FmGuZZ2VkXH/UJkCwsyOdSIOSISI1FkDlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbo2p/36dPalZ50PXSTdJmAx6GHPWcvSf+Olkv4QbLs=;
 b=OcFZPUr+kqmc6RTYlfdgGUcgU5oQ3dDyS9F69NBUnFFVn844trtnGq7bSVjNtEnfSjYnmduMwDPLXqQ7uQxbmfvjjuyaQzdNZc64Fte7AZ2W4ZqyNzkWSKXdmlenwuBRqCTvq/l7UXyjFHhMflTnGtUY7uIreiJUzli3X+qhpX4vGxuaYwL36BtFLgur7t7UObsrNehzmWeqPbTYyUAk+sjsK/nm71lBr/rBROd5YoGaThGIRU51MRIJQLbfUBpk97MOSoX69EEb6Kj7BuHXEl7TXlCHjOMSGy/Q7V7wNyoihfTU3Jvi+AGIFcOP9hDuWjyWFzt5Ux3SbWJnp3tSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbo2p/36dPalZ50PXSTdJmAx6GHPWcvSf+Olkv4QbLs=;
 b=BKKZCeBOOOunkoknLLrJk3Dh7E7vvzEBRY3pVOEdAGJB3Hg5jNfDDzt7bc098rBuMbTmLpJI3fmPF6oQdqUZjDK/bn2jNSIoj7J20pM4Bh7HrPx7s4r+/b4Xye1V7HKnTmK4USoUVffxtBOvODgaWtMKGlO03STw/u4VTAGeNphcvvn+JV0iyUYZ6PPnR5NgeEIuTkYHtIc/oheBeuFr3s5uSFUaUUYV0+QQFOR2/3ZuExjKqXR94GHaSDnNBBp9RXhavQ65w2C2NSrSC6qZUgfOIN1SR3dNlKWB66WiEV5qdBehpG8ib6D/HGUocgxNh9CVQXgPkNfR58gHpC/7uw==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYCPR01MB6787.jpnprd01.prod.outlook.com
 (2603:1096:400:b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 18:28:11 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 18:28:11 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/Dw==
Date: Thu, 1 Oct 2026 18:28:11 +0000
Message-ID:
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T14:46:55.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYCPR01MB6787:EE_
x-ms-office365-filtering-correlation-id: b14d2ead-26eb-4158-89b7-08df1fe9bfdd
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|25010399006|19110799012|8062599012|41001999006|51005399006|31061999003|260826193500599007|8060799015|15080799012|15030799006|2607281247196008|26104999009|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WEJPB82RX3oNoPFFTvBUEpPU3MH3DWA6cdBs0k5Ylw9SgT9vdmeELmWPSD?=
 =?iso-8859-1?Q?FhVpFDzb9LNcQYXPLbm1WJYeQgtE41+0pfakRHlTVxMxMe3UrInzqUGPzn?=
 =?iso-8859-1?Q?B66sEydVwGbuidpwTh2Oe51TGqAWSjLnu+UHzRpu2mmQAGvqZLLE9eSg9y?=
 =?iso-8859-1?Q?G76vhz9sEqcLiRQhC6HEjq3Rs1qNyNwQ168StsmYL+53/Bhm67pVMcbSsE?=
 =?iso-8859-1?Q?AyONJpXjlJgh7qHT5u9UBXBhhdRVczEDUBIfc0Cs1GO0S4W4jPk7sYT75a?=
 =?iso-8859-1?Q?Cay961R+BlI4fbxheV11mfHno8kuiCr/ZlipB1gbhwltyxAsVy7+bs2tXb?=
 =?iso-8859-1?Q?CDj7osAl8I6lA67PHejGpB8Ed18zFOe3Hr0S8yx5iIY+1rkpXKUXHGZuaD?=
 =?iso-8859-1?Q?K0VOkyM2sHHOBAyjzGv2ZInz52/IeHcX3UydS4T3ilq7g/DZDlank/YJMy?=
 =?iso-8859-1?Q?xGfMGc0luyDJoVZVNCHUZLMw682qQkQzbaRqq7kel52DNX2NMJyj30tkC9?=
 =?iso-8859-1?Q?sqkpuFYZduuhdcJ3sZhICc3D8ZWRqMQYZZ9UgP4LkWctwp12+RNxbt+S6w?=
 =?iso-8859-1?Q?kqG4lrNxiM+RFZVhzaW6tSzLL1VqR/0JdijWnbAArEcLs6lbtWcWb7Gy0A?=
 =?iso-8859-1?Q?Nrgcu380u18Ujs83hnA1Ubyla5DSR8tkeaeTpnTrGZ0f6D7s5FRlrrSboS?=
 =?iso-8859-1?Q?+rkKHKYab9uentxMun4a90KmgbT6fU2MZP2ory/WW0Kmu4sOM+HFJr3D27?=
 =?iso-8859-1?Q?PeedhDTHZE2DBubWO7ijIs4nOQNywWltZzI0mn4RcvJNFjcz+Q22gzDh9t?=
 =?iso-8859-1?Q?pXDP6zIqQWT8cIhdZsNUm4K3zpdVGFjEYfAnMcQ/gA291/xIY49uRh2DaV?=
 =?iso-8859-1?Q?GqvjjQWJSgwJpYXCSY/FhkLuN/eDVkffQi4d6xbxk0/pJQI73EBVRL7Acq?=
 =?iso-8859-1?Q?IW/QPpJd4xVvQwhfS7cm0nYq1xq5XqBBV66v9bkkOdMVyO6Wt8B4DZWsMS?=
 =?iso-8859-1?Q?SrvyuFhBRzp5TfxpcXvy/+cHym3UhpjAwHNY4EKHqIGN0e/GMbHGJQIvl8?=
 =?iso-8859-1?Q?xLrzRAYO2BHlpDVwzZ0007g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?L5Nj7dLvciUuL5PHadUuj2ByNnYZswgaOnVqb6LxKCk9T/PTMOH0sMwRg+?=
 =?iso-8859-1?Q?78gQiIKdD+3UmnS/oWOm9CUUGBoT3q0ng00RGwkq33f4Ooo2v41aJYg2/y?=
 =?iso-8859-1?Q?p041KY3lwubgxVmCy5wV3HsMe1dm5zt3laE3pwqlsat8FdUuUVX7TZnpP4?=
 =?iso-8859-1?Q?GSsMSlEgflKZRV1c5nCScK7mUxPucR4HIlP6JaAy0RlsI93DrUY/JBQuHn?=
 =?iso-8859-1?Q?W1RjPCiaTsx2eRd+y2agRlnzriiF8ExJ+6bhm4/g+RuWsqnbTvGvY2zVo/?=
 =?iso-8859-1?Q?y3/yCtexzaQygZ8XvK4Uu1idhfEfiaJxlAOo+GJFU6AOUCdxgyC4LfJywu?=
 =?iso-8859-1?Q?fxm+DX2F3UbOkgj9TNdnEgyeVOKks00KAY//V1QYqtagEIUiqKl7niot8f?=
 =?iso-8859-1?Q?nriw+/e/le5VeT3nkJvz6VsJnKToHS7fR5yYN9nLKA+NzGvVV1X23Up/+m?=
 =?iso-8859-1?Q?Z27MXAncFOkN6ghRjROE5FKPnf/g1+f5QKDJo7QradwVjxQniXVbKTK5WH?=
 =?iso-8859-1?Q?apvL4PtQyRcWK64qtTOt68/IG4C9/CWEa1tCcDHGQXcsZNSRqt0y7Td+wj?=
 =?iso-8859-1?Q?uRkvyEd/QREuveGEkwDOGE23kZ46S8Z89d7jt/lmwdgYlA568QioxnuAds?=
 =?iso-8859-1?Q?BU1+WRwNAMny8o45s76a0OorPh8PYhRBY+jxrA7GLdBHPMLfm9mwmqjmQ4?=
 =?iso-8859-1?Q?atTDQE34K8volOOWTaKr8/W45/bobtzty/9oN9H6/Te/eaKbKXIFGdBdsL?=
 =?iso-8859-1?Q?Pief3Don8AbraZeTFRHZ4GYCbtPzCV3utHY8/TvkUMTxwYXPjnApIzoSRq?=
 =?iso-8859-1?Q?esGSfB/PWsASo5OkKpUVVA5PdJ7xfGfQ0VpHsLQKyCJWiLRNmzdGNa3lX4?=
 =?iso-8859-1?Q?p1qF4fxYDIZDo9HFsbNAFcZ2C9ojBxy8+Mf95nlbxolJ/somM4Wl8muOHd?=
 =?iso-8859-1?Q?s9WlbR4Tt5+WvC2lo9OymYJ5ENrfReUr7cravZArKciCWuxa1noK7Kukyl?=
 =?iso-8859-1?Q?BnvBjZDBHJvLSzh21XQS+Hr1x9Ptbnmqmddt7gztZIJltqeZD+jZfNzywT?=
 =?iso-8859-1?Q?9MbXEPbeVV5/MYBvOq35njUCD9kQ0jD/aJi96RrjIlU1rkkpR5oU/khsyd?=
 =?iso-8859-1?Q?PlBz5duuMpes39cIwqsfB9Ay71J2M1MVQ+NDE7aSWagag5cW6vdFwWL5ra?=
 =?iso-8859-1?Q?fHQ/uYE19mxOsx7aoK8NnRa36Y4Ao1tm/6Kr7HE9eCmp8LmobiPkdaK7dh?=
 =?iso-8859-1?Q?L5yBBCIA5r5J1EpmJJrj+69ATBK+uXGSRv897TfQoxCgnoPImTbGS/FfIF?=
 =?iso-8859-1?Q?hOL5koNVEVS5HW6spfRIEbtCUe/xZWywD7IhZwPamKeA4TnK4hTqNOPgau?=
 =?iso-8859-1?Q?2hsK+eU5FJTbQlAnh42AW+gmorjBfwlfy0xcLgJTClpY9Sd2Qr648=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10927.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d2ead-26eb-4158-89b7-08df1fe9bfdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 18:28:11.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6787

Hi Alex,=0A=
=0A=
I tested this with my original workaround disabled and after a reboot.=0A=
=0A=
The Kensington SD5000T5 was connected the entire time, and=0A=
0000:00:04.1 had power/control=3Dauto.=0A=
=0A=
I first monitored the sysfs runtime PM state directly. On my system,=0A=
0000:00:04.1 stayed consistently suspended rather than rapidly toggling=0A=
between active and suspended.=0A=
=0A=
I then traced the kernel runtime-PM events for 3 minutes, filtering for=0A=
0000:00:04.1 and 0000:6b:00.6. I enabled:=0A=
=0A=
    rpm:rpm_status=0A=
    rpm:rpm_suspend=0A=
    rpm:rpm_resume=0A=
    rpm:rpm_idle=0A=
    rpm:rpm_usage=0A=
    rpm:rpm_return_int=0A=
=0A=
There were no events for either device during the 3-minute trace.=0A=
=0A=
At the end of the test, the states were:=0A=
=0A=
    0000:00:04.1=0A=
        runtime_status =3D suspended=0A=
        power_state    =3D D3cold=0A=
=0A=
    0000:6b:00.6=0A=
        runtime_status =3D active=0A=
        power_state    =3D D0=0A=
=0A=
I am not seeing the active/suspended toggling on 0000:00:04.1 that=0A=
you are seeing on your test system, at least under this configuration.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Thursday, October 1, 2026 22:54=0A=
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
Do you see any toggling between suspended and active (mostly shows in sysfs=
 as active but quickly and randomly toggles to different states) on the AMD=
 HOST Bridge Tunnel (maybe 00:04.1)? It seems the Barlow Ridge controller i=
s the cause of the toggling on my test system. I have tried this with 2 doc=
ks utilizing this controller and see that the Kensington SD5000T5 dock uses=
 it also.=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, September 25, 2026 10:49 AM=0A=
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.w=
esterberg@linux.intel.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andre=
as.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vge=
r.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.N=
atikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceL=
an) <acelan.kao@canonical.com>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.=0A=
=0A=
=0A=
Hi Mario,=0A=
=0A=
Yes. The laptop is already running BIOS 319, and I do not see a newer BIOS =
available from ASUS for this model.=0A=
=0A=
BIOS 319 has also been installed on this laptop for over 1 year, the reprod=
uctions I reported were all done with this BIOS version.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Mario Limonciello <mario.limonciello@amd.com>=0A=
Sent: Friday, September 25, 2026 23:24=0A=
To: Freeman Z <SHD-ISAC@outlook.com>; Mika Westerberg <mika.westerberg@linu=
x.intel.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
 <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.ker=
nel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <we=
steri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; Yeh=
ezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kerne=
l.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <San=
ath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, J=
uan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.co=
m>=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=0A=
On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,=0A=
>=0A=
> Sure. Attached is the exact .config used for my unmodified Linus=0A=
> v7.3-rc4 test that reproduces the failure.=0A=
>=0A=
> SHA256:=0A=
> =A0 =A0 =A0488899cc5a0b5f2de69466df2639e39769d40d90682f51690400399a549309=
c2=0A=
>=0A=
> This is the final .config used after make olddefconfig for the v7.3-rc4 t=
est.=0A=
>=0A=
> The v7.3-rc4 delayed-rescan test that succeeded used the same configurati=
on base.=0A=
> The patched kernel was distinguished with a different LOCALVERSION.=0A=
>=0A=
> Please let me know if there are any other platform or configuration=0A=
> details that would help align the reference-board setup.=0A=
>=0A=
Thanks. =A0Can you also look for a BIOS update on your side from the vendor=
 in case it ends up being something unique to their BIOS?=
