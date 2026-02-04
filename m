Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0F1917FB;
	Wed,  4 Feb 2026 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193926; cv=fail; b=FiT+9/ft4et3ZgJEFOKQYEAM8UiugwtQsjwdBK3g3nnvgDDQ5LvqF4vez/YeKjL/7ZIqCqaszI+Hto7wxN5oLZPr/lFQzdNo1HdRQqzDz7wHCwOQMC4m/gKZMsokJ8BaaOuoIgEdR6Bi3ZdFf8LudBj2uytG5EKAfB7sWvmsh/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193926; c=relaxed/simple;
	bh=Rx1k0hikEg6D8ZLP7uXtitePP27ANfKLvu0wXrz288Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMcVel5Lt9RvzhW/3fqUiNISQsgBDnFksvBzcMSNCkt48/xWUZ4riLR2TkxM/Uk4S2QFEeKcdB1YNLIYw795b31YeanA6ATsC/qg71YPP2Bu2NZpxBodAXeETO1UO7GTTOPSqqvG3vgUtMBxhYtyRRiNcsprdl8o0UJnhSK6PBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lTy5EYQ8; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lTy5EYQ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlNkA0VSe+QC+qBphxoWcrWsShA2WXRBPp/auj+Sdnkekg8h6/kwoqi3j9msxt8jQqErf05h6C/Hhla/vswRVnK9x9+WDR0kogtCqh50dJhQ1SgCrAZ+UDlxlKusa0j4SoXPQhQ4M6Kx0Q64OOCox9q+XNJDN5Im9LAwExUW6XzHnVpo3noee079Z9Mn8U7hgGeqZnxHPZfVGLRMZOUxnpCgd0spgCyze2S/P7c+GEizZnKp83FFRQwASoMXQkALzLsXcufqq4M/YWOjl3K7lqO8H7e2qL8/6ucC5yBMC1wXqueDorGdVWETo9Rv+nrYZw7sfDLVJGopVd1MILiK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCBj3cPxAZ2MWLZLzwYwQAwVpnbK5N+pvGgxtEfjqps=;
 b=BL+wO8bW0NVy34BJB1Q1VJPRiyV9oui9IUnlYXE4qjOqyts5+Y6qEhKd2xzOaAp/C76EcujbyjPPU8kBc7w+AhOHNDkPTGqWtCGG8sd0CyKNjyK00Q3bNsYhyx0Xcb0A4ColKI5O8R2bi0PDnEBpVs9/oBwpAOTJTckH9XdNDxhkNLuRzYz1Su7CAYlMlorRhuxCXb6c2ElrR0x4uZ1nMqzWvuWDPRCDiEAUVRI7chpj2/psD5Ncfx2NovKYdHQW9TTjaXo4CDYYznItQ24MKzjp8++dk16H985IAIT6Pr+rCvGw15ptwI16GIhFPcJPhXu/hkig59xfIvw9pDoXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCBj3cPxAZ2MWLZLzwYwQAwVpnbK5N+pvGgxtEfjqps=;
 b=lTy5EYQ8/YotMNfvqSRvqV6SFxX77N+KK+L+5xPZZvd1zOF3snLPnZa7lVd4vrs6pabxPRgLAnoHQ0Kub09N0CsJmKNL9sAmnatZy+lm/gBo3jKKRmU8R8ghRVJiekdlLXGGjiGQWFU4sICq6KqNxBd5qNYVmd/4xWgxHDN3DZE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 08:32:03 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5151:8ae3:f31e:4c9c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5151:8ae3:f31e:4c9c%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:32:02 +0000
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
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
Thread-Topic: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
Thread-Index: AQHclKMaN+gl9NbYb0yLlFjVQ+L6PbVyM+0A
Date: Wed, 4 Feb 2026 08:32:02 +0000
Message-ID:
 <MN0PR12MB59537BC8B60D76CCE0B1391CB798A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-2-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-2-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T08:16:45.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|IA1PR12MB6355:EE_
x-ms-office365-filtering-correlation-id: 14cb7612-25d5-4446-9ae0-08de63c7df43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?WJMAQ4Y/Y/bZgQeP4h4sxBXYKEh1LlYP+MA2qRgn4/HgB5ci2M+P9RNiOg?=
 =?iso-8859-2?Q?859RU2mha1tio4V9TheP3s2eahwezAzl9VMuF+MHDT1Na5SkLKvXK/K+GA?=
 =?iso-8859-2?Q?szNlVZOY0sM++9OYviFm7DyXNT3RLIqQy7kOu4zbl3KN69JIGaeZxmeR7D?=
 =?iso-8859-2?Q?0RwWOWJBeTq7qULaIscpQzmSSO8n5FebqIK0VbLnTH+jmLp0lfAtqCDa9G?=
 =?iso-8859-2?Q?1miVRjQ2iRkqFde19QYR7Ld+BfCK9nCEAIJ/gsxfYjUTuxmP1FtA7YiQzg?=
 =?iso-8859-2?Q?Q/VASPm47i3LngP40WnsiAo8cFE4oN3myuvUL0z0yJ1BP7AB65SCHsJRBE?=
 =?iso-8859-2?Q?U6dA7kYFEHlKSagHLF0hly4qP+ZJIQ6CyRyY0i8hJo1wgV8NKUQMxUxj1/?=
 =?iso-8859-2?Q?sOQLe4NFAGM383pxdPv+IDdF84QPrimrK36Pcu1VdkWo4daNpVPAmO4Bur?=
 =?iso-8859-2?Q?kTBp6MwfPfwMJbOYcmbTioyiXaJiFNwyPmgoRPMRBpRW7DCyKOFkkmb9+t?=
 =?iso-8859-2?Q?Z9ipamOkBvjmmZAzQgFJy+wYYZKyIH/a/uR+6YfAjsgVFplG2VWgAshL5L?=
 =?iso-8859-2?Q?hAly17a3tLGauGGdh0F5D6KY+0lp1zdWHIE+JRu4FsbhAaNT9tH78fiwCR?=
 =?iso-8859-2?Q?HD6F2X3HJtwBWMg0ktpsvU90jTJvleOk1eIxiVxWZiqeP7zgf6nb53KR/B?=
 =?iso-8859-2?Q?2YkpR6QKEWkLsf/dvkZdMoSeVehmqB3+WHSuhxYHgjGrQolPa6VfHCNeAW?=
 =?iso-8859-2?Q?gLHkD52QrNXXPp2A9iCjeu9UwNUdxoje+EoDJeFJ5u0RCAYAHd3CsScgrI?=
 =?iso-8859-2?Q?+sZwvna0Xj4oc03b6JxA9RkmxBmHGXOF+doqTWFb4vAGQFapyKLtfvnQgf?=
 =?iso-8859-2?Q?cOfIUKUNYMt0lJZp46NcS594e6qfro8oMk9ub6kTJjwKzSpeXuF8GGNh0w?=
 =?iso-8859-2?Q?FL79BP0WUpZDl/KQvZ1GRuGeotB8ItRUyXvmcI1Nzs/1YfgdAdVhXRO9P5?=
 =?iso-8859-2?Q?DVqholL++3SqMmkBBH/TMs8gm0XT0igmIklm2Fq64AMZJjVmL55L1eGjcL?=
 =?iso-8859-2?Q?nZPXJJgGmzxNU9BJrNkbxK7peirInl8HDFwXrEKMQmG2dWoUbVBZPAy0cq?=
 =?iso-8859-2?Q?eoUwWVu2r3fPUN/KRs8+liUe+tBrAmC3qGjc7v9jCqCvD3lKLsxErv0BcM?=
 =?iso-8859-2?Q?dan9NvE1rLI3W96Pgh3VKZ+NpizqiN9N870GvXgSLL0iClFaVfIs9XNRsl?=
 =?iso-8859-2?Q?8Wcsgf1fCk1+5C1MX9FEewTeFnBKPxe4KIYiDVG0Yd5vO5FDsGKm2KhR1I?=
 =?iso-8859-2?Q?Uf8u2GWFvB8d2aE+7IQaYlZf23zEso4VWqaZ6LAbSiKK7gmaVd/1sixmWp?=
 =?iso-8859-2?Q?mdGpuyqssffgdC8HHfcpfuj1nJaXI09ekGGAhr5LZJL2c4VDstBSz9pMEz?=
 =?iso-8859-2?Q?HkOcnkukaXAtRQ6n47oShQ2gV9kRLlt4G00zP/5/CU7/Yv7NV+355uiUvV?=
 =?iso-8859-2?Q?f7dfyGFM4ZaOd4bd6B4DmZZnDmm9O7ZlYddz0nbOVEB9eLMbHD+clHOKNO?=
 =?iso-8859-2?Q?BYM9rYjn0fMP1PnflwsCI4RNAfQwL576Nq2choqg/Ix9PWiNVcGRlM19K9?=
 =?iso-8859-2?Q?xGwHOmltiQPBXr5gOEHZvEhdgyWGB44GXM5wlknvkZB3WGOL1CiFF4ujCS?=
 =?iso-8859-2?Q?4WQFwsRlqAt7H0jgd8c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?zreitFkwL7o/4QALIIH6GLZYcKtT1FCcGA76M3IL8RtiAtXL+X06pDaVLd?=
 =?iso-8859-2?Q?EWCo27Bui0UVLTkJ6bKpYBFhMYOboTQhXtnG6Q0BKjVDKniEVd1jJTl/Eq?=
 =?iso-8859-2?Q?FqL5h5MEW+/nPzYNBUg51n0+La7/CkTmt8S4OZx0E15lvG6o7HRVAv7EBQ?=
 =?iso-8859-2?Q?K4mIWYBFIigNr7Ryte9JU5dD8j83FhZmNabUZA+qll3d6EslqiJRSj8gN5?=
 =?iso-8859-2?Q?PiFiFTLDv5H1E+7/9FPt+tcS/Cp5qx9Ho/s/MqIXEzxlq7ICTli3ZJcHdA?=
 =?iso-8859-2?Q?nQm9buASrhViesKTipJgkb+BzfBmWx7iOekOrhjCAIESgWB0v6L6mig4Eu?=
 =?iso-8859-2?Q?wU2VQyAYAcQvJ8Cpi8BR6+6fJYnw3ks9ibfFhPvdkVvGnk+h8WYnfmZeiy?=
 =?iso-8859-2?Q?oqLr1/z346EVw28txt93h9BG2WM6nsMNIuS5ckqJ1AYfB7KBPX7l8R8YqI?=
 =?iso-8859-2?Q?s7q6qr7sNVeogU4onRZlfD5SmZkoTD6txjXVrvSi8lJ0Z2pw4MVyffmVEO?=
 =?iso-8859-2?Q?iPNm6BcmbKdZDeDpBucB4rNFduhBwumkc02BbmpJfZ+1g7xSZWNcqph+ER?=
 =?iso-8859-2?Q?AujN4y7Jc0rklt8kyUlibgEY2dNyRnJzLuZucXyap2Rm8Eh62jp9lgBOVw?=
 =?iso-8859-2?Q?yXTAckyj401z9R0FVZ3OBQ51nRnDb0fjbXtAGa6RfRJ5N8NukanwuEytG9?=
 =?iso-8859-2?Q?WyJ/zNG1u5GwXmthFp4cXNrC86jubKBWH1Wgi84CE+B1tcUImyhuYbLiV1?=
 =?iso-8859-2?Q?3fppMP5N46aS+1g6d8cxDb926nb6OpWVzeApqGCTOor8coWZ6snXBjvIvs?=
 =?iso-8859-2?Q?WA5psDzGXwaOD5PxcNBF+f+fDrA95XdrZDhB3+kg9BWf0dlnAoJroqWzcV?=
 =?iso-8859-2?Q?snKQhqnm0JvLp/nbxQP0lmtMGzpv+fCMe8LQLRtFTXaUdZIeeDta3vy7ZA?=
 =?iso-8859-2?Q?lbKJcpQB5xDBlzaW3V70TloEkDURASGP/bypWf06k5hejdeu2bGQDu1g1o?=
 =?iso-8859-2?Q?acwiBTQBJPJG2f8SnnMUtnsOGGvljDgX6QRRXjWmr00aYkWGW9/hn0/H94?=
 =?iso-8859-2?Q?FLNiAqPXQq9TLEIcbzyY9ZlaH2HqcYy6qwWmu2Ys/Hrwwm+yoFfNS6NVhj?=
 =?iso-8859-2?Q?kiTsd1cAj1+kHyVOF8cEmHDDNxZf2wTOWhnkiFhe49+ToUVdvWlx6NQzYX?=
 =?iso-8859-2?Q?NpGVZYSb0j6P3mxq0lW2dFhe2Hpu3cG+fd2B2ERwf42Phyh6HCpVmaWkO2?=
 =?iso-8859-2?Q?R6ul4Vj5zCxTQrg3BosBJvzpKUuSKKgKryHMeyU2FtpY3kSHlhjyEgKKQq?=
 =?iso-8859-2?Q?L6hyordAWt5GjpeL8EBbEfK2IOxOra9RU0+hXh0skTDN0aDHwA/w1GL33u?=
 =?iso-8859-2?Q?HWxLJjzkWk4NcMsf674QhBENrHlUSnnrnmzO/R961UfILSUFW7A64Vbmny?=
 =?iso-8859-2?Q?Q+ILQFRjjMaI6mZ+GPCYu+k1YEitiG2r4llbDL2qj9fFYtwsSLvt9MpfsH?=
 =?iso-8859-2?Q?XonGlnKwzWt+Pto+1KCunmBnkiP05BfJCcVToOeTCRFJKeUDOB4ofy+IGb?=
 =?iso-8859-2?Q?3N5a2GzWh8XcTes2jj+Hk4F8dpj2VMAp/ejPcc7uwe2I+PtYgYrCcZ65cJ?=
 =?iso-8859-2?Q?TYqHvA+Fk3ik0W4pxEm/mUmJrPjW2ff+19TVmQdi1JfugjV3jxoYqyvyz0?=
 =?iso-8859-2?Q?AgPGmf+7dVBkAUAOCfDXc0Qf7r/QHWN/8L+2fi0TqP0aS9BBOmYJEDeznl?=
 =?iso-8859-2?Q?UO12ZcT4Qq2h2ylAbv0OlQTeEV2GnStZEmZae2UA0KuvBu?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb7612-25d5-4446-9ae0-08de63c7df43
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:32:02.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8JSX9k+VcuoCsF9lcY4/xzQs0ZeVriRDCrz9epIfqecvgnQWLJn2ijknztAy9tM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355

[AMD Official Use Only - AMD Internal Distribution Only]

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
> <bhelgaas@google.com>; Sean Anderson <sean.anderson@linux.dev>; Conor
> Dooley <conor+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> devicetree@vger.kernel.org
> Subject: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
>
> Add resets so we can hold the bridge in reset while we perform phy calibr=
ation.

Seems like this should a required property?

Rest looks fine to me.

>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml  | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> index 9de3c09efb6e..7efb3dd9955f 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -69,6 +69,18 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  resets:
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      - description: APB register block reset
> +        const: cfg
> +      - description: AXI-PCIe bridge reset
> +        const: bridge
> +      - description: PCIe MAC reset
> +        const: ctrl
> +
>    iommus:
>      maxItems: 1
>
> @@ -117,6 +129,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/phy/phy.h>
>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>      soc {
>          #address-cells =3D <2>;
>          #size-cells =3D <2>;
> @@ -146,6 +159,10 @@ examples:
>              msi-parent =3D <&nwl_pcie>;
>              phys =3D <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>              power-domains =3D <&zynqmp_firmware PD_PCIE>;
> +            resets =3D <&zynqmp_reset ZYNQMP_RESET_PCIE_CFG>,
> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_BRIDGE>,
> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_CTRL>;
> +            reset-names =3D "cfg", "bridge", "ctrl";
>              iommus =3D <&smmu 0x4d0>;
>              pcie_intc: legacy-interrupt-controller {
>                  interrupt-controller;
> --
> 2.35.1.1320.gc452695387.dirty

