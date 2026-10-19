Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3F22F388;
	Mon, 19 Oct 2026 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377102; cv=fail; b=lme63s658H6wHbE2E3IHbq7bMP/A0MFsprUwY2eLInmHxvfGdLaSw/qqRf8I25i1ur1YL/Qf42HFzcJuvZebwXkbKdzx8Cfb2Ad3OxiDd3aAXQ5tJ2RCSxyA9ioDaRH8AEGG49xj4zuayrSSFXwuPUgdx1Xbzk0+ibhPkGr1cbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377102; c=relaxed/simple;
	bh=cgur2Qjh7ziQcueXb3rNiATUlj9UVX3Ly1T+Qt2/VLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qyk5y9Z7C/kZSVeNMmJTIaEdI30g6tY7vVnDH3lEdkUZoGVthoi5ra7WjpD0JO/xBH7UMOUr9iWjmx8CVc7S12tTE0bxSXMsA2a8GheqI7SGqQspJpGt1sMMcRovbjBVcv6gGgPjFwrt2z7qEH26lAgpmZLsieG7Pae7QD72WJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WZbYAl3C; arc=fail smtp.client-ip=52.101.125.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WZbYAl3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3Y1WXbkTesnb+V81i6mojC37MTMppZnlM8D9fHCqxsox1MJJnZe0d2DzPa86g5nMXBY6hog/WwOoY1wjQMqLsh5OMEv2/j3TDM7bHFY8EpCh8kc4S1UxcqbnChhAuebADJj2S84rUqy3NVfOEKiLKrqv5wbLoXd3ne+iqAOCi6W3E4IIBpam3aIued+7n0mWEUpW4rGX5CeGQkQ+v3nI7Vsgq0SoEyyN7z81yM0IKz/nWib1uFq+L7282kGMaYE/HDQtqqyONGxNE7arRbC5HICFVr2GBWKZuh7JIOidZlfkf/knUMeZG7kYBaesEuskGRnNdV9YcjPOWxjXbOKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6Q6elPJ9cl1SUvPvSzkLgwcWYaz/23aJLD+Wno7zMU=;
 b=Ldi3RgHaCl5lLk0/L3rx8KvaaDmeNt/aFd/noULONdwaNCz8c9lPW+I4Q7MSEQ6t4baYbuA3ulk5CLyFEFhkbc2iehSMG/DZutMWeuB1QkfEoBIIlJ4pucsZ21bMTNxfNyev2WZIHs9l9E95xL9VwHHIbfwWRGJX/5S/TQCLoQGT+T/ky0U0P+6PadIMxz2N6R6iE/pFnRLMkz5TUCVuv2y6S8kf7f0bzzGRiMW71lHfcGaYKm6rVxhs3THGlhXbBzLprzcFb8vuJ49SNZBpVWJBF54YPYE1ft4+a3XaxF8SK9CYqNkAg5PvJ0QfpJO0PRuYZ54v0evIQNhykn4Lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6Q6elPJ9cl1SUvPvSzkLgwcWYaz/23aJLD+Wno7zMU=;
 b=WZbYAl3CZoWBXYY0vU1T11BrLM7YqUvCow2cO+/MDVzfUacH4EE3MulK6qf1R9JurakvSQWDEGXtS8gNe4UGjm+f3RL9m5X3YFgFjsMEfv4udBq+ZMDkh1feaT8svbDMU/EUJjT/x6RllLqfV9nbajqmWMo6oI98A9Ir6Zko6TY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2583.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:31:34 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:31:33 +0000
Date: Mon, 19 Oct 2026 11:31:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt for R-Car Gen4 SoCs
Message-ID: <j6ayfdb4evnc45urk4n5ewtnn22f2gwgqyjkhpxr4c7outy5va@5dhrlhgqp2ms>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-5-den@valinux.co.jp>
 <814043dc-d194-4afd-8317-03b55cc9e913@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814043dc-d194-4afd-8317-03b55cc9e913@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2583:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfa7cfc-1235-473b-9b96-08df2d8916f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|3023799007|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	v54cabeH4lJqytw+rHjW1pZYNU8Nv0ER3jUMg/wGKJLfNQcfvz5cL4W5+fLDZClAz1oI21iKQa46VRMoD6C4QPYT+tyqbK5jLlcttZF9EvtJs35kvl2oPgu2BEDXPmh5UwRqN4wYlGFx4p3sgcSlyALS91MCfNd7PTa40tCyXf12Jxl+hHpQJPN/ZUxqoeBmVv6/9eAzSkxb/nBsjCcAmX+yh3BHA1QUhwLCwKVfJsndGJjbkispjFfWPRdVLWnMREpmbbOtOTwocLRur7ghrsaAtkDWuuEljh5EDIllSOzsSS0st6MPM/MW8jWD8fxQEj/lk/iFxgo2T4kof8zjkC1LgGKEdNIi3+stPmDIz1fyumoF1k/18uYDQov4HZYbsA8XJCYm6PyVUXsbJsNEalodjkaDy0GOSzrg67YBWxenDv73ryNZ5sFPlJVmXKCG49dK0Y7sibb5Q/m8Q3zAMdK9PMuMANYezr5Ph9CHjtj2TFA9wiTDocsOjRxUrltx/K+Eda5hlM+kjOdVKOAkJJwZ2shlRZkBJZ+13kwKVomse4lET+p8V/zVAkr3QDv5MBuD51YCx4h1tu5aUOQuL3Z6dbzY821cW7viNJZJusRzNIMSgj+7omqr0DWx7psJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pr/YKan+wTQckIJeLScv2jJm14kkCqgZWpTTdj03n3vxVL9xtirbP+WsMOVt?=
 =?us-ascii?Q?/cIqcRsmw++d6JXYpVSnI8dJz55VkeqI0LLBuXSeigAOOiX0L/DN7pekspM+?=
 =?us-ascii?Q?iVZm5gpCCoYzKwRB13rr+rsOS++wZkZNqlDo3nTMHAWVN6SfTJoS/FIRdJ4e?=
 =?us-ascii?Q?RYEyPSp7Zysw+lGjrg3CYFqkm5/VvmA1CTDoqgSf46kCT5glJNe6p/zwupTP?=
 =?us-ascii?Q?XR+OoYKzxhCtFgMiljQl1yGYkg1GT/pY1RATJyt3rnMi028g2Wfk6gu8tC1u?=
 =?us-ascii?Q?ULCU17x0Jji7ExlqU3+5lM3ePrK31NIT8asiQtoKrS5xD9QHsKOzmU34BvAh?=
 =?us-ascii?Q?Qv1Z55sc7dUwwv01tGRCxr73FJLIw6H0X0OI1Egc0uFJ08WUy/SyGkyeY5sa?=
 =?us-ascii?Q?R2wA9NGq2rTnmjTpl7MEDDrQtypLtkBL0eYjxfms40CC9DylE5D0k1/H3FVk?=
 =?us-ascii?Q?RglT25nKze1H14TzCTbCiH3+s+MNyysgknPOWCIbG4FViFhQ/S8lSbWsAxzR?=
 =?us-ascii?Q?Bdvbur+IwL3kM1bZyOIqLThtdWSPLwTaTHA91z/KEe8my4LHpeTPUj3KGZ7I?=
 =?us-ascii?Q?UwfYr2cF4aDOHKaFcS00jkF6O1xNBLmFHIlS16zH43vr23b00nw5sa1UEFYR?=
 =?us-ascii?Q?nBN74TGF9N1CztbU9rsniXgS4lEPMcMJZzIQzs6bBeHaL9oH/c5AfCFbLcX4?=
 =?us-ascii?Q?tYpTmZzBZ3vDPy9ZOjgYsom/p9JasaPUzVAyPwx602ZRnphyw6Wjg7OOf6Y0?=
 =?us-ascii?Q?KP0Td4DV9IQdtKpIkVqKymN+Wc5d8GHZsMCxv5J5To/tmgEaH5fSdNeXhSUJ?=
 =?us-ascii?Q?o/olCpS4Td7QfSPRzuzjxHTjTrm3yQ8S6S7YFZqhOt4XwNH80w6+30vRKCEF?=
 =?us-ascii?Q?HV/fng4TSnr27IMg5epTZ1/KNiprIzC7heCJbJ4+e46Ieup2i1sCoLIfxRA6?=
 =?us-ascii?Q?RxwTWinlixpiLO40+1jrtKyiDine2H9xaj2FG4lYWc5NESa1Q86SSsyrFf3p?=
 =?us-ascii?Q?Rozpb5bs44wDLjLnKK3Q3t3f547FFmMDnynwSKEU61QYuYyFvYj6eJ2KyG8o?=
 =?us-ascii?Q?M6ucA4eaTtRGGg17vy5Y2rpCT9Z8335EC6uwuAcXnW8rjYtvsSl0+ufV9dj4?=
 =?us-ascii?Q?0ccSCBiKWIJP2YCcDH5Mv4WYBdvRahMaOzw6iNH+2ssuZdVIdQuQf2VsQ93r?=
 =?us-ascii?Q?jlgFq1a5JtJqxFda30v1BgFWpFWL++I0gsKBQ6g6H6IY8zjUlVmCAIZM0+Rk?=
 =?us-ascii?Q?mdhZvBoCtef1gYv2+1OpByzMFQC0AIlE0xoe1NbvNgLA70zicqm8h2cSVmlx?=
 =?us-ascii?Q?MsST9IGKZQvUfo6jpoIo43PH5caReclyV6Gtg4dBBajXXsSOlfLzuo0c+Gk4?=
 =?us-ascii?Q?lgffGxEwUcFRPmlzMNNB5sIa/gBYYJ/gsuGIbqZjF6/l7GcTkIzw3hYhOe/D?=
 =?us-ascii?Q?NvFmXgG7G0jow7mbCwG4GFMiO1RF6YuzGgtxo8LCv8/AwSbwnBf+//3n4Lpp?=
 =?us-ascii?Q?li8nZP6JpnoRj1lSzUZxUS/RN3YZa8wy2AJ9ERtKVuy6Ot/rYgvWSiUk4v/c?=
 =?us-ascii?Q?UUawmazIUHmc/FjCPDgmf6tDu7WHfqJrPPTKPOHmXjjAkOcvwqYIF8OYsDO4?=
 =?us-ascii?Q?3LBEm182+ayqc4iTSL7dhMmH+TUd/fcuHtbPoNvYlQRpnkt/DsakNwbPTPLt?=
 =?us-ascii?Q?3IbDuZQCiKb4wEYY2haSbPAvmCFz/JpJ7suyTxhdj5BmgvOWWr/5MqHrHqOl?=
 =?us-ascii?Q?CGYPouiVDEo4AZsTFfP55SFlTnuJkQh75t4sWGPeDcNtAuV2K8Zh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfa7cfc-1235-473b-9b96-08df2d8916f1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 02:31:33.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETY0L1XkE0PstWe3u4IhRTlaOiYhuhj19S7Inm2jK12MqHcQTbOdyZbsg3CUS7bmpnldAK3NKtnBgirb7oRa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2583

On Sat, Oct 17, 2026 at 02:17:38PM +0200, Marek Vasut wrote:
> On 10/15/26 5:30 AM, Koichiro Den wrote:
> > The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> > separately from the integrated MSI receiver interrupt. Describe it with
> > the "aer" name so the controller driver can use it for Root Port error
> > reporting.
> > 
> > Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> > trees remain valid. Extend the example accordingly.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v3:
> >    - Rebase on Marek's Gen5 AER binding fix:
> >      https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
> >      This requires "aer" for the Gen5 SoC PCIe4 controller from the
> >      beginning. Update the subject to clarify that it is optional only
> >      on Gen4 SoCs, for compatibility with existing DTs.
> >    - Drop R-b tags due to the changes.
> > 
> > v3: https://lore.kernel.org/r/20261006084638.3821710-5-den@valinux.co.jp/
> > 
> >   .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > index 083b77d4de8f..a86c06701fa9 100644
> > --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > @@ -26,7 +26,8 @@ properties:
> >             - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
> >     interrupts:
> > -    maxItems: 4
> > +    minItems: 4
> > +    maxItems: 5
> 
> Wouldn't it be easier/cleaner keep only maxItems: 4 here and set ...
> 
> >     clocks:
> >       maxItems: 2
> > @@ -93,11 +94,13 @@ allOf:
> >               - const: config
> >           interrupt-names:
> > +          minItems: 4
> 
> ... minItems/maxItems here ^ for R-Car Gen4 (because Gen4 is the only SoC
> family which has optional non-mandatorily-described AER interrupt) ...
> 
> >             items:
> >               - const: msi
> >               - const: dma
> >               - const: sft_ce
> >               - const: app
> > +            - const: aer
> >     - if:
> >         properties:
> >           compatible:
> > @@ -117,6 +120,9 @@ allOf:
> >               - const: app
> >               - const: config
> > +        interrupts:
> > +          maxItems: 4
> 
> ... and drop this interrupts: hunk here entirely (because Gen5 always has
> mandatorily described AER interrupt) ?
> 
> >           interrupt-names:
> >             items:
> >               - const: msi
> > @@ -146,8 +152,9 @@ examples:
> >               interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > -            interrupt-names = "msi", "dma", "sft_ce", "app";
> > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
> >               clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
> >               clock-names = "core", "ref";
> >               power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> 
> What do you think ?

Seems that wouldn't work as-is. With your proposed layout and a Gen4 DT that
includes "aer":

  $ dt-validate -V
  2026.9
  $ dt-validate -s <schema-dir> -l rcar-gen4-pci-host <gen4.dtb>
    interrupts: [[0, 416, 4], [0, 417, 4], [0, 418, 4], [0, 422, 4], [0, 421, 4]] is too long
      from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml

The top-level maxItems:4 would still apply to Gen4.
We could instead drop the top-level interrupts limits and set them separately in
the Gen4 and Gen5 'then' blocks, if that would be more readable.

But TBH, I don't see much benefit over the current (v4) layout, so I'd prefer to
keep v4 as it is. I'd appreciate your thoughts on it.

Thanks for the review!

Best regards,
Koichiro Den
