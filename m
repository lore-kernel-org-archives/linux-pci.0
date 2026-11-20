Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150034;
	b=xJHYktrBg2KBbokL55DuCSXKSr79sT+XFyyVEIxBm1DKRLMalXI44DNY7V1yU+K/Pduw
	 skB7cra5KbpfxD48o7K/PeiaiwfhCcVqnJgLUTrQ8LaadtgPiFOEY1pUPGQjdWLyT3Q3t
	 tQODNsLw7pww470lvpYvri1rQY0D1D1p8av+8DNxDHfzr4D8fbP2IDro3lzRqAhx0Q/X8
	 oOUfyA2Jfz4o+tqTtUNiC0VlASD6wFKHy4QFEoT9kKWTZFX1VSEI42mdoXgQfv92i9jXd
	 7bt+WoW1/D1w3TuhszBZLowumjSd2pZPkUtzEbBu4zpyUl6igoFZ0YfIOXK9myCnbiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150034;
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
	bh=wGa9nKhsvEuH9+SJjKQUgUv9YrHik/6jGclCnhpejbE=;
	b=JMBO87DNvb+W4fCu9Y3fIUgnJpJkwnQqyzJ1GhvOITFKHdZlVVhEtUHHBRg9/4TNLwts
	 21p+0bX2urzJvBwixScicDVPuCehOWtSNUzZD6xnrkUG9fPGA6QOVq2AUWI1u6U9LWfpa
	 pVpsfT4ySXkiEZlpTSdk0o6Xlqx5qlCCN443wV5pSeyd7rMO4OyBBh8+QCM/9OxPWBtLG
	 ++Me7mWjMCM2wORPdQgfBicIt8yvyheKYvx+j8htws/T4TXneVrdgZxLv+TRFyyI5seEw
	 Xd0dYvrBf6JEKa4UH4nv1QIkdcFCZEi8KdvFetsWyVkS80Zfd2OGhWiO7kvfwDQe32A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=k4bBnLMQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AC60A2602;
	Fri, 20 Nov 2026 04:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995AC60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=k4bBnLMQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQOYGypwDaWDv0I27jAqGStWTTwCeZU8VIze53YfoIcDIeS6osfvRtm66Iw4kYfazSKsXD6/Vg2Wc5Hur/LL2qfDiAvrXSFlBALSnI9QGHbZF2USWJ4+uOroUK2cvt+VDgiCGH/nRLnOcpVdzxMEm6Xi68Bx/DzZaL2srWaqS++v3767OJqON4p6iToDaJ3BijombRovNwYo8lNaqJX5jGwahyhUtNkdJaDSiAYlyKee/pHDDRkYkAfsVEUDnkH1D6mb3u77+1ZcFVrmwFExTPfHzXbry3f/UzDf7TKTzRYZhcF6P01HrAHyuo4ixYSetDFqg5m+L9S3Iz+QY5pkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGa9nKhsvEuH9+SJjKQUgUv9YrHik/6jGclCnhpejbE=;
 b=PGkBtZTbxHoSArAIZADj0aejIZbj/vM9oYjFftPO86kiHyE3OQflddKFwu8J9uUXWsHtKMH5bX0bvBBf4j8cZwdTC0TgGKJwlX7PJOXOHfi0v9PH7LQhOceBvXM8/PuerWulE/wCZWBB94JuMnt6pP6gUAuLxUBO+vUFu23kwIjD2dhaLouAL2pmIAAbY0RawJDOzRkdULeCJcOTSy00AkSa55zRMlTKOL36Rd/V6NSIWgMPNwI5Q7oC40Kn3SFmZIdm5rF3L+IQjAfW+QA+czWlksL7GT1f11hJlBOzY+PsHHjFK8H0kFI/+RwmvkfU1SEFa+kcv+CxSe2sdEvKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGa9nKhsvEuH9+SJjKQUgUv9YrHik/6jGclCnhpejbE=;
 b=k4bBnLMQEsoT3zuy1UYLEnDTOkhQAYimYDxPSRPDdj9kCsCw//yOul6IUDmSS1ebioFtnKOaLNf/Wih7uwwYk3cXfuyGrJZEuE5hNlcAxvtL35Qv03fzpgQawbtpKn3TS2p/EBmIS41YaD6UcLjbCeWo8OfledOD6uXo69HTRce9dacZRGDFqFQEZiOYw4iMUcXC1SbS8AV8ZlP8Y6JWnrRytb506FYjIVFEcXbyozYEmDaqM8SiMrYDI3FWPxcc6zQuhtB5jxxfeDOffVhpZ23zzl2Qv3F0oiL4xkSsD0DlTPEMzDcuA4LzNJXhcua1pKgaSpAO2yv3FMrGBwEXxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:07 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:06 +0000
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
Subject: [PATCH 0/9] gpu: nova-core: run falcon binaries for the r000 GSP-RM
Date: Thu, 19 Nov 2026 20:46:55 -0800
Message-ID: <20261120044704.165223-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 193387ce-baa2-4b0d-5a39-08df46c1543f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261021123027099003|261021121427099003|261009221727099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261026121527099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KvKiqaPuUZODCuU+4/Z5rZA6E310IeHnpORPptrmHGQ9d5ajcpATwlRnOyrJVNX0o1WfS6yOsRC8Hr1l84gs2Nff6gALMcOV8RBwXEA37GeKb9Z7S+xqesmtQJY6jOUG7dAvfLaUoPrMwu8jpRkiP5+USTtauqVzGLmGamoFfofllYVpm5zs9P1MrahbSgw/Ci118Foi20se+aF877XXBGb9Rd1fnH53e10npsCgB84m2wC2oejvNbcO4FUJqNKiaFotUba/pfTcZQh1kLhA9XZvi3tYMDygG4BuO9L0J4Qkr7YYPOiBPUzg8V0Ozg1DW5ZKR5j9km2t1z4PgclW2enNKIIyj0npgWeopLr2+xQPY6ezeY+s9LvyGuxeVZ1XKh3RMiwJ132TL/xA/vV7jKyV15pQalqGbDw2vqALS4l4Lrpu+s24UTwELsn1XrX+2OTelShqUD168t2evG3y8gyN22iDv0ULAI9hLJI5zRRfo2WIwr4/r2MeVTqV2uvi7g5hmZvJcSNldPs0CEFeSft21FKQJ7t5jot/RWToHsFH8mpOJ+JEgZgiPMRHsaoIpz34kEsqp5IzDs24l5G5/RpGjp141zV/P5vfc6WB6GUwSFQQwQuJchpgJ3bRG0gn/lP8KYqi06w7HiAByC5CyMMGunmbQU04f+zuYIZzHQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261021123027099003)(261021121427099003)(261009221727099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261026121527099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3NHjkbPE9MkY/sJaFCayhECR0KiLVxyJ2IbBt1h758CcYA99EVweIWyKo6H?=
 =?us-ascii?Q?+9hRRacQ5M5SYPNR/G9rt0UGSC9/0O4b7iz2DVmepAp18gKJMz6P3ktz7yuO?=
 =?us-ascii?Q?QsFMcZcPKOGcVvHVwmLYtYp5bIyrBpXNmJJOJHlOwY9T6Vh5GtEDf823KcLI?=
 =?us-ascii?Q?XrWbP9o/Q2pbVMITz34hoXBTwIyOi+IEUHJnpboFsBkGKUHjYn6Y9BJ3nEqz?=
 =?us-ascii?Q?fH3QEmUmfzzVGHACsNQQvLKk3HSYtF7ubmuV3QRHFfEtrFdxW0kjrOuL5NCu?=
 =?us-ascii?Q?xPWNRASaXSs+C0wM0C3TtigOKlZdkPpjznYE8jzLUkE5TFviiraGDCzWTrGZ?=
 =?us-ascii?Q?JB/U5c5rThUofwgHqRBKewEVBsFlCPZfSV/bUefGjejLq3jznBzFZNWx29ET?=
 =?us-ascii?Q?W9+kBnb8RAWEqhEgEp7/0yGWHhAbvepcnYJHXx/BlOCkBFgGSscG4QYl4icZ?=
 =?us-ascii?Q?Kk76n0t21d/WoJb+2uaOCqti/F6IxMMdgt3eFvdhkosZWeQaFfX212ccDibC?=
 =?us-ascii?Q?4q2zZ9vDaLYuH4jNgqJel+6uBJdk5lYs7vbPamG59PWyukeirovBhZc1gCx8?=
 =?us-ascii?Q?i+ylUWoxTii5quSq23aSluJK9m7pSJvJyJlbvnwZkAjJgvp/cmImzcvP7aDJ?=
 =?us-ascii?Q?OZBBrb8nbaDGfcctfVicYqLAY77l2P2o7oTtTHk4ncnB1X0XLOrbtaD7y0l2?=
 =?us-ascii?Q?EvS8E7zwJ1Ao+qY0JDnFxSjD9+qbFTFsc2cK15ud1sjwOFgx7r2LEqbmCc1X?=
 =?us-ascii?Q?ik9A55dMvIcpyjh7iY5g5tzQT8qQb34huoP5AmWxs/jqOdOtU5Y0dZ36gLA0?=
 =?us-ascii?Q?sJ+a4FiJZCRWmck24w54bgCTO0Fk06qpk5fztZu4sXAwjBtnKAy7GGQZgO8m?=
 =?us-ascii?Q?+GG7dw8VCuDk/Byld6Hm1xBKF61McdKhNsbRpPROvO/XzGv7x6pX3rae/PCp?=
 =?us-ascii?Q?u1DgqwuC0us/R032jfy4ffsOgyQOwSB76M6S+7dZAgoRc3ODALFNSxSDImDR?=
 =?us-ascii?Q?OcrAUlMJAuk48T0ToLglnCp42sWRFsU+8azWd5pJRNAHusiqaJDa8KUHFjW6?=
 =?us-ascii?Q?dV1bKiI5iMDL8hG4wvmOYbgDQY7PYWZ4yoVKiHX1W0oBPkF1DvGnWXfIcFgP?=
 =?us-ascii?Q?qxYZXrxbJln7xlC/I4PEY8DyE/bGSd/aAnHdlAjoo4I+njh9oCDaIYcq4t4D?=
 =?us-ascii?Q?Ie8pNkqYv/wtKu+MvdruOG+1U8SeO+fDRGuPN7Fm6mYY+AA9Eo9xsANUXDb0?=
 =?us-ascii?Q?BJiW64RWqUwJYzK+izyZxF19uz6ehfyBfbOtj2VMUswopbpq1MxX+cWPvwny?=
 =?us-ascii?Q?5DKq8y9jBzFUPI/t7OJNPyXn3E8nJQpgxxw1wV8acQN/NyETFLWQYBys6Woi?=
 =?us-ascii?Q?CdMc7BLrvKv+ZrI6C8k7KW3AVUNQ2cLcfyKfqtjrCuE6P5TN/VDOXN/hQ8Sw?=
 =?us-ascii?Q?6i2SxzVPQ+uxqpfkTbYLAaTblq8JeRA3lDkxavT5Q6dqVrnyNBYgcJRI3PBE?=
 =?us-ascii?Q?jATe7+mn1NjJ1EDJ6dnvvwOVoCO0IprnKJzyepNZhoUVEuvs+mOLDbppGQCJ?=
 =?us-ascii?Q?8U2IJGJnzEiYvwKUM47NS1FBPIQ7kKOB1eGMZE/rE7WYFHrm3QmyvhOjpGqR?=
 =?us-ascii?Q?5u4e3NtOlpT6SwKvrlz2GKv8vFo95Gymd/NUvU9MxWYfemVM8y1Oyof0SFBy?=
 =?us-ascii?Q?9F1oxua50n0oRvu+rtN0dNudctoqqcXMYGcglmrFRnbmxkI8/Tm5U0m7NmaK?=
 =?us-ascii?Q?bdOBGxtZOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193387ce-baa2-4b0d-5a39-08df46c1543f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:06.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqEKRqWlgzl6Q+3RksQKu5kKacj7alinf40EzalJNsGGEhch5+XBE9OwyA1vaIdUTRU6FHnka9+5ldFt0+JTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

This series adds the code that runs a falcon binary on behalf of the
r000 GSP-RM during boot. It is the next part of the r000 GSP firmware
series [1], which moves nova-core onto the GSP firmware of the r615 and
later releases. The patches do not depend on the switch to r000, so they
are posted on their own, in order to make the rest of that series
smaller. With these applied, the driver still boots the r570 firmware.

Some background (perhaps a refresher for some readers): the GSP falcon
has two cores, a falcon core and a RISC-V core, and only one of the two
is active at a time. GSP-RM runs on the RISC-V core.

During boot, the r000 GSP-RM requires a binary to run on the falcon
core. GSP-RM raises a load-and-execute event and suspends the RISC-V
core. The driver then resets the GSP falcon, loads and runs the binary,
and resumes GSP-RM. There are two such events:

* On GA102 and later, the binary is a Heavy-Secured (HS) binary that
  GSP-RM has placed in the framebuffer.

* On Turing and GA100, the binary is an image that the generic falcon
  bootloader loads. The event carries a descriptor of the image.

The series adds a handler for each of the two events, and a dispatcher
that selects the handler from the command ID of an event. The handlers
share steps with code that the driver already has, so the series first
factors those steps out:

* the wait for the GSP suspend, out of the shutdown path
* the BROM and BOOTVEC programming, out of the PIO and DMA load paths
* the core reset and the core resume, out of the CPU sequencer

The only change in what the driver does with the r570 firmware is a
slight change in the appearance of two error messages (mentioned below).

The series also has one patch that the handlers do not use, and that the
rest of the r000 series requires: the PCI domain accessor. The patch is
its v2 posting [2] with the Reviewed-by tags from Alex and Gary.

The series applies on drm-rust-next at 0dbf41fd03ab, on top of one build
fix that is in v7.4-rc2 and not yet in drm-rust-next:
commit 57d916a3eb76 ("rust: bindings: derive Zeroable for bindgen's
opaque array wrappers"). A branch with everything applied:

    https://github.com/johnhubbard/linux/tree/nova-core-run-falcon-binaries-v0/

Changes since v3 of the r000 series. The two handlers and the dispatcher
come from v3 patches 15, 17 and 18:

* The handlers now use the core reset and the core resume of the CPU
  sequencer.

* Typesafe handler code: a handler receives its decoded parameters, and
  the dispatcher decodes the payload of the event, instead of using two
  raw byte slices to describe the payload.

* The selection of the BAR2 engine ID is now introduced in a separate,
  small patch.

* Fixed two error messages in GSP-RM resume.

An LLM coding assistant (Claude Code) helped write every patch, and
drafted the commit messages and this letter, all of which I've edited by
hand afterwards.

[1] https://lore.kernel.org/all/20260918010719.1176945-1-jhubbard@nvidia.com/
[2] https://lore.kernel.org/all/20261111200549.160806-1-jhubbard@nvidia.com/


John Hubbard (9):
  rust: pci: add domain_nr() accessor
  gpu: nova-core: falcon: factor out the wait for the GSP suspend
  gpu: nova-core: falcon: factor out the BROM and BOOTVEC programming
  gpu: nova-core: gsp: factor out the core reset and the core resume
  gpu: nova-core: gsp: fix resume_gsp_rm()'s error messages
  gpu: nova-core: falcon: select the BAR2 engine ID for framebuffer DMA
  gpu: nova-core: gsp: add the r000 load-and-execute HS binary handler
  gpu: nova-core: gsp: add the r000 load-and-execute bootloader handler
  gpu: nova-core: gsp: add the load-and-execute event dispatcher

 drivers/gpu/nova-core/falcon.rs               |  46 +-
 drivers/gpu/nova-core/falcon/gsp.rs           |  15 +
 .../gpu/nova-core/firmware/gen_bootloader.rs  |   8 +-
 drivers/gpu/nova-core/gsp.rs                  |   1 +
 drivers/gpu/nova-core/gsp/boot.rs             |   8 +-
 drivers/gpu/nova-core/gsp/load_exec.rs        | 493 ++++++++++++++++++
 drivers/gpu/nova-core/gsp/sequencer.rs        |  48 +-
 drivers/gpu/nova-core/regs.rs                 |   2 +
 drivers/gpu/nova-core/sbuffer.rs              |   1 -
 rust/helpers/pci.c                            |   5 +
 rust/kernel/pci.rs                            |  16 +
 11 files changed, 582 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/load_exec.rs


base-commit: 0dbf41fd03abee01a37a83336ed84cd5812af633
prerequisite-patch-id: dba3141a4ed9123a37958daa1a27e82669d64941
-- 
2.56.1

