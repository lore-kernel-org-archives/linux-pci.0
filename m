Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465871;
	b=sQ09+wBe0Flf1kuPObFv0YS4L+TEymtYl6P+aXXrPF1PIDoIlzlW5eIzIWoXthtEUkFV
	 9H0iQNeFXo0VtH3YR2kpIieXMGy7jqIOXvULKQJwGcYCyXqiJ1K+HCEeh/v/yyyZx5WJK
	 mU7QxuErp/T8NQbsiu0R/L2+q+NqOc8wiE6eCEDXPzbAAcUaCD6AHCTz3llloThkeFTjS
	 UjUyYl9JL+HLsnU60CcoTthwDTkgTZDZeVrvnm4P5K8VnKXvjhEfE5QP3npm8oMhMScLr
	 GKqBL3vkKrArC3eYotx6voKhYQWBk9YmEk3oxyyOAUEM6OefGZ4m0TyPIBlFuC6VXsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465871;
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
	bh=YIjMFhtFDTrx8qureCR+dllzAY5q+Eov8yclcK8V920=;
	b=d9czf1mfK3l4Tnrf59QpnCFZfeEBuohCiwFqqqDFiD4gpPjaGwVscNAHdZnOZSlFOzam
	 jl7fWbMH0fd4TzU4AjRki0T8AsYKogb/nSHh1U8kejeaJr46T8zxRoyWRFE6X58sEdtMb
	 m/nwdW2ASj5cz3S/NobswlUydlwTuYsB3Xh8SBeBi8wEx1zhhQV2h9Roxt/MQkMkvlIG1
	 BIvwOhblR9kqDQMmlfsR6RGYdk9O/RLnC/6jNvjZEEt7twFBtYDYHAvDqw8qRE6opc0Tr
	 ETc8Iqc/nrhKcEG1KhzLteBSVAaJasWBX4gc5Z/WkNJJg7AYOetrJMzO7olR+gKqZ4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=j5eBUlm2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903B60A3836;
	Tue, 20 Oct 2026 03:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3903B60A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=j5eBUlm2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXl57D2b+4Cl48xtPX2XQW+z6OzntuKZ6mSyomo89ZH5yAfCPmN92tVYb3ParDSZCTXk6HyVUT3rnV8X6DkHEzOxLTGfJToswSJdfeD8uj6MGbPak9HoOOJ4OF4+/m6VcmcbMzuRmzi2GOdszVxUXtaKvTa8yxjh5fY9k6/yPiXXVW5eEZYXcqIjQkGg3GZ6QsfVSaLpzgmUbBL8x4IuZ8VOr1eOEC/gy+FRICwqoJktbLT4KgwrBzaY4wdaPpwDH/YwbG1dL/24LQ1V4UED6bYnvYf9pmgkj666hFsAqr19K+3BvhyRV5DgyVNAT+GsXEh8NpM8S7eTvF8Iiv3nbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIjMFhtFDTrx8qureCR+dllzAY5q+Eov8yclcK8V920=;
 b=B3xMt6zJQomY42WVsfMWxgBoYFT6haisesLIv8ctdmBbMbpMl3KKLSO8y38Kp8Y4QZwJr1WM1wJAU0xVMTb7c9w7Q7qh4cwS5SXmTkgsVJ3Hl1D5ZZz6qUfzO5FvOpAy6UUr4ykhzeOvmU7M5jNiZJOg5vp/246UEwFJdkovJAoy0v3jb/l1NoI4oJxlzky5UcvAWzth6RyvQQX/q0W23YXC2dZA1zM6AbSqJeYprr9bP6xdhM0r7Hjwe1Y62HWt0XJWSkGMQFjrZmngC0PsZdkprw7VvVCVBQq1O+Sk2/X/meqZx5Jy7gw6yMs+nJBWkx8QUKBIFTvcHPRan6+HOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIjMFhtFDTrx8qureCR+dllzAY5q+Eov8yclcK8V920=;
 b=j5eBUlm20WpMh+/ECCxoAMYNwYPH5LbBaMtkBWKsmYge0lthAZ2G2LGpzYwjQbMg50t/hQpKq9Yqy6Opa2gcbpshlQbkQqF6yVH2/ssxvI+nmkW1xSH+VpKbvf8Efm4id+0ZOwGGWlV0kET2Eog8yP9H2iy+7sgL1rjF9B+sSPM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:09 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/17] PCI: rcar-gen4: Recover the Root Port on link down
Date: Tue, 20 Oct 2026 12:10:44 +0900
Message-ID: <20261020031049.969895-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 957637bf-5a42-47ac-5202-08df2e57c9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|6133799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xijcpFc+ypyyNJuhOSAd5hvMxlBI3ZI6W7rDGEp61KIyyTSxw710Z8bIUHbKjNGvlgc+gGEI+HEqoKgIMT0nBNISuZJ4MqldPX2o8TIejisJhF7Hs8O9fLOocUh9ExpSyNXm2pK0E9U/TOvV3SmwC+CeI7mpQ4Jf/rLPsg/Z/TILqd8hGBUrG+WD+il/bQlPn2N/tIWHOkzuecaSs30Mfc/Rm6iJrbtB9gmHof9q9dtl6DZ77net1HpIMLdloGlPFhNgF3UuAZRKD8ya9NhYq1FDinZEU82+hpWWXM0RfUrfCLEtGOcXVfY7+GESwxG0Wa8JTxU4HcSctIfD6aAhuXa27GdGZiJAMg67tzOBhGw7oFjo3NcJvndt5OHfiVgOgibxk7r4gf27NVh9dFaNThg8lO+cTSgwn+sfgN5iMMI0Ij2PEDM7X8gHrYjI0xJmAjEunktSAgS1ATEa0HdtzoPkuJVL4s5Ednf6Mx7ttNd7HCqF+QGlBO/LhhX7Qq3pNNNssEPTi0BbziPZj3j1I9NAhOWVj1KfpNNGefA7ivhN2/fDnk2hyqzpDVBr/J34OtgkJFAOxTxLGYPmgmej4+xtkJ2ECyTJ8hfWz6dpNhHa1AuzATK4ZOZn3RYjyv3SfIS2D4FTedtNUny0GqGyYO5Iwkrn2vsaacR6RvA586KUaSUD2/N+2IeIVYArb/CvfJEv4fcAlt9v9i20Kz9JHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsWGL/ZpWaEomot+kGmZkoWcZuGS6O6MacCEGKTEeI32sE/z2nlcIfFdz4rQ?=
 =?us-ascii?Q?im3HLUMB1TbnloSKpPVxni17o0DozooPQ0FozQ7krXrLIHXR8/Ifz9AzPXDA?=
 =?us-ascii?Q?MgF4dt1B64fQl6AhnQhblASGqU/mDb4c/LJ9+2ALkpghzEvCUYgmSRhufHIj?=
 =?us-ascii?Q?K3+gLMc1FWqgYMn4cZa6UAEVF1e2IiY8/LYZO4VewNcOaODWdWBelDTliGfI?=
 =?us-ascii?Q?Rb22xWGvJE40V03siLN8dR/8KTMiyZ/+LljgZwRhSXZp5vBSPf+i9JCUhRcg?=
 =?us-ascii?Q?owZAw0vdxH5e4sDo6eGGOEPHFPrFNC9jDSC+pyBqGIWqPyc/80O+trtftjY4?=
 =?us-ascii?Q?msfH8dpzXgVJL5tg2vMDzPHf1V5CjO2sDSpdP40cO/JxHUbgazu3h/3hTGUe?=
 =?us-ascii?Q?1tnfaR7t8WwgxEH5KqF+i72gofLBblCSwYHkPy/8jC5kgnxIECfGhhuthiRM?=
 =?us-ascii?Q?wIZ2hxtuBK/y7gf/W/GB4P+gS4IbCqoRRn30iFkzmJISZxwEPk+qw/wYDFhY?=
 =?us-ascii?Q?z4w9ga5Ni4lwdSsS0PY6GkYgQWYnETxuABRkVCpzcn9CY+g+mdOwo3SI6t73?=
 =?us-ascii?Q?mOiVLJC+EOcGQtys/n0SReFSuvVBgVMr89oUvygRirugO7Y8oxCkGmKuXDAj?=
 =?us-ascii?Q?ElGsgH2j+n5Gipawle/FO7nhP4pSk+hxjFNFtqPDbbqzi3sXVnlzYajTpO3K?=
 =?us-ascii?Q?a/1fh/ktuJWfwE8zYLNqOLWQrDfvIKJkj6wVwKxJo5x79lxZLwWPTxEPQ5dl?=
 =?us-ascii?Q?D4HPnWQUfYz4up+dJ8TXq1BtHMm3LGAg0edbtqD3wQIhGlhkFJByt93tMQwr?=
 =?us-ascii?Q?WUBGvvjzcuS1QYhUgk37EEY3fl43RUFPGcuRbBLWgBIZMgXc//pIOe4NcAzz?=
 =?us-ascii?Q?sttToo1M693p82ecZnAzTtkM60sVVxp5mb8KOVmetJBgRUgjaT0WPe2qfgLC?=
 =?us-ascii?Q?ynCVSipkxORQrDdZcaPfHYkXnxYu7wjqncGwYzktdNjoUFI15XQcCCIpXGq6?=
 =?us-ascii?Q?KPBwbRjt6FvdzGFoh8EWMQ6CsD4spn9ewnqkrmCU3D18DrqyIKA1dMRN8wYv?=
 =?us-ascii?Q?6pvYg6FHKdMb13uwDujRzCUNg7ZzkAQ/6Rb35iGukTcKVtiSa6J+jRCyRkdD?=
 =?us-ascii?Q?TuLQT3xpssDG9p9LGtIqUu3nCH9V3EP2/YMVrhzBzhmN8Vjk11XZqsFDwxAW?=
 =?us-ascii?Q?8qG2MlPr/bKbqdW+NH5HqaUUZf7pk8EpkhJKV3zXa2sBTurResFXGVaj7IYp?=
 =?us-ascii?Q?tt8hZNSlw1t72vA7uoKi7m2CTPGZRDHu+Lk9kUKZAkvDrbwj4XBdbk/scQgG?=
 =?us-ascii?Q?2blpsWv25ujwxxjVwD6c2QpIuPDfr2fvK/5WM/hxV06uHT16HGfxdysmHTUY?=
 =?us-ascii?Q?4hRjqEr2+EApft+9rCOBq7tmPQMhh2BEjuOrASbaZR/ZI9UBxUChnECH8rE2?=
 =?us-ascii?Q?yXurtdszyKWDdqhlDXiWN1M+2O9vhdmU0E5SunmBXeC6OIZen2MNjNZqgo5t?=
 =?us-ascii?Q?OryzRVVFOiQk2dpOPHUEQ1tVuvpFPrYAAOcSSF1AODDiU8BCeoR4Znxn43k3?=
 =?us-ascii?Q?ZV9jF6Y5jRhh4lfeZxgh7ZUscl6Uys/QajQNDmbS25K+3L+JWEAaovZ+cnlH?=
 =?us-ascii?Q?4nvPzfX92YMU9IDMqnlm4D3hv9kdBI53B1TayyFS8VLWyVvTnquiE8wIXpDK?=
 =?us-ascii?Q?THUmuS0HgBpynVtKMOvvB/ocyF1uIzzDh7cISokaK5qJaxR31yXVh4kjos2l?=
 =?us-ascii?Q?O4FC7TGYgNDKgQsQwmSEMI7laCsye6ZnGQi2O1l4coohZGrL0OI8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 957637bf-5a42-47ac-5202-08df2e57c9f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:09.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7enk6GRJyKeELpZVd35/EDRIECngN3CccCKcMEH2umSw8d4Hr3JoTAZewylqg8DMw5AVPQ6tAVqSFGmdWOOt5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

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
Changes since v4:
  - Add Marek's Reviewed-by tag. No code changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 127 ++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 63140b678414..50d4b74e63b0 100644
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

