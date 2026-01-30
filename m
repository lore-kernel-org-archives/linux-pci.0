Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021120.outbound.protection.outlook.com [52.101.125.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECE312812;
	Fri, 30 Jan 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739699; cv=fail; b=Ws63ORGD/ialp4HZOQP7Le2AUsRUgH0WFlJahCRzLVACwv2mhifYT7TnXDQNZbA7xcjWQYPQA0kP+ImJEMc9H0ZJun0/6GYlffjmsx6qQ6QYJ7aQSszNd2JKHXQXTXYofQ/lHb0883n3rDYPRaQXrkvP4yoIF3mDA0k+CKO+mZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739699; c=relaxed/simple;
	bh=GL2OvyCBh4PqMQmC7HsTZLh0QnlNimfuIL7hEY05uUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l7+3YAzOSJAD4oq58iYx7VQaNxNUReWcgR7TIJbBGbI9AsNiFdm6W+/JRd3mDfQhInVO8RjMY3HObfVmtEhSNYZCS0YzUnrQFbzllTi1J+e46XsM54FAbXDb4UL3jXDnXt7J1Hz2W6/aUDNhAa/5YCRwd9NBpptw/0FIC04j2e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gUAnruQV; arc=fail smtp.client-ip=52.101.125.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gUAnruQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvOjIEZCUoz7pPwvOrXbf1CbagpepQnF5zPCrZXIcCZaOXG9iUhQOeoPezXMYbnvg5kknIL3cRqjmpc3mJIeBehcYgwAI+b9SMdHfhkf4MUxF30JP+o4mC6z3X37ih4oi6h5OUKTYoeQo2piKmM8jAbPBAf51g940vJ3STghXam+oDHf2y7hZgnAcMDKBdBjBluCyalCC85jz/f+4J6MPosKiA7mAk65BZZ3OqNBBjzQk/avaRnQFVOQaW9A67wpoe/+RcfBRq4A/aNCgnCXrj/d6RUXzow6ttzBkoZ49snHpGV/hMbKnwUITUV0tlp3+LNqvDqf8y1qmD9wxNvHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgjUOfDqPYZcC6ASpTnFhYtM0DM+Jax9QR3gEnAypec=;
 b=X/YeGPodVFMoOkHuCkNmb5Vt4BpLg51pKcEm7mqdO7yrPh1jq/+3rfin4qH1OCND+0R4g0Rlxl/ZmGaA4C1+8EFsX0268JJ30AgbXhiHJJjh5ucyQGLWQ5ayev58DGKb7zp2GXYlz7B3ZEeqhOxVU7Yn6JYxDsANrgMgFQbBg7A8FUp+qqhlUXtp/ypAkJHy+3jG0ZXVNGq+UbYaK1kVONoijhG3LOnS4p76TAuof7d/2Deb6pfGpjV+ysNFgMcPVFjd1+Q55d6MfC7O+HrLOynjisYrAgdbHBtLozRxE2RgJgGKjxciBaJNi00bNbET1VP2pNVbUdB537AYtfDYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgjUOfDqPYZcC6ASpTnFhYtM0DM+Jax9QR3gEnAypec=;
 b=gUAnruQVKSG1hW8Gl/xXUPIjPC6hpZgjqQ0O2NBete7jlQGjQA+bBlpNU9y1n4d9rIeZdw9iN0d7faIckqd9iVddyggdH0PpyDLdagCIyX/mb3vaOndYA3ydVTH+qzu3rS6C+gFdI/Qt004xyw+QqNU805fZV96YqVu3FpCEzp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:411::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 02:21:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 02:21:34 +0000
Date: Fri, 30 Jan 2026 11:21:32 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, Zhiqiang.Hou@nxp.com, 
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <s5hd43mnktvnuikuai25fhzchkt4y5w3ejabqhr43ihvwuefb3@wvatfe5k4loe>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtrW7viGZfMNZur@ryzen>
X-ClientProxiedBy: TY4PR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:405:370::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: ca594217-1713-4c0a-87bc-08de5fa649b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ouh+Re+uYOOIObgwFiL/OjkIxUX0UgDIWJzBCtIxe3Qp98cip/bnXcfGTFNL?=
 =?us-ascii?Q?FMmFPkgNM+NWl0T8yoWGwGzr6Q93E83Ac1M6NcpCllLZZisLbN8O0PHVLEL7?=
 =?us-ascii?Q?Qqy4LpTfQW5bgs4l9nMqCu3iLT4nKq3kMBWaQHkdXYrZN3UiLvJlL88cHX3Z?=
 =?us-ascii?Q?IFv4L24F6bCyfhOulig9aHYH+jU1czxeruf/noCuzim21AIANAJluG7WDtxA?=
 =?us-ascii?Q?wXM7Ce6Fr/cwUczsmeZuww4LB+utBYBoIp8Ro41ozc8eKB3I5hPv/vNmUU4u?=
 =?us-ascii?Q?PGm1ThPKeRD8Vp52yCwUC86jvoN1QuQjyDXJEZQJ7KHAUV2Xdupvda1GsazL?=
 =?us-ascii?Q?ogHpZSL3PuJVeBxpIwlXnv6zjv4r37wSYlh8cde57nyVva7uz6+ui39NpMAM?=
 =?us-ascii?Q?GNTYEl1dUv9tzCS4CneP62jkbKZIWsfbFau6w2FQTG+ncVrOBIfM9PfbUFbE?=
 =?us-ascii?Q?qq4Q543GZsdJzF6axfCyGTXzWn0DnnVZFtQn2A3pLCvPknLsgIAqZInGgV9S?=
 =?us-ascii?Q?A3o05uMTHaB9Uo2NYKmCsvK4lZv3Rkh883FXUzu8uvNAuDxWiXrZDeYptOA9?=
 =?us-ascii?Q?QfJHLwscB3M3MAwDq1QldJSlipBLdvy1djKsEaqSGkod692Sk8XHFT4WOS8V?=
 =?us-ascii?Q?yHLRKEubmMX9zi1T5yXDdy+dzWxc/YPlOgRo5NPQiYYTWrqsxloH4WZMRro6?=
 =?us-ascii?Q?JPwBrPoCr+AZC+b4U5BYzTv8IIHVPIsw0/o3ka059Zs19FngjOSBal//UKQP?=
 =?us-ascii?Q?9RrYyPrFoPhhOkZ7acUFf8DNG0o2GUdyEgfC/Q2mFoBvcnj1Gt/X86FNwlDU?=
 =?us-ascii?Q?Omy/BIkE5Y8srVn7gk0euRQGGKKAvEyDbmZ0px59baRh8jXuVBfyxBRktIMU?=
 =?us-ascii?Q?cMrev/DbPNmKvBJdjm5EAAN9t6PZOF84n4qq5PkgWoDfPTSQRpUxxI3mF+Yl?=
 =?us-ascii?Q?drNOScTSKW/iNd5CvjZ0TUbeRoSLQqENwtCiHl6FNfBvAEM7ZwFzVyIXhdWs?=
 =?us-ascii?Q?XBuEEfG2pdV6sp11yPJssnb+e0PU26+v5FjA/tyLQpGUXze9uUx6WZ+qGsNj?=
 =?us-ascii?Q?IU3T7Nm88wsUD8qLUAJFYos/7Cs131TwFd2XOpR+rQclZWvpT1gVn+tPp7K5?=
 =?us-ascii?Q?vk5/k3T2kvJm/kZMFO4l/A4v/fGgsnhLFRqxpMGRP27b05MGzWqvh4Dk9k5K?=
 =?us-ascii?Q?ugKAEhwBSTM1jKCGk1t5r5MRa4cYIeHckLGmvQ6/yW1nt7DPLEV7vg1QEOFR?=
 =?us-ascii?Q?BIyJywRifNTXYTjOz0s8kNLPF7trJN8MUEhu8r8Fr9bexVKSi7mX0gC+RTIU?=
 =?us-ascii?Q?kXqFdM3K698sZ3topU/4ojUkBTw6jfyftmw/hhhsGPWLRDBgbphHchcL3nTp?=
 =?us-ascii?Q?K3myOq/nFaxJaP/lLTS8sEouv/McNmLmjWVRANUIEnYabG3ptwpPv5hiqRde?=
 =?us-ascii?Q?ROVkOmK9DBHtuJ7v3U5aS4Y5ylNooyoGi3nIqFJNx9/XgKcAzVsCGu3RBDM7?=
 =?us-ascii?Q?gBvHf/CUAw2NATVXH638DlAEokZm5yHw/7b+aM4vSMAkcZqfK+dihrL0L0UR?=
 =?us-ascii?Q?O+ncTzju6742l5CWSJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hy9wg8TcjK5tD3Y054lkho45nx3GFIpclfkwdFJNUQk46ecZH2VYab/Ek+a5?=
 =?us-ascii?Q?QyAjMh3nT62ekZFfOHkGgCnFRk60nmw7hYVCZZoWW8Y+6Xu+7IKf5tiQaRC+?=
 =?us-ascii?Q?UdtFegfqMjfVjkK3zuY9jFUgt3ikL9FvZPQmJv71VLkAZYaYPRARHl4T5fgy?=
 =?us-ascii?Q?uXblZD93P+tvDv/XCAGuWUFIw4oXIiW2EOkfzgpQYs6EfIYoBBAqfpujAmBc?=
 =?us-ascii?Q?GxmQJrkrOhS0cym2XXHMtjYNUuq7NxZoHho+cUc/RfaibL3MEa47yeuv568L?=
 =?us-ascii?Q?EwJOihixY5zrbFGLtyqCmqsZcRCtjoC31RYdrrWjcCj1xFRUhHw23oZOLwfB?=
 =?us-ascii?Q?L9mCfGi6oQyDplzY9r4tIoQG4W669MBg98lZQK6fC6YQXXVm9VLn3fOGZXZM?=
 =?us-ascii?Q?TJGvB9caMJ3n4VBHWwtpBpk3oB5JbmPF/9p4XkW4YsVyP7XJjlepZ2rgcZfF?=
 =?us-ascii?Q?N/+08nGTs11fuwOEqkrPUWpVU8DFIOR1ZADiAVcKtXVvTz0kqd3Md+e6Xmi5?=
 =?us-ascii?Q?lch1jXY1tgRUBN2v9eW7rrQPBe5whYqk2MJHTslkkXsJ9ey7JJL+W9Qv74Bh?=
 =?us-ascii?Q?fvyWswFa4cFDCkrcxx/+eMjP8TwEMAdNwITdFYAb9YJq6pirmKhCOeTedCAF?=
 =?us-ascii?Q?1aXlIAP43V2rlWkN1oaCMmcbeYH6Uvom/YzpoIE2niJxXw6Q/U8IXoSp3aSo?=
 =?us-ascii?Q?HNE5mVzuMy21/QTNFdyjXSTSXtk0FEuZJEGixba1MpK+vX3tieBiYgqaujN8?=
 =?us-ascii?Q?JcIiLPxODJL6Gy9byfchBTHMeNzaRmLsGKvBnvbOMG2J1XHk59EQZXnE2hgX?=
 =?us-ascii?Q?tcyZzBDjxmwNoLkihtzkgq04w4/Gfj7sW6rNltdM02FTF+aqJAwxf2XrJE8B?=
 =?us-ascii?Q?Jz99jW8tJsVRLvFwG8UZC1jv7sXkSiS0/2J6HYlPd/a0uR7KK9NaftlJyR0T?=
 =?us-ascii?Q?sKnoVlFBxsRhAFJa4lEn4jwnqxJUplO89q4dRQ4063gBFabGSfPjeqkwLtwZ?=
 =?us-ascii?Q?f5mCI18SW3HwZ1j/FmSuoS4Ixec6XnZXVMzwrGGPv5lPSFXEyeTbgN5fVjRa?=
 =?us-ascii?Q?jdiL8/yj5RhwjhKybVFou0BLGA6IV9BFvcScg9/qG+cuVFyX30Xtv9DRy6W5?=
 =?us-ascii?Q?Jhez7J42xmGxG6dedlLcY3NuzIgaJRgGcfGsxzArcBTmcFphmZr5xqc2F2fg?=
 =?us-ascii?Q?qS1O+ky/4/33Ppsw3CGo0q+mjUi3qn30wTVLRPITLuHrtLEmplQmHdxNqSu/?=
 =?us-ascii?Q?LF3WGfZWKnwH8nLUZvta4YZW+WKVULZyx6gKE9lvFKtGl6dIyyZ1fEs/bCrv?=
 =?us-ascii?Q?kuUrreW7MziYycVRKFtQO2Nou2FBX3Gier1KkpPreHFF7X6uGz0snY+w/tcs?=
 =?us-ascii?Q?QvG4J2kRmD1Dc6dheCcW8oASER8oUoaHY5m0yrOibVAqrErW1Hfo2vIGSkQz?=
 =?us-ascii?Q?mJK00OINds6I4tZunOUuniu3sIZ2RoigrqjTkx5jtpkat8riVgHJsREi8oLf?=
 =?us-ascii?Q?e6ZOSCO9sOkzdFiYOYRDz9cqgMXV/aRmY+dmV/8bd0kvnqiSLYan/DwcbXu3?=
 =?us-ascii?Q?TosXLEED7aXmy07AIm6yoasetVNnxaqwaPcqGHDCO9r3rdU5j74DPaCN0Wc8?=
 =?us-ascii?Q?gGl/pJTyJgAlB3tiAGlefd4E8NpP2hvSew04hgddwsUrtQmQC3Ab0Z7UGPvG?=
 =?us-ascii?Q?faEBf1wCVG42NfFLjHr1RFZ57DrCQek9YXSUb6i+LAZl1uXNsxszG1kdqXMR?=
 =?us-ascii?Q?DNsEMFv2yBNp6JS40zEK7YnXRPf/rp71h2Xr3cdDLgydJ85fhPDz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ca594217-1713-4c0a-87bc-08de5fa649b0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:21:33.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT692fMqaImqe7pLqPZB0YDDb+6SN7xGZyvnu31tT18EaxYakQtrMfI711148gHddDF8W1cUMaVl2t5/GAAsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6742

On Thu, Jan 29, 2026 at 03:14:51PM +0100, Niklas Cassel wrote:
> On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
> > -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> > +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
> >  {
> > +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	struct device *dev = pci->dev;
> >  	unsigned int i, num;
> > @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> >  	u32 *indexes;
> 
> Hello Aksh,
> 
> Considering that all other functions that you have modified, you have added a:
> 
> if (!ep_func)
> 	return;
> 
> 
> I think you should do the same to this function.
> 
> 
> >  
> >  	/* Tear down the BAR Match Mode mapping, if any. */
> > -	if (ep->bar_to_atu[bar]) {
> > -		atu_index = ep->bar_to_atu[bar] - 1;
> > +	if (ep_func->bar_to_atu[bar]) {
> > +		atu_index = ep_func->bar_to_atu[bar] - 1;
> >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
> >  		clear_bit(atu_index, ep->ib_window_map);
> > -		ep->bar_to_atu[bar] = 0;
> > +		ep_func->bar_to_atu[bar] = 0;
> 
> Not related to your patch,
> 
> Koichiro (he is on To:),
> 
> don't you think that it would be clearer if we had a:
> 		return;
> 
> here...
> 
> I mean, a BAR can either have a BAR match mode mapping or a subrange mapping,
> but not both... So continuing executing code beyond this point seems pointless,
> possibly even confusing.

Thanks for pinging. I agree it would be clearer. Since it's orthogonal to
this series, would it be better if I sent a one-line patch?

By the way, Aksh, thank you for addressing the newly added address-match
mode case.

Koichiro

> 
> 
> >  	}
> >  
> >  	/* Tear down all Address Match Mode mappings, if any. */
> > -	indexes = ep->ib_atu_indexes[bar];
> > -	num = ep->num_ib_atu_indexes[bar];
> > -	ep->ib_atu_indexes[bar] = NULL;
> > -	ep->num_ib_atu_indexes[bar] = 0;
> > +	indexes = ep_func->ib_atu_indexes[bar];
> > +	num = ep_func->num_ib_atu_indexes[bar];
> > +	ep_func->ib_atu_indexes[bar] = NULL;
> > +	ep_func->num_ib_atu_indexes[bar] = 0;
> >  	if (!indexes)
> >  		return;
> 
> Sure, I see that this code will do a return here...
> 
> So there will be no harm done, but, having a simple return above
> would make it extra clear to the reader that is is always one or
> the other... you cannot have both.
> 
> If you agree, perhaps you could send a one liner patch?
> 
> 
> >  	for (i = 0; i < num; i++) {
