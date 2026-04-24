Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F53ED5C0;
	Fri, 24 Apr 2026 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057979; cv=fail; b=kYYS/sLSp5HD5/by1DFw/SKjvFKgHZUrFYHLFG0wr5fdeiJykep3Aal2iprgEtjP+wD/jEtwQTGdqhuXFmKEW8N3sXZ7wRCnLjsOvFHjqwmIYXRipklIBYV2SMhnK30o9AG+fX/K3ZwYtrhlXQi73NPYFLhSjY1A1J1p0C53SbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057979; c=relaxed/simple;
	bh=YIcIEYqEzMKZuuw36T9IcCvY91VKyUMZ/e2wjkcpZwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMhn+3zqE9Vizi9atwPHIUKosQX3gCQJ4TfzeSjnJRfGYE3rWs3zOBbh55Y3T8pMwUnyduT1OdSNwBtFOUFTu4aYZH6Kk5qWh2Nl2/auyMu+QFRfMr44WLUcW5oImyCl04hOs8AJhYT5+3+eMyO3kX76aU0l9CEdi3Dy9Kh/h5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eM2mQZO3; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eM2mQZO3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMCFif/8WxvBQLBTo1EFVeA02MVpYCf/QCQkFFbCF/XjTuTiE50cawuOWN3i1fsXk2VQySBXj4Bc67jBWICmkiRms+y5YwBlJgkYpWTLjuD2EgUuem0l1GHq59sXbK2mbKRUqZ3jr1IszO3iNQB7LSvTy9mi62st0khYExeWcPDkdoC2GSBf4WXwc0666TKStg9AfTCUNRxJzb4rre9XbvagdQxkPae8Grqx/6a1dlXLeJyD5BxALU53ZL1cFIJsPNKAJZLhfcYmstAGSxCnsxPxGq2CY+gcucQcvxoLfhGshUdg8xuqwBCDKKrwVoxJ3m32lyMYm81sSxXCL8r4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/8FVfyx1j6IAH1RF/nR9TCTxzIhBd1Lcs3X4GTLgys=;
 b=pbjUaLTEMuqXCyMgnTzDjWTPRWZPC8RRLUoGPqCsY9Df8+MwcGb28mZla8UurolOmiPpyG0ghyinJNldVTHuboJv6of0Jo0ojdADziXBokKwVxYdg82vDurkNN7L/z3hcTX08tIn7Rp2z9bcRKUQAOYeqjP3gfo4AA6P5Se6+8lc1ecONkJrdB/tg1H23DLyd5oX5bO/b1JQYp+Req7pV+XQf7cfgLc2QXSjYU38f8JQk5kTE7ikcDVUx+pqDvUlERgZ2b7OjTMNT6Erkc7gogexmFexbP87cwv8L2fVXHU7kGv+nve6/S/O2JZvHLOLe1McctQL3NYGL0W2UGGQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/8FVfyx1j6IAH1RF/nR9TCTxzIhBd1Lcs3X4GTLgys=;
 b=eM2mQZO37icho9fUzwfy9X7Qs5gJSM1+q58qhNFvK050cvY+gQNoP9YZfhlMu+67yjnsIdGQIOmTFw3jnx06rM2wQmMZ1D+ZiGDq8feguDQ4yhU+yfez6mWOBCAnlcWET+xWl2vZsjA1wcbhv6PTDZORPjfD0WV56TTWsm8j7VT188JHBmM6gcr9pRUcID/bKOk7Wj8eR/kcSjD0ZjAjYYyyg9USWvspKyu/AUAKMIs60ikFJVFDuexjcblls83d1m+yy0sd36CUzjkrliXPIyl2ZOBb4V72wG7HnsPQQ45AmK8cvoig2fKXvrzooqTXiiYRc2WnnBvYkIdHRMjXcg==
Received: from CH2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:610:5b::27)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Fri, 24 Apr
 2026 19:12:52 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::4e) by CH2PR07CA0053.outlook.office365.com
 (2603:10b6:610:5b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 19:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 19:12:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:12:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:12:43 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 12:12:41 -0700
Date: Fri, 24 Apr 2026 12:12:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, Mostafa Saleh
	<smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v3 05/11] iommu: Change group->devices to RCU-protected
 list
Message-ID: <aevAqKFq7ATYk3+i@Asurada-Nvidia>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <12a224061de4fff9e0725909fd0ba4e14996ff08.1776381841.git.nicolinc@nvidia.com>
 <779dad61-d7e7-4ae0-83a9-8c5920222219@linux.intel.com>
 <aerey+ULGG589rdi@Asurada-Nvidia>
 <20260424131148.GB3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424131148.GB3444440@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da50109-f34c-44aa-b748-08dea2357bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kxJyYShzdGF4VYgjHFkQsRKYJUGmzu1gofksDD/C3iUdpFqD4yb76FThviHARCGL/lCT3ltr9cKreXP4ybBp/Y6IbIVq86RGJbz/2GEf4E3uR/0cAZT7K4jm53QbE9bBR1IKO+m3/ugSAyNdt6xkqJPG6ed/cEznwDqxAhOurAj/2NmrzcW9OfPG2ip5T/sUNLtq6zN3elYYRi/H+Q1wfAqqBAJOAHbIpIBH8CUmuYM4MOkwqa4PAzteBau23LE2VIf4ZWU9qC9D+1QxkKRMEfSZWPVDBxZSIXVOobilMAMzXGZfTqlJliQ9uxAiFfmtKeeg2q0ByQRWAzulmRKXecB/+ZubTQ12cUnLCMztwzIE4qokl7nCOOdTklexUG4eGzIyOFd0cLciZn1oMf3Mn+HHpjmXjXWJ6eR29D5roQk0qwlu3e+vAc+hWCBvpfFXukA2orSuEHu3qRmpuHQTO6hea7Exy+hGkfOdwSOEpVvqy1L/PxnmcuxiJ7LecQWueIOiScyGJ+KAzUG/MSEemJWYmmwE/V1q30HnY7LfwdKjLM4z/+2iKidjAq9qT6lEkBGvK795f47xbsNDJZ2yYMq4QmBRLU0I3IHMFG2EhupeeffJ1TpELsL8XhXczNHKP5G7lyHljlPQH6pgOf6ZszAQ9xSGzl89yJKlXCTrUtIvKQItqccMFV110Hn58ol1eXbvBPSfY0C6VmM5vFSzJWiXM332V0xf5Ummf6ud8OpjezkoVS3L3fsuoqblTT/LGMlJ2sC09F2UjQFpl2RC/w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jap90dX63RHXFOeUTL5OUT2bUtkxwWtQJ7geaciMsn404klYyeg2UPLteHlUdB2NAr0moqBp/UDt19XzfbpsebtZnGaFXFXXjBNKQAtD/eEdDeMOMojlvLf1YCYyNRuRH9W6BiACBcuDuhUSxD3Zh0uZabi1eTnzG03MUY9cIe2FMybBTHC+SNWXtuLtwdUc6yfGiUX6/ZrY59OBQ6qfJnbTNziy8m4sbykhNL8TV/jGKQz0RX4KwlsTz6woMZk/By3yMDOxDEgGqEHrjflw65hmPGPIll2/WfZNRwZL8OanJXf9OGiEC+j3JjFDwf4/aBptDMtAM0of9kh2UlUntpk4dgglx+OagghIHTPO/RY70H1YK3d6OoeugvvzBBkxsXrSGC6m4eLsIFirD1fbyzYR/0EN85NCVxyQPMcfQsbG1I9yndgWBtUvbG0dML7i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:12:52.6560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da50109-f34c-44aa-b748-08dea2357bdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

On Fri, Apr 24, 2026 at 10:11:48AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2026 at 08:08:59PM -0700, Nicolin Chen wrote:
> > On Fri, Apr 24, 2026 at 10:53:49AM +0800, Baolu Lu wrote:
> > > On 4/17/26 07:28, Nicolin Chen wrote:
> > > 	    mutex_unlock(&group->mutex);
> > >             /*
> > >              * FIXME: Mis-locked because the ops->probe_finalize() call-back
> > >              * of some IOMMU drivers calls arm_iommu_attach_device() which
> > >              * in-turn might call back into IOMMU core code, where it tries
> > >              * to take group->mutex, resulting in a deadlock.
> > >              */
> > >              for_each_group_device(group, gdev)
> > >                         iommu_group_do_probe_finalize(gdev->dev);
> > >         }
> > > 
> > >         return 0;
> > > }
> > > 
> > > Will the change above trigger a lockdep splat due to this "mis-locked"
> > > case?"
> > 
> > Oh, I missed this one. That's a good finding!
> > 
> > Perhaps we can just change it to list_for_each_entry_rcu holding
> > rcu_read_lock() and drop the FIXME.
> 
> You can't hold rcu across that function IIRC

Oh right. I didn't think too carefully...

I tend to keep it as-is. So, maybe just list_for_each_entry?

Nicolin
