Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353F2A1BF;
	Mon, 30 Mar 2026 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774833895; cv=fail; b=e2zi+LiayRRJ4MQt5+LEDTJhjrtKW14Z1N5gtjR4Zy6/h/iy5vd91FRE4dAJQTbRjpOeSNl0rOab6clgT/IfCjD6HibocYw+iF1NMR+Nno23p8OrR7qHjfemQbUoOK6OG6SrXGYU2BEAL+ObYbl2kg0ZfEx0oGaBf5F1Y3ZFmYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774833895; c=relaxed/simple;
	bh=wGNDx+NF7VpnIvaQDYPSnHTKEPV/OdjOc0xgZJ/kAts=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GcM0t+7oVWw3ge2M8toKJcU6D+0Tx66B3IfL+C09VEEdpWPWr1SJs7nuCY0r0Frq7OHqQdArhUr/2Rj7k/xbPJ0JNyCGLzMAC0kOGu3WpMe0saCWkyapDQybPRA2ghBuHnaGfUm2PR1tfXeJwvB12WBIaaTBIVjsC8aOoYCjKIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QutqnDub; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QutqnDub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774833893; x=1806369893;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wGNDx+NF7VpnIvaQDYPSnHTKEPV/OdjOc0xgZJ/kAts=;
  b=QutqnDubVpS5FDRYWzge6cEJl97pVILKXgYyw/Th5IYQUV+AZ3a8ew9A
   LufmpkswBk4OcjczbYUgCTN08NlbNFySGmCu/odTKLKTK9ZmXXu2ZG7bX
   c/ehonkMWW/+xMfGwndurw6iEZV/XUI9f9prkb3CTeGyLEVatQZhVzeBa
   9QhRc/z2V3vAkAk/Kmu2bz1+aagQrzVDCdo6FUpR/EvNRmt9VmOoS/ZFo
   jH3sfa6pdZl+/dvNyv+AKzNmnlkuFoQxQhGkw76RJ5tf2dNsM0P+ec5sf
   3CakqS+Akexa7LV4lAVsepraROJZS1nz7Z43ZrYTOHioB6f4SHeCfg+Q1
   w==;
X-CSE-ConnectionGUID: w+2FpRw6Sv+Ev+ae9VRrJw==
X-CSE-MsgGUID: sgvQjG4zTOWJufx+Xtp9eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98431600"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="98431600"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:24:51 -0700
X-CSE-ConnectionGUID: iKxLlK6fSOi3lDXQgXxdWg==
X-CSE-MsgGUID: 3kNwdVesRdmrrfrfEq9bow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="230372171"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 18:24:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:24:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 18:24:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 18:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=catvmuxV680ZgocrogTwz7YKLhUhmN8MvXPGeCfAmfWM19LI+WGwRRI3T6WOxZaOUyy3bFnuW9fTD9tt1lfVdvOzCzOKu/0ooMaSeM2iJea9Dpm9Lb3w5IUoNVBIUqtH8xEnsyUXGd53KUl/e1aUuPTuP+TFJqu0vmX+ZY/oHY9yQDoN8R0PNxsKrqjWijyt2GRQKC/OxxRFnpZbSzjGfvRIcfS5i40ExKZXjG+55M7ISIwsVAlPq49yH7Fytyuw2tICWg43OemXxX7xrfOxngz7g2x1DOzOrALIpTdBuIHfIrxAb7ZcabD9qVttBk3J+AUQb4ALGn0r7EOeoDJlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbD04PkV74zNFVvBVn6QEEv6td84m2dx6kz/gNQzl6c=;
 b=NIvtl53MrFqv934w4FMp9DNAHoAREuHz/X5jmasJFY9DqnA26pEJuLMQUrAqd5kzlc3fLxc/5OS3s8zwD/gjHh97bNHccsGSzM1gwZkHlLwYIYMNX5KbSlazVxXMN3N/+fN7OnMeRwZQy/gL4JP/7gDQBY9K9/1bAH5ttb7Liltm/lIQKk3x1z+TYz/EwmgqvRSQRJh2SM2rfmC7zi86FOXeZr+t6ZmZNVzUEnyvHhuIvtjkKH+L9Hiv3tD9lUWK7pkNYA3IN/tHWbaWD/ISJZg7Z00o60fB2EYbxyE9b19S6BH3Ga23jpmNSzw6r+Uq8hfRaPPfB387AqHttHlALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 01:24:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 01:24:38 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 29 Mar 2026 18:24:36 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <69c9d0d42b551_178904100b0@dwillia2-mobl4.notmuch>
In-Reply-To: <20260302203648.2886956-10-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-10-terry.bowman@amd.com>
Subject: Re: [PATCH v16 09/10] cxl: Remove Endpoint AER correctable handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c0ca5c-f194-4a02-37dd-08de8dfb1c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: rqcGtx0TN34mxUaJBhedprqxMLiGOYCsbR6FMV2v4ioYgK9CMalWXCEvD5TAmLk0XsA2Wy1rixAziZ1z5ElRWoGYGf7zTCUhec15+dIRn3/rOLAEEYDPkFO1hvoh06QALzT4pAWnqt/iEIuTXZ9oz97tcJq/fbfGDvBSFbBt8JXVsy6R0cFjVV/mroHK7ikrz5I+CI2tRDVXv2oRCSEZ3Evkidj27dnKVXSbbSEk6e2MJ6s5RJCKA6djY5o2AZGj21L0xzAlP5RNeV656Jijoq9zEk4f4rii7R24nV7i8hlX6SECgXx1nqVpWkPKx7wfq7gsHfB7K7FWjqF3LfxJPV70xRBibWH0BW4URKuFk3ez91uBZpTSOhOv9m3LVrfUObP8ucLd3pUyZ5qOi7YbGX6qnQhwoaMTkPK5SqFMd6ilI33DcNxlHOYMLU3a4YATC8lZir19i/CPaeO8V/c//o7y2mNN3jdXCJtq3t0KaSmmf81U65TjZ8C7g6jtWroTXnq2aSP21zd00Njh8r45toPDIP9zRi/O9en711cR7nFfm09fsgAPh8+n7JTJeQi0MlRKc4byZUX1/uBgrypfu7u87XEiHoTPxer09LOxtJZbm0/hI3SQlW4kkgFrhmPjdpiA6koK3YJw02qZZqxPsXznuS3Vr5euT4dU/Pupp3zUWy2/tkm6w9NGyuCQZhgcJg4GPavM/3oVeQ+1mS4aAnaTEcLmKI2MLyYAJFzqsFXAFAhVlf7mHLJaCn5CD9pPGialPxsAjAD/lIFqBf3KHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVjWGtMemtDbnlMNGcwaFJvSTdwV3paQXFpV2N5TkJCS0tRRmpQK3hJdTd2?=
 =?utf-8?B?OWgxR2w0OG9lWi9rOEppWFMyOWhVcng3SDRnMU50Wnd0b1BvaUxDN1ZvNmhC?=
 =?utf-8?B?bEM5SGkzcDdGc1pIQmg2eWpoeTBUTmZucmdLVjlnT3htb2Y1M1ZHREU0a09T?=
 =?utf-8?B?NE1QVkdSRjJ0a2hFUDdaMzZUODNVc0FpRm5tQi9yTVFJOEdSM0oyWmkzc2xw?=
 =?utf-8?B?dHc0MlJVMmw4ZCs4SktHeFp0M3Flam9SL2ZvSmFnMjJrOEpxbnFSRkhtVUYx?=
 =?utf-8?B?aUl4WHR1OUF2M1FZa09tVEtJU3J2YTZVUnNaVWo3czdzNFphL0YwZnFlQ3N6?=
 =?utf-8?B?YjA5Sitid01zdEswZWo4US9VRVhsMEhZbDdIRWg2R2lES3dma3dIOStZZktp?=
 =?utf-8?B?MkxYMUxld3loMnFwQ2dLM3JPd2JkWituUjgyNEpYOE81Sm4xRE9mT1VzaFRG?=
 =?utf-8?B?WmVyUlZJUkc4dVdZaVRCVmZYeHlKYWNTR1MxbDFkSUF5M0FuWHRxQ2UyRlF0?=
 =?utf-8?B?ZnVaTkhjcXJCd1RzN1RnVnVNSHJ0WmxSbmRLSGZEaEJLdE5QVUtOVU1CRWJi?=
 =?utf-8?B?a3U5OWtwOG5yOEtpaTVONEVYUjkvUmlXUU5aNUVmSVBUWnhpRXI4WTBEOE1o?=
 =?utf-8?B?ZXRBN0ZUdFhRSHJzNk1jVUFXSWxkLzN2NGZCNjRwRTJrQURnSmEvSE9UbjVT?=
 =?utf-8?B?WldUNHhDd0pEMHB4bDVFZ3ArK1VBbml3N1A2UmIwMnZKdVlRMGlOaUxpMlBz?=
 =?utf-8?B?bnhPdm1MdTRGSVhzeWxVc0tRb2Q0N1U0RG9kRW5pVFFsWGE3Sml2cU1tcndl?=
 =?utf-8?B?MTNOY25BcU5TdS8yMFJLMW8wdGhCN1dXOHM1ZmJOQyt2ZTYxTXhVQlNpQjFP?=
 =?utf-8?B?U1EzU2NuT2c1RmtiWXphdmsvL3hISnlHcTRxRzZJeWtQMWtMbG1rbWlNcFJL?=
 =?utf-8?B?bWdIUUZQTEV2YlEzWVZZMDhzaEEyTVBKdHlYbXN0a2Fzck04aGVxZUEvakU0?=
 =?utf-8?B?ZzBmMjV5N1lTREhqQWlOT0gyVjJaVHdwOHV3VHZBUTE3MFV5ZUoxeUFiMTVP?=
 =?utf-8?B?ZEpzM09vYnU1L2dpa0UrdGpjUW5LYjdHZmpvRDFGVWJoUkJCQTdHa1pWQ3Iz?=
 =?utf-8?B?VW9HVmJ6KzZWWkpyZjJQYWxMZWtUelZRSWM1VFNHSGx5Y2VLVFlyVTdDVThU?=
 =?utf-8?B?eGNrSVp4L2N2NE5HUjkxb1M5T3RNakpzM0NEblRiVkJhTU5PQlh6dlBBNmMy?=
 =?utf-8?B?U0gwMGFDUWpMT1plNkNNUGJKc3p6MFg0SDhGNkFnYURSMTRzQXVuSE15ZlU0?=
 =?utf-8?B?cGZtODVrRi91eE1EVFl3UnVGT2tVanBkVEc5dVBwUzhtbmN1ZDJJRHZFdzdZ?=
 =?utf-8?B?ZFBxWkkvcnEwQjQ3THlTVmJ3SWZDMEdCS1JXbEdnOGlRbkR6Y2VydDlRb0N2?=
 =?utf-8?B?d0I1UVpBSUVoNDByNmplMzMrRCtZVjlHelhTQ0VOMjdEUE5kblFnVGUwNWZm?=
 =?utf-8?B?dXE2YTd2V2dJMnByQ0RwSVdONXRsSE9sWXpRUUlJMGs3c2YzMDBzMjI5OWd6?=
 =?utf-8?B?bmhMNG9yYkdwRlN4bXBZRkJVcU82aXc5YmFyU0c1b2JJYVE3OWhMK1l5TGdP?=
 =?utf-8?B?RjMxcTVHMm45bUVoQmQ0Y3R2dzlzclRVRW5UMEd4VlgrcXJUTEFaSG85Tm85?=
 =?utf-8?B?Rk1JUlVHelNrU05DWW8yMzM1UnJzbGovYm84MXhtYlRqSi9rTURQcGxCbFM2?=
 =?utf-8?B?bjNEZjhmbURZS2U4cExaNEZFZm1kbG1LNVI4SFUramhucC9DTVJta2VJZ0hL?=
 =?utf-8?B?WUhCemwrZUVLR1pjeS9kNStmaEZZcDJ1QkJEMngyN2lrRmU1cWRBU3pHcU52?=
 =?utf-8?B?dTdZNVQvOVl5WTNSNFdZTHVsUUp6VkYwWWhZWmN1YkZCaDhkZGszV1hCRjJt?=
 =?utf-8?B?dDlNMjJPQ2grVk8wM2VTc1RTdEpEUHlDWWVmbE9pNnVFU1dOeGlHOUNQRzRi?=
 =?utf-8?B?T3c1eFRsMGYyaTBZTk9QZkFMeTY5eFFTVHhtQTNtNC9RZzVQL2hmcHRReFox?=
 =?utf-8?B?N2F1cEkveVBSRlEzbDdUcUprdGtabmFjRXR1UElaRHlkZG1sY0d0eWxlNTkw?=
 =?utf-8?B?bVhueEVkY3Y4bW5zYThDekpjaGlZTmhMd2JudE16RW5Ub215YU01Nkc1UjB0?=
 =?utf-8?B?TjlzSCs1REJxbDNjVktuS0tzL1lrTnVUQmZmRlYvUUgweUpoblFTcjhKWElo?=
 =?utf-8?B?Ym11c29MQ2ZBZEZCSGdyNDR4Vmo1NDhjeU9NcTVXZGgzSjMzNFZiSWk0RmRl?=
 =?utf-8?B?cUxmcDVuT2RQcWlCMWhHY2JMRElPV09OZXlmbWF0SWVvc2Q5S2x2MjRROHJH?=
 =?utf-8?Q?AqvV1z0Y9CNRdTAk=3D?=
X-Exchange-RoutingPolicyChecked: sdxkTkDANETIKcDVhkttND7ksZf2VvfVegNsJQof4QCpNFOAde1T5/ZZqpE7uSLb2UYYTBOMrJfZi5RPtweN4o8q5Vivuy1ABrMSN3Jqftiqmw3B3gdtubelNHKHnb/g1qYP/le0R0QLMTKJHyQrRNk3fi6B5w2YjKpen3ruaG/k2RjzFH+3vWDUzvc8F8cScpDruWiwirQwtgzY48yh0PWaGJSP1tUVgCAexMvxmBey+dLbWmvOWCVKTFERnirvGPdIu3H/TOv3c5FNZpFnokIkKOcz8+tUBs2xMJpNGGc6XBJl08Wu45s46UJsk8SUoo3Q1DFQiy5teHlLeP++7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c0ca5c-f194-4a02-37dd-08de8dfb1c71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 01:24:38.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh7GpG+5XoUlMYyxnbcwU62tCPW5yzxTiyw8uKKCeCmQSN+LQJBSBEdyi8vjkgtg/UHGKrd5pJhZRGNH1SdQYQtY2FxzzV9uilPYhJnchgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL drivers dont require a correctable PCI AER handler. Correctable AER
> errors reported by CXL devices are logged and cleared in the AER driver.
> This makes the correctable AER handler callback in the CXL driver
> unnecessary.
> 
> Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
> from the CXL PCI error handlers.
> 
> This consolidates correctable error reporting under the CXL RAS infrastructure
> and avoids redundant or conflicting logging with the AER driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Yeah, the next incremental patch to add is probably deleting the handler
altogether because it does not appear to be doing anything useful.
Please correct me if I am missing something.
