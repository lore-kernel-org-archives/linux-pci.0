Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758367478;
	Sun, 22 Feb 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771759836; cv=fail; b=GcAdqjNa80oqAvy6iIEWX0/3kdLvD80WYAeVNtQZHDUmaXQcFZUN2ysgbceCj6wlbe0tdCynD86J88aO4PjVbKdW0428Ey31TOz1z9eRqYzmQpXQzvo7qGEIOKGil6awsOMfARb+yJPxzDjs1efcF2oB1BXLEtG8WCJ4WrgreEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771759836; c=relaxed/simple;
	bh=Hbs2Y7uYT0t4Waz1VVv4u/XckrrzV0jVqQObffqpu4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1pSyKp+75HlepAeAL7mC/Wat+C4HV9OlNYcblCT5ZvAcEot9+n/cGSliVM4LlvyIrGEtLtySKDbkK8bx7CIJdfeQepOgTBIsSzGC9g6RJ+mH82dbarBGGmij8u1LHmloUQ16fjSpG0jlHgHGLhd5qLVK1wCQBdDcwM7wkXf7fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Qukj5cCa; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Qukj5cCa"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MBP2dK3261229;
	Sun, 22 Feb 2026 03:29:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=q3AraLwZ9t4zAS3wqLZuH5lJxQ7KoWjHt66KN6jqgtM=; b=
	Qukj5cCaPmtoY0JHEAAz1Klxb3xTJ+z8jG4EFxI5MnOn8sVKx/ODmCj9pvtBd1Xr
	B6bfjrb8Dz1eWmuNWdlddi+tme/XW3YL0vdUVWQVulkW0oNpB4un9q9EZQ3s5wC3
	w8VBJQQqQCebs0N/Hw7gTDHkwKKcc/RDL0or/TuV9lKYmuRVErSrWjOd8HjxQUXJ
	WDwbpfEftBynLso8SdDzvlunN90K+f0Hznq4B6aHx4tef25gXQuAeEjyL8r7AMAU
	+HP3CaOsY1XuU78YKmadigHZUp6CCbhYRAxosA3wptsq4N6E3AR0ydEli4fWOjYb
	0wjxUIiwzO1JbAXAh0+gLA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cfd3k0ke5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 03:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgbRMd+lRUNZYU+QXo/PGcY1Xa7fAZ3Us9icB03oiefdZ3mAfg35O7Scusfleidyz0lVEXbofnLqdGMbjGiBZDMP9+gfU+ppUptaaVVu7N0BSTHxCHpgvtpMsdboCcIZOHwcmdJVg/L0df4YZpB5MrLCN/UhlWu1fS7VBTkyAc41C+PJ0AdA795BIK+R/aRnlFt39mCGmexSnAeIUNhBQr1h1pMXJoJmQ8GAq/OJBtEoDIpwJTICaKt6D4r+2jWtKqsnFGyE0MFBypzjy8aOXWte3Cbn9/ZGJ8Ea08jRy67/wjXhTkY2to/pYPithQHCXIJkVsJnbTtXp3zh1PlinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3AraLwZ9t4zAS3wqLZuH5lJxQ7KoWjHt66KN6jqgtM=;
 b=pCaz9UYpqFOgIugUpsFObwZQ5Z1/84V/LFqBjLGFuiS3wsgw6In/SWXcAfesH0RfSJPmx51zghv8HnCHp6IGoQ+AQ+9IwMB2HLorEWxsGvWDbi3g4ed2X50SDwOrBYkaDuvRiIjXKbQ0Nlxb6jjP2iZwOw6jspKVPFNNQJpaHMDhjMMm9XTwdGgJk0yD82ugSVqXolblySn2P/ibHti5y55XYwjjhdzISresF53d5Cv7WX69VFN+0Tsm4+wnD2knnaJyZNYB8Xx3GtzUkdwjrBGQp6OEt1lkAKtjJ3GhbVsMFNUusfONC7VvFzJ9BBl8470P50Wi8j9adkpy/bXrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB3878.namprd11.prod.outlook.com (2603:10b6:a03:182::31)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 11:29:53 +0000
Received: from BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23]) by BY5PR11MB3878.namprd11.prod.outlook.com
 ([fe80::5836:a4f7:7e05:d23%6]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 11:29:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: helgaas@kernel.org
Cc: Ionut Nechita <ionut.nechita@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH] PCI/IOV: Fix recursive locking deadlock on pci_rescan_remove_lock
Date: Sun, 22 Feb 2026 13:29:04 +0200
Message-ID: <20260222112904.171858-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209161443.GA190606@bhelgaas>
References: <20260209075706.16367-2-ionut.nechita@windriver.com> <20260209161443.GA190606@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3878:EE_|CY8PR11MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da934e1-4e7e-4099-5810-08de7205a7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nS90J0q6bTiwzF0o4ZhhnrkNIGDkKmP1J+fLp7UFEIWN7EBjzykwrYa5RsU4?=
 =?us-ascii?Q?LjmynWRAeC0ath8CMtuQI5mnat9XdW3CnF/mk7IQiNzoUPTtY251gL1rVu/9?=
 =?us-ascii?Q?tKcYOeWiQp2IUTtzNTcTqXBARTXWlBLqn8dh/zP3X9EiTf3wNSrCOuCvMmZ6?=
 =?us-ascii?Q?+eFiYZXaKiru4Wu/iO4tnzB3Grv9wka6IAruxphfB4NU1zNpj0J5GGwKxWvw?=
 =?us-ascii?Q?yNHf+VIhrJCth2dn8rVsJZephBzLKnDOGWPy9S9P5+FkpNhpiDmKa3sUMtpx?=
 =?us-ascii?Q?yBByWyKiJ1U8wpeZseolVfYLB8x2G3cmVa/v3VNtFuzDt3VxZjwCo2MvaNCj?=
 =?us-ascii?Q?+qbS+NUU5DSdLlv/iyHoF3GatYBngPKK4aRlcmTS161Qo2blQoay5DjCGYgv?=
 =?us-ascii?Q?0vRgCoYTjnjWlhu6NPsu8nRxnkD9CKkiI5OW8BtEb+YQnT500h5iEla5cLsc?=
 =?us-ascii?Q?rlWx7tbWfDObvQ6aMHYLAbucuSykH52SsiD84hZPRbb2kMys9H4VYDksP5mI?=
 =?us-ascii?Q?W9QDhbRASKc78CQooxxA8E1L8U8+RhPeE/bYITf53Y8uXOmeGwPtDxHtbsJD?=
 =?us-ascii?Q?iTzZsZIyP2Ehw7DJOHQpXGPNog/qcmIVgmRplJV0+nMvEkqdGaNZtHRRClvQ?=
 =?us-ascii?Q?+iwpwrsgxDuik6AAIWmA7cJqn8kU1ZwlnUluUCodwBavbzDrVdu8D2m2WG79?=
 =?us-ascii?Q?8D1fkv+bw7RNWgvNf4hMXJsNpa7Q9fEhSogEVq4JCi3J6U3zF+TeK6VbMn/j?=
 =?us-ascii?Q?Oboiz7j4wNABKzfScsHMjmu9F9YaQD/ueY4R9Vq0vOixGRiNto5TL4aIb+uz?=
 =?us-ascii?Q?iWNMXY9KVsQ3tvc1JAo0M7/oU0kMbSWowCj2slitPvJX32xAIcqg9roHGqdh?=
 =?us-ascii?Q?V0b1Wr+1puzPv6IqepLQXNxB8ceYdlZQTB4aaHhqzsUwDsgHFcYZ05Z7r3Qd?=
 =?us-ascii?Q?QxfmSL34+YgqfdrEPfGKYza61oorlRfMdVeNoZJ5Gdv9FlnpgV51NuzucR3I?=
 =?us-ascii?Q?/up5PuZktYQfIt+PpVAFZW5jMUJRYBnBnUzOAxGsIH6avetVU92IrwXO26o3?=
 =?us-ascii?Q?ll5aqYiLJmlQXjEtjs1ESFC0K18eE3fFauGoXRVbbf5uqQanDy9pnmhy8ap6?=
 =?us-ascii?Q?G7Hl3W9ZsSB0JpzoPddu73efUzODVfuTr9LM1yeiJqVQpjtLo+gTOXGlXTA3?=
 =?us-ascii?Q?QungZJi/icBInX4ooFQataRjO01aVqCw+FprJ3V++IZRK7v0DrhPgQvUdo8t?=
 =?us-ascii?Q?tS7jrq9I5SXN2gt701SLKMdGXAUg/xbucdglTkPdD0MIVeMsZAFnPbsrT8BD?=
 =?us-ascii?Q?pel2k/WAdjXGyoeg7Br+rduiwKd9nDpGlqvRQZk8wSLGA6TzdNsg+wak3Yio?=
 =?us-ascii?Q?HW9AA3raEX9S4jPJFN8iD9jwdsOgEB6CZ0/a2jdoXc/Gv8ndxDw1RVqkSW4U?=
 =?us-ascii?Q?3HhsY46zHpqFN3lVulUqemZ7cHaWEY4SPiZN5RowXyUc2C9ay77Ijd1sYMPC?=
 =?us-ascii?Q?mFgd+sbFuR7cUA25WQjHk4TZkepTQj0ojN1Y3GrrrsQ7C0mE8OqNPwK1qEVs?=
 =?us-ascii?Q?gJbTwZxLCgF3182iyFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u9tucZGoRQLBrbQRfQFrgOFfQotxg+Ohk9LJUVm6HscaAFQqF++wF1HcSBKF?=
 =?us-ascii?Q?YMkn+0YrYDsAlZc/kAV5Jv1B2tLm9PSWBpaNPn8hsLsPnUsS9xphrlfhKXHi?=
 =?us-ascii?Q?kTFe0/goVxo3SGRM1xvquvrO9nLvXEz7PUHz/Z/y9Wu8aj4eFmIaDByypOQJ?=
 =?us-ascii?Q?HIoYbRI3JGY4rSYmnzGfVtvvAnfaFd99ARKExRfYs1LlMKTpZF+yKLBHU+Jt?=
 =?us-ascii?Q?d/UOB2xTceIuF76kcOw4oEqRemgkDm5kx6rotvYcRrdyfW3FPmdCH+wD9FhQ?=
 =?us-ascii?Q?6XX++Cy9Y39Vq8nTmUFjfUX2SR/+zSkY5L7/IVFMypAqfVDgoIv9rASDBtTH?=
 =?us-ascii?Q?ai5y0f0vlNYQcKN92C1K82MD624zZ3shhbc/w0zAz0LPiu/w9vPmltpd5LPG?=
 =?us-ascii?Q?ynX02CBH/NZPl62zgBjFugLyEDEgfIqObL9QRrXSpKvA8SkfZqEZW+HBLhdO?=
 =?us-ascii?Q?2seG3brpXqSf/K72YLNcsRaftYPv4RW9iUC5y6nDmGni+mOWgbmA0FAJksaZ?=
 =?us-ascii?Q?jU8HbpjrwgNXYGEa63nHNn6DPwb9ET+jfzmfBiVW/Vhs4Qvgjv4p+p3eNbTJ?=
 =?us-ascii?Q?kiNXrXQj3KKEcif3E8FDru4gZT2J2AppI/yqHcKD0tJNTsqSTb3IU4QttfWS?=
 =?us-ascii?Q?ZnrmEMKVJPNpqBMobyNhRTXno2iwfwNKAEQ9UlcE7UXVyP2Bj+Q6quaxbzOX?=
 =?us-ascii?Q?5LRnUXajT47F2Nb+4UsLzHcVbrBvmF29aXGFo8DcqJWshMXchfXEluoPs1Ng?=
 =?us-ascii?Q?JwPu3pzVCpbW5TTep+4qh/3Arl3EOeq2ZRn0jXB2/w0Y84cvuREiJrxHFkXz?=
 =?us-ascii?Q?Qt3vSoN0SRShLoHCCfEEuaBzJ5cHzdkp0H0SxzHaukYyIfdy22wun7udXnbR?=
 =?us-ascii?Q?It3k2sEhWoZ4gKH0o3DCTZyN6AumwKYlnUi3awniSkqg3cqHa+IGBRXvNUUa?=
 =?us-ascii?Q?kys4lQMW/KZghtQ7B6c18DTw61pczm9sVQ0XiAcng1svvMeHtEyr9rKtn32S?=
 =?us-ascii?Q?VF5ykY80ET9BN+7hnl7+3Bc628wN2qWLycu8qAuRTVu+MFRsO+BdZVmoFatE?=
 =?us-ascii?Q?M9Ed7vXGmvOgRS8LX2PTTgkVXf46m/JWvp4Eqa6YfoY7l4KSvK22Zj68BGvS?=
 =?us-ascii?Q?zI3A4Xzu5b/EEZa6zxEXXR/ydmFzC9R23lX48UxVHaw0sIU00LmvUwHRdDDL?=
 =?us-ascii?Q?P+59E1L3l9j/LyElOwtyDMn8cjaplDrDBsBRxYaauoPjYGDlRbXeXlLqh1dW?=
 =?us-ascii?Q?bBL9BaqX84OlcLzmQh0rabVLw7lRk57f+Mp9S73965t9/Svf9YojO5OcCkPE?=
 =?us-ascii?Q?SCzHTi3tsrIdWCdG+PCgnvvnab983oU9GmqbZUmH0pQ20U/iJnA1aZKJ3eKc?=
 =?us-ascii?Q?jWFDpcXhMe4Nz9Hfgi88F1pRGmITKe5bl0svx1jbp0/KFDMS83KxgR7H9rkr?=
 =?us-ascii?Q?b+nwTdLnf199utZJFiBhpJhp6mpwWfnuHdTxTg7d+6oqv7AI5OhyRWPqs+LI?=
 =?us-ascii?Q?odb4bIldS8UfzVV1nUN16/Q5b4ZZQkNXBxwimJokKAEytfSbS/bjpa/s2TFc?=
 =?us-ascii?Q?vJsFLemUmQSgt/5Pbav0Szf7wl/7vteNwO8nA0casiasWGO32tHzBPp/9F2f?=
 =?us-ascii?Q?NwJBjcoqVPBnnEsUdL5+qkWUmb8JkWVHMUxYAflsrOq4rcOCsC7IREJjHF3y?=
 =?us-ascii?Q?gnjKllDxbr29Ur5XiUA/Eu2ptpY/UPVmSPYeYjWi0kQrnTriuq5xaEpy2uaM?=
 =?us-ascii?Q?LlQfed8PCZKi+1d+FxIMKeXFRvGXypHphp6OFeP8G5GMEW0wvxQqelDZ1N7t?=
X-MS-Exchange-AntiSpam-MessageData-1: +kqFCLjKaJEucq2JtiuCd4CzVfLIzoSoTlo=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da934e1-4e7e-4099-5810-08de7205a7d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 11:29:53.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zb48GlfUwpflZ7ZmSLmaL+SF3PATn5Dtgnheu5s5X0MTryXvElNUn7JmjsD1uI4992hQ5+XQCtRklkoKKju5GV8SJo2JLPNyOTvANutjH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-Proofpoint-GUID: 3IR5UqeEiLZMFg8L9UUmW0F_TA1Z7o8L
X-Authority-Analysis: v=2.4 cv=Bo2QAIX5 c=1 sm=1 tr=0 ts=699ae8b4 cx=c_pps
 a=/NeaHkXls/iJsjBnUIdqww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=zTgj_bJcXea47m1F8bcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 3IR5UqeEiLZMFg8L9UUmW0F_TA1Z7o8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDExMCBTYWx0ZWRfX33+q1ze70IId
 aXvV4nNjYAtEW4uTV35LtZ3XsQTadhzZKiTIBy6GzbGA0R4iGZFrd2HZK4kDvZzzDBQXMoxZRiy
 /xGh7HRad27/AzOvd9nE9PvmiCswhjKUDgAOoZZEcQsEupGXv8LjcBdgK3Kj5Zu0d0JVcPxx1bG
 b+9SGu5j9XbRzLZ+8sVkAN/L0AzJvKnHEV3yIAQXV2qlegpyg/AgmfQPalUvzEHrI8thN+jjTHA
 qxeGnUr+P7HqpoSrGOaoPMMTcbrDXBD3JKcHjQdwm44uITfs4kN/tFRzVj4x7I9KBalyCCSRNv8
 9TTRIC+wmXshhenEwtVNMiOUSp/qeV9ytol9PX3RLdtv46j0yEq7opg9X4JhBtPHgH+iN6BKoE/
 TJmYSJZIUhU5SxR02OY307AFWoGai1OmbJnQ57i0Hid+t6kynnKgXS3fKz9FzAYs925lg48CZKW
 0icIBgLYWg+lTt0lFfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602220110

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

I tested Niklas's patches (from next-20260205):

  2fa119c0e5e5 ("Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"")
  a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")

With an initial round of testing on a NIC controller using the i40e
driver, the deadlock no longer reproduces. SR-IOV enable/disable and
hot-remove via sysfs work as expected without triggering the recursive
locking warning on PREEMPT_RT or hanging on non-RT kernels.

I have another round of testing planned over the coming days to cover
additional scenarios, but so far everything looks good.

Thanks,
Ionut
