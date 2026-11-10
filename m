Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794348733;
	b=HgFYEv+7+MJPxHk0puBwV6rAMxFlTu/uZO/xgX2yNHfvU6HaMuCDSt3LyJUqFvtsG/om
	 PSNyp1eiEtzSHFklgSQcD67kBMRsSxcQ/oXH0qesVYJpWd6VtZh6KnPE7UzfU0V6IQslY
	 zv5yXpNI8KxIC1gWdYXeaTgMP56pc8geeDFV6H/4t7AFMhafYO4CASr0jc4LAzZIuNllS
	 jrpXvipOWXyO/NP3nAMmTyp/KvrgkeyAsPVSt5PpsFG0VvmO4uFZgUZl/RN3WVj2pFY0+
	 QTTxU8PqKhNiXc3S7I0vha0JkEiU2dgiVNxscfM96UVSQ/ekQ7868A9tu7cguvHJl+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348733;
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
	bh=upj4v1G+GNMWoZCAzECkLheYTECPRyUxxZaIT6rDKCU=;
	b=FTUMlTJ9X15CTBX2gqKbmLXsjSEymJo/vbgJOEusr/+1ms7Zow5RCOkknT8UFbg2LuyE
	 iNGgQ0OjQDhsz5xBN047wBY9+GGuHFlh4nCP86m+6AXgvjKUHCxVgmiuJ7eoRcVufirXE
	 jb1MSK7weg3TQoAlPhvJxiXm9rA+E5VILDNcg9o59IVB0+lGRqIp9InZX2341VPnESuLx
	 aoKLH3LLt1P0qZxN1OoOVGLvAZtLopcJLhzYF1ePsgcZ1oLOcIA9bm7h+7QNcd5zw93L2
	 r/nrlZtKvXHfzujvu6pZCfgfz9UoM8JNz1J/KiXeY8+E1PNl5G7v1+JyWZTVvojV3Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=azhLhz1n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.68
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63034606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63034606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=azhLhz1n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB0Vm9iW7qja0iNHR5+M6Hemjab1N1CNBTOC5083/F4qBfBZHSDQA6BzzqqFGTCD8F0z6uGOjI/9XkXkO/k8Y2kcP4dDvvw/QgMNRt/pbQJHzkrJyKAUXn9tRjB+uj4C7Hov8myIPHU14KzifHbaX5qShP6PV0ZAjczep4D49+ff4iQHwtohnrxTc/UC0g4sztZBOcDSdFxUwWHnmGv6KqSmF+AI4cResFz4gws8cbLAsKD75dtrd5jn7DU1rY0ssxxB6gtGkL8tv/nwEU+jBTZVJGojrdvv3DAAUugq8S+gKpjR/eXLMg9pNV8Hv+SRobOIIr1+4eL1JLKDxeZ8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upj4v1G+GNMWoZCAzECkLheYTECPRyUxxZaIT6rDKCU=;
 b=COoH2B44gk+PU60cU/4/QsZRmBl3lg4sN0akxUWe1K073Cel/RNITJb2Ym9BSUPCWMlDFMYCGJ9HeRDlX46orM/jaIaXBiOS8XaYzlUdY5ou2bLN4ZFaD1xlll3Pt6w/4eZttE+0jSoGNTXxI8EbAXEolHeoW2P+DShLOZ2Q+g4rqQKvvEyq2cU9ox+7wq9vaa6iCy/N6iYWOARQsb9I/wDQCFtPpELZbjZEYxR/kl6BEWitRlrO6B0lvcxfwu8GaIqxqUcM4a8jjIyUYLICuZklOjtAo0EtWY714karhg/isibawlWSll3omQeGgOgKN93BjJHdRf1k0/GrTSramg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upj4v1G+GNMWoZCAzECkLheYTECPRyUxxZaIT6rDKCU=;
 b=azhLhz1n1AanF33zRJa/qLxtBqA2xhNo4XQvHv4oS75WqcDXQs2YF9XuMIfPRMP+j2Xno34kUpOCBeBs0rUD4ob3ctyuY7ZZeUBzmwr3FP/FaVQBdsfr1bjN7kUgP5x9OdG6YLw8dSzag7vb3VWDdZo5nMuCY/8tOcvs2lIbcsY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by CYYPR12MB8962.namprd12.prod.outlook.com
 (2603:10b6:930:c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 22:12:04 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 22:12:03 +0000
Date: Tue, 10 Nov 2026 17:11:56 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261110221156.GA2031990@yaz-khff2.amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
 <20261110215614.3931232-3-yazen.ghannam@amd.com>
 <sashiko-outbox-207809@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-207809@kernel.org>
X-ClientProxiedBy: BN0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:408:141::17) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 63eae87e-1f27-4f6a-5f22-08df3f77a670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|261009223027099003|10067099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ALjPkTDTlVxum1G05Qbm9JY0FvTFnjElrEGueFK9f+RVcX/TCBFkIvaOh5gXWzbqeNDl9Z+z7Ja7hEj6m+rojmRXHcLGZg6lKSckKtmDb6AWtndiQTYCk+s7bY9ShfKzx9H0a4YVSZoMwivZheGPVYw/uaPm531x4Jvrw8Vsi2GyBl/5c663fIDizjjgbETYf2PEv8T4YVmR2ZU0AiSG9sFlYZepA+tndZFco0pvzlhdDuH0Nhcbb5cpDU2t/9M7U5bxqSKTSjwCxjHkcQkJRYafOmxVQR0XmVYF0gsZjSW9e/gar/cX89vxHHXjF9A2wQopxEyg0bE02Wr9tkH5V719bPxCNxESpuT3lf3EB39HA4TgwVPVTy/1p9VtsttZo0NMFZNXX3rTVD9hZ9Jxu5dwu1Aht4pEtrbW1OXfKLqFHdhjb5VtPu5jhPcvyKUonlXwRHF0vjMonLeGg8NgqdlOy/V5+oW1l0Z558y/Sddcd3TAtEAcS4UK4gdAtx2xt9WTe+4zyXTPwI/zy9/xRZ3P1Vm3ZD2t1hyWGQxQZZf4JBNVQKhOyWpf3jgNuOSUQjXoki8EcR29wo2oLBHmIMaS5utlSVX+fQkIPZWHZVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/7KyAd/LzPxLMCee54mSP1mqG0qMlzaAbO6mWU1/Ng/mA/diGu1CNvj2oIH?=
 =?us-ascii?Q?vsUNT/zMCSY5vQVLbx4x46DhgPbuE7CrYy5yGm8OHtxHXymZE9bf+5el+EgM?=
 =?us-ascii?Q?C95kxaDxKccptvHFSkhoh51N4FKSE55kI7s9mMrYwmW9/13a7ZnHthqZbJFg?=
 =?us-ascii?Q?6p1uOYTRfFD6JbNT5td0nXu1RLFDcpluWdDfKrDX4P/BEKIY0HHbxfw+Vfls?=
 =?us-ascii?Q?ENnNgR9w+qjI2urElnknmIIeXt+To0wDYoiQ8Q1o8xVNJKgveWVdg3q13J4M?=
 =?us-ascii?Q?eoZWN4WHdSc+WYhhc0yqqmDHdFVwJdzbMgDoa9x+ArS/xWHI2A7J7A1P/8K1?=
 =?us-ascii?Q?+NQzWvc7GyOm4EBbKS0fEtCau8HauIEt67Mg8xl8J9zXq0y9yH4CkaCzeSBG?=
 =?us-ascii?Q?4abYC1suGVbU/keMgU403+mdR763rT4obMVzUpc2wYO+egDIpkqC/xntDp/M?=
 =?us-ascii?Q?T5Zq7m3CsLTRo+ISI4EfiBBkkZeA5bbCMcJNkKKBfcuHWlJoO/aOG72F3IuL?=
 =?us-ascii?Q?KnkyUxROVp94LTNIJepH+Z7JKmVcl8XB/joUVN4Ocbg0SU22DiTDvC8ILnsW?=
 =?us-ascii?Q?G7/6ZOacx2UxF4fOVAAKAwjQWSqsyJYkozZZl9NeTp93Atnw5/JkKbay8jwE?=
 =?us-ascii?Q?cngEHTtJJr8cYMoe6cpDdCKdS6I89CnmztlANQ+TompvA05oJAV1HUgWQcn/?=
 =?us-ascii?Q?aiPLRQnJmwrrhGRlv6i+J8BYv9xOIWbb44ABd7/5pP9wu2HNhapkm1Em8UoK?=
 =?us-ascii?Q?gtHUebj1p41V7dJ8d5uW9XS/BuPJfi92lXthlKVeQBFon2nDcGBQZJqN5ti4?=
 =?us-ascii?Q?rb0SayZX22ehiBxAvO0srGK9cjMn//Qr4TsD44Sj6s3FaV92biQPuIW4Bmg9?=
 =?us-ascii?Q?jvmnJqaRh+DyzaCvzAkNrtiLvAi4tE/aJaGQzOfyi+vKdwusfzIJh1BrTNyV?=
 =?us-ascii?Q?sH0q4/05MUXkl5Xzh7743EmCTBgUyLyQa09+Q+z4gO1P/AwbvdPu9yMR6EVP?=
 =?us-ascii?Q?EdQ8tBaBLSUE3vNUTfVJrC9+zwjuCOU0ItN2tM2RoBbDludJAIBugA8Dvuc1?=
 =?us-ascii?Q?xYy/7ETkFywlsDC0ImLSDXwrcrBKLcIKG9mfYJ/oa8I6Tz9+ZTBNOeSi1YuH?=
 =?us-ascii?Q?5m6OmB1tBOg14509UrDSnuJFZ8/x86P4Ii9geNFf5Iv7fWapPMWW3u5ZlhKt?=
 =?us-ascii?Q?HAbUhw9tLt5mZnRquERBB7fj9RPqdXCSin+xTQqf7QhksM9yyjOsJ0+doKMQ?=
 =?us-ascii?Q?LomcYWrIP9MX+Oj2pJqdcXMF9t1iHE5zu38bu7kaNOnE2OUiDczu+lxc9RED?=
 =?us-ascii?Q?I7SypC+pwg/eeYVVQYf7PEJnPwSt+oV8/GmH2/xoGGxJtAplTUng97PrKEEs?=
 =?us-ascii?Q?fLfAqwXErqK8y3nStdN9Xq/0KNupY2eSWNbKInojlMov6V64Z9tK0si+Mg4k?=
 =?us-ascii?Q?O5WwMZoQ6gyxAgvTmrfqPnM0x1uBA9KQqi+a6u8G1zyhQ5ISueLnx6p2f2u7?=
 =?us-ascii?Q?yP7SNjAAcMchRShVwHa7uIaAFOVw4FcBwMarj2OnNwW2mFy7ciNwq0AUxzWB?=
 =?us-ascii?Q?fk/9enGuKF/t3OQ3gUyqgG5yGa89FT6LEWVNOzf8EMiUa2MclMnArmGKi7r+?=
 =?us-ascii?Q?7xKEaFKHBkJ1eGjUpRS9lPGxDbjnEOgWavWy+BNFa4fAgbuaZQiEo3+aT9a7?=
 =?us-ascii?Q?VYodfeinhBuhO7XhoXPx4egeP7l4PGcN6OFulIPskKWcYFS0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eae87e-1f27-4f6a-5f22-08df3f77a670
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:12:03.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FucJnOLlyYR0YRWnazwCqGe+fBDYVmlbl5VZ1T5yIZyX0ZE/A/hB1I93f9p3gAMNgn1aOvm7asffRE/iy9Bcpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

On Tue, Nov 10, 2026 at 10:02:27PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] PCI/AER: incorrect unit scaling in
>   aer_ratelimit_interval_attr() [1]
> --
> 
> commit 3e212613eb554aa7ec8ef93c898bf101c6bb444e
> Author: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> PCI/AER: Clamp negative ratelimit burst to zero
> 
> This commit clamps negative values written to the AER ratelimit burst sysfs
> attributes to zero and updates the ABI documentation accordingly.
> 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 6f24602314225..401cd3a1b3d0e 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> >  			return -EINVAL;					\
> >  									\
> > +		if (burst < 0)						\
> > +			burst = 0;					\
> > +									\
> >  		pdev->aer_info->ratelimit.burst = burst;		\
> >  									\
> >  		return count;						\
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but shouldn't the companion
> aer_ratelimit_interval_attr() macro convert pdev->aer_info->ratelimit.interval
> back with jiffies_to_msecs() in name##_show() [1]?
> 
> drivers/pci/pcie/aer.c:aer_ratelimit_interval_attr() {
> 	static ssize_t							\
> 	name##_show(struct device *dev, struct device_attribute *attr,	\
> 					 char *buf)			\
> 	{								\
> 		struct pci_dev *pdev = to_pci_dev(dev);			\
> 									\
> 		return sysfs_emit(buf, "%d\n",				\
> 				  pdev->aer_info->ratelimit.interval);	\
> 	}								\
>     ...
> 		if (interval <= 0)					\
> 			interval = 0;					\
> 		else							\
> 			interval = msecs_to_jiffies(interval); 		\
> 									\
> 		pdev->aer_info->ratelimit.interval = interval;		\
> }
> 
> name##_store() converts the millisecond value into jiffies before storing it,
> so reading *_ratelimit_interval_ms back emits raw jiffies instead of
> milliseconds when HZ != 1000.
> 
> [1] https://sashiko.dev/#/bug/linux-3e0972eb-98a1-4365-b40e-82736dd85f13
> 

This is fixed in patch 3 of this set.

Thanks,
Yazen
