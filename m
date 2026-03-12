Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023100.outbound.protection.outlook.com [40.107.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D6B672;
	Thu, 12 Mar 2026 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273738; cv=fail; b=X2kF9LkcRDqG+xXAxnu8ahOMjbdAf/X0uF8yqu47KPA9ubpIvoE1XMdN7sQUbtRtMbeJTswKPR5kRn69DFiSsfYNxdvWOt5Ecl7nrbGeJaxqgCg0JjuGFW3HL/dGVCjuXLDW/+Yo9Im4BB8KUqM1fz2FGxP5MfBfkxhzpr9oWAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273738; c=relaxed/simple;
	bh=CUWgu1qzhuFI3Gi4IkSHbIzHU9ia1Yjde2pZLK09EJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KKWnBZGvirr5+bGBRr3l4MKOqFx7m/I8/BACCX5Ha631aSBh+FYJQpRHpjVUz+wPKMvYpleLSXLa7Kpdbr2wxRjLQycAAO+qcdvAlQU6R4/K6E9FcVRDUl+ejUr6Qj/+gEmQT1R2sxxC+VCln/Xg0ZasiasdyBrsDSEL0Mg9W9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com; spf=pass smtp.mailfrom=asteralabs.com; dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b=a14f+PtS; arc=fail smtp.client-ip=40.107.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asteralabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asteralabs.com header.i=@asteralabs.com header.b="a14f+PtS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaTMZrjFxRjPmrwrft630vFhhEpzEUw+mLmbQg1n22ehWlqLvhmRWVprQalGeiyM6LmM+2zO0VHqZmiUSQL0HfKZKO4X7zm7/9bjOclTUkC1RDBeX5uP1QzERvTFlEeqHD/CwWwtqFY5BkwS9Twc2VZZJN8nsplzEIoiDSN/5Va9SV/jn5qTgq+g1seYzCKvFLQX1vZMlCn8eQ4od4nn4MVPb1qGb0UqEhw8AgNAo+epbTRErzPLrduweFM3lI5og+uyvyz/2Frc6WYzwrcmCgUsQOd3Gi0Vk/EAWAXN4a/249j3IIGD5YUrsaupJMcDM3cDwGl1W0BlRI8EWDLu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUWgu1qzhuFI3Gi4IkSHbIzHU9ia1Yjde2pZLK09EJY=;
 b=KBSFqsckIzHSDxfViGiEF8gpsu1/+g05xFN9/MgwtUvm5oOdO0561PDAfsZF7aktZZbPigvK+eYEYqy5q4eFcY3wpSXViieiWAcgJjr6QqWcAOsmJo2WWPFuEXGuGcX0D7+lqxnpYBqS8RuxfGELIvBrMX98+yYS7EVKMWs7/+Wn4lJPA7cTpH20gPa6FgkRE1dwMdwx5+kJYPIwFiFv0UlrxbNBQ5TJJiCDy2zxN15IpBgrI6877Ryuf/g2xtfZa3yTIPPKRoEjrH9VUJ9DgMMRPm/aZWRkBtfeGL3q1WB1uqZarQ4fcNbGVHUkcWlBcsZ4UR42lczsOvecJcOf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asteralabs.com; dmarc=pass action=none
 header.from=asteralabs.com; dkim=pass header.d=asteralabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asteralabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUWgu1qzhuFI3Gi4IkSHbIzHU9ia1Yjde2pZLK09EJY=;
 b=a14f+PtSTXh0UFVzypXMI6TjCO/tobmjFX1TlbNymhT9ULUAwhWl3OvZar9DsjkBA2v4orQ3EfIM3oaxfGPx6rdeoC2gAT1VLiKM2/YjXsIzRLfZyXyzHtL+GdB5LEFckuVhRNHduAlYPDrQhsAc37ynfky7hijWhIaZwfn1Eqg=
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:232::17)
 by CO6P221MB0709.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:140::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 00:02:14 +0000
Received: from LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb]) by LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
 ([fe80::b063:29f1:a2f5:e3fb%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 00:02:14 +0000
From: Shawn Jin <shawn.jin@asteralabs.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Topic: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
Thread-Index: AQHcsZ3eHE22fwsOREepAuj/YABaYbWp99mAgAALDvg=
Date: Thu, 12 Mar 2026 00:02:14 +0000
Message-ID:
 <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
References:
 <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <20260311231943.GA1086074@bhelgaas>
In-Reply-To: <20260311231943.GA1086074@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Enabled=True;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SiteId=f47c88fd-08a9-4016-b488-3f361c03ff2e;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_SetDate=2026-03-12T00:02:13.568Z;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Name=Internal;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_ContentBits=1;MSIP_Label_864d6687-5155-4a0e-a628-49dd428607fb_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asteralabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P221MB1472:EE_|CO6P221MB0709:EE_
x-ms-office365-filtering-correlation-id: 21471100-bd28-4837-fc11-08de7fca9deb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|55112099003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 RsOkuKOaa0kquTwgfd3wG4tdyGD8Ptkka/FNHBGkZKpEh2/sbYCutGMhnACSIAx6pqQrwKYWQfkh1pTV/AqQPreZmkI+iumJdlXIiWOF++OwZX1trRoS92rlxualf8SVDBcBGVulhNGisExntOJfFO5n56m3ii4ui8SRrzbnjTdjpeoZzAKejCxoVpRfIAgIzDoKMQyu4tZw7WBT6c90UOyLI4MHY7iiv6PQTsCmB7XYdWF5aJyjAwQDnQYGt1aM2AlbT+tXgi7gX1/sLWVUZsKvur2i1ZW/fvkz5K1kS31AOf3PH0NnHHxHMDtip59d3wQoEEn1aqzaVuXs6YuJAFuxaHdWxAAzEdsGE7SBbs+WlmfzgKhgtAbkgemK6JHY05k3jS9y72MIwK3giuMAnpAZuASWXRHruWZZDx2TXyQK3FTo8QVUtgaiAqoKDuyl3A5I5VG4Q+ZeTX9IVblK7Gn4ndU3oqA0FJu9aqZQDytpMIsRTcEP/j0T8to08ohyECQfV/3/VOrCOd7r95Fcdti1+wsZE6QvO0I2O6ccScq6CM6LLBggNLMEX8NNoUjYiLQ5hkzn7HqpmYXYxviCdWRsbBSfoq8ONAqyIOzGu3k7qudHsGQW1WeTwNniK3inSEFAobf6Qr+tq/fJy/VPfntK8W5k1Rbt70LWZ1Z3TnTGr06rFmU27ptXngnkEKEuMdLPGaDmuqwOQYJBlK20rw5ou7yR3NKTrCQKxYpWGBNbO0PPLo7t6X96ACLIDRFxRgVbeVl3zFCt2CXNH2v+PvlOTcddMSMy7vlw7ibAQss=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D0EH+zXLFwsg5gFMag1jfsBq4+KVEMVGui7YsWTMdPkgvMUOZ5g6SKD3n0?=
 =?iso-8859-1?Q?X398e8o6LLJK8FPhQPUyckMNgWFuZXJB6YwGFAiMQjIEzvxr1Qn6TWWfrE?=
 =?iso-8859-1?Q?jVzV2HulGFupT34leMMSTLDYvk8HBec2b+DQEP5sQKR44boeZw+IK6ykCm?=
 =?iso-8859-1?Q?oXe0y149bIns4M4eKz1EHK7LVN4mMKtPUC75c2s/7M8ff0U6SuHGOfQFCQ?=
 =?iso-8859-1?Q?Wcs1N84TL5vyJhgmt7e3w/UNX0CGorIRQe15urE+TUQZR7it+YMPCEWpYw?=
 =?iso-8859-1?Q?mwycWfzZG/OVqu+qtdLQclI85hW4MYJ38LEsbYaOlHcj3YWpJPjEMZdR3s?=
 =?iso-8859-1?Q?Xbans+VRqpgj1t0iG49z+UeGOCds+KhtWSmwhEw4bkdAVqyAiTfthANLC/?=
 =?iso-8859-1?Q?/6eUJYSegvpwgc2FfV6DTF/6F00KL+cn51Dh+ZW/gbGBVvfvH4YWpUY9lD?=
 =?iso-8859-1?Q?kMu5Yi/r5rhLXeKD+qmN52j1NssxG8kLvWlwnuZMxSr7tBHMlh8IjTSESC?=
 =?iso-8859-1?Q?v21VmbSFt66WOqWeh6ncAeRYhRTAOSCAwiuDRxT+LeDXrKwXru3oyTsNJV?=
 =?iso-8859-1?Q?+ytzO9dEe3oZd1GhYTqMmMeflUBg2PfN/XbkHa+Fu7SrCYhQ10CtowHxRo?=
 =?iso-8859-1?Q?RQdjXVHTRrltfZPGbJmtYBa0ttCJATfkQa5fhI/929IUsukByDxAiWz9hb?=
 =?iso-8859-1?Q?Kt1DFI39yrS+IRwyONH2i6ZRMclWn5Xish8kwRDrI9I/o34egM/+4BDM/I?=
 =?iso-8859-1?Q?TGqe8meksBeoo/KEbwp0RFrT83DPz1tKwmjGWlO9Ty1pHGVdaAdgl3+Mmn?=
 =?iso-8859-1?Q?KwVqHCgOf9yxG8iic0O+ExAyQYN8kxDtZV/xMCrE/dCcv7DaddXRjAteGi?=
 =?iso-8859-1?Q?k/zc+va0sinRZCOE0g2FHWodggIcyljUpeQM0EC5ENtFpbuQSe4rWPnzxn?=
 =?iso-8859-1?Q?p0fbkkZ4brzKayB6jD8l9Fe+62+iy+1TcGPQ5iuU64+7oy/2s+9dmVh2i0?=
 =?iso-8859-1?Q?3sg1zN9ovesOC3EAAVc4nniYlaVOyZnMyFyLQvabpqww0y460HCCU6Mtix?=
 =?iso-8859-1?Q?5dCK/gL6TnHFRnkTk8KH6hN8/uhuT8w5IX1/KvDXxRms/iyItfQDfRNNek?=
 =?iso-8859-1?Q?ry+mkYdjQF0wb6GEDoeea3YDc5Z/wTW7IG4r+ruWOaWcz2COqSaECp8Yss?=
 =?iso-8859-1?Q?T3OEEfV8eCcXZyLlL4n8E91PUOZPY/oDUS3B6BTPvOD1Vvss9tZhEzPZVy?=
 =?iso-8859-1?Q?j4Exk2oGtrindNnkHjndUyhb1xzxbJFoweLJ3tZmV+m8Bel+Dy+ezcHnsq?=
 =?iso-8859-1?Q?HK9s1lvWMZCQc9J+4dmsSeNLRnZRY/HH8/4k57lGFMOadUA0X3HFZ2Y4FB?=
 =?iso-8859-1?Q?hbU8Bhk4Ck48fRIY+rJCPhj59kwAMzK4zMvUrjSjUuiDUiGmmdFx8px53x?=
 =?iso-8859-1?Q?5kHuASC4KxQYLCL1wJg1cz8Jwv9hhRu2Ti4dtZrJrAwQg2cwVFpo5kruge?=
 =?iso-8859-1?Q?4e05pzKjys1R80m/fBCjDvulm0c6xwllwpptExijCDTP/hqJPTayDwPM8D?=
 =?iso-8859-1?Q?zDjoYf9O6uCmOGIATkKhRQR5U7DVu9h+yo28UOLElnuZhtjZtZwW578DZl?=
 =?iso-8859-1?Q?yQbHkTOWek0gEzRU0M56wQFLHf+6hpgh5S1bdqHZvf0MWjPvWwjioYcBU0?=
 =?iso-8859-1?Q?BRy1bFUfH/5P1T7rsLqP7K8f/ix6fhvpY6Y/PrIjKDUP0pppwSphIn/nTd?=
 =?iso-8859-1?Q?tsA1R4ktCbxwX1rCMZ6xsW79L1QyouAkcVYTYT0IhtR7zv0NkrmzQ/PQ8h?=
 =?iso-8859-1?Q?5Qrz516feA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asteralabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21471100-bd28-4837-fc11-08de7fca9deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 00:02:14.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f47c88fd-08a9-4016-b488-3f361c03ff2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLcfHzmM7BoFtqC1/5VLyG3436bYTuYEwQNkYp10zC1H5cm8Kro0JUk+jq4PkeJKvmgnkpI6DHqG6/00E3tVGEgHvVjgCqVjzgAxf4CUwfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6P221MB0709

Hi Bjorn,=0A=
=0A=
Thanks for the quick response.=0A=
=0A=
[+cc Ilpo]=0A=
=0A=
On Wed, Mar 11, 2026 at 10:00:39PM +0000, Shawn Jin wrote:=0A=
> Hello,=0A=
>=0A=
> I'm reporting a potential critical bug in the Linux kernel's PCIe=0A=
> resource allocation code that creates invalid bridge window limit=0A=
> addresses during hotplug re-enumeration after Secondary Bus Reset=0A=
> (SBR) recovery.=0A=
=0A=
Thanks for the report and the repro and debugging information!=0A=
=0A=
> ## AFFECTED KERNEL VERSIONS=0A=
> - Confirmed: 5.15.0, 6.8.0 (Ubuntu 6.8.0-88-generic, 6.8.0-90-generic)=0A=
> - Likely affected: All recent kernels including 6.19=0A=
=0A=
Do you know of any kernels that are *not* affected?=A0 If you do, we=0A=
could bisect.=0A=
=0A=
<SJ> I haven't tried the latest kernel 6.19 yet. I'm planning to install th=
e openSUSE Tumbleweed with kernel 6.19.=0A=
=0A=
Thanks,=0A=
Shawn.=0A=
