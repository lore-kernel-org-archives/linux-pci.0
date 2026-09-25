Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011030.outbound.protection.outlook.com [52.103.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA083FF1A9;
	Fri, 25 Sep 2026 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335924; cv=fail; b=bXYMA1c2vjOvMB/868vZNIo9VOYBZ5I3sYiYYX/3lQdBYPXUXGX6Tox8RerqPA2txJ/mglb+VRl1YusTpaWc/hboWSIFJW9Yn/0/Ot/HiHJySnDj0O8Isq1BAfTIcG9gVMEfNZmPN181Q1I0qfaYQZLTMOuLkDtIvkkHrsJ7oYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335924; c=relaxed/simple;
	bh=/a4sOieYdd5x1KeKeJj1daPVaP5DCqzIvR3GGqZ+BTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnLAOyIQzdFYn8oXmVsyR40mTaSXa5oU2TAhyYYtLCDpkOSh6FuDnXY1OutzWdVRHPR2uQm/W+k5i6OT329VEJ+vsueaYZS1iS++UoB5xrhL0UNQU12vdVtbA9sgUYz3WTjMNrfbU/kQKXvBx+FpIX9FO/XG4glMqoMCbQUn8Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sl/1HcMT; arc=fail smtp.client-ip=52.103.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sl/1HcMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3c/eMtBmxUHuNrZF1RA7jnJiskZdd/0M4mxc8SqV2NGqgmuaOFt3bMdloB49bZnFU4uknho2dVg0IJRS0N0pWT0vt0+bPLQ1yPnLx8SB15e4F2B1WLv8P/syRn25o7alyojunynNujp4Ave7R0YTMLF5xSPOO62u+ryx9lXca9s5ibD5du0uFFejrGtfEmMPxEEzccn+SFlAxUsJiTDARUXv9DOi3yIzEr9Yc+YOGKl1vjZ0NiQhmxh4p83tm9nLtXe8dpn098b1HqPSjLLjEe7rpeUIAAwVOWYdU2v+ZIGC2AT+LqJc/Iaa4eKJko1NZIe4j1yZKlTLpCIQP5uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOfA6WVyegjiPci9YSZ8JKLSqgYKXfa5XbzM3VKhAkc=;
 b=lfweX+nijdNdTXaMIUOLxuB3WRL8kB7aoyrE/ymPYXwv5LdhOnO+iciuE3zWBZ1L9ORkivYbcGcondGjcGg4CccpLJyo7tv7fuwX2QOr2+jBIXTdFVQM8oSZXZ/SqeH3n4x2oBGsw32dT2Fz8GoqVLtLyCKhFb2aqyhAzYL0eD6SIKvWCsqgWniwvN5fawPbXNpIvSMu18OKUaFJ5/PomcdLAarPuQdqxZr0eAIKVB9vrCLARMUwzbXrFZWM4FPDf4YJAdpcvg8SRbc8W/KxMtgSUZyyDj6ayPmtVnDog01TP1LZBwmDlng1oYqxncsMJlP1HTPNpvz/a/CZGoYVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOfA6WVyegjiPci9YSZ8JKLSqgYKXfa5XbzM3VKhAkc=;
 b=sl/1HcMTJIaSt4JylwDNq2pLsvjYnyvRMQo/wdw0HmBUaO9IVI+20tlo0ZOpH6xieWB2cvjhDKfOExnWsabTdxf8YNpualfSuCwUqRAXPn96ejlTZvb2pqAsou0CMRbfJ4rAasTUXXW9emmWjhvzqOnKr9MwClt7rBXW/6lEjuG7X2BsclH6lqIAaqxMf4e/ukIPaX+vgndZD1aXyrublPO+sjOk1xjKWhgAfWxz/dnWKC0QDZTTbRm0U0Pq1MJO02cRKK+p9gtyVwEfMd0M7mRg4sT1xf396QvAsmE5xlt4Q1H9MoVIcZf8kTebEoE3ASk9gb/oZbaQsDf6ZTj6Rg==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYCPR01MB6931.jpnprd01.prod.outlook.com
 (2603:1096:400:ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 11:31:55 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 11:31:55 +0000
From: Freeman Z <SHD-ISAC@outlook.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"westeri@kernel.org" <westeri@kernel.org>, "andreas.noever@gmail.com"
	<andreas.noever@gmail.com>, "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "S, Sanath" <Sanath.S@amd.com>, "Natikar,
 Basavaraj" <Basavaraj.Natikar@amd.com>, "Martinez, Juan"
	<Juan.Martinez@amd.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/gAAe2Fw=
Date: Fri, 25 Sep 2026 11:31:55 +0000
Message-ID:
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYCPR01MB6931:EE_
x-ms-office365-filtering-correlation-id: ed6d68ce-908d-4001-94fb-08df1af89a40
x-ms-exchange-slblob-mailprops:
 =?iso-8859-1?Q?JyMQWBBO+xmqmioSQ2iYsFiqQ4Fp2hzH/s6irYjt8WsKobpEGrJhU3MUL/?=
 =?iso-8859-1?Q?/LsTe6bIzt17slbtiCuZp3x+o4ibKSyZZ93GEjeHCnXHO5Q0boNZvYfpoq?=
 =?iso-8859-1?Q?tH0PHqulwKGM+els3dx57PS9ua3G5I8UI87tUpOxtkkCKPGH/fb/OUTI/U?=
 =?iso-8859-1?Q?5iottsXwTFpF2H7HdfZ+9ssDWnrNgNBu/0ztjonVfzvBEHRbqcPJECfcgv?=
 =?iso-8859-1?Q?NWU7y1NwvwrutEb+WcPjLP14gSAnKfpgpRY4XeUdO/ydJa8HbP5bJ33WdH?=
 =?iso-8859-1?Q?MiL56xKcudbizs1zFSMd0LnT2QacDUyh5CBzZn4oMzUSTdyZuO9ut4TJhP?=
 =?iso-8859-1?Q?VxLMvYRZ5SvVuPVMcF4W0HcwUBJkNqHjYLgRnUZrBR4NeTCTx7zuPhPp/v?=
 =?iso-8859-1?Q?Nir2fPMqqy9/y9Ornya2HdY3Ea/iD0PzFSB+eP6ZTxa7QjWlCq6OjvfdDx?=
 =?iso-8859-1?Q?d/CZBbu9qOekn75N7fLM7Qw9cVKe05Sm6cjVs3J+Mp9YK1/agwIYIftG0J?=
 =?iso-8859-1?Q?5Ud27f5NXkBni1k6gPXkZqQh36xYosKTIIa2O+2zB0fJmbD/ySNG2y9Cie?=
 =?iso-8859-1?Q?5IR3KF3/vk2qY8Q7JzvdWbII5QgJEwsWkU8o6/auqxOZ37kxri/PUeUYno?=
 =?iso-8859-1?Q?8qKHw+qGHquXKaHWWpZioz4mkFNdtEWFZ9Gt9rr3Nik7iQLwPjVVCZW65d?=
 =?iso-8859-1?Q?BoI4o8e+MXfMt3P8G3wrerTwZzeSviSSA1i4yGK1jxUaXAZPpwy/tCMRGO?=
 =?iso-8859-1?Q?AFjhlBqvVQhu+nEOnERe06lKDNFi//3ds6vWqMbkR5xb4Z8JIMOHWY0fd3?=
 =?iso-8859-1?Q?u27/3hx/qu9Bv464YGXBKsZ3PThFiMWgp9IqUW1N1sS8sfXN8+RXk0KKy0?=
 =?iso-8859-1?Q?iKSTu8TV/AJSvEKVYftQaPnKfA+xTJIiIHNVF/QxE5G/vdm44ONSNYFyNr?=
 =?iso-8859-1?Q?x1n/B9NJFibRAQ2LqtHNLWgycsADtBlDO2gKEAzjtDsD+EgEVoFLPeU2cv?=
 =?iso-8859-1?Q?5E7A9+sEuWU7HRhvl502GZBDaTVA=3D=3D?=
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|12121999013|260826193500599007|31061999003|8062599012|25010399006|19110799012|8060799015|41001999006|24021099003|15030799006|15080799012|3412199025|440099028|4302099013|26104999009|102099032|1602099012|40105399003|18061999006|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5Zm0jcGC4kiQgHkVQ3LFtQGyzXNPzLoVJBO5t4ds8iUWREl1zS5mnODNJc?=
 =?iso-8859-1?Q?V/mCzLnpNoieLo08eAIHb9IbcTlBK71SsgZwh3yxeLla2KsjbHbQ0k/fJE?=
 =?iso-8859-1?Q?xTjA4qMBGsxcibAQUYV/oy/Jt+mFIxcQ4pcyh4Ry06c+UI3CB4bre8mQ2K?=
 =?iso-8859-1?Q?4EWevU2zpRXyrTso3S47EOlp5mRVm29SM3YOwzaVqs8pmbDw52ytRaCzCJ?=
 =?iso-8859-1?Q?PueYjxl1ORGY7KpVaDmWII00h8D4u1yztuVYKsLQiTQy1EFamwG8R+G7mw?=
 =?iso-8859-1?Q?7D9dPJGBDcvX2AiBanRHydIelgnsIRAujV5ftXmG0jBkG7WC70ZFZI4dB6?=
 =?iso-8859-1?Q?j8AMG9J7y9ikUaQInfZUXBbBU4gFOMNVkjPx9xA6mdRZekiit08as+jXPD?=
 =?iso-8859-1?Q?t5el7C+d9M6aU1pOrs3hQq4rBBOFu5PbnTItoAeLX6v5nNW77nk6obf4dh?=
 =?iso-8859-1?Q?KhKNfvtuXJvUBYJcO6WZbMKH0k+6WZlMITBjJJ3VMIud+HHkbBInBxrdf1?=
 =?iso-8859-1?Q?/IKEB0sYK/BPkwwpzlrwC12938529cmnfcOziEmFqV6/1bKE/o+95k4e9U?=
 =?iso-8859-1?Q?G7AzosqfD6IQhadrLu8O7lmtkWdS6sgIQHkTAfMOTdwzcNVcmKJ/h22Gsp?=
 =?iso-8859-1?Q?Am45tAe1c/vktYOMM/Sxv20wgPQHhgc1IidYzLMjLLmkB5cdoFd9Z/A3Yv?=
 =?iso-8859-1?Q?XsQOppuMepCdmPiq+Gi5TbueAEF2WQhmnXF633qOWTUcl755GDzkuJp1tg?=
 =?iso-8859-1?Q?95MJw3ouv09L57laOiuE3Npwci7K2Qk+rFvP090RDQD0oXRwENbYSnnptl?=
 =?iso-8859-1?Q?pA4+zWQ7uru1jMWEefUfRvv/Po83HAyuO02XJwoMYif0p51MCIh3AAMFQP?=
 =?iso-8859-1?Q?iEnYMnaAmitE5Cx86cYxVbk1uLx1uVa+XO3Un/+3jrs3pedbdgkEd/dB2T?=
 =?iso-8859-1?Q?j84DITvloTrRELAutBdNRg0ZisWktX8QdoW8Lkogdy789+DwYwxbM00XhK?=
 =?iso-8859-1?Q?LPD0QV3iZUYeO5M0gbFPlke/TwBiLofq9Y0QWkJeodTnlj2RB0YcJciu8o?=
 =?iso-8859-1?Q?lbN41CsdFGfSmewAa89pXWIKfxfeMWikHMhEqI4RqK8fPq6ds5rxoHPq+9?=
 =?iso-8859-1?Q?s5etj/eF0zd5g38kJSYE7tB9TaIPwCsFxx147Pl3Wi2q/Xxl4+KJc3sR1B?=
 =?iso-8859-1?Q?lZPyZcwVAfmlcQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D2IM8wDnRvFMk4KsqKL/gYsrWBBMEsx+V+28NMyOiasqlr1jV8DIj3C1WW?=
 =?iso-8859-1?Q?6/OAJ3B1qhsFbL9JMatbjUXmhhEofzbqtGa44ZTD2u2cg3vNrf7hcRhwV8?=
 =?iso-8859-1?Q?RBcfczkU4s1sdY0gbmCCJGQbwvKG+t4Q9vPo40nBYNA4ug1E+M7dKwdFau?=
 =?iso-8859-1?Q?1WOPwRjjLn9hci+3AHfIZTDJv94OlrRrw/uWV8lN5tZ0UfjEsxeZBVo4BF?=
 =?iso-8859-1?Q?8sV8H+MKUi8C2TWN6k5udCtfbBeQu7S25Qibc8AQpWnzArVuUj6NfBZU4s?=
 =?iso-8859-1?Q?HCuxiYmSMswqz3EMLA5p/e9iu/kjapMWvghIPPp6yqQ6jaGS7KacPRSXtd?=
 =?iso-8859-1?Q?lrk6+bw71xChDBsBDcpxU8SOUuTGeQI0ilAhmJe/EZQwhxMiWDNTNZuef1?=
 =?iso-8859-1?Q?+/PZ14/b0PHLj8nGVIEsIEzQMUrYq5eYcPcQ16rsZHaRiKGghkR8cdgizo?=
 =?iso-8859-1?Q?HiqA5V96wV/o1g+0fyxWOc/fg5kSH70+59p+ESEH+0dR2pqEwoHT4U/uP+?=
 =?iso-8859-1?Q?Ja+JfWXqtbIEk9oNw7ZnghkugqBfEsSqfRGGw9liMC0VtABeTsCY8qmSKL?=
 =?iso-8859-1?Q?afgttLm7y3VMwZeW4/A9YghP0TVLGrFQHhTWBnXIzfCeqiKLxGAD1VaSrw?=
 =?iso-8859-1?Q?0fUNOneEENzIh18uNONAAOqevzuWaBd7EpQWBS/Rdp5NtCLZrBJqCC0RhE?=
 =?iso-8859-1?Q?fQ2HNDx23gR7+3P4xp43BK84aEyJNQ8AxBsy1AYChuDCQDR7g3kRE7Fkxv?=
 =?iso-8859-1?Q?T41Yk5NoT+XHakzMEyabWw+9HY6GCQrTq51/K9EEhVM1ud65x8PnSTdiqi?=
 =?iso-8859-1?Q?zvK5dpeMbgHIEpnXyCL/FieljdZEegmI7juYaMnYI/B5wYttOnrVx5m1SW?=
 =?iso-8859-1?Q?pgrH2zuDGzzWIMypxhoJiGLND0fPNkWGUuI8uKa5y1/1opwf8Ff/F45yQc?=
 =?iso-8859-1?Q?YGfE/Q5X7MWi4qM8oDFHvmMlnw8OoPqToI8uD6YwRJdPRzECOhcpC6Tm9m?=
 =?iso-8859-1?Q?lOZVR5vjN6FTra3AA2Wx92iKimD7CoJHPSRLB8ybdnlLO/TLjRxokcO6Bd?=
 =?iso-8859-1?Q?awKq4WK+8AsUAR0GeCksnkisdFlLhABeccqDqRU5C2NMy3ezeUMyspgXG/?=
 =?iso-8859-1?Q?L5biG8zM/8fs/2zQAGJfweSTWhDUiaTaXOxsEkzjk4kyRQA9vxV1Fp+fEp?=
 =?iso-8859-1?Q?6S/yqCEunQ1MVqpLeSrs97cla8VuCKNna265ARMnCFt8+pXrlRyFa0eK7J?=
 =?iso-8859-1?Q?bX7K5Tcxbn/EVO5aEau9V32/bI4bDL7R7CczJmdhCP2tk7W4MoeuobPaLe?=
 =?iso-8859-1?Q?fPcCs6KrAVVbUtWNTbj5JGpCcCYxJhZBRH2Q1igPQYvgh9iBdKHNlLt6ax?=
 =?iso-8859-1?Q?JJ2YB6UFTrlI43GkTRF95G29HpIL7X7oVbrcVfU1hNSl5/pEMWwdYfFk9x?=
 =?iso-8859-1?Q?UwPTpZ1VkvDGVt/c03c5ansEzEwNpjXnxheZ1A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6d68ce-908d-4001-94fb-08df1af89a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 11:31:55.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6931

Hi Mika, Alex and Mario,=0A=
=0A=
I tested v7.3-rc4 with the following Ubuntu SAUCE patch from=0A=
Chia-Lin Kao (AceLan) at Canonical:=0A=
=0A=
    thunderbolt: Fix PCIe device enumeration with delayed rescan=0A=
=0A=
Ubuntu SRU posting:=0A=
    https://lists.ubuntu.com/archives/kernel-team/2026-April/166926.html=0A=
=0A=
Launchpad:=0A=
    https://bugs.launchpad.net/bugs/2139572=0A=
=0A=
The Ubuntu posting says this was cherry-picked from the corresponding=0A=
upstream submission:=0A=
=0A=
    https://lore.kernel.org/lkml/20260121060857.237777-1-acelan.kao@canonic=
al.com/T/#u=0A=
=0A=
The patch schedules a delayed pci_rescan_bus() 300 ms after the=0A=
Thunderbolt PCIe tunnel has been activated, to recover devices that=0A=
pciehp did not enumerate.=0A=
=0A=
The patch as posted was written against an older Thunderbolt NHI API=0A=
and refers to:=0A=
=0A=
    tb->nhi->pdev=0A=
=0A=
In v7.3-rc4, struct tb_nhi instead contains struct device *dev.=0A=
I therefore made only the API adaptation needed to build the same=0A=
logic on v7.3-rc4:=0A=
=0A=
    if (tb->nhi && tb->nhi->dev && dev_is_pci(tb->nhi->dev)) {=0A=
        struct pci_dev *pdev =3D to_pci_dev(tb->nhi->dev);=0A=
        struct pci_bus *bus =3D pdev->bus;=0A=
=0A=
The delayed-rescan behavior itself is otherwise unchanged, including=0A=
the 300 ms delay and pci_rescan_bus() call.=0A=
=0A=
With this patched v7.3-rc4 kernel, the same hotplug test succeeds.=0A=
I did not run lspci before checking the result.=0A=
=0A=
So the current A/B result, using the same v7.3-rc4 base and test=0A=
procedure, is:=0A=
=0A=
    Linus v7.3-rc4=0A=
        -> hotplug fails=0A=
=0A=
    Linus v7.3-rc4 + the above Ubuntu delayed-rescan patch=0A=
        (with only the v7.3 NHI API adaptation described above)=0A=
        -> hotplug succeeds=0A=
=0A=
This may also explain why the Ubuntu 26.04.1 7.0-based kernel worked=0A=
in my earlier test while both Linus v7.0 and stable 7.0.12 fail.=0A=
=0A=
The delayed rescan may simply recover enumeration after the PCIe=0A=
tunnel has been established even though the normal pciehp/wake=0A=
path did not complete as expected.=0A=
=0A=
I can collect a full dynamic-debug/state trace from the patched=0A=
v7.3-rc4 kernel as well if that would be useful.=0A=
=0A=
Thanks,=0A=
Freeman=0A=
________________________________________=0A=
From: Freeman Z <SHD-ISAC@outlook.com>=0A=
Sent: Friday, 25 September 2026 09:38:26=0A=
To: Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org=
>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.c=
om <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.=
noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezke=
lshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kerne=
l.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Ba=
savaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>=
=0A=
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=A0=0A=
Hi Mika, Alex and Mario,=0A=
=0A=
I tested both requested points from Linus' mainline tree using the same=0A=
reproduction procedure.=0A=
=0A=
v7.3.0-rc4: bad=0A=
v7.0.0:=A0=A0=A0=A0 bad=0A=
=0A=
For both tests, the dock was disconnected at boot. I hot-plugged=0A=
the dock without running lspci after boot.=0A=
=0A=
In both cases, after hotplug:=0A=
=0A=
=A0=A0=A0 0000:00:04.1 remained suspended / D3cold=0A=
=A0=A0=A0 0000:6b:00.6 resumed to active / D0=0A=
=A0=A0=A0 0000:09:00.0 was missing=0A=
=0A=
Thanks,=0A=
Freeman=0A=
________________________________________=0A=
From: Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
Sent: Friday, 25 September 2026 05:27:27=0A=
To: Freeman Z <SHD-ISAC@outlook.com>=0A=
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org=
>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.c=
om <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.=
noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezke=
lshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kerne=
l.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Ba=
savaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>=
=0A=
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration=0A=
=A0=0A=
Hi,=0A=
=0A=
I wonder if you could try the vanilla mainline kernel (not the stable=0A=
trees), this one:=0A=
=0A=
=A0 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=0A=
=0A=
Take for example v7.3-rc4 and see if the problem happens. If it does, take=
=0A=
say v7.0 or whatever is the closest the stable tree that has it working and=
=0A=
see if that works. If that works then we have the two points needed to=0A=
bisect the issue on the mainlne.=0A=
=0A=
On Thu, Sep 24, 2026 at 07:18:30AM +0000, Freeman Z wrote:=0A=
> Hi Alex, Mario and Mika,=0A=
>=0A=
> Yes. I have now tested self-built vanilla kernel.org Linux 7.0.12=0A=
> and 7.2.6 on the same machine, with thunderbolt.dyndbg=3D+p.=0A=
>=0A=
> The external monitor is connected through the Kensington SD5000T5=0A=
> dock.=0A=
>=0A=
> For both vanilla 7.0.12 and 7.2.6, I see the following behavior:=0A=
>=0A=
>=A0=A0 - Cold or warm boot with the dock already attached:=0A=
>=A0=A0=A0=A0 enumeration works normally in my tests.=0A=
>=0A=
>=A0=A0 - Boot/reboot with the dock disconnected, wait until=0A=
>=A0=A0=A0=A0 0000:00:04.1 and 0000:6b:00.6 are runtime-suspended in D3cold=
,=0A=
>=A0=A0=A0=A0 then hot-plug the dock:=0A=
>=A0=A0=A0=A0 the failure reproduces before running lspci.=0A=
>=0A=
> In the failing runs on both vanilla kernels:=0A=
>=0A=
> Before hotplug:=0A=
>=0A=
>=A0=A0=A0=A0 0000:00:04.1=0A=
>=A0=A0=A0=A0=A0=A0 power/control=A0=A0=A0=A0=A0=A0=A0 =3D auto=0A=
>=A0=A0=A0=A0=A0=A0 power/runtime_status =3D suspended=0A=
>=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D D3cold=0A=
>=0A=
>=A0=A0=A0=A0 0000:6b:00.6=0A=
>=A0=A0=A0=A0=A0=A0 power/control=A0=A0=A0=A0=A0=A0=A0 =3D auto=0A=
>=A0=A0=A0=A0=A0=A0 power/runtime_status =3D suspended=0A=
>=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D D3cold=0A=
>=0A=
> After hotplug, before lspci:=0A=
>=0A=
>=A0=A0=A0=A0 0000:00:04.1=0A=
>=A0=A0=A0=A0=A0=A0 power/control=A0=A0=A0=A0=A0=A0=A0 =3D auto=0A=
>=A0=A0=A0=A0=A0=A0 power/runtime_status =3D suspended=0A=
>=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D D3cold=0A=
>=0A=
>=A0=A0=A0=A0 0000:6b:00.6=0A=
>=A0=A0=A0=A0=A0=A0 power/control=A0=A0=A0=A0=A0=A0=A0 =3D auto=0A=
>=A0=A0=A0=A0=A0=A0 power/runtime_status =3D active=0A=
>=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D D0=0A=
>=0A=
>=A0=A0=A0=A0 0000:09:00.0=0A=
>=A0=A0=A0=A0=A0=A0 missing=0A=
>=0A=
> Thunderbolt dynamic debug reports both:=0A=
>=0A=
>=A0=A0=A0=A0 PCIe Down path activation complete=0A=
>=A0=A0=A0=A0 PCIe Up path activation complete=0A=
>=0A=
> Only after running:=0A=
>=0A=
>=A0=A0=A0=A0 lspci >/dev/null=0A=
>=0A=
> does the root port wake and PCIe hotplug proceed. I then see:=0A=
>=0A=
>=A0=A0=A0=A0 0000:00:04.1=0A=
>=A0=A0=A0=A0=A0=A0 power/runtime_status =3D active=0A=
>=A0=A0=A0=A0=A0=A0 power_state=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D D0=0A=
>=0A=
>=A0=A0=A0=A0 pcieport 0000:00:04.1: pciehp: Slot(0-1): Card present=0A=
>=A0=A0=A0=A0 pcieport 0000:00:04.1: pciehp: Slot(0-1): Link Up=0A=
>=0A=
>=A0=A0=A0=A0 0000:09:00.0=0A=
>=A0=A0=A0=A0=A0=A0 present=0A=
>=0A=
> This does not appear to be a 7.0 -> 7.2 upstream regression:=0A=
> vanilla 7.0.12 and vanilla 7.2.6 show the same D3cold/hotplug=0A=
> failure.=0A=
>=0A=
> The Ubuntu 26.04.1's 7.0-based 7.0.0-30-generic kernel=0A=
> successfully enumerated the same hotplug in my previous=0A=
> test, whereas vanilla upstream 7.0.12 does not.=0A=
>=0A=
> There is one additional difference in my testing:=0A=
>=0A=
>=A0=A0 - Vanilla 7.0.12 / 7.2.6:=0A=
>=A0=A0=A0=A0 dock already attached at boot -> works so far.=0A=
>=0A=
>=A0=A0 - CachyOS 7.2.6:=0A=
>=A0=A0=A0=A0 I have also reproduced the failure with the dock already atta=
ched=0A=
>=A0=A0=A0=A0 at boot.=0A=
>=0A=
> The D3cold hotplug failure is reproducible on vanilla upstream,=0A=
> while CachyOS may have an additional boot-time difference on top of=0A=
> that.=0A=
>=0A=
> Regarding the display, it is connected through the dock. Both vanilla=0A=
> 7.0.12 and 7.2.6 also log DP DPRX read timeout(s), followed by=0A=
> successful capability reads during dock setup.=0A=
>=0A=
> I attached a sanitized archive containing the complete=0A=
> before-hotplug, after-hotplug-before-lspci, and after-lspci dmesg/state=
=0A=
> captures for both vanilla kernels.=0A=
>=0A=
> Thanks,=0A=
> Freeman=0A=
> ________________________________________=0A=
> From: Kovacs, Alexander <Alexander.Kovacs@amd.com>=0A=
> Sent: Wednesday, 23 September 2026 19:37:13=0A=
> To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger=
.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@goog=
le.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com =
<andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; =
rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@v=
ger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavara=
j.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>=0A=
> Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend preven=
ts JHL9480 downstream enumeration=0A=
> =A0=0A=
> AMD General=0A=
>=0A=
> Also, is the external monitor hooked directly to the system or through th=
e dock?=0A=
>=0A=
> Replied or Forwarded By:=0A=
> Alex Kovacs=0A=
> 845-625-4422=0A=
> akovacs@amd.com=0A=
>=0A=
> -----Original Message-----=0A=
> From: Freeman Z <SHD-ISAC@outlook.com>=0A=
> Sent: Wednesday, September 23, 2026 6:52 AM=0A=
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Al=
exander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=
=0A=
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google=
.com; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; =
rafael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; =
Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martin=
ez@amd.com>=0A=
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend preven=
ts JHL9480 downstream enumeration=0A=
>=0A=
> Caution: This message originated from an External Source. Use proper caut=
ion when opening attachments, clicking links, or responding.=0A=
>=0A=
>=0A=
> Hi Mario, Mika and Alex,=0A=
>=0A=
> I tested the Kensington SD5000T5 dock again by using Ubuntu 26.04.1 Live =
with kernel 7.0.0-30-generic and thunderbolt.dyndbg=3D+p. The dock was disc=
onnected at boot, and I did not run lspci before the hotplug log and power =
states had been saved.=0A=
>=0A=
> In this Ubuntu run the PCIe/USB enumeration worked without any workaround=
:=0A=
>=0A=
> =A0426.716: USB4 dock connection detected (host port 0:2, link up)=0A=
> =A0426.753: Kensington SD5000T5 discovered=0A=
> =A0428.410: PCIe Down path activation complete=0A=
> =A0428.411: PCIe Up path activation complete=0A=
> =A0429.025: pcieport 0000:00:04.1 reports Card present / Link Up=0A=
> =A0429.026: downstream 0000:09:00.0 (8086:5786) enumerated=0A=
>=0A=
> After the dock had connected, but *before* running lspci, the sysfs state=
s were:=0A=
>=0A=
> =A00000:00:04.1 =A0power/control=3Dauto; runtime_status=3Dactive; power_s=
tate=3DD0=0A=
> =A00000:09:00.0 =A0present=0A=
> =A00000:6b:00.6 =A0runtime_status=3Dactive; power_state=3DD0=0A=
>=0A=
> The downstream USB devices and dock Ethernet also enumerated. I then ran =
lspci once: 0000:00:04.1 remained active/D0, 0000:09:00.0 remained present.=
 Thus this run cannot show an lspci-triggered wakeup or a resulting PME eve=
nt: it was already working.=0A=
> In my previous failing CachyOS runs, invoking lspci could wake 00:04.1 an=
d make 09:00.0 appear. I do not see an explicit PME delivery message at hot=
plug in the Ubuntu dmesg.=0A=
>=0A=
> The external display did still flicker. The Ubuntu log includes one DP tu=
nnel DPRX read timeout at ~431.188s, followed by a completed capability rea=
d at ~431.239s, I do not know if it's related.=0A=
>=0A=
> Attached are the full Ubuntu dmesg after/before hotplug and the state fil=
es.=0A=
> Unrelated USB serial numbers and network interface MAC addresses are reda=
cted.=0A=
>=0A=
> Thanks,=0A=
> Freeman=0A=
>=0A=
> ________________________________________=0A=
> From: Mario Limonciello <mario.limonciello@amd.com>=0A=
> Sent: Wednesday, September 23, 2026 4:00=0A=
> To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@out=
look.com>; Mika Westerberg <mika.westerberg@linux.intel.com>=0A=
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger=
.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@goog=
le.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com =
<andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; =
rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@v=
ger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavara=
j.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>=0A=
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend preven=
ts JHL9480 downstream enumeration=0A=
>=0A=
> > -----Original Message-----=0A=
> > From: Freeman Z <SHD-ISAC@outlook.com>=0A=
> > Sent: Tuesday, September 22, 2026 11:41 AM=0A=
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg=0A=
> > <mika.westerberg@linux.intel.com>=0A=
> > Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;=0A=
> > bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com;=0A=
> > YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S,=
=0A=
> > Sanath <Sanath.S@amd.com>; Natikar, Basavaraj=0A=
> > <Basavaraj.Natikar@amd.com>; Kovacs, Alexander=0A=
> > <Alexander.Kovacs@amd.com>=0A=
> > Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend=0A=
> > prevents JHL9480 downstream enumeration=0A=
> >=0A=
> > [You don't often get email from shd-isac@outlook.com. Learn why this=0A=
> > is important at https://aka.ms/LearnAboutSenderIdentification ]=0A=
> >=0A=
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.=0A=
> >=0A=
> >=0A=
> > Hi Mika, Mario,=0A=
> >=0A=
> > I reproduced the failure following the requested sequence on my install=
ed CachyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=3D+p.=
=0A=
> >=0A=
> > For this trace the dock was physically disconnected at boot. I did not =
run lspci before or during the reproduction.=0A=
> >=0A=
> > Before plugging the dock:=0A=
> >=0A=
> > =A0 =A0 =A00000:00:04.1=0A=
> > =A0 =A0 =A0 =A0power/control =A0 =A0 =A0 =A0=3D auto=0A=
> > =A0 =A0 =A0 =A0power/runtime_status =3D suspended=0A=
> > =A0 =A0 =A0 =A0power_state =A0 =A0 =A0 =A0 =A0=3D D3cold=0A=
> >=0A=
> > =A0 =A0 =A00000:6b:00.6=0A=
> > =A0 =A0 =A0 =A0power/control =A0 =A0 =A0 =A0=3D auto=0A=
> > =A0 =A0 =A0 =A0power/runtime_status =3D suspended=0A=
> > =A0 =A0 =A0 =A0power_state =A0 =A0 =A0 =A0 =A0=3D D3cold=0A=
> >=0A=
> > After plugging the Kensington SD5000T5 and waiting about 15 seconds:=0A=
> >=0A=
> > =A0 =A0 =A00000:00:04.1=0A=
> > =A0 =A0 =A0 =A0power/control =A0 =A0 =A0 =A0=3D auto=0A=
> > =A0 =A0 =A0 =A0power/runtime_status =3D suspended=0A=
> > =A0 =A0 =A0 =A0power_state =A0 =A0 =A0 =A0 =A0=3D D3cold=0A=
> >=0A=
> > =A0 =A0 =A00000:09:00.0=0A=
> > =A0 =A0 =A0 =A0missing=0A=
> >=0A=
> > =A0 =A0 =A00000:6b:00.6=0A=
> > =A0 =A0 =A0 =A0power/control =A0 =A0 =A0 =A0=3D auto=0A=
> > =A0 =A0 =A0 =A0power/runtime_status =3D active=0A=
> > =A0 =A0 =A0 =A0power_state =A0 =A0 =A0 =A0 =A0=3D D0=0A=
> >=0A=
> > The Thunderbolt dynamic debug log shows the NHI/control channel waking =
and the USB4 fabric being configured. In particular:=0A=
> >=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: control channel starting...=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: 0: resuming switch=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (sta=
te:=0A=
> >2)=0A=
> > =A0 =A0 =A0thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock=
=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: PCIe Down path activation complete=
=0A=
> > =A0 =A0 =A0thunderbolt 0000:6b:00.6: PCIe Up path activation complete=
=0A=
> >=0A=
> > However, I do not see a PME message corresponding to the dock insertion=
.=0A=
> > The PME messages in the full dmesg are the early-boot=0A=
> > "PME: Signaling with IRQ ..." initialization messages.=0A=
> >=0A=
> > So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold to=
=0A=
> > D0 and the Thunderbolt driver successfully programs the PCIe tunnel in=
=0A=
> > the=0A=
> > USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.=
1 remains in D3cold and the downstream 0000:09:00.0 hierarchy never appears=
.=0A=
> >=0A=
> > I attached the full dmesg captured after the dock plug, plus the small =
before/after state files. I redacted only unrelated local network identifie=
rs, the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and=
 device UIDs are otherwise unchanged.=0A=
> >=0A=
> > This particular dynamic-debug trace was collected on CachyOS rather tha=
n the Arch stock kernel used for my earlier reproduction.=0A=
> >=0A=
> It sure sounds like a PME doesn't deliver properly for some reason.=0A=
>=0A=
> I suppose that while in this state - if you ran lspci the root port at=0A=
> 0000:00:04.1 exits D3cold and 0000:09:00.0 shows up, right?=0A=
>=0A=
> Does the PME show up in the logs after you've done this?=0A=
>=0A=
> Any chance you can easily check Ubuntu 26.04.1 live media? =A0There is a=
=0A=
> 7.0 based kernel there, and I would like to know if this regressed from t=
hat.=0A=
