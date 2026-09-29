Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FE390CB8;
	Tue, 29 Sep 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691069; cv=fail; b=JM4b7on92PSu+l/ljh46Ak81WOu9ISYqh5JGYbSmat4Fw5vaCB3qzPYZWZbsCd9eP5fehsErUXTp42lM7UFWXD0Beit1UA86H5H9uPsByRCrdqzXUIG0LRQlJM3njqa5EVNA1s14RFE+sHS6XmDmPvE6+X8f3cTMIwjGUwS9goI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691069; c=relaxed/simple;
	bh=asqq9/toqGluyiGfFqtn1dYJTHFLgNOVf7XWkI8FLbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TypHPS9R0A8itMCEna+IupblaOwpORwslFtmnfgDlQZ/Y0fKx5ebOyoaF1BGIOJ8vLkkGu9u/OdUwJ+uHN7ba5zwlhnqIbu84vmaqsyV3gv3dERuKEknAZwD/A7fzZw7zueGdPeKBOW7gJdodO45e99LCJkC60BVOFBhycZCDEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NHGQUV+G; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NHGQUV+G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV99KNOof89Zgf5wDIo72LuHnl7HMA/Kzq5s7F1gD9VsqNQVza/vJE76xYyCBnB4spWVjD4QEv2/s6NJMNUuVRixEapn57MzDv1JtLB3J6gnwij/hVn2mOTR/1td0LgTtmw1O5Q6nvTJTupZ4b0bIi8H2ANRNtrfyvDFmUteJDj3/Hi4+OV/AfNdp+TLymmOSQIdD2ep60TaFpP4zHnPkqyLNUWlx3oksyQXJUMz/LpaA2m0WopMZU4HtJnQbOWY8ZMmm3t7T6QXPSZHPd9iNZZdcHvTbm58y5s7Bl/lqO22KxCbFHfRqetaVkxlbbj8FdTmk0fPOkMPy+CgJe2fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XUpHsILyzveB+qIb5Cs8GeMuh2k8Fkg/5YjVwZeCh4=;
 b=iwjQ6N1RP73vZWdP/s2M4x0NsqMF9H+6d+uWOpLAiOjPTnpZUOij60NNKJRqf7Ga7m7+cyIe567fmTSD0Pfx1uy3xX7u0pfjBTYvFDCehVBgHGDFfrS0oVB5vUnpGBN8Fuc+UHBs+pU6ac2XnMvpzXURXGAqdbnhyWs5vsTT9j0ErMC72YlsuWv8cYhPT5/Qa8i2Pt9rd0ua5bNdYz6sL7glOZ11GKUu72JsNKCfqfzl8gDSQy2rBSwgd4EAgp0PbcEsU9I82Bwyu9IB8paGzSIl3kwjroe+hL7w1XfCFTKwfjDRdupoMc2vEryjz+1x9o2+6CBMjbcl+TCV1vzhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XUpHsILyzveB+qIb5Cs8GeMuh2k8Fkg/5YjVwZeCh4=;
 b=NHGQUV+GGT54tPP3HbIQsi5qd8WggaqKiIVZjGdz7BaPWPNxRIjEZPUEfaDInJMsJZMXsfXXJ+fy0+stQ20j9+WZjNU5BjxL1J2ddlcnaVgoZDXpGzDIVJ2KXddZ1WP50vzI+I4r09ok9yJf1ySD3vZRphCzZMVTJKSheceWAr9pAkDGCy1OgsfslxSy43JnoGmsJ+7u61wfWXSG4ydLP0oqEGmQ+M4obfH+zorVTXGv38yKoN4zkdVHi59empTrGyG85iz8ihrtVVG/SiGxJFuR+HYKANc45iFz832HvO3ts5TFD1prD8ESep441DjusssXjTg70/1u/ts51C0fMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10821.eurprd04.prod.outlook.com (2603:10a6:150:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 14:11:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 14:11:02 +0000
Date: Tue, 29 Sep 2026 10:10:52 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: epf-mhi: Add batched DMA read support
Message-ID: <arvG7FpE7_6uAKCN@lizhi-Precision-Tower-5810>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
 <anTARsISvCPUA9_v@SMW015318>
 <szx7jctqp4h6yhgvhwmiqfjtsemwlu3iardtntp4nfc22u3bfi@ux5ioixmfdnh>
 <90fcc9ff-4ba6-4e16-a322-17ad8e4a51e7@oss.qualcomm.com>
 <ep3rjgc4idxt2ta53cebdzpqvyvvm2rnpxbo2ka3sqcmgqwdb2@cwi6gixldtxg>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ep3rjgc4idxt2ta53cebdzpqvyvvm2rnpxbo2ka3sqcmgqwdb2@cwi6gixldtxg>
X-ClientProxiedBy: CYZPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:930:89::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1a0cd9-781e-4746-da00-08df1e337e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aGl7RiW9iLDU8RqP5qD10Rtnqj/ajKqnjCiHgbiqFcYFUNlB5++Z6kFtu/Ve+2uVXBw9PmlfdcyolUV/e64CdEnPvhIdzShVWFzoALX3M2m+CXCpZ7cnd+5SsBkagxQsn85dJ9XnkqkzHDiztOJnqwumZoxF3lx2uVkCYTGz8x21wFL4sWSef07Tdd1qh2Y8QBqlRUSXObKN8yknDOzmeB54s71Y88JVlOmfPF4B0tlpKiaTloyr8SAhEa+HUVmyZIlFgRDeHFZ9qJ6ShOb2wdXAZX2Os7jrJgXoa4zUhMh2RY584pZ7IlYroKP90RYNBWDASyFBpiaBQBU6FPsZv0j0eGY3RPm9hRm4DXD8r/xNbk/6FhON2iDL4FnCAXEf/4p6GqwyTiWB3AejWCflPpgYo0DRMcs0pHlkuAaF97kZ/OI37NVbfq6I+wOt65OigNeoZervwQaYp0m3JiIUEsUlLXCVMzeqgAWm+yQ5XLQA57Xw5iiUU5pb+qG59HODc2G2QaBExk1L88RUTukJbeVa+3y2gJgsueP++VnEmhj74OkhDmXYk1a284V1sK3M9yHgLGU2O3eBjfbRtMIgXXoS0/FgKUnQwle/O/ul2nc7y2mE6jclvcsoKwh01nH0/WxJC/oykGRIMJzcET7J1sL+Ixwkw7qssrBKBh31J4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFdVbzQ4ZzBxaE0va0dXZWlDaVo4UEZ0aUVjNFFycVY2MUN1dG9jbVVxdUNq?=
 =?utf-8?B?M1FkcEdJTjNnOUg3ZmFFdm0yNCt2WGZWQXAxSHVwMHgzaGlXUS85K05QRUh1?=
 =?utf-8?B?QkxQUlkxcG1Ld3NBdzZNUHY3NjZDa05jQzRBZ0QxTFMvMjQ2REdOVk9NV2Q5?=
 =?utf-8?B?QmEyV0wwWitlaXYwMFFWOFhTZXBueGxjK3haR042UG9BbEZGMXZDWFM5c2M0?=
 =?utf-8?B?Z0MzSFhneE5sMXZqY0o3YnlWT2NJSHhQdnNIeW1aYzdVYWhBb1J0MVp1VjVH?=
 =?utf-8?B?MGw0NHNPTmh2NEluektRem41NC8zT2Jub056eDV5K1dmRmhPNzk0a0Y3cGxK?=
 =?utf-8?B?d2pxTENERk0ydm9KaVVoaG1kRlNOOERxS2diMTBlMUlXS1U2ajZMYW05RnF0?=
 =?utf-8?B?Nm1sbXJZY0paR2F2MldUbVo2WitIOHZQSXZuNjgvdzliRDlobHRrRHd0d2hB?=
 =?utf-8?B?M09LeWZ1LzdEQkxtN3JXaElZaXA3MTZWcjV0Q3F4ZjdPekVTVGNHNmVqbzBE?=
 =?utf-8?B?OVNvYmNsRy8wdThZUksrNEN2bXNYUERZV2tlaTQvQnQxbWUrckdQRjg4ZkZG?=
 =?utf-8?B?SVRKR3l2WmdIU0NTdGZCUnI0eDYrdGZNVjZGVmtmUjAzTTlJdHZERkFGOHVN?=
 =?utf-8?B?ekUxSWxSQnRSVC8rZGtySHNNSlN1dElIZk9zV01MRjhwQ0R1REFMcnRkZ1da?=
 =?utf-8?B?UzZPd3R2UjJHRWU2Ti9uVGJXSTZhQjNrcjZuSzJJSm1iL3VJYURwMlVjcCtV?=
 =?utf-8?B?ellXb0dINXgyMkl2R3hvZW1nR2ZVR1EybGcvODFseldNN29BdkUxTnlSeXlZ?=
 =?utf-8?B?Q1NtK0NkdmQwZFl4c1NwOGtTZTd5Y0F5M2w4bytqN0laU2pnOXdpajRUdjVs?=
 =?utf-8?B?QjdVdE4vcmhDWTkwN0JaQ3RuVFZ0Vkg3UXAyUmpvRklmcjBvUEVYQzRrVTJQ?=
 =?utf-8?B?UWExbnE1YjI5V1YwZ0E5am5qOHpTa3liMyt5ckliQTcrR3E2NkxrbDc1OXUv?=
 =?utf-8?B?QXp1NHFJblYvZThEOGZDWk43VCtBb29OYTdTTkhRWTd2R0hiK0JHKzJwSE9J?=
 =?utf-8?B?Q29TZ1RkaXowY2VpeDdGTlpOZmpwbjBiaGZ1dThUUWk3U3JUallrVkEzWWR5?=
 =?utf-8?B?SmVlaDlvL3M0NHlrVnFXN3Bsck8rS3pmWkZsNmRQNUp2ZUd6bWRVUVh5ZkVx?=
 =?utf-8?B?SmJQb3pEbmR2Q0xpUXBPVXl0VFRZRTZ4a1F0cFpyUzhZWU0xUjczNXl5NWRv?=
 =?utf-8?B?K3NWVWxFYTN5UFc2cXZ2Zmx5eVQ4Z0gzWElRL05BUkZDQmZHQVNIRFNycWht?=
 =?utf-8?B?SStkWkNkUzErUjQxOEswK3NqK2xHVm84RnNIQjhuTHErdVdmWG8rUjE2NWJm?=
 =?utf-8?B?RW4yMzVrLzJaUjNZejVncmYxMHVWYktIMzVoUjlnZHorUUhBUTU2SHJaV0ZH?=
 =?utf-8?B?RWdMUlo4VW9JT1l2NGtMTWhkQzZCcTA3b2t0ZExyZG02b2k4S0RuSnREYUxN?=
 =?utf-8?B?S21lNlpQeE9SN0hhZytlK2JIRjJBWUVnUTkxRmU2ck0vQnUvSWY2UzRKazFV?=
 =?utf-8?B?dDFrV2M3RzE1ZjdnZHhRUHZkMFMyc2dMdjNRV3p3Y1FuU053QWRtR2NkbVlI?=
 =?utf-8?B?MlZCNzJEVTg3Um9ZOFFWVDhXcVBvdFVpbXVMSEJvU2xaNm9IOXNGbFhTdkcw?=
 =?utf-8?B?MnVybXNjOC9wdlRiUE9oL0cxYmh2RVh5cjNzSmlqU1V5ZDhrU0VUL2RleS82?=
 =?utf-8?B?UVQrQ1ZmVGFkK1NzR1p6Qzd1ZVlzY3Vkb1lQNDg5Q0FjVXhoUlNVZUZsVFdh?=
 =?utf-8?B?WWdveUVZWXUvQnRYb0pESDM0dVNMUDNvTDYrcDFiOUFHTnpmZGpTZWErNmdF?=
 =?utf-8?B?bkV5TnZzaTRza2FhMGRBUUFSbldxUzdwWmg5OTg0dzFNT0VvUjMvRlJVWFUz?=
 =?utf-8?B?Um9oQUxKWkpCMGdZQWpINjhlNTh3RjlKNWJvdTVmYXdmSDdySWR5NFhTakhT?=
 =?utf-8?B?RGMwOEQ1U0ZrQ21BZzlvdU1jOTF5VG9aWFFYSEJ1RW1Gb0tsTHY3bnhNbHJ1?=
 =?utf-8?B?L3kwMHFEVG9SQjJieTlLb2JJeXluSE5mUFFaTW5JNWVMSFQ2eGxoaFMxZnZt?=
 =?utf-8?B?akNIOFdZRTN6aExoWHdJWHF2NGNuSkN2ZC9rZW12Q0plMGlwRXBGY2pIcFlP?=
 =?utf-8?B?TlAwemRvbVEwQXNPN3prYUdoVG9LWEdkQkJhQ2JyOXVOazU0eUVnbENRbk5D?=
 =?utf-8?B?SXQ5SkVFUE5UUnZjVjFsRld0QS9OeFUwMXVhM0JVMFArN1VYeVlISlR2RGVi?=
 =?utf-8?B?cE9ldXIxelJRMitva053TlpzNEpLdFJvUWltTkg5TjFrUjc3OFpKVkRmK1Qx?=
 =?utf-8?Q?8imWvC75Jbo1gpG+cijPNgwAikcE/g4Qaro6T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1a0cd9-781e-4746-da00-08df1e337e08
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:11:01.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQVTK+XpQ2uJwCCvjDYupLEB6CjJUizUvWjS1JuhvGe+f5aipReyLqk57fLl0xTLMlRPM4UDhL5K+55EFIWOZbEk2BMLXtybETGZTMf/eLRV2WLxZJrR1SzhmIwOMNUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10821

On Sat, Sep 26, 2026 at 10:49:04AM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 15, 2026 at 10:42:39AM +0530, Sumit Kumar wrote:
> >
> >
> > On 8/14/2026 8:22 PM, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 06, 2026 at 12:11:34PM -0500, Frank Li wrote:
> > >
> > > [...]
> > >
> > > > > +       config.direction = DMA_DEV_TO_MEM;
> > > > > +       ret = dmaengine_slave_config(chan, &config);
> > > > > +       if (ret) {
> > > > > +               dev_err(dev, "Failed to configure DMA channel for %u-buffer batch read: %d\n",
> > > > > +                       num_buffers, ret);
> > > > > +               goto err_unmap;
> > > > > +       }
> > > > > +
> > > > > +       desc = dmaengine_prep_dma_sg(chan, dst_sg, num_buffers,
> > > > > +                                    src_sg, num_buffers,
> > > > > +                                    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> > > > Although both side memory address, but as previous discussion, which is not
> > > > memcpy, still memory to IO space transfer.
> > > >
> > > I agree, it is peripheral DMA nevertheless.
> > >
> > > > Maybe enhence device_prep_peripheral_dma_vec(). Actually eDMA still split
> > > > it to small trunk and linked together.
> > > >
> > > By enhance you mean keeping the semantics of device_prep_peripheral_dma_vec()
> > > API? I don't know how it helps because we would most likely end up with two
> > > vector arguments and duplicating scatter-gather lists.
> > Frank can you comment on this.
>
> Frank, ping!

I understand your requirement. It is not easy to handle. EP transfer is
actually it is two memory space (even one side is IO space). two sgs needs
consider offset is difference at both side, and total sg is difference,
which is quite common, dma_map_sg() can conbine continue address to one.

At lease need help function to easily convert to DMA's description list.

Let me think more.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்
