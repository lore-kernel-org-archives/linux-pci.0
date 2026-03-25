Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021077.outbound.protection.outlook.com [40.107.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9D324705;
	Wed, 25 Mar 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428288; cv=fail; b=Ed1ixKf7zutQX5QvgpDF/8proPAFANXV2VBreE1pdlLDrIrwbW18dxq5gcQPR83T14G8N1Eveow6iPU7awIVQut7NQoTxaJQOXF+6gIJmMNtAHNrGOfxHME9h2OFhLdmB2GUAhAVZpjt7ZD/dmrO5aaPU9y2Bch0kBB6BYAfRh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428288; c=relaxed/simple;
	bh=F4EMJxAsfnrvc1vULDSYK5VR50a1qAXMT4OM4XsbqKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXqy6d4Jcp6dWw+tGjvlR/Iw/7EY/AnxUs+LAhmKKUz4LBVHaKUzJwd1jF2w07pn5aD1SR9PA4s3SQJozP6A3vqzcDXGOV0R8Z5h57F0F0SWnztJ9heoX+wwaB/Kq/h9+V3ps/XpzGf9JVVYQyaXpV1X5bBhhyVdke9gnwfN7Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZfTCxOMb; arc=fail smtp.client-ip=40.107.74.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZfTCxOMb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlBma/+/vgnNExS/zhI6gbkmBJrNUHrU25/EU9WVtv+Zpce/4T1e62IJttkOymvCoYVlyINQ86SU1t3WHOc/uZmrgxGTcXauylMidNB3Ad0EC1EdIHLJtHQvOOpOQDCm7RcXS+xYMdSxpv3tuainX2YHr2spbN7BfiPV/BxMem8wB388RPcJ/rLhtxaIbXDln6O9fWVSj2SR9ZuliekCuJl79WmjXsaQtVRb1sPCbf/xNk36hcY5bZMYzuR+3/uzbXlvpvY263A4h+XwORAg85fGEfbjrAbWr8rH7LA/EaPFceEWHzD7s+WyDVfQG4kZR0W43YRKROrOIb3VaDjzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUJ0icJSVSbeDpSXhYo20gCqF0L9/aCgCyMyAqjv/rE=;
 b=FAhmqPfqGtL7dev23QqQ0THNPZsKtbEm0IYqNCwiQXJCV8Gp4oc/CvypqPH8HQip3akmSxT3APoICJF6gi+Yk4MdlQtYpoSN6oII9BcYwb7ig+qcgyC+YpJXwFJ+vaS8Uv6Sfio4n3djinaNKkGO/xMrjuYKK+Imtu3OxY15DEMLhOKOwXT484x2jGOjuAIqlTq+DesVk6Noi6io+SMvomVClWrp1bnDF+Ir3JaM8GIeUp5VzdAzO3F5ylY9wnstYMcpqM4V4bDjqsCKWf5/qFDfz6hsw+SxJ/OLbjt3sgunDNFwksGjKf4Us+uzRGNmDknFSYrN7Ibu5mga16LacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUJ0icJSVSbeDpSXhYo20gCqF0L9/aCgCyMyAqjv/rE=;
 b=ZfTCxOMbNP2/eiMUM0tF0HdDgKrvkevRDbB1nNl2hUQV7Dk0VGnzTxt9JvDjTxSYCBSzUpdQB1byLDFMcdNLiY4s6AvM+SwRIg7LPpvd070GvSmjUSgs98IImA2VdU5eG2MSMDOqbuh3tl/k45ULtiGu3UAU0TC6J1cQsdWOn1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6382.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:44:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:44:44 +0000
Date: Wed, 25 Mar 2026 17:44:43 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v3 00/10] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
Message-ID: <zyt2fx46zvg5i6mfntaslyeyftuishvw6xy4keditk7ftvpvku@yva4ihwas6pg>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y>
 <acN_aZNICP15ybZZ@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acN_aZNICP15ybZZ@ryzen>
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c749240-fcc7-44de-032f-08de8a4ac38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k53dhrlOnIYOcABZmnkuvIDszz0XdoGvgeCGNY7yqHd26PYOcjwm9rLhZyzNY+aUKJDc12pRMdX9xKUvGq9KDBKElCVT0SfsXogDVIUlMr1YobVcvHBPIqS5++R7KxFP7M9KHKTBS5SQC0Krg5OJFPJFQIUKHC8J+G9nie8GgV8gG9BJM+8L4ZKgs59tnZE2sBTWLIx0bfyFW0SAse/2muvuN26cSlO0Y8H2Q6VMlm5hLz5MgXkIvdXK8QLJS0Ly7+2vZna6DQGVeF3s4TzI+UORrN0esRd8Il5j0fFsX7DCukJJKh0xlchxeYVo521SKj9PnbMI7z1GqHU392zmXz/EGdfvYtgsVent6WeWWF7ddrYyXeOg42UrLwvkM7Kwy4E7yuM2Nsj0JVDr06H3wSUdXl8gtCV+hTxtQj/8HdYnUVMlM7Nf8lWg4LsPKxrzg82jeWhnfWbsRB+S+4Wq/19bGPi290OW4fTSyCeOnd4CPXgcl3ZBOi3sG53of3Ym2daDdRRH8c7NpAOU4Uv2hjWM7xpD5zesXibSANzezqapp7rXQM1aMX4kHnbYShk59c7GX5YhZD8ywJgHto5LW6Mp8cIVDjDDc8qLQTD+t5UP/4p6s4sXRXQRQbAtUJ6+XEbUlPXagUZz1qXg+UukSlm7jMxaddMmsCaSHPDYBt1C/+gtU8lcP/W3PPj5NAi8DegOmDAXGvAm1D8GOEZ+zzAbicbe3ClxuOGb934/N1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTSrymr+TwoF7tpsPgOgpAcLW7+zvU9b6bnDoCOniX/J4MHvxv/NL2vi9xSb?=
 =?us-ascii?Q?RCgMFMwRVMQvray3MtS7tzaZ22MpH+7JPYm7Eb0Ik+Z0cFIfxls/6eujRILb?=
 =?us-ascii?Q?ko5YFWcwojXO8ldmkw59uObflazMx0wm6DcavaWAKlHKVUheWdiNBkvXFuO6?=
 =?us-ascii?Q?QEv4E8DCr3UChb50z9eHFvFDcYaPGcFsR1t3Mi7HjPr7wGkOJLL6sJElFECP?=
 =?us-ascii?Q?6IDHeRyOPgBM3MwS3WV1PzDF9cXjayeyuz/nWaqdfzNam0FyhGPtf/zDLq25?=
 =?us-ascii?Q?qj0ef8uvlgpmxwuqCpO2LKjwHqRlmbxMXuZquMmCCOTnGMlRCEXzRt8zIMgL?=
 =?us-ascii?Q?GnLcO35b4YS+yHHBcXr5wvviJDuxkEbx+eEjG2UlG8TbU44zyZ6j7JIsOSyb?=
 =?us-ascii?Q?x7Gb0QfUOgOQQrzoridlBfkFdle47BQP0DcOkzWGrOIIU/XxGJu0wr8OqfWS?=
 =?us-ascii?Q?epbfM2jcgr3sGEm8HfgsDU3tu/cJR6oHi+6ogb63XOnk230it5kV96GJiOyK?=
 =?us-ascii?Q?39xbFD93DiIby4V0+VssnG2copX+6fA12Tg7q2F/f04QrQP+SZOgJ58MvRyt?=
 =?us-ascii?Q?JIY0Lv7emlD0yJ98hp3/fXU+lY233FQoNgLgSt14616r9CwfQF57juK4k1Oo?=
 =?us-ascii?Q?X7FFtUw4lZt2EItP+7wfUqnFeaTzbU4BejxVdLxf3YBOrgEAnpaypaXE6an8?=
 =?us-ascii?Q?ujigc/pKDIkSDt548FyZP4OCEsvMKVQ+In3DGaNQE0CR3yx2g3YTYjTihwz3?=
 =?us-ascii?Q?R41xlDnClEf/UERCNcB0se77kgzhxSMK2xtBYlDvzziQdOBdmoYK8j8fee1s?=
 =?us-ascii?Q?+1RFhnRbQlA9DEIIyfQeKbQA5RI4IIxATa4OlXby5VyVbwa0xzqd2d40gUWT?=
 =?us-ascii?Q?TmV3wJ5i3wNSNv46zqYSN4dj1f+077t2e09CmRu3ZnV0BOFAPePw/8VDNkGL?=
 =?us-ascii?Q?Xd/4GKCJyUq3V901bcgiJyrQ/02dGHgJ5fMAx5/TW6GBt7j3nWfFTe626uTz?=
 =?us-ascii?Q?05fbjzvSSTJlMG6/zXBgLnUdDTSHx9PzMR4QhlubHeeCLR2ukpegvBBRjF84?=
 =?us-ascii?Q?OUhZCdJ+dT2+cgVNMGznzfXNo9LuJpLhJ5+cGdVTc23hhxbN3EcNhKszCgAM?=
 =?us-ascii?Q?B5h9/3ldaAdThyhbHW2CsmkKROUblZTXDrhAL4YgbSkUQGK8EqFMvoNXl8bZ?=
 =?us-ascii?Q?MOj5f06m/DQE5/3TWCn/cCEoep4QequWjwdv+aOB+af4GMuaUBM+naUI3W8n?=
 =?us-ascii?Q?SnJdbvTbsH7wQBwc3eWPgzxjC/StmiFIxqm/kvHN/hyPG24KaSs/b0VWhEjc?=
 =?us-ascii?Q?gKVMdhPItjmyex1NRfevbTXFepoY2zf2vhQ5LUNbnM1xC0GWw0EMrXkkSMD3?=
 =?us-ascii?Q?xo7gz7fxdkz8l1WlKbRpGXMW+IYHOzr5/OVhNVVyg4+TFbDsFqTA6h28IzLn?=
 =?us-ascii?Q?fkzySzWcsUFH1lPeM1oXnLsOc8Zo75DR0LhtX6fcefKaklcIB8VUYUQrDcnw?=
 =?us-ascii?Q?pHnaAlOyDSuERKPeFtLPOCUp3EVXDL5dXFWPGfnt+D8fQEDVv/lWiLcTukmh?=
 =?us-ascii?Q?mwFj3twUKcIkwXKTA07MQPxkvVffS0cFL72ekZL6Xc3+lr4t1aMz4quzk2Rj?=
 =?us-ascii?Q?GnkTLGGAJvuQvDpmZcPstI5jdGGU7UQt9k3J40Qgj9m4w1+j2iB96BkP+wf0?=
 =?us-ascii?Q?t5GrMnb2Ck4C7A+jkMdToEC4NZetvhsHbwNs//Xu4PezopPOucngnrilwcgE?=
 =?us-ascii?Q?ChGpkkijZXUgAztLG3mvbPk/cpWuJg6eNkfzCT6P787xYAvtAiu3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c749240-fcc7-44de-032f-08de8a4ac38a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:44:44.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHaincK4g12G1E3gOWyPGHnShGz52UszEF3D45Tb9HuCeraml9pXWFxjruC3DLaxfZndEAmVdM5lI1+ZUWTYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6382

On Wed, Mar 25, 2026 at 07:23:37AM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Tue, Mar 24, 2026 at 12:43:53AM +0900, Koichiro Den wrote:
> > 
> > - configfs knobs mutability and bounds checking, including (but not limited to)
> >   db_count.
> >   In my opinion, allowing updates after .bind() looks questionable, and
> >   returning -EBUSY once bound seems more appropriate. I'm leaning toward
> >   handling this as a separate hardening series.
> 
> This is in line with what we did for pci-epf-test, see commit:
> ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes")
> 
> but we return EOPNOTSUPP instead of EBUSY.

Yes, I remember you were discussing this with Mani in another thread. For
consistency, we should use -EOPNOTSUPP here as well. Thanks for the reminder.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
