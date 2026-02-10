Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50132C8B;
	Tue, 10 Feb 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735621; cv=fail; b=Bxsy2QS892yrdXpAuvwoAETvVdsltrztY9+jjXm2ZDXihX8aBGw8e0/esxSylDTtkfAoS4AapHQ6LHU/qjcjFw2TwF0z4Han+BQYQyVjd6cBL/Bvrme0PnGPhLpsIu+SKSDzWatoLAvEm4dyY+dgM02prjFYBQyqvyljXgpTkUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735621; c=relaxed/simple;
	bh=/XPn8G+Ag2YeBiiSB0A3azU8ZhXHhcd/UKbHLZn0Fck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTqxoRtNAB6u42rZATNXYHp1EMxVQar7yOdfUbjbnWeSwwTgoZjkUhGpUVHZYnyGSwdivxrL3ERIztXwVI2j/qVfKhe/zN8DjPgKi8EA53wFVBDPKQr6gVT2rS5M5ce8iLHEz85AZD/NUp6oI2/7W0pzwsoSVxKT1c6KkZ6jC+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LxVub9mn; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LxVub9mn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho+yFV+OyLz62v0amdo/uKbMM2L0U/qtV1ODHPOmXpZNXb7TUt6esl0C7c68AWPTwhjshYDbmR+dCbRybrCy6AKbkGvmMJitG3QxlDQjkTgxtf2ZBs3o79cSWD2/LhHrjkfqZFQjlmpdAm5MysAwTsiXmyIjjMPlHg8Yo/k/6Zop36bh/H3wV0DyRATEngmlAc2ABbugASBJQjq3mLUceVioFsa7m29s64yoEQMS54cVo746p6XAmRuomdlGVvAzO0MBCrOASsPYG+sBxEB4Xl3DVTEmBnYtC1Ajt8LozHXiGnroDCwobb8NfB9dS7YCJmK1Mn2GbxMPdiaJkwxjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcnANsUfJlZoJKaOriJbu5a7iURwrw6IdaNERhBHNVM=;
 b=ejTlmCZZsp8xdS40kr35N+JxiCnkYaQVCSNJAVppYAykXuZl6TKH8wXvm8Hndicsd9TGVUyw2PL54smP5WfEqLkarD9zE9aSC2J50N5kplXkgiq3D5L10og2QIJN38suNm069hqP80XO8Q24BcM2xhdu5H8F71syUtxtJC/LS75bkdrAjdvRIbNxGl6neB046PrUXoioNjXojLbcrrJQBazmfOfAnuIgAjRngKU3X+uP+DPQgpRFFyiwu8rIg0FZex8F6cBZGQucIPsZo1TLPUm7PQpwOkGGT5peVt3RNxMvE3UDpiNugkcEZB3C3LUKhDNPz0fot+QkjHIrngArDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcnANsUfJlZoJKaOriJbu5a7iURwrw6IdaNERhBHNVM=;
 b=LxVub9mn1FBRksubtlUc6Q1r9Uh4MiyAFFx9x8sxqrwJNPL4mUfGVyZbDEiuIMRuSCfAJhHGCAlDlN6FVndfWbKLGM07N+8H90KCiXQZEqPCesZHz7ckTu/OCGrk5RG9KJBb+Tlo0pKiru9eDNjoUDuht1pSo8lPh/OBDbZLziM=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 15:00:13 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:00:13 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Vinod Koul <vkoul@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
CC: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 2/8] phy: zynqmp: Refactor bus width configuration into
 helper
Thread-Topic: [PATCH 2/8] phy: zynqmp: Refactor bus width configuration into
 helper
Thread-Index: AQHclKMb+depeZPUKUCtXNJt6CUk1bV8Ej2A
Date: Tue, 10 Feb 2026 15:00:12 +0000
Message-ID:
 <CY1PR12MB96976BE130D0A99E409885D0B762A@CY1PR12MB9697.namprd12.prod.outlook.com>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-3-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-3-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-10T14:59:01.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR12MB9697:EE_|BY5PR12MB4322:EE_
x-ms-office365-filtering-correlation-id: 75bf3f5d-9205-42ae-fc23-08de68b517c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?SXzyqvR4Jx4vtGA3zhD1DxCYSMBkeDmG2epkNXQsa4BVvWBhAk4XNGs20l?=
 =?iso-8859-2?Q?q7+SnxuPYEj9BN3pu2bnH4C6qTsszN2GGc3+wSoRURrbVeIoCstXR+eUTS?=
 =?iso-8859-2?Q?K2wU2ip6MJZ3oPb2VGEKXrCo3poQJGc7rkleLxYA/ft4AyrvBr870VVfPl?=
 =?iso-8859-2?Q?jOfyKlzeORTOiLvvWXZHOCQs15JoglF8jxELFyqvi8TFjmxmvP1wRv9K/Y?=
 =?iso-8859-2?Q?SvB44lRYz92X5jqhW+XP9kU3MlozdzkHID9zBe/LLloSE4RKmrh02kFnHR?=
 =?iso-8859-2?Q?TBzqUhM/l4nWZJX90lmdaOJP5lzqRlzer6+MY14Dmc1jyQW07s2kWpPt/R?=
 =?iso-8859-2?Q?ODYCwOmzKMD3Gr4qrjxhKHXCnUf8yE2hCPNK3op30Ev9irti9lGtEG9C7K?=
 =?iso-8859-2?Q?+HxdZCt0AXF/k3xjSB2JfeL8eKzwtrspHERGOvmh+ywLPZr3tU4VhPPX+Q?=
 =?iso-8859-2?Q?HQ68v3IT0/B60s66VqlRPHq+dO+fYh2wSxsO5uHjfx1vGtQ7PcxJcVMOSm?=
 =?iso-8859-2?Q?PkrzQUfDXcwGwY+Za0BmB5QXvpRgzzlAMu4PW9TXrOYb+QHUf7znNmLqsF?=
 =?iso-8859-2?Q?zEvq7bEbcj7TIn29SSNb7/rm7tWV6wikrMct44GaKzncGimfCyDVjxgjPQ?=
 =?iso-8859-2?Q?rVsqQvVA0oFlOhuu+jrIqUUT5AJBruIG1imut1dgOUefDJMsWWPfbxby0T?=
 =?iso-8859-2?Q?D0V8zvEptBcTP8h6MzubAg82iyBfnjRd8P+dL40sKj9AH9NWgROnOe+90z?=
 =?iso-8859-2?Q?SGc0U7yPDAwy9OR0GYyGeFvsCFJ74USjue/4eijqBTfnqnuq8hTKCw11xK?=
 =?iso-8859-2?Q?fg3EMpReGVbQZtoRQwho0awe3FN3Krz33DIYuj9C3a9Flq/ka3uVRon7IE?=
 =?iso-8859-2?Q?h6XxrDHS2RyE2Ia0+X39I2/ikrNC2op2KzSUL9y+w0VgeIqTihejPw3Mqm?=
 =?iso-8859-2?Q?+SF1/gQfyaWf5xhB9Unit6lN+iUpUFmn0XYnMkagPHTkfwL8cq2F5no8ZI?=
 =?iso-8859-2?Q?o8UtuVOwYIN8kZifWkroe2vP8qINAHXT08pvtVyjdM1UVZfxJkpYwDwKhy?=
 =?iso-8859-2?Q?nPl7R5TWrsJ6EgnlJjHhWs7j+bXgE0Udk8q8eeaG77bJIQOekthubxEbYT?=
 =?iso-8859-2?Q?P8an7q5G4CdT+Svd6/TN4L8WYY1Ed3+l6VJrOY8+y4O0aNT3dpTQRi68TB?=
 =?iso-8859-2?Q?MS/UEAB+7mAAbjZCmgBLVPScUKz6nQxn2sJiyLGAyb6UuiDAP3Z0A/uXmK?=
 =?iso-8859-2?Q?anGu9q+KB4/rc4Y8pjI0vnXO1mrEj55op7OsOE+yCCrw/t7eIbWQF6AJ9r?=
 =?iso-8859-2?Q?LPulx2OM/AHJ6yf7vV5E6NmYVcpSsxqf1bdFaILdYMrmm45qpd8jsK6Ird?=
 =?iso-8859-2?Q?vWOTyM+ktY6ennkAHR9EU4URE4gDJaWEAitCGfizj29V5TNuJ6sRpaPr0C?=
 =?iso-8859-2?Q?HVJtfi1ErwQPJ+q6UTeTHn/1OatE8H5Bvvynnqhsfppu3p2Ijbycw7DONS?=
 =?iso-8859-2?Q?NeUOsViyVHqgB3/EKW9JtJaSFtAqzNM1Gu/XxY3zzvu+P3EU07GMXdsGtR?=
 =?iso-8859-2?Q?t1OaRPQu5ms2UCBF5tsm12PZVB5TSdNtJxJiLpdioDZZZ5perZJ4A4SP6t?=
 =?iso-8859-2?Q?TBFouc0s+mgTsJrnCttC6F4ennubkeuEsL/SOR8Toha8FuEUzURXOxzYwt?=
 =?iso-8859-2?Q?bLwSUkDk7aAMZRx6aTM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?VI+B60cmmt/QYsoPoLNS5x6bj57by8b5IqJG7pMrxb9/S3B0UgRPSecScK?=
 =?iso-8859-2?Q?F1R/rtdy6sgpwqB5N/pYcZiVnQie39ZnP9we2uPLMlyJ2LhG6UwbBUNjpR?=
 =?iso-8859-2?Q?z9mumb5Z5NyUIi6aFLJtjRaC1yCrJZZvHT3MZ0t0bkcj1WEPOsOmZgdSVH?=
 =?iso-8859-2?Q?ygQ6JDWA1wrjflEi4X5r55C7lpwZfWi8428iH3HOwBtpsOmXIbEW22/OuI?=
 =?iso-8859-2?Q?kgdVKwyB5FDDCeObWAAbub/LcFo5YY/oBpbBuPVhBHfLDVQ9uL7uG5Gqf6?=
 =?iso-8859-2?Q?jeJAAQEIxCgibOWwE5ZNtsN1z6IGmmOWPmjorXdbQwG/VhulSN39zR3xo8?=
 =?iso-8859-2?Q?rWcM8kIt6fdXabBN7dshTSRN9vj+WSTFTNY/vVUmgGDAgNkFYDxKRvIkYk?=
 =?iso-8859-2?Q?t0qE+ysKnKw3bu2spyvCGvaMrIerr9tkpk0kb2hj1rhjH3Oooh39BndNFB?=
 =?iso-8859-2?Q?KPhehHAPT3e+k2TosxthHuWf9vV3MbQKiQWorMjbWmO0OIAukYf56cU6cp?=
 =?iso-8859-2?Q?+bOU3qNdv+80hLUs7Xx1CdaihRl56U954FIjqvhRsS4qDyOnOPurPZSeHO?=
 =?iso-8859-2?Q?8ytHznVf7hZSiyDt3PeG+P4LUTneHt7jIkEGwd67u6aYQ+VIDlJhkjbjPc?=
 =?iso-8859-2?Q?9MqSHrANTYbt9N2YxfJSpiS9dShT6h6PQwCeFI4n6E02JS0+fFsb73tBuP?=
 =?iso-8859-2?Q?lLGwMgYipOE/wdqEr9ZKOrYI4gp25i6jFYI8kOktEwJerbEHaCHHj8Hr9d?=
 =?iso-8859-2?Q?DBxeTnQ1H57Uix932VTu7PjmEnRTfuWagG2cfDRqmvp1v1zFd6C0iMOwu6?=
 =?iso-8859-2?Q?uNc9hMSUW9bO/75+yU3I7XVDOd8j065aDN/kMON1Ob3+ocPivONR6fGCdK?=
 =?iso-8859-2?Q?QYX7OtzvXqw23DIAW/ityV/GSHd1Pkb/odUYsLkIZxXgBL6o1MRAlS9PF+?=
 =?iso-8859-2?Q?H1UHkqKY6PDfxq3pih/m/1D71fhCMvfQDk5B0ot+r7gYPLMwIrrp6rBfJX?=
 =?iso-8859-2?Q?l7OSlp09Dfax2D6zYAhcmpBkLTguhxMmr1r51ufHokRqvLpv3RR67VfYjJ?=
 =?iso-8859-2?Q?Ewn708M4O+eJxR0Y3JiPpH++Jp9zDhni8kdkMT1nRXGCyLi6mFMsWJaNps?=
 =?iso-8859-2?Q?iSXaQEFnyV6eNkg8ZnjwyCY9LbMcAMXHrt6G1veT4qXonXh0qWKlrL/1YS?=
 =?iso-8859-2?Q?8K26bOos+2qa7hGHNzfhwU/B3t0HI9AfQvPoZWnV8B7H0je4sUsnFCv8OB?=
 =?iso-8859-2?Q?LbiWPWAWmPHehApZrocHJzAjNiUekK07JE8WQ1//6DNEylmp7+MZ4/hn+C?=
 =?iso-8859-2?Q?yHImTOxfYl9oiq14HzL40ZbZVp1w0SP5fgg2R7+JHl5qiawL2C62NRdocx?=
 =?iso-8859-2?Q?sXh1fSwqkz/Njn99wrw7XnzK9dxYaxvtRh7fnxPeQENx3ZrN52mTTUZ9uS?=
 =?iso-8859-2?Q?C7WlXyPxhHiy8TSVxA5zLjZyPHyvrvOdfWO7zuOIvofOHWbsX+iF7s/v3Q?=
 =?iso-8859-2?Q?85MPCBepySQwepgRswB2t9ENRfI/m7+8cTTXDFrdTmSyy3CzCHsBxS3ub1?=
 =?iso-8859-2?Q?W8D9ENfOOJxDOyq6K9MAnU7/+DSe/Nr9XsrqcXaBgNQXEKZ9NIDrB3iois?=
 =?iso-8859-2?Q?032gxqs0wfanXcBaFZkrmf9yexhxImLscKk8GBEACxMFiVXAOHrmIwFRJ2?=
 =?iso-8859-2?Q?szcdOyjuB5F2FIdQLhihmNpHSXljn0ZkcWL+uJ4hdBjgGNOA4OOB3XimG4?=
 =?iso-8859-2?Q?2/WM8cTKHZE/OcKo3z8HY9sNgCQJCsEsrP0GqdWzjSNu2V?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bf3f5d-9205-42ae-fc23-08de68b517c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:00:12.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymJEeI7T5oihxmj4tXHosbUNBrZTnX1FCon2YvvzMnbLHxWD4PY4aLbsWVvtoLK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322

[Public]

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, February 3, 2026 5:51 AM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; Vinod Koul
> <vkoul@kernel.org>; linux-phy@lists.infradead.org
> Cc: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>; Lorenzo Pieralisi
> <lpieralisi@kernel.org>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; linux-kernel@vger.kernel.org; Simek, Micha=
l
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
> pci@vger.kernel.org; Neil Armstrong <neil.armstrong@linaro.org>; Rob Herr=
ing
> <robh@kernel.org>; Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
> Manivannan Sadhasivam <mani@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Sean Anderson <sean.anderson@linux.dev>
> Subject: [PATCH 2/8] phy: zynqmp: Refactor bus width configuration into h=
elper
>
> Split off the bus width configuration into a helper function for reuse.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>
>  drivers/phy/xilinx/phy-zynqmp.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zyn=
qmp.c
> index fe6b4925d166..0d3c578d0f3f 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -502,6 +502,17 @@ static void xpsgtr_lane_set_protocol(struct xpsgtr_p=
hy
> *gtr_phy)
>       }
>  }
>
> +/* Set the bus width */
> +static void xpsgtr_phy_init_bus_width(struct xpsgtr_phy *gtr_phy, u32 wi=
dth)
> +{
> +     struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> +     u32 mask =3D PROT_BUS_WIDTH_MASK(gtr_phy->lane);
> +     u32 val =3D width << PROT_BUS_WIDTH_SHIFT(gtr_phy->lane);
> +
> +     xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
> +     xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
> +}
> +
>  /* Bypass (de)scrambler and 8b/10b decoder and encoder. */
>  static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
>  {
> @@ -535,14 +546,7 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy
> *gtr_phy)
>  /* SGMII-specific initialization. */
>  static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
>  {
> -     struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> -     u32 mask =3D PROT_BUS_WIDTH_MASK(gtr_phy->lane);
> -     u32 val =3D PROT_BUS_WIDTH_10 << PROT_BUS_WIDTH_SHIFT(gtr_phy-
> >lane);
> -
> -     /* Set SGMII protocol TX and RX bus width to 10 bits. */
> -     xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, mask, val);
> -     xpsgtr_clr_set(gtr_dev, RX_PROT_BUS_WIDTH, mask, val);
> -
> +     xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_10);
>       xpsgtr_bypass_scrambler_8b10b(gtr_phy);
>  }
>
> --
> 2.35.1.1320.gc452695387.dirty

