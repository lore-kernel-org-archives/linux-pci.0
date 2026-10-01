Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83335E956;
	Thu,  1 Oct 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893698; cv=fail; b=rJYOize7e7ioUgn+6WDPoC3Kqa6YNFolJpIk8AGuYLGboEdW28ahzEI03TeZtg7/7ndSGtzBrjwJZapi7YJCt65LekTMv6HQgXi1eIm6s0aZuOgW2Mt5M05UZZyjFHN4IQ0N5zTHl7JK86fJyzCWiY/xWzCRQizhItYpCdZ4EyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893698; c=relaxed/simple;
	bh=D9/uKPcBeYKPzJUa5TwFlp1TQAzTumH4QOwYMAckPCY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jgk61GnjqzBC5ai2J/+6YwILw+UVwVbmGU+3RU7iMs/1y+AwUAzG3I0VY/xNPhzgvz8LFi61iVe1xZ3lV3CQIbCljdJM5C1LV1E1dtyJErtGraF1847RnU22Z+clgBlBFTmRdxUsZSZR4vVQI8uadsw7U5Lhw+lX7+AWne+YenY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fPX48cBs; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fPX48cBs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQXKjUL916vLlIDBkpvHfxA7jw7Y7ClWVuJ3grXsoYtt7YKg8DUezpdS6upEKc3eeJxR8Dhgl9cRmphLqoeKGHMbuQIDbf838d5NT0Kuh1JNjzTT6UostrCWnyya+RZxzHGZpytQ6T5OpQeiqLaaVZTPcv/hpafsze5sj3wVfsD4J0vStbrPtAL/URrmbkTy7PDO1mpAToFjCA2nvi4h55XtlFP+htjlTyBDZlS/9dKqKt+wkgwZllcmS5NqgohfgwMmTqJMCDLnc7fQH4S5CTrOsHUV3wW94/j7OHCPsR55mRBq06TLO2Ul3aqrBh6HmopppaD3sze/jyE+HQYBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ0agkOFDkWquXx9r+t7KdvdRTnQPJZcnAMpnJ9KS6g=;
 b=cfvkp7UPZuprsFlGPLSmGFdT0FjLWMBIKEOVlQsza6tO3exxqiC0VwGh0Fh4oBexurrDcQ/aODoWGkbK3DKHWenH+fit76daWwI8MzCixXd6VpVVn+bYK28xuuDJYkAxcH4BJYI1OdrGTEhKoC4+U3mx4JynLohAnZliY+iwhWlceOtVf5AuUY7l4kgqPzSTviPR6yHgIUQWTcV6w8XxrDjq3sQ395I5HzzqgjaCns7kArvbUBGBcz8Gc/PMej5HCMxgaDzjog4JtrM7gpxEJs/ZQJY0Muz0GgsRgddcJ4Sk/wGETRuY/WtSa4kGwm+WKcUyzZZBZeWv205hMB/LGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ0agkOFDkWquXx9r+t7KdvdRTnQPJZcnAMpnJ9KS6g=;
 b=fPX48cBsMQ9eo2Ax7d/PRUXbmiQfOiLhgBp8SFqh6aMpOVIBV/P0y/lp/Z8Sd0SD/sO7TfrwMXLCT0zUOV9pQORZpx/VOOvYDB+7peEU7WCDiWaIIyE3EdLN4X9C7hT87vv5cgTj8KxtAOSQkZaaB448DAP84Ljjep3elng6paojHk05QfHVmCOVBPgoqFIEhIeSJhxspC1JDzdn1ffxcBM5aT6oJwlziK/nYcJ/WsXSY5oV3sLWLq8zqleAe8xAfvXCxlM5JkVL7+fAKrvYnqyNWpPzKTfBJuX0mbmc1ay2vEJVgW36SdMAfhuU7KChaJcue1faKIuGbA6bepWpwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by IA3PR12MB460542.namprd12.prod.outlook.com
 (2603:10b6:208:709::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 22:28:15 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 22:28:15 +0000
Message-ID: <2faad56f-c433-4627-86ff-a98af620d7c9@nvidia.com>
Date: Thu, 1 Oct 2026 15:28:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
 <20260924022228.50fac1ad@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924022228.50fac1ad@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|IA3PR12MB460542:EE_
X-MS-Office365-Filtering-Correlation-Id: 899c99ac-515e-4d45-69b6-08df200b48db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	jB8k1JiQ/ZJNuaDqls6GxAV0Z4lwCgreR8hOrFUqHC9aDq/uSUKZJuywAxGL59yXOrPm+RO5KD08k6Q9IzhB/8O8Wj9oRJCpEcXIpKhHUb3JwZiqF9lgw5d7vHQKJxWM9CylN6JXB4Wc/73/MerjXkLqGeT8PCoTzvrl2GfP+MPjWfjvqINFeTGH1yex6YWn+A8GHnehKMFD4x8jJ6AYNzQleeYuK/qcZka6h0fii4dCc9qtEeic2iOsrU3EsymaWCWp+yFOvWC0/nZMFs3NiGRVwknOAXMO5zPzoCo0i3CbMWWgLZn8odLDdoXH4ZBBcsZqFe1HiRGwwlvipLcUzAuIT/KIBjMSagKP9fzF5LctbQCXIIJmfAr9Dea9q/GujtuasqWf9efyW60bWfHL1cUZ+0DInRIzgB6k/qYCzOVM2+ks/CbJugAFIsLZH09glOJ0QZDweRzXhnvqVyXIFnwTTDMfrYMzyUCjhx9Aqn3eUdi4ieLAcC7GRTtatSkr5IjjVWx/pvRN4i5p30aqtfO5rWMTLK7R09r4m4ybnJLPiP8v8pp3k4QblZ1oD+7peOjsRjv0Vb1V8qVFrh8bEt/s5sKVmgfGfWguEiLiTvs1/+LZ6K1haX/mbaOePXTsC7FV4pjw+LkH3vtijib1VvHL2o+EiG+1SZGZMUG978U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1nUlh4Q1I1YXhlOHpDWDRmY3lRdHVvTWZUMzB3OGwvaDF1YjJuZ25qbTYr?=
 =?utf-8?B?Z0RkVkMzcldNOTNORnZ6OC85VWY3dDN1eEZFK3lBVFhabVRjd0hOTldMWXZC?=
 =?utf-8?B?TUpudzJ6R1MxQ2g5TTBOK1llVG1kTjBSdHlRdmRuOGYxZjB6ZjcvTTFBdmdr?=
 =?utf-8?B?V1VvM09VRjdQMVdhL3dGWWtuRFhjWFNYNDdWTEdlWVUxZS9NY3J1RThrSG9a?=
 =?utf-8?B?QkpJY1E1YmZHc0lySzVCSEFYMG81VkFQU3NlaVEvM2hhWXhURmpsQjJSSVVJ?=
 =?utf-8?B?QkdtUVl5b2N4Q3B2eFgrblg3UkpzaTd0RFNTaDIySzVtQ2hSZlV5MTVaYVh5?=
 =?utf-8?B?cmJBUG5keklkOFZscXBwcnFuMWhEY1pSQ0hxWTdLNEhIMzZJK1lBWnpGenBB?=
 =?utf-8?B?T0NrNjkvbm9maHU5TUhieEdzRGFNZ0NpK1JOckJtRlhodFFWUjQ4b3hJTkNh?=
 =?utf-8?B?V09DUDIrd3B0OXVKNFJ6MGRaM2NPZDRyWkUvRnAzSnV4NEVIaUJwYzVWVCt6?=
 =?utf-8?B?dXRkUUFuUzJyQlNqandVZ3BRV3NlUWdMTmhJQnJ2Y3Vsbi84YlNBa2d1ejNQ?=
 =?utf-8?B?SDJPM21GOFRkd0t6b291bndobk13NE5tMU9LTzBJNFpOOFhiL0ErMmxVMHda?=
 =?utf-8?B?Ykk2Yzh2dmhzbVpnOGxCSHZmZHEvWExWTnZVeXpObWJWVVhMQVBYUTZxMmJF?=
 =?utf-8?B?M1dKWi94YkVzdnRqaktrUTJsbmpLZE12OUEzMEJEaS85VmJaSm1Jck1vb2JO?=
 =?utf-8?B?V2xOazI1Sm04ai9ITVBPdHN3a1liTjh3NWtrS3NYM3JrZTlEY1V6QTVTdG8y?=
 =?utf-8?B?N2VoNU53UHJsUnhYa2ZTQXJ0V1NUTndKSWhTTHVKUjFLeHZOb0JqeUhMMTlB?=
 =?utf-8?B?RS9pcmgrZXBWRDBpdE1GZnVoUitHS28yY1lJYnU0QkJTMlVqYlRkQlp5a0Vk?=
 =?utf-8?B?NWJIY1JEQ1VQbEVEWGVEOWRBYkwrV3I2dHAxZkZOTlVUaTR6Y3J2RVZmSnRw?=
 =?utf-8?B?SGVqYVJaYkc1QkpmMWRseXA0WUxEY1hTckNLZFFZZzRTdHI5RUtQN01ZMUhq?=
 =?utf-8?B?TE5XbEZ1ZEcvcnRYYUpWTWlMSGNvbFR2RS9ndkJNVHhVajlWSm8xQ1VvTGpF?=
 =?utf-8?B?VXJaQThzU0ZFSTJudFNPbXdXc3Y3dnMyUWRVTVB4OHI1ZGZpRkxheTA1VzBh?=
 =?utf-8?B?QmtVQUZCZjY0VjlWTE5zZXpoMTEvc0NkVlRobWI3M0hpSmFXNzVucTVFT0Mv?=
 =?utf-8?B?Q3R1Qi8wbitDWm9oVm1wR3loMmFQQzRhT3IxQ2tQS1lYVWlvRGd0TDdXMVNG?=
 =?utf-8?B?Z1VGb3RTdkE1Vit4UzN4aE0yMS9NMG8xNXV2SUVYNXBXVTQ4T1FIR2ljSm1y?=
 =?utf-8?B?YWZEaitoSDVXcSs2Qm1nTzNaUnpDNHMzZjZqYzhkYlBWV3l6djZqNUVYTjNO?=
 =?utf-8?B?Ym4reDZ6WmZYa3hzNjgyQ3BxWXh4WVYwakZQWWxScTNmaitjbEVEQnFCZDVD?=
 =?utf-8?B?Z2t4QWFvS3FDNHI1VG9JMVo3aTlDTXF4WG5PdUhzbEtaRHpOZlZNNVZJMXlx?=
 =?utf-8?B?Vit1VkZoM3NXNXhLcEVkd3dQQVlQYjhvWm45Mlo1Q1UxcnUvM3lJcVFTMVV3?=
 =?utf-8?B?WUR3RktiTnNFbktiZ0p0L3pyOFRHUkZMNG1XbjZsajdpV1ZpeHlGOERVQVpW?=
 =?utf-8?B?TnF6ak5HMGRGUjNuNi9oNnR0d1c1R1FDeHAwRU8vK2tOWkJFRFplKzB2WHlz?=
 =?utf-8?B?S2ZjdWQxSWhOMVFldmtaZVE5MlB0Qmk0cmllRklndm03UExDNTVrblg2ZW5v?=
 =?utf-8?B?Y3NKUzNiMU13SUhuY0phaGdTdnhkUVltSW5ka2xocTlTMXJjVXVwd1pLZlpR?=
 =?utf-8?B?SGpyNGxxMjBacjJKUDhDeUVNN2psdW9nNzFTZHp0cTR0ZXRzVTh0ZS9zQ3Zq?=
 =?utf-8?B?cUJJd1E5blQzanhsMUpCclVuWm95eU9jZ2NQTFhFNnV2cE8rQjNPQkVNZmFH?=
 =?utf-8?B?OHl0dkM4WWRvUm8yWCtQc2tPdEt1WU1QMEh1ZC9GQUVVa244YjBIclpwZVgz?=
 =?utf-8?B?RGp1R2tENkQvdW5WYnZMVVFjaHVNdVAxY0dKL05GSDZuQ25ncUlEcVUvV0tn?=
 =?utf-8?B?Rk9IZ01PT2hKMFY2WEpHM3ZQZHJCcGxYK01EYmVOOGZnRVh1b0VyUjJkWlhu?=
 =?utf-8?B?MTIrOENyQXJSM2VDTVRHRFJQRWFYY0VsVTBWY29XMEM2WTRMNWZITTZ0QVd5?=
 =?utf-8?B?SmlpNVRkNmVjQmt4NUdiajRTQlBSQUZmVHRkb2FYMmNKdUxwRWZtazIvOW43?=
 =?utf-8?B?bzd2U1BGUTJPbTFJMmVOUWhqNERPbXVEeGNWcXQzaldudnNZNkNXUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899c99ac-515e-4d45-69b6-08df200b48db
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 22:28:15.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSjx60TRLrSpq7sgLJlllh031Db12f5EXs1VsiMoV3bTVvGdYBOn3u0Gbz1KShZzFkBvksL4Xu8Q39bpKxhqgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB460542

On 9/23/26 6:22 PM, Jonathan Cameron wrote:
>> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
>> PCI device to make caller ownership explicit.
> We don't need that here, so maybe briefly state that you will do in
> new users coming shortly.
> 
>> Signed-off-by: Srirangan Madhavan<smadhavan@nvidia.com>
> Assuming this is the only instance (as Ben asks) and you do
> what I suggested about not having the good path follow a goto,
> then
> Reviewed-by: Jonathan Cameron<jonathan.cameron@oss.qualcomm.com>
> 
>> ---

read_cdat_data() was the only existing instance I found. The helper now 
has two new users in the HDM cache-update paths later in the series.

In v14 I duplicated pci_dev_put() at the early-return and error paths, 
so the successful path no longer follows a cleanup goto. I also added 
your Reviewed-by tag.

-- 
Regards,
Srirangan
