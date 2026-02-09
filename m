Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89A308F34;
	Mon,  9 Feb 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625425; cv=fail; b=DCxvjPnB2hX9mEYBP1rCJTOpFM6IVptH1HcYWRqLar3lpTq3uqjY8Z+EwfNBrzXkUZBvI4jPQf5C0LYcL3bTUR8bX1PrnOJT3jonQth3uo5W5aOzahMNBdQpIQsHAvyPkiwA6DbZrsBORLWrO0TOc9ptH7f/xgXQmnrlgpWneqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625425; c=relaxed/simple;
	bh=XVz/aqsbIiHMrjcOpI6DdSc7TgW2p7xevJp+3Pzo1dA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TvZMLVmzqceoEwS5BReDybnqYQ9G4l3Hfl6BtBpjWPdCKjSg+YsDQmFaPbphUbcai9YASWqDNaO2UhEZCE7gAOOCPC9qWEZrz89800SZIYwxmP/Z6iOTRR3UgvV3sqGVzSjnfdBEFWwmihmcuot01YWq7chQ5zoLkuSPYMxLgUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RT2qZmQj; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RT2qZmQj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U24rh/2e7X8/PbUxA6aD+gNkX81D8b6FjRo62oK6QmLBHs43z433NwzGo/T9K63Y53BNQ5tWw8JjIP/BxP6xfJc+x1Uz2tM+jQ770hb1A3Mn0xTx1vF6cmF43nMxr0q5Tbk52LY3ESmpFTsHiNa9dvNK3P/pe+fPf/cydol0vwVi3DtSBJKXmKCstYx/9eOUgdlx2f5/D748x1G1yPoChW7kCI5OmKbQrSyE6mOo6X7fhEk9ynUzqWyA3hS9GvqcXfMlpXeFze/Qu1e6Z0eeJzHlGuETTgkJn+rypVYP4pdiS+oygPf6Z1L9cyjpFK8MRtkOzsZYpMNuF1shA7J5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq/JqyhfXByHfXL8GoO6LZWvY0sLyzjjq/Mzx7/HhY4=;
 b=DeyxmhWbenCpLGPZTAxO0LMJdDU1ZOkO9M6kp5ZCmG34VK1Ev839H4inSmqLgkhfAlpxjzafaHi3WUG3yY+L5wlxn1i7RJ6YfQjFfTddEkCbWSm8qe24ASFDDezq1ctLWfZ+emKoEt1aqbOwp7VthbgDtqoXnkL9Q/MwTzY4kw0fPZj5+9syahCrV6DYf8ldaW0pN95l7JW6J8/F/cHENSXZV8+0hFRDPf/ZN4yH32tXN8NgyqdXrBAz+6yN42Mx2VuneXd1ybKxH1p3wxYggmihSL0PzS96ZZEC0u4O+a0YvgkPkAUd74HisAOuWBGbT5GlSCaoLLHOKeXhjFLQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq/JqyhfXByHfXL8GoO6LZWvY0sLyzjjq/Mzx7/HhY4=;
 b=RT2qZmQjnBZydW1RmKmYprNVzEmJpIggolE0ZGM7v5thXGZmAu6MHRl29y48+wlOjplNq8Vv9wkCNkSL6N0xL9xOtbayqG3pyU0HjLBvir3XhPx74Xpc6cKkFcvnJM01eTlvA03DBivyjUOkRkmWn9wvHlL0B0R8X9UCk5lOxyFp0O5ph705G59Ih/5ZUoQ3o0/r7CIoUtyCqKVwauZ5Jkt98DuvaectX9suSbaSnQMeniKyQ0rqgggU17H8Hms5KJ96M/dqk/Q20Pax4wFFRPTjot5R16aDSrK8tRha8n3WBENl8cUCNXx6dKolFm9cspQht/ZA5TPOywLQAyq7Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA4PR04MB9661.eurprd04.prod.outlook.com
 (2603:10a6:102:273::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 08:23:41 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 08:23:40 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	will@kernel.org
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/11] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon,  9 Feb 2026 16:24:43 +0800
Message-Id: <20260209082454.2097628-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e30a8a-8470-40a4-058a-08de67b487f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEdDU3NVNXlXd1NmQWxUZ1JldGlUaXJBT1Q4Y01lVHBnVURveVZaQmdIWEsr?=
 =?utf-8?B?K291c0lPMVRDWUhCbnljZzZHVXFaZHVQNHZzdVBoK2NydUd6bnpRUGhWcmJq?=
 =?utf-8?B?WElpQm9EZkJ3QThCUHpmRWJoWnN4OENPbGNRNjZhemRTbTJuK092bGVrQlE4?=
 =?utf-8?B?TDdXeHgreDRqK2lYdFJnY3FCSnowdnpESkNlaDJvME1rNWI2SDcvWlpzcmFs?=
 =?utf-8?B?aGRHVjRlbGgwZzY3YXRTdzFoZjVvT2VvbFdrbTU5R3o5NUwxOEtHNVlBaGJ3?=
 =?utf-8?B?UEtqMnNTc1NDRmF3V3hBUDhYdTFNYjdZTTU1ajd2ZUhseEdhdWVpbG5GSVQ2?=
 =?utf-8?B?aDhGNGVYbldTQUhka2JwM0doc3JtQmZrYXdNdWxUU2JWUCs0cGN0Z1lESk52?=
 =?utf-8?B?eFNNZlJodnJONmJ6TlBudElrNkR3dnkrd3V6TUdlSWZDc2xUb29HZkVGTWhl?=
 =?utf-8?B?OHFEZWJZbVh6bG1RRUZ1SE02NUtNZzR6S3BnZFUybjdrU0ttdU9XclhuWkhJ?=
 =?utf-8?B?ZVl5YXdFcGw5M3JFbDRkd0l6dG93SFJKbStIeE0xc3hZNlZJNjJaOFowaFlF?=
 =?utf-8?B?aURWTE55bVJ1b3B3UnZ4OGxLZXV4QWxWYjFIc3JlTlA2aEhVOUs4dHBrNFJp?=
 =?utf-8?B?N0NRVFc4VndkU2lZUEZnRUJiMC9XOXdxU2lYRFFqM2FNRXgyeDN2NGJ0Sm56?=
 =?utf-8?B?QWkrbGNrcHFtWnZZUjg0V0h0YUNuSmFKYzZ5dTZhS0VadFFYUDhPbmgrWWRY?=
 =?utf-8?B?MXZ3Um83NFNTM05nUXk0RDJsS0FCT2t4MTV3NytTVDJad3BDQUs3N3VxVGlZ?=
 =?utf-8?B?VisyVkRtQ1IyWFpEamhydjkwWkx0OGRjSHhSRnhqVk1kazVlTzBpYS9SMnRT?=
 =?utf-8?B?SENEd1BBZG5BOXp1blcvd2RQYjNaWXZKZzNpYXJ5dysrT242a1E2MWozZVBF?=
 =?utf-8?B?azk0YlU5VXN4a3R1Nnk4bzZiUDJmdnlzaSsvRU5NTWZkQjRPWGFqM3oyVkd0?=
 =?utf-8?B?c0tVTnVRTnVXaUtuaDJPRERTbFdkSThRN1Jpc1JkMSs1aittZEROY21naVlG?=
 =?utf-8?B?a1RKT0U1U3FaRjdtL3QrVXBoRmI3Zks0VWZYTUVpQ3E4cW52MGQ2YU5BWXJI?=
 =?utf-8?B?U2NhQW12MS95WUNRKzl3alI2RXlBMFM1RngvcytuTFRnZUlFWEh6WnZuMWxC?=
 =?utf-8?B?Y2FsOHhiQ2tmVktsTXdFdGF0UXg5bFFwUHVIU1JJNVZhSXIvYVE2R2p3a29R?=
 =?utf-8?B?dFhMbWdRS2NzbWdqcTlxdFVZSWs4dkJkUXRWMHBkbWpERjZDRHlOUUJxbzJO?=
 =?utf-8?B?T1ptWnJMUFhYQ3NKVkZnNGtRZTdTYWREU3d2TUd2NDVMVjRsR0FMNlZJM0gx?=
 =?utf-8?B?SmtCdkRjZ1dDbDBuL29LVW1icjhQWE9rVDlkMFcwdElLdEVic3YxMzNPWm1n?=
 =?utf-8?B?QnBEYk4vbk9FTXE4bkZlRmdYU201bDBUNm1BYk1ub2paS2xVVWNzUWM4SVhL?=
 =?utf-8?B?VW1VRDdRRUwwWExqMmY0OU4rY1hBOVpodWdNVmpSdjlQL0pvRWFtNExtQVNw?=
 =?utf-8?B?Vko2YUFJRzA5UjVndldyUjVrSVoyWEFiUUpZb1BtVVBkTUJuNnFCZnh3VXZw?=
 =?utf-8?B?N01ENnU1K0haQ245b2tRbUpNYURSNEphY0JOSk1mMzJxdy9ZRVBRaDNYcmY3?=
 =?utf-8?B?NHpWM2VaY0h2UDJtWDZOQ1QyUE8rMWJxODMrdnltMms5d09XaTBhVWkzS2Q5?=
 =?utf-8?B?ZXdwaWNnSk5GaDRpWW0zWE5rYXdsejhCcjJMUktJY2JGQW9qMUFIeldORnNT?=
 =?utf-8?B?Nkd4YUNSMmM1L3c3VDZFWTduYXJpRU9JMGpaT01YWVNMSTNzaTBBREVLMlY0?=
 =?utf-8?B?d05UQmhYSnJ4TG1yekxYUThBekhrQkpCaU1DUHVUOTY0THlFS2FxTjB6Q2Vi?=
 =?utf-8?B?Y0VIbGppQTdrZk1JWnZXZ21WOTIwOXQ5b3g2UlgrQ3dMb01XUlBKN1Q2WTJL?=
 =?utf-8?B?L3c2Z3kwVlZ0UTVSQ1RNb1RvSlhITDdUU1UwVmlib3ZHOGZ1K0M1aml0dEJH?=
 =?utf-8?B?bGRIYTEvMnpwWXdFV0lCRk9KTXF4Q0NVdllJU1RtYXQ5RzlQeUNCL1owT0FE?=
 =?utf-8?B?Mk00NGdGV3NFSmUzeUI1VjBxR2xQckRkTUwxcWk2NDcrd1AydUI5THdFNno4?=
 =?utf-8?Q?+d3rucbyAN7j16tmRJlNIS+/nICMLTydyEkw5KqdwlR+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlzREJKVDQ3UTJINVgyMGdtV05NcWR5ajRZcjQ1OCs3MS9pOWQ0eldxRjBj?=
 =?utf-8?B?Rk1USEFFMTFyNm5LRERZUWxFSE00T0Z3MTdsUzBmTUp2cSt2TmxxNExJeTlV?=
 =?utf-8?B?R2lNQjdSQzNqNzVyTzZIWWRXNUZLZVJjNWVTRmE4b0NlWVJheTF1LzFqZG1Y?=
 =?utf-8?B?V205ZUpyQUM1bHUvK1o4RVhTL3RLWmhxVFE4ZnRrN2dzTE03NUt0eFBkaDNT?=
 =?utf-8?B?V28vRnltcDNKWUxxeDUxZng3VEU1YzU4ZjFJbjBIOGQzMzhGcitwRVprM3BP?=
 =?utf-8?B?V25TNDNhT3pyTVc2YjcvSlhTRm0rQmR4YXF2RjdxS05WWS9HM1J4bEMyWlgw?=
 =?utf-8?B?VGc5d1FZV3RxQURma2RKNkZnTmk1UjRFTHJMWVVMZlo1NzgxRk9TWjB3S1NY?=
 =?utf-8?B?SHJRVXRibEZqR3pFaitzT2EydWc5UUR0RXdTU3Z1RjJqTmlJVHdqKzh6RHli?=
 =?utf-8?B?dW9XaWg5WTVlQUpJOFE0cENJNGljTWxoQWlMZ0tOeUdFVWxIMTBoS08rZDQ2?=
 =?utf-8?B?SWVSNEY1NXNmL3p6S2t5TjBvSExuN2pkMk03VHlLRXdEVGhsckxDNmd3OGZ0?=
 =?utf-8?B?Q2hoYy82UWdTUjBNM0ErdmZVMkJTTktmSWc1MkMrYTFjaVhPdm1hQzBBZmRU?=
 =?utf-8?B?d0FnSFhBamJqY3NFUmtCQktQLy9aNVdTazJEQ3ppVThnV1RxamdNUGxtUDVJ?=
 =?utf-8?B?MHRuZEhITXlHWE1OcXhYTnFwSzFOdW1yLyt6NXdzN1p4MmpqS2JpdHJqdlJR?=
 =?utf-8?B?K1doc0NFRkxJU1RveWlPeW4zREcxLzhhVVVPcUxyR2hYaGJoaE90elpxSnRi?=
 =?utf-8?B?RE00ZjAxa0pFNXB4aDVva08zdUd0L0hkS3AwZDdreWl4VEl5NFNMVTJKUjRQ?=
 =?utf-8?B?eFhVTXE4Rjd0VVpHTXpmeXFlS2JnZVBpMUNEcTg5bW8xQXJHVmhOM1ZrUjNW?=
 =?utf-8?B?YndxOWNCUU9CM1JFZVBuZmNIZit4QWEybE1JZ2M3VmdkNlI3UXF5QStMR1lF?=
 =?utf-8?B?eXNiUk9QVW9oaENRNUg4dUFLYllxcjZIaVV0em5BV09XQ1Jya09kb21vL1VZ?=
 =?utf-8?B?QTg4SSt2TnpyVXJjUlBwMlpGcWpaaVAzV1FRVFJWMmRYbGhCYmRkZVRmYmto?=
 =?utf-8?B?Z1dUT3dWVzUxN2ZVdDBubG5Ia2J1anFxc3BGZm9JZXBtUXhpd2ptS0hqaGxR?=
 =?utf-8?B?ZWI2Yjg5aVB2MnA3T2dIOHhYc2lOUFBBaGxvV0Q4WmZEb084YXVKL3hzZmVi?=
 =?utf-8?B?UFNUV3VhVDRDbmZUeUozTVljaDFIK25UVHlicE96Z1RNMjZLdFI0cXBiSHpN?=
 =?utf-8?B?UXVXWWhMVDNuNGtmNFZOWis3emcrbTVBYzdtTWRRSU5wTVJiMFN5bWs5ZGh1?=
 =?utf-8?B?TTZlNE1TVURCelFKMnZaT2JLWFVLS1pVaFNEbFAvVXl3UVcyRUpJa3pCOWlP?=
 =?utf-8?B?VVprMFdiMHZmSWtzUUpWem52RjQrSk83Z1MxY292NDAyOWtQTTY1T2MveitF?=
 =?utf-8?B?K1lwNXhIdU9GSWNMdjJWbllCL1U4QjJCM3RoeTUxLzBpLzVGMVFyR1pJdE1C?=
 =?utf-8?B?SVRqakF5c0h4NGFwSmpSdWNrclVtcVBKWjR0S0dPOERKUktnL05jem1KUU1m?=
 =?utf-8?B?azcyeFM2eXJkQnJkbEc4MkxQRnYwWHZ4bVVRYlFnR1UrWTV0dlRocWI4UjFS?=
 =?utf-8?B?SHJxU2JZVFhXSnc4ZXp6MHFMSkQ4NDZ2RU1aTFRSSWx0TW5XS3doeDV0YW4r?=
 =?utf-8?B?REtNRy9pNXUyYVNjOTYvYU0xSVAzTlF2a3ZFaWllNFo2ZHNsTCthK3Qyc0FP?=
 =?utf-8?B?a2NEOEdZNWlsNTBNWVBjNlo5d2ZBaEJDeklnczkrZ3U3bmFYTU0zWFRxQ1ZQ?=
 =?utf-8?B?MEFZTkNxZGs4T2ppdngwWkpwK3hjSnRNWG96NFNGczhRNnpwWlZQVjkzbVpv?=
 =?utf-8?B?QWl1NVhSTVo5a3dIZzRSQWxYMnRsYTJUL3RRRW5CT0drWHd1WTZZd05uRzR1?=
 =?utf-8?B?ZFB3TVFzWERUVTZFY1lYWTN2WFhucmtxNEpVZkFSQmZKZjc2cUZXTFF3dU9v?=
 =?utf-8?B?SUdtUkp2SXJtT1A1K25Lb04vQ2xpQ0o4Q2w3ZGtKTUNxSEdUaExPblkrT2NN?=
 =?utf-8?B?WHY0ODY3K2ZIYk5MRmJNbStxQUZhSDhzM2ZoSDJwNFVTRlhxSmVVUkhwUG5o?=
 =?utf-8?B?R1FZQXhRQ3ZWRUJHL1BLb0Q5OTZCbTZiSGpQTDBiWFBVc043K3Q3MGtGUnRj?=
 =?utf-8?B?U1h5Ukh0YVNjdXVTUk1COWhjQ1NlaWlMU0FVdWFkYW4wNjQxT2swWTd3dlRG?=
 =?utf-8?B?cEZUalc1T0tqaFFtNXZqSHJvcmhuV2JBZndTQXIxU05Nd2Nwd1Bodz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e30a8a-8470-40a4-058a-08de67b487f9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:23:40.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm2dRxOoPXkyhlCyJ4ksBcXMkN6rvdbpNx9unHLH1W+QNXdJ1maivwqMLd30GieVvo3Mr3WMruK0kbo2Z4e+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

Also introduce generic helper functions to parse Root Port device tree
nodes and extract common properties like reset GPIOs. This allows multiple
PCI host controller drivers to share the same parsing logic.

Define struct pci_host_port to hold common Root Port properties and add
pci_host_common_parse_ports() to parse Root Port nodes from device tree,
pci_host_common_delete_ports() to cleanup the port lists.

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[3] and PCI power control framework patches[2],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V4:
1. Add common helpers for parsing Root Port properties in pci-host-common.c in
   patch#2.
2. Call common pci_host_common_parse_ports() and pci_host_common_delete_ports()
   in pci-imx6 driver.
3. Use PCIE_T_PVPERL_MS and PCIE_RESET_CONFIG_WAIT_MS instead of magic number
   100 in patch#3 as Manivannan suggested.
4. Use "PERST#" instead of "PCIe reset" for the reset gpio lable in patch#3.

Changes in V3:
1. Improve the patch#2 commit message as Frank suggested.
2. Add Reviewed-by tag for patch#1.

Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (11):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: host-generic: Add common helpers for parsing Root Port properties
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 ++++++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        | 11 +++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |  5 ++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         | 11 +++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |  5 ++
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          | 11 +++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 +++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  5 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 11 +++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 10 +++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 ++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 ++
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 ++
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 ++++++
 drivers/pci/controller/dwc/pci-imx6.c         | 69 +++++++++++++----
 drivers/pci/controller/pci-host-common.c      | 75 +++++++++++++++++++
 drivers/pci/controller/pci-host-common.h      | 17 +++++
 25 files changed, 386 insertions(+), 14 deletions(-)

-- 
2.37.1

