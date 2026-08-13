Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF843B637C;
	Thu, 13 Aug 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603091; cv=fail; b=dnkQ1XtZ3S2J+UcHBTzirqfCmEEoAfiXky0Gm5222swq33yGC0cpDhjzS2EOX4KNki6Gxg2pkmgPOS2EZGYxTVKrlaI5H+NZ9WlEp2pUSk1clPeJPeZG06LwhPc+Wracv8ncH4HdZB5Btl90/x18R6TcjFGUA2uJ+PH9m+h5Dyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603091; c=relaxed/simple;
	bh=I5lY/hiJZ9Bc0IMPukg4qgBZhxyyF0s/w27lst0y9yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Trg88PFIc9hecXJDkPGT8E3bCKVu5jiwJPVDuvxqbqpJPRU0pYLmu2UKPiPjJHEAojVMfDd09rrKlwbX+d0ljpXcLnW7FQk5GnQjbKd53c58sPWQPSePcjRO7d6WGmHJjUl32An37/QbDCx2IzCclzIl0swcAutEB0S8PuOYMU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=L35FhJUq; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="L35FhJUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BesJ3t4v9YnhAXvOSBZekmLVp+Md5ZeZeM3ZxIkgl34JLPqrD1/NoTP2qopTGDeAN0Vu8LshMWCLpTON5IDZUSeL0uCcMprlt64wQ4+cw2Q/WHFjmQoOTWHrZ/FS/0DDk6O8KNATfnvkN0CD7lG1qwRlSy78yNEZOQ0zIBobQzqktcd0N+j10tovWW73+VhY8SAqYotqWwRZDsgMJjirOE6Jg6L+TOoKq6tP1FzwYp1LG+T8jyhiSPH/MT9e5MYZvwLlSnFIPSJzH35ZLus3ujqX2T4Z+sfKMzq9IbhWs0lrC4/F75zUODKkpN1Aw7SZqpzPARxOd/YknmZGrHxuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9pYnLXWPIrTHSl+1yzrdI3JtHdWCVBs2rLkpFzMAQ4=;
 b=hD6SQD+x42khsNy2axSH2oeTJFqio7h4Yq8ziVaaYf6O0kntT54lXr3eeaWBjPz+ZW7rBEu+pmorliTYJ3c6L9ByBYYXNYCzC1460r4hLzfDimnPsKFAVZ00TjVmDJgvEeZ+BRd490FSmCyiZqCiO8HzaysVkW+3OzZKDFMOLwjGSfsZ67P4xJfi8sx0B2FmzI1NQ83vIudddVSx04PKHgBC/tBk/WNfsiVHvQqAXsuM4ZIxWo2UHCLcCWZkAO8600roEj4Li24HVxpFQlDNKxLdelP7ONqnebGfIQ5h7zP6kcZtrw0/ozfDlJkKwWFAlUayADQbxtbdaR2yeGJoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9pYnLXWPIrTHSl+1yzrdI3JtHdWCVBs2rLkpFzMAQ4=;
 b=L35FhJUqYfSv5AABG67bPWWCttdQS8nUSB6bIZAHJPjP3epKC3B31DTLPrs7mQy/m1rnizYxTZNb4CWx5gpapik8fVoGBosNz5svqVKRZzVZ1bNbHI07LVmck4lzP5j9Q+AezDpkIxGsDbqboHpzfI5z1cy0yCPd/tBeuavG+SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:03 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 01/10] dmaengine: Allow drivers to assign static channel IDs
Date: Thu, 13 Aug 2026 15:37:48 +0900
Message-ID: <20260813063757.3131865-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::14) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: cc06a983-05d4-47b9-1760-08def9056d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	D04sKbosRf6lTo8kPllQRLEL3oB2ZsCLgKWOJsvkinRLgPUFqM+ZVYfk79sFDx7BLM+5sBrMwMyqt+99cReskkL1Myil8x6rOn9jbN2z9I4eYyXBdMunkwx9PhWBeMIhLLsMytcH820mWOMI7u2uJ40l70XBuBa0vdChX3pNO7mSDCLYc7u4S+7ArQ2yOdGVlCUwNLOw2TpH8ziF3qHZo0TmVcdbaPD7a09e7h+eonCz/+PDb/lcCo1m6x65JIa3jpx4oXdzIJQZOH7600HgUgTkcOmGqaD7ZVWFF+Gz0gxx9azLHusBItUFXFZsPfjnagNiB1iKOnOpcx5luGSHNRAQmp2Wt5xVuZsholCc2zYmJO9DkvevAqM5wg/DnQwfUOd2bfMWLT0saUEyzbMK2qFfrFaVnH5Zfl0O//+KP0aa2aeGgEiu7BQicS2NxNFrnFdqhtlizgmT5u3xV7n9LxTByZZcHytYrw1I1iVemXflMqUOj7WTFwUIvZyF+6+8Pj7m6Vm2CzzAtFxhNgNEVXD2acc7rbDN9wR7byf7PIeqiJ9hESvsB9yjytnNVfS7gHQwbyYxY71f6z7hoqVIp3pzdHeL2VG4Hc2OztotLa16JNCFsFbv38qRo/+Y+SBt32CIvgT4O99iZyoTsqCg2WmyKQeik0fVRDveJ9HqgWlmm+hhyYG33p2WOnBz+sguwYDrdKQRf1bnvwuj0HYazw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miZ6MyJ0eRv0g5IbqRvdealm8fyVe0tRffUDjJsS1TXldGb0qmNh6+SQ2aOs?=
 =?us-ascii?Q?aU2Tkfp6VU4Qmxn1atrT9VGn0TX5vxokrbCbSwUV+rOAAsy9VOaG6x051OQF?=
 =?us-ascii?Q?MiQa+TYLlytyM4a9mcr7nY/1tgqZMv1Npi6eOWXusVC2KQseIVNPuG6UE7hb?=
 =?us-ascii?Q?HYzuhTERm9TEkiC+l/uaci+7Lj+BrabTulbCawtkLEGdf5ULrSGVL2hgIPOt?=
 =?us-ascii?Q?l9+EQxYiD09ufb44JFS9JP/jj07Tc9AEAE9Lvk+y7+AHnf+59bx7NjJuV7YK?=
 =?us-ascii?Q?jZ7ELv03CluniCrzZqABLvOwfU7jh1DkOu+AfyZZmb68YDv741Q5hihJFqpW?=
 =?us-ascii?Q?xT+y9+ebk0cDts+/HDzFSVx/JjPQtUwIBmEiI37/aiS31/GyXBpiK+hUVmd9?=
 =?us-ascii?Q?wFhjmCVRgLD23C62aAjzWvOe2of6xgLNZOvjpqG5oNiovXK00zvQj3kIEXJW?=
 =?us-ascii?Q?VtflrP6M61YaENG6MKgik0BS+1pHFTfwHUbwnhgsHsBKZgZGgEndhPb98CUs?=
 =?us-ascii?Q?nvyFn81l0tyWN4CF3TLIL8wxamq6rRmvG6owHiMtXUFOD9tqFmmHhvLmAXPC?=
 =?us-ascii?Q?FMjQJmOHsoRsu2Xoi8w4IrSKR2kXsCW/haLkIxoFnpeArf43I1CbpiqjRJ12?=
 =?us-ascii?Q?y92AGomoMJAjJDma9ijgxGOp0szsDdTfcb66rKgMgjySDZAmJnfq4QQOouHL?=
 =?us-ascii?Q?eZ60m7eOg4+uIWZFiFAu3E0rQjmIiDXcGng4U5FApRZIpBhI6+sXN2yB779L?=
 =?us-ascii?Q?zC8PAz/NZxejsGrxNii7gm0AyKrLb8xshDlRBpOz50TZ9pnugfmtY/R0lAEi?=
 =?us-ascii?Q?Mq0t1LBtTUxTOxZ1bpIQQQ/YGiv49VAMwfy6mOoei/Tqftefjph0emyciWLa?=
 =?us-ascii?Q?t5Nt4Xdwiptv/2tpGCr5gV2l/GET9Cgxti+K7gWe0wqcjT3AJHWnMvlT+wC0?=
 =?us-ascii?Q?ICUiL12ye1Zmt1GLk7nmLCL8DpGWlem1NBDvte0dwxSF0/enorz3dG1Yk6zh?=
 =?us-ascii?Q?nAyvtvn/dFDkt2widqakFVww+RK4/l0vVz3f/pztlAySExJ6toGeaszXCGNQ?=
 =?us-ascii?Q?mgu2TRZ0i8vuuHVabp5LhDu69woWedJmvuj/yGKD373NDC6R4liSegWz7lMi?=
 =?us-ascii?Q?83vsZV61SHwGwp4CneOmB1toNQANdYd3qV1gbWbFUwHwZw2BGWnwDFtl+FTt?=
 =?us-ascii?Q?9nEzLsFHHhCokUg4crRvQhlAL27B4MaduN6bGg+etpwlxKujfdXiz6Cc0cRE?=
 =?us-ascii?Q?PbDJWUizLLG8Lyu74mZIEYydpN0TVsUKNUVhhC9FThuh4Lts3p8xku/VTHK1?=
 =?us-ascii?Q?6XRJMq/6/TB+EPdeARwk/6RyVQ9X2H7rosG2BeqqTRQOf3QV8mGho51bkJWZ?=
 =?us-ascii?Q?39Rlcr9npZkYTGDrpSHlNRbvfFD/CMQDQn6iBZavTZVzLyIWC9LNTDoW/L0m?=
 =?us-ascii?Q?TnzNGzJ16ZObe+91kTHK16FTbwGiJfPIgO2HF4GCD3TUqilpqdtNLX/yxlFw?=
 =?us-ascii?Q?ok1ErVjoC+TRICOBARx9AI9gN6b/rRLpYmv3pGDDIrb08MCBgc2wLYZA1Xn5?=
 =?us-ascii?Q?BgkRw9R+dUwaemLp86pDQ++Dr5O1r/aUMW14Ib8cGM8UppzZEVLHsVybhIyh?=
 =?us-ascii?Q?licCFam5h1Xr3HOwANusfxc1dF7q1lBpnenwSoMJuz2yPD23UQBwZCPo/18c?=
 =?us-ascii?Q?i9d9P+wOhHMMCY8iwq7zGX25ZU4X9s2AsAFr1keR8kOLwiQbI5fA0+3st1iY?=
 =?us-ascii?Q?9yUVuaMokofGHQt2lzAIvGTnMJU3tMrp7bxc9FYi0/6wpazzeP+4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06a983-05d4-47b9-1760-08def9056d5b
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:03.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7T7/+SuHNd1heuHw3o+ARd0Q4WaM89EfiMc+BgVShkU5XR0B458lxIrxJeT+6d+4IMSSjK58SpnODbscwqzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

The dmaengine core assigns channel IDs in registration order. If a driver
skips a hardware channel, chan_id can differ from the hardware numbering
and a client cannot reliably correlate a requested channel with hardware
resources.

Let a driver request an exact channel ID before device registration.
Reserve static IDs through the existing IDA so they remain unique, while
retaining automatic IDA allocation as the default.

Use direction-flattened IDs for dw-edma channels. Unlike the
direction-local hardware channel number, these IDs are unique within the
DMA device.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - New patch. (Frank)
    https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u/

 drivers/dma/dmaengine.c            | 13 ++++++++-----
 drivers/dma/dw-edma/dw-edma-core.c |  1 +
 include/linux/dmaengine.h          | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..cc64a4679e6f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1078,6 +1078,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 					       struct dma_chan *chan,
 					       const char *name)
 {
+	unsigned int id;
 	int rc;
 
 	chan->local = alloc_percpu(typeof(*chan->local));
@@ -1089,11 +1090,13 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_local;
 	}
 
-	/*
-	 * When the chan_id is a negative value, we are dynamically adding
-	 * the channel. Otherwise we are static enumerating.
-	 */
-	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
+	if (chan->chan_id & DMA_CHAN_ID_STATIC) {
+		id = chan->chan_id & ~DMA_CHAN_ID_STATIC;
+		chan->chan_id = ida_alloc_range(&device->chan_ida, id, id,
+						GFP_KERNEL);
+	} else {
+		chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
+	}
 	if (chan->chan_id < 0) {
 		pr_err("%s: unable to alloc ida for chan: %d\n",
 		       __func__, chan->chan_id);
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1f893dc54c79..d214df55da3c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -987,6 +987,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 					&dw->chip->dt_region_rd[chan->id];
 
 		vchan_init(&chan->vc, dma);
+		dmaengine_set_static_chan_id(&chan->vc.chan, i);
 
 		dw_edma_core_ch_config(chan);
 	}
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc61..f669b79d7731 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -369,6 +369,26 @@ struct dma_chan {
 	void *private;
 };
 
+#define DMA_CHAN_ID_STATIC	BIT(30)
+
+/**
+ * dmaengine_set_static_chan_id - request an exact DMA engine channel ID
+ * @chan: DMA channel
+ * @id: channel ID, unique within the DMA device
+ *
+ * Drivers may call this after initializing @chan and before registering its
+ * DMA device. The dmaengine core reserves @id from the device IDA instead of
+ * assigning the next available ID.
+ */
+static inline void dmaengine_set_static_chan_id(struct dma_chan *chan,
+						unsigned int id)
+{
+	if (WARN_ON_ONCE(id >= DMA_CHAN_ID_STATIC))
+		return;
+
+	chan->chan_id = DMA_CHAN_ID_STATIC | id;
+}
+
 /**
  * struct dma_chan_dev - relate sysfs device node to backing channel device
  * @chan: driver channel device
-- 
2.51.0

