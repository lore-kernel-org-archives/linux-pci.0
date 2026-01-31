Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492A273D9F;
	Sat, 31 Jan 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866628; cv=fail; b=MeihejkFqsgVgh/cQ5OLrKYEOTQGy1eCH0m22HWqB7U/087fafDyAvzlRgDLjeFCMN5XNrunOqTv7Dy3rlKl3zEUh2VZbxsobVaMLEFauwE6MlMePdH4BqiEVe0CqawmnIF/3CVeVuh+j6yww1/0T9i2MUd8aVei6nCAR2pT0U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866628; c=relaxed/simple;
	bh=KdhC7l02/HaYjMy1/2RJ9CjZedUBhWujdvwmKEsLCkA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gd5hJDH1CHx8U6gW+BV1Tl+7yBLChXWE+K4VcAt1JaLU/EgcDoCjdXXEs0EfXFhy+bd0IZDKeP8/CnYriP2IQOvYtdJGMFPxlMj5Tsjz7R/7pswv3OWyIbHlt+frPK5s/1dGz6e9Uj7ta/rPUM0lMw8bgW8atzjqkWyZr84rROQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nJLOmpFU; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nJLOmpFU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaANHIphAqf6hvRZrmGBwyQD/Ey/8+qbkvPw6OLCxITRECNNsizqgT+1N4guckbBmMe/avdwgB2RpN3cavMVoc8vpykMP/3hxX8kATzshKmrkVUEPQr0KmvdQXc7/h9m+RAxg/BHY9Mwj5/giBfhHAiHB86F2yMoRFk9gymU7cjzObNfUWJ+DtRvy0B2lKEUW/Ap8m0MRGn2MpVfie+nvcnU9jUBoRUsg9m9WNZiPnxQcmLhKpt1kFJIeQB5um3f5b4ShPcx1TnFgVDPulpfQLSUo7YB4J3YTSfdWScYSH2tVHBg8+LVLbLAWYu2XbzVcPd/wIXm4LcHJ8opj+LknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up2HH/+sAKwAZlCQDXxx+NkhQ1huG/zvpVEl2lp2f4M=;
 b=Jq85x+5NR67JvjF3mnGdirudcxqbkWYtOvrU6egsD1cTyRIzuGiXqFzM/w1VsqtP6WZifNuoPpr26j3ZFWsy0ig6lNBy0UkH6wghleN/vny6sZXYQcBJ8tYxdtbzxNUOplrlMXjxq+nRaJ8906eh9gVm6+1MjuzxyQMfgCumkuBFoVrcpnMyDeD1j/reV1nduvvWmBVo0d9/lmEjTBbAL+id5dbBghcrTtfsLplxG5Ao0PO2cq6uif2P93V907Vu/Xrak+h8DM9fdjW7eZAN5j7SqAESu4paJMK4R5ZuYi0KsPJpPaEFfDvq+OI39Y2E1arNRJQDyH6n7wuIZT2u3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up2HH/+sAKwAZlCQDXxx+NkhQ1huG/zvpVEl2lp2f4M=;
 b=nJLOmpFUK8V6zUiauT3joSGuqEyULe7QnB2OykUeKT4MDAnas7Jgm37WrnLe+bvDS5ubzv/HSRfp3U6Uv1m9Uj5j4PFxMC+yl2+XmzyxPfis0At1FdRIw8VleJZF/TehcTT0u7MEIesdrxIniLC1PfKl2i2uCbHK5Bxic/7j+vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5003.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 13:37:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 13:37:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: endpoint: Clarify pci_epc_set_bar() lifetime rules
Date: Sat, 31 Jan 2026 22:36:52 +0900
Message-ID: <20260131133655.218018-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0200.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5ce0a-53cd-4d7f-7f1a-08de60cdd08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P//wRRapl9RbhWcdS2fKfXUTVk1DLswrV16QqQzKfxGDppHTWLODi86EBaz6?=
 =?us-ascii?Q?9yEkweaL29YmFtNcCM515vRY1QWCvyuZUkfYEbYlLjzsiSNC/+yNd9781lBi?=
 =?us-ascii?Q?e6XBFObbz3u35BSGLaetvIoJw67P1YtcxPXoQnbdhuLx+vnGJX3v3rW46PWd?=
 =?us-ascii?Q?BBV3d/O63cAq+3aY5hE4WJm5nomWV26D8Hc5bpfgxbTGe+PmtXoFxko1iZxR?=
 =?us-ascii?Q?1Hy/QuZobMqccllVfDAcrILNpuJnzRbbAAQy1eMB2G7IrxdJqkGNy8XjB6m6?=
 =?us-ascii?Q?A5I/GDRzo/ncpee3C+Irp3tQZxwSTbc5XFvqbdgm26uGygyAZ1omOGK/Zg52?=
 =?us-ascii?Q?bQJ5hpN6PksDEnheq+KRLTqZAqVQLuxHiqM+FswiAigcT4grsTXRHdeFYKb8?=
 =?us-ascii?Q?SA16EKEwYttP8BKVnQOaPSql754gN5ygFKzUU0l0Drt1X6rQPiW4oPxqwomC?=
 =?us-ascii?Q?e9rkPYiHj6UqBB0FEj6+LqgBE8wG7RhInfQTx2Y3xQ7zEONIXp/heVDZ1v5T?=
 =?us-ascii?Q?9Vdo4RC3R/ZfBx2b1Kt/JD2ahFh572jYsQu9f9EzSrg3fBDu/T8jPtzM+qLt?=
 =?us-ascii?Q?pLIpOx5zLXaFcjdoADpTUv7yde7wm50VlRd4meGrZmcQxPqQUqyS/df2Lbze?=
 =?us-ascii?Q?EciESi+iCbRqFOp4auUBFa5CPUoXnVbjeNbNFkUOiJCrl+NNZhhNy8ZCTq3N?=
 =?us-ascii?Q?T9/ArkbX/QTUxvH3+CSAUnEkyXu4WysztzD5wm4USCZvwWq7lUd93X6Djyl+?=
 =?us-ascii?Q?PJkUX78/OJNt9Qv/1Xl4wffPpUvBeNNsN3oi9yKg0H4pTLHjcUbEgj9AKMoL?=
 =?us-ascii?Q?74r/fPIWd8qBShLuSAoerZRCkuf1is4GY6MLRT7FAUSFWuxyWQJcZzVoReru?=
 =?us-ascii?Q?Vs9L8eurEfHXeKsvvcqKvYH9fJHTcvJkwlVh1B7L19NcTS1MLQ0qNUhsWGPc?=
 =?us-ascii?Q?awcrsvIX4KkA7RXfpK2huIqgY4QB6HrBZ9OgBAaHBLitp8PltVyR3MjjET7e?=
 =?us-ascii?Q?SWNhLu88kYzyWTAlhY2p0RrjRRIRvNGnfCD+iNYFz/Oka7LPNNIzAGvqFYdj?=
 =?us-ascii?Q?7kazD6g7iJuofy1ujNES/omIx/jyMiy4uOZ+GV0+TfxZY/n0lRxdMbmTl+uj?=
 =?us-ascii?Q?7K/cwzJX4h55ufLGmh9fGloU9jMadIlx95fGDgeGCjN8Gm2+WzLNrIveHjss?=
 =?us-ascii?Q?txqGmkwPij37KdX04lr5S6OGauoHmZFSR8gbrVnGWREjcoXflBbZ4ZQgNmSG?=
 =?us-ascii?Q?4zqVPlKbdDZNfdzXkqGUfNGgwcvxJLr4Jqb6gHnbQJLUlAKbq+4MUAVoxtW4?=
 =?us-ascii?Q?/uTZ+CI5xSjKdBpxw9v1jDgOvTgEmbP2MMrQH9SRU4htWyUtidPoA+er4eHn?=
 =?us-ascii?Q?nB1g6R5z72cMMB97RnLrxIzPShZU6nwPmJy+Qkp8GqgNhT0yVxDTESvGvezr?=
 =?us-ascii?Q?13Nan3uK50Ke0L5qL34FBliq0K8bCEhiFW9ewjSrxfpfysekFVASU7WoNzdC?=
 =?us-ascii?Q?5x0/BU9unl2xmWxThIdXcbboItUHe4LCqGNoZ40eEuLDfjch2qaoKLfNq/Mj?=
 =?us-ascii?Q?y+psbWrui1vnDU7C33qN3s8+pBv7sYIeaIM632umGR9vF/ligp73S/3YZ6Y9?=
 =?us-ascii?Q?IRXoyzhqBNcQDG5ujz83YYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQv7kA0AR0OxutwKs27b76Sx1O1LQ+TFwc85qLUCAm/TzlG8AUlGAVE3nG8k?=
 =?us-ascii?Q?7E7cNPFCKpOeHphbQHNPVf/DbpzM9gkN/F+jFe8jU02+J9ALi/05vnxvHcfM?=
 =?us-ascii?Q?G3JDlscW8EgQeL91kXFsKRQiqkhfHEzpLgaklPe9Kji4AF7GLzIKJ8PzuIV1?=
 =?us-ascii?Q?lpT2BQHhBAWk3q8ZyyOwUPH6WQd0w6mchj9Rg5GAMJjccvktB+0qUQ/dyICm?=
 =?us-ascii?Q?O6+/PpndssSdwzXjVv5wn+SU0D3zogV5gDc/viT355y9Xaqq83FSUciluDY/?=
 =?us-ascii?Q?DwkFeMl+Sr4KHyR4Gk2mn8U6z6pMlvR6WxL8mjegSQQp4BcGKeJxd7lG6w4I?=
 =?us-ascii?Q?LnBL+ZJki+9XsTWQQ+o+BAh67EvDI2p49P3MLuUyzi2qOPDgHk7gTvoig+7+?=
 =?us-ascii?Q?wk1GW1WiVE4l8Q8CUHvOj0l3TiA1G99Ua9D+gvtLUjenvBOgkKbiuh0y21Wq?=
 =?us-ascii?Q?jK60kKCMig+MfKESbZQC2wtlE6YfAMmlbSbX+KzMz0ese47R6WjoaN2jc6Uj?=
 =?us-ascii?Q?IpqE5uVwsjd5Y6TbZBaoOkRuzgGS7IKC3uLpbwrsk+yvuu0ueplSNqDamBw5?=
 =?us-ascii?Q?VE4yJ6zEoDLm6k8yrlBiebt9yEaPEe6WjTK+L3R1lC3hPuyF2PfykFNjQ9sP?=
 =?us-ascii?Q?mujUY3jnr6AowHDQYrfWIPdcbMmle2WGtvqcMDKJjeffv/ZuDA+QmkbY++i8?=
 =?us-ascii?Q?hbvLR0VtBaXTWRfsUvmAbSNLAJHnPhKUj6sYNl+MDZFPE6EbHi8OsjsAkB6D?=
 =?us-ascii?Q?xey9MuafcvfaV4QMzVh1/z5QXN9Ad8F9HubOfyEp3SN48RUaGNIFu4U+eY0y?=
 =?us-ascii?Q?e7FeWXixPbVrKwx6xUEe39+58dRZMxIwr7w10i8ckXjxrfPXoD9CbNmzSfnc?=
 =?us-ascii?Q?XsfXOjX7tuGaAk7KlvBU/cBi8Ach8gM0F+alczRJXxkj5DlTiFjeDijcO+d/?=
 =?us-ascii?Q?v29RJxcPvFCLBK+uRI5UvSybBoD0pkRm6rleXBn9t5ECOBCfLdg0F5cviljC?=
 =?us-ascii?Q?o7zM5iyket0NM4gm7gXUQMhR7iW6k/DV2Tdl53pQmvscBjoDjHKsfSG3EOCI?=
 =?us-ascii?Q?FTAPb2TxiU1hy00uXTqxdzz7s7GE+mHuVLB5ZUVZ4jmCvOmca8jZcbZLVa+W?=
 =?us-ascii?Q?wuWIyJd8Z5TtE8KUS+B14IF/70DaJ2znqC7pJpWxPIVpMmK5xWLJWPtXB8Zw?=
 =?us-ascii?Q?WL2v92NE8WmkysuxrRyzQIQYe4KyNb/jvw1Q7jq7WBhwwgo/xJS6OWEY06Cn?=
 =?us-ascii?Q?dtZnSOBQLVWpfpGUjJ/Q6GRzg2nWurbLXpIFCfEHdHolpmJAGqumz8k678Em?=
 =?us-ascii?Q?VQJoDQg9ICJlRwCYGrah0w2mPRPU7EUMvzCQB4c+1rUaCH8PGXmtBnrwruEC?=
 =?us-ascii?Q?aDUqsing6VMOdVTEzbAVoPD1jC6K1cIv9QH4EYoJ1Y8DoKWymkM+gFwSksr5?=
 =?us-ascii?Q?mnc2NrjailRbrBz/MqDU6oqp1vmW/Mb5aWDmmb5prJdS+PwWF6B/wegeIf0G?=
 =?us-ascii?Q?yQlobf1xofG0OD/ra2NYWuN3K98zxPEBDFXmfBJvOtMM291pUUzKs6rZ/e+T?=
 =?us-ascii?Q?gr16BjYdm4RlbAraqJCSC2+I2dnJo+Rlkc2XIf8uUdMKnWGWWrse2y3QcJY9?=
 =?us-ascii?Q?rhuV9myp1VKziCTGKxe52AhlrdAVN6+LFO7YBN2mkGIRvvoON3X/KF/hpn5W?=
 =?us-ascii?Q?lKevTHOycXZbsLG9RPCUgQL8AMXzHlggcwWFNXE9JTE3e3YadqMU5JLD1PBj?=
 =?us-ascii?Q?EfU43eqTZWIOsdjNOZsUldV8Nux70c30cyASmtwJS4ncLR+Suwc5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5ce0a-53cd-4d7f-7f1a-08de60cdd08d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:37:01.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzabPpvK2TSY3GFNzHkU/UD0rjgVQDyfmWLm4SFhzM4ylJaXKySian5vDs1TbAKIuyZW9l66UpMfOUDe56WnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5003

Hi,

This patch series is a follow-up to a side discussion that started from
Niklas' comment at:
https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/

That discussion highlighted implicit ownership/lifetime assumptions in
the pci_epc_set_bar() interface: some EPC drivers keep a reference to
the struct pci_epf_bar passed in (and its optional submap array).
Mutating or freeing those objects after a successful pci_epc_set_bar()
can lead to use-after-free or other undefined or hard-to-debug behavior.

This series:
  1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
     by returning right after clearing a BAR-match inbound mapping.
  2) Fixes pci-epf-test BAR subrange mapping to use a dedicated
     pci_epf_bar instance and to free the allocated submap only after
     restoring the default BAR mapping.
  3) Documents pci_epc_set_bar() caller ownership and lifetime rules.

Base: controller/dwc branch, latest:
commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
                      PTM access in multi PF setup")

Thanks,

Koichiro Den (3):
  PCI: dwc: ep: Return after clearing BAR-match inbound mapping
  PCI: endpoint: pci-epf-test: Use dedicated pci_epf_bar for subrange
    mapping
  PCI: endpoint: Document pci_epc_set_bar() caller ownership and
    lifetime rules

 Documentation/PCI/endpoint/pci-endpoint.rst   | 22 +++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 32 ++++++-------------
 3 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.51.0

