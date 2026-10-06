Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011030.outbound.protection.outlook.com [52.103.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2284A92F5;
	Tue,  6 Oct 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312350; cv=fail; b=EMqm1u0hLKo9/q3BAdcFNvKHRhCes8M2rfjx2raGA4dp4kBNp2+jq5/19UI5Dy3//VVbXrLkura8GByo1Gklj9YdzoltjJZh4OJivMaTz3Ft2K0waBzLfNMSEkkKBpCZOeYJ/muw8PKqQpclA/unoaRr3DaqBGhevaOeRaYe0Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312350; c=relaxed/simple;
	bh=HaPwBkLW394pBb64haFeupCk1FonPJSblYJkLgey+bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJXXqTuS+OwImoPn42cK/QFGPq696KjxT3rzsHtjultMGA7DNPq44KUki9qNbEg+eD2iKmfEJ/Mk2rrrIjwGvC39twopT512G8iMw4diZFM4PED654cih7HZSEQ9G3iQVF2Jha9Ceu99cEIuzwxVizne/7oNbvmUvUzwzWOcRBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GKXtEgaE; arc=fail smtp.client-ip=52.103.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GKXtEgaE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BguEoJLl6nEHpED2/GxQH4eEj46tG8AwcnH4v4GKvn2WVgAjRdX4aYbmjNLE/jXt98NmfxZ+OOoLOkj9jF9z7Zwmkfg9bqlay487ekCaCwOZiEGlwFUsga2kmsiZlMGkTKp23wgqHuuEhFekRdN67lkTS483feiPFNv8Gf/aMMtsRlPr7r0uiAdw47Bj5dWdrpgbMlMDfh2t6RkuOEYP9VJHjD8NAjW1BwjCTeWeHPnNpktbVc6NLwxSLiKpht78TaHKGKASr1BQ30ox2C/nVuJEPelmpblsO5jAgK01I6ZolivdHi5RK5nS4/4C9HmV5sjlCbYhF5XqDNhF46N6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeZKtZjIiAW5g1qMppfZSSI7ybtHOGpGF9eIsjvZbt4=;
 b=rskkleE8F+BEkJEe8oCzo3GbJQrVUGdEWUty1le/TN+WGqa3/8m3NStWwLNpIaYwmYiOZCMhVaEomN1o1M398Wn6Ui+FZ8owEu5gd+JjdzlHdq9PvBv5EYFrvKJFr3cN9WOPcPd1i2fGonhE17kq3okRZZdWtyu8ApvoIh1nGZjHRDLnJyVIhzNoyo+DcWxrury9NDU04uuK3RFpvzEmkM8UpUIrZKP27MtYwv9aIippiumaU3qvMd039OJH8PCguEzGS0LCZ1CRlGKK1mcGlrGnBB7O85k5ppqfcdPDayrlRqCSrZbjilGSs6o/PwHJbqHJ4L7+U88GcCg6PwejNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeZKtZjIiAW5g1qMppfZSSI7ybtHOGpGF9eIsjvZbt4=;
 b=GKXtEgaEwMQ8iszT+mn0LQdaZOax5hGbLlRNwo9R1uGXBagoOcqqpgAyrc3EGcrLFgF48hlE94IObc8pm62oJtHpxQnJfeLfybwMnPbQMT4jpe+TC3X0J70r1yxEanNmQQK5Z/y8JYW3Fl8iGuRkufuJzGTUAlblSB780RpDdKRaajRx27ela69A5jnzCx/u4IV3qHzcT6AHUpHaSMStJK2W3A01rVVkQoh8DyiNx3qjctlvn0taxtIzICH9X3oY0Gv5UBCxps07FnSn6R+7zOXOiik5BjNLcA0Z1HRM//oL3hdwvsQkL8qkA/STUZC3/fLjMs41QgkNjGlQiRJADQ==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by OS3PR01MB7214.jpnprd01.prod.outlook.com
 (2603:1096:604:11f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 18:45:40 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 18:45:39 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJw==
Date: Tue, 6 Oct 2026 18:45:39 +0000
Message-ID:
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|OS3PR01MB7214:EE_
x-ms-office365-filtering-correlation-id: 61be326a-1aa9-4346-120e-08df23da0491
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|31061999003|15080799012|15030799006|6092099016|260826193500599007|25010399006|19110799012|13031999006|12121999013|8060799015|8062599012|24021099003|51005399006|102099032|26104999009|440099028|3412199025|18061999006|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RfUWtWFsIxOHzlT4/H1PPXmCxchC3LH0L7btSvpSLpYVlsiiSo1SQMMqBX?=
 =?iso-8859-1?Q?SnuruepS5IDhOvXAGn6MQX+bvAM/jwObRc/aI790ttIYA1YmMgDQCnIOwK?=
 =?iso-8859-1?Q?eCssQvbdA2IimsOx33WbpIwDmygJ55/I7v9Sr1z+HOeKW+qnBpxlt8J2Mu?=
 =?iso-8859-1?Q?QCR3tJwtnHKcDg9RjkdGzNNEl7yKMyZLm+SCY6+G+b8N3EamoCPCHWNOhn?=
 =?iso-8859-1?Q?olr/Jz7KiGuWYdeP7flgdfm+2qn0yx/ZpnF6Qu4LaGtv/lWJFbKz3W/oEC?=
 =?iso-8859-1?Q?Lngml9D1wdixI0kzgiccEgMRNPHuskGSHbrnwAog5brGWQxWDGCIcSBacz?=
 =?iso-8859-1?Q?mqjjgsnY+jZJUx8d1lumz7keeolwRfs5rO7AgWppTGycYmAEA3uT+/ODSG?=
 =?iso-8859-1?Q?aW+0ifdkMOLNou5cCtG1Uy2GRcaO4gf7sDd2Op6kKz4RCvMgYyd+GgPAzO?=
 =?iso-8859-1?Q?ENkiKuCHEXAJmJ6hLX2nZjA5uAjyWx0Jxqq25zQRe37L0OgLSR5qvSXaRk?=
 =?iso-8859-1?Q?GqNMV4vS/p31i/znN8YACFjj4h4puVJu4Hqf/ljXVlrEJfGa5fWnjeVgRN?=
 =?iso-8859-1?Q?SyZJ6cWj1XdJBV7Yp+VI0jpMoAgnjCFFsW84wtDKI6+fgfVPevTMphK+96?=
 =?iso-8859-1?Q?ELvMSiCDd5zeUXe82oClh9zA4OCd+LFKnRs2ByqWP0ROm/hAYhDZbuK+XR?=
 =?iso-8859-1?Q?T09h1lJ2i2FDq0ftq1elL1q8VON87hJt5jpWSJqrx4kzlFMFhwQs6T77vy?=
 =?iso-8859-1?Q?1iHqRiZZI5etV8qpgM2UjlqxsI0hPzFKccrsLz0PYp9nGL/jGKymigOc4F?=
 =?iso-8859-1?Q?fXZ0doadtc1QbWWIQbtjGpV5Nvxq/qRryLtCzsKr2s2xUsAKJShAh6mQpC?=
 =?iso-8859-1?Q?HNgoxYeVKuJEUMla4Fepa1mlJmiY2fur4XQZjX+gm8ei4xCMg1bn4A1t48?=
 =?iso-8859-1?Q?x1FWj8o6/bRj5GHuXq2+weDQz4qRJUI4x9VlDEU3SkT7sT/zAzRrxI8bFA?=
 =?iso-8859-1?Q?7m3QKkM1ZgbLnZVV3Ap23d7mIBNK5OW/jbhExDKUxC7BgaTx7RsarSOmXf?=
 =?iso-8859-1?Q?Id/RPy2LqPA0dZD9aXcwvIwVBwEMsiX9+4li5SP5sSFBriLLC0/J1tY/kV?=
 =?iso-8859-1?Q?cDUvQ8pfOVtf3pnEQ/X7uSN63KsBNDQ631Cy1RP+voUi3mi4Hz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sSaXu9li6Mw8y+krdbToTfDfm6nbcOSG19x+dnHGamE4H9nEmiPPufA5Hp?=
 =?iso-8859-1?Q?CZFEQmX+wwWgVBj5ONyPDxpCTZPlhAHFi3AbHcDgz5ZlK/2MghTg042i0Y?=
 =?iso-8859-1?Q?VcU4e/qoYqtqOe42RM6jGuF2RP+9Fv9uxGeicl9G+SZa9gtNqmbB60UzUt?=
 =?iso-8859-1?Q?nSUfQ+EQZ5/A2BKSwQucn2Ys+5DXdkOz+Hm7NI2qqao/0O/PJlkFdTylJC?=
 =?iso-8859-1?Q?PN7aOeOPiAMotDDhvkwqZZ9SS4+EeZk3Duz1cDkQCi4WRhEMqnzk8R/cHh?=
 =?iso-8859-1?Q?x+bbgabfvnAFvRfVRE6k/g+IJJJG/ZOdyRAKeWae/ZRjny0YyY6WapdhTv?=
 =?iso-8859-1?Q?niYANChHNfGhYHrmGuzLM/L0t7qwb5o5NQldXxjMs0v3ozJkeSQm4v0aHu?=
 =?iso-8859-1?Q?mjuXxfhZmwi+9A8GKWTFODQ0CFWP+J/0PiM5J2bwGdS81yYDL9YHQX5qEN?=
 =?iso-8859-1?Q?d25CHNVDaZrgjx2gTkQJQV6A+Th9ljW6H99Ifse0F1HjiveI4Cdd0BhDJh?=
 =?iso-8859-1?Q?n8YUwKhUqnilgMTBRWIgm9tf5iHMIyUsE5yClm0IkWH0UXF38CyOATqxJ5?=
 =?iso-8859-1?Q?Nvu/rQRQKATgI5bDjfzOnLvg1vr8TQkptpQBu1bxxTx3JFiKyjfw95PmiF?=
 =?iso-8859-1?Q?QQp8ohizYrlM9TODHxWqndcZL5Yd1nqJumwKsl1WS5F9CiRr5N0rpXCOmx?=
 =?iso-8859-1?Q?vNDa0PYiDd7AEG5nH9SMDYNhBQC6IiKuNRqc2NetGwGucRUswTmzO12/c4?=
 =?iso-8859-1?Q?K/wnXNxOfD7lsAbWWleDysx+FeeFQT+yioYqIOQ7fQ2bxGJCJxViYXymz0?=
 =?iso-8859-1?Q?F12tFl/zQa501G7PALXdZPAjFczqYQhFWi3F3pROVDjnJDLDz6WYNcbWU3?=
 =?iso-8859-1?Q?qFv5Z9UhdrRcHVT7rtMLeeHkDA1Q3m84genKTQZoM5KvHoxC18bw0rGXyM?=
 =?iso-8859-1?Q?0fVQJCITLM9vuCh6NtfeBPOnhqJUGBZa8XKkEUl2Jav5fYev0zBKVEtIq/?=
 =?iso-8859-1?Q?5P89FDzN1JvAfIta20thJof7LdBoZN7ntte0wwc31BmCDqvDQYPmGQ74aW?=
 =?iso-8859-1?Q?A8Ew+WyR0WQNLvZ6nMQqYT1bgWtgcDMiJABrciSiCES49C3Qscrw6TvTrt?=
 =?iso-8859-1?Q?Cbf9cFHXM79TajRfk71yx5jAWeTBnL2a/kXkinbjU35jk4+UlFiyeUyEnf?=
 =?iso-8859-1?Q?zccISGQS1fX9ZE/kGIHhHOEpuhXCTACHao+2QGdLefKZAtEU1S1EnRiSMJ?=
 =?iso-8859-1?Q?XWp5qT1Ff6wUuGsjiVcrxCQ71IpIDFl/RaFpZcq4xWNuC3bvUL9UH/pe8f?=
 =?iso-8859-1?Q?ETA/DlcX8usRZtueobTsZh5v7VPltodGd7/Vub3kqs/HuFT2XYiFVeazWD?=
 =?iso-8859-1?Q?HTS42TJCkBi9rwVtUiIBQtdlTcA7vRzXdn0t6MN0GXXnbjXz/4yz9MZkSA?=
 =?iso-8859-1?Q?byws+nroyuwRP1EBVviT4ZjZlefNB8+nluoqYDPogp08l8WR5suTLH/Q1I?=
 =?iso-8859-1?Q?Y=3D?=
Content-Type: multipart/mixed;
	boundary="_002_TYCPR01MB109272C6ADB253EBABEEB30AC96952TYCPR01MB10927jp_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be326a-1aa9-4346-120e-08df23da0491
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 18:45:39.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7214

--_002_TYCPR01MB109272C6ADB253EBABEEB30AC96952TYCPR01MB10927jp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=0A=
=0A=
I reran the test with both 00:04.1 and the NHI in D3cold, polling the=0A=
ACPI counters and device states every ~200 ms.=0A=
=0A=
I pressed Enter late, so the manual "DOCK PLUGGED" marker should be=0A=
ignored for timing. The first observable hot-plug effect was:=0A=
=0A=
  01:54:51.116=0A=
    NHI:      D3cold -> D0=0A=
    sci_not:  8 -> 9=0A=
    gpe10:    unchanged at 27=0A=
=0A=
Then:=0A=
=0A=
  01:54:54.083  gpe10/gpe_all/sci: 27 -> 29=0A=
  01:54:55.152  gpe10/gpe_all/sci: 29 -> 31=0A=
=0A=
Despite those GPE10 events, 00:04.1 remained suspended/D3cold and=0A=
09:00.0 remained absent through the end of the capture. IRQ 35 for=0A=
00:04.1 also remained at zero.=0A=
=0A=
I went back through the ACPI tables and noticed that GPE 0x1A and=0A=
GPE 0x10 appear to be two distinct wake paths for GP12.=0A=
=0A=
In SSDT17, GP12._PRW returns:=0A=
=0A=
  { 0x1A, 0x04 }=0A=
=0A=
and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS=0A=
(as well as the associated GP19/NHI devices) without checking PCIe=0A=
Root Status.=0A=
=0A=
GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.=0A=
For GP12 it does:=0A=
=0A=
  If (\_GPE.ET12 !=3D 0xFF)=0A=
  {=0A=
      \_GPE.ET12 =3D=0A=
          (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x10)=0A=
=0A=
      if ET12 is 1 or 3:=0A=
          Notify (\_SB.PCI0.GP12, 0x02)=0A=
  }=0A=
=0A=
For 00:04.1, offset 0x78 is the PCIe Root Status register=0A=
(PCIe capability at 0x58 + 0x20).=0A=
=0A=
A GPE10 increment only shows that _E10 ran; it does not by itself=0A=
show that the GP12 branch saw PME Status set or that GP12 received the=0A=
Device Wake notification.=0A=
=0A=
In the earlier full capture, GPE 0x1A remained at zero in all three=0A=
snapshots: before the plug, after the failed hot-plug, and after the=0A=
targeted config-space read. 00:04.1 remained in D3cold until that=0A=
targeted read, which immediately caused GP12 to transition to D0 and=0A=
the downstream hierarchy to enumerate.=0A=
=0A=
GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port=0A=
with GP19.NHI1 / USB4 port 2.=0A=
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
=A0=0A=
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

--_002_TYCPR01MB109272C6ADB253EBABEEB30AC96952TYCPR01MB10927jp_
Content-Type: application/gzip; name="gpe10-hotplug-20261007-015343.tar.gz"
Content-Description: gpe10-hotplug-20261007-015343.tar.gz
Content-Disposition: attachment;
	filename="gpe10-hotplug-20261007-015343.tar.gz"; size=7753;
	creation-date="Tue, 06 Oct 2026 18:34:21 GMT";
	modification-date="Tue, 06 Oct 2026 18:34:21 GMT"
Content-Transfer-Encoding: base64

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
AA==

--_002_TYCPR01MB109272C6ADB253EBABEEB30AC96952TYCPR01MB10927jp_--
