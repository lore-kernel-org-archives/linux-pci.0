Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0A823DD;
	Thu, 26 Mar 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554780; cv=fail; b=CnGy25eExgwaLbpPkqcONVwy48HkoSd5ip05p6hFT0aiOVcr6fYLjXtDk+jqewA8RbPfDSursdsq99UgUloZ6A4JePD3zscsMti5fGPYjHSsr+oITTM1x3XkiXQ76fLXZ7xtrp8jhwnCWsgNHIe+zgm03DsDffrahPfWfGoeN+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554780; c=relaxed/simple;
	bh=z5uOcoN2bKdZD2mJd9JTyxfOrKCD0hF23ymnyyVr7nQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KfUKfv91EfXVBLJSjCagyONOjaj8F3LoCzOi4cAFzCyyhpwqML+nCF8ytJ12t4aINLA2565IBSsM5dsTaHCMaBJz8DTy5A4wzUE3fxkWM1iU8cKVIP0PN3RaIdycDUeSe7g3czXOBRm38M3b2eZC4eJiS9hAiVwr3wzzK5HLmgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pY/biIQu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l6Cgdn0A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pY/biIQu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l6Cgdn0A"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFtvbX2588352;
	Thu, 26 Mar 2026 19:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eZavOn9q5lCwJ8IrifsyVaTMtG/Kq3VLbjwownCqy2I=; b=
	pY/biIQu0OczbRrkdq8TYobFRuC1CuWQdamjWAPa819lwfykqguL7+xGjpuKlrUx
	3mRzXxVJoRp0+QttLoPdspxhsX0CPuUW4zRBfuQ08MkWc8Sv/LLdwpUtyRcOhCrY
	7qLkHBPIaQwKK4dh77RONh12tnLiDyB47IVJ+qRmU+I038VbA2HD73inJpKp0EJm
	0bsWBAwM8wBngMfdkLZzZfcPB5E17FPPEf9WYInamvIJOx6NtLGoZctcLCTgz/OO
	qh32plQEKJZPctu/alD1L5VNVYfNpf06U4pgyPeSttXErjyyW2ghBk+EhrvR1/+r
	HP4NIHL0GwEwkYEArRbapw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja8ydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 19:52:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QJUdFV038959;
	Thu, 26 Mar 2026 19:52:31 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsdkmrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 19:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8typ3WpSkIefeynVtyeuA+EtWyjffb8HIDRNDLg+JEti6dD7yRJ9hzL/B7I+0XuBZI2crgqi7PchylksTNDyRcCVBoj65/MGBVYZjoilCKgQIst0sOqZIyHenF0eyXe/dTYAHbjUBkgrPIemltjh1wC2Cazl1qKGg6aVmaocbOO/hH0ABeSBO5RRHWrq7o4XB02r3tl2t/f910NaJ0vuHFDSB3Eo3nsJfUk5Z1KGH0J8WHqLk+SMfIufantA+jNTqBKdglfaaHbIzK00UdPz6BlxmiokpvOA2aAaR4CiMcvCe6kFussyzzIZsX44wnoJDebjMbSF8AXgQpVpGnmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZavOn9q5lCwJ8IrifsyVaTMtG/Kq3VLbjwownCqy2I=;
 b=QVk53CkyYngQlsR5xEBVySmfq1kIbo95o4LCfiqZpcu3F0c2X4ufEsHsKFUNoPZC/T6EicXm7Q1L+kPsMJod0CLVkSftMeJndJyjVYIdOTaiVdP2/EPOP6cAH2/j6drCqSNETzXpsaSItLXYShZpgpgCqCsGerWZJTuk53LQUkEebm8cDLa12VnT6KFAWccAccbsAVTTFMKi3eJmgZpbmO+xgEh10VBUAKJlA+B7rnTEDtB/qlCRqy0ITLqZrHUlKDPahNtEU/gkNYx4TbHJUMYrnsc0AbAQq2I6AbqUW1YMvp2zPiIDcFZx8B6/2M4v8CblIDpeWbDkLVQ4x8ZgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZavOn9q5lCwJ8IrifsyVaTMtG/Kq3VLbjwownCqy2I=;
 b=l6Cgdn0AGfly1MZuygNRuaNx97dsTuJeG1vJQOF9OgFQOBMvY8YvMpnoZQAFRPo8MgSEIigXNkxmz7W7P1PppLSUKfxYIdX7DRxTao+WCYfSZSJs3FeDk7kfSLCBSBDUvY8Jgp2bxqkBx36VimA9xpYpoaEMkvilGl7GCoHujEI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 26 Mar
 2026 19:52:22 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 19:52:22 +0000
Message-ID: <b1645e3b-21f9-4d12-bcc1-27740e2231d1@oracle.com>
Date: Fri, 27 Mar 2026 01:22:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Matthew W Carlis <mattc@purestorage.com>
Cc: ahuang12@lenovo.com, ashishk@purestorage.com,
        Bjorn Helgaas <bhelgaas@google.com>, guojinhui.liam@bytedance.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        jiwei.sun.bj@qq.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        msaggi@purestorage.com, sconnor@purestorage.com, sunjw10@lenovo.com
References: <alpine.DEB.2.21.2602231829500.46231@angie.orcam.me.uk>
 <20260225014119.10047-1-mattc@purestorage.com>
 <alpine.DEB.2.21.2602252156250.34294@angie.orcam.me.uk>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <alpine.DEB.2.21.2602252156250.34294@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::22) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: bad07c0a-3e58-4dee-19c4-08de8b713205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2Jniw/4MGR3hGh4CF9asX3gS93oRqcwKQIG4fFOh3o2FltbsK3RwrPxhhpaI8DSpebZRGJlCV76LBgyg4a+ZYT3W5FCB4hcvJDEFUlxGUbWVwRcv2mRp/rERTIP69+02ddQxxYr3SLK859yAevKmTrcb5dOtwv/h8cUh+RH0zJonQuWbujDq/2fann2XWGI6yKIMsD0IqdgEQGJLaLMSmNIluip1xMz+BfJolvKfKoQYmnKe+1xZpHXfOpOGY1PqbFwEhx3jIFYiOOJVPyXx2Ka4G17wSpf8m9doLQI2X1FSlEvUR1fWNUTqSsa1BQl7gaDsfkBu5JQU764uNj0DTZIXHXpG6YC8PCZRELXU6VOBt6CQLJV9yfNO2aYyEViqfpOBPwsFxmMQUUQyEKZ6KhH+qrvQoAO2qNw19Nfo5zPFfZ47+U1NpYMOKb0BF8N0Sivt1f+9moQfvqk0P8AOA6iHbcYLHpA8Hr1RTo8l8r7r89P+/vvSPej7mr0EpunDwxh4ugkviO/5FIJm7F704zQO0Ukbb4NOFz0SSSOV9Gf7zfqs6BBFVEuVdRzspibbd8B1P57/Wg5ALaOV3sX0JoipUC+flQlij4PX9ZC5HNPTmpZmD/XdFalGw51IuzXIt6bT8U4/BfZeRh+o3XgoK5yhp01MMa+2MR4NPlTbW77WLljTX7cZH63RM+2GmC4QP2Aqe8eslmnJrNnms80D3LXoHpM5qa2OQwUankp8ulk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUtpNCtXWVM2TWtsWXZaZ3A2QkFtbEZsb3c3OCtCMHZvak9wdmhhWnhzaEp1?=
 =?utf-8?B?VWRlQng5NmE2VzBIZWRoNDJ0d0lVU2N4d1kwZ1JoblhYa2lxdFdkT280aDF4?=
 =?utf-8?B?LzhLcVQ3WFlsL1FuMkZTb1E5OGdnQmRLUWV6c2J3VTk1ZmNWYVc2RmJwUWJq?=
 =?utf-8?B?SEtJSnoyc2tlSXdzdDRmcC9BVytYZGhXZWpWTW1YQXdmUXA2UTBkUmV5VWdm?=
 =?utf-8?B?VklxaG5jNFZNTnZsd0pmbmJEL3dkb3AwQ090SzVhQmNhOE8yK29hbHBlbUFB?=
 =?utf-8?B?c3dOTkdiU2JibzVFTDZ3anFrZ3JDcnlZVFVyRit4T0ZFajdBVldRWTQyUFdi?=
 =?utf-8?B?Sm1JY0hYQlpZVWtXT0FiTC9vMGtaaW54RXFwY1IxZkZzZi9qeTNMdStHc25p?=
 =?utf-8?B?VFN2cUFLKysvOGRHd1AzMGkxdDBXNzF5OXl1eTQ2ZjkvRnFhaTQ2L0xMUks4?=
 =?utf-8?B?cUZJWUEyMjN1U1N6UlRuMWxKNysrSWc4dC9QM2grMGRhSUZyQjZnenI3NjZW?=
 =?utf-8?B?T3JMYmJFaDdXQlE3a1FTV2pkMEU2cmVnWVQ5YmhtZ2tYeXNFTnp1T29FUllB?=
 =?utf-8?B?L0cxRXRMbkVLc0RPWmIzaFJ1dk1MU09iRW1vU0wzTHhHcGlwTFc2dFdvTVFY?=
 =?utf-8?B?eGFiOXhBeHJUQURFTWYwK1FSTmhzekNJWHNyejYyMU1URmZ2ZVZlcDVtalJD?=
 =?utf-8?B?RktoV2wrblh5NU1aRnI1Qms0STlObzZLNmVWdTNHc2hBZSsvZU9NcGY0Yjda?=
 =?utf-8?B?OXlTemlQNXMwSExDaGNmRDJHVGJtVktmUjFoT2FDenRxOC9CTzdwSVdhWjh6?=
 =?utf-8?B?MVZyZXhBdzhuUk4wajN4Q3RGNEY2VkVZN0VMM2NYbEg1cStvV2pwL3NOTFRw?=
 =?utf-8?B?RTQ3NkVCcTBkSm1zMEowK3hIcFdqQnRjWEk4eUZJQTVGVm04YXFFQytXWUtF?=
 =?utf-8?B?UEpIM0h2YU9NMW5MODRFV0JlYndaTHlHTkw5Snl6M2tYWGFwSHBvdzhrTWxD?=
 =?utf-8?B?VHh2bDJmV3ViRmU1R0NRNlhjSTdraHE5c3p2ek9tRVpIbW9LbTUyZVNyanZQ?=
 =?utf-8?B?elJlOE1FczlEYUcxNnhtRW1iZHl4ZUxwN3diOWNqeVhObFpXdU5udVdoelov?=
 =?utf-8?B?SnZnQjNCdkVVbG81L1JsMU9zTjd4bmNjNXhQaWVWcXBhWlhDVVBLYzdpZjFa?=
 =?utf-8?B?MEtzVmZieWJZcnJTOVluRnNtbjU0dzZQeTZEOGpBSkEwWHhmeTBEVDgxTXY4?=
 =?utf-8?B?d0VmTzA1YkNZQk1kNk9SZ3ZpcGJWYVpieGpNS2tNcnZYR25NNG0zTDQrWGZJ?=
 =?utf-8?B?eERkc2ZEbzBvR0U4TlFFNmx4MEhtK2M3Si9ORm1MYzczb0VLZ2U0b1hpem9Q?=
 =?utf-8?B?RzZrUHpjL08rZ0FXM0dic3duTWlWNnNrRVB1NkpQOTBCd3VtV0xid1NDQndm?=
 =?utf-8?B?WkF3Wk1yNXgwMTRjaXhxeHJuT3VtZVE2NUVJRzBudXZsS2x3QWdUVWh5eEJt?=
 =?utf-8?B?LzlyWTZaYm8vUWVoSHlDUFByRFpaVTRWNDJVaGRJTGNyaXF4WmpXdWlwbGN6?=
 =?utf-8?B?MkpJbEQybllvR2h4RWp1TktQVDNuZ0tBMzRmWTlHTC9RU0p1bVV1aG1rb0Fj?=
 =?utf-8?B?RUVSMWRocmltbE1qcDMzOFFKTXdHMUVodlFSeXB5RnFIYlpyT0djVlhOMDd1?=
 =?utf-8?B?RzFRMXNieUNTS2xFYTdrK09YVThOazFYaUhpVXpYdTJ6YnJtbVhpRy9GdlV5?=
 =?utf-8?B?dGdqWVZSS1c5bmN5TEVKbHpLOGdkWUhGTWdHRjhuTVcxV0RKUlRsQWNLWXNy?=
 =?utf-8?B?ZmVOVXJBT2RmeHo2Q2dBa2g0NzR3VEZ3cGdmYXVHdjVvcDhiZ2Rib2JNaUNh?=
 =?utf-8?B?S1lmdERyRm9jZC9HcE5ZaTBucldETzIrQmZrVmRKenpyZDk4anBHUFZ1R3pr?=
 =?utf-8?B?ZTk4UzNYLyt0bzNUYTgvNmE5RWFCclBObkJneDltWmpKV2hpZ0l6ZXJOU2kv?=
 =?utf-8?B?VEFDNlhPdmdnQU5lWjFYUFZoMW5ZUSs3MWxXeGR0NFg2dWdldnhZbGxBQWJr?=
 =?utf-8?B?aVJiUkN2Q2YrUFh2WkhSUGRpWjhwT2hNSGFTa1JEUnZpU3lNeWdaM0NzQ1RZ?=
 =?utf-8?B?WXpZbjdGd1RWZ0Frb0RXWC9SMStkYmsrV21KVkxJMzVKRHQ3cGpPeFhtN0p0?=
 =?utf-8?B?MUNCUmdhTmxDK0xhNHNCaVcraCtYSUU1bC9VbVQwWmY3cThpNUViUFplVE5k?=
 =?utf-8?B?UjFPVDhoT1JXNzEzQ3I3c0ZYWEJraHFUdVVPaXdrMWNPR3FNUUJQcVhrOC9o?=
 =?utf-8?B?dWtUM1FoQk52K0wwS0owNWFBQ082Q1RyajFEc2RqN3hHNFBkZU94dz09?=
X-Exchange-RoutingPolicyChecked:
	HC1+1i3Udf+GR+CeVlfIBHbKNwuafCL3+tdmMnhROTiOTH0lwEP3PAq5Thl6gM63Hi/HAAY1CdIJYIkLn3jT7wA2krBgXd1s1yKv+Z4PIhKk4v5T2xl9veruFgJSPWZsr+t0hDa7YQbG97tGTDjjRNsvtmh5+arZgrlpuI7rHFvJV8qID8r8QJHnwlFZ2J01JQyr1gqphvInZxiXh6QtIzN8GEg3QMLktmoY/oGD02UCVy08G7tftc30zOfGRcrOntK/AMH+plWx4swhDj7ozrntiv1k8qvP315SWw0ovFnve2qmHMs59tr/GwRDsptP+b/urL0OrejRKCI+jvUf1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VBpgLGBM2X4VE1RFrU8nifERmuZ+8l4SyPpwPdOcqGVXHTJEsblMW5bKtbILWg/nUVesJoc1y/H0oBpMOJ9BCTghz16ccuykLL25rlsaHEdURFZ9xsA+bBGe6utRZTQkkmWRmoNMXQ3VsNovGHMj6E1lyQ1Ap5Ty58hl78FESQsvbtmdqABpSuaTrge7BZAkeUsGh3F7MplaApVBt0DMDMna6LWbciW0NyQIwF2kBcgL00bx4E3VfvzUIGeIyOfOnrFM8qfVgM50TPazGLq8DjAfPwRrAmVPZwxny1zFCvo1z5XOYVr4Hr6eBW9lwdH+o5i9jVXsQNqGTHckS4GyP0JS72J6fHLX/PWo5TLSduRkiP8SZwPDv+qTy4BMKLzc7JFV7J1jOIvN1aQlp0dqwV54kEGtOAhfxsiNgWD+5lZcRTFXaWJc88qNnUXNy8mNtDyGi5j+tnK7oKDdneWfaFbQYGl2rYJ8yEtQSnTaYp62J9t0+kHjWCBt+bdRh3XFOQ0T8OrP51BANvaMOxhqdZ8iDtb3H8TZqDspkt7E3xLGucz7g8aDc13JzYuhaprPojxhAtRtIHoSFNkTOBmaFTO9UHwQYXsiYBwj6KU0WIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad07c0a-3e58-4dee-19c4-08de8b713205
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:52:22.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYnCTgDzkJcBZ9yzWSUg36e4gQDF5MjO8G2WNFpT8xlvGtFfSefb+DCXah9iF6vhnlnI1wRK0EpAgf6XJNJTed3jgVjzn9OvnKlLEZyLF8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MiBTYWx0ZWRfXx24EBw8Ga1kP
 oUGUZokJXA/3OrTtEwI9H3qvnQ1I/qpePUggemRq84dwqCLby9ef/MJJ86bt6MNe5SXip0vJV2q
 6KifHgKOBiY2l+AosffXniaDDYj1ZSGDMlzYuRMQKyw2hUXhxsu/c5Hmr3wAwNk30ht12kaGUE1
 1kJMzR+IKPmm33cNcrxttSCukOm8UbKziJzGaI81HWJWooQF5qZjTTzxsbvWXv3WveDcI0rvwDN
 zx/415z4SBxsHIx324Z2mTPfKvZpUZ7vpONOey529B4w313gf9ObH+WJexU5ZuNQmVLBoKSfBiA
 Q9/2lIMLxd+jtVd6CoZ0RRKtzQ2fideIjrBpVJTjZ1WuY6biyETgw2zZkfP0VE5i9g48tVNpo8t
 9gngYIgU0cQryCBRgdyewr9DKXnTLJBb0E9PQtu37RkX9S7Md+7USZlM0LxAZNhzEvjYEG+owP0
 C1AcTGCAca3zO3JWWWUJLp7ZBV4auOD/tHJ1/ZxU=
X-Proofpoint-GUID: Ac2ELT2-QsWGP22PRAT2DTrgw_W8IsWe
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c58e80 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=SxJTYxFvO064oiAluOUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13811
X-Proofpoint-ORIG-GUID: Ac2ELT2-QsWGP22PRAT2DTrgw_W8IsWe



On 2/27/2026 3:32 AM, Maciej W. Rozycki wrote:
> On Tue, 24 Feb 2026, Matthew W Carlis wrote:
> 
>>>   I argue that by applying this change the issues with NVMe hot-plug will
>>> be sorted while keeping the configuration working that
>>> pcie_failed_link_retrain() is needed for.  Win-win.
>>
>> I don't think that what you are saying is true there is invariably going to be
>> some other consequence of this change.. Its hard to believe there can be any
>> changes to the pci drivers that won't break something.
> 
>   You're being sarcastic, aren't you?
> 
>   While I sympathise with your feeling, may I pretty please ask you to at
> the very least give my fix a try in your test environment?
> 
>>>   I note that active links are unaffected, so to say it's meddling with the
>>> link on every device is I think a bit of an overstatement, and reports of
>>> issues are from a few people only...
>>
>> There is no discrimination about which device it can be invoked on..
>> I'm looking at a fleet of millions of hot-plug'able devices.... I don't really
>> know if it matters how many people report an issue, I think what probably
>> matters is making the right change. Initially was there any other reports
>> of the quirk helping with other devices besides the delock 41433?
> 
>   No reports that I know of.  Please bear in mind that the failure mode is
> such that you need enough knowledge of PCIe internals and the spec to
> actually realise there is periodic link training activity taking place.
> 
>   In the absence of the quirk for the average user there's just no
> communication, as with a dead downstream device (and the upstream device
> is sound as anything else plugged in, including but not limited to NVMe
> storage, works just fine).  In the presence of the quirk the downstream
> device just works and I expect hardly anyone can be bothered to report
> seeing "broken device, retraining non-functional downstream link at
> 2.5GT/s" in the log.  It's only cases like yours that bring attention to
> the message.
> 
>>>   What outcome would you envisage had I taken the approach from this update
>>> right away with the original change?  My only fault was I have no use(*)
>>> for PCIe hot-plug and did not predict the impact there.
>>
>> What I'm seeing now is an overall confusion about whether a link failed to train
>> to gen 1 or was recovered by the quirk or recovered on its own etc... In my systems
>> I would prefer to NEVER invoke the quirk under any circumstances because I expect
>> my devices to work. With the quirk it becomes more unclear about what the cause
>> of a link issue might have been or whether it was even a real link issue in the
>> first place or some weird timing..
> 
>   I can see your point.
> 
>   However from your description I infer this is about a test environment, a
> development lab so to speak.  And you are a highly skilled professional
> who has access to measurement, test, and hardware debug equipment, and are
> therefore able to figure out stuff.  Conversely, the vast majority of
> Linux deployments is in the field, where no sophisticated equipment is
> available and the operator, if any, may have basic technical skills only.
> 
>   I have been taught that in the field it is more desirable for equipment
> to operate according to expectations rather than to strictly follow the
> relevant specifications and consequently fail operating.  And the quirk I
> have come up with just follows this principle, letting unqualified people
> use their equipment (this is similar to Postel's law if you know what I
> mean).
> 
>   I realise that in the lab you want strict compliance as this will verify
> interoperation of the devices you design.
> 
>   So I think we have conflicting objectives here and I can only offer a
> sysfs setting that will switch between the modes according to the specific
> user's needs, as the intent is not something the kernel can figure out by
> itself.
> 
>   Please mind however that throughout this week and the next I'm away on
> holiday (a proper one, as in alpine skiing), so my availability to respond
> or work on stuff is limited.  I'll appreciate if you give my fix a try
> meanwhile.
> 
>    Maciej

 From my perspective, the current patch looks like a positive step and 
seems to address the NVMe hot-plug concerns without regressing the 
original use case.

That said, I’d really appreciate input from other maintainers on whether 
this approach strikes the right balance between field robustness,

Given the concerns around hot-plug behavior and diagnosability, do you 
think reverting (or partially reverting)
the behavioral impact of the original commit: "PCI: Work around PCIe 
link training failures"

what is best way to conclude this issue?

Thanks,
Alok
