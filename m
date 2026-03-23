Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C363D34B9;
	Mon, 23 Mar 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290665; cv=fail; b=PGZaya9yVfeyrvZjZNA717q38ITUsXS17r5NQ387qnqqp97RPV9Ig0YleON8GfXmlcLDLgsZ8TRcee2lrKTBbI6K5FCUlAzEUgp1KUN9yfupRFieOnOMnEVygN/3cgO1Yajsl0QQKS8rzk5QfOzz907q7oTPYxHufEh8pz8my8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290665; c=relaxed/simple;
	bh=+S+aqn/9KAfk68ozLvsD1Ni/t5c1ZYfOTlmYCdshgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJSDgg0UIbFW2Lva4cREMkdxJGHu49+dyKDFTRBFGuaCSnxYpvnRWHre/o++k+9nxuml81CYjMradzL6AHOA6kXOXwqb8s+bQOnYKaZho4M6Y7RBam7Z5Jxx2byaBVhkR0+2nqUx8Tpkt7ivD6+CPOvNUXIJno7EJRgfaFGlmMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmyE62Tw; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmyE62Tw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+CAGkjAav0TXrH1GccZVWkHjymTpb9DMP4Ti2vlyHLKLr+JtkTl5q6+TInHX+F7vAWDA2e+eeLxSMj8N+pQfrC0mYOJf3vbhgPjtCceQmGgrmhoJM3aESsXCGCnebey4tzgtemdZRlGds4FX1ixBr1jRJDvlcKmtH2+Jp3DTapDXQDwEu2E6jek5jrTnot/1kmn3bLzdaZ7PEd/CRWv8shTT5/buW76eGmM5iI4LMiPwefSSP33Rv4AWtak3qBmo856uGP7VxeDOsnfSHc9rBTwhwQhY9JQu0dab9NRU1H91+dX5HHbBjD0yURTISx3lO4Y80uI9nZlVTu4X5j1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+/W8i4aQcBSkxWLvMraxFa00eFt6W2mAnWYNBNsPeA=;
 b=VmOgMQfX+aOH6z5N1Yj5l0hnYfrgdbYYVthVwP9WvDkVWNi1inDp4ITQCjNUu1vTRaTkS9clQetPVK4wZqAOfTing5EAiL6n7RRpT2XNSIyHAqTZSIIjUburC+kzrx1Spc8w4UdUsIDWeXaNiUvVJWqRctXo4b9pKpNlI2l4BJupj1r6ODpECIkNJQOy6JBSE7HyWgslnDmBHUy30/ewmIGJ2EepxOqGFwEAqp/U25yJkGMZtJ1A5BIFJ0y3aEO93e+mLcPYsB5S8zJ/EEvXHcMuWgzR/IwAIZFgOK8Tc4QfK62Z2iWtWXyr6CULbc77+kX52r41uCXByN1osuInGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+/W8i4aQcBSkxWLvMraxFa00eFt6W2mAnWYNBNsPeA=;
 b=HmyE62TwMfRCYgFLYZArufiksiKmUkw4FOhtr3rqSpVi+CrhweGzIfr8/hLYJMif9ZsSSu+dacFwBKCX3nO5pphlEOyFKxlusem2EPFvaYb+bCeSbaoLcM0E4/X5EMY+cj57GqaGCw5aH2Rxx7U58frUakf40nrGdtv4YLbzhKUdJx3R2jz2Dn5iBchPl7cXdMSJzmXiyTt6QDQDMVVcqZEcQ0RofVD7wNf4aM/7dUAHHzUIm98OZ/pIcCA0SQfHqkfE88KJsbWLmsG7O+a9q8NpYN77HDk/wBS8/wFt+mVWx4dnKW7VHo4EpZKZgsGfAUjSu8Uhj9QLH0TUSLdSdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 18:30:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 18:30:51 +0000
Date: Mon, 23 Mar 2026 14:30:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
 i.MX943 PCIe compatible strings
Message-ID: <acGG2pITRP2q3_ka@lizhi-Precision-Tower-5810>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
 <20260313083443.2391254-3-hongxing.zhu@nxp.com>
 <20260322231003.GA69234-robh@kernel.org>
 <AS8PR04MB8833815B161AEAA3648DBF908C4BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833815B161AEAA3648DBF908C4BA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SN1PR12CA0092.namprd12.prod.outlook.com
 (2603:10b6:802:21::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc6190f-566e-495c-2ecf-08de890a4fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|7053199007|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	kokgr+axsF7AXhmgbw8o0YviYy5aA4aiypWL2ksawj2xVbqzKXDG6gwCru0fYQVeXaa1kz0aUPrAO5Cb7Zrh8Y0MT933iM2ohFTYuKHogXh/VCaGPB/BcNVypp4lI5QBfnjrsOiURgySMgRhhsPYjF6ZaIy4RfusCFpNuJjp46echXfTApvi9G+NrvV3gZjaXD9uloLti+wUKAGZKf3yV18xILQughim1Z7caXLjOTtdQLDoMBxILUDK72C8T8sAKS6um/gpemNdULI4Mjx9DUdvJmuxLJoe1ckQOr62C5tKokUCgJTNGMRuckkL9V+ZKiFrtBzS2gQnmXWwTa9+t9q5hVVjTe0iGHMvC4Y6lT5vTTpCUNsOnwu2wTJNx7YtEg83QVIAiHPu5ZNrc6V6kM3xIkU3kq6Kyj4pW9ifwEzB0IJ5X8moKnWA5Wnayq4t2BeI9i+/7BkRmNXhzZZjJvkdyphdut1G+VAyyP5JtaUpIP1ELZN9vvHABgNJgtg5QNxo7bPjU18y+Pz3c0Nu6K3GsNL0Aav+8TFwck0hNu+GkgdxkWUGrRHod5EuEJzQ3UZMg87ZDfRCccja15an0gf04BIDLfdibKLrgo3wGt5XtZlOKqA7ulEqv3ArXemJinaggkC/dGBJRCBR/siqbkkSaNNGzgFkJ9WxKADsLhY1IM/5Pz3n6DkxfZm6yFlorb46ThODuy9Oe3a+u1pBoO8SVArLolUQDUAkKhxZCzZwD+1bGZlkmkxPqwA7H3wf5QRqge8dEF9b5zSC22zpHqBmpWyiSgJrOnGn5ZzlF0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(7053199007)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGkrNm5rQWdwMnc1KzdvdC9IOWU3SUg0NjlFL3dOMFg2VlFqQ01FVjA3c2dE?=
 =?utf-8?B?YllmbGU4TjFTSWFndHcyL2ZoSGcxNGpwRC8rdTZBbklENW9WUGhMUnRXK1Nx?=
 =?utf-8?B?UiswVlFTaXpoNkNlb25zK0g2Y01saFpDK1dKZXQzRjJENGVVZDdyNEQ2aE9t?=
 =?utf-8?B?bjVWU1dHZkVYTUhNTnc4aTdyb2F2NCtlbm85bXk4L1p3djRhMitZVGJldlRj?=
 =?utf-8?B?eEhZQjRBZFBzNUJJZnlRL0swN0ZBcnowMHFyaEh4TWZRb2FQQ0cySFBkRkhB?=
 =?utf-8?B?UU5mZFBNNnJFRGwwSTBYT2VuVGpvQVNGMDZDV0dyOXROT0N2R0NEd2dzTmNX?=
 =?utf-8?B?aTRvSEFGSUhQYnh1TFFWNGtYZlY1ckxzdWlyUmdvZnhoUWtiQlpCMjBmM25N?=
 =?utf-8?B?b0VwYVVZMXhIKytTZ0p2Y0krSHlYaFJVbjZLTmtsVm9PU0RGZ2w5dkg2WjF1?=
 =?utf-8?B?cUxYSTNwaFk0Uzkzcm1xSFFoNWdObFBUdEtsY0dLR3pDUzN5SUFDRitXUm1o?=
 =?utf-8?B?blRpQ0tRYTE2VkMzV3JvZGxsc2EyMFJRYmt6eGJHWVNLK29tZTRVU3JlOHNT?=
 =?utf-8?B?NjkyRW5jSzQ5amdLaTFIZ0tMQUdJYSt4eVB0MFdENHY3anBxa0xxa3pjbjZz?=
 =?utf-8?B?Y2J6UEYxOFp6NWJoSlNJL2hZZjA5MXJCcXlZL0Q1YUZUek92bnRnRklMbUFQ?=
 =?utf-8?B?M2IrOGVTanpxRStMRHNvRlZQRHViUE9hSmYvbnhpa1JjVGd2U1U4akt4S05C?=
 =?utf-8?B?S1RuTnpuQThhTFd3V0xrUXNiU1d0bHVsWjZJMmoyU0hmSFJYd08zc3ovOWU1?=
 =?utf-8?B?eUduaGJWZlVkbFpTZGN0YkpJbXRhRFl6VVROb1BXRUZuTEw5K0xiOXZXUStv?=
 =?utf-8?B?amhQNFV1ZU9PSWlWY3VjY3czMWJWQXFtRkRLdUR4NGxtNEEzdUQ3ZjFXZDhI?=
 =?utf-8?B?L3FvZFBzWENtWGRvVG5KUnZBQlgzSWE1ZVJQanFleDZqMk9NbmFPV3pvOFl3?=
 =?utf-8?B?TW5vZTVhb2t5QU0zTmlXOFVJQWE4a2xLUmcrb0g5RVVzb3FVV0F4NGo5SktK?=
 =?utf-8?B?NnFkT2oxUVRJajdSQkZiVTBBbHRRS245SVNUZUhMZVZCdThmYWdnZWNpbmNW?=
 =?utf-8?B?UlZ1TnJOK1BpWlNLRTBxMGllSlFxNWgrS3Z5YmltR2pIYnpaUk5TaFlhVVlR?=
 =?utf-8?B?eWRVUDhMUWJydy9SZE5BQmRyR2loNTZtV2lLUzlaVnhoTUtFWGNXSzM2WElm?=
 =?utf-8?B?OVFsQThWWVhRQ1FKSkdOWnorUmpqbHlJU0NvckZDL1hPelVtNVVpL3A2bzIr?=
 =?utf-8?B?M2RlWERramFPMFRHelc3N0NNVFVkUjdqOEFpODNZbW9JSlMzVEtuMUZoZk5z?=
 =?utf-8?B?STV1SStveDVCeHJ6b3RGVW0rUkNScHNJNkdSUHcwQzZCYXBQeTJXcjlTNC9B?=
 =?utf-8?B?ajNxWHIwYVBKQWE4b3laZzRSY3V3b29tZGdrMXozZFhFT21IemkwbFJXVExQ?=
 =?utf-8?B?bjZkOEFvQ2lGU0ladlZKSmFiOThXRVVMM1FNK0p5ZWpNWEFWMDZvdy9zcm83?=
 =?utf-8?B?cDlLMFB5YmJ4NS9PS2sxYVZjNzRWbmU5M2luMHZVSUNpWFZZbnR4TEZEcUlq?=
 =?utf-8?B?K0NNZTAybkhsaWc0TmFMQmx1cXlBN2xqczd3T2NtUU1ISDdNZVQxK2tlZzdP?=
 =?utf-8?B?eUlKZHlpOE9rNjhlcGV2TnJEWWJsK3R5ZzZnak5QR1JLb3NXaWdTaWVRakp2?=
 =?utf-8?B?OHdsajJQOHlKd0NPUmRZcjlSdmtrM043UmFyVGVVakY0VFBLQi9WcEE5TFRh?=
 =?utf-8?B?ODVZTE1uZTMvYXl5Y0pPbkZYLzRtZGYvczlDV2hXL0RxNUF5bWdDL3JIMWw4?=
 =?utf-8?B?SisyT1dZdSt5MjEwZWNMOGk2b2N3RDF4T3hUWUx4d0JKRG82aU9RL3V5V1dY?=
 =?utf-8?B?WjY0RDcvejZSRlZVSnpNNlRoOGRUODllaVQ4WmFTWlRqUkFsNlpqQUNLYnhS?=
 =?utf-8?B?Vk1MMlRkSlJFOCs0dlpOc1AvNGVBUmFIVEhycUxMd0JpaktqVXNZUmp3bDVv?=
 =?utf-8?B?WWg4M1dhYzk3UC9Pa0JEcXpmSkpJNVpHRzBxTVRaWStMSTdkRzZ0Rnh6RjlI?=
 =?utf-8?B?Q25lK3hNQXBzRkRyYWhhbXE4dTMxeU1OTjA2WjF1dGZsekZ4MWYyR25XaWcv?=
 =?utf-8?B?QXlTMnFneHUzRGVWdXBtaHZKMnRyYkRuT3ZnYU9mSFhISmRKbUVRVnpsaUZk?=
 =?utf-8?B?MVJaSlNpUGlHdEZWbUlKQmwyY0RNeHhvQmk4M2R3bHVRY3NCYTNUZlB4ZDlu?=
 =?utf-8?B?NmtoVDdxSnRaR0lZOEx1ZXdxejJRa0xveWs5VE9CSTU5dzRldzFHQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc6190f-566e-495c-2ecf-08de890a4fda
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:30:51.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSox9CxXvm1iyf4jGRNan+nW60dFwyxDBcruW4ZvaIDr+Y4TspMWID4yWuPdfjNhjCf6fN2RlKmx7Ncf0EnEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

On Mon, Mar 23, 2026 at 02:23:20AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2026年3月23日 7:10
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; bhelgaas@google.com; Frank
> > Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; mani@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
> > i.MX943 PCIe compatible strings
> >
> > > +          - fsl,imx8mm-pcie
> > > +          - fsl,imx8mp-pcie
> > > +          - fsl,imx8mq-pcie
> > > +          - fsl,imx8q-pcie
> > > +          - fsl,imx94-pcie
> > > +          - fsl,imx943-pcie
> Did these two shall be dropped either?

Yes, drop because you use fallback "fsl,imx94-pcie", "fsl,imx95-pcie", so
doesn't allow single "fsl,imx94-pcie".

Frank
>
> Thanks.
> Best Regards
> Richard Zhu
> > > +          - fsl,imx95-pcie
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx94-pcie
> > > +              - fsl,imx943-pcie
> > > +          - const: fsl,imx95-pcie
> > >
> > >    clocks:
> > >      minItems: 3
> > > --
> > > 2.37.1
> > >
