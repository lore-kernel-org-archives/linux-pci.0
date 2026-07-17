Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94245B21A;
	Fri, 17 Jul 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316662; cv=fail; b=mN+BS1bdphRO5fj3DYR8eBc+ky4LNzDjkjvjmK3aOE+DdvpYDcwuZEwbGYvJA6vqCMMJku2sLfTrpB6PoXYR1kJlRMQH5CHPQ44AF1kV8iHxei6OOCvLoa7P0EwtPsBqIgT76/32NjxE42lUJ+7j6gMOr607MV9Kvlwf/FSiRBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316662; c=relaxed/simple;
	bh=zWhUJaotrkRUwG9se5EY6ftispF1Ct2sMXH+5EpduRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ih8zyCEvyGz9s/SmFQkUXvPlYNytjL0AHsvjPNUGbU65eahxHgOjOaakRTQm8FyyIt9gy19AZ2SRCOMvjbTfjin6fliFWmkcHYNSScSvErDo9qcD7wGX7hwACgV+Lvis28+GY9eWXwaMvBheUVAr1iutTG53/3xjhi6ZMnvOfeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sl13eXxX; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sl13eXxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6WIUEHooLVVv/uyisoWPzXRlcght4CTTjvVerg7nHkL3ObHyZBsC1Xncdy8vzbJSm8qn7AUw1HbLyaAcK32BHmJ46cRzmpVxd4RAwsWSrpe2khHcTVTUi5mu44KwyarafHHyvcasT9ryPBVTBtgznMQflWhlTO5elfzUVmf5RiXOwOKhk6AC8XtayCOJ8PQF5v3Uov70NHnEJ4vQN8ysu5Ct/dp3Gtbjl7TT3JTjtAFgRuKDRiiNu65eBj7IjnSLLhabFsqOwOznSY/vEuxFYcXzEudR4Y6+YE5cBzCW5j5Wm1PH1FkTgxom1SodWRmHcgfN5l72bdIR09+QN+yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PA+TdzZlrljfX2n/J8l2NaTi3Sp0X11AKY0ezcf8PM=;
 b=rBRTeXpDml8UA5QngxD8tP8oS4wm6mOQc3kUA1ujf8f9KRfyWMwC80Z+D7tR9CdXixqY3At0EmHmE9kb22MW5pbUN1AHyGhPbXZS8+8WAtIZdhpnd3duumjAxnYZwIKppUhAQi2w/z85TwHoZVOYZLKA7h57DSaiCC65Gx2TNzNZPRQTXeFHvbvWBuPCbhL6KMeX33ldoufgs6WvM4WbKOnUmhvRXU8raDIk7490axju4xZrGuHY4fR0s+YNUEoFQjw9IOM5Rh+QYvB/up7KYaiFazPWAntkd26zRjGHCJ+jl9HU9i0dnwvJmovi0+BkI9/L3WLCYC1Ag2PvszLd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PA+TdzZlrljfX2n/J8l2NaTi3Sp0X11AKY0ezcf8PM=;
 b=sl13eXxXjGmOEHCjsaVKTg5cbkDe0kI65hL7IITlQM0cBNU51sfM6uh/+vWTsdJTMs6twG92F1zgWNC2rZ4FHJuafmd4NYyywrix8YyFAbOeRfdyxXTAeOiBysq8iT66ARLzXoPbDDxAvYbYKJay1XzlKqNM5/q6mcXnwKb1a+V2436aOLGeqNOsHsi8Bi6vXicEpUfnXTYZwi/Afq1Oht99x+Hlaol3jH0sk1cvec/N/Qx8I/MVq7gVwlqtjnenGDvOvQbjeNh3TRtS1H7eLRLY3r12cWiKquxFv0mHZOHdb/7XSYfkVz2mPOTomyNwLx+2LGqh0WAGcvQw/dYArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 19:30:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Fri, 17 Jul 2026
 19:30:56 +0000
Date: Fri, 17 Jul 2026 16:30:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260717193055.GD699082@nvidia.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
 <178431652443.189683.17611165218179620081.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178431652443.189683.17611165218179620081.b4-review@b4>
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 405a94b2-8d9a-4d67-2d28-08dee439ec6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	D1BVNH8FiVHrz8lr4Mbhq1T0k6t953BUKzmhS3+ByV3kVrF8ntYuUypUzHlt2lg6e5yuhD7mD58gXm5dqaKwfqvU/AdTUQ23h0FltbtLMRwalA696HvvQhZD8kjxnKD/PBM58iHAClq2beI16NVem13x/Jv1duYHjPDeCLzriHRm2O488ZfCnvMG7o1LvasGBEQHXCMbFbXQckTHkiC3/lGegGZnmaVik7ubzbv1VD6CjPCR2XVRLb3/VaYmWHwWZCZn3Al5B/Y3KWSG17vGiEXYkLa4PakVNuqE8X+b1qSfoQepCkw8hW0Elo5bwpXFsfvWZGX0Vr9gTAAX4aMKcVe4mlaluPggjirctPzhfevLMDU81U/xhzlfLn0+dvKWCou03kkQGGCIztB2r9Tl0OkEpcNHVd0CZu1/E5A7U9JIkh9y4nVH0HxgxwbF/mjBrNLAhADKAiYwbwp8AqZy2Dkms6tfLXPjO7b+nIPFu8gN00LPL8YAxgQiPomCLUl0VK69v8SXiFd6MWTD8MvIvF5/s/drlCWbOPp71wyG/DH9tvgLp5Uv85MzmN5s0H+AgePE90VC4tPvu/+4UmFxTQ9xGQrTO6ZkkURI1Fezpkt/H3UDP5XIKIDcXn2fOGUtCysofn1L7fDQP/YAP8bdLzh0YubeFkR00xNKxa9CeLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDRXUVFn64Ray6jmEfddl9eBSh263WCGOk21bymcIYiJYMXfWLf6hXFo7RRg?=
 =?us-ascii?Q?da09Uz3Uur4FFFeB03iLU3YRUQJXSVteV7ojzKK/U0DaxqoxTILc7iNdDqk9?=
 =?us-ascii?Q?4V2NZ4Xdp1qb/kFvcF/i+9xnrTN0xIT1afg7lj4xxZcn+PD3q+9Pi1ULIgxW?=
 =?us-ascii?Q?NyhpCx8eegH7IrsvJ5ZDn4Og+tUwNrzsFXn5j0+FSJCD6y7y1EXAMI/MbJmu?=
 =?us-ascii?Q?XNbO6pBhARAbb9QqOgviCbyANznXKqbCGfFvjhwFtiHf7Iek6DORv4cVnsNF?=
 =?us-ascii?Q?Zz3ez9mV4LAgpDMOyBgyRl06yquzYwj/JzcNIZsL0wKQwklGAbbF1tzdoZjl?=
 =?us-ascii?Q?WqDEnEaNKCdc/sAF2eTLDrx1Pi3IcOl6wMPJbOUCuZurGukFL9qR108fMdSs?=
 =?us-ascii?Q?PBdAr4754HFZDpYGDBh+tW2mrP349MmpaR865wYbDPhv6RRQ3Ow3Le7/nMiT?=
 =?us-ascii?Q?6FckSxBMTxQKB2Rvu8yePiH1Fty8O+GSmNXR8G4Sr5m6zS9Wd/Y9qbhgh2S4?=
 =?us-ascii?Q?eO81A4rd1SILKvZqLMTnWUrIC6AK3K2PeIBo5RW5j/MXoLgez2GICkmOnuyZ?=
 =?us-ascii?Q?u2W8o8NoYyzemZj7V1BqMYhTyy/KpoK+aj2m9pF/9WuBwY+WsqcLxPXN6iMV?=
 =?us-ascii?Q?gj1xGw3LRU+L8xWLdWdD3BoiNtqkp2H7J6HjuWTQ99J1SCUnwrrqoKFnBYpp?=
 =?us-ascii?Q?eUppRjPQSdOBeF3zDhzSNtvEnvD8VKQULNqMo/fH398p5nJrwcqRrBXv/ktk?=
 =?us-ascii?Q?fClEcRqUPOaNKidiVkNPUY0JjZmOlatswLSqheIFvqZICuAf6d98DHloYsIR?=
 =?us-ascii?Q?Y9z3ZfOXSy4oo16Ac00EhdCsyvb1wmog2ZQEngQ3rlmXk/VRwKObRMP9EIsW?=
 =?us-ascii?Q?txGWPY5D53yoAfMBMm5hUZZy2ivVMBApX3NhcnuSc7S1Sitp/nFo3806EilL?=
 =?us-ascii?Q?nnYWWB9tVtDOdqJpxLmAuoHXbktTE0LG00kar6qhfdpnJCeWSq949E/X00Gu?=
 =?us-ascii?Q?FOkTufDlN4xXAVx8J5KdJGVE2j23qYm7xPEjqVUnUXumX1Yh4uB7KXMuGwRR?=
 =?us-ascii?Q?qFzkEJtrCQ+fTY6dccTxIFidzdsnqUXJGRM8SIucGthljk0w7Qs7eNjfQaV0?=
 =?us-ascii?Q?BeNE+PO7SZy378G+/2hOTCUUsdsEbgcCvzQNrVh3AYKw9uxNaEbI5Upn3LKh?=
 =?us-ascii?Q?R0YXTIJhTQKoSWKhQnbcpTRuYTGsl8RnUJf2FjwWI6zfXurY3NeUYp7iUqMw?=
 =?us-ascii?Q?5Q7Kh2y/+RgRJ9AViz+s4LZuo+jeexf1FoQEwIILvmM18JrrfyNWzPJr02wT?=
 =?us-ascii?Q?OHuAY6XLWrK4OIJTDaB0QJ5qYlCwJETI1Gx0rZfWvF9RNBfVlsI51flAiTx3?=
 =?us-ascii?Q?1FRepmkfAeR8lU8+azX5UjGeqqFEpSEgAbCS3lLI3i2EEihoTlyC01kvQpM7?=
 =?us-ascii?Q?Q9L98qN/5Z2P6gZ9aFjlC2vgorqZtlPUiZI5GkWWaydM84I7nqUr8WJgKy/g?=
 =?us-ascii?Q?cwGoskFbU3M6igsH+HFl/z4gZHrftznADK+H2h+Sb2P/sSOB8vDrH01l7V6a?=
 =?us-ascii?Q?Pua9ydqPjQy5OiXDtoCy7qNjy8/dXbHczdBjuQBQeyxggGSGLUY+RwzKHSc3?=
 =?us-ascii?Q?CNNcxCLNAKk6+maj6Z/Np+I97BJnOLeafkWgryjVWV8wAJYQGIJ42VjlfBLM?=
 =?us-ascii?Q?HcH1BsALlEz2NhXayXwNeFniSI89pPGYxDP3qACIU7xUEsi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405a94b2-8d9a-4d67-2d28-08dee439ec6a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 19:30:56.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eD17RG3oDH95D7h6xbPxBh+AwJmKrfS0SjlHPZAEJIoI3ECZECOCeFxB9tPnaAAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

On Fri, Jul 17, 2026 at 07:28:44PM +0000, Pasha Tatashin wrote:
> On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > new file mode 100644
> > index 000000000000..899758883dd5
> > --- /dev/null
> > +++ b/drivers/pci/liveupdate.c
> > @@ -0,0 +1,155 @@
> > [ ... skip 50 lines ... ]
> > +#include <linux/slab.h>
> > +
> > +/**
> > + * struct pci_flb_outgoing - Outgoing PCI FLB object
> > + * @ser: Pointer to the preserved struct pci_ser.
> > + * @block_set: The KHO block set holding the outgoing devices.
> 
> AFAIK, these should be aligned after column:
> @ser:       Pointer to ...
> @block_set: The KHO block ...

Gosh I hope not, I never do that. The horizontal alignment is such a
PITA to maintain.

Jason
