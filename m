Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE61254841
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369681; cv=fail; b=buDX08JnKFpqubdme0tpJBdaVV0+35xR8COBKwiDOPKYfj9Qw0Ghq5+I1WTyD4C8YhgB0juO+nuUB2T4nQvryAAg025U4jobaCj6+S3Ndf5uyP5fVWatgLN6HQYbmftn3vmOzel7/Uo1xmbQqUvXOwqQ6Kg3KrTiT7GmHYPVx94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369681; c=relaxed/simple;
	bh=ZjnyebJq0g6Dls2O6m2KJhvIER9c36mEq0ZJO5IQktQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HjuITx3mWUe1NaW3y571BbJ8qMAjSa9+NgkJDFNFkvwIi4MU8DoGn70Gr4rsjPw1bwpgtDNWu1YLjs3pURuJ86+DucRjy1kQtCpl2ze5EgRD+7QEVijsZXqWc8zEg2gsEW1LPKmJX5aN6kK+5Cca+SHsLl+IjNNUWDeW1H2HCO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wdnz2mUz; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wdnz2mUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8ZNBoyHEirZOdMM7Q3Yd6VAzN/PTPuGFeI+8509+iuBC6WX34lWavbTLLe9DCWTmVIipzjoSylkKyuR5POH9/9+WUDGNbCqmWgsD8vhypAmIkftZaEXSEQ+NXkI24w9dcf+GPvbQx+UsJcO7elYr7GiIB/vGRsCXYDpt9vrmqN82LuEBBR+4iiL/v/DB2vwHV7+zgrs/5NVk4RubfIRp5uptF6CoxpHxFFR/jghY8a+yuFgLWkHEGWBbYJghCKMnsup2cRDgVYym8K8dRicgkrB6fXBIihSQYTZuoT05R0D57aUHAl7H+zQApP4i7KWRY/oAgr9GK+ZajKH6DUlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+efdQweXP3S1CWNuZzR+PeMePxDZk5UrEtRi/CPqRq4=;
 b=rEGW1QyLbN8ZBdHaqgJ+1zCbSZS1Z0+BAPvAlXYxPnJnbP6mrwZNh2MeuV13RzAAWLLha8Plms1re1KI527/2kwIrSUj6lx1LSLeclad24IWsNtn753iteIgLiZ+6S3BQ9drYwnZPnmcXyXIpBLvzq64hAGzTSW1BxEo9/EtSXcZginELN3DYLPARg48eCIQfJlWHlbx7gZl9vyRTzgIDSJAEDZBDNjobrtHggYMxqN5onqkK2lC+NqWx8niKdmfxBW4zkADZXIp0wx73rAygHce4Cl5y6Hu6JgEUKYwf+TklMvMJyfvNpcQ0bFAqmNW9bBkpZqZGlmHviAU3knlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+efdQweXP3S1CWNuZzR+PeMePxDZk5UrEtRi/CPqRq4=;
 b=Wdnz2mUzYP0Dehfc5mBfwniq8Zwk15yPihGv/v0G9YtyWM0vUiFisAQWzy+qFhSKavH7IapRFuh+U2aKB7LqwRFuMPxcUdZ3ivrI5ce4yP2PAR/Lc3Mk7aKaibtcnXzyRCkRRyiR+lnWr3Jz6PruKMHDUwxHDWC2J4+DzfYB9c52s15rCuCm7jsp05gJhlsryz/OsQdI3W3BrGi9r9kE3ETQzMW3AFawdXxJTgsBbQXH0o3ohgcme6fc0jcMDTR8LkfAW1RcFZIurLUSX2j+3PeqlSQ3xgSFdjxVoGjcW9YmZ73AoRfKbV7Mr8sTGJI+R4Qp6jFXaNhaBY2JY6yxbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by VI2PR04MB10764.eurprd04.prod.outlook.com (2603:10a6:800:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.18; Tue, 17 Feb
 2026 23:07:57 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 23:07:57 +0000
Date: Tue, 17 Feb 2026 18:07:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <aZT0R1Iy_i0j5GGB@lizhi-Precision-Tower-5810>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-19-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217212707.2450423-19-cassel@kernel.org>
X-ClientProxiedBy: PH8PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|VI2PR04MB10764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8722290e-b7c4-4b84-e7b2-08de6e79597e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vmgOZfCa37QUYvCZrqtSSIcWqDs1Iq5KcauN0wFZD59DxSSisdNsVDSsulRx?=
 =?us-ascii?Q?0RfzaJt3UFiao5d/2UJavAZpjNlWrb4L7HRouOMXxZSGA7ydO6xTCet30Jh5?=
 =?us-ascii?Q?ztEihWCL3xeHYwRDUmfvbqgmtIulhwK71X4FP5GjY459/KvvIiWf9oQOTyQ4?=
 =?us-ascii?Q?SGNS/RPsXBDLBJz8hFT21/r1kwjOM3mkvQylCga1cuSWMaVjQ/ysFQhdkKES?=
 =?us-ascii?Q?uJit+JXbhKc8+cszs7jpyjtmelHGD+Mtkveg0uNGKwhYKH2CgKSw2VqYyecQ?=
 =?us-ascii?Q?mAwuLnTEMGRYchMsNCJuUCom1+QvmDWvE0Stl8SfGUG+reyWtH7MdCAgX9ta?=
 =?us-ascii?Q?Y19ca4AaJ94EcBYRjA87NnbV1UaEfqJ3PKI1rMxg0wCM0cszHovMQ8Ino3vM?=
 =?us-ascii?Q?UkafDnl+xxIZfCOPXLGuziqIOrPKA2vKoqEsM3/8EX8ZJ6VVmB+Sb6O01VPH?=
 =?us-ascii?Q?KPXajrYUSQaS1fTeN7zVI648QwXpQrt/WRS6y50W+DqQNxrlUZYxgYpOyOjT?=
 =?us-ascii?Q?35dnSlJXASQ5YcFWWb3HvNal/4jrcp67QNhOD8tFSDgHZlOx/XKzCqfXGTl4?=
 =?us-ascii?Q?NMDYKfTOh3HJkHA9+WXkjYcU5jPvaFfvqFmQ9nGl3FrsLYI4AhsxLyo3m2Wi?=
 =?us-ascii?Q?zjV80InIVl6C6ud1GIVXBT8QGsPap9dJyrCVdnK8Vn6K9ptTK0LhnIamO+U/?=
 =?us-ascii?Q?Y7bCLDgk3dv2MAyncTBIOcs1CYd8b2/IQV1hVV/EEIf/47XTtX568Nmdz9DL?=
 =?us-ascii?Q?ODwf/3EOWqHMwmv2NGVH6ClJ4Ukg+aKaRtICSHsNOzrlrWWNqNSslQZ6Emen?=
 =?us-ascii?Q?3m9YsV0E5yM8PU7nCVqtkZicMLIBsq70LD1dK5tBNXP+JJsCOWQQYKDrNQCT?=
 =?us-ascii?Q?7dt8iukn25U9QPVnP9IpCFxZGIcq0UH2CVi4oHRR/2N8NmbyZGMazWf3vmWA?=
 =?us-ascii?Q?J4QxCpvoZBMNGyBN4UzwFDkWDFi0F0uZ9D0WO6zkIwauX1O8QiHwVLSqx3l5?=
 =?us-ascii?Q?SgRMeQQXkwgZjQKFwrVoA8/TEj8FfmFbbbM7XJUAUvsD0aIuYGG5OYZR40kF?=
 =?us-ascii?Q?w5/Q3S2a2kWhtStTDkI2Q+3LMQeqPgmsVC3z5TCfun5+JqnQtKtYX/xAwAZE?=
 =?us-ascii?Q?45i5B3STFN2b2e5halk+Omia56W2KTg/k+UNqDo9FANDfbC0FifRRLzFn4qv?=
 =?us-ascii?Q?f4odLOV5L2g3CRh/QWZp/D/1VrZIIlMGZuZN0JwhYKhw0KYPYQEvNsFDPoaq?=
 =?us-ascii?Q?O1JN1K2Lu7wLdGD2orwia+RcBX6RM29eOa7Z2f5sJHpiHP9/If86lpjL91w3?=
 =?us-ascii?Q?jRl5+m//tkTzXohowsTOeqt+hTZOc/sobU0FuMA21JZxsvhM4gCXrHmhKfqR?=
 =?us-ascii?Q?/Ob786ncwr1dkcbOKGF9PdCYaxAb2o8fI5jPc8r0ElLEAfoIAio+1uBTjA2b?=
 =?us-ascii?Q?mU8mdp3R4+gki/GhEjTbhRhmwumH59O4NFUOlt48XOHD+ntlDNx1c4qxsGPl?=
 =?us-ascii?Q?8FoKLVfVmjIMeFpmA0fJJlLBf0pgxK37UnfbEyl4ywK5iVRkClpwsG5YpUDN?=
 =?us-ascii?Q?dvJcsBAJY/Osc2xIVzZt+Mci5hr+vfq2rrBxvwlyRJVmwGj73GLFTR+gt9Pv?=
 =?us-ascii?Q?g73i3PEujM4+In+GFRCjzWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNbk6Mrnu0TMLv3L4Nu+//1IXMfcJp80Dvdi8YRbu2Xq6zAC7UvcKrrLwj54?=
 =?us-ascii?Q?QfAdJjKvOmWeGrmwem79BbhwJVuMo3anu6HgqrN0VXRAWft5n40nxwm9qu5p?=
 =?us-ascii?Q?RoRJg15KJt5VJMojGLyyv7HKA/bpLYI6uZAYuOvSAFbdIZ+9QXVzG5DdfHer?=
 =?us-ascii?Q?dm6eRqSfuAbbRvNzE2mk/9DgZL04m7v/gFRX10FR3mhcTFHgNVj8Mm5CbVq/?=
 =?us-ascii?Q?g9sGSsna7ftUWX2XspMGfRBvecRMDqn/lGjTuIWKL1o8ykb2kaqjkrJ/vYqN?=
 =?us-ascii?Q?SDB4kL5RQNk1gdupOx29dpQWP+EHArvUwHpIwsHjPKS8C/su6+68QA8VuuA8?=
 =?us-ascii?Q?MaSsXUT7jm7zd1+vReU53czXnRN0/g0yyGHGTXniE030mMK1F766+CM1l9b0?=
 =?us-ascii?Q?84f+QL4NFWrvHUhScpSqBqMLRFV0BH6gP7p0IARL8fyAZhgHJSFrFh8keuHn?=
 =?us-ascii?Q?+kCcWA8sPRah+z2OXZ0ZQFrqdQY6zMWypC1h4vTG3K01PpQt6U9aRbtdZW4g?=
 =?us-ascii?Q?h8GNnew1Zu8E5l4pHAGimcp5hFHeNpO7S1YPIuAgB3C8GpGTCLictUVqFWUr?=
 =?us-ascii?Q?LkPCu2kja36Rv1zhS1D/sqFLxHLIz9+nO8hoxlqOQc1VaWesbR1Fw4uz+UcN?=
 =?us-ascii?Q?l4V11+hLQ/P8qFTG4/WFaFwrlFwqutkPQlcM1bNe/JAZZQwj4E9dWQZ5KWgb?=
 =?us-ascii?Q?6aFSzr/noABZaq7KAnC3WXdt6uUCK2+0mpMFm++N/I3YBUvNMPSwKWC8Ff5M?=
 =?us-ascii?Q?B2PBj4X4MpLy4WPHiJwKHEWKoDJg4aQ7lTdEPl3sj7KJkiZ6INOH09bzuUVS?=
 =?us-ascii?Q?HBUhJns3b7GNieqmAt4KhpU1M9A5NJI3vFZ7TC6yjJhk8+7GxMjz3nx00ENc?=
 =?us-ascii?Q?Y98evcx0Epz2QxxHRzWLZeKTWX1dwgDAgYfLvBZzxSEvuCxcOa+lP+qEFkn/?=
 =?us-ascii?Q?nqY6Tb9ftvy2Mod8Wfb3nuUKDf1XV05cPCSKA7jlPFTj0jVfBCcZorOUKTj1?=
 =?us-ascii?Q?5DZQzatkl9i3RVr67xjkeFD8Om3ngkYSsh970nuFEDGAEG64wAJ4mKfjJnb+?=
 =?us-ascii?Q?PLnsvVWvK3LgJOVf1/1mWGiYHW8lo2S5acuUZpzv01rOE53OgIO/hxWtWHTj?=
 =?us-ascii?Q?w6El/sOnsUTofUqBupm6O5U/6POuulg8dDt2BEw1qvf3fQ+hiMTEvFf7cxPE?=
 =?us-ascii?Q?oXPOjb/rlSHBMmkCISXIy6l8X/UynUhNhquuuoQ4zjRlGJ+5tHMAHK62hhdz?=
 =?us-ascii?Q?pb8iIAuH3vR1wKmUnaGpGyedonuSm+74mdM3hYoiX1uIwY0EJWddIida3DDy?=
 =?us-ascii?Q?8i2TrFjNUFu2wbhiHseMdxP4Dmz2H90kH37HtR4iVlj3fR4ehvjqVeI5bPzk?=
 =?us-ascii?Q?PaVxfH2SN5u793eZV7Be2OT3gCbpPDMF+450pCwQYZxPVPy49hcvRZ23i0jC?=
 =?us-ascii?Q?STKvFXFj3J6ebXwwoQXRVFNVQq4XTHC5w2b+iIxsqkobp4CpVS0FHA9gCVy0?=
 =?us-ascii?Q?rXqUqXKRievXCgoYT7GUBX9zE2xceO5ygVvyB3pOjjknlmBuEi0KeCyzQOsj?=
 =?us-ascii?Q?5DmMqoM1sUSyaSPagDxV99h0SEF/vORBBTuaev51FfJ/28vEpusP2M/jL/6i?=
 =?us-ascii?Q?WO6Lo6nmwXIeey0WnUvjvF83YcMFx+d909ay4CmMzCqPR5D7z68PcWU6PasQ?=
 =?us-ascii?Q?re4jNhzbBZA2m+S9H8T5/Uax2oQ0T/zismg9Qp+gbtTdl0jzaiUERRSPdan0?=
 =?us-ascii?Q?gig14U5zKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8722290e-b7c4-4b84-e7b2-08de6e79597e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 23:07:57.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKkLuv3XSZW4nnugpnLM7aX94SJvcrgQKV6FoO6UXYvi01oVQcnFJE8udjJOZvXHU/dA/ezTmkHn+Z7PKJ6LXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10764

On Tue, Feb 17, 2026 at 10:27:14PM +0100, Niklas Cassel wrote:
> Give reserved BARs a distinct error code, such that the pci_endpoint_test
> selftest will be able to skip test cases that are run against reserved
> BARs.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 74ab5b5b9011..7cffb6e77c4d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -84,6 +84,12 @@
>  #define CAP_MSIX				BIT(2)
>  #define CAP_INTX				BIT(3)
>  #define CAP_SUBRANGE_MAPPING			BIT(4)
> +#define CAP_BAR0_RESERVED			BIT(5)
> +#define CAP_BAR1_RESERVED			BIT(6)
> +#define CAP_BAR2_RESERVED			BIT(7)
> +#define CAP_BAR3_RESERVED			BIT(8)
> +#define CAP_BAR4_RESERVED			BIT(9)
> +#define CAP_BAR5_RESERVED			BIT(10)
>
>  #define PCI_ENDPOINT_TEST_DB_BAR		0x34
>  #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> @@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return ret;
>  }
>
> +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> +{
> +	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
> +		return true;
> +	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
> +		return true;
> +	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
> +		return true;
> +	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
> +		return true;
> +	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
> +		return true;
> +	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
> +		return true;


return	test->ep_caps & BIT(bar + CAP_BAR0_RESERVED)

Frank

> +	return false;
> +}
> +
>  static const u32 bar_test_pattern[] = {
>  	0xA0A0A0A0,
>  	0xA1A1A1A1,
> @@ -403,7 +426,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>
>  	/* Write all BARs in order (without reading). */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> -		if (test->bar[bar])
> +		if (test->bar[bar] && !bar_is_reserved(test, bar))
>  			pci_endpoint_test_bars_write_bar(test, bar);
>
>  	/*
> @@ -413,7 +436,7 @@ static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
>  	 * (Reading back the BAR directly after writing can not detect this.)
>  	 */
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> -		if (test->bar[bar]) {
> +		if (test->bar[bar] && !bar_is_reserved(test, bar)) {
>  			ret = pci_endpoint_test_bars_read_bar(test, bar);
>  			if (ret)
>  				return ret;
> @@ -1139,6 +1162,11 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  		if (is_am654_pci_dev(pdev) && bar == BAR_0)
>  			goto ret;
>
> +		if (bar_is_reserved(test, bar)) {
> +			ret = -ENOBUFS;
> +			goto ret;
> +		}
> +
>  		if (cmd == PCITEST_BAR)
>  			ret = pci_endpoint_test_bar(test, bar);
>  		else
> --
> 2.53.0
>
