Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734F2E54D1;
	Tue,  1 Sep 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244374; cv=fail; b=XjJKo1TaVVIXSmNrUwfGhb5mxkGgQSblspdpC/7+P20Fo0sfiS/rhL3+dMyh6+u5KhRYtd283ksfh0430Xhjo1Rs0RN4+3psUcmEmTRoUKxto4j5Eu6L8nafP/y61gQpytivog75TxuCwaLW0C6VYdoY/KFKkWEJynMb0BwLbW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244374; c=relaxed/simple;
	bh=UupK/v6AxgMNV4gWGhFBM9qg2utPETufBPPfoN06w7E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5xmQJniI2Z1J4e0RznOVxth4l8Lky5X/msGfz2Dn0Ac87mOx9jkak2GPZiekTf9SPphDkr1OSCWbVsu+MMoXBA5pa9o3rA1jqpxc+5/0qeRagKfxv7b15ondtKDMhREgoJYKAlStYpwn2dBTN7k9x6FqPasf8Nc9vLmXgwq1c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KZX2VT2y; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KZX2VT2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy9E2tKKHAeiQ9A8fSJN1q8q8jSZXchoCHwVoYg3JbDz6CKtHS7r0f1H14BXF02ORr4lIy53pju9/1bG6ozyn5Xr4L3acq3q+Xjmf5kpqKehjvxmmerfdNu1CfTcStE2kgq2mZ3MvsNfxsftnctB7bKFf+sJeOIKbwTZ6kxa/2ULhlHdojZfILwh0SONNdONdi5l+tuiUBq3wfZoNpb1Sq9r+Bprtkg2lpq6oDrfxVO8t5VbVXrwVa0wZo5JmSy7k7me0qRx5BbOUOlbTiHWwJd4vExoWwkXsBRNKSs4ICuhcYmrrJ2HRGwAjTLSU7YIrqhyfRheOJ3Rtzg8ZuXHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFjgvav2r9bm/QEVcIXYTvmeHtzRox+B6BCPL14dk/4=;
 b=pCxjYERy5k82uAHyCgxLaX0VQolk5llBBp/rqvcgvba4iQF29JijPO84KPs8VGisT0GxX/y9DTeqMQISkNOopbHd6Dsvl0Xus8QjINgwNf3brYr1N1Cw7f0KPZtR1JgWnoi6/54nKWd7Eo3RETdcipr0SeiCWD37UEkoGciaV6qlnz++bCiq8TI5tuzyasFFfMBucHjjux8OGZLODEPfiVt/3847qHXoO/jqruz2Ht6/ON2d9tZSf2cbnx9Oo9COAVV+6AQNCI9PvkYI4BFRx2WHIg6qUusqlmyKc7gZ4lheiOSvnOBO3g06qC79t5V6qoVhMDMiQvpl3GX2nxGqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFjgvav2r9bm/QEVcIXYTvmeHtzRox+B6BCPL14dk/4=;
 b=KZX2VT2yaIepwrjgM37MhRugpjd94Zk0ThbtSFS2eEwa8uDSRfxyej+cjMoaaj5PVTEkQRkhjoG43knjiJftDjAXKQxLOQIOAlexkJoyp2v8KYhuTfBV5eoEn5GnFnRhiY3VX30LnlM/0UfkYAcotCAzS95BsA+2LBXw7wM/lhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2096.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:32:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:32:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] PCI: endpoint: pci-epf-*ntb: Harden vNTB resource management
Date: Tue,  1 Sep 2026 15:32:36 +0900
Message-ID: <20260901063238.631166-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f38ebe2-059a-48c4-850a-08df07f2d616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|376014|1800799024|23010399003|18002099003|13003099007|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1AsDC+r3eT6ZBdrhHxmOzLpdyVHEmJLWQNx5bnS+QdCqlfFEnbQIv3sBBNuI8YnyY5ieIQ9kHc7CzTVbwOGV+qhtepmHzfOnT1mCSNhz7MNjGIYjEKdhZM/8mBbmGzpTtfJwO7VaS5GvwcDyHA2zhj7DZqCxDucBROX/WxKBvdobbg+1VIQl5MoEd/CGuG3M2ujXdUDxe6t4MPdANeMdW8MtuYDkYP40uKcoeJitVdSGkBurfLpebqZZwn7tyMfzfxCofhmbMcfOp+HaSgFtaVRgQcLCURfavm/VuU2f6gc93tygrG2f790Zl7jpvjWlCMZaAFeIcZZwBuGhfgEp4nYI2uSLb43ORQ63hsakdFFevBIq4VUNhkwFtPhtt+NmFAEe4AtaMdnURhMpmGHOQgzW3H7JuDjNVfjzh6fNdxV+6XH/iUg1b4W9pfkO8SU0kSld9yIA9nXGfnIhX3u7mCJraFnkuLLLsTnG+pDr+4vTTH1qlY4Of1pdDLNPTqLRHTZ4J2m4nohaQHVrFC88swVETkYtg6xX2j6vvKNbQVOvEpQV9poc1hi4ivumzkZ4DzXap2xuNTl2PsHgeHM3Ur+9vq1HHmW5AdPfUUtDXQgBBB9TcQr2fvbdIxFBy1fY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(376014)(1800799024)(23010399003)(18002099003)(13003099007)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9O06zMe13CRPx/ELKkxqV9ORVdXxgNBdfn21YvhNOjXE+rqWl3ceHnzLG6IN?=
 =?us-ascii?Q?lOBnF6Tk/xLsz85NMukX97y9NsQRRkouKFzOVXCanzUg0qw5qZUiYUrHi+E9?=
 =?us-ascii?Q?X6DyTc1+bsEJnHSKfQ7NcUhESMrdbEXTCE9licKdiGy9dNz5ipp/wyzRyqDG?=
 =?us-ascii?Q?O5mkPfddoV8/2tiWeZnH05DjXn2VxyqKYQ6cWaCihizm+R573I+4Zw/J4oDy?=
 =?us-ascii?Q?ZgeFEqm4lAA+GtVZL1sPYC0efPOQNnaZv+ktm16EV9C1pMD7RJYuNxQ9OI7l?=
 =?us-ascii?Q?0wK9KeMzIbf61A988LM0Xk/EjGC7OeWKHt/c7Nh2HYqdmqYp7DrT/w0ZO/p0?=
 =?us-ascii?Q?2e7xled9op6t5dmLgP80ikG/k4c2rs2KnPlP4xDHupIwAHduNDLOUvqtjvSV?=
 =?us-ascii?Q?5ekYZjCe9PxXLULkBxYd1nRmVzSBoeLgICD7rReIKMSfOgK4MTR390Jxip4j?=
 =?us-ascii?Q?BOIjXKMTNjJLVUzaB68AVYOTyqvZzw7XIs5g+IShv6/AX5+dkAdeMPdG89Sy?=
 =?us-ascii?Q?wa9IStn2G7WOuDgzXSOlpCVYZIXt5eOPbBjFR3Fxx6wBVwnKb5fOvNI2Aqvv?=
 =?us-ascii?Q?2y8w3w7S1bsN1gjC5RiNMV04zSEzE1ADuPpOzs1idx1LBECnOS04uzop2Heu?=
 =?us-ascii?Q?7hPiCiMWGyzY7rCYFMVTCl/Q/HLDtvOX1c4HY9gpfuDC1ecls3xX72LOasU2?=
 =?us-ascii?Q?eDG7D+kQ3SAEanalnPH0e1qKfLKWhqV13QNPaTypr/Guz+ZiG6fdg+YguZ4r?=
 =?us-ascii?Q?WB2ypNX3VcY/4YqzLvva4Dw8/eSNJewg/UmYEHT/0+iIanXNbAzWSFmOEfAN?=
 =?us-ascii?Q?at7xKzDaOTKIp9kJHm4m0L1xCmQpWhUJzZDvUoeNEVQ8/E2GLIFD2oggpem0?=
 =?us-ascii?Q?pFgbTrFbcWje2zjAz6Y8/TNjUixE6sHOVLE8leiXLHkmZ8U/hfvJbTdmL6OY?=
 =?us-ascii?Q?/1nqGd40bivqSiOOkNxKPJaaayev05BTbyL+WcMNO1U8eUCiLUAJcJfE+Z/5?=
 =?us-ascii?Q?3f5eg6YYoGZ4zYgvuIq5XQfnX8dlrHgqLfRyrbUnjhLOXIaTDnByJ7BJXxSZ?=
 =?us-ascii?Q?oCGAEvPEJXqFFAuxONQzjIM6/hpz6Z8pBzsCWJtvjX3yJXAwAYjYeekxUjWo?=
 =?us-ascii?Q?gOCeK0tzjwiX1gis4J/3+XtNelsf+3W4pG6WySSXathq1TovsZ/C4VFqTu7L?=
 =?us-ascii?Q?0oJA9YQ6xvKAs6tdxuqHwHUZrWjIPhAppGjJyvn70a/nny9vVT7JVkiQ0lzj?=
 =?us-ascii?Q?2/L2/tPWnoOWyhOrjN2OPIILosi1Q+6r3rItleVXlOr0cRTpP644FI81sPVt?=
 =?us-ascii?Q?zkLQxbX/h/pfIYzipsaeRecrmPYV4GcJnTrODGdlzDRbZlzsHPHmTmEDb2PI?=
 =?us-ascii?Q?XbWh1w/ZS8UbXpFd2ja4I4iSDuiUB2yqfcr8PLym16UMeTUvRdI975rQpELU?=
 =?us-ascii?Q?sqypiWna7udbEl+Dv8wVMbn/cu3+mGrKddINKWIKpYD3/ehaqeVBzxwr32lX?=
 =?us-ascii?Q?zCG2r4jyL6TQ94yg1YNmd9l3j7f7ZDsNBDyKuBEAvUQErElIY04cNhZ5NypQ?=
 =?us-ascii?Q?kWSidqX7kTTb+XlULHQiGSgEFwUM1U6T9pdebRF8bYmGfTWyEbuqiVmBNj64?=
 =?us-ascii?Q?tiNbEyiBWz0lAItZ+ncVZQpZmA6FgIrbOMKgflwifzrjelLyvhnvyH9WyBoP?=
 =?us-ascii?Q?Kjp7fXAmFqZ2R52DQ/25ZX/uHdxkCNSuW3JJzGEqS4pAzlcuaeE/X4sxLZdY?=
 =?us-ascii?Q?+j5I3vNroUuvQSAngbRyIqyOtAOiqO1EP3rN2oykpDm176Gn9m8f?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f38ebe2-059a-48c4-850a-08df07f2d616
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:32:46.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5YVXa5YktR4G1NxxcFOI/LqQf/2aJE/9r6pHOyIEhgg/Owwhe0cm3OF04jFVIazFVf6W16Y2rk8Y7b5+uglhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2096

Hi,

This is a follow-up to v5:

  https://lore.kernel.org/r/20260226084142.2226875-1-den@valinux.co.jp/

Patches 1-3 from v5 were applied. This v6 addresses the remaining
lifetime issue. Mani, sorry for the delay.

Before this series:

  bind:   EPC resources -> virtual PCI bus -> ntb_dev -> NTB clients
  unbind: EPC resources freed
          virtual PCI hierarchy, ntb_dev, and NTB clients left behind

	  (The bus returned by pci_scan_bus() was not retained, and
	   pci-vntb had no .remove callback.)

After this series:

  bind:   EPC resources -> virtual PCI root bus -> ntb_dev -> NTB clients
  unbind: NTB clients -> ntb_dev -> virtual PCI root bus -> EPC resources


Testing
=======

I ran the following script on R-Car S4. It only checks removal and
re-creation of the local virtual PCI and NTB devices. No peer or PCIe
link is needed.

  #!/bin/bash
  set -eu

  modprobe ntb_transport
  modprobe pci_epf_vntb

  cd /sys/kernel/config/pci_ep
  F=functions/pci_epf_vntb/func0
  V=$F/pci_epf_vntb.0
  C=e65d0000.pcie-ep

  mkdir "$F"
  echo 0x1957   > "$F/vendorid"
  echo 0x0809   > "$F/deviceid"
  echo 16       > "$V/db_count"
  echo 128      > "$V/spad_count"
  echo 1        > "$V/num_mws"
  echo 0x100000 > "$V/mw1"
  echo 0x1957   > "$V/vntb_vid"
  echo 0x080a   > "$V/vntb_pid"
  echo 0x10     > "$V/vbus_number"
  echo 0        > "$V/ctrl_bar"
  echo 2        > "$V/mw1_bar"

  ln -s "controllers/$C" "$F/primary/"
  modprobe ntb_netdev

  unlink "$F/primary/$C"
  rmmod ntb_netdev
  rmmod ntb_transport

  test ! -e /sys/bus/pci/devices/0001:10:00.0
  test ! -e /sys/class/pci_bus/0001:10
  test ! -e /sys/bus/ntb/devices/0001:10:00.0

  ln -s "controllers/$C" "$F/primary/"
  modprobe ntb_transport
  modprobe ntb_netdev

  test -e /sys/bus/pci/devices/0001:10:00.0
  test -e /sys/class/pci_bus/0001:10
  test -e /sys/bus/ntb/devices/0001:10:00.0

  echo PASSED

Before this series, removing ntb_transport after the EPF unlink
panicked:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
  pc : vntb_epf_get_dma_dev+0x10/0x20 [pci_epf_vntb]
  lr : ntb_free_mw+0x38/0xd0 [ntb_transport]
  ...
  ntb_transport_free+0x2c/0x1c8 [ntb_transport]
  ntb_remove+0x2c/0x48 [ntb]
  ...
  ntb_unregister_client+0x14/0x28 [ntb]
  ntb_transport_exit+0x18/0xb70 [ntb_transport]
  ...
  Kernel panic - not syncing: Oops: Fatal exception

Unlinking the EPF freed endpoint resources and cleared epf->epc, but
left the NTB device registered, Removing ntb_transport later
dereferenced the NULL pointer.

After this series, unlinking the EPF removed both the virtual PCI bus
and the NTB device. The same EPF could then be linked again, and the
script printed:

  PASSED

Best regards,
Koichiro
---
Changes in v6:
  - Add the missing PCI rescan/remove lock noted during review of v5
    patch 4.
  - Rework v5 patch 5.
  - Drop v5 patch 4, as f7245901de89 fixed the NULL-parent bug it worked
    around.

v5: https://lore.kernel.org/r/20260226084142.2226875-1-den@valinux.co.jp/


Koichiro Den (2):
  PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan
  PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
 1 file changed, 75 insertions(+), 15 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.51.0

