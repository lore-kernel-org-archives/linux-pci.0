Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8023876B6;
	Tue, 10 Feb 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739497; cv=fail; b=GZ3WhqFbLD+xBrwriDnY6vLcjpyTXl7m/Xjn3QZWwVxRZ6MoLjLMThgJxasMBoY/pbot09tUbrp4UByyTB1Wjcf3iwvFsLo4FxEXRdL4oFcVDyITksXHwxQqrqLBTguaYpEQfQtGG9jJZwrFM7Ax87JHnPPSCh9cUJRC66nCUBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739497; c=relaxed/simple;
	bh=BkMNXtki7WDACOYwaum2vodIVtbnK1c0CH7MUWxc+mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJrikghlxT8O6MSyn3WpvOAxcvRg+aeddpGP8pHE9NqwSRKCkVh6crCvlAHRj9TMxhWqzxaYXOnodH9Z5MHYH+9qQXRc1np4gVccrWpGCTqOGzTiIGtKcWEqR7bacpUnk//Mk21Uc1Hf6X9c8sbnH26juCixpaSTrYTfJhZTqYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=07n53dU6; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="07n53dU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbOvbGN0WJY6KVTVqq25rXWf6pf7/Y9P5zT40PVFlEaHY9dluUrc0KHKhXO3vP3JUFFcaRYm+tgVi+s2UAu5hZu4nF0qbsPezx05OaF+kojuIr5KwfWgWJLN5ee5JwVf1I5Avj5MsqqxH+6kxqgXYaSzX8WORZvtIaLfCC41Psm5jCbv9RZVOV8gqF8YZDUoHRLD7LvLsNjasUIEkjfgVc3upyP5GHMGHurvTVIHkucoo+OPpsumd9Z3aWcnUTEDj141IeoLspofZvxwuXMfXyUAuvJDXYB10hbJBqrLcsotczn0gw6kxgisEMNqOV1830MsrZuUK+SicNKyMv3G2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFi1fdN5P7Uh4HK6pH0rfVlJBZyd1MMAPAWXxfyHR6E=;
 b=LkSYmNMInBVyYtQ7AhKpo7k2Hcvp1ULsjwaO/ZlcQ0F3ripO3KnhDkx3oAkh+/DAs2V5zW4+0abdVAexxWJt0lspGPJq1P+9F0tI5zfhUCJtZku+lLojaqUxav0WJpH1sJCO6QLj/bMjD/djwxDEG3d7v9tFEQQoLl5/+N+biEnRJ8jS84BIx0mxN34rxC04e3waxO2x0hu1U4CHvZ97W2Fe6bcV0o+ecj8JDeq/Pju4WoMgHfAjUoVWjWS0JHUJn58xfo/9fhxjlETfOlMA7miGh5e8lGtP6THsl5f+7ZgqsQCrMsOaVU+gtHVpnh4GPhmTZj6A7Id79oJYrWcKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFi1fdN5P7Uh4HK6pH0rfVlJBZyd1MMAPAWXxfyHR6E=;
 b=07n53dU6NEh2P75ePVppr4Y68dRvQ9UaAtTF3xTjlJ4iFKJapOpYFiPWUM3xjAaW98mNKR06VYgF0W5JaUIRQufkB0YqmzkreU6yJclBiP+vSesh0XNxCTDC+RC9B69Ncve2xAWUuSm1vur2LBwxbHVTjfgAmTDj8AO7Jt8Rf14=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 16:04:50 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 16:04:50 +0000
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
Subject: RE: [PATCH 4/8] phy: zynqmp: Calibrate ILL if necessary
Thread-Topic: [PATCH 4/8] phy: zynqmp: Calibrate ILL if necessary
Thread-Index: AQHclKMeLv3UjNcMAkSiPZrrY7iYUbV8H4tA
Date: Tue, 10 Feb 2026 16:04:50 +0000
Message-ID:
 <CY1PR12MB9697F67210064132883611A8B762A@CY1PR12MB9697.namprd12.prod.outlook.com>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-5-sean.anderson@linux.dev>
In-Reply-To: <20260203002128.935842-5-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-10T16:02:26.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR12MB9697:EE_|MN0PR12MB6079:EE_
x-ms-office365-filtering-correlation-id: 187a1831-3bc2-488d-ff84-08de68be1ec0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?DwNuPcLdWDHJkDLfJQq/ZnRjyOOikhpJ5dpAR73bdscMJ3aYZwb2iq5JYi?=
 =?iso-8859-2?Q?71XFB0c5cmhY4pJRguDw+g1HjFxYPKgVAp+t8HNXhZlr1pYBMLfg8IiB7r?=
 =?iso-8859-2?Q?BUekB7ZxZMFkkTxhOMknn/llDjJ6cDFfD0QMrcpRP95X29Rn6Ihb9vu7yQ?=
 =?iso-8859-2?Q?RrZ/jSLoz1DJDn4w7pTsqz/0wukI0/k33ZyTM/hXSb7jGNJCihayEURuRK?=
 =?iso-8859-2?Q?aEvCmlhW009JtxYuQpNTFnj3nstD07m9mqMBMCzcjs9tqrJPcYPHqbuoze?=
 =?iso-8859-2?Q?vSlCrS3SylcVfAIcee8BDWF/b008egg/Dtpv59CZNK7Vg5SKLRQi8vyJfC?=
 =?iso-8859-2?Q?VK/TVqVjnxMcsCIqfZ6CVOdzZ8gcL50azgdlZyyQ0ScZG1KUqfwzDCai9h?=
 =?iso-8859-2?Q?Am+czd2cAjYKgFUlXpXhNHDGcxrlchNbUDKPP/3WBNcoedsx626EpHtfxb?=
 =?iso-8859-2?Q?Vic0AaDoJpVPZhcj/3l+Tr+A8HU8a0k89cw2wnSdOt9isD6roHZtr+UliC?=
 =?iso-8859-2?Q?fa/IIVHVqP4OvWiq5OOrG075g0DlkEU0qCpqpAdgUBSI0HNyNm019aT4oG?=
 =?iso-8859-2?Q?ayJR8Tw9XI16RzHztmCE8Nqn5/ifqfC98jTLRXrUgUH7z0fNmZ/RMwa7K+?=
 =?iso-8859-2?Q?SXDXnBAbx7XRP7KXqEY25cmGULHwwVm43/rydEcPAUCThXRP0AuN2pl+RC?=
 =?iso-8859-2?Q?h4mj5U/sfA4pWPy8JvZqtIUR++UymJeorDoZNUvl9WdQCXFYfpGsbGl7LR?=
 =?iso-8859-2?Q?OUstzc4iU/92GaOV/gR8NYozJM+2cPjg2J8AkkLCYzsVgwiG17PTkgTPX6?=
 =?iso-8859-2?Q?7we6XAWbo1T9irLc+VYVbMd6p0I2AbIU0RXKb02s7Z7uQJHyHiUryr/RQD?=
 =?iso-8859-2?Q?JeEU3AjDtHn5c8rMLsd9MBiedcz2HG4/fO5gerush7o5HU4rXQwJXUGUGI?=
 =?iso-8859-2?Q?Lj6QAtI6Fai8zc+FJkseLO8id4vN64IkPkgFjeRz6kBGrpjf6OEHTDerD9?=
 =?iso-8859-2?Q?HPUFU6WMlt/HMEjv6Ci8AqEDUJYYkApBV4r5msgl56/VP7jGI8KZgBYqcm?=
 =?iso-8859-2?Q?YHmy8xdvMBlWIdSrGzCYeMMKX1DxMfRAmUJC8f815wfVWSy2C1LMNEUr08?=
 =?iso-8859-2?Q?9CplE+fXW/EpGyjQZ61YCLbLVbxelUhD80wBH2ydqGzrNki6UBxpJjwbU6?=
 =?iso-8859-2?Q?2OaDVJfTX1wweVz32oXhWn8pkNAEXl9btIHPPLIvI7wqoPuRBNlSMFowh9?=
 =?iso-8859-2?Q?Z4kM60/IVH8/5LAX2/p40EMv5uDBFgHm3ZasG9x2dqGXC8sfrr9Wr/Q8e5?=
 =?iso-8859-2?Q?S212gv9F31f0BU8C7iCRrxyJeWV/D+o6KJjNGujQYeAFzAqODKCjAlVKQb?=
 =?iso-8859-2?Q?EWPXy3rTYjCvflt1dKDSgJPBoWBzvlB1ApwN2X69y1N/QoxlQCudcJeaso?=
 =?iso-8859-2?Q?zXOxA306jsw5aDXzbxaoA4osYflTbr0v85aOddkQ5vd6QsJfLNFgyFGRLA?=
 =?iso-8859-2?Q?JHyCRqggjeiYkFdHQPutN6Abbj2zUW8rrJnkqX5ZkIB/S3yMQSkM42sNMA?=
 =?iso-8859-2?Q?M4Z2orSlkk2uZvaYfeOelBXRYhw9EuwuabtrmivaL0+d8BaYe3J50KBQei?=
 =?iso-8859-2?Q?lDex8RO4jFdexZo1gFhMkXtiylPfE6I59J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?BncW9PoZ4vfHQLH0vuPuRjqwXAx5oLDufuZnjjagQ5FBeZU04is7sKC58s?=
 =?iso-8859-2?Q?UpgaBR/uJ+jaJzvFYB7k1r1MqIpbJoA5IWwjq8GQ2UXC1nrpFIfIgQ3OZl?=
 =?iso-8859-2?Q?TON8xZDKZe5EB/T3ytro8NahxvWsWcMv0+Gnq9dvR9KQ3+jMn/Ixw6IKHi?=
 =?iso-8859-2?Q?5+HAYiFL6DJonw/atC2qVnwH0YG6sUlZOrph+6E/JHiVenw0/jDO0ErcoE?=
 =?iso-8859-2?Q?m1QKMtrLpZNXBSE5YqcBrWaUsbs/r4OosVA2tIlACmRGpKoPpNEtRQMevZ?=
 =?iso-8859-2?Q?0pFk4tVDnn3mHoa050+9xLPlm+xD6JT5lySs+59jEpVLGnTI3bVHp1XBnk?=
 =?iso-8859-2?Q?0aB2tsSfGoNw45xZmtaYbHAn158BjMk7q6IN2/p1SRC4qu7En+j3WjkYt4?=
 =?iso-8859-2?Q?Sov5Gj3wjFPF1tJxGlb1JqDhZNUf4CazFwIUcI3G2d8VjPhWjz3xsbX+ua?=
 =?iso-8859-2?Q?OJLPPj4Q6MwmJ1FgwK4RzMTcLCm9TuyuE3f1wF5IyeIQ989xr3ta4FRnhp?=
 =?iso-8859-2?Q?R6iSNb8y8icu0lonBOis2SPkpayhxyXx6pI6CZEA8v4k6/+yU5zOvyUNZW?=
 =?iso-8859-2?Q?iLCk4QItZLjHjOUo7gV24eddr+/TY+RgnKOuE8LbF78bSSkItGexTj/Mrp?=
 =?iso-8859-2?Q?+DAo4rLBWtYJB64ISPYEvK7P9rgABcpqfd8fWRJgyDmTLzYtNSooOEj295?=
 =?iso-8859-2?Q?ebmMhH69FJYaJbG6rGnEk83q1DzmiLL+Jlzq5dyLstWh6X17dD4SSM/rYr?=
 =?iso-8859-2?Q?UkkLPGqIOVGZUgYcEMkhoKAltfaewDAwiramEP8hwUGK1nwEaI6TeJK/ZP?=
 =?iso-8859-2?Q?ZxEngTNH7td9AOeTtjJP5l6L6Fe8TtpQNEKtCtKJEPN/yu7RQ3SZFoQDAc?=
 =?iso-8859-2?Q?QF3FNqHMEgeZDV3CELQiPqnMgz/28iOD9mNxYzcbYRB+L94L5wu0P1u64V?=
 =?iso-8859-2?Q?mNpQQQBgVdgVqBvjWXZ9NOJU3cobd5IVhj/1N9GU9OP/LYCbG8MNCyaP4s?=
 =?iso-8859-2?Q?FApIjawJFHAZYHvCXWI1sQW/mpSi/kJrwSFhfhBFAC/Fqufhvd8AIxL9cf?=
 =?iso-8859-2?Q?M1Yc2oOLcmB1uFhA1hVGzsdXOscnTFbIc3Gz75F2i55Rsbaq3Z5N3tdH6+?=
 =?iso-8859-2?Q?1Gky2nusLLHYaWHoKdkUJn15Rx5zgQOaaYycMo6xmqvrpKaacLJfDXayya?=
 =?iso-8859-2?Q?Sdphpfuqx379BPqP7hCF69SYX69zQqy3yjVsSwoS2EJER0LZ6aF6gD5oZl?=
 =?iso-8859-2?Q?0IBsJ2A3LVAK8VP34fSyU3/wWUaHNLmEdHl/XpKBDqxjJorFitKsUJ6rHW?=
 =?iso-8859-2?Q?rz9v4TJx+SNjfHEWo53vPINmlc6Uh8D/xXqLr4Vt2Q7ZV63h4HttuY2F++?=
 =?iso-8859-2?Q?8WmC5IrHeBy+yAwT3pxaeE3SosoqkYedUWPWVHzhSsJUD1khoxuHcxkbP1?=
 =?iso-8859-2?Q?Gi8JNxu8q8SBO7pTjJdKlFSJYl82wc0GA6SsizcTu3ucE/cyVU8NV4lR25?=
 =?iso-8859-2?Q?8cichaazaiJxXCTzxmBj17A56n4L3iS51+l95aV+ZTyObTToXCU006VvIL?=
 =?iso-8859-2?Q?ovwk5V3aKFBrMYWp2cDl50kSuggG1C+hbrCTB5JMXHMcN12rT6twkqdVV2?=
 =?iso-8859-2?Q?k2pRjNCLh74zqlBH8mvLKXv53dFkOCy0+27omh7e40lPh+4nn50+rCaAQ8?=
 =?iso-8859-2?Q?9BEs9lDY/C9RRLtZczBGiNTE64du79y/v5GCaYDuoZ+q0EAnrLM9LG92yG?=
 =?iso-8859-2?Q?KHBfiynxrUbBub7dW/babe9lGzJfhF8HwkJq72/5Nh5rAK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 187a1831-3bc2-488d-ff84-08de68be1ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 16:04:50.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEMVN/4E1VVuLA+EB7XZ+dn3NsHLVrYTHLgR5eseSKs6/tqkdObEiUwV5AzZVuQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

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
> Subject: [PATCH 4/8] phy: zynqmp: Calibrate ILL if necessary
>
> init_serdes in psu_init_gpl is supposed to calibrate the ILL. However, th=
is
> may fail if the reference clock is not running, such as if the clock need=
s
> to be configured on boot. To work around this, add support for ILL
> calibration in U-Boot. If the ILL is already calibrated (any non-zero
> value) we skip calibration.
>
> The algorithm is substantially the same as serdes_illcalib [1], but it ha=
s
> been updated for readability (and to remove all the "if (lane0_active)"
> conditions). Due to the amount of register fields, many of which are
> undocumented (especially the chicken bits), I have mostly used defines on=
ly
> for the register names. There are certainly areas where register writes a=
re
> superfluous, but I have left these in order to minimize deviation from th=
e
> procedure in serdes_illcalib.

Please consider splitting the patch in introducing calibrate ILL functions
and then subsequently using them.

How did you validate the changes? functional testing is one part
but I think better to match register configuration done in psu_init vs
this series? Have we tried running on multiple designs having
different GT lane and protocol combinations .

There are multiple magic numbers. Consider renaming it to
meaningful defines.

>
> [1] Example implementation; xpsgtr_phy_illcalib coresponds to
>     serdes_illcalib_pcie_gen1:
> https://source.denx.de/u-boot/u-boot/-/blob/v2026.01/board/xilinx/zynqmp/=
zynqmp-
> zcu208-revA/psu_init_gpl.c?ref_type=3Dtags#L710
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  drivers/phy/xilinx/phy-zynqmp.c | 421 +++++++++++++++++++++++++++++++-
>  1 file changed, 420 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zyn=
qmp.c
> index 152af1702bbd..854b0ea04648 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -12,6 +12,7 @@
>   * PCIe should also work but that is experimental as of now.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -31,6 +32,7 @@
>   */
>
>  /* TX De-emphasis parameters */
> +#define L0_TX_ANA_TM_3                       0x000c
>  #define L0_TX_ANA_TM_18                      0x0048
>  #define L0_TX_ANA_TM_118             0x01d8
>  #define L0_TX_ANA_TM_118_FORCE_17_0  BIT(0)
> @@ -50,16 +52,49 @@
>  #define L0_TXPMD_TM_45_ENABLE_DP_POST2       BIT(5)
>
>  /* PCS control parameters */
> +#define L0_TM_ANA_BYP_4                      0x1010
> +#define L0_TM_ANA_BYP_7                      0x1018
>  #define L0_TM_DIG_6                  0x106c
> +#define L0_TM_DIG_22                 0x10ac
>  #define L0_TM_DIS_DESCRAMBLE_DECODER 0x0f
>  #define L0_TX_DIG_61                 0x00f4
>  #define L0_TM_DISABLE_SCRAMBLE_ENCODER       0x0f
> +#define L0_TM_AUX_0                  0x10cc
> +#define L0_TM_MISC2                  0x189c
> +#define L0_TM_MISC2_ILL_CAL_BYPASS   BIT(7)
> +#define L0_TM_IQ_ILL1                        0x18f8
> +#define L0_TM_IQ_ILL2                        0x18fc

#define L0_TM_IQ_ILL3                   0x1900

IQ_ILL(n) =3D 0x18f8 + (n - 1) * 4 ?

Similarly for others  (when applicable)?

> +#define L0_TM_ILL11                  0x198c
> +#define L0_TM_ILL12                  0x1990
> +#define L0_TM_E_ILL1                 0x1924
> +#define L0_TM_E_ILL2                 0x1928
> +#define L0_TM_IQ_ILL3                        0x1900
> +#define L0_TM_E_ILL3                 0x192c
> +#define L0_TM_IQ_ILL7                        0x1910
> +#define L0_TM_E_ILL7                 0x193c
> +#define L0_TM_ILL8                   0x1980
> +#define L0_TM_IQ_ILL8                        0x1914
> +#define L0_TM_IQ_ILL9                        0x1918
> +#define L0_TM_EQ0                    0x194c
> +#define L0_TM_EQ0_EQ_STG2_CTRL_BYP   BIT(5)
> +#define L0_TM_EQ1                    0x1950
> +#define L0_TM_EQ1_EQ_STG2_RL_PROG    GENMASK(1, 0)
> +#define L0_TM_EQ1_EQ_STG2_PREAMP_MODE_VAL    BIT(2)
> +#define L0_TM_E_ILL8                 0x1940
> +#define L0_TM_E_ILL9                 0x1944
> +#define L0_TM_ILL13                  0x1994
> +#define L0_TM_CDR5                   0x1c14
> +#define L0_TM_CDR5_FPHL_FSM_ACC_CYCLES       GENMASK(7, 5)
> +#define L0_TM_CDR5_FFL_PH0_INT_GAIN  GENMASK(4, 0)
> +#define L0_TM_CDR16                  0x1c40
>
>  /* PLL Test Mode register parameters */
> +#define L0_TM_PLL_DIG_33             0x2084
>  #define L0_TM_PLL_DIG_37             0x2094
>  #define L0_TM_COARSE_CODE_LIMIT              0x10
>
>  /* PLL SSC step size offsets */
> +#define L0_PLL_FBDIV_FRAC_3_MSB              0x2360
>  #define L0_PLL_SS_STEPS_0_LSB                0x2368
>  #define L0_PLL_SS_STEPS_1_MSB                0x236c
>  #define L0_PLL_SS_STEP_SIZE_0_LSB    0x2370
> @@ -69,6 +104,7 @@
>  #define L0_PLL_STATUS_READ_1         0x23e4
>
>  /* SSC step size parameters */
> +#define TM_FORCE_EN_FRAC             BIT(6)
>  #define STEP_SIZE_0_MASK             0xff
>  #define STEP_SIZE_1_MASK             0xff
>  #define STEP_SIZE_2_MASK             0xff
> @@ -76,6 +112,7 @@
>  #define STEP_SIZE_SHIFT                      8
>  #define FORCE_STEP_SIZE                      0x10
>  #define FORCE_STEPS                  0x20
> +#define TM_FORCE_EN                  BIT(7)
>  #define STEPS_0_MASK                 0xff
>  #define STEPS_1_MASK                 0x07
>
> @@ -84,6 +121,32 @@
>  #define L0_REF_CLK_LCL_SEL           BIT(7)
>  #define L0_REF_CLK_SEL_MASK          0x9f
>
> +/* Built-in self-test parameters */
> +#define L0_BIST_CTRL_1                       0x3004
> +#define L0_BIST_CTRL_2                       0x3008
> +#define L0_BIST_RUN_LEN_L            0x300c
> +#define L0_BIST_ERR_INJ_POINT_L              0x3010
> +#define L0_BIST_RUNLEN_ERR_INJ_H     0x3014
> +#define L0_BIST_IDLE_TIME            0x3018
> +#define L0_BIST_MARKER_L             0x301c
> +#define L0_BIST_IDLE_CHAR_L          0x3020
> +#define L0_BIST_MARKER_IDLE_H                0x3024
> +#define L0_BIST_LOW_PULSE_TIME               0x3028
> +#define L0_BIST_TOTAL_PULSE_TIME     0x302c
> +#define L0_BIST_TEST_PAT_1           0x3030
> +#define L0_BIST_TEST_PAT_2           0x3034
> +#define L0_BIST_TEST_PAT_3           0x3038
> +#define L0_BIST_TEST_PAT_4           0x303c
> +#define L0_BIST_TEST_PAT_MSBS                0x3040
> +#define L0_BIST_PKT_NUM                      0x3044
> +#define L0_BIST_FRM_IDLE_TIME                0x3048
> +#define L0_BIST_PKT_CTR_L            0x304c
> +#define L0_BIST_PKT_CTR_H            0x3050
> +#define L0_BIST_ERR_CTR_L            0x3054
> +#define L0_BIST_ERR_CTR_H            0x3058
> +#define L0_BIST_FILLER_OUT           0x3068
> +#define L0_BIST_FORCE_MK_RST         0x306c
> +
>  /* Calibration digital logic parameters */
>  #define L3_TM_CALIB_DIG19            0xec4c
>  #define L3_CALIB_DONE_STATUS         0xef14
> @@ -139,6 +202,9 @@ static const char *const xpsgtr_icm_str[] =3D {
>  #define TM_CMN_RST_SET                       0x2
>  #define TM_CMN_RST_MASK                      0x3
>
> +#define LPBK_CTRL0                   0x10038
> +#define LPBK_CTRL1                   0x1003c
> +
>  /* Bus width parameters */
>  #define TX_PROT_BUS_WIDTH            0x10040
>  #define RX_PROT_BUS_WIDTH            0x10044
> @@ -148,9 +214,13 @@ static const char *const xpsgtr_icm_str[] =3D {
>  #define PROT_BUS_WIDTH_SHIFT(n)              ((n) * 2)
>  #define PROT_BUS_WIDTH_MASK(n)               GENMASK((n) * 2 + 1, (n) * =
2)
>
> +#define UPHY_SPARE0                  0X10098
> +
>  /* Number of GT lanes */
>  #define NUM_LANES                    4
>
> +#define SIOU_ECO_0                   0x1c
> +
>  /* SIOU SATA control register */
>  #define SATA_CONTROL_OFFSET          0x0100
>
> @@ -338,6 +408,33 @@ static void xpsgtr_restore_lane_regs(struct xpsgtr_d=
ev
> *gtr_dev)
>                            gtr_dev->saved_regs[i]);
>  }
>
> +static inline void xpsgtr_write_lanes(struct xpsgtr_dev *gtr_dev,
> +                                  unsigned long *lanes, u32 reg, u32 val=
ue)
> +{
> +     unsigned long lane;
> +
> +     for_each_set_bit(lane, lanes, NUM_LANES) {
> +             void __iomem *addr =3D gtr_dev->serdes + lane * PHY_REG_OFF=
SET
> +                                  + reg;
> +
> +             writel(value, addr);
> +     }
> +}
> +
> +static inline void xpsgtr_clr_set_lanes(struct xpsgtr_dev *gtr_dev,
> +                                    unsigned long *lanes, u32 reg, u32 c=
lr,
> +                                    u32 set)
> +{
> +     unsigned long lane;
> +
> +     for_each_set_bit(lane, lanes, NUM_LANES) {
> +             void __iomem *addr =3D gtr_dev->serdes + lane * PHY_REG_OFF=
SET
> +                                  + reg;
> +
> +             writel((readl(addr) & ~clr) | set, addr);
> +     }
> +}
> +
>  /*
>   * Hardware Configuration
>   */
> @@ -351,7 +448,7 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>       u8 protocol =3D gtr_phy->protocol;
>       int ret;
>
> -     dev_dbg(gtr_dev->dev, "Waiting for PLL lock\n");
> +     dev_vdbg(gtr_dev->dev, "Waiting for PLL lock\n");

Unrelated change.

>
>       /*
>        * For DP and PCIe, only the instance 0 PLL is used. Switch to that=
 phy
> @@ -520,6 +617,231 @@ static void xpsgtr_bypass_scrambler_8b10b(struct
> xpsgtr_phy *gtr_phy)
>       xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61,
> L0_TM_DISABLE_SCRAMBLE_ENCODER);
>  }
>
> +/* Enable or disable loopback */
> +static void xpsgtr_phy_set_loopback(struct xpsgtr_phy *gtr_phy, bool ena=
bled)
> +{
> +     struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> +     u32 reg =3D gtr_phy->lane >=3D 2 ? LPBK_CTRL1 : LPBK_CTRL0;
> +     u32 shift =3D gtr_phy->lane & 1 ? 4 : 0;
> +
> +     xpsgtr_clr_set(gtr_dev, reg, 7 << shift, (u32)enabled << shift);
> +}
> +
> +static void xpsgtr_phy_set_ill(struct xpsgtr_phy *gtr_phy, u32 ill, bool=
 gen2)
> +{
> +     u32 val =3D 4 + ill * 8;
> +
> +     if (gen2) {
> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL2, val & 0xff);
> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL12, 0x0f,
> +                                1 << (val >> 8));
> +     } else {
> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL1, val & 0xff);
> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL12, 0xf0,
> +                                (val >> 4) & 0x10);
> +     }
> +}
> +
> +static bool xpsgtr_ill_calibrated(struct xpsgtr_phy *gtr_phy)
> +{
> +     u32 ill1 =3D xpsgtr_read_phy(gtr_phy, L0_TM_E_ILL1);
> +     u32 ill2 =3D xpsgtr_read_phy(gtr_phy, L0_TM_E_ILL2);
> +     u32 ill12 =3D xpsgtr_read_phy(gtr_phy, L0_TM_ILL12);
> +
> +     dev_dbg(gtr_phy->dev->dev, "lane %u gen1 ILL was %u gen2 ILL was
> %u\n",
> +             gtr_phy->lane, ill1 / 8 + (ill12 & 0x10 ? 32 : 0),
> +             ill2 / 8 + (ill12 & 0x02 ? 32 : 0));
> +     return ill1 || ill2 || ill12;
> +}
> +
> +static void xpsgtr_init_ill(struct xpsgtr_phy *gtr_phy)
> +{
> +     struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> +     struct clk *clk =3D gtr_dev->clk[gtr_phy->refclk];
> +     u32 ill123 =3D DIV_ROUND_CLOSEST(clk_get_rate(clk), 1000000);
> +
> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_MISC2, 0,
> L0_TM_MISC2_ILL_CAL_BYPASS);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL1, ill123);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL2, ill123);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL3, ill123);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL7, 0xf3);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL7, 0xf3);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_ILL8, 0xff);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL8, 0xf3);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL8, 0xf3);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL9, 1);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL9, 1);
> +     xpsgtr_clr_set(gtr_dev, UPHY_SPARE0, BIT(5), 0);
> +}
> +
> +static void xpsgtr_phy_illcalib(struct xpsgtr_dev *gtr_dev,
> +                                  unsigned long *lanes, bool gen2)
> +{
> +     bool last_ok[NUM_LANES] =3D { 0 };
> +     int pass[NUM_LANES] =3D { 0 }, altpass[NUM_LANES] =3D { 0 };
> +     int best[NUM_LANES] =3D { 0 }, altbest[NUM_LANES] =3D { 0 };
> +     unsigned long lane;
> +     int i;
> +
> +     /* Initialize the BIST */
> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0xe0, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FILLER_OUT, 1);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FORCE_MK_RST, 1);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_DIG_22, 0x20);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_2, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUN_LEN_L, 0xf4);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_INJ_POINT_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUNLEN_ERR_INJ_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_L, 0xfb);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_CHAR_L, 0xff);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_IDLE_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_LOW_PULSE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TOTAL_PULSE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_1, 0x4a);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_2, 0x4a);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_3, 0x4a);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_4, 0x4a);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_MSBS, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_NUM, 0x14);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FRM_IDLE_TIME, 2);
> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0xe0, 0);
> +
> +     for (i =3D 0; i < 64; i++) {
> +             bool ok[NUM_LANES];
> +
> +             for_each_set_bit(lane, lanes, NUM_LANES)
> +                     xpsgtr_phy_set_ill(&gtr_dev->phys[lane], i, gen2);
> +
> +             /* Reset lanes */
> +             xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_7, 0x20,
> +                                  0x10);
> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x00);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0x40);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0x80);
> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x04);
> +             udelay(50);
> +             if (gen2)
> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x0e);
> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x06);
> +             if (gen2) {
> +                     xpsgtr_write_lanes(gtr_dev, lanes, L0_TX_ANA_TM_3, =
0x04);
> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x07);
> +                     udelay(400);
> +                     xpsgtr_write_lanes(gtr_dev, lanes, L0_TX_ANA_TM_3, =
0x0c);
> +                     udelay(15);
> +                     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x0f);
> +                     udelay(100);
> +             }
> +
> +             if (xpsgtr_wait_pll_lock(gtr_dev->phys[0].phy)) {
> +                     memset(last_ok, 0, sizeof(last_ok));
> +                     continue;
> +             }
> +
> +             udelay(50);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0xc0);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0x80);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0xc0);
> +             udelay(50);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0x80);
> +             udelay(50);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_4, 0);
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_PLL_DIG_33, 0);
> +             udelay(500);
> +
> +             /* Do the BIST */
> +             for_each_set_bit(lane, lanes, NUM_LANES) {
> +                     struct xpsgtr_phy *gtr_phy =3D &gtr_dev->phys[lane]=
;
> +                     u32 packets, errors;
> +
> +                     xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_1=
0);
> +                     xpsgtr_phy_set_loopback(gtr_phy, true);
> +                     xpsgtr_write_phy(gtr_phy, L0_TM_DIG_22, 0x20);
> +                     xpsgtr_clr_set_phy(gtr_phy, L0_BIST_CTRL_1, 0, 1);
> +
> +                     udelay(200);
> +                     xpsgtr_write_phy(gtr_phy, L0_BIST_CTRL_1, 0);
> +                     packets =3D xpsgtr_read_phy(gtr_phy, L0_BIST_PKT_CT=
R_L);
> +                     packets |=3D xpsgtr_read_phy(gtr_phy, L0_BIST_PKT_C=
TR_H)
> << 8;
> +                     errors =3D xpsgtr_read_phy(gtr_phy, L0_BIST_ERR_CTR=
_L);
> +                     errors |=3D xpsgtr_read_phy(gtr_phy, L0_BIST_ERR_CT=
R_H)
> << 8;
> +                     ok[lane] =3D packets && !errors;
> +
> +                     dev_dbg(gtr_dev->dev,
> +                             "lane %lu ILL %d packets %10u errors %10u\n=
",
> +                             lane, i, packets, errors);
> +             }
> +
> +             xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0);
> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x00);
> +             xpsgtr_write(gtr_dev, UPHY_SPARE0, 0x02);
> +
> +             for_each_set_bit(lane, lanes, NUM_LANES) {
> +                     pass[lane] +=3D ok[lane] && last_ok[lane];
> +                     if (pass[lane] < 4) {
> +                             if (!ok[lane] && i > 2) {
> +                                     if (altpass[lane] < pass[lane]) {
> +                                             altpass[lane] =3D pass[lane=
];
> +                                             altbest[lane] =3D
> +                                                     (i - 1) - (pass[lan=
e] + 1) / 2;
> +                                     }
> +                                     pass[lane] =3D 0;
> +                             }
> +                     } else if (!best[lane] && (!ok[lane] || i =3D=3D 63=
) &&
> +                                last_ok[lane]) {
> +                             best[lane] =3D (i - 1) - (pass[lane] + 1) /=
 2;
> +                     }
> +             }
> +
> +             memcpy(last_ok, ok, sizeof(ok));
> +     }
> +
> +     for_each_set_bit(lane, lanes, NUM_LANES) {
> +             dev_dbg(gtr_dev->dev, "lane %lu ILL best %d alt best %d\n",
> +                     lane, best[lane], altbest[lane]);
> +
> +             xpsgtr_phy_set_ill(&gtr_dev->phys[lane],
> +                                best[lane] ?: altbest[lane], gen2);
> +     }
> +
> +     /* Clean up */
> +     xpsgtr_clr_set_lanes(gtr_dev, lanes, L0_TM_ANA_BYP_7, 0x30, 0);
> +     xpsgtr_write(gtr_dev, UPHY_SPARE0, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_1, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_CTRL_2, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUN_LEN_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_INJ_POINT_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_RUNLEN_ERR_INJ_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_IDLE_CHAR_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_MARKER_IDLE_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_LOW_PULSE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TOTAL_PULSE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_1, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_2, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_3, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_4, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_TEST_PAT_MSBS, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_NUM, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FRM_IDLE_TIME, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_CTR_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_PKT_CTR_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_CTR_L, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_ERR_CTR_H, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FILLER_OUT, 1);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_BIST_FORCE_MK_RST, 0);
> +     xpsgtr_write_lanes(gtr_dev, lanes, L0_TM_DIG_22, 0);
> +
> +     for_each_set_bit(lane, lanes, NUM_LANES) {
> +             struct xpsgtr_phy *gtr_phy =3D &gtr_dev->phys[lane];
> +
> +             xpsgtr_phy_init_bus_width(gtr_phy, PROT_BUS_WIDTH_20);
> +             xpsgtr_phy_set_loopback(gtr_phy, false);
> +     }
> +}
> +
>  static int xpsgtr_common_init(struct xpsgtr_phy *gtr_phy)
>  {
>       int ret;
> @@ -553,6 +875,37 @@ static void xpsgtr_phy_init_sata(struct xpsgtr_phy
> *gtr_phy)
>  {
>       struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
>
> +     if (!xpsgtr_ill_calibrated(gtr_phy)) {
> +             DECLARE_BITMAP(lanes, NUM_LANES) =3D { 0 };
> +
> +             xpsgtr_init_ill(gtr_phy);
> +             xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL3, 100);
> +             xpsgtr_clr_set_phy(gtr_phy, L0_TM_ILL11, 0xf0, 0x20);
> +
> +             __set_bit(gtr_phy->lane, lanes);
> +             xpsgtr_phy_illcalib(gtr_dev, lanes, false);
> +             xpsgtr_phy_set_ill(gtr_phy, 7, true);
> +     }
> +
> +     /* Disable SSC */
> +     xpsgtr_write_phy(gtr_phy, L0_PLL_FBDIV_FRAC_3_MSB,
> TM_FORCE_EN_FRAC);
> +     xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_3_MSB, 0,
> TM_FORCE_EN);
> +
> +     /* Disable Tx deemphasis */
> +     xpsgtr_write_phy(gtr_phy, L0_TM_CDR5,
> +                      FIELD_PREP(L0_TM_CDR5_FPHL_FSM_ACC_CYCLES,
> 7) |
> +                      FIELD_PREP(L0_TM_CDR5_FFL_PH0_INT_GAIN, 6));
> +     xpsgtr_write_phy(gtr_phy, L0_TM_CDR16, 12);
> +
> +     /* Configure equalization */
> +     xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_118,
> +                      L0_TX_ANA_TM_118_FORCE_17_0);
> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_EQ0, 0,
> L0_TM_EQ0_EQ_STG2_CTRL_BYP);
> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_EQ1,
> L0_TM_EQ1_EQ_STG2_RL_PROG,
> +                        FIELD_PREP(L0_TM_EQ1_EQ_STG2_RL_PROG, 2) |
> +                        L0_TM_EQ1_EQ_STG2_PREAMP_MODE_VAL);
> +     xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_18, 2); /* -3.5 dB deemphasi=
s */
> +
>       xpsgtr_bypass_scrambler_8b10b(gtr_phy);
>
>       writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
> @@ -565,6 +918,64 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy
> *gtr_phy)
>       xpsgtr_bypass_scrambler_8b10b(gtr_phy);
>  }
>
> +/* PCIe-specific initialization. */
> +static int xpsgtr_phy_init_pcie(struct xpsgtr_phy *gtr_phy)
> +{
> +     struct xpsgtr_dev *gtr_dev =3D gtr_phy->dev;
> +     DECLARE_BITMAP(lanes, NUM_LANES) =3D { 0 };
> +     unsigned long lane;
> +     bool calibrated =3D false;
> +
> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_AUX_0, 0, 0x20);
> +
> +     for (lane =3D 0; lane < NUM_LANES; lane++) {
> +             struct xpsgtr_phy *gtr_phy =3D &gtr_dev->phys[lane];
> +
> +             if (gtr_phy->protocol !=3D ICM_PROTOCOL_PCIE)
> +                     continue;
> +
> +             __set_bit(lane, lanes);
> +             calibrated =3D calibrated || xpsgtr_ill_calibrated(gtr_phy)=
;
> +     }
> +
> +     if (calibrated)
> +             return 0;
> +
> +     /* Write default ILL config */
> +     for_each_set_bit(lane, lanes, NUM_LANES) {
> +             struct xpsgtr_phy *p =3D &gtr_dev->phys[lane];
> +
> +             if (lane !=3D gtr_phy->lane) {
> +                     int ret =3D xpsgtr_common_init(p);
> +
> +                     if (ret)
> +                             return ret;
> +             }
> +
> +             xpsgtr_init_ill(p);
> +             xpsgtr_write_phy(p, L0_TM_E_ILL3, 0);
> +             xpsgtr_clr_set_phy(p, L0_TM_MISC2, 0,
> +                                L0_TM_MISC2_ILL_CAL_BYPASS);
> +     }
> +
> +     /* Perform the ILL calibration procedure */
> +     xpsgtr_phy_illcalib(gtr_dev, lanes, false);
> +     xpsgtr_phy_illcalib(gtr_dev, lanes, true);
> +
> +     /* Disable PCIe ECO */
> +     writel(1, gtr_dev->siou + SIOU_ECO_0);
> +     return 0;
> +}
> +
> +/* USB-specific initialization. */
> +static void xpsgtr_phy_init_usb(struct xpsgtr_phy *gtr_phy)
> +{
> +     xpsgtr_clr_set_phy(gtr_phy, L0_TM_AUX_0, 0, 0x20);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_IQ_ILL8, 0xf3);
> +     xpsgtr_write_phy(gtr_phy, L0_TM_E_ILL8, 0xf3);
> +     xpsgtr_phy_set_ill(gtr_phy, 7, false);
> +}
> +
>  /* Configure TX de-emphasis and margining for DP. */
>  static void xpsgtr_phy_configure_dp(struct xpsgtr_phy *gtr_phy, unsigned=
 int pre,
>                                   unsigned int voltage)
> @@ -710,6 +1121,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>               xpsgtr_phy_init_dp(gtr_phy);
>               break;
>
> +     case ICM_PROTOCOL_PCIE:
> +             ret =3D xpsgtr_phy_init_pcie(gtr_phy);
> +             break;
> +
>       case ICM_PROTOCOL_SATA:
>               xpsgtr_phy_init_sata(gtr_phy);
>               break;
> @@ -717,6 +1132,10 @@ static int xpsgtr_phy_init(struct phy *phy)
>       case ICM_PROTOCOL_SGMII:
>               xpsgtr_phy_init_sgmii(gtr_phy);
>               break;
> +
> +     case ICM_PROTOCOL_USB:
> +             xpsgtr_phy_init_usb(gtr_phy);
> +             break;
>       }
>
>  out:
> --
> 2.35.1.1320.gc452695387.dirty

