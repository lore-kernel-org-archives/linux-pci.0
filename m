Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010F27380A;
	Wed, 21 Jan 2026 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958375; cv=fail; b=XhWk+nY7Bv8icCqsKzUY3KFlPKz6Pioo1BmKg9ATXZezd5ov7nyL/CifaPLYMuv8eOD6VBfXq8YVMjBCao9f2k8rCtHs78Vy1bjpTrHLfZRvTTvvXW4dU8J0pz0bRi++HdZ0/Yz2TGk6iSd25DnH3S9Vv9rN2Wc/qw7LRIocLuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958375; c=relaxed/simple;
	bh=Kr3pCMPIxNsTEL7rpWxKOgWv7XwRlqKiQlQA0XBP7t8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=FLTkXcIuna1nHzA9d+4UhxNhhHvzT32XoZUeGJy4tFwnKwRTeSB/j9zCqFxG8NOOglH+mXvd3PIxW9o6yyxNJ3gsInj7i5ALy5fnbDj3p6gsPnjlFyLSiz89P7KR63E3URSAC8aZGR1pzB7CcCo54LFs2/i+gvDAV/JldE5U6Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcWAo3ln; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcWAo3ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768958374; x=1800494374;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Kr3pCMPIxNsTEL7rpWxKOgWv7XwRlqKiQlQA0XBP7t8=;
  b=QcWAo3lnT0XUGYsOe5pIHvN3pxN1Tou24FF3hJMelG/GxRh3MREnzx08
   yqDO9ietVJaTv9GatGMNmUARapWvB3UGFaa2St3eozhNYEBO9vI9w1G05
   +HDynoR2hw7bdcoo3zZbczQwuXE46FVoottB/j29IRxhrvW33p3iu2WhB
   bl4CcFhrmeaFIs3/h+m7yi8R47Gx4xvDuUTkF/f+EEoO7RMJmUJKJvOBw
   26aBrnuDiZO8KzXzmFPMvOdncJdotbkhRP6ksP1zvpOclx1urEcfWbsOa
   9+ZfMtc8z6s5552cPZDeyJYz0MP+iCrOsGID9+YjgAqbHTiJAflOiCwCl
   g==;
X-CSE-ConnectionGUID: MdYupdYhTu2fIFFWrIA9Ww==
X-CSE-MsgGUID: NDIAK5m4Tw+N72erD5glpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70234654"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70234654"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:19:33 -0800
X-CSE-ConnectionGUID: iXb6tMJrQDOclSBBYJeWbw==
X-CSE-MsgGUID: ylWMrVRgSgWevrCQBvej7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229243970"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:19:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 17:19:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 17:19:32 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 17:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP3fUk1K5Zsp92RqOEce8JU4Qmo8mQO3MFrPqnITtTc2eD1Jb6QtbGZHlUuqNeF8X/SjntXVT4eGPud5SYMkztOHs4Djz33FdJffPsh8xjz3Bs17eQc8JcsXutZiRGH6g2UJ6tGokrcPG09t6lAQdGZN7WTKJHDdyYsv6w1cRVNkEfIrHvHqI2503fqtROc5jcMViB5eFVJ7XVS16IzLmaj+DbnMgtm7gQFGxjcGLN0iU2wY1LL+UKrBbXnFHy4Dm3xFhLfqeL2kNLxBCRvJgn9T5nq+UamWBsGh1PT6OtVBIIUX4yVgbahx+h1nMJVWp34oSxt+G1tXXLwXKhpB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elew3/6q3P2oghM9U6o3hc5ka0/mFv3v4TOse7qckC8=;
 b=eAsxjXguAMysgEk4aLgOECfo+c2mAyLexvqY07pwXrncu+tnGDJBMV06LWgkO01/gL9EO8fO3QJFKQAfOWvgOq/YBzBdvBzOoPj7iMJYIgAonOHqSz1+Mk54uSN359fVK07d/wloAXFYoKZKfPv3i+Kqpd7TKLqa63IoAsQ3xelfkqEcOo9Akug1zN5GVzNtxAEovLShqdaAA8JMSVrhf4xVyh6+I23lG6j5prgL5zNupcKtqWlQauNbADyjJ3rOXUbaJmsVjHpoJtI37qFeCMfsI2stvzLmfXnUTzwG02wXCGz3PLqFQeO7uFiB4MpCqH9D2aoeKxogFNM4uO/NMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF085B02B26.namprd11.prod.outlook.com (2603:10b6:f:fc02::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 01:19:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Wed, 21 Jan 2026
 01:19:29 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 Jan 2026 17:19:27 -0800
To: <bhelgaas@google.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Message-ID: <6970299f9ab88_1d331002c@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114182055.46029-4-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-4-terry.bowman@amd.com>
Subject: Re: [PATCH v14 03/34] PCI: Introduce pcie_is_cxl()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF085B02B26:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4f1dea-29fc-451c-f2fd-08de588b201f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkZGbFd5M3NXaUo3ZW1TZDk3MWMzTEtqTjN4OVY0LzVJbEhtNWdiUG81RXVj?=
 =?utf-8?B?N3NzbHcvOHgyMUp6K3NQS0k5WkNtaEljVTJRSDdTa2FibmIvTzQ0RmtKaGs3?=
 =?utf-8?B?RWs2Tm1YckU2NlNxRkUrSDgveGR4ZFQyYXdINmJ3MjV2NVNZUmQyM0JkbVJa?=
 =?utf-8?B?eDVKbnp2WS90azlwU2tiUTNGU1d0L0ZORmpLV2tzU0Q3dWRBSU9yUng5MmVm?=
 =?utf-8?B?SXZYUkxHZFI0ZGlOYmRweUdiR1JwZlFWU2lEb2ozaFgxYTBTa09SSmNxalY3?=
 =?utf-8?B?eXZBem1rSWp6TkRodlNGRjFoeWJHUkE1RzF3alRVNFdtMXJ0MGlldlJZazVF?=
 =?utf-8?B?U0E1K1RiTmVGelVOcXMxWnpibCtSQ3RMajN4MzU1YWtQczkrT1lqdDR1bEZC?=
 =?utf-8?B?VFlOeXdQVW10azFLbFU0eDVvajBnb2ptV0U2Znp1c25OZHpPcFd0Z2xacDVG?=
 =?utf-8?B?Y2VFZVZDOXdGWXFNZk0zV0N5Qzk4VFFJeHliVDJqSzJxY3haak9rWHhtdjJV?=
 =?utf-8?B?WWlHUC94RWtEQjFZb01ncjl4REtVKzZLdTQ3TWNWK1pITG96N29aSlhsdzZU?=
 =?utf-8?B?ZlRPRlBGZmRMSmUzMDhDakNpdUIrSUcvd0ljclpJVUpITytqVzhzOHUvZEE5?=
 =?utf-8?B?Tzl1aFVBTG5JOHErSkRLUTJPWkVlR3RzOG05VEwyWU5aM1NVc2J3ZTFUbVJ6?=
 =?utf-8?B?V25tNG5RY2J2WUhrSG9uQVkzbitnTjZkbUFseGQvSHZucFVkNUt6ZXJNcnBO?=
 =?utf-8?B?TVFjRXB2V3RQd1ROaTV6TzE1emhvbVRJaEFTU0VTbGhyOTE5aERRc05iL284?=
 =?utf-8?B?dnV5enYrZWxzZE5FcnRBbTN0dGI3M05YbjhMbktnSlcrTVlLTkhmWlNBSmd3?=
 =?utf-8?B?K255Y1o2a0w1eVR6a1lLWnNCSFg0QW80Sjd5MTBaVUVzU1dNMzhxc1pEaTFy?=
 =?utf-8?B?MUJBU0dhNmFBaGZGMzFhRUVnWEVWYUZiaXZHQ08zdjVJZ1JIdUZRc2grS2Nk?=
 =?utf-8?B?dHh5dzB5MmZtUTNGMkd3S0ZJSjRFUHVrV25sQ21lZXpWQ3JkWWhvbmlNK216?=
 =?utf-8?B?QXpQTXMxbWRmVFR6REFuVDlqM1FnNlJJdlJiRDBDaEYyOXk4VDRVVXNjL0VC?=
 =?utf-8?B?dmIxRGdobUtZSDNBLytpb2xRM3pDMThWY3ozbzM4cGZvT0tTeTl6Y1h0YURi?=
 =?utf-8?B?U0dqbmFQTHNkL2NMY3FqNXp1N0JNVU5maUdsaGpvNER2RW01K3FoOUJpWEdG?=
 =?utf-8?B?UDVpVkVjaGU5cFhpakFHeURnako5Z0FsSm9wV1VMYVBYTFNEOWFpdTcvNzh5?=
 =?utf-8?B?MjBOUUY3S3I5SHdyMnlMY0VOMDF0QjhuS0kwL2poNlZ4L2xMdDJQZG5IWDlp?=
 =?utf-8?B?eitSVWFBdVBDdkU0MUdnQjlQaE45Nlg4MjA5T1lIYXZ4alE3L0J6eFJqYitO?=
 =?utf-8?B?alpQUjBpMVlPbmNzM2RnbGdmemhkRTJzZkdZUEpadEJJb3o1V0gyT3VDZmZW?=
 =?utf-8?B?ODg1Yk5zWXliN055ejgyb3dZNHdvSmNxbFFFa1B5eEdpTnovUXVNOXdjMXoy?=
 =?utf-8?B?SmphVjBFY0o5Wkg3T0hOcXRWRjlUZktGeTZoRWgrOFp5WVB3cWJyYnZ5SkFh?=
 =?utf-8?B?TEJrVzg0OGgvdm40NDNud1IvUkZObFdLaFpwQm93RXlXUDhCVFUxZVlBdWh0?=
 =?utf-8?B?cmoySm1icHQ5OFc1eDN0RmxlT0N3VFY4QWxDQjdSa2NtRitrdE1pRUhFQUd2?=
 =?utf-8?B?UngxaHgyYjF4VnhXRmp4Mkx0SDQ2czBzUlcxS2Y5d0xtWXBJTGoxU2NpSVYr?=
 =?utf-8?B?SCsrVTlVWU5iRHNKZW1qRGgvdG9YOE1qRmxqa0VKbHBEUmRycE0xa3dhOE50?=
 =?utf-8?B?YzNIMjBHVDRabW8yYWNnNUVxbU00Rlp6dFdDYnB1VWlLSVhUOXJBMHV3ZkUr?=
 =?utf-8?B?OU9GZmtJZ0E1ZzZxTWtKNXpaak5sWXZ3Z2FQZmVab0Z4REtwM2Z4UTBid3Bh?=
 =?utf-8?B?Z0tJdVNCMGpRSStxeFVkaC9QdThwUUxmMHNBM2cvQ250U05nTkNwM2ZxSXVK?=
 =?utf-8?B?WGRsWjFNT3NKRGY1TXg2S1NRR2FJUGtPYTQwWTVoQUF4L20rTnpDcHZIQitl?=
 =?utf-8?Q?qECs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmkyUmw0ZHQrUkZGSWJwSTBQQWJ0M0xPcWNLWG1nTHJINnpGcGZIR3dxay9X?=
 =?utf-8?B?NTNzRHZzZFAxamd1enVYVlpQZVNLZjRBVVlaRno1U2VBM0RlUUhraHUyU2dn?=
 =?utf-8?B?VFM0L3czL09XdVptdnZGOUFOY2VJeGZOOUN5WkhGK3RDbnJ1UW5zb21lVTd6?=
 =?utf-8?B?ajRvZ2ZTTHJ6UGlVVFZjMkxseER1SDVEdjRxaXlmdWVuNXJGeXNiQnlhOFQ0?=
 =?utf-8?B?aEtDNm1VZTJMRkg0MEJRVStBSWZLYWhHbWJUVGZjd2hYcFFCNmxlT0JRNlBs?=
 =?utf-8?B?Um1vdlZ3L2NYMHViaHdRWVJlYnpRTEI2eUFZMVY5aUlSSmNodjF3RnBSNko0?=
 =?utf-8?B?YmlFN01YbTZKdDVyT0ovWEJYRFFUSE9ZTytxSkpxc1UrdndxVlZvZURJQkx6?=
 =?utf-8?B?bmV3aFVVbHJhZzI5OU1ESCtGQTBqUTZZZUpubW1oVWxCRCt5eDdqd0dTclkx?=
 =?utf-8?B?STVWU1VzWGc5d0R2K3Fna1N4ek9JdXp1bjdlMzU3UXAyeFFQVGpxWlBaSUE1?=
 =?utf-8?B?OEowZHllSzM4VksycFF1YW92b0tNWFc1WnVZOWFmQ1Q5TjhGMWEwS3ArRHpY?=
 =?utf-8?B?VW1HZnY2NXdGdjN5QzQxd0thWHFuOFhyNE8xNW03MUlTTDJVWjJNb1B3UXVS?=
 =?utf-8?B?bVRwTzVzSktWYVQrZ1c5eDBHUmpzU3RPVU5hUTk1ZG5xaWNnbEk1cGx1Sm1X?=
 =?utf-8?B?dEg5QWZuNFEyTFM0NmtFRC9oTTZSdjZsVU9qdlVHTnU4aVBvTkNYamdOZzN6?=
 =?utf-8?B?ZDVEdjV5NmpOMjlyem9VTWRSWVE4L2tod0ZNNGRvSEtpUElEdDlXdXhJa05D?=
 =?utf-8?B?NGpsOXZIQklyWEJUWFVaSisvU3U5YkY1UlRQZVpXVGJlcnJVaVpEZ0NWaVRW?=
 =?utf-8?B?VzZSeDlXcDFheGVkaGFZQ1hNdTFRYUFpT1hRMExTMk1DeHBqeFBlM0ttWnlu?=
 =?utf-8?B?Q2pQV242NkFReVREMWY0UVhSRWtiazcrckgycnJ2b2ZjT05HczEzcXpLbHNz?=
 =?utf-8?B?b1pPTXhnR1lYYm5mZlM5YTZwM0UyVUZUK2NETlZ6d0QwdHBZaTFIdkdublVU?=
 =?utf-8?B?dDAxdkVKYkovV2Q4RFRzL3JKSTViTlBycTRkbzhBTW1wQTE0aVpyL2ZoUy9Q?=
 =?utf-8?B?RG1HTGVxcG0rQ1FmMzFKUGYraWV4T3FmS1RyTHFrU0lWeXc1aTQ2RzBGbjE1?=
 =?utf-8?B?SGlTQ3VMOXZuVWNVQkJHYVpLajhmSHRGSmdPYjhOSmZVQVRDRFJRS3hIaUtQ?=
 =?utf-8?B?RFZneU1QcFBFM241eDk5MDR5TkFLUFlOWW9iYm4waWo0cVVWdFlMeTExRjE3?=
 =?utf-8?B?WlpDWWRONCtoSGhEQW4rZTViSGZXVDRTdDBCNUJURVRsRGVGRm0zVVhLSnlz?=
 =?utf-8?B?bExUdU5OVG1WV3hVVE01Y1hDdnN6QlV2NXIwSWlFYm5EeFYwM002QS9HTEdx?=
 =?utf-8?B?SWgybFltWFBvWkUzRVE5bjBobDN4R1JRS2RjK2hWNXkvVW9JZkRFbm5jRGNR?=
 =?utf-8?B?N3dPVzFQR0pyT1VVeTliaEJsQ2tuaVlyN0JaUW9HWVRHZklCdXR4a1g3amtJ?=
 =?utf-8?B?M1lyRmE0NFliUjVrYWNTbkNQK08vVWpia1d1cEREcFU0VkcrQWJJQ1Q3amM5?=
 =?utf-8?B?WVF6dlE0bnBGMDBCSVJIMUdmTmFpZ3R5alJBMnpoeWZWbHlMUmhQcmkvWFFi?=
 =?utf-8?B?dVFwWk1NdVBqM202T24rZ01acVhxMjRkd1RJZU1vL2Q3QkdGQlRsbU81Qm4x?=
 =?utf-8?B?OGZ5aUlSek1UQjFpK3BJdy9kcVNXRlhBWEQ1MWs0ZllrR29nZFR2VXVhUFFi?=
 =?utf-8?B?cThVVVFxdTg5QnBPdStBTWFlUmh1UEhsa2dMZUJQcXUzSmpjYi9WZTRnbnli?=
 =?utf-8?B?QmQwREVjSTVkQ2FmS0lRK1czaVpTaU9QRW9KeHdDUmI0enhLYkEvU2tLYkIz?=
 =?utf-8?B?NWJqak9RTDVWZnBkRXZNYVRGV2U0QzM2N2tqbFI3T05DVG13YkxnMVBzeDlh?=
 =?utf-8?B?TlFhakNqVGVEcVNUNk96clJDYUlObDRGQjJWYzJkS0lkZGlJT3pkeFBzc0dv?=
 =?utf-8?B?OGhoam54TDNHUzJ0dGNxSUc1eFViSDF1akJkTEFuMll0eEhDZldCd0VkUS9w?=
 =?utf-8?B?QmpocGloMWNSdHg3Y1dzQ2JLTml3VlFpMjFMOUIweVUzcW9hWmpodXljbm8w?=
 =?utf-8?B?TnhLQkpWWEQzMDZneDVtcEVManp2SmRwcFZXK3hzZ3ZnVDZ5eVYxdnAwREcr?=
 =?utf-8?B?RWFjTWVyM0kwUFZEcXJaZCtiVFZKSGFaa01LZzU5eVBGMkZ4b2JDaHA1M3Rj?=
 =?utf-8?B?ODBRZVFDSk1sNDJ6YlVILzdQWkZHN3crSmlsZGZXbEp2RjhyRERvMGJ2WnpC?=
 =?utf-8?Q?9bdj8Gar54rne7+U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f1dea-29fc-451c-f2fd-08de588b201f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 01:19:29.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdSkIWh5afjO4eAYWh6aMGEZG2q231r/Ektwpiwn/xSrNDTZDW7WMIR2MV4KXfSxAJDLefoDXnNud1R2DYI63JD83hM3yTjCYBakTDoLB8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF085B02B26
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flex Bus DVSEC status register. The CXL Flex Bus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> Call set_pcie_cxl() for the parent bridge. Once a device is created there
> is a possibility the parent training or CXL state was updated as well. This
> will make certain the correct parent CXL state is cached.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2

Hi Bjorn, this is probably the highest impact change to the PCI core to
enable the rest of the series that does not yet have your ack.

I think the changelog could use some enhancement to highlight more of
the "why" than the "what":

---

CXL is a protocol that runs on top of PCIe electricals. Its error model
also runs on top of the PCIe AER error model by standardizing "internal"
errors as "CXL" errors. Linux has historically ignored internal errors.

CXL protocol error handling is then a task of enhancing the PCIe AER
core to understand that PCIe ports (upstream and downstream) and
endpoints may throw internal errors that represent standard CXL protocol
errors.

The proposed method to make that determination is to teach 'struct
pci_dev' to cache when its link has trained the CXL.mem and/or CXL.cache
protocols and then treat all internal errors as CXL errors. A design
goal is to not burden the PCIe AER core with CXL knowledge beyond just
enough to forward error notifications to the CXL RAS core. The forwarded
notification looks up a 'struct cxl_port' or 'struct cxl_dport'
companion device to the PCI device.

Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
status in the CXL Flex Bus DVSEC status register. The CXL Flex Bus DVSEC
presence is used because it is required for all the CXL PCIe devices.[1]

[1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
    Capability (DVSEC) ID Assignment, Table 8-2

---
