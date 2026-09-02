Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEB1DE8BB;
	Wed,  2 Sep 2026 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310363; cv=fail; b=bb42tbxBNkHc1AUa4iA+jgOqM1xu7UE9YQVcCRzfzU6u4UJl81Kzg8mrB608rRdKwDWbXoUX016vub8er6XqWckApqKTJkU4mt3wdxJQyOqRIQlDCF+D6O8iR+YI2d/XOL6jW2nlBprlbVuzV90kSyEFMqsILymjcCK0RfT37xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310363; c=relaxed/simple;
	bh=N85LDDJFYSEWXkjK5VcDYx9u07Ohqb2VIyAEdcfJxJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T71v1uJ8HjOTtJMmY2CoajQc7ZMJutqWBQ3o77aL44qDGIkEGT2/Pzjh7//aTvzSnJwgg2d8HW0qRwJ4Ui3XrImg2kEYpkDSUYOyeT8Hm1QsWdnshJbuWCN/h9gQJIg6kIM7a1ehA8DmsLWt3QsUTryTSm2UATWSKqoNokdByOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHmqXQhl; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHmqXQhl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkKZjLbmi1e/7Kc70AgYPXc29+inHQ16tdBVUAaCKbemuNiUQsXq0LuZupuPd/mlj0p6jAnzRuGJp4XPmvsf445q86j7PWigAYgDnYRG0gEI8tjVbBWa1erXRsRF0HuGK69KXQ41Kuaw0zCLhilmP8ld2hgDCIbpQTQvNmmoeuxLTLkElAZ24jxHNwB9htkY6o6BNZOVKszmltN70WWkRgdjpe/7mMI8Zv+nWtv3ZGNLXlE6wJkjrVuGf63AZ9SGzRz7CXs/uBZy4ddhU56rjIJi1iEAWtQEHOXpsIebxaSIeJF++/ehI4Gke7eyY61DLF62Wla4i2txCK5UVjGWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LV81+QR7CpKEkCTP8iBpEMBO++6yK9HZWXAlLSz460=;
 b=MKuVn7PMWEoadERTC2C4IKYYFd7q8EuGYX9o8wxHO86vaE2XAGfOduDV+XPNuq+v6go2sEOCD85GRhYLohm+CH5K8mbvzYmnyKVHNakxqYaWLDMUlllDlGSHfFd44HQPHVDzlDY8JKb0BrmSsgoq2D1lm9qVckZA6k6HfxJqWHrqodRaczoXsFjGIaVmHzRsDFSTaS4nYRra0p/T0b9uqu3wPg9qZ9yQaxQMFZMycgt6BLSjkxpBMkOaRbko12RN+2PzXlhh6+KqoZXepV+f4ggSGF+CE3VaudXsEAb3J3wFVblABxx/Dc3Yq6KMy/XNdimaf7patKQgJrnjIaSAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LV81+QR7CpKEkCTP8iBpEMBO++6yK9HZWXAlLSz460=;
 b=fHmqXQhlScyMFfA0bD2npTzaeQYXJP7broL985n+uiTlDjUWCuLmcdKNxsJsB0czST42hHjtblHsZoELm3h+cEQA8go03oGyRlTXXelfajF7u3wYNVUCyFYd0DSp9/lkmT9mNKNyR+Ki7vqLTqz4tR6aG6k3CRIurey5jgBjqwaty1E/a3RWmBdQuECSnObAduu31z4IyAG9kA6+Fo1Re1dzSxBmo5Vx+j0IWihlnZGQYJ7aVv9jt0L8JpTeDcjkJFMPDXdbegsswK6xW3c4d2Tfm9DoXs/CC8stsaEx6GUmkI/X2xAp2TMqHuoUGtxOZj0r0jH3QFHvQ0VjwZSU1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999072.namprd12.prod.outlook.com (2603:10b6:408:354::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 00:52:39 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 00:52:39 +0000
Message-ID: <74fe9eab-5dc6-42a8-957d-abe45595b497@nvidia.com>
Date: Tue, 1 Sep 2026 17:52:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-2-smadhavan@nvidia.com>
 <anKcSN63nh3CgtEQ@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <anKcSN63nh3CgtEQ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999072:EE_
X-MS-Office365-Filtering-Correlation-Id: de69e7e0-83c2-48a6-2339-08df088c7cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|10067099003|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Iif4mXc+0GRdcLCxjPL42qFVzBC2ukg5Y8mjsS2WKGvJzP+qiNo6zVZA2qnf+xFyXXYufm+6jX9u9naLuxgREwFWMYmRXuONNwv9Yb9RImv6qtvQou1hr2pNBHZ2/5ArBdZcsD2hnF0zDdOrP1f6/hhJPqp7sXO0NBT+VPY2EfJeDFfAXOXPvlWwjXZvZLs+yFFfOiC+7JOLBLQDWWDpmJEE9GuEVVTiGpGhJBBsjPFzAc9Xw/ABz9EQ2LxpcDrYjXfv/jqpMbSZ8F6ekSsqVflkrOJGGz3GiyVBaM2X7U0QNVNFej/Sy4HR6CEjZBfav6t3LR+ECnUm26NuzuQeZLlctxnjCxQ0BNfAmIED70kr/61FKacWIgvML6TCC4pdQY00Dd5j7DpMmXSzpAvWQY0C92c1LbYyIs9Ejamtd5KGuMVIYu8XYoRayePVoSnMpbXyPnKv6G2uc8W+HmUadhO0YkVOFtsitajYrLzwofdRO+vESUIpBMn72f6GvFsnEDtFrShHucJzD9UE2V4uFAGf9lXJHBLk/NlpzZYGK0r7Wxe5DPzm0YB4bRMwlcuy+MY7MEMC7Xzuq4j3Up0wgaFHJNGLIG0LH3xqMhZaDkNVwbu+zikCnMxA3fJmppYLvmfK2BPwLRg6M60EGDpIAXkrD6wb0qf1mYBD4NLJYEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymk0N3VzSVBJck9Qb0pvTzFxMG9UZEY4ZENNb1ZYTktyaFo3VEJmejgycWY2?=
 =?utf-8?B?SmdtWllETldaVnlxOHQ1RVNNRVdPZ1l5R3NqYXB3N1dQd1RreWV5STZoOUc4?=
 =?utf-8?B?Yjk5Y21WK29DSlZGS0loMHNiWnZXUHJKQkJBZlV4MFFFWU1NaWZFWDZ6ekFt?=
 =?utf-8?B?MWRyb0NYNWdCdG9kZWxCQmRuMWhKVGFHZWRjME5rU1A4QzRvaCtsWFhTdTlE?=
 =?utf-8?B?M0gyYlo0QmdsZVd6aXlvTU5odjdIRUNqTWIvSzBNK3ZpZTNob1RwRHVCcmpa?=
 =?utf-8?B?aXFDT2ZTL1hnSVJVcFNtTEo5NS9qZ3pCVlA4ZTVvZWlEaXRsS0phYjNIcitB?=
 =?utf-8?B?ZXlWRlZkWmt2bmVvL0l0R1N4Skw1N0JMSGNtdDlEV2xPYWR6LzVaSHoxNTRY?=
 =?utf-8?B?Q2h3YmFKY21WRXpuK1hTQUFPcE9pSmN4eTNPaGl4VmhPRm9qZUJnc1hrak9m?=
 =?utf-8?B?SkZTZy9QOTFhenFBUGFXeERYa21LRkdIODVTaExaUS9qbTNGM2liSDBQWTFO?=
 =?utf-8?B?K2lsZG9Xak5vQlFlU1h6QnFwMnBsaVVVMm0ydjcrMjlpZGZTeGFWeWFrUkVl?=
 =?utf-8?B?SUxtV1k2RERxY2l3TDNWWVlsU1htTGZxZklTbmkzUnBhVkhtSXhTRTVoejdQ?=
 =?utf-8?B?OVg2emtJeGFPaVdING5vMktkZVZXQ1krTVlnVk42SDlmb09kSUFON3lCM3dD?=
 =?utf-8?B?eEdka3FKWldnMVdEOUFUWXZJMlo0dzZsV1VMZElBU1lncDBuYXVZTmJobXcr?=
 =?utf-8?B?ZVg5VU9IeDZBOCtVSUs4bi93VzBHd1VuMW1yTUxZVzJ0ZVlGOVN6TGlYakxB?=
 =?utf-8?B?WFJDcjRLNnVnNE9mTzZHZWUzK0o3bDJRc2dkSzZvT3pHL0o5NWdsMlR3YVhu?=
 =?utf-8?B?c2tmNWg2SlZSUG9xVFFuRmpKVDRUZzlreHRQaTd0OGl5ZnhzWXB2WFRTNE5r?=
 =?utf-8?B?dkFUZFR3TDF2NG1kSDZtNWdNK1NWTHl3U1hlNVJhUjdtS3hISW5qbXk3R0Qv?=
 =?utf-8?B?MWN1OGZ5SjZ1VzFSQTVTYmhkMWZaNXVPTURrNGRZU2hRUEIrL2ZkK20xNWQr?=
 =?utf-8?B?M0Y4SGFKMHh1OEFwMHN1dFR1aG85dERvNi9hYXBhUTljbHl1dHIvOTBITjA1?=
 =?utf-8?B?SXBzWjltcHRCcmRxdldaendzelJBRjY4YUZwa3kzSytKdHZ6c255WUJ3Z2ZF?=
 =?utf-8?B?VnNoRXBBbmNEMzFMbjRsUjRCMDJKSW1pcVJsUjNKMmlYMVZzMS9jQTF2V2xX?=
 =?utf-8?B?Qk9EMUgrWEQ0RVgreDl0RlRsTEVLQnkyUFM0djFDMVdzcEtuNDFLMFBTRVFm?=
 =?utf-8?B?MVhGRHoraDAwenArcm9haVB6ODhoTThta1FnNWZTYS9XQzl3UUZBdlI5dEYy?=
 =?utf-8?B?UWZNTytCeGo0Yk5xc2R6dld0K2JwRXc1VTRRZ1VHSVk2azZHTVByWmdkVXJt?=
 =?utf-8?B?UHVLL1NvdmxVY0Faa2VPRVR6TDgyMGpnQmg2NitFRGhIbEkzMytLQTRiVS9P?=
 =?utf-8?B?N1ZhUTcydElSUzFzc0VCS3ArWDhRdXNrT2loNnk0RHFFV0JQQ2lBOEF1bFBB?=
 =?utf-8?B?N20wZDJqNlQyVUIyN1NOMG9rWXBleGxyYzF6VGc3MDNKVFNjNHdQY09PL0Z2?=
 =?utf-8?B?c0ZTVVNSbW4vVjh2VVh5eXRJSkQxb1VtYkN2VUN4cVh6dHBUbXJOeFpqUmxF?=
 =?utf-8?B?ZHFQNlFpdWdWWlF5ZWJHZEtUbC9LUmt0RVJ0WkpBMkp5bm13MVhidjZKZFNO?=
 =?utf-8?B?Y1JNYitTaUZzbHJZajg1SG5jRk5XVW9EQXRlYWl3MUo5Qzl0bFk3MFU3a3Uw?=
 =?utf-8?B?b3diK21YN1V0cWYzajlTZlJuLzlieDZGaGRzSnNhMXYzT0M1YzlnRlZ3Q0d2?=
 =?utf-8?B?eVVIWEpKS2F6djBRUm44Nks1RnVwTUtGc0xBR3U3Y3JtTWx2Mmx5eWdjRDlQ?=
 =?utf-8?B?SjZsRVFBUkVEbjNrQUowYmtsZnRDSmZQMUZjTURSL0JubTRFTFFXblk3S2Jh?=
 =?utf-8?B?YXpUbkhUTVNWSkkwR1JwUThCem05Qkx4SkNYalJ3bU9jUExyR1F6KzdVd2Rt?=
 =?utf-8?B?QWVqOGxVRnE4a3Bac2hETytibDdwcUEyTFRkOEQrUHQ5OVZRNU5mQmg4NlB5?=
 =?utf-8?B?blcwNll6bHluZEZGUWtVZ3RyNlYxdEdoMEpvWVloWlB6SnlRL3dJRGRSYTlQ?=
 =?utf-8?B?UDRGR2liK3BpamwvT3NuNk11WG1Sb1l2WEN3OXpZTmRjYkdrT3pYRDMxd1ZP?=
 =?utf-8?B?enhNV29aMTd6NjhwVmZMdWhxT0tJemRYQWJXWFFJcnEzdHNrTGw2TTJBdHhR?=
 =?utf-8?B?QnIyQ0FlWml2bGVpQjVGZFFHSVFxb3pmV25BZzFhMWlQQlRBZFBZQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de69e7e0-83c2-48a6-2339-08df088c7cc7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 00:52:39.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYiodO2OrcAylBubXrrpengjdH+WH9fBmpJtF3RZo6b1D5ZtuylFuEx6JNakVTR35dXCQ7WWy6tiTtK1H+9oyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999072

On 8/4/26 7:13 PM, Alison Schofield wrote:
> So, remove from tools/testing/cxl/Kbuild below.
> 
> To catch this, run the mock build after any change to
> drivers/cxl/core/Makefile or tools/testing/cxl/Kbuild:
>    $ make vmlinux modules
>    $ make M=tools/testing/cxl/
Hi Alison!

Apologies for missing the test build. In v11, I have fixed this and made 
sure `make M=tools/testing/cxl/` passes after every patch in the series.

-- 
Regards,
Srirangan
