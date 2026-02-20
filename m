Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021075.outbound.protection.outlook.com [52.101.125.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12012D7D47;
	Fri, 20 Feb 2026 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610003; cv=fail; b=QAXluxoqavzjwC8Pm5CnCJWEjbTn8Zj/LTqCGZTlX2kk+poJsp2h6dp7Wx7JKDl2PIVGmYmkv1dTBxmwKIk96rqtWRrFQ5I8TY05LTcVni4QkQIlGHIx6/KaZ+w8UY+moXp/E1Eecuc62QzK/gDnARABvcHnV2knfCWgRHs/QaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610003; c=relaxed/simple;
	bh=4cTBT9XkRH+IvMAmUiXkr+SWZiVuWxiZmmnTPC+HYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3HoNfEIbeJHh3+oBtK+fwCQR6FkvGUMT73qFTnL9mq1Bj1K2xYHX6sFM+4ta8XEZDryjtDFQzlIusBzcOXyMiAo6cogusmedgH6XgVnN4jAZaJrx2leeHEHpLd3in/CNG6o4A6wqWum/jHRh7iDqAoq3+K3j9yfAR15cS/hb+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uCjA/caN; arc=fail smtp.client-ip=52.101.125.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uCjA/caN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr7UE5I2f7yNfoVif+K6eQ4f5cjFlyJ1z+RDs3NnzhHl68B5ypGUPGiUZX2ve8Oct/PZr8rh3pK6CNYCA0LTraDpDDLisaUCTXmgVZoFDJY/VbdcVcCvQHY1B0RmbcLJdXITAVVny8ZW9zH+Sc+0GYshzV5UdIekR4gU2FVjvDFeg0pHk4RZYpgU+7v5C3gVjURieRZ17DLoBu/MOUNKZtKS/f2NM55kzXYVxTgViI6PTAwQV9v1Q8oGihjDPUrqH2WvGioUhBCzPwJVQAuae9EbOSQRSKQ9+mrJnpKiFteol5Icu4HkUGw5jndllTY70pvQkRAzk28luvvz4kwjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpM+Y9VaxfLX7NXd2UWSTbFUUrRzq39dkiySEADuRT0=;
 b=pr7M1+pk/zW4rA7Ehu39yMl1PP53M0LPExis8xDL/N8vT0tMShQUm9NlX+RdzkcgcyTKR5TWwi84JEFzFrYwCA5dO7p9hLBYPNgf0nok+dy0cYwDuZmLJt9KR+Er1RtepbzJi/eDTfRTwGamXTihZ4/TpR8aChmQBoEUQBe/GwOXJCt8g9x6EPrId90FJH6Xg4JkQKAM0M4NedtqiR6jnR1bGN30DEcVEqBTgQ5gAl2cRg6LeBJZMi/V0CfWqtCUnjGUexiMc9Tr1m3D++FecPwCVAN06aDuno1IWx+5SJepuu8aSEPWCAlzt5VAX4NiLlz9y4Twt9b/0VWLnz/hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpM+Y9VaxfLX7NXd2UWSTbFUUrRzq39dkiySEADuRT0=;
 b=uCjA/caNBSkz324liiqtqSa0HPOJN/k1HCK60GuEkVB8v3bFeXVHp2GKFeBXzC5mEfUqkjkzR9kJCUKkUWWPFLbVIGKdzYF+V65MqAI068WHzGoTMw4t7/J11Tyf+4Jqr7/i8ETqC5HEKXiMV8Kcz2IEz1ZFdKYIDI8Y85jPjGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3592.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 17:53:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 17:53:18 +0000
Date: Sat, 21 Feb 2026 02:53:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, kishon@kernel.org, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@nxp.com, 
	shinichiro.kawasaki@wdc.com, christian.bruel@foss.st.com, mmaddireddy@nvidia.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <hew5wbd4fkaqlykv763wss3jirv52b5fyypzirvywysldbw5hh@qpds3syxgxgc>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-6-den@valinux.co.jp>
 <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
 <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>
 <aZg28ligp2ovwuiT@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZg28ligp2ovwuiT@ryzen>
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3592:EE_
X-MS-Office365-Filtering-Correlation-Id: d1845cff-7267-4b84-2829-08de70a8ee48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGS8/Ev6yjxmk07N0PeM/xOeQ5uFnXtfwBlkU+s68RL1wpC9arLQPJ9xlEfR?=
 =?us-ascii?Q?7drLx02s+fMglAWJUtcDK0Iho9RI3TnuPk83plyVQd6/Y6PYYg0Tq0ocFHbm?=
 =?us-ascii?Q?3oGsCzQYnrNTjUHsr+lwj6U6sIxwlyQ2FunNwCRvBWU16w5TpqNBfhG36EMo?=
 =?us-ascii?Q?cgA2N/7VravL2ieJ4rg9TZCx304fGi1FiXhXHLVEA3hbItIztD0Ok3P1hhtP?=
 =?us-ascii?Q?6hKD9nLc1JL7/FMkCbVAJd/Ev3WQP9dB7jCAkzjaDcvjAiqNNrPQ7hfRKEx/?=
 =?us-ascii?Q?tCrpblkZ4lxTVFgs/ZKozfLX5W0sOCP/vdNQ+0UgOOCirwpLloVZfXGd1C31?=
 =?us-ascii?Q?veYyFVDm1lc7k2cOWkHRqm4F5Kpzua2p5f7tYU5hzZyVLrclbbr7fadL/o/m?=
 =?us-ascii?Q?WmLUu4VaCdmJdcNtoEGZNIOryqSj1hiE8mXeZFLk5k3RjP3Uz+LPXL8OVtHL?=
 =?us-ascii?Q?2ANtroHdixQjem3kEDVIbaEnzBZ9rlZV9PM2b5RdcZxitQoahrJdAu5E8bva?=
 =?us-ascii?Q?A/1HuYIvtcUAKT/eNI7MKDjzLcQ50CZT3ljQw/PBl+cvWWZrf14J1QK48t/j?=
 =?us-ascii?Q?1rlGnIWEw6xRio7un1fEBURaZmxg2/cktZ59w2+7lhs+Aljej+bcavZyfnz6?=
 =?us-ascii?Q?CveH0kopCvh4nltMwwKgoQT3vOA5gNPaJqwFKjesvSl1WGboFyInH4gNkS6Q?=
 =?us-ascii?Q?NjRBG9IItzyInZ8vhM/U3cm529Zb0TXIBrvKHJGL0x4fp4W3RCOIvfNdO1P5?=
 =?us-ascii?Q?nLBLM2+2k2wS3G3rCeiFFpm7gCkcmrYOjAdOcOELdNz0OyrBALq4xLzZD4Ap?=
 =?us-ascii?Q?p4PenKiJxaxyBtODYNDuIneHGhdhMVCUkOaBHTkwDR0pUjQ9zG4LCQWBwNdA?=
 =?us-ascii?Q?zNAAqR4w1eCatKpRqXueyHyWFr6V05Kw64cKzcxa0JsBc1hFpGuGA2LV+b8g?=
 =?us-ascii?Q?RTmJvlESqrL1/bXTW/v1JTR88pII+1A3bxzONT+qNeFslI1q4Kb6SQjeX+bK?=
 =?us-ascii?Q?fZwLb3JcLJ/TOJ359Moa2Ln5btLZ9DP7ffQFsqx78kp5xejcAQ6Bwu0TfRWJ?=
 =?us-ascii?Q?pzTV7iRJEpZIqsdCycVaIq6bOFtMb0LiCibjvk6v0bLHJpLWByf07ir/euT5?=
 =?us-ascii?Q?gGmZ6OnKwQbBt0/B5x/L6Bo/yj+k2Som+SphTLPR2olWVYQvE2nmmPmDjcfN?=
 =?us-ascii?Q?s12kf4rRZH8eTcyyE2IMlQ+LH6kHrs8PTx6uXVZ+XFtOKME0HPLLYkzWS2fx?=
 =?us-ascii?Q?ynr5GJgLdX/cHjY44fiXA8MzpPPsGCuyPnkc1wMX0ri4d6WMmMpfXHcLQ/dE?=
 =?us-ascii?Q?yrexgfPsbPTa9BWGNgV5gh8bMZ3mfmWYAC60Ed29bzuMcyrNzicrCPrzS5q6?=
 =?us-ascii?Q?6jh8G02aXcENaoXnloPxh64o2jtiGK5NGuf9PbbBnKPZQxTOu8TcpfewG5iG?=
 =?us-ascii?Q?FgXaCJvRTO/SdP4KVfIRvu+/7ubK5Gr73chORgVhl9nGBGPFZGHGanjzxO+N?=
 =?us-ascii?Q?Edo/OEHTp9gyUb1CJJ+4PfMPlq0ukHjVNx44?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdbKUxNuxvx18SqH/CgVK8DhVCvel+KzTzFP1W69DVUtbx/6fNCGZgHMuQHw?=
 =?us-ascii?Q?Kzze6/x6Hqbml8XSr0x0siD9Lj3IhixLNGIs4QpeJMTG7a1HCruHVK1EUiZ8?=
 =?us-ascii?Q?kFTR4edRfWZUPFtKQmmuKL4jghln0+RaX6B9BHBZMixTGFQtm+1pqNJmVbrw?=
 =?us-ascii?Q?L9Yc5yE808JSWuCD44zNqQxgcRRgrSYBqqP1tUV7NHEz7MfAa+SlIDT/pubv?=
 =?us-ascii?Q?8s5n3YV9KSOzVDgYwZh+Mkla91oEA88c4xOcMIKEfY01ru71IDIwvmE9qw0x?=
 =?us-ascii?Q?z5BENu8AaXsny6TKDiQcKv0XwYUptarijaAHQ157YQCbEr8/HfhhdKqBES0V?=
 =?us-ascii?Q?t82MCAm/c2lSXzf4QhnYtYoUTTvErXerAis/cK777u9Dde8NtFVK84jkaPAU?=
 =?us-ascii?Q?Uw6WvHzCMJhNTH7IXUymOcOPugj8msu/MU+air6kJw8xTLRiCKL/1Si/8G2E?=
 =?us-ascii?Q?sUMFsDj58mXdgv/PTMmOvHbEWo+UX/XUEIkySCfBeOeBIFhfxqPkYNaj+rYV?=
 =?us-ascii?Q?1uvym8NxGNaYtnxH9CqLoBVjvG+AufT0WGUlfVMt1xk1JI9mgqmNaxZZHiKu?=
 =?us-ascii?Q?0iD4/jLGPIj+GMi8o3ysnCmJMCDXRKiO8SaLmr4U///i2BT6s6F7Pmtk+2h2?=
 =?us-ascii?Q?vg4Ak8Ke3FgQit7Snj/RA5knHGp3WD7q6bGZxBmdby/GVMlh/4WmzPKUzdtC?=
 =?us-ascii?Q?vhaTnLXHTO/35iOTHL/b5ZTwlquNnsbw1UqO87UOAn5m4SRKnfe4GZEabfNC?=
 =?us-ascii?Q?yo648I+wZR/42oWF/9plpBArzDqU4gT/2joNn0bruV57qQkG5WFAqBfhlVQB?=
 =?us-ascii?Q?wZluASy/xaDL1YCA1pb7C5p2uokexqLylwAoJjQ7QYuMZllfkBSfgyn0BPVN?=
 =?us-ascii?Q?LCOQdAUFWSAB6oPV5grIpeLSFRrQx7ttOsoX76SJlS2uzoP66ypPvLgOWvj3?=
 =?us-ascii?Q?Esq1fIvyPZPcm45NPxydc8cgZSiEvCyBf3fj/foDer43OQXxvM/TS5TMX55r?=
 =?us-ascii?Q?MmzOXHz15xsb0rOm8skL+WW9SMVt7UFG38B36J5nUzOEu9L7Iequolyb8dnd?=
 =?us-ascii?Q?g8NgTyIFldyETOYmh27Tp6UOvas29xhFtc5eR8/b7JZPlbD93UG8UkgcMYfu?=
 =?us-ascii?Q?fRTj//+gNdIeCJc1WqigfkSOp5iC8B5nEn1a+Pb4iGT+v+SZZytUbM4MSESD?=
 =?us-ascii?Q?3LiJbpsuIClqL4ktlerRKfP6X22jpUVYq34FmiQy5I5rizvqJ/awP69uYQpo?=
 =?us-ascii?Q?onBPHQ3IDQQ4qXvk3QU2uiberXM2ItBNtGj5O/ORzD90NXT/4ejO7yLiP3Qc?=
 =?us-ascii?Q?Q/jAEy4GEdfy25ku7k7IColJ1ez2Z9DCzRGwNJP2hgNHy6uTdR2uTmsm93hI?=
 =?us-ascii?Q?va6Oa1jYXxcvgAmLTOajn4D3POV3XhfhbFn2whHkmYmgYLhtknq1Nv5h0ptl?=
 =?us-ascii?Q?wcmivv/SOCs9ZyuL5ERXZZLDLxIkRsjgJikXX6edwxzGAWcaVu3M+0eyWOKS?=
 =?us-ascii?Q?Yk4vjIcvgqX7bkXO7tkMkv4xFsyhCFdylfCp3uxzEFn5rJE3OXMNxuBZ6Q7u?=
 =?us-ascii?Q?e/vTQRB/PtBZeVp2HA8jjDiqJiE6BsErubDMAHG7ez5D6a2bupzhnLRf7ZOy?=
 =?us-ascii?Q?+321BKbQKdQy44zkA1rIxxHLjfeiFQHTex1AhpFwVqsQHiNhhMP+Iomy5DRJ?=
 =?us-ascii?Q?lBAKZ0KLnDxPbrztASE4haoPtQwGYGOuh5EF/Khd8Cls7+C3k1CQ2IskaKXh?=
 =?us-ascii?Q?xfxoLRKlhhWlLPeoIN+oymHHXtoschYYM3GqU7yaB7WHj3JgolH8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1845cff-7267-4b84-2829-08de70a8ee48
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 17:53:18.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnifHk+hOKQGkWApg5W5SrV/fBoaENz4G1x6DivEpYeN1vf0d0zVVWhTDf7iw6XhngecxMlYAbRnilwWN8C7Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3592

On Fri, Feb 20, 2026 at 11:27:05AM +0100, Niklas Cassel wrote:
> On Fri, Feb 20, 2026 at 12:35:31PM +0900, Koichiro Den wrote:
> > On Thu, Feb 19, 2026 at 10:00:19PM +0530, ALOK TIWARI wrote:
> > > 
> > > 
> > > On 2/19/2026 1:43 PM, Koichiro Den wrote:
> > > >   static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > > >   					    struct pci_epf_bar *db_bar,
> > > >   					    const struct pci_epc_features *epc_features,
> > > 
> > > The return value of pci_epc_get_features() seems to be used here
> > > without checking for NULL.
> > > 
> > > Since this function can return NULL, and other EPF drivers
> > > (pci-epf-test.c, pci-epf-ntb.c) handle that case,
> > > is VNTB assuming that epc_features is always non-NULL,
> > > or should a defensive NULL check be added for pci_epc_get_features()?
> > 
> > Thanks for the comment, good catch.
> > 
> > AFAICT, this is a pre-existing issue (at least since the initial vNTB merge,
> > commit e35f56bb0330), and the same pattern can be found in a few other paths in
> > epf-vntb, such as:
> > 
> >   - epf_ntb_config_spad_bar_alloc()
> >   - epf_ntb_configure_interrupt()
> >   - epf_ntb_db_bar_init() (the one you pointed out)
> > 
> > From the current mainline state, all in-tree pci_epc_ops implementations provide
> > a .get_features callback and return a non-NULL pointer, and the same holds for
> > the in-tree dw_pcie_ep_ops implementations. So in practice this does not appear
> > to be triggering a NULL-dereference issue today.
> 
> We should really clean this up somehow.
> 
> 
> The problems are:
> 
> 1) A long time ago, not all EPC driver had a get_features callback.
>    Now, EPC drivers do have such a callback.
>    Ideally, we should probably add a check that an EPC driver implements
>    epc->ops_get_features in __pci_epc_create(), and return failure if it
>    doesn't.
> 
> This way we can remove the if (!epc->ops_get_features) check in e.g.
> pci_epc_get_features().
> 
> 
> 2) DWC based glue drivers have their own get_features callback in
> struct dw_pcie_ep
> But here we should just have some check in dw_pcie_ep_init() that
> returns failure if the glue driver has not implemented
> (struct dw_pcie_ep *)->ops->get_features)
> 
> This way we can remove the
> if (!ep->ops->get_features) checks in pcie-designware-ep.c.
> 
> 
> 3) Even if the get_features callback is implemented, EPF drivers call
>    pci_epc_get_features(), which has this code:
> 
>         if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
>                 return NULL;
> 
> So, it will return NULL for invalid func_no / vfunc_no.
> 
> I think this currently makes it quite hard to remove the NULL checks on the
> return value from a epc->ops_get_features() call in the EPF drivers.
> 
> 
> 
> 
> How pci-epf-test has managed to "workaround" this the silliness of having
> 
> features = pci_epc_get_features(epc, func_no, vfunc_no);
> if (!features)
> 
> checks everywhere (problem 3): It calls pci_epc_get_features() once in .bind()
> and if it fails, it fails bind(), if it returns non-NULL, it caches the result:
> https://github.com/torvalds/linux/blob/v6.19/drivers/pci/endpoint/functions/pci-epf-test.c#L1112-L1123
> 
> That way, all other places in pci-epf-test.c does not need to NULL check
> pci_epc_get_features(). (Instead it uses the cached value in struct pci_epf_test *)
> 
> pci-epf-vntb.c should probably do something similar to avoid sprinkling
> NULL checks all over pci-epf-vntb.c.

Niklas, agreed, I had the same thought (ie. bind-time check could be
sufficient). Thanks for the follow-up.

Alok, thanks for picking it up.

Best regards,
Koichiro


> 
> 
> Kind regards,
> Niklas
