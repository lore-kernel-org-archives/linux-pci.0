Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865B28B40E;
	Mon, 26 Jan 2026 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411603; cv=fail; b=SZ9kIru/4qBdNadae2NIzuDURbUZwtbzQ9tJLc4JFjfPlw/OqhlH9MuA9KhFUmOj/yfUUGbBkt80/cbYdvQy6B3fn+oJfJjclhOhMvrmqZM5GdWY0vOpzsgs1VvhUc4PwRvB/EHNoQHBB6QeVf8QpnczNUquKW4Lrmr0ZKmhZPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411603; c=relaxed/simple;
	bh=p6wGKEKw5PNH+SNHDCgZYag+WjbJVHpN4Oxadeisj1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTl8qOw4D8vFA4PSq6co41hE6/+Drla7tg977w+02RJzVovOtyWwAQm4bMZXzy8E+MabjChVzgDfuBSVMDVCs6ITaHUa2NuW7RsZ+sPbFYujskZa+1HhAzmBby2u4BK1WB93GBiBAWtBvOWRdtOMJFYv7RSkGBjb3iyw6i/P/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rc/ttkXw; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rc/ttkXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvk9zyEdJTY9ACJjcS+z367rftjX3OvgY1Pu5uUC6R3bPR7WpF1iot0tuTk6OD1XYtCgndYw1npN55MJbY6ru1nEtpkNgD9xZNG2ljj6iKYPZBZeb5Sipi5A866vvOmKBQRZzKQzLkEUfoqsQbMcCpS31r/wQpyeaTlk3ZTu1Cl7O/vpObnlKp0KVdI8I0rsaRkuFyi3Bv9FR9jJWdCV4C07Fz0KzqPwUwx80A7DOL3hDzfT6pSjVfaDXi5BKWo2y9nOfrAYH3WLI1BUI9UumC51tL/p7kLHraoEU7jCa1ezF10gl8xHQbygqp+/c1T/ZK1UQtFOfPUJviv68801bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6wGKEKw5PNH+SNHDCgZYag+WjbJVHpN4Oxadeisj1A=;
 b=RqQk0khdPll2oJD50YLAQ0JZJkepre7UpAFqRlOqlLERPZBhR6+nLYVE8+4PFM/+zuwP3sNniPK9Rm1J86hrG3tDrtn5SfrrnkHXVo/D1hTbcVNxZGSKQ4ipMrSFsopkAxuwU+8SsWSCe1Qq4kJi+YWMoRe+HNA3MfxDGU2wwz/CxyIxvBnAVsm+tSmgLBQxr7CxvV65X2f2NFJvimSqBSUTg61d550aFX6Znfc4aW58Ao+mf6MqTKbc0gF6zOFvMD/rkTHZXNPaQApoFp93Flp19xS3wvHBcvfaw21e0m5SJLgjrxcnmHwBmWusQA89AkW8gc/FYCBJ6seKwctzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6wGKEKw5PNH+SNHDCgZYag+WjbJVHpN4Oxadeisj1A=;
 b=Rc/ttkXwFdQbfCQwARucGtb0CcbrDT1VTlHmyc0eBVQHvS8x1GsxJnEFwc8gu7ongWOd7CrFn4oFAEtOqJDbZwbw8H4HV2zj7WvB9TcS9rNMr4Bv0LjhbWSHAPEVCTvd9RjRNQJW+XcO+mzdyDWHvgwqWp1qyi+DJbl2vcTeNqWwSOAj6HAIImznHh740/P5mMVGPzf70jgtMBPVl59sapbb1MBnZb+2L1xAOwMy2MeHHh928J+oOTe63hin2bM1CMaPMFTc6USI1vxPnV/VR5Cj8KeJxPwoeU9+mqmtd2Mc2F/c1nEsQWjnZ5rxoQnhV3zCUTZ/Q4jK+JIA0E03Bw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 07:13:19 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:13:19 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Trent Piepho <tpiepho@impinj.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Thread-Topic: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Thread-Index: AQHcjVBRoi1mVdIF00+KLWRFNF4IOLVkCoMA
Date: Mon, 26 Jan 2026 07:13:19 +0000
Message-ID:
 <AS8PR04MB8833845E3436CFE30EDEC2E98C93A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
In-Reply-To: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PAXPR04MB8285:EE_
x-ms-office365-filtering-correlation-id: 459f849b-b072-4226-3de6-08de5caa6240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700021|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?UkpEMk5ORVFHV0hIa3FOSzZNcnpJMTVuYjNkdzNzUjZhOGsyS1pHRjN4Ymgy?=
 =?gb2312?B?SmdyZm5CRk9xMGNOTHVoUFBjZ1lYQW1CWkkzQXM5TXpBQXpFK3cra0diNTd4?=
 =?gb2312?B?OENaNm5oTjNNTDQ3S0FSWjJEdGdXVmxONnp3cjFwc3pGZEp6bWZ0Z1RaUDBF?=
 =?gb2312?B?RVFnNER1cThlOWZNSVFuQVJpdWptOFVlclhzMkRpeW9vaW5ZZE9CSHE5Z1hZ?=
 =?gb2312?B?RXJ3ZzU3Z3RneUtPdHdnME5EeTcwSnNpRmk4MG5YaitKeHNURkZYTG9DUU9s?=
 =?gb2312?B?SldWTG5wMFIzdG4wcnFjNFhFT2UyZlc5cy9SQWdoZzF3RzkrOHU4c2tpM0pZ?=
 =?gb2312?B?ekhyVFBPbVc5WXVzcDJST3o2MUZZTXlRUUhjY2I1bTQ0REhUUWlhSnRrMWY0?=
 =?gb2312?B?amJPTVZxZjFjSzM2SU1ySFN6SzlPLy9Ya0dhOGFWM290dGdVbXQxWHhNNERM?=
 =?gb2312?B?YWN1UUxYRVllWG9oeW1abzlFU01wQSt1bklpSFFNTGpZb1dndTNpVFAyN09p?=
 =?gb2312?B?am5mMVVJejBiOG43bzM2b1NIQTczdnBNQW12MGNnbkNSZysxSTFDUTZ5aGFp?=
 =?gb2312?B?d3hERThqaXNZWjg4ZzQzSG9PQVg5a085UXo5V1ZJbVREdE9PNVl6b3RMbkdW?=
 =?gb2312?B?RVN1M2J3VmwyWDhCMmpVM3NVdzNkbTNodDZMK0Z1TXdWeXVZd3hEUG5mWmJW?=
 =?gb2312?B?dkZ3Mlh1M1M5Q3lvSkRISTI2OGxqdDlCUVZSMitTRWFpSGtaNldJNjNFekVP?=
 =?gb2312?B?ZW5mSEtVUW1MQ3RnMVNrMXdCRE1KVEJydTVYL1E2WVAzNktvcldabEYxWm5Y?=
 =?gb2312?B?S3FPSjlpRVg2bnd6Qzh4OTNQenlOVmd1YnNLUTdMVjRNLytLdnkzbTdjdVdW?=
 =?gb2312?B?b04zRnpuenovREJnRDZEbE11RFc1aVRHVE1rNHc4WTZ0N0NKV2gycXdIWFgw?=
 =?gb2312?B?dGMzYkpKY1VtR3ZaekJLeEFVcEIra3hHSnBRVXIvNkhGbnovV1Y1OVpRanZv?=
 =?gb2312?B?bktWL3NMZVc5Y1RZYmRkbGhLZDZWUjdGdjFnUGFiMDFBNVY4WVhycDZvRXJF?=
 =?gb2312?B?a2FPbHdQcHNlVlEyMDhPNVF3eko1T3NVSUJXYUVIV3BWcWRvclJxclBpNmx6?=
 =?gb2312?B?N0ZxRHowRGRiUUNNTlhzSTdWTEdCeDVKckVEY0pMNFArMmk5aG03bTFBN2Rv?=
 =?gb2312?B?ellMdktQN3pIY09DL253TE9wbXlwWHhhOCtjUVB6VlYySE9UWE1MM3g0Q0Nk?=
 =?gb2312?B?cG1PdXRVa05oMVpWeVpwQmFxUG1qalB6NEw4Z25GVTBXeXVmU1NMY1lRNjhm?=
 =?gb2312?B?bmJmV3BNY3oxVFZ0cFpNekV6MnZZRG1mWlB3Y0N2TkJyekg5cVkrYU9XZnAr?=
 =?gb2312?B?c3dJMmcvbzN1WFZsd25BeWFIenA4RWQ2UFlnTlRpRUFRaXBCNE02WGJQbWNm?=
 =?gb2312?B?aGI1THluamVNQll2OERFM3NoMGdNbWJxL0MzR2tVQzlkaTIxeHoyTU1GVWdR?=
 =?gb2312?B?aWlKUEdYWWZtZGFPSVNmWVdST1locEk4L0lFMDNWMmtjeEZZYWUrTUhxeHlT?=
 =?gb2312?B?eFg4OXhvdFlmN0Z0NHdZaVF6UE1tQzgyanB1T3VVaGNyeU4zZ3o2TXRpYXZL?=
 =?gb2312?B?aXl3aHZwT05EdnpRVDdESW91L2FlbnJLa3ZBbEpHbnRhUHJ0MXpTa1A4dXhK?=
 =?gb2312?B?T0JQdjY5d1BaZVJkY0Z6Qld0N0JjdVlZd3VvZGVpMjlvdEpyb0ZaaWVJNWNB?=
 =?gb2312?B?U2lqQlhBY1Z0akM5Y094cFY1bW13bGtnYlN4V29SWUVBb25JRUZRb0lHeDlP?=
 =?gb2312?B?K1ZGSElNOVBSNzNoY01tRHpRSTJxTDE2VTZoQ3BSdGgyNXBlMElwQVQ3MHFj?=
 =?gb2312?B?R0JoSWVNY0xlTEhDYlJqMHhNZTZiYjYzQ1luM2VwV2xlNVV5QjVvbmp4eEIv?=
 =?gb2312?B?UUxCWGk4RDhDTXVKS2FEUkQzNVpUaCtXVVExVFgzcTBmd2ZiZlREajJBcW13?=
 =?gb2312?B?cGcyVW1DNmxYQVllVHBCZUpSUU5xaVRzYWJqRXkvdFVOQTgxOTJNdVdaUzNN?=
 =?gb2312?B?Y2tEWGVENHlTaUttOWRNQmpFVGY0eXBRWVp6U2ordXBpKzNONUgxKzFGZFl5?=
 =?gb2312?Q?sI7gsGbS6MyIx/uE2UjGqL16X?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VEFBMWNDVkNuTmlnVzJyQmwyWmNDNEFhZU1iQjhYdHVvN3VQQXpvdFJpbk9a?=
 =?gb2312?B?Q1BmWjk0L2hiOEU0aVd4OGhweFEzVk9PSUU0R1FLKzlVWjNiSDJDSnlBK2Y2?=
 =?gb2312?B?dm9CcVlpaGFSSnRZU2pVemE1TEVnNUc2Wll6aThnWTVaTUh1dFJpemE1WUwy?=
 =?gb2312?B?SlhvNjB4T0hhM2JybVhCaElXZTQvWjhUNjRBUUUxeXAzOXVBMHUwa0hYNzBi?=
 =?gb2312?B?U3ZxZm9YeEhReFM0MHoyMVdVeXhpU1lSLzM0NlIrTFFGRitTb3YvYjhxTzFE?=
 =?gb2312?B?UUI0eGdZWG0ybkp2ZTU3NWcwZVVvanJaenJtMGxpZ3FrRHdlUVdQWjBqOXpt?=
 =?gb2312?B?dHJaSitLNkFwdGVPSmExYUYzUUc3M2l6dG83RlJ6aVl3bEM1S2RZN0VEN3Ar?=
 =?gb2312?B?Qkx1VmhlQ25vVFgwcWlkTXkwSkQ1S0JuNlpLOERtYnNTTGszNVowQXgzTklL?=
 =?gb2312?B?OEFFNS9aOUpMa2FxOWlzZ3d4YllSeVA4R3RiNGcyaGhWa2IxR20zK0RKTEsx?=
 =?gb2312?B?L1JaQVJ3cmxSNHNzQzdQWWdyNjM4V3BkV2lVSEpoTVNJWkZvRlBMY0g5cmJp?=
 =?gb2312?B?bFhyY29yVjB6WnhYN1BUSFlEb0ZJNXN5SitzS0RmOUdwSWRCVXMzQmt5cFli?=
 =?gb2312?B?THFnRUlFZGdwbElvYzRWbExKOEpFMElzL0FOOVRKMEUxazNXWlFxZFNVZVVQ?=
 =?gb2312?B?N3B3OWdWTkxRVHpYRkFkTjErSXlpdVEydTZ6R3VYbytvOUx6d2JYZHJpL2gy?=
 =?gb2312?B?L1ErUTdPSmhZMTIzU1hqaHVGR3FIVGhiTUUvalFsUEVVb2x3cWljeE4yTldH?=
 =?gb2312?B?ZGRDRGh0cklacDR4cEJXSnVMY05waW40bjV4eDRaQ0tnWXlHazcyODBOZlRq?=
 =?gb2312?B?N2JxOEhNYjNRd3Q3Z054L1FWc1pwUWFlM3hGVDFFNDlyblQ0MTcrN3dteGM0?=
 =?gb2312?B?bnFxQ1czYnlLZ3BRcjBNd0tRMUpZMUJqOVN1bUVBZ1hyckg4eEhyS05MVmlK?=
 =?gb2312?B?WS9hNHRSbEhVL2tBU01SclJNRE5pSHpubFZXN3pxZXFXWUxLWjZSZU82MjFh?=
 =?gb2312?B?YjVieDZ1bThvWXBxeGM0aUxMYVB5VHpaL3hhTXBCRi9NRmhSUkZxV3lJM2Q3?=
 =?gb2312?B?UEo1QmE2ckFLVjZGdWlrajNrSml3MVZtM2VQcm9XTklhNklUQjZORVdhRlNS?=
 =?gb2312?B?SEIvenQyS2hrRER4R1I4K21UYUNVQnJpY2NTbVVHN1NXNDZjRElSZXh5b2t6?=
 =?gb2312?B?R0h2WVVUckxMZDhvNzlOZGFscGk4OUNCK2t0aXdUbnAxN1ExQVE4OUVUODNj?=
 =?gb2312?B?d3YrZW8xYXJ2VU9sM0VHN2hyV0N0S2J0aGRpRFYvL1M3c2FrODFuRXBlTHFs?=
 =?gb2312?B?Qkc4MXUxNlhVcWxCMHYyQzBrbHdBRHJNa01WK29VQmNLM3F2OHRhRVhEN3B3?=
 =?gb2312?B?dGxRR3NqenY3eE9ZS1J6VDRBRUczelh1Vm4xdlpreng5UW9EOXg3SElVWkZz?=
 =?gb2312?B?Q2FHTWFxbmwyS3JWS3lOZHYyakVFVTI1aWswRWlxdlgxeGhleVFUczNMUEdx?=
 =?gb2312?B?cWJ6aThkR3NUck5LSkpnekM4bEkvbCthSENwYnQveklURnJzeHBFaWlzQjRt?=
 =?gb2312?B?cktlY082WW1UMGd0L2p1cFVnVnFGWGQ5SkhqOXlJc1crK2Y2Q3NCalV3d2xH?=
 =?gb2312?B?ZXo3TkZiWFc5OXAwU0pHVTZZN0hGUVhBZ21lbEQ3TXNJRTRnZHRiZzJWTmV2?=
 =?gb2312?B?T0FLcEZPcTdOMGdjZElvVzFDY1o5eG5BSnFncEdXQ216UjQ2VFJzaG1wN1Ja?=
 =?gb2312?B?SENmM042SjNMaXRHWHI0d0owdGFWRnF6UERLNGl3V3Z3cjhRbitWQUlTTzNx?=
 =?gb2312?B?M1dKcFdPY1Z1OWVoRnQwTjk3U00vSE0vZDJLb3hqaTdsUTVyeFk0Yld3ZU94?=
 =?gb2312?B?VmhYSUNiUFhhS21zR3BPUXcrRXU3V0F2NTl6SjRLMDY4M2w2d2ticEFsaHhi?=
 =?gb2312?B?bGZFYVUwd0d6ZWl4ZE5QS2FncEprdUkzb2VwbmJsQTFZVzczYy9VczExNi9n?=
 =?gb2312?B?c1FyWjg0aXN3SGtPRDEyV01WRS9HbjJROUc4YlBHSFF2NW1zbHlSeldZRmk2?=
 =?gb2312?B?amVTOHptQWdUemR4NHIyZUlJNW9wWU10aWZCZklxNlBwUWFRTXBiUHZtVXZ0?=
 =?gb2312?B?Z05qeW9wUVdmQUVQZ2pIM1VqUE5VOGNmczFHVlQxR1RpaUpXM3VYWjEzMnB6?=
 =?gb2312?B?ZlNpRzNrY05LcXViekFWVEZrd0FLaGUvcTAyNERCei9LMFRYdlN1ZlRBMFJo?=
 =?gb2312?Q?ETk+e31GLVMlO25SfS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f849b-b072-4226-3de6-08de5caa6240
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 07:13:19.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Cbh0k6UNMFrVlLVFSlksM7zZreW5GNNjGbp2T5WSsL7Hdqxkm1JueZm+hjjw0bJw2zzCfbqxldM0oFCOKtX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGZWxpeCBHdSA8dXN0Yy5ndUBn
bWFpbC5jb20+DQo+IFNlbnQ6IDIwMjbE6jHUwjI0yNUgMjM6NDMNCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBMdWNhcyBTdGFjaA0KPiA8bC5zdGFjaEBwZW5ndXRy
b25peC5kZT47IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+Ow0KPiBL
cnp5c3p0b2YgV2lsY3p5qL1za2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+OyBNYW5pdmFubmFu
IFNhZGhhc2l2YW0NCj4gPG1hbmlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5l
bC5vcmc+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgU2hhd24gR3Vv
IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhDQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJv
bml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5k
ZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IFRyZW50DQo+IFBpZXBobyA8
dHBpZXBob0BpbXBpbmouY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGZWxpeCBHdQ0KPiA8dXN0Yy5ndUBnbWFp
bC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gUENJOiBpbXg2OiBGaXggZGV2aWNlIG5vZGUg
cmVmZXJlbmNlIGxlYWsgaW4NCj4gaW14X3BjaWVfcHJvYmUoKQ0KPg0KPiBJbiBpbXhfcGNpZV9w
cm9iZSwgbnAgaXMgb2J0YWluZWQgYnkgb2ZfcGFyc2VfcGhhbmRsZSgpIGFuZCBtdXN0IGJlDQo+
IHJlbGVhc2VkIHdoZW4gaXQncyBubyBsb25nZXIgbmVlZGVkLiBIb3dldmVyLCBpdCBkb2Vzbid0
IHJlbGVhc2UgdGhlDQo+IHJlZmVyZW5jZSwgd2hpY2ggY3Vhc2VzIGEgcmVmZXJlbmNlIGxlYWsu
DQo+IEZpeCB0aGlzIGJ5IHVzaW5nIHRoZSBfX2ZyZWUoZGV2aWNlX25vZGUpIGNsZWFudXAgaGFu
ZGxlciB0byByZWxlYXNlIHRoZQ0KPiByZWZlcmVuY2Ugd2hlbiBpdCBnb2VzIG91dCBvZiBzY29w
ZS4NCj4NCj4gRml4ZXM6IDFkZjgyZWM0NjYwMCAoIlBDSTogaW14OiBBZGQgd29ya2Fyb3VuZCBm
b3IgZTEwNzI4LCBJTVg3ZCBQQ0llIFBMTA0KPiBmYWlsdXJlIikNCj4gU2lnbmVkLW9mZi1ieTog
RmVsaXggR3UgPHVzdGMuZ3VAZ21haWwuY29tPg0KQWNrZWQtYnk6IFJpY2hhcmQgWmh1IDxob25n
eGluZy56aHVAbnhwLmNvbT4NCkhpIE1hbmk6DQpQbGVhc2UgaGVscCB0byBtZXJnZSBpdCBhZnRl
ciByZWZpbmUgdGhlIGNvbW1pdCByZWZlciB0byBCam9ybidzIGNvbW1lbnRzLg0KVGhhbmtzLg0K
DQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAt
IFVzZSBfX2ZyZWUoZGV2aWNlX25vZGUpIGNsZWFuIGhhbmRsZXIgdG8gZml4IHRoZSBsZWFrLg0K
PiAtIExpbmsgdG8gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZS8NCj4gcm5lbC5vcmclMkZyJTJGMjAy
NjAxMjQtcGNpX2lteDYtdjEtMS02ZjQzNzlmYzUxNjAlNDBnbWFpbC5jb20mZGF0YT0NCj4gMDUl
N0MwMiU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NmNDg5Mzg1ZjliZGM0YzcxNTA4OTA4ZGU1
YjY3DQo+IDcyN2UlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdD
NjM5MDQ4Njk3MDIwNQ0KPiA2NjYwMyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVV
MWhjR2tpT25SeWRXVXNJbFlpT2lJdw0KPiBMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtG
T0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJQ0KPiA3QyU3QyU3QyZzZGF0YT1tSlps
M2lBcVg3MUJlcHRraE5HemVQM2VFbEdSVURuQmhZYWJ0MjY1dnFzJTNEJnINCj4gZXNlcnZlZD0w
DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQgKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IDFkODY3N2Q3
ZGUwNC4uZjQ1OWQwNWVjZDdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1p
bXg2LmMNCj4gQEAgLTE2NDMsNyArMTY0Myw2IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gICAgICAgc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjsNCj4gICAgICAgc3RydWN0IGR3X3BjaWUgKnBjaTsNCj4gICAgICAg
c3RydWN0IGlteF9wY2llICppbXhfcGNpZTsNCj4gLSAgICAgc3RydWN0IGRldmljZV9ub2RlICpu
cDsNCj4gICAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiAg
ICAgICBpbnQgaSwgcmV0LCBkb21haW47DQo+ICAgICAgIHUxNiB2YWw7DQo+IEBAIC0xNjcwLDcg
KzE2NjksOCBAQCBzdGF0aWMgaW50IGlteF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UNCj4gKnBkZXYpDQo+ICAgICAgICAgICAgICAgcGNpLT5wcC5vcHMgPSAmaW14X3BjaWVfaG9z
dF9kd19wbWVfb3BzOw0KPg0KPiAgICAgICAvKiBGaW5kIHRoZSBQSFkgaWYgb25lIGlzIGRlZmlu
ZWQsIG9ubHkgaW14N2QgdXNlcyBpdCAqLw0KPiAtICAgICBucCA9IG9mX3BhcnNlX3BoYW5kbGUo
bm9kZSwgImZzbCxpbXg3ZC1wY2llLXBoeSIsIDApOw0KPiArICAgICBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wIF9fZnJlZShkZXZpY2Vfbm9kZSkgPQ0KPiArICAgICAgICAgICAgIG9mX3BhcnNlX3Bo
YW5kbGUobm9kZSwgImZzbCxpbXg3ZC1wY2llLXBoeSIsIDApOw0KPiAgICAgICBpZiAobnApIHsN
Cj4gICAgICAgICAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgcmVzOw0KPg0KPg0KPiAtLS0NCj4gYmFz
ZS1jb21taXQ6IGEwYzY2NmMyNWFlZWZkMTZmNGIwODhjNjU0OWE2ZmI2YjY1YThhMWQNCj4gY2hh
bmdlLWlkOiAyMDI2MDEyNC1wY2lfaW14Ni1mOTdkNzA4ODdkZmMNCj4NCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBGZWxpeCBHdSA8dXN0Yy5ndUBnbWFpbC5jb20+DQoNCg==
