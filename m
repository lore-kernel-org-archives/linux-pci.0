Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D33314B63;
	Sat,  5 Sep 2026 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788587630; cv=fail; b=nzaUtSX4FdS/Gdp3EUlxY/LiFfnjD4E/P15+HlO02T332z4nBuYRD5VHw/8jTyBD/MZ24wOcISO3bMhsqnYCGFSvlfVuCTKy4foZKC38swXErJfeAMX8byCMkqT94o8g0lzO5STSJJtwuX2IneuOwuFoRn5GhKtjQC/b88X46vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788587630; c=relaxed/simple;
	bh=FN4A6s1Z/37KD5Nj/KYX0CdMkCnWeQg3URw4tqpbG9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKtyjgd58jwvoyBppSfZjOUENvDw7N8qsaL673qL3l9lmspwpKnVb8Y+wQva4XeXcC/Z+5bONHOB9+mErb7KVi9Y/xd2ys2kvYl30W3Zbly/HceToOLHQQlEWNbZVhgjcisZo009JfVuyV++G2Vae6/8wHNivSQ9O8/2iY6Kf4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8uu7ZUM; arc=fail smtp.client-ip=52.101.193.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8uu7ZUM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH2ol+n/9pBzjdaugwjP2xLicUWjYupSc1FqfJOK8ZgNLFA/jOCNYvdslDdvMCjZfvvEzyFnkllyuukPquVAOn8VWSpinowDh/Wsn56cquzdIfD54DJflIIIX7vpbC5Nr/DHEcGhc+OIK3tPUJnC6oaaROIJdF/GTacFClq2Ao7PlmszSiaYfwm2lZlQ2nrGKV+p7hSUweAbpKFQDXPGN73Wi11yXIX4EjSHIweptgFniBUmWLHCUh3Cic3qUpkuyQOEZ03pUbhsU0RPf2IEUpfpFh1GRpqU1s1dyicEeupETff5DT1BwzUnPWu7+mXCNRFqkPCvbF+JLLOFwg1HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Slb41UrarB+OPmJ3OTqdy1HcZRgIxQMEQqVrx0/9a00=;
 b=IA1sD49Dy9wFST4nHq7X5ICCWUxL89ZNX9SshWNM4DQcy5t338aPMWKQKu0WNiSK/++XAUXbskGzGQgIRNH/aEz8hrVBcj5OibGKQAsbGFYTjiW8zURnz2uGmoX3zpK1lWMe5JqqfdxQwcBgqzb7j2fKFGZX5sap9caj/Ykm5RPDMgqzkAaUYdd9rnVm/nofmmKgHLKwWWAYifn/0qWTXomPEuQAespevIhK2NRiMjl6BbVjskBLCCaFGmHgVx6ZTUsi+SSG+0lPUYzpbd0Gsl4oHWyS5Gbxpx/d7DecDlU7OIFmFVnbFkvv4eqNciHblecD1krS05MqdVPRhAOHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Slb41UrarB+OPmJ3OTqdy1HcZRgIxQMEQqVrx0/9a00=;
 b=P8uu7ZUMAL7ptVCyc1n7g+iOXpjaKfzDI7K4cFPCc0/QT7+/gI8AZTLV5dlC8j+KhF9zViY7ft50uJu3JMAPGBMQ0OpmkgFuzt3Y+ayxvAIEG82KdlodTZse5QmCJY8XdFP5Ad4wV7AsMda6AhBQMk0nGhJ9ED6kAcIphbHNHzlSVlqh1zbN5WHHsMpwAtdxd4oA+jysJWXRzrN/cww9y1Dg8jyNOumo8DZuxTQlmObnB0D/P38bvhbtYXTQE4G0Ke41E3yhQVjwcNdGtE6GqFdexgdAsGIMG6wnZbpcrAbLmuKRu4OIo0mzeKBWOytYTBTx3m/BW7hZBGNKtmlTfw==
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sat, 5 Sep 2026 05:53:41 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::a0) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 05:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 05:53:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 22:53:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 22:53:35 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 22:53:29 -0700
Date: Fri, 4 Sep 2026 22:53:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Enable PRI for PCI device in
 arm_smmu_probe_device()
Message-ID: <apuuV04NRqljXnIK@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <b0442ba9eb1598bf07782b14fbcad284bcefbe40.1788222486.git.nicolinc@nvidia.com>
 <178846311320.1308030.2192800704181905560.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178846311320.1308030.2192800704181905560.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: eee279c5-9ab0-4715-edaf-08df0b1209d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|10067099003|56012099006|18002099003|22082099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	e7hor4LnJ7omlsMv2tjdGAa0eTI0sS0Py3uyP/7wvv687a3R+3ntaWl7Ut4D7sf3loy1gW/v1it/fuv0jqHxPFkSJeTTHGhJ9sYM+lGS83rkuB7GMfVbHSmeZHPusphlpGTdqkCqor2N1ARG7KqdmNG3sqpmIDVYW8nCJHfzpNCgFYaWPv4HGrTz41G8VLnp2gX7QoGgGq7KJDBJV5ZWDOqlHKPQwZNaR3DIypJP5EennkNrrKLURp/2po7LMb3VcxMbu9gIKVEzsQCk8pJewadvu4zwRK4x9Juj6EjIWra8bEedPU/7Xip1ztRvOpOe1LOMigaq9WHj3FAx1CNann3+zL6MSYDb4vl2zTpHDIrxOuQ7HycHUbbZ5uyf6xE81KB0It7oiHFlrr3envjLAvJ0h0ESz/jgzOht6v61lfB4h5aZPGh/zYoXKTOCfnfdl5FXIc7LfK6DUmkg+UY27aAzoe7tZR33VSkTZbxVdZr4mAno6rVndU8CT8a4So7gk4hHeUqEZnmWmk4qDxdJavggbOPcarQjcN1HZQ6VOxUO94YHG1qzDFY1/wmDfjmAtFQAuZqXn8T6boQy2AD8vPHrtz99Jpgd+DALjRoDg4ZMRv9STxiC7a/MG0D0SxcVPiDFP2b1OX3X/d6uik4Zl64PcBRKaFrmsT0rOqy9C3/lynxt+mKAHAS4w0xn22SLOJ+8QLy+bH0wTxR94WCh+A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ceQFQTYyt2poL4ujr5ksCmy02MnlC7t62/D4CbcqoWNVIUodCLi3xbXbep+gQ6Qm7U22mdRk1TCOPoqi7gmNMLAXhyNzjkbAAVKcQABdxBb+6DoU0AeGAvrdEntkSYpB8EWOWiaYCtgrPSWthZLbNzUsh96cdYYI0ThPEuQaDUIGo5O/OJKIiioeN96uc6Y8Wrv/UnNsafAHiiEF9Kt1ut15q6lWR9ikfunXC7EHkGH7pAEeLzqpEUxOFDuZhCOulKxdYugyKJISi1LmYGn/Vk6MG4x4I2E9FgG6vVvvWeLhAmGSK716oLxFLPfWKgz8lvzQU22QnA6FnRaIvQv0O9w4SN1+rd5soAYv6DPSqgOQf+V68Em1eA4J1ZEeeFl77ruXmKn4P7+8a4G4mx/Am/tBqjcvnmNAwMIswULCq4m4KEdE/CpqpU98CkHd3prY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 05:53:41.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee279c5-9ab0-4715-edaf-08df0b1209d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > SMMUv3 forbids the Stall model on PCIe streams. Refuse to enable PRI on a
> > PCIe master that came with stall_enabled, so page_response() can dispatch
> > on master state unambiguously.
> 
> As earlier, we have exceptions in tree for Stall mode on PCIe streams
> (lets not reopen that fun arguement) so I'd focus this on PRI not
> making any sense if stall mode is in use as that has alternative
> handling for page faults.

Replaced with:

A stalling master resolves its faults synchronously, so it has no reason at
all to issue a page request. Refuse to enable PRI on such a master, so that
page_response() can keep dispatching on the master state unambiguously.

> > +	/* Same as the eventq drain above, for the hardware priq */
> > +	if (master->pri_enabled) {
> > +		ret |= arm_smmu_drain_queue(smmu, &smmu->priq.q, false);
> > +		/* Ensure pending requests have reached the IOPF queue */
> > +		if (!ret && smmu->priq.q.irq)
> 
> Similar to before, I'd factor out the if (!ret)
> Using |= on return values is never particularly nice though safe
> as used here.  Still I'd use another variable to store that things
> timed out already so we are skipping these.

OK. Replaced with a "bool timed_out" (in both PATCH-4 and here):

@@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	struct arm_smmu_master_domain *master_domain = state->old_master_domain;
 	struct arm_smmu_master *master = state->master;
 	struct arm_smmu_device *smmu = master->smmu;
-	int ret = 0;
+	bool timed_out = false;
 
 	lockdep_assert_not_held(&arm_smmu_asid_lock);
 	iommu_group_mutex_assert(master->dev);
@@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 	 * against the next domain.
 	 */
 	if (master->stall_enabled) {
-		ret = arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q, false);
+		timed_out = arm_smmu_wait_for_queue_drained(smmu, &smmu->evtq.q,
+							    false);
 		/*
 		 * Ensure pending events have reached the IOPF queue, unless
 		 * the drain timed out: a stuck consumer would also block an
 		 * unbounded wait_event() inside the synchronize_irq().
 		 */
-		if (!ret) {
+		if (!timed_out) {
 			if (smmu->evtq.q.irq)
 				synchronize_irq(smmu->evtq.q.irq);
 			/* Pending events might be in the combined_irq handler */
@@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 
 	/* Same as the eventq drain above, for the hardware priq */
 	if (master->pri_enabled) {
-		ret |= arm_smmu_wait_for_queue_drained(smmu, &smmu->priq.q, false);
+		timed_out |= arm_smmu_wait_for_queue_drained(
+			smmu, &smmu->priq.q, false);
 		/* Ensure pending requests have reached the IOPF queue */
-		if (!ret) {
+		if (!timed_out) {
 			if (smmu->priq.q.irq)
 				synchronize_irq(smmu->priq.q.irq);
 			/* Pending requests might be in the combined_irq handler */
@@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 		 * such work still references. Skip the iopf teardown and
 		 * leak master_domain, rather than risk a UAF.
 		 */
-		if (WARN_ON(ret)) {
+		if (WARN_ON(timed_out)) {
 			state->old_master_domain = NULL;
 			return;
 		}

> > +	if (!pci_pri_supported(pdev))
> > +		return;
> > +
> > +	/* SMMUv3 forbids the Stall model on PCIe streams */
> 
> Again, I'd tweak the wording given we have quite a few examples
> in tree that do stall mode on PCIe smelling streams.

Replaced with:
	/* A stalling master resolves its faults without any page request */

Thanks
Nicolin
