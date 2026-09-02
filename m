Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A83E51CC;
	Wed,  2 Sep 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382657; cv=fail; b=CIzlZ9GLWW65dsCqa7hca9KOR6tw4i+jNS6zy/jYXSi4TVLUI9Xx08e3bhVXIDOsxIO7aCslVKjM9b8uGoD+PVxwWv+Cy1IOVvY4k321wdIMtTG9uSnTh1QOjPOVJWljcGGAGGgeoL/RcQPiUojfrwx3BTFLUEJ/AEni3tUtDEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382657; c=relaxed/simple;
	bh=zJsL4LQmw3j4p0hCQKHUzqMhPAqFFW2Xq4lbyw9Qvms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ODZiAkso4XKR63d+k1FPDF1qyUaDAt8gIHObcW6aNh2yQTZ6Ii4QTy0SRJtbwcaMCIHmLQ7CdFpmbR1ttzZgCuIPtPiPx+cS2hWAoWrmEO+YFPNjpQ+FzVIlEq1VbAV6XT5NjDXh1eIlpuLFr5szcO2r9CfOJKVEcrdPPqEIfds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EMzG9B1O; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EMzG9B1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCkngkvWKIBoOyszxJmHFoo9KXAd8Gut4gABni+yEWnb5cdxNWi/CTc5AYrzlmCeFwV8jKZmdb4LxpDwyS6KiSEWEpqwF/v3BK0aB19PuJOehd6QABfCM+yW4EKzrk4tJD9eHqaq2bDLUZci/HahpKhnb0iXvnoxM7s/MN1aJqRBiyuMEG3slwUaWjdy4Rnyq+fwoXnkLZVb4jOf1tKMelgz0SFo/WdEoyAEErCc72vMj7wfo9uLDY+JOhR9PTQ6qGNLWvPc8kkUsf5xItxemRSFmS3iUHEHAw2heoxDPXK1l4oxqNXwwNo1LC8FAGa9l+Xybq9OMBjmZJ4tSPqJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkaBWX7h5aL3csbB8UzklvFcUMXOUjGxtbSbOS0hkjY=;
 b=NPDG1jio9Gm6sBvTwV8xbk4INS9cyeNaHk1rK8cQpZ1VSYmEB/s/NoZbeuTmAKVBAI0Ct6g7ZjLlHNhFfAcgGm21QQIWx1eL76/EzS/05vTWSE8czu9P2zLatDj/D9Apj7Qo8kNsPGv++i0TdfoD3S+BBLsMRAIfNHPE698VUvQ5IZiF6C6VL8Br2LjbzhWDkA+KyLpXBllLEFaCYUNAnxUZULEzSoicDMCTTp8X3Swi05uG4V0OUADPlUOICRQOA/YZQdxy7XiDORYoMLQDXVoR1ieczvtaW5wjmjq3SYodnWX+C/gszw1wzxnS3X1k6Nlw9RfXr8nE5ZqAVjICLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkaBWX7h5aL3csbB8UzklvFcUMXOUjGxtbSbOS0hkjY=;
 b=EMzG9B1OaMdtcaiMux9XarySMsVW+OPsehfDvtWouKaYhmRh7emGDW8s/+/f57jdI2JovfEBE9zzgCX83zY3eFnpJ60dHirm4oe1OEC2bZkK1uTDvZepLmmW66T+qpxhqgI3HIHlN6y2bTJ0fB44Sn7aJxVermyK7Ww++EDrHWc=
Received: from CH2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:610:5a::17)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 20:57:14 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::73) by CH2PR08CA0007.outlook.office365.com
 (2603:10b6:610:5a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 20:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 20:57:14 +0000
Received: from [10.236.189.59] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 15:57:13 -0500
Message-ID: <a8ea024b-a608-4eea-bbdc-cba37b2bf2af@amd.com>
Date: Wed, 2 Sep 2026 15:57:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error
 flow
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
 <20260902133933.2992457-3-terry.bowman@amd.com>
Content-Language: en-US
In-Reply-To: <20260902133933.2992457-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: f65a27db-8bb0-4fe7-6f31-08df0934c44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|1800799024|36860700016|921020|6133799003|18002099003|22082099003|4143699003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	amQ6izh18Crr6UPkPhGT9YoOL3Ykj2DkgfSPDNgp0WL/iKQyRGXbQKZOrk0cK83dmaCJbcCto8c2Z+J5oHGw0EGU0XvWTNftAOZldH4Eqkoxw5fNkh4N1CgxEbFBlMEl6wFmWy2VQfdxeIrJU5erBIPTjDuSf71C72bnexBB90bdOLB8a9MZPG443QMj4JGtAirk2CxwOagGYQvxujozBdAH65d02F9q0ZoxA8slcH4XzwCF2nY1zMmUWrk50lpDoEBzicWySMYnjG5Qw2dkIXJilDNMGRXW/8qi5eOfVOeLUzlM84QmCiL4O5fFMYjJv1/ce4esbsak0W9VOByaMDVvn0i3cp0TF+rKypSZlkP1FlemQkf7peykDm4vYMHipaXyf9fu5iBFn86MbF9+6wZe1nZ5hcS4doS3eM69gWusqhxwB0+6ieNdxulgtS8AxFn+fJ8ZO3F4akPvwqvpZr8O4qVXqW0ltFPwxGm/PwyL9zP3ylTz2nGPyJRweer4UTexcO1v2SZDVxfVE9gZCP13cVVJX8UewUS1RkKbLgrdXKPmqMKm2jX384afoXcxztO3OFAbfYfhbInuZC0uDYLTsLwtdL/Fy8jIWZFMtx8nZwh6ybo4QoCWBr7GH4+yHfgHMm0fSZRMst0iKY973xS6rKLF7qR5bShE0cp8futPNac8ZuQnvTEb1a20dnH0zU6zAegDktQSutu0+GTzEQ6yyQcB26iHsV2ruESPD58d5hIWdiPunrbVJowh0ovj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(1800799024)(36860700016)(921020)(6133799003)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K9NQfqcqxrds2F/SmaIpli6ve9eSMPD001e1kMAwuNO/gmv1xW6bJVsO1LLrpuKc1iuVOD6x1wZoKTedZAnlv1Mfhjy/9EHLgfPHwwmNJnYEw07vrgpZpmQowVzhjoDtjfqK63ASX+jfpg0e7jIssCq0/K0e+a5rmtmN8+sNxnU5zzjdBKZIGX8DUraonFbw6rU+GPy5kZxFa2TslIHN+HKkr/5AQpMTrvr8tqyqW3Xe8JxIoKrggR/70cR7dpzRlnWRiZLglcaM+EVxt2H8wchKMYUZah6Xpbr/XRWVzvPv8pdcFFH3xtMKcoTsXR11B1WZIBsu5X7Z941rsnfiJKeVmLN9g1G6oeMu1Or5syfPetSexX9sdJthW+/t2s/G36EjXZUi5y1X2d2KJOsqq62t+S1Dx/+qRKa+Qa7wNlreYk2sdm743VmzBP1c6ao0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 20:57:14.5841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65a27db-8bb0-4fe7-6f31-08df0934c44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

On 9/2/2026 8:39 AM, Terry Bowman wrote:
> Establish a single CXL protocol error path shared by CXL Virtual
> Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
> handle_error_source() routes CXL protocol errors, gated by
> is_cxl_error(), through the AER-CXL kfifo to a cxl_core consumer for
> logging and recovery. Producer and consumer go live together so no CXL
> error is silently dropped across a bisect.
> 
> is_cxl_error() expands from Endpoint-only to also cover Root Port,
> Upstream Port, and Downstream Port. RCDs report on behalf of an upstream
> RCH Downstream Port and instead reach the kfifo via
> cxl_rch_handle_error().
> 
> For uncorrectable errors, cxl_proto_err_wait_for_empty() drains the CXL
> plane (RAS read, panic policy, state clear) before pci_aer_handle_error()
> drives PCIe recovery, so recovery does not tear down RAS iomaps while the
> consumer is still reading them. Correctable errors run asynchronously.
> 
> Panic policy: cxl_do_recovery() panics on a confirmed UCE, and also when
> the RAS registers cannot be mapped -- an unconfirmable UCE is treated
> conservatively as fatal since CXL.mem coherency may be lost. A
> mapped-but-clear status is logged as spurious with no panic.
> 
> to_ras_base() centralizes RAS base lookup (dport->regs.ras for
> Root/Downstream Ports, port->regs.ras otherwise) and provides an
> injection point for RAS status simulation during testing. The
> cxl_cor_error_detected() AER callback is removed; correctable Endpoint
> errors now route through the kfifo like every other CXL protocol error.
> 
> Update cxl_handle_rdport_errors() with locking to prevent dport from
> being freed and RAS from being unmapped.
> 
> At this step cxl_handle_rdport_errors() still dispatches a single
> severity per pass (matching the pre-series baseline). The following
> patch, "cxl/ras: Handle RCH correctable and uncorrectable errors in one
> pass", processes a simultaneously signalled CE and UCE together.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 

One small nit, but otherwise LGTM:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

...

>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +	bool ue = false;
> +
> +	if (!port)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	if (is_cxl_restricted(pdev))
> +		cxl_handle_rdport_errors(pdev);
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +	scoped_guard(device, &port->dev) {
> +		if (!port->dev.driver) {
>  			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> +				 "%s: port disabled, abort error handling\n",
> +				 dev_name(&port->dev));
>  			return PCI_ERS_RESULT_DISCONNECT;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS read is unconditional regardless of channel
> +		 * state. Any uncorrectable error bit set in the CXL RAS
> +		 * status register triggers a panic below because CXL.mem
> +		 * cache coherency is already lost; continuing risks silent
> +		 * data corruption.
>  		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
>  	}
>  
> +	/*
> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
> +	 * silent data corruption.
> +	 */

Don't need this comment and the last sentence in the comment above.
> +	if (ue)
> +		panic("CXL cachemem error");
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
>  		return PCI_ERS_RESULT_CAN_RECOVER;
>  	case pci_channel_io_frozen:
>  		dev_warn(&pdev->dev,
>  			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> +			 dev_name(port->uport_dev));
> +		device_release_driver(port->uport_dev);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
>  		dev_warn(&pdev->dev,
> @@ -335,3 +371,82 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
