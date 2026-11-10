Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794281883;
	b=nYsfY5voqyCclN/PptusYa+eRJUGybPGRPqxa/a+hNNjkF3LPUDQ2V1hpV669S8F2zAc
	 MDzpm6DzEEsRUcsBYIeW6ldumL9YMtG4yMagvT1Jo1uWR6KCjgzUmTH6n6lPIZ8OAU6pp
	 sOSWSgq+ToSYMcJk0LE9eWwCVEvl6KPSd/loovg4FCaAguOXFOvMc5NbecxEDvwRafc3I
	 ojeKysqq84U+LUIjuAPxWbmFqxPlRY2HIwLiJsV0eJOP+MD4zfhSX/9SJztpuGhRtmoOq
	 b2ohFIAjvveKDB2uzx9pjfubjSziUBwROMWP0yFI9dR+c68ispg1bvhO1W0RCYaGrJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281883;
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
	bh=mF0ONvtgZBz5/00SlejcCeAsL6JHc8mOf4kI4lWQL28=;
	b=vYt3UlArpQFsNJcJ66ykWRasHO3D+HY85QVEj4FLyemXN4TFTXyl60sBcIL5EDzU5LQ9
	 4wq4VFJpqAautoqEqpepYKlyOKdKiOFtXYHnhOgMAdpSvwDwWxW2LjVXyYfu/qizODo44
	 6BYx/DYXdXQQVn7bb827vHYSYXdZYkywYIqtqtoSDCd9gQJMnnC6ESLo/9ctYaZ3N7/V7
	 Ww1Vzv34VrTN/ZlZRta9b+ofMgssbtKV3M0rff+5eugE8tXZL3vXHjt2pj3zfd2Lze0pr
	 eQXnwFpMdHmzGHVQFPotyq/qJpZ3MZyu3rZ27DJqE1/bX5Yn7cKPAMKwVjQl9eH5G5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sBwnGGmB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.49
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B315606AA05;
	Tue, 10 Nov 2026 03:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B315606AA05
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sBwnGGmB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWViQnJ2zF+VmEzNsXsAlELmvwMWPCOPJn7qqIWQVEdGuCPYd/kUOScYpyTuOwYOEfozgGmHM+dJOwuQ6D3HVZaM5J0UN/3cMDaY2eINVx2V+97lbwcpLyGi664EXUtl2DTzPdBqZvQd8Hzm6g+QNgcfu86NTtibeyrTwLEhoj8SpYnptni+Xp9xJoYBl/RGI5sQqxSrxznhgY3H+1/VqMqwWs8lyxFMcILsX2hItmjyvZuuD/kZicwQ9/Czsa4gWVvMyL7zU0B4yxi+Gp5dOBP9wetoYZlT6wmGBwf9nlVCTlcrhaoil86PBmwH0tTowsLIIU+plSos+7ZpoaoQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF0ONvtgZBz5/00SlejcCeAsL6JHc8mOf4kI4lWQL28=;
 b=Ph90QnZBYyPxM177fw29A/agQxJ7tFhZ40KjHiAS9H5TD/EhpmjTh59kIbaGWmgxBTIU0F8Hn2ocVhErWXY212QjAl6BFWEwPVLj6G6LFPbeNunfBurEWVuVTJdLoPm+dwwPOLKPiX4/m8HJ+kVYA5moeq9n2gB/zeAjtWGHo93j3fO0DunOXBj7tWg79RYAAkyrDdsaq/qWKy9MTXDpPhWcx3zHQRjpVawrDnVZ8poWs7Tl0Okwiu5Dt4z3MjXlSn6jMvJZG+C58UoIYm3VJoiEIlh0wzqU9v1NWuHPtVLlcqiuMWozyYI0Oueia2PwfNSCT7HgDsY21gvBgObfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF0ONvtgZBz5/00SlejcCeAsL6JHc8mOf4kI4lWQL28=;
 b=sBwnGGmB+UiTufAS8YXAri5CScTk4EAHXEX2B5zTRE97HKfb5UpeGjwjgXKadVKbtELdD6OnZ8hoRyaZJWWLwRS8n8yjC+Y4/dJwQZ907w0iJJwwXBFy7InXUewKIL1ybyXbTriu6lT+2m1ni8DLGmA2k1jqU4skoP1qApt5QqkbqsFo952C0P184Uybinwp5vgNa2NIFKjaIo/j/W+OIa8Pg2hvUwqi4lnlaiVfB7ZNYS2658RLjMPoCJ1NawoivIO2z/vobIYo5rh0Fi2+BtYF25efV6JHgkQ+abNmoqrrpbVVoe1SzB2ifai4gpyZ8f3xrzbVi/B1tggK/XotPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 03:36:59 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 03:36:59 +0000
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
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] gpu: nova-core: add two prerequisites for the r000 GSP firmware
Date: Mon,  9 Nov 2026 19:36:52 -0800
Message-ID: <20261110033655.148487-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f15622-ddfa-4993-1055-08df3edbe00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|6133799003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	lttik//xaMneMdRpC5i6XDUSN/ngqopYVVK0VUnI2FDL7HCXQO4NbxREcVVJy4lo+HpHtYLlRiDErzf1TQ8AnWLYCIiHsZsHTokoT7OcM/NjQpGaFQgLagyDc3fpUXIXM5InFtst1HT1vNwKdrb1MuOPmTkd2ifFt5KYUpHKVLjkx88unXjIrxbXubkIfEcQ8n6Ghbhq+Vzi2svqJmhnljfn7f5TI2ComfIbkO+IOY+b/ibXEXY6BVzg41H4RZs9uuY5uAUYOX6NfzTPvD9valNNNJKm6a6NKhL80Je6xRrwGu2d0oZBfa3cZObS5jd68oiYs6NpLI5ikoxb8UGAhwSS/8n00O4dN+bp7rkZUdJhDbQ8vvDc8uY4x44Zn5uSr4FD4ZPYoEp4MzxbfQ2mNz4fyhZMUD+ydZzmnV11IH04k+iuvgo4tzjBCrFJyOkBofMJZxQcyMgrBBw9FAESyXHbfBqnRx+bDmfoyngW8CZyV7uteBeajavGZ+p73ZQzScGKLdeU0cjD5/f423FIWLKIIB+gXstAfY0DFukE4m3pVYo7rtS8Svwjly3bsGncExXuptUaGqqRB3duUvcxM8ZWSdW4Y/r4DYnvodXW2SrxR8Q1l/s09Bkb3Xd3XqS/+THItbX2DNlbXMaQyRyQImyeEaVTvFls7Y0mkhYowY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQbs3HaLtsQAdhcE/Fhcued8Lve7u4wFdoy0Vp+Xr1q3uFEZZFvNReUDd+SK?=
 =?us-ascii?Q?TwZdNyPP14gH0hKxiN+sL/nbgmJ8xY/kmWWhr3KSNyFDjtMCWnI9kwpRcYnK?=
 =?us-ascii?Q?FCHgn7ZDAsMzbNsASAeG/sq0Yom58Xbr4I4qBADrdAVYZYIEivwrO/apYm4i?=
 =?us-ascii?Q?1idoGbB+q/rA4TTwdHGZ7xANl3wTkj9N/NyWcOGI97GS+OE9zMUUcVJfp5yR?=
 =?us-ascii?Q?EBYsQ1jYc6YMxJ88GmkIMxz3Am+/PaVSW+hA3bsTE+vwB1D01y6ELnXg0pKO?=
 =?us-ascii?Q?rylJBb+T03KBNkByqPNgz+uO2UIKtUtz2nV3VrQDcC0pJSKsQ4IEd1fgNFsF?=
 =?us-ascii?Q?juLmvZNu3xG/yWjPSPcDCpbDPAws8WrwaUQjs8H1SmfxU7i30m/RHrFZj4UO?=
 =?us-ascii?Q?0BCY/zHb5cJRpcRnEhYZ5C9mvk3ipW4ltZx6v/LW+0Y9SLNKqwXjmr/X0zud?=
 =?us-ascii?Q?NNhbyAHZQI2c60DwjEpoAGmXtksP25sCUZ/m2GCXqzXJyBrFDK9ihFmHAarS?=
 =?us-ascii?Q?c+D55PPd35c8/jJoSaxk/a4IMleS5jAvqLSFjckTO73jqJ8Wi+dT43o+9zyt?=
 =?us-ascii?Q?h3j2nDRsnludivIQ7VHBgApHNPGjAgRx5IjRtVoiLG7uWo4fNQ+jXKpaKbrX?=
 =?us-ascii?Q?Wg2iTYxHAGX2sVzFQTP7trfCak7O6kbFbKukut0naX00SVFBb8NupC3x4cI5?=
 =?us-ascii?Q?w73fwJnzNocFPvcRaE/I+fmoK3DksTdDO93SdwyiSb25eLI3zjAR5CcJ24u/?=
 =?us-ascii?Q?zOlPrk/NoS+wKIkOCnRaB1Jgr/pknJW1XYhUu3Lj0dQyiky7YWBTi83v/x3o?=
 =?us-ascii?Q?klfTs17ZvQERE3+qKmQwuNQqyNDaMPEU1z5/vXQfJAHiUnpQZ/E8hVMpdw8w?=
 =?us-ascii?Q?oYj8dZDI0VfN0M5W7Ms66D+l4hyfLzkVHfNJ8cIpZD6sjGMWj1TuMFsV/Zy7?=
 =?us-ascii?Q?VzY5xa+cr+ZICzyc0UBCAekZnAJ+6nB1RWyYtDpPXUwVzQrUgxsYS7IUcAtg?=
 =?us-ascii?Q?dHlA/03tkijXl7gCUqFdd4xHY3L84htqZ/yAgeMeABtR7A1xs2SY540xAGH6?=
 =?us-ascii?Q?iRt1Q6vmyRn24y32Gyk7cssN/D705za7QTfwhff6B+i7xL9V39O1jsImvesQ?=
 =?us-ascii?Q?auhEqJRWhwphawJbEMPEI50TbBK+rtmlbjK0nI+qVF0PLohx2n9Cf3Qp1EJD?=
 =?us-ascii?Q?ATobyzL6x8c/hWrDgHTYqHJsiEYkIQkNDH1mTYmDCYZuHJ8k5o09vJlnqwtg?=
 =?us-ascii?Q?cxQ7QHaSlPL5BGx3tJOKJG4xgYkfeRodsuFX8YFXA5GAazt8T+geJrcfxgLp?=
 =?us-ascii?Q?Nh4E4wPk7pJtuMC07piTaaGIz0N8+BQ/YaKd82bRviAn0n5xR83tWXqi6lBz?=
 =?us-ascii?Q?e8Mys4ZOHXGY5uiA5fi86oTrxA9Y61NlI+5n2WJ6sW2ov1ivKOyWmOEgMdHz?=
 =?us-ascii?Q?c2J74Y/mgPp53xuM8Q7J1DKPFZ7goFgc5eEftuGcDJ9hvWLBI0ja3N10tRP8?=
 =?us-ascii?Q?qFYyynnQsM29ClOoxV4/F/iFKecRwzornWzs7wSbVSkAsOpqxAK23yPuWIq7?=
 =?us-ascii?Q?lMJ/woBj7r7cOrVTjVW8e+MAzXL8JNcoQUK853PCXuXITrSRGLJro2dURPkR?=
 =?us-ascii?Q?uD7NukuVn7FoSlMFodOqc94gRk3VrEJErbdwRmbVnKtL8FobUWgEEhiEUCr9?=
 =?us-ascii?Q?gd1IJYwE1xGKBsntmI3ZVz4i/WliFm2/KAM8qoujVyHE3mq1JfeJ5v2xAbgs?=
 =?us-ascii?Q?H1aRChhlCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f15622-ddfa-4993-1055-08df3edbe00d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:36:58.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqaz+WTchcGnEo+OWkk4BuzbjyS1ZQAdZJJs5GjjzzHAk1Q3Dl5xAkvRyfC5AYAScxyjbA2d8bB/OrGuoHEb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

Here are two preparatory changes for (or more accurately, from) the r000
GSP firmware series [1], which enables nova-core to work with the GSP
firmware for r615+ releases.

Both of these patches stand on their own, so posting them now helps
avoid reviewing a huge-er r000 series. :)

* For the Rust PCI abstraction, add an accessor for the PCI domain
  number.

* Factor out the shutdown path's check for a suspended GSP. The r000
  boot sequence needs the same check, so it gets factored out and
  cleaned up a bit at the same time, by using register!() for the bit 31
  access.

This applies to today's drm-rust-next: commit a7cdb17ca0d7.

An LLM coding assistant (Claude Code) helped write both patches, but I
have fussed over every line of both the code and the commit messages.
The LLM also drafted the first version of this letter, which I've
completely rewritten, because it totally missed the point. All of the
points. :)

Testing: booted nova-core on my 3-GPU test system (Turing, Ampere and
Blackwell GPUs) with all KUnit and built-in Nova tests enabled, as
usual.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/


John Hubbard (2):
  rust: pci: add domain_nr() accessor
  gpu: nova-core: factor out and expose Falcon::is_processor_suspended()

 drivers/gpu/nova-core/falcon/gsp.rs |  7 +++++++
 drivers/gpu/nova-core/gsp/boot.rs   |  6 ++----
 drivers/gpu/nova-core/regs.rs       |  5 +++++
 rust/helpers/pci.c                  |  5 +++++
 rust/kernel/pci.rs                  | 14 ++++++++++++++
 5 files changed, 33 insertions(+), 4 deletions(-)


base-commit: a7cdb17ca0d7ce67e9f3a52d39edd60f03223729
-- 
2.56.0

