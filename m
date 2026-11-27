Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795773714;
	b=HXepw6KdEiCxb5B3kHlDFp7HoIOnN5QL3anzFc+P7WElt3sGYDWy3Vyi7vpTSb2wMSLP
	 XHeJg+3PbkcsLgJW9G2e0g4a1YIjjVvXGhlyF2C5jvy3JGXJkm9oeCu8YG0eW8RVLuBfY
	 csvo43dZS3ibYEWfB4pbs3ppwcGP2icouVTfgsX/Q0/tPEBMcVXsIIJSuPTjdgXTTJrUF
	 xtM5DyngHUtdRJGUr7+9ZjnCKvd6ndpgnkL1kNYObPSS4kjzCb/xZuCgheloG25SEQKOd
	 LNBG/M3Zyy+FaMvKjBojlmR8dh/pf2BFXP7IY5h2rIY9no2mEszm6ajLqKQ/lz8NjEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773714;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=l0w7m78Q3t7NafSqffnDLuqKONPoccVan1Yqy46w+7A=;
	b=17MtVZtb9ljayIXOt4wox8JFIt7jVwxzLC54t4I8U4dgVmCXsVlsqT0nwP2Wyf1YPeLe
	 lVKVk9ALX53Od0QqE9Kv2AK+RVgcRjh+3NAQj0klQvS8FzeAtoKQUWr5oG8cRCi0ZOSPb
	 TCXHLTiJcYqwTBF7DVjX3dO31UX70MZNdf5YvmAZRxaIGwt4PeNiY5PYYWpAZ+lAPA8I1
	 k/bGktYN0BX+lrLDVTB/4TL5IOwwYv9VXSu/nMKUCW2G7D8S4g4Tu7+e+XTHJulvuiap0
	 Q9nsKeeiN/2wqgvZ5yuSLTVExLJQVsHngr8DmPucLKTPk5lbesg1DcK3IFJTmYeLJRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hfGhu9vf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.59
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F5606A33F;
	Fri, 27 Nov 2026 10:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7F5606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hfGhu9vf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIl0Ry0EswVbofiZABrg18/soxaGjsQHWCaMi+GpBBGD3MbihGNfom52vbGdS5oaUt76lDhzW2QDH95wpB3ti+NBgZYtde6JyOoWtRfTU+4tRth/vkMK696Ex8lHeEn5E1jLrxqAIICtIghlfV4FxwnsCS6QNU9BmT/NKbyySDcUSAfIkreupzBLt1V/lqaSbBp8OvSWyQPBnGMDil1aTAAG+q5zpTFI11vCVYPb3FOhwdvjXkKYhUZKs+/3Ipe43UJnESZBUQMXIUNyrH+CVx/dWI5NO0ZOxyq/MqbdJDOyPmJyWHU3Os6VdzIwcrt4PhhfYWCgqpWnuao7JnseOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0w7m78Q3t7NafSqffnDLuqKONPoccVan1Yqy46w+7A=;
 b=HVucWkf9xuY8G+0A0VE3YWFz07/uQ17d7rfDOX6Ke56SOLqgnMolXNaTizZYFuu9ywNrAmYqHAE3Q7Jgru9rQWpWrXVdQbxclBrEXDtzCCCNpiKKl9z/6g1n0Szg6zq9/B6zOceTO7e8xBXrzDYehigu5oHgKF2Db360gzA49UJHAvvUD+vo/nE8dYean4WJJyAErPV8vEidRlMwKVb/xd+UiP2KWdOcuc1hTSzivCyR3PAlx58y7Tip22I6xQw+fwP23aCpLmuAllFf7I/NzRuT2ikYpnt/nnxrEVEJbDmZXsaBlwLrVqm1QhbkpSWSGc9BiXsMFuql1LJlbophxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0w7m78Q3t7NafSqffnDLuqKONPoccVan1Yqy46w+7A=;
 b=hfGhu9vfQGbENvcRA5asNK0tSwx66j5AIdq0kkUVOIb1+1c615ull1O2hfEHGY/xm4MBHn03aV5PRHmQ4o3HOcJqFzvOQDEoSLn7+85nli8df6WkIQvcY59rZlXxHybXImtj+XVjtSu5L9ltxAXnuOEVEzRzZcZbh/UTkICEfeM1i9+hzZoYGkvPZoyq965QvbbVQ4c8US0ILZ8DSxNZMprxDf2DwDbYravNxLkkYGEy6PyFM31sh7RsAP51STJnnuGmxLJhkeKjMQijp889EjSxDTLaful1RrK84Y+lP+hOBTyJNgeOyeKpaqY9CGu1Dz7NHMwsBIk44LEzoU5I5Q==
Received: from CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 10:01:45 +0000
Received: from CH7PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::58) by CH2PR18CA0038.outlook.office365.com
 (2603:10b6:610:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:01:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH7PEPF00000017.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Fri, 27 Nov 2026 10:01:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:01:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:01:28 -0800
Received: from inno-dell (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 02:01:16 -0800
Date: Fri, 27 Nov 2026 12:01:14 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Alok Kumar <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<kvm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<nova-gpu@lists.linux.dev>, <linux-pci@vger.kernel.org>, <alex@shazbot.org>,
	<jgg@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <jhubbard@nvidia.com>, <apopple@nvidia.com>,
	<joelagnelf@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <kjaju@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiw@nvidia.com>, <boqun@kernel.org>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
	<jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: Re: [PATCH v5 12/35] gpu: nova-core: mm: add VramBlock
Message-ID: <20261127120106.6f63485d@inno-dell>
In-Reply-To: <DN5HKLQK65L0.1L9NVW750P85W@kernel.org>
References: <20261124135937.18583-1-alkumar@nvidia.com>
	<20261124135937.18583-13-alkumar@nvidia.com>
	<DN5HKLQK65L0.1L9NVW750P85W@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000017:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6f90ef-a66d-4e2b-cad1-08df4c6d71b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|10067099003|11063799006|4143699003|261022105027099003|56012099006|261026140227099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|18002099003|261009223027099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	RWaKKCeTx/dM1sI3YzWoWaq57o5tUQLXVjioVZwiMiw3ZlBVUE7ZsoHaYB//K/UL3cRTNBTSZiWZmbFBvSeDEmO158vNLNmef3RXgVXkj49fjKq0Tz9jMq7D5uFTucCdni0dr1r+DbeZ3MJ4x9ZWxqYfShZXOCA8imOaPLQATLXa+u2wKezEBYqdpRfxzA9SJfYDZLPt78Z5w2Lvs/4E+2nNKOghUz38+hXOrwFtU0p5V4bcDzPJH0vrxjwD+12jRpYa4tPqgyR6L+q7/ja9MsWCUfr4xCxMYJb6e4KBkHdW1FArfq20oyzQpygFHJMrRGtJj5zyaG8YYCiLWsLXAJoRyxfajCv4N9k8euvBN67Me9yYgngpk/Rk126OTHpsUHhgZpeFFCemRnHTMrpV/Nuoly/qERyDK16qD4jdc87Ypeh+S2U0f/k5N2jyVQDm5EESbxb3eZhhQMaZgOz+YN0cjgWNBlYYtBG+CTGDz3mTTDB+2OBhIR9i2x2LI+ZSxttmCwHcaTTPXC35lAYvg0mDM3l16eSywg8MvVmkgs9N1X4u7tnprB0tBPjjF+/XHx/lUuVfpu0PQqW4bgNfLbPOpJP9YWR4rqnhiJEfpISvfs99jj2iOzAXtgc6y4RUei0sxAfKV2TGMxjmh3nb1pEGrjBrQKufMjR+6Bd8m/ayHOv2Tfe+jy0nnVn/fhtGJf1o9pUwSpVugY3B4K3MGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(4143699003)(261022105027099003)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(261009223027099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tL7ajNcNCeAA+x20392y0qsckveTj5DllMil7v7AqM3cZmBHKx9EQ5dYvQCmNO3J6gzCSFAB5RSN2urRMbQTS+ZhDJEzeWuHhunEOeWhrVXpTCpq13+Tf1MdONYtRTHs43Ya5bzkpaLrEOOwxQSXt0wLTXoza2nU1RLRgQ0nSXN3QcDQsl4/9fpHcuG7Rzm6rHb8kOCc+zkVNqMKfu2/5X+pttsgZW01oUwQ5cACeA8y42V0NstjG9ZO4FnoZjVc1yxuTrm/eTn+bNB9lgzeMv3iAT2ua6ohruGDiI+VwFqQE43s8Ctq5voFdygYk7HlvxBREqdDE0iyeqc1xcRaYGSKPoIwKv7kHBl6n6OF531DSDTozyTtYA/eDVVIfE2CUsku6+EREt6HhW/sZ+3JexhCUBG2k4Xlg0tqKW1iEsd4u3XCxWasdHswEjKiWLw4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:01:45.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6f90ef-a66d-4e2b-cad1-08df4c6d71b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590

On Thu, 26 Nov 2026 23:12:47 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Nov 24, 2026 at 2:59 PM CET, Alok Kumar wrote:
> > +/// A physically contiguous VRAM allocation.
> > +///
> > +/// # Invariants
> > +///
> > +/// `range.start <= range.end`.
> > +pub(crate) struct VramBlock {
> > +    _blocks: Pin<KBox<AllocatedBlocks>>,
> > +    range: Range<u64>,
> > +}
> 
> This allocation seems unnecessary, VramBlock can itself be
> constructed as pin initializer...
> 

make sense.

> > +
> > +impl VramBlock {
> > +    /// Returns the range covered by this VRAM block.
> > +    pub(crate) const fn range(&self) -> &Range<u64> {
> > +        &self.range
> > +    }
> > +}

snip

> > +        Ok(Arc::new(
> > +            VramBlock {
> > +                _blocks: blocks,
> > +                // INVARIANT: `range.start <= range.end` was
> > checked above, hence
> > +                // `address <= end`.
> > +                range: start..end,
> > +            },
> > +            GFP_KERNEL,
> > +        )?)
> 
> To me it seems that reference counting is not needed here.
> 

This patch was cooked long time before the VgpuVramSlotPool and mm
settled. At that time I didn't know how the final ownership view will
look like among those components. So I just put an Arc to ensure the
backing allocation stayed alive for as long as any region or BAR
mapping needed it, without tying those users to a particual owner's
lifetime at that stage.

And you are right, looking at the current ownership view, there
shouldn't be any user of the backing allocation needs to outlive struct
VgpuInstances at this time so we can definitely remove the Arc. 

> AFAICS, a VramBlock does not actually have shared ownership, it is
> owned by the VgpuVramSlotPool of the VgpuInstances.
> 
> A VgpuInstance owns a VgpuVramSlot, and a VgpuVramSlot owns a
> VramRegion. The VramRegion borrows (a range) from the
> VgpuVramSlotPool's VramBlock.
> 
> Finally, a BarMapping (also owned by a VgpuInstance) also borrows
> from the VgpuVramSlotPool's VramBlock.
> 
> Do I miss anything? I tried to double check and asked my clanker to
> inline all the relevant structures, and it came up with this:
> 
> 	struct VgpuInstances {
> 	    vram_slots: Option<VgpuVramSlotPool {
> 	        backing: VramBlock {
> 	            _blocks: Pin<KBox<AllocatedBlocks {
> 	                buddy: &'mm GpuBuddy,
> 	                // Allocated buddy blocks.
> 	            }>>,
> 	            range: Range<u64>,
> 	        },
> 	        layout: VgpuVramLayout,
> 	        fb_region_size: u64,
> 	    }>,
> 	
> 	    instances: KVec<VgpuInstance {
> 	        vram_slot: VgpuVramSlot {
> 	            index: u32,
> 	            fbmem: VramRegion {
> 	                backing: &'pool VramBlock,
> 	                range: Range<u64>,
> 	            },
> 	            mgmt_heap: VramRegion {
> 	                backing: &'pool VramBlock,
> 	                range: Range<u64>,
> 	            },
> 	        },
> 	
> 	        plugin_rpc: PluginRpc {
> 	            comm: CommBufferRegion {
> 	                map: BarMapping {
> 	                    region: VramRegion {
> 	                        backing: &'pool VramBlock,
> 	                        range: Range<u64>,
> 	                    },
> 	                    access: BarUserAccess {
> 	                        bar_user: &BarUser,
> 	                        mapped: Option<MappedRange>,
> 	                    },
> 	                    mm: &SharedGpuMm,
> 	                    unmap_error: Option<Error>,
> 	                },
> 	            },
> 	            // Other RPC state omitted.
> 	        },
> 	    }>,
> 	}
> 
> (In case you wonder why it says &'a GpuBuddy for AllocatedBlocks, I
> have [1] applied locally.)
> 
> [1]
> https://lore.kernel.org/nova-gpu/20261126221108.3768637-1-dakr@kernel.org/

