Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749146;
	b=UOzUvMMo53+n7b+VYNVdJSTka7k0k21H9XGsbYruvdr7T0uF17U4PMdGy5V9j9MtsSMY
	 TUaaeyZqNv2gTJNcaacf9SD/8pcy2VzLA494/zVTqGsnEsQRg/Ojr6b5a4YVOgdAby0b6
	 nQ52u9Oo8Jxkn+UBmdzmhYEudq03RXlOL9uQvsXyc2K07CcBZyKMtdT4Sxw026oI4s1tV
	 B4xHoOnPoPY6EnxGIy4OBPXs+jvSmipByGKv1t7AS9FWg4VUPIHucFgSbh7DoBf2Y7CUq
	 6pmUuR8+4IIXztN8UTjyURq9UyYYBc3xVtR7VLzx5xxD4uv/Ix6s0aU9NnMjSG2uAiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749146;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IH/lp6yFngKoB11/HMTYQ57NwgQ2mo7N9xntuBw4MoM=;
	b=xQEmXVXwEZ0VdfeA6Nvut31hSCe0GMzhp+JF70hHtLEDx1PuldBR7xuX13DrYLYJePEw
	 gc3TOH463xLoH8gZWfjCYcrOHSum24Kz5/vputPRoW8qOGVypzGXaI38/XMbufvvxz9OF
	 pc4QAKRpskoZ66+yYkk6xAugCzjKoAg64kA0KG4ErRSgflmz0iv33DnsgxJ5iHPKXrmLB
	 nnI0RirrBg3Geyzw6MUwrnNbjah98zR2D+KsuBY1n2BVa5118ESk2tK7h7V26XQyjD8c1
	 QDZOCFbCdrxL+vZpPNi1Cou1/I2t2+qZhvPrSOHv7jQqUiEYVJwcW+GDy/mEZIUz7/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Zjy1Bypq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD660A3809;
	Fri, 27 Nov 2026 03:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBD660A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=Zjy1Bypq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asIUcS22s+gfQdsZ+FkuaKm70nI5wv4ZnTOBgzMzyAdeTlIYbAgr2vRX0Wf+PBE0qObJNAro/jRZyKOU2AnJL2++HpNA59GyKVqus9IkGUp0jiTu4yGi2qxWWWY+tZIyoXk39mBl2El9i7RFTiEBvjziwl3dxg2PzQ6QZrt9pk5ydgCYGZhqoNiAZEanAQC5oVilunhkif1MoAKxLHY+1dwmwMp3JCJsDbRUCRg4MsMb14Y6GFyuywoqOdGWFB1Z282zXX7u4U7iCW0hOjiaC1kXDfqrmTEVxIGCa0N55YuACYIIaB+R1SJCRFhMz7ifdKXknDk4yWc9X8mZFro7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH/lp6yFngKoB11/HMTYQ57NwgQ2mo7N9xntuBw4MoM=;
 b=vNO7vmHJSWnhm1H7DWbtlo9ZYS0eOEmrs2ITg3B4x+zjWJazG5LWQezpv8tq44Aw74ONBnUSaBO838nXBHlVcUU9BagnW6d3pRGht60+m5NxBiWOCWE1eDHyk2FQ1DBkvtEbYg4jSAT2oqZBW6y0+XeDYHVw+c6NWrNT5BQyahf3CxUm9FbGSrDS0/EXWa1fBWVdAE4GVqHV6b4bwNuSgeMraRzbLCDbP8DPf8UURkc9q3p5paWwzpvnHkr5ffZTEvpkdLSlQGRkWlkpr1aeMQZ85/Q2H6QLS/H53KVqh3fANLSgzcYC+UbHI28yF6QkM8BoJB/XIrks/ETvOi8c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH/lp6yFngKoB11/HMTYQ57NwgQ2mo7N9xntuBw4MoM=;
 b=Zjy1BypqU2TObuHE3BnZqiag5peJ9CRSbqlmbNnupzE8J4qaPlvZvr94KTKC55q/uUisraS4qHJf332LGN5ETMehNS23bsoI3sGP/WTvkDrdFC+ogQ9dFGNomrhHVJYZpI3ZD8U3lh81PVrXJpRUkWOw5zQxvyhs9UnaAk7mCfY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:23 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/17] PCI: rcar-gen4: Recover the Root Port on link down
Date: Fri, 27 Nov 2026 12:11:40 +0900
Message-ID: <20261127031145.2521228-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b324024-f117-44e9-9493-08df4c343fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|6133799003|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	0RZzmLys0iuXih+bfPZBw5QPYKp5uxNLnkGlCNGjRfw2PPtKp1axX7qJ56Gd6P8xd8WvNFm0It2z/d0zeUtHowea3VtGQmDANyvl9tFo9LroROdNJzos52WpFq3NmFraGMoqmJi03HOH3pAibSHYBGt5p34TkpRqLqiecr4piw5jw1KVo9eRjq7iv6YpPLCZEjloJlNxKVACn4JckAYyDwOAp09NwcT2tZDqeclWQYC8JhstDQ5ECH8z7i72+DTm895ugdJ1UHbo2IM9Lb5yw9ovnJirNCsLO/DqP3SilOOsqoLIiWaVIm1sMByR14WQVLJCwv/EIBaP049YfQSkoaI6M6BQdMf6gGnbdD/AH5RSGFS1hGXImRDUepTqQmLv32pbofaaVA96qDKuDK28XUvPAQJ/D030t5KXBIJoqVkxcnxVXb085oHawJ+WGNaWoIgbY+m78Y7/+i/aNy61FpKh7ELB+8jIQDIt/H30s1Jjcl3lo6830EfAnvwSZXEB8c/Bx/seoizICSiRYBuzDh2WCjtat/olPpSaIsfX6zWfVV5Y3SfYWI0ePI11K7IRyxeBnhhcDK7yu4yLndCjsHp6aK63VcxF9c5Kmgq/1C02QwUHz5WNsqvvs76F4+h2GmYVbQgU2wou1+YboWTmqjslOysBheOw3slfBscAk1v36vAy0YCptv1lBjVBndWm4vL/Pdvy2FSwmPWlMv7SmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?faS1pGKWwRvBykemVIKjpCA2v8LGhXrNUjmMowtu0oHLWx4VCT4CQ01hQzj8?=
 =?us-ascii?Q?WdviU0BIAd+0HsJRAHfbpt/s9kIm4LSlnK6KI/qbQnCXv5bddI9iUARcLPsq?=
 =?us-ascii?Q?yQH/wcdAJgTzV83HjKhU+lElLSdfHQ02D2InjgswJ2YA9JmSad6pY0gqPQ8d?=
 =?us-ascii?Q?GFtjVLPE+IlE+XdFCU5rXv7F5jQ2LaR9s8AT8ICait0jkYYRCskcx7fgfJui?=
 =?us-ascii?Q?ItOCRCmNa4yQCItMlPyqwqnYClJS3bLClUQaRtUzpnkiwz0UbPF+pdKRYb4Z?=
 =?us-ascii?Q?Q6OwU4BML90djPyvtGZsqQlB/l2Viyh4gHN25QYvOlTF366M3KxbPiMSxJjU?=
 =?us-ascii?Q?JBZyIhVPek/w/haXj2BtT1moHk3dhbn0EYMTWTrcTcvJareoFz3JoLBFolDo?=
 =?us-ascii?Q?nGGqGnA0lywRiJIX6CgPtAyvw7VNHqq0l6teTqGS2fr5G9RzcM1SFUqP9iKU?=
 =?us-ascii?Q?eTTiK4/BRO9VGYI6JrJemNPbfNJoEyBgkdrcsB3Ww7wve1mRok4DhJEWqCwf?=
 =?us-ascii?Q?5MNDRTv9AVSh8Y+jhFbVo9euSqHcbNj7ADD1p0bKsd3U1t9kMI4Y+CY72Dgd?=
 =?us-ascii?Q?vwi98FD0PYj41UMLOfu/HzwU1wBGgIjQrPNZcBevfPOXU9GvARdqRSheG3qc?=
 =?us-ascii?Q?1RDkPP5AMDNl01ASBPaSWQMCIEdjavDaDxUjP1llKh4UD+obNzeRhWU9XruJ?=
 =?us-ascii?Q?RZxvCpCIc/UvZ9q4YCgENgGpPkuQII9Ie2rB45NZf0TESPVEdwDRPG5X6Gmy?=
 =?us-ascii?Q?0hHws832eZsArIqEL4BkewykG6YjqZ21UxMrlqwYZrQcTQfoyMXs0ADnd5Q7?=
 =?us-ascii?Q?mAlA1cQ9EhjxgpT5o4fuciriBK0j+vFcx2zg3759YyqqQoKk00CRW1Eicg0m?=
 =?us-ascii?Q?TbLNmsBUcrr2kVR5FKVqTAPuVowXaB5hg1LCoKgi0cvMcDsuAhaUJqe2rPJ7?=
 =?us-ascii?Q?5yqmnO1rKY6U/EFNAArzFkohA9+oAmfqo3oUUnEib41u53wdkpNpvM+O1DWt?=
 =?us-ascii?Q?IcWTkBAyXXgpd3ZnCRK8R/oBP52QweoYgD1IVvahFX7mVYF3FnC6Q56Weudz?=
 =?us-ascii?Q?PcBeOnpXvH8uHs3zBO4FnUuMKjTACOzmuvbXjsopu6lRIxL6EunzRvZDSIxB?=
 =?us-ascii?Q?vSj4NkeE23dTC3gptEDzMmYNxf7EisT9a0ubyFJPemPvUA+zzE+iA03HuZdi?=
 =?us-ascii?Q?3VGSX7FDtArep22CBeU3VjNqMWxMpww7OSYv7m6dNv/ixG3G7z+zcdXAtd1z?=
 =?us-ascii?Q?n1U65bhiqgCGSSz+tPfHtgZES0nF00B3eWLfmiNiqqBrLQkia4UoQomxJmY1?=
 =?us-ascii?Q?c9HXbkNIo25aV+PZ+TNp4IhbjAfawv501uUJwT2JRY7owW10wVvJ9H6La3tH?=
 =?us-ascii?Q?5DfgKVzidPkcNUSFb9Ql3uuKXEOcUtJ6VFra5sofA2PQPeAnc/zmCOYnZw8v?=
 =?us-ascii?Q?8izkuL+3vM21xyFPP7PSL7H10dlkcDSu6RdBW0ETT+/MnFospHMSFamg+dMN?=
 =?us-ascii?Q?k+0jifPa6lP/sYk3I/jQpz0bonUMUfaSdZV5laimN5MafIWtSo17x9qwwNc+?=
 =?us-ascii?Q?jGv6aRRfCnVa2bWBEMLGwdkPr6aWiJvD/qo+UUc4jEjBWMJOCmTE7lzqqjLW?=
 =?us-ascii?Q?n4e7sjS6Zx/qqNdjMZgu0ZBpJjRyhDyJw3fCZtvu+z0E7tO0Zt67U0uNQVos?=
 =?us-ascii?Q?D4g6anNs0bDKoS3fkWju/i7YwIhuzhsGUodoHF2LOpnLySzeLZ7Y71g0YV9Z?=
 =?us-ascii?Q?AMCsTewQdhVms1DNYpMzONbeLlbUrc+1tNI9kTCjgiUzh5Bs4HU0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b324024-f117-44e9-9493-08df4c343fa8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:20.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWNsZnXFyQGkLeluLWb+2LM+ntHB4Jvt92E9WYWC4yhbqLwZG5hiYxH/6hLp+K8KkzeyLgHD/g1nYXCXRKeYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

On R-Car, the controller's reset requests (smlh_req_rst_not,
link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
demultiplexed from, so DBI is read as soon as the link goes down. On
R-Car S4 that is a hazard: DBI accesses issued within a few hundred
microseconds of an unexpected link down do not complete and hang the
host. In testing, the first Root Port config read after powering off
the link partner hung unless delayed by ~300 us.

Check the APP reset status in the interrupt handler before DBI is
touched. When a reset request is latched, flag the controller as
needing reinitialization, which masks the sources, ack the request and
schedule recovery work. The work calls pci_host_handle_link_down() on
the Root Port, which runs the AER-style recovery and resets the
controller through reset_root_port(), holding a reference on the port.
If the Root Port is absent when the work runs, reset the controller
directly so that successful reinitialization can restore interrupt
delivery. Hold the rescan lock across the absence check and reset.
The APP reset-status check also reports a recovery already pending,
whether started by another interrupt or left over from a failed reset,
so the handler issues no further DBI accesses until a reset succeeds.

Arm detection after initial PCI enumeration, so recovery does not
interrupt device discovery or resource assignment. Only unmasked status
bits are handled and pending latches are cleared when the sources are
re-enabled, so requests recorded during probe or the reset itself do
not trigger another recovery. Teardown only disarms the detection: MSI
delivery has to keep working while devices are removed.

Run recovery on a freezable workqueue to keep it outside device
suspend/resume. Reject suspend while a reset request is pending,
including one latched after the parent IRQs were suspended.
dw_pcie_suspend_noirq() would otherwise access DBI, and the queued
recovery can run once the system thaws. Disarm Root Port events during
suspend and re-arm them in .post_init() after resume has set up the
link, so taking the link down for suspend does not start recovery.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - None.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 127 ++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b54acdd386f1..76f520b6e86e 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-designware.h"
 
 /* Renesas-specific */
@@ -40,9 +41,18 @@
 #define MSICAP0_MMESCAP_MASK	GENMASK(19, 17)
 #define MSICAP0_MSIE		BIT(16)
 
+/* PCIe Reset Status */
+#define PCIERSTSTS		0x0020
+#define SMLH_REQ_RST_NOT	BIT(2)
+#define LINK_REQ_RST_NOT	BIT(1)
+#define LINK_DOWN_RESET_MASK	(SMLH_REQ_RST_NOT | LINK_REQ_RST_NOT)
+
 /* PCIe Interrupt Status 0 */
 #define PCIEINTSTS0		0x0084
 
+/* PCIe Reset Status Enable */
+#define PCIERSTSTSEN		0x0300
+
 /* PCIe Interrupt Status 0 Enable */
 #define PCIEINTSTS0EN		0x0310
 #define MSI_CTRL_INT		BIT(26)
@@ -53,6 +63,9 @@
 #define PCIEDMAINTSTSEN		0x0314
 #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
 
+/* PCIe Reset Status Clear */
+#define PCIERSTSTSCLR		0x0330
+
 /* PCIe Interrupt Status 0 Clear */
 #define PCIEINTSTS0CLR		0x0340
 
@@ -117,6 +130,9 @@ struct rcar_gen4_pcie {
 	const struct rcar_gen4_pcie_drvdata *drvdata;
 	/* intreq_pcim_sub ("msi"): iMSI-RX and other controller notifications */
 	int msi_irq;
+	struct work_struct link_down_work;
+	/* Allow Root Port event handling after enumeration and until teardown. */
+	bool rp_events_armed;
 	/*
 	 * The controller needs reinitializing; the APP interrupt sources
 	 * stay masked until a reset succeeds.
@@ -543,15 +559,35 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
 static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_rp *pp = &rcar->dw.pp;
+	bool rp_events = rcar->rp_events_armed && !rcar->reinit_pending;
 	u32 val;
 
 	lockdep_assert_held(&rcar->app_lock);
 
 	val = readl(rcar->base + PCIEINTSTS0EN);
 	val &= ~MSI_CTRL_INT;
+	/*
+	 * Note that rcar->rp_events_armed is not checked here because device
+	 * removal may still need iMSI-RX interrupts after Root Port events have
+	 * been disarmed.
+	 */
 	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
 		val |= MSI_CTRL_INT;
 	writel(val, rcar->base + PCIEINTSTS0EN);
+
+	val = readl(rcar->base + PCIERSTSTSEN);
+	if (rp_events) {
+		/*
+		 * Clear latches recorded while the sources were masked, so
+		 * stale requests do not fire as soon as they are re-enabled.
+		 */
+		if (!(val & LINK_DOWN_RESET_MASK))
+			writel(LINK_DOWN_RESET_MASK, rcar->base + PCIERSTSTSCLR);
+		val |= LINK_DOWN_RESET_MASK;
+	} else {
+		val &= ~LINK_DOWN_RESET_MASK;
+	}
+	writel(val, rcar->base + PCIERSTSTSEN);
 }
 
 static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
@@ -615,6 +651,50 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
 	return ret;
 }
 
+/*
+ * Consume a latched reset request and start recovery. Returns true if DBI
+ * must be left alone: a request was just consumed or recovery is pending.
+ */
+static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
+{
+	u32 status;
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+
+	status = readl(rcar->base + PCIERSTSTS) &
+		 readl(rcar->base + PCIERSTSTSEN) & LINK_DOWN_RESET_MASK;
+	if (status) {
+		/* The sources are only enabled while armed with no reinit pending. */
+		rcar->reinit_pending = true;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+		writel(status, rcar->base + PCIERSTSTSCLR);
+		/* Keep recovery outside device suspend/resume. */
+		queue_work(system_freezable_wq, &rcar->link_down_work);
+	}
+
+	return rcar->reinit_pending;
+}
+
+static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
+{
+	struct rcar_gen4_pcie *rcar =
+		container_of(work, struct rcar_gen4_pcie, link_down_work);
+	struct pci_host_bridge *bridge = rcar->dw.pp.bridge;
+	struct pci_dev *port;
+
+	/* Serialize the absence check and controller reset against rescans. */
+	pci_lock_rescan_remove();
+	port = pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	if (!port)
+		bridge->reset_root_port(bridge, NULL);
+	pci_unlock_rescan_remove();
+
+	if (port) {
+		pci_host_handle_link_down(port);
+		pci_dev_put(port);
+	}
+}
+
 /*
  * intreq_pcim_sub carries the iMSI-RX interrupt along with other controller
  * notifications, so the driver owns it instead of the DesignWare core (see
@@ -625,6 +705,10 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
 	struct rcar_gen4_pcie *rcar = data;
 	u32 status;
 
+	/* Check reset requests before MSI handling, which accesses DBI. */
+	if (rcar_gen4_pcie_handle_link_down(rcar))
+		return IRQ_HANDLED;
+
 	status = readl(rcar->base + PCIEINTSTS0) &
 		 readl(rcar->base + PCIEINTSTS0EN);
 	if (!(status & MSI_CTRL_INT))
@@ -663,6 +747,28 @@ static int rcar_gen4_pcie_msi_irq_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+/* Keep link-down recovery out of initial PCI enumeration. */
+static void rcar_gen4_pcie_rp_events_arm(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+
+	guard(raw_spinlock_irqsave)(&rcar->app_lock);
+	rcar->rp_events_armed = true;
+	rcar_gen4_pcie_app_irq_sync_locked(rcar);
+}
+
+static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
+{
+	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
+		rcar->rp_events_armed = false;
+		rcar_gen4_pcie_app_irq_sync_locked(rcar);
+	}
+
+	/* Handlers queue the work under app_lock, so none can follow this. */
+	cancel_work_sync(&rcar->link_down_work);
+}
+
 static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
 					struct pci_dev *dev)
 {
@@ -870,6 +976,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
+	/* Re-arm Root Port events in .post_init, after link setup. */
+	rcar_gen4_pcie_rp_events_disarm(rcar);
+
 	/* Stop the handler before asserting reset and disabling the clocks. */
 	rcar_gen4_pcie_quiesce_irqs(rcar);
 
@@ -880,6 +989,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 	.init = rcar_gen4_pcie_host_init,
 	.deinit = rcar_gen4_pcie_host_deinit,
+	.post_init = rcar_gen4_pcie_rp_events_arm,
 };
 
 static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
@@ -891,6 +1001,7 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 		return -ENODEV;
 
 	raw_spin_lock_init(&rcar->app_lock);
+	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
 
 	ret = rcar_gen4_pcie_msi_irq_init(rcar);
 	if (ret)
@@ -912,6 +1023,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 
 static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
 {
+	/* Cancel recovery work before removing the PCI bus */
+	rcar_gen4_pcie_rp_events_disarm(rcar);
 	dw_pcie_host_deinit(&rcar->dw.pp);
 }
 
@@ -1309,6 +1422,20 @@ static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
 	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
+	if (rcar->dw.suspended)
+		return 0;
+
+	/*
+	 * Recovery work queued after the workqueues were frozen cannot run
+	 * until thaw. Abort suspend so it runs then, instead of touching DBI
+	 * here. This also catches requests latched after the parent IRQs were
+	 * suspended.
+	 */
+	if (rcar_gen4_pcie_handle_link_down(rcar)) {
+		dev_warn(dev, "Controller needs reinitializing, aborting suspend\n");
+		return -EBUSY;
+	}
+
 	return dw_pcie_suspend_noirq(&rcar->dw);
 }
 
-- 
2.54.0

