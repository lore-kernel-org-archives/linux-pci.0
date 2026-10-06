Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB801380FF7;
	Tue,  6 Oct 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316430; cv=fail; b=QLV6xmXXvd1L2NcGOGw3k80L0ALO1yxulVRPuy32MQkK89jdtgGX4edws6f5kL6cYv+TWPz7NnvCcnLs6vUe6+XE3KBNpB9SuBB/h49Ds9DLOSOwBjzLUEWXO0kfvV9wle/vULp+/r6WhPy4hgEO7OXHCjqrIVEu+nTNgFrJr7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316430; c=relaxed/simple;
	bh=1LY5zM/Q1RsaIAjYPihbawxcevv1lR59F+Q3pTEchAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEnu3xXzND78Snvvt1XZ6CuPhmRJBofmt9PQfN/GvnOqNeLsjMCgp5fSfdNXtTk1ismpBNrBZz21C0e4Z5uPitWzQkUkdK7G62XiogLGfbeDiWnfbkYc8Qa5rOdgUBIVftH6kWwI9XlRVQLs2zRNblfg9v/WuOlcdaC2eDrbuF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKjpBm/u; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKjpBm/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1CPrHk9cdhTF5Fp4obQPensTlo9NTl+edco847Yg8mVQzRKZs6dAlDPaTUZiqj2K0VLXBCYWw42sym2JDhSvzbQtXoZF9kfBTopmtxJL+s2edOwjTU6Rzl4/fv9Z0+hAvJFJWc4IOlj/yFoN8MtMTdny5HA808pPwuoKSs3w35UAOv3zngNkmVVsrS8i+sesWdjvs0oUlNzJ+7USfAAKWPUbUglqC1n+AHyrcuaQcn2hWFnEIHAVxoO3Y0FEnioyND5r1uPt2K5vUj0MRLEXGrn26El7BP61Si8YnIjqumf+QVc1HM3lzRox2TTxzCIg5xvUXeTefIwVVVKnQxd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW9dwF0ZFGB0JPpEbgA9aHTI5BOCcv0u1trf2QfVTEc=;
 b=TlYDNsQS5knsioM61+aFlebj0RTlJ+0FAF7NQQ91rqIsiuSTo+PCbM4UDb7xrVDau8XGG8KCcf3EfU5DQwwjU6yaWVTI3A2vNxw6VxaZfR8oGLO8y9NjDyPve2BaSGtpe547qQdtKdk+CLL+PwmsZJcpcw9vDVQ8BaLAp0jSqZDZRzyCGtUHQQbz7Etr6csCkHH8SGL882akgJVBl/8z89zQ0ckOWxYudPUvP+GVlXi2Smcg7iVWBytuWnNHOapnQ5t01Umbpv6f/zFPO9DcDOmj60GL32C59zc3u+wN6ezU1q9e4b7AKmswWUD/OYWpakOXhDBfX0+XAk5//juklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW9dwF0ZFGB0JPpEbgA9aHTI5BOCcv0u1trf2QfVTEc=;
 b=zKjpBm/uBGnxk/W4UBo3amyHCOHB+zGvRdtYDiBZqCxh5kYUyc8pRMXYZ7rT99You8e76Z1BjIa5DxBvHvPHsOBPrPbgJ2QaGg6Y9d1LFKCc8NyVFAbLb8CLYyrrtXMeYIsKABhdnCBBjaG0WGXSG/btAtxbLoD3Ysy4/P36wYU=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 19:53:44 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 19:53:44 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kCAAAk1QA==
Date: Tue, 6 Oct 2026 19:53:43 +0000
Message-ID:
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
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
In-Reply-To:
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|PH0PR12MB7471:EE_
x-ms-office365-filtering-correlation-id: 3f97edf8-6b52-424f-5651-08df23e38701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|4143699003|5023799004|11063799006|3023799007|260925021911599003|10067099003|56012099006|260925021311599003|260925022911599003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 5O5BiacVklNxQk6l/i8mKc7dr43BLl4XsBWnsUjwTwIL4Gle4UrVLrHqPz6ZYsDSBzqrzXIkIizh0A4OKQnHb/JqyGQFcIqQPfaNXw2pXa5zUcr02+38RbRHPEl77MLMCMHp8GKPpg5635I/PVIO7mSpvdZ6xP7s2118o90nqXJ+1McPenQqpCZwuEdwitklGGRJ/65uhhe7aRg56qeg75YzllwFRu6f22qCinmdNeMBHwyfjmzP2IIYj1isQlgL0gVoBfwksDb63XFjf6ugx2gKG5u96nLgy7vWMKjKosxP6fssitl1yiCxJfzw9eEVRRsVrhruvqhx0Z8zRrBGu9VcifVdSIqvgIUkApah7GOj7KG2PkqB3VJ4oJn9oRlBySJTPcGMwbFQkWdm+DbhRFa35jh3Mi2dYv5B7t076oYQBwai+F0OtGwUPJo7tIqABIlrtrNSHXUEvAK+5yKWJVoSSuDhrIVEMA/EqYn8FtqHBTsLYhfpvSYWAXgLjzBcZxIBEpOOSgI2qEp3fvRL75sr0al1PPh9TpbiYLLHbWR84oyqsFJh0Lcmmg2IxiUepD2FcDZQZlWwNCiV2/b2sB0Ym22cerQpi96E2ukj+/DjuwwbHI1Pj6hK24RVanbmP+KWsQfxzkGDGVAzZlAv9GABnu9UAtne4Pb7I8PPfJ5dPxHExzMLZ+jAoh687ci4ewhdxol5bgaEQf/EDI8YRwRs2K0DLgZ1spzM/YypoYs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(4143699003)(5023799004)(11063799006)(3023799007)(260925021911599003)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aV320ICu+J/TeQTheDO07Iccr8VpgmRG0Ydo0Qi7lfaWmS+eLrAWt2db61/w?=
 =?us-ascii?Q?yTWdLyBUwz1jitpPF4nUjK2cz/zZ+q31ZeSeF6xKuKm5hHOxaojjyaNAzbgp?=
 =?us-ascii?Q?rtIHF1qgehTvYi0WBaRampR92WiuP7mvRw4dnlWggl/R0aQFLSvoup/3UFSl?=
 =?us-ascii?Q?le5ZGFfFa8WmP252x1ZLaUvFyTq9LfNjeap4Nc5p0H+MLKgpCtfaD7j4cmkq?=
 =?us-ascii?Q?AP5Lo78vPBjJKlbwOYT6dyljODODIbiorzYcLeR52/24LuXsIrTOYeeEE9D8?=
 =?us-ascii?Q?WgTpeNnjS6OeWlGhedXV+T/r8d8b9MHsB+zvJre7oosV6Htz4nyTs41fdiaS?=
 =?us-ascii?Q?h/ttphPwJqt5DzL7YOnOULapaaWZXSwMgWCayiQ2TqIBjDvTXD1l79CqkF1V?=
 =?us-ascii?Q?JJareKjkMnegyCom6ekzXZ4/aLUvgaLOZHjXMfG8Hf8PAtHDL5pMMEQMFGAK?=
 =?us-ascii?Q?TB7ca3GVxL14ypfhkV4S5hQ9qPJg94nXLghhO8K5V1TWBZZ+XifX6pwaNEFF?=
 =?us-ascii?Q?9F2R8JPQStVUywRajmiM+pTkxWPoVrBCGWfgilvFDi99v0Yft+tHP30MxZ9l?=
 =?us-ascii?Q?CESlTgnvvsGo92BjM9/NQKxLc4IOFxjTj7nAxIuCMCDwE6wokJ/GlxPa1I0h?=
 =?us-ascii?Q?u1NXqLq03I8O7rW+HqaiVkLFVDof318/eeWiS6/ldrj2xb5DK3X/p8Rdtzk4?=
 =?us-ascii?Q?42315oLAA5LoOMfefHN5yH12YUkIBBbg0bjjUKPsvd4hl/EEgl4PfpCMxIB/?=
 =?us-ascii?Q?8GZIaJN/JL161s785VKTztrfls+tvGXBm0o/x23Hobqv41iCOeoBNd29yKzZ?=
 =?us-ascii?Q?flT7uC4sPK+0lKQO0IbiYn9waXYDtpn+Et3Mz2Au/oW5euJ89/e45pZlK/SS?=
 =?us-ascii?Q?Zcqa8NiUGKj3f73YQ2mHdaRoPLzJyPKIc3ZZ1OtW9CIJHRePshGCmKC3NJM7?=
 =?us-ascii?Q?6QdrJpM2nvOQXwhB8SdK/Bl3j6h1kuH/UxOLUgZacGK8WhjAUOqAThA4vtAq?=
 =?us-ascii?Q?lCUAVixX1Qb6ob8fRDXyiYykH4t/S3cioMjkqjUQuHuybHnoxjMiMztewKV9?=
 =?us-ascii?Q?t+msH7DOyLgNwCbIviwcXTIQHerFkjlLEPqE7WneHg8LUfa6tj7FeIUjdpT1?=
 =?us-ascii?Q?9f19q3serj84dyHIFOcoCbELLryaJyU/s2Vw13sIjjl92IwFpEvnRJciwzH4?=
 =?us-ascii?Q?vFBstoLcLj54+ABlsz/9iaX5x5g1BFHNfU6BjmzJAW2rs0oc1Xyr6kLrz8RC?=
 =?us-ascii?Q?ynEWJR+LdkvI7QCk3+EFBOivdpChakCXoQiOcGFmfLiVmEm3UTJo0lKbv46V?=
 =?us-ascii?Q?7anYVWbELaUHdwT8EdJgJ5dDTxJAi+YKT94UL00k0mg+trpEz4E59obabdfc?=
 =?us-ascii?Q?y2E9pputb7WQuYl/Xjb5kQ5tFI/YDLXt2VrvVaUE9vHoIpn7WvJmYmH3FRSO?=
 =?us-ascii?Q?vETVW8n8vRCrk1i+YpGYdFdITJ+djEywZ4i7Hl9hlUFJxSk+1Plupyxd+jmk?=
 =?us-ascii?Q?zUITghL+imviDUmuQp+4hTkzwU5OAyYJOOOtDeKzgccFgvoocj8/Cxd8fEiF?=
 =?us-ascii?Q?Lw5ZTSVizLDrRQ5eIiihdIH2MjOqlYby8qKluWk9YzmoRSyud7X1EUVOQYk9?=
 =?us-ascii?Q?urBiOwbeWa7ohOCvy6eVH6uDjG/usrbcSyWgt4RBWC0xZkQgBFOpExssitQp?=
 =?us-ascii?Q?RGyBQKuA3Awkdhka8sMdcVNZmc7HW3UH1NUDoa2GShmaMY2y?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f97edf8-6b52-424f-5651-08df23e38701
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 19:53:43.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PGgmSwtxVcy15f3xaKG7P4vp+g1X1PwUm4pusNgHHWmWjvZ5XcUUPJzmRJRBUOa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471

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
