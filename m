Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892579;
	b=NuT3ayCRL6vA05QrbPFu7GZLZaak4wPpk6UGOfRsquwmhEMwpExphfksuxeHkkQr+WD8
	 jmseG3RAIA4AfJb7JVafUIDjqMbfotL7k9qZhKocnSoM8lTAefjW3FlI1UNiYuBrfo32o
	 nusxOZ4h/6MOk6YDPm/3Fet1amybG+/68mDfhtLXvfw0HvxycnJPhVuG4ZcDzWIu6640T
	 R5M0zLwDnRQTUGJo9zHj627AgHBvF4Uye2P5UBOCX/X671cr9El0m2CV73aJVrfuvvL1d
	 v64mKBFcCTDO+aL3OwrWewCoxOREdb+cfBchdY71csCOjQ4uTCxw0a4HTylgejOdZ+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892579;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/dyO0dptigg9Mi2YEgB4Bq5CNwWQyZcykgELngI8GME=;
	b=I9owmpWx7U3RlRyIAWpywV4Xn2ktdbQdUtjSa+VOz5thdZ6141FbSuuTc1BPomRp6tmB
	 pKTOF7g/q2XbW+DzhXHN8y/1shQaEbDv5WbobH9z9rinY8tehC+0OqI+g1KWRLRLmUtsS
	 B3zD+dW3F9NoCrP58dVVVLh/FoHXtFlBS34gS4+LPKYfTTDsGTrh2uKEfHrTdW3cp3WwR
	 gWfQeXBDgjHGrSozqzyu6Z8XBvOE5rV1Ky9TLjogBYgNFcxOkQNHjWIG2mMWd6NKGX9P3
	 1AmvV1bzC5zmMSi4wt0yeQrsPpzJs4/h+ZqCcDym0R9A/iZfaIboapql3/6v3tOepsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZjwwgVYb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EC606A333;
	Thu,  5 Nov 2026 15:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 059EC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZjwwgVYb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx8zeV92aw8tGsMpIkB3v9bxMpLLF1J1rB5InimHBjczykNeWb3chvyaqpGxbuQ9B5jjJTggmQvQyf4WI7AHOK3kgXxnOEqQom/iXBlloN9sF2jkKhSZpYuk+Ec0Q6lEfv94p/sywxYGZiac5KLAw9x/jpPaTO0umuRB9l5Y7WHdRlMw1CEu+kkqXmoNPVkpKt0uPwplYi9hEix2TGo4pJaCxMByO8e1qPNCvmJM/sKS3hkKY5XOOpEx27JLU8ZZZD8VEbzmOGoXNtKQRTbHfMcLZUWWtus+G8Q631pNdS+shcgzXZdd881JdzOvN1K9y9URiGr3bj0U0HUjoOpGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dyO0dptigg9Mi2YEgB4Bq5CNwWQyZcykgELngI8GME=;
 b=XkZxRGx/LbhdLHA9cEIe7Lx3zQ10sFFehwkBBD2phfmkLmpYzYPLsinwJy2qb7aFF7SY02l1okOiDrcZiI7NNIcprWyUnGeoJVmOHEnLSkVls3Y62p5EdZU0j2TsHawJO9Fc6aaHSJmYmLdWRegtMt/kjAcwezKkGQsZ6ihvBv2Xc8R6iZ3kZ3oJUniVOP0Qe46iSQbJNYmedqr9k9EqxJR9oLozoRavIgCsH5PQuUkZ/EVQ6wjjamUu/HiTpSMGvovOR/JVbCPNsItrZutA1FSJTTeRQw8HI8AaSk60nPm4uxbM3PU/yaWVuOztd1iMLh2GstLYA5gFZD9rbK8UDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dyO0dptigg9Mi2YEgB4Bq5CNwWQyZcykgELngI8GME=;
 b=ZjwwgVYbw69Cg9WTOfOdIjxnVIcxxTJ7ltJEVhqCawZtL8m2Mo7z2uqc46xx6TKBk2qtbYyPKUA8fHIvFzdXKs/zT5rz+O7iv50/RV9Dqezm0fTE+hueco+hy1S++ePT2dBXOnRqBkwPvdEgcfaglc/ib3em55R/89SfW0kSune+LmLx+HK4EO14MjSm2tikkppV9dVbpgswGyV9owjYNyL155LBzVRQOUR7tSIZWsdsaGJwdqlqeznoU7va9KMUVHXe0x6yUqHSY5ZUpArD1DYKjv/fwnsYFGYlU8iEWhKV0eQUVWfHqjpnyCNwoyBujCYKtY7BO0a9JS2EA9goBA==
Received: from IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::7)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:29:32 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::aa) by IA4P221CA0003.outlook.office365.com
 (2603:10b6:208:559::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:29:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:29:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:10 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:10 -0800
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<terry.bowman@amd.com>, <nik.borisov@suse.com>, <brads@mainlining.org>,
	<lukas@wunner.de>, <rrichter@amd.com>, <gourry@gourry.net>
Subject: [RFC PATCH v2 0/5] PCI/TSM: Resolve TDISP coherent (CXL) ranges from precommitted HDM decoders
Date: Thu, 5 Nov 2026 15:29:04 +0000
Message-ID: <20261105152909.53452-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5550f3-fcca-4f90-7b30-08df3b51976d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|18002099003|6133799003|10067099003|10063799003|3023799007|13003099007|56012099006|11063799006|5023799004|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	vEzi0tcCjtqglUC25SVqGMEUUZJeSuvR9VwxuhV+TtQhjvLIkNhIQOoWTyD14+uKAeo68b32GSTNDukVyzmJ7wgAtplcacdDJP9YKUkHhPQrj7XpnpM2CLjtN4dl+W0h1UY/23i6qgkA2I9bc6MqOHKnjZGLPb/QHVq7jAihuDnVEaJ1anG57vyF6pMvpL+AQj75HviS2KnkBSZnLkN+cG0FZaGWjyjByviQv2FCG3BGECWMNTnWDq68+hCb/HixNFLpnDDvdjb63ZfitQeMpWo46R/hiIx0FhweMI+2b//uSM+OoDY5G2ESqw8LIIwjAz8xLTyMTiTJhP1cwMy/IBDBg0dP98wq3+S1B6Q4YsXGG4C1m/1r88chv1Hy/OQ4/E8VUuNPWpUH8O4YB6IQCBFNcuKr790n6JUdt+vtBMmg4qF5mvJd3kzQpuweo+tphRq2/8rxb2+sG2sIledzENFSbbdcqitrPWq8R66E+EPmCbuvYOxVNviKZiKXMZRfKtujxytED4YV3VQDjxlbfqA/EmTgIl6Mg4fs8Xm9F8ZwU8wVLe8x9D9bB/vB94dFWUV0ZkcLhYJSrAMCW7qQQ493UqRhEz84d8q/Gfp7rSjuVG6WtZG5Op8jLEOUVYyGqrm/m2iGd09CVmE78rUaPzrZe5JKpyMa70lUScRxlPNUrEswZ5hQ9h2N76GyXua0yRi5/9p9xXCKxrEU1MV/pg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(18002099003)(6133799003)(10067099003)(10063799003)(3023799007)(13003099007)(56012099006)(11063799006)(5023799004)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0y5oQCe6WOWM8/G2ZOep3Pd9cfdKe3kbc3UFb0rxlrVEBvvvko9a9btKmBsUpzc49vURQJCLnGHc7CTHdSWpjFb5jsvUOsqot1srnN3bFH/3+bKtQRrrUcyWxRzMRATRmu1YpENJGUJqNgfnWZY9AnMXVw/J66TWeF+ZmLr5y0U3CZApCtwGHGJwcfI+EDrDx1I1+ZjuSYF2KvERT8hIYuzjefu1n+16z+3JBKHEc+ox881BPt/3Xlu8RJcts/nsfdmC4m+WQUWJVhGVmLH6rwex2Exu8OyNK+YX8cMLlbAGM+n/z4qPcaESVldsf9A2jLTLXqIt78QC5q0JIOB5P7jzpkZfGgdK/ddWiW1Le+QMhI+1DDVHncZ6WXQhRw4jek5tgzx4gUeXeSZPd3sYx5El2wOFbT1L3tE2W/Pouo61zULtm3bf3DIEo/zBKJpa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:32.7021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5550f3-fcca-4f90-7b30-08df3b51976d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7

=== Background ===

TDISP (TEE Device Interface Security Protocol) lets a Confidential
Compute Architecture (CCA) guest establish a trusted, encrypted MMIO
mapping to an assigned PCI device. The device's TSM (TEE Security
Manager) reports the device interface's MMIO layout back to the guest
via a GET_DEVICE_INTERFACE_REPORT response. The guest kernel should
parse this report and get the IPA for the regions present in the report.
This is required to validate the device regions.

CXL (Compute Express Link) runs over the PCIe physical/electrical
layer but adds protocols beyond plain PCIe config/MMIO access. The
one relevant here is CXL.mem on Type-2 CXL devices, which lets a
device expose device-attached memory (e.g. HBM on a GPU) to the
host as regular cacheable, coherent system memory (called CXL region
in this series).

A CXL type 2 device exposes this CXL region through one or more HDM
(Host-managed Device Memory) decoders - hardware on the device that
maps a System Physical Address (SPA) range, as seen by the host/guest,
to the corresponding Device Physical Address (DPA) range on the device's
own memory. The host (or VMM/firmware) programs an HDM decoder's SPA
(IPA) base and size, then "commits" it - after which reads/writes into
that range are transparently steered by the decoder to the device's
memory. This is conceptually similar to a BAR, as both are ways of
mapping device resources into a physical address range that software
can access. However, while a BAR is discovered and sized generically
via PCI config space, an HDM decoder's mapping is CXL-specific and is
not visible in config space or backed by any BAR.

On the systems this series targets, the HDM decoder for the coherent
window is "precommitted": platform firmware programs and locks it
before any software - including the guest OS - ever runs, and the
mapping is fixed and stable across boots (i.e. the guest never needs
to program or resize it itself - it only needs to know where the
firmware already put it). Because this window has no BAR, the TDISP
interface report describes it with a special sentinel range ID
instead of a BAR number.


=== Implementation ===

This series does two things: it first introduces the interface-report
parsing infrastructure itself, adapted from out-of-tree work [1]
originally developed by Dan Williams and Aneesh Kumar and built around
the common BAR-based case, and then extends that same infrastructure
to also understand firmware-precommitted CXL coherent ranges which
cannot be expressed as a BAR. Concretely, in four steps:

 1. "PCI/TSM: Create MMIO descriptors via TDISP Report"
    Introduces the report-parsing infrastructure itself. Only BAR-relative
    ranges are handled at this point. Cherry-picked and adapted from
    Dan Williams' posted series [1] (based on Aneesh Kumar K.V [2],
    co-developed with Xu Yilun), with the evidence-store dependency
    removed.

 2. "PCI/CXL: Populate and insert/remove pdev->coh_resource[]"
    Snapshots the precommitted HDM decoder's SPA base/size into a new
    pdev->coh_resource[] array early during CXL enumeration and
    inserts/removes each entry into/from iomem_resource so the range
    is reserved like any other device resource, giving later patches
    a known-good source of truth for the coherent window.

 3. "PCI/TSM: Derive the coherent-range IPA from CXL"
    Extends the patch 1 parser to recognize the coherent-range
    sentinel range ID (0xffff) and resolve its address from
    pdev->coh_resource[] instead of a BAR offset.

 4. "PCI/TSM: Support multiple coherent ranges via coh_idx"
    Generalizes the spec defined single 0xffff sentinel to a small
    index space so devices with multiple HDM decoders can report
    several coherent windows, indexing into pdev->coh_resource[].

 5. "cxl: Invalidate cached coherent range when Normalized Addressing is
    detected"
    Addresses the Normalized Addressing concern raised on v1.


=== Dependencies ===

This series is rebased on top of next-20261103, and requires Srirangan
Madhavan's v14 "CXL HDM decoder state caching across PCI reset" series [4]
that is also undergoing review.


=== Open design questions ===

 - Patch 2 adds pdev->coh_resource[PCI_CXL_MAX_COHERENT_RANGES] (10
   struct resource entries, ~640 bytes) unconditionally to struct
   pci_dev under CONFIG_CXL_RESET regardless of whether a given
   device is actually CXL-capable. Feedback is welcome on whether
   this should instead be allocated dynamically.


=== Testing ===

This series has been verified using an adapted version of Dan
Williams devsec tool [3], modified to exercise the coherent-range
reporting path added here.


=== Tooling ===

An LLM coding assistant (Claude) was used in preparing this series.
I have reviewed all of the code.


=== Changes since v1 [5] ===

 - Rebased to next-20261103.
 - Use a strict "i == mmio->nr" check when parsing the report (Nikolay
   Borisov, Xu Yilun) - 1/5
 - Document that BAR alignment of the obfuscated address relies on the TSM
   (MRO a multiple of the largest BAR size), citing Arm DEN0137 A9.6.2 (Xu
   Yilun) - 1/5
 - Only record HDM decoders that are enabled and locked and skip
   zero-sized ones (Richard Cheng) - 2/5
 - Rename pci_tsm_coherent_range() to pci_tsm_retrieve_coherent_range() and
   return a struct range (Dave Jiang, Andy Shevchenko) - 3/5
 - Gate the code on a new CONFIG_PCI_TSM_CXL_COHERENT (depends on PCI_TSM &&
   CXL_RESET) and move the ifdef to pci-tsm.h (Dave Jiang). - 3/5
 - Use pci_dev_for_each_resource() for BAR containment and fix style
   issues (Andy Shevchenko). - 3/5
 - Handle Normalized Addressing through a new patch 5/5 to invalidate the
   cached range once it is set (Terry Bowman) - 5/5
 - Drop the Assisted-by trailer (Andy Shevchenko)


Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [1]
Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [2]
Link: https://github.com/ankita-nv/linux/tree/next-20261103-tsm-cxl-devsec-v2 [3]
Link: https://lore.kernel.org/all/20261001092227.3004747-1-smadhavan@nvidia.com/ [4]
Link: https://lore.kernel.org/linux-coco/20261005070252.84810-1-ankita@nvidia.com/T/ [5]

Ankit Agrawal (5):
  PCI/TSM: Create MMIO descriptors via TDISP Report
  PCI/CXL: Populate and insert/remove pdev->coh_resource[]
  PCI/TSM: Derive the coherent-range IPA from CXL
  PCI/TSM: Support multiple coherent ranges via coh_idx
  cxl: Invalidate cached coherent range when Normalized Addressing is
    detected

 drivers/cxl/core/atl.c      |   6 +
 drivers/cxl/core/core.h     |   9 ++
 drivers/cxl/core/resource.c |  92 ++++++++++-
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/tsm.c           | 298 ++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h      |   2 +
 include/linux/pci-tsm.h     | 112 ++++++++++++++
 include/linux/pci.h         |  14 ++
 kernel/resource.c           |   8 +
 9 files changed, 552 insertions(+), 1 deletion(-)

-- 
2.53.0

