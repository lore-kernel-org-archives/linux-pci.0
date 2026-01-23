Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8A534027E;
	Fri, 23 Jan 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132204; cv=fail; b=mqkzQmr0VLIwvq9I+/nfttmXjK3FPxFU+3ozdCBMJXAM03bkt09ghx2SgBZt0rDsyrenWE1SuXO7MSnUvS+WYpeCDFpBTsMausRLE76/sjJsI8DCTLOVKyrxXktll1I17qCVIqd6j37G3AjrvwzzO93AiVu9Zd2kg9/YcZJrUNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132204; c=relaxed/simple;
	bh=rZW8RlqxkjCjtajSNI9pSh2UEP3e/qTsPbwhjJZrtvY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=uJMo0d5YZA4AYZ35PKIhtDJ9qHgFfqkweojMQaPIY8epSKWgWt0mQpkMj2p+1jzhtmFwkUCex4ZwZ5uqqz5LcGQgaGFdjmpE1eBGEn38U3FLInVeapvhWu6i7VudBBbHK2QmCP21Tf5Wc7jPBE1PBRss+02icXIF9DUXAnzEJZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maM43+Ao; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maM43+Ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769132178; x=1800668178;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=rZW8RlqxkjCjtajSNI9pSh2UEP3e/qTsPbwhjJZrtvY=;
  b=maM43+AoDXOx45xSZEQ8c0udBEnRFABmjzrjokYJL4oeinkLHplTWnHH
   /k0/OY4k1ogIhz7yfbARM9F2/Rm48WniWgeonudISPQo2WTT9XuE07Tb8
   4CPefPY0nl3Ef1Uc3vGZ/Nh5GW1mXROg1A0V1rDvQ7Jsa6YE72IbN28ra
   QXV0R7caI7W8PaSNIoh4w8VAmo3Pl1I3FUuuwclaQo7eR2dwIrZLunY/9
   MltNlWs3dbggWgP7aMWXbPHONmoyqzQOappZPpIykVVzV08vX9lZ6Spr/
   SHrc1n5BC8fi9IP+uwxjSM2j/jpe00MpNnZjTRmaAfy5zSlLKdrmRaZcH
   Q==;
X-CSE-ConnectionGUID: CR0lxDBjSVGsmzhxRRl37g==
X-CSE-MsgGUID: ovLw8qw9RTijGZ2P/vrCFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81102181"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="81102181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:36:11 -0800
X-CSE-ConnectionGUID: QFgiWvq6SdKrIPpS50rSVA==
X-CSE-MsgGUID: bQ3m39BJQCGMQURQLOzoNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="206482868"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:36:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:36:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:36:05 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:36:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUnXhHk2vJ4/IKEUH1h+tj57DKzUqrNfOnGAFK/+lL3tQBxGWb/U6mz8T5e+d8l6gO76Km6ggtWAecJxtp0eC1s3s/M03VrV3SO/Nl6IQa7ycAS/tgknGS8KHN2Dsg3OS1DdJ8P8aMRh/uCZyenixnIfb0+KqTPoqAud13Ef2p8ycOgDu/iHwunT5QCP9XaZBhOp2wFjtUWvjgBjgcTDtdA3MEJJXX3xXi/IYMqOGS6QZOq1hBPZWXkWlQHideGWmcEl5oEJix8qIQEXZsDZVxIziNSLmKh3+PxMXCZVSZYfeumwjfeJfwG+Nj2Va1zKlAbJSH8otYMWA9kraMXLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZW8RlqxkjCjtajSNI9pSh2UEP3e/qTsPbwhjJZrtvY=;
 b=UP+u4H9RmW+rAEk3U5f8CymZjl4axKn74DK5l191Yi8YYpZrLWkKF/a5BAAPm6SEyYh6wob4HiqjZGEtCjFeiBOcUgzdxZUQ93H6yB+7+aebuhoDrDupNifmSPI0gp677R0sUERtmxH4lLOLFiJ2eA8tP0XWlq9/fOJCJ+5KoGfdCvpWl26YfqlcyeD/zzlstGJOQuXhRRrzJbbDfecp68PcYqXO3cHSVHhnFqkzX7Aoys0ReU2LnAgTO/d719ztfiY/7hZ9xGUvkm4zitZ6GuUEvZo9kVzMhfog3/xaSz4qK49eAXP56e7PisyefLT5KpwltVa9UK10tUpYVkzk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:35:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 01:35:52 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 22 Jan 2026 17:35:50 -0800
To: Li Ming <ming.li@zohomail.com>, <helgaas@kernel.org>,
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>
Message-ID: <6972d0762f71e_1d3310065@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114111455.550984-1-ming.li@zohomail.com>
References: <20260114111455.550984-1-ming.li@zohomail.com>
Subject: Re: [PATCH v2 1/1] PCI/IDE: Fix using wrong VF ID for RID range
 calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 207d5a98-b752-411a-bd3a-08de5a1fbe7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkJxeUMvMGIvQUdWRWpVSkxhS2YwQTVEb0lodHN5SGYvNmt2d0NqdlRyVkZK?=
 =?utf-8?B?dGxLUDJrZ2lYU0FINmJGNlp0bFZJQjF6VjZIQ21CemhCL0JWdmdQWWRCWHhm?=
 =?utf-8?B?ZFp3azZ2alBnLzNrTWxqbFpBWFNsdzVxWkZ3eG5HUWRhbW14VCtFQ2JjL1FD?=
 =?utf-8?B?WE1ObEtMV2pXR2YzUkxBU0lpZTJTR0dBeFk3ZDBLSkdDTHprME5vWms1YjZH?=
 =?utf-8?B?SEo5ZFgwZ0drZDBoZEV3MmxudzhabDJ5ZVczQWVXWUhWd2ZJZm91c1N5ZUFO?=
 =?utf-8?B?NEVFS1RHdGtqQSsrR3ZCSjQrUFhzTW8rUzhMZ3gxYW8za1BacVVRN0M5WVlS?=
 =?utf-8?B?b1Z3cXFpSWR6MS84Ym9xeTc4MVE1SWpFd2c4bGV1VjBhQWN0TlhmYkZrVnNs?=
 =?utf-8?B?OU42aWpYT0ZudVA4SjYrYVRvWjk0MnpIRnp2Y2cxbWdMTlFlQjZwNVpiMllE?=
 =?utf-8?B?d2ZPZGcvM2JGRi9Wc2JveFlkSTJ2a2lZYlg5NWRoc0lwQUgydXZtdTVCMXBT?=
 =?utf-8?B?S3dYUUphMXcxVEl5VVNYQUV2TGViWHRhczFPK0kzZytoV1BhWks0RUxUZXg2?=
 =?utf-8?B?YlVoYnVSZy9Mek5KVnpMSDV0bDV4Y0tmV3FNWGd4NjhSNzAzcjdBMFloYXJo?=
 =?utf-8?B?Y1RjbmwyMWc4N1hqTFFKMU9jblZGdjNKZ2FqS2YxQjlybkxkVkx0aVEyTEIy?=
 =?utf-8?B?RzdoemFFTmZ0WmNDY2ZXTURpUnVBWnNsTythQ04vd0FRNGVqMGJYbHNxSUxT?=
 =?utf-8?B?emRnbDE4ZDFjeGk0UzdNbGxvcVRPUE1raHEwTUp1R3dISDhLZURYcUtOVkdz?=
 =?utf-8?B?bUFkOXdYdUtUU3gwMENXQVh4MnVERnVFZlBNTUZGUjFyckpjekw4Rmh4cHFp?=
 =?utf-8?B?c0pScHE5ZGp1ZmZ3bVNGNGNManZTaVVRN1FiZW5NeTJURXZvaXFBVXU5MHRG?=
 =?utf-8?B?WHQ3K3EvbDRPMitCN3ZnU2ROOVpxa0RZMWdLZlNxSHhSd1Bnd3B2YjhZWmow?=
 =?utf-8?B?Y096S2NXem9VT0ZKOW5zOEN6ODlZa1ZrKzNCSzBNazRKQjdZa2JoVWp4enBo?=
 =?utf-8?B?ZHgxTnk4eEllY2hSZ1I3MitQOEo5dnZzeW1tVDFPeFZOYy9OWmQwS2Z2ODhy?=
 =?utf-8?B?VnhzRUQ1d3dITjgwMEdSRlhMeFY0WGZ0M0FGMmYrS3BiS3c3ODJ6MVpBMWhN?=
 =?utf-8?B?YWZDb2tWSmZhQXpDbEo3QWVIVXRsZ0FMek50RnVlRzN5RTBMTG9rVElpNDkx?=
 =?utf-8?B?RHprL25FQW1vbytBRDRyaHpSVXpsUFA5UGd5RnJtMFlaazNnRUVMc2tyVytE?=
 =?utf-8?B?RDkxbjBvTHl0YUJPVmpnR1FXUzdqN29MczNnNXJkaHpESDdZRmZFQ3dsWGpt?=
 =?utf-8?B?Rmd4WnN4aDJFWDVHaXVhVXdGM1lDT0E5VXlTWHVtbURjbFFjTW82ejBHR1F5?=
 =?utf-8?B?Z1loN1FtcEJFNkN0cyt6VDBuUmFDaG96TDNXSXVxOVlLdHo2VmZPRTIzUmRp?=
 =?utf-8?B?cFo5bTRZV0trWmdHQk43L041REYzN3EyUkoyUWZTUnJGczNJN0J1L1U0dXlj?=
 =?utf-8?B?SmFUdTBURmZaRWYrejNpRkx1K3pOc2ZSK0xXWGlzaWloNDBMR0lxOHR5MVJB?=
 =?utf-8?B?NzhpcnFUcVNjbzFyV1N1UG9aSldSV1l5aXZLd0J5cFExUnM3QUU2UWZFUDVk?=
 =?utf-8?B?VG9JRnhKa08wSWJCbVk0K3MxZ2F5dXJQUHdQQTgxU1FNMzNTQWZtZ1lRVEx3?=
 =?utf-8?B?azJoK3d4YzluaFNXaVNITUFhb0ZhanJXNE9sUGZDT1lmYlVra3ZkNWJMdDJQ?=
 =?utf-8?B?QlEyUm4yNjdqZVJ0eWlOM01BZk1WNnJibEQ2alRoek90cFhRczRJNmlBK3ZS?=
 =?utf-8?B?RUxrMVRkK0NWdDBObHJFdEVwYlFidUF4WDhXNDgxcDhaYlo5djdsT0pPTTU0?=
 =?utf-8?B?eWZQK3BJQU9hejRJTDVDV0llaExIbUFEeDE4c3FRQnU5NmtYQlc2Q2Q0NUc0?=
 =?utf-8?B?VVB0MjRVZ0ZkcVZOM1ZpL2c2eWZRLzk5VURaOXI0c2N5L1ZNbGVoYUYrTzdT?=
 =?utf-8?B?UVlKWmlzaG9Ga2t3MEV4M2R4Rk9rNjhIZkVHZnVZM3l6UnZRZzhnMTNYcFV0?=
 =?utf-8?Q?wkc8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFNc2FGdy9XSVZQbUJ1d0dwWVVBT0wvdWsxRVp4anFIUTRzSVpWcUxFLzhE?=
 =?utf-8?B?ajF1NXhjREdyWjNKZEJXd0NlZHEyNktvZlVWRFQwWkxGYnpIOE5WQml1NUho?=
 =?utf-8?B?MmhieWlxcGFkUTdoTWE4QXBJWVYwYUg1TTUvUmlSaTQvOTFGMnNIYTlHK0Ex?=
 =?utf-8?B?aUtESzhLdkhYYUJYNGZVRVRkQVFzOFU1eEZ3Rjl6RFlSUjFLb1l1VlRuWDFt?=
 =?utf-8?B?UkF6ZHdtZStLeHZhZVV1SUVQUmJSYU1yMzMyOGFJL1N1dEg5b1pwdXpoRTc5?=
 =?utf-8?B?bHhaTHBKazAwQzJyeVpUZDNIME1IUDVHMzVXQkVDWWFZZk1tMXRZT3BYSlJN?=
 =?utf-8?B?Q0dIRWkxN3grK01uWjY0SjNmWDFLdnJ3aXRUeWFUVmtDcStZU0p1Y0RtZjNI?=
 =?utf-8?B?WXp0ZVlpVUg3blpuZjV6cktNSmdUeWkvVWNlelZ2c29HNGxtWjl6MWlONU1y?=
 =?utf-8?B?KzlvRkROc0FXVE1DMERZUEE4cnpXbFRNUFFWTFJkY0t6cEs2dDBhaE8xVVgr?=
 =?utf-8?B?Q3cyMWNLN2tzRGtnaVRZYnkvL2dENXhPNFQrcnA4VndINEt3dmN4SWFWZW5X?=
 =?utf-8?B?N2R4ZnRyTWZjSFM1UU1oU0RDMFFNOXo3MHBtME5ETU9tUCtDelZBc2xjNERF?=
 =?utf-8?B?OGlrNDVyRkRwQ0FvbUtidWYzR1RYRzZwbzdveEJVdzFmUE9kVzVtK3huVGdO?=
 =?utf-8?B?Wk9GRG9EbDVxMDRwWXVjUTlIdEFNMSt1ZVZVQkdhYjVVRWhJVnVNam1YY2Nx?=
 =?utf-8?B?QWdpZXAxK2IwMVpLUHMxbGVFS09KeE9jUnhmeFRhRDlScXljZDVRRjRjSXZH?=
 =?utf-8?B?UEVhMklBbVJUc3BUaFp0K3E2T1ppOWdMcFJ0bVNINnFycjZSRFpnd1JMYmw5?=
 =?utf-8?B?eWpBM0p6ZnE0TXVoclpvZGlGYjFjSmwvQlVsQzF5ckRCdXBjVzYySWNIYVRl?=
 =?utf-8?B?QjJFbGFQb29IeElBUWp4bVl3KzlMT0ZiVE5FMGFKM1kvbkN3bWI4bEFhRnUy?=
 =?utf-8?B?QkdpN3FudWRtUW9NQnJncFdWNXRXTWczRC9ocVRCNXFWYVFLdkx5SDdYaDBs?=
 =?utf-8?B?U2ZtYkViWnJXVWUrQjJqVDdsYk1XWXlGMGd6TE1MbkRkZi9Da05qT1RXRXlZ?=
 =?utf-8?B?cTJkSW9VQ0IrZ1NIR0dkODQyM01PTnBCMFhTVTJrV1ZOYmdzb3FMTmpGZUIz?=
 =?utf-8?B?eVhtb1FuSFU1WHlYOUZHQ0hYNi92anZOV3FYMThDb1lPY3JnYU9vZDJGR0Zv?=
 =?utf-8?B?SHJXbmRpKzhxaEEvdEJCd2gzcVQ3ZFlPNi9HWG5hTmpwK1YvMUdXVmZIRTRa?=
 =?utf-8?B?WEJjT1laTmVSS2s0RktwYnNxUytvWDZsa2J0Qkw0RkVlQzlJb3BoamluOGJJ?=
 =?utf-8?B?OXZSZkNENk5PcnZ5SmY0a2M5dFNYVnFBaFpSMDRLeVR1N01FdXlmYW5VTWcz?=
 =?utf-8?B?cm9sb0lFZm1nN0tzN2Zyb292Y3NzekVUd2xFa0ZWdnV1a1dOa2N3RU9VZzJC?=
 =?utf-8?B?cnpiKzAwRzZxckJBK254YUpMSVlZTWxYVENoRmVlNGlrcCtvOXQ3bS9rTmcx?=
 =?utf-8?B?ZjVpc29xa1lsWDdRUDBYUkNuZ2IrZkZBdGVvdmwwUVNRalZyanEzSGt0L0lP?=
 =?utf-8?B?UjZ2bkFqUXpJU3Z5Z1lkT3ZlTGVacjdEMDNiSU1zTHFWMGNsbnBtdkRENmgr?=
 =?utf-8?B?L3c3ZmpXYStnTmV2NW4xaWNGYld1eExUWndvWm5WcURpV1dCUWZCVXI1N2hR?=
 =?utf-8?B?LzAxT2doREFPZTViekR6aEM0dzJCQTNOemtCNkc3cjJJRFVlajZvUGQzcXpt?=
 =?utf-8?B?YWc1TXlPUVk2OUdEMXg0aE84V2JvQUZuaFFncjlRRUxLMEI3U2t1bGcwM2t3?=
 =?utf-8?B?bWdodWZoVFkvcTdCcCs3bDQyRTVrZ0t1aGZKMlJnUE9sRVpkMXVHd1JHd3pq?=
 =?utf-8?B?NS9ScmJJMmtxb2VkM1NqbUtYYVBJTlM0WlJ5RitKdXlQVTM4bXN3SlpQUmlR?=
 =?utf-8?B?VkI2eTE2MkdxWS9HSVN3cXhsTHAwbHNGRGg1cUZOc2g3Rm5IQm1mYzc2WmFx?=
 =?utf-8?B?QmVHeG5QdGYvVXRndkZZek5JTzlFRStuN1k0ejFwY3o4TWVXb3ZENmI2UEdJ?=
 =?utf-8?B?ZjVzbWpjenZGeVlxOW9GSDB5Q1h1ZEJLc3NwMDlVS0Q4d1o0dEM3N3NQKzRi?=
 =?utf-8?B?YlZMU2szYzBCQ2t6Tlc5dDhSaWptS0U2MHo1OXpjdDZwZ0UwOHkzR1B6MGFl?=
 =?utf-8?B?N2NYNmh1UjdIckhxeDhwZk52WXRlY1dHUXFsKzE5REEvdVVSNnZ5ajBCTHQ1?=
 =?utf-8?B?ek1Wc1JLNnIwUElINkx2dVVsWE80OW5ETVdCWjJ3cGd4ZHYvR2FLSGZYelJ2?=
 =?utf-8?Q?UV0Nid/k5xdavBj4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 207d5a98-b752-411a-bd3a-08de5a1fbe7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:35:52.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVJ+p3QAA/BDuScdJsTdu36QP9PKh/8AvoHYkrjAN/8NO5MVeaHKfqO2O3MZTxG4/+TtqBc3uAtG4z+GvGJHhSeZaV+WHAoPX+ag+x78YOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com

I will change this subject to "PCI/IDE: Fix off by one error calculating VF RID range"

Li Ming wrote:
> When allocate a new IDE stream for a PCI device in SR-IOV case, the RID
> range of the new IDE stream should cover all VFs of the device. VF ID
> range of a PCI device is [0, num_VFs - 1], so should use (num_VFs - 1)
> as the last VF's ID.

This can be even more succinct / to the point:

---
The VF ID range of an SR-IOV device is [0, num_VFs - 1].
pci_ide_stream_alloc() mistakenly uses num_VFs to represent the last ID.
Fix that off by one error to stay in bounds of the range.
---

...but otherwise this looks good to me. Thanks!
