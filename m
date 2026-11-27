Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749130;
	b=CHtGHVMSEQpEGiioPqnGuCKdZyRis35/38xuKLIueU3iN2TUCRNe1a/qS6USxCuzl02e
	 BDwEcHB62Ecxp8JjRl74G5KY03PNB9KYgtniMUs/uoh3GQ/FWkJ7Q+z+87Ow7TvUAqLnf
	 X0+hFXP4+vz6KLWpamfkK7jlUr6oRlxkIx1ZqTG1qaP4xn+KM01prnuVJbprsQvAhxsuv
	 QEzOvqSQixD0iLiHbjuigYpHcOf4TT4GIHACrcLTAIBA7vLUd0ZQumloQjg1M0SZ4Z61T
	 KDdfm1PsNmuiPmwF1s4B0y344VwQFwuYlEtJluCbWwZCrJBf18ZJojNWkIlyxNejPBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EMLe8LWkgSUXyMsfd0GxqI5vD0B/G3cO6YJiSIbBonM=;
	b=My7zwP4A8vIWyKCPGwqGxkUi3Px2Cuh7PHaleYFWEUfWm1L+wwVRH0ncpnhXggHldV5Y
	 /AibyP1l4dKx7aqXDQHtDVKawo1x2PZBnNJz8CvsngF0r0WH2GJaujtjm3PtgMyHOjvNB
	 sII0r9SgkD/kwmL6CfGf6WH1Gt8NexH7EiQYYaOPm6g9HC86kxnXZ46FJem6vP7aStGei
	 D+f1Sg1kPi17LmD1bu3a+dKjfzerCWgiMxkD4VWbv5jNYajCHq7V8Eufxs5NpnnIosb65
	 YJOM5LJLZj92j/Fw3+XjyyRuLaPdEQcvSznnkoV9JHbHfIulnN48r0ivHfwn9yqjQCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=kJbcAVHm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.92
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021092.outbound.protection.outlook.com [52.101.125.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809B606A31E;
	Fri, 27 Nov 2026 03:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7809B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=kJbcAVHm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMfUJ7VAPW0LllNY6+WSX4H4/bFbYm0+wWimE24K2PFIVIvlTr8AWuEHgwEaE4gROnZCytkcuD1mVaNCBHwU/E8/Si5Byov0ZvweYQwhC57Yxu/+OMpMGOmhPKNomw+wS/JFSfW2eaicdBao0JDEKrgSNCDIDV8ryZJFKRIV+ViV46SusrYBbit1I6vPgQqW2ukia4iwhvTVKlF/PecUBThuzy16IwVu6BBnbJlgS0pJT55BYkn5lzPHik8LKp/wjIHXiIz3uhl72yTXmYj12se0U9YMzWUVNeGscXKtYNPZVSb+nbuKb7TzytFTskm2CtlOdjzKfP0STdhvrB4Tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMLe8LWkgSUXyMsfd0GxqI5vD0B/G3cO6YJiSIbBonM=;
 b=Hie2sBjnkFsAejskGCkLjpnUIQlthDqIn7xVYX1g85SonZCE658NlzuLW50wTSCu6OJO19lxRdfZg8olDlL2alxmYQQUerieRHrC9658dbi9VBJLHZs5xiND9/b+uOQuU1sxZ3M/NtHlxzuxrfnSTrUGD3b5fqwXCm8+cSF7UsUYe1e9zGeUF/ypa4NpVjnMjlYwjlAOu8bnxVjyURIGP/XU7jEBGRbB3XnnwiQlmBejNfkgfQxd8HZu0KqXBUXt6xIItcFZm3t/hGsm+A1YTKmrWDpQat9S8WVLEOtLAhA6HhQZkMfwA5gCsqx7o5k1dTsdazNe+Yvi2Yoowu/ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMLe8LWkgSUXyMsfd0GxqI5vD0B/G3cO6YJiSIbBonM=;
 b=kJbcAVHmkvxvKyAV9w6ph6deJxWujh+6ynNj5av6+LEI3KdEOIGnNJQHjsB551kcQ1tQtOhbhdz+twGAS/kdKFJmQvmzHcvWz8+PpgeXqhew5TwKRnIZMQTk7idI52L8dJGes0dRWblAeXJ3qgmIje7gPul11wYP+eQxraLY6dU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB4718.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:03 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:03 +0000
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
Subject: [PATCH v6 00/17] PCI: rcar-gen4: Recover from link down and route Root Port interrupts
Date: Fri, 27 Nov 2026 12:11:28 +0900
Message-ID: <20261127031145.2521228-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902c4b3-7538-47c2-5ddb-08df4c343519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|10070799003|366016|6133799003|261009223027099003|5023799004|18002099003|921020|261102123227099003|10067099003|56012099006|261102130727099003|261026135527099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261021123027099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	j2TKV2qO6qVhL3gqNnWHljyqIAkKFrBUHy8zWFZARlm6I2fDxtFZYT/xVLP0jz5o77kc1hgLEbTycXRi9pxL92eRjrUVkPjUsNMeefr++M/XLydaSwOFzLlXjCcep3Fuz9nwKkpzX9L89B9TNzCkFlYbD8ELtYzsBXSQbNOQ7NUNMo5DKGvAudgIkocftrfJT4Pl6DIj++8IhdAhSXBPITB1e3JgnYjiUe7EyLIDTNxrZH5zZbvtceFhlXUcTk/JeE9DCE7oqqQJiHL7alC7Tf8pTkTfwGUOlAVD/C4CtBvsxm+sWVjLpl82b0d0HEqCFFRuSmQKIXssMcxDjOUcMZrAFMKcFCn/Gu39Is1znP+u/24zhKUfFaYX/TH28Ec7gZh92klB65ZNUozMiO+801LH9igwsLP+xuFqF0cyO8hyz+7/Oa9U0wsQQXc2p3uG/nagPxkiLdQciKKKjaWmVReoFfNKPhV6x+9ohhQgnAqnuemrS1GAJ8N9Tyq9i505CsZtrBbN/nND6H7cwm1Pvn/aOEh9n/dbztTUrdEhifVPLgm3uy1mJVBz62UCWW619z5PLZFYsDgSDwmV0GSbG2Tv0ReaJUp3NLktUk7WT3+onLCJjCMqXf/X66RGw334aVYdZQUG7oaoOM85B/WMswk6XNbWmOZvUK5mP1cx7ws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(10070799003)(366016)(6133799003)(261009223027099003)(5023799004)(18002099003)(921020)(261102123227099003)(10067099003)(56012099006)(261102130727099003)(261026135527099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021123027099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpzUDQUyIe9EHDLGjEQxh1RZ5ZDZc3GThNNjJQlMGIfcU2T51vg4N9ezNayO?=
 =?us-ascii?Q?tvzemvcJZlC+aQz9q2qJy+lOypZSUfLM1RHFIPlCfPBgk6Xi3pdjiTKSoEl0?=
 =?us-ascii?Q?qz9ppFZ52LewttXl1QRTlSR2sxXUHYaZsmX9B+OP+z0OcDgkBuWcMJjRfG58?=
 =?us-ascii?Q?H/YGxA3zTGuZ3Z4c41ceTa9wOGtrRK6/JEfbXErkbrTXwtKiEFydLIt7B6lB?=
 =?us-ascii?Q?oJim4lnBXHNW0sOtuFvftmPy9FobKkhO5xiA2jm4YSdVJLX4AoitmNswK3yH?=
 =?us-ascii?Q?EUk96bSHqIx/bKgUU3ApGqNkE2VVDXCsEzbyhHr8unzr3cv0LAITNvQUsH1l?=
 =?us-ascii?Q?WaZ7KEJ3Wri4rq7ckJUbKMVt7lGxTlxpP26w4pU1kTX4lKfuAVgamaR5RR3m?=
 =?us-ascii?Q?ICcNvOgsNEi1+Jp6MgpQ83lnvZY5na9amI2xa8J7DHpTWGa2+0Bkl+q39Qpb?=
 =?us-ascii?Q?3mSSVtlc6iYS6KCkYW+P4H++dxt7tEL0p2ZhHkZiSKiBIGyyCZX9BKZUBPLK?=
 =?us-ascii?Q?URnTSiUljOTpPyboIrt9/BFaMhwMRWgeEmtg7b44MynseycY89EOJu+8qmQe?=
 =?us-ascii?Q?uaCObdsu60s8FdIws6Xjpx4E1J+XfQ8MUDldnCvmpNALuy3I+olC8fKkx+kK?=
 =?us-ascii?Q?8rUEaXPSV9SrSx4QA3yON95eP3uXHUe0jz2gMa1gH7xoooYr0kKDS0fApwD/?=
 =?us-ascii?Q?Fo0DdfbVpRs01N4VZ+Qu9FJoH4d8RiNLJCeZqslIFmrZZ8drlOp51dO2HT4X?=
 =?us-ascii?Q?BDziRfD8RxXMqHtz+skhtpn1w5k0IAS2lMeGMnoXivctlVCt8PbUu2q9RoKL?=
 =?us-ascii?Q?zPxAnSeok1EwU1LVlBzcjjaLKDzwMO7+isKlJInJeGE8vaJupfAbMvJ8gS5B?=
 =?us-ascii?Q?ugTp/TDqYksgBdnXBbSFi7IgXkDDr7b33Rg/5dnM8MMTVcAfLDGeT9FUSAzi?=
 =?us-ascii?Q?Sli+HMP58lmudLZSX8AmkwdfiWtDF3Z9GP69R8wdGTf22sUAPhdnuKSa7rbS?=
 =?us-ascii?Q?WG+/9Jy1fuNByIR1xalzxuFigrd5X/xpoIiTRYLX2Znla0tF3lTbbNnVVy7x?=
 =?us-ascii?Q?Akgg9hCfpZ6qAhacAJ9GOcKgu61xTTRP7f/bKLBPzSj5FGP6aeIGRKwOYPHZ?=
 =?us-ascii?Q?EAuUpGy5b1fZjgXCUKPk8ZJlQbqydHZK7Mm5oj2gqJnf5jFS8UzHb2Fn2WpL?=
 =?us-ascii?Q?EcpfO07Pz1ntbakaWMfoc5H1hLKF1REXLiIcJMfZY+5gFiXOuDCPLhfHID8z?=
 =?us-ascii?Q?mMXn879bqPe+jOpail88ZdWunXUo9QoRTqkYFrvNAT6JTEEoWPYvUAAZpEP2?=
 =?us-ascii?Q?5rSyxsBP/l4EPme1zvInsaQK+qnctUnymOmJ7Wft1cHsv3uX9o8UK7soBUnA?=
 =?us-ascii?Q?ikWoD41AET382HlGrTfqmnsYbw1v5s10hupWsl6habz1vWXIDWWP5dCm8KAa?=
 =?us-ascii?Q?S+Z+/1VFYvVsB/RsItSBCd6Kw7gB0TTbxXpH/8ZYXa/KuEGlBQ+MWANAEfHu?=
 =?us-ascii?Q?Zrj6qRxLNCvXbJ/TE26o+zsBgKtuzrqxHRSgV47Q9sHGrggSeEhgyS/CF2NV?=
 =?us-ascii?Q?O0bpht3Xqtc+1Yp+Ll0RpAuAT8zBTBvTE+Cigd+m8GekgDVI3zxM6ez7GMTy?=
 =?us-ascii?Q?18DFYuo5BUQirKE8nS9+dRaGjxVAofPjboyzoSVMmNqE/Pmi5Z9s7ZrfGGIf?=
 =?us-ascii?Q?Z4WCG8F8Mo1nxA43x4vqtdpPLnaom4dt7b3Cyeuk7qzA/nOyM6R3D8QS8+4a?=
 =?us-ascii?Q?IkLa4su6PxqNcqzoPpYoa8eLmO4Rj5DowBVr2CRIqeUTfr38OEBM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902c4b3-7538-47c2-5ddb-08df4c343519
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:02.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP1kXyNnRgJ1sbB2x8337MK5ijTKZEGs8EikmtzhLZzzVscGZ0yRCiZrrIbagSvOu7OEcheDGgwQhg5s+eq4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4718

Hi,

This series improves error handling in the pcie-rcar-gen4 driver, which
supports PCIe controllers in R-Car Gen4 SoCs and the PCIe4 controller
in R-Car Gen5 SoCs. It fixes unexpected link-down handling so the host
doesn't hang, and wires up missing Root Port interrupts (AER, PME,
bandwidth notifications) so port services actually work. I retested on
an R-Car S4 Spider (r8a779f0). With v2, Marek tested the link state
fix on R-Car V4H and ran the bandwidth notification and Root Port AER
tests on a Retronix Sparrow Hawk.

A few hardware quirks made this tricky:

1. PCIEINTSTS0 link-up bits don't track the actual link state. The
   driver never noticed when the link dropped and kept trying config
   accesses on the dead link. Patch 3 combines the APP link-up event
   check from Figure 104.5 with the PORT_LINK_DEBUG1 live link check,
   which patch 2 factors out of the DWC core. Startup clears the APP
   latches before enabling LTSSM, and the DWC core polls the combined
   condition on the RC side.

2. On S4, a DBI access immediately after an unexpected link down can
   hang the host. Commit 0056d29f8c1b ("PCI: rcar-gen4: Assure reset
   occurs before DBI access") describes an SError on V4H after reset
   deassertion, but whether the S4 hang shares the same underlying cause
   has not been verified.

   Adding a delay before the DBI access avoided the hang in my tests,
   but that alone would not provide link-down recovery. Also, the reset
   request shares intreq_pcim_sub with iMSI-RX, while AER arrives on
   another IRQ. Delaying AER dispatch alone would therefore leave the
   MSI handler exposed, and both paths would still need coordination
   with the controller reset.

   The driver handles the reset request itself and schedules
   pci_host_handle_link_down(), as the rockchip and qcom drivers do.
   This also provides recovery with older DTs that have no "aer"
   interrupt, without relying on AER to initiate it. The reset callback
   shares the reset sequence used at probe, including the reset-status
   readback and delay added by 0056d29f8c1b.

   This covers the interrupt paths that fire on link down. Port service
   threads or work already queued or running at that point are not
   stopped.

3. Root Port interrupts only trigger APP status bits on platform IRQs.
   The controller appears to lack SII2MSI, so Root Port MSIs never reach
   the GIC ITS. The Root Port's INTx is routed to intreq_pcim_sub as
   well, which the driver holds, so port services can't request it
   either. This series works around it by hiding Root Port MSI caps
   across the board and emulating INTx using a virtual IRQ domain, fed
   by the "aer" IRQ and intreq_pcim_sub.

Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
list so the DWC debugfs error injection works on R-Car. I used it to
test the Root Port AER path (see below) and included it here for that
reason. Happy to send it separately if preferred.

Note: backward compatibility with older DTs is kept. Without the "aer"
      interrupt, only Root Port AER remains unavailable. See the testing
      section below.

(Re)based on pci controller/dwc-rcar-gen4 at:
2fcb7513361b ("dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5")


Proposed merge plan
-------------------

Here's what I have in mind (thanks for the correction, Geert!):

To Mani:

  I'd expect patches 1-14 to go through the PCI tree.

To Geert:

  Once patch 4 is accepted in pci/next, I'd like to ask you to
  take patches 15-17 together.


v6 re-tested on R-Car S4
------------------------

Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
       pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.

  1. Link down / recovery. On the EP side, toggle the endpoint controller
     off and on. The short pause keeps the endpoint away long enough for
     the RC to notice, but brings it back within the reset window so
     recovery can succeed. Adopted the test approach from [1]. Make sure
     that the unused function 0000:01:00.1 was removed on the RC before
     testing.

     # cd /sys/kernel/config/pci_ep
     # echo 0 > controllers/e65d0000.pcie-ep/start
     # sleep 0.1
     # echo 1 > controllers/e65d0000.pcie-ep/start

     Expected on the RC dmesg:
       pcieport 0000:00:00.0: Recovering Root Port due to Link Down
       pcieport 0000:00:00.0: Root Port has been reset
       pcieport 0000:00:00.0: AER: device recovery successful

     and the "msi" (intreq_pcim_sub) interrupt count going up in
     /proc/interrupts. Without this series nothing shows up here: the
     link comes back on its own once the endpoint returns, but the RC
     never notices the outage and the endpoint is left unconfigured
     (see 4). Config accesses issued while the link is down hang the
     host.

     [1] https://lore.kernel.org/r/abFMa6DCGGLUHddA@fedora/

  2. Bandwidth notification. On the RC, retrain the link:

     # setpci -s 00:00.0 CAP_EXP+0x10.w=0x0c23

     Expected:
     - the virtual Root Port IRQ (rcar-gen4-rp in /proc/interrupts,
       shared by PCIe PME, aerdrv and PCIe bwctrl) fires once
     - bwctrl clears LnkSta.LBMS
       (setpci -s 00:00.0 CAP_EXP+0x12.w reads 0x2024 again).

     Before the series LnkSta read 0xe024 afterwards, LBMS and LABS
     stuck.

     This test does not generate a PME. The PME service shares the
     virtual IRQ, but its path was not exercised separately.

  3. Root Port AER. On the RC, inject an LCRC error with the DWC debugfs
     (patch 1) and issue one config read so a TLP actually goes out:

     # cd /sys/kernel/debug/dwc_pcie_e65d0000.pcie/rasdes_err_inj
     # echo 1 > rx_lcrc            # error detected by the Root Port
     # setpci -s 01:00.0 VENDOR_ID.w
     # echo 1 > tx_lcrc            # error detected by the endpoint,
     # setpci -s 01:00.0 VENDOR_ID.w    # reported back with ERR_COR

     Expected on the RC dmesg, respectively:
      pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable
      pcieport 0000:00:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

      pcieport 0000:00:00.0: AER: Correctable Error message received from 0000:01:00.0
      pci-endpoint-test 0000:01:00.0: PCIe Bus Error: severity=Correctable
      pci-endpoint-test 0000:01:00.0:   [ 6] BadTLP | Receiver | Data Link Layer

     plus the virtual Root Port IRQ count and aer_rootport_total_err_cor
     going up by one each time. The link stays up throughout, the DLL
     retry recovers the TLP. Before the series nothing is reported.

  4. Regression check. Run pci_endpoint_test after step 1. PASS/FAIL/SKIP
     counts match a run without step 1.

Configurations:

  a. Without this series**
  b. GIC ITS, DT with the new "aer" interrupt (this series)
  c. GIC ITS, DT without "aer" (b43aa6a6ebe8 ("arm64: dts: renesas:
     r8a779f0: Add GICv3 ITS and update PCIe nodes") or later)
  d. iMSI-RX, DT without msi-parent, msi-map or "aer"

Result:
             recovery   bwctrl       RP AER    pcitest
  ---------------------------------------------------------
  a.           none         no         no      all FAIL
  b.            ok          ok         ok      no change
  c.            ok          ok         n/a*    no change
  d.            ok          ok         n/a*    no change

  *  Root Port AER needs the "aer" interrupt; without it the behaviour is
     unchanged from before the series.
  ** I retested b-d for v6. Row a is from an earlier run with only
     patch 1 applied for debugfs error injection. Nothing restored the
     endpoint after the toggle, so all pci_endpoint_test cases failed.

Best regards,
Koichiro
---
Changes in v6:
  - Rebase onto controller/dwc-rcar-gen4 and adapt patch 10 to the
    DWC MSI renames. (Shawn, Geert)
  - Adjust patch 4 for the final shape of Marek's patch:
    https://lore.kernel.org/r/20261026224447.606715-1-marek.vasut+renesas@mailbox.org/
  - Correct the DTS merge dependency in this cover letter. (Geert)
  - Add Reviewed-by tags from Marek (patch 4) and Geert (patches 15-17).

Changes in v5:
  - Drop no_rp_msi patch; handle it in R-Car host setup instead. (Shawn)
  - Use scoped_guard() in the MSI setup error path. (Marek)
  - Collect R-b tags from Marek, Shawn and Rob.

Changes in v4:
  - Rebase onto next-20261014 with Marek's Gen5 AER binding fix.
    Only patch 4 needed changes.

Changes in v3:
  - Rebase onto next-20261002 with Marek's PM ops v5 applied first.
  - Keep parent IRQs registered across suspend/resume to fix the
    unbalanced enable Geert reported. Request them in probe with
    IRQF_NO_AUTOEN and enable/disable them in .init()/.deinit().
  - Use a freezable workqueue for recovery and reject suspend while
    reinitialization is pending. Re-arm Root Port events only after
    resume has set up the link.
  - Factor out the PORT_LINK_DEBUG1 check (patch 2) and reuse it in
    patch 3. (Marek)
  - Replace .reinit() with .configure, folding v2 patch 8 into patch 9.
    Drop the reset mutex and rely on PCI core serialization. (Marek)
  - Free the MSI domain after host .deinit(), so the driver can stop
    its parent IRQ first (patch 10). This closes the known gap in v2.
  - Reset the controller if recovery finds no Root Port, so a successful
    reset can restore interrupt delivery.
  - Drop the raw lock around virtual IRQ dispatch. Preserve MSI-form
    latches in irq_ack() while the IRQ is in progress or disabled,
    avoiding lost notifications without nesting port service locks.
  - Add patch 7's Fixes tag, clarify SoC generations, separate guard()
    from goto-based cleanup, and simplify IRQ return statements.
    (Marek, Sashiko)
  - Add the V4H and V4M DTS patches 17 and 18. (Marek)
  - Collect Reviewed-by (Marek, Krzysztof) and Tested-by (Marek) tags.
    Drop Marek's Reviewed-by from the reworked patches 12 and 14.

Changes in v2:
  - Rebased onto next-20260925, including Marek's R-Car X5H support.
  - Keep .link_up() and require both the APP link-up events and the
    PORT_DEBUG1 live link check. Clear the APP latches before enabling
    LTSSM and reuse the DWC core's polling on the RC side. (Marek)
  - Let the R-Car driver own intreq_pcim_sub in all configurations (new
    patch 10) and check the reset request from its own handler instead
    of hooking into the DWC chained handler. Replace the pre_msi_irq host
    op from v1 with an export of dw_handle_msi_irq() (patch 4). (Marek)
  - Keep the reset_control_status() check before asserting the power
    reset. (Marek)
  - Separate controller reinitialization from .init()/.deinit() and split
    out preparatory changes.
  - Use bool flags instead of a state bitmask. (Marek)
  - Keep Root Port AER notifications masked until .post_init, after
    enumeration. In v1, they could be enabled during port-service probing.
  - Keep APP interrupt sources masked if the Root Port reset callback
    fails, regardless of the reset trigger.
  - Hold a reference on the Root Port in the link-down recovery work.
  - Clear only the MSI-form Root Port latches through PCIEINTSTS0CLR;
    the INTx bits are reserved there.
  - Serialize dispatches to the virtual Root Port IRQ from its two
    parent interrupts.
  - Collected Marek's Reviewed-by on patches 1, 3 and 15.

v5: https://lore.kernel.org/r/20261020031049.969895-1-den@valinux.co.jp/
v4: https://lore.kernel.org/r/20261015033103.3076869-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20261006084638.3821710-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260928165230.3397664-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260918032038.2216471-1-den@valinux.co.jp/


Koichiro Den (17):
  PCI: dwc: Add Renesas to the RAS DES VSEC list
  PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
  PCI: rcar-gen4: Check live link status in link_up()
  dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt for R-Car
    Gen4 SoCs
  PCI: dwc: Export dw_handle_msi_irq()
  PCI: rcar-gen4: Move deinitialization helpers before SoC
    initialization
  PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
  PCI: rcar-gen4: Separate hardware setup from resource acquisition
  PCI: rcar-gen4: Add Root Port reset support
  PCI: dwc: Free the MSI domain after the host .deinit() callback
  PCI: rcar-gen4: Take over the iMSI-RX interrupt
  PCI: rcar-gen4: Recover the Root Port on link down
  PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ
  PCI: rcar-gen4: Route Root Port PME and bandwidth notifications
  arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779g0: Describe the PCIe AER interrupts
  arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt

 .../bindings/pci/rcar-gen4-pci-host.yaml      |  16 +-
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |  10 +-
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi     |   5 +-
 .../pci/controller/dwc/pcie-designware-host.c |  32 +-
 drivers/pci/controller/dwc/pcie-designware.c  |  15 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 725 ++++++++++++++++--
 include/linux/pcie-dwc.h                      |   2 +
 9 files changed, 723 insertions(+), 93 deletions(-)


base-commit: 2fcb7513361b449384ef87200f9e1a20fc9053d4
-- 
2.54.0

