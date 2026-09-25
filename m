Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011024.outbound.protection.outlook.com [52.103.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DB351C20;
	Fri, 25 Sep 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329115; cv=fail; b=HrZ9USfUzX720WhQNNauz+rwFW1Zhd9aslrLU+yI8W85cf/O2/4/V6sB9pCtORwv6/dNOlwfbOWy5nLJmh0gUd9A6wQghG2mTOskS5dIKOgQ27B/9/51ePvkOADIA8b9nX8UstOazCQJKshN2niOll8dRtqFKI+gMoMozt3bn8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329115; c=relaxed/simple;
	bh=NzQKwALILJB5GOhSCxU1CNhhCcHpJnP6aP4SK08yrZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dpBALQOIv3geYSfCxazlQq0Cmz684Av8HYkMP3VJW6poLfL0vxZYw2m07Hlm1vUhagRU1SO/tpu8pEAxivb9+7B4KEXgv7vYojp1GG5VIYvhbliUlXwdSqz3mbPHYGaiyEOTGWGmZCVtt6jQPbCQjAm1zkZU+P05y4DvpLnJMLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nq3/EScn; arc=fail smtp.client-ip=52.103.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nq3/EScn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6dc0y6ys/uQq2QBApL3QBzqnqRzMXCkJDblP5BF54midS6bc8ZWR7FmJGtM2y1L4fj4ctYD0HP2MrhEA1RuLp//BR/8zXsWGDiC1GTa71n81s7woqbxL6hggAd2eJ3zaQLwP/duHp3BG0cExXh4JR6DK9w8ge/RF+U/ym5jw9fhg2WlVjSBKfol1cMdYh1BLk1Pc+X/kfW8Mm681N3H1/7uLOwDCk44rh3kiWyaechC1/2+GLWyhopxgygzDowsBwaoDUnSxtxx7rE+STpAbIefU/19IsIdT/BcFMQq7HTI5ZbwSuxdNahlrdUT3bhhSn24R3QWksKuTb7CbN/0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v+QH6pB/Q2HrKf7acyvzLNro97E2w9o3Q+pGbAOP4Q=;
 b=wUDBF0M1bQosK3RnaDSiRoqKTvXyGxfTfccq/thBOmBQGapk/WEbNOq5LUM1+P+4zuAvp4FzsOvVwrWMi6NW4PfFU2Byc4nEqiIm3iJk+tWQb+qeyCpE3gWNnpifBt2wTwT2JJNG+0KBx7b4PUkKtAZcAm+x40niYu55YRUZMQn9+bRxyv0Qc/zLoZhawsKX7jrpAsYdr0SeHUySYbesXaAdMGU6RdhyGFqUsW2/sQUyGgasETS02HLtToZEOiU+ZocNMj0vRjHDkc95Ov3v/iUDYKW29htVQV5dmuhAzWRYvWfgO4mXcDroi5Bleku0hO99Svag5JNSyhvO5qRWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v+QH6pB/Q2HrKf7acyvzLNro97E2w9o3Q+pGbAOP4Q=;
 b=nq3/EScnfB7Zm/jzEGinPpFES5BpXQsNAFPS+wWIbsXwTmDHmsA8yxfF9a7j6uUyoCVxDiE+nWLhoutC46eMfdcnCvpybVL6Y+GH2hs5oXk4RGYhzbcra5H6lkeN6YSfJYQHqH88vby+EtHxrJvkza6+Cc9mjijLvYCWePhqyysGfUrG4XO9OvN8uzsMlhkVJ1ZgwaqmdrjPiEMuZ2FuhJgv0mpvePeBn4DLNYi7f6coIdwQSU0X6mc6RF/towDDfcKIbiXngNWh8GF6VqgzsYKK7zGjoLMWe7m/UIKaBsbgzznj7gULTUDxPEOcmcHSsb9nDjQ/QZrfkfuATAh3tg==
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 (2603:1096:400:3aa::13) by TYWPR01MB9923.jpnprd01.prod.outlook.com
 (2603:1096:400:237::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:38:26 +0000
Received: from TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7]) by TYCPR01MB10927.jpnprd01.prod.outlook.com
 ([fe80::c225:1d5a:1a78:c5c7%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:38:26 +0000
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
 AQHdSDNPea4qqw1tcEOkT/edQjHT9rbYfQ8AgACtPACAAaXMFIAAN8+AgAABpQCAAPzaBYAAjxGAgAC1UD2AAYHugIAAQ8E/
Date: Fri, 25 Sep 2026 09:38:26 +0000
Message-ID:
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To: <20260925052727.GV106095@black.igk.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10927:EE_|TYWPR01MB9923:EE_
x-ms-office365-filtering-correlation-id: 728eb45b-0f2f-481e-9bba-08df1ae8c003
x-ms-exchange-slblob-mailprops:
 /UmSaZDmfYAYx1xXrBLUWTP0Nof2HmsepVFKxSrOVwW/8IIoKwe3KOyZbzscFOIk3qQRGf8RUDhcguAYdUl4/Ga0g81YssCHylEu697B/wqHcj2pOXuU8fnHAGGwfjsF9zZg1B+FaTGeYeCDK8cJ7WIRZUO2RTXMB+GE/w8S1UkLXJlym9yf8xKjYLxI8ZJJcgU/JMJjQqAZ/wddNW9kIwGnxGCJ9g+EvFLPyH31k9xf1KVSI5MqOVRCn2kj6kBqZBPEgsHa1zniQ1mu8FHiskeHa6D8liSfjQl0hEz+zvEiG7EffIT/BO+6yaCidu/J8JxaB4ydQomhEa9ROY/9VyF9ix+c0l2yk9GEAY1QauqHpIGhLoRBniu2goO8maw/+0eDxqvgOSGHGt+1EdUr2tIzpfAbCxI+d6+RZt1iJq2ufFQWOK5Wk+Q8M0opMChjMWMpUrHKZzPhjbvTq6rjMsrPs4kMzrdTw4h4BxV0xrk8UHFiNGzoj69FFsvauaV0CY6t8Cx8HKn0HbooZpEYbsqN9FLz9RRNj8PaGjdMH4T4lw4ocCUhIvnxlt+O9zK/FZBxOBInHyd2sjz8HbQlIb3a57KBMeOvtKOrd51iDcFeaxjlScIdI+U3gORb5+MoRg5J0ZL1ttBHNuutl3doHAIwFZIMDV7wWOoslgoMCIqvbKmYVbM/UvuHB1DM1mAsvwXlE2c8vhtrjMt5YqmiwvFN/AifgKFD6G/6DNqBRRRE4Kij3UP09KbFuj4rbbBIAivdMDt/P00dl557BLaQqFrwAUybjj7w/in8DlNnsvePQXbGgQ6F5n18iXmSiui6Wxo4VRrT8Sofbw+SNpUOjQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|31061999003|19110799012|41001999006|25010399006|51005399006|8062599012|8060799015|15080799012|260826193500599007|15030799006|24021099003|102099032|26104999009|440099028|4302099013|3412199025|1602099012|40105399003|18061999006|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JxVsC+dX2n1fD8aowWdglrCtm6dBCtD8uDjZrvV3DmlrHUbD3dykVXA3bC?=
 =?iso-8859-1?Q?ray2GpOUfiJY09BdPhid9IbJd1VYySW1NDZmcqvTniAxGmLJa0OR8LLmaF?=
 =?iso-8859-1?Q?XgycjC9BYW4U1QCxPULH0qg8eNWpa+I+jOLvwYS7sSThkxfPHiTyV13ZcH?=
 =?iso-8859-1?Q?z3pCpqG+UBDp0FFRI805RLwIpn6eHrQGtOCIcM3f14GPdjThyIYnvHJ8to?=
 =?iso-8859-1?Q?tyWLjyfKhdFjng9IhqNoVQ5BTmt8rul4zLywCwPKeS5TwSLwvgWLYk79SS?=
 =?iso-8859-1?Q?8n/Ez1du5LAHVI08t6Y32UY/41XGe9qWyv1cYiRO3oQayavmT0T2zMlTXk?=
 =?iso-8859-1?Q?CEVPYwaDhp/u2BiytDL9yNHvai1/xi+lTm9KIJdjw0QCSpIBB9qHpYEzRD?=
 =?iso-8859-1?Q?/mAc23xezrhRhicOin+nFjvX+nmdgSO3AhUsIM/Cjtu1ookE5QJAwTRXso?=
 =?iso-8859-1?Q?NrzbSIC0yr90E6XOH+l88LfsLkBAWtsm5Lb8zcf0QoNTJRp7mY8e+VtngF?=
 =?iso-8859-1?Q?Mr8C7M+UQpYULaafTArWKA9wk+EJRZIWB+wk4qnVkiFaDzVzVYQwNEWuqI?=
 =?iso-8859-1?Q?hMSQdSHo1pfL8d/k+CLjELpW3e3YWeW2JJgdWJywWx+/Z52oDcDt2f0D9q?=
 =?iso-8859-1?Q?0cIZXjHPbpzKvA1zGN4x3C1Zs5K/6wDXxxnxmcmBFHbVZpXg434k0kVilv?=
 =?iso-8859-1?Q?KMSx2Y7yeze0Y8Yc3ViCDwVGNkakwfNzsD7JJp9NZXQNnWqc4/PtVvnXs1?=
 =?iso-8859-1?Q?o72oJPUFYhj5J+txkJOm8MGrBkIk1gwsKIRng8VLqyJowM+2Ar4HM+TFb/?=
 =?iso-8859-1?Q?RWwG5oC1tbGJ5YU0mEtx+Eiy63N9V1FerWvgVSf4UN0JTWqElfkDcBg+bf?=
 =?iso-8859-1?Q?uaiuxdiJau0X8mwMJROgjQpBqtoeig3+nXHjwJtPVVZ0cZi4jlFdlL+cA7?=
 =?iso-8859-1?Q?icIcL+UGhxNc+nlPHSQUSEF5Be5cGSA8lWPXX7mQzzH8WNCL+V3MeacweN?=
 =?iso-8859-1?Q?zZhkDEACNm89HvlnNGT/+OVkkE0JaNrmWWM5WrC4HUjMFMTtyU7scYfazP?=
 =?iso-8859-1?Q?UJaP5kPRZWTI8WbxtslOJNNzGKT5AwH00NehU1/eftRbLA6AHByG79nXHA?=
 =?iso-8859-1?Q?W8PB+GEQDzG9A2Lmh+Gwp5HTTUNGh3XnkGl6CixtsEmZJAvO3FI2r32JyV?=
 =?iso-8859-1?Q?ck2iOm54ulNd6r0TD7SnoItMowwBBccG0/n22LRedyFOOkfgQEs9oLU5da?=
 =?iso-8859-1?Q?TV1cOuomhjM8JB6XQZvQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DUJKDKXPvCQRzo2vGoQsCRxB+56VFHxJY9x2uMiysyPLkxJ78e7bTGysYa?=
 =?iso-8859-1?Q?+fDFXaX383Jqum8jszCwwVy8jPsBlk9N851t8Lapa14s+8KoHEGv0Z1xs+?=
 =?iso-8859-1?Q?ZiSK5QX57Syede/b4qJBu8f9O6KiNrvV2mSGqSnKj9r2u5PmCRkygTqLOa?=
 =?iso-8859-1?Q?C+4jZecLULNgKr1ZMxh1sVvKguMGu8Drpx9a+JG4F68QrL01aMjBlXtD9W?=
 =?iso-8859-1?Q?fECVs5b8YVbrnMT8ekD0zCCf/NUrbMXx0AAh2Req853gCuDQmplO9v7AJ0?=
 =?iso-8859-1?Q?nfMPl01RsuMQBFzJuD/439Sao0sQQvO7kNXgLTebB0pBRUjTGyCJhKIMRN?=
 =?iso-8859-1?Q?9efiKBcZWf4MQHhgs8duvO5LDPpIUlyf5/RP8Qv/dIX/UG7Hep06z02fqP?=
 =?iso-8859-1?Q?/2a2kxh6t8Vqi/LJ9piA//SbF8OjRmoACUSYVV/lxaP7azfJOsgAvfkPHl?=
 =?iso-8859-1?Q?vborZMAptbPcvXCCaxy5dcuwetTV7aynuob5vBRbzUzTNZXpi7//8iffxr?=
 =?iso-8859-1?Q?SojB3CVO0KAqV5TzR4adFss0Do5kR5WTtawEhDDnxyXNzov/1ClY0pd3BA?=
 =?iso-8859-1?Q?CaeuwxP2v9Tnd2lozQ/cH+B1WmHKmEXI1IIRs3RqoARgjFfKCTlhG5lPRh?=
 =?iso-8859-1?Q?uTdhtDw71cDfdY7vFWcBbx2Yoat6KjNHeyhCDJ/QlTpdJWOJXYSqSh36Y4?=
 =?iso-8859-1?Q?feVeBhjkfNeD1hyCHSMU1Mn2MujKlfwUqRDoPAHf2+wHlwMsiDyGJ0p+Xw?=
 =?iso-8859-1?Q?xCsefiTbg8AxJPpIjb87s2uyfBz/dptbZ7OvRXAWDXFiyUvEmQiq/SpYeW?=
 =?iso-8859-1?Q?mWbR/bpE4oZfnqPDUPMHcdLr+jMKRtU3sb9hdf0VvZaRLpwGa4dvc/w+dI?=
 =?iso-8859-1?Q?SbtyrrpEKO70zF96tuQNhVVubBGC9HI1C18626W43ETAJmDsgTW0AP5x6x?=
 =?iso-8859-1?Q?16qQpIyIVSZ0Eac6mjTap5h2aF/yO7ExTrxwGdV59WWmXyLa7qd6UuutlL?=
 =?iso-8859-1?Q?2gDw4xp3cimfnB2asyNZnLYGEUlVwhzI2BoUXQn3SHirLHlV2eZ7+TWI5v?=
 =?iso-8859-1?Q?sihPoDshX1aUEh1bDhg5Yj400Efnf4InO2WUP7rvYCdfZRVIWuGIeRBG7u?=
 =?iso-8859-1?Q?jFbELPrzaqoIVgui4dxT8QWUuJMUgqFBsxZgb/q2uzh51kZ329b+Jmce4o?=
 =?iso-8859-1?Q?cD3C3AQ+5VJk9utgAbDWbjRxqsZmD4svDpT96ZYrZihrb7MrDl/yTQ0BST?=
 =?iso-8859-1?Q?UDNyfLrw6qNc45VBMKV5vz/eRGjDkKAtqGJs3/lWvZ1LLc/2nZq5xaAb7l?=
 =?iso-8859-1?Q?MJWDUNNlvn70eP/jvYMY4ayja7Tw0jM6ZjJmmwW1K5emke7vqZUJ4VN6f9?=
 =?iso-8859-1?Q?doO5fJkKXcInEa77GW9qfDxM5UTsx3UBxfZRTEUcMOQWIUI3KPfno=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 728eb45b-0f2f-481e-9bba-08df1ae8c003
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 09:38:26.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9923

Hi Mika, Alex and Mario,=0A=
=0A=
I tested both requested points from Linus' mainline tree using the same=0A=
reproduction procedure.=0A=
=0A=
v7.3.0-rc4: bad=0A=
v7.0.0:     bad=0A=
=0A=
For both tests, the dock was disconnected at boot. I hot-plugged=0A=
the dock without running lspci after boot.=0A=
=0A=
In both cases, after hotplug:=0A=
=0A=
    0000:00:04.1 remained suspended / D3cold=0A=
    0000:6b:00.6 resumed to active / D0=0A=
    0000:09:00.0 was missing=0A=
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
=0A=
