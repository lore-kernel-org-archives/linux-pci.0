Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598142C4E4;
	Mon,  3 Aug 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780287; cv=fail; b=OhgAqV0KAaT1MnDBmiq7hYbrCjY0dzgAXVtJtKkcCQDPW5N5cQthgui6QzFPPWtFH2GoKSraJxZQb1NzZ0terMVESadyOWQc7EH93h2X4xECX4ILjVzFerXQ2tvENDfyAlymfRgsAn7uKZuv41JPQJZE266ATDXrA8I56okJAWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780287; c=relaxed/simple;
	bh=PbtWKLeg+8DrJkrINMLuLUpMyJl2eb7dq7XvMIH3ayM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K2hlm6xh63kjqsYHhAB9PcSSb9aMYWbs4CivEipcvvaQF+HlI9foJNX+pK8Uh5X+tUjNGtGahxX9oGzOYLUeHnToz6ACyPgob5gMIQVvYhVgj4Cmz2YdbSVdBFlXITzG9+KVjJR8vOBjWfzT1obfcc3odVHPgpXbStXbj9fTl4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dEzzwEOY; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dEzzwEOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlAirIEVcE+vMlNXNwHEYonpokVuK+DFNLegnRVaVFa7Yzf4kZCAASbFRzCkdmKmAt5ZL2OqChAy7Ll7Hn3Qzho3iBjqTLCSLWqM/Q/ie96lk/7GCIPUMse5EsZRdAWykLj6EbSJ8cXI93Jli0uLLG4bxyYZ3bD1h1WZ5LKUG6sMj/4n7CUCQVlqgMTXBGTlPo64dHjkXBp6nQxPGU3jmlOz/w2peSCZpExCJqmGJkdWOuMiXC+M33H3kh9wqXumkbnZnWH0aRCrbcbJoTGi3VjKqKlB4NsXfSp7sx1hV+yQioJsB0G/1fxMmy8Bawvi60+kpcbIjbKzJ1PCGUpHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD4K/4LoaK4m2d7Wn8nubJa+dPg4bslaplw8rFOxsyc=;
 b=I1+Ewp9Urf7tiWAv816RQk7F+glRgFREvEjQiZwKLH0CYijXQYJgcyVcC4oX6LhXASzQSrBdW4myUWO1BYwh02RkLdRa04+QTBd07/OemZvI2Ro54G5mDw2jpZOW8IIF+m7j3gQKotMwRwkSWh2ShYhIbmxWI6tWf/GJBQAA9Lg5m7evHkr/hgm/6wdrjrLq0JVwpmJ8wq7X5bSRSiIGd2ObRBWR4iZ1XEIL71jh43h8zVXZzb6i7KUA2sbOKXLtcRQuQ+GyKc5c9cFH5ypLu4DNfjsQGLukY2ay+WwefY5mBSxWZqcxwM8MCBPXNs/45OOGb3ejGc2crodndjhwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD4K/4LoaK4m2d7Wn8nubJa+dPg4bslaplw8rFOxsyc=;
 b=dEzzwEOY3Gjy0xMihlCskhsC9paclBwSKG3CnvwHGGF8Dov7GnXH3fHUfHn90Ugz/Z7yolFDISLkK4s0eT3LBmjZ9wo6k80RveW4RtXqtdUDeCivxo4ABBXDEo0Cl+2OYfxFq+YUpelkmFVL+yOaJacXzCDvj/giKLS/LfTz8m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 00/11] PCI/NTB: endpoint: packed vNTB memory windows
Date: Tue,  4 Aug 2026 03:04:27 +0900
Message-ID: <20260803180439.1963864-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e992d0-9dcc-40a0-bba3-08def189b0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|6133799003|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	14dKyfZ29FjTt6C0e344m36ah7KhBqplcgbbfspwhxOKwJiDtcYzIPPdyQn8yftJ9xXloArXQi0euV5dU4rEJs7NTzwkFNv7G2GcLQcWSFvIJXnASSNwADmNY0ozpZ5V8ZEwamNwoeFCO63XHbdLpWEErwdfClkQBxeF83R0ZyPPzwPFZ129y3mJbRWuzRymLHZ4T6GPQIEgLwareWabn+5x1GohDXn1GUaFOncUZYwtFFezl5MM/HWbxJxoZTgwev4UwcDinSO9qV8vlscCw+9QrVbs7Mnsp6CIb2QEU3w0DmkfCLk/1o+2FGb89WxWj9wtyERFyXMlOtI7FFYoKEgddDj5j/cjkjImiA4DxaB9UDb5QCZfGbJdFmq/WBL8bu/0OH/SI5DeLOJ9ylg792K3wIcJHZQg3UTkRaco2SuARN6K6LQXPO8ahSCQvnrLISWPLWYS/CYr2oCjVUix+o4HRNHNJDAw4v5j4Gc9mEPXpTiZ1+KbgTNRBL69sM+mFOYHlgPBqXTtMvMyU7OTN/gRdmql9H5gFD6TTp+Gff2aA3YMvk1Gvby4D9e25o8UOgvwB/ku4OnoeVkAMxRgv90yy+4P18vhpgL7NLus9J2jVUucVqGyq5orSD17AGnsMDx0pA+rVhaomqDnSUeaiMwaQju/X9+YQcPcUBHJtfDVbkCd/qBGqF3RwOHGlAzuTKhpUoui9JXsGdYg2LtofQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nozayg4Yh+SZ0B1Y2oTQBNsNMq3/J6BN3k8/8TQnlrLOUXc21qA4S8wxNh0j?=
 =?us-ascii?Q?Aus76gklmMJU22YRc/Jm9ax5VzscMGv2jFdkEiFmgOXnTeQkn5ZZVv/LthyU?=
 =?us-ascii?Q?3PHO+7OvT7kH7AdPGYvGs90AHfCCHPioEDPWd4c0z+cZyxz6/wZQEo4r897N?=
 =?us-ascii?Q?sxxA4+nXJnxEQJznUJlaFu3TB4LPqQ3U9o8o4t1+aSHpXBABDgC5FhzOxTQn?=
 =?us-ascii?Q?bLUYfTMefXbnOYYdnfOH+sfpMZUW/lfWnX3xzvynNW29cX0luin6uAnlz+KE?=
 =?us-ascii?Q?yGp9ueaKjQs6nm2zWnB3Wlb4o7Z48dM9UHyOf3EUDgo/q8SGZx31aq1bhF7l?=
 =?us-ascii?Q?KxwtV/HqZXT9soteiDA/gWCJkERZdn+Q0AQP3a1WHIsvel0uppUnaRMDprIF?=
 =?us-ascii?Q?eWNAF56yBP6t8JCP2MyIhyTT/3OCrl1jTdZI8CDedlY5GV24EV0g767cCdWs?=
 =?us-ascii?Q?3o2ViAuopfHTG7ih/GpFQEBwzumoqMUqNsE5bmzbbt3ezVFifKnlOxMnHqzY?=
 =?us-ascii?Q?uWLSENUSY/TkuOxHNQamFIF+4pY8rb2Kl/ZqmAkKJcgK0vY1h7d5rispc9+j?=
 =?us-ascii?Q?UofpibfTa+VYwvPB7/s5zv2OwSUL/a8+HFh94fiKDQjccKMOPLCDrDI7LHLm?=
 =?us-ascii?Q?7pjM8wWnkWboQ41pp4WAwufCPZvj+fggKAJoz/OHpNEHC4EZ3+FbNm7QlqME?=
 =?us-ascii?Q?9/nu9UuKfOyqYrP+Q02CW/dzpvAB5+nG5CudbwRQh1Axzlm1RgmlhgjDlOte?=
 =?us-ascii?Q?KrcUd9MYOa8Za/rtCrRtwp0WQFwe3jBoVoiK0mpAV6dTtXgIjnBEDO8awghC?=
 =?us-ascii?Q?u7/MiqiXhxWdLWU7S7MhMmoACbAL7KPIvVj1sgByhCMVYmXjqwjqTA20ADy7?=
 =?us-ascii?Q?FZVDs7zXjOOwM8cYKM6KBMgEB52jnfrPLIZ37+r7l9ji3vvxJtJoo/BAdHIN?=
 =?us-ascii?Q?HXQDa+Zz5i0ajp39uBRyxBi07X4x13W4GwdatJpDxUPNQicRjs4rhaWoAMRT?=
 =?us-ascii?Q?krHVRr5Jw3DGImkOD907AEhvA3qUBk3O9ASNS+/CEjSxvW4lPshP1SGU5Zal?=
 =?us-ascii?Q?3HcBwgUTIObHcS/3AxTLu7Twe9hLUAWlOA0yX33Q4/M46/mv2N90Ws4z8LRS?=
 =?us-ascii?Q?+3NXVzE/JfffpeC+Tc4Kuj3/CcSSAbcLS4evRUgGYsUG6AAFMCL0vNO8rXVF?=
 =?us-ascii?Q?esvoOyULgSOKus/54vMYq9wfbDqqlYYUnigYVBDcbAk5edv/kS1ZmdFqyjk7?=
 =?us-ascii?Q?KNmknouBP6zTTV9Ld8QfY6DYLgXHuXi2VFTTkTmvmsFFSIKztFyTh5UvYkOe?=
 =?us-ascii?Q?KsElYGTw/qjWWUH6aAc028qoNPiHZ7bVgwfJKLo0AP9ZJkydg24H1W1ZVdc7?=
 =?us-ascii?Q?LNx8ZSmyknxMDsjyOjh9VGjxomekCSLmaxHy3Fet7orBkEcsgAg7nSkMML7/?=
 =?us-ascii?Q?LcLk8HFoxQ+bwnvW+hCbGrSB2Ih4RW5wHkdVCEMPR3sx0tAoKHnTgqKYs2j4?=
 =?us-ascii?Q?UF7/4J+5kyWXtS9AHODniDWmuTclGBzvKB17QVQ3xKxlbyWVQUeN69MsvqAq?=
 =?us-ascii?Q?Kvay+HHpDzLxmp1esHsdrSoLuWgHUAtw9lp/1Eeifk2xfJSH0hMe5W8OnUN8?=
 =?us-ascii?Q?4jhsjvJ0yUEyBLkfI3hE+eXKDiJQjzqVlt8ut74xLqzZ+H19bmG6vf3bkCPU?=
 =?us-ascii?Q?M/QfjXmD00H8PcjQOZD202GTSKgSCG8VHU84IzcC9Q8aMeiT29vFgMhSxRE9?=
 =?us-ascii?Q?RJJIsiFYocJcRVaaEv2uNoitl8hT05TdZZ+0DG9ahsiE5QjaDq1J?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e992d0-9dcc-40a0-bba3-08def189b0d7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:41.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGdBaITQ5n0jubxxl/9A65xm7PZUE/mhgRfem28nZzEXKR5NZ8Ndvhtqd0cSxXmQX3264NW7MHErb4PiomUBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

Hi,

vNTB currently spends one BAR per MW. BAR count therefore limits the
number of MWs, even when one BAR has room for several. A large BAR,
especially a Resizable BAR, can instead be split into logical MWs and
leave more BARs for config and doorbells.

This series adds packed_mws, which exposes up to 16 equal-sized logical
MWs in one BAR. ntb_transport uses the new group operations to configure
them atomically.

The immediate use case is increasing the number of ntb_transport queues.
The resulting performance gain is shown in the Testing section.

Based on the latest pci/endpoint.


Why not BAR subrange mappings?
==============================

An earlier proposal used mwN_offset and BAR subrange mappings to place
independently backed MWs in one BAR:

  https://lore.kernel.org/r/20260312165005.1148676-11-den@valinux.co.jp/

BAR subrange mapping is currently implemented only by DWC, and that
design still needs one hardware mapping per MW in each direction. This
series instead requires one contiguous backing range and maps the whole
group once in each direction. The initial implementation intentionally
trades arbitrary MW placement for a constant mapping count as the MW
count grows. More flexible layouts can be added when a concrete use
case requires them.


Testing
=======

The packed data path was tested with ntb_transport and ntb_netdev. An
`iperf3 -ub0 -l 65482 -P 2` UDP saturation run produced the following
results when only one Resizable BAR was available for MWs:

  Configuration                                   Receiver throughput
  ----------------------------------------------  -------------------
  num_mws=1, packed_mws unset (default 0)         607 Mbits/sec
  num_mws=2, packed_mws=2, combined channels=2    1.19 Gbits/sec

Meanwhile, I realized that the in-tree ntb_test.sh does not fully pass
with the pci-epf-vntb/ntb_hw_epf setup on the base tree. I had to apply
a separate collection of local PCI endpoint and NTB fixes before this
setup could be used for regression testing. These fixes address
pre-existing issues and are not prerequisites of the packed MW
implementation.

With packed_mws unset and ntb_msi_tests disabled, ntb_test.sh reported
the same pass/unsupported results before and after this series. One run
follows:

  $ sudo ./ntb_test.sh -r ${EP} -m 1048576 -p 28 0000:01:00.0 0001:10:00.0
  Starting ntb_tool tests...
  Running port tests on: 0000:01:00.0 / 0001:10:00.0
  Local port 0 with index 0 on remote host
  Peer port 0 with index 0 on local host
    Passed
  Running link tests on: 0000:01:00.0 / 0001:10:00.0
    Passed
  Running link tests on: 0001:10:00.0 / 0000:01:00.0
    Passed
  Running db tests on: 0000:01:00.0 / 0001:10:00.0
    Passed
  Running db tests on: 0001:10:00.0 / 0000:01:00.0
    Passed
  Running spad tests on: 0000:01:00.0 / 0001:10:00.0
    Passed
  Running spad tests on: 0001:10:00.0 / 0000:01:00.0
    Passed
  Running msg tests on: 0000:01:00.0 / 0001:10:00.0
    Unsupported
  Running msg tests on: 0001:10:00.0 / 0000:01:00.0
    Unsupported
  Running mw0 tests on: 0000:01:00.0 /  0001:10:00.0
    Passed
  Running mw0 tests on: 0001:10:00.0 /  0000:01:00.0
    Passed

  Starting ntb_pingpong tests...
  Running ping pong tests on: 0000:01:00.0 / 0001:10:00.0
    Passed

  Starting ntb_perf tests...
  Running local perf test without DMA
        Peer 0 test statistics:
  0: copied 268435456 bytes in 137063 usecs, 1958 MBytes/s
    Passed
  Running remote perf test without DMA
        Peer 0 test statistics:
  0: copied 268435456 bytes in 139188 usecs, 1928 MBytes/s
    Passed

For comparison, the before-series run reported 1997 MBytes/s locally
and 1950 MBytes/s remotely. No obvious regression was seen in this
single-run comparison.


Control layout compatibility
============================

The endpoint selects the control layout. Non-packed pci-epf-vntb keeps
the version 0 layout. packed_mws selects version 1. "Old" and "new"
below mean ntb_hw_epf without and with this series.

  EP configuration  Old ntb_hw_epf            New ntb_hw_epf
  ----------------  ------------------------  ------------------------
  non-packed (v0)   Supported                 Supported
  packed (v1)       Not supported [1]         Supported

[1] The old driver accepts two or four MWs but looks for a separate BAR
    for each MW. It rejects larger MW counts at probe.


Packed MW compatibility with in-tree NTB clients
================================================

The in-tree clients handle a packed MW group as follows:

  Client          Behavior
  --------------  ------------------------------------------------------
  ntb_transport   Uses group operations. Without a singleton MW, MSI
                  mode falls back to doorbells.
  ntb_perf        Rejects a non-singleton MW group at probe.
  ntb_tool        Loads normally. Per-MW inbound translation setup
                  returns -EOPNOTSUPP for a non-singleton group.
                  Doorbell and scratchpad access is unaffected.
  ntb_msi_test    Fails probe unless the MW reserved for MSI is a
                  singleton.
  ntb_pingpong    Does not use MWs and is unaffected.

Further client support can be added separately when needed. A final
singleton MW on another BAR can also be added later if MSI mode is needed
with packed MWs.


Notes
=====

* About pci-epf-ntb:

  pci-epf-ntb remains on the legacy version 0 layout; this series does
  not add version 1 layout support to it. A pci-epf-ntb bridge should
  therefore keep its existing behavior even when its nodes run a mix of
  old and new kernels. I do not have hardware for the pci-epf-ntb bridge
  topology.

* About existing inbound MW clear behavior:

  pci-epf-vntb already leaves the inbound BAR mapping in place when an
  MW translation is cleared. This series keeps that behavior for packed
  MWs. This limitation is independent of packing.

  pci_epc_clear_bar() is not suitable here because it can clear the BAR
  address assigned by the host. An EPF can instead restore a persistent
  fallback mapping with pci_epc_set_bar(), as pci-epf-test does:

    https://lore.kernel.org/r/20250908161942.534799-2-cassel@kernel.org/

  pci-epf-vntb has no such fallback mapping today. Adding one, or an EPC
  operation to unmap only the inbound translation, should be separate
  work.

Best regards,
Koichiro


Koichiro Den (11):
  NTB: Add atomic MW translation group operations
  NTB: epf: Parse a versioned packed MW layout
  PCI: endpoint: pci-epf-vntb: Add packed MW layout handling
  PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks
  PCI: endpoint: pci-epf-vntb: Allocate packed outbound MW space
  PCI: endpoint: pci-epf-vntb: Add outbound MW group commands
  NTB: epf: Implement MW group translation callbacks
  NTB: perf: Reject grouped memory windows
  NTB/msi: Require a singleton memory window
  NTB: ntb_transport: Use atomic MW translation groups
  PCI: endpoint: pci-epf-vntb: Expose packed MWs through configfs

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 143 +++++-
 drivers/ntb/msi.c                             |  19 +-
 drivers/ntb/ntb_transport.c                   | 127 +++++-
 drivers/ntb/test/ntb_perf.c                   |  16 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 423 ++++++++++++++++--
 include/linux/ntb.h                           | 133 +++++-
 7 files changed, 801 insertions(+), 76 deletions(-)

-- 
2.51.0

