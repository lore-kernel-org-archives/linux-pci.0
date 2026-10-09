Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010001.outbound.protection.outlook.com [52.103.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF322DEA6B;
	Fri,  9 Oct 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557702; cv=fail; b=H9cX8kNAjGiFdTFDZkBD33DKjzfgS+12rZYld3vplu6xA3VwCM1Ive34yH9+avm+4HAmg5P8O4KMycF/uaO10fookBK6KCktggLF4V9+mqrJUuJ4hb21un1fSt3uRPcWf/g6HlUs19vWB535SKSBfkHmWvh8/W0E6sF8QOLWltA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557702; c=relaxed/simple;
	bh=nbXo6n9o0KKqE8LII3CSVsgGMZ+OwM1UrJJMR7GzkN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XSyuVotfL8O13346NxNk6hNXTHGpq0MzKgjRS6BPxHfDNrgkN+aGydkuRW8Ttxl/34r+duLX3tJ1tBeZw7bwl+Vq/vt6iwfSD7xnnTdmdcgVyQR1HFrKCFne4A+KtjUZwBvUfePZAqfMybGFgm8M3jImI9UYI6ry+Wyq73VBq94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VRo5PHiO; arc=fail smtp.client-ip=52.103.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VRo5PHiO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdXBrqXc/+N8siCdFQItoSEcgDWeRQ8Fs/SIps/kUn0qh2Pg2A7ltijS6aPnGb5QWa/2EFHC7Q/nJTQR1fs6rcPfDbLiAqr+kHj+eyUfaOcUr3DfFituZZfhIRhEUn9/Sz8JaffDTSOMxeOETg454PhBwEaEUlBrtfo51V6M+WGtLCQm/3QLt0cDRId/14HORujxCsQVEXLEaKut+ztGlGlcbNeN6lJWB7zd7H4Ka+0SrmCqWH4LfjDM9fyepI67BIQ2aF63W352NNL1Y/kQavdK4HdP+9y5iv9X+wjBObfh60EwbSPZ7JevJDZvxsEAQdA8mGzQWBZxHfU9xlXz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XEFjUPpqpFyzYDsIExWj6IJm9GJbSI5ttZVYuz/iMQ=;
 b=cRzU1Wh63/hdD5e0Ka1IQunhYJWCOUseIJOhp6K77KES1HRv7PqVvXXle8GcGLUzNAyEbbc7EQrxsxBrvdGvjcthGR42xuAHQdx6SPipfNm5OWY9zIsNCUOHLemlUog9HANlJgm/ZCV/4YBemPiC/TYPxToI5gEkTQTnzOw1NaGNtfFrOMNdM2Q9+93V5kKG+/DLpEAuwcUtUK546ZcPONu4Px4nIzuAVf6rA9uYYngvfKAElhBijaFK7Gz/hldfBZiKonMcvnalvAGXuSYOTe8lCpN8415/HmWbJUm/rXJ8rfAnDQNlomv8RiKk/YlxAHgfry2WxDe6mB6r5x3r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XEFjUPpqpFyzYDsIExWj6IJm9GJbSI5ttZVYuz/iMQ=;
 b=VRo5PHiOagMihP2vLuPzBn1tSBL/YFe5RgpJBl2TQzbPjejJb7c+1voQSLH1XhWbx2V69bt5bA9rGajynCBp67O3pBxJulNDS6hcsjwAi1LMJP+sfrmCEIwi1U8HcDZ5ONMD+SncXeoy0LV9j/70jsR10tZohw38NZhELmqTlwD33EewxUxrQholNOkiC6nTqA3r0yXM1yONRliAoZu16krjmzpsl9nTC36xcsrdfuVWRM5ItRwd81eZ2Y46sBaoIQvlt8QxoNOkcvZ5c1C/R6PuC9zsPZ4gcDOD9DLi2X3GQrtdkfPruQrDNyeYOHdaWlRuG8phUx14VbpZrCG/4Q==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TY7PR01MB13924.jpnprd01.prod.outlook.com
 (2603:1096:405:200::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:54:53 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 14:54:52 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2FyAAAh6gIAAJxUAgAAPH8SAAAVwgIAABbk/gAlgAYCAADo/D4AGCcGAgAAQnVOAABhFgIAAAdCwgAFnD4CAAAEXgIAAGv3dgAAQU4CAABZsJ4AADMmAgAAJ34CAAA64ZoAEMSwAgAADgPeAAAroAIAAEzAW
Date: Fri, 9 Oct 2026 14:54:52 +0000
Message-ID:
 <TYCPR01MB109272AB9BEA4B0DC82DB90C496922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <DS7PR12MB95500DA47DA5616DA06DF67D9C922@DS7PR12MB9550.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TY7PR01MB13924:EE_
x-ms-office365-filtering-correlation-id: 19485ce7-e9e0-4bb7-9776-08df26154671
x-microsoft-antispam:
 BCL:0;ARA:14566002|6092099016|15030799006|15080799012|24021099003|51005399006|260826193500599007|41001999006|8062599012|31061999003|25010399006|12121999013|13031999006|8060799015|19110799012|102099032|440099028|26104999009|3412199025|40105399003|18061999006|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SpqsOUQCGlQ+8RTQx1b/OWZ2/9P34xHiEbHgiqrFCH2Y8AOyvIgRP0J3IO?=
 =?iso-8859-1?Q?GLyDc6OTubu8SqfDdE33Lc5OkmZXUztJ+zjMJik2TWkwWPBnnNcBg/A4lj?=
 =?iso-8859-1?Q?pxCOerjTTTx5b41trhzMm4ZyonvJpbbSPHGLWoq/1JRMQKTOG3xqgFQ1/w?=
 =?iso-8859-1?Q?y5wM6Dp0oxJvBEfoxdLl3b5La8BfhZBiUeP1uwN176+YelNdRepfNgrX86?=
 =?iso-8859-1?Q?xSnYq/lsVPx83tShPRGpZwTGLS62bCT395jhyindbVGHgGA7tIHJ9mvUVu?=
 =?iso-8859-1?Q?dKSw335kweZL+3N5S8blaU32qCaFFNmFJT4IvNtAZqTPmgmu8ZW7KblbxN?=
 =?iso-8859-1?Q?CtBR31r26XkBULsyQtWBxnjPczrKjAxJoxxf3Y/dQDzndbMYIeo6Q+u21N?=
 =?iso-8859-1?Q?mJYK+KltAzwn3dr2w5hZdvqnsEAcB+CGAjEaUIMWgkdl2XtRpOUvsM72zI?=
 =?iso-8859-1?Q?YjVwU2SrGjT0i4UBkWuq8Nvt9JyqigmIzVWTP2mIzO1k6106Y/pABu72Xl?=
 =?iso-8859-1?Q?am0NMvtjqod16schjqzq6kowWXru6hrRF9rhiP1qRi+oe63ye/1zpHE9JM?=
 =?iso-8859-1?Q?mNRIQ+m/Mui3IdSNAeCML+PKoCAMvXDoShUvTAd0lq+ErIPn17BfZkI+XJ?=
 =?iso-8859-1?Q?q8BvZNHo9XQN47j7gR56t1Tq7rB8VyPEUhJzCvFCMOzQgygnG+CkX9mWD7?=
 =?iso-8859-1?Q?lDYHWjJB/wwBCxJ03NdrmknLv20aa5sLYmagvDW6Dhg3Ho+7UXs2xGEqBj?=
 =?iso-8859-1?Q?oSpWMp9EuZsy2bwQE5xHQZII4SOCVcLX7ULSzAhek7RuphJAZ1mjNjyTiN?=
 =?iso-8859-1?Q?yIUh9VQkCFHyC7hXiW0vCRXN+A8Rb7sGlASlsRoofntuM9r+OWUu9EVSeB?=
 =?iso-8859-1?Q?Mw8vjhwJRKmwjIqgNp3dMvm0m6gpK2IYcfXPYVJh5+v1Sn2IaulKpdO6H6?=
 =?iso-8859-1?Q?Ti/sHKxw0ykOtWRhnoZDSEbTHPQbbUeGRfAoGLWvyfTNAiCFeUGxiPHSaX?=
 =?iso-8859-1?Q?iaPhrtULvDCQiSL9gDBBkc09VHwsHG7lNWV9c6NyrspRS31kWaY+IVGz/a?=
 =?iso-8859-1?Q?ihhM6c1p5VNCN999dk9OM/o+EjspLR6JaKnjuTREacwiXAkSNss/n6dnDf?=
 =?iso-8859-1?Q?ivdZMFoOKy8Xw9swsSqnNwaJD562WFKUyphy5DQ07W43/vtgZx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wh/sYUf2HUljjMcCvJXnKWarHkSlqcrvzUZYxy17msKVd1BjcO2BZQT0ti?=
 =?iso-8859-1?Q?gTwZmA5GX0fGCutvLiSxIdxXXO+HAQkNdcTtQN/cbd8JY4sgkelMlvhBHh?=
 =?iso-8859-1?Q?Ab0xA8eLVDjJd9KJUa0yBm68d8X4P1LdRi/TjcDOg1biYyMNkKtq+nu2JA?=
 =?iso-8859-1?Q?/Ebfx9rjCsIn/PkJ2KEzAJUSE3debsvZYPHETBx4vuFqFjjmPFPelotev+?=
 =?iso-8859-1?Q?NpOCVKZNhyFdReYxgX8lSoaJIMCVof2nMk1RGiKSQTlzDzwtLXeKx9oibt?=
 =?iso-8859-1?Q?MoLj3ZC23k2yDeLcE+8Vz3L54djPcFcZKSeLpLQAZ9lZ6XUuistn5mICQT?=
 =?iso-8859-1?Q?+0u4LTHyI0P6/+wY8Zy82YqmO7H/oSNUExI9VwTg43vGQTtss6oMxlyJQu?=
 =?iso-8859-1?Q?VM3DRGdkvqhdgnd7cjDGgbhX5+guJLfpv0AVHhntkKR9LjWZ8rNFFOP29L?=
 =?iso-8859-1?Q?kYWWy2LcI/CGrEnC42P/utW9h7OI5I+rT8qaJF4LnRePEX2FZl+C4XtSml?=
 =?iso-8859-1?Q?SEKP9JOJbI8kvnf/PnBqNS68YeVuTXdhHbWUcZNYragAVbyeYvf2dkxzeL?=
 =?iso-8859-1?Q?mYeHi5bY7Zqmf6ND71vuHak5mIlDzxPND2lJS+PGybRkFsKtNcZAtfc/Zu?=
 =?iso-8859-1?Q?s/K4hV79NPQVhHfDcTrFJ8/agv3CUq9JQjLrO8UhJWAn7olWg8Q92eb23Z?=
 =?iso-8859-1?Q?bHI2A7nuMvUJpC5iuRtG6O5iRyGCCYs3RzvJzT+fxh/Cg1p/tO7u+cE6dR?=
 =?iso-8859-1?Q?fB2jGJK01QRQxl68jCDIeuUVQGY+u2OELcLvaftSuiGytDHfoKw7gZwX/R?=
 =?iso-8859-1?Q?S7qeSFWKvYap6rzSTKQ+kThpIlTwyzQw6vuIJjgCkTGCGS4yQempqud4qi?=
 =?iso-8859-1?Q?CAfLC7URmRO60d95kVKDP/REGPlw9ZzO8mYyAgZwqc/X4dIlKjhr/nTC/K?=
 =?iso-8859-1?Q?YQr3Skh4zsnqvoK+05kT5+odAtU4CtiqxD4D3TVtOO/Ad2nIO3D/ZLiNI9?=
 =?iso-8859-1?Q?P1T2sf70ZCVAQE/yfnTbYOBVBAUAvCM+yprzFvBDx0hepY3+UcIbf2C1ua?=
 =?iso-8859-1?Q?+I16LVXwMBKFc1z28tJIQ/s3hR2DVoW++dUWDesSErZrjmDdLZO+GRKPfa?=
 =?iso-8859-1?Q?M8MhqO3IIpBC8jNpVTHg1Rz8Dd2iiexrctScPaJEtH6W312OnK92fVuVUD?=
 =?iso-8859-1?Q?rs3ZfOJC4nu3BPh7bwN+gM6KSOzhZLtPX3uEL02mhBMcslUy1IZwaKgtWW?=
 =?iso-8859-1?Q?hHx/+05Lkcu324VOuPAe6eSNn56ZFnuArJd3TGiPLg+TALmksgLdUGBLuO?=
 =?iso-8859-1?Q?S9uxAEEmOQD8vuV+OmhXbYnL4NtuBIUhL6HMnZXs4+F381SoZr3BZYfYm9?=
 =?iso-8859-1?Q?7R7INnkzrtL0v3K7A2/FQQpGVTLrEuDnbub86SZnsnnndwAGQ+UbDMvGGW?=
 =?iso-8859-1?Q?Q/pC/+CRKXK8TwyutU14+kc47K/N+xkNjzD0aqFhrSMbuiXhA8MnLMN0iH?=
 =?iso-8859-1?Q?k=3D?=
Content-Type: multipart/mixed;
	boundary="_003_TYCPR01MB109272AB9BEA4B0DC82DB90C496922TYCPR01MB10927jp_"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19485ce7-e9e0-4bb7-9776-08df26154671
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 14:54:52.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13924

--_003_TYCPR01MB109272AB9BEA4B0DC82DB90C496922TYCPR01MB10927jp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,=0A=
=0A=
I reran both tests using the new v2 script, I've attached new captures.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Friday, October 9, 2026 21:39=0A=
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
I have attached a modified version of your capture script, please return th=
e 0 & 1 logs of the attempted plug actions.=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, October 9, 2026 8:03 AM=0A=
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
Yes, both tests were performed on CachyOS.=0A=
=0A=
Best regards,=0A=
Freeman=0A=
=0A=
________________________________________=0A=
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
Sent: Friday, October 9, 2026 20:47=0A=
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
For clarity, the D3Cold Allowed set to 0 and 1 tests were on the Catchy OS =
?=0A=
=0A=
Replied or Forwarded By:=0A=
Alex Kovacs=0A=
845-625-4422=0A=
akovacs@amd.com=0A=
=0A=
-----Original Message-----=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Tuesday, October 6, 2026 4:04 PM=0A=
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
Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.=0A=
Logs for both cases are attached. Each was taken in its own cold boot with =
the dock unplugged at boot and the workaround disabled.=0A=
=0A=
=A0 d3cold_allowed=3D0:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3hot=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 PASS - 09:00.0 enumerated naturally=0A=
=0A=
=A0 d3cold_allowed=3D1:=0A=
=A0=A0=A0 before hot-plug:=0A=
=A0=A0=A0=A0=A0 00:04.1 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 NHI=A0=A0=A0=A0=A0 =3D suspended/D3cold=0A=
=A0=A0=A0=A0=A0 09:00.0=A0 =3D absent=0A=
=0A=
=A0=A0=A0 result:=0A=
=A0=A0=A0=A0=A0 FAIL - 00:04.1 remained suspended/D3cold and=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 09:00.0 never appeared=0A=
=0A=
With d3cold_allowed=3D0:=0A=
=0A=
=A0 gpe10: 27 -> 29 -> 31=0A=
=A0 gpe1A: remained 0=0A=
=0A=
With d3cold_allowed=3D1:=0A=
=0A=
=A0 gpe10: 23 -> 25 -> 27=0A=
=A0 gpe1A: remained 0=0A=
=0A=
GPE10 incremented by four in both cases.=0A=
=0A=
In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an runtime=
-resume request shortly afterwards. It reaches D0, pciehp immediately repor=
ts Card present / Link Up, and 09:00.0 then enumerates.=0A=
=0A=
In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no runti=
me-resume event for 00:04.1 after the hot-plug. It remains in D3cold for th=
e rest of the capture and 09:00.0 remains absent.=0A=
=0A=
IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.=0A=
=0A=
SHA256:=0A=
=0A=
=A0 d3cold-allowed-0-20261007-041520.tar.gz=0A=
=A0 5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292=0A=
=0A=
=A0 d3cold-allowed-1-20261007-041802.tar.gz=0A=
=A0 3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4=0A=
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
=0A=
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

--_003_TYCPR01MB109272AB9BEA4B0DC82DB90C496922TYCPR01MB10927jp_
Content-Type: application/gzip;
	name="d3cold-allowed-0-20261009-222535-public.tar.gz"
Content-Description: d3cold-allowed-0-20261009-222535-public.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-0-20261009-222535-public.tar.gz"; size=22808;
	creation-date="Fri, 09 Oct 2026 14:51:24 GMT";
	modification-date="Fri, 09 Oct 2026 14:51:24 GMT"
Content-Transfer-Encoding: base64

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
/1GuwvR4k//1i8r/Cl3pqTK5yf/6587/KvTnyuMm/+uqaDb5Xzf5Xx/mdpP/dZP/dZP/dZP/dZP/
dZP/9R6Z3+R/3eR/3eR/fbL5X+kt+d7kf/0y8r/SFZje5H/d5H+NXRib/K9Pns9N/tc75X9lSq3p
Xjb5Xzf5X++dnKef/5Ur4lnJ65PL/6o+NJt3z/+q003+17t0Yu0e2bzX/K9Ce6qt+Tzyv66UPreG
/K/ENI2n1JrPLv/r/NOTa87/ynS99tZ81vlf6apsPnr+V77J/3qX+uO4CvUQ+V/rjRpbvz2fXP5X
VXsQPpfnf+Wq+kxE+Knmf2WPyOcm/+sm/+s9ov9T5n8l1DQfuss+vfyv98X188r/Sgz9TlEAm/yv
Oceb/K+b/K+b/K/PkOFN/tdN/teHz/8qtLWHmk3+103+103+103+103+1y9hlN3kf93kf330203+
103+103+V6I+AxY3+V83+V83+V83+V/r4HST/3WT/3WT/3WT//VBb6mmMH0Op6vlf/1iUy8yjaZ5
ERk10tyY1NQMI/sgPdcNE/0lBh5TjDThHlPU7ANNzexd1cgStAnBU5tfzfPnafm6t2BZrjaTZ3v9
DDXNSEcVHXca/JlTL8KUOJs3sTxxIjOzuaPQsgV1oWfzZ8HyD8xM2zOW08Jzm13kEWeF1fkcLhF5
bsY8Oo0yVlprWJZ6UVBqZDQbhdx+2V44luWAZDwjhKrZLcsPB6Qmz2jKkhmCtso2fVAlS0kJMpkR
refFRF6HppZlB+RYWyukXlSppmdJFs0UlwBqE1xcy9I8ckMXSlrrRpqElOsiTUrIBUsrkzMt3ZzE
RBYRz4SWNijV1XR/FeOamX7LjKw/qzRd/GCmTG66UupFPK07q9wsZyo186dq1n7UyFN/5tUIvGcN
wbVZ6RTz3KDEzBN35pkxqWJkKGimEKjC8luEu0m9uEm9+Ai3m9SLz+F2k3rxWZikm9SLz8g+3aRe
3OR/2uR/2OR/2FxfVv6HOyWAXJr/UdPK+R+ozrVN/sdHuTD/Y9zEsxJAqh1VvNZ0xmBWrtJFCSDD
STh2R47rtPf4hR/JNJDFZ1gCs0EOvTDEYKrpbJBLU0LdNRukUskGqVSyQeqrZYOkX5B+3Iz/m/G/
NP5zbTP+b8b/fPyf+iCC6V2z742sQfOKtcKLu4//XNc4zcd/Ae8ZBw2wGf8f4/r6L+1JGLR73qjt
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
dJs49gD4AgA=

--_003_TYCPR01MB109272AB9BEA4B0DC82DB90C496922TYCPR01MB10927jp_
Content-Type: application/gzip;
	name="d3cold-allowed-1-20261009-222842-public.tar.gz"
Content-Description: d3cold-allowed-1-20261009-222842-public.tar.gz
Content-Disposition: attachment;
	filename="d3cold-allowed-1-20261009-222842-public.tar.gz"; size=13185;
	creation-date="Fri, 09 Oct 2026 14:51:25 GMT";
	modification-date="Fri, 09 Oct 2026 14:51:25 GMT"
Content-Transfer-Encoding: base64

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
X/VVX/V1h+v/A2YrcN0AMAIA

--_003_TYCPR01MB109272AB9BEA4B0DC82DB90C496922TYCPR01MB10927jp_--
