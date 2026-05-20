Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F013438B3;
	Wed, 20 May 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779236524; cv=fail; b=Tq0uB4rLuiQwduTtdjOSjOIdWU08WDvGRvohf9WcY4ZrUAgspjZWY1Vs0fNPq69m+caCE4ocUIshzpH7/8hmq7QlWeYIxqQoHjXf8awNjz6DXPcWj8CT+XoU2psX+1fvBS0BzKMlpih3ZZM3ula6XJ1wYs896XTL06FO6MtJfDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779236524; c=relaxed/simple;
	bh=KXO76XJnjYNcn3QJNocpeN+NtZxKES3mPSpf3I8AqsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrUXC0zB4KkSjwA4nFk5Xwdf+JQ8Qc7H26MAKsbAYTwNwwZItOcTyPzQ2SuULhHizJNM1gMe5JeT+x3VLDvOZua2fT8EijTas6Dqu6vKPuk6begWICjHZKDaZJwErxk7GJN+HTQ7spSn2ogrUxLGUQIN9eqR3nc40uoqz1Nw/Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tn8lsnFH; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tn8lsnFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3upXZBMZ6X1DKGcmvhYgIBqiQOnrGn0A2egl47nsY/J4khvPp4/42HqM2s0QZmo6r+ict/oioinhp6SNvUetkpXk8/M/dagkKHCSB1B4GPZTx9uBwnEQIjnzuqdmweijnlmYFiRbl48JymJM/a0qsRSnv1LO1z/eI86Se8oGS4Vl8lLvVf+dQPKg+Df7K9eRgYLC+/xUKyKuRmbAL5xPHLFa+N/RKrlxzwD7Mdlgla1VWkftx+GH4gW74gVkZebHee2G0f7jg7c1rWKsTsMmZdFXaC9XzGbsbygSE/VFYZqwNM7ideEdondJGh2bExn5r/i3OgQxr/Is1sfGAXeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN0T134c5RGWRNzxFXHaqO2CazCX9Xl+d0DADm4/AlU=;
 b=Ec0pxTD4Lpi1+JQJLL6beoJZc3WMnnq52H2FCjLPB7wGJTBb9LH7dxfvkTnggBn058aQ671byL4pAPXn9IRPwQSzr+bQllvNc3x7aLCgF8pF9PV4xAR6K+WuLpXwd/cbQwgDTwLkinuiDuhp6hf1le2g+X5MpcBX3y0Mzih3bSOI6XIOUu+mn5EhDesCTFISW/rIJ+aZYvQVpNp1D7A8E6wlQbD7YIF8ZkEX4aFBbxBg1D+yCOj9hQzMg9Jl4yrvH1K3NBZmHFJacMf1VFpWdV3Q7Qk6JgJAN5778FAVcpvpHqz2BxE+wbK4d4OVoEToGBMVTdWPy738ru1O3sToTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN0T134c5RGWRNzxFXHaqO2CazCX9Xl+d0DADm4/AlU=;
 b=Tn8lsnFHh3vP/lAjD/YYF/+PzLLBuKdeCQHA2JAzyRg9tF0TT6UKzvwojafFqePCi9YdFhN/G88dnHNCwFJ0gnRG+louyLqcG0PssFsTbXh259CIWfOnWK3RpvgLBOD2vxESAYtlNsJ/+lL4HXAi7RnT4mzdyawqwZqHFpbKwvC4F1XfmgE8aufZOnCnaNn1YvPr67N0nzlZTeF7SX8zegxSOFE28eXanCKW3eJuSz8WXZEGRIM3S0t+89r4ObRNZ47+887lzFOxNTXcxdD6j97VOZX9SJAZHeKfzlt5f4HswfvO2dUQsdTlxA1Sq3nkEsL4A19vh42r+fHNQImOsw==
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Wed, 20 May
 2026 00:21:56 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9d) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 00:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 00:21:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 17:21:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 17:21:38 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 17:21:37 -0700
Date: Tue, 19 May 2026 17:21:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <agz+kL2S8kcgHywG@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260519230204.GM3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 015dcdc9-e729-4f21-2ca4-08deb605cd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|11063799006|56012099003|22082099003|18002099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6EsjKxyKAlbTnRjoaHqU/0xcO9Z57FOv5tMzn2lTbA482hoX4qcoTyJdQrX7Q7P2Rh4XdydVR0z0jvJuSwt3dj/mLwvRcbfe77DjVhuP16zeDD4uZqf8Hux3gEkcFz+fSLvauYhmrK5wknrpM5quszwi558oyE9fJ0oOTmjFrTPsiOFB+kaQPPXxKHIAMhpBwP6a4/bsWSGi9zfKJT8x2Pt/HQ72kITpn0Y6J/YRQaqDoGellKVKdLeKCCKcpgvyZBpsboaljM8j58exIqo5BlDNpOE08847b0rXTx+TcShLX1u6icCmZG1DNVTZk9w480qQV314i0xWu9pQKCQ1OD22Ew+zA4gECY6TsKisTfAceFkWAVpnAoUpxA9DF08FxIqjec8rYjMXq/RabLPmqa73U0rJ/M+oLIu/sUBKubIWhYv9pXYLNiD8iShiJrvqQdHgqZO5siot7kw4xCQYd4bDEG3CH/U+WQ1gjlK4awR8xYzcIvBTqIoqkXMkYnb4julIr7BGnD2gxcCQ6n4oPXuqueEStTZ2XaOokMWM0H/bFryZ9e7zIqjyAUsVovJFgzzKAzk0m2q5TycQZ9NxkhEStvsnzlvImN8VaCJZ65LzcrublIqiITPyPeoJXhsYvpB6b4MQ5ixEQN2QnO8x11SBWz4TaedkgTZeydY18TtRCvoGn2L9KUKPbWKIIpAr/QQ6+h4gSXlhpjYflmmALjI4RdCGn7XMSLqavbwjzM0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6lUpXKiSQlK1+PGd5k0BHrOYkvwQkw9YOp/UyLG3N4HiTELA80QrqLrPI0s4KxjkOrKWIT2I7ySxtbsvb1D1t7q/vJaEwcQ78Usur2kfPXWIJYe8AWmVQmBa41i9gCgnb9Y8pAwuADPK/BWchI6PsO2B7VBYjwQXANmI0CAVNcoGexCvfxYbtDwMpt7DCsUaeEsrioal+DKRnkRgPyDkl3VpWzEse2A8mzrVTKLFSEVDyHr4rLPgfE5F3fL+NIS8dr82iRr5yhtUFDBZTH2K/wohTzPiHFb/GmhXLMaUhqyMq/1U47n6uRseCsUfP5YlfcZtdfpi47JzecZ/VS7gc8ziZ1fSKc73LnHwNXXzpI8KDcWlMMYHc94uY9AC3WJz4C0CoFG2T72Vkq3gQzgBXCAJmJYv8ZVQTDNEEPX0zbumKD94VfSGlhuUjooW1EDm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 00:21:56.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015dcdc9-e729-4f21-2ca4-08deb605cd0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

On Tue, May 19, 2026 at 08:02:04PM -0300, Jason Gunthorpe wrote:
> > OK. So you are suggesting a quarantine at the driver-level only:
> > 
> > 1. Driver detects ATC_INV timeout during an invalidation.
> > 2. Driver retries the commands to identify the master.
> 
> I might argue to push even this out to a followup series given it is
> complex and I suspect it becomes much simpler after the batch
> removal...

I see you suggest to treat the entire batch as ATS-broken. Just to
confirm: without per-SID retry, that might falsely block a healthy
device in the ATC batch, right? The driver now batches all ATC_INV
commands via arm_smmu_invs_end_batch().

> > 3. Driver calls pci_disable_ats() and clears STE.EATS.
> > 4. Driver marks domain->invs ATS entries as BROKEN.
> >    (optional since pci_disable_ats() is done?)
> 
> We need to stop sending invs otherwise there will be trouble making
> forward progress.

OK. This needs a surgical invs mutation: maybe INV_TYPE_ATS_BROEKN
that you suggested.

> > 5. Driver sets master->ats_broken to fence concurrent attach:
> >    arm_smmu_write_ste() and arm_smmu_ats_supported().
> 
> Not sure this is needed, if we race some attach then the attach will
> re-set EATS, get another timeout and clear EATS. Doesn't seem worth
> trying to optimize for.

I didn't see that coming. master->ats_enabled && state->ats_enabled
in the commit() for a concurrent attachment would issue an ATC that
may timeout again to re-start the step 1.

And since arm_smmu_atc_inv_master() doesn't use domain->invs, it is
not affected by INV_TYPE_ATS_BROKEN. So, ATC_INV can continue to be
issued in this case.

Ah, I feel that we are walking in the mine field where every single
step could be a kaboom. But your insight is clearly a safe pathway.

> > 6. Something external triggers an FLR (sysfs or AER).
> > 7. FLR goes through pci_dev_reset_iommu_prepare()/done(). done()
> >    reverts 3+4 and calls the reset_device_done callback clearing
> >    master->ats_broken (5).
> 
> It should restore core/driver/hw synchronization of EATS and the
> pci_enable_ats() by installing a blocking domain. Then it can go on to
> re-attach a translating domain and everything is back to correct.

Yea. We probably could drop the master->ats_broken, as done() would
be seemingly sufficient. I'll do the rework first, and see if there
might be some corner case.

> We do need to push a pci error event (didn't see that in this series)
> so the driver can catch it and start the FLR process. I suppose that
> will still need to bounce through a workqueue, and once you have that
> it can also set the blocked domain prior to calling out to the driver.

In the specific case that I am trying to tackle with this series, I
do see AER error prints from the device already but there is no FLR
process. So, I assume that, even if we push a PCI error event, that
wouldn't necessarily trigger an FLR?

Thanks
Nicolin
