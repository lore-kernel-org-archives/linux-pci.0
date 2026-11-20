Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150035;
	b=ablYcafhzUvrRebruSeihhJsvTlCT8uvIrnzuFD9sNW/DLNHWMBFTNd4jqo5tLi78Chb
	 14bbm9OXpU4Vf5SZZnU0ToGNNFV+euFMD/syXzOkryBUAz35nOUhNWSySY2gvW99PSCao
	 R43uPGs+pi0cwvtCtimpikC+GNScKgR7KFxuSZNoLnkHTtUxXLXrXXSjYwDFNSJn/Eivk
	 aERpcJHQCFdSVOB8zBZdCi5GrZirTZBLZiZIt/aVY0dy6WpKQFjqfnTMZHiPvSdhMqn3b
	 H+xlpcxVDyuJzlhs5B8Z+GM6tMhE86sCCOfEuUjD/l40nz/b4x9FLwpoBdxLa0crjnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150035;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Oh1pNkx3EwfrVmJA8a8V0gKqM6bymUwb87R2bGnjMG4=;
	b=axKywlOysM8PftYhho3ChXSCKME6FwEcSQnplI+KToOfwSu/vSajY/QZKQf2UaIDAqI9
	 ETQThfo13qXzX3D8uDT8nGYNJfQrSrTNpizsBsBGNCTY/dmxR7ap6l/QQWMtN1xiaOrOG
	 2BdNHbn/l51a8ZKrbNImuf7Q8wAd2pjmaqBuXJRUkFDlwAWVP4GRnttda52ydY6JZUN7o
	 BsjmiYV1S17PjPCsyfUgc9wIxwdpoGTR/b9i+/ustLZaiORR4a3K3N3wb/nTnNsa30eWI
	 7DCjqkZk5oMVd2Cgo60Pwf6RXjX70z8qNT0smnLRq5P06FhwOzaLYOzgcc01kGfoQlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="P445i2/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C960A2607;
	Fri, 20 Nov 2026 04:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3C960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P445i2/Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqMh02UScOF9hXlTosZJ2WiIezsJiSt6d+kNCXrIdRpp1ijXTqbJVONjvNW3qmdU+A1NsgYqTAotNd5kBKfP5nQD0XPQex6NCE+nS0Cz9WRSpjdtiDAFMnK4aptmUB2g/0+zKnvhz/iwJt5Fkl1qRnU0eZHxI0cHI73oFwHiCaa9dUpDljZ81w11SFHB4kb9mD8f7S3X0IbPMiO4T3OY+V7gTowGyK99BisJCI5Oy39qcHQ/HiRLvEJNsL9TKKJ5AunHbBnb1J1qTP3By6YGtMj6KupaI7deI6FzIu2JhMFz6MV2n0/kiagL3v37XgLF6E6OtvJPs/Cq1jRyigZnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh1pNkx3EwfrVmJA8a8V0gKqM6bymUwb87R2bGnjMG4=;
 b=mJa3pKRayp4YBlAdPVC8agtWVyLuocbMYPrwQgS5jzAAZo/zbsmf+Di3gtOJkvi4jhib0vsCQbB9ex1bECUl/95qI3ld6FZ3DlhC2nVuVvyA6w37Y1WZZlwAYQEfiCh+20DA7sNUamYyZS783igmrlCpIYLgbh4vR/t82zpuGByxZwoV4NBpviAoxx39BGIXOBDBPYnxHJMO/V011gFyjPH61iDNX//zn6KyXJ+SrwLhJ1r5FCJj1ck/huIivYi6g/8fP8fdi4oHXk1WOarzqeVA2sZx0xmoNBSyWvgq9kURnrlpWlnNby7bfWTXmMNhMWve/o43bDEmbtU80730qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh1pNkx3EwfrVmJA8a8V0gKqM6bymUwb87R2bGnjMG4=;
 b=P445i2/YjG76m2LWZveC85eFL0ZmxTlZiFez9jSKyqSLq2GC9QT+da80P/8qTauBTZZlRQGUJQ5lKwC4YXg8tU+Fhhb+qEey+snVc9ePr4ftRs7TiEPbiUZb0C9YPXrf4Po+/0MSyTDkQn7O/F7fMRz95SePRRIM+X8shE1VUXR+iPG4ifNFR48SiDp4mk3cPCil9iiur1QRgJZCHe/fDHjK6v4+XrPiWF+aH/7OURkv+10oVoew7t9loXVAmpLX00uSmZrpfsnJiyQAf2NjQrcLGQKJc6F/Y16RArL/OzUpsZg528waU1NdWLlg+nAGXd9gvVQXup9f3sQfs7Z7vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:11 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:11 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/9] gpu: nova-core: gsp: factor out the core reset and the core resume
Date: Thu, 19 Nov 2026 20:46:59 -0800
Message-ID: <20261120044704.165223-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LV0PR12MB297887:EE_
X-MS-Office365-Filtering-Correlation-Id: e59ef149-f88f-4128-240a-08df46c15723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022113327099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uHRn3+InHfXKVnzWHhf06xos7SGcPlYeYeQ4xkvAvZdFKcuIJEbKbC5dZHvxtwsIbQ4XYMtrDwZ4PIxYljax8ZshTXWAFhUeMeCfflIQLRErkxuL9dkDXeV0n4DunKj/ybEgGnHKg8FPm6cgNJjN0klQPYyBL+aLR2uiNxzpZvxTyrpSnYhZyS4psPaZMjbIhhuACY6EFxsL9WgRYZ+i+ZgDIuVPtAhXcPvkBkj/0H9vr1dXOM9ZrIIEbVGn6JFodrGZCnAGOMt3ccTYwdWnUz+R4/G7ROqUcrbUmnKNOljoHwlIP8vwunq6tT3NdaBVjLjn/bGwp74nNh2Wc01LxvghsG/Q8rw1MVkNA75AOBEpn6NBaChsebAipnZjpQNIxYipbd6EmXmOSUSp+0OGLvY7au0lGMudTUJNBJ5X84d9ZtsGS9Pzg8GS3p+zEAvZpJMsALd6Ao7rV3ODnhUhRf7XYkjGT0CVVV24NwIEX6XE/IYafDggIhDJ8i0xLrBuctTXZ7TtuIp9t70hslGyR+PkJ22Ugs6c2S4mIqJN+6SSbyx/S7l9ECuair0s9lyXxOfGz+CA4oqZHNuriiRbBqbcBTwxzG2LX81iKk7QO4H2VB3vAdbvljwWhhD4JdiKSNzKHrt3KiMit0aopaap0i11QAjeWMfRqQh2LdKleR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022113327099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3acZo8z+9nsNOsCYcU2XWf8Ot9PE2BYCuhz6RiHkw+Ek+AEoI3Q3qyo2PPT?=
 =?us-ascii?Q?kmGpKt/x58D2kF6KlqiH1uOpMEmJKxPNdh6RzNMLi0gL2dLNtrfJ4TDLk9Qp?=
 =?us-ascii?Q?eNh2OjQZyPzXkdwDtzQmADatG+1NYCuYQVck4k+Av/EOY6T6kU1Uu04KeRGj?=
 =?us-ascii?Q?MR7/QswALDd69/ghmx4k/57hdrvjKREn6IYgZ2z5hffFnGUqc0jNUveJgcmI?=
 =?us-ascii?Q?bNy7bu+eNXdcI16AzykXRjVUMZxSO+GpPTzo4kiZs9fxJ5fFeaZKlr4TpjRb?=
 =?us-ascii?Q?64pIZss6jh7gGmt6jRXwbp1IvWFrUTSnVUTH1psbLrhtgzhudiIknV5+evHp?=
 =?us-ascii?Q?Zpe/nTuV7hem49fqvu9b9ezUvRRbjNCTMgQRdl1Jq5ZTdeBgwWUY8cFIgVEL?=
 =?us-ascii?Q?Sm4uKjQ53KIQxaX3U9pgpA9hzCYcn6s7ta0ejTLM6BrVug9GzE5aAsPyuE2Z?=
 =?us-ascii?Q?iW19Ry109mAj4hlhoPqA1ihTEy5Scp9cLAlNrR4zxbPUewYUhwedjU1OqLCP?=
 =?us-ascii?Q?NY0tk6p6kHqFkvXEOeg/dBDY6QoO8XsybMJ4ek0r1A0t40pZ48MjQx26tM6V?=
 =?us-ascii?Q?DJ8kIbPyOSSH+Ia2bkj7zJC1a5Dw8tIqFwjLbrI+FLLJUROjlw96lPy7Xvia?=
 =?us-ascii?Q?+PWHQkRBmmaLS2Rof6yDWj9v4eq2sTwfum21xSWOhv2RYMyoRIz5A560wSr3?=
 =?us-ascii?Q?V4ZIYcS+Qrf6pkQf6ZAMe16dGvXKWbz2AK4yGrVGwn2UtqjjFldZvQ58KGk7?=
 =?us-ascii?Q?JUKrM6l7QriDL1kUbmapCY8lBvadOdkIP/f+TG/GFPusgmSiny/pZQguCS99?=
 =?us-ascii?Q?oboJ9C7uCd7JUtlr2PxR2QJejJlQiZVtoWW7vXD2AhlEoYJu4cHz7XxyYT9x?=
 =?us-ascii?Q?zCgGR7PyifTYAHy1Ep/4XTLcwqQd9RkX4eCNPUC8+Ov7Lw6F+9pSjIbtZH+G?=
 =?us-ascii?Q?BL9XTm4yOymf5S0W/ImIwH8edCSkHAEXLvyERxJrBo97aVPwX0EkIILxZhPE?=
 =?us-ascii?Q?w5KG3pm4eAJXdqOoHNydi6Z7j1ApfAz30jrKjs+p4uy7kVdLAqWqnvSPU3bw?=
 =?us-ascii?Q?4Y2kh75NDfDEwirv/wvEsvyuzOutvh9e1GnCWCOXDnaPmE3a9boEMLWsHrVP?=
 =?us-ascii?Q?YjEu8EE1oLa1Yi9HbeTHUJTbOQjQoUH3J55Ukkf4ZMeM2CD9lB7Z5QioJ6lF?=
 =?us-ascii?Q?a8bKT9WIlO9/8zMlVoxonwjTfArqvjsETBJ8iow2ujwRidEUAVe14COW4dYx?=
 =?us-ascii?Q?hsZVdKLPa5LpijvjSLopJvMJphHI5nnXNXm5XRogNMROY/aI7QFXkWducXYi?=
 =?us-ascii?Q?p7dgcJL0ufteX/c0Iajj3aFS23OXRKJ/J+ZLOff5s596u6YOzL+1kRpzlpqi?=
 =?us-ascii?Q?N/H6V9B/VNwRPbVDIIscYh4c539b6NEEK59llu8EzqbHrKmxYf0VUL8Upymh?=
 =?us-ascii?Q?vQj1gHwv8cFgkooDLcjJEZKjVcU9cdvV20XyqbRcffreRPhXSmky4hwEWo+V?=
 =?us-ascii?Q?05UIXdDKY7Z+umF1VCMimUgbD+3EEqyislnliz85lDJboYqx+xFa9M2934aH?=
 =?us-ascii?Q?JkX/UqKEOlDl/cIhGz+z6hA5NjZUFrGATXIn5IRFHH4PJDKtsPhgCLbIaTl/?=
 =?us-ascii?Q?HweDiGjvku3iuWhQk68Q7O3EdCUi5ViVh0oC5p8ad9HQkOsTH03zNllD6rQp?=
 =?us-ascii?Q?fvpRoD5x3ql//WQ+p/wwd/p0pCOeXGdeteapzXHVv3TxG14r2dVhHMT4aoLc?=
 =?us-ascii?Q?ydvWihyVVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59ef149-f88f-4128-240a-08df46c15723
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:11.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYP2rcWWbaty7jJzYylu7a3sdgR/oSZNMTaE7YhY+s6vhiNO3Ulj7qQyBd3FTceNJr1JfCKG86MxYGqMOwGANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The r000 boot protocol requires the driver to reset the GSP falcon
before running the binary of a load-and-execute event, and to resume
GSP-RM afterwards. The core reset and the core resume commands of the
CPU sequencer already do both.

In order to make the core reset and the core resume available outside
the sequencer, factor them out of it, into a module of their own.

No functional changes.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           |  1 +
 drivers/gpu/nova-core/gsp/load_exec.rs | 78 ++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/sequencer.rs | 48 +++-------------
 3 files changed, 88 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/load_exec.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 2f1cdf8b7bec..854062112cf1 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -20,6 +20,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod load_exec;
 mod logbuffer;
 mod nvkv;
 mod regs;
diff --git a/drivers/gpu/nova-core/gsp/load_exec.rs b/drivers/gpu/nova-core/gsp/load_exec.rs
new file mode 100644
index 000000000000..ccbfcbfe3ce5
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/load_exec.rs
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! The core reset and the core resume of the GSP falcon.
+
+use kernel::{
+    device,
+    dma::DmaAddress,
+    prelude::*,
+    time::Delta, //
+};
+
+use crate::falcon::{
+    gsp::Gsp,
+    sec2::Sec2,
+    Falcon, //
+};
+
+/// Resets the GSP falcon and its DMA-related registers.
+pub(super) fn reset_gsp_falcon(gsp_falcon: &Falcon<'_, Gsp>) -> Result {
+    gsp_falcon.reset()?;
+    gsp_falcon.dma_reset();
+    Ok(())
+}
+
+/// Resumes GSP-RM on the GSP falcon by starting the SEC2 falcon.
+///
+/// Resets the GSP falcon and writes `libos_dma_address` to its mailboxes before the start, and
+/// writes `bootloader_app_version` to its OS register once the resume has completed.
+///
+/// The SEC2 falcon must hold a loaded firmware that has not started.
+///
+/// # Errors
+///
+/// - `ETIMEDOUT` if the resume has not completed within two seconds.
+/// - `EIO` if `MAILBOX0` of the SEC2 falcon is not zero after the resume, or if the RISC-V core of
+///   the GSP falcon is not active.
+///
+/// Errors from the reset of the GSP falcon are propagated as-is.
+pub(super) fn resume_gsp_rm(
+    dev: &device::Device,
+    gsp_falcon: &Falcon<'_, Gsp>,
+    sec2_falcon: &Falcon<'_, Sec2>,
+    libos_dma_address: DmaAddress,
+    bootloader_app_version: u32,
+) -> Result {
+    // Reset the GSP to prepare it for resuming.
+    gsp_falcon.reset()?;
+
+    // Write the libOS DMA address to GSP mailboxes.
+    gsp_falcon.write_mailboxes(
+        Some(libos_dma_address as u32),
+        Some((libos_dma_address >> 32) as u32),
+    );
+
+    // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
+    sec2_falcon.start()?;
+
+    // Poll until GSP-RM reload/resume has completed (up to 2 seconds).
+    gsp_falcon.check_reload_completed(Delta::from_secs(2))?;
+
+    // Verify SEC2 completed successfully by checking its mailbox for errors.
+    let mbox0 = sec2_falcon.read_mailbox0();
+    if mbox0 != 0 {
+        dev_err!(dev, "Sequencer: sec2 errors: {:?}\n", mbox0);
+        return Err(EIO);
+    }
+
+    // Configure GSP with the bootloader version.
+    gsp_falcon.write_os_version(bootloader_app_version);
+
+    // Verify the GSP's RISC-V core is active indicating successful GSP boot.
+    if !gsp_falcon.is_riscv_active() {
+        dev_err!(dev, "Sequencer: RISC-V core is not active\n");
+        return Err(EIO);
+    }
+    Ok(())
+}
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 23b09fb875e9..913989cd7615 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -32,6 +32,7 @@
             Cmdq, //
         },
         fw,
+        load_exec,
         GspBootContext,
         LibosMemoryRegionInitArgument, //
     },
@@ -213,11 +214,7 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
             GspSeqCmd::RegPoll(cmd) => cmd.run(seq),
             GspSeqCmd::DelayUs(cmd) => cmd.run(seq),
             GspSeqCmd::RegStore(cmd) => cmd.run(seq),
-            GspSeqCmd::CoreReset => {
-                seq.gsp_falcon.reset()?;
-                seq.gsp_falcon.dma_reset();
-                Ok(())
-            }
+            GspSeqCmd::CoreReset => load_exec::reset_gsp_falcon(seq.gsp_falcon),
             GspSeqCmd::CoreStart => {
                 seq.gsp_falcon.start()?;
                 Ok(())
@@ -230,40 +227,13 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
                 // At this point, 'SEC2-RTOS' has been loaded into SEC2 by the sequencer
                 // but neither SEC2-RTOS nor GSP-RM is running yet. This part of the
                 // sequencer will start both.
-
-                // Reset the GSP to prepare it for resuming.
-                seq.gsp_falcon.reset()?;
-
-                let libos_dma_address = seq.libos.dma_address();
-
-                // Write the libOS DMA address to GSP mailboxes.
-                seq.gsp_falcon.write_mailboxes(
-                    Some(libos_dma_address as u32),
-                    Some((libos_dma_address >> 32) as u32),
-                );
-
-                // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
-                seq.sec2_falcon.start()?;
-
-                // Poll until GSP-RM reload/resume has completed (up to 2 seconds).
-                seq.gsp_falcon.check_reload_completed(Delta::from_secs(2))?;
-
-                // Verify SEC2 completed successfully by checking its mailbox for errors.
-                let mbox0 = seq.sec2_falcon.read_mailbox0();
-                if mbox0 != 0 {
-                    dev_err!(seq.dev, "Sequencer: sec2 errors: {:?}\n", mbox0);
-                    return Err(EIO);
-                }
-
-                // Configure GSP with the bootloader version.
-                seq.gsp_falcon.write_os_version(seq.bootloader_app_version);
-
-                // Verify the GSP's RISC-V core is active indicating successful GSP boot.
-                if !seq.gsp_falcon.is_riscv_active() {
-                    dev_err!(seq.dev, "Sequencer: RISC-V core is not active\n");
-                    return Err(EIO);
-                }
-                Ok(())
+                load_exec::resume_gsp_rm(
+                    seq.dev,
+                    seq.gsp_falcon,
+                    seq.sec2_falcon,
+                    seq.libos.dma_address(),
+                    seq.bootloader_app_version,
+                )
             }
         }
     }
-- 
2.56.1

