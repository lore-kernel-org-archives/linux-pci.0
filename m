Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021129.outbound.protection.outlook.com [52.101.125.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC9274FE8;
	Mon, 23 Mar 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278578; cv=fail; b=kjPtGG9X2AAzTJ2RI4I1GNgAwIKEXq6PtfCPdP7vPGBxGOn8j8xgwnHoGR+eOkSE4XdcMMBoEuPKe2Sov16um5VqmMwS9XOg5NGWmd2Z97OfErZe3LCw3jMRVOmKTvZuw6bBGqyxwlVsO8hxuMrPrOD8KNzdt4GYh3STbgXWSLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278578; c=relaxed/simple;
	bh=7G1jBBrbs7zTfEfU3jAc+nQs1qTJs997ozXUSUpQjhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M8Zymto6XpCrQQQ9TYs6xmPbDkGMeAx1TUZVizmywywIm5WxpHzIEF1KZX/eeBZdeR4E1ggLWvcPGdG4bq94iM2JTjSJ9KNKeTYWibOzLRCC1j1sqLDbvddUcxJfsNTUYxsYmY3H3RYK2NroUb3SRhRl4gLihGJky/p+dh4fI/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NiXVXf1T; arc=fail smtp.client-ip=52.101.125.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NiXVXf1T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAnyXuAowBCN5puQ1qEDcm0Kw56ehq80sLEe+lUfuCOjCn1EJ2Uy8E9p3gc3M2gnQse4ssWnoYw1ESHYU8DOD6YFRSAe1SFdefLdlKvBjnQJHiLIy4ijPc3GfkVfgtYJhhdDXCqQKakUuaJSnb+RGsBABwib1UWVCDtKn04MZ3f44hqNwcLzKYch1TbuHkzK/5sVaCMgsillkDn3TWeAE3ig8yUO0ygTH5LoNuxi5yZCNHv6/fm8r7m+Sw2abeus231Y/hDgqpS2TJ2lcO2KtPqDpF6OS+oH1IX308vEy8HeHTH5BPeN6GTNkyk/q5d43bwA5nLPXXdfl1CEK76jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6FgM/VRusbgypBfjrYUmm9h99LGSxoLJWc8eGH1hq4=;
 b=ObpXfQne0Zk/u2zuDv+2/qJeVJlcC/xbiA1Ha/te5Lc3Ta9STzWQblIYw+odL0FAjzGV8w0c+qhny9RviXo8bjZjndjj+FP8FaK71l2Vtwr1ifxmFiyPwJsNotM1sbCga3N7aPYpVdDqVS+jF0ykhWQlM/N6Sxh7ZeXdm0MjmhFh4hUps8jSusXlgx/qYhVBWv8lPEH9WOvQT/JsAYwxGahcsS3/Vz7QhUJ8jMVy5SMo6vGxhemYBxar5wZUgVi5yGVOTEFHilZ63hFdH42sNoS0Wk6aZDwaXiwN4G6kZ2xY/rufzXxa+zFL0TkzPTaFKrJAQEOdUQtZD4DBupjSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6FgM/VRusbgypBfjrYUmm9h99LGSxoLJWc8eGH1hq4=;
 b=NiXVXf1T8aUj1Fizl5aqf9E3eTwZEQ5Zsow7Zq5Qpfm667zURj7/7oY3X7LWu23xnIp7nVHgwqDsSvoyLuRwo0xaQt2G+JywyvKygHzJJHbFlX5GNg+9zArPVO2rysP20TcpdeEFOXoz2drn79T4GwyAdh5CHtUGaIQYmD8DGr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6014.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 15:09:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 15:09:31 +0000
Date: Tue, 24 Mar 2026 00:09:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Message-ID: <z3vlgz3zqrfir7rwrw2fqic6v2nz222zmytb3fbawkrhypndsk@inwddhn6yo7s>
References: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com>
X-ClientProxiedBy: TY4PR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d942ec7-0abf-4249-5d40-08de88ee2f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	EWJsoPTVvVcyjDFol4iMPuqTRZPz/POAAPg/HIgyosIVVAicNWygLovd4bc3iqxPt5yKm9463axE9bksfK/KuNCsvpxTBroxp3tEo+JjgW0QhXaOcnwBrq14RELXEUN7IIvcaf8Ke9nlMVcAGtISzTb4HDKiSCnRhNF86c+I7EiuEhgYYJbsfd+8dqNf4LO3lDVqmG0QFbV/okZxbKySVvd905fnR4jNWOpNECgVt+pmY9KjgWop0QADBWyPejnIFxSW8CBC9Lx4LXJ041mhfz4FyFD0tFQBGbhcY8CvtSuiIZRpkDRdYJe7CyyWu6jZEr7r6+8EOKmLcNXubVC40YxljwytKacPUGKNS/1C2yFPDs4Izu+7Oi92PLG3OO/oOi3i2hTsJh2KOY15kONCZve2BNViBuOrnQjmkwVoe7l+VOxPjSd+Zl/WKKwpyaamEIggSW1q3tfDnj3oeBSrBcf/f2CTzKiPDGh+pajjUiQcAkh7WTEpchrRidb/tk/J0/V0ULNnzA5CDGdI067VRcKS6oWExH0ydcjO54Udg/mEvPHmBJmh1GblTiVi8iEO/X5GFlltswuB4lvmiFdk/d8e2zxUgGKXnFVVLcHmTInVJ/d9KQIahYulgWz5Gz/1offI/nv+b+2NqDS1rGDp6nrhZkVn3LpUQ1UfyRtq+IEjMEu5ZahEZ17cvThkrXQOAZPDAGO0ORozBw51ME5f8hlrhdRp2CR8/LJhuuptL4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pf2EzGp9NbtS9rDL+aA4Q53QaQlY4gQ2XMH3JXIBz/52+WAxpthoBRcTIY3v?=
 =?us-ascii?Q?rGRKzFPgEslMBervsvQiDpp63o57E0t3GlJu8m0PDcbPMTpSATzRkqgxfTVM?=
 =?us-ascii?Q?mQKMdV+EzBY2lgFOfKBrwrb2yuwvl7hyk3emTjZrAu2ikbSVhnJ2IbGSFuYI?=
 =?us-ascii?Q?7x+ARfxlk9gohKNIlvym0dxziJU+4dm+7CtocPBWORuj131q3GQnRZ4Ydb08?=
 =?us-ascii?Q?LkMl0WcjK7mAJNEH03OnpE3JOVIbAwcp9NZANlaAs6AB6cBESqyz1zbbXLWc?=
 =?us-ascii?Q?NsVzHa0GYV/LSEMSxXPHQrVOa9R71GWX5Potnxpsr0Y/ZT2shiy0C1Zt81e2?=
 =?us-ascii?Q?EsNt774f7/2Rc3Uf/rfeMqQ6wRthWhKYPCX7xSxwJobE8rPqt7kIIfmjVtai?=
 =?us-ascii?Q?p9Kx62YAbbFcJtmUBzw+kLTkIf1ftgYlg7U48KjIKk3cdlZo4bQMMGWlGN2D?=
 =?us-ascii?Q?YDVDBA871fxFjfSkX8UkZGVEzp524zMxxPEMtFiKwDW6I+ZiImsbdHixbcnD?=
 =?us-ascii?Q?y7I6CnlVjO7moHd/6WBA0GJYvQ1z/a96oKp3y4Rr5KAlIZBWkc6ZlBePfDAs?=
 =?us-ascii?Q?aVFswBVbVkQ3pZCBoZvkeLJhxcfMnvYZ/sJUBq9EoDrudgCVwqB2mYglgM/d?=
 =?us-ascii?Q?eGDYfAG9/6p0CBb0jM31bhMENYh/Ee7qML5hj6uIjsa95e7BGRqCEzI6/iI4?=
 =?us-ascii?Q?+g/g9jRhseWz+I2KVPKviAB2o2adItylFtDbR0uuVroorkTyWGTkg7iq9g5n?=
 =?us-ascii?Q?VZn5aegzAwgn237OFeQz1q7ydGMuBYVzTENYbWcGsPtKMWmMQHRvcDnYPHWe?=
 =?us-ascii?Q?VSB1rsS0tDyXzN7DMe7E7Wozdf6vbT+yZMocj6c5gl2Hxc2wPR6KLkUYSc+F?=
 =?us-ascii?Q?DtPFCYBvc19uwT3yrk9/Mmj5gYvGN+yu1kNz4mhUpWUY1GIkgRDpkSu3u6Bx?=
 =?us-ascii?Q?1CwoVEBmWgkvmYoEP9NyvKKXfxvQxyBiOzTpqSxnen22UgFpjSnTJUhpzCgZ?=
 =?us-ascii?Q?/Qqwg0B7A6gTcBRPMMd9n0VrpE6FRS4XaPMaSm2+tic0QaBQpkE+nnClCwcm?=
 =?us-ascii?Q?Ju6N2CENASsk9dOoQfbQu1dwwNxzU0BXUM44X93Rvi0/INxEi9crjSdihifu?=
 =?us-ascii?Q?cxkEDkoV1LPW3GZH9pMUy9jDgVU/BL2KeQewFQO/Ga4GP2N27FR3AjBQmT+u?=
 =?us-ascii?Q?oUzMoX3OcfrncZyLkyAad2ov9YRfsUte5AvkM72jxke84Tey27X/E+PjKoLx?=
 =?us-ascii?Q?nwbZxtCdvkol6lQEPrXHkYThw6TU7ZaiYVFk7LwsHdax0Jggf4YWduHh9yE1?=
 =?us-ascii?Q?ECJFk+0/leezn9P1Cl8E7/2w7XBtshoLoR2Mp1W7BMOF8vulH2GloZbrBPl8?=
 =?us-ascii?Q?V/COUGio2AM5gddKHd05T4V7s6y6n2GmphKfK5gFd8g5x9Sr/DMlY3PVMRG1?=
 =?us-ascii?Q?Kto2KGVPVyW8NMu9fu+0RwOxeJeZv20l11Plc4waLRO9pHTnqaNXpyxnWmG9?=
 =?us-ascii?Q?gY1SqD0ink9bJxrZ+o8uRCjx8DXmp7jRtGxHfrZUdLvAh9oJ3j3vhKQSwN0n?=
 =?us-ascii?Q?PHSeXIEeCHAcVieaBEJuChA8+fwjPfJLJAqy0drOn5cGxF1R3ukogVmnH634?=
 =?us-ascii?Q?ysDV5qKjihTPsEdRQCaRcIJxoki7QoiccqACoi0RYSLEOcN/R4/LjwwQf+Hi?=
 =?us-ascii?Q?DW8tm2BVEOaHutwllMFyf++HSyl2wle2l2hrFsVQzkCm1rM68Gb54ghz9qqF?=
 =?us-ascii?Q?d6Z3LhfA8nK0oNjYhtCU9Os6MDGPipTEcju0DOphKxuWNB/kezpw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d942ec7-0abf-4249-5d40-08de88ee2f53
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 15:09:31.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+wphQigLHzM+oPL9vN7X1HO/T4fuwaW3rHOL9KyrUupZWSOGLLXAsFP9SvUPpiXGKOx63YdJ4tKMV0FJVcfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6014

On Mon, Mar 23, 2026 at 12:59:26PM +0100, Christian Bruel wrote:
> For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
> might fail to allocate the ATU entries for subrange maps requiring more
> than 1 slot.
> For the dwc controller, this failure is reported with -ENOSPC in
> dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
> to be skipped.
> 
> For other controllers (Rockchip, RCar, Cadence) the .set_bar functions do
> not use this error.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
> Changes in v3:
> - Remove 'BAR' from SKIP print message (Niklas)
> - Added 'Reviewed-by: Niklas Cassel <cassel@kernel.org>' tag
> - Link to v2: https://lore.kernel.org/r/20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com
> 
> Changes in v2:
> - Rebased, reordered patches
> - Clarified reporting message in selftest
> - Renamed STATUS_BAR_SUBRANGE_SETUP_NOPSC STATUS_NO_RESOURCE
> - Link to v1: https://lore.kernel.org/r/20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com
> 
> ---
> Christian Bruel (3):
>       PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
>       misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
>       selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC
> 
>  drivers/misc/pci_endpoint_test.c                         | 3 ++-
>  drivers/pci/endpoint/functions/pci-epf-test.c            | 3 +++
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92
> 
> Best regards,
> -- 
> Christian Bruel <christian.bruel@foss.st.com>

Hi Christian,

Thanks for the work. Looks good to me.
Reviewed-by: Koichiro Den <den@valinux.co.jp>

For maintainers:

For this series to behave as intended in all scenarios, please apply [1] first,
then apply this series on top, as it depends on [1].

[1] https://lore.kernel.org/linux-pci/20260320140139.2415480-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
