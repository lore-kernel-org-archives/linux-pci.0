Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A4339843;
	Mon,  9 Feb 2026 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623899; cv=fail; b=MJ5IC6TrTGbK6UK3hTr6qTGY48FfREsr8VYkA8NLj9jqalsV20kY9I0qWFmzUFjNkwGkx4vnnd10nbFYZ3GYZhOS1LglGLsPmhMyppYeC5OxHcPV8piKSaZd+fMEzZ5YGO3ET/jl/gfTkXl5I0llydnoGyJHx3nHRZ6gLHMK+bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623899; c=relaxed/simple;
	bh=DTa3SDtmhtZQy/MIrd0GJVJXCcx5e2F0ly0LrrsUHwA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gYPgUSDjjPJxY3AerhNQogeTnuvY0786Pdi0o6txqgegb4EDcJvd5K/zNovF5Rb1/eayGmTWtnA/T0uA06I7f0FPY4lFNbrhsC/irfKZg04uG8k/CkhTGLSUctos+jCWTNp34AkQiix+LCRCl5fwlWMy0l1splL6hCS8sDpHQ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IpiMa47u; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IpiMa47u"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6197ZmlM1324158;
	Mon, 9 Feb 2026 07:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=AX7Hp4VBm
	94ylDSe5j22hwmdsT8pzzm4W7CSsy9VyPM=; b=IpiMa47uM7HupQruFziul3y1v
	DnhF+yvxojb5nndNDIwlQdh63zOKfw4JcsAcZVLEAs+UEWjqbeql1VkDX7tlQ5ZQ
	rNy8LWqSixI8cN5x9uUSXaLKrKjAEN8C20YqC2Y3h91/SoVZJan3aIZQf5MwyYEO
	80cxnHY3TARXXmBaU97aDgTqTVOBtcmoIZoppWEtUzBphKxuMz7J2lafai3Y3exu
	yMJi6H3GkSwB1mjOID9Pqhjksu+ztveWoGuzezRR6QZKJn6Bx+jvQ6vdcWJUHM1R
	9ia/ocNX+P8E/TqVslRDNoQ5L/aZge49UbF3bzUkGyQV1JQiFprrpPirnCYlA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5vc59jh1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 07:58:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtXYrF90HDFqxphOw0zPS1ZDOHMmqQJjYo/ZzicQHDmj0qAUaoTfOqosCrefEflxKCZHvKYnMYBOyMSUv3Imue6TBtyJVfmQlMYIsixmaKPj3vSsphvytNgl0ocHe+4nSyYTJjkfYJNcAOLA6LHQBbFbNgM6dwFoH5jZN6xkjtFE2EFKlDUmgDe5vt3RcEap/hHDsagdbWIxvphoz5rKYIJ2zyGHxQqzqRwHjEo0Yv19OPhHNA0GZIM9TGRdnlUIeNymMeAziYbgG4TrC2BrKOlkQmgz5IvcS+/x6guClmIWe0O0wz3cNreYFxynZHDmJmQ1vyIYgRGgRFFhzZcuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX7Hp4VBm94ylDSe5j22hwmdsT8pzzm4W7CSsy9VyPM=;
 b=D5fUiteYGI6Fy/2VutgXKetoWWjFEzSqcm1EqJ6cpfpUj9lBr7VL1DidueDTrjeWm1+HDBqbBj3Sja7oPL6tWNnqi7eNNaVUPf8OJzN+o5sh6zALdsUNzO5mB3qS5TfPNvkgA35iyuUM5OpX1ZOkrqj85OzFRrgAcoB1ZtdzAFdRTpdKCtSN1yOCbCgqdfw7ZaMlIu7IYt9s/OdgzcfR66q6/XPvomCp+ku/wZG3Qnu+fsY/20YtelP4jXn2HdcLS5SB/PabyBClNBrelc40b169GgJqO3wIPOdljkbKaNqN1vTS19zgn0ylISVouEQerDNbG34eOq5An6fNRoy8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:58:05 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 07:58:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH] PCI/IOV: Fix recursive locking deadlock on pci_rescan_remove_lock
Date: Mon,  9 Feb 2026 09:57:07 +0200
Message-ID: <20260209075706.16367-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:802:2::43) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|MW4PR11MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e674b0-ab46-4fb6-74b4-08de67b0f490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tfqr2LV2tQBJ6BOPy5vgv9ij8XyJy6zMJgZIVkXVy7GqfCqD5GZ6rO+Ii+Zz?=
 =?us-ascii?Q?ecTWfCTeWrDeS58xYwRbh40LhOogoLlakOSsVgcYuQqHa2EGL8ksvd8jR7yI?=
 =?us-ascii?Q?BN7Ia1lP/++fNmIFkXDRb01vBVHLliENmSzmO+bYmh28eb4iz5xdvCFgcs74?=
 =?us-ascii?Q?zRlZTnXjdrCJ460XfcS61MpeXZ+qvoG6Y0VFav1oF7USuAnaIPc5HgR5pEZK?=
 =?us-ascii?Q?fUKLQ9kr2Q7P7JqRwo/cr56rWJcl/lrxyIhgDnHGlSgwwcyiTw3dfDbSYFHx?=
 =?us-ascii?Q?AEPMbWcj01O8Xu93panE69L70pojPBKMvLLXWdRYg16IxP0ImWN6+PDWH5oP?=
 =?us-ascii?Q?zDMi7zoSrqsQuYXMKo4Qtl7k9duIWfP5NaI5pJGimwF35T+QRero5lqJglfF?=
 =?us-ascii?Q?II4vEzFc7iFFVwci5LdaRNXr2ihi+1vjzy5B4vqikmVGnrCKyfEomUOMFRJa?=
 =?us-ascii?Q?Zd5z/6d3akasEtnrNkxkML6qLyucSDINw1/NXoNOstEfJf0foDUOp79zrwbX?=
 =?us-ascii?Q?kOZXGTA1bRPtknCRVWsvRu3ojQ++wxeOlX6A3tN1zUr3PnD0rMerLG6NssJn?=
 =?us-ascii?Q?TbnA0uJoi8ypbXOdw4kWka6XLqjRllorzdE75PpGx3+k1znV0LNn2jQyiGc0?=
 =?us-ascii?Q?BcvuJADN2A4hqpSVFwFkr1XVIiH8i2EE5qxfmhnhFF4fMjPrrGOhkF7Ty0yP?=
 =?us-ascii?Q?0nN8pdfozFbzDz9wiI1vZ7xjdVjT10LXf9PulinJMaprG2quG0cyEUegysmu?=
 =?us-ascii?Q?CXY6XJ5nwO80nBNKzX+h+zD2bZgD8fZRkW4ZF9gvHYqU+k/aP0gY2zvUEzZt?=
 =?us-ascii?Q?6xaJLZVUBoO+1vn44oyZgGx/CswVu9Ozz8HZjuvqQzmMwg0cRzJkC43yhrMn?=
 =?us-ascii?Q?O9Rlbc7qt6ijOM0WAvT2LVJkJi7lCXo61Sj8jLYR1Mxwex6xXnBcXikfpBPw?=
 =?us-ascii?Q?5mcDRdfPsIAAXIZs46v9w7jcZouKUgfMLlS6+gifGZ6r3zu/ZbNrUnmvexOZ?=
 =?us-ascii?Q?pB3MiTHjYNebTTcG33k3gzjhWGm1yl4Gq8xBavGutEaUkPP03EW+ek3jG/Wl?=
 =?us-ascii?Q?/X2DtajQmL3T1FCd+CLlERllTtcIr7HYwDQsU8psjnXTk6qVsIND6rABhSh0?=
 =?us-ascii?Q?SvWJ6uSzFfsqWMtZO1FUsP6Pwl5KyjceJwp330w5IulLtLiYpIotlabhtMFt?=
 =?us-ascii?Q?ULOkVKr/2CYgI+/WAMzpliEYgEtSGaZ+9PDnhYB3SZ5oX0K/4ZZ9oy7xr/j4?=
 =?us-ascii?Q?x3k66KIcjojf2OPBfF09GvHeOzqjzTuqamMoOM2rctg+XszfcMkXD+KTkfQe?=
 =?us-ascii?Q?l7znwZgSrUDw31Wu0FxOQLr0kI/w9CnSUUZOiLG5CJ0jC8IRj9GGk3ocLMtK?=
 =?us-ascii?Q?hseygbeL5h2+40JXZluQvgdb2+vuTcFhsuu8seUrszNPIhBRvqJlWW03UBdE?=
 =?us-ascii?Q?iGh2Q9vJyUOfoPx2c+advmgZi1dcm+cKiC1HhI/7phh0+WnrskAGATICKUCv?=
 =?us-ascii?Q?OFLW/7rHZ0t8cKbvY/JVLuPZN2C7wg5G5e3XTftq3ABA8D27FBXwNxG/CsD/?=
 =?us-ascii?Q?ph0cmpuPzRDQdPpI9Gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/e6a7hW60+Zb0iLhGsbvmOfnxlO38YeTk17fXg/a86giYfqVbdvDDuRPoKc?=
 =?us-ascii?Q?XefJiHuXVhpOb7k0CFySd8tlT5GVUOQ2PsDsSvhCUHrf2R6+D7gdJTnJOYDK?=
 =?us-ascii?Q?pZMz74vrxnKoPQRrpUDn7jGEH+AS58cJkCxYwBHhhccwJ2sD0oFAo3ClU0LO?=
 =?us-ascii?Q?5imtyNCJmjcOZVnn59kdNjwd88eeUD8N1AvfnLuVx/9a79FEjrnHVjy6uVWh?=
 =?us-ascii?Q?PxMWxp2RHh70UDcuXaL19vt1Gd4vQtEOPAL69VYm/RLcroACi+FIvT6QxNS3?=
 =?us-ascii?Q?TbRVkeY/e+5dFXdCm+Ro/pz2vfvbF5+1z4F/lMGfiadmSDvD1JrxwbVUe6sA?=
 =?us-ascii?Q?shHkh+Qj6pKH/34YCbZ2+MsQzdaqSziRUclL/heXNinW7cKQKePi2ngZjpuP?=
 =?us-ascii?Q?EsHCKqQe8jOlJANemHJVA8s0lTMras1Mit1hwKE2dVicQKG5kiTtj7n7/S3J?=
 =?us-ascii?Q?Xuo89LHHju+z+CH8EYeUUS9XQCt9fPkYayQaiGl/+AEWJyhlxXxMLcB+IDXQ?=
 =?us-ascii?Q?IM6ge4q8rvfZM6Zq5zJD8qVrelY6XNO6TOr3AarGTRbEwYBsgDX55CemT7Tc?=
 =?us-ascii?Q?mG4VRfJwAHJwJ9DpuHHl6LIJ/7qQUDeG3/QgM877qt2zIlw4Nxr9Pg3UERT3?=
 =?us-ascii?Q?7O2Ra824k0JxaLv46AEmoz0HhB/vIw9zopnZIAq08KnaqT17T20gJ7mPm7Uq?=
 =?us-ascii?Q?IQdu8ohwjI/oWw1BBsJCTMWm9mbmKhO+B4vd5PbKv2OAbPcOJz+QrCTGPZ4i?=
 =?us-ascii?Q?ADZHHFFweI607CJF3Ev1dB3brGcZru22bFafctIfxEWwb2/KZe+phFH95KwJ?=
 =?us-ascii?Q?9ViwtASENhtM4w8btT/SdaTCnUTIRdMe0BdwWpNUFdYieppVc3WUWA6DKVez?=
 =?us-ascii?Q?VSEttkNls1qLkpHeU5dMTPzp9gWTEU80TBxQtjxpRxDqSUx65864twI+99KP?=
 =?us-ascii?Q?XihJNS3pTDF/OHWRsPtCbsMARbt1VsIB2fbAjMpkqT6BzUoxiD9906RVIJaT?=
 =?us-ascii?Q?mJSF4+uJsccWkE7MPT3I0obPw0GWsdktegabFSdYqazp8Zro8g3/rpyoivDW?=
 =?us-ascii?Q?uQr1Q9Krny2Z68VwXM+KkzlU4XMw7ejQP8qYu6fhQ0tFVPwyhFA+1qbsddTn?=
 =?us-ascii?Q?qgnq9IYJruGIs4VKPbsvr4SOi1rtgRLbZW/RZkWJMv9ktFsL5FWXWxU3wjzX?=
 =?us-ascii?Q?NCt9O2vAO0FyYJXiWK+5cE8RB01q0XhlsWKsXtknBU79gmmMqnZFK/iuvwj0?=
 =?us-ascii?Q?jdEGNvQPfhsJWb2WMIopfQCLCxgW8MjdkbbkRTcrL/OOq/3M9eHJG0eKjqKq?=
 =?us-ascii?Q?7o9mLxi2m8R9/IDC/w8TWdt24+rzwqDNy1NEyANOW7IcaUaDcdHf/dNBM08o?=
 =?us-ascii?Q?NMbiXMrLsT7Fw/vit9YkMnroTng3IlQzZT9QQ0sJlFVIEc+weN5fMu7tzUra?=
 =?us-ascii?Q?Wq2p4Mr0SJxx0r17NDRsuh9++s4n3FGcWFM9pztZ1RI4hPeMRbWsnEalmI5h?=
 =?us-ascii?Q?7/d7eWvooJnUL1PN6QzVnKEC5AlCEZm760ng41IOQ/zEqJfssrZVkQ+81C0W?=
 =?us-ascii?Q?HPmdjTVHgwxWO0hQSCQc9qc14ZkMZ7lZEKWGWVKMyjqTAukCnh0LGMqE2tb/?=
 =?us-ascii?Q?MzsfwDcCbo/9dPmeX3UdTlq/vNymlagFU7kQr7jAqLH4fRL+Za6n0IkxZSfe?=
 =?us-ascii?Q?Jmmk2BnI2KlJnLhCrKzRqJQAeKg0bnSD6KBFMLrviB+2As4d2GkkfPGMuzRs?=
 =?us-ascii?Q?8E87FR/pmW8ZuInPbODQznOfsmEEbA3yJytdXNbwnkwOX3OZ2TmLzF2n58EL?=
X-MS-Exchange-AntiSpam-MessageData-1: w0EtwL0zmGXAxAucUh7fMPZhIZDHyOI+oBE=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e674b0-ab46-4fb6-74b4-08de67b0f490
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:58:04.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma2RAfwMfv1scpkK+jhxkWI0CBq6EPdTbsblNOFXtv17OD/kn8Uugiq+TLTlBeifwovodUSs0xbe5UtPeLjn7gPJv//dvK8p76ktsyEfz7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-Authority-Analysis: v=2.4 cv=dPyrWeZb c=1 sm=1 tr=0 ts=6989938f cx=c_pps
 a=BKMVb8u7xwlFrvPG8etDZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=6pPjT_HeCsJMgyK8P9cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA2NCBTYWx0ZWRfXykRmJARuleVA
 pb6+tzz69dMHcPtWaLRJjqoKXYQ6ROSzm25ZV1k655bxR2O7991CDC1CF01p8N8RlAwg69wkZIV
 kWQGrnogtWmgxizSqR6WuCck+htm9w1u/76WBmeU4g0kYGvE03pbjuaFr5wO2b81ALw0s+hsvDY
 vWq0e03sjeRMcG98D/6zzzytgxL77mLxjMh8pb6ZXGbL+y6kCw4OBR4eqBf4v4GVxPEaN0J31FN
 kp++kDfvUxxYlOpgKeZA6MVrUJxCPr7UW0C/rC7NjeN5z/4uJhL9PK02BlXxQ1XAjQGyDZAlTln
 JZFCZ3j9qNuNta29rWEX6fAu5RlsvNN4tzpqfo8jt0oPMoLb9FUphEseM8yJGqwnW14Q3Jgns/9
 cP7maFQA1GxrSgAM7G6UBmhzSpvLqWh5bmhxMrygWCIKGG84FB5SBPQji7eRXqCPje9mNllWAUR
 kNjtBrxc3FkdFu7cXqA==
X-Proofpoint-GUID: IOZZNOGCNlAugsq6GvDfZN6WaU9moG8X
X-Proofpoint-ORIG-GUID: IOZZNOGCNlAugsq6GvDfZN6WaU9moG8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090064

From: Ionut Nechita <ionut.nechita@windriver.com>

When a PCI device is hot-removed via sysfs (e.g., echo 1 > /sys/.../remove),
pci_stop_and_remove_bus_device_locked() acquires pci_rescan_remove_lock and
then recursively walks the bus hierarchy calling driver .remove() callbacks.

If the removed device is a PF with SR-IOV enabled (e.g., i40e, ice), the
driver's .remove() calls pci_disable_sriov() -> sriov_disable() ->
sriov_del_vfs() which also tries to acquire pci_rescan_remove_lock.
Since this is a non-recursive mutex and the same thread already holds it,
this results in a deadlock.

On PREEMPT_RT kernels, where mutexes are backed by rtmutex with deadlock
detection, this immediately triggers:

  WARNING: CPU: 15 PID: 11730 at kernel/locking/rtmutex.c:1663
  Call Trace:
   mutex_lock+0x47/0x60
   sriov_disable+0x2a/0x100
   i40e_free_vfs+0x415/0x470 [i40e]
   i40e_remove+0x38d/0x3e0 [i40e]
   pci_device_remove+0x3b/0xb0
   device_release_driver_internal+0x193/0x200
   pci_stop_bus_device+0x81/0xb0
   pci_stop_and_remove_bus_device_locked+0x16/0x30
   remove_store+0x79/0x90

On non-RT kernels the same recursive acquisition silently hangs the calling
process, eventually causing netdev watchdog TX timeout splats.

This affects all drivers that call pci_disable_sriov() from their .remove()
callback (i40e, ice, and others).

Fix this by tracking the owner of pci_rescan_remove_lock and skipping the
redundant acquisition in sriov_del_vfs() when the current thread already
holds it.  The VF removal is still serialized correctly because the caller
already holds the lock.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/iov.c   | 23 +++++++++++++++++++++--
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 15 +++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 00784a60ba80b..3a21cf9aaa747 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -763,12 +763,31 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 static void sriov_del_vfs(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
+	bool do_unlock = false;
 	int i;
 
-	pci_lock_rescan_remove();
+	/*
+	 * If the current thread already holds pci_rescan_remove_lock (e.g.,
+	 * when pci_disable_sriov() is called from a driver's .remove() that
+	 * was invoked by pci_stop_and_remove_bus_device_locked()), skip
+	 * taking the lock to avoid a deadlock.  The lock is non-recursive
+	 * and on PREEMPT_RT, where mutexes are rtmutexes, the deadlock is
+	 * detected immediately and produces an alarming WARNING splat.  On
+	 * non-RT kernels the same recursive acquisition silently hangs.
+	 *
+	 * The VF removal below is still serialized correctly because the
+	 * caller already holds the lock.
+	 */
+	if (!pci_rescan_remove_locked()) {
+		pci_lock_rescan_remove();
+		do_unlock = true;
+	}
+
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
-	pci_unlock_rescan_remove();
+
+	if (do_unlock)
+		pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa0013..c1055d333e08a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -92,6 +92,7 @@ extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
 extern struct mutex pci_rescan_remove_lock;
+bool pci_rescan_remove_locked(void);
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..f058ffb51519c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3540,19 +3540,34 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;
 
 void pci_lock_rescan_remove(void)
 {
 	mutex_lock(&pci_rescan_remove_lock);
+	WRITE_ONCE(pci_rescan_remove_owner, current);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
+	WRITE_ONCE(pci_rescan_remove_owner, NULL);
 	mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+/**
+ * pci_rescan_remove_locked - check if current thread holds the lock
+ *
+ * Returns true if the current thread already holds pci_rescan_remove_lock.
+ * This is used by PCI core functions that may be called both with and
+ * without the lock held, to avoid recursive locking deadlocks.
+ */
+bool pci_rescan_remove_locked(void)
+{
+	return READ_ONCE(pci_rescan_remove_owner) == current;
+}
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
-- 
2.52.0

