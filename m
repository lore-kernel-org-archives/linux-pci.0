Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493824D8DBE;
	Mon, 12 Oct 2026 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830610; cv=fail; b=HkzGuDmw5OVj/FBv+bIVM0Hs3CEM2OZViFtcrVVg2lSa6PIQ/fAvZtx6rutRhUlbMUnbDpQsGUswxyXhQgSzHRNghTZwu1wXKxGCP4KrpoNIZWEL0HOBwXxGgo102o8KVD+dz7QhfzBxGyA4emLQE/JNzAEdDMUd2vH4pTdiztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830610; c=relaxed/simple;
	bh=HrHr7RzBwjGE6ZdrOpdvML68SOhBR6VzmmsORX8iBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qQofy6KKWCnaL3IRhDj+/rysMWdLZV9LxO4EQdrRVajzzepWYbQIPtjKRs1mUMOKH+n4lD3aqqFhVbyym8kfrFWHPwUH1xbtVK7nuM+YZAsd9P2G6f9cJqLQIVZpUS6asl0BTNbxWsNlMwZF7ZX4eiiNkKgwHKFsZ5E6fD/3XTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ozXjTQPd; arc=fail smtp.client-ip=52.101.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ozXjTQPd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM880S8+V+EZ14Vo4OUN3gVrvLrpFXKP6410kY5pjaxZ2xpW7xvcR5/8XQxxSSmZhDgSbOdCcMOtfkw+1m5FjlOQdojGNtbH6clqDFpCNOmcDNZPLFGEzbilN6GlOLalow9U39H/XAm4Ity5bmlfA1rtKXvMxs+zBYd0Im9YxW9Ex8PjVMxWZiC8RDUV8UaHyVkeP/fM/XAkVXK1PtIv3gOEwBJxBjihR/RUbwJyK5qE0AbMKLjgtBz6WazvDhN0/Yxe6YPvthdt0PVd65nsR8Y3nvM8NpmJaQFs393cFOVsoKITvQdtfAZr2laSmaRffrkUGlmOVBOeXYOFYfm0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwQBedko8sbySKXN9Elm9cJu8dLKGldjjgM4x8UNyd4=;
 b=SjAGfPWrdZ8J55eQKE7nh48jiQVI6r1Zu7CxxTIbd0bXWvy3MRgevbgh/kDzoC2rIlINElkXaJuDO7D9901JOhEfrRV4DGL+3PZQJ558t6eKn3qX/2bqfGaxkBJ2nihY+VYYE2FkRx0O/46tYcRqdBf+GJwNRqcHmPckmshuEsVIz3PQPOoZ/gjAwEqPmroWqRCkkbnwqXn7U6Qj+hGSb8Er5OdEqsOivyyLIh3Uwsn66aIeumbJ+letC7uvnKaD9Wg5lpy17wtYzv6/0XxvzUGZ193ic+h6HsWSDt8Z9O0jqTrMWwb35Qcaqkg6KBmK51S4IkCjz5+55lSHvc8hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwQBedko8sbySKXN9Elm9cJu8dLKGldjjgM4x8UNyd4=;
 b=ozXjTQPdmyOUR6461ZWwzxKdXN8xkZJelM0ZnVnJQM/62oo/M8MRPeHdJtf9U753IP9rEv0zxiIQjpQUXstcV2coBFUAWzhxJkHRgK+y80ewPTSxN6BX4pQ3SNHtA6vGvvrP6PB6YPmEuD0hSLM8oz3cNFF2sMMVIL5XjDp6LcCr5t9lAQ51E7fhmWp4wF/VtewmTe0pb5FKUM8V94MLtsI/UbE/GS0/ftcsxmdzSVxFlPEEfXT8+vQaRn1qiox6wFhgNgeENVx167DCkxCC5T/7KRCVnXm7bw6PRWiR3S1cXFcBE6aHkjE15RSAlZ4qJTxDpnPnhASZcYPsFnGPlQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 18:43:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 18:43:21 +0000
Date: Mon, 12 Oct 2026 13:43:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: jan.petrous@oss.nxp.com
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bogdan Hamciuc <bogdan.hamciuc@nxp.com>,
	Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	imx@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC v3 03/12] dt-bindings: PCI: nxp,s32g-pcie: Fix SerDes
 PHY phandle in example
Message-ID: <as0qORxP0Roh9ktO@SMW015318>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
X-ClientProxiedBy: CY5PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:930:15::29) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c945f3-de41-4a5f-0422-08df2890afc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|23010399003|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	IfcSg5xQsvaevAib+loyfoVr1DihwvkYT+CsxLCSyfHHN37z5Ip7fdPT59Rls8wqxmX/2DSwkbwZ6DzIGlP3qSlXn9ymB8YrGjCvr7ym5z1YWno8a2wUs3p7IodTj6H4pxVGNiCQ8z75YfNZ6PLpltsgodLj6fOXowT7zjcFsZ6KCuY3ADQitfkjwOwJIuAjHsqBXjEz76kz5hcYCHdm+tAxnPsEzFrmoJd+Oap6345kExfXHZsPc21ZUa4nhnf75NgFSYAfdnKjvQBSqjz/TW4CaPb3jyGE0os9RUtfGk5WTx/AB2Juw7mCzaKb0eSAaw8msn6DU6vKGSn0S0CFGRzKhUyVXK3U8HoNCcTkOInx/0CNkOta00ees1z40ndwz4RNezYfu5nmPHYAJVImSdVmDeYUiJJOTJtjy9MyquwE9qKE3keRaOCnaO8cDQVxAKsLVmBClJGgxr+7LWu1a1cEcs7lKb2Q6HI7jzmUO0MoLLxlV8ZWLsL/QmkTXMeuWiiBm+6kmrLdeySRQFZf2wCVLQJ8BGpAUgdhbqKRu7ng4gfD0lv7Hl7prWW8LbcN2JtXrsKZDME3CUKiaDYwdRbMZDdup2SMTrTJGdfnB9Yv/oGivEEv/r+R3xnDCgSLQwD3wEuSgapFgc6W2xEPztR8gBoqz71ArOudIuOqvgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rk2aNl7bzMpTYd31cOd/KYyfy/q534R99OObTr08wW02VMUdtC+33fjXrzoL?=
 =?us-ascii?Q?9L+0Uu+C+5hOKVfJeaUBFKj0reRugVGmTiYaNZHXgxfSbunR+4vwdy1WrxMn?=
 =?us-ascii?Q?fdaKqEwg8Vuy+uCz5emmlq2Ougg2jJzTKz/hZ8EyINMqJ1yEDEbCuxjPj4/E?=
 =?us-ascii?Q?7hh5cHR89eDKNV/ecIk2fp5V59x/VFPw3wt1K8ScFaWuSd362W5NWTx2meGj?=
 =?us-ascii?Q?U0OqhaTvTneYTKiomF7ANILR4JfP6pGNqLJev/n8jLxAeZ+Tf3ViIDoxxDXB?=
 =?us-ascii?Q?Dzc+Skw//FhK07APkxEpKHVbFj9zCMdPQ8HxwHkR6y2FeM6Wm08vVS/LwG4V?=
 =?us-ascii?Q?nldMFGKcwNBoSdmtAxec+IM1TGOe2O8aKXR4a4lixNU9knVRCV4dNtcEVK+A?=
 =?us-ascii?Q?pnd8H4RIJxSuFFz0ow+9DgID9+KZxMQ9RpoiPRzc7qUv8Mj2jfuYv5j5yR8S?=
 =?us-ascii?Q?Nmcfqb9Cie6Sp+96CUvWn7nrUGIMAh2+O7bb0FWm1jDOFWcSr7sO7itjC+pn?=
 =?us-ascii?Q?6EetS51Stub3z68RLge8oSDPm1uz7azHYCCCa/3susKXJ6ufYYAa5/VeHwsx?=
 =?us-ascii?Q?1by60Dk+cxHzF4wW/6QQ96OQW7sAHT51CYbrVsUGKKsU8r6z1BW/jB/tksFR?=
 =?us-ascii?Q?tpIsFCgQA+asjq2cYdmQrj5Imbsmty6epY+66VOYZfYJrc1WByMm8B7E1hz3?=
 =?us-ascii?Q?aIUVYF7r9BWG0IjZ8DxR+w4p19UKLmlJyc9l6hRrAPyxnsjvZ/eRXSuiwbAg?=
 =?us-ascii?Q?QyRkhjQULi8X9esz7dLwdnMMwy2t+fubnCHtaTtsDySFleYOfc8cAqfMGIkJ?=
 =?us-ascii?Q?S1BRE/Ply65PSk5YlIPc5z0K7+N6DVcq+fXOGj2TtObqDvMiQIc62sEZ8LNH?=
 =?us-ascii?Q?3cv7d3dP6Nq6Ish9PXISf4CVeZymm39URzBTCech2cGvhwUp18LFHGaceH4A?=
 =?us-ascii?Q?6DcwIdK5tEjBj0MRdyNWbXzH35CF1cZT/m3OKC01uEdMjLswdwmMK/7oigW8?=
 =?us-ascii?Q?9nz9onDFrjJP7/UcAPolR4Ayg/pfHoglyD4vtInb04ip9CJXs2tUowr6Xyvb?=
 =?us-ascii?Q?9tc8wu3Y+V+t+6kZhiLZIW3wLpFsjuZ/Aj31xXWijlgwZPv2cYiKPV3lMuAS?=
 =?us-ascii?Q?FcHq/HRSLI50EQDFRd0UwxtQfo91rMR23FZzEqc8hmYO9VjGej5k0H6L5lwQ?=
 =?us-ascii?Q?NQXn1FCUpfQqp9ZGiHrKU22mXnXiOh3OLWrfd/CNtSKwrJRKB7KWgYRF1af3?=
 =?us-ascii?Q?K1J3DnZET2beLaifysSg3+Dfx3DIlthqMyMEvhFKlRmwizQy2otFlhQ+cnir?=
 =?us-ascii?Q?j/+e7+s6pwKnhqCu2P6Lv1UXDdW0SfEec6JeedM835rbEgznmmDI1AcwOlmF?=
 =?us-ascii?Q?5s9RMU1wK5HzRc7oSrKe8D32HgN611QxUHgCpI1398FCIBuoHCUs51ba7xTX?=
 =?us-ascii?Q?7oiVAM49lpL73+1Fz/vbznDbztANcw7ULd4puQymDI6tFKA7Y7dXQnRCcmIj?=
 =?us-ascii?Q?eNgg3qh6gZQoQgO5jr9ju6XPvtCwZUyRbI693BT2W6LFddq4drzXRQvfSO5p?=
 =?us-ascii?Q?SyAVwF8XI2rG5to+KxO+Q39vNw74WSNT1tKiFpju6HkMwouv6zw+X/o2a9SN?=
 =?us-ascii?Q?NS12kEdxEUousN0S9Lt1B0C0wne8m2YS5mq+f8vHmBmSN6M++7E+xt3Cn/yS?=
 =?us-ascii?Q?EKQB5R6iTA7REOkfwBDZ31Lk3SrAVAPq0HoX7HdL7IX2I7/pATlZg3vklSEL?=
 =?us-ascii?Q?MJ6fdS3asJIzSCoDcI/ftkJfBsPDjK82J5vtkOWgAkdl/NHP3Mkj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c945f3-de41-4a5f-0422-08df2890afc8
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:43:21.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5gZC/1In5jn/bS2coyS5CjgQEMGFPdj425ZuT4T8pR4L+/LzXrzT9FIEz5wTLOZsGIv8FpWSy1RwoXH9Lna9aLOjgnMH5rH+b28X+t45NeMAPLhj+EKqK+Rx+hjduo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

On Sat, Sep 19, 2026 at 08:54:31AM +0200, Jan Petrous via B4 Relay wrote:
> [You don't often get email from devnull+jan.petrous.oss.nxp.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>
> The example references the SerDes PHY as
>
>   phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
>
> i.e. the SerDes node itself with three PHY cells. That does not match
> the SerDes binding: the per-lane child node is the generic PHY
> provider and carries '#phy-cells = <0>', while the SerDes node itself
> has no '#phy-cells' at all.
>
> Point the example at the PCIe lane child instead, which is also what
> the S32G3 board device trees use. The dt-bindings/phy/phy.h include is
> dropped along with the now-unused PHY_TYPE_PCIE constant.
>
> The schema itself is unchanged; 'phys: maxItems: 1' already describes
> the corrected form.
>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> index 66a050028278..29323e50bd8b 100644
> --- a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> @@ -82,7 +82,6 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    #include <dt-bindings/phy/phy.h>
>
>      bus {
>          #address-cells = <2>;
> @@ -124,7 +123,7 @@ examples:
>                  ranges;
>
>                  device_type = "pci";
> -                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +                phys = <&serdes0_pcie0>;

I don't think it fix somethings. The "serdes0" just a label, point to
provider, which is not neccsary that "#phy-cells" is 0.

Examples just show need how many phys and don't care about phy provider's
arguments

Frank

>              };
>          };
>      };
>
> --
> 2.55.0
>
>
>
