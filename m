Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931437A483;
	Thu, 12 Mar 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295569; cv=fail; b=ihZuw3v+c4IY8kd8stOWWA9YYS4WH3Vtx6oGyOXgnAeLbhWwtET36Ub4Ti33nfITwyYyzjgF+0w2jLfyoQup423tI3KzQT0IVBZxXUXLHH1OFP8yzvoEwrlgj2vLVO2eukOw/aMV1Z5sdxb0DMOq8sQaoztwB54f+TsCykbRac0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295569; c=relaxed/simple;
	bh=aro43vl3u7lP86fMMMqAZQyWS8vdJJ5ViM/XiNU0oWw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ab2SlaUI9vhVE5hO85Zn/KhHLC57pjdA9rNjfJ1eYRQK2HQ+HRGQ1XT2X/WV+LZ2GwSp6YrLkZbJKiu4+q0Ek/rtFoCTvMzmh/7mY+EPEab+YRj1EqhEICtQXvl69YbkQOJ21m+FrthCsXKCrgX6h0TkPVNXEiY6Mweu2w+Cy8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWYvIhMj; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWYvIhMj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYtWYdQN0FG3DXUtN8OokslO4fc7yOLsVE1XFEqW+Ri+K501dUww78Z6nQPfLXcoINYtMusMwkpBG7GdcJXFufve974HIy4YKmTclbU4iXbsdga4b4zPuzKJv8gNXRJBhy7q7l2VODAPkrE4duChN5S/cUzuYg17ync5I//C3rEQXC5dQkVHx52ko0o2qFW4Elt1/o7nPaCP6zSVnYaUDy2ef+a1UGzI9a5b+n81hKOvg0Ggp22yimcUuf6WfO6jtCBqBup2GlaPho7+bjICC7HcTC9nsFh5wMZhgBH4gdAwF/jzQriANt48AhiKCXzeA8lIifZvI2BQKogUD6PMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aro43vl3u7lP86fMMMqAZQyWS8vdJJ5ViM/XiNU0oWw=;
 b=SAnp/2RznPLCIgk+dw5z7peykiIn5lMBvLBVcTgknHLxAoHt+t+cQC+lJGlYaOAeWwfQc41VmoCKkULzMqjhf+vISNpnpCzXqUzR9QdfkJTPPYH2/7iC1aeNTocguw3F/ZdWSlOAQtR4gmkUBR1F3iBZTRLnhQUMGk53B7jXZtptVHRVED40d4gaol6tKtiSmf1OBNIsU0FVmSHfPqRMW8G3doqzYafaiGgdWqb4N33zCCMr2sqVRcYaZRPF+NpBgHpEtvYMrIYTp4MQCEayXojibMdeFRIZYdw8E5muSNTBf9hdaayazBj1jhwV3fIqrNpUP0igutUULDOZvuW+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aro43vl3u7lP86fMMMqAZQyWS8vdJJ5ViM/XiNU0oWw=;
 b=WWYvIhMjcQoZ+oyPYm7Ck4lMXxjM67cGihvPMt8CYkRFKflwat9Bg5hwcWTf1+g8p+R7nsdEDo7duWzXML20RF5aOiDBBaITW40pSkvYitYHfn8Qe1ydppbOOfSFr+zDK4yh36nE+SiXsdnX6r6R5gkI5zNK1gsvGy478k0+J9YOlWHeDh4dghZeDrhiU0xgdszUCREneHEROiaib7dPWxrAZml3jOipx/oXfmEEhJP75cvc+dSLK4LiC1GwieyIrtSwIzHm4blIQrUBJZ7nGqFDItlOfvjQ3NlfzGO2b9+gJwjzBeHatvfLyrpaaSCdGrGbX/d2svPpCjOfH9uWYw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB12297.eurprd04.prod.outlook.com (2603:10a6:10:629::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 06:06:03 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 06:06:01 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Lucas Stach
	<l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: PCI: snps,dw-pcie: Drop deprecated
 reset-gpio
Thread-Topic: [PATCH 2/2] dt-bindings: PCI: snps,dw-pcie: Drop deprecated
 reset-gpio
Thread-Index: AQHcsW6/roOp1kYc/kGCQQQ4kaZe7rWqaHxg
Date: Thu, 12 Mar 2026 06:06:01 +0000
Message-ID:
 <AS8PR04MB88335C2A92ADA42D422A08D88C44A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260311154955.145120-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260311154955.145120-4-krzysztof.kozlowski@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU4PR04MB12297:EE_
x-ms-office365-filtering-correlation-id: 7b4216e3-7706-47d0-54a5-08de7ffd6ff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 sN58I3WMO1XW8d5cXzeD/8GZAge12thPG5e27sdY1jy7P3db9avGUifefDXzIJ3HZQ8sDD1cep/2ZvIMYlhKDP4etgNJigqzCy/b/0fAzzCImmOLlIM3KYEwjE7g97nu6wRUCVlt9C9B00lqAGaTtwK+5YqfiCghOVdj0Sc5YRT8YignlHl04g7xlnCWx581so129vx9LjubVrg1dkw7qfFIaXoEl6215HC+Ck811tYuXj6ME+KZiRf5B09Nn+N4x3budCHPYPEC0LnT2N0ajG1yVxWUleKrBQN4mBQX3NRviHKjSOP4UsBfc6nU6xXHY3KQcN2E1tRMeYvQgEMlSk9IwA+7gujW7ij1oTymSzG5JMOFEqPSmoeTPH1RqJtHWGAvHu/93mDiBFBOamvD1tHLIsjiwdLbkLVD2BbIHo818KbVWygoJdVxcDsK6MZs7l1J6VoKN4YA6UXzcShuoaeJ6GPEaToTofDnyn9vJxrA6K3PTX7GFQ899ePtU0H7sJi++2sgvaRDoOG52P68PE+joAHL+94HTkkUNLvgNR38b7M9BvdkPSYnFiydV+iPI+Xy3zkQyl/hV3oPSHNgBJL+lWl0Jzeyk/SbqlOLwCvTu1AW0rweXT2Unp6PX8DHJM+z+6IS6Sz44Tmg6hEgfRzJzZIZZTvmX0uvS1SLSG+746gnp3Qrp5XhVPQtqT4c4FYSseFEw/db8k+ktx9GjHDt7pbz5PI/SiiOFiil4TwDJwlqARRjIngmUsyLGHqyx/fcQn4e4bM8waErei5qI101prPsPQCDgo5FdJ6CeUF1SaAX991P4cvZa29BM8UY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NllnVnRncDRCTi8xbjViU0REQUIyMXkyaHZ0VEZ2Y0E4V3FibjIyQXVicmgy?=
 =?gb2312?B?VEMwRDJhZWRydDc4UjYwUWNodEVXNjArWDJZbURudmo0cUZ0c1hjSjR6TU9x?=
 =?gb2312?B?Sk9ONk9oVlNEallQd3BITmhiU2RTSVNEdlFTM2VIZHVJRzBZM2tjNUxabnk3?=
 =?gb2312?B?cnlZVCtZNVFnc0xDVk5kKzhoRzdOTHpYbWdVdkVIU1NYbHRxM0pBbUdvU1dI?=
 =?gb2312?B?djFZZTFNRTdXdHZaa0U1a1ZFN0hJSXFULzlGeVJWMkVpbnJLMyt6THo2dHVy?=
 =?gb2312?B?elpNMm5oR2V0OWgzTlNyVHVoQjJrVSsxMmhqT0liWWYvaWE5cWt5aDVoblNY?=
 =?gb2312?B?alpmdExQQVZsRGQ1cUgyZFc4R0E5Nyt3QXRuckJsc1A5TUNjV3hBRFJoNmpF?=
 =?gb2312?B?YzRQdFp5N2hXRlV0UTVjc1AvRFFXRWlOQ0xJQ24zRUdZSG54MjBuSUFUZnhG?=
 =?gb2312?B?LzBENFBTQXZlK0tMNVZMNGtMQVFPVm16Y2pSRXZsb050Y3dkS0t1cHkzM24w?=
 =?gb2312?B?N0FBbU53anhiZFJ1RVZDVWV2NlRlV2hwdVh5eUJ5bFYzN0RlQ0x5STdzN1RY?=
 =?gb2312?B?elY3VmlsU3g3QWdNb1hGNFJwRWtjdE51Z0k0QjJVcUtlN1JXS0NQOHBSQXgr?=
 =?gb2312?B?L2tRMGRPMStrTHZydU9Scm8yZ2JUeE5hdEdZRzVOTStFL0Y3TFYyTlkwL21h?=
 =?gb2312?B?ZEFIMmM1TTRTdDFwS0IyRHdDd2lZQWZoY245eU5VQnNtZWgrNG0yWVNLVURU?=
 =?gb2312?B?QXNYSm5NS2ptN2FwbTBEaTd1UThjSS9DYWZZL3IzMDQ0QkdDWDlvRzVLZ0Jq?=
 =?gb2312?B?MVJDbExQQkhVOWJ5cEVRV2d3ajZ3cTZBa0l5bmRoQ0czS0FHb0IvbXRubm9z?=
 =?gb2312?B?eDc1U3dpUVFGMGVObktyRnIzN2Y0ZTNxMGgzZTdKdEZXdVdpVEVWVFRMV283?=
 =?gb2312?B?ejMzSWxWOUwzVUY2MjljK3ZwTXJ0RE5pS1pydE94THQyZlJRZ0FrUWo0WWVG?=
 =?gb2312?B?LzQyaEE1ZFpSaHZLU0I1N0l1Lzg1Uzd3dmRoYnJiaDV1alk4Z05BZnVjYWdv?=
 =?gb2312?B?WnM0SXZjb0Rid0V5OGxicVltQWM1bTV5bkxUazVzbmNzWnlZMHV4R3hwejFq?=
 =?gb2312?B?eWhqNksxOWdPc1ZDVkltN2tUeE9OQVhlNEZKRXdEVmQvVS9keUVTdDhUYkNI?=
 =?gb2312?B?eDJ1TG1RWUFaOWN3TUFaWUlsdjFsNE04bER1Y3kvaUdSNUN1SDI4ckNiNE9r?=
 =?gb2312?B?SFhub3BiSjNIUXp2REg4enRQZHhtaGs3emhSYk53ZW1TSzRSdW5jNXRBbnBZ?=
 =?gb2312?B?WnlzYmRoNC9tdnJ5a2E1N2VlU2J2MTVjeWs3bVhyUldkandYNlRKdUhoelZa?=
 =?gb2312?B?S2s4VHhGNnZhcGlnMTkxMXUwbjRZTUpnL3ZGajNLT0RiL3MzYjJVZTBPQ1BJ?=
 =?gb2312?B?SmZWWmFFSVc4ODYwTk1uTFhsOFA3aVViK2s2cFF5Y08rc2lrLzNEbDhrNGM0?=
 =?gb2312?B?dkNjN2RpcGtER3V3V1dPcFhsZ0haU0FrczFSOTZoWXVNamhPL1NBdi8waVJK?=
 =?gb2312?B?dDgva2pBdVFjaWY4Q2NBZFVJRERqbDV4bXJNUnpURWtSdWVCWk1iclZDNFQ5?=
 =?gb2312?B?ZmJHL1dMRzJ1WjVrV05EcUxSais3VTJXUm1lZmhLWCtwallEcWFWZ1l4d1pz?=
 =?gb2312?B?eG90OXdVY3k4cWFhR0trY2ZnSmJZVGIyK2pRVDlrL0F0aW4xa1Y5TmgzSFFz?=
 =?gb2312?B?UFA4MUx1WEtmelkzMGFUcWdJWVhtUTFObTA5N1lpMkFkY0o5M3o1VDdrZ1lk?=
 =?gb2312?B?M25ZVWM2WGVwN3J6cFhUdVlhWmpaaWpMVEIzZXZEU0sxWlhWWDF6T2NhSWhj?=
 =?gb2312?B?dXM4QTFndGhqcDhaYVpLV2ZWbm5OSDJoVWRLQUxFc01wTTNZZHV3czdQM2Vt?=
 =?gb2312?B?R2F6VE1BSC9rSTA4anplUDB1Y1JiV2JNRDR6enRFMU1GR2Q1aHdNRndqNmtW?=
 =?gb2312?B?NEFpQmRxWVlycnRjMGlBcCsxNFV6azJvaGFmbTIwQ0FBME8wNUxaMjBHRGRS?=
 =?gb2312?B?dzQyQVlDVXUweDhJSkNEdDQvNkJzQ0laOFFDSVA2L2s5TG9YRjVEMW1GVm5z?=
 =?gb2312?B?clVOaU9CS2dhbzRObjNJVVJZR056NEJhVnk5MjAvaEhxMHg5UHErOXh6Z3B2?=
 =?gb2312?B?OXFGN3BXSVhnbmFNZkppSldWN0ljd1BDNkEzN2xHQTcxZldRQmdvdHBodWNH?=
 =?gb2312?B?bjVFSEhTQzRKdXVITW8yWWFTMHpQVFlLU1ltRWpJMXBuWkxWbGJNa3ZueVJ2?=
 =?gb2312?Q?mKeV1GUC/i/Tz2ZFCR?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4216e3-7706-47d0-54a5-08de7ffd6ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 06:06:01.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEfaxuukETjQpycyZY8Wm6zIFXD5pmPUPtTS2r8anWOlZO+lUtM1ngRxl43uXHZuixMfTy4J+3oERt5LiYR3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12297

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+DQo+IFNlbnQ6IDIwMjbE6jPU
wjExyNUgMjM6NTANCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBM
dWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IExvcmVuem8gUGllcmFsaXNp
IDxscGllcmFsaXNpQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgV2lsY3p5qL1za2kgPGt3aWxj
enluc2tpQGtlcm5lbC5vcmc+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbmlAa2VybmVs
Lm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzDQo+IDxi
aGVsZ2Fhc0Bnb29nbGUuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3INCj4gRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgSmluZ29vDQo+IEhhbiA8amluZ29vaGFu
MUBnbWFpbC5jb20+OyBHdXN0YXZvIFBpbWVudGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9w
c3lzLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIDIvMl0gZHQtYmluZGluZ3M6IFBDSTogc25wcyxkdy1wY2llOiBEcm9w
IGRlcHJlY2F0ZWQNCj4gcmVzZXQtZ3Bpbw0KPiANCj4gR1BJT3Mgd2l0aCAiZ3BpbyIgc3VmZml4
IHdlcmUgbG9uZyB0aW1lIGFnbyBkZXByZWNhdGVkIGluIGZhdm9yIG9mICJncGlvcyINCj4gYW5k
IHRoaXMgcGFydGljdWxhciBwcm9wZXJ0eSB3YXMgZG9jdW1lbnRlZCBleHBsaWNpdGx5IGFzIGRl
cHJlY2F0ZWQgc2luY2UNCj4gY29tbWl0IDQyNjk0ZjlmNjQwNyAoImR0LWJpbmRpbmdzOiBQQ0k6
IGFkZA0KPiBzbnBzLGR3LXBjaWUueWFtbCIpIGluIDIwMjEuDQo+IA0KPiBMaW51eCBrZXJuZWwg
c3VwcG9ydHMgYm90aCB2YXJpYW50cyBmb3IgYSBsb25nIHRpbWUsIHRodXMgbGlzdGluZyB0aGUN
Cj4gZGVwcmVjYXRlZCBvbmUgaXMgcmVkdW5kYW50IGFuZCBpbnN0ZWFkIGxlZ2FjeSBEVFMgc2hv
dWxkIGJlIHVwZGF0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+DQpBY2tlZC1ieTogUmljaGFy
ZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJp
Y2hhcmQgWmh1DQo+IA0KPiAtLS0NCj4gDQo+IEkgd2lsbCBmaXggRFRTIHNlcGFyYXRlbHksIHNv
IGFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggdGhlcmUgd2lsbCBiZSBidW5jaCBvZg0KPiBkdGJz
X2NoZWNrIHdhcm5pbmdzLiBUaGF0J3MgZXhwZWN0ZWQgYW5kIGZpbmUuDQo+IC0tLQ0KPiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3NucHMsZHctcGNpZS1jb21tb24ueWFtbCAgICAgICB8
IDcgLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9zbnBzLGR3
LXBjaWUtY29tbW9uLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL3NucHMsZHctcGNpZS1jb21tb24ueWFtbA0KPiBpbmRleCAyYzRkYzA0Zjk5ODQuLmRlYmE0
NmQ3YTkyNCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9zbnBzLGR3LXBjaWUtY29tbW9uLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9zbnBzLGR3LXBjaWUtY29tbW9uLnlhbWwNCj4gQEAgLTIwOSwx
MyArMjA5LDYgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAgIC0gcGF0dGVybjogJ15wMnUt
WzAtN10kJw0KPiAgICAgICAgICAgICAgLSBwYXR0ZXJuOiAnXmNwWzAxXS1wY2llWzAtMl0teFsx
MjRdKC1sYW5lWzAtM10pPy1waHkkJyAgIw0KPiBtYXJ2ZWxsLGFybWFkYThrLXBjaWUNCj4gDQo+
IC0gIHJlc2V0LWdwaW86DQo+IC0gICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPiAtICAgIGRlc2NyaXB0
aW9uOg0KPiAtICAgICAgUmVmZXJlbmNlIHRvIHRoZSBHUElPLWNvbnRyb2xsZWQgUEVSU1QjIHNp
Z25hbC4gSXQgaXMgdXNlZCB0byByZXNldCBhbGwNCj4gLSAgICAgIHRoZSBwZXJpcGhlcmFsIGRl
dmljZXMgYXZhaWxhYmxlIG9uIHRoZSBQQ0llIGJ1cy4NCj4gLSAgICBtYXhJdGVtczogMQ0KPiAt
DQo+ICAgIHJlc2V0LWdwaW9zOg0KPiAgICAgIGRlc2NyaXB0aW9uOg0KPiAgICAgICAgUmVmZXJl
bmNlIHRvIHRoZSBHUElPLWNvbnRyb2xsZWQgUEVSU1QjIHNpZ25hbC4gSXQgaXMgdXNlZCB0byBy
ZXNldA0KPiBhbGwNCj4gLS0NCj4gMi41MS4wDQoNCg==
