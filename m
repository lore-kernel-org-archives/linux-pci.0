Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DE36CDE9;
	Mon, 30 Mar 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884810; cv=fail; b=nMSI5xpi5a+fyvBDXntnSuQJ4+2jU+I8KidvpGMGJ7PRU31BW8xU+JarNZQePQelAcaCIcnxC4FSvaqs97bhX1qQPbu/BgS23LYKhn7xMG0zjsIXnLU5aGA98CyNIl2acf7SFKX0RY55P/1IzyWdSz1CoV8V23TizBX0JTs+U30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884810; c=relaxed/simple;
	bh=YwIuXAL50+63k8gFJFgrjEOwyRNcvJCB8SUClmzijSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AP94amCKdpIKx5tBILrMElmSz5dkkhn3Sgjtm1V/UT/YJ5mNv/9YRwr+2RFXwXpiWlJ5H1jnGkI5lrAGOTgI9o1FqcvwNwEe9psaOVm6Gkiptoe1ho+2HfS113isXp8HdRByKQy7+YBpLivRR8IBgslQgYq4g8h2bpo0hwDOFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C5UOws9T; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C5UOws9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npvuqeP55NrQ3/EdUTbsT3eNdk6EOJuG/5eAV+9kA5qW/QBNC0y614dmvj9VYjs/3feFF/cGfh7R1dTfeCO7vfeemJHblvmKCmutkszBykFDaeH197TB3BX8sUYCXkz3lLMgFdfz/2tGl3G1tnX4UvJQZ+s8hYliqp8kTM75E6KMsHUv8RMBkD19iYBiYr6TBDOXibM/Bj9CXAY/0s99gHiy6gWdV5smSgvw5OiXc2S1+3zI4LHEUcCimYm+pUndIw1ZU9xbjkdc0MTPlZd+ciqrjNUuambTkREuz8+HOn6ie5zVuYhXZIa3Roj4P0pX9IgFxCoP+W77HMhBg9kLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEO0CmgVcnjgoLk4aZLIQh0X6sPoJJislzGotVMBT9g=;
 b=u4uujkx5MJn6lAGfp+vqqayWLebXfWB+b8QmENQtbNoZLnPTl+jXudE5HORBG5ewHWTfxX0n59IbwIDf84Lk4OW14vZjuSQhQuopcPA8lQoLRaAbnfsCESR/nv89QUh/LOGoVhMqHOI7zU2oSJzJ4CN1aSlrYBNnuU7mqTr3YAyMQ+jfga+c60E0oHtdFannkxesaqCDHbdTxwyipKkofGlp1mSsAsWbdWzDFqgHMIaBGYP3BSbhQPF6M7JlSv3o3B53+ikywF8Vrx0VVbkfWdYBbVwkGqhtyK7dI1yFF0qmv+oTIsN50UIWiOd+fbeYwnEXXozuvPfc9tVPQ4oFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEO0CmgVcnjgoLk4aZLIQh0X6sPoJJislzGotVMBT9g=;
 b=C5UOws9TH2aMS2iJ4PR0Xy0UfUIJE1M4quB+okc1H5V1Ote4WcYtjA3GOAML/tDqjjfh6o05D0KHm6+lk8AADKfe7WaAvLS8GWOxzdOnbrGB3xBes8qUIc/W58CkAEUEH1s4xO4UOXieL5tugjMMMrMTlMy1EBC1mIBGWndKpXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 15:33:23 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 15:33:23 +0000
Message-ID: <3f83fa0a-e688-4d2f-bf2a-0e4784ce337b@amd.com>
Date: Mon, 30 Mar 2026 10:33:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/10] PCI/AER: Introduce AER-CXL Kfifo
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
 <20260302203648.2886956-2-terry.bowman@amd.com>
 <69c720adadcd4_1b0cc6100b4@dwillia2-mobl4.notmuch>
 <69c98caef1348_178904100e0@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c98caef1348_178904100e0@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 185f977d-05c7-4fe5-ee35-08de8e71addd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3KDPqdSdj+h8QT7iGWQ+wV6QBvb1bP0tvXPFGCloDYa7utAzh9LVUZ9rZmtyXs+h93OaZ92Awi0c7jeQ8Dqqo1yZflH57vcjnVYyxxpFly/zHvqv1ja4D7U0Gp/O4gFCB2vHhpfB3wjzitzsKXXk9NkC3g8h7f2cL4FkTRZFs8z6LuMg8mp+IuER/XImKr8RwaTuvpTb+gjqBkhegl+bI43PAMbYNP7ytirvnAIe5/ujZ3x4s38DLE+OwmRqxH8mBbWlRn4HM+VASJfybxY91p4eS6WdCoOZ4pELJRz95+t+lFUdTUtzwOZqcEaiwSAAogbur3HED6efMijxorOcG8Aus3GV8Zv0zQBSdvl/LhNUuhvhyFg1vZ50jLNHmnJr33c0H2ePUD7tbqMwuaHRUwCNzA0SRMYUZrdWhOwPn9dNuYsLipkneToovI6TmC3jXM0kqD13pghOm3JH0JVD7xl9JKzCukQqkOk/bzaQmNA1NdC//UhCJjiRz0Ijh53ZT0Pm3rkU+zU9gbfqZ+tIVNjyyBCGU9NbETbNFyqcirzrpXWHM9O+bfGKMtF3Ns0f+Dk4H8Rfru/JrSCqAOi1Uv3HCIukKjhKdBhE88gkVzwhgYpNsWldqKMKfSGYhuQJN9b9LaeVA/TCs2aCJa+sN3E2F3SekPXZNXD9Ep4H5zO1yOhnTUroTu/HLAjVPjLhiRgiSY/FbXsQEbO7ZAf/abyfgkbsHTcV+Pcr3zAdngTKKYHIEX1jX8e71gxARRBJMQ4drgsX4lX+ieE2OKiR+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1pxd0dOczlrK1ArN1luUTJrd1hJeHhkTFFOWWtmRm5IU1Qrd1Z2Q2RvNlN2?=
 =?utf-8?B?b3BOL2s3aCtDa3RXL1lIR3p1UkdLTHhNQjd5bjN3QzdwcUNSTk16ZW92S2l2?=
 =?utf-8?B?OXJaTTNIUmRmUU0wbWxtT2RjcVozNm9UeFk3cDR2aHNQdFNPcFUzeXZuM2Jw?=
 =?utf-8?B?T2k1K1BXcmJUaGtYTXNBeUx3MkQ3eXlwMjZEamxZd05UTTcwMVZsYmdrNW85?=
 =?utf-8?B?WFBOWmNsckFoS0VqY3RmMmdSbDYrZkZnVm5YUmNQbVl3WEVRcm9hV0FMSFll?=
 =?utf-8?B?bWlhcGhnNERIQW8rdTJ6ek5xeGFpajRmd25xR0J0dmRzY0dvNThGSmUzZkN4?=
 =?utf-8?B?NFN1R0F2VEUzOU9qWWtwbXRJSlFBNm92M0RBZEtMbm1xcWJDbCtRMVpOcndz?=
 =?utf-8?B?ZStEZWFGaXdmYXVPUkFWMEVXcFgxQktKcHdJNm1mQ3NhdGZrNFloUXhIbCtR?=
 =?utf-8?B?L2l3bDQyek9SdDJqU1VKZFlHQmIxbnk0MmxHMnZxeGFkUTYvUm53ZFVyVnp5?=
 =?utf-8?B?ZDllUlg5TEVHRGQwR3V1YjRaai9kQlA3dHNJbHl0bHhMMFYzNURTeDdBbVQ2?=
 =?utf-8?B?UWZ5VnY4Yks1WVNmUTN2NkErY3NCTFM2clRITHo2d0ZwN0daNjU4WnRLWHZl?=
 =?utf-8?B?c1NyL3dTOEhOdEZQaHc0QlhlSGpxWTZkTjFqQlZBL1p0dlliY1VDWE1iVXVN?=
 =?utf-8?B?VkhIZkZ0UEdubkNiU2hKUDVIVlQyTGY1ejlmMDI5bHV5YnJoekN4ckhMUkJX?=
 =?utf-8?B?S1k3MEZwZ2hTZWgxbEQrMW9HSFJoYStWYlR4R21Rd01rMVFhU01SOXlrREVZ?=
 =?utf-8?B?YStCOXdiZ1hPQmNVbzB0UURWQkw3NElBaTJLTTZ4OVJrN3A4ekNNamM4RUc3?=
 =?utf-8?B?OHpJUDhWL0d5UGlGZWhsNFVubHBhbkpBUFVteHRjZWw1d25wa2JGZTlad1JJ?=
 =?utf-8?B?UzNqYnBYa1pRTUxrUWIxTDlHTEhMd0lsSlBEWTY5eUVHQUJFNEdYTDI5S1ox?=
 =?utf-8?B?bU5JdTltaTBZRGxzQTFlaDY0L0RkMmN5UUp1elBkaVl2VGdsSi9DeUxmRFBB?=
 =?utf-8?B?Z0RjNjJhcjBVVUZENzUvS2VNZjlLR080NEtaZHlRNDNpbGdWUTY0L2l0Mzdk?=
 =?utf-8?B?MXk2VitXbmc3dEpWZzBrQ3gvRXgxcVZqTWlGYm9IdDRHSm02a2FLdUZuZDZx?=
 =?utf-8?B?aGdJb3EyQ0FCc0U4LzhBc0V2KzYvQTNoK3RFUC9hRi84ejhrek84bXIySXFm?=
 =?utf-8?B?ZFZZMU5yaFpKZnd0MTUwajBjSXdjNnBVRzFTdFRid096a3lVZG5VTmhRaVhX?=
 =?utf-8?B?NTdoTWN3MWFyd0Z2WXI3Z0FoQnZJWWdJMTRuSlo3b24zbkx3U2o2ZTc1Q1dq?=
 =?utf-8?B?RFJ5NGJtbEhWbjZmbFM0SE4zUStxbWFBSnNZaUFic1MzbHdxSmd3ZjlIajNz?=
 =?utf-8?B?ekVQUTJ2UXlNOFJDVGJoeWM3diticUVpeStoeXZtT3JoajlWeVoxdlkza2Jk?=
 =?utf-8?B?MUcyanZzcVBmL09WLzVtaEJCMURhL3ZrLy9kN2t2L3U5aHhnYzEzb0pla2ky?=
 =?utf-8?B?eEROQmpVMzJJUEo2cGkzTjlFK2VMUXBVUnJvZkxlL09mc1R5NmF5MGpjZHlL?=
 =?utf-8?B?MS9TSERtTUlWdVNzaHVPTW9iN0VJM1RJT0E4YS83ZkRCYzZnbVQ3OS9Kc3c1?=
 =?utf-8?B?U2NnV3hzcWhlVk1zSDY1bmdSclB5U012SnFTdWdjV1FVa3JySkkxczJoeU1X?=
 =?utf-8?B?VGlsK0pwN3hxWG1LaXlmYjhjK2pQOUxFQjhSY0V6akhOOWUxVXM2NE1vNXVS?=
 =?utf-8?B?dllJZklqNU1qWUlaMGlEWDRGK2dXS1NJNU5CTzVka0FER3FqdGlLb1J0WEx5?=
 =?utf-8?B?cmJYQ2hTS3Q1ZHRzd1JiK0djTVFJVGVXdEtCN1Z6b2xNbzlMNFNUZVVEeXJX?=
 =?utf-8?B?bm1hK3J6Z2NDVnBTcEsyYW95Wm1kYmxRUnd4YzM0YVJRdGhQZVRNeHpsV1Ew?=
 =?utf-8?B?em14R0ErNENUZytiOEhlNWlERHJ1UmxxQkUwRnUwZXgvVFl1a2U0R0lzMGtv?=
 =?utf-8?B?akV1MGdsRDF5YWF5dkZsUFBudFdDeVFncWEwcTVUdXNYL0d2cGkyRWY1OHpD?=
 =?utf-8?B?c3o3MUo0bkhQV001UUEydEJwV2Nnb1dJSTNVWmhGRzJsYXM5YWFDTFJNTnRC?=
 =?utf-8?B?WDAybGtJUXpMUGtTUW1NdURwMmpQRzhmWTVuaFFrNjJqeSsxL2x0b25DOFFV?=
 =?utf-8?B?R0tMTHlMeURMa09tZXhBVm1YS1VKT204Uy9UdWlEZTVKeWVsZVZxYm9aN0Ux?=
 =?utf-8?B?QTZsVks5NGZaMjByaGNrbjJGekxKUkgvQWF0VmFUck1RN0JFOVdOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185f977d-05c7-4fe5-ee35-08de8e71addd
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:33:23.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krKorRTO+uiGCDHg3rmdbz8SwoGeW0dOC30ppM8lqYDU5k5h6fHM0W9RFv3EjiFhuIpL8aNB5ThISRyzQ9oRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

On 3/29/2026 3:33 PM, Dan Williams wrote:
> Dan Williams wrote:
> [..]
>> I just realized that this reacquires the semaphore on every invocation,
>> and leaks stranded references.
> 
> Terry, while I think this issue is significant I think we have passed
> the point of utility of continuing to spin this series. Specifically we
> have general agreement about the approach and the issues being found at
> this point are no worse than the maintenance fixes occurring on the
> already upstream CXL infrastructure. My proposal is apply this v16 to a
> for-7.1/cxl-aer topic branch and start submitting submitting fixes on
> top of that.
> 
> If that topic is merged for v7.1, great*. If not the commit ids can be
> stablized and a for-7.2/cxl-aer topic branch can start up from something
> like:
> 
>     git checkout -b for-7.2/cxl-aer v7.1-rc1 && git merge for-7.1/cxl-aer
> 
> * The primary merge blocker question for me is whether PCI core agrees
> to the proposal that CXL AER requires 'struct cxl_port' objects and
> forwarding notifications from the built-in PCI AER driver to the modular
> CXL core.

Ok, I'll align with the new approach to work with the changes on the 
feature branch. I'll begin with the fixes for the ref counting and adding 
your recommended semaphore change.

- Terry
