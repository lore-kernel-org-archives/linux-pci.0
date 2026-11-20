Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150034;
	b=EbEbhJbGA5YaYkPa7a5xJdZ5E/On84ID8YifFIJBbVLCpxkqtJnWTnVVNhRg9h4Xp/MT
	 kR3uVdvbutxoN+2xwQQ3mgGIpQYqwUiyS3++0Lp33FMJzYdgI08je0CFFEQBB0DAs4qGp
	 qn6XU71nvK6H1Xj8KYHyB91V6lk6j3d9gkaz/zWvnblhsaU1eDajSZYPPTHy72LaWKMgR
	 rfhYsggbx75B0x+zZGhh7QRRlWIqH55eZMOYT3mCt8ys0KwvdDB5lIajzZgJADE23tnPv
	 tw4yrof5mvoxR8jjMfAy+TPSVbRVqFwWHInz+eQ97il7TKgz2iyHbM1g8MU+UP0C9xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150034;
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
	bh=aMXa3lTkYUXGyOvCKZGh+fcSniTZoqrqoh50oz5ZcXg=;
	b=gMIhHeNPkGgKUznuOomisBpJJ2+am5QOLYGe+xSPu+v1Z2qRsmcyN4Ktr7IEa3OhYZEU
	 Ej7fxBWkwFqloWN9N7fI73U6M/34iY7OtXWLcgphbxQduDX627UFwn7jyZMnfmxHA7s60
	 bUsXr91gbycVvBfz6GOKBSwJcivD0bddl2BfKRa65RoUVGdvFKJmf+ydxWmHViQtfW0xQ
	 xQHM2mm1BJu2uDnNlkMkiznvJ7DAy5N5FMxFVXUzmNEH9HCztMy+mKdPFA99Mx4tDwB9u
	 4tOsNh97W2wDzFFOrAexalX4HS8Ewiwf/XmOEvlXtqO4iw4242vRn8ammeq9Ykws6KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gzOHsOCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C960A2608;
	Fri, 20 Nov 2026 04:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 415C960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gzOHsOCY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGFiFYptSFGtBmdb8GZuucLActIyPbsDtHm9Q+hsVwGOCsxCZt1/0qGzTlq8fKQT1a4LNNFkSEFmaC24SqCG84R1sY1cDLbbps0KuMtaEJw+T+gSEOyL7sIdGxfaIhjRFbRYJGrw9VBdGMzpu61UcRuRlbOLc7iwEG2BiuXAzqJ3R9U1leqM9XSUQjTy7toefuXigNdcLjA6E9jSu3bzO9GM7tDiqGCbLt7OnH3rHZpfrm+tSZ8SjCNFsEkQC1ZzDcATpZs8lH9f6N0kdMErFZYvdhwaZSwuFwFudyUT67KtaQOT8fQ+iXHKePZhbdlXQJQIJP2KUzh8eDOK/zuCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMXa3lTkYUXGyOvCKZGh+fcSniTZoqrqoh50oz5ZcXg=;
 b=nKqYDYZ7dVR8JuKt7IPiR/nZgKeX3OvW1MU+r4Eg9axmXwuf6BCx5iQp92vjwyeWRQ3pvIHTK9+6kK5E/NbQZw0KeNFlVfUbrJkfJu+Fc3UTwsTMaRCio69f74LLSTx3UPB3yM+P4jpg+VYiSFB2HReGPKgyUFcG2VuhbTvLCJPPiQNWuSWfBpdg6oBnVKucMGbmA17/eo8NTdixipHPcZOcn9aXWjqPT0SuqlMbuuaQs1pPYb0ZgFxr3dy001w64V4HdjUd45JP3g3ezWroOIEoxlTotVhx3fdRJWo2ESacbyw/704rdgD0dpdrZ1fkebWOdYPyjnig1VXDN2Q/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMXa3lTkYUXGyOvCKZGh+fcSniTZoqrqoh50oz5ZcXg=;
 b=gzOHsOCYjMLpAcdnMkivo4XYN9vnygtBJF5Wyul47++vXozXbyv5n63nKkGnjJME4xXo+zL9EycuofCLra59WqI0ezDxME3MPLZ0PbLTsLvNyiDviwiCjV+9Kp625ZAVVIZR5x/Joif0Bi3t36IWKtgjIsJZscU+Cem1lGAx9Y6e4oUI+IM5fUXSKwPKfXkx8jKJEQqifr9koKTo8MpHPwdxO/Rp9OgFNzMc14+U5B3RyPuU0Jm/Q9TFzdQaJUoYUkS0hbOeOAACFfkzBKhcH4ovyWaQaFcJJkn6U+j8frFzmJvqQEwKpS+H119OuRcMhYA7tlxjK0BuASeKTHvgYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:10 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:10 +0000
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
Subject: [PATCH 3/9] gpu: nova-core: falcon: factor out the BROM and BOOTVEC programming
Date: Thu, 19 Nov 2026 20:46:58 -0800
Message-ID: <20261120044704.165223-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 79e97475-1709-450f-7d8e-08df46c1565b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IEYKJvhY2BRyKAwtqs8DjdnhIZ15arZiM4UfnmpyYWR5n6v9gZejsWQPA+uAq6VcWtjwcoWgQouXNikClqRsOqOltxn9KNBYG0y2r2K+fMkdh33tJUuQfyJbPzCkPui4me/NGyk9vT8hE9JpG0H74AlE1G8RO9HHujyj9NFLZ3Ygihf3NQcIl5hH+GsnRmAHcN5DOoWY6ymWCO1/5uLhPMGBva9YJhNy7xWmX5sg4r/ediGc1tx6wMBqZL3nRfNp3rcckfeZRsNOqHEO8oDAx6dU9ac9Qg1aSFAE0yQL7tfYbINVbiQIuN2GTNcdXTFzwFLztNKvfWpwluZrQUX7DmqO4vCIhC3+D9x7S+jCdRQSnpaB4bn6w+qZb1PT/gY9VMjHDFq7dEWoHe4errInrHpaKBZdmClYmZ3veXcxOxpVwbcp/MHdKlqeE4bNkG5iDAWPHu+0yauoCTbRH57IDIwlLYZLKJSdIysfSf3xml4ZO9wX6Xj0LcfijKNOnv238k8DgGqEwIak753JObpahQPDknLywWzO803bbMMsuQfeKWLE4S31GncBiIGNaOoGUYxiOWz12lvpHgPPYj9/ybmcQ2CGFHdzLH1Lp7F5BEEU2B6Tbp64m0hg78XjlEqp0fXt6+z2/mUtNh11PVSgm3hYf3rIfnpHCz6w7lpchDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAD1Rq6jEydBy7gMtPpgwzKQz1oTTUJiDuC9Ol9QHL5LjrgKaXvMIPiKJqwc?=
 =?us-ascii?Q?o+lW1TMLHFygooYrhXrFRyy93/UGtKLQoQ/w9wzELTc35M+IEkR1pJqSDP4p?=
 =?us-ascii?Q?iJWoGkDbYmPmZugWj2EyH+/MAE1ZNIkQWuuVintUC7z/8xXhLHq/uVT63FHQ?=
 =?us-ascii?Q?00+MFeHDwcxWx3kmfed37Z+XKCRwE2kejEOtdyeaKj+DEX2aMYfkeYodAgHK?=
 =?us-ascii?Q?/Rk0ojAILpAxk/7pAjCPbu/GH9Qdm+Y3CvCuQZwCT8qXOshWXUKPGCXhsFNg?=
 =?us-ascii?Q?HhFvkU31lhfo2c4Vt+tDHeCA8RjICLHYF+lmBVHzCTay1Cog+iJZszMTiIzN?=
 =?us-ascii?Q?XiGojOP9j82fVDu9IwzdhQ3ekUKGfnMrzGTFzuGksboFcdQl16aV+7VDl63S?=
 =?us-ascii?Q?RGrMFplt1ORmTDQMJ0ngDFdssPqMjA3/l2jWECHUk9HKZ8NDA59CUTv1+ySW?=
 =?us-ascii?Q?sCCxntBBLkfChbwOJQBj3VvJPZgGEzLChV2Xs5OGOXvhRqDydNT0S14WdSG3?=
 =?us-ascii?Q?5ETH0MbKDpY/mDmXYbO2Z6vHxeXk1VwBhdv7AvB97yUXDRgQwayGJdBQaY1l?=
 =?us-ascii?Q?VNh9PRIDhDu5VHVXu0voyXHtHZvLBElm6OQRryCObWZBJw/gkwnQ8xPP0tH9?=
 =?us-ascii?Q?Ot0kxTqte3yvtun1J/WJrmdOqHlSnqEv7p+LmMr4AGTSRwasWd89qTb4ni5J?=
 =?us-ascii?Q?1WpSk7EFPUHKpbE+uDuVCTGH8MRw6Zed5wUaJ6eF0ii6DGWU5oaf1gwQZFjD?=
 =?us-ascii?Q?iFO9UMJX+CZHU+Agjz20Yzw5zfLZKrTE2PW8agqIWxlRcoBQxvq1bA+nXS2T?=
 =?us-ascii?Q?4rRWIFPVrrPFNX1hg8b3oFv6wubee5OGE/Nkdqti0y28pL8YbhkzqF6xOx1F?=
 =?us-ascii?Q?7piNiMGasjTnBeHlfaLavGlJ0VorVoMfkJfWqihNNtAaDrT59cpPhQjFGXwO?=
 =?us-ascii?Q?aSIpbXFDpChdwncxe5KU5O3KNaQS9qFfezLZnSND+9bOUF44ePnU/Gq00iel?=
 =?us-ascii?Q?20yts95eekS0rvkwUdDcSHJJExWTJ5pfmwHib9gpLCmiPt+A+iLlq0+46bDF?=
 =?us-ascii?Q?mcvROrc3Ss+cFjWOc+c19HYg2DnXf8AMmctMjTfUHBN8dWkapJSmlKUbpRuN?=
 =?us-ascii?Q?6Z9/z705tieF3rV2yJymOzLCC0ULe77Jk9UnJLZZW1VWSq5aY5VjpyPGAklG?=
 =?us-ascii?Q?29bZamnQHPc1KLAqGrW5wLV1LIG11uQF8HXohHrsGsKycXX4X1naWa+6YKXl?=
 =?us-ascii?Q?ai9y4Ydor6kwC3Cnpup2z/Q2vMYfcEMRey8BmLrbd+pnj2NT4m5GmAiJYBft?=
 =?us-ascii?Q?GQ6SPBtR+UlD3Ll/iK8tcBJElC8+oeiRXPPZKwxItH4Mp+E5I46Mo2THaEeP?=
 =?us-ascii?Q?bcKo6D3y7RM/yleOZV7FSwifcVad/m8kJapuT/QBM1pNNWAYG3wmV4p1GZCo?=
 =?us-ascii?Q?7eNZw4Z8tLgeBcLPhmk9JADze4apmz4CZt7D3v0Cua/gf04gwl0PzJkNf3u8?=
 =?us-ascii?Q?9rxNms/TbGmW0FKEuMs57jqcaeuvwV8U0SL3bgopxwJR/94GsJ8Ea/Q9CCxP?=
 =?us-ascii?Q?SYPzY110ZkqfbNwiQXpivTn0Vg0PMhLINoQDkanUHExkWQj+0zPRfEUQh3KA?=
 =?us-ascii?Q?vBm5HO3LxA9dJRCGwJHWWMlgArE6XX0+UMDYSB8dWJElIkH2z6FHDxRRKPqO?=
 =?us-ascii?Q?oF9r3hzt65v2Ouc2RO7b1k7iIS+OQ+YQGeyAdmXY5o7ud0x39WR0hzokiCvq?=
 =?us-ascii?Q?vRLgJysD2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e97475-1709-450f-7d8e-08df46c1565b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:10.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ACsdBqQR0MKQcwjxQ2BT+UlaEUzquK2njoaN3XovLTgalyKHpQxjPm5i6Yr4VmOOnCEWDm+Bn5nkSbOwPTUoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The r000 boot protocol requires the driver to program the BROM registers
and the BOOTVEC register of the GSP falcon for a binary that GSP-RM has
placed in the framebuffer, as the PIO and DMA load paths already do for
a firmware image.

In order to make the programming available to a caller that has no
firmware image, factor it out of the two load paths, into a falcon
method that receives the BROM parameters and the boot address.

No functional changes.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fb4f1cad867e..28c37c82b8a2 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -515,10 +515,7 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         }
         self.pio_wr_dmem_slice(fw.dmem_load_params())?;
 
-        self.hal.program_brom(self, &fw.brom_params());
-
-        self.pfalcon
-            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
+        self.program_brom_and_bootvec(&fw.brom_params(), fw.boot_addr());
 
         Ok(())
     }
@@ -676,15 +673,19 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
             fw.dmem_load_params(),
         )?;
 
-        self.hal.program_brom(self, &fw.brom_params());
-
-        // Set `BootVec` to start of non-secure code.
-        self.pfalcon
-            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
+        self.program_brom_and_bootvec(&fw.brom_params(), fw.boot_addr());
 
         Ok(())
     }
 
+    /// Programs the BROM registers with `brom_params` and the `BOOTVEC` register with `boot_addr`.
+    fn program_brom_and_bootvec(&self, brom_params: &FalconBromParams, boot_addr: u32) {
+        self.hal.program_brom(self, brom_params);
+
+        self.pfalcon
+            .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(boot_addr));
+    }
+
     /// Wait until the falcon CPU is halted.
     pub(crate) fn wait_till_halted(&self) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
-- 
2.56.1

