Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256C21B192;
	Wed, 25 Feb 2026 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052874; cv=fail; b=bhQn5easR+7LqS3iWfd5hKS5JJX2G5I5kD5QJzi+StTVfdDkcxT0lvnoiTCO/PIYiZYNDB0SeOIW+Eqav+bUCtAx4z3sGNtRryeN7hByznara5kKKAQ7J0EX/9kYSBiN0D/7pMWp7Di33BO3fzImYg4Pvour4boJ5RRHTSNFXyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052874; c=relaxed/simple;
	bh=mhC69kXTnESShkP6a8+M4iiFes1VegIs3ZyexAM5Bug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GoMBiBOj+XsFM8/nKqFPepWkW37j7QYhg+/4lw+PnDB+yYwCpx6PWcmAuggrk/ELLkqOgafrB3Gkd0Y20QfGQOv9u84GYWSGH1KR81iyttwlI0C5ntnFRXETlLHGEPKbU8JkNXxfcnrT31DcXrzgjkpp0UD5aefVhE2FrXXpWwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nso0IM/l; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nso0IM/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM0qnZoVZF+8aU0RWePWOqmUPSLGRQS077e8uxKyzqDkQMXR/3wUmR8L8UmpWXCfgBF+NSh/4xyREqWBKDS+ue0C3jQlxMXUq4y7x+zU6o757N/VXNq0MY5vDxLQHm0XhpmdGCtgBtnBPhe+Ph0sYfwipcUOe6h3vK3wvhvRIUcftYhrBdzonvsYmOkjCwoVUZxI5ov3zzzxcPan53erb2W/0xIpq3wcZAERNe6/rm1gJQgVYR2YJ2EufNlo/RFX8c7h4eAaYU2K9IKEwC5iayAkqYV/4QUNHRTNsZ7/rhgBi6I8TMvMZMhO+DIo+rmYpdx/8P37GSOnTmnKDzGVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhMeIbNWzfpyfJgwsigDgk6r+U4ElG4y+22ZxLURbdM=;
 b=VJ7vabCwvOwAAmhDVzeuTKOh/Y9SoXmjya0VTvGpPtNmu1eFCQ6VqZcDBwddFJgb5JrsT4ubkszv3UKMBAXbX19YCd6hRy42DYLwnf5faaAw7tCP95XFLW8ppLqlkXtPopbpqTQ0pQk2Slj11reDdzpLvo8f4VKa6UxS1G+9km/gWDPxvuE4f1XZ0r4jZtIPmGwiwUbAE/9c1ZwAJUyS63REYqFv1FbGC97bw5ez981hupdYc1sfxh3LmQxvneRe4SuR+3uoL8RrxaoKQNBCwrXeLpVe992+6/2ilRNx2+jkTS+ZPfsAsG+SfkCJzz8+subVVqySAGkbq1XS9Q4gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhMeIbNWzfpyfJgwsigDgk6r+U4ElG4y+22ZxLURbdM=;
 b=Nso0IM/lzPj1JTMRgdydfK6gRx7rzDXDoYvl8JX4+/tavWPj2aumoC+PzjEfOMXFZG0J0jtXMcVy0hosmOog/U3kihN65dNfgotA1o8uOzHYUQ5nyK+l0kIflXnGlcJaBba9PlJkqHNuj9S0K8VCA9r/5m08Xuf1O/j7Al7YgL4OYH5a6vzFHvtqrXW6635jxOIOgLINaV63l+lIiEzq7pzza2EgYq1t7BEpgk2gAzRdrUpngxkQsXhzOyfxCV8y12T0BXh0YuCnzU/6NnmbdcuADntjg/2wVTYtDLoSPHMt9QA+MQsF/qNyzyM6plqenMDZTRnYN9a7xC1b5FLl/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 20:54:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:54:26 +0000
Date: Wed, 25 Feb 2026 15:54:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: kishon@kernel.org, jdmason@kudzu.us, mani@kernel.org,
	dave.jiang@intel.com, allenbh@gmail.com, kwilczynski@kernel.org,
	bhelgaas@google.com, jbrunet@baylibre.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] PCI: endpoint: pci-epf-vntb: Report 0-based
 doorbell vector via ntb_db_event()
Message-ID: <aZ9heHxFL66Z4raB@lizhi-Precision-Tower-5810>
References: <20260224133459.1741537-1-den@valinux.co.jp>
 <20260224133459.1741537-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133459.1741537-4-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbd24c6-ca89-41dc-cd89-08de74b00fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	BvasElAtAPAP4bh+TKgIlV06NR5L3VrY0jTX5VKIreTULIC11yFCM5nvLMDaa7nQGzp8zzIoXutXV/k5XO0fedIZskmQXCXNDPOkmbtRCEB3ocDuLlbahG0gQlnG+GElKuRXd6FsCoYXZG1T6OgwDCb5QpzjEOkbMLgWjx0zG2YJ+lo+IEjyLgq7cMK3fNdrfK4PpsLrWjx2LbgPQkNmks19LvBYLKUt6f5CThgwBkMNR0lkq/rsaG6MI8Ek5vbaA6p+rA1JfI9E7VjXpESFnYi3ap4azJeuD5+kDUoXRCWag9FKB9ThJjJYcf8D9ExP70GIDUyz8C/IAxv6ORU5BzgzmuXYqmzp+USb0jsDtY6yyyhtRyZWJswVicX3ZsNpGs+fQ2P1V2kfhtpLtJ/z8UTQvF7KdhYH58ydU9Hv4iU5yaTmQS3iiDe1uHfHvwIc0WZvUzY4fcpIqI6+OBDwJbW6M6MVEywztLYVQrc+Qjsw3IQqrc4rw2+XWZTgb3CSPAGBqRv+7l0P8aj483k27QueZogGR8Y6KgMcl6AQL1KGg+8vfCTO/ajP3auOc3F7Xw8VGWUkuedCMzaZkqKjUBbrkIqiyInIqdPD/6cevbMj3fSqj4AdA+5pdlDAxcdaBmOId0jtHqNLh0rBjqHSc3Rb0pyYfe3Ynnt1sQ5MRHxsSpDdKFn89gmW4NbHoHgMq2mluUA6kXVmqDiawFiHIR6rEDMaS9hR9iKyrNFurVxsy6oK1I+Ze6j9hRVvgCnyDMkWipkFjfs6aAVBCtbOakVMEd8oKqG1nk8fGTYVl0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrD12VKDnWQjqNG5uSE2w0rQVh2CyL6Q3rYLdHdpXh1Jeps/a18H8I2TkcmV?=
 =?us-ascii?Q?SHLsmZR1Mz5z/dZyqN5Ko0sstQwXxjQdkyRpoqBlJAVm328nblnGqfPMxS7o?=
 =?us-ascii?Q?/mfdZe9UWgQara0IEKP+DEfYcnG+XYc40AFiug5O8JdKxVnHG34mjIAz7pEo?=
 =?us-ascii?Q?wCVjtXFEYJ7Q+4QZpcCiPgu3myqKDjRUhTrM73he32bzQLMwv4Wcuyt3VKwT?=
 =?us-ascii?Q?5XYxkjpL397MBRgoYVoKJvIjjfhmdEy6sJm6YNWyLNsUIUERDYAy+nL0KiLq?=
 =?us-ascii?Q?9YlfhsJeA//YA04QYwxOEmH11uYs2SSgkcUzKd91OaGfPbbUaIx7JjeFcmGT?=
 =?us-ascii?Q?lYHHfxWRkWuXA9zc4vs+h/G5ZbnmFbQjTAeHbPBOO5jbblNmSB1HEZRM7Evm?=
 =?us-ascii?Q?z3u7gm1O20qA+spJF3OkLfZj6wuFLNrqnrSv7Q9POXVgNvP5WYbjMvPvsh9V?=
 =?us-ascii?Q?nV/NgULrS3Jx668OqEMhIfJkDHEBUCNW1Bbuq8U0UOGyu4ozGXf6mwsdQI4V?=
 =?us-ascii?Q?c+rqdnTbuyATiGZFbtwcX+co/cBGvX9SJjD/+Rvz8aM56Eg1jJYMZ2AuOW6/?=
 =?us-ascii?Q?F531XxNLbrHeoW9tRRuDYOv/4kBgE5CXbHpx/HZkngASk4EmRieCflZPP9aU?=
 =?us-ascii?Q?XDa4FYLq19AXGIlvs1c3tjZQrbmR9viRZerg0eZBordVEitUJo9qgrwoJkHl?=
 =?us-ascii?Q?IufbcJk1YVDcUdeJ5w21Howdw968XEXeYoPANlVdTr5yJz8CNLIHggQKi0F4?=
 =?us-ascii?Q?pLBti5/YnrCvJfWiBkefnznFq+3xDbUPNn5M89bhUEyLXstIWs0G+P5WXSB+?=
 =?us-ascii?Q?Ix+zob1a8uU01SBaLvwIDgtVIfhcZToGdopDjX9FZff7vaBtgSVe8mDm/Q5N?=
 =?us-ascii?Q?Cy1pYRtPtOvqyZRUZmRlFHntnAWPe6ZcBRRhLLSXagqeOwBPMyLJeUepAqAi?=
 =?us-ascii?Q?PEPYA1TgnlB5hOPXSoGSYf6EsZ4BS7laYE/CNvu3MMlhJ70jOSOGojGRFtGV?=
 =?us-ascii?Q?K3M+zW1369qZfEbzSmKaEWjocJMmXKmI8DYwujYY7xi75EeE4/e3uzm3kgOm?=
 =?us-ascii?Q?JqixypCHzqbEpIAVDhSG1giVrTQKEjVg7chL4oMhI4HNbzsTCLH5tYYxLhXG?=
 =?us-ascii?Q?JbmE3THGPgXK7QHjhHKo901Uiyr33j0WouEeb4ucmazfmxDnEO9u+OGjgUbY?=
 =?us-ascii?Q?InPw+ekpiz1ydkI62/231TPcxKa5lFpzR4NcI+LjwJd+IRU85InZ2qpGGgMe?=
 =?us-ascii?Q?Hz2ihrZ6rDYP0OG2zH0jK+Y43fz7mTFN1420RH0eCZBNTouux+sOjYnEuQWn?=
 =?us-ascii?Q?w9X9o/Nc2wsMogIJWm9pe9q9i6Omp2USk/XeaLdleMIf7jTBOQrD2nbQ2tzu?=
 =?us-ascii?Q?07hS9ksuQjTV5O/cJK2BfyGXwMC7LTzSW+gz/LNhKdyaVzlWESg8t8eqG9aM?=
 =?us-ascii?Q?zsvt32hdxTcxBvMG+Of9IuaAB5MqyUxm3uN2jHN7kmWRKLW3EYC8CDScCkT7?=
 =?us-ascii?Q?TsIS0fEnB7t2F6hpu6//ddaQxCjQMMcIFjsAAAJpxzOecnpM11XcBRH0iGa0?=
 =?us-ascii?Q?0uaf9GS9PfHwGboLKrxfo7z+x+BS+v3DLClVZa5DJWmHWvdPuFgqhwZ0YuNN?=
 =?us-ascii?Q?zMN8Xhfe9V3Gmen0fpuXo8juZ+n7CA2UiLpZLlQXdh09Rigr2c3v3U7vmBRx?=
 =?us-ascii?Q?M57xG/0G+1Y8K7NC8ZD2yodL1WFPMMwKPlhSGdcBn/Gibgmknc7NXG579hOC?=
 =?us-ascii?Q?uKOARTMbYA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbd24c6-ca89-41dc-cd89-08de74b00fe7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:54:26.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1A+iazscvHuaakgwdnBP6est6hlsrIsmcBp1ONAaQwP/HcrFuJHo+5imJk8N0RJa/wCc2MeMOjEqk2pBoDwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328

On Tue, Feb 24, 2026 at 10:34:52PM +0900, Koichiro Den wrote:
> ntb_db_event() expects the vector number to be relative to the first
> doorbell vector starting at 0.
>
> pci-epf-vntb reserves vector 0 for link events and uses higher vector
> indices for doorbells. By passing the raw slot index to ntb_db_event(),
> it effectively assumes that doorbell 0 maps to vector 1.
>
> However, because the host uses a legacy slot layout and writes doorbell
> 0 into the third slot, doorbell 0 ultimately appears as vector 2 from
> the NTB core perspective.
>
> Adjust pci-epf-vntb to:
>   - skip the unused second slot, and
>   - report doorbells as 0-based vectors (DB#0 -> vector 0).
>
> This change does not introduce a behavioral difference until
> .db_vector_count()/.db_vector_mask() are implemented, because without
> those callbacks NTB clients effectively ignore the vector number.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c00898ac8269..cbce50afc4dc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -266,10 +266,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>
>  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
>
> -	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
> +	for (i = 2; i < ntb->db_count && !ntb->msi_doorbell; i++) {
>  		if (ntb->epf_db[i]) {
> -			atomic64_or(1 << (i - 1), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i);
> +			atomic64_or(1 << (i - 2), &ntb->db);
> +			ntb_db_event(&ntb->ntb, i - 2);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -335,10 +335,10 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
>  	struct epf_ntb *ntb = data;
>  	int i;
>
> -	for (i = 1; i < ntb->db_count; i++)
> +	for (i = 2; i < ntb->db_count; i++)
>  		if (irq == ntb->epf->db_msg[i].virq) {
> -			atomic64_or(1 << (i - 1), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i);
> +			atomic64_or(1 << (i - 2), &ntb->db);
> +			ntb_db_event(&ntb->ntb, i - 2);
>  		}
>
>  	return IRQ_HANDLED;
> --
> 2.51.0
>
