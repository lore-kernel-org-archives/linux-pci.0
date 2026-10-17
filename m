Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3DB39B4A5
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278244; cv=fail; b=YXe/EnGFu/Pu+d5C+yi+C7GcR1+umbIymNXQ8wsuOSc1jhgyEqMbpAOHW46bUEuxqyXtpQXV3A2blBU0MHE6b0k324s0Uxm/lW8zyVzCjzf4/+4Vyr7IchiQtDu6D/qWXrin0Gy/yQaE1giLxQ8d1gD+BCz4ui9nsO7aiVWygmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278244; c=relaxed/simple;
	bh=RlZEeDzVk/YhdQ/6djUXAI1IYCWmBI/7jWpdYP41rao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FbzLq6jLluXDP9uzoPGblWpcUSaFMfRXJwWStdfaSj6aplBdWY8rmydrASo933YaoNzM4zDfgD3yCgv+nJoUd+S+xVFzLYBWMR3HgtSk7E+XIYnqjAENVKGJEVRz3kqFv8nw0FcLmKLdPkrA3IWOY0/klHUISzK0u6joFOvuZwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSaCcfa8; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSaCcfa8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7pV+T13H5ab8y2Quf9VqRDok3gwgI/aTxesoeKvq8XBnTrJ17o/uQVIZigi9cqp7ilZDrKyo8sFOpjCZTx7T02CxON1MUG89U4F10Aha3VxKy85lMOxx//rm01XE8CrDEJOE+BOJZnM6UbBRu5FwaQFInBK2oSc32YnLITvreNJRKI8MGqsf34srHcNfHFjlY4BuzEsLZljv7Vv9sb9FKpqumRoCzcyegZKcXDT/vkRBF9ghE6gItptuIfe3eO/pPIM8aCHTv6eSFTveNiLQQvC/Ebcx4ZPoFMf4g34R9Ozw2LdOPhmgJr/Smh1+Iqfs7QHhF8Oyz7kVQnsxxoFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlPe8e9nDqYccAM0UmMpsxvDMEQoQlDLJNaSyie+4jM=;
 b=o5dYLkPYCT/P+u3lWG38jhI5LcAqbB1eeBhMAHmxDRFq+0a0+VNfUYJJAalYknSR6rfPLfydytAYsJ1+nFZuWoTJYamqgxWCRV4jMYuhKApmjpZVo9JXtphGcqurOYyCoHk2gyVkhcCPSW5ka0QnbBqhXBtIDet5S3ZtN4Sy5YJ+laXyU3j3tbIy+VUhjh+jaxyrsY/YjQRp/NSBgfNsQSG6601wwYzkL/zSDvT32Zx8zwUF7wJGmHI5IVNebgWPR3KI4DaDc53+J4n+l/se5/CxFa64Ksg9TgXU7c+vmJhcbjHZb9iep09bXnwin/I2zy6ePR9WPLf2fBhKDmTD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlPe8e9nDqYccAM0UmMpsxvDMEQoQlDLJNaSyie+4jM=;
 b=aSaCcfa8CiHcL8ixpCREqgNXBhlAxt/wSgf3gA/dz8zKa96FvEt0FPpK75mHCwOQwlT2usrk4S9zdlMQcu4nTDf2ZGBKS6QyO4MHiKs2lS9rbAJNfBslavbVPWOJPd6bALy6Yq1CUHfhdjMtivSufYVBvjaLAhmYZnBnM1P3E4A8kSsYgMPAuDTij6VdeknqotXHdwJAWLc2CYDhRRkwEZk3md01XmmvB70ae94t/0/epnbLG/1fZSNbAxCrcu7KXKQcAQtDk5ruY9MpfmVYWeU491GuCQL6hX7faoozs9qoSlsXy1BLWADwVqnDahVVZmwPRTT0iSdBKHLNOpNGkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DM6PR12MB4330.namprd12.prod.outlook.com
 (2603:10b6:5:21d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 23:03:55 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 23:03:54 +0000
Date: Sat, 17 Oct 2026 20:03:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	ankita@nvidia.com, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cedric Xing <cedric.xing@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Kai Huang <kai.huang@intel.com>, Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
	rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Will Deacon <will@kernel.org>, yilun.xu@intel.com,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH] coco/tsm: Update maintainership
Message-ID: <20261017230353.GO13920@nvidia.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
 <atPlP3imtaPDQXTo@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atPlP3imtaPDQXTo@wunner.de>
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 76032df6-28e8-4f0e-8da5-08df2ca2eaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|10067099003|18002099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	T/s0H0YUcRbs6jCMT9OZyY0hIBbnk/IQjqH23RH7jI2/heK8g5SiSGNpWaCSY/IgR4K4NhFkCIB6QURfT17ONtoswm+KjRt/zk+yZMz03L15MeHjCo/D8oT3BmaSBohRVt7j7Ndjmd/hG0tH13F3QZ6DG/KTc4a+AcgP1V+4Qq/1CzKdWFU5008NfeDSdosFiHuIhLDsQ2jrbUJiU/QhyKCfCC+9AOshNL7/jzPD6yIP7kMIM2gYHswB2MKDiM65Y1ADk0s3e0p4Dwvm40GM+HKrGiFjET3FNU595Ocz/+S5BurrT4oVo/Fy/haZCS5CsCG9a+k2fbtcBgNpm2ph1PVZmm4JXReI6BB/vZQUQ0e0niz2hq3iLYfRCKYnNlK7g+CEIhQ3ELdLAwTMY3TRdD09TRdEFJr/jMZ5xsh/ERjj18Cej0xztAbUEZiQqcPHxUVhr1H3O5u2qa1chNxTD3FvG6axOXeI6Mk0UMUurY+/AjChEvOJA3HeexWTq/AxCAxZ0wJvLEsv/Z+6zNRTFpbqcwwvq8X81bt7w9MrmyO2UEcHV0NkW0at+T/fxTVg9VJLe8G6iSN7Ow2QeNlImZ7fREQr9Q29COneGdB48xzIhdbv7Jk0cyIXPWhAQ6EBNyE+EI2SaEKnpd+Ohrj01UDoZpZdgRiYwOuzlpUqEh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWu8P7XlRl4HapaxC635fGmOyyP9iywOZElYoViLumI+JxmD48owl17M9fcm?=
 =?us-ascii?Q?z910i6avjHhnSVhBR0B3lSnoCSOvd9cPGu6Kl4QSSMQfM/+7LWwd+yJrbczl?=
 =?us-ascii?Q?5UjW/GPibuLB52CqSthi+ZPub4qy8eXT9CqsKWH9rKv5c7wcPtnb/BlscXwj?=
 =?us-ascii?Q?qivAnPVhIbugLMsK5oDJ0rKRnNRhCXrIfiHQhFediSGovoqic9WxWPZbYmIM?=
 =?us-ascii?Q?XH0SzesF2ZJlQ8i55IrZDYEaVkJbvwuXTU8MG0s4UEgDtZNLxetyqf5X24bA?=
 =?us-ascii?Q?4h8HgBFLIb8FjdZqvfr6jLOXH+DQUt1zxRYfaGf8HCSpaND8MImafnTgG8dI?=
 =?us-ascii?Q?al7wqMu5bzqiYWNc/9Ai98WEkpTyGCx7kqeibHYWyKQSaCr4NiEXioOEQXEi?=
 =?us-ascii?Q?UgzjAOkRSKLfgWehDf7eIq1GwIKwYP+PISNfufwRuKDaypuIWLGiIyefMIh0?=
 =?us-ascii?Q?K1mgbdWAyIAe0laWBHN7QhGYxv1xVUgLP+wBMsJ3vdT8z7OdlPqpFGWbXoxY?=
 =?us-ascii?Q?rQQBCG1oDXikYScBQ2SK3p+0yBpEYNzfiE0kubeBr7G7sCRmhV1EN3bezdEK?=
 =?us-ascii?Q?u/So/WPWgx41LehRaTSPmPMuWtdseytuqBeepMXM0lFUacISc4LzgiQ4aDug?=
 =?us-ascii?Q?rnhYayG02gyFu0ktcNQeFYnTX6LzDaBlVrFyp6+28e7mAjI7KUZZdytcN5UF?=
 =?us-ascii?Q?NGAXQZ3KBDGhcBq0e4DZPjN7Y9KtQXZyeorNOEQ6edjhWC10z9KdKHxtetKc?=
 =?us-ascii?Q?9ZOmaQ5pJ6IkfcFWW88n4JPYG92+5WBkQ7p8L7/CjffFdjQ7eJ5x5kc/urwN?=
 =?us-ascii?Q?rECMVpV4a/ksu8QwmAUCtoWNh0G506lud787Jz5CLysyiIH3mM1xgY3w+baR?=
 =?us-ascii?Q?rjK/d7ktp36WWN0oRu16GwwYYe/LxtZlRimg2J0QLGV8K2UcKRrTSGNa9XAe?=
 =?us-ascii?Q?svHIcLgRieVRyUyGmPwHwJZTW0FURTdrejYd8/mAlpHSC3urYlOkyJBaWhuT?=
 =?us-ascii?Q?UyBra2ePAzZH3aO0oBv74VfhEZvWmztkvkdzAISvrhhdvsuiod/6h7d+9G6X?=
 =?us-ascii?Q?Ok78iwTG03Xnp1tAg4lyRRSQeL/6KXLUSyaygMddPeMQYH5p2mOelsyPoFzF?=
 =?us-ascii?Q?w7qO9mCLDghpNKFwzNiwrODssmMIHfnN5fzojfYshON+1Mo1z+2eJjW/MtgF?=
 =?us-ascii?Q?XfV/FVDLdnz0Q+xGahpxtywR4MqYJkgo4OcFabFsKa4+jZq94JlIIsNOi+fU?=
 =?us-ascii?Q?/r7oVLuxTIN3D+SToI4QPBAH4URuiJBILhZxuG/PHFhmiyUtUq20Iw+iN8Lj?=
 =?us-ascii?Q?/Sb8OGwC9uVFGkUH1kJB9UYkfA2YFOlbYsj3clTVoO3cAFcqt+HJuyJHGOXO?=
 =?us-ascii?Q?Mn2d5kflS06x6bFJcL4KWVbVLh0Qroz8nr9fqlF4ILiE4FD78TSAJygKKUOI?=
 =?us-ascii?Q?Fwz2xy0IW9aQ+mJjRZvdDNezT+FUIsQyLaY9d8tsPiG/tzox4pFTC1J3nqHp?=
 =?us-ascii?Q?UlC6NFtGD7jX+hB/bJ1hX5UOHAzxcGJ4qiUHzLaSjbS7MX2pZJ+8PhCTKzci?=
 =?us-ascii?Q?3QbVUHXJjlGo3HfvAPbP+6TFv7f1CDE/IZX3zkR1zOa//KOFRGVMY18yjZ0/?=
 =?us-ascii?Q?wN0qG1zwXPzvaBz8HDz59PpnAbjNXqnj73a4DfErUFzFgqOKW8obVof76Lrc?=
 =?us-ascii?Q?D8Kqe9RRtVZEzMOcF2DRpLUWVtA/QlM8CftjWCuWD6IR+MCX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76032df6-28e8-4f0e-8da5-08df2ca2eaa7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 23:03:54.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pztMd7lQ0riYaubCe1W4FA/zI/ECOsZJbFSdfwEBwv8tH+RVhoSat11syFymDwHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330

On Sat, Oct 17, 2026 at 11:14:39PM +0200, Lukas Wunner wrote:
> On Tue, Sep 29, 2026 at 08:26:41PM -0300, Jason Gunthorpe wrote:
> > +++ b/CREDITS
> > @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
> >  D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
> >  D: PPC port hacking.
> >  
> > +N: Dan Williams
> > +D: Technical Advisory Board member
> > +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> > +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> > +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> > +D: libnvdimm PMEM: persistent memory driver,
> > +D: libnvdimm: non-volatile memory device subsystem,
> > +D: Trusted Execution Environment Security Manager (TSM)
> 
> As said at Plumbers, it might make sense to including middle initials
> or middle names for unambiguity as there are other Dan Williams in the
> community and git history.  (Full name: Daniel James Benjamin Williams.)

Yep, I added the J and the additional text from Dave

> > +++ b/MAINTAINERS
> > @@ -27788,7 +27788,8 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/trigger-source/*
> >  
> >  TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> > -M:	Dan Williams <djbw@kernel.org>
> > +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > +M:	Jason Gunthorpe <jgg@nvidia.com>
> >  L:	linux-coco@lists.linux.dev
> >  S:	Maintained
> >  F:	Documentation/ABI/testing/configfs-tsm-report
> 
> This touches other work of mine in the PCI area, so I'd appreciate
> being kept in the loop with:
> 
> R:	Lukas Wunner <lukas@wunner.de>

Done thanks!

I will send this to Linus on Monday

Thanks,
Jason
