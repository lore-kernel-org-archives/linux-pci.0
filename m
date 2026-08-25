Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466B257845;
	Tue, 25 Aug 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658694; cv=fail; b=uYnYtiLKrXCgQLHdQfNg8r8uiIu7/lR0VIP6fpLBAjz9bSZdk935fr8iVEvY1Xd3HyJ27RvoCFzmthld88QdN28M3v5xJZllFCC8Kfx+TuVyBm9mf6LDkde2NmTDD5H9/y3+YTFvbuq6VfbtS8n7rtjENDoukOTulGosYNL/llk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658694; c=relaxed/simple;
	bh=xmgZ2Z8zo7YEnr3jQB6k5y0qxZua9xOzhDNacdhyIeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7EFTZ+jmBXtgDg0htIudUiHJZydZCxgdlLNYPwK7eySvE5XYYQM+7bohvJbrTPfcolRh9Dy2N8s9LaMrD+1m1U3NvoOfwcR5eNPMyEZKJZnYAnlEp1/14qO6BM2kU9dt/suoEvDHsSRhSrtLW0XO+A+MvcGW99KPiEgV4t+cRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B8nLa/F8; arc=fail smtp.client-ip=40.107.209.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B8nLa/F8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSrSsFi4vRf2Y5qnCsiEbQWs7zBXZPTKV05pTdi1h6bRj9GE2mbfr4VzT+O+o/cBiXCR28sVvgWTPYdh53pwllSExxeBcZzh30N4YrB0T3Z9guLmvw8mGoFiRLcSrV6U9ArP7BDoApmfZN0mxn48QDhpssj9NrHsGefcOqXFhXQYmXu0kdREGaFra6xWkDL9vPVZedpzy/kaKNkVbhqy848xG4CcTxS3s+IPVl4yztRtJk8QQNpCpQmS76Xn5F/bphd0NhekSrXDpXl9yQI1z9Y4lDgRyiTIEyHpEVFkQTABk3sIyZOzoMLwQpIdYBINcZetjhXzlw5KijZKvQZ2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAFFHyRxNH/ggBFc7yAIP70yobY0fNJGXryfBFYbWXM=;
 b=PHdY+rKLmcq/bbhYjXX3rsmlrNnrkdo3LueI9qq2yO9YOakOM2I7kFFqE3Mi4P7E3VfWSH+QN+tLJ99txwV+AkOxzX+kK9YzhdL4yKkp6+Ph89oaY/MVUQ65sMze9ENZXaY5el3wntnt65oL4wq0rmYRrIjm2i8m7HrXM2wfSNr+QqNgljkbnrDcD18aIChRFWBdmw3+Q6kFxExdWzxGS3cXICUVFHEi3ymq4wpEAZfWF1sH8+c+fPQOJvsEqypb7t8CjFt8ZyMk86iTwisDnBcc2tqcKPrvWd4FbEnWNMS8fBzbUViNHJzX90MdaXpeyBpnbTJniANSzSGRM/SNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAFFHyRxNH/ggBFc7yAIP70yobY0fNJGXryfBFYbWXM=;
 b=B8nLa/F8giGtexPBK2X2wUe+vlOB43dHhmc/1EEJQzIBb6pZsENuuteg/rIKvAZS6raSXTvm7lNkN6Bu2vuxlRqvw2UAQPGOO2e02uidH7AIloGSv4ceHVP/qxxp/8yPSbO2doNhkrJpisKzJXei0UY87mZfmpr2QsI6RVZVrWPooH908YezyBt+tY9voEb+UTUt1MXaumpIMPwjpnKvMYML8hnF+2+8qlt5Xf64d5V7WDk2kC3uoqKS1Csl1VpS7gY+/k7/WSMGrcqLb8MC9cWGe1P2tnofd0k/qZcA4w+IBt2KOPrZGdtFkfuqdyudws/85YRRpJCKRTcBmXbkkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:51:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 11:51:28 +0000
Date: Tue, 25 Aug 2026 08:51:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
Message-ID: <20260825115127.GV244917@nvidia.com>
References: <20260824122347.1588592-1-praan@google.com>
 <178759520115.3131778.12333086025639368747.b4-review@b4>
 <ao1w2dzzsSHOzvhT@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao1w2dzzsSHOzvhT@google.com>
X-ClientProxiedBy: YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 092ddde9-1931-4f29-4e46-08df029f32a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|11063799006|10067099003|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dCrzLfD57jEHu9aKTUiFD+wXxbtTfJK7V7b4yP18NdE6EtgrDcJWv6+V6QvhMeeqloT+BEXHLmHwp6xVLdBl6WcLoZ5ZbYUEKGinb08ADWf3YH4txDZkpIzrPY7BdBRo/pBRtYPZ4gitDY4FyhZen2LG4kCCKxzjQp4Jp+LCSMWRWODMA/RNefJoKFfSw4t0NQO2dOiDwF/zUF/kg84b4kyq2BQKZB+7yf58mrwnRv0K47r1TDur6AiKg5ELWcaDB5Bz5yKhC1ocTsz6b4G2tN6DIkdwoZceUsiAO2Ax/4s5pNORVRCHvf0MhB1mOBR3YVTPc4zonvLrQ8DIVKBqzyjVRUcnqoI2trGRsSxJE5Xhp6Q8xhSJbx5COMF/RGms8ZCsmMTOPFqQQpX5HlMNBI5B+rJLNb/8G99DSKnoBnzCT6pIa9b3Jov1KcN98m6d6tTh5utS5hvd3Y+iReGXfjKcco+PihRRLmGVa21THGa7xqWfXFRwtp6Me7PH53X29oAcdacWXlntCqvdVfEGXdaNr/vVGjBtOyXyQYLHhev88X7GAVUi2ktNiDfNDG19iEbGxZsjFmvJvhzKzEIMuvYiLyk09mpabn4wW7+llU+1BerYAV0IHqpCRWjbZxyRLsKuRbodR11fm/vGbDxp1ZsfLbOp8L6dAS1AFYae9zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8nFcY9fBNK4mkp8cgck/jreR/UdWZmTyhMOULiU5Tx8yd4c7CuwKcwqU+jm1?=
 =?us-ascii?Q?HndST8tVaOxIWxDOhy7R+zC6krYI105P5HlXDdzIZB+pJ1WjeT/+w7Rrq7Nh?=
 =?us-ascii?Q?ydf3NoN4/Fs90QkoMypYLegmUnjgjZS39i6zRbGR/vjTJFcU3zDvsMvUAYWu?=
 =?us-ascii?Q?cMk6rbdoB5qagBpzmcbXfBrllIGgaLUk722tEnuEHZ+mCg1DouefcEq56YMQ?=
 =?us-ascii?Q?fI+5lwct0OQmbuHtCygbhAGRY6p1N+7fRTG7s8Wk9xalm4HCQ2YzcwJU7VnC?=
 =?us-ascii?Q?dMA2fHCbLvAm1UELbKwJwcfdlVrw6Wk+xoxkTbtcLGX8vJyFNVYm269BC8S8?=
 =?us-ascii?Q?MBYjJgglgqttZZ0uGO3UNLWQQ0vG2GylpeEsv/I8tYPtmhJ3URXENac7PHEz?=
 =?us-ascii?Q?RZQmUiX0a/bON+GD3gczChxZF+BeDH6ZGL4qOwG4BRZagsRgj3LTJvZBu0fV?=
 =?us-ascii?Q?xiJ0w7Ui0HNnG2hi60NE21oCIS0oJyyXq7sSxjFgbRkKiMUIqyGqkyY85l7W?=
 =?us-ascii?Q?g5h5ImjAx1EpIh9wWmScUafwyAIu6b1gJ5bX6t3W1xIAVDgmAvmColznUT76?=
 =?us-ascii?Q?jYmETC8P+407GJF1XK4GVAOsu7U3p57TgIUmxu4Up8nHy8SOKLlpLTaVBEBx?=
 =?us-ascii?Q?YbmxH2s5kcng4B+/q4wS8ss6fAeIsf3Ez4wbJzk0GLZRsIvc3ydwykdMs0Y6?=
 =?us-ascii?Q?S+RtYtMKL8ZtzpJIgAgh1PNO4vjysfgS9K13KL7xDp2ZL5P3K87hrqyaiU/p?=
 =?us-ascii?Q?4l2lxK7ZjjMbCOjDDeeIX9iIhKcNqRV7zVE71dcSsSHpNRnPSvW7foC5qEUV?=
 =?us-ascii?Q?SwVSpGN5JO7cIR5GjP74FPhp/Mry8B+8TmSg89DlMNqnWxDMV4C2n+MGLKwE?=
 =?us-ascii?Q?ttRl2reSYtLulzIyvV+7BwR1VmxVK9lTe6eerLafnoG0T/Vw1nZRQNSgDfF9?=
 =?us-ascii?Q?Ovu+q7D26IU5kMfbHeZgfC80neL9riTGFr+zwMwduG9IwrRVDw7dWrHUXD1J?=
 =?us-ascii?Q?H5n2db1dyGaqqZNZnWldPe3i3SHLAdpdtC7wVIW8u1P9XK3uAIrRJ2jLWt9g?=
 =?us-ascii?Q?wID4FEWb4wK+2FzcIkkm9VwnV/ICZKB14zaHR8neKUXiIDvoQrWzUa3N6fON?=
 =?us-ascii?Q?swZT6dw2kIotQS4QUSgkjdGjDhwN4e1boz+smMYqeB+goC/HeHI4n9gQSkvq?=
 =?us-ascii?Q?/rhm53Sl09+y15OrDjTXylu7vVRo3/Hc9yTd9Y3RwLRKXcjizFjJpJAyYAP2?=
 =?us-ascii?Q?4adhs6nxUKoujZ1HxBX5TZXzEBZbBDYPjrlmOTLQrrqaxhFNGkwfnd0mjbfE?=
 =?us-ascii?Q?gDzuPZ/FS0kGCkaZoBHn//BZQUK8rmAF1F8Psu+Pzb7ur+YFM0vsSDx35TSY?=
 =?us-ascii?Q?IOXTE1bElZ2/UimpoxrLFbZq5aiXVpFUu1uhqcK7oXlIu+wcEscdPJrBnV2H?=
 =?us-ascii?Q?29iXy0nJ1loTDBxHax0q/oB8n5CGsMHnGVBnZMbnNgKUI8wo9lPtZTx1BeUu?=
 =?us-ascii?Q?Gr+7s5u/40zxiw7kJ4jWj/eOcK9vgdQhX1Y6B7WkmRfmqFcda/kq4wTcrfba?=
 =?us-ascii?Q?eMNZuecEXIBDNgIfmiz4kYp+/AQQ3UcLthv37XB5JheF0vMITX8IraLoikIk?=
 =?us-ascii?Q?YT2jkSMlx9PVpcIEZrANmfNVISjZeFOp9vl7jmawfrsVkf04hJ7bSNomt/Ji?=
 =?us-ascii?Q?afY2aMac/lQzyy/NBUzMai+FItx5qqmSrqmR5WWyPVk/5z20?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092ddde9-1931-4f29-4e46-08df029f32a3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:51:28.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65tcJv/9F2lQ3IqWPX1Og6pOUZ/V5On3NxBYBX4QgSWjnm4CTFJxN2CNSU0pbstl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Tue, Aug 25, 2026 at 10:39:21AM +0000, Pranjal Shrivastava wrote:
> On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > > [ ... 41 lines skipped ... ]
> > > Pranjal Shrivastava (5):
> > >   iommu/amd: Refactor device probe and capability initialization
> > >   iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
> > >   iommu/amd: Split probe error paths to preserve IRQ remapping
> > >   iommu/amd: Fail probe on ATS configuration failure
> > >   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> > > 
> > >  drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
> > >  drivers/pci/ats.c         |   6 +-
> > >  2 files changed, 126 insertions(+), 79 deletions(-)
> > 
> > FWIW something about this series is mangled, the first patch was
> > changed before it made it to lore. Maybe whitespace damage..
> > 
> 
> I see. I generally use checkpatch with --fix-inplace before sending and
> it seems like it tried fixing something. I'd drop that arg now on.

Never edit patches after git prepares them, it messes up the hashes
git puts the headers and desyncs the context lines in later patches.

Jason
