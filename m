Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587062;
	b=SI6wUFUJkB0d0LdRlkrE5+Vh62mQ9XnTCiBW3gLffuFf+u505l60Vwxm1UXYCm1drp2q
	 Cxo3C2uP6rJ8BDwi1qYrHktDGFz5KdWoGRDe2Nl+qighS/XlGujbKnWxWpRBVhllmGFqd
	 Fo8xfIME2UPKVN3c08hMDvzs4bhK8V5HEolJ/a9L4RaWnKFH09FKUqLf2vyMC/s4wqFgb
	 /TQsGbbuI5euOwvz89UwMZyYVj9YhZOBNFyvrGxBUhQFC6Oq+W7dEab97BP1ZKfK1dnqs
	 ndUlOGJMDHgQ/8eGbgeqxU+zY3NR5FP+pAa1twZzm75BH3RezTMPL4w037TJhatkeuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587062;
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
	bh=KIpFVEpBEu2xBvDpQO79Fp5dt7iTRNV0NKLQchyLdy4=;
	b=R6c00o/qAfakWg0acwBKcoT1uPUnpuFw6tyhiMzZC8XejnIFNBtFg/yCor+U4BLjl4Qq
	 zpDUtimZqAHxNMzaK7Nk2v2lj4NepmkTtg78uSXZtEJUwN7aBpvIuA5kOcWU6oj+LHDGg
	 1VWo7qNxmThJRcvQznvlbZyOTEulA+ZZCmIsKQJ01RrDUGcjgOTkbgl9dY6T6LyDaKSl6
	 VPzAD6jfbgAaLE3U7+2CvrL0R7oLWCGusCYGpOaAuQNZBTH4jxU897hQxbJlUVGvR1Yl4
	 PyCIGWO78kUs8eEzGnOIOzSH9vduUyZvQslkv+wZavOV3fbr6wPGsNCIJ7jnDOXekCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BK8MXAmZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B1606BABB;
	Fri, 13 Nov 2026 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB7B1606BABB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BK8MXAmZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTjACv4QxQnOt+Ib/IF5tyEiWfbuY13DjY/B2+as/Bj/AaP/piKqEV/rDBj5eCuGF/VGTtCINqfFG+DW7VcyGCiiMjmi/xiMRzO9+cSDV76oqWm8I1w83mqtw4wNK8/z1qvcw468YAZATpFV+GaxowEwdW9K13jBiZrixeaRKUbQU4YRa7eii84yw3QTRAIIS5qEpVotIkdG35F7vQls7MDrtO2ftpKJkj21enoskdEf+WL6nqvzMTrKBsDVP+1x8pAKvJM35vf5v1S/FCEPbKIC6i6O+yI2G6QQD8UqUH03TS/3EFHOjJIbMMghC+py9hM4jIZRGtM+wdbOopML9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIpFVEpBEu2xBvDpQO79Fp5dt7iTRNV0NKLQchyLdy4=;
 b=a4jpuSsLCVyjv3kx8rlX1IHYHBIlyQvnY2puv+pP8X1yOELMjkyeZ9Skul7G+FUbSW21XHssvrs228Rnmf41exImMVl/WYRkqRsy5iynI/a9+Ky7VdrCy1hCg/ZS1bw2g2HBJkATSoB1pYNVNaAxlxZrsxsXEbSZLosF5MKTuuPOFz1JJhwII1ySrqWVN0z97Yat3Oj+DnxXocgBSfPr5ak2twboGImt0tINbL4OIAGMvV5LutYi2tLrQ+4yuiVao4+Quouvw75048HB9bHuOrWxoSD1L28Jg2xUe0XpMocAjUEFAeftYgADWWGR5g6l/QMU7RJTjU5KJtKv9mAA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIpFVEpBEu2xBvDpQO79Fp5dt7iTRNV0NKLQchyLdy4=;
 b=BK8MXAmZmUkThWnj4NmwTWvk59HGspHTDuPFfWit1ikLWnSxy/7E7mSxwYbx4llCqU+YGa4tzAuHVl0Mz9N5facBp3b9GFltLh+gY26lRX4tO6rrJOrw+XNieowXdzTmYV5ZzHS2g5Tu4sHFTPV0UoL/0CG2sM3Y3KSmf/JO4Bov/+G6veCXll9PaIRYccV4Qyef1uOYH9GE2Nj2bxuYBKJG1BM1t0yIEt7AYAMLviryPnB7X1Ren89Yj/88DpXIzWdAk+TCFgLS+Lc5RJvot2wPojobfd2j3qNbqZ50kXJWyX7hbhAgLv22eeBGNUnz9ui9hSgGkTi2Y69lc50FXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB7843.eurprd04.prod.outlook.com (2603:10a6:20b:235::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 16:24:18 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:24:18 +0000
Date: Fri, 13 Nov 2026 10:24:09 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v10 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Message-ID: <avc5qUSOUHzJXxR9@SMW015318>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-10-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113132935.4152566-10-den@valinux.co.jp>
X-ClientProxiedBy: DS1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:8:44e::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c8ca9c-2248-4b70-df1f-08df41a2911b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261022105027099003|261102123227099003|261026140227099003|261022115727099003|261022075727099003|261021123027099003|4143699003|261026135527099003|261021121427099003|261028144727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8b4VFSIsjP+XdLtHYVYL23xUnbC/lswE72rwsJIKPYWF1AudvhalpwafULaSNlRB+sQpwv0mRqEUt9ubcTolCmydnOv4x0zC28ksVWbdGWvn3aZFyZ4Dp7PxECSjavvgztq3hEc+s8GhO+YrzwP34AqGuDhUiodER+WjS4JLXwMDiK+o9chz7dZaYn4wwpx7QXVBXEWesk0KKBqzMl42ZgjrOCFnSNi860WhD8T0/cGWRFpARc94z38H+G13QgZj59RuCVcNzqbZVv3wJqQkHlpa09SNrhR+MMkpUu9yss1H2bOSmAo8XVRmgegxS406K+OKmDb4UuVc1CcR0rWOOUMdKK2E6V/BkiMbv9dy1NAzcbshJEAKQCBez7aYApr+SNgqBhtBcDGBI1LP3gNwf/banTB8ZwpFrDeY3cc0XQCY7Eq0jIcCx9Vu9tftzb7xUVA2GOqGtM0IWPZv38zrQTdeQutnQ2ou7FDg69G/CirN6UOxMh9OBie1owCYLiehc/dqgAHQ6js/RXBqpugmReBThbOZ98R4h8fQUA0/vFjXmjS/ZXjjMYkk1kh28e9BPTBAoQdqpQHkoixC5JzDRGksXFmg7/+Nfv19bUumlCAYObfolOyxb22KWILqvZPZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261026140227099003)(261022115727099003)(261022075727099003)(261021123027099003)(4143699003)(261026135527099003)(261021121427099003)(261028144727099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OQukg3hpSZKL5awhDPhUMa2l9TiZiWlJl9c9zeV/IqcsVmfvDQjxNhH4k0d?=
 =?us-ascii?Q?0y9wygX5ozHBlYbz4r6U27NcPaxDALnGc7N6D6ZHYUptdBAVXw5L9+ULCsS9?=
 =?us-ascii?Q?T2AzzNjfxWDSp8ez0H3877Yg9sY0YWgWEt3sdOQdmKxWSvFQ/GKGKRAckAIU?=
 =?us-ascii?Q?3o6thtglfsZeXnAIVcwmd3L48Ij64FV7kAPrD7TqEUcvmyPjZChizAJWIsxN?=
 =?us-ascii?Q?m7YdH4MxA3ip8ndJX4jQceTf4x2w1DaZZztU7ossQSkmAYkRHNQaE0q396HR?=
 =?us-ascii?Q?EQoTBTuDHbkYvjbwNZpNCifzdMNEi3HdZvYQNNl3YEVvfsibPlWSX/JXIpGt?=
 =?us-ascii?Q?WwsnPRofu9KY7m53XUd7wSzbB+cs2wJ7Q9vh6QdY6He+GQVrwkhFADCqV9fb?=
 =?us-ascii?Q?b+nHxUhTmA7oK0G4Q1SvaOxMQGUL5lsXxjp1XkCvaS8xCa4oBnSzC0BOdLT4?=
 =?us-ascii?Q?h2hDII1J4WZmNWvb6MSOpt8R5O5LFoWoqPLH6TUwPetiZqzJa6OsYwGx8zsN?=
 =?us-ascii?Q?wlEv0cXfmYDMPH373OFXSpIkOSC7IH2M+jcT8hCt6NLxbcBSyZRIeSTc5Zhg?=
 =?us-ascii?Q?6/0PyD6CPB9OQC8TwopqAHksaFpqFz9t6Fz7V3FPxudcp2JiE/51fy7rxNYU?=
 =?us-ascii?Q?dZwQoWyqTgsxP69yCfRdDrK5NUmHN33IbI8ZIHAITKk3O5G70czHp3yExCO4?=
 =?us-ascii?Q?qcUCKJVy6Hhv7AmkNVP5DwWH2ym6CYZqM8Axnfedkz4nqvxA2CcFCXi5ZbAn?=
 =?us-ascii?Q?LCEjI7AbvM17sFnLp59fKDPARSSFoQggRVYIeFQA3pap69M/HZD1a+q+J6wg?=
 =?us-ascii?Q?bv7xm+T817WC7Fcndm81M4T8xqSSJLi/ecdH1m7d3M9xfHTwnCey4rFbcRt6?=
 =?us-ascii?Q?IagCLMmnPq+2581F6SdIMIIxlbqueQYxzkeNCaFzGj39m48SKgWOgHRK2Mwu?=
 =?us-ascii?Q?nmFwTjRTDCH6hMDsaawz5QFQPpu4cC597w1W2pmCuWMU+Yo9QbWyLQ7BefUu?=
 =?us-ascii?Q?qMiiBm4FlQI/pVyqbAtXx6hjUXyfVQ+YENiZxc70esTTdHe3+n2/JwiwlxDy?=
 =?us-ascii?Q?UZuthzByrkZ7hd+LZFEs0dBXpe35l9CRzns47KeN54u9Wn6vWXVxyb2XvWPq?=
 =?us-ascii?Q?eoNn6ri1yjBfKVQfvb+KTmYwzsUPuZgN60wDwaEnLooP61u4NzUeMEtXNkdF?=
 =?us-ascii?Q?ritkHJ7TMnR6iJhPzEaWqB3O1uiHR2gonYeqAer1gB39+GT1LnA0vLgobf0d?=
 =?us-ascii?Q?fZnIDGQwoZzSe3+k4Vr3+KNP03YdRCOf8WjLgR2dUxgqMOCAZ5SlKlr2SaTr?=
 =?us-ascii?Q?ouDIuL3O8mfK2LQI6Y8csHVRUNefgbG8j3JczOZJ2BcuMyH8gXd4SSHaGSRh?=
 =?us-ascii?Q?+x4RHAkkOAMi8/blS2e1MgqTeGMAbBjOnxHrn5b5Hhpjsqz/4WBe+YzV3iBs?=
 =?us-ascii?Q?ZukypkMdg/gBOkghuxmpiHhXxhZyve8pwCyDktqDDxE8ISsE3a125PXFrdwd?=
 =?us-ascii?Q?ThyHAgQf7RTNNXriJRj5FmnG5iJhQ2NaEBUbdfCj3GKTDzJtbe/Vu6UEhYbk?=
 =?us-ascii?Q?89VFU3hX3FC3gYR2zBhx8eK7DEN86o7GckxJ5gK2N3XMTDO4rWS9NTxI2fIA?=
 =?us-ascii?Q?6FzqTs1KFrZNAagEjVMq9GiwbE2IeCM0DTynOKWugvV1xGKIBwTJF9o64sxZ?=
 =?us-ascii?Q?sHAyf7v5RI6gzROrv4WB/75gdb6fMCcYbXvYNJmKjtbbd3VdD4DDPM8Q+xy+?=
 =?us-ascii?Q?a1BTDfKbWyIahQpXyYrU4TNRwYru1qXZn3IPf4R1vI+7C+oPEikS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c8ca9c-2248-4b70-df1f-08df41a2911b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:24:18.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6kdsYFUT4IaYaNTqKjurSBIXuHTyDqWv9TDjACAi+UbK4vrCHwNsikqq/n7n9juRXVR43N8SUzM7TZbF4F67bXNW0VAb5/jjoSyKa9YxxvS7b2cFGsxare8/ko0DWNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7843

On Fri, Nov 13, 2026 at 10:29:34PM +0900, Koichiro Den wrote:
> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type, continue without DMA.
>
> All DMA channels share IRQ slot 1, historically unused by link events
> and doorbells. This keeps the doorbell count unchanged and needs no
> extra vector.
>
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v10:
>   - Use the historically unused slot 1 for a shared DMA IRQ without
>     taking a doorbell vector. (Sashiko)
>   - Drop R-b tag due to the IRQ allocation changes.
>   - Link to v9: https://lore.kernel.org/r/20261110082459.1798763-10-den@valinux.co.jp/
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 259 +++++++++++++++++++++++++++++++-
>  1 file changed, 256 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index ff92c2a61ce7..a70da2b4f187 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -18,11 +19,17 @@
>  /* Offsets into the control region, see include/linux/pci-epf-ntb.h. */
>  #define NTB_EPF_CTRL(field)	offsetof(struct epf_ntb_ctrl, field)
>
> +/* Private DMA wire extension produced by pci-epf-vntb. */
> +#define NTB_EPF_DMA(field)	(EPF_NTB_DMA_CTRL_OFFSET + \
> +				 offsetof(struct epf_ntb_dma_ctrl, field))
> +#define NTB_EPF_DMA_REGION(field)	\
> +	offsetof(struct epf_ntb_dma_region_ctrl, field)
> +
>  /*
>   * Legacy doorbell slot layout when paired with pci-epf-*ntb:
>   *
>   *   slot 0 : reserved for link events
> - *   slot 1 : unused (historical extra offset)
> + *   slot 1 : unused, or DMA IRQ if enabled on the host
>   *   slot 2 : DB#0
>   *   slot 3 : DB#1
>   *   ...
> @@ -71,6 +78,23 @@ struct ntb_epf_irq_ctx {
>  	unsigned int irq_no;
>  };
>
> +struct ntb_epf_dma_region {
> +	unsigned int bar;
> +	resource_size_t offset;
> +	resource_size_t size;
> +};
> +
> +struct ntb_epf_dw_edma {
> +	struct dw_edma_chip chip;
> +	struct ntb_epf_dma_region reg;
> +	struct ntb_epf_dma_region ll[EDMA_MAX_RD_CH];
> +};
> +
> +struct ntb_epf_dma {
> +	struct ntb_epf_dma_region submap;
> +	u32 type;
> +};
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
> @@ -82,6 +106,8 @@ struct ntb_epf_dev {
>  	unsigned int mw_count;
>  	unsigned int spad_count;
>  	unsigned int db_count;
> +	struct ntb_epf_dma dma;
> +	struct ntb_epf_dw_edma dw_edma;
>
>  	void __iomem *ctrl_reg;
>  	void __iomem *db_reg;
> @@ -136,6 +162,209 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  	return ret;
>  }
>
> +static bool ntb_epf_dma_region_parse(struct ntb_epf_dev *ndev, u32 base,
> +				     bool optional,
> +				     struct ntb_epf_dma_region *region)
> +{
> +	void __iomem *reg = ndev->ctrl_reg + base;
> +	resource_size_t bar_len;
> +	u32 bar, offset, size;
> +
> +	bar = readl(reg + NTB_EPF_DMA_REGION(bar));
> +	offset = readl(reg + NTB_EPF_DMA_REGION(offset));
> +	size = readl(reg + NTB_EPF_DMA_REGION(size));
> +	region->bar = bar;
> +	region->offset = offset;
> +	region->size = size;
> +	if (!size)
> +		return optional && bar == U32_MAX && !offset;
> +	if (bar > BAR_5)
> +		return false;
> +
> +	bar_len = pci_resource_len(ndev->ntb.pdev, bar);
> +	if (offset > bar_len || size > bar_len - offset)
> +		return false;
> +
> +	return true;
> +}
> +
> +/* DW eDMA */
> +
> +static int ntb_epf_dw_edma_parse(struct ntb_epf_dev *ndev, u32 length)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	u32 count, chan_offset, chan_size;
> +	unsigned int i;
> +
> +	chan_offset = offsetof(struct epf_ntb_dma_ctrl, chan);
> +	chan_size = sizeof(struct epf_ntb_dma_chan_ctrl);
> +	if (length < chan_offset + chan_size ||
> +	    (length - chan_offset) % chan_size)
> +		return -EINVAL;
> +
> +	count = (length - chan_offset) / chan_size;
> +	if (count > EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(reg), false,
> +				      &edma->reg) ||
> +	    !IS_ALIGNED(edma->reg.offset, sizeof(u32)))
> +		return -EINVAL;
> +
> +	chip->mf = EDMA_MF_EDMA_UNROLL;
> +	chip->ll_rd_cnt = count;
> +	chip->func_no = PCI_FUNC(ndev->ntb.pdev->devfn);
> +
> +	for (i = 0; i < count; i++) {
> +		u64 paddr;
> +
> +		if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(chan[i].desc),
> +					      false, &edma->ll[i]) ||
> +		    !IS_ALIGNED(edma->ll[i].offset, sizeof(u32)))
> +			return -EINVAL;
> +
> +		paddr = readl(ndev->ctrl_reg +
> +			      NTB_EPF_DMA(chan[i].desc_addr_lo));
> +		paddr |= (u64)readl(ndev->ctrl_reg +
> +				    NTB_EPF_DMA(chan[i].desc_addr_hi)) << 32;
> +		if (paddr == U64_MAX)
> +			return -EINVAL;
> +
> +		chip->ll_region_rd[i].sz = edma->ll[i].size;
> +		chip->ll_region_rd[i].paddr = paddr;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ntb_epf_dw_edma_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	return pci_irq_vector(to_pci_dev(dev), EPF_IRQ_RESERVED_DB);
> +}
> +
> +static const struct dw_edma_plat_ops ntb_epf_dw_edma_ops = {
> +	.irq_vector = ntb_epf_dw_edma_irq_vector,
> +};
> +
> +static void __iomem *
> +ntb_epf_dw_edma_map_region(struct pci_dev *pdev,
> +			   const struct ntb_epf_dma_region *region)
> +{
> +	return pcim_iomap_range(pdev, region->bar, region->offset, region->size);
> +}
> +
> +static int ntb_epf_dw_edma_init(struct ntb_epf_dev *ndev)
> +{
> +	struct ntb_epf_dw_edma *edma = &ndev->dw_edma;
> +	struct dw_edma_chip *chip = &edma->chip;
> +	struct pci_dev *pdev = ndev->ntb.pdev;
> +	unsigned int i;
> +	int ret;
> +
> +	/* Install BAR submaps before mapping the advertised DMA regions. */
> +	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_SETUP_DMA_BAR, 0);
> +	if (ret)
> +		return ret;
> +
> +	chip->reg_base = ntb_epf_dw_edma_map_region(pdev, &edma->reg);
> +	if (IS_ERR(chip->reg_base))
> +		return PTR_ERR(chip->reg_base);
> +	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +		chip->ll_region_rd[i].vaddr.io =
> +			ntb_epf_dw_edma_map_region(pdev, &edma->ll[i]);
> +		if (IS_ERR(chip->ll_region_rd[i].vaddr.io))
> +			return PTR_ERR(chip->ll_region_rd[i].vaddr.io);
> +	}
> +
> +	chip->dev = ndev->dev;
> +	chip->nr_irqs = 1;
> +	chip->ops = &ntb_epf_dw_edma_ops;
> +	chip->flags = DW_EDMA_CHIP_PARTIAL;
> +
> +	return dw_edma_probe(chip);
> +}
> +
> +static void ntb_epf_dw_edma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	dw_edma_remove(&ndev->dw_edma.chip);
> +}
> +
> +/* Common endpoint DMA */
> +
> +static int ntb_epf_dma_parse(struct ntb_epf_dev *ndev)
> +{
> +	u32 magic, type, spad_off;
> +	u16 revision, length;
> +	int ret;
> +
> +	/*
> +	 * Legacy endpoints place scratchpads where this extension would begin.
> +	 * Once the extension is present, malformed metadata is fatal.
> +	 */
> +	spad_off = readl(ndev->ctrl_reg + NTB_EPF_CTRL(spad_offset));
> +	if (spad_off < EPF_NTB_DMA_CTRL_OFFSET + EPF_NTB_DMA_CTRL_COMMON_SIZE)
> +		return 0;
> +
> +	magic = readl(ndev->ctrl_reg + NTB_EPF_DMA(magic));
> +	if (!magic)
> +		return 0;
> +	if (magic == U32_MAX)
> +		return -EIO;
> +	if (magic != EPF_NTB_DMA_MAGIC)
> +		return -EINVAL;
> +
> +	revision = readw(ndev->ctrl_reg + NTB_EPF_DMA(revision));
> +	length = readw(ndev->ctrl_reg + NTB_EPF_DMA(length));
> +	if (revision != EPF_NTB_DMA_REVISION ||
> +	    length < EPF_NTB_DMA_CTRL_COMMON_SIZE ||
> +	    spad_off < EPF_NTB_DMA_CTRL_OFFSET + length)
> +		return -EINVAL;
> +	if (!ntb_epf_dma_region_parse(ndev, NTB_EPF_DMA(submap), true,
> +				      &ndev->dma.submap))
> +		return -EINVAL;
> +
> +	type = readl(ndev->ctrl_reg + NTB_EPF_DMA(type));
> +	if (type == U32_MAX)
> +		return -EIO;
> +
> +	switch (type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		if (!IS_REACHABLE(CONFIG_DW_EDMA))
> +			break;
> +		ret = ntb_epf_dw_edma_parse(ndev, length);
> +		if (!ret)
> +			ndev->dma.type = type;
> +		return ret;
> +	default:
> +		break;
> +	}
> +
> +	dev_warn(ndev->dev,
> +		 "Endpoint DMA type %u unavailable, continuing without DMA\n",
> +		 type);
> +	return 0;
> +}
> +
> +static int ntb_epf_dma_init(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		return ntb_epf_dw_edma_init(ndev);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void ntb_epf_dma_deinit(struct ntb_epf_dev *ndev)
> +{
> +	switch (ndev->dma.type) {
> +	case EPF_NTB_DMA_TYPE_DW_EDMA:
> +		ntb_epf_dw_edma_deinit(ndev);
> +		break;
> +	}
> +}
> +
>  static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  {
>  	struct device *dev = ndev->dev;
> @@ -366,6 +595,10 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>
>  	ndev->db_count = irq - 1;
>  	for (i = 0; i < irq; i++) {
> +		/* When DMA is enabled, the DMA driver owns slot 1. */
> +		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
> +			continue;
> +
>  		ndev->irq_ctx[i].ndev = ndev;
>  		ndev->irq_ctx[i].irq_no = i;
>  		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> @@ -386,8 +619,11 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
>  	return 0;
>
>  err_free_irq:
> -	while (i--)
> +	while (i--) {
> +		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
> +			continue;
>  		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
> +	}
>  	pci_free_irq_vectors(pdev);
>
>  	return ret;
> @@ -610,6 +846,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
>  		return -EINVAL;
>  	}
> +	ret = ntb_epf_dma_parse(ndev);
> +	if (ret) {
> +		dev_err(dev, "Invalid endpoint DMA layout\n");
> +		return ret;
> +	}
>
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> @@ -720,8 +961,11 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  	ntb_epf_send_command(ndev, EPF_NTB_COMMAND_TEARDOWN_DOORBELL,
>  			     ndev->db_count + 1);
>
> -	for (i = 0; i < ndev->db_count + 1; i++)
> +	for (i = 0; i < ndev->db_count + 1; i++) {
> +		if (ndev->dma.type && i == EPF_IRQ_RESERVED_DB)
> +			continue;
>  		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
> +	}
>  	pci_free_irq_vectors(pdev);
>  }
>
> @@ -760,6 +1004,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  		goto err_init_dev;
>  	}
>
> +	ret = ntb_epf_dma_init(ndev);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> +		goto err_dma_init;
> +	}
> +
>  	ret = ntb_register_device(&ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
> @@ -769,6 +1019,8 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	return 0;
>
>  err_register_dev:
> +	ntb_epf_dma_deinit(ndev);
> +err_dma_init:
>  	ntb_epf_cleanup_isr(ndev);
>
>  err_init_dev:
> @@ -782,6 +1034,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
>
>  	ntb_unregister_device(&ndev->ntb);
> +	ntb_epf_dma_deinit(ndev);
>  	ntb_epf_cleanup_isr(ndev);
>  	ntb_epf_deinit_pci(ndev);
>  }
> --
> 2.54.0
>
