Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021072.outbound.protection.outlook.com [52.101.125.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19C392830;
	Thu, 26 Feb 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095635; cv=fail; b=ra+UEQp45Hkk5gMDmSmnTkOquoyZnomN5MhoJfZaQFftN1CL4+kzOeYc6tqenGc6qtTU8QSlD1ckt/0oj0Vt4jIlZnpGx9/Jl2ILdQHJ3XKBj00olykMxJzlStABFe871TwGEjNGKJkr2BnEuiJwQBDhVNIpomeGd8RjvPdPM80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095635; c=relaxed/simple;
	bh=4V9xYfhWieeCNN/OGbyCrN+mpPivG05N7fwdOS3+8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X0KxtDPPjC1koSPF1yiGlFq4kQMtYSarmCcSMnAJAxKaUXNDu8GKsyqkVeLoFqus8KYTAt5kklrdlUjTgsVO6hb+XRjz5plRysa0/yC9eyjMy9035mkL2b5XNDF95y/ccn4iC0gGcd6yxXN99g3L1PqzxJPabVfiab9xiZ0T6Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GJZepbtz; arc=fail smtp.client-ip=52.101.125.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GJZepbtz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNTTKE3+lGyKHxCoyf6GJP1YMBguGO8SKcb36rO2JluEl7u+ITYyNY7Cgk9Hu8hBKW4k72Ouk1DUO8NCA/n5XpP1kdFvNYucTdSHmfVmDCgSY2jeo85C6vcgB7DqxHV9f7qYHGGbTSnvrEVzPJe/A+kp49uu1iOexQwo1j5pPYv65VLTxhzBRHmHsOrmhl/MvJUJIw2pmYvAg17IkOzS2wpxCyMkKnpxiBQa41lkUKMItDHojZczge9AN65uFfcLOVn5uJwpcs1vVjMDpZac9KN78ss2jyRT+0p4CVJO8S2+y+0A6r7JdWTpcUNwXJluas7TyshOgwYD2qpkHiCwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efFt6ASlfUJ1Li7UFENPEJjcqoT2iB5L/xvhL6IsAPw=;
 b=VKiU4iRdt0/Cp57O2XqQDvtrFjHPqVB0b3u+NtJze1uSJb39tFjz+q2gQUMx+2NVDpYNEZUmMdYoP/87iBMkZqys7hglccj2/mmuwV8uaNLtIrrff1MpLbkZiSmGkoPbaGedf2YPSbsSHf+oez2tpHS1UO4xhZIU1P906rQQtRILlpmIVT+iXzgESGuOlcWPMN3mRnXSLfpumydCoOyoXDbKvVhKMRf3XjP/kC/eFLUYIZq1VTNbb2+4CUFu3SyToNqPPvpN1h4E2B88Nd3oPtxC80/kx8hYMQxde5mZIFUtBn00vfeJyJjd53ot6vQD7b0VjWEBgkH0YmDIzy0aJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efFt6ASlfUJ1Li7UFENPEJjcqoT2iB5L/xvhL6IsAPw=;
 b=GJZepbtz0I+nn/uylONWNPGu+VbZYrVztwSrGWG2cnNaREnztv9vAN9h+S4p/VUXrkkisew/bTq7XxE00PhSdFd73XT+Jr7TlU/8hoPOCCEObpnJhtboKgVCJij5OpD0TYqsfP8aQFp4gKivD0cWJWDkoDEz4hOZDtJa58cnHas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4457.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 08:47:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:47:08 +0000
Date: Thu, 26 Feb 2026 17:47:08 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <oko7yldqqlwfeyz3m3eecf3arixr4olvhogux25jauw5vezzgg@yzrph2drxnbq>
References: <20251202072348.2752371-1-den@valinux.co.jp>
 <7hqhqbtqvrw6bqraykdbccllags6gyal6rekb6yehcfx2tzhet@lex46cqheta5>
 <ap43e4jypppkpavrhf4ewgeivwnfrlldykkqyf3oqk6i4ckbhx@cg47vhgjzbrc>
 <zet2ktcxydgsbf5ij4476vqqrb4apwfk2iag737ht5htphobhs@3dbc6i4vl26y>
 <eazctmg7ptxadg4oq34e2ydib2frm4x76f6jpzm763uswocufl@uwpz5zhkd7sr>
 <o35hfok2oegyxoajfhu3vwm2sstrykpuz3aytmrpy47popwhba@2ps7icbkx7e3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o35hfok2oegyxoajfhu3vwm2sstrykpuz3aytmrpy47popwhba@2ps7icbkx7e3>
X-ClientProxiedBy: TYCP286CA0142.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d821ce1-c4ec-4b12-d64c-08de7513a054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	fRc0jpYzUNHOUJI8IO4WW1HcX8COWqDuCzkmKE7Cu2wDF3ezw1RdUjeiEUGYMBmzc7Pms2Fq0bO2PuJ0988TO7qqPStf9EZkmW4cATLS0HV34YrrS4k9yI3zN9QrGzSfaWE4kQ0RbA07hJEeqmWoMmgGon+8Sq4CCm7D5lX59XZCbFOmtF71t5fQUT8SZ+hZ4xGr6eW3ECSUxwvy6aH002AGTJdNVyPzCS0XtYjpKvz8mfcT4enBiwRVveu4wJYRw9dXsZ5jgIS+Uo7/FoW5KLlil0/8eZjAamMJoGe5YzasNEbc+cYXwc9il8LFfbWZthZgiOpTFTAXb/2we/aq1RzVKMxsHEp7lZ1qDP9XRNQ7g3vgY/8Ka9iomquDVtJsIJ6Sww0KL6M2Epbwe6nTjmygG+OUMGSU2jtyjDh3F8h3D2EbTEgO0SLiNsyfhw7fc9uK4KQln+Pagip3dyIgatWe228x2jFu1LACGnTNsf/d9gVRKnuE6SvshNS2IltmIkXR7LK2A2uJ0LCWZy4e623VHRikprbtLR+8wdKQ8yL7yl2HVf/VEnmOvKYYwA8xEGS4hdaGfunLTd9rrFGhU29WSjGEKiChAT+6//+sWW+/bK37ELGYqdOOkniTQ3HcUjPMtjVe/KdVTcndroRCuXe450LfgqSHd4vw4k9PJXq0Cke+FcfYEIXTVOrDzI1O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDBLWXZ2bW5jR2RwbUhya0JHNGVEM1krTHJtSzVoQ0N1QjRieENtZmxzajBv?=
 =?utf-8?B?aXdpNzg2ZVQ4NEZPeWVnTnlKcVFoalVZd0NNRXJSblBydVpCSDZlbndJT0F5?=
 =?utf-8?B?SGUwNDduZmdTcDlGT2FFNStHUGJPWm5ITW9wbVNMM1h5V3RXMlVJdXRtQnVt?=
 =?utf-8?B?LzBHQlVhSTdiTWkzWmF2dDhGODV6SGYwblRTeTFqOExqWTdsdXY1TUxaWnFG?=
 =?utf-8?B?YXlRN25VTFhnVUxIN0FRenVHcFE0WjNYWEJxREJGU21DSWdROEMrNmlERFo1?=
 =?utf-8?B?bmZrd0s4RlJ3aFRDVytmSnBnelZPZVVEQkJoYjltaUV3UzZKbkVINnhJWGR4?=
 =?utf-8?B?ZlFRcWNDV2NsWmxzUDNiRE5QSm04NmR1aHdSRlkyTHg4a3pjK1lzVmxkOGpZ?=
 =?utf-8?B?clZMRDloMWEvaFVHMzF5WGZ3b0JMdEFuaWdIYzhIQkdOUE5PbFVVWkx5Z09R?=
 =?utf-8?B?L05UamRxU2RaczdHcjVyS0U5ZlpXRUhxc0dKSnUzaUQ1TXRNeUhxaWUzMTNP?=
 =?utf-8?B?TmdNeWViL1F3SVFzWW1lY3VMUzErZThKV3BMaVFMWC9qOHovUUZMWDVsWkt3?=
 =?utf-8?B?VkhSdnA5NjZBdHhBUWtZVGtPa2pNa2Rjc1Rqbm5nQmh0UHFES0VtY3hSMkxl?=
 =?utf-8?B?V24vdFhzVVBvb0VuOWJTd1EyZEtDd2RqLzIyTWZrZU1yaUNydkxQWkZheS9C?=
 =?utf-8?B?NjR5WXdYZ1pmbFhuU2pDeExaRCtubnF3b0hzbU9COHhvRGN3VS9PREVHSXp0?=
 =?utf-8?B?blBYWHpFMWpidlJpY3h3anh5QXB1bzc1WWxYZzI1Y3hoOG5TRm5VNFVtUk1O?=
 =?utf-8?B?cHpWai90RDdsMmJoUHRhRnpUOE00TllUbDBQQ3ZMdWJDeC9hNHR2dHBEZFRS?=
 =?utf-8?B?WHlmSzRSRGZBSmdBRmwxU3FrUmNqMWhBQXVUb29tanN2SE1YdGZ2TkJHZ1k3?=
 =?utf-8?B?a3ArbnEvS2NuMk9DYTY4UWgzSlFNVTdxR05aTzU4RHJSY1IxR01zaWUwSER5?=
 =?utf-8?B?UUk1RGVRNWdmbUJlaWVGNjlCdlZHdGtieDc3ZVVJUXhPYW82VGY3VW44Ty93?=
 =?utf-8?B?RVg3OWRwVmJSZm51RnRqdmgvSEJieFRDSVRiemNhZE54SUJ5SldVU1dmWnho?=
 =?utf-8?B?aGZGZEI1U3dKTUdJMEgwcVhtQnpiRUR3dldadzVhS0pEeVpJOUNNMlEzN3Ny?=
 =?utf-8?B?bVdDVjlmMVpIb1JUeVdtRVc5R0o0aHBOckhkUnZjNnVCV0lZbE1nMVh6NGFy?=
 =?utf-8?B?LzcyR093OHFRbjVxU3RCTTcwR2hVblFzdEVXMzVGa0pVeWtLL2Q2SHYzU05Q?=
 =?utf-8?B?eTlpNlc5T1I4aWJIOG9BRjVuNEdiTXBCVkprcDFrN3dndGlJUUw4a3lJVTUv?=
 =?utf-8?B?OVZiWDVHVDZ5Q0dnaEdVdFV2MGE3Z2h5MXh1MnJ6bzFNcWJOcU1sZ3NHZkFt?=
 =?utf-8?B?dEtXeW5kL2g3eUgwd3F5OWxoYzBtQWE5YkJMTE1BYW00RUdlQkZqV0dncDJL?=
 =?utf-8?B?Rll1Q2ZZZzVBSHdXbmptRFZ1Q0pXYWZGS3FOYXBqU29seFJWSFZ6cnJlOGdn?=
 =?utf-8?B?aVJ1aGlpVEp6R0oxWmltRnpaYW9Rd3E0Rm5raUVVbTZTckV2WXdZUGNYOW1S?=
 =?utf-8?B?cis3bVF3TnhUK1ZXOHpSZ0Q4azJ1bmlXazg0MldkQlBsWUR1OVlyalhaem9C?=
 =?utf-8?B?RTE3Vko5elZzM3Z1c0Y4YlFvbjlVcE5kT0ZHd3I5Sm9FZ0VCRGY4ZkRYYWIr?=
 =?utf-8?B?V3E2NzhlNFdSZlRXOUZVZnZFV2hITTVTYjR4eWEwd0hJMHpjOVdOdngweFhK?=
 =?utf-8?B?OTZ5UzhhTS9JYzA1c2lXemMzVFdpeTFiUmtlWDNHRWMwSGpmb2RkSlJ5dndv?=
 =?utf-8?B?THdQaUhZV0cra0JVN1JKM3lhczJ2R294K0Z0S2VRaXE2TDBwckY2Y0daZWhL?=
 =?utf-8?B?RXV3N1NCRldxWmxyWnpseG9KSjFFSFRHYlBCYW85WGcrZDBqMHZ0OFlMWXg1?=
 =?utf-8?B?ZXVYV0grU0lIMnpnTk5qcDN3elpRVE9EYldIZE5kTndlWWZ2bmViSmdqQU1k?=
 =?utf-8?B?WmE5anBuOCs3aGFaMU5FRDFWRy9aV29xVWh3RHVjRUdKeEtFV2ovckpqNklp?=
 =?utf-8?B?dWtLT0RQakJobnc5bVgrQ3crelI4N25LeXNBV2tTRUo1ZHN3OTVxUlBkSWpN?=
 =?utf-8?B?Yi9GdUkrZGZVSnlHQUVHZ25iaTFnMHp3dWM3Zm1XcFFOT09PaTZRR3hxQmRD?=
 =?utf-8?B?ZHdCOVk3emhUQktYcktuaU96aU5ldUhtSnRiWDlkTFhFZDMrNDE3VldwSkxj?=
 =?utf-8?B?MG5FWGM4aitMaDZ2bXQvTVN4VVBzYlBxM1JGN3l4OGZhYmdsb1JIMWN6MUpD?=
 =?utf-8?Q?hIzj9b+HDGwEGvDhw6zIGyYlwLOudjxk2hn8K?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d821ce1-c4ec-4b12-d64c-08de7513a054
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:47:08.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEa8/wBHPnfKSrXWHWsZ+EWGEIAc53pygEFGaf1NWexKWCu4pQjzqllBclMAaqQizFZlw4MqYGyum1yV+m3mlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4457

On Thu, Feb 26, 2026 at 01:12:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 18, 2026 at 10:09:13PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 19, 2026 at 01:36:16AM +0900, Koichiro Den wrote:
> > > On Wed, Feb 18, 2026 at 09:52:08PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Feb 18, 2026 at 09:45:22PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> > > > > > The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> > > > > > through configfs (link/unlink functions, start/stop the controller, update
> > > > > > parameters). In practice, several pitfalls present: double-unmapping when two
> > > > > > windows share a BAR, wrong parameter order in .drop_link leading to wrong
> > > > > > object lookups, duplicate EPC teardown that leads to oopses, a work item
> > > > > > running after resources were torn down, and inability to re-link/restart
> > > > > > fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> > > > > > incomplete.
> > > > > > 
> > > > > > This series addresses those issues and hardens resource management across NTB
> > > > > > EPF and PCI EP core:
> > > > > > 
> > > > > > - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> > > > > > - Fix configfs .drop_link parameter order so the correct groups are used during
> > > > > >   unlink.
> > > > > > - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
> > > > > >   avoiding crashes on .allow_link failures and during .drop_link.
> > > > > > - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> > > > > > - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
> > > > > >   vNTB PCI driver. Switch to pci_scan_root_bus().
> > > > > > 
> > > > > > With these changes, the controller can now be stopped, a function unlinked,
> > > > > > configfs settings updated, and the controller re-linked and restarted
> > > > > > without rebooting the endpoint, as long as the underlying pci_epc_ops
> > > > > > .stop() is non-destructive and .start() restores normal operation.
> > > > > > 
> > > > > > Patches 1-5 carry Fixes tags and are candidates for stable.
> > > > > > Patch 6 is a preparatory one for Patch 7.
> > > > > > Patch 7 is a behavioral improvement that completes lifetime management for
> > > > > > relink/restart scenarios.
> > > > > > 
> > > > > 
> > > > > Are there any dependencies between pci-epf-vntb and ntb-epf drivers? If they are
> > > > > not dependent, you should always post them separately.
> > > 
> > > I'll make sure to be more careful.
> > > 
> > > > > For this series, I can
> > > > > merge the endpoint patches (except patch 4 which got merged in other form).
> > > > > 
> > > > 
> > > > Sry, patch 2.
> > > 
> > > There are no dependencies between Patch 1 and Patch 3-7.
> > > 
> > > One minor note: I just realized that the Patch 5 subject is inconsistent.
> > > 
> > >   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> > > 
> > > should have been
> > > 
> > >   PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> > > 
> > > If possible, could you please adjust the subject when applying?
> > > 
> > 
> > Will do.
> > 
> 
> This series fails to apply cleanly on top of pci/endpoint branch. Can you please
> rebase and send the endpoint patches separately (with all changes)?

Hi Mani,

I've just sent v5, rebased onto the latest pci/endpoint:
https://lore.kernel.org/linux-pci/20260226084142.2226875-1-den@valinux.co.jp/

Please see the changelog for details.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
