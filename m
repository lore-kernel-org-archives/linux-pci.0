Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211033065D;
	Sat,  5 Sep 2026 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569732; cv=fail; b=kdGlB3CicRppxbAyy3cwct6jl0ugbULG41MvSsfHPd1nMk9jCCmxTgXcp9IcMG4UISZ6kPvIt1t0Jsg4dxocGiD+kkwKG61Szz+uVtifeR+EkZryRxq5hZQNS/UrCHrpGyjBq33rexIu/GlvUb5yC09S+q6+QE3wlOWm6V8wCJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569732; c=relaxed/simple;
	bh=Wykr2EduKo7l9EkSPLcpVrg5Sg/L7Z2Lf/pii0/ksFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTyEB48xZUBkjf54O+oNzhowoHFsuytjf6WxQkWwGmK58ILZRfEpa2L8FXgDxyjD+CI5LOVdMUKP3z/R4hymXUL8WlsVAy4gPsSfe8jNKnM8VNiZLb1P3Jq3FB/PbOZl+pFXTU9mXVneCh96CTbK7Uq3Ym3axPFo+ikQNRCRJfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDKEG6qW; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDKEG6qW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgSftW+3gz6JTYiKQ6hyU1j/TE1ocNyZLgaRgvFhq6KWDqtKC+Z5ZMNS3yL/jv/Fj7/pJ7PjZLaph/DJ+4VUivduL45B3xVvI9ck5Ieh/OIfiQt8xUePsOHKInyDDP8FICk1IHBz9xU8Se52jHxVWKNa/VTSDfB4y6qHTrJXikxAO8BQirNwZYDVfH9UzzRgRCdSiBH8YTyDDY0gvOTkZ0Opho2iW9aO+DE89CaQ6+SHtyIWtv7w5A7Y1jxeRGuJNo4CmnBY3RSv+KSUFiF2GRM3rE8H9VtHw7h9Q99EEvEFIXa63ZBaKfKoPGzvr/w6jEvU/sVj2+/XoiRXgRFWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C8+Cvsu1IcbwMJrjb2DJP7R43gG+ZDdJXEO6N9v7gA=;
 b=U6Mf22sCOjag7+RgLVtKUb7q04xc1VXjm3Nb274bFKJfPNRo/e5TualSLkT3k62WaHdpoGE26m1ZisK9IXmRtSVLEe4p61kGOFPMw9tlVi0s7UsiSE7utLyzwfUZGed1ACe92qcemybFkld+WqNXREJRmZCDoOBHDbvtd9KKu5bUfAWEcR8T77HdCWFaKt5vors40zb7X7MeEexQG5ZODzks/nFMIKZCCpPIFiNJaKy4COL7058/6PyL3LnhkFJ2x0ji18aNtTaz8BXBaXHegNPm0RDI+3M1CjMmQoTNAx39n8eHyaJnzEFnUmvZq3jthfGejCnn2jARppgNv5s80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C8+Cvsu1IcbwMJrjb2DJP7R43gG+ZDdJXEO6N9v7gA=;
 b=CDKEG6qWi4LQtgyckGyfouyZ7P1Ryv+QoJkw3RGmOuahAfngrUpM7+wErEyht1G2Tzg0iMfcbfSFXOEcGmvxi3g39fdNsdTqgrgm6TjvrrNqUU+EblY7kPjykCVjEMlnAgvaKZjIw0n8bz0mdGwT2rGpQby5+jhaSDlpfym1p+eGQ/9PF6ZL6AKPkkyWWYtaSrLPAnvKaoSvPw9j/IDWqOpg4WO2Uq5lJQMiYeQYyo2HFmr6LyLHstJx071RWgKsCDo+zCfDq+mGEqQCPsb8g5vCDKdsgzEZ+TtpbWzwd44XnWCPlLPPoI17JB0Uvs9tSGuHj4Aay9uaVgzfForDIg==
Received: from BN9PR03CA0385.namprd03.prod.outlook.com (2603:10b6:408:f7::30)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 00:55:25 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::63) by BN9PR03CA0385.outlook.office365.com
 (2603:10b6:408:f7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Sat, 5
 Sep 2026 00:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 00:55:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 17:55:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 17:55:13 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 17:54:48 -0700
Date: Fri, 4 Sep 2026 17:54:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 04/13] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
Message-ID: <aptoU8s1+90alMaI@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
 <178846311317.1308030.4066178511081757826.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178846311317.1308030.4066178511081757826.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bd4fa6-20cb-446c-f021-08df0ae85ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e5C8wGgBlxweuajZ0NQ9bdfHsVOEpjr93AxXmyh+YogOjiPuNvp6xGhoKG3FkiXYVmd9RKHIZKtPFIEanjV7G4foE6hyLMo2ORTCPugnBctXlNrurctiiV4QPp7rBuZOgGoGDQGmb0wo4TsLUUHVW8vWMV5oTm01YjSwVRpY8+AB24wQBK7khYKmOLtw/rzj7IEp1srKwhH87lV8OAKUXq9k2ISTnEu4/SmCy9UFEArPHX/RPomigQ5lJVSSuchloR1hrQUPcckAoJzp5wpa9+wEfFeaIZ0z5A+5TWm+V30B3gjp0ZFt5RT+9S0uRUnAd2QQdL0W0tsG625R5UrHOVKvVsYZkmy3Bv7GOcvhrY3uEeyr0ASVjJiQenJfJQ/O/xnhCSjXrrq6hPenIQGRqMrczkmRaq7qZfxIKbI3N3auF+MHKadzSXtWkxkeD3fIpQDT1ZAzcQVbGqKh5NInnK2B6R51pB8ovpdda98+bG9BQrnjiYfrRTxdGnaNuQ71HbyIluuRrQ0jVDfxriBWY2GSNVg1myjkYl5ypMAfb45nHDfzZLyYs57j4lT+or4lz+ALj+efsUM4d7XRu4Z/I8ARwVlugcqo/idFeiBtEuN090sdSjfBEd1FirCmjjgpuns0jNfPuFBjpmJVyp/4Zbnx65lW/qbyeJht8UXeAZXhiC8LcWuJ46y2lHz/eBe5vfxX/i3Sx/d/aMJ0vRbHyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y7MOY8pelGVQ4JHcBmjzJBq6JICgPbIEfii57ATldKUk6D1MvZ2/KYenCe1wsOn1K47mjfaDBkociPEVlasFZoNwm5sh1rD7bwVC0EqQAZLPjMZOpO5qeNgSVziJ/sm7CFjQ/fZM+oP2+USHhrCRvfnXi/Ue/9LvN1qZtdWh1yQVJFteEP3V5+P5N2LfDoJ9ir0Prj2Pct6nQqQFI4HoK8i3+x1eURZbMGVhnfjxncZqT6HXJgMVWjHAkhdgoscBwXhXZ7pdM8XFWTcCpx9RmIRupRAT31aQXT5mZfxa4IATC454+OqwBhHPK7/4hAGi81owq7tzmgqFTKfEhK8g7AVxH9wmi1y1KfreCmniueHl6bOkyBWIc10DQu2te/wzAdHkF5iqCaikuS3R8JOWwQ6mvmjyM1/j1iz/f9HUvd+WiSBYu8Y3XqJsQbX2fKkM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 00:55:24.7642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bd4fa6-20cb-446c-f021-08df0ae85ed4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > arm_smmu_attach_release() polls the hardware event queue to drain all the
> > in-flight stall events for an old domain that the IOMMU core might free at
> > any moment. However, a drained event is dequeued, yet it is not necessarily
> > handled, and the IOPF work for a handled one can still be running.
> > 
> > So, first synchronize_irq() on the evtq and the combined IRQs following the
> > drain, in order to guarantee that every dequeued event has reached the IOPF
> > workqueue, since synchronize_irq() waits for an in-flight IRQ thread. Skip
> > the waits on a timed-out drain though, since a stuck consumer would block
> 
> drop the "though" - doesn't read well or add anything.

Done.

> > -	if (master->stall_enabled)
> > -		arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
> > +	if (master->stall_enabled) {
> > +		ret = arm_smmu_drain_queue(smmu, &smmu->evtq.q, false);
> > +		/*
> > +		 * Ensure pending events have reached the IOPF queue, unless
> > +		 * the drain timed out: a stuck consumer would also block an
> > +		 * unbounded wait_event() inside the synchronize_irq().
> > +		 */
> > +		if (!ret && smmu->evtq.q.irq)
> > +			synchronize_irq(smmu->evtq.q.irq);
> > +		/* Pending events might be in the combined_irq handler */
> > +		if (!ret && smmu->combined_irq)
> > +			synchronize_irq(smmu->combined_irq);
> 
> I'd group the two things that happen if we didn't time out.

I folded this in.

@@ -3423,11 +3423,13 @@ void arm_smmu_attach_release(struct arm_smmu_attach_state *state)
 		 * the drain timed out: a stuck consumer would also block an
 		 * unbounded wait_event() inside the synchronize_irq().
 		 */
-		if (!ret && smmu->evtq.q.irq)
-			synchronize_irq(smmu->evtq.q.irq);
-		/* Pending events might be in the combined_irq handler */
-		if (!ret && smmu->combined_irq)
-			synchronize_irq(smmu->combined_irq);
+		if (!ret) {
+			if (smmu->evtq.q.irq)
+				synchronize_irq(smmu->evtq.q.irq);
+			/* Pending events might be in the combined_irq handler */
+			if (smmu->combined_irq)
+				synchronize_irq(smmu->combined_irq);
+		}
 	}
 
 	/*

Thanks
Nicolin
