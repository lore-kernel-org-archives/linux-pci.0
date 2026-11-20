Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795150031;
	b=hnAR2DsE7R++tBihQI/fU2V9+2mMQlXB7v2BvxjB9CzisDtNtygi3jWy2Qs1nl+VlGzn
	 XHlex8AfwF6OM2EoriocpYgaEkH4ZS660skmg4Smx+iqtKUNT2nFwen+8aBD6mGxGRWqQ
	 k3Zh8znrlVyjK2lV8KG26sW/Z34sZCZqmWOMIUmoE39DfC1nVwHdrpBcy+3jww2vOQ4Li
	 Hfa/VxSkHrZ3o5PsK5uL8TdxwKdNHmm+TY4gSdP1pvQ8Op0Z5p8/yvtpy3B5DoFliO7iA
	 b1nMhOVAs37kq4atcJD7qxahQDXbzMIUq+gWKCjjAYg5siw2FxvgNuYGUfiCwd7Z9iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150031;
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
	bh=igyRWpf3kdi4XqYMDTLUwaTIElSV6Tv9ZbiIBMVz4sI=;
	b=BIU2B6w0a3A3y2ScOyTD1PNc6iPIyoOzrGMc0YNyO7jRB1PcNfK3htbEB0qNtOmdnm89
	 LhiPg78+uNLa18bbdSGS6noXS/THLfrE551Jtpt5KTixWtcm+RmdTvKT/ICQsbJYA30Ml
	 fGZzSTizhGjQBLuPhVGLJybtcSopm/BR1910Qg5N7/wKxKgWmfPMchXrVKxoxfUi6yZCd
	 33J0w5t96rTnDw+MIElG/BLamf2j9az3EoBA4nFfw5kHnyopmAWMuzapX3k6yhi7zDfEl
	 /I/KNJVbvRWRdLZuTdYo/RVD4yqyVKqddsrso5gMs7WonLTe5eZlta7MAE+V3Cm2ZuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hwJeCIlY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C180606A320;
	Fri, 20 Nov 2026 04:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C180606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hwJeCIlY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpLiDfGUAyW+3tusnvBxf0n1bkWFNfo20+0w+vvWxInPe1bQa7IOiHi6YJZ+K3PxUjQZOflL+chrxPGdnFgdUdy/rIsMzgkQ/kZcq7ltyIUFEWJQ5kDqdo7o+HUosmo3Q2kDn29BGTbsVFo+ZeBdaAg5+sQ4MjvzgG4KLhBGvCydJMtCdDqK6iQgk3oldsQiuQ89cl3CYLzmI55DXT+Ao4PjPXwHsahv1mbvpYySlas5uBacPI5TGRX/hmGWK9wfWB3A0tztEqHa0XJSTZpqmdotoMk/lKM2xVP0nzAtOi14CT8wkit3X5CaqdJq2lMvAEPfkZrVa6j8DuVcug05sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igyRWpf3kdi4XqYMDTLUwaTIElSV6Tv9ZbiIBMVz4sI=;
 b=bSyoTcQXy2XHrzWXCx48/Cl0Bs7GcANtUnIOQSCMOhKkBzpQwn8IHFGeMlGGRmpoejY4Dv+zIUSdglK5saYixnrLPn403fYuZxE1TyxxFx3CdeEW+ePrYLfcXtmbCuI71nQGIsCodWr1CZxWlzhlPj/3DaI+gSK5yPrAn5tV5b1y7Qq32d34tWZnaQF4aT06Vgc3uILKJ/j1Wx4RcD+b1GyARokXwmAW3+MnGuMyQwVSNuJxj/h5+Bb+RL5WoaXGTrB7SpeGj2+DuPGcQai8K96MM/UVmQaWdnXCowciSciFV9MJl519FHMYUJ6TZ503TO85TerlOFYMm/S2yN3jrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igyRWpf3kdi4XqYMDTLUwaTIElSV6Tv9ZbiIBMVz4sI=;
 b=hwJeCIlYFHCc67y0os4KwAvfnL5r7srDaa336Xn2pav6utenIBNnxHp/YTcCdXWo/fmIjqPQrH8FJwxh/wZnqQEwTyAmwTuPJSmunV1Rowz9EoqJgPR9/RanoOgH9CSalmsRr57bppMSV2oA+gLk5n/mW6FYJm0WZpemeTzBFoJP73hYMxLFshiQQ6tiq+ajMUU8DaU/10iiZGPLVoDQY7Ul9jym/XU41akfA7UNfABm4ayltNIVo7O1fLo1jxJY8tOWYDoe/rtCcndgrj75rBwkyCWOdg4a7s1Wd8wupimWegreveINNwyf9tztmIiRUQRDUlApIH1WIQPmZ0qrZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV0PR12MB297887.namprd12.prod.outlook.com (2603:10b6:408:608::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 04:47:08 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 04:47:08 +0000
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
Subject: [PATCH 1/9] rust: pci: add domain_nr() accessor
Date: Thu, 19 Nov 2026 20:46:56 -0800
Message-ID: <20261120044704.165223-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120044704.165223-1-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To SA1PR12MB5614.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 00fd78cb-f44d-4702-050c-08df46c15500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009223027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Fqrg3CY/dx0tWLAhrif0+RKmK9gcZDvr/ykg1rBuWfwf01qBgfQvmosi1CLJJXHW39jX0Qdq5fulUFV2DDgG/QpFxraYGsgHqUlFDUwJaM36i4OR1e62decK/+PusZmjttrQhzQ6804vKFQF4k+JjnUnHqOOGrTyv4zObN1PTJDjhkTuGb4zq/NbBL76ACwMFu8Fre37yBikqlJk2rE0zjHuTbHK3saPP0W3UH91XuX4utMq97F7E50qlIbFHZYU/D6/3IL3QDwigkW7Dne2awJDiGAqpuH2FB6AMh9fewvhdUs4ehaItpgcuKBeuu3P0zVREQHxry3WPMQZCk8MZzC130L0MD9ReYfD/8Hc6uHeWXyp1OuUfSPnYn/XkIIDZZYZrHB7vDzYvw+H65prPrFfy4MMbzw8TERCwnyqtexEmSTxDSXwjxbulFmK7M+ej7dyhpUv3y+FbD9XsrmEU6FtzllUu6Il8YKzs2FeH7WzfAwxJg+g3nYbpAFqGnkmSU377+PFVJhVQqvoKHYDBYmPCyEjURtia9Rb8s8NU/52Yx7TefOeFsOhFHZ4scgk1GioRGuKdTA/W6ksMcAbNPRm2aQJMJph+Wycsl+fn4WqbiOg0VdhXjoaFcFDg+qdHW3uPoQ9fwQZn0w+eHW1bHN+fhNwRkoq1eKHFhnmYCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JJmdm0kkdtvHZ+rE29QmSojID+/E+G9wksOy3B9r8fpFYcLT0ChHpfvr1SY?=
 =?us-ascii?Q?s8yGQcLt7OFDwmwsGbqeWbaKNv8yKRhQsU9w0Vaybf9EBSskOTHZZKVJHSE8?=
 =?us-ascii?Q?m7sc3MEPnfsoiHXr4V84b/rpR2OP1riXg9UzNV227P6gIpdFAPhos8RHorAe?=
 =?us-ascii?Q?ujgGioPkRyvF+NlCHW3tOT4NzRtmFIaXBVM3UQBsgkWUGlhDhCLIK9hYKADO?=
 =?us-ascii?Q?FqyBpfATIzJmAF7PAFf0MsvuO3FkqIszQqSEZXiyXPL6wATSJwhBT/yamedy?=
 =?us-ascii?Q?RFcYv/0XDooHksxsLtufK4eBy6Z7linfLaK/f7ZlHRKTNX86G7j/aw3SfKMJ?=
 =?us-ascii?Q?khj4jDJsl/RhYPacf3xdd9seqydc9l+Xdx4o1WM4S05ckILFEjda6hb/e3kM?=
 =?us-ascii?Q?xbMwVYrFaGX4umLt53T31T5PfPG4Io1UHf1Ti3woJUPl9Qa3rH6pmge/TIYg?=
 =?us-ascii?Q?SYznXral5yxl4YuJuZIuoaByThTxrT0Y3T23Jf2qdqrJr6hmaJ45JF61sazL?=
 =?us-ascii?Q?H+V5LpFaVj5ZtQqerUL7FjseWoX2P2+0Dq5PKsyEH+iCczEXJZk1znW9f/GO?=
 =?us-ascii?Q?/VGw8lhcTUAXFkV9mhxKzZk75dGysAlJxmw9TvU4EdkASp9xC68BZ0qr5wRS?=
 =?us-ascii?Q?FVNUmLsYCMHUCtlVYSShLWW9QbPx3vQ1/CklNsVCZrJ2Zq6cpYptkb0z0Ejk?=
 =?us-ascii?Q?kbgzEkm8nB4TRHOk/g4N0Na/GkUYRxhyhvzaJCcK2Zlwmd5hgHjJUSpbqKzB?=
 =?us-ascii?Q?PCuLytTf/yHdT+wmECTXMQu7O+CqTQ1C5gFd3L5Bmu1TUQcz7kFI+MyTOe1l?=
 =?us-ascii?Q?emyZcRLks/AlriGmwsZT/T/JAHmko2m6XdnIWtkkUcv1vOJW1+RoqCgigHxV?=
 =?us-ascii?Q?F0w67XhajO/SSqbNmd5ZxG5ymyZ8n7i8WwCzkuxBuk6x2oWOGuLTJjtyWunW?=
 =?us-ascii?Q?eIYxlZ6/+RhCfHVxhThrEs3ihLQ774HDfeQHDJX9om7GqeOPg3GHmvvj9+y8?=
 =?us-ascii?Q?qqmLYHzsFisjk5cxcNW9DBm2KW/6ORmww++uo+RPQPBTht3ODUHWOCSeq7H4?=
 =?us-ascii?Q?zA+eRRbz1BrFtL6mzpSvYDZA31jOXxH9+UaYsIWgw9DFM2gII15BBVC4WCqH?=
 =?us-ascii?Q?i/F62VJ1wbGCx/o7VRyIfAweu7OPhxtOUQj3M2OOUydF+pr/9R86QThEz69c?=
 =?us-ascii?Q?lPSA/aj8SLi2xOvuV/mjU4qRsNHzOUnVITUFWjpjrDQ8EhlaVr66iX9xIinx?=
 =?us-ascii?Q?Fekwj4sYhHiPPC8pipQ5W9m8tTAoNEJfCko8kmDB0R7QfY7NsKbqB35sVl0G?=
 =?us-ascii?Q?mVFknLZGgwCcaH1jWg/OqaKKSq90H10znDqht+6MxXJSTUU+T9JfyBusRK7W?=
 =?us-ascii?Q?sZj6C+/4K8TRbYTEXmmCSuZSoMqUMrfByz6RWnw+gQ6gX6oQkeDkp48+Lz1H?=
 =?us-ascii?Q?S+3ByqJlXWEVb9Q7PncUPs6iEDIMYvZ1Nb76WEdpBgy4AeJpaFYshU+nQAnR?=
 =?us-ascii?Q?+Jp5zJo3mgqzgAaBID/lgkCEfzbDv2aRDwNN4vaVcN1HkIGdHpvjqE1lNFnF?=
 =?us-ascii?Q?ZRbAMICnItS9SA2ov1U+grkivwPLGyLjR8hZpBgqWvSR5wdoG7aZQEICP2yk?=
 =?us-ascii?Q?OY1CIN0I8bVjIg7Ts1WI/BInPHNdOrK+mOKrZ5/EbttcU3GbKhwS7SRO7wa+?=
 =?us-ascii?Q?BsmS9qQU2fJotS01xUCtLZBbsHaTr65hSFf6FQgqY+PwM5WwvsDqLpPZIj0m?=
 =?us-ascii?Q?Yg6Y+XI9wQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fd78cb-f44d-4702-050c-08df46c15500
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 04:47:07.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sWuOqo5PN+exQ2qf7V8HeJrHxEOVrgtCmbrgnaPcNNEhJjULbR30uQ3WM5ft1IgeCFnxCkjrNSN3X2Nj3XFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB297887

The nova-core driver has to send the GPU's PCI location to the GPU's
firmware as one word that holds the domain, the bus and the device
number.

The PCI abstraction has dev_id(), which packs the bus, the device and
the function into one value. It has no accessor that reports the domain.

Add an accessor for the domain number.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/helpers/pci.c |  5 +++++
 rust/kernel/pci.rs | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index a8540f90b13c..a1e033531419 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev *dev)
 	return PCI_DEVID(dev->bus->number, dev->devfn);
 }
 
+__rust_helper int rust_helper_pci_domain_nr(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+
 __rust_helper resource_size_t
 rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
 {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 769d01d23429..60e0d8518266 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -408,6 +408,22 @@ pub fn dev_id(&self) -> u16 {
         unsafe { bindings::pci_dev_id(self.as_raw()) }
     }
 
+    /// Returns the PCI domain number of the bus that this device is on.
+    #[inline]
+    pub fn domain_nr(&self) -> u32 {
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`, which holds a reference to the `struct pci_bus` that its `bus` field
+        // points to.
+        let domain_nr = unsafe { bindings::pci_domain_nr((*self.as_raw()).bus) };
+
+        debug_assert!(domain_nr >= 0);
+
+        // CAST: `pci_domain_nr()` returns an `int`, but a registered bus never has a negative
+        // domain. A negative value here is a kernel bug rather than a condition for a caller to
+        // handle.
+        domain_nr as u32
+    }
+
     /// Returns the PCI subsystem vendor ID.
     #[inline]
     pub fn subsystem_vendor_id(&self) -> u16 {
-- 
2.56.1

