Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717934D4C2
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521151; cv=fail; b=T45vBa6tvkhA7n9pPmY07texxXdFLR+GD5Mlo+7xy6jNkKFnFSOosRclP3ADTs1kGDX8VGlbuhNSFqHpVlkTw5Qs7brcrqxhBwLOziAJ34k/Ak0zDsF+UNJ3vL33jpJvpKSxBXVfNcRnutfD8p2C6L0peRJ+h8lP9hieRHaCo/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521151; c=relaxed/simple;
	bh=KCO5igl9FRtwPYo7UkuI6Q8XnRWgKRqJbsPxzZnuGlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEY1lROW2T72CmB1est3r/Wz0qsG+Pd22os0AzTFO329xwKwYihJTbGBCQwfC6Wiun2kkX5gIdzalzKy2nfXEDiw+51d/QvIB7/lLbi1QGpMzcnKPDzN0dBZxsZtfyCC+efxQxWnF2U7wWWxHa2Y5TBZg59NLShwkORYjiUi7uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vez4IZFn; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vez4IZFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKQVDkxqMVOfjnnQm0hzOrUALWA7+8MAgYf7qOwtfU5/cTp+aoUblKiSe3OSH7s5izXwGEMUMH7pYuX1etEYGGp1E6x6splPIZa/eu8zVTPGL28q+1bssrfce744upebRtZohekRnrJRnfexZMoTmSKwSWfALB2XOG0PwfrjUEdNP0pI1S0OMo0BpnrW2F4zLa7hx9HXJWxRsVooZtY7VIJo8cHJFx2jLqR28okwVNiRRUT+rpB5bs6qVXsfl1HlTtFm9UnYkUJI7Og+ypidAXW0eXlqYRtMEpRfPbZTp9vZj1HbSjOw8bAQd0P16gqPKb/6q5qH5PXlYql2gm6vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/EwJcEhIwvaz8W9SIZX8WbRDWZHjovYSVRaCcd/gB8=;
 b=wwnRwvrza1zuFpV66YwWoas4uc/lYk2Jc2AluiGW8w9EL10AmpSiJiKAl3cTbrFM7vnY7xMz6hxH7fByzRhXdubBQqNLeoKGAuVBmeF7uEmesw1M9fgTgeSVpMRhDObeiwwvS6hjC/AAi1QqchAH/mBRBVgtvIdOsnFn7VAM8Nkx76cYGoupwyv+A+J3TWRIRrbCe5jd3V9LiE6VmOe5XxM8miUE4oepAtlcxSzZwCd+jBqZrmK9TlLMhDtev939NyC7f27mFM1qiPeslp1xP65IqTJQuAfoJMriQ8wQUhCcDJHR2DSg46Za7lOV5jRkR1DEukX3UQ4KRpz1RLzrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/EwJcEhIwvaz8W9SIZX8WbRDWZHjovYSVRaCcd/gB8=;
 b=Vez4IZFngE1msWSMh93w/jkoVV2YoIZlRd3MyqrtcWHMeBYuZOzHoFyWXe1rjSyObVWkRYnc/Ykfs+PpXYvmL+DyGF8e7Fs0C18L+5P76xikf6mLNBJUoVOD2JNWQAnvyuSGHRK8gHdVdTmLCoazbH1dWAFSia2rpk53+SDmUfjf2Yxxkg8+p/Z6Y2akuiPSaoy5t2LEzd1yZX7M06sYPMNig6u2XjsQwIJi+s1zlGpsrP/Vy7+Q+ZayrOBrgbnfG/Fin3tqn/KBkH1p3oSufxKIoI6Llk932qeteD6M6iDck3Su9hnJEcdvAyFylp7v/zLV7Jle3Ms4Ajee1y8lpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 17:12:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 17:12:27 +0000
Date: Thu, 19 Feb 2026 12:12:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Message-ID: <aZdEcbN5bXoUS1Xu@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
 <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>
 <aZWXzzul8xRaDQgm@ryzen>
 <aZXiEWmNEdCfXse2@lizhi-Precision-Tower-5810>
 <aZbZTyrsrSgcX2Ly@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbZTyrsrSgcX2Ly@ryzen>
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf859a1-327e-40ff-b689-08de6fda0e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQNjHkN+WhF1Dk+bSR6ktW4k7i0QwEiFqVE5DGfX6Nkfczt0+2BT300a0dPA?=
 =?us-ascii?Q?uOmj+pl5IJ4uaW+UtiLJCBdtNwHDjureEUs4j7DrhPy3iX0E/OYesqvJuUCe?=
 =?us-ascii?Q?HOllzpYyqxrqvBL4K0CxT5czhCEKWQ5Z4Qta+93102dwEM/FSqqxh0wTVx/X?=
 =?us-ascii?Q?uHOxcTDE8kYqeQqawnsf4MWS4oaNtcL01Gm2YQRMTGb/A3B4WgnvQnZ04NjO?=
 =?us-ascii?Q?ggu67PHU1cIu2ukq1jFod03kHbM5ZKUiAJtvMNt7MDCD45d3u/l/36Hmru5e?=
 =?us-ascii?Q?BrN1vivojbNcpt968tifddcZ0Sy31MUaqfZ6/jQFBgBMcDSBjKJ/tJLMq63R?=
 =?us-ascii?Q?6wAeE1yHiWBA1sFWnAAWHjjNqVPbWbfKFC8kVVS+mzGIJM6z1QhVFNaGSAc3?=
 =?us-ascii?Q?v73OUc8LFiWa15UGBqpcgiMbEVnrGPWXaKPJ6DozDq32LoQltTGYeKo8YNLJ?=
 =?us-ascii?Q?Ahr7GbvL9AFEig9wxJThBrSlTeQNstSA2EXs/mXuDzONH3F1LSIwD69h60lT?=
 =?us-ascii?Q?DWdgk8PsOFlIy/CnA+IcpLRPMegnAIKEep1NI4YCZc1Vrk8n1HleRsvjLheb?=
 =?us-ascii?Q?hi1xwndXaGqhTpm9+0K8Q2MS4PQg5Iv7AFLSlBPPoQhTHU33RYV+2lyTIWAZ?=
 =?us-ascii?Q?tcbnZLipt+Zk6PmGwKsuI2ShQumSqfXMUmcTH333P6L3lLFeEkNLJizv+MKa?=
 =?us-ascii?Q?a4hbimlTiF+N4TCuehO/RTt3VyIlevGHyaV9wEcf2D12RvZfr2NXCcASC7Lf?=
 =?us-ascii?Q?EZxqQpDqoIcV0mT4BkuV0IiIHqoCbwRtVMI/Ve0gdlaO9sKmYQHkORKb8oRP?=
 =?us-ascii?Q?wAs35H8wxBn0nTmPYpp9w0rrK5ly6uf5OEW+JumpBlyTnGb9wHsO4oFy3n/C?=
 =?us-ascii?Q?OaqXwqxfXGa17RJGxfpJ6ZUwjNsQG5OfZgM/r7Sp/33h5eC4Mnt02kuhzNm4?=
 =?us-ascii?Q?I54MzpkwZP+opsSqOSwaqcbK4GVPQSu+f/EhrO2zlTu5QWpIlIjVF9+lVvAx?=
 =?us-ascii?Q?uUoiyuFtLgENdjRydLghkM+mxJFDWg4rwXKXCw6eS8N+URDQ6CHHWT90Xcv4?=
 =?us-ascii?Q?diTxlja1JQTEXo5r8g64o/BAk1zTLSWzNMNErJdlKjfOFAMPsJqzKvMIq9gJ?=
 =?us-ascii?Q?dt1NuhuhNnJLBDt4IdNXIYNj9ajcMVl1ArRXhRhTpCT23YdRGteyCI5TebHi?=
 =?us-ascii?Q?jCGWwfuWsKFPLi4Z+965Aqh2z9CnYaNmjbYnaUjQoJoXYu9tKKPNNNJDb7hn?=
 =?us-ascii?Q?06xTaogXwfuoQ9LS3Nsu/ZAxWrovU0dHJ6/5J8jfn3ImHR/jNswiv0eSpeFk?=
 =?us-ascii?Q?LriHHR3ApiXzRFXcg2hqr2DCqEf1qsR8+yrXu7ADrow+OvCZwFVC0bgqRz7c?=
 =?us-ascii?Q?HyZUqxhUFo06SpQ1glFkhIVHstv7kP8UpoEnTB3ozP1A4sAQB5e7YsGVd8vN?=
 =?us-ascii?Q?JrJ8zLjl3k5ZLf1+ZQLwp6BfwHuezI8qDYKNxYfjbx/U1LFI5Pc4lS2ol4PW?=
 =?us-ascii?Q?TORKQHM30+rrLf+7rRLjNa5zy4boWjBocoPHMPRuv013M+X6r31vsR2ucDSG?=
 =?us-ascii?Q?7O63PliI8+vsU1EOJH7nkRcVa/Ss7yq24yh+mCImB+0PA92BjjH+wgPxeZHO?=
 =?us-ascii?Q?YlOM6u3w+Au2Hcd18f9aAcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AfE5sxyUk9dLQBoRJ/9CkznDTCKxLC3OnFrNmWs0cS/PyoURgVSauVPaVZJ?=
 =?us-ascii?Q?FiZHWuN8x6Om4rLF8fKxqJ2jfNlllrBEcCPqbKeb+c2JhS8hW42vhcRbu0R9?=
 =?us-ascii?Q?GOTLM8p56rnQOAPeQ0MwYJ1Aa7jZ6N0nZB2pLalzLUYJGTi0B22gm630tF/U?=
 =?us-ascii?Q?kOMXAbazcveUAGY1Nnn7BXTl+ofNtKjzStYR9dV8WRrrmUQqSc4ty4EpkV4K?=
 =?us-ascii?Q?L1fYpBGKG0YTuHkq9xiQDBoXwnkb2U+uO/VweLAeY0vpIiGA77XtPeJd+6Fl?=
 =?us-ascii?Q?DHz9Cgeud6ytQSfiMIu40PMjspa9usmDqK7hfqRWSooMvHZaqibtWOHqziSD?=
 =?us-ascii?Q?GVKSquI2vubt2rrYfURUDT8i+30mpYxqpM2tEj1Ge3Hs7a1tKVeZE+WoVaBS?=
 =?us-ascii?Q?WizaxYhc+j1P8p4JAorF+EWE3RYR170pYR6VDAZvFzgnYZz0mZJbed/1j1Hd?=
 =?us-ascii?Q?O6xhTOVHgA3AFpEZQ25KBGreq2WkMTyvZYPXhD7ljglIoizDIDSLCTMM53C8?=
 =?us-ascii?Q?lTAP1oYhXp3chxaWw8vtYBM0jJcMC+bolvhCjb6qn9/zez67TE4rLDdXvtMf?=
 =?us-ascii?Q?/7A2iw7g75WjbbWl0sSRhhWZIE64UkHmM0d3+G1dUoY7H6B3J2aP0lTJllNs?=
 =?us-ascii?Q?jE4XgwR4oPbWysPo4LpOvDyehoIFX2usKrFWFEphWEgaF/u3KVuBguChHKsc?=
 =?us-ascii?Q?9foHOgBEEKWahwmdukXLzl6hbyVRimiPX8zFJpfmpXJTUnuYw+2TIWSbF0fM?=
 =?us-ascii?Q?8HgZ7qg7x0ZJ6bwrfnjaHMfx/HI4qm+m2hHpj9u/tfCWPiTsY+Cj/emOXWmh?=
 =?us-ascii?Q?Z96YODb811D2YitIFUYeXxNwgZUMwpGN4x4OcaHUUs37YuK9NoOOI54kvhcy?=
 =?us-ascii?Q?JOnGs2oEIK2LkDvPowiX5d0DeFmrdO+aU7pb09UY2vvzYdNBtD7d9mbo0+Ra?=
 =?us-ascii?Q?OrMSwfRtqgi5CR8UyRmQPA+Su556enL5pZuSSmJRFKnq95Ws8Uu0+27Vf/bZ?=
 =?us-ascii?Q?RjnneifIMpvobPuOYRkxXSoihDhpYgLjqOAqlO4XqMEwPwQay4Qkh9Zz5CE4?=
 =?us-ascii?Q?WUexaxIPd3zJAEhjtbkjtcbPPIc83KRuBmbEyoiPgLNZXsLQGHiqrJoFqcBm?=
 =?us-ascii?Q?3XjuE7RxjLJi1P5bTeWGL22fTXE5sLG0wOm7CsjrAefgNDnl6DZkTm2pa9bV?=
 =?us-ascii?Q?fJjcQwq3c6VE3Pm8NdSOP67rFfE3StxXS82LFsZzvnl8qWE658gNQ1Q05vUg?=
 =?us-ascii?Q?8c02hrPXp4HGBmc/k5hxZXY49DzICFQ+wWDlOGWnpFcqzmJ+W5P+Fq0glTHN?=
 =?us-ascii?Q?986kByZcL1QD+6yWyocDHZt4EWfS71oQiAd+/RPL/KQzqAErEMJ+OZFYREAX?=
 =?us-ascii?Q?/alOEs9cOVZPSLbiyP9tnvehOe69jmBQXKL9Lga18F9IaFK17rBSdAA+bNV+?=
 =?us-ascii?Q?rYYSpIUuMU+7SZgbVo16JQ07C/Qyb2xRebHrX97iY3uggGzY0VebH0nED7fr?=
 =?us-ascii?Q?XB0FTFuRC4J2RMAIiX4Vbj090Zm24/4K9vZyKNdEGidGZfbVMxOPzLqjOD0C?=
 =?us-ascii?Q?bzfgRfhBOHYQ6LHpJmxb22tJt4S4M39jdKsznJ/JS/IV7/0gyLntzl/U5a0+?=
 =?us-ascii?Q?AmiwSVB5Gq31+ABnWrY6AGW2AW7HlsLsG31TPN/ujUsveJaigtq6yBHMCzQ5?=
 =?us-ascii?Q?ESM5Fg3XEo1k8I6xpYv0Qw13pQhYjItfYVOuiQqF50UfsBMU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf859a1-327e-40ff-b689-08de6fda0e73
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:12:27.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65BMGR0V5PzpQ4eJQt7PsrjXGsEHc59NyXW68jvyJrmC2p5qX9zJ8vpwdHd3AS1MbGtVFw45YQpxPFtF9+mKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192

On Thu, Feb 19, 2026 at 10:35:55AM +0100, Niklas Cassel wrote:
> On Wed, Feb 18, 2026 at 11:00:17AM -0500, Frank Li wrote:
> > > Thus, we need to tell pci_endpoint_test that these reserved BARs (which are
> > > not disabled) has to be skipped, because if we perfrom READ/WRITE tests
> > > against these BARs, bad things will happen. E.g. if you write to a BAR that
> > > exposes iATU registers, you will clear/overwrite the current inbound addresss
> > > translation configured by the endpoint.
> >
> > I see. it actually means skip bar test. is CAP_SKIP_BAR<n>_TEST better?
>
> Yes, for pci-epf-test, a reserved BAR should be skipped, but not only for
> the BAR<n>_TEST cases, it should also ignore the BAR in the consecutive
> BAR test.
>
> Everywhere in drivers/pci/endpoint, a reserved BAR is a BAR with fixed
> MMIO registers (to e.g. eDMA registers, MSI-X table, iATU registers).
>
> E.g. the code for the consecutive BAR test in
> drivers/misc/pci_endpoint_test.c is:
>
> @@ -403,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>
>  	/* Write all BARs in order (without reading). */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> -		if (test->bar[bar])
> +		if (test->bar[bar] && !bar_is_reserved(test, bar))
>  			pci_endpoint_test_bars_write_bar(test, bar);
>
>  	/*
>
>
> It seems quite clear that pci-epf-test should skip a reserved BAR.
>
> I see your point, but I'm leaning towards that that it is better if we use
> the same terminology everywhere.
> I'm worried that introducing another terminology (SKIP BAR), might lead to
> more confusion than clarity (we already have RESERVED BARs and DISABLED BARs
> as enum values in pci_epc_bar_type).
>
>
> So, while SKIP BAR might be slightly more descriptive for pci-epf-test,
> I worry that that using a third term, will cause more harm than good.

Okay, RESERVED and DISABLED is epf/epc concept to inidcate hardware cap.

pci_endpoint_test is just one usage, skip test RESERVED bar. I am fine
using RESERVED here.

Frank

>
>
> Kind regards,
> Niklas
