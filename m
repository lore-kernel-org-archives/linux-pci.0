Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013081.outbound.protection.outlook.com [52.103.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21938328B43;
	Fri, 23 Jan 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133052; cv=fail; b=g88b86aZnqExvC/8pR3vvUp7cLggy8fyDjMzoae87FdRMJT7tsOrxO+HukzX4gYRCiCaehBlqdZlcrZQb/S4EiwoTc3KAtHNw3tSRQOdWETwQxo5U4nD+AUCpRZyzV9skXWLO60riEdDU9VsvuXg7pNsf6cAE7edpQSd8iUFpOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133052; c=relaxed/simple;
	bh=5MTkE/MfgrCpkj1Rm0GHGRD0Bcf56Qa1MPNPGX9an7s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y4AOR1tHLs62i70Bcah3uLkWaZ8mwZmsMOkI/i97f73PhnITQ39/km020LHbTLLvneCQ7VzY9KqR5KtSUeA7P/cNdJRTQYm5GmntO0TcHXNLarzzkSJrs7u5BHDAdNDDmF36Ep8yF/M8yz+uCh3ifZA8TcGd9GhYy7mhVomstjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=UEMR7W83; arc=fail smtp.client-ip=52.103.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="UEMR7W83"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUgCXfnZ3mDJvJGSzUUs8ASm3hmwTPfzgaGgcm8kcuPJP1No32vESwofex1/4IVweAmeTKgWNHnUnCet+vGuWaEymdzVtBbmttv/zdSjJBuO8i1fHubQTmseQSLy3AjjrLD+K19Cbjlt9iJKra7A2gopnkwyaWrvkdWDIBNFM5X9HXFgN9P7TkzzMLxD921r7EzGFemjO4jN2fTjzKpSEpUjUvDy9+Sqv+HOEj6Bcdyq3lBNzjjPRKHMZpNQTzoELJbYo2Qa/9ufk1PkWf/yiDrkMdJK18pDmFhWqIYD88SMEmdO9ZSv8YDTVOaAKuMqYU/sfKzIAtXMSNLldQTNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NJA3MQA5I3wQ3PEw7nhr++SlYJAT+vitWFZJLu9Wqs=;
 b=Gujxi7P8mkrGWeONjJCzCqmb+uJqz10JucpJQBciSK5rfez4uYQEIzpjEv9UiVDm/vGYmHERCHUOurR1xpdh1b4DtrP5Iu5oPak7VzG4cWbh6NsAu8niP6+TdHjD79gDc/ge00kea3dH/7IS5HDgyREpgWPLaH8DPAR1fqMRMFcPBrPnzZ4Y2LRJ9TxIRZin3OfnaLleJMZRvLDadb+RcPXdOpbhCCAVswixy4CDabODG8Sb4EiVgaglzHBvRF7qD+rPWaJFrtGjyqRt8uuMMz3SWldvB+L3DbTRVO9RQk8N9ONwERjGJ9CPRZKzbUb+H9D/Xhfobpo8OjrN2viIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NJA3MQA5I3wQ3PEw7nhr++SlYJAT+vitWFZJLu9Wqs=;
 b=UEMR7W83d/f4M0+Bmg7pNOGN0sS4frmHLTUPeVS3yslv56a+J6SA0dLoN4y87rZa3zVr+u13OgMzD+wpOYzhPIvfUfqkN2sNDsZHZ4W+Vh931TVIlm3Uj3jXUMjw4CW/fGBraePHAlNkQojyrxPB+K+bg+FmbXsXZmL+YoAA+XPRXlU0WWY3wLtHHpsm4rkfIzVBTPANCmpLVDSoodSKrKh+wuOdOWaLFPAMiJbBC7zWjG2B8SD/eYT1kNNAWeVa1xaGcVum2fPWajEiLgvOvUdp+rymjKjcFLKWt5UDOAoogBTYrEUcyGVlINSoo/7oUDQuUqKX7/86yPodCqJRjQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5198.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 01:49:56 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 01:49:56 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v2 0/2] PCI: Add support for ACS Enhanced Capability
Date: Fri, 23 Jan 2026 09:49:41 +0800
Message-ID:
 <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260123014943.1311157-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|KL1PR01MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d637c7-5cb8-452e-1785-08de5a21b4e4
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SpLJQB2HbV02gEHmJtp/Q2dmSNe1WJCFgfc8ocuU6Y3RgRz2FCB77cCWGJ75zLjfAXAj8LtDm6vn8Hqi4Gx8hIfWXrXsxQPVe1ojceAoj5bGYcwhusYRvAUIE0d81EfE/MhC6RnrguY4P1Y4XKoCun7MHiLJuesKSnoM9okWswZ/IpXheZ0PbxREQv4UJ3M/vWA84GFzaZVz6RN6UFFIXWDcE08xMbe51gL6q91dOZb5ll9dPAl+pVhCbI3BKdcblk47dhTOecXJA2Pfacg1sDe+6sDFd9hW8nm7Ufd4SRiufmca+bOoqcohu1Ttiv2ADZ4G6O0BhN8ypJE/h4pIGKBbbRVQH5QNxMSBAOEJLK/w80sYolsEOaT1ETk9GffqAY5NaAkbLLfOW2FO/jGGvygboW03voxHtOGzoMKONHjBzNkAC7c9W2lD6OUpWDm11U3TNGC1TbBnvzk6Xq6zPPsN9j8yaQRqlsfS1oB9Z+jbl2mCG8cLNZFR569umsvNE2HKGrh5mNuu7U7cLO3aUeP1MqYfOQzkYeJT6fp2qOOHepKL5dsaDx6x+rC74Ha1nnUTErHc+8ErZs+RREh31GYyiY/wOWXopUT4b5A2JySNF/wrMuQ1QDW2seTi2Pmq5Vu3tSu+wpCCz5cmJjKV9ZfgH6YnyCayh0B9kr/vkqxTzRxH7y4IRnGQLBpsTSPyD9Lab9b61M2htg506/YBiwwzsmAYT6SaqDNJEnlevagI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|37102599003|8060799015|12121999013|51005399006|6090799003|461199028|15080799012|5072599009|23021999003|41001999006|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkFhaHVWTVBna3FyZksxQjdUVkZFTFBaRUlKM3JKTGJGaEtpVmRHd0wxekpN?=
 =?utf-8?B?V1kwOUlwcGp0dXYyaW1Rb0pJZmxHeHZUSllVWm5VMFNXaFNSVzhCY0UzaU5z?=
 =?utf-8?B?eWVES1BNVGk5eEUrbVN1QnUzbGpFcVVzRnJvWUFESTErM0xKczJZYU01cDNY?=
 =?utf-8?B?aDZ4cFFHSW1tOWlvME1YNWk0VlNleU5JYUxKR3pBWU94QVpIbDB2dkRmVmZt?=
 =?utf-8?B?cVkxbXRoQ2dDN1hINjF5M2RmMGtUZzAvOG5zYzRWWFhvNE9XbWpvUFRPSE5w?=
 =?utf-8?B?U2FadUdMRzAxOEJqOGVwczZBZjRXdVBOOWVGcVNrQTBGbEVoMzljamMrQ25H?=
 =?utf-8?B?OXJEZXR4MmtER0VOVWVZMmR4QURZeWc0UDFySWNmSXo4ZE91RnNSdUV2OXky?=
 =?utf-8?B?L21DVFRuYlBIdytJUEVBaUYwKzA4L2xKbFdqL3E0RlJwZjh2WDhKQURFTlhK?=
 =?utf-8?B?VDJQSnp5VUMwQms5TDVDajlHTzY0VVJLOTd0SDc3d0tzUFR5UEdVRXNLSTFN?=
 =?utf-8?B?OVEydmhES3lWRW4rdDV4cHRCZ0ZuamJmVVhLSWpteSt0TmE5VzI0R1NIRjBS?=
 =?utf-8?B?Zkl3WnRNaUtoSEdCSXVEdGhhYmptVUxHOTg2OE5hbzlGenA1Ukl3UVVocHZ1?=
 =?utf-8?B?eWhWQ1pEQ0JITkV6d0tVU2tvZlMrejR2OXlROVhkOHdHeVpWMG95V0RVRjNq?=
 =?utf-8?B?eWVxRTJjSlNUZVBRelNZYWFjcWRwVXJKb29ja3RKREF0ZVBzVEwxcnc2M2xN?=
 =?utf-8?B?SW0rVDFZeHB6QnpoZTdWYmVXbExKMlVNV0N2QnRwam16M0VLZnhEQUx6TEJa?=
 =?utf-8?B?ZzJUaWRWTENvckRiSG1rTVVsZ0JDSGo2OFFhSFlQZGR5ZnlVTmNLbE9MdmEy?=
 =?utf-8?B?V0NxSXhvbDJpaFZpeENEemUwakZ0OUs2ZjN6MFVWZzBRY0pST2U4dEQ3YWhO?=
 =?utf-8?B?d0orOW9DRmoveEI5RkM2RkZqeHNubnlLZ1o0ekhGTjNSd29wdmFBOG5NN1Uy?=
 =?utf-8?B?SGVoVDh1TFpoSHluUHBJR2tFdEh6TDBWdTdLSGRhTDRlcVYva1ZQRk11U0Jt?=
 =?utf-8?B?cC9QUnlsWmhLNUY5UHpXZnhNMTIwNkVwdVp0NkJOdEQrTTh4ZGhpUlBYUHda?=
 =?utf-8?B?NlRsU21RM1BNUmwydnQ1RWxLQ0FTZEdFOUxOalMvQUhtbDVXYVA0bi9LeUZH?=
 =?utf-8?B?NGxiODcwRklYNFpVYU43Z21tbHpOVUNoV2o5YkIra29BSUpxb2ZVQW1uVmtX?=
 =?utf-8?B?ZEhyWElVQUVQa2JvckFqekdGTXk4VGU5SzFrYzhsTWZHMk4vaWc2WkhrU1lw?=
 =?utf-8?B?eEM5bEd3YXFVVWQvZGRGaGpXaXZJbFR4RWUvb1hEMW9RM3RxaGVmWDRFM2xk?=
 =?utf-8?B?amQ1bm5qT2RicWJ0QkxaR3BITWZJMDM4djQ0R2liWUxjaCtudCtmKzRnUW9C?=
 =?utf-8?B?cTNFbUs3U2pVZkhOOUJQMWpySzlHaFpVdXdDTGlUMExMY2tQR2s0RXlIOGlx?=
 =?utf-8?B?dDZZZU8zVCtleHFqemNwNzQwLytZSFNCQUEwc0hrU0pqRWJ4Y0p5VHdTdTZ4?=
 =?utf-8?B?M2pNZ2ZWa3p5QlV6cG1JMXJ0c0pQVWIrdWE1WkZSQkxNazRSZ3pyZmoxOGhU?=
 =?utf-8?B?ViswQzNBdUVWUElSSUpiaFQrS3RxSytoZG5ueFdrdThyNmswQ2ovM1dOdEZx?=
 =?utf-8?B?bHovL0xSa3dlSTJ0UEUwZDhnaFBZdWloS29TNzE0U29IdUtrL2RlcjVYRkJP?=
 =?utf-8?B?SkVENFZtQ243V0NrS3hXTkVwNXh6OGNQMzRHRkZ0aHNBWmZyZWFzblp0T2Yr?=
 =?utf-8?B?R2poemVlcDNDN251U0g2dz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDRSLzFDWWVxNXRVZGtwWUdmcnEyZFdkNHZVNStlOHdsSWU4SllVbGpUSkwz?=
 =?utf-8?B?dzFxanl2ZWdDRXAyNmpDcXBNcW80Rk9jV0U1aUYxbjhna3NLQ2hva1kzVVFk?=
 =?utf-8?B?blAvYmVuTHFkSnRkR2svbGtBT0JqY3JYeFU1NVFPL09TUWhxK1VvK0tuU2Jn?=
 =?utf-8?B?ZWJJdm1UaEtiaU0yQWk2MGk0YjVucWpzeVdYSlNDdkFleS9mblQxWW9vQ3lQ?=
 =?utf-8?B?WG9ZeGRIb1J2em5oU0R2VHlvRnVHanRVeitRNHBRNVNCZ0ZyWjd4a3QveWNY?=
 =?utf-8?B?NVNUWVhtRWZoT0swbENWQ2p1REczVWoxeFJDeTh0aW9MS0xzQ3NIMzBJN3Zk?=
 =?utf-8?B?MGxESlFBWVB6TXdQNjM3ZkhOeFZhK1FQZktlVVdYWWVhTkRpOS9meUJHYyt2?=
 =?utf-8?B?WWhOdERFN29MR00rMkMySGM0Q0lKTEJpM0EyOGNMTmJvYjYySlBYb1U0MkJX?=
 =?utf-8?B?MHBoZ3A4ZWd4OVc0dmREaG93cHppTlNra3RPMHRRRmlIRXVyUk5oY2xaTjNN?=
 =?utf-8?B?bVJWT3A2OTJmWE0vamVHQnJZay9nSk1qY1lTK01WK3Q2YWVGa21XaTJ2QlZE?=
 =?utf-8?B?NWYxa1lEaFpHZXNBNDcyWGFKdEE2TlhCaW5TU0gxYjBqYnpRY1J1ZlJmbWNo?=
 =?utf-8?B?eHBqVnd6alY1bnBBb3dwcWVRa2Nmd3VXR3pFd0Q0NWVKR2ZDeER1TEwwRU1X?=
 =?utf-8?B?RkFweTJOR0gza3c2SG44dkpNdFlIYitQSG50NVpKSG9GLzl0c21oTmI5QnRN?=
 =?utf-8?B?S092MWQwaDJNK1BwZEFJTnBlMlZtMERaRUY0dVYzU2UxODNzem9jbnB4WTN2?=
 =?utf-8?B?eEVCWjNNYStQUDBSdWsxRnlORHhHTytNOEZ5TUV1WGE4ZFVzdGJiZzhrZEVy?=
 =?utf-8?B?MTM5M0RLS1FPMjVrR3hOQ1dQYnRya3Q4L3E2L3J5OEtmaTRybkFEVEN5Q1Jr?=
 =?utf-8?B?OVhQSEthSU9LNWNoZTRCZ0d1R2hMQU5yU0N6a0ZJWkR1azhKN05UaWxLRGh0?=
 =?utf-8?B?MGFpNUVvWnpVekpRQzFUelFkaXZjbG9hTE56OSt1L0NWMUVISWxnVngyTmFW?=
 =?utf-8?B?RHVEcU0vRm5qc09HZ1d5R1lUSFNZL2tENjRhdW5hTmJwZWo4djFDbjhUR3VM?=
 =?utf-8?B?dXdFa0VaTDF2emV6TE5lN3dpc3hxS2xFZ0p3bEhpU2hGS0pXaTVLR0ZkNWh1?=
 =?utf-8?B?dndrd0dPUWdEejdSZWdtc0JkaFZiRXpNTmFiTi8wUmZQMFBseWZGUEFyOHVW?=
 =?utf-8?B?Z1Q0WlJwVkNKZjZJdUtUMzVsQVpRSGJWMmFCc1lrVHNIR3grS3Y4eWs3eDBU?=
 =?utf-8?B?RU92Rk9TOVQxK2k2R1BYMXVoWU1QWXQrdEZoc0NyejRrYkl4ckU4dEliYlVM?=
 =?utf-8?B?TTJrWmVzbzhhMUZpK2prenlGOE1pTDd3MElIcGNXLzlCTDR6M3FtbHR4dXNa?=
 =?utf-8?B?RWdwdDJobCtaL0VaYllHR1cvdUdaNFRmK0ZOVkxub1Rwd1crYlUrbVRKM0h3?=
 =?utf-8?B?QWV0d2dsRS9CUGdWcjJGRTdRTUduMS9BTldrUjR6dzZIbnMxejVmN3hUcU9N?=
 =?utf-8?B?UWg2bU9DSktsdkRqNmxDR2JPOTFnY29WT1dPTUpGTklsZENRZnJaak83WVow?=
 =?utf-8?B?OGhwWS8vYnJXdUZuanNmdG9keGg3VFEyU1NaQ2NXYmU3Z3NqZkVJWEpRdWQy?=
 =?utf-8?B?ZXJyMGdkMCtwNGZyUzI1NkpnaWt5YmZTbEVNYzNHSWtjVExxRTF6N0lXVFhL?=
 =?utf-8?B?VFdKczVHZEJvaDN0VGozeURNMmtpUEJ0VnlWRzdNS2RDTDF3VGRrMFJLK25u?=
 =?utf-8?B?QksrZTIxa0NHZWZuTE5EZ1VKWFhDVHExMjJsMXJaM3cxUGdGZnpPWWdVMzNE?=
 =?utf-8?Q?6/g0CafxMXZwy?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d637c7-5cb8-452e-1785-08de5a21b4e4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:49:55.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5198

This patchset adds support for the Access Control Services (ACS) Enhanced
Capability, introduced with PCIe Gen 5. The ACS Enhanced Capability
provides additional access control features that improve device isolation
— particularly important in virtualization scenarios where devices are
passed through to different virtual machines (VMs). Strong isolation is
critical to ensure security between devices assigned to different VMs and
the host.

In Linux, device grouping assumes that devices in separate IOMMU groups
are properly isolated. To uphold this assumption, the enhanced ACS
controls are enabled by default on hardware that supports the PCI_ACS_ECAP
capability. As with other basic ACS access controls, these new controls
can be configured via the config_acs= boot parameter.

Support for checking the enhanced ACS controls on Root and Downstream
Ports has been added to pci_acs_enabled(). On devices that support
PCI_ACS_ECAP, these controls must be properly enabled. To maintain
compatibility with legacy devices that lack PCI_ACS_ECAP support,
pci_acs_enabled() skips the check and logs a warning to indicate that
isolation may be incomplete.

v1->v2 changes:
- Enabled all enhanced ACS controls by default, rather than just Unclaimed
  Request Redirect (which addressed the primary issue we encountered).
- Added checks for enhanced ACS controls on Root and Downstream Ports in
  pci_acs_enabled() to ensure proper enablement when grouping devices or
  enabling features such as IOMMU PASID.

Thanks to Jason Gunthorpe for reviewing the patchset.

Wei Wang (2):
  PCI: Enable the enhanced ACS controls introduced by PCI_ACS_ECAP
  PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()

 .../admin-guide/kernel-parameters.txt         | 23 ++++--
 drivers/pci/pci.c                             | 80 ++++++++++++++++++-
 include/uapi/linux/pci_regs.h                 |  7 ++
 3 files changed, 102 insertions(+), 8 deletions(-)


base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
-- 
2.51.0

