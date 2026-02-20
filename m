Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021106.outbound.protection.outlook.com [40.107.74.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4E349AF6;
	Fri, 20 Feb 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610379; cv=fail; b=gU26s8va381rNWAm1DVZ/qSBpDAp975rokdiiugg6PzwdrBxIg8rsme5r6kizXZS9FyPsdln9zYpa+wBO62QOREuh11ROxQma5zq6+kkZWMKX9re9sEP4MlMNfDYB+r8plOncyqcFlNYtlmUK8PXSzb8RVvfBnuHEnobIXqLyRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610379; c=relaxed/simple;
	bh=s5GhG0kV5A3V3g20a+qCJKeFhQajC2q1zaEZ4FNJme4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asO/jIgJXZUKzS16PVdAuy9metgm0j9ZWQLJW9HdC5tscjERj5fgusUp1vsCj39P9cIHs/618eGF6PxjVDbiN0Q8SCWhlegLRXv82eHnP/3WVv1R0MNu7JCyTRmzhKnIOUQ+eI6Hs2DGN4+pBTQOG0qO1ubFVV/hAIeo2ONoLmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZtwjJ63C; arc=fail smtp.client-ip=40.107.74.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZtwjJ63C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcaHCcEWaFc+22CaSGwopW6PkSnIXI2cijE4wgenlgzni/sZk+0L59W79riT59SuCcjZ0xmV5d9l1fpnCc30WXnGTBBkmRbLuVppAfjl6N5RquaLGJurBT9S7gbK07OYPuzTYycs6L2HoPv19euLHX9Ec5oEDy1sGQcYiE5pNVZzFb+DU7M8gufIIQSjufU2Ifhba6J1TgZFq0QI1Fzf5gJfxzMGCMpmrfC/3zLm+s8fm6UHixKWCWWtRxWWSnGbWk9vZ1v5EEehft2QT619QN8Yz8sGSZJj3jECueCI8mFXnN0MZVcv77DnEfym4OgN5YofQ7zqfyk167dlOYs4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZEWgKM1YOmthw0C9ZdaZA2+hrwFihUK8qp4Ivd3zS4=;
 b=WaQbyjaJVGXFnm4Keyrl6WVpO8OAp2tHGW45nTRkx9k/xuxwc0GQTOY62/Rqc0RQusnGdAnRCPhGV/dhaiGVkNkbkfqqLwEAy+RGOrE1X/dlWwMER2PPA5WPmO2EtnHiZfz+MRZdK1a295kStSLzWlNSl2Xds4VQTV7rEUozt2f+DxZMpEplc22rOLOErVQWfFESoaodL8zhNBxrQZWk0nE9SuvAdsNGdiDJpOYfxPMSa0tTWX9t9mcodPfBHS1XBfJ2GldUb+lzPzefqU1yPDolLuCmk39Du5oVS7u03f98To+AAoe1OCNq9vARQSDmkavNNsGtoPF1QsqnIBgpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZEWgKM1YOmthw0C9ZdaZA2+hrwFihUK8qp4Ivd3zS4=;
 b=ZtwjJ63C2ya7BM6J5ToWyjzbghSFnQnQ8qc308oDBb05qtMyFYe+7pX3MaxrYfVTLlBBwFF/9my+nC8JrxkVEDzEYZpyCu8mF67XyHHvabkPPL4GiNCc4o30PKNJmsf8vpUxiZ32iL8p2U89HsghjOK34sBgH2/5GOVxlRLg/Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3592.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 17:59:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 17:59:35 +0000
Date: Sat, 21 Feb 2026 02:59:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, kishon@kernel.org, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org, 
	Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <eohbfzq5nlmcw6adw46ng4v3my4c7d4llkm2gkj5lae7g4dgvf@axopjnuiosez>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-8-den@valinux.co.jp>
 <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>
X-ClientProxiedBy: TYCP286CA0171.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3592:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fc3ff6-047d-47fa-b5dc-08de70a9ced1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014|921020|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnX6UlxLhGI6nZ753xbvSdHjEK0ZEehmTxGqHAmOi4hnx+Ej6pg0ZMqesJVL?=
 =?us-ascii?Q?WL0yXAYVL+i+e95c8EO9SkktXiQd8HPy1cJWUcaMaW/9Lrj6cOEl2uSWFVyY?=
 =?us-ascii?Q?+TkmapbnefX/+2M18UbFicCn+UOi7Vl/2EPDqPC2WYSZjjFNiTIDUasAld4j?=
 =?us-ascii?Q?Vql917JIYBml3kIk/Kt/Ihqz5Krn1qcypwEooaM+DzDcp7eZmLEcEYlwserg?=
 =?us-ascii?Q?F8nyjJIs+DUyiVYN8sqk9SJKqD85gK4VisgGdezrdfL7TAn3jk7l0cQudjMb?=
 =?us-ascii?Q?xoRs99A5TqduPOsIOWT8Z1wm1/TS0hLQY+L2y/THqESpmfzAGlRGOiZ3rewm?=
 =?us-ascii?Q?T9Y6N0hzMWjPoDu3nBQSwo1PYAtz+HOFA6k3eMZHL5f7fD9ybHZkPiE44q89?=
 =?us-ascii?Q?mTPUYRO+UHIQ6gRSL0GwKl+AAiBAeKLEq/yujBxXxyqbQR391gZr9nzSALUI?=
 =?us-ascii?Q?gbvPIv5sa6uCw/lK8kzYtkLI7eodUvKvgLYTfWXP45X7Req5zX3XavVacps4?=
 =?us-ascii?Q?M+LTbu9g6T/AIQPiZTCi44TAnuA5svVz5iTOqCX7LunskZW7dpOczz0yoyTT?=
 =?us-ascii?Q?qmlXGRObwB9KsvstwKaaGhps7IHBBOpP9mfAOaKMca9LMIwBulSJRkqQ/CS/?=
 =?us-ascii?Q?kn2T1X1DwxUa+uRDhwyDkjjJDuuhBgJ/NBmUMSewahbQV2jRCTg1ISHzS9+6?=
 =?us-ascii?Q?iDXblRbY2fb0opAFzL8A6LRD6khUjPCFmvT/qmRMf/oi5FE3TFf2JvJtKn9s?=
 =?us-ascii?Q?zeusVrmtkmCqsrsFz12uz52PRnoBxgcMTVqUcFPCKyd7xuoEFN7tNGe+If9Q?=
 =?us-ascii?Q?6OdVHlvvftbVhY4i9cAnTJOK0sbAHBnkE6ea5QTMvTyT2KHwwtMcxJfdP5Yt?=
 =?us-ascii?Q?V4MT3eFrkxB6ZC1Lcb54KvPrHT04O4/Yi6flaUwGyRLvDB6rZ0biqPoR0UtB?=
 =?us-ascii?Q?KFZV/Ej0CGhtYl5kFYE0wpYklZSBFaIB/X1mv2EFdJLtFdClXyL+6pl41p55?=
 =?us-ascii?Q?/wciKvcL3b5y0po6aDOoOf3JuccwzJCwQ0L5zUzcg3c2Z3+nq8W7aDVNnhgK?=
 =?us-ascii?Q?qHdWozBz9klnhInsaFHK8IOhr1kH1wpcRBUaxB142tj3tBF9U+j2HScklhRn?=
 =?us-ascii?Q?0GTQ96LcM7njXpcEqTz41ZCZja9m7WBjB9ZI+ZTGE1zc4kakrqOPmV8fiHCD?=
 =?us-ascii?Q?4zV77w8TYWZGRnOGiairf7FSloqbDMThzXOcM/osalYlxiLhJpigCoy7xrPf?=
 =?us-ascii?Q?wP4FlySNOGOpuXSnej11SckNzdPYhZGSx/U249nEkR6L0XrgFb75gNYg359/?=
 =?us-ascii?Q?o/MuOsi2dIw1Y+HqK+1FqtiJfsc6KxovtUaey50XCl+tWt+Fe01JysovDN3l?=
 =?us-ascii?Q?6BuqCnKIPFIknnqVUcdmoR8qDmNTGHJwrGdG+woqEgO4tcaCJ80X7PrnNXx0?=
 =?us-ascii?Q?uXQlh3vNhTej+y/iG5sLDK/xossQUxRcgPOcRVPukQ0a0jQzaSXr4AHyQVyd?=
 =?us-ascii?Q?19GnMlrWydlmf66Em3A48I719Rtq0VnjHrrTZ+oPyvgdYJmbCA8Mb1HF0GAe?=
 =?us-ascii?Q?NHmnBsfzoKOM493sRei1AeHF0J6edMughWvt6T7SfxnGuJCQbvzD9s3rzAT0?=
 =?us-ascii?Q?y2bkEeGcjNFHUUjhy3hufiNst2Fx6P2mpArnyW6viZbR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(921020)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?up+XdVoqtQbmgTWh1SJmW7vEmqdA5K8qrhLGMKpsypRfWqDqH2/oldBfedsK?=
 =?us-ascii?Q?L7LExuiIFla27TeBuXCwwpd7PiE5kaa9IV/lHPVswWn70wttogs4TGa5UQ4B?=
 =?us-ascii?Q?t+1SSGZfxKvZ+aCEegEmhc/LyvpQ9+msngFJOCL7bY+SkIeRGpaEi2adT3mw?=
 =?us-ascii?Q?0Bz72mQH8ZihR28nm4H68FSx+DddhSkesGD8nqN7jQUedKl0YFRI7BmUrbzm?=
 =?us-ascii?Q?G4DQxd+qGRlyi3fh4koi4YAMlGT0VKymLFXGPTK0zZ7rBqtpcuHlFDub9HF8?=
 =?us-ascii?Q?Dxh2vH0zJTWY/nEihIw5TtmdeLz+EvO/9foghtUiuY9HuciafueSW+cLapJs?=
 =?us-ascii?Q?8NxaAAoiXiU0woYvmSSqp+Ujt6Gm4jhpwCJiVp7luZGas2THojujmlpSFNP/?=
 =?us-ascii?Q?nK2Mx2HQ5I6a547iqYiCUZID6wXPt4qWf04ZJROSMji+3wDXqHqjxXJIuoIS?=
 =?us-ascii?Q?xCFKrB3/Q7v4nWO21I14RBt6lxGHFBAfFZKLJuQToUL5Sqc1rImsTs05zFUc?=
 =?us-ascii?Q?VXhthRT0fhhDxkguzpmuFiF6+53cZWZ1fj1t1QrSFFWEdhzvIULI1p+d0PPs?=
 =?us-ascii?Q?cJXq09S8dL7rRWWm6WnaV70bWEgF7gJZwUs5X4kcyB0XCxwj7bleWEAfv79k?=
 =?us-ascii?Q?9iwvkSy8vIQM4+NKEx58H7QoAZZ8CzlcjPpZivzARNJuKYtfoytqexUSxqpQ?=
 =?us-ascii?Q?7AZxvWtf93ltE/7E/N6mqKKsAFnmUVslQUy6xjBjjNiQcZDbIx0e5cYYyTu+?=
 =?us-ascii?Q?0AukjRUsNPrqAtrMuILG2nPUHy5hmLX/rXuy1/sV4B2uPQZnvVswTTeuZC2A?=
 =?us-ascii?Q?J5ovh3Ic32q/0dmM2gVYIvbYEK8hIeJaug3KIqnievySdhNhO7M3y2b9ArZB?=
 =?us-ascii?Q?YfNlS0z9nfSGbnFjVG5hwKgXRTQv2XvBDE2GNe4kGGBngiy5HEeM0HlfLuyt?=
 =?us-ascii?Q?jR6pKZYaBv3HeDBR1WBUxHkJrnkj7Bjrjh2LQtJngwegq3vMyvKK9SZrK1dp?=
 =?us-ascii?Q?X8BUZ8/sdy2QRf7SbmWObeoKscwrqp38vUGvg/ZB80eE1RWI7ShLyk3QKpVG?=
 =?us-ascii?Q?f7vUN961jclEMo0TJ8qtRtTU/UO7qyEgygkO62a7S8IyIIc3qS7VlBFbuWkl?=
 =?us-ascii?Q?TkSArKsIA3ivVleXOs6TgFmNwmIKqgx8MM4QpmtTkhc5lr+AE+yHgBYUWsgJ?=
 =?us-ascii?Q?ww6KoznkRHxBi/era4UgGkiuPO1LRMcLC/CZ++uuChnCCAbkSr3bix7oA/b3?=
 =?us-ascii?Q?eH730OgPPNOt+1IjACn+OWMLZC0I9WGiq8winfj+y+UB9UPYnLG6sR8DM+NY?=
 =?us-ascii?Q?zneC/NY5f23kFWBlmYADMe+Gr2jeaK0DnslVQEDo3h2nADfP2SedkHuBNLfa?=
 =?us-ascii?Q?El2YcKyufXU0j5xPPw71O4pRrpxqBGyxcCYPMCtUsgC/fy0SvM8uUhFhJWpE?=
 =?us-ascii?Q?VHsobOw1wEqufk1zRwUI8epU5wxhZMSYxay0GBhLjgZFWUIvPWrZKUxyHiwU?=
 =?us-ascii?Q?JsSuHHX3E2OF1lnJs/c0wRVmqBL0Ayuiil7mhYI4HrADNOOnvn9uo4hw5cBm?=
 =?us-ascii?Q?E5MQdCP+0yUPNumDMXbppGE9+fIQnvPEs6j1NE/sRT9SAYfaxCEXbFUWjwCi?=
 =?us-ascii?Q?oqJzQQIL8GqBwySNlOVpThksM4BfonjWkd/XwEGL17QvNN0jzFLWE7KNJyy8?=
 =?us-ascii?Q?NMUWtskbGVjss/LZDCDOc2PISy93BkNCxC/sEoK9DYKO882FKNMf0iVJSG1M?=
 =?us-ascii?Q?CiegizVsSjalKNyIa9LsYDSK8gQGQdqRyuTPBA5y22MznHm250Fc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc3ff6-047d-47fa-b5dc-08de70a9ced1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 17:59:35.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPbVnj+/m4D5CG/8bQKHy6xx0e52jFjRQJ2CIDmCKFh1oArjjahQbvxXUPJm4dEdgSPN7nr5LuM2wn9kFBhG0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3592

On Sat, Feb 21, 2026 at 02:42:37AM +0900, Koichiro Den wrote:
> On Thu, Feb 19, 2026 at 05:13:18PM +0900, Koichiro Den wrote:
> > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > interrupt-driven doorbell and often fall back to polling.
> > 
> > Add an "embedded" doorbell backend that uses a controller-integrated
> > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > doorbell).
> > 
> > The backend locates the doorbell register and a corresponding Linux IRQ
> > via the EPC aux-resource API. If the doorbell register is already
> > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > the physical address so EPF drivers can map it into BAR space.
> > 
> > When MSI doorbell allocation fails with -ENODEV,
> > pci_epf_alloc_doorbell() falls back to this embedded backend.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v8:
> >   - Add MMIO address alignment check
> >   - Drop 'eDMA' word from the subject
> > 
> >  drivers/pci/endpoint/pci-ep-msi.c | 99 ++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index 50badffa9d72..f287fbf684ca 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -6,6 +6,8 @@
> >   * Author: Frank Li <Frank.Li@nxp.com>
> >   */
> >  
> > +#include <linux/align.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/interrupt.h>
> > @@ -36,6 +38,86 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	pci_epc_put(epc);
> >  }
> >  
> > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> > +{
> > +	const struct pci_epc_aux_resource *doorbell = NULL;
> > +	struct pci_epf_doorbell_msg *msg;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	int count, ret, i;
> > +	u64 addr;
> > +
> > +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					  NULL, 0);
> > +	if (count == -EOPNOTSUPP || count == 0)
> > +		return -ENODEV;
> > +	if (count < 0)
> > +		return count;
> > +
> > +	struct pci_epc_aux_resource *res __free(kfree) =
> > +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					res, count);
> > +	if (ret == -EOPNOTSUPP || ret == 0)
> > +		return -ENODEV;
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	count = ret;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
> > +			if (doorbell) {
> > +				dev_warn(dev,
> > +					 "Duplicate DOORBELL_MMIO resource found\n");
> > +				continue;
> > +			}
> > +			doorbell = &res[i];
> > +		}
> > +	}
> > +	if (!doorbell)
> > +		return -ENODEV;
> > +
> > +	addr = doorbell->phys_addr;
> > +	if (!IS_ALIGNED(addr, sizeof(u32)))
> > +		return -EINVAL;
> > +
> > +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
> > +	 * typically provide a single IRQ and do not offer per-doorbell
> > +	 * distinguishable address/data pairs. The EPC aux resource therefore
> > +	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
> > +	 *
> > +	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
> > +	 * For such backends we replicate the same address/data for each entry
> > +	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
> > +	 * as equivalent "kick" doorbells.
> > +	 */
> > +	for (i = 0; i < num_db; i++)
> > +		msg[i] = (struct pci_epf_doorbell_msg) {
> > +			.msg.address_lo = (u32)addr,
> > +			.msg.address_hi = (u32)(addr >> 32),
> 
> On second thought, I'm wondering whether it makes sense to handle the case where
> the embedded doorbell target resides behind an IOMMU in this series.
> 
> In v9, we simply expose the raw physical address without establishing an IOMMU
> mapping. When the EPC parent device is attached to an IOMMU domain, a Host->EP
> MMIO write through the BAR window may result in an IOMMU fault.
> 
> Initially, I planned to submit IOMMU support separately as a follow-up series
> once this series is accepted, to avoid making this series too large [1].
> 
> However, for consistency with the MSI doorbell case when CONFIG_IRQ_MSI_IOMMU=y,
> it might be cleaner to handle the IOVA mapping as part of this series.
> 
> [1] Supporting such an IOMMU-backed case would likely require additional
>     patches for vNTB + ntb_transport to demonstrate usability, such as:
>     https://lore.kernel.org/all/20260118135440.1958279-12-den@valinux.co.jp/
>     https://lore.kernel.org/all/20260118135440.1958279-16-den@valinux.co.jp/
>     https://lore.kernel.org/all/20260118135440.1958279-19-den@valinux.co.jp/
> 
> Perhaps the cleanest option would be to submit these three as a prerequisite
> series.
> 
> Conceptually, the change would look like the following (to be applied on top of
> this v9 Patch 9/9):

(Not 9/9 but 7/7. Sorry for the confusion.)

> 
> 
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index f287fbf684ca..05423c83ae45 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -44,6 +44,9 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>         struct pci_epf_doorbell_msg *msg;
>         struct pci_epc *epc = epf->epc;
>         struct device *dev = &epf->dev;
> +       phys_addr_t phys_base;
> +       size_t map_size, off;
> +       dma_addr_t iova_base;
>         int count, ret, i;
>         u64 addr;
> 
> @@ -85,6 +88,17 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>         if (!IS_ALIGNED(addr, sizeof(u32)))
>                 return -EINVAL;
> 
> +       phys_base = addr & PAGE_MASK;
> +       off = addr - phys_base;
> +       map_size = PAGE_ALIGN(off + sizeof(u32));
> +
> +       iova_base = dma_map_resource(epc->dev.parent, phys_base, map_size,
> +                                    DMA_FROM_DEVICE, 0);
> +       if (dma_mapping_error(epc->dev.parent, iova_base))
> +               return -EIO;
> +
> +       addr = iova_base + off;
> +
>         msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
> @@ -111,6 +125,8 @@ static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
>                         .bar = doorbell->bar,
>                         .offset = (doorbell->bar == NO_BAR) ? 0 :
>                                   doorbell->bar_offset,
> +                       .iova_base = iova_base,
> +                       .iova_size = map_size,
>                 };
> 
>         epf->num_db = num_db;
> @@ -211,11 +227,18 @@ EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> 
>  void pci_epf_free_doorbell(struct pci_epf *epf)
>  {
> +       struct pci_epf_doorbell_msg *msg0;
> +       struct pci_epc *epc = epf->epc;
> +
>         if (!epf->db_msg)
>                 return;
> 
> -       if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> +       msg0 = &epf->db_msg[0];
> +       if (msg0->type == PCI_EPF_DOORBELL_MSI)
>                 platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> +       else if (msg0->type == PCI_EPF_DOORBELL_EMBEDDED)
> +               dma_unmap_resource(epc->dev.parent, msg0->iova_base,
> +                                  msg0->iova_size, DMA_FROM_DEVICE, 0);
> 
>         kfree(epf->db_msg);
>         epf->db_msg = NULL;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index cd747447a1ea..e39251a5a6f7 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -176,6 +176,8 @@ struct pci_epf_doorbell_msg {
>         struct msi_msg msg;
>         int virq;
>         unsigned long irq_flags;
> +       dma_addr_t iova_base;
> +       size_t iova_size;
>         enum pci_epf_doorbell_type type;
>         enum pci_barno bar;
>         resource_size_t offset;
> 
> ----8<----
> 
> Note: pci_epc_aux_resource was intentionally designed to expose a common
> 'phys_addr' field (rather than a DMA address), because some use cases require a
> raw physical address. For example, in the remote dw-edma scenario, the host side
> programs the (EP-local) physical address directly into
> dw_edma_chip->ll_region_*[i].paddr.
> 
> Frank, since this would affect Patch 9/9, I would appreciate it if you could

(Not 9/9 but 7/7. Same typo as above. Sorry.)

Koichiro

> take another look and share your thoughts. I had to drop your Reviewed-by tag in
> v9 due to a small change, so a re-review would be very helpful in any case.
> 
> Niklas, any comments would be appreciated.
> 
> Best regards,
> Koichiro
> 
> 
> > +			.msg.data = doorbell->u.db_mmio.data,
> > +			.virq = doorbell->u.db_mmio.irq,
> > +			.irq_flags = IRQF_SHARED,
> > +			.type = PCI_EPF_DOORBELL_EMBEDDED,
> > +			.bar = doorbell->bar,
> > +			.offset = (doorbell->bar == NO_BAR) ? 0 :
> > +				  doorbell->bar_offset,
> > +		};
> > +
> > +	epf->num_db = num_db;
> > +	epf->db_msg = msg;
> > +	return 0;
> > +}
> > +
> >  static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
> >  {
> >  	struct pci_epf_doorbell_msg *msg;
> > @@ -109,8 +191,21 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >  	if (!ret)
> >  		return 0;
> >  
> > -	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> > -	return ret;
> > +	/*
> > +	 * Fall back to embedded doorbell only when platform MSI is unavailable
> > +	 * for this EPC.
> > +	 */
> > +	if (ret != -ENODEV)
> > +		return ret;
> > +
> > +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> >  
> > -- 
> > 2.51.0
> > 
> > 
