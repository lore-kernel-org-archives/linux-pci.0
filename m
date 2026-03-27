Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021142.outbound.protection.outlook.com [52.101.125.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E166372667;
	Fri, 27 Mar 2026 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583675; cv=fail; b=OaM04yiIY/K96IQ9R5Y6V7ajmefHLHOWCsXVifdmA6OP3HpQLF2zmSxPr0krdLJKIFcdAklK5PIsWunxquGuxUiQh0b/yv5UPOqB6DXYqV7ssHFIqCK//C/WxYQYG+icrRb0HvJZElCod3XKk+tLLdfD7jPRc+/blK6Qhd99Ql8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583675; c=relaxed/simple;
	bh=IdbCzxztA+dyzjlWD9HW1qWmDElwJkhKzY+TAM/al0c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r40Fdq9s4KfXm1hyKdvr+FYVhzTlna7x3u9eOQEWakpk6aTZHdUv7GKua5WctBuDEmEgAo9XRU1Ag/mvlwxwfdPsCrOEQdXUvwdXAZpDbZBizoFxPf2MnRLJNuNqiXS2/Y/caGqLT8CE+/QjVvR58KgmUmeZRBW2rcxgZnIYQjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g1mMZQp7; arc=fail smtp.client-ip=52.101.125.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g1mMZQp7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVJJ2TTEr+oGDZmhkcuAHhrPeMMztcYbcqz2rJKtCtC0zjLZd5F2ayNwLuo1ZWFDIMYwroPfAZSKmBa31TPjPx2HhFnxTLQvDL3/J0uFL8tuyHWm6e3/seuZVggpzpGGxuyiIsq7dLu5uJe5laG1OHSJ1CCZZjjEZakY6YegJIhNN0ld+aALSuIHQHKv6MwUKBGtMfP5h9PAbNBYMvHFZIdttfiV9hvWS2Cb1906Y+gq0L8B6HMp3xRqwB8skXSCinFIFjh9QHTJP8a0DyuQtKp4KXIPjlugmR6u4LizGn+s3oXiT+MGgDQ3chkuZ9Nu8ouaqXjcmRKDoPxMTm7DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dbQKfflqzquamQtk717+zZN7MjClHs1B36F2Pu2fUc=;
 b=srR5P5amQxsL0kwTgrQxgq74alfhsQNwCrkyDRbozDX7X/9JNlVM+sVDLuTGi4sc7KWjW40UFPk22Z0LjK+KFkM5sUDGm/W1R9sYBbysnCrhuPLxtd5lYa/JpNgt2bV+Tp1yxEwzKxjVTVlWNHEMPqeWnU5RYNIuhAwE+TwasFckQabPWDfl1crPTSyyDTmDlPCwokD1NhHH+DT4w/tiX6yNNNSxl9eWxqqur/BwUS4VH5yCbI6eW4jiFM5h5pZHRZD7PQbTFOqrpysWGaZBJNY/v1k2oI+P7mkhR7m8vFZFJS4hcDJINm0lqD1Kbmx+Iy7EJy31kKDroY0XehFIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dbQKfflqzquamQtk717+zZN7MjClHs1B36F2Pu2fUc=;
 b=g1mMZQp7AyIt3we6N/XN/QajKllT1qHI+QrOBJAIvfQW4PqshloJ+pBEB6hhPI9IV5qZDBa3y5grJAQdXSslk5yBAWsfby5abmbZKji2Hh6Jlqkuwv9xXDzrEYJLpz6sID/zrCGfiwYxhcs9VTAPCIMbXV83zUCQwZmvDmLvWcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7090.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:54:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 03:54:25 +0000
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
Subject: [PATCH v12 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Fri, 27 Mar 2026 12:54:15 +0900
Message-ID: <20260327035422.4020455-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d86eb8-f1c3-4020-4ecd-08de8bb48968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GrugVfR4jA8pCP6/wywU6EKCeeiFwJahxAcg/+9XkmRW/j0GL09TDYLJXb790iWLYJ1SblwES3kJnILHyi9MHazx9OHXQ+Ietk6cgi6UQkETIeU3NlnkbDc8b9qYtwRvqrDElAA4rhHXHsIbNeLhNLXjXvcXpvCk5dlJn5urJYduE5kzRqiWIODNNKmLSgwayUsKBZu885W1a+57JW6fDjnyhSMCXEJQAC7WWFEO6hNPTcIwyS+M/Q1gzwYsb6wGvEMkZWu8zKb54D3kHn63GddGadylKYSJwGMIq7jdGdYz0lO3lPR7XqRIyFEJPgL/flCKukii1zCObdp0rtLc6ISvIYqEwDgDgQObk3HEOH8ovcORL91gY0r6mza2GUrVMimRH6l+JTtthGOVFGF3LC+rCeDcQ156SeU7lMO6lXuICG1QTohxBJnnuXifQB3FRUfcaJuEcaMVrMjYMHdkCrj6F2WOEGBjv6sb2Yh7Pbv8vhqL7bMeqdn1lrlBvkCD1OUybsIW5tU9tRh2YTlot/ZDTGf9Oje+L84GmlBiJLxDEhIfinx5MQgYm33dNlhellrOXMZaJHpl2PSqgZ0j+lX6wgl7L8H2BD7+9Hy5yh1uL0p8uF1lazDr1zVjRKBbzBz2/7T4UQOpfQREGVFXYj8SHUUSyRfnOy+0ap9ADHmNpCFCOTQ5tmIHtPFDKQpDq3zX+ERfgBbH1NMsCz3VNd2qFyzuRGgyXhiUltyCeWfbTQgxz8nIvy4lbvovgdhduq+xwOkuEmvKjAkZjMNeffD5fDmDyCqbaKhu6v1jsQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvDT/RTRO9CJAyxSSMysz0B1d+NbPmnv5vSJcd27Md4kUFpPItUD20x9HVHA?=
 =?us-ascii?Q?THPmau0Fen6z878jBbe7CyvCS2xeZH5UiNiT8jI7EpcBLFdAJLlDBrZRibcE?=
 =?us-ascii?Q?eHzHGZe7M237L4l0FPF51V31dOWdOqzcgunnf4Y8L1cqq7CIl0eXwM2PVmBL?=
 =?us-ascii?Q?2WPqmkOJ+2lA10lqnYAWMlWhRcydumZVNfAPkSdKYC1gDNb/RZw9TDBIgo8P?=
 =?us-ascii?Q?+NSBGCp1htN/P8ttRNy56qC1dLsq/FAtz4UEhOXTwrB95y4WyqosHp48jNfj?=
 =?us-ascii?Q?whi2nfZ9sFD4Yf3DAWCaurFZ2TuF2Nuri9GgH6UMWnFJT0RVz0N5ECuoZyEK?=
 =?us-ascii?Q?B9tt5nWIleNbTbukZzvDgsMtd7gL3XdCzKEeMut4oJYFLyCiTNQn1KZChJiN?=
 =?us-ascii?Q?LcAyybJg9jzQISYmpSjnHxebMGGbOmMgXOvsXiatgdtwKSWvkDvPRVnw9SlU?=
 =?us-ascii?Q?/W90UvOQqd6gRZ1G11QLpeWMjjNthSdASuYKgJ4o4gddqbfjIfcwxUTia8ff?=
 =?us-ascii?Q?KGoHdo1iNFp2rh3G9xxrKCRhgP3Wb3KvIV0qht7wK5w0Sibedg4GztQXVDkC?=
 =?us-ascii?Q?BKOx2FGnV5C1/Y0kdubLnHEWpKljXQUJMPLvsNdCEl8Huns+8irvORYbXIDE?=
 =?us-ascii?Q?OMtxs2b25rE9tHaFiRUPRIxr2AxUDlxteZPq3orprlOn63zB6X4QaQmHb8U/?=
 =?us-ascii?Q?xLmdHJ6f8pyLVigLHGiDSIiDVIr3FyKJAdpOQl12p9sKt/KnRqzAw6rEvb0W?=
 =?us-ascii?Q?CdtKdI3Mi8kXJMUab1y3nAkA6N2BBVKGVMh+mNEjHxPjnqRPdpJSPbLxlSg/?=
 =?us-ascii?Q?pMb/4UQoR1Tj5y5t26SmQeJu9oKDqCCiOAMUm8gBjKXlNtzfQqE+MCI6fHEU?=
 =?us-ascii?Q?+3gvP8NV9cfIH9itBilj68VJCfZPGoBelyTJUI7gGALSthuAj+fxU6eHU7rb?=
 =?us-ascii?Q?Ib0bahlCm0FcQZf9igg21N+JSYzQy5hq+MP/mF7/fx58AuU+C8/+Q7GGVo+v?=
 =?us-ascii?Q?BaB4+RwF5KRYlVxdry76sbFiaRqdIIIffLKv+c448TxlOpLtt4flN2UebgrF?=
 =?us-ascii?Q?ydDUU+Fk4E1riz1Nq+qdDmVhnn7b3WA4lyjcOeKZsF6wPtCrIjzIw1vaUE92?=
 =?us-ascii?Q?7ZkTvqhG0lDghMQAHbYKInUPGky62uUsVPUpsPF/9E5+WK6w1VAHntyyX7iu?=
 =?us-ascii?Q?32fxAgFfD5y+vF5goLDjglIkL0yGFtbpH4yss1crqXrRYND4+cCpPDNOFGvb?=
 =?us-ascii?Q?SJznVlp5vv2bSlCwMq2++JhvLeuKaUI6NUqch27VLOJJ5udGCQQVFX5QlVdp?=
 =?us-ascii?Q?sJMPdEeE1iTtri1sl5fq/WlfiaQ0PFaB1Vnwo16OFFBJfzyar9xB62bLRxo4?=
 =?us-ascii?Q?ppHtjORMT1H0jpJiv06sSDa1MAiwZe/8zi1BZneazROHAMA0186AOtAmT3az?=
 =?us-ascii?Q?oCR6saBg8AqLoBxqYcuFzAQ5CU4v8MYWQhWwkpijTirW+nsSXnDS+/CaNVpT?=
 =?us-ascii?Q?LuPUh1sfl2SyA+mtF4cC+8z5746sqSy7ZKw/LPYMCuu531CqIA+EL64wxa9N?=
 =?us-ascii?Q?hnnhho7RvxbwnGMLNfSYH/oxs9Sv8UUMbYDB8tcomYZx8jLAnrPg0bgzlXNs?=
 =?us-ascii?Q?QdyOxVdilgozt/s/XbsIv1bJ/MiI4x44H/S4zqSEl3I0crsyE2joZk2ZbCsC?=
 =?us-ascii?Q?YtvnXCdRH8O1S3Yg+wcHNdzB+YV/wuXBY+snZIZK62FMlQYwVMMomOIhejwu?=
 =?us-ascii?Q?8h/am/0uqUOsAkz6BlunbywpMVvSd00xlbMUfUUVze3Z7Gh0XFUZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d86eb8-f1c3-4020-4ecd-08de8bb48968
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 03:54:24.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi+MMoQhBg0v3TLAc6MnnWyfn5WTU3WlSupwTJVzgwoRC60k4JLAn8JZzefSxu/iCRm1b8K5OJyYANoVxF4rTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7090

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
pci_epc_ops.count_aux_resources() / pci_epc_ops.get_aux_resources().


Dependencies
============

(1). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
     https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
     Note: already landed in dmaengine/next.


Tested on
=========

v12 re-tested on:

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

(*) Re-tested with v12 only to confirm that no regression was introduced
    in v11->v12. No performance difference is expected.

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
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.809 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.756 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.813 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.974 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.874 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.888 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.878 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=1.11 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.811 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.922 ms


---

Changelog
---------

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

 .../pci/controller/dwc/pcie-designware-ep.c   | 123 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 183 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  83 ++++++++
 include/linux/pci-epc.h                       |  53 +++++
 include/linux/pci-epf.h                       |  31 ++-
 9 files changed, 577 insertions(+), 47 deletions(-)

-- 
2.51.0

