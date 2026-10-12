Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A8488D92;
	Mon, 12 Oct 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837617; cv=fail; b=mUWcOov2b+JLC95ZvTZouBg45KQTWibbsKHPf3XLQHSXgs14VUVIw+J94pq1svOumtVJigN4552ZmyAtlWfVLXh3awck/ysPmMuJtm9OnpdXoLPE5E/1gvF3c/Fg8YgitFKJv1kIrnkv7rkXIrJtx1mMHbe/xQSWBDy/R3cmph8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837617; c=relaxed/simple;
	bh=7B0k2XZVTScuNyGGutqzCYRiPL74ltbcAhkkmyIEGZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oy4J2lk74D6AZfU1Xw28yRvvejWjfKrtSO6FbbBiC1MYRCupCNcQ+RSzY0N73Xv1hEqw1DIJr7UrhNfKbYT/r7cFWFRZ+usrLdtZRYjxOAzKJj7GKjFtMREUaZi6krOrMzUzR5YhOzFF+ngkBLp0BYxZAHvS8ty0QGa2aL8N/XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Up9ZD/Fk; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Up9ZD/Fk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVftDs1tbAU1AQDln+byc4K70ujG/EAHbFpFUKdcZZa+Wy1P6CBOA1XMyhfy4Tnaql3xiL1IHWZEF551+VK+Uz6oaqJeSBXZ88ogY18unC64GoZluifSCgS8bN4wnnHIao99lj9t8SdkGLcaF8VxeesTWE179rzAL8P5tg99BoYF1IA/uO6UR+fFnEXQjOUcTAgxJDa5aScRamnCiOA5S4yQ1pu/QP5pvGqDYFAQ0ops+5jNMS/PdGo0YUPDBYtiK3x6TlCaRjiu56yeIs1C+RjeLIu4dGQCQfLRGxBLiYQp+4i/9aG5S48hfdrkfJiaYgRm4YQSKjwDmHMyVnYrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QGAWEhDfRTcZXiDexYuSr5CAXG6YqmikhwYTn1vSVM=;
 b=JMCUbcr35kqElrsPwWXGmU7j2pWa9/GxhhUNwx0HqcGDsdRTpdFMuCxMuHV1nXjZnD7mPmYyt8tsy/zsZ83IA+UX6nQRkbsW7cHw2nSdrEAWEwSe0tBvLRUWLWoVzvUMs7PjMXPD9OxQLFYfi87d9qRITAwCj8W7cFk/+jIS8+bLWfyMbyx7dOSUyHPa3uZjxd/S13X4vljUGUD/fhNNijMtpQ7HvQfaCCiFpV/kv502nEcnKQfWhA2dc6LlXgzOIfP8r3j+PS2rcsZz2SNQDwZZCRT9o4ZpF1Wz8MK5TLN6P123DJs4K6ihzXtMBfEowl3JJ743ZX9raxlUFHEf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QGAWEhDfRTcZXiDexYuSr5CAXG6YqmikhwYTn1vSVM=;
 b=Up9ZD/FkpSq4HcJNisvTywkok2chj7Y4fYuXhPdeBOBGtFRfZ+Bn9kemqE1rT4pVXpyyTl6S5AbiP2rm17vhdTPYw7h0JccMUpf+CZQ2kzvlMzgRbVyJE67oAQEaTMhrBVSF+xs55gl+mjAM+IvFYwLLy7mRc5EJY6xL9ewUbH8=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 20:40:11 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 20:40:11 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kCAAAk1QIAAFJeAgAQrt/CAAASwgIAACANQgAAXXACAAFxcoIAAZMiAgARVHwA=
Date: Mon, 12 Oct 2026 20:40:11 +0000
Message-ID:
 <DS7PR12MB9550F5271178DA32819F9BF99C9F2@DS7PR12MB9550.namprd12.prod.outlook.com>
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
 <DS7PR12MB9550BB636770CB3984E5DA999C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109277E30BB08C87B1E3021CB96912@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB109277E30BB08C87B1E3021CB96912@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|LV8PR12MB9359:EE_
x-ms-office365-filtering-correlation-id: 2aef0517-d073-47fc-d0a9-08df28a102fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|18002099003|10067099003|260925021311599003|56012099006|260925021911599003|5023799004|260925022911599003|4143699003|6133799003|11063799006|22082099003|3023799007|38070700021|261009223027099003;
x-microsoft-antispam-message-info:
 IWM3q1H7yuzzqw28XEl0v6NYes064GTUff5HIpKhskRalM4hpq4hXjdbGeTW8I30Sp7dP0C5yRcwJLM6MpUgFMbtz4TxMBlDJq7YBNIFAf2MBxP6FEL38H6AXQPRvXPq1E0THmHf0yUrgyp2nLnQ8TKewTQUuRS9Q4lnIGVg8dVcMloeHZE6KroeU3oIq4f4/tFsDZwfYYoeKTy35c2veYjUSMycFyo4WWpqUzcTHk2xAdF9QB+IFEDlsdA8mxgdTZZZ9l3OSdvtZ6oNIyzAO4U5doRGz/VRlGZl9hC1ugLEWGPsN/s4OGXe53L+smwkLw0bEAGujvqqokS0ExsKDz0eg1Zxp1Jw7oJnyiizW9PR0IoXG3ga0uo8I8onXRYmYxplfp+d2csoisWuj4Sk+qXpMoEbHssg59oBrmFJ0ZikZR5HXjz33ftpxLoafLSwbAMKcMZUaKWzOP6EyBxstYks2oYbi2AbtjaW073JQCw7huOAGvEGnDJ+WqC5MqQsgn1hsuv/eq2GMAWe1PhRoYgKlGT6dfaoQUccU58X0hy7jK2rAm9h7+mjbBIMepLb+FW9EzWlXDSNkN+nW7Hv15s3OKKt1/k5zWnlDiTDG7H86D8v6WaUtaKGATu6GF2vs9jjPO0AidLzY1I9t6bEo5RmCwk+wJy9SuUhD5bxeaOZ5oo6zHIx3dyFC0g9H/TXq5QZojyz8iw9kdWgsW6lfV6kqKkShjfaGZ1AUpJYMJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(10067099003)(260925021311599003)(56012099006)(260925021911599003)(5023799004)(260925022911599003)(4143699003)(6133799003)(11063799006)(22082099003)(3023799007)(38070700021)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?V09ORlJVbUxTQWljQ1A1SkQ5WHUycE5GSHdqMEdDaUhoSWJ0YlRLSFJV?=
 =?iso-2022-jp?B?VzJZR2duaXZEbmlyQ3ZDdExwVCszZHNJbnRJczdqSDRFcEV0ZFduVmVp?=
 =?iso-2022-jp?B?Q05Ba1BvZjhDR1JtaVd1Mjd3Q3phOFBlUUlHalZ4cEJHeVBXcElvdFRt?=
 =?iso-2022-jp?B?RE94emtrcjdzdXZJRWpHZWFYYmc5K2VDbVgxUnRNWVJ4c0tsM3lMdVdR?=
 =?iso-2022-jp?B?S2laU09ma3orMGVZSjBIeE5rMTY3ZDQ2WmRFRCtlTDdZYWpEWnpJSDFB?=
 =?iso-2022-jp?B?MW1ORERYN2wzMW5qUUJrL3RzNVc2Y3E0WGF3TXVIbDJxVGt4UGZ4YnRT?=
 =?iso-2022-jp?B?d0p3c0hxOHVWOWRDMGdZYkRZYUxYZjhFTy9iUjYvaThtRFFiK1A3NE93?=
 =?iso-2022-jp?B?eCtKbCtSRzUzVHRqdGdacTNsaGpzalJxM3JQaXBHdFhRYXFBWHRyVkN5?=
 =?iso-2022-jp?B?T2g3QTE4aUYvRGZsNnp6elljUDd2L1A2dklJYnBtdjU5d3o1MHV5ejJE?=
 =?iso-2022-jp?B?RXV5d29GMzBKNEhQeGxxRWhNRDcrekoxNzhieGFya1hzVXRQeHF3di9U?=
 =?iso-2022-jp?B?SHNuZElqR0ZMbFdGYXNHYmNoeW5WVzBCNng4QzhKV3AvM09mV0NPcVhX?=
 =?iso-2022-jp?B?R2hLNFJnR0dZM3pnb3FzOWlMTDR6VHhXNE8zaEp3Y0xyZ09iS3hzYUFs?=
 =?iso-2022-jp?B?OHdBUFgxUGJ0enI3bWtUM05kVjdoZlZabVFBK0NNdERWUDRXd01zcG1F?=
 =?iso-2022-jp?B?elA1cjNGdWZveURPdEd4M1AyVVFHVGhoK1JjK25pMTJ4cnVUcTA3cFFI?=
 =?iso-2022-jp?B?Z1RHRlhXajdJWEZqSWI0U00xWWNXblMxUHhMUzk4K1dnYjdsVTRTSVlT?=
 =?iso-2022-jp?B?Ym84bDdqNDZidnBCdVdLOW5NVzlHYW1GVTdtWTdNdGFFWFhTY0prU2Fr?=
 =?iso-2022-jp?B?bHNDVkdCWThteHhTWVdZdGg3VW9wWFM0ZmpFaFJSdVVxZlBJVHlVNHV0?=
 =?iso-2022-jp?B?c3gzOUFCOEQ1YzdiemZuMWFSRnlvZWdrVytmS0FJK2xyRjEzSk11cHJo?=
 =?iso-2022-jp?B?ZThQSjhTYXZ2N3o3L25IaW1GNk12QXhJbTBMVmVWbUpVZ2JsRms4ZWhK?=
 =?iso-2022-jp?B?eldPYkpyNW1Va2xXc3N6ZGpBUXRsWlBKTmdhR3p0bzExdVlucVFQQlFu?=
 =?iso-2022-jp?B?d25GQVArUTVxOGxTWWtwLzgrQlA5ZlBJL3ArL2k2N1BGYW1lT2ViS2Rv?=
 =?iso-2022-jp?B?a0hWcVU4N3hpd0FVN2tuZDRmUG16Znh2MkZXTU5OR3lKQjBKbjhNSHNj?=
 =?iso-2022-jp?B?QkRkSjI2c002dDQ1L0E5UE42ajdydVFnS2pFWmZiQU5DZGJiZGlzb2t6?=
 =?iso-2022-jp?B?M2JDSzNtTjJUSC91NHVYbE83UFg1VUUvdmw5dUlWSU1YVitjVmY3SWwv?=
 =?iso-2022-jp?B?U1c1UmRoTEptQ3c4ZjkvTDNmajNnZmxLeWxQK1R0b2ordUV1a0ZQWTBT?=
 =?iso-2022-jp?B?TEJaaTgxZTJxY1hQTUJwak9Tc1hTS05OaVA4ckp5WE9kTUlmMWZVeXhF?=
 =?iso-2022-jp?B?K3BiSUVCMCtoY2U3VEFNVENuTDBKdU5QK3k3dHgrM1hyS0J2UVVRNGJU?=
 =?iso-2022-jp?B?SjFudEQ0cmxPSTlLNmdEUkI2bkUvaUoreG5lY25mVU5nWVhpRG1tbURH?=
 =?iso-2022-jp?B?T2xCWWM0N0p1SmdxY3gxZlhCelpvWFRGbDFXZkJoTHRvM2Jzc2pSbVNz?=
 =?iso-2022-jp?B?RS8wamdRMStaSEtobm4wK1NIZXFEdnpsNGtxeUhPaUxzNTFWSEVDeXFG?=
 =?iso-2022-jp?B?R0tEV0NxdkxRT0FtUTBUY3BKdi9IWXNLcTNKNzQ1SWRwSGdxL1BPdHFZ?=
 =?iso-2022-jp?B?ODR4Nml5TTk5VkZ1bVozZFlDMHovNHV4M1hTUkVGaWVpekNLSXUyNnRn?=
 =?iso-2022-jp?B?ai9IVTdnSFlpc3FaWTdLSjd3TVpOZEQzb1NlS2NEZFNWaG1vdDV1UTBw?=
 =?iso-2022-jp?B?alRWMUs3ajl6Zi9RbWFZclh4bFdYR011RUFBTFdudVRoUkRmUE5QQjdi?=
 =?iso-2022-jp?B?MFZVVlc5WFdWOUlmTTNzSjFpWHRQaFRkeWdtOVB2Y240anRTMERLS1M5?=
 =?iso-2022-jp?B?U08vMkpsQUN2eUtLNTc3UmtORkpYOGdCNkJGNWxLZFJVUm1INlZmN1py?=
 =?iso-2022-jp?B?WXVnQ00vV3lub1JqQUZncWxvNFEvTkx2dm9oYVlRRjRuelJQcWxHVERx?=
 =?iso-2022-jp?B?aVMzbklvK3VyelVpcUxhT0djQmNUSUJ4bTJldUhIZVBQbVVKa0pJdWJo?=
 =?iso-2022-jp?B?NmluVHZINy9MWlM4Y1QydWx2c0xwTWtCVTJvY0J1WWpXVFZmMXlrYk13?=
 =?iso-2022-jp?B?K1pRcU5YVHpPejFxcG43L1ZlaG5YMllKanhXbm9makJVZG0yTEh6YlJl?=
 =?iso-2022-jp?B?RUM0SUs3Y2UxTlZ0TGZwamR6VVF0VTJoNG1OOERESHBPTzNnZGYxWmRm?=
 =?iso-2022-jp?B?ZVdwQ1F2?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aef0517-d073-47fc-d0a9-08df28a102fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 20:40:11.4785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+IHxGHDCWnCx88h8HI5tqt0EkOa2TJbetaF8siXfCqH0SoKRbjWXex+fOpHBf5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

AMD General

Freeman,
We are working on an ACPI override It will be quite similar to the one need=
ed for my test system to prevent the toggling issue (I have already tested =
this and it appears to work). As I said, I have a kernel hack in so I can m=
ove forward with this.
Can I get the output of the following:

  ls -l /boot/EFI/Linux/ 2>/dev/null        # has *.efi here  =1B$B"*=1B(B =
UKI (initrd is baked into a signed image)
  ls -l /boot/loader/entries/ 2>/dev/null   # has *.conf here =1B$B"*=1B(B =
classic vmlinuz+initrd

  And the two prerequisites regardless of which branch:

  zgrep -i ACPI_TABLE_UPGRADE /proc/config.gz 2>/dev/null || grep -i ACPI_T=
ABLE_UPGRADE /boot/config-$(uname -r)
  bootctl status 2>/dev/null | sed -n '1,12p'


Thank you

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, October 9, 2026 9:26 PM
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

Here are the logs from the rerun tests.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Saturday, October 10, 2026 4:28
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
