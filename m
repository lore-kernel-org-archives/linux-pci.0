Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF8379966;
	Thu, 10 Sep 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053602; cv=fail; b=aXJpkIhvsxE1PqIv3xeHc8GbJTA/tapkylY62cx6a23joeclhdfm1T1t+rKikeqNLUi5TEJVA3tuPp7qkQl+lpd86bNGqyu8BIO23A5q+GrLcwgPVQWICq2xd3i3z2VAFGDA9aysLC2hUR2LskPrb8h1jpf7wSxCtSyTyCz16tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053602; c=relaxed/simple;
	bh=mTepK7g2hfmoT33m1MmkqoVf7CN9ec2cV3NuhdO0fDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGbC/0+qFZZyWmz79FET+kgE9J8wtQxR4GkD+xt9CEcJkzLkjJiHc+K+6Z+A+T+e5oF7dOKPaQ/OJbpHpIUywD/HBqHK48yR6v2aWEJiqD8tk6bV3mLLpf1+q61/RbT6PHipTmYv/3mNshk80nte+LZpatlKE0L1xov5SaNsLvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GSa+kED5; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GSa+kED5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfFRqTqNZWvt9fbqzPxo7Dk+Ua+YI9qREFklAu0RLdUVqGkYpYgqzV6534WPm1q10E1eLNcl3oz7t4ePWLi6zNaUqDzpqMlSp9xV+g2kFG0QQdeBbp84hSl06kguulCK5/f36CZa3fwJ2LWsnhkaXkHzM3tm9wqfd8CbZCkDu5aWzTZ90ro8yEKHEy8CqnF+OAgtwIHXnCqSlIXBpkjRZ6tihPT15E6jay0lIuNCC+ban9i2Al3MDMwWo3Mxsy3lJJNBsJz7H4upoQwLPz4XQXiy/eQL8HdxOLAj1EibpM/jjD1+HLyKYSIQchkW3GSoZ+wU5qKHZgIY1c16ywuRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae0cV2TtpOaimTqUJFTuFzcBeNtCeed+JcMkiMIlwDw=;
 b=DCfBMJH2uPpSCrxZWqQ46Tgq3g+wB/WxIbmYl2p2ZI5MPPknAq7xQDrWU3yED2umLEVymSRG/HHLuN0Zwpq3YsIF+YApW4jRAygrzDvwI7H7f6vuUPwhyUUpRijsVTNW8HK3TwzKsuKjRvk4GEyI7NfFWscXkULgTxfknV2gGX/eu1WNGAc83xLJuq2nlIht93UcMWqnrMPbu8LdN69IMO/K9l/rNajG9WLoZ/Nn+zT3MbWW4cLoqXtCFhEWKgNHs1IMggKBUBJ4yzgmLCxGXnejp2bcwWd8ohonk9kB9Nox1rhkoufBmEXfRKmVNUoENOUOK+7xSoq5kS2yIK2GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae0cV2TtpOaimTqUJFTuFzcBeNtCeed+JcMkiMIlwDw=;
 b=GSa+kED51L2Lu0nwpaTLvh0A3qUt4diNX3n3gKCQIY2bQrQEHVAdP10KJ6LB1UI3stZyhlqkmqMKuG04kXYz7hIJTu5y2biguY4uqCDDjb4tqMRakyWrU38Eh5gxnpebtNf9rEh+HbW2GKiCLw+5hIPKUtNhCvVPyqlm4HQpfBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 15:19:48 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 15:19:47 +0000
Message-ID: <841e2342-273b-437d-82b0-f85bf6940001@amd.com>
Date: Thu, 10 Sep 2026 10:19:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 9/9] Documentation: cxl: Document CXL protocol error
 handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-10-terry.bowman@amd.com>
 <20260908193906.093dd008@jic23-huawei>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260908193906.093dd008@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:8:191::8) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: c5eac3b5-f04f-4c58-b9c1-08df0f4ef308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|3023799007|10067099003|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RWWiFLIaOCpwER70pI2dl+epVv8hkc3cttd4OsKw1fG5wUVJRKoibX5p27EOYzbH4v3jnK1bJMLfg73rQPEuDaqMBSsxjzYovaV+VSwR3qgC/6+Xy6YyQ/kLrw63LQqhLz+7ntQRtadSwTQKdGHeClNnoYEsVotv/eFOESMneupcNQL21ggQrJJBCrG9JBvRoZVUKHIdGyJSz6rYl56892+oUwS52/orAMfAuDPbRtVALHUaBxCxqgjFmBdmzMkscNutKeZpORyynrWiOyEZXwfR0CK0al0yVTgi2Vsw7tjkyMuThFsIRehp1HguiKQ+XPjD2gkI1sRGNp6Id+3F1FaHmI+9hp5plDRagt75uq/aMKwkXqtmTb1QhVVH/6po5B1J9TqZq+Islu//DQxHaOZ2HW3rle3LF048zYFRdudt1el5AI2wSfbGj+SXj/K+4FbAa16m6MRGp3rhzIARnonqLr3gBlA/dpqpoT9KrjlWx3PRGRAnInl24KsJOAKJb3b+Sb40G2WCCxRdKZNQkZ7zWMmS5LMELjkCh6Z4xkZm8Fs7fYULmk3x6hxOkjz2i5d3n4K2kbqTku/MTJB/crevXvBmjoTOsPwa1D31QgH8tfYlqwfeveTrr3l1Dt/WXawCAg7zgsA5U5FJBriU/iKoCjtpWYewd35u1rVY9bA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHM2MXd3d29vbU1xa2djY0ZiQU9rMFdHbVJXeEJtK3RzRFRsUlJ0cTRvZjZG?=
 =?utf-8?B?a0NzVEp5M0RPS3BtL0NSRHdBbm55Y2dTY3BoSDk2N3J2VmoyY3lJQmZmbWF1?=
 =?utf-8?B?L1R2djJJcFl2RmFRWVhIVU1qSjFuek54NVFjRHdlUzJPNzR3allkb0hrZjN0?=
 =?utf-8?B?d2owVjI5QXdwR05LYkFySWFPZ3dBQVJrU2tidGhBTmd1eXJCM2c5Tm9IWlo2?=
 =?utf-8?B?N3FVUmJ6ZTI2ay92Zm5MVnBlNENkekVEU0o1WXFFT2xzQzJ5R1lIZmp6cXgw?=
 =?utf-8?B?bjBOOWNHUjJ4aGtSTGlxaEI5bkJYMkFFajRhUi8yd2grdlorQlFnU1NJSlBv?=
 =?utf-8?B?S2xxam50S29DeHRPSUtYNGErT3U0MkN6cUhneWVtMmJ6dTZnbktwaGh2cVo1?=
 =?utf-8?B?V0lWcU5NbGpQaE53MmZ4c1JaYkFQNDhlTGhRZ3lsV04ybFh3eTV5ZTh2Nzhm?=
 =?utf-8?B?amovbmk5aGdPbjhra0N6Zm5TOFlCN08rcWd3Q2Fac0YvSHN3T0VuZDZ2QUFF?=
 =?utf-8?B?SVRrVjFVVnJPMU5BWnZVcjEwRk51NmoxaE5sa3puMjBHb2cxcktOaHFxNWly?=
 =?utf-8?B?SDc2VWNHVXgzeUVNVGRmNis4Y01aZE1QaDZyQTZEb21LN01tZW53bFQ3Z3d6?=
 =?utf-8?B?WWExM0QyVEJlcUtEK1pxaG9Qdll4dnRPbmVQdmhKdjAxWGZBNVNpeTZNZktS?=
 =?utf-8?B?eC8zSWR0TWJtUERwcHVrdThrZVBWUE9SREk2dDl0eDl6a2FSOFZleHJLOUtV?=
 =?utf-8?B?b3IrRjlRTFk1cnZGSzFpZVFGSmttcUlETi9wOGVmUENVUVNqSlpzYUlDS1dO?=
 =?utf-8?B?eERxZ2Q1cC9HZXRrMTg4dE5UeGtZdUlKWVBjMnU2NnU2YVhQWktwUDcySUVu?=
 =?utf-8?B?ajBSUk1YblIvT0JLcTAxYkgya1hJU0xUcXE5cWFldUE4S0FsV1R6S0V3UUdD?=
 =?utf-8?B?ZWlJUlhySXUrZk5Ia3VjREcybzdXZU9DekcvUHdtN1E1RFhqNTRpYTB3OW1z?=
 =?utf-8?B?cWsxNWVIN2VLcVVnWkg5RE9MZFQ0eFJoeTFMa0JLdjFkZ2JMOWRPK0dhNUdU?=
 =?utf-8?B?aTNaVGZscURWa3BFV2ZHME5NYUk2ZlJ5ZytpU2RpUXI2c1NYS0l4cVZndklK?=
 =?utf-8?B?anZDRnBpL3dvS3FHS2RqdWJQenh2eU9vcGs3c1dpQzRzbFVoa2JVTXNuWHM5?=
 =?utf-8?B?TkhzVE9mUW9zTmtINk9INDdsTGw0MjM0SE9MYkRKRzV3UUFsQnMySUxrbkRo?=
 =?utf-8?B?bTVNNVl1ank0bllFSmExQXUwZFd6aUtMdzZFU0RNWWpHaHE0ZmxxSkxMNDl6?=
 =?utf-8?B?Y21FQU5PUFROd2VzTU9iVnBEUFcxS0huK0hiMjFxOWk1N3RTVXdPdGpCVE5U?=
 =?utf-8?B?NXhsTWNjcjNOVmNuOHF5QTdObmxXdVUxYWtDYVZhUUVvVlN1VEs2d2JIOHUy?=
 =?utf-8?B?K051TTV4clZHczhkTEVaeHlTSFZYV3BLVHpLM1R1ak9sMUhqQkU5a1VxZTdT?=
 =?utf-8?B?U2JZTE80bldXVDlHT3RyNHIxb0RwYjltNGZGRnVGbkNMckV0S2FUQ3ZBczhI?=
 =?utf-8?B?QVhpTjlWVEJSZGJhMU1ESzFvUmk0Y0JwN3dOL2FNbm1VTDdnSHIvWldhbnZZ?=
 =?utf-8?B?djAzU0MyU0c3R205VlQzVVBQNmRoQ3REUGZpeUE4aXRwQXlPTi9iWnY2eTh1?=
 =?utf-8?B?K0RNaERnK1JyM2hPR2xHSUUyNkxXM0JoSlk1UGJwOVlHV0s0TGZObVVRWjZk?=
 =?utf-8?B?bzd0NUFwaVlwY0IrOGtzODhnbGpXTGUyYXV4K0FDblhoZWg1L2FTcjB5cUdK?=
 =?utf-8?B?d0tiWmFyQ0hmeUQ2ZnR1S24raHlFVGdpVEJFWlRmeWxGVHpmcWFJNjZyTnZU?=
 =?utf-8?B?RHBLWTFKOXZxUDJkVXJBOEtISVNCNGRVU01VdEYzWHpVYTliTGY2Sm9EWHBP?=
 =?utf-8?B?eHpVTDBjNjFaMVdldWVGVUZJODMxR1dLVXYzaS9hbFM3cVN4VGVXMHgwZ01I?=
 =?utf-8?B?ZWZsQjhVNGdkZDNxQkhORFdQWFh3aThzdFQreldZKzlVMjhGOTNNT05KclR1?=
 =?utf-8?B?eFIxK0Vsa1VrRnhtYkloSTZhSXJxUXZmeC9nNVQzNURYTWdoblVaOTdIWlV5?=
 =?utf-8?B?UXVCN01MT1JVWnNXWk81ZytadFRBNE1FY0FEd3lvc3AyVkZoNThsTDdLSUY1?=
 =?utf-8?B?bjBxemY3ZGlkU0tmdXdoRFFHOUZzc2dMVXBtMUZyUTNNbHUvVDB0dHlsUWZr?=
 =?utf-8?B?WEdvTGZxVGcrOXN3Wk54RlR1NVJlYVEwV0V2UEJzSGl3dVVCUGVmNVpndHZL?=
 =?utf-8?Q?l806iJdlVt/A7FFkoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eac3b5-f04f-4c58-b9c1-08df0f4ef308
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 15:19:47.0327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTO1lyl+1A1RhTibAO3iziThIZL9dDzmPa0hO5+nHcWCUCF2ydx1OUnBMlmv8A68QfBdZZ+sBcSV00Bt7sgGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

On 9/8/2026 1:39 PM, Jonathan Cameron wrote:
> On Wed, 2 Sep 2026 08:39:33 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
>> describing the end-to-end CXL protocol error path: AER ingress, the
>> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
>> cases, severity policy, trace events, and a source code map.
>>
>> This documents the architecture introduced by the preceding patches in
>> this series.
>>
>> Assisted-by: Claude:claude-opus-4.8
> Assited-by: LLM
Ok, will switch to "Assisted-by: LLM" across the series.

> for all of these (kernel documentation was recently changed on this).
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
> ...
> 
>> diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
>> new file mode 100644
>> index 0000000000000..1da71d0409a05
>> --- /dev/null
>> +++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
>> @@ -0,0 +1,441 @@
>> +Error flow
>> +==========
>> +
>> +.. code-block:: text
>> +
>> +   CXL device raises AER Internal Error
>> +   (PCI_ERR_COR_INTERNAL or PCI_ERR_UNC_INTN)
>> +                   |
>> +                   v
>> +   +--------------------------------------+
>> +   | AER core (aer.c)                     |
>> +   |  aer_irq() -> aer_isr()              |
>> +   |  -> find_source_device()             |
>> +   |  -> handle_error_source(dev, info)   |
>> +   +--------------------------------------+
>> +                   |
>> +                   v
>> +   +--------------------------------------+
>> +   | handle_error_source() dispatch       |
>> +   |                                      |
>> +   |  1. cxl_rch_handle_error()           |
>> +   |     [always; filters internally.     |
>> +   |      RC_END enters the kfifo here    |
>> +   |      via pcie_walk_rcec(), NOT via   |
>> +   |      is_cxl_error() below]           |
>> +   |                                      |
>> +   |  2. if is_cxl_error():               |
>> +   |       cxl_forward_error()            |
>> +   |       [enqueue to kfifo; EP/RP/USP/  |
>> +   |        DSP only, RC_END excluded]    |
>> +   |                                      |
>> +   |  3. if cxl_pending && non-CE:        |
>> +   |       cxl_proto_err_wait_for_empty() |
>> +   |       [sync drain before recovery]   |
>> +   |                                      |
>> +   |  4. pci_aer_handle_error() [always]  |
>> +   +--------------------------------------+
>> +                   |
>> +          (kfifo -> workqueue)
>> +                   |
>> +                   v
>> +   +--------------------------------------+
>> +   | __cxl_proto_err_work_fn() consumer   |
>> +   |                                      |
>> +   |  if is_cxl_restricted(pdev):         |
>> +   |    cxl_handle_rdport_errors()        |
>> +   |    [RCH dport RAS first]             |
>> +   |                                      |
>> +   |  cxl_handle_proto_error()            |
>> +   +--------------------------------------+
>> +            |                |
>> +            v                v
>> +   +-----------------+  +--------------------+
>> +   | CE              |  | UCE                |
>> +   | cxl_handle_     |  | cxl_do_recovery()  |
>> +   |   cor_ras()     |  |  read RAS status   |
>> +   | trace + clear   |  |  trace + panic     |
>> +   +-----------------+  +--------------------+
> 
> Why so narrow. Seems like bits of this diag would be more readable if
> you use the whole 80 chars?
> 

Yes, would be more readable with wider boxes. I'll make all wider.

> 
>> +
>> +.. code-block:: text
>> +
>> +   Fatal UCE on Endpoint (VH Endpoint or RCD; link down, no AER status)
>> +                   |
>> +                   v
>> +   +--------------------------------------+
>> +   | PCIe core error recovery             |
>> +   |  pcie_do_recovery()                  |
>> +   |  -> report_error_detected()          |
>> +   |  -> cxl_pci_error_detected()         |
>> +   |     [pci_error_handlers callback in  |
>> +   |      cxl_core/ras.c; the RAS handler,|
>> +   |      NOT the AER kfifo path]         |
>> +   +--------------------------------------+
>> +                   |
>> +                   v
>> +   +--------------------------------------+
>> +   | cxl_pci_error_detected()             |
>> +   |                                      |
>> +   |  if is_cxl_restricted(pdev):         |
>> +   |    cxl_handle_rdport_errors()        |
>> +   |    [RCD-only: RCH Dport RAS first]   |
>> +   |                                      |
>> +   |  if port->dev.driver == NULL:        |
>> +   |    return DISCONNECT [port unbound]  |
>> +   |                                      |
>> +   |  cxl_handle_ras(port, NULL,          |
>> +   |                 to_ras_base(...),    |
>> +   |                 pdev->dsn)           |
>> +   |    [EP RAS read, independent of      |
>> +   |     channel state (not skipped for   |
>> +   |     io_normal); dead link            |
>> +   |     readl()==0xFFFFFFFF sets all UE  |
>> +   |     bits -> panic]                   |
>> +   |                                      |
>> +   |  if ue: panic("CXL cachemem error")  |
>> +   |                                      |
>> +   |  else switch (channel state):        |
>> +   |    io_normal      -> CAN_RECOVER     |
>> +   |    io_frozen      -> release driver, |
>> +   |                      NEED_RESET      |
>> +   |    perm_failure   -> DISCONNECT      |
>> +   +--------------------------------------+
> 
> Similar.  I have a new favourite irritation - overly narrow LLM (I guess)
> generated diagrams!
> 
> 
> 
>> +.. code-block:: text
>> +
>> +   Platform firmware CPER record (CPER_SEC_CXL_PROT_ERR)
>> +            |
>> +            v
>> +   +----------------------+
>> +   | GHES/APEI (ghes.c)   |
>> +   |  ghes_do_proc()      |
>> +   |  cxl_cper_post_      |
>> +   |    prot_err()        |
>> +   |  kfifo_put(CPER-CXL) |
>> +   |  schedule_work()     |
>> +   +----------------------+
> Ouch. Definitely wider here too to avoid splitting those function names.
> 
>> +            |
>> +            v
>> +   +----------------------+
>> +   | CPER-CXL kfifo       |
>> +   | + work_struct        |
>> +   +----------------------+
>> +            |
>> +            v
>> +   +----------------------+
>> +   | cxl_cper_prot_err_   |
>> +   |   work_fn() consumer |
>> +   | (cxl_core/ras.c)     |
>> +   |  drain kfifo ->      |
>> +   +----------------------+
>> +            |
>> +            v
>> +   +--------------------------------+
>> +   | cxl_cper_handle_prot_err()     |
>> +   |  pci_get_domain_bus_and_slot() |
>> +   |  find_cxl_port_by_dev()        |
>> +   |  cxl_find_dport_by_dev()       |
>> +   |                                |
>> +   |  if CE: trace correctable      |
>> +   |  else:  trace uncorrectable    |
>> +   |  [trace-only; no panic,        |
>> +   |   no cxl_do_recovery()]        |
>> +   +--------------------------------+
> 
>> +Severity policy
>> +===============
> 
>> +**Fatal UCE on EP/USP** - A fatal event brings the link down, so the AER
>> +core reads no AER status and is_cxl_error() cannot enqueue the event to the
>> +kfifo. Endpoints and RCDs are instead handled through the
>> +pci_error_handlers .error_detected callback (cxl_pci_error_detected()),
>> +which reads the CXL RAS registers when they are mapped and panics on any UE
>> +bit. If the RAS registers are unmapped the read is skipped without a panic,
>> +because this path has no prior confirmation that the error is CXL internal.
>> +Upstream Ports bound to portdrv fall back to standard AER recovery - a known
>> +limitation. See "Fatal UCE flow for Endpoints and RCDs" above for the full
>> +path and channel-state handling.
> 
> This 'known limitation' language kind of implies there is a solution. I'm curious,
> do you have one in mind?  I can sort of see maybe that the class of UCE that leaves
> CXL.io up is larger than that for PCIe so maybe it would be worth logic to probe
> the device and see if we can get to it's registers?  Anyhow, job for another day.
> 

Yes, we may be able to update aer_get_device_error_info() to check for upstream link 
health and if its intact then can possibly read the AER registers. I was leaving this 
for future improvement.

> 
> This looks good to me and even the diag things is just a 'make it prettier' so
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks

-Terry
