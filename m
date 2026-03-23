Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB226F2AF;
	Mon, 23 Mar 2026 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285431; cv=fail; b=Fs9NWSM3atYR1FElPFnsnScJVEuObNXcHXadhcBcxwtthArwDlCqKfNaochMLHobH+dCzxEXAOvGdxgQfw45x/apCKq465BnEDip8DNQv5iHdXRLksoaCm0Nq+xTFpUOyEZJSkIjs8fTIV0S8251aWYp2r8RrcV6TwTTygZeQS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285431; c=relaxed/simple;
	bh=ljYPRTSk20S5xHpv3Z8VAkfh+TrfPwPq/NtYxy2yaaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQul9Ft1TvPtczK2odTLM+pxlNOtPNQoraBATcYF+OnMQalVK5YgDmmUT6bUAk1PHIWAuuqN9MXnXOq+gqYKSTfem0/OpbMgjG6x5Rew5tTOTbJbRVMfFdVxEk06oMltt4oxv+g4J2pMFo6ZlNn12+FW/TfvdJ2l+FPd1t/UPDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GSR8jqdV; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSR8jqdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm3kEe7dJuRQf37PFm6UKYLmiumG6Q78WPvPkb4+obmEZ/i6SQbpCZ7J846Ou3xVTctn6cG+LAqrIiIhoepA0MKRK6rBp4YuZN5jT/qwfMok68KxLiv3SKHXGMEe7jJE/25qwdfzw1+LKjUvz+Cy95KRTbe6g+7NJJJfe+b/uXc8I1FXHElSV2BZp79F1kFnxNP4JccGGHsSzX5g3LGzaybSqs7K2o3040LIoMyakPwzH/yD70LI+QMcztIngkKkAT71y572X/v2DIo+Iw3eSncqfQQIo4UR3GjiQ56gEaVIk4a/eZRHdXSrdHvL43vhUDc6n1o1y91WOEYrhEWJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8AdHYodac3gG9Nzw7ng0cZerdFj5MrX3BXqehhQvG4=;
 b=kg4EfMK6suLZpWKI8y2QI1Fx4KRRo3RDUGPElPzt2pZgLRT+9/Wua5ouSOprdezkvm+mlwb7oTYemiGzMf0evb1egZrU8pONdJNzPNPT2l4QsjsfRNFh/j0nb9wwfkdq5HbT4J1SqGWQlKKrlm3WltINoyyBkhkS0vxedVIbhMr5PjrZuzZAtnGf3kGEkwisd0lXPZels01+g1yO6763YXQfCnysnqUNKNurxb1FsMo5tb+ClVNIdmW8umLUE//P3vfedDnCklzmC4rdMgz0hUTTD3qSSNLyZqLNQ+1wtaY9joUyvByoG81fAnyEV5PMv+y9TbG7Up4RYflwFHTbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8AdHYodac3gG9Nzw7ng0cZerdFj5MrX3BXqehhQvG4=;
 b=GSR8jqdVkDibK/rKtaPH2NRZuL3yWpvhrgxubHSwOFEhZQG0ReLVSeJ7Xsb27lctfahfZTJA1UI3+NeiQcfmSrLYTdZKK/fEgXy34VZQMaghKSyKgFXyqQjB9Qmf9R02GHe4xl4cb6tn+Bf9eE0emg/Ukxk0ZDhvq26RiU1natWDdz+9fPfm0ZkiD1vTKrAzPvUEP8QnTJouwGOSDgYPQhIFIAIgzIjWmdjCWenq8bFcgFo3FS85drcJcE9dMlPOY/gGWK+7suEj3Spcz9/HsDj4gd1FLC3VtOrViMWLRN2ngObBqYsqQSG7noiR2TbxtixiE1RhUy77NlfEfQmIBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAWPR04MB10053.eurprd04.prod.outlook.com (2603:10a6:102:387::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.29; Mon, 23 Mar
 2026 17:03:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:03:40 +0000
Date: Mon, 23 Mar 2026 13:03:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: pci_endpoint: Skip BAR subrange test
 on -ENOSPC
Message-ID: <acFybL8PxlvTeCZP@lizhi-Precision-Tower-5810>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v3-3-4780f296a5b4@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-3-4780f296a5b4@foss.st.com>
X-ClientProxiedBy: PH8PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAWPR04MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d397bf7-cde3-412c-f099-08de88fe21ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	X+YidmmOGugmmO//vfD91DhskZmqsROAds+qR9zYyqgao9MtVx2EvEVQvgzEftPwWI1Zk58ZFMbtK9O44v4YywBlSwfnb9PBDSumFUcaxLK086nr6/4uvNeJ9rkqLjN6rV8DKKWDcv1h1TUn/1C3SpAZK//aJhvD79KzcIMIdDGsfu14lFL3+ZBrWV/Vr4khx6nOHKVxhge6LoBdZaW1+KVlSETKi89TB5ks/iSqIHARLiQfiJjUVLxmGi9fb7DAEtpNN2pR92jw1I+GFA4nVUp7vSq7ft2/kKZtHTfldwfJ5v2C6+2ET0jSGC6gWCvWiUoW2hzx6CM5sOmzZ5mPHRjs+K08UAhFKpjlUYLF69z3njIjYFQwP9rJgWTpXg1ELvh+TZDmOQJKgvvaWemAgPoDaaukJfN5JFwUhCHzpIobVIA9WOejfKG812746dKz+nsSW1EP9zykuXMqslc5vzbOLfOICsKSkuiQlFKBdyY06sE/a8VpCwkwibT0R4tTZtXwGvCRr2plcPy7VmT71iJupf4LI20IVbjCVxI8qfxYalDiYP6h6OroTsWel4o18418p0+tDD8siPV7TWP/l6zm52RydUFK5olGJR15QkJ6THXD//Mc9mguzzE1KecQAGeFQzI1AiLG77gqB78/b9MBNOonlN5Ga5UvO0h8pBufm/sp7QESebffUXCA3pvcpAeUkBY5+H60ynTt4JO1QeFn7XS/I8Cbc6OjhzSi/GrWJCl7Otkc+wHdeW53y35in4AD2+XFZNpBDhYS9jyIpisGn3Em2VpQ8EQ9aW7gRIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrNv6xEipBUS3prU+PlmfmRjWRp5NSkL4pfb65Q6slxLBJ4N8ZOx5kM5Tx1I?=
 =?us-ascii?Q?GCQbOEsvXa9ZZTrs75pxYKd9NIAp5zGRx7oJWgMluArBFFJsXB/9vURsJN9P?=
 =?us-ascii?Q?betikLV1SN3irjAeBR5diRsJOwHp57zxsAK6A1GFXvROMfeIErgOgcSog+ZC?=
 =?us-ascii?Q?O5ilKcuV8wDg7XoKFORgEfuuVgvqofGDToqH2tHVsyzq1s1uXPt1eEHAarOc?=
 =?us-ascii?Q?IGHTB9a9gJUrX4LVzA9f1EJIw8/1NdtGiTtkQOcpDtp1UbUbiE/CBRR9J4Hv?=
 =?us-ascii?Q?ynF6SHqdBNgb1uD9Q/IsaHanhF4hBEgtDSF+EsihCMFZ4CUniMVx8QzGbr5P?=
 =?us-ascii?Q?klmIm3McpdAkt7HURRYjcGiJojtdtEwlGKlp0MSKTkpr7SR4Fe35L9hiqFkM?=
 =?us-ascii?Q?3Qt9bRLnFUnNFrrJCk/W8+KbmDo7bmFZX12t8ha908EtMPazUFv2gijlA62M?=
 =?us-ascii?Q?AOYwPJRtXvcQDcqaANZwb3poa/4rzF/ojszhuz5KgXlMCAII/BO2hEYs/ZZ5?=
 =?us-ascii?Q?P3Z6Px5OzC23UZll50XT/SoUd+oJactjAZSZMpSxj8hvgEuHc54a2nCvlrw1?=
 =?us-ascii?Q?jxi/92siCD3W8kHv8p4rj7/kY35q5fkW2uHlzyNbvouXsFH2OlZOyPRQzjAa?=
 =?us-ascii?Q?MlFXGrqbdX4Xj2wYsjGk2yc3Nr/Mi3OWNYaHPyLhHAUzbfmbETzaBi80c9Ll?=
 =?us-ascii?Q?nFjx197mi9ZC5Thy2JZ5k9+PUyZSqGt4ZICQVsneQm1gxLKhAlAgd8h0noZQ?=
 =?us-ascii?Q?NIfj8EHLISn1EF2EORCDuRYkWFisUx4ehVx6Gjm9qD7Ap0qDXTN/02xpmv11?=
 =?us-ascii?Q?iZPd1nTdiX5WqI7W8x23T9n5jbmUSoDtEGIWS3iRDfaXUMDxUYe5bjllEjrO?=
 =?us-ascii?Q?CTAkQbyf4KbTIBUnfMRwHmpB+5lsr2UTW3xnx9sriShCdICZ6EKJS2fMbzcq?=
 =?us-ascii?Q?aZDdC81Etq+DDrnSAvCY7KYk3XVWgsoGwfkgDQTSTrU7j9YJhQcRgcZbewk7?=
 =?us-ascii?Q?shPsCd816nMXpemIynZ0s9xTQD1oGzUyJ9a0coQ2us5Nu7yWgnvdoPvh//Jf?=
 =?us-ascii?Q?7yfu/AOa5be2D0A9WnNNVA3x9v+O/oLDa1Z/t+ZzYcqS5ZmPdNUMwVR5q8Rm?=
 =?us-ascii?Q?NP/1NjQP45e+FNz57+xKQTfMiRuxd6ev4Ev6GBsVagZ2lx8ih7rPsMqyza2y?=
 =?us-ascii?Q?fM/GDJWOXIhUKQPvHvDs+X3SmHCRu4otbdlO07DfeNpGupp246xsY0zMQ+GP?=
 =?us-ascii?Q?IkPaABNbWKrVWMTyFMkMMQV4sZ9V6rineTvSNUMSBNpAFSvSZL0myKNnMOZ3?=
 =?us-ascii?Q?T58xJP1H+bIeuTymtUseqxHra6tK829Ay7pZwuoWAKsWho2Ckg+DRHasstLa?=
 =?us-ascii?Q?A5Ib5Th/wFdNTAHNfnGDiAFHQl451xMB4WpcO1gDaXgSqfndKg60BjyVkgx4?=
 =?us-ascii?Q?bNOaPJ07ffReZXTZj5xxm7lmc+MeDNf4E2tCmB7cj9dPprYsExxMHpA9lIiL?=
 =?us-ascii?Q?U9kVHNMjwmKf0NUy2zAx+3ZyK6KQlgtkSkxMI+1L1XyKc9IsM4UlXw1mGOmC?=
 =?us-ascii?Q?cxbN/g8t0q+v6AncWN3R+QABCfoVj846/OkJdkGzMmxSpBPwHGRH9HRnpeuC?=
 =?us-ascii?Q?3VhYoXgtsXWeix04TigpHAJB2g71M87PkjqB21uLejel2kDlNnX/9gBlpuoU?=
 =?us-ascii?Q?oYUDabTNJ5+GaqIHnY7YuxT4IdOnhdhk3cq+ySPnKZpgUs0W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d397bf7-cde3-412c-f099-08de88fe21ca
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:03:40.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+XNPlY9s9zHTjGUj5JFKOC/7MnFx6PTtjxQJm5vHIuUI1nPmV4jr5RtfvoEY3+EIkS1dg8ihXjBzGbsgkpzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10053

On Mon, Mar 23, 2026 at 12:59:29PM +0100, Christian Bruel wrote:
> Handle -ENOSPC error. Skip the test if the number of available inbound
> windows is insufficient to map the subrange.
>
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c417fb3a198b2d92c3060938c23807cc8bea5573..588d75c97ad181d2f8e84c9b86b865439152e20d 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>  		SKIP(return, "Subrange map is not supported");
>  	if (ret == -ENOBUFS)
>  		SKIP(return, "BAR is reserved");
> +	if (ret == -ENOSPC)
> +		SKIP(return, "Not enough inbound windows");
>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>
>
> --
> 2.34.1
>
