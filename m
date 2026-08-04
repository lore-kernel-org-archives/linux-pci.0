Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C842049C;
	Tue,  4 Aug 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831360; cv=fail; b=cSBkXwD8et2qYFsKNgxrkGsRuJPJLN0W8z/P47nIsI7TqdQmcQF4AltdefB37eCqgYloGcgWS1eWTUHhvcD+sXjmQCOJjWf1I0mpPxbjvjALzU9MFSsY/pUqHyel1r90aRWHQsWaVKGwkksHfcdBOqGCDdT3FW2pbSL9J8yklEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831360; c=relaxed/simple;
	bh=kN7ddRU+lexmP7QPPZ9lqSHrjUkUKOit7QPESw409Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNaOezK31wGfMOkDFJSvMHZT+gBlDiuv6pjJQZoTBcVVzoG7mk4CP4dRQ7HB3gGAJKh7PWQ0ObBZXUPFYhomnVtuLb4qOMHyex2T75DFjs4MLxiw4UnGRkjGCRqKHnwk91zsCcebs+3KRkxBTry12FVgKON/82oatxshQljeCGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jK74nmbF; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jK74nmbF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVr38X5UxNqGUs6tHYB5gLwjCmscXl4FQutZqLAfe/eNjhf9Z7h8zfqZqqTBTdOXBXoO0O/N5FGnd3A+t/lo3hLALb6xUjgK+TAvXyhmF+nYmjzrpCzUzGdMXJ+v5+79dmmToJHpvnyRuFirKupg6TeWTO7ppZf5q9KSfMSdRG/Cxrgy6e3ukacm3Tc+kJ8o61hkXelehfHnt4iEZNev8EKBspQtNbKJgqxVAhhI7NZVRTuoVGBdic/Yk4rm0lRuWsYMZYHyBZ5DZV5Iwm223M6PTABjvQT+NDtgrkPJz9kXwFar+CeGpUIEKtC/vaIoZbAYSEd3bKgD8ATbshiBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89sB7eiHQ50GsuKbL+325uyp/7rAMoA+YKl6WdvqSrQ=;
 b=u8unDJHesfgK62eoZywv4oNKdXoVxKwoitnBKuEHbNY3+vWPTOgdnGGK5+JRopTCdle9CVoZtulxov7Z5wL7fPOwmP0l0ERomSwei0XGxwgve2W+YOMvxiODj5Wanbr39141Wxi9CrOHJyx8PcBpKm7mjJFb+u+fSZWaJcfuZnjfYj/qH3TFGBAIAaSVflvduzC8G6C9kPLQ5p8aJ0hZidmb9ab4ijWmiBBukG8lim/zcIieZ+g2PDAFspUankzLoCwYpJQ90kIK3pBYNJjYwe2NJugiwWbZLhTL3hOUDjOKkpuYsaRnsdoPeOcVnNTKiUugxongpkn3JwwEt2WMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89sB7eiHQ50GsuKbL+325uyp/7rAMoA+YKl6WdvqSrQ=;
 b=jK74nmbFS/P61EC84v1k0olL1cP2ov6mP3TChhyURnfu8P++wDEwel/sKp/+K6YNZYd7lGfYiK1t110MoObgFo/qAuhayYRvkFq5YJBuZa0ESZZ/cN9DdCxoNjIPIgfgK3SUbLzhSfrlKqgPCRPwxeiLQ+9QDSkBjCUktZTHD4Y2wRTP6cG9GIpOMlRix6+OZswkFvbwN7vwsK33jdfv0NPTV4vuORUGu5WF5qv2UyWIgeQyLBI8UDPXoUBogWeHxfL7UokNTnC+Dj8Kn4q+owamVzHLe1+7M+wWU+nYi9zMHJvkw43FFaST8ILBPTHa/WtKmVuoxOPqbMBEpO2qzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:15:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:15:53 +0000
Date: Tue, 4 Aug 2026 16:15:46 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ben Cheatham <Benjamin.Cheatham@amd.com>, Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 06/14] PCI/AER: Introduce AER-CXL protocol error kfifo
Message-ID: <anGe95AFo-98IbO9@MWDK4CY14F>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-7-terry.bowman@amd.com>
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10dbd0-1279-45ba-932c-08def20099d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+Oq5zj5/KiFyeeMsRdkLAEjBkRM5zB6TJFZkDN1mn74GmGVSTittDkWyU6lQLeG6Hhw1/mdy+hnfI2cXkz+spx4eN9GyPOgJmjHOKLIzTsPbtnPCDJKM6AlZhqA1xDB5ZR54e6G6VAO+2i6MW103X8fv2AF6BRJyXlAoT9cISmYW+1fy7N8iH+y4WSUJ2Hk/KCdFi8EFGsmsKLuYUCxDiG9m8LvzHH/S0qFafCkTyCH7uyJ0Hwt4lPq7YzxEBIguaTLovppi+YZvc+KahlX69gRWJfPQSFKwQaG6fEf2UWDVt0e8+C300UT07qtXwO6QaZa6t4dUsn4hMsfG9nV3VtHjmjnF804hyfYoRIou4ykc0znHUy9Ui5xBc/j6tqAomg4Al2J7cRQ5OHNqIl1KdIzUtjheKUU/ukrVORmo70jie5E2ddxMYJti7xCZcwIsG0kpHyLw0mBvIUwSzMtpIqju1rN7RFdkV+LouJ6xCqWT0xC4vt9tH6ZA6btKQA3ZR/3XqXlDSIRJI5HMyxojnkajqkUIPyndBnPUrV/fLLfhwW/xCkTE2e0RKE3mQH5d44+LGgqeueC2OBV7gflUL3zcmtb15IZJu84MbfcjQPmhNgZvf8gU6pYhLKzsFeFHFscJ6Df/qNDBv6MeV3nL6lCXWp6nil5w6WT/pZN86DY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBl5vK4Dk5jQae3SzxAAloB3cF9wO4sUdBpRsD2V7r1OMjOQGf8g7xslQPNH?=
 =?us-ascii?Q?6b3dzQwvwj3SUGGeVMCqUtjPXfyOCaUHF4hYRGyXAuhZZWdBJmrufMuaplmP?=
 =?us-ascii?Q?eewpRu7AcjJqxqAftA9Ku9DEfpUgz+vWpAF7mdxEPIePrfPY8RhO4MFE6Bq5?=
 =?us-ascii?Q?P2GsIcsd7R6UzyQJ2hxt8A3KVlv8Nv4AbEgSNeGs8+vdL8VXjCk0Sr6MerZo?=
 =?us-ascii?Q?YaXQOc/L0E2CsW5+0EyxAOkjuzDu+NVt39nAVFRrcAEShrXo+cGmnAa3BNDb?=
 =?us-ascii?Q?rRUTz4EVO4L4/85HqS/NBgY9Auapt0QcbT6GDJR/3BDMdRAyRYgzlwy6B8Q3?=
 =?us-ascii?Q?DeAG5qv8Qk6TjyHa3Lu2wo26Ie57OW1BNRWCstdgcnL1vWIIUvQAz7CT74MA?=
 =?us-ascii?Q?IKNIaTYn1hXteG0d4WoEBnwAfrt3OgrkK7U8h01CYzMQM74T4Q0jduGWxDhI?=
 =?us-ascii?Q?PGWRqGj+7+OzxRE3/6TCfxP4lfIWtItx+GA6z7hB43slDfRA7BQJ/CjWkF/t?=
 =?us-ascii?Q?+G9d9Q7cGAxvlxjwAY/jvQDyXVg5GKYZ87AYX6bD63UWMUsfy6yyC8UH7UxH?=
 =?us-ascii?Q?YZu6Wqbe4OrqORkOVW1fIHgIvuexCLR8ErNFY32D7j89SiuCZmqBVvYG38HO?=
 =?us-ascii?Q?rT5yewBPSh9ahEmXWNfGIsfMozNx0nCk9PfM2IMOFoNl46vQvwD2qJyYAvcq?=
 =?us-ascii?Q?4Dcxm5t3rmZ5Fct/Zl1GLHBVT/CJJdmKptfVC3BXsMuiGMwOfPiU6Vud3745?=
 =?us-ascii?Q?Nqsh6hPjdbo6NHTv1ItM9HWdvWaj7CN5nc29dyHeq+DId1MXUOhHdhO3YDie?=
 =?us-ascii?Q?YqPzx1CD9GNAJl45XxIJPolsL3z0SHeIYVnASgYdTjY9VRbxUPktU1i2VowN?=
 =?us-ascii?Q?Mvrey2kf47WnbOsrMpAVOA2y7fAN9VmN/cCa8Ozhm9nMQK3rt2MDVwlX3RAC?=
 =?us-ascii?Q?f6qDE/e+XDQqInYEU5aYeehmqRIFAkCutp0cc8avydVJr5dFW/fmwGZn1u7q?=
 =?us-ascii?Q?VlLzsjC+Ji2c0IBPnEEEW+WxJZfJaFHgUn5JAv/IYU188ZtYtGM2QGJrY6ha?=
 =?us-ascii?Q?F1ejuPX523te1BTx2pS4qq5OZfGWc3SuuL5WpdL7FjYiTj5TwcYDKfj3GTNU?=
 =?us-ascii?Q?uQO04IN2XAH6lQ2DprsJB8KiJCoGKnhjCEWMUEXZi6/42fJO1JRMnyXTuEAU?=
 =?us-ascii?Q?8+AHfvmmolFQ446E3GJDDshUxRtG1LCp4X6dIuzmLH0/+bv2FVKtkADegeXq?=
 =?us-ascii?Q?8jby2xHGkxr58tFp9EiQtkztBhEXsK0tOqL74/DFzV9XBJH8GN/hPpEw0AmY?=
 =?us-ascii?Q?tiUTB9jx1WwzlL7jj7Qaq/M4Qp1GenZ1KmfiurUhGmMcDKNi0mnvrGLUuxBM?=
 =?us-ascii?Q?n4CueVHvM+H5C+patw/7dGD0RbimPBCkNoZjv3pE7+qi769eTwrs6A/viauY?=
 =?us-ascii?Q?taBGQ6kk6AhIUdLdNnUGp8G2IGKmeXZufmaNjWYGlNzax8iTG0WzDIG1jJTK?=
 =?us-ascii?Q?yserPYahaQ/NijBF65YCXvYtye8zCLKvj09k3L7q19n54SNX5YEsk5lT/8BD?=
 =?us-ascii?Q?+7ZVU3Uh2MYzLU9q5d350gQQAP2ehlsqslECB/y7v2V4JCUnTqXzFZmhr3RV?=
 =?us-ascii?Q?uwfuzFKZuWz3uM7Ru4S4zZo+lo7r0KH0sk2TDqUuXcXxY6qXesQ1avHKveAq?=
 =?us-ascii?Q?avzf8Ii552PfaFI+5KQFZX1ZE/HcaHvzf9fmYY1hdJHByz1Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10dbd0-1279-45ba-932c-08def20099d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:15:53.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upPZFIOm/a/QujjJ0qpxhdXOBvPE4pLQhUigtveQ2YbiCylZaLqe3ixtnmQEkUIYumwVpcYb3aGbvlFG720lkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

On Mon, Aug 03, 2026 at 05:18:02PM +0800, Terry Bowman wrote:
> CXL VH RAS handling requires a path for the AER driver to hand off CXL
> protocol errors to cxl_core for logging and recovery before PCIe AER
> recovery tears down the device. Introduce drivers/pci/pcie/aer_cxl_vh.c to
> implement this handoff via a kfifo-backed work item.
> 
> Move is_aer_internal_error() into this new file. It identifies AER internal
> error status bits across both correctable and uncorrectable severities.
> 
> Introduce is_cxl_error() to gate the VH kfifo path.
> 
> Introduce struct cxl_proto_err_work_data to carry the error source PCI
> device and severity through the kfifo.
> 
> Introduce cxl_forward_error() to enqueue a CXL protocol error. A reference
> is taken on the PCI device; the consumer releases it via
> for_each_cxl_proto_err(). On enqueue failure the reference is released
> immediately, the error is dropped, and the consumer is scheduled to drain
> existing entries. A subsequent patch wires cxl_forward_error() into
> handle_error_source() where correctable and uncorrectable status clearing
> is left to pci_aer_handle_error().
> 
> Introduce cxl_proto_err_wait_for_empty() to synchronously wait for the
> consumer worker to drain the kfifo.
> 
> Introduce cxl_register_proto_err_work() and cxl_unregister_proto_err_work()
> for cxl_core to register and deregister its work handler. On unregistration,
> pending kfifo entries are drained and their pdev references released before
> cancel_work_sync() runs. Export these and for_each_cxl_proto_err() via
> EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
> 
> Protect the work pointer with a rwsem to correctly serialize
> registration, deregistration, enqueue, and dequeue against concurrent
> AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
> 
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
> the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
> bridging code.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v18 -> v19:
> - Rename cxl_proto_err_flush() to cxl_proto_err_wait_for_empty() to
>   better reflect that it waits for the kfifo to drain (Jonathan).
> 
> Changes in v17->v18:
> - Remove correctable status clear from cxl_forward_error(); the AER core
>   clears all status bits via pci_aer_handle_error() info->status writeback
> - Schedule consumer on kfifo overflow so existing entries can be drained
> 
> Changes in v16->v17:
> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>   registers the kfifo consumer to keep each commit bisect-safe.
> - Rename rwsema to rwsem
> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> - Add work cancel function.
> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> - Add fifo_lock spinlock for concurrent producer serialisation
> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>   kfifo->mask, ->esize and ->data are set before first use.
> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>   device is acked for correctable events even when the consumer drops the
>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>   recovery completes, mirroring the AER core convention.
> - WARN on double-registration in cxl_register_proto_err_work() to make an
>   unintended second consumer visible at runtime.
> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>   in aer_cxl_vh.c
> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> - Update message
> ---
>  MAINTAINERS                   |   2 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/aer.c        |  10 --
>  drivers/pci/pcie/aer_cxl_vh.c | 227 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h    |   6 +
>  include/linux/aer.h           |  24 ++++
>  6 files changed, 260 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5114e6db7307d..3a1f1057a21e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6527,6 +6527,8 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/pcie/aer_cxl_rch.c
> +F:	drivers/pci/pcie/aer_cxl_vh.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304b..62d3d3c69a5df 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>  obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..c5bce25df51cb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   */
>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -#ifdef CONFIG_CXL_RAS
> -bool is_aer_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -#endif
> -
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 0000000000000..cd921ade1a38f
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> +
> +#include <linux/aer.h>
> +#include <linux/atomic.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/lockdep.h>
> +#include <linux/rwsem.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	void (*flush)(void);
> +	struct rw_semaphore rwsem;
> +	spinlock_t fifo_lock;           /* Serializes kfifo writers */
> +	atomic_t flush_inflight;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
> +	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
> +};
> +
> +static int __init cxl_proto_err_kfifo_init(void)
> +{
> +	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
> +	return 0;
> +}
> +subsys_initcall(cxl_proto_err_kfifo_init);
> +
> +bool is_aer_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}

Hi Terry,

Should we use unmasked status here ? just like other consumer does.
aer_get_device_error_info() gates on "!(info->status & ~info->mask)"
"info->mask" is always populated on the path that reaches here, so it's free.

Does that make sense to you ? or any specific reason we don't need the mask
here ?

Best regards,
Richard Cheng

> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_aer_internal_error(info);
> +}
> +
> +/**
> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
> + * @pdev: PCI device that reported the AER error
> + * @info: AER error info containing severity and status
> + *
> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
> + * item and schedules the consumer workqueue. Takes a reference on @pdev
> + * that the consumer releases after handling.
> + *
> + * Return: true if the consumer workqueue was scheduled and the caller may
> + * need to drain the kfifo before AER recovery; false if no CXL error
> + * handling was initiated due to an early return on error (e.g. no kfifo
> + * consumer registered).  Note that on a full kfifo a correctable error is
> + * dropped but true is still returned; this is harmless because the caller
> + * only drains the kfifo for non-correctable events.
> + */
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = {
> +		.severity = info->severity,
> +		.pdev = pdev,
> +	};
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Reference discipline: the AER caller (handle_error_source()) holds
> +	 * a ref on @pdev for the duration of this call and releases it on
> +	 * return. Take a fresh ref here so the pdev stays live while queued
> +	 * in the kfifo; the corresponding consumer is for_each_cxl_proto_err()
> +	 * and will drop that ref after handling. On enqueue failure below,
> +	 * drop the ref we just took to avoid a leak.
> +	 */
> +	pci_dev_get(pdev);
> +
> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> +				 &cxl_proto_err_kfifo.fifo_lock)) {
> +
> +		if (info->severity != AER_CORRECTABLE) {
> +			/*
> +			 * Unlike PCIe AER, a dropped CXL.mem uncorrectable
> +			 * error cannot be treated as device-local: it may
> +			 * signal lost cache coherency over HDM memory in
> +			 * active use. The error can no longer be confirmed
> +			 * via CXL RAS, so collapse the unknown state to the
> +			 * same conservative outcome as a confirmed UCE.
> +			 */
> +			panic("CXL: dropped uncorrectable protocol error\n");
> +		}
> +
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
> +		pci_dev_put(pdev);
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +	return true;
> +}
> +
> +void cxl_register_proto_err_work(struct work_struct *work,
> +				void (*flush)(void))
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +
> +	/*
> +	 * Warn on double-registration to surface driver bugs (e.g. missing
> +	 * cxl_unregister_proto_err_work() on module exit)
> +	 */
> +	if (WARN(cxl_proto_err_kfifo.work,
> +		 "AER-CXL kfifo consumer already registered\n"))
> +		return;
> +	cxl_proto_err_kfifo.work = work;
> +	cxl_proto_err_kfifo.flush = flush;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
> +
> +static struct work_struct *cancel_cxl_proto_err(void)
> +{
> +	struct work_struct *work;
> +	struct cxl_proto_err_work_data wd;
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +	work = cxl_proto_err_kfifo.work;
> +	cxl_proto_err_kfifo.work = NULL;
> +	cxl_proto_err_kfifo.flush = NULL;
> +
> +	/* rwsem_write excludes all producers; fifo_lock not needed */
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
> +		dev_err_ratelimited(&wd.pdev->dev,
> +				    "AER-CXL error report canceled\n");
> +		pci_dev_put(wd.pdev);
> +	}
> +	return work;
> +}
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	struct work_struct *work;
> +
> +	lockdep_assert_not_held(&cxl_proto_err_kfifo.rwsem);
> +
> +	work = cancel_cxl_proto_err();
> +
> +	/* Wait for any in-flight cxl_proto_err_wait_for_empty() calls to complete */
> +	wait_var_event(&cxl_proto_err_kfifo.flush_inflight,
> +		       atomic_read(&cxl_proto_err_kfifo.flush_inflight) == 0);
> +
> +	if (work)
> +		cancel_work_sync(work);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
> +
> +/**
> + * for_each_cxl_proto_err - Call a function for each kfifo work item
> + *
> + * Single-consumer invariant: this function is only called from
> + * cxl_proto_err_work_fn() via a single DECLARE_WORK.
> + *
> + * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
> + * or cxl_unregister_proto_err_work().
> + */
> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		fn(wd);
> +
> +		/* Corresponding ref incr taken in cxl_forward_error() */
> +		pci_dev_put(wd->pdev);
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> +
> +/**
> + * cxl_proto_err_wait_for_empty - drain pending AER-CXL kfifo work synchronously
> + *
> + * Ensures CXL RAS handling and panic policy complete before AER
> + * recovery proceeds. Only needed for UCE; CE runs asynchronously.
> + *
> + * Snapshots the flush callback under rwsem_read, then releases the
> + * rwsem before calling it to avoid deadlock with a concurrent
> + * rwsem_write from cxl_unregister_proto_err_work().
> + *
> + * The flush_inflight counter (typically 0 or 1) prevents module
> + * unload while a flush is in progress outside the rwsem.
> + */
> +void cxl_proto_err_wait_for_empty(void)
> +{
> +	void (*flush)(void);
> +
> +	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
> +		flush = cxl_proto_err_kfifo.flush;
> +		if (flush)
> +			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +
> +	if (flush) {
> +		flush();
> +		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
> +			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +}
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index cc58bf2f2c844..357310916088f 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -130,9 +130,15 @@ struct aer_err_info;
>  bool is_aer_internal_error(struct aer_err_info *info);
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void cxl_proto_err_wait_for_empty(void);
>  #else
>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void cxl_proto_err_wait_for_empty(void) { }
>  #endif /* CONFIG_CXL_RAS */
>  #endif /* _PORTDRV_H_ */
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286f..8eba3192e2d15 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -25,6 +25,7 @@
>  #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
>  
>  struct pci_dev;
> +struct work_struct;
>  
>  struct pcie_tlp_log {
>  	union {
> @@ -66,6 +67,29 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_RAS
> +/**
> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
> + * @pdev: PCI device detecting the error
> + * @severity: AER severity
> + */
> +struct cxl_proto_err_work_data {
> +	struct pci_dev *pdev;
> +	int severity;
> +};
> +
> +/**
> + * Callback for processing a CXL protocol error from the AER-CXL kfifo.
> + */
> +typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
> +
> +void cxl_register_proto_err_work(struct work_struct *work,
> +				void (*flush)(void));
> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn);
> +void cxl_unregister_proto_err_work(void);
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);
> -- 
> 2.34.1
> 
