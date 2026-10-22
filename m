Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792695049;
	b=EEGXf/ivAdxT2piGTIfpwoULbpwzXi75ebTkTz4/GgHHWCCA6zeTU5Ic00S7AbO7Faof
	 5D3EigeUtcYEO8RgIk5ZTG4YPWyAbtE4k1KyyfgsqwrXk2LT4fFRzUKwiPQvKjUqA8bni
	 5mBZQpAsbhddJ76GvtKPaTOjkajZNX7V3UMrWoSo2qcc51q5vCepOekms0al9uhbsnKsZ
	 LO8AKM6/GC+WKMAjGnJafma6LKmE8grYlnJqjy8utRtHLztiircIF63fxTl77q/Y5uGZT
	 Tvgu+cvop3U9XSsKZHiFfbTuX29+UHh9RU6fbC/AQ1xNFzluzcQAmeNKx2GP8K9YYUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695049;
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
	bh=SXssp4o7lowZ6lzZvocU+0yBUrAlU/2wFDVrGbf+5cY=;
	b=AGJvWG/FZlK+KTDyzxUE6rQFqDTGQIoHBUGyUbyQFQkyCOfe3upY7CzTWwIB0DNTFV9A
	 BQtS/exmZb7f3+BUk0dzGwywoHVVBkDXy6xfPmI2VfjSoOSwMCSs5cfRfCCF4LUhV1OXo
	 aK0nGhFgdC2lJhZrMTwDdDasTbXE0EjQbiFeyvEvmYSFtF6hWl/U6taGBn2i1n1zxHnxh
	 jgljY3jrgHkRsbP8NSrPzt+eeNCTGbhE+npiBZE5WJPEev4DagAmyrxR14HY1IOdQEDDz
	 lkz2LudJCV4XG7wm1rZ/jMczlOVkF6yTStMDcKfyZXM9T7RVx9u0AukEVUr5TRD6bgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FAk+9CQL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.4
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FD606A31A;
	Thu, 22 Oct 2026 18:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FAk+9CQL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIShblDn6XtTqYPJcSg9VBKgH6e9vTHYZ6oH01qp0Yxms4uit/jxKzWFo5WFQK2Vm1Euo9Ef5OC0uINdvX+oUkCYwC5t6ZNmhJ5EWr5BGUS3MS5kZ7SgNAV3w9IibNa7/SU0ZKn5Pvj1tHSsAJBpxlZXxLekJZ0fP3JwXQPhoohbgJLkYKWNsLYPFeD8VSzED1Mj6ZyEUJiNBddcdguugjqjWypUVRAMgE7rs1LC1AsrCEK06YOPgCPFNtWMbBNyewOA9wTSltzdc5+UMK1yzejBNwAhqO8w5+yJh+2O42BcIBH2by7MmiplEHTImDcuE8JJJkavvnl8viB0z9DJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXssp4o7lowZ6lzZvocU+0yBUrAlU/2wFDVrGbf+5cY=;
 b=SNOXvZdxfIgFCl+nxH6sSVKcYLRqnYoYURo7NWYWfsOJntOUR4bbRha9N821z2hBmAeFE/iSMhxG8fZ5e2V6fGKXDAy5vdb/XK8cPdCi+j88xMGXNdanm4bkAIHuBnwNu8PLo5PIF9jvvt0GAFANY+UvgbGUev5pUquyicJMsSOQjrisSt7ti+QDdDtkfjQL/HUA+XTKva8yKHLQNrw1lSNTMTMSlGOldnv6Rx9IFiLmffYNd2GfsYLjLFtVghZCjX1P0hUqXPBCDvXd1FGPQM8PrysQewFPz69iGlsLGJO8lK+lZpEWzdBO0MZhFNEq8QAmhD0NKagsx5n4QTXqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXssp4o7lowZ6lzZvocU+0yBUrAlU/2wFDVrGbf+5cY=;
 b=FAk+9CQLqew5s0thRfkA5DIyIJ/522lu1sxOJgGbrrGQ4TZv9uzdq79rxGm554iZjBwj0UJeIkjLO8wqJYrp1Mubq3ypfbEjZkUEuRXpvsIaprWzf5nLr+tQQZ7YoHWi+67gH+75Z0fbPKMlVTDT9VSLWq7OdNuSYFUypL1+nMw3DjkdLhZwaioy+NUMNGMM9Gvm6uhDX2Kf848BEHK2PKaMUrOE+oTibjSi6L69QFy+Ssqm7dtrLA4En45jGxSw/FyIO5JbUtWodw9gvrkF5yj40OyoaStkIWpJ0cUgS9JE7Q2GoeNTUpmzIAZQrXPDEKmlEMaTz2mbh32WTQ7eCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by CPH1PF95694F931.eurprd04.prod.outlook.com (2603:10a6:388::3ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 18:50:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:50:45 +0000
Date: Thu, 22 Oct 2026 13:50:35 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
	Niklas Cassel <cassel@kernel.org>,
	Aman Gupta <aman1.gupta@samsung.com>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests: pci_endpoint: Do not link with pthread
Message-ID: <atpa-0Ub1fYndTpg@SMW015318>
References: <20261022180022.1282641-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022180022.1282641-1-florian.fainelli@broadcom.com>
X-ClientProxiedBy: DM6PR02CA0152.namprd02.prod.outlook.com
 (2603:10b6:5:332::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|CPH1PF95694F931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b08662b-17ce-4e14-2e83-08df306d6195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|23010399003|261022105027099003|56012099006|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jSBfv6gFnSxcGwG2MZVWuBIHYmn5wRhsIplRlm/o+49dnLkMfG85u6YdxJ7XSu7aHDd/M9NGcmul9Pq0RD29JSybsOc1KTmsNpcP6fFGp8N1qZRIDz/2WZtNMwpP7cmmpTOm3gZGOI8rpnVyHSo0HzVyEgSDl2cnH+yUVLLEGnSwVts/mSEwoT9fEpEQzklObAV0eoLaafOTCluHbLDQJgSv4TP8QT6BOXYgr7Ckzd2SVXdzwA4EKmz2YmXWiMa3zvkEcLDrKoMoAsM7AsPS4QnZJUFI5Cum1hw9sjAGOdDPuUHzaLI3TQ0LnXm4ovMJrQf9vmpf2o2cxK01paGe83wjhyVGtFcp0oLWFzdpnJHVw1mQ7IjkOy3HMbQvEDsyEc4JJZP1hyWWhtxverXMBv5if8XgFQaIOTvXDKoGBnLxvHhEznzlTY222U5+MOnHbBqJU5cKQw0YkyR/co7G0OgypfJ2+2IPVlV1GRUwYrF7LwyHxg4mXsJhjnEWObKazc08Uqz41TI8eM9JHiYkSe/vdlFvUW1/jrzDApXyOYV3XYRgDhMxii8KV+9EDTs31Ffd3dqYQlgkCKyCZQLlvoY5QerBJtyUhM4vGiyJ+0u4JDU2I2j3mRN2p+CqcooQ3+xWYHZRYOGnCoj5Y6GprVKUDwAYfe5MJ/MliMJVbRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(23010399003)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TA9UAkpkgFtme5LvgqwJinFwtBdpdOz9kz2JOuGXYVPHzPJJ6WF+3EZQlYoA?=
 =?us-ascii?Q?H2WBOwhKFEFra30mJXp7JesTSmFa2yxkbBiz+S+zFk7Jj35GL8NJArri+1Tn?=
 =?us-ascii?Q?upYIqUrJZ4clVUb9jQw+0QkSabLdMLCrJPSPMtcKzd8s0I1c9ndiNTHGalxt?=
 =?us-ascii?Q?lFXq8gRttBA9kdUuZiPOHGcj1RHjfSbBdfM2DND+n3R+uilEYuJbUNDiAv3L?=
 =?us-ascii?Q?xbvFLu6sQmK7xty5Oz1zMzridQfjrJcwHiMM4i/IRwlTPto964Q5Fk9x5xf3?=
 =?us-ascii?Q?Ptl2fMFc/zoLkVpw5aaym1re+f8zeZAX4exSRWMHUKrjACSAysA5Nf/4n6zT?=
 =?us-ascii?Q?byF5OPbLiU0DooJXmi5JAqLMTUBUQPafrOXKjk10PndZ9xJu8GFRMfUlEa+8?=
 =?us-ascii?Q?ir3RJGDZOkvxWIrc1uqKVPJ+JAIdXJ+Ec2TYh/xB1DDP+oEDq6QQ6eFE21t6?=
 =?us-ascii?Q?DsLhUxR9MIX1Eytv/tSuO8Q8ET7+TgKehVB6T4zCTgzza82q1AMXgsbW/ett?=
 =?us-ascii?Q?UxMmjq6VgtAfIOHhy8DfeYUGhgBFT20poYS8lC2nVXqbvw/E2A8L6xdT92ib?=
 =?us-ascii?Q?nmhmiZh8dQmiyaUmSyd9tONSzPIf9l3AyyGuy0ZxPIRuyBbyG37cGV9CrPw7?=
 =?us-ascii?Q?erAmrHc4kAM+G5AD1BZ9EU1bgTlUQ5HqXJ3huhtbRXOO/uuoztO2jESSF1ib?=
 =?us-ascii?Q?LGOROPHgjrsMfA1cP/nhiyD/xBxgPeyVT0DEziIyaMqbrIifbAV0QYVY3w8P?=
 =?us-ascii?Q?Gxk2lXf1gJHyekkdKDLrIwBeNDlYBWwW+G6HNCiJA/8NYD9GVqbwlwL63sdp?=
 =?us-ascii?Q?abqvxsBdLIEUe5NR3xNojhYWlVfwK5PG4BH++5zILOh8Rt+NRZn7gwqPUZGH?=
 =?us-ascii?Q?zJNqexMCfWHeVqGDZc9r4xKYLHcriC/7SMPO0W7NnUCCixWxOmTRh5fhti99?=
 =?us-ascii?Q?QQsQxnX2C9s75Fq/mIvl8NgcyD+vrLqMICyeYnLhweLD3mYkZMM+dwm602At?=
 =?us-ascii?Q?awkKEnHCaNVtNgsqhNe/+QrMj4ulI0nueImuAO+sz4c1EHuLtn206/Yx5uMM?=
 =?us-ascii?Q?+sNbIZkzKEmDVeOOiWhpnJ+FenQs8IpnSU95F60gTRrvjk/N4JVcCctXzaku?=
 =?us-ascii?Q?LngdYl8E9aHccfXGmf+vbHdM7Rl63PNVHzM/SNDEE1iqMZkGhzYTp8QToNPM?=
 =?us-ascii?Q?AywIsBjlNI8HFYn5sfsm4NB0wqXa1yC3LAUrE2AJ80fS6Ex1yv+Hg2I2FHvH?=
 =?us-ascii?Q?cZE2TZ7FFbXXUCoxd5kZ7uweFDUjFUZD9lWcOJNlGJMMP+q1wao4OCd0LB+u?=
 =?us-ascii?Q?nouXbQWi3qv+UcQRUi/+LJNBCQ2CpyV2r9hiqmMH8jRqkL23gLmfUPeJ3aDA?=
 =?us-ascii?Q?u53sh5tOfPr6PnOBajAoaYOvraE/wwu/cvSLaILAqe6m/iR7+SU00/u+Kxnx?=
 =?us-ascii?Q?OLkhXK90ILyCj9dlmTqnLqHPKVw3BTyqESeURPuRDeiJ4PAwi2Is1NCzn5nr?=
 =?us-ascii?Q?hBrjDv5k3YDIj9G/+NhhPKFPYJwhtdqCceWMOB64r5Wiq/5htjmtlJZ+s4cg?=
 =?us-ascii?Q?5i/hKKx9EhEdrLv003ziHs5e+39RpvjaCqr6Huk9nyst+P6zCBGlbn6W0Nyl?=
 =?us-ascii?Q?JE0LApCP8uSEwkrf/3OoK2sgpPY0q3H4vplPfYts8aJ4KzjSzhOl9Smr7qy/?=
 =?us-ascii?Q?QPePme83qLbMy9s374zokp/WrQ3anzA8eAwa754LzKaQxwaDa9qnOM0P4Y7I?=
 =?us-ascii?Q?eExFQx/6BpKOX4yWZD7N+UOYCDiEhhhxjWa2JA8/9iJrC1w9c0NK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b08662b-17ce-4e14-2e83-08df306d6195
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:50:45.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VH5gBvBObTXUKh9wvNAVhgv1nWmjLeaFdBtOrKQsmWZK2O8ME4NtVgIo+R+bGKHwPT9/gjfELRpw7z1+K8wJCYcfFs994WM+RkW1aoRqaKQhQE2j2SNBAKSaBMDQmlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PF95694F931

On Thu, Oct 22, 2026 at 11:00:21AM -0700, Florian Fainelli wrote:
> This tool does not make use of POSIX threads there is no need to link
> with libpthread as a result.
>
> Fixes: 392188bb0f6e ("selftests: pci_endpoint: Migrate to Kselftest framework")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  tools/testing/selftests/pci_endpoint/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/pci_endpoint/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
> index bf21ebf20b4a..b4ddfc52e79d 100644
> --- a/tools/testing/selftests/pci_endpoint/Makefile
> +++ b/tools/testing/selftests/pci_endpoint/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -O2 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> -LDFLAGS += -lrt -lpthread -lm
> +LDFLAGS += -lrt -lm
>
>  TEST_GEN_PROGS = pci_endpoint_test
>
> --
> 2.53.0
>
