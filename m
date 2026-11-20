Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162196;
	b=sdVDqGH/CXqG4+6Vn6Wxe2o/zh7Ya/by1ekvtS92yLgwk92jqp1L+WZp1UpFUe2uu0SD
	 WlirUuRGPOIYDRj03UEIwUh8WpwRcW9SduI09JYMJ6LYPLeACLei2zfzUkBDf7H2S6Fr4
	 +40MNSirR7TQTTAEJimrsy6OIByuk1wmJm0TGA+lcaKrJ+jysp52atZlYAR1HQCx5y9Cp
	 QGZLwdYdWRuSUPOFIg+3TWpPXwGUIcNeVdvU+i3uYW169V2xFRfRu3GOpG+VR7Y4te1Uh
	 GPSNFRoofOX+3C5vHvSSZlE6pggBFEu0VCirQ7zPtc9OWOuzZUfst9bA1JA1GJnNEKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162196;
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
	bh=B6BYinZGhW1J79Nev4h2YZg8EUT/FLG/1BQvDe4/usM=;
	b=Uv6VOxA7bDg1lBQXjp6Jv2KniICGeNAnirgBmsgveblUgrvZ0+zi+bQd1BB1eLns4JCo
	 p8iPjdgFcVWTGVb+YrGAHP6fQeOWKAfpoVv8Ga8XM9B8vpWEFr3gcrqT4ZkScSdgtjLBw
	 ChkBFyonHRrzmnDc7Uy72rzsqglnTMuQ+GqL17YrNWt0XzaIMUSd6eQJiAjOaUcoVnW72
	 XLcANS4z5qN/PidHBh38Sqblr6nFAqRtyHJcxZCEb7fDLXwH5Cf9rTfPG3WgsEKowgGNr
	 Ln6YKrZsIDLfqiaBl8ZCLAYzF74ZjG6Mgf2eizmzzQIKws08Hmr4nXeNtuS2xA5IeXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oylJsAKa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.7
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE3606A320;
	Fri, 20 Nov 2026 08:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97FE3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oylJsAKa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qum9kb3E1l9jXtqhe2UF98g1s64HFwjUIz7NRVsMbK3a64lkcp1nPzwghAPG0R5sthRTuroLmw3k9BWr8fTF06IILxzhYkLXYsdJNHayYJNnPpPFtBN0L4o6uIO43Jyd1+5STvAbkzqSqe8J7Hba6fJ1HkQdXNLDzT1lnUIVnRlIhlz3cZq25O4h8kjnsnaC29aRGa3sj65Os7zWhIXXqtyILKix7FS0vsTKUbTYqJ6owqQ/oBMTkDofVEUvqPvWMULRbYvYujbSpm2/vzo8PqsUiIgza3et/Y//V12UYQV+1gFv8tI7j9+E+iqEXHHhryRzO4OOnS5MsmjDD/gwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6BYinZGhW1J79Nev4h2YZg8EUT/FLG/1BQvDe4/usM=;
 b=tvSTaNSgSL1CUVC/tI7fDTT6XHDHM0EDuexgCb2ssivUbT8icmj/Wblzve/gWykhdn9tpan2XEeOwFsUwBu8E0QfbAFWWrtQXOUaW0ncS9Zt69KKh913KaYpbPIUtVSZvTrZ/5WsBod4UnQovqzxpo+XrZpgkYvRLXwEUJFRYg5cRPwqkF7a/SYQayPu2jO99BWY4SzR3iqEhJXdxvB0o6qZzXN0hG87vCevUqgpusNerpAX7Wpg2bElgl+lXTM/ypioshZ2WAlPMIaM9mAyH/kIq/VoeRMbQssVrphvuSYn0OzLe7+vcBvUm4sycXzbql20Zb7wfTKwzpJbQgWCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6BYinZGhW1J79Nev4h2YZg8EUT/FLG/1BQvDe4/usM=;
 b=oylJsAKaAxbPB1LwD4+2h5VfUP0Q/oZsb27j7rxwXoWGCcv2w6CG7KUIX4EnVM4xlaZmnxEhuhvx9CypQGeIo7iJUr8v8+YjXJ/U6BopGuQdQ+iu/adYeIUicRfq6S1D9t+KBIa+9+gg/PbF4LOYLbqW88T7IwEYBSsYXzY7SrMYNu0xTw6h5TJaJDqxheq7h+OBxGpsmDq7LIT0OS1LStAAUwVIEwzEao/DSyekIEVcFPMRV4rntutOr0EFhMGIo4BrYXWIo3px9nhbZu6YH1qfY0YQS2UPHyTg2Sfg/7zHAi1OpcWbajZEUxiaUwR/2zne1MAGKk7fr1P+BAo6Kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 08:09:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Fri, 20 Nov 2026
 08:09:20 +0000
Date: Fri, 20 Nov 2026 16:09:13 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, helgaas@google.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, tglx@kernel.org, wangruikang@iscas.ac.cn, alifm@linux.ibm.com, 
	shawn.lin@rock-chips.com, lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com, 
	xiangzao@linux.alibaba.com, vidyas@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	newtonl@nvidia.com, kristinc@nvidia.com
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Message-ID: <av_8-NLyjXUQC0lK@MWDK4CY14F>
References: <20261116065229.38194-2-icheng@nvidia.com>
 <20261116190939.GA197209@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116190939.GA197209@bhelgaas>
X-ClientProxiedBy: SI3PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f18865-4954-439e-f6dd-08df46dd9420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|11063799006|261009223027099003|261021123027099003|261102130727099003|10067099003|261021121427099003|261102123227099003|261022105027099003|56012099006|261028144727099003|261022075727099003|261022113327099003|261026140227099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vVs0HncfR0Pv5DLsLef6fkEUMoP4ZheKnNCzcpdAV+xoKec74oRaU4uKwufeqZxCwTwCHaL4SIad1AXsNvbF6BeFMgFXvyUumBiX8Wj6tJLhuMH0CQPNDmAv5VI6QcMbr8p0053uzxUJfZ9PMynL/yGglZi/dSFV/1qenRLbxMkEVYKDi2K9UUtGXFdbiD0K4HdS76819Pz5QjJ6YiRYn5bfrDpjIc+xH1SDGE8b9aOv+tXpH3phiO6V9OmhicE0VB9tbWPDrDIsR5wD7VtAh+1UU3heCkp5EosK3f6cz8DbBjA2AMXS+gk8NpFyQ4i/32UHnWlYY2B64GUlYrbK8BrVrQFjVWmlzHvhq6TES5sLqP1OYSZQA6T6MIqkbZFElpJ7uGQ7gIbwrL7+umPHxE+FV3axHath1c6jCj32jo0nemWwo5sn5+fRgWsqz2bimastWwOcZBA5gSS72Euey3nG2Z3VwWhFsdukcoI1wqpeSoACwuKFMTjHJHz3TmwPLS2iUaccTD7amCMFSXESAR152bIJjvbVxmr5aHw5zpBLq7YTZUGYM7RdOrtaxfQql1+vsGuUDaOHWub8gxFiK4BMREy3hoYK4zmN+oSCe5vKtLVCUKC9+ZJsYsm9Jn1Zg4PltkkvvQV+1nVXVYbKESAfX6wDFeKZ25NByK89Qys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261102130727099003)(10067099003)(261021121427099003)(261102123227099003)(261022105027099003)(56012099006)(261028144727099003)(261022075727099003)(261022113327099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0pYCYTMJOWFbYQF/sBQ5KAEij0m74TIk50Khaer4JgKVrFIf+ZhkRL9J1Bv/?=
 =?us-ascii?Q?A8FROm76RrEJdNWuKV4/GSr1lEkjx7IwWxd6GGyMO3CRHP0w/O4O2RtDo8ln?=
 =?us-ascii?Q?81FLCAOljLp5Y3qu1AlXE29kSYqej6diHlGTVpwCA3QPP8Y9b/crlX2I8Tay?=
 =?us-ascii?Q?hx1W1rVMXNpXlorjB4S/SGa7gBFaXMP3VS7JNFFtdsKaaJ6RKYPUrTVjzP92?=
 =?us-ascii?Q?bnB6m1S82WSB1RJLNiJVfTrqXQxilgE+BxniFUQ3U2vPoOAzejSCc703aRER?=
 =?us-ascii?Q?XKER4M+K27j5nhHI3O7z96yZwJkqQ/2uXQQsavs3h5gD3wpPbAW0vSK3YPXY?=
 =?us-ascii?Q?ibeJ6+EyHdZD3iaxAsmiJuL3Has3JL8mPiZH3BUJTq8mKUCVZPkkjXPUic1f?=
 =?us-ascii?Q?4bHDYOrOlLmST1CDfYq9x/9OJOzmy/Ze/liYEQVz60UkfELHcrlBa6WEqBRA?=
 =?us-ascii?Q?gGzGLdME1qSCTrAy4tbBX+oxlPqKoOONXS4LV9lbqQ77XN+vjGsO30B2sotG?=
 =?us-ascii?Q?Zo+Ji4OUT9ywFPEKfkjiJVzR4vIxyc/FJT1pUtPS8P1nE9OPBVu2ugBYXafI?=
 =?us-ascii?Q?7wdAzUbRZPnYezJZ+CBXneQvGWong3wGW7mlt+wfnnJU7cTm08ZE/KKA/KGZ?=
 =?us-ascii?Q?xNJblWg6L8ysgATIsM2aanoDc9GVdPw9TQtor7Fys4TJCqQxFRjI5v2/yuU1?=
 =?us-ascii?Q?yVI2fIpFsZq+D+zoOxCi0htxF0i3+HrT6dJD17zIxswk36vgz2A55WUUBEBg?=
 =?us-ascii?Q?35bmFi4Mkv/bCnhcDPZsw/7uKYvhBdXg0N9ODHftBPyevYNoYTd+ngSmsxHd?=
 =?us-ascii?Q?+jqm4qXx4SvgYYVhUxzRiiygmOgzPV+frtnsvXYNbhTg3g36RYwVAtVad2BI?=
 =?us-ascii?Q?ApQdSL/qDB7DffR0w48DxWnnlNq+uWqZ4fJ5wiLxewriabzASO4IpFixdBBv?=
 =?us-ascii?Q?6+BnbXSX53/8E27dU8WCKJyfLChG/tWkWg6fN7POSKJxeyvBRQSdHYe3O9m5?=
 =?us-ascii?Q?vEQUgtH78FGm7Eq0AxGRriSbfmQCPB0qt+8AjLc5xzdN/jB4t/h4PwiTh1CX?=
 =?us-ascii?Q?k+nn+78bIh4Ly4HXh8O77+pLR+mvUXPQrAO79TGLCuHZXxo3C+GSg+/KHmdE?=
 =?us-ascii?Q?YOZOZOO8esTHFmoBvNHDWZ25FJ04bf/MlKh9SUG6Uo6FloF7ju7dw7Hw9A+w?=
 =?us-ascii?Q?mvB3Q86L7+tr9HQdTYkuuQhTDXLZnF5cBnKp/Q7bNZxbzoHoFVBnQbRQ4SYF?=
 =?us-ascii?Q?ruO9tRy92NahHE33FIFoEqCqecPsaQ8S67JdSdd9T4n4wCbjwCDST/eDBj+p?=
 =?us-ascii?Q?eaaDJHRT3q4EnAW9BNv56WhcZAqWH18wdugAHlQJFzMrdgzDDyvMn6NYSS+a?=
 =?us-ascii?Q?j1UiS2H7XoimAW5bCPXGKgEBnTVLeo41HeN8jTDO21Spcm7I5LU85+VCnbCq?=
 =?us-ascii?Q?XgH9EeSR7Y0IGjOxyy3mc4n4TyIiAT6r2Oi/qdt3QC9IqwsU3lqO4CTSMa40?=
 =?us-ascii?Q?WjT5U1DXaEq5sK3fXR4C7BTMIyIaefAW6eCtGT3DKeD6o2kL0ed3GGvOYv3f?=
 =?us-ascii?Q?jijczfaDvwsxuZvB1izMYJRG3WXP8o4ufS+G0Vo65831dw9H6Xt3J/vg8QNl?=
 =?us-ascii?Q?uhqDLLfAQ6gAwNWv8b4dAhY+Cuq3EUrvWDtKKfB1+ghGq6u5sT6K5oGsX6Le?=
 =?us-ascii?Q?DGc1U0EUBRqBRdgJTIiL9X1fXd8s4/exPDwC4hsPFT/B8acTrGkYbprxbf1r?=
 =?us-ascii?Q?kdcJjSKxUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f18865-4954-439e-f6dd-08df46dd9420
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:09:20.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKD3YsxE9cehFCQ1J492vbRmJhTEyUqP2ubBW86u6tgKwHtFevQkqKyQpPLfh+hDXyzwTut5xubr+KCzX755EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

On Mon, Nov 16, 2026 at 01:09:39PM +0800, Bjorn Helgaas wrote:
> On Mon, Nov 16, 2026 at 02:52:28PM +0800, Richard Cheng wrote:
> > PCI state restoration runs even when a reset fails. If the device's
> > config space remains inaccessible, MSI-X restoration still writes the
> > MSI-X table. The table lives in device memory space, and these MMIO
> > accesses can trigger additional errors, including DPC.
> > 
> > MSI is programmed entirely through config space, so it doesn't issue
> > such MMIO accesses. Restoring it is still pointless when config space is
> > inaccessible: reads return all ones and the restore path writes back
> > values derived from them.
> > 
> > Check whether config space of pci device is accessible or not at the
> > start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> > and before any config access, and skip the restoration if the device is
> > inaccessible.
> 
> If these are two paragraphs, they need a blank line between.  If a
> single paragraph, rewrap to show that.
>

Hi Bjorn,

Thanks for the review and feedback !

I'll add a blank linke before "Make the helper non-static" in v4.
 

> > Make the helper non-static and declare it in pci.h so the MSI code can
> > use it, too.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v2 -> v3:
> > - Cover MSI restoration path as well (Farhan)
> > - Use pci_dev_config_accessible() instead of open-coding the check, and
> >   make it non-static (Farhan)
> > - Move the check before any config space access in the restore
> >   functions (Farhan)
> > - The return value of the PCI Command read is no longer checked, since
> >   the helper only tests for an all-ones value.
> > - Update the subject and commit message accordingly
> > ---
> >  drivers/pci/msi/msi.c | 6 ++++++
> >  drivers/pci/pci.c     | 2 +-
> >  drivers/pci/pci.h     | 1 +
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 8a0133a6a286..2865f73f5ead 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
> >  	if (!dev->msi_enabled)
> >  		return;
> >  
> > +	if (!pci_dev_config_accessible(dev, "restore MSI state"))
> > +		return;
> 
> Sigh.  I hate the fact that pci_dev_config_accessible() is
> proliferating even though it's obviously racy.  Maybe it's the best we
> can do, but I just feel like we're digging this hole deeper.
>

Hmm I agree this is racy even though we're holding the device lock
throughout the reset/restore process.

I assume you mean something like a separate sources DPC happened and
make the device inaccessible , some scenario like that ?

 
> Also, this is called in the pci_restore_state() path, which is full of
> other things that also write to config space and will also fail in
> this situation.
> 

Actually I was trying to cover the whole pci_restore_state() in v1 [1],
and Benjamin raise the concern about the drivers may depen on PCI state
having been restored by the time reset_done() runs.

What my bug actually hit was MSI-X table write triggered DPC, I can't
justify for all kinds of driver, so I limited the scope.

If you think a broader check in pci_dev_restore() is a better place to
handle this, I'm happy to give a deeper research and revisit it.

Best regards,
Richard Cheng.

[1]: https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/

> >  	entry = irq_get_msi_desc(dev->irq);
> >  
> >  	pci_intx_for_msi(dev, 0);
> > @@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> >  	if (!dev->msix_enabled)
> >  		return;
> >  
> > +	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
> > +		return;
> > +
> >  	/* route the table */
> >  	pci_intx_for_msi(dev, 0);
> >  	pci_msix_clear_and_set_ctrl(dev, 0,
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7c6f2aba8144..671ffe4da1c8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> >  
> > -static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> >  {
> >  	u32 val;
> >  
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 77efa4c5c960..98dd3dbd5edb 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -240,6 +240,7 @@ enum pci_mmap_api {
> >  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
> >  		  enum pci_mmap_api mmap_api);
> >  
> > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
> >  bool pci_reset_supported(struct pci_dev *dev);
> >  void pci_init_reset_methods(struct pci_dev *dev);
> >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > -- 
> > 2.43.0
> > 
> 
