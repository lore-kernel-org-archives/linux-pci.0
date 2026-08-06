Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFA3ADB8D;
	Thu,  6 Aug 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041788; cv=fail; b=n89Pq68H624iBKnsBeEOf+mDVhbca2gAJdeDcCeUztlpiuD8j2CpQxdiZsWMX706WDRxpYQFmeb7X0p4UvK/SSxvJADVlONJwalxWGQzKkAFEvBAM/POJrt8SNxj5u1KawG3jveXXZCcWpCN/MpJV3DFIRxSqwPTh76TmPAyJeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041788; c=relaxed/simple;
	bh=DAnoStR8OvJ+2OZkeAZGJ52xY2K2ipMw0nkZPmYQKBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7iwFMDx6yCtwKmzUAPtHinbHk7yWx4tsJAot6pKtNeM2l40GhSpjUnwN1IzvdIyo9zAQ6mQIVmR3L57/gprdvonp5B/mfo8M65CMQ4sB+g1JdK5ptZWmJ1JLSX73j31OcVciJ6uOFSrsJAeswn5bQLdcI4+1404hP6ikGuedwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ppvyO4CP; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ppvyO4CP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbKVrwf3WQdWZO420DlEdz9A2uDCfIVnIWMN0uI7xcECyM/ASUSj0p/bRImx9A5VdGjArAAh7PaUO0kuX5kBamh0TD5Z38h0P24Qm1PGb6oSusynSz9xOJ20fYD3CyAWl3U1VGer3k+t8JKdtRR8th5cEfaR0+MuhlY7Q9XT24Osy61uFmk/IrIZq6/46rAGSJLdQ33Jja/WXgUuEt5ckmT364meAmozOtyi56Z+ik2a+0VWT3EXj9nxrqYs3siuWL9dBA0AufLlo2jsnzJCNNQRuyBYib2TfV9hNqR8K8IIj2bXQHqDoQf8ix3U3bPaev5oeH+gz+aNJGiJld7vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqHS23B/j3M3Zr2pri4JUWveFK+1aT75T8q5+LEvGFE=;
 b=NEZyIMRbjlFJY7AtY70s/XOkAZUQl7/U3OXP9Xp1WMTBH9s54vBehBwxncOOmD2LAiQr3MI8Ftb43kOcDyVkpHBrAg2oiKgnbrm6LUo/e5RsQyDugDb1ug6WoMKrqvxFFLJYjszqGlOW9HN5qnGIOVfbjrYSncSMWyfazKFBa78nr5rWgC7sJsLrbfi+966PVEqsDUH37oeYAw2OvOmN+Hr0VTLqx7ac8nLzhX7XVOaIZl11b4qDOlpoZ1csDhVXNI+TiCiShdD1daGvUo58WSN+4wW1ogwqDuGV0hx25HK6OJt7/1dOERZ6eU9caWAkcfOeJf2kpZLjnxjXFoZ8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqHS23B/j3M3Zr2pri4JUWveFK+1aT75T8q5+LEvGFE=;
 b=ppvyO4CPoKi2Jh3FXZw0aGYGJoW9IrT2UjXkP2SxW5MJ8tb7LqOIlE2nTkfr5tfnSDq0alHujghGuAFdgvb5nfj2T+TsubfXAsWneAwolBYBkW3eZat+1kZ/gkRV4telMvfBoRUgurr4xBcMfIFkaOeSFo0OIAvZpRW9mWxOFmoAqMAQBrd0DypdvzElyq8ADc+Wa+DFMMO8vkIwLtiAEM9Sbq6sp8JKM1NRMGZSMfY0ebwweYdoB7iwuElNiFXhgOg36WxyI5PA1OQa+Xf8koSfcQ1mpIvI05ODW5stsBCfhknoQtRblcnu/IXU+VQ3MarybaedeoV0OhS6MQ/I7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:43:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:43:02 +0000
Date: Thu, 6 Aug 2026 14:42:55 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 12/14] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
Message-ID: <anTVr7sk3Cd4jJE5@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-13-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-13-adrian.hunter@intel.com>
X-ClientProxiedBy: SA1PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: 762a45cd-ed90-4331-d162-08def3ea8b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Q6dVfy7OYlBkEHPkn7PuNvUBMLGegxMVMktGxI4/dTWl1j0IGdFp7kkAIjZ5NWo4qPqaVjRznHTm6Fs8cCMmpVTWX+tH98RciEdAmCoYm65KBKNmnfC/U66EmqoDjDY11gl8wp8tHldCngmyQi+36mZXtMTnqr5CND8BYXhcKWNZ2ch3wV6ElwAXkCm/RQsVb7bpHicYvBo4tOrxYGJ6Cwe6kW21xPye8iM5bltEWjXAfMQpQdOkVbaZJnbvl5F/yWXwQX4SF+G9id3VZGnWXiNe4f9ty4Fl58i3Un8+UOwOJ6FfVTa3Igkul6QvARdiHPw9EU38e91BFuUUYSUYLWb9dRYETAayt2N4jts/ij7XX+Qf7CasXD12/8YNeG2BeGAbpz8baigvfsURrJsNtKDcZCovJy1B/Cqy7gLybpLyCr6AIKeaUiv7C3PkhC1+z9IbJBqyLGgWCpR4fWjON1Zyo5O39KjyAfN7sHD6ABCIzCpldTQRiQzJitFgjbwKggIRiUN/GOUngMr8rB1IOiLD0q27K6c3RlPTvlfU9R9UVE/W/+3zNA/hElopOdOGngW2LK4j1NUKzYjj02gAeguB3jHUqNfmz4vtV14/HS7MTd01+oV5+XB9+M6qD09LIvFudhFXAYKwatZtmeFy1ViAja168gP7qeW8WzGqmXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtPL88D2Mh2l9H4cACHp2C53fo+LXBqI5P+kAOOAjNzt5ig1G0w++fBcexrS?=
 =?us-ascii?Q?jjZZfsjF5hJuiVWrnuqUhnBol4+91Pv4qDrb7TGyiatozFQEcTS5xIjkz3mp?=
 =?us-ascii?Q?XnyiEPidVujvrhlOZbjuyAnsV2a+BSZ63TdZRrR2xy8ZBcB2ZWJeHGT8HdZ3?=
 =?us-ascii?Q?sk8ULZZlwiZ+UADxGdMKzVaP2bnKFFoomS7ITc1A341eGwto1oD/vU072+1w?=
 =?us-ascii?Q?ULO46XoIzuTW2ZNuMKkCGkDFNR198LiNiwd63zHEjF8Rm0wj3SH+9+d7x5Vd?=
 =?us-ascii?Q?NtNH5Gmo0oEYCYzNikcRii1v7vM5CtjTERIIMAtrOw9967JQ97+YVAH3gH74?=
 =?us-ascii?Q?m4rg3cU+Zso4u4o/oMyjn4zZmO56PDjHYLEd05FOFsnSjh5BNF5evFuZwKUH?=
 =?us-ascii?Q?fTp3FgtYZe8dKtaPeS2I2Hd5FINh3LzAKscvlwl9+Zl3Vf1pWBJ9FsnJyQ6U?=
 =?us-ascii?Q?pY3gGPzDuKH3w75yGkP5omgfHZ+dS2GT5iIlc8njQgZ9sPlX2NV+4ri70IjO?=
 =?us-ascii?Q?ePSUiWO30j2SNB0emek2xyP6qhmvN/cA2PmO75HcIBZ0DC+FQu+SM3bGwcV/?=
 =?us-ascii?Q?CK5uSc/oPlsJCZMNnCZdIiJtVm9Jqn1AmtRwmCAsfqeOPJW6ShEELNQ/ybnZ?=
 =?us-ascii?Q?I43yv5b6ph123EpK2w+UiXLi7sNa0V9dn3p8Q6jsSE2njIrYJAbwsK5qRJaC?=
 =?us-ascii?Q?p3U9kv1AgjwHaDvnjGcSSYjFb+luAAMuOHBW3qOzf0dmeKgFe0N6eokXu1tN?=
 =?us-ascii?Q?BYJ+oQEC1BoImQr7JWBKxCF7sZzxkl21e4hIO0pcp8gbjozecxlxhU9x31bz?=
 =?us-ascii?Q?UtZopsLME7aapbY7hyVdF7Qc64MCzGW2TfLbp+RZSXk9W4pXSYTv2KkApxwL?=
 =?us-ascii?Q?PVOycl1PM4wPECchTwX7CAJIL8TuKzmuoD3cnogmit47S2R+NPtXpF7qY3EB?=
 =?us-ascii?Q?qLiZZeq/e2/0e1CyOPx3b8bReqATOWQM83jZ19m3mwjQiZ6V+ZtfBWkx8L4H?=
 =?us-ascii?Q?APzGABa4a3Q1a+BJmWSpmExuutR/QDn5lFRX812ZgYqBsrU3me6uSNip4+nE?=
 =?us-ascii?Q?4mRuyPy0A3VuczxQEUedqIRchOaV9zgyG4qQeUpjDAqTlaTc+MIOmRvsryDk?=
 =?us-ascii?Q?89K69Ugu1Qv+6U0he2+tarUdzhogWaKjDdQPdpl0sovbfiriYIOz+tJ7rJEP?=
 =?us-ascii?Q?yf5IkleiqhcYvVAGQhO3p4GQbh9uA6ddWoNudGitzNcu0vJjzdyLFFgoXbHp?=
 =?us-ascii?Q?8J5/HjQxzLchVrNYaHXjM83WcS5w5FIuyRo4vHu5NOlA2zR6ASYs6t6Dy/uR?=
 =?us-ascii?Q?B29uNSFFVCfqZv2Fpb5MltOlW3+4it9Ivtmqts712c1W02mEi7Hu3ZmaDboj?=
 =?us-ascii?Q?G4WveGXBxIt16MW773K297E226P6t/OdODKdUWBchcvHVC46cVlLA0NEWklI?=
 =?us-ascii?Q?31AVCrkjtawge1p6h/TpIY/KGJ5PKntPgt8IrHAluT2gn7Lpl5MLktHQrWfI?=
 =?us-ascii?Q?qeiMCrZhq+b+Qt97/OENj5q3EVckxM0K7+mx6y4qXF80Fu0PHzB8i0hM4jkk?=
 =?us-ascii?Q?X7gBX6WiaKS3jkOF6c/xXpw2x+M4Rc6XOR7k6DkUXFM5plggEOQpN7/iyrTX?=
 =?us-ascii?Q?4TAdEp5Wum/3+Bhh7GDHxWMCwSns0i+f0NAEjl8nP1WEXZ9NFhukZMGjWKbS?=
 =?us-ascii?Q?JWBujrZ6KRs11cRwBxfqVKLJ3v8JsNLv5+CDjRdQwL/7sNqof8bM5HIyjNKG?=
 =?us-ascii?Q?5Mrue2aGNnMcUYj+QtU6iisnYUlhKm14RM19BtvQVtKDZUjk0OW1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a45cd-ed90-4331-d162-08def3ea8b5e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:43:02.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSrn5H2uQvXz0oLXvHs23DderiPkuSmcsUM+P5Y31hr7fQVpB5obejwsUEiF8oe6ZMCRloAhmxxdHJGA80KGdjF+4ikp4IqHu2hhPl97MR3TSM9xZugU3p27v4Mww5Sd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

On Thu, Aug 06, 2026 at 04:18:55PM +0300, Adrian Hunter wrote:
> Keep the PCI wakeup state aligned with the wakeup requirements of the
> devices served by the controller(s).
>
> The PCI function is the wakeup source for HCI instances exposed beneath
> it.  However, wakeup is only needed when at least one attached I3C device
> is enabled as a wakeup source.
>
> During suspend, check whether any HCI instance has a wakeup-enabled I3C
> device and enable wakeup for the PCI function only in that case.
> Otherwise leave PCI wakeup disabled.
>
> Note, the suspend callback is used for both system and runtime suspend.
> Although this change may update the PCI wakeup state during runtime
> suspend, it does so only when the required wakeup state changes.
> Moreover, PCI wakeup-capable devices already have PME wakeup armed for
> runtime suspend, so changing the wakeup-enabled state does not affect
> runtime PM wakeup behavior.
>
> Note also, since the PCI wakeup state is derived from the wakeup
> configuration of the attached I3C devices, the PCI device power/wakeup
> sysfs attribute no longer provides independent wakeup control.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>
>
> Changes in V4:
>
> 	Updated for the rename of i3c_master_any_wakeup_enabled() to
> 	i3c_master_has_wakeup_enabled_devs().
>
> Changes in V2 and V3:
>
> 	None
>
>
>  .../master/mipi-i3c-hci/mipi-i3c-hci-pci.c    | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 5a9e2a43eff8..42c172e82622 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> @@ -265,6 +265,8 @@ static bool mipi_i3c_hci_pci_is_operational(struct device *dev, bool update)
>  struct mipi_i3c_hci_pci_pm_data {
>  	struct device *dev[INST_MAX];
>  	int dev_cnt;
> +	bool can_wakeup;
> +	bool may_wakeup;
>  };
>
>  static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
> @@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *dev)
>  	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
>  }
>
> +static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
> +{
> +	struct i3c_hci *hci = dev_get_drvdata(dev);
> +
> +	return i3c_master_has_wakeup_enabled_devs(&hci->master);
> +}
> +
>  static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
>  {
>  	struct mipi_i3c_hci_pci_pm_data *pm_data = data;
> @@ -287,6 +296,9 @@ static int mipi_i3c_hci_pci_suspend_instance(struct device *dev, void *data)
>
>  	pm_data->dev[pm_data->dev_cnt++] = dev;
>
> +	if (pm_data->can_wakeup && mipi_i3c_hci_pci_any_wakeup_enabled(dev))
> +		pm_data->may_wakeup = true;
> +
>  	return 0;
>  }
>
> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *dev)
>  	if (!hci->info->control_instance_pm)
>  		return 0;
>
> +	pm_data.can_wakeup = device_can_wakeup(dev);
> +
>  	ret = device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_suspend_instance);
> -	if (ret)
> +	if (ret) {
>  		for (int i = 0; i < pm_data.dev_cnt; i++)
>  			i3c_hci_rpm_resume(pm_data.dev[i]);
> +		return ret;
> +	}
>
> -	return ret;
> +	if (device_may_wakeup(dev) != pm_data.may_wakeup)
> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);
> +
> +	return 0;
>  }
>
>  static int mipi_i3c_hci_pci_resume(struct device *dev)
> --
> 2.53.0
>
