Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795161738;
	b=XR4FFVKI2hD+vpauZlTzsoZGEd0WRjP4mZ6lsVPa0Lxu24+Br2G9ug21hkLg0pI5RzKY
	 YOZYV2OO7HvuM2Qq1oSG5t/XIeTpJsGTqTlrFHb4ikGtkglPBjePc0O3+UiYIOzLagZs4
	 8tsrLh85nY4IChY9KnxnwbBSZ6nw9X6r73lkO7oGGdfbexQ3rtaEFTU6mCiPWF1XGsKob
	 3nAool5FAx0mlc8C7364gwUxP40wMpUYhdozqKCbQ0f8MK4lavOavXfwcvFzyOIuT/eNS
	 VIElGE6iGi0lmfnxL/wPf0VRC84k7CYNco83zK1zO/rQRygu67L+uaIPxQA72bRi9TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161738;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OiWdKUgaIIc8OXLK26APZiwDx1El3p9eGZKfS9GQAh8=;
	b=CmbNqPW2nnAEsrMxS5D6nfaRIadT8k7lg4lhHK1/ea6IC/UJkL6G8OZ5SKdU7p4XDWW3
	 Bl0coeaPU+E5MsncQDbk9lEIY9Dlz7fZIOMAjskOjFxHwAvYuWFTTJWNKbx49yFXobvYx
	 1kqG9E2ZnTCf5je40+BPUplv6g61aO3KgUkf3Dqgnt9BXL/kn09MIN+Zv1/Cmtk7mgErA
	 DY3DPagJyR2vZwoaL+0seGNGHsIrElbYN6tU3mXjdoLA/C/5fETZT8C8Wai9f2FnzKHgV
	 8xIN78KVqfhPFEE0IFPkfahkRjyLYFxhEMfkYP0GYFfo7Hgzv2m4Kup4P+dssM+kIeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=RMUUFTJq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CC606A320;
	Fri, 20 Nov 2026 08:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=RMUUFTJq
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fqHj683496;
	Fri, 20 Nov 2026 08:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=OiWdKUgaI
	Ic8OXLK26APZiwDx1El3p9eGZKfS9GQAh8=; b=RMUUFTJq88eS321MOnzJBycQp
	np2UewGkj2rIcfggPxYo+INtUN0S1rzmUJqV0pD6W/ShdIMdvV3ejEmtx0wiO3xO
	olaXuUzfb1TYJRqBnX7YjGaQztuM/RJt8BRnHlaP26zgxL01ScGH3QnRC/kmNem8
	FGptPA4sPEVqGo7b0ZBYDgthbA0lQ2AHcVK9JNnshox8BM/dNeCvxgNSbj3P84iX
	7XEOiBMf0nEAVZq/eaEMqbRjzLHaTZA2b2Z3TlkEp2JqDS/FOXjYb6PXGoTOJYI+
	wvoqhrJn0DjybZAway7h8RBhnTVqczEJUNFqsVGxdJyWIi+AIeiRkrqC6UiuA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022105.outbound.protection.outlook.com [52.101.48.105])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8c80-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:01:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctfhpd1Nic7NXx8DeRv82B+6XQAUMqiuMfm86R2g4luHt9/zlmR038fWebJrOPnstgisLPUOl51jXAV11lBdTROCjQ6UcQB+IHtP1sI8InobHCrTwtHZ+CBLaq29NXfIXiBLmm3E8jpSS2wgrH/N1VFGf8UmYyQrcfWPE9a9L5Kpyveyi1NIQfGRAYa1XrSysD+dl59JcIyYfq1k9JKsPjRzkCcGeWdH6jqcR6fkBMXV+mNlPId57cpT50OOY4QyaQ7VNqjrK68PTPx1sM0uiLm9Kih1oWSEi8vYZ7eTpwtxnoY+jrdsFFQ8xCh1AnlpR5jYdfaXkFJdbRB/sIqZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiWdKUgaIIc8OXLK26APZiwDx1El3p9eGZKfS9GQAh8=;
 b=dqXSLuytQ8jDsCOhGBc+RWHPVkXY7gXWLKLSczB8xGASVy1yDSdEV27TEXOJHKN83QImvoeo115qFnZF6FMKHYY1G4tm4NwPug4MuQ6u9WZjeR5x9BIFVexlDOHa4w0VsyZ6Mn3YMo0/tHQMQ54vcCdoHxaED6PCPoAKXy5DJ9i+HA0xjvvhQES1egbb867lgCeiHCeQHXKpK7pvtU0CB9VBdMR36YV0GBrENjTgXQXDiQPKTF7GiXmN6cuI2FLV279o08iXbrFt7RmnKoDyXj46nE9E2CMvpiKsqSge0cF33SBzaFzHpdcvtWgIBW1RbG2N+HovCRjlF5lQ13bmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:01:56 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 08:01:56 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pierre=20Cr=C3=A9gut?= <pierre.cregut@orange.com>,
        Alex Williamson <alex@shazbot.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH] PCI/IOV: Don't make sriov_numvfs reads wait while VFs are enabled
Date: Fri, 20 Nov 2026 10:01:43 +0200
Message-ID: <20261120080143.56701-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0053.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::36) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: d48f7282-fcf1-4cc0-7d13-08df46dc8bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009221227099003|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	U9KzBXaNzHY0Cg2E7JhQmBHbHHo3Rkt8lA5jZMQrvMUyXll+WUc8DDExWxjNrgmrBLZ+FFih9WGbitFUFcqzfSWIW0HqTcK0io+TdehxImA7EeNFLJxS9jfY6KYGM2qKRQUSTfSgag6iPctnF6iFoUwRW9DbT235BaIomXD+eC0pYwLVY8PyzVsF+zX97LfiDX8glzQOhoO5qnUBS+InzFzGBY6P1DE0GFW+GVr/Oxrek/tGciQwxCjtCQSY44GJKKSHOIJqVdZ4ayHi9I2sUs4Hor6V41kLgLB6kqGJA0BRtu1OA2W0fahvHfRRUrlpN/yxlmcxR6Zc8AFxXPVl48W8y3GS4JXz/l4qGrrcp6LiHS9qIAZkSAQFx1JRLNLbyWtl8AyrGxgClXKUua4mNdldZqPmJMTne8RLwhHEgxPxRktcAz8EsRRknl4dFYadal8/2p7fMrLjJfdRpS2ZXUF2HnpB4N2TTJ0aKeXnNNq1F5SSJ8jZLAy6aRp8ZnjP7q4bZcRj14iUjKy5hmNM2D0qKlWOr56boxo0AjpC6MbULEYcFi7miTuDBJWzgvErXo3+bMuWFhE/3YWPxKIA1xYoNbdd/V7ACE4TzUnyH+OQV4VH+tbYrpZjXvqadvirgb5cYQPwoZ6RrS5eYNsTZ4xqUdY3xZXjQB8z7Wfmy1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lgs7Nc0y62fXbBabU0FrKxmlUc60EsfmtYsu8kICALiM3DjSjkQNVdidlQvc?=
 =?us-ascii?Q?iE8ktpnhSYADwHTcsgG02GAgYnlgqorZHQej8cye+UJmJfqJ/YNuWKC30xXA?=
 =?us-ascii?Q?Psh9gdD+ysMtfXYOFDaQe/sY5WvehP7GSLMTBSy9jBa7A5feZRui/aNz5MDW?=
 =?us-ascii?Q?Uy2WjsczsF2QC2z7l48RARrouE2hf2eDpJXbQXiF78wo7KgrXAwh2h0DRMFi?=
 =?us-ascii?Q?Khzpfn2y0GHNgkn7MqJhfKp1q2fVXYEybJ/zLMtfmNJ/IuI7hlVs206UKC97?=
 =?us-ascii?Q?tPd5fydRy2B/hphOinp8qXqCwg3rj400P/i/8PbXrjgMrgjimeRRNS23pJG6?=
 =?us-ascii?Q?su3sPnTOcP6xloYVnxZCbYTcAJA4GvXxgyNuSEFqi4o5PGON5CzjSSoL1AU/?=
 =?us-ascii?Q?GeQ1xMIvOmtH4IxDRjfQCklG9RgGgfXIdq5w3eh7pXokLEbh14dkm6caj9DL?=
 =?us-ascii?Q?gXUMNncdCVHUIsR/Qmd8rmDSSONR0+6va+JVd8iiV6ii0rrHK3vj1x4zf3U8?=
 =?us-ascii?Q?6sd/IQNkfu7IRiVSjc5zvxpEaEhdpEPnoHdHrvGLlxaaP/7Z/e36f3S9slDN?=
 =?us-ascii?Q?+sFMfKFqWvHhGNlAG4lCrvnMEeWpHYTVY8B7UgocaL089PQEbLe1Opwzsm8Z?=
 =?us-ascii?Q?c0c7xYktKGyRPv9L7CcdB8ppuO4agJTIrkiq1T3ZEPO/FMXKoY7BcPAmG4uI?=
 =?us-ascii?Q?TxFMJblmg0i6iuyYuz9AKsAke35J+bkNZGdvoeCvG9J2vtGln3Hw2LNRZsP8?=
 =?us-ascii?Q?Ytw42LRnmmzLopI+4rfa/AQ76+DEsRAAOUOern02YL8QzU3t8LBnMPya/q2K?=
 =?us-ascii?Q?xeEJpgpOkjWpztcH1U9ScQhbMYQdiCZZtBJKXF1MXgLwGBvR6wQ36xpCwF63?=
 =?us-ascii?Q?lPUzuQDgMZiA8gIvi8nap8UHWJyY68RGzV6IGzChgT6QA82aoN2s8DKTzpZK?=
 =?us-ascii?Q?Y7Pkw1Qo5kwgH6Y6oCLNMOYZvo/gKtXigQf4ONgoOzU0rGG2PeBIhi+RtKEJ?=
 =?us-ascii?Q?xRVbm0AsB/pvHBoQ2E9Xy6vPhyW6maWRVUfjsqt6DfvrURGKSIk/sRWjSk4u?=
 =?us-ascii?Q?qEwszFUV7TJQsWgAJLWlWJWFEYWrN0CUt3t4/UFZzSVxlgb2pHniNrqehXKb?=
 =?us-ascii?Q?yFBJGIxaV+Zc2sFF2hq+94etk2YsPD+yZaLtod6q6Vo59nioVuCrgjWid5Tm?=
 =?us-ascii?Q?RCaQrdXWpVf66GHTtuYSCW3yRn97ZSfUkofmcAHhjk5d3FJHUmaN4J8+3RSr?=
 =?us-ascii?Q?JBkciv02kwo0ARky0YZkbUayT98fvC1jyk8Yy/qEHYnqD2782e127phLJbPq?=
 =?us-ascii?Q?hXYypVMQel66/a/Qh05+M057uVeb2mZOJ5mYb/l21qiCWqIjLn4djyAnS54x?=
 =?us-ascii?Q?COoTMXCFj5l+5rKj0vdvwChDEKfXjRuLBEXiXMUTwHIywVoMIOnl8XujT5iS?=
 =?us-ascii?Q?lrWoER5sJxOcOzrsfRhURgYkZU0YZ2bUSxy3qeXevudZt5gynbAemzeBj7YZ?=
 =?us-ascii?Q?i3nJBtckLlDVNhaWdNJa88qB4EaLZezAiJyvLZVHYe2oGAAw0eShtahgyEd3?=
 =?us-ascii?Q?CSr/obuJR3y7qkxIhD6rglPcxmsoQddpRd4KzXfs7er6mfXn6XlBB0VG1SKv?=
 =?us-ascii?Q?nrP1+TqHw1euOWOA9TA+J04b6ZdZ47jO8ymGZCuBbx0v69Nwcr+L02y83Pfh?=
 =?us-ascii?Q?BJe8Wj+tRblgxPGqQTnJT/nZ1vg87qsHsrD/QpvYu9euuQnWN7yKpjCFj9yu?=
 =?us-ascii?Q?eX63dLlKhqaB4kJfXCND0TBjLPum5vTTk4MZLiZq818FcVq+yztYe4epsUks?=
X-MS-Exchange-AntiSpam-MessageData-1: T15//XNtb5mW4hdr5DlEnQgmlrsS0vLmsLk=
X-Exchange-RoutingPolicyChecked:
	MzWJ2+C5v2WhS7XVZuNkqkk5Yl5Ot5f2nuU8cQIC0kV5D7hz3jajlvBobVQCaLU6u2AH+J+t3qrKPKYcejAIPUzcYBcq/1JG8dQa3uG14R5XRMOw5Q1Aiu3vrGkSfCBIsvg+5dU2e5M8mRDTjYM921QnX+Yj2K91Q8OaQUfaVI1bSq5nZRSMvguaNafOWasm/frIc4Baedo/lcKLZdw5OW5HRGcQE1s133BWHymuKHpgK00a2vUPH4RwnRwwexeXVM2uMfAo29WEIpFH6HIV4gXYuUK8kDHLoOP80qfjjxsS1prap3oUd+dt6MNu0HNhEDyeBgPdsy2iOsbBLXXwXA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48f7282-fcf1-4cc0-7d13-08df46dc8bdd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:01:56.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B4Gk8rVsVu64LOAXub4S37LD0d35AGydentzffAILJqPzYOv32sCsWLEUew171puWl+QnZZHnJ85JVZYk7PJAtEs8BAA1cTMZ7dIxRFyLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-Proofpoint-GUID: KgBJGMpJh--zL4WLS5AMPLklrah_ckZr
X-Proofpoint-ORIG-GUID: KgBJGMpJh--zL4WLS5AMPLklrah_ckZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfXwaRtgQJYjbbD
 wzEY0cdXB/36kZ4xnvVNJypCDh+ccz/mxrlDev1u3qswg3GTSO+AhPMxa0uJ7PosdUNvD+e97a7
 UGbrD7Ya2pLVm8nADfUplg7BNGt+ObO6wDQF15wMSkZoaHTk+gTrRI5U9Pa8otYetNgdyhp5UM/
 oxC7gzo9vixCVjVwIFX5CmPwEkSO2mrj3HUvTtPcpWr01+vwkwYeBoIXtMUiJq9uMaTa0gjLtgG
 7VmC0YLiwGjyUwKhpL71o5ebvdyPT3uEQySMGSp5AJ49SPABlgDzoPO4mJVe+Ipdz8H9eJ+iK+N
 pOtvKmsPjLX76E6SqehX4xOMaXkhlULly+u8Bx1e4ch0Z+FS2Ws4EtRmk52W8Fz6tVdqtI3lx6b
 +IBJLv4PLqYmpYBjsninbf/gbvyLJOxql9zi4ndtj2iaecdBo9N/005+33lkBDxEgMtlPMt/q6n
 udF2IX5Gib6lfkbnGIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX9ZmFVn0bDCTH
 kN2Bouogj4N/kvK+Bco34yvWvwEGUx1q96YnSKzJEmSwB5yxr/z1i+CLGf06lhCpMkunzGdQFiV
 F4j7rb/AWX3i5ZHwENaTWE1qDpXAMfcNmoL3DPxM5HogUVhtdykB
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afffe76 cx=c_pps
 a=mtSqpVOEitwwaRRTiGNoZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=nTNqVFG7ghiT4CK2tzEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200031

From: Ionut Nechita <ionut.nechita@windriver.com>

Since commit 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs
reads vs writes"), sriov_numvfs_show() takes the device lock so that a
read does not return a stale num_VFs while sriov_numvfs_store() is
enabling VFs and they are becoming visible. The store holds the device
lock for the whole SR-IOV change, and disabling SR-IOV can hold it for
a very long time: with vfio-pci, sriov_disable() waits for the VF
driver unbind, which waits for the userspace driver to release the VF.

  sriov_numvfs_store                       sriov_numvfs_show
    device_lock(PF)                          device_lock(PF)  <-- waits
    vfio_pci_core_sriov_configure
      sriov_disable
        pci_iov_remove_virtfn
          device_release_driver(VF)
            vfio_unregister_group_dev()      <-- waits for the vfio user

Until the user releases the VF, every read of sriov_numvfs on the PF
sleeps in D state. Inventory tools and agents that read sriov_numvfs
for all PCI devices hang with it. This was hit with an Intel FEC
accelerator on vfio-pci, where the SR-IOV FEC operator reconfigures the
PF while a DPDK application holds one of its VFs.

num_VFs is only set once the VFs have been added, and only cleared
once they have all been removed. A non-zero num_VFs therefore never
reports fewer VFs than exist, so it can be returned without the lock.
Only wait for the device lock when it is contended and num_VFs is 0,
which is the case the existing serialization is for: an enable in
progress. Use READ_ONCE()/WRITE_ONCE() for the lockless access.

While SR-IOV is being disabled, a reader now gets the old num_VFs
until sriov_disable() clears it, instead of waiting for 0. That is the
value it would have read just before the write started, and it is
still an upper bound of the VFs that exist.

The remaining wait, for an enable in progress or another holder of the
device lock while num_VFs is 0, can still be long. Make it
interruptible, so that a reader can at least be killed.

Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9185934a9..20d0d03e5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -420,10 +420,28 @@ static ssize_t sriov_numvfs_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	u16 num_vfs;
 
-	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
-	device_lock(&pdev->dev);
-	num_vfs = pdev->sriov->num_VFs;
-	device_unlock(&pdev->dev);
+	/*
+	 * Serialize vs sriov_numvfs_store() so readers see valid num_VFs
+	 * while VFs are being enabled.  num_VFs is only set once the VFs
+	 * have been added, and only cleared once they have all been
+	 * removed, so a non-zero value never reports fewer VFs than exist
+	 * and can be returned without waiting.  Disabling SR-IOV can hold
+	 * the device lock for a long time, e.g. while a VF driver unbind
+	 * waits for a vfio user to release the VF, and readers should not
+	 * sleep behind that.
+	 */
+	if (device_trylock(&pdev->dev)) {
+		num_vfs = pdev->sriov->num_VFs;
+		device_unlock(&pdev->dev);
+	} else {
+		num_vfs = READ_ONCE(pdev->sriov->num_VFs);
+		if (!num_vfs) {
+			if (device_lock_interruptible(&pdev->dev))
+				return -EINTR;
+			num_vfs = pdev->sriov->num_VFs;
+			device_unlock(&pdev->dev);
+		}
+	}
 
 	return sysfs_emit(buf, "%u\n", num_vfs);
 }
@@ -716,7 +734,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
+	WRITE_ONCE(iov->num_VFs, nr_virtfn);
 
 	return 0;
 
@@ -764,7 +782,7 @@ static void sriov_disable(struct pci_dev *dev)
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
-	iov->num_VFs = 0;
+	WRITE_ONCE(iov->num_VFs, 0);
 	pci_iov_set_numvfs(dev, 0);
 }
 
-- 
2.56.0

