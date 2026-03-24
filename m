Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260371DF980
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355920; cv=fail; b=LxEbv80YI55PSyM5kOlxkp5zSFjsmIdxJi6lFp4PUVIqeSC8Ftaib/xQtxhXms1aJec87vpcPrSnFv+kU4woGQFOCi05QYF4hYc/LuyUQzMXISodiovr/NKNSZgOuzr1WSYBEpXLgv92LIPAJMUBAM8fwGFqPmuFz6n21MnOUzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355920; c=relaxed/simple;
	bh=u8dbFgJF67Xb+DYAhVwHmmA5j1vdPHlsFJBhk9KRofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxbcrY1UyyVu1TzR2aQjGNp63G5QpmlU7p2dqw2JX6xxWEk8KzxSJ9T4TJxOHHWkWoWR+jWs4mT3RIUMhCLq/NTHhFWqZ4ke/Z0hedyW3kp8lv9KrSObpC0ch0faN7McdQA91ICySD4O2C00Cgkc4Z3dF/3VsTxuMCHjUZ1Q7GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8ZWnwa1; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8ZWnwa1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNeLTMPzRnlxALKbHZuzfMMH+PMeTwvgH8bwrleKg1AX45m3/6UqsCRm+6kdk3iFx1C4KVpUltkHRzhtAkjK6sW8Wm07p9CtK8BgWsqYguqdXQbmihRhYVzpMMErv4IVsKkc8TsBBwoV1veV+MiCkZOXgyz/yqppIAuhqdnkO58cGKgLvHpaB8OFo0VyAjBO+vF/Ie6rrfYqbQoZezP3nYsY/AaiHorXai+p1zg01AHsCdBMleyKgwXQNslxhd5Puanr5n2Ex2yJn1HX9xBg97pqAe2+iqi9gQ83Cehy2DpH9OovtbqE0xCO8hCWNOzaEQwFGkcMnlQbccM79KsTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5EtwlLMd5qtjMJofyhrzw+5uIo101dGhGT4OGgzqZw=;
 b=CMkEFqADK2fu8oGMv0Q92LLlyTz5D3m0Wl8hn80p1zXB47IRG1tC26+9n1zS7Uz7TSCQNvk8HcqSsho5VNfdezSHadfgKygNijwm11z7PnuVNTr+75O6r5zorLSgUieszeozYn0s0BjkT2Mn1oybJaGMF4813idjyAQ6RbT9hiIF3qJNQ7+X15y6ssMbmDTTdNEkkXEj+Xy8fSQ3vWvN/sKfYJBAajWwQHhd+anA83LI2mlDvSVG2YUM7uY9GPNzIWeXG/vFtPECQnotYSCw93tR65s0ZgnXXqfc/2SLBBXYpzxSENeb+ec1MoTPBD0h4v6RdxMAJ3osBlz2jjseHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5EtwlLMd5qtjMJofyhrzw+5uIo101dGhGT4OGgzqZw=;
 b=h8ZWnwa1poD7vqj1034z7BNxw5SMg/DzbgzR6DIbBJrJoN3dXHh53+Jo0a6MUdAFo5ekCrUC0Kb09S8iFlKkW+vtXHZHKP2MkgLHBQpD3RAN+gP4rwrYMcJGTbTdfJhhdiuUHcuacG5ypy4pzYayvuPsN0Bpuf+ag1vXQ7HX79a7w87NSAN5FKsDtSbHX9w1TYKhAwb3hFMQwZ0D5NpqfYvfM8zFWpe3Yt6ekAwcJicrZf1sAFAG8duX6tADxQx7L/XBEW9u21KDXA+UzJStrVqiuhNjoi5aByktouAE55wdieOFRazvRpo/wgqh4lJSBRFlc9Ft51iH9Bg+Xt6CQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 12:38:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:38:36 +0000
Date: Tue, 24 Mar 2026 09:38:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, bhelgaas@google.com,
	alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260324123835.GZ7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <20260313133658.GD1586734@nvidia.com>
 <abji3A72ogqdRiGc@yilunxu-OptiPlex-7050>
 <69c2046287d35_7ee3100ed@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c2046287d35_7ee3100ed@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed05a4e-d389-47dc-1718-08de89a24481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eDYv61mSu7Etgu/ZGsjL+27OnNEw1MotsWjoVSeRkMaOE/h4RkNDq9FyaeRSku825fY1LaDbA7+j6xJyKPQN5ik8s3xhhL+A2ZtHgRryYGTNnJAbbpu/PP1NzqvDzgGSKhynpmaJp9oBlotmPuLG2uzvNpsomG0DLFBfpRPj7IsPfTM8yfOSH9PmrkB29TXZiQpexTwGB5TDGbdtELSD7XfmYqUfj+H3iHz5dvevNiXYkSTXtje1XLLca56T8y7VE1KXwVmS/TtrzTDJN0iV1cPOOHsN6D1/JvK0vjPlY6YA05spnDgCR02E3h+d2RIWrBgyAFEjiT1+UM8+Hd/tNPOX04tzNce4vVmpluwcyp7Q60LUmZZpuW0S8Gvy2g8kidZ9P+fiG19WGw+QNrLajlgHWk0VEZwPcft+FDuEUqEfvDW79H+cOt3fj2gIRhL9IQ2XTuywLO5hxM/a5CH3+uSpon7Eb+k1n8lDGmXab8kH1igJ0b0Jhh/TVvGpklZwM+CRtzGqah9hrWTMyFxuN1lC6HRRavDyYuuYl8z9Y1vRv2psHgr2wNHw/DnCwAyJYI2y6w52Bo78QqNiu4NRE/0rNS6jg8zque0ekHISKehqL+EX1r1IEar25p/XwTJEKNEN+tZy1YMfaQKPKqj7322jYMb52u7LhfA3fCoVz5utjS+boGiE6ybv/k59xUnrm3uVXpF38IYBCchzQpKrTzzw5orrVFLLlMWTd7wLPwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZ0jh5ImO7hTLKf5ODlbfIo5cUfNt0N7jVxrVCpCbZik9YwQKNvbE4qCfxK0?=
 =?us-ascii?Q?7KXb8JVQ5YisA8vFec3m+AKEhJFvwEiiEtz1Io4/4jE0yoOvnxtRa6pQ7CEK?=
 =?us-ascii?Q?KbOneDnOZNgtOsl8ENggQQ4XX3yK0vvydWdo2phykxvkE8D6hF8ivbcJR0gU?=
 =?us-ascii?Q?S6ICcaJjyJ7w2uGz1us9Jx7bF8Oo6l4NKkOVfhzS6lGvvvitnKSkc65ejD4g?=
 =?us-ascii?Q?U/fsRck4o44BIP1wvADF6d/YdDIwhhKWgTAkFQmfxn3sD6rena1mbMSGvX6+?=
 =?us-ascii?Q?Vojw7j+aRk6cyb7mqqyvOfkT91A+Z9P5PuvGwsTf0vElq+OnppUJ2nM47ZfM?=
 =?us-ascii?Q?telMhOyvUyC1B8//YQ6h+ylDUutcXh5mKvG/L0c0cpmW8f5bLM0waYAYf6xn?=
 =?us-ascii?Q?4UC8yzekt5o/qY4ejq1YvyILdC8mynMNkDVLd6kBYloMt31vGM4yPWCr6Sbz?=
 =?us-ascii?Q?kG/st5OozTDQSRrplk3ZSr3ICRs/otfJYhHoCCqZSZWm8lHVFgZtNd0jSijW?=
 =?us-ascii?Q?2xlv9E2sfx2r4PQtizJON69sD4aQ2zCJbjKx2W7LOEZ3mejarmNREfbpV/M1?=
 =?us-ascii?Q?kLDMBDdmPa/KC9O9o2YHglqhLH3BBfh1ePIoSRbP0Q0JGUTqjgW1iau4j/F6?=
 =?us-ascii?Q?wjVYewF0wCpI6LrD3T65l7es+1gzgcEl2dMrGQp/sn3IKuhtrS4LkTY/CrLt?=
 =?us-ascii?Q?eR8ok/3ckK6a2wcOprauY+ovE6ueE/sRfs3/8HgvJg7glSNG70AOgBkPmuuz?=
 =?us-ascii?Q?ESZVFP5z2iSAHRYZj5e9P4wpjg/EboZLdTxRZX1DqZnof3h2Q9AkI/2dPXCJ?=
 =?us-ascii?Q?hRsdynXzewT6jsqDkqCDHYNnwu7EvE4Wjbfc4GP5XxgcLXQYnPnq07OGeVFv?=
 =?us-ascii?Q?pOrJSiDGTcgfZee8mazrfH1FBJL7L82pMvtQBN5nTpj9FbzU09lcWBj+dT7G?=
 =?us-ascii?Q?yGeZZ3Z+yUEGYYJvgin/K9WHBCCfcxEBUSPGm8voDFGjLqN1Ljn1nKYDUheq?=
 =?us-ascii?Q?fPQKmUnOLCwGwztKiNYl0PNJPFRcFn25AY+4t1L6PEKFXn18Zt0BxTKDSn5/?=
 =?us-ascii?Q?UgyMx1PoQBTCtNkQXvHjfwjNI7Fu7gVRsBlY3ySIpl2Bzbgm/XAIyxkyTz/Z?=
 =?us-ascii?Q?foq427gC2Q8GfaQyoJKjI6l/h1IWAuwJhpFTclINhqSISJZNQu5tOjJ9iSYk?=
 =?us-ascii?Q?MsZxaOUu1n0AgAtPK86ftFRlAykCM/2K6PC485Tjq+wiCSsvooHVoe6rO/OW?=
 =?us-ascii?Q?4gOcxKn8ij0a1z+qq9Ac7rJ8393l9Mq66AaKLhI97sRl9GjfNzaoVomom/ED?=
 =?us-ascii?Q?vu7I0Iv0NP0qWhaKZTxdOLQW0Brpj9ahSC2wPLzIglglIhjsNPx/JHKlxLip?=
 =?us-ascii?Q?FXf+8gdgTH4FMt10aSDMagqkEN96/IPkpe5b/aNQ9YWyecv2G6bJwk6uvWYS?=
 =?us-ascii?Q?8RtjbO9qCkooGgmuDqcE87Zz5WovCxqP1N6xU5I+mcKyYWdtej0qzXsrN6lz?=
 =?us-ascii?Q?18CqcZV684E+WZZETH87lZEEeMF0yAKFZAXLWci8DVIH/b+Id++jO8JcQrRv?=
 =?us-ascii?Q?wdcfD04x2EgGPHfOkztj4jVK9ZkIWbwaX9eFx7zZYkPOugpmR4rSzc9/NYkv?=
 =?us-ascii?Q?4InkTJy/t2Rb+PGflviGosEsb4Chi84O4mqN96q38XCUJ3wPfvdGGMAF+BoO?=
 =?us-ascii?Q?uMMnbL1V6rzl6GKZIvrVP4TJ/ywAJFoeg2ffLrWvR3jL3DaK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed05a4e-d389-47dc-1718-08de89a24481
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:38:36.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whaYnZfHarruXbW6w6eW+WmjamvGkRPzHFzaQnnEiJJjZPU2kxSNrW2HiLu6Ojwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

On Mon, Mar 23, 2026 at 08:26:26PM -0700, Dan Williams wrote:
> Xu Yilun wrote:
> [..] 
> > And I've no idea why unlocked MSIX/PBA must be hidden? How about other
> > non-TEE ranges, must be hidden or mustn't? Is there a possibility we
> > enforce DSM to present all ranges, then the layout is clear to OS?
> 
> Just to close this question, this was discussed at the last device
> security call. Indeed the expectation is that Linux will assume that all
> ranges besides MSIX/PBA must be present in the report, and that offset
> is always aligned. If / when an implementation violates that expectation
> they can help write the Linux quirk for that case or otherwise fix their
> implementation.

I don't think you can quirk it.

Implementations can always follow this requirement by setting the
offset to 0. If they cannot compute a proper aligned offset then this
is what they must do.

Jason
