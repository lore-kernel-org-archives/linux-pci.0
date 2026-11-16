Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835270;
	b=gu9y0McCWhlAaTT5yz8Y1WP3fN8T2lPEkVtKy97eK7IXbDfqmtyzqzjjpTnkRtBqIKo9
	 k4U55hpMz9MGsRbH9IK3elWqRV+OcvSpSKZRvXw7Uq4aJtX0x9smlxS3rn56oDJzYfZob
	 I6ven+D1LZnnM99fs42BcI1hNYA9OStQaiSrhHkjIU0q7H+32odkHa7CeCBE782FpIhSp
	 NEwZVnwmdPCwKkrG4GtjetqcMmQ5RmoNHE9NOYtWMYafNdPzTuiqKqbjdMu/LZzUmk1Jw
	 5WSzr9l9rUbariy5rORxzubosGQUFNc7bHm8JzOOU9f/e9M9/akU0Vfuz97mOa1P4Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835270;
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
	bh=TKtg+hCnmq42BF25g6dM2aS/tTun9Y1xgbOmY9LH+mE=;
	b=GT/SPxdIVp9yoBmXKS940VDDgK2ICzFxSlHX13lAX1t441V78oOLsLX7QVcNC2wRu7Jm
	 yq7Mk91DIFolvSCXQS3LRCbqLmn+NPAesZ+pmB6hSW0kMYRlWgfZVHTOlALdRpiOM4KOu
	 aURlD2PDdJwzcWq6MuJyh93ny16NqJ5xVCbGQwZD/Sk38ifTWHGCYTCN77QKmWUeicQaP
	 4E8eMgAJoQapK86qpA1/KcV8TvhotYxvHTbHx87eqUaHUdfKhUaQOOUBTwLJcEd9opcQp
	 rjFDSghxYVoHoLUGe5kfwOELN218VsNd5MP7q98x/C233ZCAu2CN1n+U95ixj4NcoxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="RBPETet/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.9
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC8606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RBPETet/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj4by8s8H0LYer5hbLAKnYH2WzaNOwfDdX2vqI3zj4IECT2JFhvr25uwXq8bLK+LsLNssPjjvROdN9ZjYiodL1g+GJ/Y2qHkvWuNVwNzOOiFn6kD5t6uwgJwKYD5cUs1o0UAzmnMn1x4+evVHs9ef0w+6ddfymT7gwuRd+9T383WXdXQf3aCuKOR1RLOVilSKTMF1RsoveAlKZXq1o+j2YH72eaBzDHxHsHbOCUpWk5jcUnlt9FPn8+IyT7FVQiz7L2vHPydgAESG7PtcmsAu7VgboV5y4jkLbjlwDb6uYWb7MRKxNqtTMmVF91KzXaJGTI+9e/QegEDhB57k3cEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKtg+hCnmq42BF25g6dM2aS/tTun9Y1xgbOmY9LH+mE=;
 b=ymWgQKcLk7Y8FiLphfO1jyAou81oflBUz3HlUDB47YXOMZSiZCOTfMPdhMGyJCFFnDURfOSEAC1azR95yqvC7XfW8dgyi8FR8hUSqK69agVwJeSM7dpA6/zoy7G9DYuoDSmyuQeP8tsRs/AYkVIsQayUXUrgeb7c+v5y1Pdj+nnmyD5wkz4uGarFfpq2RdB1Ni2atxMiQEu7+5oQf9mtOWxB9GrFP2XscxVoOKc+Idy67xWa35vrI4z9P/6lHt+HhoTuWzieGRnt4Fqt+bKhJ3ISKoU78L21rx23ayf0Erq+fKnRxp3RdE5IenHthBu+zyd/FFHcNabJTB1ydwe+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKtg+hCnmq42BF25g6dM2aS/tTun9Y1xgbOmY9LH+mE=;
 b=RBPETet/iqI0Jo5r2R1pUw7WxTscr9lNiAqcDk1mErWmmDSgxzzfNj8SfmKH7vcQDqTRnbhtgKXrj/lf7oHEH3bGZyDFcvpkVSDtgqaQ5qUm1CgpBerxnko48cK287ZifAjdkSf1S06gVSZAsasOBvF17X1pTjsIYQKzZQ6bGLQr/WfbViMjRjlgWKxfxi2OXAdqSzjsRObg5gPonyTUliY4Wmmo63c1+KTtE4DK7aRhwYlSK/bB3Za1Wz8l6dmsxTXwf4j6KEneRuNvdsc5G1+CktxSRRRTJEwUhXQWJ5fhbPXXwxxpUXKkLBapN99VMD9p8x6jMgQrLhBM5vp9kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:20:00 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:20:00 +0000
Date: Mon, 16 Nov 2026 09:19:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
Message-ID: <20261116131959.GD1850935@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com>
 <yq5ajymcyl2g.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ajymcyl2g.fsf@kernel.org>
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 494ed551-41f5-4012-f96c-08df43e45130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|5023799004|56012099006|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UswNyO0TWrhVVSZrXRyldPZ8MHgqicGHifVwzQfSSSNQysDyK3Hek5U+lKWIQy8H59DuY3JLWdWmfpeZmn+qJOGVq0mJEfU2fyMzObHhP+JnzbenbWoP3v7PBiEY13vlmKyjTHVBfN1zSVUj0ymmrMFnpGGrJUuYTLYzk4IJjasmCOwvOVGifFb6nwCo+NCO4imtzPaphG4xoEkf7zQgTEmHkVtXNM7riDrAQXmidtzmHIEEU3I+EDVQyxK45WYzPAhCXzgM5l2P/ym6E/+dcR7B7NLKFXC+X3grUNnwrbQ5N/QwSDow7G0N9FpPaKP6iCfs1cAtWQillJHGZwUlk63AXMjzkVI+SkocNKKpUWPLlPNbttQ9weggFMotvtPJSqbAF5xg1j31q5yzs/tNBw8Hto+YyKUy6u1OE3fcuAoycRMMgbJQrbmy8bJ44Yn7xvPJdBQUKhQ8AmmIun4mTLgagyN8OT8hHZV7xMYnHT+pdiOsERun/eHUTxba1mLL579wu7jvxBy4npi8kCYpo4YUWxYnXNaD8oQ1b14YdIQ66gMK7gR55AMWL9LKIWiNi3fKtrttqb0KyeadrUriksYPKxBhi+DJLB74skxPWUQrm/LrSXHwOalFjYPpg8GNJnQJKubzPSrx8MKAUIGjCIut73xXAeOgXBJF6dT3XG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PXq/Csg+DfDW0JS98mBPj4ssZWE92s70pNwiWaDuToXJ7bagEkZuRLzb/D2?=
 =?us-ascii?Q?1P+MPv5xFB5Z7IwmW5uCWzNW+gqVF7L4r8gJY+WwwqS8vhxmMMuBy3jhF9rc?=
 =?us-ascii?Q?B9ase4NUoN+z6AJg6S9WLE033peg7qnKbVRAWdwVwmxLCHu8W/gzUGhWNxxt?=
 =?us-ascii?Q?KSwpqgz053ehex58zh5UXqt7EYcqEhvOZbEkfPLyw/i4GObHo2QTNDFaQ8V4?=
 =?us-ascii?Q?Z61PP0PV2VFNRCXQs05ll+OXsnu9oL1Hks4xyIW9ZhPlj9TwU9RMDDOMKJ7T?=
 =?us-ascii?Q?72bAgy6dUZGQTcI6glNFSg7EV+OZfPfUn5+EQm09lElokcn0KvidGnJW7scH?=
 =?us-ascii?Q?DDNYJKRvyHWhPYpeJhcLQMfeOMrdW7nqPxm/BNQdvhvvG6S9IYGzOqfMYVMn?=
 =?us-ascii?Q?ZCQSueuZu3ryDFPOU7/2FUMW9pnU/KJPHt2XYpE/fw2UaY3ZXRG8CO9/6vF1?=
 =?us-ascii?Q?aeZ9P7ag7st1b9qiHy1Em0zS0Sgr7PDGENNHN0zQNkD1O4SNM6JMws8/N3++?=
 =?us-ascii?Q?i3UE+DPwEJrRrkPRfRN/hxd126I4NkWoMEotsZuAxgPwY7tGtj3HuVli3a8e?=
 =?us-ascii?Q?HyMYzX+Tk1Mh3qzgYRkcYkkvE84FywOOrf03mbVmjuKfHr4PlKwE42fxF3ul?=
 =?us-ascii?Q?K/bDvDauQZrU2hEvctNxfAfrQ5DoS0Nz4gdlLuFdj+UfP5Cpwr3OKd19kwUc?=
 =?us-ascii?Q?sSGdBR5qLfDZxj+gDkyPFGCGxbNY9CKOxwwH0x3v9/p88S9z7pwNAybW3BEn?=
 =?us-ascii?Q?GyLKyfcBpWSLD8UVxf8kF3ZLxdmIDjUSDXuuaHXFIiYI7ydk5L0GnEuhMulM?=
 =?us-ascii?Q?qw4Drt7GI5M3uzlNH/59k21Ok3UNlQi7Tb0rzfooMc1GuafujWLbttdA4s9u?=
 =?us-ascii?Q?Kn8uX5haDTDzR9uSMNB291syUSPqc5MQnCmzVb+YKH7nIdDm8giJ5unqoHd9?=
 =?us-ascii?Q?thAw18y/2FviKKS5+Ux0AMAREb9WtHiRsh+TQr33iD1cZKL49Xs+z4bdWglf?=
 =?us-ascii?Q?TC3UPMsKazPt8DskA3oplByna/GXSQqx2gcs5aGMgJbDj/KGDJOolqqkV8Ki?=
 =?us-ascii?Q?JOuGADaD+NoL5f61bdR9T1gJQRUn/qJH3a/PfZLIPvj4lcaiVjbgv455CmIG?=
 =?us-ascii?Q?0HE99X+cYj8HpoG1zqCrhyN8SeB7+XAN+xrH2BdfTSM5UqL10RlbVkeclA7p?=
 =?us-ascii?Q?tIz0x9GQZmUiMBlsJZKtFLaNSIHxylZfNBGX99UjwSdFxU2mD1lD14cD1ecu?=
 =?us-ascii?Q?O0BHs/G0ehErJwjJN7Bcmj9S0FW8KAERphtVVvkjIK1qr8apmMOfxIVoJu7p?=
 =?us-ascii?Q?xiwhu+3YF8BI55Ki5vSdVc1vKjVhAoSqUlZ+XD4q+0Kqa9HxGk97jN29BxGl?=
 =?us-ascii?Q?HKWAUoUSe7+mzQCpZeM+4rOyypKwvL1FvzHDXFRxs0FioWxQ8FIDI/sFTEIK?=
 =?us-ascii?Q?3zm9mOQSyYj8OPNQPwKDoXmi4qMtRDxZKjIinu2TcuhDKGpu3VuxpJ760Moc?=
 =?us-ascii?Q?6wBrKbX8YbSvlmUf1m0SP+U86xuA5Q208Iyi+Guz1XC50dehcWXcjP5jpk6x?=
 =?us-ascii?Q?1bN1ciFGyWh0NuRtAbvVHizeCHJ+x96vJEN97asF/pWE9xiwZpNBakAr3+Sc?=
 =?us-ascii?Q?MvzItLQnuh5VJwqVIQhEcfAvS4DsVcD3MPW13EhvFsgcQ2nzxLJZgBsl9IGE?=
 =?us-ascii?Q?gGmYw/s+Qh4BhuCZox7rYFfAAL6F7vBOxP4/GLgJaR8H/SDP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ed551-41f5-4012-f96c-08df43e45130
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:20:00.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1DK6F8IIbjP3UTB0P+UU/T1JfG2EqeiOjlQfydBctTIHq7uKnkHS3l5BdvO7Mom
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

On Mon, Nov 16, 2026 at 06:45:03PM +0530, Aneesh Kumar K.V wrote:

> The complete CCA patch series adds the following files:
> 
> attestation.c  core.c  ctlv_attestation_pci_gen.c  ctlv_attestation_pci_gen.h  internal.h  Makefile  spdm.c

Why would any of this go under drivers/pci ?

The whole point here is to make an 'attestation subsystem', so that
all belongs under

  drivers/attestation/ 

Send a series to move tsm-report.c and tsm-mr.c to drivers/attestation
to kick it off.

Then we can extract the AMD and Intel drivers

Jason
