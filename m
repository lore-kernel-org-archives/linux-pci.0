Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794840180;
	b=tjh57e/rcpP7GqYUVQbqqBobEAuawZNVR/w72OyPWQkcRCmz7uAiVfQayWwkkdJNBhKq
	 DTOZrQ+32Nbfv4PaKkf6vBirQ0Ruvg7XgYjNGeP4k8tupmRSq5ZgGMwiRnGwdYAqkNZTn
	 B6il5pNTYz98GRMv26tJs4J0QPdEWCkeR6env8nfx46tqdXe4JWxbA1WNgSBJLj5XlGpW
	 rAipMUwm1uCInPP3vGEU7R5RWK+gCnOL3nlyCL70qwvdrXAgYXPDsq6MapQJDr0i1yKDQ
	 QvJ72Bliqv2l7yOeBG8apbtQLCMFdlcaFBtvxz5pHKOP3fDmTH0A3hJtmvMx5mI6u8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840180;
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
	bh=UC4HvoB6E1sAsaBh6JYCbIN94flVwAZVvBiUCRs+hZA=;
	b=UnXIGn/RXnAgnBQx++ChPOyWOOPcT3OfUxkvYgo9J+YI95ON4l6Aj9RPQ/ylIK+0OVOE
	 MyuhlUJAiwzwwYMyX5FfWfirGHfghvyObpxFqHoRytAl6/gyFufldVwpVDcrZpmgHZxWX
	 2XtjNe2hvQjJNSQwkWoLUPzarw6CeXy7MY5aVd6wmdIfrxTwOYiafkzfEI+xYHTMy711j
	 20yUVeRa74zfwpF86o6OQreDmAnmeEhVgJM5/tH8m1oBLZjUDGBguDoaW8crPK3iLdrdY
	 0d+McgCfwaxOti5lfs/T0rui/5cVkWQdARtaoVq2G/VBJal9ye0r/4GpVqdrG0mHAkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQhrcYPp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.24
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23A606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 14:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF23A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZQhrcYPp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDJwEKfIaenKsHWMWdSOsoJ6p+oB/MdZjTOprbR2cTE2fFFqVm9SD5tQ12YJEp3fdzirbtQOoMmqO+TNC2caWB7FQn8Dk0EVQsruYFgYdJu9BFOaY45LVnU09MkIKheluvVkFUgLJoXmyI66STBrBPzEM6OBnZgmkgJylTbdPz/BZbFVZOPjPaqmgnkWjmSQBq6BmNT5AxbJbBAzkfeeG835MnZtcu4qUAiD1XGw+dPYJ3Xy+EWRTgqExCkaSOsvwGLZrZ00A+/mX1NSGMPuIxrL4vCDv85hMI/gs1MnhTgAR9tBODd3cFTE0Bbj6fiLQNWpbmAi9R4G+rXmF6QFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC4HvoB6E1sAsaBh6JYCbIN94flVwAZVvBiUCRs+hZA=;
 b=pZYZOxWEDLF88/vDaMqukOqRyaOqGNeqqNveFzi9uM24Ae+4pgy2drAivh1HDgDM3Gi1dLFD3K3sTI5H9hadXqv1pmUz2DSHm8n7Pax7gYr3degd9dWyHsPevnE2/p5wisB9RunkAMaBfigshfcwpSPX94Jh2GWVl9jyslghz115uC8iC9bV8vY6pUEqmXEntZ8FX9p6iq47346tix9g7ehk+cvxHVXvbuguZzlMVUHbDNuEiv1vy/JVpxzQt8c+BcmkNvanHnP0XihFtVTdKCTzmsCl6D/5T1iA2NIX8q1u2ox8vqif4SiCqElWk5AsM4NKHwsN2JXkzisy1tA5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC4HvoB6E1sAsaBh6JYCbIN94flVwAZVvBiUCRs+hZA=;
 b=ZQhrcYPpOai60EljU3Hzez8c2rKt8Egt8coAx2tOb1XrGqL/6Mkcln3ML8qj3Yg8ft4mGdyiMVwyJAkt1oaGwARlCMNAqNRf72QyohQPpvkywGs3ZqvZCsSytlr6RAoa4CiTXwYCu/p/o+FHk36qDXtCdlqwr3TnPSrgP/D/2c475vVZuMfZfUtNxY+VS6K8Vhl8SBiLKDgMqWuNwMDEgxTnkClQ+47KNMwKQUhljCMs3bcfUkrzVCHYSJCc99mNXV9hzf0e0iI4p5CVb3usySBaHezsG3AfeopNukHhnyPs7BGRSMCYQVcYSi2hCcYqi8iy0KopUmEeewgg/xSAEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:42:43 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:42:38 +0000
Date: Mon, 16 Nov 2026 10:42:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
Message-ID: <20261116144237.GB2245175@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com>
 <yq5ajymcyl2g.fsf@kernel.org>
 <20261116131959.GD1850935@nvidia.com>
 <yq5aecckyhdn.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aecckyhdn.fsf@kernel.org>
X-ClientProxiedBy: MN2PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:208:23c::32) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d351f33-0108-4cf6-3cce-08df43efdc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	83SHmCCzS7crE9UEDcOxd1X9rk4E317Afl710kN4qEVO/bJY4IDQx30uWLzYpUv9sg3TA5CrY7yQHfyaskBUuDDAhvRuPiZ8WSPNCTeTqJGYKG8B3XYwUzY0WSum7EZfIRxbvDhyq4qvt1EwG4i+SjrsdxyEMC9zOOuhRF5nP5Cqf+f15kdJoDBZJW3DFbqVNgVBDJ2Hh0f982AWijUQ3uDU143HaWB7rRFrX4Uuy6KlabgXB0nyvmB2p9LMXF+bW9T8ca/2ScB3u5cH7eS0sqaqvNXoXCof3Irj/v2MGkecBZONo2cfeQAcWykDqDjIxciFZKLpVWNKzv1gzG8tiD6Wpq1Sp+B/NtEhlcNIynI5ajG0sC/bPxlOnvMT8ADhXFaHX7nHq4zMi9KHq0hGWcY6D5wrkEhJd/nIxG7uGRxBLKlXRXyQsPwEKItqRffM6Yzxrwjv/ohtjeOcCBaffaOh9APSUFtXwKIQXAFkVmpsSObasPwVKw3ss1DDwJo+hEckaEGttTiPIbl4Nf/QQAW1zJlgpE3GElSHqoUL95c9kI8GcCx6sIwatqcF9ga/bGJ+fN3xyqIb9mb8M+sncyL+r93LRNrgFyonWRN0pWNDWkJS8YdwABlo8q9xSuFcufLUelz+/R0q6gKdYyrdjpphUN9oGxoDTJKNn0Wcjo0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duexpX/gTdwqaDG3A9VBQ5NlVAnAUKxot5gxAlnDmUWAwG3t1caFZrW2Ejk2?=
 =?us-ascii?Q?3Ee7K8rZUA2f9E2QURnCSDtxMxVfchJzFeDGPxDP5E6cAJCTZ5FEZNr8FtFm?=
 =?us-ascii?Q?rPl08sZuU7Cz9ys6m3jSs5+rZhl+0IdBNv/QBpEfdwmIa4xR0SUvBeOvcQ20?=
 =?us-ascii?Q?lvHR0WT6ijr24NreRwRgoGMHNFtCY5BvHdCT3BpjKAF3iRvzmmfuT5d+/m2Q?=
 =?us-ascii?Q?zO4ryakcI0RsuQGUVDFEt842Sw3zvmm696eui7xmk1cQL8Q0PMN9fFsf2MEV?=
 =?us-ascii?Q?TPRgrlaVwTtdakLm29y1uo+ilMmWOX20tviOL+IZpIN/iFob1x3+zlSpyDy0?=
 =?us-ascii?Q?CN7tg61IKubR9j4cfOhe29RWi8ePiHAPNGeqFPph/c1KVZjgMmPek03KJW47?=
 =?us-ascii?Q?SrDdIpg1E7EgvOqRjOYGMIW+UV3CQYg9j5vPsNLQHsE7UCsPBS75DbsHq8D0?=
 =?us-ascii?Q?9NPB/QK2YH1zjlqkkfuuh8jjPdDSbdlwBAkCiwJ0y7oqq43hWtHq8lsaZUhX?=
 =?us-ascii?Q?GI4IMQ5c8x7vyz/9Sh2eBZpODg6m0QRSPazQYSA5K1wUhQzyLahFVwvI6frZ?=
 =?us-ascii?Q?YWr5o6YOP0Fa3X1HGIT/FC+fQdIJPXv9m4pAOREtWRIN1dkwMy0S6nmsMiSO?=
 =?us-ascii?Q?9Wp2QqQip1LHhNnid5g9oTAZCVrHHUE65tB6CYFI0u5MX6ZGHljr8DokfwBk?=
 =?us-ascii?Q?k27CfzP+bUrlXGVqaGjc+Z142bbFJPaBdwkPiYAuF5MK76g8/bLTWBPfvnu2?=
 =?us-ascii?Q?iWkYDE6N6AXFpcSN9YgNwBGdHqH7390SaoyZIhXS9zEzqEZSYH6SFiWx5JdZ?=
 =?us-ascii?Q?plZiXW4CFES13L738NOmEijNyClQVUuheZKnoCt4da/xHXZwURT+GCjgmGlL?=
 =?us-ascii?Q?0ZiFCkYJVRBFvxiQO3bjqsPBlErlnKSBmmaULwiaWlhY1o5qrTqLSUbiVeCM?=
 =?us-ascii?Q?aHL1onheVrv3bjM3G1RlaJHpIFM78s7drEAplhVSWZFM4yflWjYLyeTfWOJE?=
 =?us-ascii?Q?xjI3oYugl41yGxbvSqaJ/sjCDgTE1LiJVZfBasoPBD0+2kHRmbp8Hc68w3Zr?=
 =?us-ascii?Q?H4BudxKTVvWx9QRkSjPCntRyNLSQawoQT4qBRN9hvXXcPuzHPWDVSo9cfI/R?=
 =?us-ascii?Q?h5G/i+DEcGFW/G7wV2AVAHRJIWKoUFEyL9GUFf+cjf+5LPgZKy0wf/pv9HvG?=
 =?us-ascii?Q?0gxf8EiDAbjJZYrflDPn8K9fwCHrKMj69A/k3936IDbp0/maD3zcPf48ss9h?=
 =?us-ascii?Q?pdQ2jAdpuEYZOTxJws+0+lUH7e4JmeKONp4ajpFDpRrG+sNhZj3uk5gh4JEW?=
 =?us-ascii?Q?QuecGrWnyVakA14zApDf26Oy8CV0nCqLEp0YymkZMi4Pnr+R4ZNvdClkmGMf?=
 =?us-ascii?Q?POZahT2+PsaujvCrUyGzmm0Z34+Wb7B+54E4g3YQLUn5IR0b7p6ZCmWI0ule?=
 =?us-ascii?Q?8ulcthK6J0W37y0T79Te37UY22kRIJJNkRgbG670YzTlpfZ405QrqxZUoR4i?=
 =?us-ascii?Q?hQGCa2BygyDQ2913TCEnrN53LBhj92/2jLkb9q/gbvOAt7/55BQcwK8BsDRu?=
 =?us-ascii?Q?PDdL8FEdZP5uVBEpWec7z88SL7CLZUT046wl/jj+Ya6R+K//+XtKC+lx0slc?=
 =?us-ascii?Q?oVWBK5MaDVMIE03/Jy5Cgy2iOh+uke59aTRuzKNo5Fw/g1a//viqEM8MLnGc?=
 =?us-ascii?Q?lKUzAN6u5RwIDxBktQvPkHKSKsb0JY2l5UAvysjVRypcX+ti?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d351f33-0108-4cf6-3cce-08df43efdc6e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:42:38.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqH/7AjcERXDQUFLtbm78c0zAWgg3Z6WbuZJOfNvYaTrn+72P+y4mJySqpwVofPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

On Mon, Nov 16, 2026 at 08:04:44PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Mon, Nov 16, 2026 at 06:45:03PM +0530, Aneesh Kumar K.V wrote:
> >
> >> The complete CCA patch series adds the following files:
> >> 
> >> attestation.c  core.c  ctlv_attestation_pci_gen.c  ctlv_attestation_pci_gen.h  internal.h  Makefile  spdm.c
> >
> > Why would any of this go under drivers/pci ?
> >
> > The whole point here is to make an 'attestation subsystem', so that
> > all belongs under
> >
> >   drivers/attestation/
> >
> 
> So the attestation evidence would be fetched via drivers/coco/tsm/

No.

The tsm code causes an attestation driver to start, it doesn't do any
attestation activties itself.

> and stored by drivers/pci/tsm.c:pci_tsm_evidence.

Why would we do that? Evidence is fetched, returned to userspace and
discarded by the kernel.

> I would expect drivers/attestation/ to provide helpers, like other
> core kernel components, allowing different subsystems to register as
> attestation backends, with PCI/TSM being one of them.

I expect the thing in drivers/attestation/ to provide the full end to
end driver. It calls the RMI/RSI/RHI's as directly as it can. Without
spreading stuff around all over the place.

Jason
