Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841E36D4F1;
	Mon, 14 Sep 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400700; cv=fail; b=g1YZa0l2esioEoqp/oxgU/GyF1SzQEQuzCcuLQarsg/JbN05iT8RmTvtkU2jhmqIu1h6sJyK5Yz1YrlhoPPofBnXXEi982+JvoUofAsjn60W6vyhu8LoVR0pCELtArrQu58P6g0voktJAstZmvpWeXVBd+vEEN5/LFURfc/x91s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400700; c=relaxed/simple;
	bh=uzlpymp1rk/hmSj3hQv94a5fOLFq7Y6qfheoPb8/OE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTW1sNeizEyRYEf3AiJUut0S+YQQ23dGI7iI1J7KeY3v6jPVYNinpENvwFcjSLK7zmPJyvuebT4r1It1+yyxO9uwyoylbhn9m1TO2eHxPEcPRN/4AsfUO13fMTSOf/fskVnkLrH54/c1ZSYH+NoITi1OkHGS16PbgBUf3s0Go0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gFXqpHT4; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gFXqpHT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpXxHCori2o2+7PQ1H3ofl5pdA25Txidz/nMJKis39fSYOFBAIEJXbEP6KYZ/wzFg67QGqrXp0gKxam99WfzZtTlvppCzF16WTXNjhl2rRAYCJBNaTwR+ESrd7aPxkUqCNHjbknnl41aMUCGuRYxE4ZqzK3FByC+xDgdK+1HdNnRW70ipJz1GKFsd2cLV3ATBnQPmO73SwUmoUR+TjzZVAzKjZ3N/DNNlN9m2NR/xYOw0bqG2GZnnYc7cXUH9TOvOnXTU5ZvxR67fGaiQ+2tZNwqw+k83L3pF2Jkw5O6t0FvDMzEN5SYtgci5GvTUCwoLX+iJC0T2w3m0elEqg/8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNA7++2csiCKfuLpaxQ4i2RWjtRFn41EPFxfywTZiec=;
 b=lQqu+LBCkzWyFEmI4wjW429/8JNHndQmk996tU+/JG70sG3DFLVj/Ng2HtSXynNc4FalndZnC470kCUbMxSeBCOl6RvNxvm1cznXrMDgI/VYriwg6GoNPbuJgy7RkOiRAJd2Y7f4fSrEHbig2O0vsgiCiXpK3crjsH1SIL/Dz4JGpyOYgwtutRyZGX4mgt0x1t7MTDY38EHFk/GwiPdEcD6L6Ii6IdP/O8V40iqcEmVkWIFElQWJWmhKgOXUjbwi25XjbE/H53uJ3AaeTCtjgERsfd4X6U9iCHjupM057RjMWfe1NUL3RAx4ffAVqA8oFvfxb8DI+IYpo3oubCyn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNA7++2csiCKfuLpaxQ4i2RWjtRFn41EPFxfywTZiec=;
 b=gFXqpHT4RfO5YCpnlfdDEsWLMyHbCjy2oVt4LheBnDz7n59B5s/7BPi/tIAmH9KX/xpci6bCL5e+YM6CEWr7wIM3ve2Vi7tvB1n2r7RsMbFVLuFR6K1OiFIr2Wo8tLswv2SnjnehzStwyt7r3DVoWoKBc37lAkUiYh34Uft6e/P/IF1s2lU+yl5WRtGQUtGHRreD+AY+UoxRf1XzfmcZYNddEdp8chjUHuNut7jQEjkI4g2PYk7W8x0Tllu4T6bcQULn8L4z/SKAHFxi24q0ZpYm1LCn1mEyiYfRB6FOxXz0NLOVAF+xMCBrw+h7kHmcUtqWQ5rXhWPNJSbGBk0ASw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:44:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:44:53 +0000
Date: Mon, 14 Sep 2026 10:44:42 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB
 and PCI bus lifetime
Message-ID: <aqgWaib3sTchhmaS@SMW015318>
References: <20260901063238.631166-1-den@valinux.co.jp>
 <20260901063238.631166-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901063238.631166-3-den@valinux.co.jp>
X-ClientProxiedBy: PH2PEPF00003848.namprd17.prod.outlook.com
 (2603:10b6:518:1::65) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB11276:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b79d427-08ea-4b14-0f93-08df12771e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|23010399003|6133799003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qngCOrkMNuqoFf9GLCAUSwNs2XC3YYyXMwc3vwYtMk9lgyFZmZoZ7G0yj+X0dkM4TvP1ct4OZ11czll9YID8jmxVJc9vUyusrUIfFzSVStvdeKL/ka522oQjq0t9TlQiLeGxKFI+F2vUkq6GO+nl7/JbIwjOh3Y0i9/uu5S84DMQAdFC/LKMtmpVpZVUUr8qnQ9+S72kaLYQkmkBTVOYVGqRtuWTo9etyf1ZZWF23Y9wXJW+/g1K7jQdFF3RmCfiFiSBwP2ITFn9y5OVVbUQYC9u4GFTufwu3e24zhSEPwNjYu+JewToxd3BY+Xg7+tclc7EnbzN9Q4WTfo41egiQUinwNmIiuGGzxmBht74tEDwmb6lijApuFZQazwryMjrfoRhi+Ac0rgHHN68AUF29RM+QGBfBKVS1y8hc5AJkc7BbZ79RMMFA+gC4IH+7bdXgGvTGntUWJzidlT/CuMqf0dfrCLVPbk+SInVsu8RrjFjdVkK7Qeb5jdKaqL7Ia08ziWwrO6DbdDd68V1Wqc8Y4he2Kc/RvoCo/x2mX1M39tEHV0iEfkn/tJXzWtygTJxrLs4HZ84aESagJIjYlyo3XPeWvMhNqu0XpZQ0QackRCLMSheLMBTNToazJhuI3OQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JY354EM6udm4uZI7nzS1p1I8KA4wk9aq7LliUnG5cpx1c0asQNbSqKWRkFaI?=
 =?us-ascii?Q?zqu2bWbjnvii03oITHqjHZgEezbVakDdsVAD3KEy2uyWCPydvqujtSoWvQsM?=
 =?us-ascii?Q?yp8QAgi2gzkul1FAV/u6HUfml3Kl3anRvO4i0ZZcaprdsAOmMaWEt6u9cH0w?=
 =?us-ascii?Q?EtyOhsDmm0eXKzifjXkffMArI1s1J6N2Is9vsoB/vrMtOfeXA3SSzjrdp/3v?=
 =?us-ascii?Q?76ZPM4JNp5mx5uO0aO3EtDaHCVElNRwVK9aER/6zcHMTOjIEQBdl6/Sadhz0?=
 =?us-ascii?Q?1dombl4tDa1417JKi1EIj1YGEKAPEmyjKYDVbgfNs7uC6hjOvpFbwYTyJBKh?=
 =?us-ascii?Q?ILdqT7TwsHXTtpZDDoHc37OF0I2dOj4wHey12jACbJEUhoQ/2RcEETEHKoh4?=
 =?us-ascii?Q?7rwGFuWfl7h/xRLxpmJw93W//lSU3fFShzX9dgs5zIXIShN2B1HOaKeOk6CB?=
 =?us-ascii?Q?B2yroLAh6nfwiz7sN8WQCNoUk2Du0Wt7UGE6HvQFG1YR5SQXrIbddTvFL43O?=
 =?us-ascii?Q?4whgowQuz3gBBdi1kJfx8NZbzxWYKJZXxjSuekg49B/9Oc0JzCLZBOhcO88W?=
 =?us-ascii?Q?us8Y8v2CfSj2yxw1u53Gd9QSx4YUGuXPX9TPSrmlhmBXsDwAVKw4v8H55XiU?=
 =?us-ascii?Q?YRZmoSkBte7A2JmJ8IoIrGEvtfsN6wbM66GF4CwOd9Bffk6Y90MRw7qmjx76?=
 =?us-ascii?Q?HOVXiHXZJLreBdCF4lXGdXqGNiJ5jAQXOMyWnx62LPME6IYZ+9u+u/XJkfJt?=
 =?us-ascii?Q?hXZLDKUVQ1s4mw0/4TQyxI/VKaQfVO6hL87sf9YSVgUF8p/2NhmLEVpUzDbT?=
 =?us-ascii?Q?MD+ynyM07KSZN5SCijOO1OFw7pbqOO+Hp5re+aSCggLmsBtYmT+DU4xTdepv?=
 =?us-ascii?Q?zR+Uz5CofZpA4sVvpZaOtMCzZe+NyXTq1mXe7wV9Z5+HQba89evVUO0mEiXC?=
 =?us-ascii?Q?a5giiDlCUGEljgH6E+5WlqlZ+FRyRnYmHjBB6mRnLZYNkZqPDmMoFkdllHAe?=
 =?us-ascii?Q?yqlnh6cmOOuLzM3qO6EC4GEBo3xwG8nH2sxeY0GOJZ0w4nqjz0FMcC02/J0M?=
 =?us-ascii?Q?nrQ6kAYRrlYZwf1XYiV/t8a+i2eGO1QE1URtwo0yhEINwU83TP+MDxH51/Cm?=
 =?us-ascii?Q?OxCAa5Dv/ONPmYpaPTTFwz0JpW4AB8BdWBES/bSflTXy+RJ157RkiswJ5FZO?=
 =?us-ascii?Q?NNX36751tyduNeP7wXLAXMoKlPhSKrjh/NPvCxN19yXPw+kHWmYyVVePEnxL?=
 =?us-ascii?Q?LeawDVy8e1Gjh3lmYAsHaiHltRFtWTkUxZThUYt+YMwk033KJCOZU4wITvMs?=
 =?us-ascii?Q?YaXLWU1PFrM2O+OG0tvb4aVFZhk0kJKenRUOilKJcXy7SsRB0yQobjm5oULk?=
 =?us-ascii?Q?X8f+uQwHxt62XekD6QuWxcpIZDaZc+zyozkFyNYFs2asyz2OT5Lu1iutydF+?=
 =?us-ascii?Q?76sfdTQ1bXWX8fP+YEH4q4qHnR4h1yVXkVqedjMbdzy5vUGb2fYAX9xQOGpk?=
 =?us-ascii?Q?Gg3lC0CGvRRenQ9snHDJuTlE/z1bzkzAaI2klc31GBxpNdb0c2xzYVJGd27h?=
 =?us-ascii?Q?E/ovpyVjgwLPhiIsYd1XDzLLCC65wxX1sSdWmpjlh2UZFJCDes6/kV4zJjWD?=
 =?us-ascii?Q?c+RB+oDF21E3K8WH1Xp4+4iNGJYgmicuR1dsfrkMN0iXDkzMAss4jVVK4u8e?=
 =?us-ascii?Q?didn8naRqEdIAMgNJUy3j5QGIvh8OrhZk/IInFRJBUvn1zHtHmkG9WRuQoMI?=
 =?us-ascii?Q?XXG0A09VA8Noln1gvCMB1eZ9F99YB9YDkCYa/GJbQkKhHNDQhfqy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b79d427-08ea-4b14-0f93-08df12771e2a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:44:52.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEspMHMz4ZVA1b/2zIKhFIXdgum4ZGbQD9Jdm/IvUvn8j2cxuxq0ZtqjrG6DzDCyOguzktJznX9Uts81295SUpJotpgCXJZwbAB91J455Yg8GEskc4EXNW8OZ2tdQ5Va
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11276

On Tue, Sep 01, 2026 at 03:32:38PM +0900, Koichiro Den wrote:
> The virtual PCI driver registers an ntb_dev but has no remove callback.
> Unbinding the endpoint function can therefore free BARs while the NTB
> device and its client still use them. It also leaves the virtual PCI
> devices and root bus allocated.
>
> Allocate an ntb_dev for each virtual PCI probe and unregister it from the
> matching remove callback. Start command processing only after registration.
> Publish the device for doorbell IRQs at the same point. During remove, stop
> the command work and drain IRQ handlers before unregistering the device.
>
> Retain the root bus returned by pci_scan_bus() so it can be removed on
> unbind. Unregister the virtual PCI driver before releasing endpoint
> resources. Stop and remove the root bus under the PCI rescan/remove lock,
> then release its host bridge.
>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Cc: stable@vger.kernel.org # 6.0+
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - Rework v5 patch 5 on v7.3-rc1.
>   - Publish ntb_dev only after registration, and tie command work and
>     doorbell delivery to its lifetime.
>   - Retain and remove the virtual root bus, then release its host bridge.
>   - Drop v5 patch 4; f7245901de89 ("PCI: Check parent for NULL in
>     of_pci_bus_release_domain_nr()") fixed the bug it worked around.
>     v5: https://lore.kernel.org/r/20260226084142.2226875-6-den@valinux.co.jp/
>
> @Frank, the code changed substantially since v5, so I did not carry your
> R-b tag. I would appreciate another look.
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
>  1 file changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 412e8cc6fb1d..992f5e7f8d4a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
>  } __packed;
>
>  struct epf_ntb {
> -	struct ntb_dev ntb;
> +	struct ntb_dev *ntb;
>  	struct pci_epf *epf;
>  	struct config_group group;
>
> @@ -166,10 +166,15 @@ struct epf_ntb {
>  	void __iomem *vpci_mw_addr[MAX_MW];
>
>  	struct delayed_work cmd_handler;
> +	struct pci_bus *vpci_bus;
>  };
>
>  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> +
> +static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> +{
> +	return ntb->pdev->sysdata;
> +}
>
>  static struct pci_epf_header epf_ntb_header = {
>  	.vendorid	= PCI_ANY_ID,
> @@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  	else
>  		ntb->reg->link_status &= ~LINK_STATUS_UP;
>
> -	ntb_link_event(&ntb->ntb);
> +	ntb_link_event(ntb->ntb);
>  	return 0;
>  }
>
> @@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  	     i++) {
>  		if (ntb->epf_db[i]) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
>  			ntb->epf_db[i] = 0;
>  		}
>  	}
> @@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
>  {
>  	struct epf_ntb *ntb = data;
> +	struct ntb_dev *ndev;
>  	int i;
>
> +	/* Pair with smp_store_release() in pci_vntb_probe(). */
> +	ndev = smp_load_acquire(&ntb->ntb);
> +	if (!ndev)
> +		return IRQ_HANDLED;
> +
>  	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
>  		if (irq == ntb->epf->db_msg[i].virq) {
>  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> +			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
>  		}
>
>  	return IRQ_HANDLED;
> @@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  	}
>
>  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> -	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
>
>  	atomic64_set(&ntb->peer_db_pending, 0);
>  	enable_work(&ntb->peer_db_work);
> @@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pci_unlock_rescan_remove();
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>
>  	pci_bus_add_devices(vpci_bus);
>
> @@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>
> -	dev = &ntb->ntb.dev;
> +	dev = &ndev->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1563,7 +1574,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
>  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
>  						PCI_IRQ_MSI, interrupt_num);
>  			if (ret)
> -				dev_err(&ntb->ntb.dev,
> +				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",
>  					interrupt_num, ret);
>  		}
> @@ -1681,13 +1692,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	int ret;
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
> +	struct ntb_dev *ntb;
> +	int ret;
> +
> +	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
> +	if (!ntb)
> +		return -ENOMEM;
>
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ntb->pdev = pdev;
> +	ntb->topo = NTB_TOPO_NONE;
> +	ntb->ops = &vntb_epf_ops;
>
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1695,16 +1711,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
>  	}
>
> +	/* Publish after ntb_register_device() succeeds. */
> +	smp_store_release(&ndev->ntb, ntb);
> +	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
> +
>  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
>  	return 0;
>  }
>
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = pdev->sysdata;
> +	struct ntb_dev *ntb;
> +	unsigned int i;
> +
> +	/* Stop the work reader, then close and drain the IRQ gate. */
> +	cancel_delayed_work_sync(&ndev->cmd_handler);
> +
> +	ntb = xchg(&ndev->ntb, NULL);
> +
> +	if (ndev->msi_doorbell)
> +		for (i = 0; i < ndev->db_count; i++) {
> +			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
> +				continue;
> +			synchronize_irq(ndev->epf->db_msg[i].virq);
> +		}
> +
> +	ntb_unregister_device(ntb);
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1716,6 +1757,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1796,12 +1838,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
>   */
>  static void epf_ntb_unbind(struct pci_epf *epf)
>  {
> +	struct pci_host_bridge *bridge;
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	if (ntb->vpci_bus) {
> +		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);
> +
> +		pci_lock_rescan_remove();
> +		pci_stop_root_bus(ntb->vpci_bus);
> +		pci_remove_root_bus(ntb->vpci_bus);
> +		ntb->vpci_bus = NULL;
> +		pci_unlock_rescan_remove();
> +
> +		pci_free_host_bridge(bridge);
> +	}
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>
>  // EPF driver probe
> --
> 2.51.0
>
