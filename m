Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC663090C6;
	Fri, 24 Apr 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024185; cv=fail; b=ZZV+prETRY1RCeI3MdbYCJYZpGaiRMwGMDJufDdKmgMaYFuFEIjuB/uJ/qeosd9Pl2clRofRULgvF1uOvAkVgPAbCIzseHhmAFo0+1L54Yx/D9WdyUVXmU5zOvQBTpnygdJc79sf4MS6VSlHKgcLPeBLfznJxU0YTetZpCAn+/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024185; c=relaxed/simple;
	bh=bhRFNaJqkPWBqwBF6NWfYI1pH0nREqZplwYGqVUASh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzefznjJcICeJvz1DC0xNJDg4otXrWLM7WX/sLwAU5gPkTe6P0WBSZ/hhcnjgohACYnkH/D+JELljiPXVFYLTMMGddckAVfBepOpTwCjquEyyIt49cz6CBSi0KqX/AQ6k4gdOdrXyCpHQTRTIkUjkfrUWQJdMHgHGbypjjyGplQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=r0lft6Pp; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="r0lft6Pp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hg30sTlnOA+5CZ+nlT8VZSaOm3Ca+Rquwn0vW7Xv+GIq/ylzWvU02+SJo7wdL0d7KA9Fplpp2Uhlgjn+l3MjIHINd/JGnPayWCUYmzrtS7/0VQ3KIzdVXktuNL50l2s2Ujf5LpOLSvbM/sAxwByoPwomVMzJRuvUU0u57M38Q5AkYz3ncqDfVMruN/+DY0zra8h5DbwAPaD85SpoGXTZonvywu2DZHeGEazqpxeHnaevBakKtiQphhjyEda45YkLNiqsXRRHfWKFpO3d5GaKVJwpKBYSnQgZdFudB18ALrjW+jbje64b85yHOeiBf8kPmsxqGMkjp9kBtLer3fTYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivJMs2Y76+V7A/H3pm3TU3muagmoXA8CrAUAszpgFRk=;
 b=drm4Wi1BgqpoGfjVmRM5LYhGvGyWgu8gbp4d+dagY8wU13CatCQHTDFtSe6lw3eszQOMIs4S93dpcUIWaEE3BQa8ZvKLYMJPnITjzM1ujAjjnbEqtNZTFO9679ASwA75+xQMRkaJY3bSnwKDU65F8IBOAz25r3cASLfEnWvnJoLT016/+U+3iUltbX4G106wR/k3gqNonyit/I9jMk+UXD0d5S6L/HxEhbWgdCUflZRCh2VHBnU2eboIdaegf0Dcsf9wemmi8AIKcVE5ASn4AVI6TNci+DEHdc98IGK2v15Z1aOGCzkSB31Cophkrl3p0rt+s0FiSh//gr6OJrCQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivJMs2Y76+V7A/H3pm3TU3muagmoXA8CrAUAszpgFRk=;
 b=r0lft6Ppq3BW8YoK2iNrB4XstRAXsgkkA6sHtp2k7Ms6NQoAkB12UNZodC0S1dEFirNxuS20XKKOEWXE+TQSGeR3uFxFVH13tco2mtTlOQVel0Zj0OPsO8E/taIhJyUWaAirz9SjIACcnh2RMm30dYS8Wni+j5yay7WtyB/maM6LD4dYLryxlI8B1HUJ1CAr9HLciEqmp6wHl6slc9wCKkAW7oZyH0l+Q0yDFGU31YS+U3TJcNiRf331SD+80BqzJywp+3djrIj9kfKBz8xcOxgyWMbNE+5Pg1HE35Tn+D1lFvfhkM0apPkPsgqY1QARDbi+We2lWWUfElckDsSXOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by DM4PR03MB5982.namprd03.prod.outlook.com (2603:10b6:5:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 09:49:42 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:49:42 +0000
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
To: joyce.ooi@intel.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	subhransu.sekhar.prusty@altera.com,
	dinguyen@kernel.org,
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Subject: [PATCH 2/3] PCI: altera: fix resource leaks on probe failure
Date: Fri, 24 Apr 2026 02:49:12 -0700
Message-Id: <20260424094913.522123-3-mahesh.vaidya@altera.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424094913.522123-1-mahesh.vaidya@altera.com>
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|DM4PR03MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7695c205-8be5-463a-6110-08dea1e6cf12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5dh3eQEWyKduXqsMBOus5Z5rbKpuXRUpjqxlFge96usXCy/eVN21fx6LHL6hyNgjGjyz5Z2lZJ3eKQYoNWJMFlNGSTrEJZuYAeMWv2bUhIkw20UMaY9uTL8bqzaqVx51HfWMVGhe7WWaEwXJ5o9j6EkqPskYKhjcJRXd85N6jAL3/pWSsMiOuTFbt6iWdLwzTQwv/SCwHQsROMt8l8oLR0yxkL9DJmXBSSU7Oi6qr3RWqFP7q9yoBXcmRNWnc/06cc3BNUB557w0RT1gmGyTWmhMX+aOZz7CNBDpJ++kOpFZ+l9CuKrWfjwakRi7amTittgMpRAoifAA9FZTnR3c8pQ9045pK01p0mb44tI11o4yZVtNS0UevX27cQZCZOcJAJKMQVPO/7Dyjmz4RaMaaXHdKbbfaJt6HGxjPOGnadYeoouNszAL8UaW9MJc1lAZM6VmfNzvbLzATbWkhJqpcCjuli5FGV4FxKask3lWPNbjiLXWNzipAyWE7SzqXtrV7XjrfwtO+70HWCsHHj4/joNFl/fhUkFpOumgEDvszjudG/Xsdlmgvza26kaK2RnWN2AIfdWMjx8KmppDwTCxnBdzdNvRw7hHtK20NM/kYg7UjFrDg+B2llwRUE+naKvckNsuNdjxcM0MNPSYgv1kl/aGZ/kxh79tMblQMV0s1vPRUOPK/pVtQAgUPLtVPlQAqQ3MXi9BigNoY4Ep4oy18xbl4bGAN32D0v8TnJflxUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uMTrJAwOhTWdcpKfIrrbwugkA9I/lV3PsM0WfjG1J4sXWLdKLPVUTdmbdM1t?=
 =?us-ascii?Q?uKw/ESBBQi7KKTrztUBoX+3qie5VCZXTNd9LkA/zUYeVB5paXK8ndOWvFZRx?=
 =?us-ascii?Q?oTAB16QHo9iVsT+KiggrRM2gx4V/oEuLdvQXkhMVMncqfBKPgMbmpOt0XYCM?=
 =?us-ascii?Q?IXWoZzW3E2xzY/V6CKDsKrKFrJ/HFho6aHDD0O5iUt3uDBtOx8/3ggRC+b/w?=
 =?us-ascii?Q?UzQoi6Edrfib3+hnT7+9+KiTQgKy5OPzylqdC2yEYp4e6mBF0siPc4LSm1fF?=
 =?us-ascii?Q?87ByrPnFcYwcUZF2YSYiNHOKESK5x0VpGCL0detvhb1oKPJf0KcjV7CbxrV2?=
 =?us-ascii?Q?SUMFUNhklL4CdbO7jK5rQthYDOgeLpc79AlaWh2QSX18whcu9b1Gvy/CfH5K?=
 =?us-ascii?Q?41REv7pByAqamVS+CzTdQS5T7V7aMzCZ4a81VMOPJ+4XkUsN5Zfja9FWVgg0?=
 =?us-ascii?Q?bMxcC2JMZgKK07CunYKHE7OxndD7XRUS/RfLCIXYZJmj+B696ISatiJT2arI?=
 =?us-ascii?Q?zsIi/+JZCZoeiKF1XoliCW+2LJj4zmmRGRFoSHCEXI6xCDfh+D6RCfl6qMGr?=
 =?us-ascii?Q?mlTnUIn2isc7eBZeA0QSUHMmUy19dcePYwelsGCTAdrf3M3PND9PBMOd699G?=
 =?us-ascii?Q?NWyu3iGjvRBusEv6RRrrPUush9iIsrBgUgRUqdGJCtnzmGrBSX5J5FUmpCit?=
 =?us-ascii?Q?m7+NkbiBkld/SWC3pnTIjBxEQFy+HCJ2zXTsf19VdwnMLyAawdxmi7g0+Esi?=
 =?us-ascii?Q?BngnMv4jvv7yhrnDTtd13z8Sx6E/71OR/ZmicaxKXEZsDnb6kYjAWCmx6Ppi?=
 =?us-ascii?Q?4/jyBvZmHg9jbriRPlmJoyHdp4nd6+rmwuNOmKiA3194ddIRnrhdjI38APdz?=
 =?us-ascii?Q?hgwAPbSUX2RaJcUm29UhomkaYzfnZ9gDFcmo6YbBnKWo+2W0SMjUDYYeO1tJ?=
 =?us-ascii?Q?cjePh/iKpF9yoCF9BB79EcitIQHp6JEz43LTiH9lwSXzzYrYOwWfnBQG0jUW?=
 =?us-ascii?Q?zbdo9iLMY0yi0xwun+WL10NMU/TllVvICVnK9EV9omrZLrT6k6EHLzrcM1L3?=
 =?us-ascii?Q?CtS2MmO2NI2BfO0tpXUmvNIxPUZUtKG95OnDmgd/7gXQN75hpqCFGym8rUJc?=
 =?us-ascii?Q?TsDg4jtp4TLPx9QbK1kNt7RMqMphGdButYRIFQfGSUXZW5rHljNfKvlxPjg8?=
 =?us-ascii?Q?GvebmALfjG4yPmDHCNTBBEBTXatYxpEEgQjc1T+t9j0O2kwA9jyGIeCkv7CM?=
 =?us-ascii?Q?TTbyaG7GnAyJRA6CeB25DecWMonDm4vomisVbuPnJyfQQem/YW24SVLEUpWR?=
 =?us-ascii?Q?iZrVAlP/voQsN4cYjDhq4Vy5YnnozXMdxrSMdXeWaSNY7WhHezh4bi9Ew3Pb?=
 =?us-ascii?Q?DuVv1NUtaqbYUUnm7MF9Dkj3MuOMgTBn+smZUdcRdAy+oEXhf1FnsdffrMoj?=
 =?us-ascii?Q?/Px7mpWG64mWE+afDylIc5VKbq/ZyWiJbC6TTpiCbJSXUpif6T4wgLkzhYtp?=
 =?us-ascii?Q?Jx8uLtuK7aC7mddYy9aev8eA8UqxZqeJal/HN+aymr/OhR9S0/zyVizVJg36?=
 =?us-ascii?Q?ZN8izi7Gz8f3xPcS0E+G4GIX5M+bBO1oS2NAxPFslqiWYBiptWjUaMyL4S0l?=
 =?us-ascii?Q?1a5+aatlnN+Jap7V1bChGKxVeIJAFWljpKKZifMRHu34L9HlCIAB8X8ol3GJ?=
 =?us-ascii?Q?nlmLMOgaH6gpHpv9pBWrmFNz8WAqjHMa/WdkggzbBF50FpNGQ98hITIjXgW+?=
 =?us-ascii?Q?RPBnBAlN1g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695c205-8be5-463a-6110-08dea1e6cf12
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:49:42.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdoNl3AvNR/lkYrTC9M8XOS5gPbl1fvw+jxjWtUKn3iekUfJpcHhqXJ1jcsDSCem5aI4y1JsYk9Mp/xdP5qyy+IWZ6BxZ5wwnWuIBAzeN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5982

The chained IRQ handler is installed in altera_pcie_parse_dt() but
never unregistered on probe failure. If any subsequent step in
altera_pcie_probe() fails, devm frees the pcie struct while the
handler still references it. A subsequent interrupt would trigger
a use-after-free.

The INTx IRQ domain created in altera_pcie_init_irq_domain() is
similarly leaked on probe failure, since the existing cleanup via
altera_pcie_irq_teardown() is only invoked from the remove path.

Move the handler installation from altera_pcie_parse_dt() into
altera_pcie_probe() after the IRQ domain is created, and add a
goto-based error path so altera_pcie_irq_teardown() is called on
any failure after handler installation.

Fixes: 60f2ee5f1472 ("PCI: altera: Add Agilex support")
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
---
 drivers/pci/controller/pcie-altera.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..025ba74d1ee2 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -891,7 +891,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1020,6 +1019,11 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Install chained handler after domain is ready */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1037,7 +1041,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)
-- 
2.34.1

