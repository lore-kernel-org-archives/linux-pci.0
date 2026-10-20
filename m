Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792516286;
	b=JU/qJgspZb+rAqNBynIZ648sbi4s5vOOGiwQAxuPAdFgI9rb0S9X6EWdSduIrrxI2rK6
	 8mkFWeb1O2Vr3ykePlTMAjAhAqe+3UkMRqXQAfAlUf4mu/vBmpw3vQQlSjUz+pN+f4SNh
	 cyYZ7azSEOvM3yXMiOYDsdjrfbxak7s41OYr7iITbwV1/qt6/rGEFE2FYzut/jv0PKLNL
	 FJau4xckQhs/yCVOfe4av3bEtM08tV8Ft2YfLrTkoE/BXm9o1vM94VFIsknebwi5OKB+F
	 6LylNjjDjLmpmbQyRlo/7sRoW6Vg1mB80b/4lbrF4k5S0v6i8WhNHhGh283FAgb9BXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516286;
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
	bh=gO8OrWbVFfRmoQBnQaiFjUCclCjZqL/0YdHEzao2gds=;
	b=17Zll4xcBBUehjFnyP9ac0l/kL56jX0OXZvP2AR33uGP0szbZwhntoPACnK8KOrcoucb
	 /bDHAVg6x1Zpz8dJ/5uy2jBwmua44H3kfOObtp/fr3RVcujW5ux2FAQf0Uyi/ZqSTL7Lt
	 xxrcjxaRpjIZBAzFJPq5Ky2qvb2jrMv254YbNf+8oumOUxwYVjXiQT6QdfxzdoZevbytS
	 upE2a245XhlV+fjYAt1b72JeakU0KeTDcf+1cV3Vx9rA9+aWsqoNNpxrWYuH4cAHpcdOX
	 XELsvAVeR1UQO8EYuTE6N8HWnamD4Z2nagMSA+QjI9LauyvG6lU3g+wGAhEl098l64w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gh1gkY9c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A360A2600;
	Tue, 20 Oct 2026 17:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5A360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Gh1gkY9c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHqOn+eLZ6LXbC2CpQr23hrxzuQtwQ9r5tj/CCSN4JePy9YUcfnofKl83Byi9LuGhSM0sElAVHpP8owmHzJ0GhHohK1Pwh5J2B1ByE4D+D/t2HPikHfr+3XOQsj558yu9PxmZLhCHvcsd78HxTGQV5e1Byy6oJZSaoc69XdoM7DwtU0LIBRFHQQ2gbD8FSNpltS2NjA6Ui242p5408uqLhnWbWerULabZ+IhAfHC3uLeyHXh/vILp2EwPg009Psm3Q3hMX3BMlXwFiTUk+MvCAxaujSGDw3FK7XsZP/o5jLK2lrpGEpNWWl8yikLup3SUAlYyJ0Btnp+EuT9oRr1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO8OrWbVFfRmoQBnQaiFjUCclCjZqL/0YdHEzao2gds=;
 b=Ae2axPX4C/t+6VDAFuh1WALzarGY2FVnLNYcRUrpE4gFV1p83mWLXPk9XGh2rXnwKP/XKQLPkdMYMx0KKDAqSOEHoFy3qCQ7IFm6XTm7efYOeVC3Y2PJHn1L5KUkNjn4AknIBZHqduzaYw04L61d4AxDtQ3Tv0EcouokB7fuRRENKV6dWPCJ99FWyVlm0+8ZKz0MhxvQalwI/7Vt+CvlfOZlUjJszS1cm1uPXRr1bzJv5Cp4RkuMujyi85bY6Yh5EqXL+nrDiTN2Wjgiz+9SE89DOznotv6dG2OY/XIU8HvyLCJSnyxql/K9f6geoWyf3haNrNoZXecZ19Mix4H6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO8OrWbVFfRmoQBnQaiFjUCclCjZqL/0YdHEzao2gds=;
 b=Gh1gkY9cU0eLDmv/Ivu1L0KecSLyJ+vEYW/fToQ24ilY48XRK3L++KD9RjXAFY4bMLdynss1vcF+SopH545/dLg/H7x4IzH4glA2KhrG/WU048DpuF6K7ZpfEhlgGBdbCl/jHtCrLxQg6CF+HfDnhXhSMwiH4mkDF4R+IPfzBOCnfINgWtfSGT/r8W5+cF4k0Ckxb2mVa7oX3pD8xvgKE+ieNFtovd/jLuHPkgx+tx6OCG9lz8lRQuN/PM3jZS9Hh0nZME+eLr5yjRWGuPGB02n2WswUTp3pVviJQHv7q6ac7Au32pJFmuzNQG2pq1LbGc0OZOxaiH27nAliaL4L4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 17:11:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:11:21 +0000
Date: Tue, 20 Oct 2026 12:11:10 -0500
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
Subject: Re: [PATCH v6 7/8] PCI/NTB: endpoint: Allow DMA and MW to share a BAR
Message-ID: <ategrk-hgqS1owKU@SMW015318>
References: <20261020054948.1218370-1-den@valinux.co.jp>
 <20261020054948.1218370-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020054948.1218370-8-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0018.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::24) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV4PR04MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7fc8cb-495b-413f-d46f-08df2ecd29ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|23010399003|366016|6133799003|18002099003|22082099003|4143699003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KA9Z+QxQZ3WcGACAReHjv3dHK9gDxSaPrE0o8Bm/CzrnMBcyBer4HmE1QuBP5DnL4k73uQXNEGjfc/Aw0T7yal8EyV5OZoh6Jk96li1vM047Urc6uKDLAOPI+abWo4KuuRbHmtIJ0ErujezGBhDtmtKBUj7WPIPfrNUDCiUVL3quolfStR1xAI1hhnPbLGRr7dzFnBY4aS4ms6WAyEOoGFCZKQMAxMftr0khA+2jRJwdjFzfLXPvCgTDjl/ut77yC8RH7wDG75n40s64XwdDseRLNszYOpeOagdbPCkvXu2KgrANfLvdHxGmtTTdWrkcdtrSjggHd2skL+hyDRTAbxUqEwRuwjjvPKQGboxnYrW45+2d1lOD45zKXZHaXzlUvgiKxidqYurjOFllCL6suOt7qXZI41Sk78ZWDpx5p2Ppc6Fs9T28GLtM3GBuvZ9s6QFd5NtzdzYswxeQbkuTJ7GAte/cAY8BRcUdsEb0pJ9p1WPHIqGoS14zFFtQF1uuhzYPtzdgRiMjYRN0M1nMbY/rr5xtnvcVPd/OjNXwaqXmaIMStsm61xhN8YIjW+mkV6oDzOg8+yPryoGEMhdtkNuboRKndvAI8Xj++f04rdQRyOCQhNJNETbfkhQ6eQSOCnV/WoodOLYIYe3oORbGkgqfv37b8Q/0CTibehoVYuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?45drezrpRPyXj5hyfms9TqLFAxD06Lt6uIJ4jfxm3QzqWjjidrswXlfCMolJ?=
 =?us-ascii?Q?5Va+Sa22I9MUxH4SdZaogPjAxNtE8fTzUSOReGPjlaA6emIWEufRFBcQQHGp?=
 =?us-ascii?Q?nZUbIDcQ+cxaIgyX0RFlWfsBsWKCMWbetcjHMAFb1Hhesj9+s/gStqy524/N?=
 =?us-ascii?Q?wRLitM8uh36Fnn0iVDGRr4q7uiqrtpXgMxDc5yUPYv44iywkkW905Z8va6eZ?=
 =?us-ascii?Q?Ir9LTjf4BLw2eJ+ubndFIQA1+EBGUAjVZjosUpvjV82vi7B0ggfEoJRSHE0g?=
 =?us-ascii?Q?ZcjEYdVpzUvjFBYII3Cl6iH/TB2OEUJoyGx2F8Z2CaVt4uBnXyVL5qzQAToB?=
 =?us-ascii?Q?+iuzimMpBoIZcIEeZlKqxT7qgERF8CMn5DhWkmGp86YE5AhSoawmmZfWNqe/?=
 =?us-ascii?Q?qtfQMHJXHgs49VDMNe423EgAjeZxahZaKwzp+aQppcp0Hwm0X94mDgUmk3i8?=
 =?us-ascii?Q?e9jbzzHKAqz2iu1R+bG5qKXr09jLcrV9AQc5u3G9zkLgCJeShEnWvk5Jnw+F?=
 =?us-ascii?Q?STOfV8xX8v/+o1vM69t9BJTFIl+v1jGhTznJgVyBRyKx0mbc+GYVJxaqqKEW?=
 =?us-ascii?Q?naQTpLJ/07ImBupG907xXSyHPESf8iFRMqJ7gncuf8yZqXtsaORcBT5d0WTW?=
 =?us-ascii?Q?Qe0v7DMK/aWIVicpZUvVoPkz2/i7xFDeBEgD3eAaw9Md+bxmLIlNB8nZBPEB?=
 =?us-ascii?Q?z4e3SLr6+gcq2qO7k1LpEoSgKEqG8dc1lPyhX07QbTMt4O7kZERS7UinJSbC?=
 =?us-ascii?Q?MwiqfAEowGc8CNGsRvsv9D+Tuv8MTBeV1eH2UAhNISyLPR5OgYzeZ8DD5kO7?=
 =?us-ascii?Q?1Hmzz+ecaOdgv/wOkzC3ZZ3SzPPLJZ9k47byr+5eyF/uz+vTyKPw8UzhoOe/?=
 =?us-ascii?Q?mFP0wRajITdbQtl2tEjQlu+ABESGK2AL0e8miXzrVRtq3u37fJZ9yDatUaVe?=
 =?us-ascii?Q?TpirheDV3r4qSa146XD6aRqbXwlAgxeUUfrHWKFFM9vg6kUuHfiRsTtplFFp?=
 =?us-ascii?Q?m1E1OWAy8nwvpDE5ql+N9Y/LSMblqD7puE2Z+Q8ujAIeke97lNUKYX4lKW8F?=
 =?us-ascii?Q?BhnmjLy0pyjjbYcx4rpQ2HEZ5LwNSPY4/fL1ztO6FAWuOxbKDVqI42YeX4db?=
 =?us-ascii?Q?3I9Bbb2EvTN7pO63GynwmEn7FA/X6DsejzE3qsRMFzCL4uIf8OOB6BL1OUSv?=
 =?us-ascii?Q?bULoicl4wwvKN2Vh9bppx1fW5k55/gUrLJydBEPELnfmnC5gC8MEnlSZGE/O?=
 =?us-ascii?Q?eBkVAnInsxigdLvqZ1SylFNACEi1uRqHDyREivhlysOgqZQrCIseATu1qGUJ?=
 =?us-ascii?Q?f7izLE4uIJlqyj2/QsmKLkuYOVQcber+t1vRFPdMilTyGG1j2qYjrX9OSpW+?=
 =?us-ascii?Q?t9k9gndWzZAHhv/s6iITKtrckC5YDVXIqQF52+hh8GDotNezyKu8WSgaIr6L?=
 =?us-ascii?Q?2WHgqCSiEvVq1uX24uWSzTMq1a8qv6S4sM9+/2AnokEncvPz2pqojpFpwic4?=
 =?us-ascii?Q?+Pa+WwZ+/kg4KQaI04eEunArUaerw2u8NzSk/L0MvwO3KsWUKelRby3B9m4E?=
 =?us-ascii?Q?FkvSjIDAMQUEwSZjtWDU2jFBrSJjzJqtGC4h1ySG7dAk/0B/4VQc4wlYS+07?=
 =?us-ascii?Q?etclEFIxaMunwezdsXU8UPrHT+BYSD0PdOsFsKG7hTr115xZYa6O55M7fnHA?=
 =?us-ascii?Q?uess9AmsZBHe2D5gLKK3T4Dk4JhLpGjLPyv3t8RrrMoy1htpiFUn8Q4Wg2Xx?=
 =?us-ascii?Q?yFbzOA+o8lV/HylPG+YWiwh6/lMzNxtfj8XebdTtIHOmIiB1x9SU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7fc8cb-495b-413f-d46f-08df2ecd29ef
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:11:21.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sAffYKIT2xs7kV440xNbvaQuE8Yy1noKZQYtSPhZZzvybUX1GP2suyz3k2y+KcIE0qTFeHsrrZbHa48+hppICb6tLkYywk3anHNMYOiLadqQggIjaRobw9yRzwg92ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

On Tue, Oct 20, 2026 at 02:49:47PM +0900, Koichiro Den wrote:
> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Report that size as the translation alignment
> and require it to be a power of two.
>
> Limit the host-visible MW size to exclude the DMA ranges. Older versions
> of ntb_hw_epf treat the whole BAR as an MW.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v5:
>   - Include the host-side MW boundary handling and place this patch
>     after DMA discovery.
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  43 ++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++-----

what's happen if miss match? host and endpoint may not run the same version
kernel.

ntb should be independ on endpoint part. So suggest split patch, so
ntb can go though ntb subsystem.

Frank

>  2 files changed, 148 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index e0016128b95c..975ea424de6a 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  	return ndev->barno_map[BAR_MW1 + idx];
>  }
>
> +static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
> +{
> +	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
> +}
> +
> +static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
> +{
> +	resource_size_t end;
> +
> +	end = pci_resource_len(ndev->ntb.pdev, bar);
> +	/* The DMA submap offset marks the end of an MW sharing this BAR. */
> +	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
> +		end = min(end, ndev->dma.submap.offset);
> +
> +	return end;
> +}
> +
>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> @@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
>  		*size_align = 1;
>
>  	if (size_max)
> -		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
> +		*size_max = ntb_epf_mw_size(ndev, bar);
>
>  	return 0;
>  }
> @@ -707,7 +724,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	if (bar < 0)
>  		return bar;
>
> -	mw_size = pci_resource_len(ntb->pdev, bar);
> +	mw_size = ntb_epf_mw_size(ndev, bar);
>
>  	if (size > mw_size) {
>  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
> @@ -739,21 +756,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 offset = 0;
> +	resource_size_t offset;
>  	int bar;
>
> -	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
> -
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
>  		return bar;
>
> +	offset = ntb_epf_mw_offset(ndev, idx);
> +
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>
>  	if (size)
> -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +		*size = ntb_epf_mw_size(ndev, bar) - offset;
>
>  	return 0;
>  }
> @@ -851,6 +867,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  {
>  	struct device *dev = ndev->dev;
>  	int ret;
> +	int i;
>
>  	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
>  	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> @@ -862,6 +879,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  		dev_err(dev, "Invalid endpoint DMA layout\n");
>  		return ret;
>  	}
> +	if (ndev->dma.submap.size) {
> +		for (i = 0; i < ndev->mw_count; i++) {
> +			int bar = ntb_epf_mw_to_bar(ndev, i);
> +
> +			if (bar == ndev->dma.submap.bar &&
> +			    ntb_epf_mw_size(ndev, bar) <=
> +			    ntb_epf_mw_offset(ndev, i)) {
> +				dev_err(dev, "Invalid DMA/MW boundary\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
>
>  	/* One Link interrupt and rest doorbell interrupt */
>  	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ac83af54122f..89f828234ca7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -84,12 +84,13 @@ enum epf_irq_slot {
>  #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
>
>  struct epf_ntb_dma {
> +	struct mutex lock; /* Serialize DMA submap and MW updates */
>  	struct epf_ntb_dma_ctrl ctrl;
>  	struct dma_chan *dchan[EDMA_MAX_RD_CH];
>  	void *bar_scratch;
>  	dma_addr_t bar_scratch_phys;
>  	size_t bar_scratch_size;
> -	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
> +	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
>  	struct pci_epf_bar_submap *reg_submap;
>  	unsigned int num_submap;
>  	u16 rd_ch_cnt;
> @@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>  	return false;
>  }
>
> +static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ntb->num_mws; i++)
> +		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
> +			return ntb->mws_size[i];
> +
> +	return 0;
> +}
> +
> +static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
> +{
> +	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
> +}
> +
>  struct epf_ntb_dma_filter {
>  	struct device *dev;
>  	int chan_id;
> @@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	unsigned int i;
>  	size_t align;
>  	u32 next = 0;
> +	u64 offset;
>  	int ret;
>
>  	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
> @@ -371,10 +389,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
>
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) != barno)
> +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno == ntb->epf_ntb_bar[BAR_DB])
>  		return -EINVAL;
>
> +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> +	if (!offset &&
> +	    (epf_ntb_is_bar_used(ntb, barno) ||
> +	     pci_epc_get_next_free_bar(features, barno) != barno))
> +		return -EINVAL;
> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && !is_power_of_2(offset))
> +		return -EINVAL;
> +	dma->ctrl.submap.offset = offset;
> +	next = offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size = next;
> +		dma->num_submap = 1;
> +	}
> +
>  	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
>  	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
>  	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
> @@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
>  		chan->desc_addr_lo = lower_32_bits(dma_addr);
>  		chan->desc_addr_hi = upper_32_bits(dma_addr);
>  	}
> -	dma->ctrl.submap.size = next;
> +	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
>
>  	dma_dev = ntb->epf->epc->dev.parent;
>  	for (i = 0; i < dma->rd_ch_cnt; i++) {
> @@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
>  	if (!dma)
>  		return -ENOMEM;
>
> +	mutex_init(&dma->lock);
> +
>  	switch (ctrl->u.dma_ctrl.reg_layout) {
>  	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
>  		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
> @@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
>  		return -EOPNOTSUPP;
>
>  	barno = ntb->epf_ntb_bar[BAR_DMA];
> -	mapped_size = dma->ctrl.submap.size;
> +	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
>  	/*
>  	 * Submaps cannot be installed until the host assigns the BAR address.
>  	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
> @@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
>  	memset(bar, 0, sizeof(*bar));
>  }
>
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
> +				      const dma_addr_t *mw_addr)
>  {
>  	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma = ntb->dma;
>  	unsigned int old_num_submap;
>  	struct pci_epf_bar *bar;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
> -
> -	if (!dma)
> -		return 0;
> +	lockdep_assert_held(&dma->lock);
>
>  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
>
>  	old_submap = bar->submap;
>  	old_num_submap = bar->num_submap;
> +	if (mw_addr) {
> +		old_mw_addr = dma->submap[0].phys_addr;
> +		dma->submap[0].phys_addr = *mw_addr;
> +	}
>  	bar->submap = dma->submap;
>  	bar->num_submap = dma->num_submap;
>
> @@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  		return 0;
>
>  	/* A failed dynamic update may have already removed the old mapping. */
> +	if (mw_addr)
> +		dma->submap[0].phys_addr = old_mw_addr;
>  	bar->submap = old_submap;
>  	bar->num_submap = old_num_submap;
>  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> @@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  	return ret;
>  }
>
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma = ntb->dma;
> +
> +	if (!dma)
> +		return 0;
> +
> +	guard(mutex)(&dma->lock);
> +
> +	return epf_ntb_dma_set_bar_locked(ntb, NULL);
> +}
> +
>  /**
>   * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
>   *   to access the memory window of HOST
> @@ -1269,6 +1328,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	bool shared;
>  	int ret = 0;
>  	int i;
>  	u64 size;
> @@ -1278,22 +1338,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -
> -		ntb->epf->bar[barno].barno = barno;
> -		ntb->epf->bar[barno].size = size;
> -		ntb->epf->bar[barno].addr = NULL;
> -		ntb->epf->bar[barno].phys_addr = 0;
> -		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> -				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> -				PCI_BASE_ADDRESS_MEM_TYPE_32;
> -
> -		ret = pci_epc_set_bar(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      &ntb->epf->bar[barno]);
> -		if (ret) {
> -			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +		shared = epf_ntb_dma_shares_bar(ntb, barno);
> +
> +		if (!shared) {
> +			ntb->epf->bar[barno].barno = barno;
> +			ntb->epf->bar[barno].size = size;
> +			ntb->epf->bar[barno].addr = NULL;
> +			ntb->epf->bar[barno].phys_addr = 0;
> +			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> +					PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +					PCI_BASE_ADDRESS_MEM_TYPE_32;
> +
> +			ret = pci_epc_set_bar(ntb->epf->epc,
> +					      ntb->epf->func_no,
> +					      ntb->epf->vfunc_no,
> +					      &ntb->epf->bar[barno]);
> +			if (ret) {
> +				dev_err(dev, "MW set failed\n");
> +				goto err_alloc_mem;
> +			}
>  		}
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
> @@ -1310,10 +1373,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  	return ret;
>
>  err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
> +	if (!shared)
> +		pci_epc_clear_bar(ntb->epf->epc,
> +				  ntb->epf->func_no,
> +				  ntb->epf->vfunc_no,
> +				  &ntb->epf->bar[barno]);
>  err_alloc_mem:
>  	epf_ntb_mw_bar_clear(ntb, i);
>  	return ret;
> @@ -1331,10 +1395,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>
>  	for (i = 0; i < num_mws; i++) {
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> -		pci_epc_clear_bar(ntb->epf->epc,
> -				  ntb->epf->func_no,
> -				  ntb->epf->vfunc_no,
> -				  &ntb->epf->bar[barno]);
> +		if (!epf_ntb_dma_shares_bar(ntb, barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
>
>  		pci_epc_mem_free_addr(ntb->epf->epc,
>  				      ntb->vpci_mw_phy[i],
> @@ -1936,6 +2001,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		/* DMA submaps start after the configured MW size. */
> +		if (size != ntb->mws_size[idx])
> +			return -EINVAL;
> +
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, &addr);
> +	}
> +
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>  	epf_bar->size = size;
> @@ -2134,15 +2209,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	u64 size = ntb->mws_size[idx];
>
>  	if (addr_align)
>  		*addr_align = SZ_4K;
>
>  	if (size_align)
> -		*size_align = 1;
> +		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
>
>  	if (size_max)
> -		*size_max = ntb->mws_size[idx];
> +		*size_max = size;
>
>  	return 0;
>  }
> --
> 2.54.0
>
