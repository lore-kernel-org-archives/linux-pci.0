Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794427556;
	b=FQttMSE5q46qzMHjbuBEG2qf3VtXSqYKNxxhA6Hryd195Fh/VNjRPtfuMP5gYzWtZY/O
	 UmTtT8JL3S4IdOHRKDcUafW/hiWms/DS7vNXYCGihHbYZ8YvQ1vZXJSJUETxDUDqaCS4i
	 K4DQs9m6jvvTtjXsqwPXwp7f0GaPAoCoxhdJhtaFCk4V/r0RkonScWc6KkA1P6NkGGEvF
	 bFWw/cfhqpVWQl36/jYdwUx6Wu5NyMZkBRBPoQvB3FiBgwdtSkWTbDZQg8guGW12sdwut
	 vGXMOSotFqF/ZpTHTsMjcxy1NSj5AFd5kteIJJT8y1fARjlMXjNLFr3xrmFTUnRbEQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427556;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:X-NVConfidentiality:
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
	bh=ZIKZLgWocaG8ZjPNBuk01dSWqDY7VIQmWruUT0xVnKc=;
	b=i508Jm6YqxrxftnIWdU8wx/awNACR/3aOKQh3aht0TIJp61J3bG4enaAIF1ZECB+ptbW
	 xmefQOoqmNvccJI9NQirMwMNIIkAPTZHkJYr76cGgF79bfG5w/ViDzl+5Moob1IqfcPD+
	 btAkJVtA0zSOmMokudHqcLeCwb/PUjquuR8RW5CRjzGSA61PQj1wgHNLd+8YkabR7O+B/
	 gmpFgitcTh6/Qyjdy7Oq67getSQHfu6FS52JuJWaIk0dqcHVANR7u4qnfIwI9s/QKFKsZ
	 Dxfp0QRN5I4m8Q1Vg6g+K9S/2dGIQ6ELZVzHj8k6Qqyo5IEN+X/EFS2f1Dyue6xVnBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ao6XsX7X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.59
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7565606A326;
	Wed, 11 Nov 2026 20:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7565606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ao6XsX7X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WutohYfeqXNcZCg9fGmulII+D/72mEWMBEe0vsvIhkENbvzokGJ4jxpEOkPOHRlGNhgal9kVnuWXNK2tAscQQwdO8oXXvKqztMmCaHTdYhKp0kqZncPpom+/OT30orzYGyzeBwUF623UtZAGjSk0zBnuQelLKri7FoDGS6Y6llm7+GsJbwtHR98W5m/ADsZu6ZdWbmYVCb1JpQNHROEPKtx/XpH/zw4YN1a/RtD4KSTr0x4aaxFIdTl7lLmwHat0M3DKMdPPAIMzqb9z2kddtv1xR5A4Xu1TVzE+qxp8Gj11Jb5Zc2YVJOrOQFWZdBe3nZm3kZRNjbuOSZZwB5KwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIKZLgWocaG8ZjPNBuk01dSWqDY7VIQmWruUT0xVnKc=;
 b=k7Vo58JQn+lgbJldhoP333/VKbXGjgez0mnnVDIrEa22sh+ninOvbxq9HSgTimwik51fOT5bWdg9+TG3ySrUwuXc1U7MwBu7W7FbpinNFnWw7TBSc/qzE3Gyq3cMVQV8ak8BcMv7gA3T44J3/RcyS3KmXgcjAd+zy5CHj36puGFlgA7iP0JWIHUH3Cmf1PuY3Q3AOv+oqvaHOXDF+XHMqeXM0ZwZdUMiwgdQ+apD3QLvNx6ED2I9LlJHhJ2zd1CUveCubbIJu6ga1tLd5mhIj01rDStq5e4JpJ86besIaCOjUy/DTA2YSMDaZTL+lo8pXTUOrmsiOj+MBzd2wDGbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIKZLgWocaG8ZjPNBuk01dSWqDY7VIQmWruUT0xVnKc=;
 b=Ao6XsX7X/0kOaYBLkXS7RyiJJec5GfPKCzvL1n7Xazk8YM18zGSsWc1vqcbd2fIc8U48k8PVAFz1XesNp4MTjtWUo72JqegLlo1RzXM6TPGDOZWSDHr5+7nBEuDj9x0O9WHYUpbxwS8gkXc4iqGa+IWiMy9sRF+zjTri0u9FA/EcPMEHBx4VTEBHUUjEScwSpD/Qbj6TvfeaOZ0G20LRwItgTgycJIHTbDI7lISvvasXavvG2fm7o8F5jBQyobLBQze8rGM+fTb9mPszzOvm3SBLzP8zQVVfpxSk/A6EV8e7kYb7cCp5ew6ehs+GVqEqC47VILr5bH3WdPKk94ASqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LY0PR12MB427268.namprd12.prod.outlook.com (2603:10b6:408:3b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 20:05:52 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:05:51 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/1] rust: pci: add a prerequisite for the r000 GSP firmware
Date: Wed, 11 Nov 2026 12:05:48 -0800
Message-ID: <20261111200549.160806-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:806:122::28) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LY0PR12MB427268:EE_
X-MS-Office365-Filtering-Correlation-Id: c1519e1e-0918-4e9f-e73c-08df402f2f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|7416014|366016|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	7p3g8zzSj5pYGIp1Zz0De+DFnXISnJKxTLq52r2nVDbTOCudByj66MoZbV+4dRFMIg3kIh9YVP9sFBsnUmBqxhlXPGydCHuQBwm72dERA/tFs7jpzqvYi8s2WMdpMl+0IbddaQgHO2cfirb6GqOejDOYEiKhDTaYVT9RCulowYL/E3/CHKLVj6LI5nWa4xjaZmOEOz2IRVHsyAShpY+ccOJoTflupXUGpr9bzzOM70PCPjIJQMX4msYiDykPu5HtP8VyVS+A5xo7bDH7FXBtoKbfDdekSnFn2IbiBoFTVbWZEvLxeekh7Yk4KVIUkHuVJPn3LvBnZEcdRUBs4IsOcFLqjL3fBehGnEQcugr0O3o9N0VVjKp3XSO5qCTryj68IRM4zr2LI6BbtuCBJ/fSn0Rs9Q2q9W1BK3m+OdkeuqTQBzEIpJy0GUyblRcrIGNBKknSzwFTQ8mGxhGiaB21b9P2xZ08MIEvbIlIkA5dPHRGtoL1K7SCFSM+gDfscKiFiJ2S7gz++kK9dwc/zzCgn29cng1573XqXCCYoNJebwGRIhuMLtPNQCivKIsDU9ggNLELYSKmZ8Ld1uq1r+eBItVCKChtq1DXe8/AscczJg3LjdUWJm+KQJbpGF9j3whKLJTAXiBRp9kY49s8/goMzlkgEvuyQDzcInfDDRGqwaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(7416014)(366016)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K3a8OVRIrXdwSovRNxx6ockgULZcdHErTw61RFQQtHDeP1Q12Hed4rGAvNos?=
 =?us-ascii?Q?1v3mRyT9OA/v7mVeMebfrym9Nvm6iypUfo/ihHtq/PIlTGa+HrEaS8zdSpZ1?=
 =?us-ascii?Q?F3E84e1biutSO4iYoOKUQqyxWnCcG2+7PesfoDLgLqKV0J2pk29ZOL6kKM8f?=
 =?us-ascii?Q?zbRXXFYU0geIPFCAiwcJlmjU5r+nC0odlVjmEMNKoDiA6t+CCv13tiHjLWDu?=
 =?us-ascii?Q?P0GHSuSov1dYCwSEFnpZ/cblUsTsdvXGmYBTcZCiB2cIeyvRmB8cqR7lwFf/?=
 =?us-ascii?Q?Oupd3L2xulnmNX17p2VzYPSnzpf/6iybiuryZGPNJUAGmg3cX8ofLkb+ngZ5?=
 =?us-ascii?Q?5XRbNXm2+nlzVTwHUytY7CrAL3wIVeE7fPCRllnb42k2Pk+9QE9UD1BUk2Y+?=
 =?us-ascii?Q?Ya0Jp/e6wi5xThJQQE5Z/5szw8yILTjz2581bdgOpLzVwQ4gkl/EfRKIcF92?=
 =?us-ascii?Q?emoq3H2pW2oVxH8oiXPXaaEWhBFxwnrvZYvQ84g0zKnv5Tho0vX8YJtDpsGV?=
 =?us-ascii?Q?tHx+KdiSKviJnSu+82YxamuH+mhoFeH9V+vbCxaoaFxntjYc4hLysqoZtwqx?=
 =?us-ascii?Q?3YkRqT1oL8m+pi4qXMJOHr1UG4zxeEJk1T/IG2HrZYoGcvkxm1Q78UkrX1lB?=
 =?us-ascii?Q?wLqr88Gz8KWx/wbbGRWHfER4zIe8bTbLpoDHfHX3ymh82poQbY0xCjyATADz?=
 =?us-ascii?Q?O23JMxkaaN2cm3Iaf+0N1JPXCabX+hB3nHL5aYrw/s0TxKK0d8PjLNkQcsnx?=
 =?us-ascii?Q?1G6RlyZWZjTf1DMMRzg4dfwCFabrYExg52svCe7cfZcoOl73GBxxZy+6BnF6?=
 =?us-ascii?Q?L9UsDzKbo2W31pitv+Mg2XpAo1QP00Qkg7CjD/jZkmBUIfluQgF8OamTuMk3?=
 =?us-ascii?Q?VBUUWYT3KEmy0vbfLw1HgPJjcKibnc9AXAZiup+F2sHGRv7iTWWG+8xsNWRA?=
 =?us-ascii?Q?Kwk8IPCz9MJIX2CrhkkkOsgHFFovt/20Fb7mGDjv+Vc81PGTUgf093Cs0rmQ?=
 =?us-ascii?Q?k/bt4JGHBfThuvJIIJRlKGirhbfvpIACX8exUXnkF60b3agRuRoVH8vfTwU7?=
 =?us-ascii?Q?KTuN99HCS4DMI9ZgY7eEJaEbYh8k3lRGHT+3FF8FCuLH6NyfRhLCnJbGeXrD?=
 =?us-ascii?Q?3jKr2u/UrG46O2QdtgUWNKU/F2/JSHSSN0H3dR3P6JmBsi76JBtVpLflfvMi?=
 =?us-ascii?Q?6csji4XfpsoGcs6i4IZ9nswnNioRi5FBRAx3M+Wk4JU4jPRPLMDGn6FhW9y6?=
 =?us-ascii?Q?jZM8DNfDIzvJThGSuhbVzJTqOfgxnYfN3qSrN5yuJrhEpHQX5ikZnm9GxmWJ?=
 =?us-ascii?Q?ayTI3bcB0mjGaY29eM+e9Cb8hgF1y2zA3TI0+feJlnKNu9L8f8HstNdGlPtt?=
 =?us-ascii?Q?cLwmm/niYYSBz7qHpU3BLwipWKEszUcf4Bwkde6KF6DaWv/H4CU/OiJYLzjx?=
 =?us-ascii?Q?Skn7llU7C4P0DuZN4Ibdyk/94t9cH9PFJGkhihx5POmMrd1V6c3UtN5926EU?=
 =?us-ascii?Q?TXDmDrpgQCHQMGTNqG4HIlNcGUqUuXZPghuQAAZEx5V9FVer+oPq3lfaUefD?=
 =?us-ascii?Q?7FST+wfT0AD+sz+WrTMy69cFcYKHCMeSUNNavN50Dq/bI81UzaNx1JhidQYB?=
 =?us-ascii?Q?NMavrwACvF7o4eHwuQLzFHmKuf4G8vIADBeKRHD3mYWMMsxA2E5aR2LnJPz8?=
 =?us-ascii?Q?yEfEkPh9waiixsqNzSeC+adG0ozGuzbonjSa/n/wwnJ8+LMeeyeG3lwu1OML?=
 =?us-ascii?Q?b+5+0hiLYJrAX4PUf5PghBxZMLHGocw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1519e1e-0918-4e9f-e73c-08df402f2f82
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:05:51.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXEADXK7DCNNLwqYtkdGoMuevYCJhmCOLDQ8mj9dfeVNiZSbjDxYXXc7y/YYuFC5ggaV58UM0lEb/JYrfOd9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB427268

Here is a preparatory change for (or more accurately, from) the r000
GSP firmware series [1], which enables nova-core to work with the GSP
firmware for r615+ releases.

For the Rust PCI abstraction, add an accessor for the PCI domain
number. The patch stands on its own, so posting it now helps avoid
reviewing a huge-er r000 series. :)

This applies to today's drm-rust-next: commit 6e557330b874 ("gpu:
nova-core: factor out and expose Falcon::is_processor_suspended()")

Changes since v1 [2]:

* The helper takes a struct pci_bus pointer and only calls
  pci_domain_nr(), so that it is a transparent wrapper (Danilo). The v1
  helper took a struct pci_dev pointer, which broke the powerpc and
  s390 builds (Sashiko).

* The CAST comment is directly above the cast (Danilo).

* The CAST comment no longer cites pci_register_host_bridge(), which
  checks the domain only under CONFIG_PCI_DOMAINS_GENERIC.

* v2 has no Suggested-by tag, because Miguel suggested the
  debug_assert!() and not the accessor (Danilo).

* Patch 2/2 of v1 is in drm-rust-next, so v2 is a single patch.

An LLM coding assistant (Claude Code) helped write this patch, but I
have fussed over every line of both the code and the commit message.

Testing: booted nova-core on my 3-GPU test system (Turing, Ampere and
Blackwell GPUs) with all KUnit and built-in Nova tests enabled, as
usual.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/
[2] https://lore.kernel.org/all/20261110033655.148487-1-jhubbard@nvidia.com/


John Hubbard (1):
  rust: pci: add domain_nr() accessor

 rust/helpers/pci.c |  5 +++++
 rust/kernel/pci.rs | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)


base-commit: 6e557330b874b0e1fdd03e8fe4c438f36c93eefa
-- 
2.56.1

