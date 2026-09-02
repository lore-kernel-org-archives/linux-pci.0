Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5853B19D6;
	Wed,  2 Sep 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382663; cv=fail; b=Y0HQSxNw8HEPJz1dxejaqYSVd4g2AuSEZLVZ02TJjgvMeiXjVbQo0dR6SCUnAaUBZ787wZQcVvhQUmgxv0M38EQZE8uQbP3wIN7hgY64hPbwT6oab9Cdll5KyO3NREIrofSyGKRFgVkVoHP0xM+gbsH+uqO7ge4hIDsUkIJEZK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382663; c=relaxed/simple;
	bh=tn4U+Z7I5lfGDdQhduk39lwlRE2BDFkMhAlg61w/78o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Q1EI/DcXp9mqBptLY4u/t3tfNgZBanlFu0HF4nlL9Y1Hno2sfrLClMvAzVW944j/syGKEyGbfDsTP6EkORAZfqYyxAN/O909vvsKUos7CYvRySZDUoSsvCVaBmTS9/XNfR4bXXduxh5b1DmpPwOegS5MDp8s4SOKSX2boZNM9co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=thPIQTZP; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="thPIQTZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx6T7W95pxD7epyo82aSwrFR818pU6wqRlpY00K4Cskz1QyJ34m+qFbI1S4gJVPljZBomIXIyEvFMQKip1YgI+CSPNTqA0rgIMTFvPcXv3zWD08NeqHX/wr66YzQAeuXu5TCt0LDr02W8voglPwRvp9rL9cca/183yrrDu3Z1qD2jTSOIQKhjT17Al3NZSC5Q8QQ5mUa44tN2ymM3M2EJToIpa5P6luGRm4OqzqU8ZczDHY+azjpejOVX653xW4lAsPxwlzWrXyOvQ4Vc35KJ9wwLz9fshsTuz5jpQRpGRPZueVr4MFneDqUZW5m5GPZJBtLrRCI8qHy0C3SFkyUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V8z/UB36CqFmb08Rp8PO0b9JGAtA5HjtVwvJ8No9kU=;
 b=DMFXpLln2qY+TZKFWLdKkZGF8i8kJJltfe4TtHGAKjwA1pJ1gCb78NenAgPgnrWP8mRnO9ROZVTFO2//pTzfO0dXQwJ7CUA/YjqvSc4NmKFEYvwMJD7GUXDaTIXER1zeBWPGYAX3DVU6yImmLVnMzQyOvJFjIkrZewS2X2r57R90XgQQchiFxgQyUUZPYy/dG/hHeZtX15B1hvMEwA8gPqHX3Tso+BTOEtTrtoNl2NVBfNbTkDbJ5PH6BY8z2/WRCJ1u3XdJ3oZd4vO4OANN69/ZVWdPrf14x8ekzao10q8QJJgBKLhsSXTEELp7JJobBmAt4FYwQ1tjBu1jQr/r8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V8z/UB36CqFmb08Rp8PO0b9JGAtA5HjtVwvJ8No9kU=;
 b=thPIQTZPS6HhtLhF+Qk96J3b0j0TdhaEsO1BoVn2vfC1fU8KLVJSIs9J+I3cda6Gtk3rJuXk9d3GD7olx0MvUSkspuP0ycGz2jt2AgxbNPUYSuhIb5Udrt9pSOngx/OV/3KGhbdvktDJ7wwVbBe3nl+YkjG1bLEXJl2HWUlnSQ8=
Received: from CH2PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:4e::20)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 20:57:23 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::41) by CH2PR02CA0010.outlook.office365.com
 (2603:10b6:610:4e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 20:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:23 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:21 -0500
Message-ID: <2a1ddf3f-64fc-426c-9453-93b9e034dbf8@amd.com>
Date: Wed, 2 Sep 2026 15:57:22 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS
 handling helpers
To: Terry Bowman <terry.bowman@amd.com>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
	"Dan Williams" <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Richard Cheng <icheng@nvidia.com>, "Robert
 Richter" <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-5-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 8176b3a5-f4ec-4f96-cd22-08df0934c97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|921020|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TzycffarBtXsbhT9MMKit76d5ZmGTbMKRborBx0UlWJkXhw8wPJPdRqg9mSCxzcHR+y3qvXmZWC3d/6PRhCKAaEJ2Dx/u/sOGuoxxYf2bNDmA63M+fBkxsew46H7xAx1AvqTQu7rDbf2XH0+r56SdhV+WI0Zg+jYCC6BwXpFY56amTXi9QQMcZSYwveTEYei7yUzcY9hvQwLE3EnXXBEEOT9LU0/Mi4gxd+/IQvb6yGeGR6tVdO5HpZuUlokC63I2URuG4ynbIwGezbAaBrf1YYMkvji/Ij5+QgHAA3A5f5JmPfSVHhE4hen/F2tEdjg+hBmQNNq9EoBy5mw/B949JfqIo4gCr5OsyxbEkJhKixGSzFh5yHR5AJwRdJ6w2uCJbbqOMhPVxGzsmALy3k11pzthLfdIBWmqI8y6BNoqtrLRc7YUe7UJc3tVFPY/fK5cShGTSbIZAFj2OR1Gw5A9UwS7UEeO5Wtn5XomeqgH4+xBwwC0o0hbnaZUj/x7qB+/E2Kthd851vT3mHNjrpof1fSWk/KAXY5pepm+KCqz7PXho7DS3FeDUd9+TvLM1YNbUk8iIgawTaILU2coqW6Dxc7jsKq8yL8EnkUxC64jTFOaL23JuOHIz5DTq0WYE9bs4AeZc6QCKf89a+0DRo7gCAVA2oF88xBru3b0HVk+LtVS9CfHZgYTgHLuRFLAE1yiF7Tsi1GGx8fn+JC2ZzyG/aAhnYk1FWcILMFZUq2oECGwsunC2Dp5ZBs0bjHzDH7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EQHRMWDSEUSCFY1vyl4dTbd/tQSo+Q7QAH2uZstHJok5/8Q5VnYUYLTaQsFwfQgjXi2mN+ddDDlxvmMu69o2/mw0A3mu8BOqCeMCkGg77pP5pCv4y1sKajSntoTQ91BZiwJCcp0SxQh8WSNX/F2QqbRJquQbo6YCfcUr8qnKLGyU32a8ZUk4Iobs7kxhKCvIg+Ue/BFiBhufTAr2kR/eS3n8raD02tTinqi/zpjyTYrT+5eY8VBAvdlp9DBiFQ0TEfySLkJz2BHzj1SXP0K3QSNOq5IvhuNeODOxvsdabSUvxvPQbZE++FcPRfboO9R9cKppM79mPlWSK7FJfUlROk3X9HP9mR9OE4Z0n5KPo0PbVhm6Kj6VDBKcsOcFxfvpYfHcUegaQEbVgb7UE+nqv1qZNVEkBJ0oaiNbxRZCIVo3nxCNUkNOx8Opqjjll/k3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:23.2889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8176b3a5-f4ec-4f96-cd22-08df0934c97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and optionally a struct cxl_dport * for the device
> being handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from Ports at trace emission time. Threading
> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
> dport/port branching for cleaner trace dispatch.
> 
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint() and emit with the memdev, dport events
> emit with dport->dport_dev, and Upstream Port events fall back to
> port->uport_dev. This branching is transitional: the follow-on patch
> ("cxl: Add port and dport identifiers to CXL AER trace events") unifies
> the trace events on port/dport and removes it.
> 
> Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
> Port and Downstream Port to the refactored functions.
> 
> RCH Downstream Port correctable trace events now report the dport device
> (dport->dport_dev) as a consequence of threading Port and Downstream
> Port through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit memdev,
> Port, Downstream Port, and host fields that provide full context for all
> device types.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> ---
> 
> Changes in v19 -> v20:
> - None
> 
> Changes in v18 -> v19:
> - Added review-by for DaveJ
> - Update commit message that three-way trace branching is transitional
>   and removed by the following trace-event unification patch
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/core.h    | 12 ++++++++----
>  drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
>  drivers/cxl/core/ras_rch.c |  2 +-
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 645824167f788..4f6b4702deb38 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -187,10 +187,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +		    void __iomem *ras_base);
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  		     struct cxl_dport *dport);
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> @@ -199,13 +201,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				  void __iomem *ras_base)
>  {
>  	return false;
>  }
>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport) { }
> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
> +static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				      void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 02c791f149270..e99dcd028b738 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -227,20 +227,19 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>  	void __iomem *ras_base = to_ras_base(port, dport);
>  
>  	if (!ras_base)
>  		panic("CXL: UCE with unmapped RAS registers");
>  
> -	if (cxl_handle_ras(dev, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base))

I haven't looked ahead, and maybe I'm missing something, but why not have cxl_handle_ras() just
take the port & dport and call to_ras_base() internally? It's not a big deal, but it would
make the call in cxl_error_detected() a lot prettier.

Either way:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -252,10 +251,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		if (is_cxl_memdev(dev))
> -			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		if (is_cxl_endpoint(port))
> +			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
> +		else if (dport)
> +			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>  		else
> -			trace_cxl_port_aer_correctable_error(dev, status);
> +			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>  	}
>  }
>  
> @@ -280,7 +281,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
> @@ -307,10 +308,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_endpoint(port))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
> +	else if (dport)
> +		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>  	else
> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -344,7 +347,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * cache coherency is already lost; continuing risks silent
>  		 * data corruption.
>  		 */
> -		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
>  
>  	/*
> @@ -375,10 +378,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
> -
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>  	else
>  		cxl_do_recovery(pdev, port, dport);
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 285eed5b828b9..bc6cf50fcc926 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -123,7 +123,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  	 */
>  	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
>  		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
> -		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>  	}
>  
>  	if (uncor_status) {

