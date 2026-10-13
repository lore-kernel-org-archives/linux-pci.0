Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021135.outbound.protection.outlook.com [40.93.194.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70C514740;
	Tue, 13 Oct 2026 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901596; cv=fail; b=YLo/VKrrzDjnvnWFZ7uNc+tULORR53hAYXOvbzIzHXr0Youc7f/b1SYFok98YQwyCKRvCFHY2Qw6H4SNHTfailSO/OOj3lXrSqHoncSMT87zJYEXtGmzgIxZRC6N6l3laF9laaEic1Hzrp7uYt7heqyqI3TZzGu2pnvA6Ueu72g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901596; c=relaxed/simple;
	bh=PgH8omHxWdGk3FJ12QWbnpIXACv1reB05dCE3LiiMoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQx4NLKHGd5zryyHuqPbbzVA3yeJhFq5ydx0FC0dliiWGLItUnh11aLoY2AJBwUjEy57Bfi/NXqgekNc2ZldKzyWnyYmf+qWyc9qPj96OgXpwc3NumoYcm4Fh+SKYi8f9Rp+y6dzWORfnXFPLgnTpmwUu9AFAP+jvzHp8Sxym5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net; spf=pass smtp.mailfrom=trailworks.io; dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b=pFXqpAGI; arc=fail smtp.client-ip=40.93.194.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelburch.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailworks.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michaelburch.net header.i=@michaelburch.net header.b="pFXqpAGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIWYYVoQF8QtA47UGDopwXMzi4Zia9wMzfk2D9MGG7LqOGgzlmtNg+FGG9DPpdltd96FqPJA5wZJArzr7FsFQaab0dyUY0Y6TEq65A7eVpFtx4enGYLxcfi94VONIw4gE62Ef7U6z4WHs8KrWyjG2m2P9DDzItgq7XJV3erVd6p/7B5lI/EXj6Ue6ffVxB5dYX7bzCdkJY3luIhQfw0BGFurgQXCP/oyjJBUlrb3Lpsj9N/RempQnLiAqnhjrkeSu7+9dVGMNfK5ZVEbBaaHwcOkIKbkb5v3mWAD+psusqtmgM8e6lkwFEtR9oAwioadN/a6jtbIZVNYOWCO/O5zmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzuXkWtft/NRmmBriE60SwiLFY8ZDsH64Ez4OgqK7QE=;
 b=khgpC06s3J50mDP9Dpk2a4BnOvWaYrkDaNC+F12CAJzvSlLpc6RvUTWPQvhrRh2K7BtZf9G7RVjPlGzb3616y1IADIH2bMfwciPpN31+qaOm7fEVm87OcbVXZxpT0SCfEjgZNJSHKwd5hUwObS6HGMrlrz0KCnqTaBvWsD/F5VQjpNfkE6O33SHZxMoc6/Nl9bSUJScWEkQwloSpq9tyHo6K2wJC/xxSzqVSSgepc+N49DatJ5zn3j5Q9GGfwKNmurE5qgSLXRR1IkHylaDbxg6PjVYkDY31m7PPlWgGoXSP9SnUv3NEZdjv04pK+J5G2JHytdDF/VgHfdoGFr+kmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trailworks.io; dmarc=pass action=none
 header.from=michaelburch.net; dkim=pass header.d=michaelburch.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelburch.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzuXkWtft/NRmmBriE60SwiLFY8ZDsH64Ez4OgqK7QE=;
 b=pFXqpAGIW7UcAQNfYwMuVFf7vm31QoeR8skkWepOYx5GAg3KtpFHTUONTElFEnorVCot1o/YUt3c0CxvyTCFXP9MPTd1NUcQ1X3WAW4T4lLXFqifEh95v/eaTr0SbVTbEUBgtaVJSzAizJ6Ur0EiX7GqA0QIQcbIGGkwQpM2KRdzDgQO0sg4UCTTrCVNNk2GUD8xgFHcReJCz3jSVoB+/aKP6t7G/fsffmNHKzgADNjnrRK3D1YAuy3yOtYmR4B0lwIEoxI4qqfAGLqPH5ckyDS/YaukgVzota/4HwK24Hiew+Ritg9xMFvnEQ0f4i1K3parkwCzF81Jgqv3/K554A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=michaelburch.net;
Received: from PH7PR01MB8123.prod.exchangelabs.com (2603:10b6:510:2a4::19) by
 SN4PR01MB7454.prod.exchangelabs.com (2603:10b6:806:201::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 14:26:30 +0000
Received: from PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930]) by PH7PR01MB8123.prod.exchangelabs.com
 ([fe80::da98:a31d:73b6:7930%5]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 14:26:30 +0000
From: Michael Burch <me@michaelburch.net>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 4/4] phy: qcom-qmp-pcie: Split phy_ops into init/exit/reset/power_on
Date: Tue, 13 Oct 2026 09:26:19 -0500
Message-ID: <20261013142621.10328-1-me@michaelburch.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com> <20260915-align_pcie_init_sequence_0916-v1-4-0b2195836f30@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:806:6f::26) To PH7PR01MB8123.prod.exchangelabs.com
 (2603:10b6:510:2a4::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8123:EE_|SN4PR01MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 3746569e-a5ff-48e4-b389-08df2935f96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|261009223027099003|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	zORX+ggSHsZk57BKCyF2ET2J2GEphkyMX0IH95O111cR9kJbr5pxgDkpqj7rdZEJimY5txzzRKVQgvzmI/+wvA5G2BpemlRERw8ZKpFtbsVuLkrvHTiqF3Kn1fO6g/D2Nq9MCJR6FyklUfY5D18SvBxTo1PMwtXXJXn1WgCXsMIXaZ1FaEyWfuzd3TVAIXywFeeAbi8mzw8cXvZlvJ7+2cwMGLfFDucm5F1NGYHi/FLVScWR1/gCDZKQ3iVz3Nj5xhsL4f+LpKS2nJLS/sJ3ZlwP8zTNXNSVsmApSDVdhNLLwqTJgiYjqDFeOL8si935zbOmLJd0ww0saY2+u3vLy1ciTBI5tArjaDvSkIOnfBBxoOAxWjBTtkIc7GsVJsCO0uSkO1glqyWQGnexpHbM7ZbboqaAO14AXjKi8vXNF9ifFWogXD+mUhEsOJGJJ+lJ4ZzN53PnQB+/Qb7qynqX9I70qAe2+X3Z0jC0scYFRE6ak8rkSxEF+qgKb+QIJ2YXCtkr3q+Q+W02iDze0OTctHAKZ8aiVvDCrIEpfXM6XN6j+KYMMbA7ZA20gg29mCfJYQwcesJCvJOt+VfmSvHoJhF9DDToE+p/iy0j03mWM54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8123.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(261009223027099003)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1/f5lfkzDrt3PW52KiU+PlFOd3Pt7TSodOrJEMMR/qak4avkjD2b+5VtpQe?=
 =?us-ascii?Q?+HgUuYsmP0JR+/qiRcpUtXhJIDxSquchFFnrk3oHkjjS7jkgXsDPHfBs/PGH?=
 =?us-ascii?Q?I066Quf40sNj4IbFHAkNB6DNOTwnpBsxWJicOIr9YbDzuSFAHRtl6TPhrozD?=
 =?us-ascii?Q?ivNm4z/DWkmJbf9+fLNThvaQjB5GfY0p4jdXrYRx5uq6lTi0NgTMS2nQ5gcw?=
 =?us-ascii?Q?RzaqA67yTWdY6EByZzufxIME4f5ZoHM8oVele7qkmCnNnRtr+6CEdlz6RVUU?=
 =?us-ascii?Q?LZ6Gm4aL1Rur1UmCrcYi0/PC3xqEeKimC0QLZWqb7w+O+8ML/7t0jfVLHSsQ?=
 =?us-ascii?Q?MVZEt/Ue6D0dHP4w7eON5csjp97RhDH6MbCIZGyY6rYn9/cgeDi2TS03RVuJ?=
 =?us-ascii?Q?M11nfbW6HUpZjFbJatdtnsPGJdrObrnqEBxVHGwcw9OKjjRZwT5BlYLgWioq?=
 =?us-ascii?Q?07v5hUOD3ouLJWGY/OKgMJMRLgoqxsB/U2ysCBbhZXHFQ0wNkve0VtQbDMda?=
 =?us-ascii?Q?Lwh6eVpxgk6G5uHt4rg/GFIwCxCtnpxtwixUVKlYCT3fR9m1/JLh5b4C71Hb?=
 =?us-ascii?Q?jlxiUMYgVvxuQr5TKnPTnb2Iz+WagbuHUtJ7QApWJcK3JWdMqPs+I5C8RazQ?=
 =?us-ascii?Q?sKakyJsKkS02ak+A4dTv+S9U8NOFXHQL8/yGAFB6kK3M7hbrJcQlIu3HF7kA?=
 =?us-ascii?Q?rdEFs/+e9hTAwNwHw0NAwVr6OBjRC5aJ5K8NkJWjmJN0t/Y5Ahw+RPGflq2/?=
 =?us-ascii?Q?NdE03hVB1vCv8EHRyBIOuGAwryzaiQvArNAHECIq5c5OCDfh/nXMlVzYEvc4?=
 =?us-ascii?Q?voK9b2wTrUVeDY553ALa5/gNnzV2S03dc2Voqlc5oejdG6wp+xTWfnxYrNvR?=
 =?us-ascii?Q?49TuchyOuW+TeynUTi/vWLj8VFkBUYkwbymldWsfeLYut3PD7+S2pVSb4L/q?=
 =?us-ascii?Q?z25MTsJsr1SXU1DtW3gGf5SKVHT2VNwZu6tX2xHxH4MpPGMw5PbfotHGDVnL?=
 =?us-ascii?Q?T/FelqCV3DVbCpopvKmFCye5NPurm0oEoxnZZ7EnaljiwDnoNAButCj0GSSW?=
 =?us-ascii?Q?f3jTwx1lIfRcJpHb5TDIuo2hKbbMQhij8L7UH7WyTS1UipgdhtaWDFf+72Cd?=
 =?us-ascii?Q?q0DbfbzYELqoA4/JDOcVpY5/GcBGiu6ddO0haTjahl3va2SCTwDW+GZE3vr8?=
 =?us-ascii?Q?QuvWmaQMFHzEhrfuGBiCtPrIi3a0RA7zgm5Ypa9qLOP+gr4qVDBAxdH9aeLV?=
 =?us-ascii?Q?S50bBA13W44GukIpwWgLUb8ZfFpXSFplG7KeVKg6kcqkeXYZ7l0ReuTs4UQ0?=
 =?us-ascii?Q?aV5N+2sU0YP+6vQctBqWaoh8Ud+HdaZn8uFXu4GYdIW87XBUk//a5Sz2xh2W?=
 =?us-ascii?Q?4DRfJkPy2K1dOaxIvS4KKAN0d9YEbxgX4eAdVW7yMScOxr42ZuwdbRiRh/VQ?=
 =?us-ascii?Q?e+lxZ7S6rIuXWqX9LlpbuOa6GnOEBVA9+1MdYU6Qo0zX5Dh7kXpacvZI8AMo?=
 =?us-ascii?Q?GZYU/FgmwNgYhdb8KogQXfwWfSnL9NALsNCn28s1lWuvTpkK8vEP4MDPd54h?=
 =?us-ascii?Q?mi2jaK0jyV+Ijm0LP9GJP2bI/0K138WaafDjcn+MIbTbQ3XBc/QBYVktqh1D?=
 =?us-ascii?Q?Nwru3knXlKHoJsCQ8jhO9HpgXNcefEkyPFDCmlXG5+Y/8yh7TXxC2dXYO32E?=
 =?us-ascii?Q?2NhqunD5K2YPbb6hMAc4f1L37JR3hv1SZASAnFFzech5kYNVOf4etPfSD9iL?=
 =?us-ascii?Q?CRXd3NzH2Q=3D=3D?=
X-OriginatorOrg: michaelburch.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3746569e-a5ff-48e4-b389-08df2935f96f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8123.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:26:30.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8256b244-08e6-4df2-b146-877069d9ce10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfsgLxjJdoefzb6qf3Wq2b+gt4CyoYYI66wfYysSqwl7N5cPFY4hZYJA6cklIM8k4yb/E+9J8+lZthPdUgOotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7454

On Tue, Sep 15, 2026 at 11:04:24PM -0700, Qiang Yu wrote:
> -	skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
> +	qmp->skip_reset = qmp->skip_init && !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>  							    cfg->phy_status);

[...]

> +static int qmp_pcie_reset(struct phy *phy)
> +{
> +	struct qmp_pcie *qmp = phy_get_drvdata(phy);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	int ret;
> +
> +	if (qmp->skip_reset)
> +		return 0;

This keeps the skip from 910b828b22b7 ("phy: qcom: qmp-pcie: Skip PHY
reset if already up"). That skip stops v7.3-rc7 from booting on the
Dell XPS 13 9345 (X1E80100), and I've sent a revert [1].

UEFI boots from the NVMe behind pcie6a, so the PHY is already up when
Linux probes it and the no-csr reset is skipped. pcie-qcom still
asserts PERST# and resets the controller, so the link has to train
again, and it doesn't:

  qcom-pcie 1bf8000.pcie: Device found, but not active

910b828b22b7 only changes whether that reset runs, and reverting it
fixes boot.

With patch 1/4, X1E (qcom_pcie_init_2_7_0()) would run:

  qcom_pcie_perst_assert()
  phy_init()                        skip_reset = true
  reset_control_assert(res->rst)
  phy_reset()                       returns 0, PHY not reset
  reset_control_deassert(res->rst)
  phy_power_on()                    skip_init: no tables, no SERDES start

That is the same sequence as 910b828b22b7, so this series would bring
the failure back. It also doesn't follow the HPG order in the cover
letter: the controller reset is toggled, the PHY reset isn't.

Could qmp_pcie_reset() always toggle the reset that skip_init selects,
with qmp->skip_reset dropped? If link retention comes back, the
controller knows whether it is keeping the link, so it can skip both
its own reset and phy_reset() then.

[1] https://lore.kernel.org/r/20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net

Michael
