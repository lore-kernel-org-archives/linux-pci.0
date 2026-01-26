Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78272C0F68;
	Mon, 26 Jan 2026 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411772; cv=fail; b=YRgqqJe0wXC01yKQcQTE5khB7LnXOF7SbzWmge7yUO+BKrdYLvZSXrpaZjPtD4yF/WfnFI0CxsSl93aT6wD9y0tgA0bcgpLoTnN4AF2ezCE/PI8ZuKABt9LSFOX198wPgYjmk62l4f7Lvi5WfyD031FbcWi4s04hi9ziyuMZx30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411772; c=relaxed/simple;
	bh=hi9RMBGFeGh4C022hzTE+KdXblpNUzcbgRt3jFx+49I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=crL/5t3/T1a6HFl9vuZGFqAz3o3ZFi9nqzSpCoxKckFhCHiD2wrTR3LOQHjZGLUSftnWVdxaCRt2uGVdVCJloSwYnuWtXUcmS646k/IARzVhcaTXhBIvC4kyUSIqvJWR6PDq8Sdzy0p9T4QE8d+/FB3plNcd8MqveYK+RiWVvwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bbtMnbop; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bbtMnbop"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/YDZnE8BRo9SdbnVLLeo+71o7ZRM9VfNkNsLwFGFdXnEylSnA+cSlLAREfyxmxEphyNvWNQIrLqgNOMXL3OhNShSX8rQxpAMjCgitIg3GJyVJPR1X7Bo+qkgfWNqsnvMCw348Lqn0j/4ooXtQVTyEe33FT+Q+5HdJAceL8XoNLFETIlDF7BrKPlBvtTU9OtHsl1DFekhE39T81KKhxQGk3gNIlVmNxwRA4GVxi0sb38yXtpMih8JYXM+IfanX8KXhUurnRBOCyEZoYkAIMowO4fTnh/OrsTb1iW6pscUZ8drxfdUWD5QEiss+gc13w7jUzTF2Bmzx03qQMzgbZ2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHxciGjsmYuHgkhlRNxA2aJWdCGc8bawA70GFw/WL9g=;
 b=E2y7Q4mIvRXhBDJMulatygauF3rdsUPm4QVJOJalvzAZ4hZE4kCS5HqLcp31EHVRp+cF+toYWjCzUP4oW6P8FKBw53XH1QM0zzus8+hROoB+cPZ79i5mwxVncirtr3YEFAPACG+z8Kna9NK7KR8ENvIQNOZwM4en69kfI8tQ4DAo296mxr8fuLdTEtH6XpDiY0SL05H8dJcnKN/kztvo5/q9ciQ2CxxpSqXyi/aiBkOIFMye3TIif9GysH7xEGkJzQbHbU0bi9o5nLJs0W2cI6kAaD/vNv1/YcQh7e148VQg8xDrBiVLKO5h5XqVdysfzoGswgaJX6kAkgbOj787tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHxciGjsmYuHgkhlRNxA2aJWdCGc8bawA70GFw/WL9g=;
 b=bbtMnbop/t/kS6aYfzj57PEUN1Gf8yKUyJCVYKXfAOpFUvcpgvjVgjJMz5hr15R8+JstTxD0x7Fea+T+mM6HkjKRiJQDcutoRqQ8TwurxPysp58ypWHMGMPjt8Xmy41WJoq+uRWTHqKFzta5w/Rf+btDq/juubhxIYR8C/ZhZFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6973.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:16:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:16:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
Date: Mon, 26 Jan 2026 16:15:48 +0900
Message-ID: <20260126071550.3233631-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a6ca5e-7585-416c-fac3-08de5caac2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Abuul9f3EqLjPjRC4YOKYTApjYvGe7ifxJOB9YM02pRir2B8thw3rGWT45dr?=
 =?us-ascii?Q?Gl+s1HXkLJV+JQOgb/tDAh48wtPO9BAjoV/NCcOi8qr4zYRcVIXMl5+KskIn?=
 =?us-ascii?Q?EOpWEAmTCHtjJlgaMug+RZLHCtpm1UO9uQIn3A4MLmViUIl7zPUf56CNXBZv?=
 =?us-ascii?Q?0nKkPMA96UTtqnYpPaF0MQvwBPpp7UeTkpik+K+ILQcD2fXB6Bn+otZpy0BY?=
 =?us-ascii?Q?lxKY+iRxhA1ufNzK+eudZ44HaPQMlVvTqIqisPYlSNhdVWRQC7vtB1z1fFMT?=
 =?us-ascii?Q?Wk93CMzU5uziyfZou+0HTe87iNAmAaGj28Pampq/rfZMxRSerXxSkA13mSvg?=
 =?us-ascii?Q?u6NfOC33Kn56Ls0bhpoSdaUUH+nrLFlYpQa7EmU+48Fx93AnaXBtEBNhlxVt?=
 =?us-ascii?Q?AAn3OwsQ0wmtP8g+acMRlHMvpqpY4g0etbyP675QgmIKAE+G/gF7CAQmaAJ4?=
 =?us-ascii?Q?XAkUxRbuMzhGlKOYOZ8jRO/FNdM1uV812vDQxg9wGbzZv6Uz9aZ0jFU3/BFx?=
 =?us-ascii?Q?aYXBiHDEiksY6L2EpnC7POCOmp9MI2CjmVSwrZXYloZqXtreyIjAoS0ciJoO?=
 =?us-ascii?Q?568N4/It2EL2m2+OouRyV8ov+h3ePvWj3LCWSu3aenTfAGRM3YPtsrhjOtwg?=
 =?us-ascii?Q?HnrMuhNIoe2eJpKuIx4pwjz+Aryjbz9U1qbM03eKzrL8G4n/0PW/aThsZhLa?=
 =?us-ascii?Q?KvOyUrgrGZMjDpjKsN7ovNdPx4065HggVPB3anuLmLCIt9FJ+CaWyVB/YI2h?=
 =?us-ascii?Q?Zr4gUFLV+nVnRjB9SjaNHUQCPe72YYmWP4R6LYlj7/Q6hqLN5FWUq4+m7bPQ?=
 =?us-ascii?Q?8jxJj30M47qlBt2YxK/KAdptJ+f5BDIi0b2YkWvn8PpjRVqW6xYs36LXzX48?=
 =?us-ascii?Q?gq96mkpMATV9ByqxUA3Yq0SyJJz3E5+G3+Rz77Zm8Tr53xMhM+PCaDK8aO4F?=
 =?us-ascii?Q?QX583wAJAldNHYZQ1Sf5hNxxGEI1M7+qQbnoiyJ4uFr+nuQkCF0Opvqpnbph?=
 =?us-ascii?Q?CbZuatE0OnC+YyTTh0Ip++o/787dP+1poWxUJczv9z6Y7tCP5FDIY1guYuJ6?=
 =?us-ascii?Q?ZQlmxcNFf9iqErJa4ZMxJhRvut8tTzSPWaWR8TeG6iPKNfjnAkXKNbeslaSn?=
 =?us-ascii?Q?0ni7u3tu89KriZ3aGXBPuCeMDxGDDi3MkVyUm0bhVBR+Pw5nbjE5PsHoEDQz?=
 =?us-ascii?Q?tfEPQdoDAWc7lbX/yv01rK3GxSi+EYmUVXkSUEwUkgOVroRHBwY7OkP8VROB?=
 =?us-ascii?Q?ee0rRtP5L7Z2hj77tikb+nS8B2Psml0KgYvbe5N69uiOefe2Pq/S4SfvL1vj?=
 =?us-ascii?Q?i3mJ6RT21mSGGhw+FSb42jDJSRihJSa7RRFS7mgQh84ssrVzKkFza8ItuM4x?=
 =?us-ascii?Q?e04nCtdjmh6mf4vva2GOXlPagS7zcz69ZAAzQrpTNeEExLRFZdcuG1mHdCgX?=
 =?us-ascii?Q?a8x0+dl1XUlKKcAFEYhiUPRMnrt6MZGGPC46kViNmu1OaguJypilaTKOmEpz?=
 =?us-ascii?Q?B3n1JEs5BVgIYR2qy/jhCv8P6FeSC42CiTjFWDdPtksFCjzEivGrLwwcO3IJ?=
 =?us-ascii?Q?wjeDWviysz3XoJCw4Wk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9IDxqMSI90OafgjJHFNJUBpFGW1OnwjxigE/CzDu5sh2vr1a1ZiGV2PQp6/?=
 =?us-ascii?Q?k+FpyW0deGT9LBDTXI/kPzfRzA4ldpR0O7jt3OQXzNJ4ZUBGd9wEuyKVoWXa?=
 =?us-ascii?Q?4t1l7STtudvVweo4NbcjFi+uBkdPOiCWyCRteQi48HDAn7li96HYMbJh66gb?=
 =?us-ascii?Q?hggAFZBOU5H2AJVEKLCnyBX5yUy7bFITmQuFMqcJi5KVpTJ49q5iXdJnpdTQ?=
 =?us-ascii?Q?XVoPC/Qvb4anYdlEerCGPLwaB+Swj4bKFy/Sh8eN/rk36/3fipBXXatsbkxz?=
 =?us-ascii?Q?o+eCJv32SrBW6netDQkn/h5X/UmBY8auynQSh9L59QfMX9BzQBo5V3QBkH/o?=
 =?us-ascii?Q?YnACbOEdRlaekjZZEGrWkUt7HimKBKFW4YumKeyTTgZT8Yljj5EC4q2yYBFr?=
 =?us-ascii?Q?rEMUyh+cGFQ18Jr1VwgOYUbZlOliQrVhAlK62dBhvbJr8ADuDkVru0iZ8N5h?=
 =?us-ascii?Q?jUeqJhJYhP9+gBxMwCkqcga8vJnRJcNjkaks9TdbYY4DgUF8nMv/pf4qTEpq?=
 =?us-ascii?Q?mW5jPr3Y/P5mrFm8oBJtDbzBx30hoOM0R45Qn48TbC7N8R+txhcByFDNOUw0?=
 =?us-ascii?Q?2xXUwXl2F+Uq9y9q9HJ82sgmV9u/7zqyeCr1mpynd28dnDXylZd3FAi7MCJq?=
 =?us-ascii?Q?imE23yXrttVQObugUTz7SKChJyozhnl7lKAMeMRqMvZEoo0IRhmZCIi7KVxf?=
 =?us-ascii?Q?aUWW80TvBwBZzdwsRUAunX0nvJQfOmIvpD3vTK51I9JENDsBpFbOgWND2OsU?=
 =?us-ascii?Q?fDGca1UhTFld2wkqqLJs905dWKWzLCrqpjNlVGujwjOGSs0Atarzf1INr1Bp?=
 =?us-ascii?Q?Sh8nCPIi81PA03fvFQdYuMWquPu+OuNHaNYJLLZdPbyfFkrmcMXHHmstilL2?=
 =?us-ascii?Q?9NPMpm4UVqi+uXGlKlJR5Jm6nwu1EpiaOb3+aam0QUjYkl7Cta2Y3caLaQ6+?=
 =?us-ascii?Q?qHUfqOPy5w7BbCcaaSaTK1j9D7dh+53krSxhoaimC7+vZ+WxuNyO9JDSNg4D?=
 =?us-ascii?Q?CN8F7ribDze3RnIxpXptSxIvLJX+TzBmCClMdj5XnnGib5KbCjSsjWan+1bX?=
 =?us-ascii?Q?JNQiiq/ZOQ4QwAVAxrbh2IUFD0cXA+C/9dTVApmFJCvYpiUiIguWf8RUJYVH?=
 =?us-ascii?Q?B0kk9tlTgFMimHn18OWcDiWl0ag/BEslG1qgfZL0OtX9ji7x+fFq5MiTQJrU?=
 =?us-ascii?Q?AL8Nyb6Fe+btd8GxWJtvE2HQpK/+KkoJadh0/b0ihYtyeIJ7Dyu7x25N04Js?=
 =?us-ascii?Q?T62mjELNICGKY65Pq1z/rLbSeOQHPnSFL0MmZEuEgEvXLlwarMjpCXhvIm1O?=
 =?us-ascii?Q?KE6BdFnS6fhKNXDxsJR2EK2F1jN/sspqfLBjKYyGbjEfwHmlCxj6a3q2Lizl?=
 =?us-ascii?Q?l8qf+UmPvVDD4qs9DbqeN2sSJJGsG1mO5YNsYDJR8nihCzf+8t5zjvKkwFl0?=
 =?us-ascii?Q?7Dl9NYptGRSwQAL/zdKgJOBXFZsw3XUyVcEXdSbXkF9Cv7BmdgwXWTK85HrJ?=
 =?us-ascii?Q?yuIRsJZGriRxtVyPJXdS7ndtpVoszZicL1fHwZFydqulS1WbZrt7m5OjZQvL?=
 =?us-ascii?Q?sX53o5p8MyVKuaH+rZCPUBiNaR4K8ph5dhCQBeuAxrUstrZh2houpFWX4dDV?=
 =?us-ascii?Q?fUWk5CEWJaPT6p+pnJcTO6odtV7730xxBlgNekdqO7A/a9iHuxSTA/q+ZI1t?=
 =?us-ascii?Q?FZhj5wE0Nq1/Avtm6jFOZovjckEPOWaogp+Hseo1hUTVSTO0dV9q7+4a39aD?=
 =?us-ascii?Q?BvY4F4w09k+ZNmHBnaIM0QmeGb2xW8x53Jh3lOiRSAzQxSRUz/o3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a6ca5e-7585-416c-fac3-08de5caac2d3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:16:01.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFzATpbsYwtYKNSzgHg4o55J1Vx58+eAnSf8RKSialCi36Tb0nrY2cTuknVHgaZ3yYWgqnk63Iz5TLebz1937A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6973

This series adds small, query-only helper APIs to the DesignWare PCIe
endpoint controller driver to expose resources of an integrated
DesignWare eDMA instance. Specifically, it allows querying:

  - the physical base address and size of the integrated eDMA register
    aperture, and
  - the per-channel linked-list (LL) region base and size, keyed by
    transfer direction and hardware channel identifier.

The motivation is that some DesignWare PCIe endpoint platforms integrate
an eDMA engine that can be driven either locally by the endpoint or
remotely by the host. Remote eDMA use cases (e.g. [1]) need to expose
the eDMA register block and LL regions to the host through PCIe BARs,
while still allowing the endpoint to boot with a standard EP settings,
without DT changes to hide the eDMA instance from the endpoint itself.

The hardware channel identifier used by the LL-region helper can be
obtained via dma_get_slave_caps().hw_id, introduced by a dmaengine
series posted separately.

[1] [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
    https://lore.kernel.org/linux-pci/20260118135440.1958279-1-den@valinux.co.jp/

Developed on PCI controller/dwc:
  commit 0ecd890e3cf5 ("PCI: dwc: Rename dw_pcie_rp::has_msi_ctrl to
                        dw_pcie_rp::use_imsi_rx for clarity")

Kind regards,

Koichiro Den (2):
  PCI: dwc: Add helper to query integrated dw-edma register window
  PCI: dwc: Add helper to query integrated dw-edma linked-list region

 MAINTAINERS                                  |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c | 74 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 include/linux/pcie-dwc-edma.h                | 72 +++++++++++++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pcie-dwc-edma.h

-- 
2.51.0

