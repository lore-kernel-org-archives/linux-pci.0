Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458F2EA16A;
	Wed, 18 Mar 2026 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815279; cv=fail; b=po02Rx9BnoN1D6oj6aF2WygIswmHac81UrHhxKk2jbKR07rMnaKUpnm7+HkC7YoL9llI/GIE7LN/yzQFdB0A43r/6AwXO4ni4EEFNcDAQyoFUxDdtUjK3ctnIVlIPDewLkZRPi0kpBgP3a5LaClK8WoEkE9ApYHz4F8YdzJrRyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815279; c=relaxed/simple;
	bh=dXIZnrXxegOHNOgUcDZJhhJxRIUpzFH7zBcq2BOwUrU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lH5IYyDbSI5Z0EByfNwVCf2k+yuWs8bsGsx84B2V1ZXFM0+QXUPaFuBYtzr3eopXmpCAVGyksxv9tVxDbRtdSVt1dXLA8jVgEHphnQe+vQG9zz/gLuxOKzF6SeFuJiKyiPLJbqto88LnaBqRMnMjmbGHgyvZFsw86ULOBMUiCbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VspQQkCX; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VspQQkCX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb4uvwPt1veJyatHbS6tjXAUJ2ps7Sh5G/Pn9Yex2lN51cT7UyRtVWs9fAGnU6t4YVE5qZMNo42B3rAZHoorfY8lVNPsqgllDw95JyFNvDjz8AJioLpnPzMsTXcVSGkv3vveyh61iTfsPfepyxgaXsLaMJp8G03rAkDRvrgsS5ncurgDj6jjtbX5158xQtYcOvjnEpxP29L9IqqauyCC5qy7ybeSxndEHbzcBZyINhFFL8nzwPd6ZohdSJlv3DGqhZfr3+xfDxnNms0klvU1Rf76/gRLz5DrMvv7LVgqvbp08qChRH7OIsx2f9V4wBldqwh7sEBFuvkb9Hn2C4P/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2GIFpi0bSP69SSQowC0dnYkJeIBS4lH1mK31jRBK5I=;
 b=PBbJhEaes7gqS6Ozo144PBO6zHUFZVSMD8kEDx6lfWzvi7/CSh8R+eafIniN6uTQAKb3cLYOjZqpjDjTsv8S945eJbz2eVeMk1xT5YoBLBXVMtIsCUf9kG6yzpA6aOwANfxCn/r5X54vCwBXGD+IsqruPvzijMVA6xdWPmNcYdCelHVJ+wZqpHuTtMGWseSyDUvtC9Y80P0pkyrsiyTh/TjI6khorGZZ4Hx0/1xV9vUhzf1JNDfc7n53gn1z5g+FAZlj9vieZcPsAEN/km1FIdZuXhE6ManK056tN0r6r9lVtUCWp+qSm4LoE0oj6chMmUbV1gY0aJi135nBTTmnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2GIFpi0bSP69SSQowC0dnYkJeIBS4lH1mK31jRBK5I=;
 b=VspQQkCXP00Ye7oIHIWjMSC8vPR0q3HZoq6y49g2ReUJnPuHIRJ3292La3tshbeloy9nTOHYEj5HLQCRd9E7MjPvvh7Xb0AbrjRDyZDBvU32nQOdbnThk+7PcvGYRqZ2pgUbsoKvKJJzx4g7lDB377UTLGpuTKo1VQnRmHuLxKfFtJ1I5i0uIim2OrOJswzehAUyk7/9fvQ/3UjH5OomEQ1VPK46fm2Oo3bGnQ0a1wWav55PGxBJSgsZQ1ESkTqs+39dmDSCzJVsf7BTY8EiK4yjGnkBq6Aa4PFN1e9oHUgdJWGaVeIfcJS3bodiCVv+0i81yMv7S7RP9RtJ3HzlfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8021.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:27:54 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:27:54 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 00/13] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Wed, 18 Mar 2026 14:29:03 +0800
Message-Id: <20260318062916.2747472-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: dd73a656-bfe6-47d0-3fa7-08de84b77cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lDOBrejboaimYnDCQz6PHzmN6U7FePAtsz4TuBr3i83XrGEJIzxei8l72BlvNIlxt9WZZw/vmndeEjTcw7z5AmddQMetaTE+dqQHpzAGEqMD5CyOvYQWxlDHKGWPVKYOCoQogFXTL1eBYY2Lb79o8Tik+U7f4rjDFYXlQm4z2bynFrf9h0pxIYuek3miax7qOK2y6+hl690NSb18kX8iue1RTxF+zyhVO+NBej8WIHvAnzavRb0XKF42yCcUhj0N1ykif7DT4MgxSlWMby7KcBg4ok8N8EtXF0GPqeUqKWe7Rq/q94Yv0434nFwEtuoJ0kiZ4nJ9ZOlq4aMoEB7M1NrEqKvycUHI9PwftYCvSar2NiPAqpWqIcPOwhJzY2PnwGn9I1iJrghHdmg96RXCHDsmnukJEB+OAkzZHcwzRSBmobGhKXn2lE/Goo660SmOQiul2GMRTgK4Kzqqt7cOXCqb2l4BCzotrk5YZp0cpiV4zJGuZFInAqRZk0X+YoJpu3hlGdQoJkHf9Nc5WFJm28STFfsHLKqlk6OcckiwP98PLq61tphXdNig+V45aU8iMwamefC3uSvGNyx0Kb0jJHW04gmS5tKL8jufySg2odWuKj23EbIKakrVhp+2VN+XZlSd1RaIC1208frJmJkFZ3VcsKA5ksFX0FuxWcFMMjjo0YwNaLEMQ4neqMa3gHpXlHHVT38Z4BEXsPBHqPvB3jgi7yqvoL61NjJ+xX7X5xjfC9cK8eohB3vJevlDR/bc4bdwLzUxJ54CBPeKwK+3UhHNONLFJYsueilNXGv8Hc0wuZ9Kb7K5sXk6cMENRT2T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkRVa0FhLytJQW1Xc0QybjhLZlIySFhWenBla0FpcGhUNWo0dGpGc1hybHUx?=
 =?utf-8?B?U3Uxb2VkVlpIZE5LTW1hRk9JZHp2VHZiMENncVdYZ01NVHZ2bE42UDhmSTlK?=
 =?utf-8?B?OXpOSU5QekJIK0FraFRXb0R3YnRNQSt6TDh2elhjdEZveW4zT0pnajRVUm1i?=
 =?utf-8?B?aWtOQVNwSnBnZHVsRzlTNWtNZ1RkVnBpdEFuK2hQM2VmeUU2bTV5WWQvTWVp?=
 =?utf-8?B?ZTJuaVUrZkt0d2o0UWUzYi9rSFJaa1liU3p2SjduSlkyQ1N4dUZIZGsrWU9G?=
 =?utf-8?B?UGVQVGVLVjBuWUFIbzY1Y0t5YkV5OFQ0alBnVDArMjJYNnI1RlFXNWlPZHcx?=
 =?utf-8?B?cndkWVowMnVzQVlBeENWSWcvTVlsWUhLbTkxU2d2YnlpdjN3WENsVE45LzB2?=
 =?utf-8?B?amhUTFNid3hDdng5Y1dWYTU3bER6TEc4dytIQUJ0ODBOYWhLemgvMDBsTDV5?=
 =?utf-8?B?R3Jzd3M3UlJPQTNYbmJrSDM4aHhvbFovTDU4ZmFPNmkvTHlYamRNTHRNZUgw?=
 =?utf-8?B?OEJaOTBYalQvdjNRUVZTRzlNUHZZdTJhTkdNU3BUbG1UcHZMbXo5cnd2a2VZ?=
 =?utf-8?B?RFVsUWdIMWR0QzF3dThhRWl6UUxlODlOS3puR3hJVzlYUmtIUUxtcGpHUXYy?=
 =?utf-8?B?MEJvQkVaVVI2bGs1bVU0RlQwTktpYTJWclhkTGgyUENJRnBMS2F6aXc2MFJ4?=
 =?utf-8?B?R0JTRk9SdnRaL0ZLUCtNaXNNZEFJdlFlVjJaMGVtN1pHQkY5TEFvUXIvdzVS?=
 =?utf-8?B?eUkzanlzOHEyMy9HVjRwM1hqS2ZGZVJiNEJmTTlWdWM2eEw5eTR1cC9nNGV6?=
 =?utf-8?B?OWU4bjhwSXFjbGdRMVA4Z0llbDhjVE9abnd3TVBZR0lWRHRlbVJudmlNR1VE?=
 =?utf-8?B?NHRwRGwwZkVqNmprNGgwbTN5RkVCTWh4Q01uZkVrVTFzZVkzS2F5dVJSQXB3?=
 =?utf-8?B?dGt3QUl0YUxHc0VhYjdUaDZCSmhETnJiaWh1Q0Z2MFk2NW9mWUkwM1Y5Y1dn?=
 =?utf-8?B?RW1qTU50NEJKdzZxTlhKWUNWVVNVR0VHYTVQMERXc1NON2tqb25HOC94TWdC?=
 =?utf-8?B?T2RRa0pqNkZHak1iZm9lOFlpbU04Rml0VDlqTE9ObjViNkQ4djBaN05NNUxj?=
 =?utf-8?B?V1BxVGc1VWE1djU3bDVZRWJ2MSt5MUdzZjRaczFaK2FaZU16cjI3aytOcVg3?=
 =?utf-8?B?WEdUdGJwT0tWeVlkb0lWZ3g5SnhtNTQyeE84R24zd1dycER4T21IV3FxTENq?=
 =?utf-8?B?aFVSUkU5L1RONlZ5T2Yvek1KTzc2TjBFYnNkZjRnbXNQdFVoNkQ2WnRxZzBm?=
 =?utf-8?B?Q1RuQ2dlalhlQUhyL3orVUppWHE1ZjJJRzErTkJYemJjdzFSZjVBSUNtUE5L?=
 =?utf-8?B?cER0VlEzaWp2MHJqWlc1U0pYOEtLN2Eyc1hTd3FLY3lYKzJOTVVCdHBKUTZB?=
 =?utf-8?B?Yk9pKzZidU9GMU5SWjdDaStVZnRnY2JweTFmeGRCQStEbmpTZks1Y0VLY0h6?=
 =?utf-8?B?VmxIamI0MjJWR21CRmNOQ1NYRHZDd2tjaTFYRlF5UXBTVE5hdlUzU1BrcWdK?=
 =?utf-8?B?R0RRaWpwQ3V5ZVJ6WkRJWGpyVkhVUTQxOGwxY1YyV0thNVJ4TDA4L1FBVGs3?=
 =?utf-8?B?Y250czNSL0hPaWpVRUt6WUo0QTQwN3VHbkFsbDMrMnVxQ0EzZS83U2pYY2dx?=
 =?utf-8?B?NWxkN2JPYW5XbDhneFpTam8yQW1WcG5pc0JjMXNjd3BmUUppLzJSN2JkejJU?=
 =?utf-8?B?QTlBS0tQYmFZWW5mNDRoNHYyZ1ZDeTV2eitNWTB2Z2NNMlljRE1tOXZJMmlo?=
 =?utf-8?B?U0FqenJoU0tucURUS1c1eklaNXZ2MS8xWC9FV3ZwQlhFc01ZblM2UXNOY1ZN?=
 =?utf-8?B?eWx1ZWgyWnlHN0xQb0NHWmVkTEFRcWp5dXJZK1RTUjJ6dHNyT20xL2s1T0F0?=
 =?utf-8?B?MmRQR1pPZDNNemx4R3E3Zi95ZllxQlR6NFQxTWdkUWovd2ptSkxXSTFOUGs2?=
 =?utf-8?B?bExnaFV1UFdqSmx4ekZIV1pvbGJQMmdkc1RjL2QxbG5hQlk0b0dBZ1Y1K01n?=
 =?utf-8?B?NVdOaWxHT0RjWFJQWmp2a05QTGh5c3lMc1I5V095ZXVJbDNuUDdITVdGeEhX?=
 =?utf-8?B?STFacTUwZlNYRWdUd25Jdk9qSW9CcEVBNWVCY0Z3bktpaURsNGd6WXQrZFRp?=
 =?utf-8?B?Zkx5LzA1NzVDbVNhdHoxS3JLZTlXYngvRmtLTkRFSmY1M3QwRFNpSmV4Yisy?=
 =?utf-8?B?bE8yTStxN214WVY0bDkxdE1xMm1lNVhEbFREODVpQlorekxEc0ttZkpKYUZr?=
 =?utf-8?B?SmtFdjVleUhVZ2FMeVdkSVd2dEpGRlp6aFh3bWY0QWVyTzduaC90QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd73a656-bfe6-47d0-3fa7-08de84b77cde
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:27:54.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xUpVqk6JoPfBkfD4GDfzEc3Gcqg56y+hsjVU7/38LEasKZ+h0HEodJ33fAyPo8ETy/7UjYoO6YisrML4lUiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8021

Note: This patch set depends on my two patches [1] and [2], which do some
cleanup work on the pci-imx6 driver. 

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[3].

Also introduce generic helper functions to parse Root Port device tree
nodes and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties
(currently only reset GPIO descriptor) and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree.
Also add the 'ports' list to struct pci_host_bridge for better maintain
parsed Root Port information.

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[4]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[5] and PCI power control framework patches[4],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/all/20260306021247.991976-1-sherry.sun@nxp.com/
[2] https://lore.kernel.org/all/20260306030456.1032815-1-sherry.sun@nxp.com/
[3] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[4] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[5] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V9:
1. Improve the error handling in pci_host_common_parse_ports() as Mani suggested. 
2. Move the list_empty check and the comment to imx_pcie_host_init() to make it
   clear that imx_pcie_parse_legacy_binding() is a fallback as Mani suggested.
3. Export pci_host_common_delete_ports() so that it can be called by
   imx_pcie_parse_legacy_binding().

Changes in V8:
1. Add back the cleanup function pci_host_common_delete_ports() to properly
   handles the ports list instead of simply using pci_free_resource_list().
2. Improve the patch#4 commit message.
3. Remove the irrelevant code change in patch#4.

Changes in V7:
1. Change to use GPIOD_ASIS when requesting perst gpio as Mani suggested.
   using bridge->dev.
2. Add a seperate patch to move vpcie3v3aux regulator enable from probe to
   imx_pcie_host_init() and move imx_pcie_assert_perst() before regulator and
   clock enable for pci-imx6.
3. Add device pointer parameter for pci_host_common_parse_port() instead of

Changes in V6:
1. Drop the pre-allocate pci_host_bridge struct changes in dw_pcie_host_init()
   and imx_pcie_probe().
2. Parse Root Port nodes in dw_pcie_host_init() as Frank and Mani suggested.
3. Move the imx_pcie_parse_legacy_binding() from imx_pcie_probe() to
   imx_pcie_host_init(), so that dw_pcie_host_init() parse Root Port first, if
   no Root Port nodes were parsed(indicated by empty ports list), then parse
   legacy binding.
4. Add device pointer parameter for pci_host_common_parse_ports().
5. Add NULL pointer check for reset gpio in imx_pcie_parse_legacy_binding().

Changes in V5:
1. Add the Root Port list(pci_host_port) to struct pci_host_bridge for better
   maintain parsed Root Port information.
2. Delete the pci_host_common_delete_ports() as now the Root Port list in
   pci_host_bridge can be cleared by pci_release_host_bridge_dev().
3. Change the common API pci_host_common_parse_ports() pass down struct
   pci_host_bridge *. 
4. Modify dw_pcie_host_init() to allow drivers to pre-allocate pci_host_bridge
   struct when needed.
5. Allocate bridge early in imx_pcie_probe() to parse Root Ports.

Changes in V4:
1. Add common helpers for parsing Root Port properties in pci-host-common.c in
   patch#2.
2. Call common pci_host_common_parse_ports() and pci_host_common_delete_ports()
   in pci-imx6 driver.
3. Use PCIE_T_PVPERL_MS and PCIE_RESET_CONFIG_WAIT_MS instead of magic number
   100 in patch#3 as Manivannan suggested.
4. Use "PERST#" instead of "PCIe reset" for the reset gpio lable in patch#3.

Changes in V3:
1. Improve the patch#2 commit message as Frank suggested.
2. Add Reviewed-by tag for patch#1.

Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (13):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: host-generic: Add common helpers for parsing Root Port properties
  PCI: dwc: Parse Root Port nodes in dw_pcie_host_init()
  PCI: imx6: Assert PERST# before enabling regulators
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  32 +++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |   5 +
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |  11 ++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |  11 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |   5 +
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          |  11 ++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      |  11 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |   5 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   5 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   5 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  10 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 ++++
 drivers/pci/controller/dwc/pci-imx6.c         | 119 ++++++++++++++----
 .../pci/controller/dwc/pcie-designware-host.c |   8 ++
 drivers/pci/controller/pci-host-common.c      |  77 ++++++++++++
 drivers/pci/controller/pci-host-common.h      |  16 +++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci.h                           |   1 +
 28 files changed, 436 insertions(+), 25 deletions(-)

-- 
2.37.1

