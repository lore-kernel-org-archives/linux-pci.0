Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841D3BCD04;
	Fri,  4 Sep 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553034; cv=fail; b=XQITBg0QmjH/w4IwNM9lon5D/CB9VNklEdQbuxsJaFrq3s457jegCpqwxu9YMuW7TPts49IA9lblCKvz3v2bmXYQdKTkAQArf52LmrzGkR6x48MCZtqefgx9lYpxU3aWCRMfmXwN9Um9l3pxxD3vzFBQVWjYB72saiyGlrldwYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553034; c=relaxed/simple;
	bh=CN9n3F5UIdovbyqroH23SBjgXs6hhlyjoBvftMmaQLc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzI5jTOlfapBpHmbjN8x0b7wTzrbF97m/zrgEAuZUXwi2CsH5Nh8wy6QS476VJOJMMBReYb4WBJ94MkPgXnmPw2ouoWXHMblPCIbBjyaMLpJyhpCQC0S/9Fv4nkZaZyt/Fa9EtrcX6PTdggN3nxAiOeB16zx57w5q4ghbjTAxOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wv/8y+Iw; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wv/8y+Iw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRtY931JbRL1V8vUaSry8pvYVui+uJlS8cXJKyebLX2poqNDjtMzZuhc4RwXPU79vFev1GMcMDQR/DkBXfAd2hxTkOz6zm6SwrGMgHmRaEengdu92sgJlefYWie84fZPfuFmOgGw9jJKrXHNdABvlT73cPOT7Iry3yyBOK2rPn7Ox5a93cGznB6fE/suOco6gnbBF3cw+Ayc8fO6SHHhVNycriw+/gu49np96V3thrhe3KHDmGZD9JDOTmJMxh/2LoZ5yMK6hnYqGLs6mj83z7WDEJ96gf6thEFVY+r6e64xva+lRBFfwWW/5vFnyFehJb/ep9Orb8wPYBt04LACtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdAmSLJebVhinKcoPq7CPjEUQ5Rr2lwNv46T1EU5zcI=;
 b=ycEaUuh6h/NYbCqkmaRuma1684p8XSMP8Ci/aThPAXqgQsJAx4jrTwXbGcjChQIZCjQ2SYzdr+sxlmfpblXg1UTPrLKrztwso9rVIVIvphat8d1hxboPilBjFGkzjdkimb8WkbwhnqCI+HI80Dwy2gKtoQpe8tZvpf8pWq0bXjDCtNtiN1JjXMNMwv7m5xEil+5U+GF+oFFASU7O0yg2xFBPnjDzN09CpqYsDHTenEFk5aTCHS+qMI7bGtpMBk7ZZVLg+EhvQ2WBPzno9rliSaIKIgAdwxs7H/nXuimhfpPBebFFurj4d+aDYZ4RSD3K7EY6koG/OxolB3GSYgkciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdAmSLJebVhinKcoPq7CPjEUQ5Rr2lwNv46T1EU5zcI=;
 b=Wv/8y+IwvJTg+tqLM0DMwqM/t89s1XMhNTpWU1yWWwi8D76Dx2Rnk1FFkta9cq0tokrcrDP06EVyYrPe+4TE9ZU7pRnsOKOhaOKBhLYl1KNyAvkxNO8OYU/RSRlW0AMlA22JFkVoEHOFJV2MxPjnwSYtFVBSHcZYPQJ4Gy98fqGBZZoyb5nKm2BV5/+Q/3NiWGCa0e/9kv60Q9VgLhYCAnw8ks+RIQkV/YvKka/+2kpP0tsX8QY/ijIUTFBEl6l/tHvTrbXFb1aiu3GwT0RPj3hisb7jCcuZIeo+xqUZTUo088jC+u2bUNtRrRaRnLqEkkPe+aRQ6j0hlZGDUtCvpA==
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 20:17:04 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::3) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 20:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 20:17:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 13:16:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 13:16:34 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 13:16:31 -0700
Date: Fri, 4 Sep 2026 13:16:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/13] iommu/arm-smmu-v3: Add arm_smmu_attach_release()
Message-ID: <apsnHhQAVPRN6AMJ@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
 <178846311316.1308030.7431615023426150106.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178846311316.1308030.7431615023426150106.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 48684fce-75c1-4720-1a2c-08df0ac17c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	p3BffhH/2gxNSDUIxW30ngWn36DvEY4lN5FBhvho4KeeU4j1iiv+71jcvRrnZRSRQO09KQTTq9tAfGUeF3WBI07iQbpTKwojQvJLw5mcEkNgoxXOj8aq+AxAOS4rjnqwMJyluIF3iXQo6aMBAXYbBqMpS4FLCnDeU/9fYAMOPgNEyxVYX2PYZZ92jNLtakRC8/a+rP8bNYxEFtfLeevFn5LG8/3qa81/k4mfplEf4p1lBiuuVwHtufYPqh0x26+F3TRoVwHhg5Qt3rkkYa+3PhfpDisCy1dj/+3PN5EJe18qYBoTZJi7q3hHmDpUwSnNWMZUvJX6ZOfZsyEcgRdI0D82ygpVUs/vkYdbz4iq7JY0Q9Jpl/azoaFsfrlakcRMr9fFu1zkWmOHhXkVXiNDoYspDLICnihxc9NLPLBXbflUXV2uoKylqQ7m+ZzlngjCLQOUZbjH/bbVO0ElJr0l3Uh0VIEy17sWhOhdGNTA7z6/xja1SL1+Q6kzO5Mfy+ZCfFyJGaXmRNNCOWV3h7KUKo86vK1MtRbdTbrxNzk24oJQ6QCw/R5qG/+RZQ5iW9J2H4zrcK06I4WTBE2KeHxzMPWoSenHxxIYeBEcyYMZeym83jbRZ3p3q+RpOOrRkX4E3ishdWqQiNEIpY3J6AEU1UhaY4G5BA6XDMIokMDPCsFtq/UH8OfRPARoyAtlLKRZlQF5S6PKw6UyXsaUhOT76g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jl2nhBBDAshfsf9wMlFtZqSiy2w3hRW7E+VVS/TShrSWVXaq2EZpfKdpck7FlBh8EIM23weVboLH4pfcgdpC8zirZ95sJZdd3iphZfbduVYp1xpn2HD+Hk9lT3LSVdEIm47rDHLf1bJBkSUdCGB53agDtNYe7Ox7SNleISNlpQ4lT4C7xR/13lm0Nebabw+XPs6IMBH52+j3ZF0ZrWWw/Zj0zSqNjz8rhqafrNVydQ92QFxBSVainURzGUX4CJC1hjdpmRSfyixDs4suukaRyYSqrk/U5O/V4t2B7SmAnTUdqTGeXQ/PSt0ZQD7CTizePaqC+RSWeao4Q4w7MCq4WY9duBMB/Hzo4MsTP2I8oPHzEOwimxW+JEzO+mfJRspjOMgtli8y0iERXkeMIpeIZkx7QWSgClKAv1nqiN0yZtd8Vluyyqf5cfE+5fk1jUcL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 20:17:04.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48684fce-75c1-4720-1a2c-08df0ac17c75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

Thanks for the reviews.

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
> > the master_domain on detach, under the global arm_smmu_asid_lock mutex. But
> > the teardown must drain any in-flight IOPF (for the old domain), before the
> > master_domain is freed via iopf_queue_flush_dev() calling flush_workqueue()
> > that can block on user-faulting page-fault handlers. Doing so while holding
> > the arm_smmu_asid_lock would stall any unrelated attachment in the system.
> > 
> > Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> > arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
> > 
> > Since no other device would use the old master_domain that is being freed,
> > it's safe to move out of arm_smmu_asid_lock (still under the protection of
> > iommu_group->mutex).
> 
> This is a lot of text if the next bit about being a refactor only
> is accurate.  Seems that not blocking attachments is the issue and
> to me that is a functional and useful change. However, is that
> in this patch?  Anyhow to me this needs a rewrite to focus on just
> what is actually changing here rather than the eventual picture.

I rewrote it:

The IOPF teardown is done in arm_smmu_remove_master_domain() when releasing
the master_domain on detach, under the global arm_smmu_asid_lock mutex.

A later change will add an IOPF workqueue flush to that teardown, which can
block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lock
across it would stall every unrelated attachment in the system.

Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.

No functional change: the old master_domain belongs to no other device, so
freeing it outside the lock stays safe, still under iommu_group->mutex.

> > +/* Release the old master_domain detached by arm_smmu_remove_master_domain() */
> > +void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
> > +{
> > +	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
> > +	struct arm_smmu_master *master = state->master;
> > +
> > +	iommu_group_mutex_assert(master->dev);
> > +
> > +	if (!master_domain)
> 
> I guess this makes sense in later patches, but for now the local
> variable seems more confusing than anything.

I'd like to keeping this: this is prep patch anyway, so pre-adding
the local variable here can make later patches slightly cleaner.

> > +		return;
> 
> I'd add a blank line here to separate the sanity checks from bulk
> code.

Done.

> >  	arm_smmu_disable_iopf(master, master_domain);
> >  	kfree(master_domain);
> > +	state->old_master_domain = NULL;
> >  }
> >  
> 
> > @@ -3784,6 +3801,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
> >
> This path is hit from a failure of arm_smmu_attach_prepare()
> At that point the old domain hasn't been detached.
> 
> Now it doesn't matter because of what is currently done in release,
> but from a code flow / what that function is documented to be for
> this seems wrong to me.  I'd separate the good and the bad
> paths in the function.

I cleaned that up -- once prepare() is done, it is in a no-fail path:

@@ -3783,8 +3784,10 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 
 	mutex_lock(&arm_smmu_asid_lock);
 	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
-	if (ret)
-		goto out_unlock;
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return ret;
+	}
 
 	/*
 	 * We don't want to obtain to the asid_lock too early, so fix up the
@@ -3798,11 +3801,9 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
 
 	arm_smmu_attach_commit(&state);
-
-out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	arm_smmu_attach_release(&state);
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,

Thanks
Nicolin
