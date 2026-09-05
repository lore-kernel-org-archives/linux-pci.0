Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECB238166;
	Sat,  5 Sep 2026 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571014; cv=fail; b=GDju68UKTOWHODb6JHjuOI0yF1NRyaA+gXoYzQH8yHjl7Eh4SmGtlPCPupAR1JyfrktFW2/oE3T0JG6OfMX5/i8Ov2ugylg68SxAICoCzi8vpJ0feKB8Mzt6cwjTbDiQsPA5rpxYhkRxFK4przZbej3oNIfbD9LiexqyfzglYnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571014; c=relaxed/simple;
	bh=7lSbp3umqo4Oj6sdE2qvXZASXJ2Fj1AZ5n6MyUPeY44=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0L15IejL9G8kGTe1vnyLr1mrigKHBq7Vu6jNz/9l79Yr6xmjettRIe4ncSrjuA5xF9VaMicEG9zRjEwOdMtzyYzNVax8v9HJeZl+nc1LTWSgpsMOc1oR7UZ9Ahyj7LUnB7k0U1otHU+9zMvj20xjCVjHMpd/Y4LJIcqAKtq+cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/uuE68y; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/uuE68y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7tFFDFmZrGsJ6DBKV0/eW5bjWPCcASwURsBYwUETMTYbn25Lw10JzC/AQJxSYJhwbxXzqKYwxMLD14Z2UWFYCFZzeJ1sKgBZcnsx7U2FcnoAqxtGg7LCzz7dx9CAGZ23VAjjFjUEVeMm2OaiMcT/iu+wdVYIPKvRV9ddjcL2ZapwBeRZ/54Ozhw1XrFJRWtDkxoqAOZNfP6ZYglWtQ+2FQhqEeZE93YzYWmkOKEWgbx0jlZGoMzIOdrBzEIWuyBB07/nlUmdJTCwgYaWA3r8+aBWwPK7r2GmnwAPto+IUp2OnMtsfrqOUdRfRgJ9EybuE/ya+vHzoIxmWgHB21/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LC8PELIyjHRF1GWAiR/o1wa4Eyy40LiiCnmW3Ar1tA=;
 b=ZRC3jg8ikJ65X72P02ap8MQ8kAIwwcZotZh+Bzoocf49+QGb9yvmZbO9+gKc86jYXinczzRdPij0lm8Jw1brPnafjoeVikaUaZ260MsmTAIW9KdWLUFlPmP5FmLCCxTyXPzfp5a1hIHmXe86ZFiS9vti58KFYAb8useshNIdWUpSHdMJAA2Pnd1bsA2LUwUz2rvOamvvQhDvdnMG7ha+2fOm1oxN9SBysHVTKAErNcEITjSr4FsoJ7wcM81YufkQg1T+MFpM90aGhkZkjgpz8lwftpZZ6a/ua6uJkz29061c9gufa1+JECHydPPrTMCAMwVMjO9FLTrrebEwOOUSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LC8PELIyjHRF1GWAiR/o1wa4Eyy40LiiCnmW3Ar1tA=;
 b=D/uuE68yOZu3MoDWl5ZG1bqzhcUdXtRv62lssSUh2iz8ea4x5qxGzlVNKpX91nslBblNVQ2BZfw/ms58Sh6HgaF67MO85Gl1H3FqilHGwsvkS8qOQHF12g3yhSA7cpuF8ZdFVN1Dvezld0LxhvIm868zfOcnfvar4wQ5Y73oviP1bNTEOPVDjfclNomCq8pO/Vup51YAtx9ux22YXnZHjeY3gH9QFiwmB17q8oDNxxRotD4eaYPtcSwldkhUOyZSxoqmJc/tYJY9hPwKot6I1arOYoFI4Imq/nCe7BgfigSkpgbJ6hndCrC9KRCH1B/HbhhE0TKwW4cLveWJbdmsvQ==
Received: from CH0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:610:cd::17)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 01:16:46 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::85) by CH0PR03CA0102.outlook.office365.com
 (2603:10b6:610:cd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 01:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 5 Sep 2026 01:16:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 18:16:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 18:16:33 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 18:15:40 -0700
Date: Fri, 4 Sep 2026 18:15:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Message-ID: <apttObDR6jf0rvt+@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
 <178846311317.1308030.4335813024474016483.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178846311317.1308030.4335813024474016483.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 53370828-7a1f-4b62-171a-08df0aeb5ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|4143699003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	m5VFNMp8aI6DI/9uawnQDHXlzrmwj09VuSPEEWKyFANHNznypQyHwjwC0ZFKG1+X3FlNweKJgVONwZWo/zgoRziLNVJgeI26b/gtL5V8J3rqE7xq5YzXPaDy41Az9XbYnSar6PuuZeK7sSCEbrZwgtqNX99mmb+oX/mMumbq9Taw+vtONvyNeOcdAL2MDtvwTeG77w23zH2gHBB4tzJTlAGYg+2pI5PCF7JEcwy/XPwh2aN4vbea8BzPTYaX22w8EVpxRkr5w8ksvLpwbZewJjU2FCcPuQOOwSSoMim0jT7127IRuILmSbtFCci6X+c66olgSa4JHoRFivNaqGcwbGuJP+BfK5xJFmpQMtw+gYn0U6/TXSR8Je19etfdqG2RINLpmzz5OHKTR/ON4Kr1EGhODhLl1QA8Cth02Hj+ADsE+LndHRUKl9ET33pBFR+rJ0BMqH6buu1OguV+CQzgIV3I6NHrihiqUEsXlEGUcpURR/cdqyWSgSoU7N2kysEzGry4e+aBkfOZZLFBf4hEaOmFnCzKsYoOq5ESdh+3+HVK/v1qtMaq6rEL++rtbR0LzVSzrnNTGSyV4pILuNPJN809oo/DdutbfyL3sxAFAGEiT15Og3XNv/lW6lz1EU1NdVle3YlrJ2liurkm8lm/rklSiTdXobegdAp5000rECzfnA7AjjMSCA1VYQenyyyo
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	94n6ZzD5zG7Pz8E9AwMtF9YQtS62Ky1IZOM1ZodHbFPFIXgCyGCbUw3XnLEn6EqiCURPYF+LOI4s1uGS9BKV0Xkt1q0mOCY7MVyFV5LcQ86NkCEOVg/ZeiXwGTJ0K4lwxYu4q4JVghJIzI19XqAlAHGjQXdIMiPRfge+G1bYpZuVBEXrRPB9geXXEQXyTAlwlcYPq9zVuairAYoKekz5Tuu/Z2WWfNSAYVmKxXSNm0yB3ukWBwrMd+pABQA53jtBDqVX7j8C/W5aZX5vqIoAQXlPEgndSGGMI8JKHGn+ADn4lVXR4ilWMX4uAEQbkGxWMjsINdYRME7otILs84u4bR6FSCJcdHriBZ/H2UQldwyue4Qt+x6+nqPs92VBW7v4ze5XMZ9+4QWZXaTi5wSNmpAItLGD4+/Gbj/Y6EnIlLVv/vGWt8d0AVC4u9XPpZYK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 01:16:46.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53370828-7a1f-4b62-171a-08df0aeb5ab4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > To handle IOMMU_FAULT_PAGE_REQ from the PRI queue, arm_smmu_page_response()
> > must issue a CMDQ_OP_PRI_RESP back to the SMMU.
> > 
> > A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
> > IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. SMMUv3 forbids
> > the Stall model on PCIe streams (PCIe must use Terminate), and PRI is only
> 
> There are those systems that annoy some because they smell like PCIe
> (present PCIe software interfaces) but aren't and use stall mode. However, it
> is nonsense to use PRI with stall mode. So, instead I'd just argue that for
> stall the fault handling is done synchronously from a device point of
> view so a PRI request makes no sense rather htan associating this with
> PCIe as such.

I changed the paragraph to:

A stall event in the EVTQ and a PRI request in the PRIQ both surface to the
IOPF infrastructure with fault.type == IOMMU_FAULT_PAGE_REQ. Yet, both two
models are alternatives: a stalling master resolves a fault synchronously,
holding the transaction until a CMDQ_OP_RESUME, so it has no reason to also
issue a page request. A later change refuses PRI on a stall_enabled master,
so the two will never co-occur. arm_smmu_page_response() can therefore key
on the master state: CMDQ_OP_RESUME for stall_enabled, CMDQ_OP_PRI_RESP for
pri_enabled, mapping IOMMU_PAGE_RESP_* to the PRI response codes.

> > Co-developed-by: Barak Biber <bbiber@nvidia.com>
> > Signed-off-by: Barak Biber <bbiber@nvidia.com>
> > Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> > Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> > Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

> One trivial comment inline.  Given I've mostly forgotten how all this
> works, this tag might not worth that much!
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Your review is helpful!

> > +	} else if (master->pri_enabled) {
> > +		enum pri_resp pri_resp;
> > +		bool ssv;
> > +
> > +		/* PCIe allows only one PRG Response per group */
> > +		if (!(evt->fault.prm.flags &
> > +		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> 
> Go long on that line.  It is worth it for readability and it's only 81
> chars.

I added a prm and cleaned two:

@@ -1061,12 +1061,12 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
 		}
 		cmd = arm_smmu_make_cmd_resume(sid, resp->grpid, resume_resp);
 	} else if (master->pri_enabled) {
+		struct iommu_fault_page_request *prm = &evt->fault.prm;
 		enum pri_resp pri_resp;
 		bool ssv;
 
 		/* PCIe allows only one PRG Response per group */
-		if (!(evt->fault.prm.flags &
-		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
+		if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
 			return;
 		switch (resp->code) {
 		case IOMMU_PAGE_RESP_SUCCESS:
@@ -1084,8 +1084,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
 			WARN_ON(true);
 			return;
 		}
-		ssv = !!(evt->fault.prm.flags &
-			 IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
+		ssv = !!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID);
 		cmd = arm_smmu_make_cmd_pri_resp(sid, resp->pasid, ssv,
 						 resp->grpid, pri_resp);
 	} else {

Thanks
Nicolin
