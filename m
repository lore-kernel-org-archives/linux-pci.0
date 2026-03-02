Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924C333447;
	Mon,  2 Mar 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435706; cv=fail; b=tPHDfEO6yp3r6dY4w/VfIgFHeyKwiX/eUMF4dMSiLLyPP33F8Zs4txY4fRYNUWJ47xmNp/KasMSbcifRfyNCttbueg10NDN8L8fVVYPstjkCv590mLQVqwQs8zuUtygbwlU9EoPLRBCel6E/j5vKH+sBUNsT2ZRt3tR0lOTOrA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435706; c=relaxed/simple;
	bh=vbZFXRVqFLhzwKB4GxCWDE3Y2YgeMZRBTSm0Qytq17w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gi8GJOshkmQpsADWvAyndcD0ukimd7xBzuP19kZOB8Rjv3rCI2VYQ3/b5uxA6jOHgOKiqaUYy9PT7mLdvioIsMdfeYb4G1nktKlSiGjoKGd8Jxs+C3z9NT01yeKC7e6ZZnNMgkbbGkO58ztPSYRS54m/4jb70/PCMaB3U/yv0l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dgxLgFOF; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dgxLgFOF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFBLvl8qmTwkRwOV5LpWLRw7NkJz+GMq1TwL7NcAoS42SzLXJoqqJCYbv1KWZftTpQgVQQYdfHThndrPZdQ843Wf2N48iPwYmr9EYeXlBszLD1h8huYoaMolQxxirkEy3WbGUh8Xi2RWdsJMENlAIro7nMvA0uTFl6c6a13sv5YOfyHGLfm38ZlpoYpGkeDmDDoTlhcGRL/KfTdceNotP7mNSgIzKJ7yZaCFpuK+JxLwJxuYrAjZHgTaLD0n5lZESR/ySBb5dxtiygTydrZjRie0kIWNAXwfHcwMhQ0ZtmRcylMExJDcPKQYs9HaFw7mq9BGnnF2JdIprK7eAPzZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQc5gVhwilp1sg2bu5UKJ9tmDRlWNB0KaTyEAkeeVJw=;
 b=UtYMPEjHo4z9kxGKLBmOXX7TPK1/CQaLlN8LB+7iYzvnWONJulp+Gw/2scA2DaKq60LJhLA9o6aVNOoMcHL3MflmLUj5RgWGVpsqX2wot5aBV0Bq0yPKpUalIjhYU2Xx6/bWN/NDG2NLy8X4vGZG3V+/CMN7ukAHJa7WoqQgsR4LZwlN7jaVQ/2g/EP6R8Y8X+JuA2Yj4HMmgC+6xcQ0TGfNIeyudYW+3RizFCTSyvLjgXn+4MQwyw3OHqodHzuUtliABBR4VAYFLfRz5YOhDQJd8qvZQQM2BANFhg+UqXjTId0t/mU7qbNSI6mLeHTdZu4WyBYtaoK7u8W0Vh7lZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQc5gVhwilp1sg2bu5UKJ9tmDRlWNB0KaTyEAkeeVJw=;
 b=dgxLgFOFn4cuHlIK6suJXqeFJ7rXnGwkZOP4XCpnebDeHU6Y78zcn4TWsewBf0pqaFC+kB4IL0Q6l/2LpzDeIcf1FPDXIzejMzraopKkW6Prb5al8ECNAUNI8knc3+bmoiiWO4hgT+6BWM8ix5/yQK4gbWLG6drOavKdZx98LGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3705.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:15:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:01 +0000
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
Subject: [PATCH v10 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  2 Mar 2026 16:14:20 +0900
Message-ID: <20260302071427.534158-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe35691-2693-4869-cb49-08de782b6b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	6FEZE0b79YcEF+9+29j9ZxO5Kte8zom1ZAe/3XSeDr36mQSAvko1f0ZcXakPPLtp+qE3gj0X5E/rCa5b/Fx9yYA3gXW+tg9DmSYu46vc5QtuyVlFnxdqFMVMs0i2J9xUYO4SN7XumDHeKOOMryX7xSJ4nS2/7rbtceha2mZBGHXI9G3cCxqTJIXBu+ahTCxwUY21RjL4K0TV6jNm0iTQTxiTmXUysoeXqfbsMizXCsmyqr2wateMbLE+x1Cl7PWZUIDx3daKSo24I2ntVY+IG41WopnAZSSYUmK6A5GRipXXgOjia+yeMwr+RSGOP/VJBLJ+EjNdAkTFdUONAVfJyjx0qP0i8orjukoLftf/l68aO2QlP/U3uzmtwjD8Ld6moFNcrXAdvPzBwH78v3cE3Gijl7BqkVVH7mExhnj078yc6ft/4SYfYrdZ57reMdquOv3sYlYZk/pYkq/9eb6cg9Zbj8qcV8FmEqa2wguMmYxk4dPTHQiVq2USZzzOuQN/k2UEpK4nKT0inWfm+88dqNpHZalzYEc8m2FVX9veO14YFnI1cOTYse+N+vBrnjlgzrza/FyDK+t3cyDHHRUIjAdYW/leXSZh+zXQi+JpU2+vcjMGoX5P8l+c6kiHoNJyViKHH2eqopgctdjGE1rvyNHy13h3CNyhGEToh966E9jQb3WDxzGTO+3vMtCYhs1onX2Zfndo3ZsN2wGrkmIiFhhNiCjok1CNpjcojGZZlRf2lQsFTNBxkatCRp9+7kQm1tvfELj0ZsBJtAuNy3Vjkb1sT/9c9PUJrHC65Kiaiqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrVilT7P0Ew8xcsZG5qiylQwCZA18c7yYanPF6yTW1b1/t5EhIq6D1OcaAc5?=
 =?us-ascii?Q?qBA1/FEW5OX5AeXMPHswawQ4d+1wtNPFj69/+xZ9gOquDYkTD3I9jQYrzXL3?=
 =?us-ascii?Q?UWI9mI67YE0L/zMWInssHgtztL7O8Osnnai5ypwEaBJCEVuaSORj3QKYgkHi?=
 =?us-ascii?Q?MFD2wtGCPN9hF6TtX3xICHNEyQWKdUQZsJfFM7I/PvPmEbfT+GPCbB+24Rzm?=
 =?us-ascii?Q?melccRkoyXT/4NIqVkMeonJCiY3oQWhhWvLqXcoNIJsgV1ED1hAGlUZHpUMM?=
 =?us-ascii?Q?QRrVoSI2uS6UGHqbstrjFvzDGSN2YS0hruoyW84GCYSEohRtfYazwSa+50hT?=
 =?us-ascii?Q?9rtLsbKcvnSnI/KjwLAG614+0Uiibj3z/Q5OITGt63a1pTB1aC74mIUBlHe7?=
 =?us-ascii?Q?NYLjNnXQ2udcKmg7pYwwWpwXu3EgZV1e86cqAauC0CASmKRtwrhFZQmy9lAe?=
 =?us-ascii?Q?BhImsX8vpRDuahCI4dW+Gw2NRv2BXAy0fJxO4YGWgI/uKslymodGoZTQo/gw?=
 =?us-ascii?Q?FnOYPjedN6MLXz+FbmLUbPKyXXLIv6fd2Gk8ITAxwzNGQ7LRoaPhMyeNzJUH?=
 =?us-ascii?Q?Oq4/2p3sMcWj26+Y6mQU0J3XlmtZc0WNDg3gVsmxkKF/FqGDdfl1OkzQXsee?=
 =?us-ascii?Q?5eXvypr68BaMIoQwyh/1bdZVcWZ1N9TizyIKrFFoIht0TnH12o854GZxSkIr?=
 =?us-ascii?Q?jTiIoDbNwhC80Hvn5KXsRZkxFuEQQBdxYhybC4qn85F3eofhNSF37y1slLJb?=
 =?us-ascii?Q?n990hySl+NMrpfGsARtcOoAQGCgZ7GMbgMHsnrWsALRPFdSV5Hzx9hHvJUZM?=
 =?us-ascii?Q?K1aMOH2mAdsDfA/LIg6Zx/+QOgNa6EK7Zjzit6VlV4hoO9vH0gGYQNNp+qhg?=
 =?us-ascii?Q?PgcASzmWmu/mPAJpzN9gQaUyMAM4uoULXM3ZRovlZv5eauBUtLSHycRCpirA?=
 =?us-ascii?Q?3fQeqOz43Taa7k+/nH3qfk6EQY3QszRfHs8rMOwnCW+rN31qqhRwPTV6MWUx?=
 =?us-ascii?Q?YxDpqyITqGzukT9FKT3GHPoYVWtUoCaZFw7jVNXCEqvowFmIsMYKIskW7zCR?=
 =?us-ascii?Q?DgIICOq+UAKN4DZUPLZLVifgVNDf1ctiRIE49hnYBHlGYtqsigRsDT0PpqOG?=
 =?us-ascii?Q?vmiiDjVZNweTiSArvBx7SJFtoH42use1GWN26+HQnWwQmsrvs9AlmKzXZPWs?=
 =?us-ascii?Q?C+9pte0gxMFERq5Ohh83faPF+HdYkFFgS+kc2T0bejLjGBtGudHhtBsKDy6a?=
 =?us-ascii?Q?PPYQKlb69OhMcJ42tXn6Vwyvqr1f4f2x1QgeFsWJnkQOGFMvYwJQRbrrN0ni?=
 =?us-ascii?Q?fsfl2g+7s7I/ujX4tafqPJm/IPGFC5/8C2TYxsHDCK/eEW/n5II/jnGnOTCN?=
 =?us-ascii?Q?DJ8lopAURHIRDyOfjCDUM2xPgm4fKJ3J7a3x4eXeZQkJ4xeXZ3OcumE5Dw+k?=
 =?us-ascii?Q?KIuVKVUYJ5Div68AdlYlFJvVQrGuxcf5x0hKa5ezowLNdvl+Gy9JPC5+GQoB?=
 =?us-ascii?Q?8GLskxrYfArUtCRXRiwqs+OH5SZ43vrsCiQ9ikMUr8ZZwoGPYzrGebnyDxyH?=
 =?us-ascii?Q?mAj3e6v3ftAIn9DSRrlv7xNO7mFVTYOw4CmMf1EQ95HuWPqRLPpdtTHQgdBE?=
 =?us-ascii?Q?61DmL5UibGzWIKuJQ5fNp3w7xY3u3IgB6nqDbdNETm9Q0acUs0d78iiE3Fpi?=
 =?us-ascii?Q?wUwuHLfXK/OIyQJMVP16u+VRW2XPqkBEPQPgT7XkkM1v1n0SSrSqMIPU5r1N?=
 =?us-ascii?Q?kQcNW7XSVVoFyWb2z/zJpklh8zNUkzBweGMOWgYD+PYCTx/lVAcR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe35691-2693-4869-cb49-08de782b6b0d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:00.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oFjrMRaK13AfrWHUTrDGhhKCcmW5T3RN2yZBc6cnjAOAvqx8TsUY/x2vbgaxCXn+Fvs683KBvFjBs5+KfALSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3705

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
MMIO-based doorbells by implementing pci_epc_ops.get_aux_resources().

Many thanks to Frank and Niklas for their continued review and valuable
feedback throughout the development of this series.

Compared to v9, Patches 1-6 are unchanged. Only Patch 7 has been updated.


Dependencies
============

Dependency (1) is already in dmaengine/next. (2) is still pending.

  (1). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
       https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/

  (2). [PATCH v2 0/9] PCI: endpoint: Differentiate between disabled and reserved BARs
       https://lore.kernel.org/linux-pci/20260225170324.4033466-11-cassel@kernel.org/
       Note: Only [PATCH v2 2/9] and [PATCH v2 3/9] are strict
       prerequisites for this v10 series.


Tested on
=========

v10 re-tested on:

  (1). R-Car S4 Spider: EP <-> RC
  (2). RK3588 Rock 5B (EP) <-> Orion O6 (RC)

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

Setup:
  - configfs (R-Car Spider in EP mode):

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
      echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar [*]
      echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
      ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
      echo 1 > controllers/e65d0000.pcie-ep/start

      [*]: On R-Car Spider, a hack is currently needed to use BAR4 for
           the doorbell. I'll consider posting a patch for that
           separately.

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

  - With this series (on top of pci.git main + Dependency (1) and (2))

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.23 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.995 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.893 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.901 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.896 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.880 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.05 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.942 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.955 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.837 ms


---

Changelog
---------

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


Thanks for reviewing.


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

 .../pci/controller/dwc/pcie-designware-ep.c   | 151 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 181 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 ++++
 include/linux/pci-epc.h                       |  52 +++++
 include/linux/pci-epf.h                       |  31 ++-
 9 files changed, 563 insertions(+), 44 deletions(-)

-- 
2.51.0

