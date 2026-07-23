Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7527707;
	Thu, 23 Jul 2026 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784922; cv=fail; b=oZ+KAPTiW8ZmQY/JW1uq3hibxGkZP8bnFHVfK7CrvwM2dWW9Dr5wCSjNQz3LUQFEMQTthuKGgaluWnvLOiaMGmEYuXueEaYBaNpcf5CKqId6loDCIZPmys1A3XxNJpX1O21ivmO0rZUt9IUEAxuuLGfjZNbTOtf8bEIidRUiLUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784922; c=relaxed/simple;
	bh=2UYOfc/IJeN2Hlk3pS89Kxt2RJpJnFBT66RzOux1FS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IqXcLuAta7fx1DZSH1wxHpxXnHJMiLPEqKPHs221tLZkTa4ADT2SXArPUrAZAwci5GT/HQuQJuoIXGuu7aphJwpntuU5+dxX212JvbPg9/I1H+2N98kLdrwFf4oEaWU1Lgn7wjBa0zZA6hEZe1s4TnCbCFxUJ/vbBKcwcUMNXkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkgw7KBM; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkgw7KBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3Vi2hFQnUs+KkyiGXY4OWEQfj1dxkI7OLgIeXGXsn5NJYNEt59+8DB774lMFswTYHZqdYnZ6Fl9TYq+TFLdXIqHrgx/9WoZcxB1Yj7trYY03sKbY1cEjT+uVSFfXnsV8DeJFUjpn/BBZsWWeccnXEkdGC4+dUHygaAQFE9s6jvSwmX9HM7JcADsZYEB/yzZ34q34182sj0LgASDI2p4iX4TlGRvUVRnxp59Ijse9ZvM5Q2fl7nRSIOI95+NBJdCia64Sz/tYXTSpnPOr5ej7gF0j0iyuNPTaAimeC75ujhM8vqMro9E1yXum7c3Z4zx2+0qwJkiWkmOsB37iM+PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I92/nFy+eHGanLvhVHMm1aifD7jrhvTxxvy2iefuymI=;
 b=qgQzDvvdR19GcfH6doPSYx2wsOhS2aTo+yZb3UqhVmW3U2mNlI+HzHJdbPWtSsnCLixgIeOjL1ems/pm8ZDqnoznUW+s7mDO7xni+dHX9GROZnbQ+91E4RKiYAI6DAOEfFvGs/ibc5K/skmm1bJBUDsAqJkkOAt0jPEQL6LarWd8/fhldfxO4aGq835e5zKEUBP+kUgQoORBaRkMAeRvIAFdqqouvvIv6jAV1gTkHYRx5YZ42lN6ZOwM44T/9Sj+jAUuJTgELkk40VsuEo9ywlsPd5R+m7IBwU6QVn5p5lALf2zyrt79Ce9v6OdZN1xXyYoIFBUXFa0qlnky7V57CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I92/nFy+eHGanLvhVHMm1aifD7jrhvTxxvy2iefuymI=;
 b=gkgw7KBM1JhNGr52HnfY5xBJphz+8FRKZjMMXNsBJCght3oPxrnUV2ckCdqucUPzf9T0CWF6EpUdxqsQXGaAzErIybq6aJbTKK5OaoWoZKytK4X+F5g/iNFOeXsQdK/DsyrrOFVnDUTpsytliFIQLQP9onMvKLfGTl+Q7A3QlHAB3T9JzoPW/ybc2IEoXqRwoCXFNnfbTqaLl2GT/D0zT0WmpqxutX8LGMzvjsPyW/+hlBZZkhrs1uZyvHxYsgp84Oqda9j4qutj+RTlp6XrR04K6QuhRWzhvphBBtAg9JqT2hYMjUSnK0LVicsrQLSdsDP8uMe/m1rS+c/37zBbhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 05:35:17 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 05:35:16 +0000
Date: Thu, 23 Jul 2026 13:35:09 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
Message-ID: <amGWvnoT5XNIBMMb@MWDK4CY14F>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
 <20260717224321.1BB411F000E9@smtp.kernel.org>
 <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed4793a-b1a6-4459-b1ca-03979ae8af3e@amd.com>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ad7c52-baba-4deb-7f73-08dee87c2c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|5023799004|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LdDL/y9yYvJ9QwDSK6AGlv72M4DxTQyH+/oQfKF6t+so6UUHMnrdoju8ibw2icNOpZcbjfOAP+RiVDRN7BUU6/T6cogrmkBUv4R/Tf9VFYucE1t9aLdbLuZONaDEjnH22C2LusVUr8muAVZ6KCf5hNbeVxCEglF2tu2kyitnsyayqQrzPJWWdaR+USli3oNh/SEwqi89lTn+usaYgzvOtp4aHInKxEYTgcvUdUzNsR0n/h80i2dBF3fYdZnEbSshqM9ZoRIKidnef3ttCm0+9aGGm/KWaaQ+tv17taLeS2GUAXGNR5t5EptpI7/S66k04Z+SDLiqTxHEWmxb9HrGCTi62ASm2KG17/QcS7+gdYSE3IoMw+Mqbxh85ha4SSSbIZ3kKkKwYMIWDNkW0Os+1gaVnkNUcNNTCi/flsDIXDRxjzzwL1Fg0o9vVpRVvCi46KnlMuJhDCW3GObHIkZvyEpssxnltnePSYJlOK4AiBYhkdBUNLl2UCnaxZIDN2YBn1gvK1O91+Wnx101RG/vgf4MOHW4PhCyDOXd2e/+bpSndeEIYVHqP6iRwJvi9AT0kh3uCqPA7441JdaGN+2azB+D1UtIyNT+flpzMC9xTcRc0ji6eXXTU9QTw6EdKyDmJv8eect3hVz8rglrMRNHotmRboBWm1ApDXM8OLGphZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bz89pnN6AoSlruiyKbryT/dpFoQ7DgwxHS0DmViZk7iVDhXvOzdA9J+q4Jpy?=
 =?us-ascii?Q?npdlYMZk/ouscy8QegT6f2JOD3vJteDSDYYim6kB7ro0qto4vxIErpPey4lP?=
 =?us-ascii?Q?fTpMoh3jTPhLu0BR4KfWMHZWdSLANU481I78Or9xFFjH9UXcWWXoURGjJVll?=
 =?us-ascii?Q?Mtc2nisSVafuQyvHmgpsHo6HPCuSHUdK7srxFHs+QcRldtUv8pxntsClZA4H?=
 =?us-ascii?Q?Nc/YQlyV4cOqQZPrbCmjs+ptQyl8mFKQKXUtPpG+63pU0qnHZpHvcc5bp0ro?=
 =?us-ascii?Q?sWIqwAaWsWAVFk2vNSTJZiqgQ7AnZIm1Kj2l6dmvLfhi8I8x9yzFSyBlE3hg?=
 =?us-ascii?Q?vGI8K/3LTfhXyqtyi6H8UDlACKOUoWZZk4rWiCh99mByuVq9hArPi/FCFSYA?=
 =?us-ascii?Q?TKkBB1Vp7HfTLvIm6j4LYpIpew9hpkpk0NNWWUeeu40Tu3zjb/pRz/rYGs6N?=
 =?us-ascii?Q?deG22yvO/VNTTvRCCoC++UTrI0JIwwlKZCdDk7VppMqRR4MrT9D0KLuNLqSy?=
 =?us-ascii?Q?HdwJoWBDMkcFW/WQ2VJr5WmngkW/qPJYsiMagK0OrG0LyAUAAq2lAV4ZaWcL?=
 =?us-ascii?Q?R1g9QqVb+NMQAqMvQz2x2+3mhLB3LF/mh5RUmlnmchAhfOeetDknth+pOtMP?=
 =?us-ascii?Q?BTJ/ikIuRAXtqmAwHb2v/xzVDbU896YjU6//VCqojdpP8FfUjj+EjA0Kvphu?=
 =?us-ascii?Q?9MxYqzK4qGZ+O6Pz+PtU16gBvwJ0JN0jTNdoeYcuPXDffusr+mmuuVeVCdRT?=
 =?us-ascii?Q?85gXgOIFgbrrsMvIHeUPv3yhuxqoWEQ2MF6uMLLam5/YlXyka7YmnYr8eEpm?=
 =?us-ascii?Q?SmXQI+WAqE6Yw54k3vpykXvKfFPV+YWrw3ndhTP1c4O9UlUVPBt7OcDzC/P2?=
 =?us-ascii?Q?jX6vwhDNiNzCI7R46kiUlGVuc0oOnW+iEX/e3Yn+QI7SZ41Q/dnGcbq1UYjc?=
 =?us-ascii?Q?QgSng/WNP6iJTQCDm60MkRw4tR6/HiONaJ50juUg7+HI0/QrQ3YQrgA/U3rr?=
 =?us-ascii?Q?051MTjbqZ+8227VV6h1EQlCWGMs1nNdTFLOGprE79kT3W0orpBmV+lNIC0JQ?=
 =?us-ascii?Q?DkQI8UO5om4yyXLe7O8PwNmU9Qrjti3Ag3DH/mWQzxDmLUEn+yKg8iG3F6jw?=
 =?us-ascii?Q?CpJnx2DP/3iLsBAshFiLttfV7S8EBGihIDUfpOXK9y+kbTF/qJVBmRbBvUkb?=
 =?us-ascii?Q?f5PfbVG+YePlhoz+ym0Od/86FWUrHOWNAd2cr5UnrBFCpl+bGorWiXOVTz09?=
 =?us-ascii?Q?wz0Bt7WRtstHAUj11XPKS0VIZHsyom7i4FAFhXW7aTKJDzru1tWXCwHPLs/Z?=
 =?us-ascii?Q?tjzDBZr+vfzNZaxiluKMLA4V02ICXnhU+0jVvOqPaVr3cjFIaot+7g+zMIzD?=
 =?us-ascii?Q?rURjPJjl90hywMw2Za7Yld+s4ami8DYfFvhXqvnNQP8fsAyLywdo/w5kopt5?=
 =?us-ascii?Q?wTvXDn/TylrcC2ics6747YhjBtQRZkU050Ksgbl5n/ML+W/sEcpHxIXo6BHJ?=
 =?us-ascii?Q?HnwFfBE3Dnhsw4Uo9FnRSOSwX1aL8bIQ7a2O3gUz+sJrDnUkBrB1NS8UuACw?=
 =?us-ascii?Q?5HHdnEKWiawNQCw/ZQ3+36ccZCoivCqAvl0NFh+wELUxF8pmQnKUPPJakBKh?=
 =?us-ascii?Q?Do3TXj5WoWSMXqTFeUi640hcJdJXYNbUm9DqvhMuCzZP86t/EB4nmmU4z1oJ?=
 =?us-ascii?Q?l9jVnc6YiZ3khMROUyzWgVAg/kbskTDbqb539p4cgWSFWORBVdzQ4Po+0t3W?=
 =?us-ascii?Q?m+jTfi3RRQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ad7c52-baba-4deb-7f73-08dee87c2c01
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:35:16.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1t6+BYP15hc8xfy8FlRtfqmSuBQd3rXM86m/cXP8HFDe9j0J2v2izyGWTH2UHziO0v3i12pkZaJTAA2/XJYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821

On Mon, Jul 20, 2026 at 10:06:34AM +0800, Bowman, Terry wrote:
> On 7/17/2026 5:43 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] Removal of explicit PCI error handler forwarding for RCH devices leaves RCDs bound after a fatal PCI error.
> This is a false positive. device_release_driver() is called in cxl_pci_error_detected() 
> 
> > 
> > Pre-existing issues:
> > - [High] Preexisting lockless dereference of `dport` returned by `cxl_pci_find_port()` and `cxl_mem_find_port()` leading to Use-After-Free.
> This is existing issue and is not planned to be fixed in this series.
> 
> > --
> > 
> > --- Patch [7]: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers ---
> > commit 6a99c70b18865d01d350aa367342e701ebe6dde2
> > Author: Terry Bowman <terry.bowman@amd.com>
> > 
> > PCI/CXL: Add RCH support to CXL handlers
> > 
> > Restricted CXL Host (RCH) error handling is folded into the new CXL Port
> > error handling flow. RCH protocol errors are forwarded through the AER-CXL
> > kfifo, and the manual CXL.mem error handler invocation is removed.
> > 
> >> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> >> --- a/drivers/cxl/core/ras_rch.c
> >> +++ b/drivers/cxl/core/ras_rch.c
> >> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> >>  	return false;
> >>  }
> >>  
> >> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> >> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
> >>  {
> >> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> >>  	struct aer_capability_regs aer_regs;
> >>  	struct cxl_dport *dport;
> >>  	int severity;
> >>  
> >> -	struct cxl_port *port __free(put_cxl_port) =
> >> -		cxl_pci_find_port(pdev, &dport);
> >> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
> >>  	if (!port)
> >>  		return;
> >>  
> >> +	guard(device)(&port->dev);
> >> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but while this change correctly closes a
> > lockless Use-After-Free window for dport here, does the same vulnerability
> > still exist in cxl_pci_setup_regs() and rcd_pcie_cap_emit()?
> > 
> > In cxl_pci_setup_regs(), cxl_rcrb_get_comp_regs() dereferences the dport
> > returned by cxl_pci_find_port() before any lock is taken.
> > 
> > Similarly, in rcd_pcie_cap_emit(), dport->regs.rcd_pcie_cap is dereferenced
> > entirely locklessly, and then the function takes guard(device)(root_dev)
> > instead of the required &root->dev lock.
> > 
> > Since rcd_pcie_cap_emit() is reachable via sysfs attributes, could an
> > unprivileged local user trigger a Use-After-Free by reading sysfs during a
> > concurrent device hot-unplug?
> > 
> > [ ... ]
> > 
> 
> This is existing issue and is not planned to be fixed in this series.
> 
> >> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> >> --- a/drivers/pci/pcie/aer_cxl_rch.c
> >> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> >> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
> >>  	return (pcie_ports_native || host->native_aer);
> >>  }
> >>  
> >> +struct cxl_rch_error_ctx {
> >> +	struct aer_err_info *info;
> >> +	bool enqueued;
> >> +};
> >> +
> >>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> >>  {
> >> -	struct aer_err_info *info = (struct aer_err_info *)data;
> >> -	const struct pci_error_handlers *err_handler;
> >> +	struct cxl_rch_error_ctx *ctx = data;
> >>  
> >>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> >>  		return 0;
> >>  
> >> -	guard(device)(&dev->dev);
> >> -
> >> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> >> -	if (!err_handler)
> >> -		return 0;
> >> -
> >> -	if (info->severity == AER_CORRECTABLE) {
> >> -		if (err_handler->cor_error_detected)
> >> -			err_handler->cor_error_detected(dev);
> >> -	} else if (err_handler->error_detected) {
> >> -		if (info->severity == AER_NONFATAL)
> >> -			err_handler->error_detected(dev, pci_channel_io_normal);
> >> -		else if (info->severity == AER_FATAL)
> >> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> >> -	}
> >> +	if (cxl_forward_error(dev, ctx->info))
> >> +		ctx->enqueued = true;
> > 
> > [Severity: High]
> > Does removing the explicit invocation of the err_handler leave RCDs bound
> > after a fatal PCI error?
> > 
> > The standard pcie_do_recovery() on an RCEC does not iterate over its
> > associated RC_END (RCD) devices, so this manual invocation used to handle the
> > CXL.mem driver fallback. Now that errors are routed solely through the CXL
> > protocol error work queue (__cxl_proto_err_work_fn()), the work queue only
> > panics on uncorrectable cachemem errors.
> > 
> > Does the work queue replicate the PCI recovery state machine's fallback
> > behavior, such as calling device_release_driver() to unbind the CXL.mem
> > driver on frozen channel states?
> > 
> >>  	return 0;
> >>  }
> > 
> 
> The change to forward CXL errors through Kfifo using schedulable work is 
> intentional. This series does not exactly *replicate* the PCI handling.
> 
> The device_release_driver() is called in cxl_pci_error_detected() for 
> pci_channel_io_frozen. cxl_pci_error_detected() serves as the PCIe error 
> handler for Endpoints, including RCDs.
> 
> Terry
>

Hi Terry,

I agree with you on this part, but what I can't find after this patch is the
path that invokees it for an associated RCD.

you replace all error_detected() for associated RCD with cxl_forward_error()
and queue CXL RAS work, what if a fatal case where it finds no RAS UCE?

It'll return normal and RCD driver will remain bound won't it ?

--Richard
 
