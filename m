Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFA39E6D2;
	Tue, 24 Feb 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949395; cv=fail; b=jW2spuYPeMw03e50ORrYJJ0BJ9vGyJtmuwg5al5Bv6RXzegJy8JTj3Baer/ZqmtV+5zvzSJK41bnmP2Yjwd32XgF2Gve4RzBpdQluRD03niDXnXKa2me5kToVjsUVoHBPkYWHpcC7UAHW7Slk+Z1f2SRk3L/Fo8G7wSuZvZUrV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949395; c=relaxed/simple;
	bh=NMlxAcBZLSg6lwtEP6aHWdpV//mirF/xD8RIytRpLow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dd6GUXohUddIEnXpDVkMICqyVF7ipdH/I9S1yiWkluQG5juXVWMm7cVX1iASRbqApf6lc2P9pZMp2W4Anzw8EfS+YhuzPYOlp6kwWTB+44uyI4xeG2UXzuU5oJNhIj8bblHVhJS4A7EIxJKVkAkzUX5EDAT1YTNwIRa+cGMOudk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stxyZCoY; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stxyZCoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1ilCVs+u4y4IxLwRSiKNq0isOtYX2N0g2KonPnRImKmNqP7/tk9j49rWYHUdszA0YKsHExTk9y4VEDdaXPd4IHkZf836vwI0xlV3lVXqi3gYihqRKnKnbSOhpzOn5+k82CIngLGZa7NSyJ7ACmDLg3axKumMRmucTv9Z7OmUSX/SoFLq/idR7UpaR196y+EcXniqOBXhg/297ldGPF0Iy4x+xjxlczqJXOn7Lalf3KuNhTIfD+8L0E1a0VQa8ta9TzQyJw1g5W63T6LDINzjo0njHn9KHHfltHSN/xzIzPhtDDzoQkuFgVYgBAjURvOB7wUI6utvVUYZn7SYUKWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3BvHJOJ7zYJ/CXj6CCXcYeqj4nhMy2QTecqdAznnWo=;
 b=N35APj1Vx+VESukoAdV8kg/xEREgFY2hSUjwvIaifJ0VXfFfyvEIkeIXoYK8Dk3yo4pQj3bb9X0AJEe9u6sC52x+bcTciMm38TfIcDjqiIPkZjk+b8dk5oW2p7b2Zmv4CS+Rrl7qZLa1mJG4ADHN6AwQ4NBEwO9EJXGbLcyslWGayvhoEpwZEpqVrMBZ3n+TgwtSfLClyTs/viNMN+FqRKh9C6/2o6ZpY0AsLxpDYA8nyqnn9QaWRBIQgaZUUK+zY0gn6kMK4VJ3De41C7NdEO91Juet8JVs+d4z4in/Rw23dbVTKCNvaIxT6Yzu5nRvmEnwU9OHLS3lyq/8vFbs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3BvHJOJ7zYJ/CXj6CCXcYeqj4nhMy2QTecqdAznnWo=;
 b=stxyZCoY/uDzOo9nlyV4Rwx5rfEB10F+zzqkRcieznp38dqSZGUteVzq6c+TxRQcCPqEdA94QNJ2e5ACqTRmnRoV2MfmIkuGnRXXZ3Z41brQD6KS0f8x2wQyaK9/qE8NIiobz0dblbRZYFD89s9BlE3ZYKlrVVqT2bq23PTRItLesFnpBh7NDStZH2BsSyjeBHabbae8i4lYlgbYpSZxOSeOl9guCHal59IV2QWPh8fciBIDZiqQDZuScSD5LgvjmmYnvE66+GNvh2Ap/x3CuZC8g0D9TQZdNrQCm4VWZCfO5ic0ATsEcdTmaP5Q64qBWUjOdCGhwhI6MEeADZ4wNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:09:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:09:49 +0000
Date: Tue, 24 Feb 2026 12:09:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <aZ3NS4GhxhElWhh2@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
 <bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
 <20260224120615.00003ad9@huawei.com>
 <aZ261odHq5gwQYXg@nvidia.com>
 <20260224155742.00000282@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224155742.00000282@huawei.com>
X-ClientProxiedBy: YQZPR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: efdfe9c1-b393-450c-c974-08de73bf22b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivhZcxGOrsxZloPT1MGPAiP+H0CQo5YXHmGhH24PSI5dB08OIU6e3FkVj+B7?=
 =?us-ascii?Q?c6URukVLDgM4+kNh3euhbfqHF4GdK/zNrD7xk4GL3oIJJ1uSc1UM3doUN5m4?=
 =?us-ascii?Q?woVPA5PU/erh/JXsHmBU7cMvb5H8yal2rF9Zx3R86b4SHp2kYDYxvhf911br?=
 =?us-ascii?Q?YsE+0r2zAvvrrchkgnG7tnJdP7VN88nJe3C5pk4Zk56kgdH/vaYVtNOm6ZLG?=
 =?us-ascii?Q?Z3cewkviT/OJ3XlvUjDaMW41feDNNNiUUB2aPC1HR3MdjW6uE8X07a7clu1D?=
 =?us-ascii?Q?Cm6Q/PZFxvH9x/rlkPNRNw/fkY/0euDka+xOeEN8e5mwbAdGwBqd0emuGNj9?=
 =?us-ascii?Q?nEKwdh7CHSn4FRYRdrDsFvaZdrd0vMP3MhhgaxZ+GJP/Nv+mMmoTimlBYhrf?=
 =?us-ascii?Q?1xTvCkTAVzF+1AJjZ2/dKutM9cIq6v7tUwDIaNv7nc5bhFq0OX2KkmHKLBjv?=
 =?us-ascii?Q?QXiIfCmqFOdQfKiPqKMq2vhlhQ6Ge8h4UKzOKJYtH02F6vLNaOtK7icbIHrU?=
 =?us-ascii?Q?GElw2mU3gPCFwDe3zwy0PPAzOjMUjQQER3oUC5Otn63I5YAYIZltOFis3keY?=
 =?us-ascii?Q?+LReAWvzI/Rsi/4LKyLAK/wEY05cV+ueW3TF5e1n3b7BRXIM90rgQtL+RbG1?=
 =?us-ascii?Q?zvGyLK6664KD5pTHXc3IDXTMiOyBZRTfYTUdEnd2cakCm8NSWOQZqXdmltWo?=
 =?us-ascii?Q?anDnfLnYUfYbBm0LaVAGg+VKchVt8YaTbQcAEuv+YEoB7bPAIwlKRdXVhSHV?=
 =?us-ascii?Q?DOxzdzdC4hJP6Y5tQNr3/sb83UjvvMrcgWt+z48cQmXFz3dgAkidGp6Zss3P?=
 =?us-ascii?Q?k13cclaYFFiPzo48jXNuthgipLjEGc5KQvE0rPY0PTuTcA1MG6Gwdu6x7vio?=
 =?us-ascii?Q?YZzLmnC7Ga3eCJEplvR0hmce6x+wTSEMc/SdTwurkijCFVx+uU0++Gahi0R5?=
 =?us-ascii?Q?Ft3sEnamZIrIWKHNuDevc0P5RGg/T5217W+Sg+hj5n+zCJuKfdvv3hFJa27v?=
 =?us-ascii?Q?hvn8x262QtyOeZNAHLPrqSi3pXomSqXf+gIgnY5mltmJqwPl4F+5uD1rRsxf?=
 =?us-ascii?Q?w8AWK/zIBn9rY0SuZ7OSPstueoB+unMzs1oyv8dJHOF9hCvoyUQHx6W55FJt?=
 =?us-ascii?Q?73P13HAfSweANdxstLcRKc9uOGi8Fm2D71R2gTZ5dMevmnnAIk7uwOkiZZfz?=
 =?us-ascii?Q?Ipg9FRGOX99fvaA+2qqXBqZNo8xhROJgOycMXj/qm7g6x1dzZQf7uYY9NwaA?=
 =?us-ascii?Q?a0JWQtvWPTZh6qYLUM1IRhsvqPvIRQraWJ7mF2Q2j/SF8HeAaru6jo34F0Pz?=
 =?us-ascii?Q?3o58meuaWysxhR7493sAnhc7XXln2obQYZ/SQIuIT8E/4hcmyaBXCq+2dPA1?=
 =?us-ascii?Q?+HStHXmVAxhrT/tz2PexAPcawqGH+iqH+1QLJDIahonhXWEb5VlkI1kLGY5D?=
 =?us-ascii?Q?/yEemI1oEEx/9EWgbj1kZhioTsPOhLUTU7RhwLcXYa+LftIACzEX0gQaDqJ5?=
 =?us-ascii?Q?9cITocEw6AmVt9iJq9SA3Cl0/5hH+G47hwE0SU9hOTqn2n6KvJcnTN+tique?=
 =?us-ascii?Q?Nvu8KtkqErMdWNEVTH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/LMl0IEZIcn3av/+H28rzQ9dAUBtZy8tGKj/tsm2+j4K7nLziO18s+w6sGg9?=
 =?us-ascii?Q?ccXyDsnpgX0gOpZkMSlmAF+af37rtlMYqaDbKnp8gLYbtn8DkZStRpdFytv+?=
 =?us-ascii?Q?68ocUr3fZBJ/EL58pxxyYv109Y16hoii04QDouAu3kEvF9L8VreVSvHhrcyG?=
 =?us-ascii?Q?TlV9p9RRq4webCyJvUejOHfhPeyU1yLnTtUmwLGWDuM/ifzwN80bJZlFwyQn?=
 =?us-ascii?Q?0SY7ULftLzUsaHoMjoEpLmiChBUbo9/dG3+bJ6GeFElMM48CEaX7yR9nkCjZ?=
 =?us-ascii?Q?rultKcgceGJVYomwvwrgGw918EZPYlqjboaW8mNCXbEuFKgqqGSUPOVfvnc4?=
 =?us-ascii?Q?i2zJzU5vNKinVrHcDLpLL6Rp5mRAWXuog7c03SVVlwA9zNcXTJIPcQwVN7yf?=
 =?us-ascii?Q?A0HV/sSgoE3F6j3vELp6QxEhAqBhwazFT63xURs0ReI4t0qsO6XQwDBAYykx?=
 =?us-ascii?Q?3d+zFLn/9yNQdXx5RqV+oWttDwluxfBCGwfWknyNcBdTi7PqajaAu+IP3cMd?=
 =?us-ascii?Q?84om3LIgmEySqhS54tQeAQt0Gc5Ny0/ebqPOm0GvUaxll/ilY67A1Ehf9j7k?=
 =?us-ascii?Q?Q8vVTUfHarYwgyIwmlALwv2x1R5yzzqEGf1PbYRUiaZrt2ACvg1/nnmd8BFZ?=
 =?us-ascii?Q?ZyvddfhwwC46Cf4kErkXUDcSZxMh3ZIZTBNKa9Sqnu+PcFI5OjNowECnKMub?=
 =?us-ascii?Q?f7raT2fFOJzZJfcXEgXBORQoI9ZPvkjdI0RK/30b3CrzzHVMKKPol1MxD1nO?=
 =?us-ascii?Q?WM+ukE/Pjh6hXBdSAWlsvOtG7e8h+Xgvn5OuiJ2vSQUq2rD6/xgdwXcgjEws?=
 =?us-ascii?Q?TA/K1mcE+4C+9lkQbFx5yRAvqOo5OtmQVnX/3DuEMeM3Mo/p7kS/NGQmYyR+?=
 =?us-ascii?Q?/oV5qcBe+T/HIc5YdAZonMeoRUCw9FIgKcQ+L+H1A6uOC3r6LnJDBR1cS8be?=
 =?us-ascii?Q?KH3laBE5IoymZjvD1m+ZhOjREQZD6U/yqnvpcqqsErJk5s6AgQOGSYaK06F0?=
 =?us-ascii?Q?opAp6ewRxBAVQK9rh012oavsmbkehlyxcPSQwiV0nzgg6+svlzhSrhKG353H?=
 =?us-ascii?Q?wE8eWMxwrM1OBOw+S+T0TguUEZUEv5WwTnvSro9LyxI//O5i0/96OjFda8ut?=
 =?us-ascii?Q?RkOvgzv9wdOuamREDTBPmJeUoxalgc40MXWiFiqFCUw5gsp/R01U0U8Ob5VO?=
 =?us-ascii?Q?Vb6et0BzUGJq3Uf3wC5SCtjLfeS53hfk/f8CvXUJwyR5MnZO/C8alFxQqPJ8?=
 =?us-ascii?Q?biwVipJ0D2Qfz23ob/AvoLLnxJqflP7VKauAoaiZbVPqUwIPKKkz7JKrBzp7?=
 =?us-ascii?Q?hhT5WAPssEGYB4hqKvUJ8KSIlOFhC5/R90T7o+byEMvpYqHNjrXBysS/YmfW?=
 =?us-ascii?Q?hYic47ASGd+FPiaZcZBzVYYzTvo3iU1CqPWZTMOEDpCFvEtrCEfAvDlTRtfs?=
 =?us-ascii?Q?+Ht3CewG/1TlQWUkMHhs0ZivrkUv+WOrC0dT13YHTOAJLPauk0qZtrWM00r+?=
 =?us-ascii?Q?ppFtFSC5VeLlOS0GyzMM4OWXXykD9J98xNjhvwdIzWsJo+ueKsXRl4JXhYde?=
 =?us-ascii?Q?h9hgwfyks15St3Ya7wK+tz1yEOivjt2Jff8AIko+gwWhF93902H/KR3BIhJ3?=
 =?us-ascii?Q?flNNb6CTBSJDuZkRqzS9jNzfMdB+2mDk7hk3IGn83b3a3kQey8gnrm5Y2d/7?=
 =?us-ascii?Q?2e7y8BkL6DLosae3zOuIDYP6aDsvH2o0yYJEjoAjJ3v9I55znj8GLAbz7dU+?=
 =?us-ascii?Q?3+hyY0pl7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdfe9c1-b393-450c-c974-08de73bf22b8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:09:49.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYSZU9fEkR1ibbh2L59yq8I5JFd6hNu3YNYVXTOgSGU1Vsuuqj8CJNBLJ08VG3IA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112

On Tue, Feb 24, 2026 at 03:57:42PM +0000, Jonathan Cameron wrote:
> On Tue, 24 Feb 2026 10:51:02 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Feb 24, 2026 at 12:06:15PM +0000, Jonathan Cameron wrote:
> > 
> > > In my head at least, it would be nice if a driver had to explicitly opt in
> > > to this behavior. The presence of CXL.cache support for instance doesn't
> > > actually mean the driver is going to enable it.  However it is probably
> > > harmless so lets go with this as path of least resistance.  
> > 
> > That same remark applies to ATS in general, we have no idea if the
> > device is going to use it when turned on or not..
> 
> Yup. Understood. That's the bit that smells bad to me.

Do you have thoughts on when this is a problem (aside from device
pre-acceptance security already discussed)? So far I haven't heard
complaining on this point..

Jason
