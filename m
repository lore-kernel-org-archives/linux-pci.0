Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA18632A;
	Sun, 15 Feb 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173547; cv=fail; b=F59DLtJbQQ3oHF3VOhC2dYYGfSEGBZk3sUO82UNabaYfZopnqIxsv3ELKddvD4wGX+zq5kTMCcTCq/CjyxcdgHyPqrtlxt0nMwQHEMxeQIfy9ToVyUgzw3sPU/Fox4qcVj9AXucv9ASnGqGyH5QmrK/lKsdvw972YryZ4LCNth8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173547; c=relaxed/simple;
	bh=KiIQ09hgG+7Jy3L+W/16DWxZh7Cfx2oH5SI4/VqNkXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XlMjHSuJngHYcgcpybne9pRUelIL8/wFzUiB+CUsWg0nEMv6/FKAdYp4CAAdiL5tkUZ76/MOqnWFRttpKFsuE/HoonqHIqA9DbNFo8DPfcVJm4h+WhUjAXLfnJZpcTAokB8LRuwBi1tFy2imsrijvYXCQbgUVDPsMvsa0wYix9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wf78mclu; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wf78mclu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5zLLnaWZcCpf2hZ5vDOUzZSFhLCOwr++hVzJZ9jbefDEgXQ4NhkmP+dVZaUVIq/gl0CjOKmJJ/Q3+M6L0ERDpKmLzhMSmGagJcbhQXe7koq+Pf8ZLvfrp+WyawNSdvLVus8Aam7lTAwHIrXl8FcbE6ZD41HP13rJ0yj+bJjpWDbH6pgYke6fmKkUue3VL18Sx9SG/W7DC8F1U5pNSUgVfusz/e4i3osiXF9N0ILKH36cr6qPiW/jJsLMIAPQQFeg5sKTzzxS9ooyxoly0YXIy/Nx0NsnMhKXga11xmgNRmFkQ3sLFPONOytoRA/wtefbsUS53eBFUFxp+KtWyMHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWHWhAJ9gifH95U0c+oOmlJeDjFQvWUJmid79cfGm3g=;
 b=h/hBsBY//dDKUB3quq2zm+D/I5Q+Hj/EYXGeEQO8w2kM1OiMjX9thW6g7It86E/oBDG5w49Sc+va2ifT9FfNAHJguI/1yJydjDD3nTz9cjPJXCAAhDF+dOiOZUrEsf2DG4NAZAwxjvEBZdzEf0cVriGq3eVUP1/2StoN/Wqu2kamvtvlfHXl5iFmJHdl6m24ZY6Yu9Wz2/KeXZf3fFOBU7iiPaSq4+u1Pr0tH2UoykxGrU/NoosdYchS2fhyYslFM3/FD47+diBo49kuCAhtGd4M/AaRz18poRkTmaXjLC7pVWV6mHHQVAbZENXUVVkE0n5OfI7z8MBGVPu9HTmpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWHWhAJ9gifH95U0c+oOmlJeDjFQvWUJmid79cfGm3g=;
 b=wf78mcluCJL+egK1h10oz5XBMqwz6cw1XLaf/agRE+CGNQrPS4h4p5ETG8hYj/XmNW8PCzXz6q7pv5EIzjNSu58D3fAKQ7fKlNYB9fdMIeQjnHLpMaXXCpFmNfnT750T3vtBkcbZu+iHRXG1GEHfrHTelY0MWM3AMjIpfe3eKNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 0/9] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon, 16 Feb 2026 01:38:38 +0900
Message-ID: <20260215163847.3522572-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 66eed5d2-bc80-42eb-69eb-08de6cb0b958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?miUHt8/gSX02uRnhrRZuvsY7WQGrR1IDbeq0mtJ6K1/w5KcYgst0KBHHTqQ6?=
 =?us-ascii?Q?ODOElEQEeUQF2EqgHoO927hfr/5/ofDBqLltmyKMkYnL5Rh5lNHHJ/O6iFvM?=
 =?us-ascii?Q?3xirR5ZEWHJ9DiWj+m4GQRAvxp4jege4jm/aezfH+rAJ6i6pudz9rPHqr7Ky?=
 =?us-ascii?Q?XD1zVnimFaWrmCyDlUFe3xEWrUsLHMOUDrr9GYTLF5pIjjbLgUNAhtxpjvuE?=
 =?us-ascii?Q?LeGAM3on9TlBHmCE9F8cbHBHKacmq+7IGQz/291mdFd4RBye3Jws3C9qu5GP?=
 =?us-ascii?Q?9+wX6g0o+PXGBJIcYGM0aAX7eDrzzWowyNDaRz0FrnvDwG5tyjExJB+iPbl+?=
 =?us-ascii?Q?A/NhqqISRe3UHxQbQYG/DGuU5Cmga2oD3DHGgJhCSH573rEHPPZ2RTDDv7Wf?=
 =?us-ascii?Q?ZIJDyvNsAX18+XYkQVFH/JaE2IKRbntCr2kJcl+eKxxOowYPwShRnA0Kp/Fe?=
 =?us-ascii?Q?4qhQ0bHFwXeIITWBgZX/Hp2k68ux6WU4QUw43hqRzMGys1x6i3o2181RiRDG?=
 =?us-ascii?Q?4v0ohC2q65yPn1C0wCpk/ytrDxJ0rcR/pSO7STT+RSu6I+c58+XUUQMCmRe/?=
 =?us-ascii?Q?wXvmi97QQ2RvxY3sNztxovYkYhjndltgWgzehFhIT3OebVyjFCCeZe/i01p1?=
 =?us-ascii?Q?6PRJ9eTE6rA+AHNaHQ2Bi9xJxFFETIX1LdvW2AawGMKQQQPqluOArPTELbX7?=
 =?us-ascii?Q?D46PS9VHcZrDOa7YdDHpSvk3pBgPQkikRf5G428OaqpyEhwqziKGLvkyqBJx?=
 =?us-ascii?Q?Aj2D7QJ39yzUDULOuu30VLorOcyjE4livBojxiXZpaKJ5MTpoulq2PS7Det3?=
 =?us-ascii?Q?jUetz7OdHa3rk2wvWFUQtUF8ZxK/67lSVzlXwAA3DhN2lVySsYawhBzQUGOh?=
 =?us-ascii?Q?AuCbvJqs7cSoYAv65S9swIXYYbBCA6ZNMF15RqoQZGMiX/T5E3inmY7Y1tzW?=
 =?us-ascii?Q?F5j97s6K2pT+8h7lhQUt/JGSK1UWKo/v6+w9BsT6KpVPzxSH6twonDDyWgvt?=
 =?us-ascii?Q?3DUc0/ybWM1rysGe8RA4T5kRA/IzTZVkwpMBny+RTBDGDbWbrTNjZ4A6Yr6g?=
 =?us-ascii?Q?WnaENJPvoxQY7QZ6lGuI6cetJuOdXsw61xQ4ueMGm6uvmibFUcL5/CcrVy5o?=
 =?us-ascii?Q?jmVO2K/S1K8Ab+4B7Tfjvw7ut4GWGryfc5nXZSU8qxURKdYFcI9b2ciZRRV3?=
 =?us-ascii?Q?OLm63RCCAKC5OqVizz8wqjhLnmWl+fOOfAbkgKGO/uC7RUb2auDNYaeLN4S0?=
 =?us-ascii?Q?yx39vkEl852JkKf9yy1F+mGjCUs21kqGYMIhYAibnjyevZH7wW64bnKYlYZ0?=
 =?us-ascii?Q?pwgxAsomafwEy5U+t7dLSnNeDqMTuUZygRaaxs7mUkmIr+6F1P5n0YhGxE2Z?=
 =?us-ascii?Q?ST97lCYh2KvEkOCd+0KM3u7jp5E0YFlvQBnCspXOl2YOxVzr2H8nP+BsVUaM?=
 =?us-ascii?Q?IijIk/aYSiYQ5AyCrvXRGluTxRohus++Crnb8afejipwE28K80kogf9zOu10?=
 =?us-ascii?Q?B+i065M92P18ReakE8HK1pVx+eiquXiBGFvHtR/KSoL/aGp5Dvi4HLOe63qt?=
 =?us-ascii?Q?e46TQk7rj94hinKs9kH6tXxwoysV/c7Jj/Cz2Ziw2T4no7FjHyPsKhZl5R5s?=
 =?us-ascii?Q?d1q9peIKvYIYIrP3TkLLH+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waItBHgtVrmBdpepouqGV01kq/shwxPuzRfzIlYWeAfp0EUIx+3VKF5M7ZB4?=
 =?us-ascii?Q?3ecGSoum9WTOI6r4T8/9xcaHlw2NwAoufu43yrY5aDsG6SgBlWBtm5wE1sJh?=
 =?us-ascii?Q?eP5m3zVDHBpNaSIqKGdsBG5lXzHXAioVEZeZOnXT1Yy9TfG4x3MUp7QoXJPr?=
 =?us-ascii?Q?wbG6G9ultrLMvp154QVJgJIYPOnCzgheieu4FEfLf0ZDGxNk4GNvhfDdBsJq?=
 =?us-ascii?Q?bA2IF2hezbgY5qK1oVz0zLWmg4CjSsOJYES23+3RsphyJDH2uSa8ZL01Dhml?=
 =?us-ascii?Q?i/0p5fHOR/VuDoDyqN+y0b/PUO7hWy7GKpZ8WbtzxEMXaSVWSkurCjKbv9Ky?=
 =?us-ascii?Q?Kk2PeLytwYhNW//fq1LWqxlGVclbpDJ6gmYBIxu/ZHWO/GAGEc3VYgY0nHhL?=
 =?us-ascii?Q?yahc2HI4NMlfnmrnZ15T6D8H71Ig5KFZe+UJs43fYtUDeQHxlxs+ZvGNIdzW?=
 =?us-ascii?Q?zJz0tVsccgHB8k69q0JTfOucFuG++PYi+VHN00jew/VBw+NRLv5XKiR7NB3d?=
 =?us-ascii?Q?oz3U0QPypfCDRMGU11k//34kNmgxqyGDzBw8reWIBMm1sGpAWklPA8cENxUV?=
 =?us-ascii?Q?hyMDtDKTLHA/ObZXUA58WHUx7MIKfCLMZkAKu4h6g6KX/VW+SsDG1E+KwFdY?=
 =?us-ascii?Q?aTDYxIgFodJd85kAWm8/8HsHflXZ6PjoVCVL5SBz2V/EmjNPGi69ZHHn7xah?=
 =?us-ascii?Q?CRHurSilXRBCUNbsp/ruqVfWaA5ZHigXX8u7bXYduosW39m3ffJDW3LlVrIG?=
 =?us-ascii?Q?27Witibbjwkg9nhBmhgj829+l4EIvXCQ/1GjUfAMkdYuSenLuoG4UcGWIQRt?=
 =?us-ascii?Q?nCYWdEn0HwPXU9F8pk/mIxh5uctYW+4VaO/cvOatfH/cc0QltOghOrYVZL8H?=
 =?us-ascii?Q?KzO+bS+MnmCmqsSKMooD4iPh9uadxNb2XCbjQX1HUJB0GQjDUbrHL3itiNwT?=
 =?us-ascii?Q?TNMHKTcNnnMN/+4FBg28bxkzXyZBfHVOAgBjFdFI9xVSw3yGi/5xUek1RKza?=
 =?us-ascii?Q?aJsVxsw6YI8ZjkyJ0lp1OGMddjA3rwjdwZcpesbWLNJU1sPK6AOf+MTrH48T?=
 =?us-ascii?Q?ntNClAg7/HgappGJpd5iSBtJqr/oHOBLDCWI1jLSHsPDbiGNuDXFE/7oZKjE?=
 =?us-ascii?Q?0VjRIqfibrtZFDspBigAKuonkXQWn3XEq8zIgBrlXi0OzMBKjMixPCPjDvCt?=
 =?us-ascii?Q?wMj+EZn5fEVwyPrhVmXIzh68n3ZLjRZRRvyD0SoSX4Amo6nMrL1MxfFgs7fE?=
 =?us-ascii?Q?PnJRG7bCj1YkwC6EYbaR3PnBUhrNWZ9qoKPy5bigpU3FZkXx/aSwdtDrwiEO?=
 =?us-ascii?Q?kUmlgJ803aD6LG7pQTZ2xQ5JTxZanOEF6czAM5KTnupHYhmrP/PzOOkTfc/s?=
 =?us-ascii?Q?NsGuo6SgZf1aYP6xuweytkL/+uYWkL15gMhUwUr6ak8n2TcaLWCN5c6DQzxM?=
 =?us-ascii?Q?W89WkWKsBeN1fz/l6Vi363Y+yieUidoR8/ZtyQcWt64YUnVGz21XLaM5iUO2?=
 =?us-ascii?Q?XKyBzQtr7ZhXgsD1EZ/rB2u+lpVVJKxmQ1rrgf9gRAm3i067PlDMdvnWmhdH?=
 =?us-ascii?Q?Kh+FegYN0jKAmZcVCxyoOAw0PeidON4H2AP72RWfVk8oQU1q2B37nhyIM5+W?=
 =?us-ascii?Q?bJtwzu32yEoIgWalK358xcLlPcfRq6m8GSmy6ddhdqgy0E3+bWXWLy1INaXH?=
 =?us-ascii?Q?rfgUAtsYikiBXtF8riKQOwRGFTd5piViQT0jsak2baTTBKUdfermqMBv1c6o?=
 =?us-ascii?Q?SquU8CEkPiHjVdKjXkcVwAiF1AJmaReUu66TCSPDF78cFiotgJUM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eed5d2-bc80-42eb-69eb-08de6cb0b958
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:01.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP2n7ULJ2d68cldMWiDtAl+QTEjJ90WjzQpARm4044TzcVaK57IIydm49Nm7vsFqgQWmB/joKgKWt01ZqNzalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

Hi,

Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
EP-side doorbells. In those cases, endpoint function (EPF) drivers
cannot provide a doorbell to the root complex (RC), and features such as
vNTB may fall back to polling with significantly higher latency.

This series adds an alternate doorbell backend based on the DesignWare
PCIe controller's integrated eDMA interrupt-emulation feature. The RC
rings the doorbell by doing a single 32-bit MMIO write to an eDMA
doorbell location exposed in a BAR window. The EP side receives a Linux
IRQ that EPF drivers can use as a doorbell interrupt, without relying on
MSI message writes reaching the ITS.

To support this, the series:

  - Adds an EPC auxiliary resource query API so EPF drivers can discover
    controller-integrated resources (DMA MMIO, doorbell MMIO, and DMA LL
    memory).
  - Updates DesignWare EP controllers to report integrated eDMA
    resources via the new API.
  - Updates dw-edma to provide a dedicated virtual IRQ for interrupt
    emulation and to perform the core-specific deassert sequence.
  - Describes an RK3588 BAR4 reserved subregion so EPF drivers can reuse
    a platform-owned fixed BAR mapping for the doorbell target.
  - Updates pci-epf-test and pci-epf-vntb to reuse a pre-exposed
    BAR/offset and to honor per-doorbell IRQ flags.


Dependencies
------------

The following two split-out series are prerequisite for this series:

  (1). [PATCH 0/4] PCI: endpoint: Doorbell-related fixes
       https://lore.kernel.org/linux-pci/20260215150914.3392479-1-den@valinux.co.jp/
  (2). [PATCH 0/2] dmaengine: dw-edma: Interrupt-emulation doorbell support
       https://lore.kernel.org/dmaengine/20260215152216.3393561-1-den@valinux.co.jp/


Tested on
---------

I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
R-Car Spider boards:

  $ ./pci_endpoint_test -t DOORBELL_TEST
  TAP version 13
  1..1
  # Starting 1 tests from 1 test cases.
  #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
  #            OK  pcie_ep_doorbell.DOORBELL_TEST
  ok 1 pcie_ep_doorbell.DOORBELL_TEST
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

with the following message observed on the EP side:

  [  109.470756] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
  [  109.471302] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback

(Note: for the test to pass on R-Car Spider, one of the following was required:
 - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
 - apply https://lore.kernel.org/linux-pci/20260210160315.2272930-1-den@valinux.co.jp/)


Performance test: vNTB ping latency
-----------------------------------

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

  - Without this series (pci.git main)

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=6.04 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=12.6 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=7.40 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=5.38 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=11.4 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=9.42 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=3.36 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=9.48 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=4.24 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=10.4 ms

  - With this series (on top of pci.git main + Dependency (1) and (2))

    $ ping -c 10 10.0.0.11
    PING 10.0.0.11 (10.0.0.11) 56(84) bytes of data.
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=0.623 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=0.603 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.772 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.769 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=0.686 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.785 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.789 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.694 ms
    64 bytes from 10.0.0.11: icmp_seq=9 ttl=64 time=0.678 ms
    64 bytes from 10.0.0.11: icmp_seq=10 ttl=64 time=0.773 ms


Changelog
---------

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

v6: https://lore.kernel.org/all/20260209125316.2132589-1-den@valinux.co.jp/
v5: https://lore.kernel.org/all/20260209062952.2049053-1-den@valinux.co.jp/
v4: https://lore.kernel.org/all/20260206172646.1556847-1-den@valinux.co.jp/
v3: https://lore.kernel.org/all/20260204145440.950609-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260127033420.3460579-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
    +
    https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/


Thanks for reviewing.

Many thanks to Frank and Niklas for the continued review and
constructive feedback throughout the development of this series.


Koichiro Den (9):
  PCI: endpoint: Describe reserved subregions within BARs
  PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
  PCI: endpoint: Add auxiliary resource query API
  PCI: dwc: Record integrated eDMA register window
  PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource
    API
  PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new
    backends
  PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
  PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
  PCI: endpoint: pci-ep-msi: Add embedded eDMA doorbell fallback

 .../pci/controller/dwc/pcie-designware-ep.c   | 149 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  15 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  84 ++++++----
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  57 ++++++-
 drivers/pci/endpoint/pci-ep-msi.c             | 143 +++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           |  41 +++++
 include/linux/pci-epc.h                       |  79 ++++++++++
 include/linux/pci-epf.h                       |  23 ++-
 10 files changed, 548 insertions(+), 49 deletions(-)

-- 
2.51.0

