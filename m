Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020133.outbound.protection.outlook.com [52.101.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4334CFDD;
	Tue, 14 Apr 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176189; cv=fail; b=Zk12ZSWY4tJkMfLCU8xO0Faqx1Xl0nBx5tSz3XVx3vZyzb2W4iavIV7ysxUFcbnBjgyUDkW6fmhRUtWJO7FdtvXJz9PxgLQBZB5D/lbWxMJf6EKfTv+WzDWKRkQNoC0xFTLDeNpgtODDAfEIWiY58x9Q9b0Ea6M9zrlhXm59VE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176189; c=relaxed/simple;
	bh=Uc7cCFcJgAf0E9Zq/xvrqyJbMhTrExKB0oe+crJRk3I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kTqm47N6nT6BJhYzgwLDR/rZimVn/VcC/6pmfCFzlr4OhPbJCGTePhJ1gfsEFXuR4/su5m9Q0K6L4gk/79noYAlDnSWH375fX1h2U9a0XH0+iwSHut0CnSW7uSJZqEMQClzYxCU3LhYsa+53Y5H9Z6A3L50DzHXIwbTNL51gnno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TBTAo/BD; arc=fail smtp.client-ip=52.101.228.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TBTAo/BD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj+G/QPLWoTY21El5x9KE55xojOVHA5QBVtGsJnp4ZDbtrt7K2QaviTdVxV1PI7bxl910wg5ECjuA1qUorJS6mLR16pQS99zGcEFgtqIDLkpVNdjSe34wrh7EmCnoh25LJyUau2kp9084YvUsOc5ssKRH3anE2WuaCqZkX47wZ6B4M2ZUErdh46Wxv8pL3d4onioTks701hoA/8y/dnznNy0f5dtScK3PQQKhs7P2L4IecrHabK0JAmH8fCjOwY+cg5FLw5Ua9memufJ6lxdzthI/rmOBNCPC5s6JQhEAtcIUOc4yrVyGntQ1lLz2jgawfb3vRFF3i06oSc5tE9i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ViAFPKC+br0nQboVyYA6xrY3A6uRR9jnVAG1b9Bflc=;
 b=K/79DXi2FHmQRk/sB9JaPhHoRU50L3sG7+ujFC1LIfWpp7AYip9R9Pwx611T+oV58pw3DStxJPPBqz+5KUk1I10zuy9hdhHWdwkJAuWuAR8sEw+Hij07DEZBvrPAKO7v4c3muaWVu5r/Agy85UeHPNc1lAI4MJuhGtyuVZOe64ssOs5FFHcqOwiUV62wXv3/DGA9EMmd+jBC3SMXcy+SyRd7+6ncOtpTmCrgcjMKU2ER83WTTM49WZidUqDR5LVitZ/oeN5H3pu3/UMceUdeHl9/V0igu1FLhOwdJCvTuD+JORl8Ul4cYU68ar4NZn6MgKBNVsUOW+Aajr4d42Jggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ViAFPKC+br0nQboVyYA6xrY3A6uRR9jnVAG1b9Bflc=;
 b=TBTAo/BDHm1+dypfj1xYvLBS/RMPkr9cpdtAQMw4nvO5wRwkoF9CapqC1j3HFR93iFmoZSNRgb1VIp3UC1FdsuYNqwrW8RoyiHNgpyf5U91kpEZJp6yEJlZEMeRW7Y5xAZ1yr/ZtBIRO/WcFUCEElDzOvMb+9sfO1KO4e58xoIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2529.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:222::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 14:16:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 14:16:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v14 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue, 14 Apr 2026 23:15:07 +0900
Message-ID: <20260414141514.1341429-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0068.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d51332e-c793-45f2-fa82-08de9a3067d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KpkdVVtWX7LBtVp1/LwqLEgU2RZ9BUfHY0KrE09At5TRjoxG7n8u4GAzN66eT6LC8RB3mvi/A0bv8Gtk1y5U44vJjgsbnZp1/A7MJBXyjWQFy3xCJHTl9ZX7rqPiCSfwTp67AiiQa/tyjFh2kdxcTk0r0NhR8DU4WWROAYft26TzZDMlie3zf/DrylCz/5QpyXa1cV3v2nKbx9j+1GSHufxpdiy12y6JKPTcbJdqAO4swufFJ02zY6QfJ59WPwGVZpWAVo7lDXGRASa+umEJzXvuTFf/zu1FfqVUEtlt+zJXPLsg2iFLnLY4iBJBkqg/JbW52Upi/nrmF1N/WSd6qIo1fI+MTff7Wc15hynfUiM/d5mjS54B88r3Hm6aFe0vmPQ651RAokHkL189KwTIEQnD2RFPw9UxHg9k8+J0PNgXqa8J93hYld1o15ze/bKMS7Kb8gT1XGzxxJmgDio/JgpuZhx9VFaPY4EMduQKui9Bak3+xf7S/t+NFXtvytcKcKTEWnJpqXo/nnYTkk76iqArVUzmtaPHvjGRTLJkWxmufd/vqoMKjPDkQx52lXr4/TjZKl8jpzGyiS5Mo6I/AxLa71sHX81eTFEvho4+IKGBoD0fJ6Dj8Df5gz1fXT8PtsDJVya8hpHdwoXXfXC85GGNS23HOAWeoJYY6oJ447c9WyOIp1+vBF2Bh8Lq64C/YDDOcAot9kKXeHBnwGdR6uoRlYh9iQSi0vURpywsXeZ435jH3H0H5dgHo7Mg3yD9GrsP3vNGpteRUToqS1aVR2LtuD0bsHOxcepwy6C4PNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gElNmOc6kyOOhUjzXx/7K9Symk0JYkRRH1ajUcMeH97LxhnLNe8OptXd8uC?=
 =?us-ascii?Q?KesDJZIQIxT2SwQD8+K+E97ny8PMSHfghrgR55p+s+8QybpIgHz3nAr4AFw+?=
 =?us-ascii?Q?RyF5jBMNbZvyBW0JM2QN9zSfqwSbTfABcwxpdEzHPbFB3sCxefCowLkQXJS8?=
 =?us-ascii?Q?5vE7tRHYrEkxgTjfSGCwbJ80PTBTBdhG9o02vyfNy0RjKhKah74ffjrYRMWp?=
 =?us-ascii?Q?sUydUUNalSi0CqQSsxHGeaRQ70mzwDrNjFG4uBKpXRaeYkq4r9ValIDizeet?=
 =?us-ascii?Q?Usyry6POuULBkTf+jBhp0IYq7vtT2PTDjnreBh06y32JMraYCYZ5fNZJzQhX?=
 =?us-ascii?Q?HSN+zxdWmb6GxHN0CmXynjlzc+Gp2ftpr6+mWPocwgG0tN/Pann1xZXGF7Bo?=
 =?us-ascii?Q?OWcw0zGNaSHKR1tw0NYToRM/ZTntyPtw61BAoEKFv/+b+twzkHnDDk3wokIJ?=
 =?us-ascii?Q?Q7mRWPCcARN3jp8GyZHqx0V09yG2PtF8OHXCr9LeGfP098bff4aPkRvom65I?=
 =?us-ascii?Q?UoSbq85/NExEcotDktPeq+9YyyJ5z2m9UGAgafjLa1FNPgTpk2KTAkO2rHcu?=
 =?us-ascii?Q?6rLT8x3gALMGiaOPffnGzUYMBEsPBwF5nHCyBslPp5NYEdmsKN8E0QZ0JK4k?=
 =?us-ascii?Q?lc3wOYyE4uh1+UWoc79sn11KdfZ08B6lPUn7L/y898ImbLMgbznPMUN9fwu5?=
 =?us-ascii?Q?VABimtU2lN8vEjlKFunlWFBqrsSTVlKm6ETZ4vPYrxrx1aq0xWoIfq5udV+z?=
 =?us-ascii?Q?MQMkYM1+nVFABG/9soby//BU5Ur2joMBcmNVWxAZKKv6csGXuTJoqKCOpVSp?=
 =?us-ascii?Q?tXvfV8GkYoq0Hz8TSo9PjuAmzd40qroysoTn+vSbGJ2K44FrdNVX/ZTythLx?=
 =?us-ascii?Q?0Td5mzGCPopvdbOBXJ6ViQALgrAt/MryolPW1kw3ZJI3gM3QAtcE2nB0OPqE?=
 =?us-ascii?Q?D5wq4+nLMetQ6lMatirdJerBvJeBpA8ADTW518oH25NvoqAKQ6bsm1y/aC6H?=
 =?us-ascii?Q?JljbC35rpYk6hctabgxRZT5PmuAjzTLVGLfwmbyae/6ZNFql/bPTT8DVM+sf?=
 =?us-ascii?Q?2gsjUGOsc/W8EPK8esA+EGnwV7/Xw/RiGXqxf0cxNqodXw2fhv5q7qOHqzhi?=
 =?us-ascii?Q?Yp8jv9SByEAQ2GkDSMiUaTTLoli9TtDHGF4Z/kNJabfhzzDHLgKKkrGgr5HS?=
 =?us-ascii?Q?14wTkIhcGp4sIjfGV76jUX5k4oUbZ49DDUWxgE6gHSH9O6B+kDJ3+e17VB1m?=
 =?us-ascii?Q?gCQ0GWdukxKymGAFKClFQcD3+qyvH40XoWzGYHQ0m3Y1McZKzOyp8hrItUuG?=
 =?us-ascii?Q?FFE1ItddGDvqPMAe+irQVr2UF0Mw5CgKcUBhjsw2KfW1de4togKZSlrUym+m?=
 =?us-ascii?Q?PiueBUnAh2FxvX/0FuxpOhbnZM9cVZwjoaJwmferGv+DnLn6LFEpNrfmJCiX?=
 =?us-ascii?Q?fTUcDJJkCJ6OScifWbMQsoPMbtWcTFqumxp5Ru7rLbZ4BXa9idTDFA4YyUxv?=
 =?us-ascii?Q?Wkma83bfmELaXR9RiiZXkrHvQQaIRYLrP0dXHxsc3Jn674hgqYtynlLS4Skl?=
 =?us-ascii?Q?iOGzxOzi+sWkFZ35KrsWOjKitLLOrUm8wknXTnw2c8VjZWmjClf3W/hYjAmX?=
 =?us-ascii?Q?3OkzlErRzhGyFKKA8cpw/HHUSEKPDgsUPa/gC7tcShaa5aAIaNuYKFGn/u6s?=
 =?us-ascii?Q?EKIRZqiBcr4o870CTE4VebnDIK26bLFQwNA/t4Rims09s2bdU34KGMhJUMCa?=
 =?us-ascii?Q?77T7kdkg+OdZb6xVkJyxswLrdjgyP5NqrasKaYnhBlp97Lkr0/hy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d51332e-c793-45f2-fa82-08de9a3067d6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 14:16:22.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFwa0x85P7RYmtpiWQIZcAw2YLBpJwXFFo0pDHyvMzm8WXs9IfqcEwArbW+LuzRjeTV9pduSL0tRtEiox64Yhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2529

Hi,

Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
EP-side doorbells. In those cases, endpoint function (EPF) drivers
cannot provide a doorbell to the root complex (RC), and features such as
vNTB may fall back to polling with significantly higher latency.

This series adds an alternate doorbell backend based on the PCIe
endpoint controller (EPC)'s integrated eDMA interrupt-emulation feature.
The RC rings the doorbell by doing a single 32-bit MMIO write to an eDMA
doorbell location exposed in a BAR window. The EP side receives a Linux
IRQ that EPF drivers can use as a doorbell interrupt, without relying on
MSI message writes reaching the ITS.

The DesignWare eDMA interrupt-emulation doorbell is wired up as one user
of the generic EPC aux-resource API. Other vendors can support their
MMIO-based doorbells by implementing the EPC aux-resource callbacks:
pci_epc_ops.get_aux_resources_count() / pci_epc_ops.get_aux_resources().


Dependencies
============

(1). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
     https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
     Note: already landed in dmaengine/next.


Tested on
=========

v14 re-tested on:

  (1). R-Car S4 Spider: EP <-> RC
  (2). RK3588 Rock 5B (EP) <-> CIX CD8180 Orion O6 (RC)

The EP in both scenarios prints the following in dmesg when running
DOORBELL_TEST:

  pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
  pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

With this series applied, the DOORBELL_TEST succeeds:

  $ ./pci_endpoint_test -t DOORBELL_TEST
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.DOORBELL_TEST
  ok 1 pcie_ep_doorbell.DOORBELL_TEST
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

IOMMU coverage tested:

  On R-Car S4 Spider EP, DOORBELL_TEST passes with the EP IOMMU both
  enabled and disabled.
  On Rock 5B EP, DOORBELL_TEST passes with the EP IOMMU disabled. The
  enabled case is not applicable, as the EP IOMMU is explicitly disabled
  upstream on this platform.


Performance test: vNTB ping latency
===================================

(*) Re-tested with v14 only to confirm that no regression was introduced
    in v13->v14. No performance difference is expected.

Prerequisite:
  To test on 2x R-Car S4 Spider boards, the following two commits are
  needed:
  - 13f55a7ca773 ("PCI: dwc: rcar-gen4: Change EPC BAR alignment to 4K as
                   per the documentation")
  - f761e0deb4d9 ("PCI: dwc: rcar-gen4: Mark BAR0 and BAR2 as Resizable
                   BARs in endpoint mode")
  Note: these already landed in pci/controller/dwc-rcar-gen4-ep.

Setup:
  - configfs (R-Car S4 Spider in EP mode):

      cd /sys/kernel/config/pci_ep/
      mkdir functions/pci_epf_vntb/func1
      echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
      echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
      echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
      echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
      echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
      echo 1 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
      echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
      echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
      echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
      echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
      echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
      echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
      echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
      ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
      echo 1 > controllers/e65d0000.pcie-ep/start

  - ensure ntb_transport/ntb_netdev are loaded on both sides

Results:

  - Without this series (pci/endpoint)

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.1 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.17 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=12.2 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=6.10 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=12.1 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=9.96 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=4.04 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=10.2 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=4.13 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=10.0 ms

  - With this series (on top of pci/endpoint + Dependency (1))

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.828 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.822 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.848 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.869 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.775 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.889 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.893 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.964 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.890 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=1.08 ms


---

Changelog
---------

* v13->v14 changes:
  - Rebased onto the current pci/endpoint:
    1d3225cb5d82 ("selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC")
  - Dropped -EOPNOTSUPP to -ENODEV conversions.
  - Fixed whitespace and alignment issues reported by checkpatch.pl.

* v12->v13 changes:
  - Rebased onto the current pci/endpoint:
    5ab7a225888b ("misc: pci_endpoint_test: Add Tegra194 and Tegra234 device table entries")
  - Renamed pci_epc_count_aux_resources() to
    pci_epc_get_aux_resources_count() and have it return the count directly.

* v11->v12 changes:
  - Rebased onto the current pci/endpoint:
    185596ad93f5 ("PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()")
  - Split the EPC auxiliary-resource API into
    pci_epc_count_aux_resources() and pci_epc_get_aux_resources(), both
    returning 0 on success.
  - Added the corresponding count/get callbacks in pci_epc_ops and in the
    DesignWare EPC provider.
  - Updated the embedded doorbell fallback to use the new count/get
    helpers.
  - Stopped warning on duplicate DOORBELL_MMIO resources for now; use the
    first matching resource and add a TODO for future multi-resource
    support.

* v10->v11 changes:
  - Rebased onto the current pci/endpoint:
    e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs")
  - Dropped PCI_EPC_AUX_DMA_CTRL_MMIO and PCI_EPC_AUX_DMA_CHAN_DESC from
    this series; they will be added later together with their first real
    consumer.
  - Picked up tags from Frank and Niklas for patches 5/6/7.
  - Dropped tags for patches 1 and 3 due to code changes.
  - Revised the commit message of Patch 2 to better explain the purpose.

* v9->v10 changes:
  - Patch 7/7: report the dma_map_resource() DMA address instead of the
    raw physical address, so EPF drivers do not need to perform any
    additional IOMMU mapping and the semantics match the MSI doorbell
    case.
  - Rebased onto the latest pci/endpoint, and updated dependency references.
  - Re-ran functional tests and vNTB ping-latency measurements, and added
    Rock 5B (EP) <-> Orion O6 (RC) to the test matrix.

* v8->v9 changes:
  - Add a new dependency series (3), which moved the BAR reserved-subregion
    framework + the RK3588 BAR4 example out of v8 (dropping the corresponding
    patches from this series).
  - pci-epf-vntb: rename the duplicate-IRQ helper and invert the return value,
    per Frank's review.
  - pci-epf-test: drop the extra size_add() doorbell-offset check, per Niklas'
    review.
  - pci-ep-msi: add a DWORD alignment check for DOORBELL_MMIO, per Niklas's
    review.
  - Carry over Reviewed-by tags for unchanged patches + drop Reviewed-by tags
    where code changed.
  - Rename the last patch subject (drop 'eDMA' word).

* v7->v8 changes:
  - Deduplicate request_irq()/free_irq() calls based on virq (shared
    IRQ) rather than doorbell type, as suggested during review of v7
    Patch #7.
  - Clean up the pci_epf_alloc_doorbell() error path, as suggested
    during review of v7 Patch #9.
  - Use range_end_overflows_t() instead of an open-coded overflow check,
    following discussion during review of v7 Patch #5.
  - Add a write-data field to the DOORBELL_MMIO aux-resource metadata
    and plumb it through to the embedded doorbell backend (DesignWare
    uses data=0).

* v6->v7 changes:
  - Split out preparatory patches to keep the series below 10 patches.
  - Add support for platforms where the eDMA register block is fixed
    within a reserved BAR window (e.g. RK3588 BAR4) and must be reused
    as-is.
  - Introduce a dedicated virtual IRQ and irq_chip (using
    handle_level_irq) for interrupt-emulation doorbells instead of
    reusing per-channel IRQs. This avoids delivery via different IRQs on
    platforms with chip->nr_irqs > 1.

* v5->v6 changes:
  - Fix a double-free in v5 Patch 8/8 caused by mixing __free(kfree) with
    an explicit kfree(). This is a functional bug (detectable by KASAN),
    hence the respin solely for this fix. Sorry for the noise. No other
    changes.

* v4->v5 changes:
  - Change the series subject now that the series has evolved into a
    consumer-driven set focused on the embedded doorbell fallback and its
    in-tree users (epf-test and epf-vntb).
  - Drop [PATCH v4 01/09] (dw-edma per-channel interrupt routing control)
    from this series for now, so the series focuses on what's needed by the
    current consumer (i.e. the doorbell fallback implementation).
  - Replace the v4 embedded-doorbell "test variant + host/kselftest
    plumbing" with a generic embedded-doorbell fallback in
    pci_epf_alloc_doorbell(), including exposing required IRQ request flags
    to EPF drivers.
  - Two preparatory fix patches (Patch 6/8 and 7/8) to clean up error
    handling and state management ahead of Patch 8/8.
  - Rename *_get_remote_resource() to *_get_aux_resources() and adjust
    relevant variable namings and kernel docs. Discussion may continue.
  - Rework dw-edma per-channel metadata exposure to cache the needed info
    in dw_edma_chip (IRQ number + emulation doorbell offset) and consume it
    from the DesignWare EPC auxiliary resource provider without calling back
    to dw-edma.

* v3->v4 changes:
  - Drop dma_slave_caps.hw_id and the dmaengine selfirq callback
    registration API. Instead, add a dw-edma specific dw_edma_chan_info()
    helper and extend the EPC remote resource metadata accordingly.
  - Add explicit acking for eDMA interrupt emulation and adjust the
    dw-edma IRQ path for embedded-doorbell usage.
  - Replace the previous EPC API smoke test with an embedded doorbell
    test variant (pci-epf-test + pci_endpoint_test/selftests).
  - Rebase onto pci.git controller/dwc commit 43d324eeb08c.

* v2->v3 changes:
  - Replace DWC-specific helpers with a generic EPC remote resource query API.
  - Add pci-epf-test smoke test and host/kselftest support for the new API.
  - Drop the dw-edma-specific notify-only channel and polling approach
    ([PATCH v2 4/7] and [PATCH v2 5/7]), and rework notification handling
    around a generic dmaengine_(un)register_selfirq() API implemented
    by dw-edma.

* v1->v2 changes:
  - Combine the two previously posted series into a single set (per Frank's
    suggestion). Order dmaengine/dw-edma patches first so hw_id support
    lands before the PCI LL-region helper, which assumes
    dma_slave_caps.hw_id availability.

v13: https://lore.kernel.org/linux-pci/20260406155717.880246-1-den@valinux.co.jp/
v12: https://lore.kernel.org/linux-pci/20260327035422.4020455-1-den@valinux.co.jp/
v11: https://lore.kernel.org/linux-pci/20260324083728.3744734-1-den@valinux.co.jp/
v10: https://lore.kernel.org/linux-pci/20260302071427.534158-1-den@valinux.co.jp/
v9: https://lore.kernel.org/linux-pci/20260219081318.4156901-1-den@valinux.co.jp/
v8: https://lore.kernel.org/linux-pci/20260217080601.3808847-1-den@valinux.co.jp/
v7: https://lore.kernel.org/linux-pci/20260215163847.3522572-1-den@valinux.co.jp/
v6: https://lore.kernel.org/all/20260209125316.2132589-1-den@valinux.co.jp/
v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/

Best regards,
Koichiro


Koichiro Den (7):
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new
    backends
  PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
  PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
  PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback

 .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 179 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  80 ++++++++
 include/linux/pci-epc.h                       |  54 ++++++
 include/linux/pci-epf.h                       |  31 ++-
 9 files changed, 567 insertions(+), 47 deletions(-)

-- 
2.51.0

