Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC7317709;
	Tue,  3 Feb 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133285; cv=fail; b=lnCWeaJs2eQ/ycHDIGeHbNhKuZeTirjgoXaFnpT3Q8PCa8apk7VGAWX7ql+ob/vLhScFZMTqrBX5kiYWpqDrOLxpzEexZ8HfnBtEri3XmlT7Ip2EmOmngfe9h1s1qBbIaotWOOQ98dYod5EjsHVmnuUUlnkG3z5s3Kp9JLAIiYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133285; c=relaxed/simple;
	bh=sn3wGI5izxb2Ln/Km3NUd1NEuVe/Hj3QS1+si8MiqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EQrH15wjiMuYvZzecUNuGZU7Fu8HIh30k4r7wAf+U2GPZkfFSKKYgylwjeirX3M/hHR7DdW3SlN7qzf0MwwJijy8y8E3zSpBz5QdffwaH+4wIYsZRJsgmVtAri3aQo9/L4dkgsejr3MOhR8cTtU5CFI5NpvPAWAYbCCgNuPhuJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eT7EZS1o; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eT7EZS1o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3822qZNXRbJmeKttjd09dhDzo8H5dyjwm79hb+pbXRgoQ3y0BICqCLmdy3Dg3g66wBwHthpzvjpubDpbgkEqbdKrTMR0CFrVd8xUNw8qCf2E52nNiBGUnW+bhavN9V2c32mayfqsAUq6Yddov3L1WvtLVIMaRrakq7ETKjKJLUZLfrdL3UfpLNJ7OGGhns1c43AehYwq8FnOlYJHtk01sqE5vnj9yzR4rZ7OrCvzska+CBPu0Gqqsg+IQOebrsTTsQymiFe7NrRrKSuJBqjd/0EFldSsVoWzbiSobFvR9ibHjxoqVnajW035iai3ZghhWaYVCzGahyHzh3Wp932IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPr3/K2IA7B+Psb1GDUE9EqV/EGskCr88s3zkU61kl0=;
 b=naZlnP4/ywMd6YJwvCDaOXznWruxNsXdDuYnncYM8KErqoqLF/MX9SWTUwqJWrYdXJhX5bSnspziv3rWBPiHcX6Ep+XRWxckI2hlJl3O1ooV4WQXtwX4IhEYwU/Dd2gDFjkob2JDPFbjIJv4Y5e7kY6/LUH18LbtQD2x2NMSpMf5zeGJg8CnrR/jv9kYfS3VGdefrynatAjpgt8vuABbupSBamtYgQoz0iDCbL7GbcWrfm/ypdElKls9Jpue6SzIKuHUFoCYKgYkO4iB8jx5MuK9D2PNVFu1k1uuUkjfoBXNGem0UKcPyJN5y2m/JakWqfbVBQvyKULY96aPCTNfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPr3/K2IA7B+Psb1GDUE9EqV/EGskCr88s3zkU61kl0=;
 b=eT7EZS1o7iVFPse0+3Ez8Uy1lCSrRFtGeKXb+P7uCuzazSeDvB/MQ0FCLpi7c61d9dxpcQWSglyIZNEklAVFHO5bMXlyCWKepidlfqi7qLNzK+9Bo+td1vZHZN9srkKcFqYJ4qBWB96cSL3wnF8Ov+LW/hFpukQhyi/scmN/h5s3gG039CYD1J08VTaruaXp6zHHaSKoPfm55v9rVsO6lGyhTPto3xoeq+z/7gUExct9boyiIqh8CyqaGFJPllHiH3ONGE3QSISs0TsHEpt9qyF/vVojnEU2G04BLnqEc7ZDG6JVRA77F1TGTqfawUa4as1rKBT3MWA1v9KA+RaLxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:41:21 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:41:21 +0000
Date: Tue, 3 Feb 2026 10:41:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
Message-ID: <aYIXFzOoQXq8Xtyv@lizhi-Precision-Tower-5810>
References: <20260202151050.1446165-1-vincent.guittot@linaro.org>
 <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810>
 <CAKfTPtDjad7aowTQ3UJPi5Qqgzf3q8J=kASa-t3YM4zfjUv3-w@mail.gmail.com>
 <aYD+/iTSF8ikTLIY@lizhi-Precision-Tower-5810>
 <CAKfTPtDcKw0qc3o70AT9_n2omejNrh9fnkwS5NWKQpqjaCnBdg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDcKw0qc3o70AT9_n2omejNrh9fnkwS5NWKQpqjaCnBdg@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS8PR04MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0ca6b9-1366-4e70-3106-08de633aadc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKnKLkLIr3bsv2JfbG9rRIoTHHdszuuIZSfDvbg04wgLTJqxvn4i6npc7JXb?=
 =?us-ascii?Q?PT5K1U+iRM7PAhwrc4L7dJ7JAh/nbTF0UiRYefittsI85mx+8XtCz6v2nLsf?=
 =?us-ascii?Q?mR1pZPZ2I1AUSJW/dBy0TSwu4uaWoQxQgp131EnEPzIq1MAkneGvvgE3P157?=
 =?us-ascii?Q?W4AMUrldiavkgxStM5Wfhsndwh399EPE83Bw1utynaZO+0+rHTnWcGPW7Jvt?=
 =?us-ascii?Q?4qFGju3WiYaGPEtjlxVWI3iXWs87N/tChhjwL5sJDgT8Knib7mkeXLRt3Iwz?=
 =?us-ascii?Q?TeeU5R/RJhX/BA3UqsLyJ5Ulh7R6g1bF/xOknY6G7Xbrho2OsC6K4GdEYdPo?=
 =?us-ascii?Q?nvWRFwYHwk/99fq/HQDt5G+iwi96Zwz0BPeSOFzkiV7iyR01pxhPQgZgFWnx?=
 =?us-ascii?Q?r4x2WzjN6wpP6nGLPHt0oDtqBQFiu3UMub/gBYWapXeZeHrFbxmKvaeVU1sq?=
 =?us-ascii?Q?G16GDsC2/63qQKgjxxujNNFv+Mt/JH+P6JA05jAt1FUvh7mn4Qojxk+7exJO?=
 =?us-ascii?Q?mEU3dyGfbWVtbkCxX2X6/hwx8oFZuIIUYiTZtCrm7+hFniXoPD359vopnsEL?=
 =?us-ascii?Q?UzL7/TVjfp9qTgRwA4vAkK23Tt8B7ehQFJFFsV0wHD0cjxTmjPr5PRHBxALd?=
 =?us-ascii?Q?tnom9lhi44COyaTpMIPwVCIIjgQr1v1ayOqE6t4PjLfDjKqDptE+aAkXw2DI?=
 =?us-ascii?Q?ZFqpo18dnuuCxOETRaOA0RegYqHsb/mqn7KppA6YqgMO+8pt+xjW6YwJN+F1?=
 =?us-ascii?Q?VWszY/4LBmrMOq/rd39uTfpuany0TRIykIQJwpRCQS2HteOTJnJee6L4BP/2?=
 =?us-ascii?Q?9neCNIxoV+losCgVPaZrlYo8656jMWA5wtSqLVp2W8zw3PaJ83pboK7W0eeC?=
 =?us-ascii?Q?zt5PBSFWW5ZmHzDoX50I098TJeWErf49zucwB/4pbwA3I6lbNGuVXHTFYEDi?=
 =?us-ascii?Q?CTVQLlOUhb6TASuA8JZDwaXyx4iijgskajMtFlvdL9YDHkSCqdLLKrDZnmRg?=
 =?us-ascii?Q?TVIt4Y3R2X1cAfuj/h8DyVgODuCH/OJZQrtaO+BwtfgXYQagVWtw4ONEWTXH?=
 =?us-ascii?Q?3sQtjMotju05CHXFeVnXY5++hJM8Lcy3kgeqc4lboCM9Lx7XDgBbpCZTv9EL?=
 =?us-ascii?Q?iiGTs/thLyM2kINi+ysZ7c3qZgi0acum8HunoDfn0REsntVcRkuHpFNgxB8G?=
 =?us-ascii?Q?AOcye8iXfpX7oglqOh9k2HeMkhqzov86Uc0lKIm4qeNsO5MDvDhsDBEZ6NNM?=
 =?us-ascii?Q?d0k7nR61ep/R2gMoaQsrFXUoh0PI3G0tSoF8mIT+IZEjcTJIZS7KcOxj5T3L?=
 =?us-ascii?Q?p45v+YUJlYxEvZLTeikvR+6aGxhZK8zcFmIBB/UsnAY2M5LSi8sM6KJBOicq?=
 =?us-ascii?Q?o10zV5xDRxToHyFYYdLlDLpDIicu0jSLNGXE0kaJyjEfEd/ZlUFnLBgAVGZJ?=
 =?us-ascii?Q?ZLU5FexM06UtQoX1tM3ZT6C15v6TWOW8oJgZ5mF+HW0xJj3LEn3/o5CiIAhA?=
 =?us-ascii?Q?V4PI0ZwwDgXy0Q5SEMzZuJjPatkvbg2ut3yK5gAv/OsZTe8Bx/YoWZClko+9?=
 =?us-ascii?Q?EZZjeE1Hpbw1OFZT+logcB1fLW177cb7KxU0qxxa9VkXeWL3rcJkURuxsdl2?=
 =?us-ascii?Q?U4u61bcitgnRjgzBe7CTsV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GnNKI8fxANwkikGxHgVK7oN0mzgNj5pZRYgGZ3/oQT6iHG636DuffCX9Yzgo?=
 =?us-ascii?Q?oriAvxNLziTWDCSpkOZRTYNUmwoqkGRgBNq65E5eW9tAoErNnhDGUDuGDlgK?=
 =?us-ascii?Q?Klr0DA3P1nM+Qq1p+2Fe+/HSJ56WXMqTRh/n2qOP3+lgVz1jropyioklwsbI?=
 =?us-ascii?Q?wZSknftdn38tQrZbEq44NrhD9joNhgWWIyM7fMIh8yeTGHJYM00oqnnl33Pl?=
 =?us-ascii?Q?d2w6NbTNfu2Egb1atkgSyuqbT6JZOJpvJbNInYtD3ktBpskRobVGVgoGUWeP?=
 =?us-ascii?Q?+TjnXHS5k6/1WHKjIVIX6Bw1kFf7Dwnk0n6Sh/OBaWTUoeLMB0m7popIqgry?=
 =?us-ascii?Q?XqQdCBwUa9FrSOsOQVt2qmonRYxhJWAtytrxZ0ouWFJm6qiSx85xBqBwv9wq?=
 =?us-ascii?Q?BSdde/9MgG39GoIx5SzV8BDYrVPhLlrhAdBkQkr3q5TJh8Efc+GPaAt0CSLr?=
 =?us-ascii?Q?I/pez+E0O8L4oNMimNiU0cNDFyBi6mai4fDxEoMVYC9GMKUGfvdnOE/sLVn5?=
 =?us-ascii?Q?yTZ+aF6IsX8tiqD+h+PzP8V/n5TowuFQeNpz+OV5dtWKgW5HsfCX2r8ggjKn?=
 =?us-ascii?Q?hY6Jh8d6R9fytnNreZq0Fm9sMvldgmT9tuevLgVQ/n2BYG2RgjPbVxmDYhlK?=
 =?us-ascii?Q?i9+mDjUm5yFLkIUDQbx4f3AWYYavErzMB3SbG2Zh+Pae308hECUQN6OD6cXr?=
 =?us-ascii?Q?2I42raI283uTbMRoe9JrsUJ/BgH9BlbLd5fG3Y9rLFPXJUVX1R25xJrz5bw8?=
 =?us-ascii?Q?83+kv8zEf6I3p5T1S+6mGgXxdfx9MU7W5OwRdd1i30pvlv8ohg7j3XH/uG7T?=
 =?us-ascii?Q?oPFA/GTqeOpPRDqOcT4L+/kV1AuvnhbS57VRZZ24pdZOiI1eQPdXV6I90YYT?=
 =?us-ascii?Q?h6+lWkLHIHcWq31/GfJWOhJg30H3mP6hRQKr2uhJrgh7jxg2wLtcSrE5tqd2?=
 =?us-ascii?Q?yjdcVZBcIBTSlyeJ75osh09z+xWadQsTwkJ3zmZf6+LiS3ysbx7ECpUCQxBY?=
 =?us-ascii?Q?z+rJTrJXqgPotGrPhx5711U8oEp+hraFvE3LXXZFeQ9K9yCvUNJnnTTmjSB+?=
 =?us-ascii?Q?EIH/IoFqIlV7/po7xMKror8C8SGL+aCLTo6NmOxwPA5vA9S3BQJcTPfzr730?=
 =?us-ascii?Q?GHUh7Y51WbgLIIZBLkdbgdQeMXnfIU2U16bU7sGygYj7yqtQxoqAHMevyp1m?=
 =?us-ascii?Q?e6Oh+1gG4xI3A+UV03SouAkeq7tnBQTmz5jvHE9dz5pvr6WKLrBzTn7tjaQc?=
 =?us-ascii?Q?4YMN5DsGGxfmAusXjP3ASQrm5wr+XnaACazd1Gke36SvSvxkoutXx2LlXeRC?=
 =?us-ascii?Q?xCUKbZdUFzLNpTcXKCc2N3ZgAO9vfiNFE9hckah5ukQbxuVXusauK+2+LfsJ?=
 =?us-ascii?Q?+uG7IbqxG3q3gT3576CSveEjHpDEf2iWJzRI0cmEG5/5+teYw72bBwDrkgGw?=
 =?us-ascii?Q?nSwRKf3/ZuQYMDQwhwM8I2cSpQ+nYGi18WYjN8WCmgryiE37qDhJqolI6oJB?=
 =?us-ascii?Q?oDO/bbkwIKYIU9PTPNvkmT5AdVngjdq6GQi3A0iLpZ5r0whqnhjoTgzERS3b?=
 =?us-ascii?Q?D+sbWDoQRhHuMW4j77vztHRysiuhS1SFR0jhk+Uk07Y+sxqZX6z+nFFiG+pa?=
 =?us-ascii?Q?Nu2GdL8Qi/dGQFe823IctaBqYQZmh4w+fbNpTfAot/F1t6/CmbWEbiCeW96+?=
 =?us-ascii?Q?Ea9ffet2ygA1MHpm3v3jZMPHVBL/ZJxeSFllHPsooVKiQBwS/8lpx45XdMIY?=
 =?us-ascii?Q?HrtP//Ynvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0ca6b9-1366-4e70-3106-08de633aadc9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:41:20.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgQDrcF+vm0z1Ut+uCJgPnqNds7DhLOugfPYrEcNRRrvBoUydltrJcx3EyXqCprRrUdOrMCyWbx3Mzh1JXTnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974

On Tue, Feb 03, 2026 at 07:56:23AM +0100, Vincent Guittot wrote:
> On Mon, 2 Feb 2026 at 20:46, Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Feb 02, 2026 at 08:23:30PM +0100, Vincent Guittot wrote:
> > > On Mon, 2 Feb 2026 at 18:42, Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Mon, Feb 02, 2026 at 04:10:50PM +0100, Vincent Guittot wrote:
> > > > > No error return is missing after the loop resulting in removing the
> > > > > ports from the list.
> > > > >
> > > > > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > ---
> > > > >
> > > > > Change since v1:
> > > > > - handle correctly the case when there is no child port
> > > > >
> > > > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > > index 47745749f75c..b3ec38099fa3 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > > @@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> > > > >
> > > > >               ret = s32g_pcie_parse_port(s32g_pp, of_port);
> > > > >               if (ret)
> > > > > -                     goto err_port;
> > > > > +                     break;
> > > > >       }
> > > > >
> > > > > -err_port:
> > > > > -     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > > > -             list_del(&port->list);
> > > >
> > > > break and goto is logical equal here. So only need below if (ret).
> > >
> > > Yes it's similar that why I removed it, the goto becomes useless and
> > > make code less readable
> >
> > But don't suggest change in this fixes patch, which should focus on the
> > key part.
>
> It's not a suggested change, it's the fix. err_port is now wrong
> because it's the path for all cases.

But "goto" is the same as orginal "break". Really fix is below "if (ret)".

Frank

>
> >
> > Frank
> >
> > >
> > > >
> > > > Frank
> > > >
> > > > > +     if (ret)
> > > > > +             list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > > > +                     list_del(&port->list);
> > > > >
> > > > >       return ret;
> > > > >  }
> > > > > --
> > > > > 2.43.0
> > > > >
