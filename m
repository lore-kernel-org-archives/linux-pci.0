Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452664;
	b=lKTG/uBTkayT4l8HbJNtSTDE9wLZ2jQNeVI9ElmSYvLMOA9tSDQWWIGwqcr5AdJZLm+K
	 9fPMwT2d3t5oSUESXHhxj2V1XXy+4E91uTiKcNNXdxJT7p5VjaAXHKAIsq02A3GvzJnYx
	 1e7aw2PJz4DVmK+XgnBBezJt64cetOeu3LXosETgWSk6JCF1WLwoGLmI8yIQPOL3uf4Hc
	 WLh+Y8ku4D/zUPq1AayV2UBuhxJK726ffi31dfaovxQe5MQWWt3OR9UsRc6lTgwGcEKRG
	 qwXfjUAgLjQMFUlDeIhmw+p/CFEdYQWIdwPbMI9Pn8mOG6An2ngdV87g+5xnoQB625Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452664;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sqG2/gkA7mF/6TiwFahNOdc9QcX8sTghQn1ydA4FHZA=;
	b=0jh1wCnASKvf+v0w8XsDwXISeYH1g+8tcW8NHdiYbZ/IcF6iTRWeeLHKTSZ6p6yS41U6
	 8A/7KBVEaGILcLW56pXI7sPRqw70zIr2sJVrv+CQwfYJRUnkWA2E7AxNlBpjVQ159Mb3l
	 7RqVweFDCweP8aFYLIO9B97xTL+a7aLvqn/OJ0OXz1HcpAN9R7C+4KItrKX1BZBhhmoDA
	 rD+7M5plVoWcZL77pBTCjK21qVsk8IHyfafDzGG55gS7/Jja9h8h+iJv9nigzsN4C6jYD
	 hczBviksH3eVZ+mPcrVI4QPlYHr8duA3IU0rjf6o6yTkZ7HlWSrQlx6B5UrsHMgHUFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0fzHMYtA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A127606A692;
	Mon, 23 Nov 2026 16:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A127606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0fzHMYtA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6Ds8yg5FTRWnGE4h0aNLEZpj9cJXspVVZVZMN98m82oTPgWm5Xn8Ate+PfdnXoNOom5ZrmITnv+ZE/gfKzWiC4NDMFXT5rZdJ/W9kcLqo73JcE1xJSulbMjtIWwfQd+2Vi/WOPPmjuJMGTkee7h0i5rPtdueuwOZzt+HxxjtI0d7SDIPw9tUkH3ZA+NXvewohOO3CbkyM+eOtaoX3VVmmy2niTEL1o5nt3oJnk+j1vdgeAuDcqFkk9Bfo8uMcT6KCmDcYJkmym6rr0oe4QV5p8nOcM6zznSTZe060aM/SIDY1Cp9xclIQv+izwdfF56y63TprTCo+UY3/a/BWPVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqG2/gkA7mF/6TiwFahNOdc9QcX8sTghQn1ydA4FHZA=;
 b=pLuXJLg5L20IdRidz/BpJp+qwmivRQRDuV6PGA9Jbwhlzc7/n/9NZUkuc+0rhpJyQckcweh6z7WrFYk36hBlX75GLekHrEIGgrkpHEPXZqSWaDIohOgRcfLwtlzoQQiViusA0CB1RefFWtRwPHXpr5dXqsaTsIaguVKSOvafaVWBK9RvAT6E9Yz1uT2TFRBw8WwP2oFlUQs7pyukD6A1wqV/v+tgXjJkRTYKUAkZvwE28n9LjQ/DI87Shsf5b2wPZ8ndKgE8u/NyGJKBgsNIX6VMrY1EHUUFv09DzEtjbhtxJRonFPC1At0k478cdRHW3aHA8Vz38mxK0kNXGAUPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqG2/gkA7mF/6TiwFahNOdc9QcX8sTghQn1ydA4FHZA=;
 b=0fzHMYtAV/BAylmGNG631XmHyhgyXFuj83aHO2I4aQrbXXDGvhDRfQecR3liXqmVncq3gYL5/SDa+WpfTifUpu2X6TDL1hDtHEYa4rIb6c/RP/4Frij7kRG7F+oGt0Jjw3tzghwrgnTkKwNr73Az9gDR+u+4F19LVTHkCfZpZMg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by BL4PR12MB9481.namprd12.prod.outlook.com
 (2603:10b6:208:591::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 23 Nov
 2026 16:50:59 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:50:59 +0000
Date: Mon, 23 Nov 2026 11:50:50 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261123165050.GA1741477@yaz-khff2.amd.com>
References: <20261120211307.GA1524494@yaz-khff2.amd.com>
 <20261121001202.GA917755@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121001202.GA917755@bhelgaas>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 089fe895-9ef0-4f0c-030f-08df4981f357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|13003099007|5023799004|4143699003|260925022911599003|11063799006|261102123227099003|260925021911599003|56012099006|261026121527099003|260925021311599003|261028144727099003|261026140227099003|261021121427099003|10067099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	8EvY4Z9rdNHMuVo/J7zpKn6K/JOFkq7H4/rMcrIm53J6l+ySW0ABC1dlIABg8nacrzNP9bCzSw9sYhjEXuhLbw/L8MMCiRdF+149AyDcZ0syqURpcQJWf/vGw/pF1Nt/lFsw/Vqorf1Ydis956NhhmLtg8gKxdQCa+E8M95gX7OXeh57gcnB9+xo/TmH9/3VmWnqDZKtDVu1VFSr3MvKEJgXR3eaFrNbrfAIbbkshtI5Ipp7YIVyIAy/SwMbF5sXeFuPZ0IUxYpCw3cLexHRTDuPb7KXnNXREypoDvZl5wip8WWkK5S4yQfvDH4gzZ+TE2z23SY9d5J2FqDEptjOgz0O6/uqlfgxFZA2MVhI7ouoZn+9nMGwqYPPdOn3nqr8maJx8eRNxdCahnizacfKa1XMdnb40kDnQFBdpiPj/5mZIB1ll8I6+q96Z962wuzarqrCB0249DJbZQpxMUG9iEA8xJ/9eq6BmZtRggWXfht4eWfOaFDk3P7D2B+2RIk9lt+z4z0AknX+xjFoUhdFn+B2+zGR+8bGzNhUKfpHFCzDoiOIxw6VWVXB7fPs0Xzw4He951feGOGz0+RpqSiLZixNLrO1nBbgMSKc/4IUQhN3/dJ37XS5VIW/p8FntA+/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(13003099007)(5023799004)(4143699003)(260925022911599003)(11063799006)(261102123227099003)(260925021911599003)(56012099006)(261026121527099003)(260925021311599003)(261028144727099003)(261026140227099003)(261021121427099003)(10067099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qqgG9KRYnFICSyRkrMcl62kFrVTaR9Frni75obj31EyV5EHRRLMukVANv9I+?=
 =?us-ascii?Q?OrNnBYZvGBmpVKZJ5IgTSrHn8wcJA9hwaBYn25LZNJeDwHwqntJpau06xeJA?=
 =?us-ascii?Q?5C+gOZ5mfDcaVq74aRcwe60FyLRi+Gr9gMwKZmPG36ZsHbau9QzimaJsK9E3?=
 =?us-ascii?Q?YS+NahhNEZbxAiCTZRasu3wJAbqSh6AC0yd3m89+YscdWLmrP10c7SjQS0br?=
 =?us-ascii?Q?NNgKOtL9PEpQHgMteKcDJLPngN3bPSX8NR5U0gSwEt0MkdrKOuLKF6GcOG6q?=
 =?us-ascii?Q?rbngn+1Tp0PjNSoj1hAIUKR297EJAwmMtCGNgIoimXINyH+JJ8IxcHQT3AJi?=
 =?us-ascii?Q?AveiJJMBzH2oxWAiaBjGps1DIFaGTdbA7ypz9e4p7iWnHHZ6pFHDLiLpZ1Yy?=
 =?us-ascii?Q?AztLxopmmh30lE5XoEdjNZP6fezpIb1PQUwazANrcojCjSPVmmtzKDe7r2oN?=
 =?us-ascii?Q?WmqUwcoW0exrwddwQOHv00azZ0YzIHYWLe2t+R6ZnHgQ5MKpfvg5lIx1QD5i?=
 =?us-ascii?Q?vGGhtE3T0KZqBzJircIGbVh2SPUrETrxpJzgzGyT+PVXS8vgyrn6KacteoQ2?=
 =?us-ascii?Q?58i98IOpdpg9i9/hvmwCwHCU1MV69GqiTvpoR4rUDBUm82Q6en2tB22xPF2t?=
 =?us-ascii?Q?Tj8Bp+hamGFoGvQcJF49LcQEYyxDImzzD82oIbWX1uPJGC52/o+bDO/p2Klf?=
 =?us-ascii?Q?2O7Rq71YFTlUC6HQo+Vo5EItOjXXY3IQx/dTfpHSbkZyfC1eWTAGqfcc8q1g?=
 =?us-ascii?Q?5wZLjaa0QWwyCNta48xc8SIpW/ERIKpFGMfxEzKvTYRocuL4ptUh+8qkz9Mp?=
 =?us-ascii?Q?caDe326TP5xanonjDPbuAXGtqMu20O6e4DSAvJoLl8/FqELxrQlf433eyfIT?=
 =?us-ascii?Q?lpNTdfO0/KAs8LwimbKUIsUvtrLVN7tqktNNRhFGLuDWygNLf/vEhIsvZdSK?=
 =?us-ascii?Q?kXKQiV7K6X0O7xhFLCoi73UDwxysaQnqzGfxVy6ZCD5cNgX3g7kdHXp9xLZa?=
 =?us-ascii?Q?/2TNYm6nB0184nOy7t07usbQGuwWMojFT5+yYrYRR9CKhxkm/hoG2bVCSh9V?=
 =?us-ascii?Q?iRPVtu+h4VkTycLANe28QDI3tuym2sR2tDKfcxHQao4xvGFFA86JP1JADV4t?=
 =?us-ascii?Q?rdhzU/AdEhjEOFgH/EzcRNOebMF8FNnfOuUnx+vQTR8DCayzDqHsjRI6f9qc?=
 =?us-ascii?Q?G6kdfs6prQ92oMW8L4aMhpBYWH7puAM9J/n15NcJUR1kKWIJfs/lxTUaZBlb?=
 =?us-ascii?Q?cG1KEBENx/3vLh/hJ78Qdw8rF20FQxpyGYl6aosbrJom+ZfB0EtvMT4WsO3Q?=
 =?us-ascii?Q?qWZbgSwY3ys2J5hV2RHUH6UPuI1YZUO2m7FyjR3dZkYWkWjSU5ib3qzTCsIs?=
 =?us-ascii?Q?4dCxCXuzCV6kX1JTgMRCoejk38KgxteLsan0schmW1mi2AHPADuIGS6A5CEQ?=
 =?us-ascii?Q?mMsrkEW1Vb3jm402HRfIG+lM1feCmEs3rW3wND5cysnoqO4PFHeEdT3+lVqQ?=
 =?us-ascii?Q?2y7fl3bAv7L8JL7vArtHWMAiWaP/q7z8mC+SFFXuFuEW30ZNes3OrrzZNZn0?=
 =?us-ascii?Q?MBlLd+rmhUo6G7Ay1tgURUoOwmFXzNNUvkOyvY+9/tt6nnog7EfMDfgu9Pk6?=
 =?us-ascii?Q?l1lZjcl4Apzts+SIN+wVD16kva2Gjsk2D21y1+n7RkUeFOXehOuEYBdwW4WQ?=
 =?us-ascii?Q?oLeD+YBa917HMH4PxbV74qH0Agi+ufddXGOGMFjClAfkoAvC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089fe895-9ef0-4f0c-030f-08df4981f357
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:50:59.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex5i45+kaYlAwsMfgU4dSdZY6/3B8e1zRlZaMGEduf/la9CEU5ZgkicCRg+O/UETHmMUpMPvwYYNrg2W7awCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

On Fri, Nov 20, 2026 at 06:12:02PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 20, 2026 at 04:13:07PM -0500, Yazen Ghannam wrote:
> > On Fri, Nov 20, 2026 at 12:10:43PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> > > > The correctable and nonfatal "_ratelimit_burst" attributes store
> > > > whatever kstrtoint() parses, so a negative value lands directly in
> > > > ratelimit_state.burst.
> > > > 
> > > > ___ratelimit() reads a negative burst as an uninitialized
> > > > ratelimit_state and gives a WARNing.
> > > > 
> > > > Clamp negative values to zero and document the clamping behavior.
> > > > ...
> > > 
> > > > Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
> > > >  drivers/pci/pcie/aer.c                        |  3 +++
> > > >  2 files changed, 17 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > index 5ed284523956..215cf8bd4c30 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> > > >  Date:		May 2025
> > > >  KernelVersion:	6.16.0
> > > >  Contact:	linux-pci@vger.kernel.org
> > > > -Description:	Writing 0 disables AER correctable error log ratelimiting.
> > > > -		Writing a positive value sets the ratelimit interval in ms.
> > > > -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > +Description:	Writing 0, or any negative value, disables AER correctable
> > > > +		error log ratelimiting. Writing a positive value sets the
> > > > +		ratelimit interval in ms. Default is
> > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > >  
> > > >  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> > > >  Date:		May 2025
> > > > @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
> > > >  		before ratelimiting. Reading gets the current ratelimit
> > > >  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> > > >  
> > > > +		Writing 0, or any negative value, suppresses all logs
> > > > +		unless the interval attribute is also 0.
> > > > +
> > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> > > >  Date:		May 2025
> > > >  KernelVersion:	6.16.0
> > > >  Contact:	linux-pci@vger.kernel.org
> > > > -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> > > > -		ratelimiting. Writing a positive value sets the ratelimit
> > > > -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> > > > -		(5000 ms).
> > > > +Description:	Writing 0, or any negative value, disables AER non-fatal
> > > > +		uncorrectable error log ratelimiting. Writing a positive
> > > > +		value sets the ratelimit interval in ms. Default is
> > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > >  
> > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> > > >  Date:		May 2025
> > > > @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> > > >  		allowed per interval before ratelimiting. Reading gets the
> > > >  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> > > >  		(10).
> > > > +
> > > > +		Writing 0, or any negative value, suppresses all logs
> > > > +		unless the interval attribute is also 0.
> > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > index 6f2460231422..401cd3a1b3d0 100644
> > > > --- a/drivers/pci/pcie/aer.c
> > > > +++ b/drivers/pci/pcie/aer.c
> > > > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> > > >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> > > >  			return -EINVAL;					\
> > > >  									\
> > > > +		if (burst < 0)						\
> > > > +			burst = 0;					\
> > > 
> > > Why don't we just return -EINVAL if the user writes a negative value
> > > to either *_ratelimit_interval_ms or *_ratelimit_burst?
> > > 
> > > I don't think there's any reasonable interpretation of negative
> > > values in either case.
> > 
> > Right, that's fair. I think the reason to clamp was to be consistent
> > with the current code.
> > 
> > Would you like a follow up patch?
> > 
> > > Any non-negative value for the interval makes sense (0 disables).
> > > 
> > > Any positive value makes sense for burst; I don't know what a 0 burst
> > > value could mean, so maybe that should be an error too?
> > 
> > "burst == 0" came from here:
> > 084a990ded63 ("ratelimit: Allow zero ->burst to disable ratelimiting")
> > 
> > IIUC, the goal is to **always** hide/disable the messages. IOW, keep
> > logging the errors internally based on the interval, but don't print any
> > kernel messages for them. The user can still get the error logs from the
> > trace event and leave the kernel buffer alone.
> 
> OK, so burst==0 should have the "usual" semantics (disable
> ratelimiting IIUC).
> 
> Can we make a replacement for this patch?
> 
>   - Return -EINVAL for negative values written to either
>     *_ratelimit_interval_ms or *_ratelimit_burst 
> 
>   - I think the existing *_ratelimit_interval_ms documentation would
>     be fine, no change required
> 
>   - *_ratelimit_burst documentation needs something, but I don't know
>     what.  084a990ded63 ("ratelimit: Allow zero ->burst to disable
>     ratelimiting") suggests that burst==0 disables ratelimiting, but 
>     you wrote "suppresses all logs", which sounds like the opposite of
>     disabling ratelimiting.
> 
>     Also, I don't know what "unless the interval attribute is also 0"
>     means.  What *does* happen when interval==0 and burst==0?
> 
> The pci/aer branch is mutable, so we can just replace the existing
> patch.

No, burst==0 is the extreme opposite of disable ratelimiting. It's
basically a mute button.

"Interval" takes precedences, so interval==0 means burst is "don't
care".

The three scenarios:
No ratelimiting (interval==0, burst==X) => show every message.
Ratelimiting (interval>0, burst>0) => show messages based on settings.
"Total" limiting (interval>0, burst==0) => *never* show messages.

I guess a user could tune the settings to get to certain level of
"quiet". But there isn't a way to 100% filter/hide the messages. The
burst==0 setting gives that option.

What do you think?

Also, updated patch is below.

Thanks,
Yazen

================================

From 88cfa8ba46d3f212cb94679c3a8211ff15bdf678 Mon Sep 17 00:00:00 2001
In-Reply-To: <20261121001202.GA917755@bhelgaas>
References: <20261121001202.GA917755@bhelgaas>
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 23 Nov 2026 08:59:07 -0600
Subject: [PATCH v2 2/4] PCI/AER: Reject negative ratelimit interval and burst
 values

The AER "*_ratelimit_interval_ms" and "*_ratelimit_burst" sysfs
attributes accept negative values. A negative interval is treated as
0, which disables ratelimiting. A negative burst is stored as is, and
___ratelimit() then warns about an uninitialized ratelimit_state.

However, a negative value has no meaningful interpretation for either
attribute.

Return -EINVAL for negative input.

Also, document 'burst=0' behavior.

Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Replaces "PCI/AER: Clamp negative ratelimit burst to zero" on pci/aer.

v1->v2:
- Return -EINVAL for negative interval and burst values instead of
  clamping. (Bjorn)
- Keep the original interval descriptions.
- Describe what a burst of 0 does.

The rest of pci/aer applies on top. The only conflict is in "PCI/AER:
Enable baseline capability error reporting", in the two interval
descriptions. The resolution keeps Lukas's capitalization without
"or any negative value":

  Writing 0 disables Correctable Error log ratelimiting.
  Writing 0 disables Non-Fatal Uncorrectable Error log ratelimiting.

Tested in a QEMU guest with injected correctable and non-fatal errors,
for every combination of interval {-1, 0, positive} and burst {-1, 0,
positive}. Negative writes fail with -EINVAL. Every error is counted
and traced. Interval 0 logs every error, whatever the burst. A positive
interval with burst 0 logs none.

An LLM coding assistant helped check the ___ratelimit() semantics,
draft the change, resolve the conflict and write the QEMU test.

v1: https://lore.kernel.org/r/20261110215614.3931232-3-yazen.ghannam@amd.com

 .../ABI/testing/sysfs-bus-pci-devices-aer          |  9 +++++++++
 drivers/pci/pcie/aer.c                             | 14 +++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 5ed284523956..e4c39839cc6a 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -143,6 +143,10 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
 		before ratelimiting. Reading gets the current ratelimit
 		burst. Default is DEFAULT_RATELIMIT_BURST (10).
 
+		Writing 0 suppresses all correctable error log messages.
+
+		Burst value is only used when interval is greater than zero.
+
 What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
@@ -161,3 +165,8 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
 		allowed per interval before ratelimiting. Reading gets the
 		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
 		(10).
+
+		Writing 0 suppresses all non-fatal uncorrectable error log
+		messages.
+
+		Burst value is only used when interval is greater than zero.
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f2460231422..2c42d6e8bd9a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -690,7 +690,8 @@ const struct attribute_group aer_stats_attr_group = {
 
 /*
  * Ratelimit interval
- * <=0: disabled with ratelimit.interval = 0
+ * <0: rejected
+ * 0: disabled with ratelimit.interval = 0
  * >0: enabled with ratelimit.interval in ms
  */
 #define aer_ratelimit_interval_attr(name, ratelimit)			\
@@ -717,10 +718,10 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &interval) < 0)			\
 			return -EINVAL;					\
 									\
-		if (interval <= 0)					\
-			interval = 0;					\
-		else							\
-			interval = msecs_to_jiffies(interval); 		\
+		if (interval < 0)					\
+			return -EINVAL;					\
+									\
+		interval = msecs_to_jiffies(interval);			\
 									\
 		pdev->aer_info->ratelimit.interval = interval;		\
 									\
@@ -752,6 +753,9 @@ const struct attribute_group aer_stats_attr_group = {
 		if (kstrtoint(buf, 0, &burst) < 0)			\
 			return -EINVAL;					\
 									\
+		if (burst < 0)						\
+			return -EINVAL;					\
+									\
 		pdev->aer_info->ratelimit.burst = burst;		\
 									\
 		return count;						\
-- 
2.55.0

