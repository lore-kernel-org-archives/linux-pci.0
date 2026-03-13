Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E79258CD9
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409028; cv=fail; b=GTcGp0/uoncoau2AfuXv6jUuf5PP1vt8z2Le/4VBOcXZJBV/t/PiyyYBDcqS9Nt4nwOp+SYu9WMEWKoFhzDSW/bPj/lXriFTdtfYzl7PBWPZXCYSQMq0eL7/jVnJNYuO8TY+Z1MIczAsnUPndpgY4fdBaPF6zEJEJ4ZZfFXve1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409028; c=relaxed/simple;
	bh=/NUX9rh399YVUBxLSC0vJ17RYAkFcth7SL4dYmct3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F6YwCyMkMUxLFNaLNd5IQ3F6XLymV0u6mNG1vEVT3RShJWlQ6L99R+LZRqEkBJ8QrV029r6S3j2/uUAYCe2Bt/CPpBAozQtBKxe6u/C5GzalhzrULkng1tcPl05UXR+NPK0oFpKcMWbaavD4UWE/Zsf0++NKLpxL0Ycv17bbJRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FNzebXIQ; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNzebXIQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSLtJrVizzFqOI0vu4gWFehOn9UgVER+4pCYVj6BTAUBomBg75n7IrhI0zm7Ow44cLNiMZ4kmsrfRsMuPOGY5paYOZKx4HHgDsI9RdAZ1d+QVPL7MOYHSNyLRlGs+7Yi1eZvrTTx24z+/5ownQFlDGWn+4fSk47GzA/e6IXvJXBdE7s9A6U27OJTvYPCIfJgokj4Pf9dPNkI1RMEnmWMbcq6Z41/klx3JHdqCYzpyCX5GtwFpYhxSl2QXWIdoB2//XbnjeBc6Jn1YdX8P8CardEJJqLaGJS8QQ0s4BuH4ANA6AKiCee6KKF7fIGPf3veDumvtxig7MW9FplRZv7lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgN6xKvlELNKtWnLre+PmV7VM8szKqSDKAfrJcIcp9o=;
 b=Wm4vSkJVk84DeqdsG9RoOcuzNc8Nd3qdC+Llq6a8Q2cjhw/9zkzkSbtWsJb2FSTGvXSdIGChs85kejL/Xd6CO3dT26MNeCX3zFTV0eRlCHlIRzrAuXiTaQsdGwU+Fl4UYzXWAVJEshdlSTc/QGRPUb1xKFjSCYw4QrtofB8r0enT2lYD9TZ0CXxgAV235UMRRyX7jmlr9EWEq+wL/z6wKuMvAtmHox/EZZlCGTFeVbg7kROzn/bFShNS65zggpVStMF3AxsF4Kpx+rUjoZCrVwABo9rnJ9fQo2jzYunhWNfbrxM94fswUf5mT1ZrtaJ4RJKLNSHgZkrL6vXkquwWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgN6xKvlELNKtWnLre+PmV7VM8szKqSDKAfrJcIcp9o=;
 b=FNzebXIQp2B8qsxJBze5o0bNchi6DKJK2uP5q5UESpcnQay+qE/ObzW7EFVVvw7PoQ4RU2sFO/bzyuheq7uetYWVybFtUUZaSNMXbEw1+D1jkBoIFBGAf1qP5mG1uw0z6Xs36ZlC2MAIvuMNPKi/+i0JQTmJ0XJPlHDaE9i6QiLlqkCr2v+1SvFchxD9QnGiqrrCZMXyNcwqGn8tEF1DsfDNY6Xdadhl+cJoKuQKE+X+yVUy9i5O10l8YG3IT45UPcVg8V5ONoqBKqtTRP/jljKJIzGJnVls5jfr3Wg4zGYYzyEPUogY2YMGK/KKuhPVw76N0nBmsaOrEyQZXSyROQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:37:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 13:37:00 +0000
Date: Fri, 13 Mar 2026 10:36:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, aik@amd.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260313133658.GD1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN0PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:408:143::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4808a4-fe6f-4f0b-999c-08de81059a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	st7BbycWA7Y8MMabwBVGxStaguTpF5kfyWNnmPo8Jix2Fe4ebJzpinALsm/OEDiQVviMIdR33e9ol8ReW0gJmSYjLVuang+XhvJ7nJ1ojFWBikeFUj3yrbFKbv2a1uMyI2699PdkQz/aCcfF6ps3Q1pdWXmidDRqQiZSbAtDDhTaF4RuPB6X6oMs8pQ+bvkiAGFxOK7UXB7RtbBLZVUl0i/A5C47c/PqCPDYT6qyUcXVVOOtQWdN97NRp4MV85kuGb1kjWoFv3FONMG+5mkFXMGU0Sf/CF+/K/3PooAVVe3Ml+Qq1dgWnGDLETpesLsgOlyUKPCXfpdMLATUu5oo83UbfBrbUA7i8z+PbRrEi+/1RVVWu5ZW358t0ttfxAx8LZjCXMqaeBd64ZlQzKxUpvQ2fHSocV5HdJydQ0qBijHXmi330wcIjwvNTd0KvjrIzi4mi1V54Hvwpq3JtKUC4bIba960M0cr0UkXhEUB1ShJGBtXq+iCa1dkxW8dqALmshQNkW83UOEAc0eJH3S9Me0w5Wxori77zR46WlJug7C09US5fW1m2c2aMI6NpBcPdtSjyLH0wb01/RkupCw6/nooGGOfsXlZ+jRwkhpAwYy2vdThViT1GQ6JNW1HbjRsErXPWDpHw/qnXkbiIOLtYGM2YsVohQFV+VxZVdtKRYwjzjdpD2wgHDBEmTIEIf/QyJWpGId8ETbf+tCV9jgPzmOGKX6oSXt7XT1IIhUSyYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gybJgkPjMNSaifcbrrfHYCyn/ouP17FVBczQ+TPSi8llgn3v0R21EO0Ft70x?=
 =?us-ascii?Q?isn9ADGxYYwXpZEcGgpaAOt608Gjgd091qz2vHT7mla0U0x5TPYNLDcFjlk1?=
 =?us-ascii?Q?HcV5oaE9hzTR8DSaBYOv0P32xplkknRFVibjzP8ckyaA3tPSM5zOuho7+qb5?=
 =?us-ascii?Q?/kdCml7Uvn3yty4pqwqWERdAq6Pl3Zr1wBsPEP2OCBaevHROd8KGvNUg7Mm2?=
 =?us-ascii?Q?0ssHux6V/d0GUiLCwpweCzBP7JGMgJ4LobJemo9VzSygfQDvdjl3zD3PVTtX?=
 =?us-ascii?Q?kU2JIDQCKHpzbcAKsIXrvMPYYZkeoHY/BC1Bw6CDnbsLYTFcM/D6bzZ6hBrY?=
 =?us-ascii?Q?+VAGQI3FXgPJqjH3uohWvrrgcTlz+IN3P2Z7NmruZXs7stQHFlr5QJtonumQ?=
 =?us-ascii?Q?b1D96ZWb2XDLOctYMycoAFNK36E2krjy4T8u+1W4Z9busdnpq4Qs540rwfPq?=
 =?us-ascii?Q?2fE8io6DWHfBGxG4FzwBp1KuliQ0bCZUus1YJ73446o2CWJNJNzLYZxw0SfF?=
 =?us-ascii?Q?PLv06VNlGRxXfxnq9SUxLWxPNGA3fDvo7h+rFk8NtT2tmbWLazFmojjZCVPE?=
 =?us-ascii?Q?35LyREQRQyeUnScN8zVhGD+k+pwdWhzqf6K4sWhvhNG6PXH11mlf1H8aadQr?=
 =?us-ascii?Q?xLVJA3cxb1fDiSMnMVSVHnt7Vo13HqubIt9RsHUCqqMBDrcIWKhq1F/b8+vP?=
 =?us-ascii?Q?1lT90SlQGetCoZu3Xa8DsNmesCsS6QMgOMDGLSrnrbO8DW+97+k1fl1jPXtM?=
 =?us-ascii?Q?n2avP1RDLPyulk7bQalrdAhl8Uh9e/0TAMvaDqCS/KVtgQXPW4WrYDMV3Udt?=
 =?us-ascii?Q?iWpfxGhzerIYs7uFNfryHLTrHowjH48MO7PkxH+tbOBcQkfKPyeMDo8VjHcv?=
 =?us-ascii?Q?AE1R+vQ2nnN77RX5Fq++N4vHN+d9jbsBqydDt/TSqRqYuHRrGN2Uqt4qJBk/?=
 =?us-ascii?Q?Cci1XNhq5E5Sp6wqp3g+shnuSaYazeUzT5HmkILs1nq2p2RFTK22qHXjwnCR?=
 =?us-ascii?Q?kviXjpWpK7n0Yof7KH13/L0eH8NNLaCPH46lI7b7W5i69UCpng2UpwkUE5Zk?=
 =?us-ascii?Q?fC786oKgXaOFTYqL+u7qTW6aJfTBHF4jZj/V2RFLljQ2mmBel9V/6zvNHd3R?=
 =?us-ascii?Q?ewkNt5G4ffhdGGDFDHvOdeV92DQPGUtLRbf/ANi1oV9y8nheHu+8AGbdObcJ?=
 =?us-ascii?Q?8ZNdPDCqS1e76f0bO1Kct8c6YvPbtDLmbT2dhynxgAoWJXkow+Nsok5iXE5D?=
 =?us-ascii?Q?m49qzcAclX/YbFZ/S78BUGDKlw2DBwy6/t+lDJwty9489fTwdtJDgxXvSjCr?=
 =?us-ascii?Q?By4ce8Y/nICtShljCu/X2+P+jlWIWI3m/OgeohxxuCEGSwYTtRtSeTN96Fdb?=
 =?us-ascii?Q?q0bqZ5Rqw99RxOwAJq/d/7vP2n2o5J3Ch1LKQVe+SKXFqeQ+6NnHFvnJt/Ro?=
 =?us-ascii?Q?Y1u1MDU06kgAWMp/Mm+qatRU/+z+PdukSoyHlcgNbLa8m+8ofJZcB9YY9GwN?=
 =?us-ascii?Q?TS741RH3Cv3ifTGpKX8duya4Sv+AmKvsNds5/iaW/qcvKCRCNHSrtYfYRJOT?=
 =?us-ascii?Q?9RydpmvpaMs8p41Z98H5ZQKTyVJeAC5G8oU5sPiwBaaDe2CB9KzvfFRwecdq?=
 =?us-ascii?Q?HxVSWoDlv91G3wvGImK5N/lxU6B5tu0NJOW1iUuIfwQCgZWqSq//Jc7aUlqP?=
 =?us-ascii?Q?GJNjeKDqhoes5D3VB+MrLldOSt5yTgS0Lp1cPJz+0HZ6ZNF1B2sWYJcvxYkc?=
 =?us-ascii?Q?DotpWC88ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4808a4-fe6f-4f0b-999c-08de81059a3a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:36:59.6579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvpPPS4+FVPbZEO8hkrB1hLtkjMydDClroquuxXTN+CafuLA1YeGWUOjEReDsJqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

On Fri, Mar 13, 2026 at 06:23:51PM +0800, Xu Yilun wrote:

> My understanding is, it is the obfuscated host start pfn of this range,
> if this range has offset to the BAR start, this field should also be
> offsetted.

The OS must get an idea of the bar layout out of the report, so there
have to be restrictions on how it is formed otherwise it is
unparsible. IMHO the PCI spec created this very general mechanism but
the CPU CC specs need to constrain it to be usable by an OS.

> >  		range_off = tsm_offset & (pci_resource_len(pdev, bar) - 1);
> > 
> > So that we correctly handle if the interface report is reporting a range
> > within a bar. The only requirement here is bar address should be aligned
> > to its size and mmio_reporting_offset should not add offsets in that range.

Right.

Jason
