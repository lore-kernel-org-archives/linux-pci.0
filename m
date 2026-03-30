Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB43859FA;
	Mon, 30 Mar 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888308; cv=fail; b=Vn3iAY0GxGYdh5cGKlpAON2KUFBAvezsLgUhU2OYFj4Y8GN0/al+Gc0n3q1guoQI9RGui3q39PGyQG49wzhv//FZgna8yQjsg9YKlUAC6ajLXirDLQMU80MMCvMuaQt2T2mkB+DQC4T8iAvww0h+fAeC9xv2ni2uVVx9B2pwKAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888308; c=relaxed/simple;
	bh=AAiKzBZVaUK/OaJ+KuneH0CXnhG4Es5M4vGdE9VFjhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJ0aAnE7qhGjkCFNok9Cund3QeYdJvKsvT9+TmVQf8jSy6jBqhs0pTClbtuIsCCEohID7ea7VEwvmgojpgE9eENPEm++5VIGeeEi1NFOUhthVw8wWypm/8vVtveY99Cs0bcY4Mh2/Jvf+eYs+nfcJ3IgmMHWmTumgA2APYe/834=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hnya7NoZ; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hnya7NoZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+Wkqn/OVEtPx7yO7AU3qbafzxV1pEtNczpz5mBEeVxZxy7Z3Ycqvib8FnMpyP4JU3WqQX71H0RnsgYAHENlkR4krrKXu8e4a5qnztotqgl5amBp+f57XR+Dxyyj0qeFyX5BxfsWHdbmq/ZksoXG/tf1EH3qgy25Qstw9sRh/IRVCVFm1hnnBU2dWs7PszCf6GVLEJrjYCy+sNCAN8lOtssETeGd1lR6SMUUeZSGuxQeV74ZOaJyCHbV6DUA3s545eDL0r3+RmwEkGgdIyQV6tIPPdBHJB7vmTQHIQlujOAHILcnZsFD92or1mIv/f5tMwJtvnmH5FOF2i5ZNl3lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6MQRRkeBXwG+tOx1rJC8RmbkzP4ysWkxseoNz2o4GY=;
 b=UAhpf4GxCeY44nh/W1YlknqGDUxRkWM1KZcMiTuCsZ/fHTrRpCsqkvz2iRys1BjpM6fBgVfWYHkM2SGXfXR/oqKMrGf3RlAmTBGYGYAwEByCXx6UUKRrLngVAasVdyVl3NoaW+3SJRSiMGx7YxjBOJfN45dl6FpxBb5bPmEAlRG/6zjTeSVLOEaC01/VQCBVQHCdtY11czp41Dqc5Teq6ukTMV3y6o2gCfwS6WGCI09W7bcfaAiitNoi7ay7jnMhOZoiJbKXHGR1RuLXHkE1x9HFoBNtClBUtXF57lKfFCbMMdRv8fDKUey8zgHroKS9X/mNKGvuyvRDGxpmgrlUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6MQRRkeBXwG+tOx1rJC8RmbkzP4ysWkxseoNz2o4GY=;
 b=Hnya7NoZ7hIO2CwdRqQhaP2d/EXdT2fYZbWa9SVDyEcQeRLK/CicABKBeocnxG4PJTHj1W3IuaKzWLE303fG1OLayMu++scDGIFX7NYH8fzMdvT8z45yxfaglNdhzcHl9ON54XPXycuX/cXgSbELzlENeUkkj3vy4GRBpn9PKvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 16:31:41 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 16:31:41 +0000
Message-ID: <e840b60f-2fec-4645-95d5-27c14ae33853@amd.com>
Date: Mon, 30 Mar 2026 11:31:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/10] cxl: Update error handlers to support CXL Port
 devices
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-8-terry.bowman@amd.com>
 <69c9ccbc3d1cb_178904100cf@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c9ccbc3d1cb_178904100cf@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:610:56::16) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1f4f4a-c736-4327-1f7f-08de8e79d28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	NC3fG0TGZFKqGKXe/OTH+dtckpfQCPxbRHOHM+QhHyoyCy3lLuPaQyTEg4DmxO0t8eci3SphibNJ9QFl4xQicGqSxO6SFCfoGjCmudBrmb1iluFr0ch2cupOUGEXFngSgMS/FGIvYW0VF8c3pI7vf+6AA4cykUWNUiJ8IPPWbj2YZJcRd4XxwrWCUGd/EIaI//f8Oqn+GRjsbzCzDHc/M++SWcKRy2nqcWBnVI7LzF/AVPTD3u/c1ahE3Pur8xpAkWMmLvqm3Bsfu3mKjrsiPh3dN8InGjidSJla86UDtLurEl7vY9CIZRgeQKWCXC0gqDlgrX/S9mBFU+MybvXQUziGGxd3n0TlEIKsTUoubAo0fsghnQAKzZyuvx/Fk2jlhyRNFDp864VZb0kFpRPGzdp+6tVnAfy5ys5++qxKECqLHl7rD/qZ4OZ0gRfSkGXjLpYSC7tIYfo2xzYWv7Dr5Elxx14zKiF92286E/EfBoYaUTftA4az6wH8I2ljUFx5Ss1r0+9M5/QwK8sVuxaZRJqFel5qN6m4gDBktwHMblJM0/hD/Jr8mcsU3CuKY5PtaidIbu+N7kK/hdDYjNFcIaXkxcvNR6mEQreV6oO4pTL2Ksw8pjUxagurw5bjgXT4z+KSa38OeCmzFi5Gtfa0i5woHhPnUJj516LOkqtFQgQnZQ4RTTQ7keKL4J9an247v4fFBA9FtRRLsBrBHRqMKjkHC9xTBCuLyzT+VDAli13bstBbQIaqCAlwXZSFpZXhbw4A1M6yciamQkrjZ3L/XA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjNHcWpEM3c0RXhYRUpZSG5CRUI5UXUzMDdQY0JSdFJQWm9qcTU4ZmtEa0wz?=
 =?utf-8?B?RjM5WkhuNURjQjAxTzJ6Z0xnbWxTMDk5aTZhVmo1SVhNUW9OcWRzL290Rm40?=
 =?utf-8?B?emdDSlV3d3hYMnRGV1dTR2UrUlBxdVZWbVd4dXlCS3Y1SWZjcHhSWnl6VlA5?=
 =?utf-8?B?SnlUQjR4RnVFVWZ6TmdLeXRYajNhcnZBVVdiZVdmdUFUdlNPSGpRU3U1Sk1s?=
 =?utf-8?B?VW1jd01ucnpTYU5Fb2tqYmxnWjdGZi9VYXdFZTB0THZBTlBWK1dmOFVVNE1o?=
 =?utf-8?B?S1NOK09SOVRvTHFLdGhxK0xpRTJWVkNUbnZKL0QvTFFvcEhUYnZRQmVLWXpW?=
 =?utf-8?B?SGUzeUJSNXVwSi9UWmV4K2tSU1JzbWcxNC9RdE9YT1NtcFZzZFVBbmlpRHpP?=
 =?utf-8?B?QU91dEQyeEVTZE9qUkphemRSRU1vNHhyL0plK2RrelpRdzBXc0RKeSthMmVi?=
 =?utf-8?B?Y29tdG1zVW9Ob1dJRUpxVFNJSndBZnNEYWFXbFlYUW9GdlVwUFB3cDlaQnFN?=
 =?utf-8?B?MjdLWVM3ZGpVRTUzaDhSeVh1OHNxRElUdGh6YlJPWWVlT2Q1SnprTjU0OVY2?=
 =?utf-8?B?MHJHcDRMRnlBY3FmdkpqMGtmeGgva282SzlBMVpXQjNNZnhNZEFlemNESll6?=
 =?utf-8?B?c20rMjFDMjR0ck5QaTJQVWRpTFN3Rm9CNzNrMUFpYXV6OWxSL01yZWpjOHBT?=
 =?utf-8?B?WmV5dTRRMGNwbGdqSi92Qi9wUDIyUTRLeHlpS0pGT0RRTFVZY1NtanJreHBs?=
 =?utf-8?B?dkVsRWRkNWlqZDZCN0N2TFVOdTRORnVVWEthd3NndkJPTzRwcFZxdDAxRlpF?=
 =?utf-8?B?cGtwQ0U1bzA5eXJweHEyWCtsNEZGZ1hEcFhJSVhrMkRTUXNNL3R2dUlGai9M?=
 =?utf-8?B?bnh6U2JObnBiVlQxbU5iVTBoN2JUMUlJRWFJN0N0bHNrNnZxcnhqV0VEL0pW?=
 =?utf-8?B?OVMvWXVhZm1Kc2RNQmx0UFZCclpCSmk4T3ZwaTV6ZFErWnAvYzd6TExaZnZv?=
 =?utf-8?B?c1Y1UTYwVFdtc25hd3JSOCtFTGFDZTQ5eEZOTDh0V0ltZDVPUlZEZjZwMi81?=
 =?utf-8?B?R21mSnU5STlOdmZYNnFrbnpITUl0ODQ1ek12d3d5T1hxT21nbFF1clZ1bFR3?=
 =?utf-8?B?YmVNYnc0bGI4ang4WlVBV1RScjdhWjVvdDlrVHNvcWhDUXoxaVhocWNnRklj?=
 =?utf-8?B?eUk5cjN6RmM3RkR5Vkp3T1VyOFU3eUEwT0xOL1gwUE13ZmFlZ28yU3RNYmNZ?=
 =?utf-8?B?Z1VSWWNQWVdNUDZsM3hCRlYwSVdRc1lzY1ZkRFVyOVRsL3pvZkQ3K2ptOGdq?=
 =?utf-8?B?YjU3SWRlVFN5TFpJUGc4YzdXQ1RuM1RlU2d1MEt1YUk2ZDRyaUtNbjFQOWI5?=
 =?utf-8?B?WEdkRVlDL0szVDZLYVB3T2Vkb0UwdVlZbFN3L2I3T1VTTFhSbWhWd0FmWUFx?=
 =?utf-8?B?cWpJdWNPbmVWb2hLQzBrRE43ZFF6UTlwRWFqRWpqMDlWYWRIK1NmSW1RK0I3?=
 =?utf-8?B?azAyanRLU29GZ21yY3JwWE16aTU1SmRiZFRyQWVucHorT0ErY2lpdnRRLzhr?=
 =?utf-8?B?VitrdVpUdFF2ZndSQ0dTWmpUcW1IM014N1QyZ2tmY0FoMkZEVURKSU92QmJN?=
 =?utf-8?B?Tm1FWEY3SWZGaEJ6d3U1Vm9TNElidVNScnU0MUcxdWR5Q1VmSnNqSlNxQ1ZW?=
 =?utf-8?B?TGUvVHFWdng2elZaNTVLVkdhdFY4MEdpQ3JGUmdabThhTXk5RVYxT1FTZEps?=
 =?utf-8?B?V0dlZjJpd2NNZUNudE0wYVhzR1kyK1BVN29FSElWSG1GSVVKYnNGVjBSS2NR?=
 =?utf-8?B?bUZmL3RDR0ZHVGdSZ3kvbmwxS0tKOVRkWmtFbXJySFQ2K0JVZUV0ZDVaK29Q?=
 =?utf-8?B?OVZiZENnVVRibGlOcG1zRVZtODlvQnRoRFF5blY1Z1lIRHkrajNUQkpaMjlz?=
 =?utf-8?B?T1J5R2VmV09KK1MwckIzSDZxcDFVKzZHdmJZaXQzajVVdHdYd1dTdW5tVDAx?=
 =?utf-8?B?Kzd4ak9mM21VZWkweW5wUWlpSVlYOFNmVkZLL2hkQUpDQ3pISGMydWhZOGxt?=
 =?utf-8?B?NHZwOFc0ZlNvYkpLT1BHVzRQNFFHL1VFQjJveHBDMmtVdWppczk1MGxYY2Rz?=
 =?utf-8?B?MFFKTGVhaFlWUzU3RERVSW14aENFejVXSUt2dXdITGs3eEZTYzNVMUpTTm1U?=
 =?utf-8?B?R2lCTjdxWnM5NGw1T3d3OENybzVENTFBZDB3eVpZV0ZGRXIyUktBRzZBWmVU?=
 =?utf-8?B?alh1ZlhQaW5WeGpLN29USzVsYW5JTlRlc2puRTY0MGFjb1Q5VENIZWttUFBF?=
 =?utf-8?B?bEk1aFVIS0d3VFdHWEFEMkppYk53WFlTNXFTRmpoU09scFJNc1I5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1f4f4a-c736-4327-1f7f-08de8e79d28f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:31:40.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37MXzIoh+3U7NLCNUZmPEhTbYmO6bXH7C02sSDEytTgXKwOtFZWRcz+ZkYI+laFPEJZCYkvn7PTN5VIAiuj2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389

On 3/29/2026 8:07 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL Protocol trace logging is called for Endpoints in cxl_handle_ras() and
>> cxl_handle_cor_ras(). Trace logging support for CXL Port devices is missing.
>>
>> CXL Endpoint trace logging utilizes a separate trace routine than CXL Port
>> device handling. Using is_cxl_memdev(), determine if the device is a CXL EP
>> or one of the CXL Port devices.
>>
>> Update cxl_handle_ras() and cxl_handle_cor_ras() to call the CXL Port trace
>> logging function. Change cxl_handle_ras() return values to be pci_ers_result_t
>> type.
>>
>> Check for invalid ras_base and add log messages if NULL.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v15 -> v16:
>> - New commit
>> ---
>>  drivers/cxl/core/core.h | 10 ++++++----
>>  drivers/cxl/core/ras.c  | 36 +++++++++++++++++++++++++-----------
>>  2 files changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 76d2593e68c6..984cc37be186 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include <cxl/mailbox.h>
>>  #include <linux/rwsem.h>
>> +#include <linux/pci.h>
>>  
>>  extern const struct device_type cxl_nvdimm_bridge_type;
>>  extern const struct device_type cxl_nvdimm_type;
>> @@ -181,7 +182,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  #ifdef CONFIG_CXL_RAS
>>  int cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> -bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> +pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
>> +				void __iomem *ras_base);
> 
> This change is unrelated to the conversion to call different tracepoint
> handlers.
> 
>>  void cxl_handle_cor_ras(struct device *dev, u64 serial,
>>  			void __iomem *ras_base);
>>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>> @@ -195,10 +197,10 @@ static inline int cxl_ras_init(void)
>>  	return 0;
>>  }
>>  static inline void cxl_ras_exit(void) { }
>> -static inline bool cxl_handle_ras(struct device *dev, u64 serial,
>> -				  void __iomem *ras_base)
>> +static inline pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial,
>> +					      void __iomem *ras_base)
>>  {
>> -	return false;
>> +	return PCI_ERS_RESULT_NONE;
>>  }
>>  static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
>>  				      void __iomem *ras_base) { }
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 48d3ef7cbb92..254144d19764 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -291,15 +291,22 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
>> +				   dev_name(dev));
> 
> What does this new error print have to do with trace logging?
> 


The error print will be logged when the trace is absent. This is an indication 
to the user why the expected trace is missing and will help in debugging where
there is no other details otherwise.


>>  		return;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
> 
> No need for this thrash if the tracepoint is kept unified... more below.
> 
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (is_cxl_memdev(dev))
> 
> Wait, the whole point of patch 3 was to make this tracepoint generic.
> 
> The format string in tracepoints are not supposed to be ABI. Incremental
> fixup below. Now, there is a difference between "not supposed to be ABI"
> and "whoops someone had a dependency". We can always come back and
> restore the old format string if someone screams. It would also be nice
> to delete trace_cxl_port_aer_correctable_error(). That one might be more
> dicey from an ABI regression standpoint, but worth it if you only need
> one tracepoint for all CXL protocol errors regardless of source.
> 

Would you like that logic moved to the trace routine? The trace routine would 
require additional changes to determine if the device is a PCI device. This is
required inorder to format the displayed strings. The Endpoint displays 'memdev'
which doesn't apply to non-Endpoint devices.

Terry

> ---
>  drivers/cxl/core/trace.h | 14 +++++++-------
>  drivers/cxl/core/ras.c   | 25 ++++++-------------------
>  2 files changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 5f630543b720..70c9e65bfa08 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -145,22 +145,22 @@ TRACE_EVENT(cxl_port_aer_correctable_error,
>  );
>  
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct device *cxlmd, u32 status, u64 serial),
> -	TP_ARGS(cxlmd, status, serial),
> +	TP_PROTO(const struct device *dev, u32 status, u64 serial),
> +	TP_ARGS(dev, status, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(cxlmd))
> -		__string(host, dev_name(cxlmd->parent))
> +		__string(dev, dev_name(dev))
> +		__string(host, dev_name(dev->parent))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(memdev);
> +		__assign_str(dev);
>  		__assign_str(host);
>  		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("device=%s host=%s serial=%lld: status: '%s'",
> +		  __get_str(dev), __get_str(host), __entry->serial,
>  		  show_ce_errs(__entry->status)
>  	)
>  );
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 254144d19764..7a1319ce0f84 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -291,22 +291,15 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base) {
> -		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> -				   dev_name(dev));
> +	if (!ras_base)
>  		return;
> -	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> -		return;
> -
> -	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -	if (is_cxl_memdev(dev))
> +	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> +		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  		trace_cxl_aer_correctable_error(dev, status, serial);
> -	else
> -		trace_cxl_port_aer_correctable_error(dev, status);
> +	}
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -338,11 +331,8 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base) {
> -		pr_err_ratelimited("%s: CXL RAS registers aren't mapped\n",
> -				   dev_name(dev));
> +	if (!ras_base)
>  		return PCI_ERS_RESULT_NONE;
> -	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> @@ -361,10 +351,7 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> -	else
> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return PCI_ERS_RESULT_PANIC;

