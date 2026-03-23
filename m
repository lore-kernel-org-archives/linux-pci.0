Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178333C279A;
	Mon, 23 Mar 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285350; cv=fail; b=ZdTQfL0c9jd0uX4Yea6iyHM483cP5xcueyWSsHkYMa/+wcTd2uVQK6QaZHlTxo7llekRH8qFpXk1JspcOwbEMBHbjsurONqNhiW49GB/O1z8HtCCZq6UCZTtfW/Ag+icxg3QpTIf9GF6/CUKHCpPHQcfUfiDRIlZGZUPutaec3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285350; c=relaxed/simple;
	bh=G5pyWNMbGkI5O9ILlK/K2Tk1QLe+XQmmBM9eRN7mliI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gRCr1k7NtA6twZ8vgzYRz0x2hwgDZ3h+A3mRiDGfE4m2pI+ysK405BoUn9Ru4rLEMT9tb5gw0sJxapOyECqJ5KA8eFjb67vc4xtrqVpJZu3rcFH4AhLLaMtINRIoi7HTLkPJS1AWiLum2V6DZbHfc3eiXZwhx49cmJjiH3EP/CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LoeHVvpl; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LoeHVvpl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe+CLZRTCPNhMkRyq/QFGIh8BYPT9i5jdsXMry2IDkVA3CVbIivegFmkQ7/jbW2iFGU2yux8VfKO7ajPm4yu+ebnzfMF2wkgsMRatz2tAwizHxGYXZM1u7Q9pv/TxlkLCBt6JqHcPq35kytmtLRIkNIs+QEGukKXszJZzfiS0d5p1/f2PqmT5ZALTmOPCJulqLBbpLUWVQdMSl5yhj7YxRWdjzWccqrYgjCFs92FpmDue8hieiK7nGvnN8xtS6160cUx+lR1GURO587sCHy+KnfW0NerlZIRWm1ElKyHFo7kTEHNBhRT9FaybvZlMmOqXRNGiisq7mtvUOGB2CR+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofWwR62Z3YQHtm8Df364AULw+qA8fwKxeEusjrR+i7o=;
 b=xHWZw6ly8Ox4Qn20ACkf45S/sSXG7+11MagPqRfZPoeT1nDyJxwF1D+aoflp4xuEr2p11hKQ/pGepEX82bevKd++bk2i25nJdHtQXQctQt4a8z+VdkId29z/fn0c0LHvyOMqnhqWr5A/frOURvf6Pzf9lr9E/3ll9DF7sPHqiTB+nThmD2ogP5cDL8OcAhxdescRP5fHhRRFoPDp36lB7IkvvWgFodcrdWWA8Ac7Ih314EaYigZETNIUuS3VTWw0GOdgrzCSFzeZwZvMPLUhM9coT+guW0Ut6h5s7A2ExdiH7us/yxsF6mk5NC4PsfwyhnFhfrjedQBmBO0ZCC322g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofWwR62Z3YQHtm8Df364AULw+qA8fwKxeEusjrR+i7o=;
 b=LoeHVvplIo5ZfJQCJ/3v2U/7Nn2cjs3xCb9TRBLHoRy2S9P3Qw2XWsCIWvT96mPgpNEWz2PRBYAknX6qFRN6mN6w32sjNiGCHHmcsqgZxwuUvrCFvgRayLQTpO6jq4M1/kei7OQDkMuzbD+DjmVFDAtoFgC845QzmBr7tgxLcNmnxnQ9i8EhxuAEhM2Tq7Db1d3shQlYB+NSTswpVVtwI1EBtn6RIDXi6Kf0eQP5l7veeaRaDlrSLU3GsARKSQPEsItNeviMLALS8HMBu1GLn7b2OI60LM+wrdUnEIw7RmQj9lmfk9GmLudPi1b8sMwOd0VclrL9JKmpLr9/OZbXiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 17:01:59 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:02:19 +0000
Date: Mon, 23 Mar 2026 13:02:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in
 subrange_setup
Message-ID: <acFyGTt3QNKehuJU@lizhi-Precision-Tower-5810>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
 <20260323-skip-bar_subrange-tests-if-enospc-v3-1-4780f296a5b4@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-1-4780f296a5b4@foss.st.com>
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb2f3be-8d5c-4ef5-3b4a-08de88fdf17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|38350700014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zmwcc7PUpJ8m/c7gCuukz0GEvTeaWxjRnxZN5VfatwOHyyWU1CiuCz1jJrL7sxYgP1zijILUsngbMcQFeJuQprl+wngnJIyQqqnyP/mSVGnXmIt7t/TmHVHlCEki8O6HMsggoIfw7NDA+H8WW5y49tjeW+RVVi29hnJZ1i83tPgC+5cvziyUykjAcNydub7I6N9yCKPRTQ8Sw1//eeXxWZUM2ZbysOx2MJ2eTpw6+2lWxsLOoY2PGiFTETYWuZfbucSdb7vkR/bxVhtmtOgSch0USbul4IkuneLCam/IBk/I52TS7cnTdJdZuaEiG5mAQhYK5IDkcZklXy/oaVVmSId+gphZZBZqDVu5oFPopvolRZUy0unKaXSoKpfFxtOTP0OpJTNF0ddHwWhl5bEQCa3ufchItfCddtLzR1H4biYxxGgK5Q3419ow906z/6xv8cunNeqYZazQ27aS/RtWVDmGChF3rOfkvb9jCoPJDEoK5mS20F/vs+Fiej7sL7uHnvKYAzpdL9E3hAki/CAd785ipg1wbqTnO5aZ9C/+zdUFhkeH8egnb0Q/hUE4q4wkN5ej8Uv2GB9kK7lAHWP9WWZWqbHv4kfdYkAPD/aoOKqqMDoBHYHuOqTj4FBun16F4Rmo72MFh/UuqtDRywExVdzwWY/S5LTH7pie1smyHo2VuspSUs4ZKYV21952iDySZ7fy0bwhe2Uo+vm9bnZ0BQJ9J/MeZnuI/b3mWXy15pUJsgXFqlLqZJXe7m1MROdwMncq2NXeXXLKnzhRRKZMWazcMmX3dtbBrZ5/gQ8Rw8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(38350700014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/tD52ge7fev8jS3+wzEwe+vLhNMeGT5z4Eft4L4637pp9zcgWK3rJAbYYib?=
 =?us-ascii?Q?lnuzMxnqTDVQ6I4dz4Pm/eXvYAMZA0u8r4B0Rogz6pQIHx3ssM313q6Sqldh?=
 =?us-ascii?Q?0c6ItnuXQdcyIymrn/hwwptuzWPxqKGAgJxd+ois8afur3mIF+NFxGz5ZpVz?=
 =?us-ascii?Q?9fRiCxw0OginMSUjNBkaDwC4mRLJf+4jCvYqbAV51H/XPI1BYeY037zV+C2S?=
 =?us-ascii?Q?FuiudgTmcT85ufbmg6F9ALcBtN0ZNy0ikgr3BwGiwsTPz/6b8w26nnrliqIt?=
 =?us-ascii?Q?Sd8iel2E3ZQEctBu7k/DfXDscn1tG3c2tGHtbMRAbgX58O7BGABsvZg36lc3?=
 =?us-ascii?Q?++r4OsJrKGnO1GFLFuuEeGDdQcFIbIXki9dEVQ/BYr0kUoc4gIZ0oc3bZlcr?=
 =?us-ascii?Q?DTMZdkS7YpjJWLGuCXwEXp2laLumSdYOtENYMVDuqHjwHaleRsgqZ7VZzWxh?=
 =?us-ascii?Q?JuQ7o3u+xXqS9btdVwQwMz5feOASeY5LwlQCemiaCR/CTbTosAeTzeSdkGYm?=
 =?us-ascii?Q?EmgmUgb7SXfZErqsTH3PO7y6fUd8DwmGwjZAWli8+MFZY1GrPfGyDA4/Sd26?=
 =?us-ascii?Q?qjIP+QW8re08/Od5apK+L01JmPud/B9VlGGoCt1xHDsEcEuHc9uks4Ea4dqO?=
 =?us-ascii?Q?yuRO03EAP2zTEbXV1p0EA/9W7ozlTOuPLec1Et5v5VP2Q6j1w7E7OzHIvENb?=
 =?us-ascii?Q?XIu/A5oGbNks5hmyxhBevOa8wEWwNJgWFZL7S4CI3wsTBP095wISbU5FI2jH?=
 =?us-ascii?Q?8a3a16J0Hx8Y60pPQR88J5NFTdWdb6d0QbulGPabb0Wop1pw8bqa5jXxegpC?=
 =?us-ascii?Q?vSUlWOwoOAYcqbjpajaTy7eJ7Wd7tRoBpniqS2dbLS/5rD1e7t9OcfeUFlzA?=
 =?us-ascii?Q?FsKPxnDSfUZOfVVXHrSNybR2a1iplok8DagPGbWKJKZDmEv+hYcWGE6IBWOZ?=
 =?us-ascii?Q?QV8CsWtllfnLzsXhP3xfUWcAMlQ0J/LaNVAJGkj+d522EJG7XZ8tiRWDNLsD?=
 =?us-ascii?Q?prVAvb0gebN8hviU+safCOrMx1TwL3kHx4K/tO7jVlZgn1znE3QSg0B4dpwF?=
 =?us-ascii?Q?6wrYYXvsIIg4ZTniMaJGbvL9yg7szo6nC51ll5FT1nYaVpPDmID6mZX2MQcl?=
 =?us-ascii?Q?d6mvlgZ3kH2hOWMLcQ6xcMRG08AiGXEqxikmSTYoSi4IwSNYiYc2X5U5k5mu?=
 =?us-ascii?Q?c1K7EUSBVyMjszmxo3pUBHZSSR2TTILumdpb7bbe0Oo97Ipe5Vl3vzCY2rSU?=
 =?us-ascii?Q?AIl6O/5Wakj7lXvHAMO7CqofoiLJsjtStv4p8DoVo6yUI3UDQKpcytYg2Hdo?=
 =?us-ascii?Q?5H49KrfCBhXd7aw2UrmrBd0ut31+KgbzVf/k5oKspjnWibh86fIxIBQJf8FV?=
 =?us-ascii?Q?DLyGvsqCUrgjtR2T5SnEPARX4PFq3YVScDIaXpT4SI+bgz3uwEb0MjWl4az+?=
 =?us-ascii?Q?zUslWRUbhLkh9nA3dWUHDmSq3KoF8Sv3XpuUVK2HeaD1vWQjIzw35mnpIPYz?=
 =?us-ascii?Q?l4whgpsgXn7iDjpr9CT8mjcaZcXkeOxJ3oK6ECRADprwLFBixrP23T2HOhwt?=
 =?us-ascii?Q?zvlxKxVvG86L6c8toI//0y5TmtT2JFm6hzRF9qI0zplaREr5ZiNAkhZVplMA?=
 =?us-ascii?Q?YwOCDoa8XbmMOZs2qwVaOU0tqur1luNq8+6ONkWIOuqpQniRr04z9HXUsCvV?=
 =?us-ascii?Q?vVADHDzgEEzFpYDcqBwS8MW4S+6L/LYy9K5UP0kErNiwUSIA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb2f3be-8d5c-4ef5-3b4a-08de88fdf17d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:02:19.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaPa5EFnXAEhJ2F3qa2MGhNhRWPG+O29VCJ75phg5/9goCvIKX3DpOb2+bRjGj7D3a71HdqDKnMeMVp6wuYmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401

On Mon, Mar 23, 2026 at 12:59:27PM +0100, Christian Bruel wrote:
> Set the STATUS_NO_RESOURCE status bit on pci_epc_set_bar() -ENOSPC.
> Here this is used to indicate there are not enough inbound window resources
> to allocate the subrange.
>
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 06bf53b28fb7ae2244a6d82bd5fe76d40db830b7..591d301fa89d89addf5df16e775e80460b689589 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -54,6 +54,7 @@
>  #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
>  #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
>  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> +#define STATUS_NO_RESOURCE		BIT(18)
>
>  #define FLAG_USE_DMA			BIT(0)
>
> @@ -901,6 +902,8 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
>  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>  	if (ret) {
>  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> +		if (ret == -ENOSPC)
> +			status |= STATUS_NO_RESOURCE;
>  		bar->submap = old_submap;
>  		bar->num_submap = old_nsub;
>  		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
>
> --
> 2.34.1
>
