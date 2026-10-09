Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D248595E;
	Fri,  9 Oct 2026 20:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577697; cv=fail; b=ext0cBoJkEav7KSg9wHI4G1AyF2TtNJ5JM8AzQsZJua8zaurMlDE6tTJtnKmPCHAMj+m8t3YC6HnEeBEHZtkLzPt5eQrBNpH+/HjS92p2omSH7aEQRiykT0oAsighHlQath6EAjrSXlFwfyppgKHz2bb4SQpVPpySJhgbha9sA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577697; c=relaxed/simple;
	bh=O9pQeiSkqFd/qYNUb63bk/e1BiEmlVS7zMMSWEMIG7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LC9jPEJ792UrFmxbyCZoPZl7cdKglUcRpbmZdUzwhsBqzBABQ2JnF7sIZjuE9ORg6V2VUTPai+ddUlq4/CE0acz14nHb9F96qywgjwNpnL7Vwk4mh+3J546OfQHCvfZzNJF5otc+nDnQdsIBC5+mK1YydeH/hH6/ERxRb0UyskE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MdHkRgwv; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MdHkRgwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUrN4+7vk2znLlv6aatM+2/lZl8kzBrM/1oU9GBPGX49M+KXJpx8eJFd4lKOgiKVu3Vh79SwWWWPY66RyhzIWXJK4ZFTzh7CFPbNli2gnQ1TVsv9E+akKyFvPkuINfjYlBXlPsd2doKl/GLK67TAF5OfwqqoU2BaKzdbBPoGeC2UQg1+TpmE1Tkiiq7X7rdsrYd0xyUmAsKUd2/yXM6EXvyIH+ZmZGwBVTPvynIxjdaAUa6bLoz/jBXWrKvSE7J5oVivU2r/egW9sLJgz0B7CKls9hiBPQJnbmcXpZNjW0dhKwEBvoz0jsYAdai//alDS/EzbPVV85ko0RQiuchaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXozLTs6z8TAM9aKQRo0zyuBSZy3lKdFmK5fveQ+0x4=;
 b=x1AviP4wZ+r0fE5cZOPttpWnpJtIIHtob09Rz6z3mJcciOrN5e2TERPui6Y84zIT96DiUPD3i02briBmDlVj+JU/lobUvO5/fpR0nDhR69TgbekguoW1wuFOsQRLNgkYsHn9AIFLFB9/Xjfwhii7/gKLr4EA0uMDYs2da6zC2IBHC2VeE/v9TXuRFQeyYcUpD7oZhSHbwNEhYCyJLg4iLtlKycVd+Le1dRB93g3dvogh7jlwjE8KzfStGmtHjxWObH0te+Q4BYnqBCKNm4Ddm7QgxamI58Fkg+KoYDninjCLMMcnLRHlyH4o7tT9V46u5DClod+tQaHVfGhTymV1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXozLTs6z8TAM9aKQRo0zyuBSZy3lKdFmK5fveQ+0x4=;
 b=MdHkRgwviD51CbQJSEc977sxW4xyL9VAFh0gqMAN6zc2mc0Mu+MD/NbErmyReXKhZ4xGLxdushasrGkyEIoctiwYwfVnuYGY4Ukvu0fZxBvlMS1qTvqDvWGxtqqj4Ny070sF//bY+lTV4X7MCWFRRrt1KhYlElstIaWlV/H7Vmw=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 20:28:07 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:28:07 +0000
From: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>
To: Freeman Z <SHD-ISAC@outlook.com>, "Limonciello, Mario"
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
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kCAAAk1QIAAFJeAgAQrt/CAAASwgIAACANQgAAXXACAAFxcoA==
Date: Fri, 9 Oct 2026 20:28:07 +0000
Message-ID:
 <DS7PR12MB9550BB636770CB3984E5DA999C922@DS7PR12MB9550.namprd12.prod.outlook.com>
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
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB10927E84328D5CB5D9278D98096922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95500DA47DA5616DA06DF67D9C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272AB9BEA4B0DC82DB90C496922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB109272AB9BEA4B0DC82DB90C496922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|PH0PR12MB5608:EE_
x-ms-office365-filtering-correlation-id: 9dfaf2cd-3523-4a0a-ba31-08df2643d410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|6049299003|376014|366016|1800799024|10067099003|5023799004|56012099006|6133799003|3023799007|260925022911599003|11063799006|260925021911599003|4143699003|260925021311599003|22082099003|18002099003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 EVZAXTv9e8BIwKjd31IncdEohMrGJOeqADY90heprPg0mwTkxnu+0eWaHbe/sWmqr/Fo6hoLSrhAl0AfY+qEKLDYqnflZvYFwcDdBZk850RAdZfwuJdRcm7lEuPtT6cIq3VUbyB5huhBFDU+RAPmYAHz9z1ZNsEE4H4qmTkp5MYvJ33iHAlRNYwcMYeHjWzct8rdF04p1ppm4y8lPm4Nq+mPJqfUZ7RGaJSSCijQt5Z2ySeBUASnRG0uifNFWsJ+S6DL7f70foK1h3OUIZzlynbjL4rfYzP3xFHjc++MBOTp3rE1QSLaOF0q9EhCpti0POU3IO0XeOZyH0pXsqn8+gZWsNQF6PGz49cw2Xv3HYeC3yg6qVvA60F38Zgrn4XyJj5B7yCugbeueeD5JmvH1mnqYZWMRW8jCTufOElGGoTxu04OcXQgF6OGRce7Hz3EkRy5FzcAP+W/jW9ADFO/avpKSSNVykvpDS2ds6OmlaM9oqxiX/hGWlW4JHGYTAMCUwgWcJY6F6/jSXgN4l/Nt7hJt7aqhnD3Ua0zzt5LeYxyDYzHwDfvwTDf0Dv+OOqS6YagGmWSkzt7+RCgIfHEChBz/oJMt1N8Jrh9J0szADVYXqXYXGWIV9ZyCgyEA4ZglrHsqKiViqYLCVfmm7ulIn3kCxtDiCnaef6Qt4XPxKQujGqogTrvuNC/qek/QKgfH/mATIYjKiRclkfh2mdRxIkFsHvwqoOH4dyHufLyuQQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(6049299003)(376014)(366016)(1800799024)(10067099003)(5023799004)(56012099006)(6133799003)(3023799007)(260925022911599003)(11063799006)(260925021911599003)(4143699003)(260925021311599003)(22082099003)(18002099003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Te9Y3ozURNls0aARrgaSVmtQa4aZu8RYuRUS0tvUADLBQd7QRa1d7m7bxUbJ?=
 =?us-ascii?Q?ew7CfbsoVm8n/QkUG7JRlWD5zmKTkGBU4ZMokxD6UEbLerIg039lsaZsZsBC?=
 =?us-ascii?Q?sX1Zt1YB/5S+5qrWzkRDDzEUdUzo6qG7OaQCPq/o6Vjk7ynYkiD83fL3TpsG?=
 =?us-ascii?Q?yZSG8BpLb8v48Ai4ATvxrkk8/tXsKOlFgORdGuNkXgl7JU60lbNRVGH+gHg6?=
 =?us-ascii?Q?uNdIUGO/tByrzNGxRsGueC/TmX+fE1gkYJ1M1etmdkOIJ9DDMngHccNJmm4S?=
 =?us-ascii?Q?9gFaZRogRLWNoej9DT5A21stbxDwfjDGEtSwyC1KCvCw+ZQ+I7wxaAp8rNhj?=
 =?us-ascii?Q?P+66yqIPDnGNm55KuDmyWlv+qpI8h0aUlbTr0rZJYaByQA3aePfoafeMUpQD?=
 =?us-ascii?Q?x3ql7k4spgHDwLCedq70/F2dlrMvtjrw4LCKMlaA1FiuPzVI5z79v1ohvA8q?=
 =?us-ascii?Q?9qaqrAjO9WqH8WYmcJP81AXlzSdGPj2dMh67zVOMnjmG5NegRAnpSyyPOLjN?=
 =?us-ascii?Q?7ohYxI3pqSoD3E04Z9YTbUGckkMdptNZgpb2o9SdHJn8YtM9mhiWfjfiqIvZ?=
 =?us-ascii?Q?JxRIoIAJbw92vHcY0xmARuYxC3R5DowSBdkKMAUAwhYPoCrzNED4cq7SPiWq?=
 =?us-ascii?Q?QC9uyhK9YB9eiVHzPcQTJBo8AbZZS5UwO4R5z1Yj/w4ngNGjlrGbMLgOlMLo?=
 =?us-ascii?Q?33VsMM+R332PGL9/DtgClHsVFf1xSBU2RXZjZF93GEgDplUNMBMf+soS9pMH?=
 =?us-ascii?Q?V5LtepetS4UP1w4Tbr8OhN1AebNERvyWwc8/r3ElAVLc6PRoku2usS9NBaWd?=
 =?us-ascii?Q?UCk+cPdsY2CP1CEZ7U/apoltvaQG8mPyb2ItPMIyo0WZFPQjL2rzECjISq6J?=
 =?us-ascii?Q?ehK3Y4Stndds5rbcBG6EK99EftJPL9SHPa0hVzYfxunvRhpIOsS9fDPAUBIl?=
 =?us-ascii?Q?ErVRJxV5jwXLjUghFKnI446Gu16BM19rkIzM0wlNV6H7DMB0bvrE5ajCT+cV?=
 =?us-ascii?Q?g8OgVZ1qJxcEVY0YdYTs2NgSSyjqLJW4nLc42oXaQlBu1OCl6xV+ZVGIQR1n?=
 =?us-ascii?Q?i2orC8rrlqxrex9/fyZciuP/F9eTV1/nhCAMi2ac+0pmV0o+GIeUJrwOZbwY?=
 =?us-ascii?Q?Wt7V8HhZsqBrv0YFJZw1bd4/zxNltHDBfBtJb98F+K6c/YoFLR27uzy6X4MZ?=
 =?us-ascii?Q?8N5QZj6IlXs1oAlZ0eAUBipPaYSDYLO1EykIpFKJ5AqK6GqaLuPpre8xctxy?=
 =?us-ascii?Q?aS0G9QJaK83f9imgc4sg8/4KlpyqfM26cULv4TcUZ+R9d9zZEojNWFuifPzq?=
 =?us-ascii?Q?8cIajms0TdrnsFjuXvRjYmOp874JaxrI+B7tJI7KwwLjRpmA04lpoP6hGNkw?=
 =?us-ascii?Q?GaMzW+e0/pdgi2CK0AgojKgJ9iFG6V2BDXrWgMOrUkeuJOQjfkkMwoSzPmtJ?=
 =?us-ascii?Q?eu8eQ4OdRA/S87tLlDLfkEgvU7waCEHY0nun1LKJwvPGYm7wnClfSctzBO/o?=
 =?us-ascii?Q?KSXiW0xM5o8mbC7QEd49Nc/0O3A8vRUIWM0penHe5N+zf3uySEcX2sE+ViZZ?=
 =?us-ascii?Q?0aiFS1W0OSHLdNhIbWKeAa2CYuP62sfM8iyI1tt8g2D8utJofNX9HYiNTcSo?=
 =?us-ascii?Q?TdCUgn125rCt1oFNC53ZS7MDVSLL2fvVxj0ogLxrmxXChOLb9kpTeGMIexmy?=
 =?us-ascii?Q?Cpc5yc1PmTd+XeC1UAt4ErqclF4rpFcFoKzxBuP6Izz2zQyX?=
Content-Type: multipart/mixed;
	boundary="_002_DS7PR12MB9550BB636770CB3984E5DA999C922DS7PR12MB9550namp_"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfaf2cd-3523-4a0a-ba31-08df2643d410
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 20:28:07.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNMK7ikMaikkAi7TEwcw+/xaAikHhylYws13sQ567UIMW2bEo3HEBnZGsCecHrOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608

--_002_DS7PR12MB9550BB636770CB3984E5DA999C922DS7PR12MB9550namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Freeman,

I have attached a v3 of your original script. Could you please rerun both 0=
 & 1 test cases.

Thank you...

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, October 9, 2026 9:55 AM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

I reran both tests using the new v2 script, I've attached new captures.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Friday, October 9, 2026 21:39
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

I have attached a modified version of your capture script, please return th=
e 0 & 1 logs of the attempted plug actions.

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, October 9, 2026 8:03 AM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Yes, both tests were performed on CachyOS.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Friday, October 9, 2026 20:47
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

For clarity, the D3Cold Allowed set to 0 and 1 tests were on the Catchy OS =
?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 4:04 PM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.
Logs for both cases are attached. Each was taken in its own cold boot with =
the dock unplugged at boot and the workaround disabled.

  d3cold_allowed=3D0:
    before hot-plug:
      00:04.1 =3D suspended/D3hot
      NHI      =3D suspended/D3cold
      09:00.0  =3D absent

    result:
      PASS - 09:00.0 enumerated naturally

  d3cold_allowed=3D1:
    before hot-plug:
      00:04.1 =3D suspended/D3cold
      NHI      =3D suspended/D3cold
      09:00.0  =3D absent

    result:
      FAIL - 00:04.1 remained suspended/D3cold and
             09:00.0 never appeared

With d3cold_allowed=3D0:

  gpe10: 27 -> 29 -> 31
  gpe1A: remained 0

With d3cold_allowed=3D1:

  gpe10: 23 -> 25 -> 27
  gpe1A: remained 0

GPE10 incremented by four in both cases.

In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an runtime=
-resume request shortly afterwards. It reaches D0, pciehp immediately repor=
ts Card present / Link Up, and 09:00.0 then enumerates.

In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no runti=
me-resume event for 00:04.1 after the hot-plug. It remains in D3cold for th=
e rest of the capture and 09:00.0 remains absent.

IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.

SHA256:

  d3cold-allowed-0-20261007-041520.tar.gz
  5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292

  d3cold-allowed-1-20261007-041802.tar.gz
  3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Wednesday, October 7, 2026 3:53
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

Thanks for the update. BTW can you try:

BEFORE plugging the dock

echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed

to see if the devices enumerate properly without the lspci. If they do can =
I get a log of the fail with echo 1 > /sys/bus/pci/devices/0000:00:04.1/d3c=
old_allowed
and the pass with echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=
   ?

thanks!

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Kovacs, Alexander
Sent: Tuesday, October 6, 2026 2:18 PM
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Freeman,

I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 1:46 PM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.

I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:

  01:54:51.116
    NHI:      D3cold -> D0
    sci_not:  8 -> 9
    gpe10:    unchanged at 27

Then:

  01:54:54.083  gpe10/gpe_all/sci: 27 -> 29
  01:54:55.152  gpe10/gpe_all/sci: 29 -> 31

Despite those GPE10 events, 00:04.1 remained suspended/D3cold and
09:00.0 remained absent through the end of the capture. IRQ 35 for
00:04.1 also remained at zero.

I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.

In SSDT17, GP12._PRW returns:

  { 0x1A, 0x04 }

and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.

GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.
For GP12 it does:

  If (\_GPE.ET12 !=3D 0xFF)
  {
      \_GPE.ET12 =3D
          (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x10)

      if ET12 is 1 or 3:
          Notify (\_SB.PCI0.GP12, 0x02)
  }

For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).

A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.

In the earlier full capture, GPE 0x1A remained at zero in all three
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.

GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Wednesday, October 7, 2026 1:12
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

Great, thanks for the confirmation...

Can you try:

get the 00:04.1 into a suspended state
Run:
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10
Perform hotplug of dock
  If gpe10 does not increment when the dock is plugged into the suspended p=
ort, that's proof the wake never fired - and it's likely the GPE-0x10 _E10 =
path. If it does tick but nothing enumerates, the miss is likely downstream=
 (native/pciehp
  side).

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 11:33 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.

That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.

Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:

  1. Cold boot with the dock disconnected.

  2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI
     (6b:00.6) runtime-suspended in D3cold before the dock is plugged in.

  3. No PCI config-space access to the root port before the hot-plug.
     A config-space access wakes 00:04.1; both the targeted 4-byte config
     read in this capture and plain lspci in earlier tests caused
     enumeration to proceed normally.

I captured a failing hot-plug under these conditions using:

  kernel: 7.2.9-1-cachyos
  BIOS:   319

The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.

A redacted archive is attached.

SHA256:
  4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065

The relevant timeline from kernel.log is:

  98.774
    First observable hot-plug effect. The NHI begins resuming from
    D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one
    between the snapshots, which is consistent with a PME wake through
    the bridge hosting the NHI.

  101.015 - 101.017
    Thunderbolt PCIe Down and Up tunnel paths are activated.

  101.017 - 135.664
    00:04.1 remains suspended / D3cold.
    The NHI remains active / D0.
    09:00.0 remains absent.

    No runtime-PM activity is recorded for 00:04.1.
    IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.
    None of the counted ACPI GPEs change.

  135.664
    The script performs only a 4-byte read from:

      /sys/bus/pci/devices/0000:00:04.1/config

  135.668
    GP12 transitions from D3cold to D0.

  135.681
    pciehp reports:

      Card present
      Link Up

    Its first link check after resume reports:

      lnk_status =3D 0x3011

    This has DLL Link Active set and no Link Training bit set.

  135.808
    09:00.0 [8086:5786] begins enumerating.

A full lspci scan was not needed.

So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.

No wake of 00:04.1 was observed during the hot-plug window.

The kernel also logs:

  Wakeup disabled by ACPI

for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.

There are two observations I cannot explain yet:

  1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci
     remained unchanged. The snapshots do not timestamp that increment,
     so it cannot yet be tied to the dock insertion.

  2. The final Root Status of 00:04.1, read after recovery, shows:

       PME ReqID 0021, PMEStatus+ PMEPending+

     0021 decodes to 00:04.1.

     IRQ 35 was zero in all three interrupt snapshots. Since Root Status
     was read only after recovery, I do not know when these PME bits
     became set.

Best regards,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Tuesday, October 6, 2026 22:37
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

On 10/6/26 09:33, Kovacs, Alexander wrote:
> AMD General
>
> Freeman,
>
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.
>
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`
> (00:03.1 / NHI0 path)
>
> But that more than like does not have any bearing on the root dock enumer=
ation issue...
>
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.
>
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.

I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.

--_002_DS7PR12MB9550BB636770CB3984E5DA999C922DS7PR12MB9550namp_
Content-Type: application/octet-stream; name="d3cold-allowed-test-final-v3.sh"
Content-Description: d3cold-allowed-test-final-v3.sh
Content-Disposition: attachment; filename="d3cold-allowed-test-final-v3.sh";
	size=20059; creation-date="Fri, 09 Oct 2026 20:20:23 GMT";
	modification-date="Fri, 09 Oct 2026 20:28:06 GMT"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYmFzaAojIEFsZXggcmVxdWVzdGVkIGQzY29sZF9hbGxvd2VkIEEvQiB0
ZXN0IGZvciBBU1VTIEdWMzAyWFYgKyBTRDUwMDBUNS4KIwojIFVzYWdlOgojICAgc3VkbyBiYXNo
IGQzY29sZC1hbGxvd2VkLXRlc3QtZmluYWwuc2ggMCAgICMgRDNjb2xkIGZvcmJpZGRlbiAoUEFT
UyBjYW5kaWRhdGUpCiMgICBzdWRvIGJhc2ggZDNjb2xkLWFsbG93ZWQtdGVzdC1maW5hbC5zaCAx
ICAgIyBEM2NvbGQgYWxsb3dlZCAgIChGQUlMIGNhbmRpZGF0ZSkKIwojIFJ1biBPTkUgdGVzdCBw
ZXIgY29sZCBib290LCB3aXRoIHRoZSBkb2NrIHBoeXNpY2FsbHkgVU5QTFVHR0VELgojIFRlbXBv
cmFyaWx5IHJlbmFtZSA5OS1mbG93LXgxMy11c2I0LXBtLnJ1bGVzIHRvIC5kaXNhYmxlZCBiZWZv
cmUgYm9vdGluZy4KIyBEbyBOT1QgcnVuIGxzcGNpIG9yIGFueXRoaW5nIGVsc2UgdGhhdCByZWFk
cyBQQ0kgY29uZmlnIHNwYWNlIGJlZm9yZS9kdXJpbmcKIyB0aGUgdGVzdC4gVGhlIHNjcmlwdCBw
ZXJmb3JtcyBubyByZWNvdmVyeSBzdGVwIGFuZCBuZXZlciByZWFkcyBQQ0kgY29uZmlnLgojCiMg
ZDNjb2xkX2FsbG93ZWQgaXMgcnVudGltZSBzdGF0ZSBhbmQgaXMgcmVpbml0aWFsaXplZCBvbiBy
ZWJvb3QuIFRoZSB1ZGV2CiMgd29ya2Fyb3VuZCBmaWxlbmFtZSBpcyBwZXJzaXN0ZW50IGFuZCBt
dXN0IGJlIHJlc3RvcmVkIG1hbnVhbGx5IGFmdGVyd2FyZHMuCiMKIyB2MjogdGhlIHByaXZhdGUg
dHJhY2UgaW5zdGFuY2Ugbm93IGFsc28gY2FwdHVyZXMgV0hPIHJlc3VtZXMgdGhlIHJvb3QgcG9y
dC4KIyAgIC0gYSBzdGFja3RyYWNlIHRyaWdnZXIgb24gcnBtX3Jlc3VtZSBmb3IgdGhlIHJvb3Qg
cG9ydCwgYW5kCiMgICAtIGEgZnVuY3Rpb24gdHJhY2Ugb2YgcGNpX2FjcGlfd2FrZV9kZXYoKSAo
dGhlIEFDUEkgUE1FLW5vdGlmeSBoYW5kbGVyKS4KIyBUb2dldGhlciB0aGVzZSB0ZWxsIGEgZmly
bXdhcmUtZGVsaXZlcmVkIHdha2UgKEFDUEkgTm90aWZ5IHJhbikgYXBhcnQgZnJvbSBhCiMgZHJp
dmVyLWluaXRpYXRlZCByZXN1bWUuIFNlZSB0cmFjZS50eHQgYW5kIFJFQURNRS50eHQgaW4gdGhl
IG91dHB1dCBmb2xkZXIuCiMKIyB2MzogYWxzbyB3YXRjaCB0aGUgVVNCMi9QRCBoYW5kc2hha2Us
IHRoZSBub24tdHVubmVsZWQgaGFsZiBvZiBhIFR5cGUtQyBwbHVnLgojICAgLSBycG1fcmVzdW1l
ICh3aXRoIHN0YWNrdHJhY2UpIGZvciB0aGUgaG9zdCB4SENJcyBYSEMzL1hIQzQsIGFuZAojICAg
LSB1Y3NpIHRyYWNlcG9pbnRzIChpZiBwcmVzZW50KSBmb3IgdGhlIFBEL1VDU0kgY29ubmVjdG9y
LWNoYW5nZS4KIyBUaGVzZSBzaG93IHdoZXRoZXIgYSBwaHlzaWNhbCBwbHVnIHdha2VzIGEgaG9z
dCBVU0IgY29udHJvbGxlciBmcm9tIEQzY29sZAojIGJlZm9yZSAtLSBvciBpbmRlcGVuZGVudCBv
ZiAtLSB0aGUgcm9vdCBwb3J0LCBpLmUuIGEgY2FuZGlkYXRlIHdha2UgdHJpZ2dlci4KCnNldCAt
RWV1byBwaXBlZmFpbAoKVkFMPSR7MTotfQppZiBbWyAiJFZBTCIgIT0gIjAiICYmICIkVkFMIiAh
PSAiMSIgXV07IHRoZW4KICAgIGVjaG8gIlVzYWdlOiBzdWRvIGJhc2ggJDAgMHwxIgogICAgZXhp
dCAyCmZpCgppZiBbWyAkKGlkIC11KSAtbmUgMCBdXTsgdGhlbgogICAgZWNobyAiRVJST1I6IHJ1
biBhcyByb290LiIKICAgIGV4aXQgMQpmaQoKUlA9MDAwMDowMDowNC4xCk5IST0wMDAwOjZiOjAw
LjYKRVA9MDAwMDowOTowMC4wCiMgSG9zdC1zaWRlIHhIQ0kgY29udHJvbGxlcnMgKFhIQzMvWEhD
NCwgX0FEUiAweDAzLzB4MDQpLiBVU0IyIG9uIGEgVHlwZS1DIHBvcnQKIyByaWRlcyBkZWRpY2F0
ZWQgRCsvRC0gcGlucyBhbmQgaXMgTk9UIHR1bm5lbGVkLCBzbyBhIHBsdWcgZXZlbnQgcmVhY2hl
cyB0aGVzZQojIGNvbnRyb2xsZXJzIGltbWVkaWF0ZWx5IC0tIGluZGVwZW5kZW50IG9mIHRoZSBQ
Q0llIHR1bm5lbCBhbmQgb2YgR1AxMidzIEQtc3RhdGUuCiMgdjMgd2F0Y2hlcyB0aGVtIHRvIHNl
ZSB3aGV0aGVyIHRoYXQgVVNCMi9QRCBoYW5kc2hha2Ugd2FrZXMgdGhlbSBmcm9tIEQzY29sZAoj
IChhIGNhbmRpZGF0ZSBEM2NvbGQtaW5kZXBlbmRlbnQgd2FrZSB0cmlnZ2VyIHRoZSBlYXJsaWVy
IGNhcHR1cmVzIG5ldmVyIG9ic2VydmVkKS4KWEhDSTA9MDAwMDo2YjowMC4zClhIQ0kxPTAwMDA6
NmI6MDAuNApEPS9zeXMvYnVzL3BjaS9kZXZpY2VzCkk9L3N5cy9maXJtd2FyZS9hY3BpL2ludGVy
cnVwdHMKVFJBQ0VfUk9PVD0vc3lzL2tlcm5lbC90cmFjaW5nClJVTEU9L2V0Yy91ZGV2L3J1bGVz
LmQvOTktZmxvdy14MTMtdXNiNC1wbS5ydWxlcwpSVUxFX0RJU0FCTEVEPSR7UlVMRX0uZGlzYWJs
ZWQKCiMgVGVzdCB0aW1pbmc6IDMgcyBiYXNlbGluZSwgdGhlbiA2MCBzIGFmdGVyIHRoZSBQTFVH
IE5PVyBtYXJrZXIuCkJBU0VMSU5FX1NFQz0zClBPU1RfUExVR19TRUM9NjAKUkVBRFlfVElNRU9V
VD0xMjAKCiMgT3V0cHV0IHBhdGhzLgpTVEFNUD0kKGRhdGUgKyVZJW0lZC0lSCVNJVMpCk9VVD0v
cm9vdC9kM2NvbGQtYWxsb3dlZC0ke1ZBTH0tJHtTVEFNUH0KUkFXX0xPRz0ke09VVH0ta2VybmVs
LXJhdy5sb2cKQVJDSElWRT0ke09VVH0udGFyLmd6ClRSQUNFX0lOU1RBTkNFPWQzY29sZF9hbGxv
d2VkXyR7VkFMfV8kJApUPSR7VFJBQ0VfUk9PVH0vaW5zdGFuY2VzLyR7VFJBQ0VfSU5TVEFOQ0V9
ClBPTExfUElEPQoKbWtkaXIgLXAgIiRPVVQiCgpjbGVhbnVwKCkgewogICAgc2V0ICtlCgogICAg
aWYgW1sgLW4gIiR7UE9MTF9QSUQ6LX0iIF1dOyB0aGVuCiAgICAgICAga2lsbCAiJFBPTExfUElE
IiAyPi9kZXYvbnVsbAogICAgICAgIHdhaXQgIiRQT0xMX1BJRCIgMj4vZGV2L251bGwKICAgICAg
ICBQT0xMX1BJRD0KICAgIGZpCgogICAgaWYgW1sgLWQgIiR7VDotfSIgXV07IHRoZW4KICAgICAg
ICAjIFRlYXIgdGhlIGV4dHJhIHYyIGluc3RydW1lbnRhdGlvbiBkb3duIGJlZm9yZSByZW1vdmlu
ZyB0aGUgaW5zdGFuY2UuCiAgICAgICAgaWYgW1sgLXcgIiRUL2V2ZW50cy9ycG0vcnBtX3Jlc3Vt
ZS90cmlnZ2VyIiAmJiAtbiAiJHtSUE1fU1RBQ0tfRklMVEVSOi19IiBdXTsgdGhlbgogICAgICAg
ICAgICBlY2hvICIhc3RhY2t0cmFjZSBpZiAkUlBNX1NUQUNLX0ZJTFRFUiIgPiAiJFQvZXZlbnRz
L3JwbS9ycG1fcmVzdW1lL3RyaWdnZXIiIDI+L2Rldi9udWxsCiAgICAgICAgZmkKICAgICAgICBb
WyAtdyAiJFQvY3VycmVudF90cmFjZXIiIF1dICYmIGVjaG8gbm9wID4gIiRUL2N1cnJlbnRfdHJh
Y2VyIiAyPi9kZXYvbnVsbAogICAgICAgIFtbIC13ICIkVC9zZXRfZnRyYWNlX2ZpbHRlciIgXV0g
JiYgZWNobyA+ICIkVC9zZXRfZnRyYWNlX2ZpbHRlciIgMj4vZGV2L251bGwKICAgICAgICBbWyAt
ZSAiJFQvZXZlbnRzL3JwbS9lbmFibGUiIF1dICYmIGVjaG8gMCA+ICIkVC9ldmVudHMvcnBtL2Vu
YWJsZSIgMj4vZGV2L251bGwKICAgICAgICBbWyAtZCAiJFQvZXZlbnRzL3BjaSIgXV0gJiYgZWNo
byAwID4gIiRUL2V2ZW50cy9wY2kvZW5hYmxlIiAyPi9kZXYvbnVsbAogICAgICAgIFtbIC1kICIk
VC9ldmVudHMvdWNzaSIgXV0gJiYgZWNobyAwID4gIiRUL2V2ZW50cy91Y3NpL2VuYWJsZSIgMj4v
ZGV2L251bGwKICAgICAgICBybWRpciAiJFQiIDI+L2Rldi9udWxsIHx8IHRydWUKICAgIGZpCn0K
dHJhcCBjbGVhbnVwIEVYSVQKdHJhcCAnZWNobzsgZWNobyAiSW50ZXJydXB0ZWQuIjsgZXhpdCAx
MzAnIElOVCBURVJNCgplcnIoKSB7CiAgICBlY2hvICJFUlJPUjogJCoiID4mMgogICAgZXhpdCAx
Cn0KCm5lZWRfcmVhZGFibGUoKSB7CiAgICBbWyAtciAiJDEiIF1dIHx8IGVyciAiY2Fubm90IHJl
YWQgJDEiCn0KCiMgVGhlc2Ugc3RhdGUgcmVhZHMgZG8gbm90IHRvdWNoIFBDSSBjb25maWd1cmF0
aW9uIHNwYWNlLgpkZXZfc3RhdGUoKSB7CiAgICBsb2NhbCBkZXY9JDEKICAgIGlmIFtbICEgLWQg
IiRELyRkZXYiIF1dOyB0aGVuCiAgICAgICAgcHJpbnRmICdhYnNlbnQvdW5rbm93bicKICAgICAg
ICByZXR1cm4KICAgIGZpCgogICAgbG9jYWwgcnMgcHMKICAgIHJzPSQoY2F0ICIkRC8kZGV2L3Bv
d2VyL3J1bnRpbWVfc3RhdHVzIiAyPi9kZXYvbnVsbCB8fCBwcmludGYgJ3Vua25vd24nKQogICAg
cHM9JChjYXQgIiRELyRkZXYvcG93ZXJfc3RhdGUiIDI+L2Rldi9udWxsIHx8IHByaW50ZiAndW5r
bm93bicpCiAgICBwcmludGYgJyVzLyVzJyAiJHJzIiAiJHBzIgp9Cgpjb3VudGVyKCkgewogICAg
bG9jYWwgbmFtZT0kMQogICAgaWYgW1sgLXIgIiRJLyRuYW1lIiBdXTsgdGhlbgogICAgICAgIGF3
ayAne3ByaW50ICQxfScgIiRJLyRuYW1lIgogICAgZWxzZQogICAgICAgIHByaW50ZiAnTkEnCiAg
ICBmaQp9CgojIFN1bSBwZXItQ1BVIGNvdW50cyBmb3IgdGhlIC9wcm9jL2ludGVycnVwdHMgbGlu
ZSBhc3NvY2lhdGVkIHdpdGggYSBCREYuCiMgUmV0dXJucyBOQSBpZiBubyBtYXRjaGluZyBJUlEg
bGluZSBpcyBwcmVzZW50LgppcnFfdG90YWwoKSB7CiAgICBsb2NhbCBiZGY9JDEgbGluZQogICAg
bGluZT0kKGdyZXAgLW0xIC1GICIkYmRmIiAvcHJvYy9pbnRlcnJ1cHRzIDI+L2Rldi9udWxsIHx8
IHRydWUpCiAgICBpZiBbWyAteiAiJGxpbmUiIF1dOyB0aGVuCiAgICAgICAgcHJpbnRmICdOQScK
ICAgICAgICByZXR1cm4KICAgIGZpCgogICAgYXdrICd7CiAgICAgICAgc3VtPTAKICAgICAgICBm
b3IgKGk9MjsgaTw9TkY7IGkrKykgewogICAgICAgICAgICBpZiAoJGkgfiAvXlswLTldKyQvKSBz
dW0gKz0gJGkKICAgICAgICAgICAgZWxzZSBicmVhawogICAgICAgIH0KICAgICAgICBwcmludCBz
dW0KICAgIH0nIDw8PCAiJGxpbmUiCn0KCnNhbXBsZV9saW5lKCkgewogICAgcHJpbnRmICclcyBn
cGUxMD0lcyBncGUxQT0lcyBncGVfYWxsPSVzIHNjaT0lcyBzY2lfbm90PSVzIElSUV9SUD0lcyBJ
UlFfTkhJX0JSSURHRT0lcyBSUD0lcyBOSEk9JXMgWEhDSTA9JXMgWEhDSTE9JXMgRVA9JXNcbicg
XAogICAgICAgICIkKGRhdGUgKyVULiUzTikiIFwKICAgICAgICAiJChjb3VudGVyIGdwZTEwKSIg
XAogICAgICAgICIkKGNvdW50ZXIgZ3BlMUEpIiBcCiAgICAgICAgIiQoY291bnRlciBncGVfYWxs
KSIgXAogICAgICAgICIkKGNvdW50ZXIgc2NpKSIgXAogICAgICAgICIkKGNvdW50ZXIgc2NpX25v
dCkiIFwKICAgICAgICAiJChpcnFfdG90YWwgJzAwMDA6MDA6MDQuMScpIiBcCiAgICAgICAgIiQo
aXJxX3RvdGFsICcwMDAwOjAwOjA4LjMnKSIgXAogICAgICAgICIkKGRldl9zdGF0ZSAiJFJQIiki
IFwKICAgICAgICAiJChkZXZfc3RhdGUgIiROSEkiKSIgXAogICAgICAgICIkKGRldl9zdGF0ZSAi
JFhIQ0kwIikiIFwKICAgICAgICAiJChkZXZfc3RhdGUgIiRYSENJMSIpIiBcCiAgICAgICAgIiQo
W1sgLWUgIiRELyRFUCIgXV0gJiYgZWNobyBwcmVzZW50IHx8IGVjaG8gbWlzc2luZykiCn0KCnNu
YXBzaG90KCkgewogICAgbG9jYWwgbGFiZWw9JDEKCiAgICB7CiAgICAgICAgZWNobyAiPT09ICRs
YWJlbCA9PT0iCiAgICAgICAgZGF0ZSAtLWlzby04NjAxPW5zCiAgICAgICAgZWNobwogICAgICAg
IGVjaG8gImQzY29sZF9hbGxvd2VkPSQoY2F0ICIkRC8kUlAvZDNjb2xkX2FsbG93ZWQiKSIKICAg
ICAgICBlY2hvICJSUD0kKGRldl9zdGF0ZSAiJFJQIikiCiAgICAgICAgZWNobyAiTkhJPSQoZGV2
X3N0YXRlICIkTkhJIikiCiAgICAgICAgZWNobyAiWEhDSTA9JChkZXZfc3RhdGUgIiRYSENJMCIp
IgogICAgICAgIGVjaG8gIlhIQ0kxPSQoZGV2X3N0YXRlICIkWEhDSTEiKSIKICAgICAgICBlY2hv
ICJFUD0kKFtbIC1lICIkRC8kRVAiIF1dICYmIGVjaG8gcHJlc2VudCB8fCBlY2hvIG1pc3Npbmcp
IgogICAgICAgIGVjaG8KICAgICAgICBmb3IgYyBpbiBncGUxMCBncGUxQSBncGVfYWxsIHNjaSBz
Y2lfbm90OyBkbwogICAgICAgICAgICBwcmludGYgJyUtOHMgJyAiJGM6IgogICAgICAgICAgICBp
ZiBbWyAtciAiJEkvJGMiIF1dOyB0aGVuIGNhdCAiJEkvJGMiOyBlbHNlIGVjaG8gTkE7IGZpCiAg
ICAgICAgZG9uZQogICAgICAgIGVjaG8KICAgICAgICBlY2hvICJJUlFfUlBfdG90YWw9JChpcnFf
dG90YWwgJzAwMDA6MDA6MDQuMScpIgogICAgICAgIGVjaG8gIklSUV9OSElfYnJpZGdlX3RvdGFs
PSQoaXJxX3RvdGFsICcwMDAwOjAwOjA4LjMnKSIKICAgIH0gPiAiJE9VVC8ke2xhYmVsfS50eHQi
CgogICAgY3AgL3Byb2MvaW50ZXJydXB0cyAiJE9VVC8ke2xhYmVsfS1wcm9jLWludGVycnVwdHMu
dHh0IgogICAgZ3JlcCAtSCAuICIkSSIvKiAyPi9kZXYvbnVsbCBcCiAgICAgICAgfCBhd2sgLUY6
ICckMiswID4gMCB8fCAvZ3BlMUF8Z3BlMTB8Z3BlX2FsbHxzY2lfbm90fFwvc2NpOi8nIFwKICAg
ICAgICA+ICIkT1VULyR7bGFiZWx9LWFjcGktY291bnRlcnMudHh0IiB8fCB0cnVlCn0KCm1hcmso
KSB7CiAgICBsb2NhbCBtc2c9JCoKICAgIGlmIFtbIC13ICIkVC90cmFjZV9tYXJrZXIiIF1dOyB0
aGVuCiAgICAgICAgcHJpbnRmICclc1xuJyAiJG1zZyIgPiAiJFQvdHJhY2VfbWFya2VyIiAyPi9k
ZXYvbnVsbCB8fCB0cnVlCiAgICBmaQogICAgcHJpbnRmICdkM2NvbGQtYWxsb3dlZC10ZXN0OiAl
c1xuJyAiJG1zZyIgPiAvZGV2L2ttc2cgMj4vZGV2L251bGwgfHwgdHJ1ZQp9CgojIC0tLSBQcmVj
b25kaXRpb25zIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKW1sgLWQgIiRELyRSUCIgXV0gfHwgZXJyICIkUlAgZG9lcyBub3QgZXhpc3Qi
CltbIC1kICIkRC8kTkhJIiBdXSB8fCBlcnIgIiROSEkgZG9lcyBub3QgZXhpc3QiCltbIC1lICIk
RC8kUlAvZDNjb2xkX2FsbG93ZWQiIF1dIHx8IGVyciAiJFJQIGhhcyBubyBkM2NvbGRfYWxsb3dl
ZCBhdHRyaWJ1dGUiCm5lZWRfcmVhZGFibGUgIiRELyRSUC9wb3dlci9jb250cm9sIgpuZWVkX3Jl
YWRhYmxlICIkRC8kUlAvcG93ZXIvcnVudGltZV9zdGF0dXMiCm5lZWRfcmVhZGFibGUgIiRELyRS
UC9wb3dlcl9zdGF0ZSIKbmVlZF9yZWFkYWJsZSAiJEQvJE5ISS9wb3dlci9ydW50aW1lX3N0YXR1
cyIKbmVlZF9yZWFkYWJsZSAiJEQvJE5ISS9wb3dlcl9zdGF0ZSIKCltbICQoY2F0ICIkRC8kUlAv
cG93ZXIvY29udHJvbCIpID09IGF1dG8gXV0gXAogICAgfHwgZXJyICIkUlAgcG93ZXIvY29udHJv
bCBpcyBub3QgYXV0bzsgZGlzYWJsZSB0aGUgdWRldiB3b3JrYXJvdW5kIGFuZCBjb2xkIGJvb3Qg
YWdhaW4iCgpbWyAhIC1lICIkRC8kRVAiIF1dIFwKICAgIHx8IGVyciAiJEVQIGlzIGFscmVhZHkg
cHJlc2VudDsgY29sZCBib290IGFnYWluIHdpdGggdGhlIGRvY2sgcGh5c2ljYWxseSB1bnBsdWdn
ZWQiCgpmb3IgeCBpbiAiJFhIQ0kwIiAiJFhIQ0kxIjsgZG8KICAgIFtbIC1kICIkRC8keCIgXV0g
XAogICAgICAgIHx8IGVjaG8gIldBUk5JTkc6IGhvc3QgeEhDSSAkeCBub3QgcHJlc2VudDsgaXRz
IHJwbV9yZXN1bWUgbGluZXMgd2lsbCBiZSBhYnNlbnQuIgpkb25lCgppZiBbWyAtZSAiJFJVTEUi
IF1dOyB0aGVuCiAgICBlcnIgIiRSVUxFIHN0aWxsIGV4aXN0czsgcmVuYW1lIGl0IHRvIC5kaXNh
YmxlZCBhbmQgY29sZCBib290IGJlZm9yZSB0ZXN0aW5nIgpmaQoKaWYgW1sgISAtZSAiJFJVTEVf
RElTQUJMRUQiIF1dOyB0aGVuCiAgICBlY2hvICJXQVJOSU5HOiAkUlVMRV9ESVNBQkxFRCB3YXMg
bm90IGZvdW5kLiIKICAgIGVjaG8gIiAgICAgICAgIENvbnRpbnVpbmcgYmVjYXVzZSBwb3dlci9j
b250cm9sIGlzIGFscmVhZHkgJ2F1dG8nLiIKZmkKCmZvciBjIGluIGdwZTEwIGdwZTFBIGdwZV9h
bGwgc2NpIHNjaV9ub3Q7IGRvCiAgICBbWyAtciAiJEkvJGMiIF1dIHx8IGVjaG8gIldBUk5JTkc6
IEFDUEkgY291bnRlciAkSS8kYyBpcyB1bmF2YWlsYWJsZTsgaXQgd2lsbCBiZSBsb2dnZWQgYXMg
TkEuIgpkb25lCgpbWyAtZCAiJFRSQUNFX1JPT1QvZXZlbnRzIiBdXSBcCiAgICB8fCBlcnIgInRy
YWNlZnMgaXMgbm90IGF2YWlsYWJsZSBhdCAkVFJBQ0VfUk9PVDsgYWJvcnRpbmcgcmF0aGVyIHRo
YW4gbW91bnRpbmcvY2hhbmdpbmcgaXQiCgojIFVzZSBhIHByaXZhdGUgdHJhY2VmcyBpbnN0YW5j
ZSBzbyB0aGUgc3lzdGVtLXdpZGUgdHJhY2luZyBjb25maWd1cmF0aW9uIGlzCiMgbm90IG1vZGlm
aWVkIGJ5IHRoaXMgc2NyaXB0Lgpta2RpciAiJFQiIHx8IGVyciAiY291bGQgbm90IGNyZWF0ZSB0
cmFjZWZzIGluc3RhbmNlICRUIgplY2hvIDQwOTYgPiAiJFQvYnVmZmVyX3NpemVfa2IiIDI+L2Rl
di9udWxsIHx8IHRydWUKCmVjaG8gIm5hbWUgPT0gXCIkUlBcIiB8fCBuYW1lID09IFwiJE5ISVwi
IHx8IG5hbWUgPT0gXCIkWEhDSTBcIiB8fCBuYW1lID09IFwiJFhIQ0kxXCIiID4gIiRUL2V2ZW50
cy9ycG0vZmlsdGVyIiBcCiAgICB8fCBlcnIgImZhaWxlZCB0byBpbnN0YWxsIHJ1bnRpbWUtUE0g
dHJhY2UgZmlsdGVyIgplY2hvIDEgPiAiJFQvZXZlbnRzL3JwbS9lbmFibGUiIFwKICAgIHx8IGVy
ciAiZmFpbGVkIHRvIGVuYWJsZSBydW50aW1lLVBNIHRyYWNlcG9pbnRzIgoKaWYgW1sgLWQgIiRU
L2V2ZW50cy9wY2kiIF1dOyB0aGVuCiAgICBlY2hvIDEgPiAiJFQvZXZlbnRzL3BjaS9lbmFibGUi
IDI+L2Rldi9udWxsIHx8IHRydWUKZmkKCiMgLS0tIHYyOiBjYXB0dXJlIFdITyByZXN1bWVzIHRo
ZSByb290IHBvcnQgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIyBUaGUgQS9CIGNh
cHR1cmVzIHNob3dlZCB0aGUgZGlmZmVyZW5jZSBpcyBhIHNpbmdsZSBtaXNzaW5nIGV2ZW50OiBp
biB0aGUKIyBEM2NvbGQgKEZBSUwpIGFybSB0aGUgcm9vdCBwb3J0IGlzIG5ldmVyIHJ1bnRpbWUt
cmVzdW1lZCwgc28gcGNpZWhwIG5ldmVyCiMgc2FtcGxlcyB0aGUgc2xvdC4gVGhlc2UgdHdvIHBy
b2JlcyBuYW1lIHRoZSByZXN1bWUgcGF0aC4KIwojICgxKSBycG1fcmVzdW1lIHN0YWNrdHJhY2Ug
dHJpZ2dlciBmb3IgdGhlIHJvb3QgcG9ydC4gTm90ZSBycG1fcmVzdW1lIG9mdGVuCiMgICAgIHJ1
bnMgZnJvbSBhIGt3b3JrZXIgKHBtX3J1bnRpbWUgYXN5bmMgd29yayksIHNvIHRoaXMgc3RhY2sg
bWF5IG9ubHkgc2hvdwojICAgICB0aGUgd29ya2VyIHJhdGhlciB0aGFuIHRoZSBvcmlnaW5hbCBy
ZXF1ZXN0ZXIgLS0gcHJvYmUgKDIpIGRpc2FtYmlndWF0ZXMuCiMgZnRyYWNlIHBlcm1pdHMgb25s
eSBPTkUgc3RhY2t0cmFjZSB0cmlnZ2VyIHBlciBldmVudCAodGhlIHRyaWdnZXIgZnJhbWV3b3Jr
CiMgZGVkdXBzIGJ5IHR5cGUgYW5kIHJlamVjdHMgYSBzZWNvbmQgd2l0aCAtRUVYSVNUIHJlZ2Fy
ZGxlc3Mgb2YgaXRzIGZpbHRlciksIHNvCiMgdXNlIGEgc2luZ2xlIHRyaWdnZXIgd2hvc2UgT1Ig
ZmlsdGVyIGNvdmVycyB0aGUgcm9vdCBwb3J0IEFORCBib3RoIGhvc3QgeEhDSXMuCiMgdjMgYWRk
cyB0aGUgeEhDSXM6IGlmIGVpdGhlciByZXN1bWVzIHJpZ2h0IGFmdGVyIHRoZSBwbHVnIChhbmQg
YmVmb3JlIEdQMTIvTkhJKSwKIyBpdHMgc3RhY2sgbmFtZXMgd2hvIHdva2UgaXQgLS0gdGhlIFVT
QjIvUEQgaGFuZHNoYWtlIHBhdGggLS0gd2hpY2ggd291bGQgYmUgYQojIEQzY29sZC1pbmRlcGVu
ZGVudCB3YWtlIHdlIGNvdWxkIGtleSBvZmYuClJQTV9TVEFDS19GSUxURVI9Im5hbWUgPT0gXCIk
UlBcIiB8fCBuYW1lID09IFwiJFhIQ0kwXCIgfHwgbmFtZSA9PSBcIiRYSENJMVwiIgppZiBbWyAt
dyAiJFQvZXZlbnRzL3JwbS9ycG1fcmVzdW1lL3RyaWdnZXIiIF1dOyB0aGVuCiAgICBlY2hvICJz
dGFja3RyYWNlIGlmICRSUE1fU1RBQ0tfRklMVEVSIiA+ICIkVC9ldmVudHMvcnBtL3JwbV9yZXN1
bWUvdHJpZ2dlciIgMj4vZGV2L251bGwgXAogICAgICAgIHx8IGVjaG8gIldBUk5JTkc6IGNvdWxk
IG5vdCBpbnN0YWxsIHJwbV9yZXN1bWUgc3RhY2t0cmFjZSB0cmlnZ2VyIiA+JjIKZmkKCiMgdjM6
IHRoZSBUeXBlLUMvVUNTSSBjb25uZmlnLWNoYW5nZSBwYXRoLiBPbiB0aGlzIHVuaXQgdGhlIFBE
L1VDU0kgY29udHJvbGxlciBpcwojIHRoZSBBQ1BJIHBsYXRmb3JtIGRldmljZSBVQlRDIChfSElE
IFVTQkMwMDAgLyBQTlAwQ0EwKSAtLSBOT1QgYSBQQ0kgZnVuY3Rpb24sIHNvCiMgaXQgbmV2ZXIg
YXBwZWFycyBpbiBycG1fKiB0cmFjZXBvaW50cy4gSWYgdGhlIGtlcm5lbCBleHBvc2VzIHVjc2kg
dHJhY2Vwb2ludHMsCiMgZW5hYmxlIHRoZW0gc28gYSBjb25uZWN0b3ItY2hhbmdlICh0aGUgUEQg
YXR0YWNoIGhhbGYgb2YgdGhlIGhhbmRzaGFrZSkgaXMKIyB0aW1lc3RhbXBlZCBpbiB0aGUgc2Ft
ZSBidWZmZXI7IG90aGVyd2lzZSBpdCBvbmx5IHNob3dzIHVwIGluIGtlcm5lbC5sb2cuCmlmIFtb
IC1kICIkVC9ldmVudHMvdWNzaSIgXV07IHRoZW4KICAgIGVjaG8gMSA+ICIkVC9ldmVudHMvdWNz
aS9lbmFibGUiIDI+L2Rldi9udWxsIFwKICAgICAgICB8fCBlY2hvICJXQVJOSU5HOiBjb3VsZCBu
b3QgZW5hYmxlIHVjc2kgdHJhY2Vwb2ludHMiID4mMgpmaQoKIyAoMikgRnVuY3Rpb24tdHJhY2Ug
dGhlIEFDUEkgUE1FLW5vdGlmeSBoYW5kbGVyIHBjaV9hY3BpX3dha2VfZGV2KCkuIElmIGl0CiMg
ICAgIGZpcmVzIGFmdGVyIHRoZSBwbHVnLCBmaXJtd2FyZSBkZWxpdmVyZWQgYW4gQUNQSSBOb3Rp
ZnkgKHdha2UgYXR0ZW1wdCk7CiMgICAgIGlmIGl0IG5ldmVyIGZpcmVzLCBmaXJtd2FyZSBuZXZl
ciBhc2tlZCB0aGUgT1MgdG8gd2FrZSB0aGUgcG9ydC4gVGhlCiMgICAgIGZpbHRlciByZXN0cmlj
dHMgZnVuY3Rpb24gdHJhY2luZyB0byB0aGlzIG9uZSBzeW1ib2wsIHNvIHRoZSBidWZmZXIgaXMK
IyAgICAgbm90IGZsb29kZWQuIFRoZSBmdW5jdGlvbiB0cmFjZXIgY2Fubm90IHNob3cgd2hpY2gg
cGNpX2RldiB3YXMgcGFzc2VkOwojICAgICBjb3JyZWxhdGUgaXRzIHRpbWVzdGFtcCB3aXRoIHRo
ZSBkZXZpY2UtZmlsdGVyZWQgcnBtX3Jlc3VtZSBsaW5lcy4KaWYgW1sgLXcgIiRUL3NldF9mdHJh
Y2VfZmlsdGVyIiAmJiAtdyAiJFQvY3VycmVudF90cmFjZXIiIF1dOyB0aGVuCiAgICBpZiBlY2hv
IHBjaV9hY3BpX3dha2VfZGV2ID4gIiRUL3NldF9mdHJhY2VfZmlsdGVyIiAyPi9kZXYvbnVsbDsg
dGhlbgogICAgICAgIGVjaG8gZnVuY3Rpb24gPiAiJFQvY3VycmVudF90cmFjZXIiIDI+L2Rldi9u
dWxsIFwKICAgICAgICAgICAgfHwgZWNobyAiV0FSTklORzogY291bGQgbm90IGVuYWJsZSBmdW5j
dGlvbiB0cmFjZXIiID4mMgogICAgZWxzZQogICAgICAgIGVjaG8gIk5PVEU6IHBjaV9hY3BpX3dh
a2VfZGV2IG5vdCB0cmFjZWFibGUgb24gdGhpcyBrZXJuZWw7IHByb2JlICgyKSBza2lwcGVkLiIg
PiYyCiAgICBmaQpmaQoKU0lOQ0VfRVBPQ0g9JChkYXRlICslcykKCnsKICAgIGVjaG8gImtlcm5l
bDogJCh1bmFtZSAtcikiCiAgICBlY2hvICJ0ZXN0OiBkM2NvbGRfYWxsb3dlZD0kVkFMIgogICAg
ZWNobyAiUlA6ICRSUCIKICAgIGVjaG8gIk5ISTogJE5ISSIKICAgIGVjaG8gIkVQOiAkRVAiCiAg
ICBlY2hvICJwb3dlci9jb250cm9sOiAkKGNhdCAiJEQvJFJQL3Bvd2VyL2NvbnRyb2wiKSIKICAg
IGVjaG8gInBvd2VyL3dha2V1cDogJChjYXQgIiRELyRSUC9wb3dlci93YWtldXAiIDI+L2Rldi9u
dWxsIHx8IGVjaG8gdW5hdmFpbGFibGUpIgogICAgZWNobyAiZDNjb2xkX2FsbG93ZWQgYmVmb3Jl
IHdyaXRlOiAkKGNhdCAiJEQvJFJQL2QzY29sZF9hbGxvd2VkIikiCiAgICBlY2hvICJzdGF0ZSBi
ZWZvcmUgd3JpdGU6IFJQPSQoZGV2X3N0YXRlICIkUlAiKSBOSEk9JChkZXZfc3RhdGUgIiROSEki
KSIKICAgIGVjaG8gIm5vdGU6IHdyaXRpbmcgZDNjb2xkX2FsbG93ZWQgcnVudGltZS1yZXN1bWVz
IHRoZSByb290IHBvcnQ7IHJlYWRpbmVzcyBpcyBjaGVja2VkIG9ubHkgYWZ0ZXIgaXQgc3VzcGVu
ZHMgYWdhaW4iCn0gPiAiJE9VVC9pbmZvLnR4dCIKCmNwIC0tICIkMCIgIiRPVVQvJChiYXNlbmFt
ZSAiJDAiKSIgMj4vZGV2L251bGwgfHwgdHJ1ZQoKIyAtLS0gQXBwbHkgQWxleCdzIHRlc3QgY29u
ZGl0aW9uIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKbWFyayAi
V1JJVElORyBkM2NvbGRfYWxsb3dlZD0kVkFMIgplY2hvICIkVkFMIiA+ICIkRC8kUlAvZDNjb2xk
X2FsbG93ZWQiIFwKICAgIHx8IGVyciAid3JpdGUgdG8gJEQvJFJQL2QzY29sZF9hbGxvd2VkIGZh
aWxlZCIKClJFQURCQUNLPSQoY2F0ICIkRC8kUlAvZDNjb2xkX2FsbG93ZWQiKQpbWyAiJFJFQURC
QUNLIiA9PSAiJFZBTCIgXV0gXAogICAgfHwgZXJyICJkM2NvbGRfYWxsb3dlZCByZWFkYmFjayBp
cyAkUkVBREJBQ0ssIGV4cGVjdGVkICRWQUwiCgplY2hvICJkM2NvbGRfYWxsb3dlZCBhZnRlciB3
cml0ZTogJFJFQURCQUNLIiA+PiAiJE9VVC9pbmZvLnR4dCIKCmVjaG8KaWYgW1sgIiRWQUwiID09
IDEgXV07IHRoZW4KICAgIGVjaG8gIldhaXRpbmcgZm9yIHN0cmljdCBGQUlMIHByZWNvbmRpdGlv
bjoiCiAgICBlY2hvICIgIFJQICA9IHN1c3BlbmRlZC9EM2NvbGQiCiAgICBlY2hvICIgIE5ISSA9
IHN1c3BlbmRlZC9EM2NvbGQiCmVsc2UKICAgIGVjaG8gIldhaXRpbmcgZm9yIFBBU1MgcHJlY29u
ZGl0aW9uOiIKICAgIGVjaG8gIiAgUlAgID0gc3VzcGVuZGVkIGFuZCBOT1QgRDNjb2xkIChub3Jt
YWxseSBEM2hvdCkiCiAgICBlY2hvICIgIE5ISSA9IHN1c3BlbmRlZC9EM2NvbGQiCmZpCmVjaG8g
IlRpbWVvdXQ6ICR7UkVBRFlfVElNRU9VVH1zIgoKUkVBRFk9MApSRUFEWV9SUF9TVEFURT0KZm9y
ICgoc2VjPTE7IHNlYzw9UkVBRFlfVElNRU9VVDsgc2VjKyspKTsgZG8KICAgIFJQX1JTPSQoY2F0
ICIkRC8kUlAvcG93ZXIvcnVudGltZV9zdGF0dXMiKQogICAgUlBfUFM9JChjYXQgIiRELyRSUC9w
b3dlcl9zdGF0ZSIpCiAgICBOSElfUlM9JChjYXQgIiRELyROSEkvcG93ZXIvcnVudGltZV9zdGF0
dXMiKQogICAgTkhJX1BTPSQoY2F0ICIkRC8kTkhJL3Bvd2VyX3N0YXRlIikKCiAgICBpZiBbWyAi
JFZBTCIgPT0gMSBdXTsgdGhlbgogICAgICAgIGlmIFtbICIkUlBfUlMiID09IHN1c3BlbmRlZCAm
JiAiJFJQX1BTIiA9PSBEM2NvbGQgXAogICAgICAgICAgICYmICIkTkhJX1JTIiA9PSBzdXNwZW5k
ZWQgJiYgIiROSElfUFMiID09IEQzY29sZCBdXTsgdGhlbgogICAgICAgICAgICBSRUFEWT0xCiAg
ICAgICAgICAgIFJFQURZX1JQX1NUQVRFPSRSUF9QUwogICAgICAgICAgICBicmVhawogICAgICAg
IGZpCiAgICBlbHNlCiAgICAgICAgIyBkM2NvbGRfYWxsb3dlZD0wIGxpbWl0cyB0aGUgZGVlcGVz
dCBhbGxvd2VkIHN0YXRlIHRvIEQzaG90LCBidXQgQUNQSQogICAgICAgICMgbWF5IGNob29zZSBh
IHNoYWxsb3dlciBzdGF0ZS4gIEFjY2VwdCBhbnkgc3RhYmxlIHN1c3BlbmRlZCBzdGF0ZSB0aGF0
CiAgICAgICAgIyBpcyBub3QgRDNjb2xkOyByZWNvcmQgZXhhY3RseSB3aGljaCBvbmUgd2FzIHNl
bGVjdGVkLgogICAgICAgIGlmIFtbICIkUlBfUlMiID09IHN1c3BlbmRlZCAmJiAiJFJQX1BTIiAh
PSBEM2NvbGQgXAogICAgICAgICAgICYmICIkUlBfUFMiICE9IHVua25vd24gJiYgIiRSUF9QUyIg
IT0gZXJyb3IgXAogICAgICAgICAgICYmICIkTkhJX1JTIiA9PSBzdXNwZW5kZWQgJiYgIiROSElf
UFMiID09IEQzY29sZCBdXTsgdGhlbgogICAgICAgICAgICBSRUFEWT0xCiAgICAgICAgICAgIFJF
QURZX1JQX1NUQVRFPSRSUF9QUwogICAgICAgICAgICBicmVhawogICAgICAgIGZpCiAgICBmaQoK
ICAgIGlmICgoIHNlYyAlIDEwID09IDAgKSk7IHRoZW4KICAgICAgICBwcmludGYgJyAgJTNkczog
UlA9JXMgTkhJPSVzXG4nICIkc2VjIiAiJChkZXZfc3RhdGUgIiRSUCIpIiAiJChkZXZfc3RhdGUg
IiROSEkiKSIKICAgIGZpCiAgICBzbGVlcCAxCmRvbmUKCmlmIFtbICIkUkVBRFkiICE9IDEgXV07
IHRoZW4KICAgIHsKICAgICAgICBlY2hvICJyZWFkeTogbm8iCiAgICAgICAgZWNobyAiZmluYWwg
d2FpdGluZyBzdGF0ZTogUlA9JChkZXZfc3RhdGUgIiRSUCIpIE5IST0kKGRldl9zdGF0ZSAiJE5I
SSIpIgogICAgfSA+PiAiJE9VVC9pbmZvLnR4dCIKICAgIGVyciAicHJlY29uZGl0aW9uIG5vdCBy
ZWFjaGVkIGFmdGVyICR7UkVBRFlfVElNRU9VVH1zOiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJ
PSQoZGV2X3N0YXRlICIkTkhJIikiCmZpCgppZiBbWyAiJFZBTCIgPT0gMCAmJiAiJFJFQURZX1JQ
X1NUQVRFIiAhPSBEM2hvdCBdXTsgdGhlbgogICAgZWNobyAiTk9URTogd2l0aCBEM2NvbGQgYmxv
Y2tlZCwgUlAgc3VzcGVuZGVkIHRvICRSRUFEWV9SUF9TVEFURSByYXRoZXIgdGhhbiBEM2hvdC4i
CiAgICBlY2hvICIgICAgICBUaGlzIHN0aWxsIHRlc3RzIEFsZXgncyBkM2NvbGRfYWxsb3dlZD0w
IGNvbmRpdGlvbjsgdGhlIGV4YWN0IHN0YXRlIGlzIHJlY29yZGVkLiIKZmkKClJFQURZX0xJTkU9
InJlYWR5OiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJPSQoZGV2X3N0YXRlICIkTkhJIikgZDNj
b2xkX2FsbG93ZWQ9JFJFQURCQUNLIgplY2hvICIkUkVBRFlfTElORSIgfCB0ZWUgLWEgIiRPVVQv
aW5mby50eHQiCm1hcmsgIiRSRUFEWV9MSU5FIgpzbmFwc2hvdCBiZWZvcmUKCiMgLS0tIE9ic2Vy
dmUgbmF0dXJhbCBob3QtcGx1ZyBvbmx5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KCldBVENIPSIkT1VUL3dhdGNoLmxvZyIKOiA+ICIkV0FUQ0giCgpwb2xsX2xvb3Ao
KSB7CiAgICB3aGlsZSA6OyBkbwogICAgICAgIHNhbXBsZV9saW5lID4+ICIkV0FUQ0giCiAgICAg
ICAgc2xlZXAgMC4yCiAgICBkb25lCn0KCnBvbGxfbG9vcCAmClBPTExfUElEPSQhCgojIFJlY29y
ZCBhIHNob3J0IGJhc2VsaW5lIGJlZm9yZSBhc2tpbmcgZm9yIHRoZSBwaHlzaWNhbCBhY3Rpb24u
CnNsZWVwICIkQkFTRUxJTkVfU0VDIgptYXJrICJQTFVHIERPQ0sgTk9XIgplY2hvCmVjaG8gIj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09IgplY2hvICI+Pj4gUExVRyBJTiBUSEUgU0Q1MDAwVDUgTk9XLiBEbyBub3QgcnVuIGxzcGNp
LiA8PDwiCmVjaG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09IgplY2hvICJTYW1wbGluZyB3aWxsIGNvbnRpbnVlIGZvciAke1BP
U1RfUExVR19TRUN9cy4gTm8gRW50ZXIgcHJlc3MgaXMgbmVlZGVkLiIKZWNobwoKc2xlZXAgIiRQ
T1NUX1BMVUdfU0VDIgoKa2lsbCAiJFBPTExfUElEIiAyPi9kZXYvbnVsbCB8fCB0cnVlCndhaXQg
IiRQT0xMX1BJRCIgMj4vZGV2L251bGwgfHwgdHJ1ZQpQT0xMX1BJRD0KCnNuYXBzaG90IGFmdGVy
CgppZiBbWyAtZSAiJEQvJEVQIiBdXTsgdGhlbgogICAgUkVTVUxUPSJQQVNTOiAkRVAgZW51bWVy
YXRlZCBuYXR1cmFsbHkgd2l0aCBkM2NvbGRfYWxsb3dlZD0kVkFMIgplbHNlCiAgICBSRVNVTFQ9
IkZBSUw6ICRFUCBkaWQgbm90IGVudW1lcmF0ZSB3aXRoIGQzY29sZF9hbGxvd2VkPSRWQUwiCmZp
CgptYXJrICJSRVNVTFQ6ICRSRVNVTFQiCmVjaG8gInJlc3VsdDogJFJFU1VMVCIgPj4gIiRPVVQv
aW5mby50eHQiCmVjaG8gImZpbmFsIHN0YXRlOiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJPSQo
ZGV2X3N0YXRlICIkTkhJIikiID4+ICIkT1VUL2luZm8udHh0IgplY2hvICJmaW5hbCBjb3VudGVy
czogZ3BlMTA9JChjb3VudGVyIGdwZTEwKSBncGUxQT0kKGNvdW50ZXIgZ3BlMUEpIGdwZV9hbGw9
JChjb3VudGVyIGdwZV9hbGwpIHNjaT0kKGNvdW50ZXIgc2NpKSBzY2lfbm90PSQoY291bnRlciBz
Y2lfbm90KSIgPj4gIiRPVVQvaW5mby50eHQiCmVjaG8gImZpbmFsIElSUSB0b3RhbHM6IFJQPSQo
aXJxX3RvdGFsICcwMDAwOjAwOjA0LjEnKSBOSElfYnJpZGdlPSQoaXJxX3RvdGFsICcwMDAwOjAw
OjA4LjMnKSIgPj4gIiRPVVQvaW5mby50eHQiCgojIENhcHR1cmUgdGhlIGlzb2xhdGVkIHRyYWNl
IGJlZm9yZSByZW1vdmluZyB0aGUgdHJhY2UgaW5zdGFuY2UuCmNhdCAiJFQvdHJhY2UiID4gIiRP
VVQvdHJhY2UudHh0IiAyPi9kZXYvbnVsbCB8fCB0cnVlCgojIFN0b3AvcmVtb3ZlIHRoZSBwcml2
YXRlIHRyYWNlIGluc3RhbmNlIG5vdzsgbm8gZ2xvYmFsIGZ0cmFjZSBzZXR0aW5ncyB3ZXJlIGNo
YW5nZWQuCmNsZWFudXAKdHJhcCAtIEVYSVQgSU5UIFRFUk0KCiMgLS0tIEtlcm5lbCBsb2cgYW5k
IHByaXZhY3kgZmlsdGVyaW5nIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
CmpvdXJuYWxjdGwgLWsgLS1zaW5jZSAiQCR7U0lOQ0VfRVBPQ0h9IiAtbyBzaG9ydC1tb25vdG9u
aWMgPiAiJFJBV19MT0ciCgojIFRoZSByYXcgbG9nIGludGVudGlvbmFsbHkgcmVtYWlucyBPVVRT
SURFIHRoZSBhcmNoaXZlLgojIFJlZGFjdCBjb21tb24gaWRlbnRpZnlpbmcgZmllbGRzIGZyb20g
dGhlIGNvcHkgdGhhdCBnb2VzIGludG8gdGhlIGFyY2hpdmUuCkhPU1Q9JCh1bmFtZSAtbikKc2Vk
IC1FIFwKICAgIC1lICJzLyAke0hPU1R9IC8gSE9TVCAvZyIgXAogICAgLWUgJ3MvKFNlcmlhbE51
bWJlcjpbWzpzcGFjZTpdXSopW15bOnNwYWNlOl1dKy9cMVJFREFDVEVEL2cnIFwKICAgIC1lICdz
LyhzZXJpYWwoW1s6c3BhY2U6XV8tXSpudW1iZXIpP1tbOnNwYWNlOl1dKls6PV1bWzpzcGFjZTpd
XSopW15bOnNwYWNlOl1dKy9cMVJFREFDVEVEL0lnJyBcCiAgICAtZSAncy8odWlkOltbOnNwYWNl
Ol1dKikweFswLTlhLWZBLUZdKy9cMVJFREFDVEVELVRIVU5ERVJCT0xULVVJRC9nJyBcCiAgICAt
ZSAncy8oWzAtOWEtZkEtRl17Mn1bOi1dKXs1fVswLTlhLWZBLUZdezJ9L1JFREFDVEVELU1BQy9n
JyBcCiAgICAtZSAncy8oWzAtOWEtZkEtRl17Mn0tKXs3fVswLTlhLWZBLUZdezJ9L1JFREFDVEVE
LURFVklDRS1TRVJJQUwvZycgXAogICAgLWUgJ3MvWzAtOWEtZkEtRl17OH0tWzAtOWEtZkEtRl17
NH0tWzAtOWEtZkEtRl17NH0tWzAtOWEtZkEtRl17NH0tWzAtOWEtZkEtRl17MTJ9L1JFREFDVEVE
LVVVSUQvZycgXAogICAgIiRSQVdfTE9HIiA+ICIkT1VUL2tlcm5lbC5sb2ciCgpjYXQgPiAiJE9V
VC9SRUFETUUudHh0IiA8PEVPRjIKQWxleCBkM2NvbGRfYWxsb3dlZCBBL0IgY2FwdHVyZQoKVGVz
dCB2YWx1ZTogZDNjb2xkX2FsbG93ZWQ9JFZBTApSZXN1bHQ6ICRSRVNVTFQKClRoaXMgYXJjaGl2
ZSBjb250YWlucyBvbmx5IHRoZSByZWRhY3RlZCBrZXJuZWwubG9nLiAgVGhlIHVucmVkYWN0ZWQg
a2VybmVsCmxvZyB3YXMgaW50ZW50aW9uYWxseSBsZWZ0IG91dHNpZGUgdGhlIGFyY2hpdmUgYXQ6
CiAgJFJBV19MT0cKCk5vIGxzcGNpLCBQQ0kgY29uZmlnLXNwYWNlIHJlYWQsIHJlc2Nhbiwgb3Ig
cmVjb3Zlcnkgc3RlcCB3YXMgcGVyZm9ybWVkIGJ5CnRoaXMgc2NyaXB0LiAgVGhlIHdhdGNoIGxv
ZyBzYW1wbGVkIEFDUEkgY291bnRlcnMsIHJ1bnRpbWUtUE0gc3RhdGUsIGVuZHBvaW50CnByZXNl
bmNlLCBhbmQgSVJRIHRvdGFscyBldmVyeSAwLjIgcy4KCnRyYWNlLnR4dCAodjIpIGNhcHR1cmVz
IHRoZSByb290LXBvcnQgcmVzdW1lIHBhdGg6CiAgKiBycG1fcmVzdW1lIGxpbmVzIGZvciAkUlAg
bm93IGNhcnJ5IGEgPHN0YWNrIHRyYWNlPiBibG9jay4gTG9vayBmb3IgdGhlCiAgICBmaXJzdCBy
cG1fcmVzdW1lOiAkUlAgQUZURVIgdGhlICJQTFVHIERPQ0sgTk9XIiBtYXJrZXIuIEl0cyBhYnNl
bmNlIGluIHRoZQogICAgRDNjb2xkIGFybSBpcyB0aGUgZmFpbHVyZTsgaXRzIHN0YWNrIGluIHRo
ZSBwYXNzaW5nIGFybSBuYW1lcyB0aGUgcmVzdW1lcgogICAgKG1heSBiZSBhIGt3b3JrZXIgLS0g
cG1fcnVudGltZSBhc3luYyB3b3JrIC0tIHNlZSBuZXh0IGl0ZW0pLgogICogcGNpX2FjcGlfd2Fr
ZV9kZXYgbGluZXMgbWVhbiB0aGUgQUNQSSBQTUUtbm90aWZ5IGhhbmRsZXIgcmFuIChmaXJtd2Fy
ZQogICAgZGVsaXZlcmVkIGEgd2FrZSkuIElmIHRoZXNlIGFwcGVhciBhZnRlciB0aGUgcGx1Zywg
ZmlybXdhcmUgYXNrZWQgdGhlIE9TIHRvCiAgICB3YWtlIGEgcG9ydDsgaWYgdGhleSBuZXZlciBh
cHBlYXIsIGZpcm13YXJlIG5ldmVyIGRpZC4gQ29ycmVsYXRlIHRoZWlyCiAgICB0aW1lc3RhbXBz
IHdpdGggdGhlIHJwbV9yZXN1bWU6ICRSUCBsaW5lcyB0byB0ZWxsIHdoZXRoZXIgdGhlIHdha2Ug
dGFyZ2V0ZWQKICAgIHRoZSByb290IHBvcnQuIChUaGUgZnVuY3Rpb24gdHJhY2VyIGNhbm5vdCBw
cmludCB0aGUgcGNpX2RldiBhcmd1bWVudC4pCgp0cmFjZS50eHQgKHYzKSBhbHNvIHdhdGNoZXMg
dGhlIFVTQjIvUEQgaGFuZHNoYWtlIC0tIHRoZSBoYWxmIG9mIGEgVHlwZS1DIHBsdWcKdGhhdCBp
cyBOT1QgdHVubmVsZWQgYW5kIHNob3VsZCByZWFjaCB0aGUgaG9zdCBpbW1lZGlhdGVseSwgZXZl
biBmcm9tIEQzY29sZDoKICAqIHJwbV9yZXN1bWUgbGluZXMgbm93IGFsc28gYXBwZWFyIGZvciB0
aGUgaG9zdCB4SENJcyAkWEhDSTAgKFhIQzMpIGFuZAogICAgJFhIQ0kxIChYSEM0KSwgZWFjaCB3
aXRoIGEgPHN0YWNrIHRyYWNlPiBibG9jay4gVGhlIHF1ZXN0aW9uIHRoZXNlIGFuc3dlcjoKICAg
IGRvZXMgdGhlIHBoeXNpY2FsIHBsdWcgd2FrZSBhIGhvc3QgVVNCIGNvbnRyb2xsZXIgYmVmb3Jl
IC0tIG9yIHdpdGhvdXQgLS0KICAgIEdQMTIvJFJQIGNvbWluZyB1cD8gTG9vayBmb3IgdGhlIEZJ
UlNUIHJwbV9yZXN1bWUgZm9yIGVpdGhlciB4SENJIGFmdGVyIHRoZQogICAgIlBMVUcgRE9DSyBO
T1ciIG1hcmtlciBhbmQgY29tcGFyZSBpdHMgdGltZXN0YW1wIHRvIHRoZSAkUlAgYW5kICROSEkg
bGluZXMuCiAgICAgIC0geEhDSSByZXN1bWVzIGVhcmx5IChiZWZvcmUgJFJQKSwgJFJQIHN0aWxs
IG5ldmVyIHJlc3VtZXMgaW4gdGhlIEQzY29sZAogICAgICAgIGFybSAgPT4gdGhlIFVTQjIvUEQg
YXR0YWNoIElTIHNlZW4gYnkgdGhlIGhvc3QgYnV0IGRvZXMgTk9UIHByb3BhZ2F0ZSBhCiAgICAg
ICAgd2FrZSB0byB0aGUgcm9vdCBwb3J0LiBUaGF0IHhIQ0kgcmVzdW1lICsgaXRzIHN0YWNrIGlz
IGEgY2FuZGlkYXRlCiAgICAgICAgRDNjb2xkLWluZGVwZW5kZW50IHRyaWdnZXIgYSBmaXggY291
bGQga2V5IG9mZi4KICAgICAgLSBubyB4SENJIHJlc3VtZSBhdCBhbGwgaW4gdGhlIEQzY29sZCBh
cm0gPT4gZXZlbiB0aGUgbm9uLXR1bm5lbGVkIFVTQjIKICAgICAgICBzaWRlIGlzIGRlYWQgdW50
aWwgc29tZXRoaW5nIGVsc2Ugd2FrZXMgdGhlIGNvbXBsZXguCiAgKiB1Y3NpOiogbGluZXMgKG9u
bHkgaWYgdGhpcyBrZXJuZWwgZXhwb3NlcyB1Y3NpIHRyYWNlcG9pbnRzKSB0aW1lc3RhbXAgdGhl
CiAgICBQRC9VQ1NJIGNvbm5lY3Rvci1jaGFuZ2UgLS0gdGhlIG90aGVyIGhhbGYgb2YgdGhlIGhh
bmRzaGFrZS4gT24gdGhpcyB1bml0CiAgICB0aGUgUEQgY29udHJvbGxlciBpcyB0aGUgQUNQSSBw
bGF0Zm9ybSBkZXZpY2UgVUJUQyAoX0hJRCBVU0JDMDAwL1BOUDBDQTApLAogICAgTk9UIGEgUENJ
IGZ1bmN0aW9uLCBzbyBpdCBuZXZlciBzaG93cyB1cCBpbiBycG1fKiBsaW5lcy4gSWYgdWNzaSB0
cmFjZXBvaW50cwogICAgYXJlIGFic2VudCwgZ3JlcCBrZXJuZWwubG9nIGZvciAndWNzaScvJ3R5
cGVjJy8nQ29ubmVjdG9yJyBpbnN0ZWFkIHRvIHRpbWUKICAgIHRoZSBQRCBhdHRhY2guCkVPRjIK
CnRhciAtQyAvcm9vdCAtY3pmICIkQVJDSElWRSIgIiQoYmFzZW5hbWUgIiRPVVQiKSIKU0hBMjU2
PSQoc2hhMjU2c3VtICIkQVJDSElWRSIgfCBhd2sgJ3twcmludCAkMX0nKQoKcHJpbnRmICdcbiVz
XG4nICIkUkVTVUxUIgpwcmludGYgJ1JQIGZpbmFsOiAgJXNcbicgIiQoZGV2X3N0YXRlICIkUlAi
KSIKcHJpbnRmICdOSEkgZmluYWw6ICVzXG4nICIkKGRldl9zdGF0ZSAiJE5ISSIpIgpwcmludGYg
J1xuQXJjaGl2ZTogJXNcblNIQTI1NjogICVzXG4nICIkQVJDSElWRSIgIiRTSEEyNTYiCnByaW50
ZiAnUmF3IGtlcm5lbCBsb2cgKE5PVCBpbiBhcmNoaXZlKTogJXNcbicgIiRSQVdfTE9HIgpwcmlu
dGYgJ1xuQmVmb3JlIHNlbmRpbmcgdGhlIGFyY2hpdmUgcHVibGljbHksIHJldmlldy9yZWRhY3Rp
b24tc2NhbiBpdCBvbmNlIG1vcmUuXG4nCnByaW50ZiAnXG5Gb3Igbm9ybWFsIHVzZSwgcmVzdG9y
ZSB0aGUgd29ya2Fyb3VuZCBhbmQgcmVib290OlxuJwpwcmludGYgJyAgc3VkbyBtdiAlcyAlc1xu
JyAiJFJVTEVfRElTQUJMRUQiICIkUlVMRSIKcHJpbnRmICcgIHN1ZG8gcmVib290XG4nCg==

--_002_DS7PR12MB9550BB636770CB3984E5DA999C922DS7PR12MB9550namp_--
