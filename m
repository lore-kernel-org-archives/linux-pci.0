Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E1C2FF;
	Tue, 17 Feb 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347869; cv=fail; b=ZQ92Tpyz7hZs/pJ/cqQn5JedHfCAergu05pnBzDzKRoltoRoJCxb6h5bMFpnTcr9JTHEO16OB7zN8tF1V2L6FhLrJne4/esPTh4w1R+7olBJfNgSVngM7wYpD7qE7DaCsNSy2fWF6hTSrDo1G1XOrSfaZsKPYQS/0Sfrpp5py7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347869; c=relaxed/simple;
	bh=HOJm3bkxyWP6THmj6EhFijqTsa1YSHmnR/AviNYSi/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxgMqRJGtxRLxyE1+8Jq2APsA38tU5TmKLt8ejx+yOHtGK/GdsexGMWY0FLASYqDHt3+55cDi2819QKMvElG2sqnIXxSjbO1+LWNgxChUJe+iV4bqoHzS1n/1iFRrESqgeekqH9N10VT0Witl4hucNyDtZmFKfE8EN9vEtMFYN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7r2KBXd; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7r2KBXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfY3fakeZWPOaKG1HwF4XzdtwBOyVQmaGCseu5CRAR9FmaguENv8ZaDwr2mKujHiD43wPM6qH2DQ4AsnJrLazttpOCJ4xg1K9xhVYtKku1mbGYvZCGRGGCSwA3r0b+3QtRunnkX2re9WwdN9G2tkHd4VsX5VnCnGOEvmVDR9TisX0cR0MBkWzxWuez7vL1sNL07wx+r3Dday8C0oDg5sHzTnkhIejaXq2R8qf3jXL/5/rGMfKkrexoHz6BpsStbn+ngWfgvznC00koIvs1pdzE19n9mDdi0L3f3QfMeIlImpSN5QatVWg1v+D/xvKdfKEC8oDomL4GLzVjoouceQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUNVMG1U6tJFojCUMGUtQUjKsMQN+Ukv64kkusnmlaM=;
 b=Y08+avgg0jFXF19NgYgsM7VCOUI2eNt+n8DPR25s9zJPXYAcwI42Z2V1eJJe25vnAAJGhsHYDsz1Yd2xQ4AOClW/d/osMPSX8/gx1dlpj6ffcAhsL/5hVUZkgy5ehplTS/1MVaS53hslB5szwXYRFK6mYc5nHrYIPN9EVf++ft21Hizj6UYdRZj2mVps+DyVFiVNZO9PPDHhjNhmhPb2vzCGxdjBilZF6IWK+jLOqSoNDHWmYI/A4FU+UuCC7TN5gE8hK/jMsTn40iO2X2wySVAEbf+3fBVmmPyuqeEsk8RaQ8S3sAjIBr+QhOssUKwdttkFY1Kj7ENgrnQ/OcQbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUNVMG1U6tJFojCUMGUtQUjKsMQN+Ukv64kkusnmlaM=;
 b=C7r2KBXdVuhs5/QwgrqlyrgOw2r6X+POFV1nmjQZMNR6paJhmw7qXTizFmNO1GI0C1z98qyKMqzyc2N2kcJTFKJNEQkIq4aTsZHsZkCitRGDCXDednXaqvP4ob5RJe4wa9A3zWdYoljbr8+PN+SEblbtKbEtOCKj6kmnQanP8I5W0lo4wAZ+lrWTioZJCMvhi4nDavoqfBCX6QXHdzm5gciz/D4tujfCeScJbCRTHZDG28eKhxsyUrFwnuEh12DwDVZG4PIXZxYx1sj/vxSXlOt1OUQtTvzbEFXqLxkRRd/eNNi8xEMaDVwhOQ/XXA8/MsKZmLSY55QsZOpuob+6uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11167.eurprd04.prod.outlook.com (2603:10a6:150:27b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:04:24 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 17:04:23 +0000
Date: Tue, 17 Feb 2026 12:04:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/3] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ
 unwind
Message-ID: <aZSfkGgcTS0FEWuR@lizhi-Precision-Tower-5810>
References: <20260217063856.3759713-1-den@valinux.co.jp>
 <20260217063856.3759713-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217063856.3759713-2-den@valinux.co.jp>
X-ClientProxiedBy: PH1PEPF00013301.namprd07.prod.outlook.com
 (2603:10b6:518:1::f) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11167:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cc68b8-ec42-40dd-6e6c-08de6e469996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|1800799024|366016|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IpNjvKD/ytsOhQY/pPldDCM6YAXAzG4OpgR0xBz+LEkgHqDTuDdCAZuaXAy6?=
 =?us-ascii?Q?sIE87Fj3q7P1J12ZuH3xUZWLkSDT2g6WtJroy+T6roFdDrFRmJaYHFageE4O?=
 =?us-ascii?Q?4OmYFwh9err/+y/lc+Xq8f9Ppd1OdPa8h8Gga6qCNfJE8Rmro+WMDWFmk8Ro?=
 =?us-ascii?Q?Ty6oW4PHSzAi+cpRq8knpCBoLxGcBLiwVJYz1p0chux1I76x9CLYDwSrPPS+?=
 =?us-ascii?Q?APkBvaxbH+Kcdpn+XKIWZY/5fo+rvx4wuaMfI1vDWalS4PDTvYoOTvWX0I4L?=
 =?us-ascii?Q?HbJa5BN87t4KKEPvtVfaaX9c9FgtBpxDwRNnRrJDSmA7GUvAsAM81GiB9uXR?=
 =?us-ascii?Q?xkmzal8oIGoqSRnLTyYfBIL/KrSl55kWXIavnwLJQBD/NEENd/W+JY7gcopV?=
 =?us-ascii?Q?r8kdUm1XP9Uys+SToLsmFfiv9FnesCqlt9NRXPy6qQLKuPdnQUBiBkYzwm5w?=
 =?us-ascii?Q?sDCyptqjrq4gTwTt6VTerCZ+lx0dNcoTVEu0vHMtQpB3zR6SghkbLUf1rmJL?=
 =?us-ascii?Q?/PUKfEPk9LhFpk938Ee3TQBlC7UbiITDSlWjwkRUKudwweDsQc039WSqZk0+?=
 =?us-ascii?Q?kO/kKC5TjhaCPxcq+Regioq3O38vmhIYBqQpvxmvMBdGryUEYWg2K65jSMhL?=
 =?us-ascii?Q?AwluAK9Z0e916O8y7Xcfm72hkeJeL+miMyAwOD0Dt3hMmmGjGGMfOGMlyHsS?=
 =?us-ascii?Q?McxAsRiiifQeUftOXoIIjdDBRD6rbL14azsFOVX1ZkWQg0GiLV8r7KMdBoCF?=
 =?us-ascii?Q?uyQkCQ379BMhrEfhDc7TN0F0zLoZr2XQyOcAHQ+Ah6XJbLvRGmdxkO9mjMeN?=
 =?us-ascii?Q?39thqYQz5YIxnDbXPX6eLvjFajxoEIpVJAGI9MuVP0uK6sXvMjjzWz++u29x?=
 =?us-ascii?Q?P63RpccEh7Lyd13AJP8qnVVLEB6yUwtDhced2C54LBQRPCbKbKuC5qtwyhD8?=
 =?us-ascii?Q?nwcma5T5dajmHMcL62ITjGVcEm2Gpg1Q6lPUrwNI0Ecr9WfVbiStnGaiCwpM?=
 =?us-ascii?Q?z9CLzDYvzUc4rkt2xluY3nQ+xedebAKAcGNH/6sL8G4RCdEwQvjW6onLp+LX?=
 =?us-ascii?Q?05Byp3RYURQS1QBBGTH/qCiO7VmcFfJID59tHc7XzyOwIH70T+FFHk4OcbQa?=
 =?us-ascii?Q?OE4+dUPJ4rRLa5ZaNcaZGC5+64pXHI74pjKdBe2CoJN88jld/9HeIUmdQoB6?=
 =?us-ascii?Q?xYtt76KEmJtqay0/gffWkwb0MCRVD9V67OcrTKOg1EtUBkx/Zf+3Wvvv32xi?=
 =?us-ascii?Q?ryxLLNp3FB603b1KWdBvXShFIqDAe9706ZY1ReHFcnUUKbuWxO3+nklHQ1pa?=
 =?us-ascii?Q?KjJB5fXgS8nS7Lvu5dnYeteRK8ir4MEtThX4AEULRrOC4pItBoXzW/fbtljF?=
 =?us-ascii?Q?+ATPbNyjYKaHEgFaOMtAgmFGPkPkuBy9lnNZGXIaHWRhQqnA63iFHzXT/m9g?=
 =?us-ascii?Q?7EaoDvYYvv4fdHp0jcyx6CM0/oCrDi1z9gloJ6rcXCThfi6rR/DlQHkZekHq?=
 =?us-ascii?Q?LY/L8Ti1vXYFj84mo/znZ8pc3XDEizI2nIHjJff8aL2GJVeSYKw0mHRzpzQj?=
 =?us-ascii?Q?yBIXEoK3ry2p6ER/+9Y9aw3q0nfgIM+/36iClo4LrM7UOskXouMLBKyE+bHw?=
 =?us-ascii?Q?zDI0xO3k/DX6mKB6W1V6reQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(1800799024)(366016)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zvS14MmU5gs4kV+YZyWYTIU5ZFKo74jRq+dzrX4gqqUKDSW99NQYoZIXtGJr?=
 =?us-ascii?Q?g0pqtZhNot/ABaiuz+idGLX036Zp/JTWvxH5tr1519kxgVTjUqdONYncQhoL?=
 =?us-ascii?Q?JCrbwBzydaQmq3JnzzwWPBhk4+DJvXIwtWgl8DHer3ec0h/vefBkHcX2jCE5?=
 =?us-ascii?Q?9HwWpmxfDGMoExgoWz9U0z7znxhVL1wOx4aVukbWqdL/yETwkdWdfKwZIsbf?=
 =?us-ascii?Q?dmtpKq7xT0gl1OB1BFwNBdZBXIc3Yt6C5/4zjSOrw0/FIDeID8/eqHB48Be5?=
 =?us-ascii?Q?hQsM4tQwdUQCi9Xa7x2zbE02S6saHqaB/A/XQO3d9zZEjM14c+Vlsm+Ec/2M?=
 =?us-ascii?Q?G4s+jves9FyT0R37OfF/xvhTDPO0anhZo7hA3movQZSVNKi5f1ckkEkoPepL?=
 =?us-ascii?Q?i6nbG40b1OTAXTxXRx2wHN4mHEdQHlGVX5RS3Ur7jnoaC9sZAEk3dedd+viK?=
 =?us-ascii?Q?3gDnkd7WKIxjfaeOkBJi214Rv35+OXgNdR45DRf9DWS5fXcPxbv1jRAyWH0u?=
 =?us-ascii?Q?jkihpbJvDv1EXBNsD2FQJOnRTaLK3uo5VBu3O47kBz2mUTjAW3v6+1qW2HZi?=
 =?us-ascii?Q?E2xd4f0x9FE88DUDuZZzSVF/It1UzlvtG1Uk3UYuV65CqWUvxTeDMa8avrcm?=
 =?us-ascii?Q?sFryPNvTvwb1RLVyiN90ljbMAJIDF7Hb5FFkt2d5vA29cKEnRfNPICOE7CXz?=
 =?us-ascii?Q?yKMDQgkoLhU806MpSgVvGL7vVueyx5mDfddztCTZxQQOHjqmzS/LmZKOopTB?=
 =?us-ascii?Q?lhNRHF0L1lqYtckeQ2zlxdUQ8FKxVRINUqGkim4M0m4/bf65oqFHO46kB8xr?=
 =?us-ascii?Q?qFeN2kzV+2o3WQ2uzTJVbHKRo1GdAhP6iHFpITJPdK4hiZSJyy9IfBEXmP5K?=
 =?us-ascii?Q?ajDMUqSC+ieggEIFTHd7LCluhPgPAzAAtD3akBx1yU8SKBRg//IvE7R9JTgR?=
 =?us-ascii?Q?2hAvZbcS2GTaoh7C2u7oXm2JBto50HVBXsbTQRqRS9MJRDIX046lT4ix4Yv8?=
 =?us-ascii?Q?jLEF0FROQX++PsAat+vRB7ZOaH//TsZGF17QB/s2b0CTNShP5xTRtpFINoq3?=
 =?us-ascii?Q?kTe3GYGPtnvSMPOmjbAI3ykClUEhYMiiOxMvFnR6guipvM2zBsvEY7ypxij+?=
 =?us-ascii?Q?qnvS4Po1O6KyX19bE3a9XEkV5Rr7FYzuJ9cjtW3aK2/ScbUNE+z4qmnqCx0e?=
 =?us-ascii?Q?f/j6bGBBMjtzwLj/xvU0JRF0YVcl9PJ83XhQ7PYNEYpwQ5mAsStkkCjj5kk7?=
 =?us-ascii?Q?LIZ9E2HqmmVxH55iq9N0ghBTPf7ZhXC7pgjRNziQu4x5RH/yIPdy3/8BKREk?=
 =?us-ascii?Q?PsMDwXBUEfHQe0TnwtoR50ioXmWKmnN3N3nBaezyCJN8yK7ggQ0qkITzG0xz?=
 =?us-ascii?Q?E4sE+aS+gyKrn9DIz2uo3HezsqQDdGboIQBtxpFgAl7LypDwKK6qQg7Jj73s?=
 =?us-ascii?Q?5wXGKWl7aaIlbhdxZo0PsrR/1nDjmS37iY1zULzqDfkUcscGczZlbcGckpDa?=
 =?us-ascii?Q?v4eWafp2JsDXyCl9Zpvp61zf/9vKrycYtyD6CpTWwTk4VlGR5G6AxRe2Z6xJ?=
 =?us-ascii?Q?6pmkeeRyNuRgqbilPqAOylNYOvKd/4kfEDlj1DSWT89Il/toI3vIfJjEA9Hz?=
 =?us-ascii?Q?3HGTwlMlyK7gIk6GZQ59ziFSDzTHIHCa9PNkggg53C6o9hUwmdrBeHLlRnqp?=
 =?us-ascii?Q?MyE4pT3AJsIHg5PZKugVbZAALjuyaPS7YM9ie7fTrROCQPN8m4e22RvXs9ry?=
 =?us-ascii?Q?zteSTYy/GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cc68b8-ec42-40dd-6e6c-08de6e469996
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:04:23.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRTcxea/8ocsUidSNOwcMe3GCiAhI3PV1lA8P0K9MrsSrLFZXRnUrxWT2nj2BKxewQgn25ieyf1YBE82APVmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11167

On Tue, Feb 17, 2026 at 03:38:54PM +0900, Koichiro Den wrote:
> epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
> and then performs additional MSI doorbell setup that may still fail.
> The error path unwinds the requested IRQs, but it uses a loop variable
> that is reused later in the function. When a later step fails, the
> unwind can run with an unexpected index value and leave some IRQs
> requested.
>
> Track the number of successfully requested IRQs separately and use that
> counter for the unwind so all previously requested IRQs are freed on
> failure.
>
> Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20a400e83439..52cf442ca1d9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -527,20 +527,20 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	struct msi_msg *msg;
>  	size_t sz;
>  	int ret;
> -	int i;
> +	int i, req;
>
>  	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
>  	if (ret)
>  		return ret;
>
> -	for (i = 0; i < ntb->db_count; i++) {
> -		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> +	for (req = 0; req < ntb->db_count; req++) {
> +		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
>  				  0, "pci_epf_vntb_db", ntb);
>
>  		if (ret) {
>  			dev_err(&epf->dev,
>  				"Failed to request doorbell IRQ: %d\n",
> -				epf->db_msg[i].virq);
> +				epf->db_msg[req].virq);
>  			goto err_free_irq;
>  		}
>  	}
> @@ -598,8 +598,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	return 0;
>
>  err_free_irq:
> -	for (i--; i >= 0; i--)
> -		free_irq(epf->db_msg[i].virq, ntb);
> +	for (req--; req >= 0; req--)
> +		free_irq(epf->db_msg[req].virq, ntb);
>
>  	pci_epf_free_doorbell(ntb->epf);
>  	return ret;
> --
> 2.51.0
>
