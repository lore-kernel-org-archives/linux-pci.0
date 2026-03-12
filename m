Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5D331A7B;
	Thu, 12 Mar 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295562; cv=fail; b=YRYswOOmwPkp7AIEsLV0SNLGxU09i1lNP6b8Y0bAhDtHUW/ZuuX5NtCpNbtk1zFPaHdodCxGwpHg285hEvEt119tYJObKh/Ibo0WvQ+y10PasIqoOThvYQXi7zPOUsZ8B8R4EW6Vqs7MF77epslVwASfTKrto5anYdqJ65ZE5CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295562; c=relaxed/simple;
	bh=xahPoXuG1WBcJ6iaGi1gXf4PW12dQnpw5kLFASJYOYU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WUNwBPEwKoDOxxPAd5w/pXotTkRkFEXG+zwiZVF4SLRXr9PlP3434FaLqzxFybMsV5vha3GDCuEFFy03oPPrKWFBblZsvwv/K89GwkOWuNn5Qa6gNGBESs9QuBAcsDpQ5z/Zeec9DaDEYltc7dTF8TSpn1tesSrCtJhjAB5i8ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHuYEDqO; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHuYEDqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5xxpYmdR9H8nI/n52ZJp8NpMUZWwty1OcqOqRER2nLZBoPzDdYFxKrAVTnAZTv9Sh9Hrly8llSY1/K56tj3fGBmlzwdM2HbKUXppaXS7t8cfWMrxfevmG3Wnnn/WWOYVXKDbvtWM2zIZ1ZstlO6eFwA33JT54ser/CUdoyTt/6Qf6sQJv24vLPPnpxxuPBFxpHL5tCfg6+PgNKnQuuNS3v07wz3h2VQEnW1hQYruinUMZNGV/4MvN0U2SKa9/b/TdcXPOfgQh3wzT8BHTKhoq/3rnkSJ8jPmBHnTE4SeOVNnfK995P1xE1WeMCn3xMrlk2KFcsFZDKgpQRjN1i+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xahPoXuG1WBcJ6iaGi1gXf4PW12dQnpw5kLFASJYOYU=;
 b=hnD2nQwvxY6xhrsGytikMy6AekxFct5oRNo3oP7wnbk+gkXBx2EpoctPeO/m49JZ52cXJVFit69AIvM4hMxO857zZFTj7lFUmVPNyUzJgF6qVdUI9TiCxcGHE2ftvjKQccj2UBUvYuBqnVaq7iPCfiw/VDdiWC4etNDtozdsyrcS7P7IV4vEi80DYKwyHiqfMOUuJicIOHD0a5lGSeBDdUBP5uT0DpaAIr5cLf/rwtESMGIHQ8VNMejAjoZEOxIhqyYbk40bs2MQvpnKaGZk1gsPo0QLbTzhXaVyi+ReJ7ekG+zwGJnsEr3SlR5j5OAutLZkaOMF/ueB9lXLEPTDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xahPoXuG1WBcJ6iaGi1gXf4PW12dQnpw5kLFASJYOYU=;
 b=YHuYEDqOzl3Gt7+60hPINYlkfZ+yqIJx55FO5o35afjQvldUvLQqftJwdTxhI8diH6TqM7iiVWirGve1JUicGGiPmPoscVu6/I46v4q59DaXEns+wmALW5U9gHTqPLexkcFdXbk0QcOY2aUIkMezFaLyPv6/j/OELVQXCZ2/RXLBh6ZW5SWd4dKqnrFAIBcYZb5mP70wnj7tjRM9p90i3OoL7G+Aj1/Ypi2srYKiyV9mtNtBFnJdnWTObhPJ61WKgMFnwkMb/WTLIjGrsRMlLWoEl2x/NYmn7JQ3LTEIQkgz7oQ1BRE4A7ZY3k82DXnu5WX5d/xjXOBZaP5a3Kx6Fg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB12297.eurprd04.prod.outlook.com (2603:10a6:10:629::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 06:05:56 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 06:05:55 +0000
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
Subject: RE: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Switch to
 undeprecated reset-gpios
Thread-Index: AQHcsW66kS1Vq73D10iWQtzVjwNm7bWqaDIg
Date: Thu, 12 Mar 2026 06:05:54 +0000
Message-ID:
 <AS8PR04MB883343DF61A7F730D1302F6D8C44A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DU4PR04MB12297:EE_
x-ms-office365-filtering-correlation-id: f5ed292f-fe8e-43e0-56b2-08de7ffd6c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 +bi9jZdonsjSMKwykIn962roFc/IdO4epphAOTpJb2Eu/TwtTwyC5IDHP4Qn2oU2mWLfDyk25TvvcQNqDxBtwSKthdKp1uiZ8OosCcgKDaWUySd2DDn1LpDsU+vwh8XtjZs0rubMKxUmkmgEBkzt9K4k/9L5JLZkvp7Ep9zBkSsMSW0YhQ2FkXXIRM3nILMi9+WWnpbhX9g2wtV166ONqLqawQJ2cXEqK3t++zmhvJQ/AeoqqGHR+53qpZcFr82KItVwToNhtaobnL7E/RFsy6mFdLZBNo6zge7imqI+yGnA8+JMfVn0TWWg78XDIu+V1ogVoZ22ohAOMJMSN3kBQCxQee5wZpu4rrJU02nedGQukYm4jB/MAb2jN/bMfs4PqCLcNzl9WkBIb+dEFBPk/uLw9omMr5XUAXJK3Qf93bNUP/HJhT91QAdQ9FPC77HoWTkZnIyitv9toSOo2SjZHmJflTclxefEQQykLAtVjVN/Zhs0LHnkuMUDh5bOf0cWg98lvkurppE7lIO7d20zLLL/W5zo5j1QgpnJV3npDsFtSc+YtrgozkVMRPzbr+a7dNo4lgJoXQP7Ycj/UKkPS6SbHyfwUCdIkaVKegALr3vGb6JruZ8izrHgkib1A5eFmdRzAp0a6bKRAhVNuGusKHldxFxFXQf5J8MrPwPxuPX60KEEt7YEnNo0jcX8K9nQxs6P5vJzmdh2eQmbZJGPO23LgEaNy+FbqcqV1aRJ9YBarspTQGUH9uV/yerH7GbjL3uVkoKyDwp3Di11TDoI9KiaYyoKL+Pyc+WdfJpWmxCcfjj2vRfYOPrL+xns8QVJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VXBCTytOc1JPM3U2bE1Ic3lHQ3hTUkllUUZEWHIwcGE1RCtLakJRY1NTTFZu?=
 =?gb2312?B?SFk3TXRpaVZrM3h6amQraGVZREdqREZubHVGSkNoeGs4c1NRZ2tUSjU4RVZ6?=
 =?gb2312?B?dEtTUnZmY3FuQnBsZzFKS2R5cHdUQURYckZ6M2FNWEt0OUJMMTRaTXhBSkYz?=
 =?gb2312?B?ZkY3dnF2cUJKNVBmU291bHIzU2VhbGhlUFVwRUM3RXh6YmhwZFlWTFFhMkxW?=
 =?gb2312?B?YUFZdUtFQk4xc3RUcWtyNkZPNnpUdTRndkE2cFFYYkpySDI4RmIzQytmNzBq?=
 =?gb2312?B?c3pzc2x5cSs3dGxzcmpXWjc0Y1MxSmpqTytmbEcwd0FZaFNiRTRxKzBmTndx?=
 =?gb2312?B?cGl3YWdYeWNrWnphV2xmS2RWVnVyQXVaT0Z5U2pIMlR6UXIxWEdkc3pneDFG?=
 =?gb2312?B?L3ZZamNVQnB6eG1SR0ZOVmpkekU0YU9NN1lLcStQTDZzU3BXOG5VTUthTW0v?=
 =?gb2312?B?eXZyT0wwZzVQeHZyWWpzZ1M3cE00b2F3bjB1VThaaGo1MEo5WXhsQjdXc0Ir?=
 =?gb2312?B?eTVpdkxudEFObmVZalIxZThPQTgybGJUWGMvTGNudDUrMWZTaC9MRW5KNTJV?=
 =?gb2312?B?SVpMZ1hTb1JIMWRWR2xQZ2grWTBzZXBPU0dqanpFSFRrc09WR3hUMGF5Q0VV?=
 =?gb2312?B?bnQxaWU2OUhweFNJSXp2YlBva0pHelVXWUdjbGxpTUgydmNyazd5VEdldmVQ?=
 =?gb2312?B?NjhYd2F0V1hkUmMvc1FLN0FpSzZOVjMwZlFIbUpwZ2FQMlgxL2JKWDFUbzF0?=
 =?gb2312?B?OHRYTElTb2FNdzdjNFlDTThuS2wxR1R4Qk43NEZCNW84Y3lRUE0vR2ZydTN2?=
 =?gb2312?B?NExpcmNocm10Tjk3d0NpYUpVdTRObk53NkpINHVtd3lPNFRFSzRqYkdzNVF0?=
 =?gb2312?B?aE1hSmgrWW9KcVBVSERZd3B2YmJRQXRmY2haQU1ZVERHNi9xR05ab2lnZDdC?=
 =?gb2312?B?d3VvNm4wNzh1Y1FTK3l1SkEveUNTaU1HcFphRzhXK25JdW15cTJ4cDFaVXBi?=
 =?gb2312?B?TDBMM3JGYTNrVDhOTWU1cHFtMVhjMlZFcHBkMTFBNVZjZXJUOXNoUEE0RUlD?=
 =?gb2312?B?NnIrblpuNDhTQXNKSGtVb2pHSENLQW5Ud2V4cjk2SUN4OFJldk1aUktRZXI5?=
 =?gb2312?B?SDc2cjVxYkJ4T3VCN0c5OTZvQ0hTcFJ4dzRxREJNTk1hWlN0ZnlJZTNXNy9j?=
 =?gb2312?B?eWRZYVh6QkpuZ1Z4eFhpeVZJbnZuTnRXdlhYeE5ENHJCQkZZcnAxWU51MFRw?=
 =?gb2312?B?aTFSamlFWVJ0L2hOdjN5UG8vUzdnb3VPa1BVSGQrbnZYczlFSENpNnlwaEUz?=
 =?gb2312?B?TnJhL1F2MUJGdnBCWnZmTG1wVFM0V1dqdm13b1ZEQ0RPaDB4WTVpQnY0VDlv?=
 =?gb2312?B?bnVQZXlmYjZuTE1NTVhrN1BVS0VDTE1uUk5HSExDTUxJYjBUZnN5ZlpjdTNa?=
 =?gb2312?B?R1NqcEYxZDRJRDQ0eGFsaGx3cm1DaUFkaGdZUUNDTWxLOEpLNzZLbTNpNnNV?=
 =?gb2312?B?RXE2MjZoV3VFRmU5czdSckRpTTlzU3RVNkZkRk8rdFdhTEJRS0NiTGprRTMy?=
 =?gb2312?B?emdyTUowRmVXQW9aY1Ztell1Zk9ETDd1aXBKV1ZOVGlmVDdiQm9FanFYdVNj?=
 =?gb2312?B?Y2Z2REo5MFpEVXdndzhKM1VTNmszakQwZVljWmFzRDRKRTNkRDJTck1MSEo4?=
 =?gb2312?B?YTI4cnlUK1NHMDFIc1RXT3JwU0xiNzVFRDZueVE1dndrRXo1dEdtSHhIUU82?=
 =?gb2312?B?VDlSRVJQcjNIbGtVd0tnbTAxOUJiV2dlTUJMUHUwZFpxaktxZjZrZTlNZGJt?=
 =?gb2312?B?M1ljY2l1ZFpQUzBxUGZRYktFMU5PVVVabGNGK2VtM0tYQTNwbXJEdkxHcXcw?=
 =?gb2312?B?UkFoYjhUam44WDdmRkY1ZEJ3aXFlc2pqTXlWTkhkamplZVN5bnBSYXJJZkU5?=
 =?gb2312?B?VzVwQjl5WjVFMzZoVlRzRTZ3N0c3U0E5M21oNkZ4OTB2WXArSHdVTGVpcUxm?=
 =?gb2312?B?M2x1eHBwZlkzRkZWcnhVdXBwNGh5N0VWNENieGFJdlpsdW93VmFJUXoyMldh?=
 =?gb2312?B?V3MyQzB3djhjazRtUlhlaFUyZlMvdzN6ejdkaGsvRXpmWEthNVZLdXEvY0h6?=
 =?gb2312?B?anNhUUZWMVR3OUxobEYzZzBoeEJ6OWJFMzVpcTBzUnE1UERXOGN6OW9Eei9S?=
 =?gb2312?B?dUNaSmlkK2c4WEpEbWtJSkFhNDI4bUlLdWJNb2FWLzY4YXdwY0pmbWVSMUVE?=
 =?gb2312?B?eWIwMUhMUHhNblo5ek9YWmVHSU83N3h2WHcrMm4xTzFPQmwvMFdKMmhZL0t0?=
 =?gb2312?Q?xWXG1ouktnXtuAte0X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ed292f-fe8e-43e0-56b2-08de7ffd6c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 06:05:55.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psWoEPMy2uCyEuSxwKVLbeYZvml+8Qxlo8OkWRmREOIfbdgJuIhL6M7RsQOzygClXAmJvxw8mbWDEOHhppFkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12297

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+DQo+IFNlbnQ6IDIwMjbE6jPU
wjExyNUgMjM6NTANCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBM
dWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IExvcmVuem8gUGllcmFsaXNp
IDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gV2lsY3p5qL1za2kgPGt3aWxj
enluc2tpQGtlcm5lbC5vcmc+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbmlAa2VybmVs
Lm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzDQo+IDxi
aGVsZ2Fhc0Bnb29nbGUuY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwu
b3JnPjsgQ29ub3INCj4gRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgSmluZ29vIEhhbg0KPiA8amluZ29vaGFu
MUBnbWFpbC5jb20+OyBHdXN0YXZvIFBpbWVudGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9w
c3lzLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAb3NzLnF1YWxjb21tLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogZnNsLGlteDZxLXBjaWU6IFN3
aXRjaCB0byB1bmRlcHJlY2F0ZWQNCj4gcmVzZXQtZ3Bpb3MNCj4gDQo+IEdQSU9zIHdpdGggImdw
aW8iIHN1ZmZpeCB3ZXJlIGxvbmcgdGltZSBhZ28gZGVwcmVjYXRlZCwgdGh1cyAicmVzZXQtZ3Bp
b3MiDQo+IHNob3VsZCBiZSB1c2VkLiAgTGludXgga2VybmVsIHN1cHBvcnRzIGJvdGgsIHJlZmVy
ZW5jZWQgc2NoZW1hDQo+IHNucHMsZHctcGNpZS1jb21tb24ueWFtbCBsaXN0cyBib3RoIGFzIHdl
bGwgYW5kIHRoaXMgc2NoZW1hIHVzZXMNCj4gdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOmZhbHNlLCB0
aHVzIGNoYW5nZSBoYXMgbm8gaW1wYWN0IGV4Y2VwdCBjb2RlDQo+IHJlYWRhYmlsaXR5IGFuZCBy
ZW1vdmluZyBkZXByZWNhdGVkIHBhdHRlcm5zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KQWNr
ZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NClRoYW5rcy4NCg0KQmVz
dCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sIHwgNSAtLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+IGlu
ZGV4IDEyYTAxZjdhNTc0NC4uYjliYTkzOGM2MjM5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1s
DQo+IEBAIC01OCwxMSArNTgsNiBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgLSBjb25zdDogbXNp
DQo+ICAgICAgICAtIGNvbnN0OiBkbWENCj4gDQo+IC0gIHJlc2V0LWdwaW86DQo+IC0gICAgZGVz
Y3JpcHRpb246IFNob3VsZCBzcGVjaWZ5IHRoZSBHUElPIGZvciBjb250cm9sbGluZyB0aGUgUENJ
IGJ1cyBkZXZpY2UNCj4gLSAgICAgIHJlc2V0IHNpZ25hbC4gSXQncyBub3QgcG9sYXJpdHkgYXdh
cmUgYW5kIGRlZmF1bHRzIHRvIGFjdGl2ZS1sb3cgcmVzZXQNCj4gLSAgICAgIHNlcXVlbmNlIChM
PXJlc2V0IHN0YXRlLCBIPW9wZXJhdGlvbiBzdGF0ZSkgKG9wdGlvbmFsIHJlcXVpcmVkKS4NCj4g
LQ0KPiAgICByZXNldC1ncGlvLWFjdGl2ZS1oaWdoOg0KPiAgICAgIGRlc2NyaXB0aW9uOiBJZiBw
cmVzZW50IHRoZW4gdGhlIHJlc2V0IHNlcXVlbmNlIHVzaW5nIHRoZSBHUElPDQo+ICAgICAgICBz
cGVjaWZpZWQgaW4gdGhlICJyZXNldC1ncGlvIiBwcm9wZXJ0eSBpcyByZXZlcnNlZCAoSD1yZXNl
dCBzdGF0ZSwNCj4gLS0NCj4gMi41MS4wDQoNCg==
