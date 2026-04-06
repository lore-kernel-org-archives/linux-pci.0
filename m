Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE72308F15;
	Mon,  6 Apr 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491046; cv=fail; b=Xh/Pw5mTkYX4LB345xnDrZIGzQjBd5agaiGhrciNYMky7ABBZlweesNJDQ8J8uV2hQZY6qUsNZP5ay69g6QBfOWoQW3gDP/ZbgAkl34kGcxWuy+65Mr5kQpX3ImgvBPXSZlpMD8xolPKjMqBnFMMezzSIN0fLKQ4/CD2spCaANc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491046; c=relaxed/simple;
	bh=FDbd6Ph9WxCE+HvH6aUyOHliDJGhIy92H8FcihWl4d8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rp4BuFNYFXE+beznS62yqkNboPP+x4jcficUPnXFL6dbdurFXdlI4dk5ghdlZnudgyDAs705fveKjRRF8xaoaRQn5G0H1Nklbave+n/lZvwd366YG2qQmc85CREbeF17FnLA+9ews+pOfL1WT49nuPnNRgrkBKT4x5/2/0cT7vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lkFa1Ev/; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lkFa1Ev/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no6fQd9X6dlRtxHzpUicWhcuXAdqScg2hmjYllpFdUii5vzH3Pt81tKQtSZj+JzXYAAnEOPniVLM8XVSX+svaVBaTc4zkj3PoBbQKgRKq7mqgB2/pGTWu03lUQjdOu/jslNfOhXyDk5P2pX+CpxE4osG5XHRSp3BDBB+QO3q6lpD/J1ZYYxK2PDGi1f+uywUXRGLXeaqT4ridF4x+1YiGqX3VF9diErTMyeUIGPT3HWK09S2acKhq3r+18CIC2lnKSQp5Rv1R6kaU3meZloL6EQ1SaBzmetd97PQQcy91dSal5msLRSEU3NTIwNQ17Ao3r7UjfJ7fWrFWdSI+4sm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVoG2wFxtJ9iC5SEOSHYE4IouiacUaANaYsvTdpArAA=;
 b=PTG36+azrBWrTBoHQ8IZwrHUiDxreTWcrK/9mqLNcUOgQCKsWFRCJkHv/BL1ELf7pVQFZ/gym9WLoBSEeGLgelZkFUaBdHNv5CVeyDBX5W1Go4ttGBMBRolQpx9Q3jHIqgv3YmtwDj9cggfAdFZWkSpHgqfU0BBJbx20bo6Uy7WlbOfXpN5wYs0x+aGU1TOp3snnjmsG82kSi390pWk6thHuXkzMd7B2NLLMzE5kydP5aFauJhTjd5fndtAEgRgmqH+1QURrgVxzVAg7WTqiL4Ke6YoZqoe7ekAzNaXNckeKl4uzJcdFZkBeSw7kVS5pDdzqJguK8AA9QEYVttRMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVoG2wFxtJ9iC5SEOSHYE4IouiacUaANaYsvTdpArAA=;
 b=lkFa1Ev//i2xoJrFST80Nxhghx5PW3EAtmWnvVx53Hq1oD7ZiyTIQQonEjwxWoFtiRYukertE6p+J7+WHSEQ9pgfWH3wRbpGECdY2hWxtPginOeKM8czdPet9fZEWstnHzF5gHCcj7sRU34N80KTyef0Ym5LWfWvnyhGm23hvy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:21 +0000
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
Subject: [PATCH v13 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue,  7 Apr 2026 00:57:10 +0900
Message-ID: <20260406155717.880246-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 20aeb164-1a12-42b4-0630-08de93f52fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	w8uRaCSzW4p0rIa8GNUZC0ZPslrYOWyUTEmrHYvjfONC/VryAMgC0T8B2yB6kQCNWHKXa8jxPiGtgp3DV98vm6jsL/TZbHel6wa0nAjHPCgr5VvNuDeHx3YFG3OkYcpxnXCkEJdplnZ6F923e2Dows7277wbtD0pmCD3aM7G7ikQYvmgnEv8eqRSu5pP9M1QqvD+gkybXbHM5imzRQJ6na52ZhuSPzWOtTEq112ykbWZxg9EaygMkdHkHueQNWhch2lBKKHEkKgGfH8LScft82N7B+RqVxuFsD6/9krGe9qjSUkiFF0igbtcB/MrJzUbAHXzIMzeLT6HPHp/wsh5wOtAfg/Nm/jCZ1z0XsL/m9VvPvRF1KKl4vXGXtMhom7Jh11yid2BH4F61L4nhmwTiSnzdu5xb65YsoUYdLojyVeO6+yl5YAUWvb37IgsOhjYFNj1yuQ6P4kZA/YfKHZ2oEE2ySV9mNvgRRRxXcQ60xBuUjY0/rmrFLj416AvcWQDQhQ988ua51svQWZE6YBnm49rQqOb7G3KX3bq0oMMF78UcNke3YqXA6wAXF3n7qt2HbDBXPZt9ahDMoqs76FXPed0vVXt8i4hX1An8Mpy+dTSkDOZeBr50qWao4PtChOCZCFJ/pSfRNCUPkbLZGTQTzoxEAhlJnhR56WxqInYFA2y7NiB+0+l+PWlGdpubDkgKwTREnBZrUAbHWRsoVtuk6zyJ+7uEP33CFV0f6HHGvi20BM8fGMwaU+6njHcOBF49HaqcQxbhNf9j8Bt2HHQpa8ZtCAMdrEZPN9e7xqqJlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSSy5E4pw4HYlMM+3kjdKQs018PA+REhYAaM0Gl/lZXvVfoBwE86iKLZgGOw?=
 =?us-ascii?Q?ctTsBYZGoYPgme9IhWfJtZUJoI3odTFZpAf5T2zkvVvMKbHNSX4PjgAM1I9J?=
 =?us-ascii?Q?NX5mplKI3dDaMe1ubflsxcz2exGITpC3TcYCKk6ALSchygvn8IRorxmMB3V5?=
 =?us-ascii?Q?Qm3T7FqNZST13iN4CIKDrNvsz7FIObfWyeBbn28CqvgJQ0iqKb907B6nyNb7?=
 =?us-ascii?Q?xM4gvoYPwUDWa+TPxdk77UsOLcvKTEN2tCqrXzuLlaqe9RZvev1P0BOvTi5k?=
 =?us-ascii?Q?Kr6t8hQeXQnho3amsd/7GxvOrWLJujSxt4eKpfqhkdc77aa802gW5I4cKezj?=
 =?us-ascii?Q?5v54SgDMm+EExjX2pnL8Oteor5DBQJmq6KH1jc0oeki2yybcrXnbhRkmajqo?=
 =?us-ascii?Q?px6I8RaIbSdV9B22cfr9YRTTRndU7KCORuJLYkGFHXL/OH8jyQsaP3S2HEqP?=
 =?us-ascii?Q?YLo7SFTTRhhsTL1qGMENbJ9D9RagqpgVBF2OdrgUcF9v29JbAmpW0dNKkTPV?=
 =?us-ascii?Q?ztLaVRkubfFMFb4kVSjUchNXwW1MDyJpIGIRMHRK7DXAp8Edwv65CSE8Psf0?=
 =?us-ascii?Q?hxtfhmH7dvixQJOeIEKZka3V/bVJTlZOYBLNYqgDc+v0C1YwfYeb8GZQW6vD?=
 =?us-ascii?Q?n3MigzV0BtOkhZtH57CJsP94SMcbUCKmA8Kp6gxxtabAbO9dO0jHuQYRDM3V?=
 =?us-ascii?Q?55K6JVi6KrFIz1OV1AXZdNdh+RfJc/uzM69Bf1uBYY9ZwmDUxXOK6uZFJlXU?=
 =?us-ascii?Q?erubIrqIns921eTQ7Y+6jjWPO2LaU+QcpxAtD76LymLcYziAUSIOxjtMaQr7?=
 =?us-ascii?Q?DSu2H6DoaNj7ATqXaS1Wy3dGmOEt/ZNZriDaECtv/fhGa42rhSWTMKoBXX/C?=
 =?us-ascii?Q?q8+5zc2Xud/usU8rEvJSSYj71BYvVeFhp1hXkgm9FWLW/NIBv9LdFrbhldV+?=
 =?us-ascii?Q?Ed19bTLQ/SVpf9GrlOg+N/M3niGtTlElfRCpY8qP7c9UvSF+6MIQvxcVYkOL?=
 =?us-ascii?Q?lyw8J4OeQwJEKemYwSo1Xg3R+UGO1WpDfdYcd7JTD7NFkLuLAPvQBMOigfZc?=
 =?us-ascii?Q?BqqJ11s8kx34NGJNnwrzSw+wMdYU0/WbrU2DE5SqcY3Nb4x8wcyPJMGhlpHk?=
 =?us-ascii?Q?ik5YOTyAookK9s+q19q3ye+lqjdyfWpt44qiQiiNoek++QqGxnpKHn+j2h1c?=
 =?us-ascii?Q?q1kQuDZEbyim2rc2cyXcaBQi4Nn7qb0QSoxohK1JcJ3fMlYnkjxW+ZVFg1aL?=
 =?us-ascii?Q?7KwntuUqxtkWieWTJGnrmkJuSAClmz2FjJ7KAbrfa3r9XFk5yPd2HiEQpGnk?=
 =?us-ascii?Q?2+KKFPovStf36uEyyMPWLGNkpNWFzQ/qdhAq6nKx48NuUhCAyoUSztUNm0JL?=
 =?us-ascii?Q?icUVa+I4FYxBuCLQpDlS7xHOLWeoTzll8q5pS2NEbBvgRt63BZMKeW45CSaO?=
 =?us-ascii?Q?EsrsTWL+vPo3VPP/8Lm2Ur63vzbChzpex2mF6NtX5N/UjhmDoyYUAb02ftrl?=
 =?us-ascii?Q?yBj2JZm1BqDLAq/KaCV8OuaWuPCrcKLfRABN5TxqZdopvNKNujL6geJ+t8YE?=
 =?us-ascii?Q?3FUi0+G9dD7zm8wi/0zTI4BeBK72NZY/kjnutUqHC9+75FjSMr76a8TXzDX9?=
 =?us-ascii?Q?9k07CF4Pd/mNtOu0sQxbkrMNhJ4dFfkb+XCU330cl419NrWwFOJ84Mx3muOD?=
 =?us-ascii?Q?eknuXuIuRk7Xj3CT2/0zPeEqkMERbAthugpykcKnkO7rvarJ47+Cv/pg/39c?=
 =?us-ascii?Q?9GXLiO5MqG5atiYzV/cbVw5OJlpzBzkpGH9XC5840KBxvy8s6+W2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aeb164-1a12-42b4-0630-08de93f52fb1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:21.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTu/WW+knv+ckL7PeU3j2JjtxWJ77ICpTXC5L9s5AC9xXxUDVq9LIqWNVtxBW/rmZR3vRAVPDFQUnS8V34bK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

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

v13 re-tested on:

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

(*) Re-tested with v13 only to confirm that no regression was introduced
    in v12->v13. No performance difference is expected.

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
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.854 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.774 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.956 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.861 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.864 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.875 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.858 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.812 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.888 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.909 ms


---

Changelog
---------

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

 .../pci/controller/dwc/pcie-designware-ep.c   | 119 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 183 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  80 ++++++++
 include/linux/pci-epc.h                       |  54 ++++++
 include/linux/pci-epf.h                       |  31 ++-
 9 files changed, 571 insertions(+), 47 deletions(-)

-- 
2.51.0

