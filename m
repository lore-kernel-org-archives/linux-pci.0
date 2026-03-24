Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020122.outbound.protection.outlook.com [52.101.228.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD73B6BF1;
	Tue, 24 Mar 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341507; cv=fail; b=EuBqR6Jo/XrGGGI33ffjeAqjDSY4/SK13E/hmiNHU1XX/pZJukTbnG55NhjuymeVEnqTwNnrSrXOxkzTvEuxnpm/9CuJ8Ep6VW/HLixvBbf60XDXmKGgbCxbaHejGnPa6n7jOnALp730sn+Vssa5I8h5SQyIsONBpI0DzzNC4iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341507; c=relaxed/simple;
	bh=8dl4FL041erTUAnr6HF6EHHXfJT+D+s2jgH3dvCFJ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bp+YEYKJ2TkBcLNVTTGldrWRjqzbhK6bKWTAn0/Hf+mQ67HANPeRR8NlxhTl367blghF32yE52GpEp4GnQJEK8/8sWIXV2RllQ3jO3RIaC7RlGXottIOZhQoaztJbpVf2u6EPDwvHTEgUpmUjZxU7sKfIYaYSsQnQkm5QtqY7js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Z+DhTJ99; arc=fail smtp.client-ip=52.101.228.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Z+DhTJ99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTJ3K7z8EAY4S3TzNnjjOL0Th/q+S6DtT/QfxlJPtlkFE/L8YZyUD3mjuWI1VyOvtuYIwLgfy1qSsSWU3dp1CBMiz45gVCdjj5N0z/XGhtmrIAam0KILOBLKMh4NNuqAea4AKhbtn51BbRs6Vi6FkMnwoQGqhcFFqnU19XGb4op2MbJBszdpvdZ7Zq0Rc9FpSy6KZiVZpTyi41teCaf5IUHQ5eQxR9Cvs6jl+t/JAQ0cEAV2CVI3XBsnf2bgEz0CIH6Xbc93QnPnBv6c5f4HYLMOQty+EeN9cI43iMpwgQNVU+A7e+etNQZSayMumWnhGfjwOkhKX5Xa7TkpD8ArKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QADjv406FN3GflYDADEkGSJL7lFgFivo+iQ1XfVKbw=;
 b=KftkjMMw2rMbevpYcEtkxNTEeZptPZWWlA0aeLhnRXWjCbAnLYqETFcJioAc5N8o+LyunOgREznR/nXGBGTHXy2lBgZpW8MzqCDD46RZc6tWT1SDKit2R53RRH5o0Aw5LRrUOFKd25Z6JaIYPoyxBIp8GWsqpUWuJtpqvuyzdnsjchmkmJm7INi19ZpC7OAR8GadB20BAb4d1z02naCFPLlIrQw5KIH2Mp4beO+UW9xzm/rgnVm8ZaxEZaPLmy46WoBNGLKFLeNLYafUfdwSESOiKZBLknUUsfcb5uPE1XLmfZZJM2Eqq3M+qmusqLfqw88Z9O3pUzSTBF/OXLDtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QADjv406FN3GflYDADEkGSJL7lFgFivo+iQ1XfVKbw=;
 b=Z+DhTJ99h45XgshXEc711W52bKq4f3n43kupWaxIz67PLKKbQ1xgQnKUvC0XzVGUl+8R26V+bskbPFZpeIdcLWvkJ0FpDjV5MJEhs0y5mbTbDMxO2EvNlIA9Sau0n+vgP0cqv3DX4CiRp5onlDwcAhgcGKB52iXbJ4+tsXWau6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6981.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:38:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:38:16 +0000
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
Subject: [PATCH v11 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Tue, 24 Mar 2026 17:37:21 +0900
Message-ID: <20260324083728.3744734-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f377aca-df6d-439e-9346-08de8980b1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XdUUxdUQEvK1ALTvIaD7TBClphBku2pf2dorhkKUKHtoCDiTWn9TdIuLbdblX5ElkKhb39cC9nuDDrNkKxR7H/zQgU+x/Pig0DBryZ6FzDwbsfD8eixV3tXjZipc47Vz58d/Datp7YYDKNRPyjr8xoL2ZOjquWydo01dpMNs/lUYN6uOtPUgwFNcsZMbdhR5xQT5prZOv1ZnTcOdyJsMX8unXGbl01BES6bP2OHrAZvtQE+Kek+I3qy1BYq07vCRg+E9wbLTMjkxHVf/o2+I5vZuIZP4upQPMRcw8s4JO5y3uYn531k/kfiibJfHNgW5Ya8a+VRxWPvU0PMyBN7qptEco48WsP6ezTScC7gqqcTjMNTiHaFCsCNdV/ElZ7sMnicpy/Nhr+cr838DUzXDQvCTv1eTr7H0+wXE7r2WzhKr2xQDa1fDiGGRiCwlJrc1fc+Vag+f9GBWybbaXdz3Zls8oS6hfzXo3423kMGtnoZwjhp3P/JWU3FNIk6BmTgC5bYkLjTidG89sTF2cSF65YspCUc4cCefzrPF26Zb4GrY3juaQfd04fHPllbYoSGpYbdSvt/uR0urzp7iuTmWKA+rfLy3NLB5c4eqJrIKYUn3bNwlvl3V4VsIXjpFJkrsx6fSFz/sK4Y8LyqxxD6z4q/1KtcxgJNPRQSijwUl+FJ++OmuhJYI1MKiDLCCKauDhWC6LfjZUQuUpWbhrqprwFqDmTZKSoIggblCqHiEGHeNeqbZ13o2CNwe60GXrLHJNr1Cb5zvq5vxJoBgUYTzSpU0AMCqc90vzA3nneIpS7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ruXoNXMStZI8NezajkcMcDhE0NzMSv1Ll3q3LuAtuQo0HN+tXxQh9rIU7SmX?=
 =?us-ascii?Q?eZYbt/ZfyZ/TccM3YdaIZg40L5s9dTIPLclkVC5PwFgThnrV3Zbc4zx2xLcx?=
 =?us-ascii?Q?KfSm3N7ki0SGywYyAXxbY2NeleGdBnir4q+ZRiU95jtuDbC+V0QsqwMlPsJT?=
 =?us-ascii?Q?AATBMJR6x2AUbqDKxfIjkCQTQPi0vmHVIXTb1M8I74Y1tayK8mvji0Uh43pj?=
 =?us-ascii?Q?8pu4H08HR8PGhbTLMAmzOv0A0audxbsc7wihlSO218P6LaLwHNnI53+seKUP?=
 =?us-ascii?Q?tMEJtHD7R2IFUa5WINHVa+j+5/ZV1M5hJNcFlnOe5S/Xmz6aJmmsFV6Go63B?=
 =?us-ascii?Q?sqL4DywVL+18OZzKttoVXOzBlXvk8gFkMoyLKQj1N/mEEGSEUNGF4De0Nn9O?=
 =?us-ascii?Q?Z9n66gsMaTc3uxo4dNmYXSsVR5OXr0Yoqc/8nvBRXC0qqMyzlnBQGgZZvzc9?=
 =?us-ascii?Q?6np5WOEN98gZ6mpXq8j+FhV1VS982/H+PJEOa4ub53NFZn+es/EAWMhsBXWq?=
 =?us-ascii?Q?+0HuFKwfNrKcMedrbzLsTffGEhY31Fjge5iccZhRGpY7au0HislqShtpuJqJ?=
 =?us-ascii?Q?ChxyyXsaLyR39EMqmoJ9r9jrHoQUqHXobfTdGehIcYfxfciCUWNZd6URYLLN?=
 =?us-ascii?Q?1o4y4ubXEELkOP89CcmQE0fcxXm3g6kuGt1wAcG5gPNuRLEWNUZZiYiejE2A?=
 =?us-ascii?Q?WzaTweeN56Xan3CRrNnzRdAZM2ioF2imw37+n0aX/YS9DGx7SdRg/t9BmUxm?=
 =?us-ascii?Q?cICdd9T9uciJTQGqkwcaw0YDemyFfEPqbJnvYQQ2r2y3VIjrE5GHUZEDBoV8?=
 =?us-ascii?Q?ONMom+WXz8WBk37pKmqCZrqA2Ecarv32e2sdnHYXFh2LDA7XXTEpuNatEhtb?=
 =?us-ascii?Q?euwR/mq0XiW5LhBYIlfwX4cCzo8l3KdE8Imr/VveUM6BszNBMPmrBLAKH3FF?=
 =?us-ascii?Q?K5vqarRHiiDpcPU6GlYyY/9Fadl3CGe/g1OeTEERAduMsQKoaxIBAsSdoosu?=
 =?us-ascii?Q?tm6sVX6Hrejxp2syJf/G/kfyUzEbR4hdwrxWX67nuJxjtOsZARhBiPVLYJAx?=
 =?us-ascii?Q?kU2qpY8rB2iptBlV8EenBuu03ZsxkOxBR+pQSKwBPrlE0mTEmD4FmdSgLjQD?=
 =?us-ascii?Q?hGFIhKPJ3GUSbZy2WlhvZ8fX0T7SogaCYlfLKgmskvHg+SR8Kzf/Vvw2xyBZ?=
 =?us-ascii?Q?BU6cwnBV3u5eIUxNLV2bLVlD/PkmWwxDqbcwXTlUN/LSNIVrlneof4LOtgSP?=
 =?us-ascii?Q?KSlah/i808iw5p/ZEiuhd8lmKkoWbnIDOjMfV/YtJRfwNkiE1uXT2l5DkKKo?=
 =?us-ascii?Q?uRK7+K/kYnjY9/zfjX+Q516zUxfZsQBwhrJjfa1419MDMbNz53QSGHNgz6gg?=
 =?us-ascii?Q?VKZHLC+Ej0VMksMwuC3lPt/yMNsLg++a+9Rz0vuD8QF2rzsZlGwSw4QztL41?=
 =?us-ascii?Q?45a/TEtuU/cJXZqcRsOrKHmiSET67NkewZaEg12wQzt1KFsN6r54M+sjpC5b?=
 =?us-ascii?Q?epmZ09mftty88Y13c16dmg7jYpVpO1ICNhLrP2rj2m67LfGCC4NdM2OEpNT1?=
 =?us-ascii?Q?qKWSU4sTnjyCkZRoCKtYkhq35G3HmjcNQkqzwWs1diw8ajSw1ErAiM/K13WU?=
 =?us-ascii?Q?/9CTf4R8KP/obMQRPIpqRWD5XVWoNkjXyQhVBob4gm88JSUJ0a2HJmYpkEgk?=
 =?us-ascii?Q?AS+99PfIGp+ob8flltVNMvlvxZoCPKm+4m6Z/jD3UBNzEKe2KfYrAbo3j7A/?=
 =?us-ascii?Q?ATrZk1os9vpd4xk/4jwlw3vQObxmUQ0Cc/1wLSRM/UoWSjmEUdlx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f377aca-df6d-439e-9346-08de8980b1b9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:38:16.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlYcJiEwoJroI5A8oM9AQGPEoPGCCBtgC097wQ+jic2VluPR3mFcuuETqZE4bP3UumMDjxOE5GVe+erlsxsNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6981

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


Dependencies
============

(1). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
     https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/
     Note: already landed in dmaengine/next.


Tested on
=========

v11 re-tested on:

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

(*) Re-tested with v11 only to confirm that no regression was introduced
    in v10->v11. No performance difference is expected.

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
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.703 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.654 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.793 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.812 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.815 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.796 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.804 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.873 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.904 ms


---

Changelog
---------

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

 .../pci/controller/dwc/pcie-designware-ep.c   | 106 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 +++++---
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  61 +++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 187 ++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 ++++
 include/linux/pci-epc.h                       |  48 +++++
 include/linux/pci-epf.h                       |  31 ++-
 9 files changed, 517 insertions(+), 47 deletions(-)

-- 
2.51.0

