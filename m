Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CB242D76;
	Mon, 16 Feb 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258736; cv=fail; b=nCl/snCNrrFGRuB6bavBQxQePfmXX/8Jae5q75gTHrqHwcqrEnSN02AitptUJ+wbdg/ylUnpvnvM8XudbiHpxIJXG7CbdKaFPNmeZL+azuyfvcv9OcnT/LTPo4KeVY+oAIU84n289y7gXC3SPwYtjGyU+Eh2IsriGwdBdTqBXFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258736; c=relaxed/simple;
	bh=i6NZBkOVXT+pjRtwbCCwGjoSrm+hWeXuzZGyuqA/Wyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbUeZVIOQBLHhKcFounQBP4SfRp9EHeeHrHBiGe85XlT7fUD5YDDWnm+MtiAwsLSWBl0nKEiKUfnnrP+u46F6+JfRsx9YFW9a/Vxv27uLG/7KaH8rVo/YdaJbYmgDW9qFkftzLoh6A3HzO1DTMvODwOuc7QbH7YN4CAQB0189MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jgz5AwS3; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jgz5AwS3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAhihLBgI7pV6g/p6N7Q3hHnpv/8ZBc7dNpnCWF3fb5t0Ir8JrtYBIH8FNFffaWDRp3VuhrCbyz+dconVDJupvmmcBn4k6oeqFqOLc9UmmbLByZl4mMFHXY8F82Jeread6mwCqJg/hXHQykMQp0y5WUr3xPcZqSvBcEbvBfEcqtNCazdE3ed58XWcaoWQKLq1hNsBQWh8uyBx+nCPpRMuEPz9FJtwZODgf/USKscuQy0fXpeKKxvUJ7xtt2XwU8cXBMpxplMiAUhqP3IAe7CfYfyN6g1lYcMEc5teV0T9eJesUvX+jU38+nzhQOaTxysY8VbYF2vKfvkhTjQ8YPu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rneGX/PSSUMPn7240h3nCwFepU3s4NXdBaGM18NIOiI=;
 b=p0ZPuj1Dtqc3CbHfx9o7ruDbBg8WXQdlNfDynBQBJna4vJhFBU3zLDNU49JpkYbijK3owewV0/Yym4wjT5/UmJ8zs/gm8p3pCfvWds6GoWHl4XbCYKXyNIwrktlvkkV0k+McewFszX5BmdEZ5VyWwEmA5NKyTqkG0N+w6msF3FLJezLeynNmIuQZGDfaxWUlbMFLm3FEHKbL0HdI++qcqqcesVplL3Ot0v9jWZ4mbtHAWOtw+BV6paAJr8lfPW2cHyL6rmWrrqDFGuv+5HyarqkazK6umkZQkq3XHdaXo6SjIz7zmsYNVRo7f7hLhGlIw3KEQZ9uDxtFAkUf62SZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rneGX/PSSUMPn7240h3nCwFepU3s4NXdBaGM18NIOiI=;
 b=Jgz5AwS3ltO5abVkIvlwTnSvI74oNXkmKPPzi2lJnBNXik60FdR+XpL353h1r07v4132oMCuQ0EEh7q6+kCNj2G5zp6wrYFBSJsJVe8Vkx3PBuEJSUzXAcdmydtOgvwObCPDk0y/Tj5Q/k1JvvcPUUJMWhQBRzQNDOGg8YIT4yT0zWFLtEcmT1PHNO5h11IWbaLxYHcdXzn9VMe80L1jilzxGtOGEGepabJ34kPVvEWuEFCb0j0bJRXjBigVFq5lXZRxNc4xNQE6IDIC5T0Nfj38wW6DBEYw90h4FxUqOG0UR3GcvEVKWOtAqg/pswHYKI0H7Ui1cQXUubEE1g5iBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Mon, 16 Feb
 2026 16:18:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:18:51 +0000
Date: Mon, 16 Feb 2026 11:18:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, cassel@kernel.org,
	shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v7 8/9] PCI: endpoint: pci-epf-test: Reuse pre-exposed
 doorbell targets
Message-ID: <aZNDYmR3e2z-VnZA@lizhi-Precision-Tower-5810>
References: <20260215163847.3522572-1-den@valinux.co.jp>
 <20260215163847.3522572-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215163847.3522572-9-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0167.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: ee585d58-e606-4ab5-fc12-08de6d7712c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tIczgJlWpoTP6eJmcs4QvqF8m/gw/+Jn7GAaw0jPQAIMv50+0u3bcyFKhLEQ?=
 =?us-ascii?Q?ENsTZnWm5u63I6HRcHbk4z6uk8EsWCSJbf5mR1lqunPMUxqCtdV9Fi3KLJga?=
 =?us-ascii?Q?hTDnbppzTxsNtmD55BpUhmhf6K34k46hvDRdWYO8wwUmGbAq0DY3xWVg33mj?=
 =?us-ascii?Q?TwQM+YdKlGjXFumVZ5NvoUuDU6tzmGHr0TN5SiPkhOkjHzkeHaGml+/Gg7Hw?=
 =?us-ascii?Q?+PsmA40bt3cKNQkBZKWto6zLpBHghUj7WOCQ+6XBqgo1KTqPB7NapriDRYtE?=
 =?us-ascii?Q?MxJ99IuXUK4OSdI8pe2WhqVRzfVYeXQrHsYZzAa20ozXdXKERFd/cVP0m/bp?=
 =?us-ascii?Q?EGXdjUvBLfQXrx+QW8gc2iOjCfCzx9tRZ1PFH5KEgYhlv34b0eE51n6bTtPh?=
 =?us-ascii?Q?97Zj5CjY+ANeO6vD/CMbqvhAcD2E28arfdCa7n85c3HvyrcziCXRZaYom1n3?=
 =?us-ascii?Q?AEi4jw1LNrBWlzTD3srTFCVwr7SfGy5omGhjpodHdDB2y5Ii+dVHHTEr3vbA?=
 =?us-ascii?Q?taQO8lDJOCUaULDyaHYcGlnnnLfJ5jFSOWuJ/hFpnSs3AZHc7OLN8/KHOFZB?=
 =?us-ascii?Q?xJPNidFKkGcF9WjMgxpibgTkZCNXf5YKu8OIHs7nVoBUcjzAthOWMeUEgmZh?=
 =?us-ascii?Q?Am/1Bmd17WqizYVbM+mSWiO5iUmuv/Y7d5ZGLjg4HDzktW93mD7JYEOouci+?=
 =?us-ascii?Q?RToXt1w4Pi2ToLpd5srzJQR/rkYUOMYjm3c2a1bMws4HJzcL610DA3rJ9VMU?=
 =?us-ascii?Q?rHQXzR/GggEOjqFFE6S7jhbj2N0GZiud8KTH/PpxpJOjT/jqatFBrEp8pf4Y?=
 =?us-ascii?Q?dS1+njr6B86Y7WOnmyJU3p9Y6NokfQN0t0Nn3e+hMoyymoFsap9D8tke4uH8?=
 =?us-ascii?Q?1cP3wyrWfYQBdJUYc2RxmO5mHPP0Z5kpmLhumogNNN+21VZEkb1dgQTe16VC?=
 =?us-ascii?Q?fPrwZaswTtbPpu5+oFR0Zq7s75lY2N2JqGqL4oyQV2tZGsDfihYd/G/oH+d7?=
 =?us-ascii?Q?O4LpAN0jRNKYVhmeVUw9kGKFQUT3YyMbqATM4nzsVLj4gdejOj/Oa0pnd5do?=
 =?us-ascii?Q?Ou6DUbxBpa7fLfw2MiWzQSRjoY1yBKil0bj/2m8SiFW/k8B6QlBmtop8fJDw?=
 =?us-ascii?Q?upbnwQW1jVZJaEMRmU8yCCy8fZ1ZsRkDJYk1lafA1SSDyWSY2jEalwNQEU4s?=
 =?us-ascii?Q?DQHSNyNH8rXwdC/dd7U6ZpKyPNYW+95uuE9WwFSUdfWfqsSVLLnU4eP+vTgT?=
 =?us-ascii?Q?QRgaBMUTEhzx0aeA9/QstgMpuSY+NvBaAk9qT5+iFQKukWEQL2vkbP15MKUW?=
 =?us-ascii?Q?uqRf/j2FCkLEnQVsAI1OE4EZEVkhv+818MbzepSCNjJDa5pqSMy7iFWJ37ji?=
 =?us-ascii?Q?NEPb1cLbrAimcsmyZJeYxluuDlvRq0RvlXopmilDKqkAu1QNNvui7euwQq4s?=
 =?us-ascii?Q?5hsAeeZDDmWGv9tKxDg5iyrCT+gRyr0Rk4mcsm8qq8nyb+Fxuj3pUaEuF9Jz?=
 =?us-ascii?Q?d8HgyFH7NjaosepCxvylbWJ8ps/kwYX8/LBIE8h2PiCS3I/P5NJOGIJn0i0t?=
 =?us-ascii?Q?U2Cb+3A3f8skSsaGbdNTNi4ejtMM797nKcBSmLpByX+CexGHoGJDE7UDfORc?=
 =?us-ascii?Q?nGjoHGEDDABo0RHhcMEB8/M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzvXA2GtVCXdDAhXumBfIP6gClCt8F9vEJbFjnZa/owXtMXZTHsnVoJMeAuZ?=
 =?us-ascii?Q?K85M6icvt1C3tKLdpFH/M4VZvww3DuJdf1MK17cQ+i8j4deOXS74wEvMnV/O?=
 =?us-ascii?Q?PS730yg9qhLhR/N5WJbowHtxLbD5P+b3nxz5/m7yt2LJEdj4yhFGOdHMxPuq?=
 =?us-ascii?Q?SSgwJ6vXM2GWC7rlmFgZaWjpqwxk58LOAJWOk2Ho8QXrfR9feDXEXLf0mTvv?=
 =?us-ascii?Q?cH7xT6ijxHs8XoeSVd/WjH1v4OprwB4+q0u3Dss/0u9rNkMY4L7XpoGC4Yu/?=
 =?us-ascii?Q?eZbrNo4lZeYto2iTeWBMJeJ/X9BIKx4+3nHXzxpF9FWwbc4eOQcFX1zrt9tt?=
 =?us-ascii?Q?gFPO1fD6PJyDHjO4HMSepU7apbTS6hGzOPzXC4xqaei23BlfRGFYO95ZtdGe?=
 =?us-ascii?Q?hF5qzCAr20V9lhea6ox16TXkOClSG6DkxnoOfnGr+eUcXXyLuZJ7HHALEHJf?=
 =?us-ascii?Q?Wi0HiwMLyyJQ++eUNkWEWg1NV9zIMZ4tsL6P4DicuBRDBlV3tiGtwDfq/h8t?=
 =?us-ascii?Q?fEMiDUKo8qcernmQdohWcgn2fhXTdMRwxm52IaWHiaUAXozJusH5QYfXq8aa?=
 =?us-ascii?Q?imKEi3/Ht8qNYrFbwHLkg7aCIixxoLtYUGLbJn+FAcYxsYvl8vxtLbelR368?=
 =?us-ascii?Q?vaHwv/zt+sib1dN3Qlbjpxw8vkFrRUDZypXYLLMv0PbH3ps5InPq5Ydr3jR6?=
 =?us-ascii?Q?Zhav87WoEGun5P1KcaJoYONe1PL9JqpORW9QSqSc4wH6EoAKESXMZuI09Nm4?=
 =?us-ascii?Q?93eN89oJHYC5ndqe/ATxsWohRbZk8kQdWYMrfYY1eF5/HNMXalZAq/Bo9xo0?=
 =?us-ascii?Q?NHmQIi2L5eF/046aVbPqT39ahew+CRd9OlcksAn1nYn0LPXbUhZvQO2C07Cc?=
 =?us-ascii?Q?DaCdwVZeAw41/WOg2Wt13LC/7u/fpMy0q+JIr4bdCOi6KV/8RJ/APrKekhsK?=
 =?us-ascii?Q?TRrsCfuRqdm1gaBRM2+sisGl95c3kCWiaH/r6TP79u8G0VeMBL2LmIBRv3g0?=
 =?us-ascii?Q?00RgyCH4UnrXCliAAx2HW2s1ZvqRo0LaIld9NatChUSYeI3wUKZ3cmnpALog?=
 =?us-ascii?Q?2Ov/W4wc8MNxjywfogjQf0bmE1wTJ6o2Z6A+QVBhWw1Xf9SOVZi7/PLhyjgP?=
 =?us-ascii?Q?kJEA9sBVTXEJRItP2XAxGzbw/4WdBqFEcSKVnVJj2e5p2kpM1dGyR8VzQF/f?=
 =?us-ascii?Q?DtZSv3mWo3MUXLAjr82LS3jz9SjiV+ILRBnZ5TXhdi52DamFKLKxj04uQIGX?=
 =?us-ascii?Q?YbPMFacpncescmmrfW848y7SzFpkq8IJZD+kWmDplr7avckSFB68VQ/qTUS9?=
 =?us-ascii?Q?n6LvQw7C1C7de5UuFLOxsIJMkK7lKEV0HnRPSVoPGgyvS86X306AxBSX/Onz?=
 =?us-ascii?Q?9DXNmVeGJYltaWE2KfhkKUMjDv/qKE2jhD38SrgZkpYs8X+1A5E9cv1v5q6i?=
 =?us-ascii?Q?lSt8+aC7LAKgZiCpzqzyCt15dbX5rZfW6HfXrvQd88XorQlGGG3LOHrNlmUA?=
 =?us-ascii?Q?EjJ6Gc6I2Uo31lxDydamjZ8RTwV/dlMPE1OXUaoURC3OYgPMD3cMgYe8qfyf?=
 =?us-ascii?Q?to5BOcGsyDuLxz014IqPULoqKYL5pGe8/rnS1X6DWsxf1fVpsE+LiRWWQdEA?=
 =?us-ascii?Q?lM3WgVkBtI5qkDUIeSjU1sfmgvd0znTHkC88apDTGmHmYdfhXiBRKnNwzMMn?=
 =?us-ascii?Q?Euz2zJkV4eid17f3Uqfhzk1oqGD4F33ICbuw4QwZOos7wOS6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee585d58-e606-4ab5-fc12-08de6d7712c8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:18:51.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7p1C6DvPh7lNKnRfoJC5ZUUg6aA3Ko/tpPjuo44NzbQo/cgr9VWe7eBzpg0eTpxzvBieuQrv8QfJfUL/aFsyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

On Mon, Feb 16, 2026 at 01:38:46AM +0900, Koichiro Den wrote:
> pci-epf-test advertises the doorbell target to the RC as a BAR number
> and an offset, and the RC rings the doorbell with a single DWORD MMIO
> write.
>
> Some doorbell backends may report that the doorbell target is already
> exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
> case, reuse the pre-exposed window and do not reprogram the BAR with
> pci_epc_set_bar().
>
> Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
> only restore the original BAR mapping on disable if pci-epf-test
> programmed it.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 84 +++++++++++++------
>  1 file changed, 57 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index defe1e2ea427..7b0955b4c703 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -87,6 +87,7 @@ struct pci_epf_test {
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
>  	bool			db_irq_requested;
> +	bool			db_bar_programmed;
>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>
> @@ -730,7 +731,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  {
>  	u32 status = le32_to_cpu(reg->status);
>  	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epf_doorbell_msg *db;
>  	struct pci_epc *epc = epf->epc;
> +	unsigned long irq_flags;
>  	struct msi_msg *msg;
>  	enum pci_barno bar;
>  	size_t offset;
> @@ -742,13 +745,28 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (ret)
>  		goto set_status_err;
>
> -	msg = &epf->db_msg[0].msg;
> -	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
> -	if (bar < BAR_0)
> -		goto err_doorbell_cleanup;
> +	db = &epf->db_msg[0];
> +	msg = &db->msg;
> +	epf_test->db_bar_programmed = false;
> +
> +	if (db->bar != NO_BAR) {
> +		/*
> +		 * The doorbell target is already exposed via a platform-owned
> +		 * fixed BAR
> +		 */
> +		bar = db->bar;
> +		offset = db->offset;
> +	} else {
> +		bar = pci_epc_get_next_free_bar(epf_test->epc_features,
> +						epf_test->test_reg_bar + 1);
> +		if (bar < BAR_0)
> +			goto err_doorbell_cleanup;
> +	}
> +
> +	irq_flags = epf->db_msg[0].irq_flags | IRQF_ONESHOT;
>
>  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> +				   pci_epf_test_doorbell_handler, irq_flags,
>  				   "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
> @@ -761,25 +779,33 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>
> -	msg = &epf->db_msg[0].msg;
> -	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> -					 &epf_test->db_bar.phys_addr, &offset);
> +	if (db->bar == NO_BAR) {
> +		ret = pci_epf_align_inbound_addr(epf, bar,
> +						 ((u64)msg->address_hi << 32) |
> +						 msg->address_lo,
> +						 &epf_test->db_bar.phys_addr,
> +						 &offset);
>
> -	if (ret)
> -		goto err_doorbell_cleanup;
> +		if (ret)
> +			goto err_doorbell_cleanup;
> +	}
>
>  	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
>  		goto err_doorbell_cleanup;
>
>  	reg->doorbell_offset = cpu_to_le32(offset);
>
> -	epf_test->db_bar.barno = bar;
> -	epf_test->db_bar.size = epf->bar[bar].size;
> -	epf_test->db_bar.flags = epf->bar[bar].flags;
> +	if (db->bar == NO_BAR) {
> +		epf_test->db_bar.barno = bar;
> +		epf_test->db_bar.size = epf->bar[bar].size;
> +		epf_test->db_bar.flags = epf->bar[bar].flags;
>
> -	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> -	if (ret)
> -		goto err_doorbell_cleanup;
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> +		if (ret)
> +			goto err_doorbell_cleanup;
> +
> +		epf_test->db_bar_programmed = true;
> +	}
>
>  	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> @@ -806,17 +832,21 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
>
>  	pci_epf_test_doorbell_cleanup(epf_test);
>
> -	/*
> -	 * The doorbell feature temporarily overrides the inbound translation
> -	 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
> -	 * it calls set_bar() twice without ever calling clear_bar(), as
> -	 * calling clear_bar() would clear the BAR's PCI address assigned by
> -	 * the host. Thus, when disabling the doorbell, restore the inbound
> -	 * translation to point to the memory allocated for the BAR.
> -	 */
> -	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> -	if (ret)
> -		goto set_status_err;
> +	if (epf_test->db_bar_programmed) {
> +		/*
> +		 * The doorbell feature temporarily overrides the inbound translation
> +		 * to point to the address stored in epf_test->db_bar.phys_addr, i.e.,
> +		 * it calls set_bar() twice without ever calling clear_bar(), as
> +		 * calling clear_bar() would clear the BAR's PCI address assigned by
> +		 * the host. Thus, when disabling the doorbell, restore the inbound
> +		 * translation to point to the memory allocated for the BAR.
> +		 */
> +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
> +		if (ret)
> +			goto set_status_err;
> +
> +		epf_test->db_bar_programmed = false;
> +	}
>
>  	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
>  	reg->status = cpu_to_le32(status);
> --
> 2.51.0
>
