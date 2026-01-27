Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955A30F522;
	Tue, 27 Jan 2026 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485457; cv=fail; b=pSepYugcRUIsRNfXp0HM6N7TfPiQ89MdyZsJfbRPabrma/NKcdChZCI+hQnGWIB+mLQb0nD0nJgb4EswgISMZPKER2BEo3dYAFSOcjpjqFf2gEtrd3bB6Me23PPfD10umx6zOmPpJF70DAeYDXOOje3T8iGhEkWrSTY9AVZ+QgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485457; c=relaxed/simple;
	bh=5IrT6dzwvKuo0+UPOt4HHJTTsYiqLtAGhJ05KlaS6aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcK/kljFh3otTdarnPe9DrMeWudITOBX0zt0CTzVQMMzRoaTSoQOVhWIV9jtxdER4D+ER7mtLT+YayXsw1xbp/FXUgr9rxQeG20LwLV+wEVnvM5Q+OwXn0TVLQDyWMsHDKV5XEE1X9SjvICjmviZYu8fAhosot9S3rU7Ypl/BYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O8p4An3+; arc=fail smtp.client-ip=52.101.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O8p4An3+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ3XEhO04rRId0gq7P/09gsa52nhTD8DtQXZJN+NhwSiesyZRbZF2/z6WQd86R8DBHMQs3/UkQ9pPwWEGdrHw/+pW7ohAH214acfO5V2xQ8EXuavSPl261C7IHKQikJejT9PNiUJGXz9CUbHsqPSnDAQ/MealPi289fDmf9eUlKIALrzkV/gjFXy8vIPECuuVrCmgk6tG6ZW82nCyKCjqar01SByLKwaIuE6Ned0NZfkVZ+dOaNM+8fO868j5CyYqqeilFU1y3rR/rEnZIwkeIM1ZGuhm4WIpDS5k0b3XMJtz8dSSHzIYwpqHviFGe6rUAhymBOTS03R5Qbxy3BELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=derL3pgMSrSj2strRnAnx6dktB18sVg6ftfMhjHSk94=;
 b=SGBQNxmY/1l5pILwHkPYeUTSHFgDfUMAviwA8DkNlGJ/vP+eSdr3R28CfgNb0n0x6sqpx+P6hI47TU6H/Z6WgJALrmRQL+QpJUV90t7kI2FJL8SrZrieBarV/znZDyT9L5hN+VmjoOGRsCut4AIbutTSxL5rKViF0Rf/hcAMoVscqn1kyCW/hzStT6BCK8EfOpbYE+YJTOHelfmVAlMpPz8nHN5Ur+3c7edHeJToiFx0N9nZIKsCJkvyN/7TWJ1uUEFALuA9grTn1s7RGTu/+85QDMZVHgfQPaxgCyF/UNnpJ5TgqVfjIRHFmsiwsrfSEPCxbNwo+Vv9VhD840zBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=derL3pgMSrSj2strRnAnx6dktB18sVg6ftfMhjHSk94=;
 b=O8p4An3+XYA+adO6idzyJPy+AILK8lzqW97R+ZyFmPV1E7ATe6m5YrdJrvWEHmeLaqcF8yz2GtBtYFbkQezVtSYQEuyLb4VCWkn7sKQsv62bLdv2dKO6WFDgDGv3i7xYE5NerdeUjEKBQlTNyI5NV7OJGQN8zS5nIZC6vm//iW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6346.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 03:44:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 03:44:14 +0000
Date: Tue, 27 Jan 2026 12:44:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Frank.Li@nxp.com, 
	dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <23lxq2hvynxqmothnkhjtarpklin3prv7tvjlvy3xjnzpn5kdj@ks2qay2tgzc2>
References: <20260123180747.827357-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123180747.827357-2-cassel@kernel.org>
X-ClientProxiedBy: TYCP301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 628de6d2-4ce6-4f0d-037e-08de5d56570e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVLrKypUoOZt3FNd6hKuuE1a9jyCkHy2fCtVlY/9Z4EDnO4ZXMth2WqDLPUm?=
 =?us-ascii?Q?vacwNJcA/bD6dM0LTopjipNuKdVwxiPuDGPZqd8mhnD0qg/OIgz7em6NI50V?=
 =?us-ascii?Q?ed16VoD6sbzzROskawEiWQAI2LnhiNzhtLTALxS+5lJi9GZLw8qFcSW7ZMAB?=
 =?us-ascii?Q?4jXAz5V0I3kYPBCpjbQUFmOFi7rVknffOUQoXOvNldB83Yk+62lH8S89Sq7V?=
 =?us-ascii?Q?pXGECF1FQD5Q4kNTHYMZCRPTXHMXIFH8IKknbJ5oRniGBkk49lLjb6I7EZiH?=
 =?us-ascii?Q?KyMvf5gtqCGRmyZA2ws466qrqk9pffJjGm2fKhYjdbv8vPWyuTpl5lxTy5WQ?=
 =?us-ascii?Q?eaa+jjkLfZzjY9Edzqndzfy2k1RlYHND6mt4PHnX7aX7hxv+kTh/DxXOQAkq?=
 =?us-ascii?Q?SEPxwd/ot8OQCkp3WhgxYUsr/qficZkbBrWHpYITMbJ+AbJ2lAuJDbJPv3Iy?=
 =?us-ascii?Q?N5a+vdkgFNwwWLJRcbQI0tD6kgMyw5B/jgP8h6H9dbO2qOboEd2hALVP0Usm?=
 =?us-ascii?Q?kg2vRMq9FV4y+fJ1VymN+9MC/XQk2m3h9xoi3iSe5qo5xrEUeZhAydA0ROBk?=
 =?us-ascii?Q?FZJPM2OUs0f9jp+fd+gbcUQY8LfS8fGo7cXnraTWVdc/GDIqwKs0D24wKOQT?=
 =?us-ascii?Q?P7T45wZATAjCTkjVhVx5MHDrBqlWZ25W3AV9rJjUZ1H6VigHWOgjRZFtr+3w?=
 =?us-ascii?Q?nWJFXFioG4po7WxI/4E8sHot/wv98/bSRP4bVx5BgxxuRAHFrssBSEaM3SEx?=
 =?us-ascii?Q?QLqtCxAa8wTBcFH3NJhr6hViorbcvUPrXhTH11pRqs0QaVNvr1VAseOtv4j4?=
 =?us-ascii?Q?YmpOuK+1RU2XsgWsP+2ZQ5szZ7I0zobzzOjJcqnTe98kgKIifqXo7BoxWJgm?=
 =?us-ascii?Q?Okei723PtyS7I9+RogqNdCTqVvQsUmF+35s1IAHsA2WuJcamHTtgvu3l9a34?=
 =?us-ascii?Q?J5HpVHkkbGvp+Bfm/YOQtxOYg7tHEEA+PHTXTFgwciBT4SOJ3VfHiue8TucY?=
 =?us-ascii?Q?8vrAii7sSBBfQLGfucNZreC4gSTmq+rtawy7dXJixoAZr1nAx+t+ybqKyjDp?=
 =?us-ascii?Q?pNRLcrNfhV/9iHLfCf3W2oz8LfUp0MlYqAwmnEuyPpN8VyKMDPgkSnUDiLjo?=
 =?us-ascii?Q?5SMisL3OSHQls0/lh0D7Nx8ubICEpN/wBsAFmaS9HL0eFh+mWgovvo3Tipkm?=
 =?us-ascii?Q?OqFphZFdRI17lft+Jhy0JImEocFcT1k7rgmYf/YALx1O4ng1KyOzx/jjAD3x?=
 =?us-ascii?Q?uEOzthh1X075VFiQTN16IIpP1+9Kv1UQRYSDGrHQ8C6Ka26D9ft+dwa6WaIc?=
 =?us-ascii?Q?jj9caLxIaghHiIf9bEgy9aB0fbliiTnHTX+pVBSkcX04dkATrTG9cQThV+wz?=
 =?us-ascii?Q?ww0tw+6NFHfGC4QlxL0q5hq5uRiqeB9t3FE/79M3tak5PDWkA29akD94jA/F?=
 =?us-ascii?Q?xkDQLKIvdsatoQ4vyx0VrDwFXR2HQsah3st85hEfMV3otxznSydYHG7Mh9gq?=
 =?us-ascii?Q?04jedgoRHmquFiqM6e1Wdz+iPQhhtMqfgs/gmo87v6rTRsRsWtqmeokHYZLU?=
 =?us-ascii?Q?OEAY2xbGlD1k5D5NW7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMnsaySWv8wdUCm10Faoac9x6FHJkcKY3Qm9RCsiVt8TF6dK7zOBxhFRP7rx?=
 =?us-ascii?Q?VZord5YsdK+SnVc6iV6qwlpD/6+1BQ+6TdqcVDBPTl5Ju/16otPFucOOi9V7?=
 =?us-ascii?Q?bD7hRemtgiE863Cf+e70t/mouRV760s6bSYZgxnhaS91xOQPcdf4iwXGxAwI?=
 =?us-ascii?Q?rPZAbrYy5eKs/+2cLk6UnTNm6ZF5lQ+GRMIELl1Af4s1I9qCQY4r4POO0wMp?=
 =?us-ascii?Q?XY50lITchz3mpPBgOP9u63g6CkZouRkcgp6SFcVsiZkmD9ZawxO1pbPAbxi4?=
 =?us-ascii?Q?5DfmfOzWUhCe4CgdchrgpLOYsyGX0fisEKHvEqWEt3BExMr2qA0UDwhA85aw?=
 =?us-ascii?Q?AFzEUd44nkY4eHQTdVwQDmUBP/5SPkt42mndYNzVBSs5MKosaRFRaxjge3YL?=
 =?us-ascii?Q?Z9NUFfgU9MMQ3W/ZayDotMoNLsm/LGh+vXS5bhNIln1m7/Zqj8x1MyQ+gls/?=
 =?us-ascii?Q?rUqsHcx1qPgZ9nTDLoNuuxA554dpD13HzANWIUXGZpcUJHDt5FRWa9C9y94L?=
 =?us-ascii?Q?TIOBdBcqIVhyspPHq+vskX5+gHUv5Q9PWWbmKs/sZ9bzN0GrkYEZCvzHE+gG?=
 =?us-ascii?Q?k+1490F+9P+C4DeQl6AoO6PFSW2h7jVYEqql6+A6V4iLW+N2yvdZFXBxNxkd?=
 =?us-ascii?Q?ms51C9q7U+evi1blIYt6ksILqOQc2u+qgJV/YbduayeZ5V3TaeFiBJBLXxY1?=
 =?us-ascii?Q?jPr4h5VG9eHpKsjqxnsdMqAFZ+oDGqPyFeL4gs1HQznoW7ZTeuYzlgmTjlCC?=
 =?us-ascii?Q?CKESMyjil5XxyhtsdDstYuDU/aJSdHQVgRhGo3d+U8Cs8b/eovpqSXERU3BC?=
 =?us-ascii?Q?uzyYC5hJzpvJ1/eHJ/f6wLouxYWpSht0+AVZu6P4n8GKo3sQ2lvTnwD56IOJ?=
 =?us-ascii?Q?TTbZg+jpkGfcqQhvukeTiFnx+AiSokD4k2V5h2eLA2Y+qwj2Hbys1j77gqVO?=
 =?us-ascii?Q?0fx2NOlwnaqOy6gUkLLN7jfNYqX7zUd13NVd/ms1vW+eBFt7eWwtwCVbPqMg?=
 =?us-ascii?Q?XQ2wGBclHjC7GXteNXIIJnWgfAYdlGXuFi8mUC8w/aYpKYkBfkFWJzYbEeqK?=
 =?us-ascii?Q?MQSv14mFIOVE53r7Q7EMVqAV4R9OC4TwR+o1ZoNt4EgEqD4B2r9UlZDljgv/?=
 =?us-ascii?Q?0WvjkdxCch3isXOZclBEP6KrWYCQDodEVerzhyZ9bXZa6+ayOCtKb7u/apSS?=
 =?us-ascii?Q?ciF64PT6mP4B/4/jROuFNir6haRtBXE9iPkVM/7Gu1Sx9M57waAd0MM6oLlM?=
 =?us-ascii?Q?q+dbu1WydF4eb4n1hQv2TZLfTlyjM4EPOaHhBL+icZtUKJM5TlWdNP672ZE1?=
 =?us-ascii?Q?xzATEsAeCbhWhWuPAbSrvj6y7hCyQKpR3g/EAdAVJchVz7XUWIX4lv2PcWig?=
 =?us-ascii?Q?GuaUB2okaa+/tzwEbF3nEjldWA6qJFOdYfM/Aor3IP0Z/nqSk0eG4Bl2sXoM?=
 =?us-ascii?Q?zGxe9ZG01WduKzSlm92ztLSNy0P+INqTF7pzC1R8tM/KJ/AzBE9IK3OarJ2r?=
 =?us-ascii?Q?r9sbM4E1pvaT7RUGX+jWBVyDpSc46UEcUSgJcVTAl9H/905aPXhKs8LtbeDB?=
 =?us-ascii?Q?tIpf/IWe79HEgfesEbUyLeSCMPHEJTwGSIs4jjS+aBJ7/VwzIf9dbSjPzoeS?=
 =?us-ascii?Q?avZzQ7oJ2cQDTIMAzpFoEsGZecKW3G/jzN6LzU3qBGzdyabYRpHvQGmROG1Q?=
 =?us-ascii?Q?4+GaKv5IqK9CdHjSSwtnmuczzeZJRgA0HAt4ZONAKL4+jj6X7j/JRvnemmQk?=
 =?us-ascii?Q?Py+UtP13yq/bbftF+re/5Gy0Vce35SP/Sl5kktn0GkQnrYSdFN1P?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 628de6d2-4ce6-4f0d-037e-08de5d56570e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:44:14.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMoMceFrQiCbLf7x06rbiQo/46nRbF7o3RTYuNae+PcE86b0yS4k4ZpYDdlY5wPL6vC6kIGaCaI/occxAbmuSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6346

On Fri, Jan 23, 2026 at 07:07:48PM +0100, Niklas Cassel wrote:
> Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> restricted to run pci-epf-test with the hardcoded BAR size values defined
> in pci-epf-test.c.
> 
> This code is shamelessly more or less copy pasted from pci-epf-vntb.c
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This is useful, thanks!
I've used this patch as a dependency for my series [1], and it works fine.

Tested-by: Koichiro Den <den@valinux.co.jp>

[1] https://lore.kernel.org/linux-pci/20260124145012.2794108-1-den@valinux.co.jp/

> ---
>  Documentation/PCI/endpoint/pci-test-howto.rst | 16 ++++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 92 ++++++++++++++++++-
>  2 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
> index dd66858cde46..71975721cfd5 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst
> @@ -84,6 +84,22 @@ device, the following commands can be used::
>  	# echo 32 > functions/pci_epf_test/func1/msi_interrupts
>  	# echo 2048 > functions/pci_epf_test/func1/msix_interrupts
>  
> +By default, pci-epf-test uses the following BAR sizes::
> +
> +	# grep . functions/pci_epf_test/func1/pci_epf_test.0/bar?_size
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar0_size:512
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar1_size:512
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar2_size:1024
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar3_size:16384
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar4_size:131072
> +	  functions/pci_epf_test/func1/pci_epf_test.0/bar5_size:1048576
> +
> +The user can override a default value using e.g.::
> +	# echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar1_size
> +
> +Note: Some endpoint controllers might have fixed size BARs, or reserved BARs,
> +for such controllers, the corresponding BAR size in configfs will be ignored.
> +
>  
>  Binding pci-epf-test Device to EP Controller
>  --------------------------------------------
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index b785d488c284..fda257e46920 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -63,6 +63,7 @@ static struct workqueue_struct *kpcitest_workqueue;
>  struct pci_epf_test {
>  	void			*reg[PCI_STD_NUM_BARS];
>  	struct pci_epf		*epf;
> +	struct config_group	group;
>  	enum pci_barno		test_reg_bar;
>  	size_t			msix_table_offset;
>  	struct delayed_work	cmd_handler;
> @@ -76,6 +77,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>  
>  struct pci_epf_test_reg {
> @@ -102,7 +104,8 @@ static struct pci_epf_header test_header = {
>  	.interrupt_pin	= PCI_INTERRUPT_INTA,
>  };
>  
> -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> +/* default BAR sizes, can be overridden by the user using configfs */
> +static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  
>  static void pci_epf_test_dma_callback(void *param)
>  {
> @@ -1070,7 +1073,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  		if (epc_features->bar[bar].type == BAR_FIXED)
>  			test_reg_size = epc_features->bar[bar].fixed_size;
>  		else
> -			test_reg_size = bar_size[bar];
> +			test_reg_size = epf_test->bar_size[bar];
>  
>  		base = pci_epf_alloc_space(epf, test_reg_size, bar,
>  					   epc_features, PRIMARY_INTERFACE);
> @@ -1142,6 +1145,87 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	pci_epf_test_free_space(epf);
>  }
>  
> +#define PCI_EPF_TEST_BAR_SIZE_R(_name, _id)				\
> +	static ssize_t pci_epf_test_##_name##_show(struct config_item *item,	\
> +						   char *page)		\
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct pci_epf_test *epf_test = container_of(group,	\
> +					struct pci_epf_test, group);	\
> +									\
> +		return sprintf(page, "%zu\n", epf_test->bar_size[_id]);	\
> +	}
> +
> +#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
> +	static ssize_t pci_epf_test_##_name##_store(struct config_item *item, \
> +						    const char *page, size_t len) \
> +	{								\
> +		struct config_group *group = to_config_group(item);	\
> +		struct pci_epf_test *epf_test = container_of(group,	\
> +					struct pci_epf_test, group);	\
> +		int val;						\
> +		int ret;						\
> +									\
> +		ret = kstrtouint(page, 0, &val);			\
> +		if (ret)						\
> +			return ret;					\
> +									\
> +		if (!is_power_of_2(val))				\
> +			return -EINVAL;					\
> +									\
> +		epf_test->bar_size[_id] = val;				\
> +									\
> +		return len;						\
> +	}
> +
> +PCI_EPF_TEST_BAR_SIZE_R(bar0_size, BAR_0)
> +PCI_EPF_TEST_BAR_SIZE_W(bar0_size, BAR_0)
> +PCI_EPF_TEST_BAR_SIZE_R(bar1_size, BAR_1)
> +PCI_EPF_TEST_BAR_SIZE_W(bar1_size, BAR_1)
> +PCI_EPF_TEST_BAR_SIZE_R(bar2_size, BAR_2)
> +PCI_EPF_TEST_BAR_SIZE_W(bar2_size, BAR_2)
> +PCI_EPF_TEST_BAR_SIZE_R(bar3_size, BAR_3)
> +PCI_EPF_TEST_BAR_SIZE_W(bar3_size, BAR_3)
> +PCI_EPF_TEST_BAR_SIZE_R(bar4_size, BAR_4)
> +PCI_EPF_TEST_BAR_SIZE_W(bar4_size, BAR_4)
> +PCI_EPF_TEST_BAR_SIZE_R(bar5_size, BAR_5)
> +PCI_EPF_TEST_BAR_SIZE_W(bar5_size, BAR_5)
> +
> +CONFIGFS_ATTR(pci_epf_test_, bar0_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar1_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar2_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar3_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar4_size);
> +CONFIGFS_ATTR(pci_epf_test_, bar5_size);
> +
> +static struct configfs_attribute *pci_epf_test_attrs[] = {
> +	&pci_epf_test_attr_bar0_size,
> +	&pci_epf_test_attr_bar1_size,
> +	&pci_epf_test_attr_bar2_size,
> +	&pci_epf_test_attr_bar3_size,
> +	&pci_epf_test_attr_bar4_size,
> +	&pci_epf_test_attr_bar5_size,
> +	NULL,
> +};
> +
> +static const struct config_item_type pci_epf_test_group_type = {
> +	.ct_attrs	= pci_epf_test_attrs,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
> +static struct config_group *pci_epf_test_add_cfs(struct pci_epf *epf,
> +						 struct config_group *group)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	struct config_group *epf_group = &epf_test->group;
> +	struct device *dev = &epf->dev;
> +
> +	config_group_init_type_name(epf_group, dev_name(dev),
> +				    &pci_epf_test_group_type);
> +
> +	return epf_group;
> +}
> +
>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>  	{
>  		.name = "pci_epf_test",
> @@ -1154,6 +1238,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  {
>  	struct pci_epf_test *epf_test;
>  	struct device *dev = &epf->dev;
> +	enum pci_barno bar;
>  
>  	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
>  	if (!epf_test)
> @@ -1161,6 +1246,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  
>  	epf->header = &test_header;
>  	epf_test->epf = epf;
> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
> +		epf_test->bar_size[bar] = default_bar_size[bar];
>  
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>  
> @@ -1173,6 +1260,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  static const struct pci_epf_ops ops = {
>  	.unbind	= pci_epf_test_unbind,
>  	.bind	= pci_epf_test_bind,
> +	.add_cfs = pci_epf_test_add_cfs,
>  };
>  
>  static struct pci_epf_driver test_driver = {
> 
> base-commit: c0dbaab0524adbc90d693aa15ab84354dd71acb2
> -- 
> 2.52.0
> 
