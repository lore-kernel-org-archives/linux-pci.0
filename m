Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793244897;
	b=eRq8AE4udW7C2ySOQ18UjGaZg6LWQSZdieEIJ9SlSdnJtfA+fiJL84rTnIxkGWwzAHKq
	 MZBi+0oUZSbqqe6rV8c2ao5KeYW+I8LTJ+aH5YP9CpP0SKKCN4kX7hUQC1TxdcwzUplnw
	 AkO0ezPQ884VzwNh9a7nuB7NGxi67sLDptVJq/UmTrP8RSSK74SLgHTOjIu1OtFN/o7Ie
	 hGnSFy0i8Oa+rnp3/6LDwlL3wP9wGeKYArmsRlL6d9GjQp3B1fVd1wSTr8IBHcd6Da3Yp
	 xbxpx90JaCFpeBE2jDP19tFatimW2b9/OWQq4qsfEX64k5r/5eeOulDptsEZmp43Wig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FXRBROL6vs/aCtzrthT49cr9e6Cbo4xzbcFmFswmlTU=;
	b=ifY4sM34jvmehHB5x1AFoxlO5mw4K+esypfAts3MQzRORgIVX1JGf+i0Z8grJgtbIjv4
	 TXwKp94e760/MYlAlZrhvCvONqTP9D1vwtCGwBPPQkgeqv1mpNcKUlc9UM5XNMFafl/rZ
	 KLjhEYV8OZ86ygecggYGalgmAmNUOK+rWCEWaG3rtRV4jUQqS1CPTeIwlqAEhUEbUx7dP
	 L/xq+NoDKmr1BCdqRD3qA35eHax1TjfcXQ/erJp1UD91L7dudfd7DndRA0JRlxll58AgP
	 pnG7EJRJj+sD1JoKyD4I4VebSwSE+3aM4RTKKe9yPopavtziT12HLIS6uNTecgYjfaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qwFCEsty;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.34
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DD606A323;
	Thu, 29 Oct 2026 03:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qwFCEsty
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIUcQyUOz9PbJpvpWv8yNU0jpP/CycpdMERZqBh4bdE4R/FBhGwP3zrn0jXJpFdit9zqKbjRbKLcqYCR4iqest4yCwPzktw5fqJNwPduiU8tDdEZm8FxPKuCj33n5mm0uK//0eBLr8c1CrOimHbwhLSE0EBLDR+sfdNapVFvG5wRr9esiCzfYoIA4QCldTtRCOHfSIeoieM5Ja7//IQi9JEdlz45bG2tze2g4vP2mx/A7JG2ewobnz/OGEGfNeSNWa1xI0UCNZK2/O69vvQzSQ3mhM948Ez8V+b4rRHkx/RyNhXpHnRj4YUxmCNz1SzSp416b/Qkw+bkgr3gJ2qi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXRBROL6vs/aCtzrthT49cr9e6Cbo4xzbcFmFswmlTU=;
 b=KnK+dFlbsD5kk0+Y5ueTmy5xyHQxQa0I/g60BiXQhZX659eyE1H9G/kpOqh0Xa4DQrXqc3jaATpbX1t5ihTrH/EvQVOiUZrfFgyf/5zAncijZeEhUhJK54VV030rohWKJy1sfb6lKftBaLcytC4HjUXFKRm8hRWvYsYkrA4WpPEvJBgG8NHAlsI34pJNAJCY1SPufRuKKuF3VPJo7YV0QT1zKbNDw/QYzPGJtJBK/8yBU2Sjsg9Vpzm6glrEDWFVXRXocbtsHL4yPH9uQA/g6W3GvQRa0ffoN6k+1NpEtnmrSl9QvshcjuPrCfjjzZHptpG17xzv7Tvt2u3G9Zz+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXRBROL6vs/aCtzrthT49cr9e6Cbo4xzbcFmFswmlTU=;
 b=qwFCEstyhk/wt3qKg+LhRyzbpXEJe/ETdPJRC1Go2VhTjfsgfcaCq00CPG31uDopRuRxVZ4WEDGfCuDvCun1OsmEeTpoUKKAlAce2AzTQosoggqsGV5cvtsdpCIanhwHR5KIF08CtMaJ4Affs+WUs60oJ5mun2yzKxRcdSGL1TL+PFGj8mvgG7l1OLJcrgYJFk8cFdUu9Y0kuhmJDVxcDADdyCt+vn6BML/Cm7FK8dMHY/qn+JvlCXMfPM4OLyPyXw/ky+ocFfA3p7NmVgCFdIavkp/pItpG8o5Y785w+05tIz90gyKGKAQoo2Gf3EIRrQSjybJePMh5moRaYWNvMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 by DSVPR12MB922022.namprd12.prod.outlook.com (2603:10b6:8:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:34:53 +0000
Received: from LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350]) by LV3PR12MB9166.namprd12.prod.outlook.com
 ([fe80::e46b:ec42:12f6:1350%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 03:34:53 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 29 Oct 2026 12:32:03 +0900
Subject: [PATCH 1/6] dt-bindings: PCI: tegra264: Allow the ats-supported
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-t264-igpu-pci-v1-1-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9166:EE_|DSVPR12MB922022:EE_
X-MS-Office365-Filtering-Correlation-Id: eeeb7e78-3a13-4115-e008-08df356d9863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|921020|11063799006|56012099006|261009223027099003|261026121527099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yWILosKRXus3c/EkMRJroVM4YBB0YeAHTzcFc9pLxVvJe9BtpnndZc5Jjuu3jVzXvgwmAXTl/sssU0C73AOElim1n4J50glMA5XagrFy4RLIVnDfyTThIDOw5rNF6TrhoBHM8BWJEp2TwH+AQBwo2uHmkpfzy0TyU9cyUqHkS/pt7uV+zOdij7KDRij2Q4n4B9zx5xewk60WnhAgBHIgeMWE+7cxbrGCHthC3mIWM1/yJlfl1vTp6I0q/wWR6mJZ03nL8ho3emrQI+SS3BEdhnmezRh0rpjepW58RBZ7RkpS1Km71B37FXuvuj1posDoSDu5ATMjivN++6ejhMwQnmXP3H6dhxXW07pB/vyMaklAT8OmQ+dZU2pQhJXLLmqf8EPzPDPMyQJQ/ctaVgC31+AnmCcWP0LmOGRKHGSpVTno+gyprbSGavCcr1pm/zCqS/pHp5GJ47Z9IYDjoqnR7PNYJo9cM9iUSWvefn0y3QgU3CWqwcfLtVvVJHI/wV8KJK5xo98sb/CZGo1oCfyVaXnHmqVmRGsb+re/Ob1wA1GtRAQwdx6YpTLuaiIPancYWzAr+zQuB4zR9WibUyUruGnzfkzQokMT1VhvKpnrmo9XkN4H3WFTxmE7uKOQtQlO9QK+/LiyLX6Em+Gs7kkYUkKEZMQsOC7qT8QZ/jrj0DzutZzkada1M8evXVNsnwQTIHZ4tzuqhmGGbDlyTZSgcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9166.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(921020)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGpETlJqbjFNMUZ0NE5sM2pEekMrQlRKQ2VLS3h6OSt2VTJCVmUxMXRVUFBx?=
 =?utf-8?B?eTBiYktCQ1JMNVpFYk9aVDlSbjJ2c2wwTC9jeGc2Zzk0eDFwRWpMMW5tMDd2?=
 =?utf-8?B?cW5zRmYrc2w0MEdqYVlaN2g1VUdYeWpDeWJFRkg1VE1hNW9MUk82eXErRjAv?=
 =?utf-8?B?Z3BlT2ZzekdOdkM0Tm1QakVlY0RqZUZpN3grZU1xc0wxUmd3OWNnU1I5SXgx?=
 =?utf-8?B?eml0bmF3cmU4MzR6MHB1N2VOWElmdE9WVXVzUWNweWdUeFlUVGREZDRPRklr?=
 =?utf-8?B?MTQvUVRicmdMUXpsbU92ZDl4amVEUTJCNUVuN0ZtZ1k5ZW42TDRLRkdsRzRS?=
 =?utf-8?B?L1dBeC9RRDhoZ1k1WlBaaWw5aFYrWjVOU2hFS2cxQloraUJrT1YxQjRKcUhm?=
 =?utf-8?B?emsxQ2xCa28vSkVOSWthVmN4THBQNHJHc1F6T0h2VGxjRFZvM2RCSms1V3oy?=
 =?utf-8?B?eVpSQlVSRDlSaXNBOCtFbTBqdHo1RWh2VFVsMHpRRnBwd1VjZHNHQXUvSDFV?=
 =?utf-8?B?SVR0eFRPSWZFQWFqcitWbit3dm03T1BTK2FNZTgrdC9JVzRyWTdGU2s1K0N1?=
 =?utf-8?B?ZHVzZWpYV2xZZHNiTjVxbFE0VTZXZVptWDJpdEl6aDBGd1RTem5Bd00vYWRH?=
 =?utf-8?B?ZUk5dkRxdDZON2hHVGx3VG4vcDJlWmw5UXRyd1UrWlJZZGh4R2JsVU1sNXVV?=
 =?utf-8?B?bXlWWFZrZ3VtQ3NaOTZKU1loZUxxVFRsTE05WjU0VjY5elo4aHFpbGpWTjBn?=
 =?utf-8?B?TDdGV0hPMWZyUW1La2FIejZpbXZaNnA0MDIxUTRoTENOcFU1alRxaGkwS0xM?=
 =?utf-8?B?TXc1NnZTYTRKQTlod0lrbExPbjhndHZCd3N1MG9DQ1Fxb3RLcXZTaDNsZlcr?=
 =?utf-8?B?NWZ0bzZTZy9RYnFXV2JtdUpzbXBtcWswcE9tZUxBNHE4L00reXBnaDNCeVkz?=
 =?utf-8?B?UjZRTThMR2VraFMzbmpLbGRWMHcvcnpyaFFMTkY5VFVNTnZjdk5aQVlBMkpP?=
 =?utf-8?B?VldnOG5zWXB1MmdVZUtqcndyNGJMN1htY3NpZGlVeElBdFFwRlQwTFdDV09D?=
 =?utf-8?B?NThQdE1FWEFoSkxhYnJMMlBSdTJudjNxbXRWbEo3UG5lT3dicnRZbER2QUtv?=
 =?utf-8?B?R0lheDlIeGMzMkhNUVUzSHhtV0lOU2Jvc1VmeGkvT2YwNjZDV05yNlhSV3Bw?=
 =?utf-8?B?NnRJdUJoWTBseWF5WWFQZnN3NW0yUXZyT2V3MHlpMnFQdXJVRmRpLzFxUHU1?=
 =?utf-8?B?M0plZ1ZmZzhnYnkxYXJFcklnaVdPV3FJa0d4N3V0LzV1R2cvTkxiSnZYb3Uw?=
 =?utf-8?B?UERnS1VZb3pwNU5CZEN2R096eW5aVThkaGw4K1BzN3ZyRUFGYUtpUk5jUkd3?=
 =?utf-8?B?M0JPK0hXQzNjaWx0TmJLbUR1L0QvcVBXWEYwU3RiaitUOHM0eTA5MGNKQXMv?=
 =?utf-8?B?RTgzWExxTWtFamVlRm9nKzA3ZnliZ3lja3YyMFZJQkxXc0d5ZlcyaGRDWEhW?=
 =?utf-8?B?YXJkbEVIWlYxS2xKSWlEL2U0MElGSHRaUzZlUUF2MTFHTUR6UjY4MElWZXU4?=
 =?utf-8?B?SnJGcjZld0hJV2NDSnVqbnFnL005dDFad1BZZHlldlkvMmNabkZXTFNQbXpF?=
 =?utf-8?B?cnZHVFdqNlZ1NVNVeXdZQzlBZVlUZWhiYW5nSkZ3T1BMNXhQVlZNVXNzUVVQ?=
 =?utf-8?B?ZzNNM2o2SlBaZ3E1ZHdMMTNwRlYySElJNFYvcTFhTXNIa2tSdUVMaHcvNEY2?=
 =?utf-8?B?cHk0TE9vRytDNjluRmgyOWZWTFZEZzF2N0FmNjV4THQ1UytaT0VSN0xDNUdC?=
 =?utf-8?B?ZzNmcHV4aTkzU0txR3ZkNU9MUmpPQnk4Zys0LzVVZisxZUpZdUNXS0lVYVBi?=
 =?utf-8?B?ZjBHZmtkelo2Q1Nua29NS29NQmhJS0FZNmtmcTdvZEk1c0MvTTkxalB2Wi84?=
 =?utf-8?B?YmRaNVZHQkhTQWtSbVM2dFZNZncyVjBkT05iRTIrTkx6RmtON3FydlFCY1M5?=
 =?utf-8?B?Q2lIL3VlZ0hwK255NTJIc2w3TTBWWnhaRWp4YXFWd1FCUDVTc2QyQVE1eURv?=
 =?utf-8?B?dXQyMUhPQkJNRkJ3Y2tFQ3Q4dENDLzkrcU1XTjhiZUJJclBaWE44MThrT3M1?=
 =?utf-8?B?WjNaMHhwVk9PWUlGQUpOd0pWT0Z5TDREWHhVa2ZOYWkrZkFFMXR0SmF1SUM5?=
 =?utf-8?B?emxjdVlhMmlhTWlUV3JWN1krbXNPUkZKbThkMmVuZGl1V2RoMXkvWnNtMjY5?=
 =?utf-8?B?Rm8wdmRkQjFYYmEvMjk0RGI5ZkJRKzlySHJTb2xIdnRjWFkxeVgwVnU2QlBK?=
 =?utf-8?B?NmphUkpmRlZ6NEFHakhZQ0c5b3hUaTFPZllncm56ZTRrZzdjYmJvckZLSXhm?=
 =?utf-8?Q?4/JOCJm8mRNMWyr/lt79zfYSa97U+y9ZNI0qZtqPLWBXi?=
X-MS-Exchange-AntiSpam-MessageData-1: CevzmzEEWMa1zQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb7e78-3a13-4115-e008-08df356d9863
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:34:53.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDzWBVkLFtAIIx436RtpjMrkQID/Qo1MvmwLNTqipQTSphBwFoa/7eY+LXtB47YIjVGYm8akPBLo6/Kg6UhblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB922022

The C0 controller on Tegra264 is connected to the integrated GPU, which
issues ATS requests. Add the ats-supported property to allow marking
ATS as supported on the controller.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
index f0114defc04e..3b4f31a4a4c2 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
@@ -34,6 +34,11 @@ properties:
 
   dma-coherent: true
 
+  ats-supported:
+    description:
+      Indicates that the controller supports ATS.
+    type: boolean
+
   nvidia,bpmp:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: |

-- 
2.55.0

