Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297C357A4A;
	Tue, 17 Mar 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767017; cv=fail; b=QWD27RnXwtVLv2eTZcPK3aTLieaEOW+Wk9snOgW5nvUDOS43xxvNZZGGpZna2Kbx4hXhOGoW4/34yhQCcv68TfLAAhl+rB2hP5/wox4q4LLimupOLdsDyaTLpwzkoX1WovUneDy0kgaGR6dMXY0a1ibIBKZRXjyKcYJHrjizMyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767017; c=relaxed/simple;
	bh=GtWjNC6vmM1SwzWqti37EeI8j/TFplP1NdeiT6D82iA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=n/psM2pw885MzRhxxa0DHb25OV8/zPGipMQO005E5G2wJaCMYjX+QYWOZ7bCNEKw2fMoR0aZ0Y/pwM/BV/sUKeWp/HPRj6xlMO3tjQOh59yctEHbwiWWRYOdnjbOGTq2kdDKQmd6WhEz0zaqONbKChbVIKvN4U3MJCICVGxifxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgGfunRB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgGfunRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773767016; x=1805303016;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=GtWjNC6vmM1SwzWqti37EeI8j/TFplP1NdeiT6D82iA=;
  b=VgGfunRB837UGIN+9+7mqOenMKcbZtnen7BmZfc9CyEhQAxtkUWD+N0H
   5vKfn0xmWAaZ1mD624kDbetZXSBKj87H54KTlxpEVGrtyN7S8Dp7BEWjS
   ocDhWMugmfSC7ACwJY+B3pamChRddel+sfDa1Z76cAvG1GAAtJlpt1N55
   SXoGgPyaXpIaKIlYQJtje4iisFsl5DXCoG9Eiiy48NPVL0m3VvY8Ez8+h
   X/KtP5RQd4xY0Yl06vsELHBmY9BaQr273dUKC/3p7NXHEThOFrvC8LGjN
   au9l2bA/eh+uo+E3ifHxv0cym/10I96DgK9yQqPdYcHF17k8GngarAYd/
   Q==;
X-CSE-ConnectionGUID: kasFFdjiR1ib0ZCqV8n46g==
X-CSE-MsgGUID: LGF1ATrmQfubKdziEzb7Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92189739"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="92189739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:03:35 -0700
X-CSE-ConnectionGUID: yqX2thbwSmaVpgu11m+1UQ==
X-CSE-MsgGUID: GUvNYFtbRCepwIDvihC6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245348648"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 10:03:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:03:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 10:03:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 10:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyFRbseFurjji/v1qPliCfIMirU0Aj5rZY3ya956d9bRMykebLG5IfKFx6sXCzPRKdtr4t6YnFmAvfEnAuF+4x7E1IpHe1xIbPt76d6zV/eqjHR3ldBFmTPwB1PEVrQWRQ/kzCoNJPqRZ/kh2uYlh5qF1SKtRyRcmdo3eQsBWVyTvai+y21Z8zpMhV414Qh3oV/zdxuAKcD0V1vNPUTeWpJ/B32IKPMPbw/lVCNM2XpxRwCivVL1GZxfV7l8GjbQZvu5IuV7sbZt1KOmydChYXhv67tW0FfisQzAa1XtuguOsWWcrvrOY3SBitgG9sE+QMDJGytBUd3XwEPufoNKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQNPXmNX6d60xigtL8M/kigs1aMiPsE1HyX+FnlgFKw=;
 b=H8g3gSgRYTBQyZJet/TCn+/8MH1K5ItW657cv3wvEoB677iGXmLkqVg0GrJFpQAmBb7X/2S6nqTyjxd+eEtUYik4gqBWMo9iD8NhOXKtJk1bfQTFU3Ulb6A5unRJvf6zIQ6zFLSq+pHsoEXY0FEo9ok8uz3+qtAK6wPONvymR/2hE3kablJ+b4/taiqGqMqF5FYkX5vEl/55lbjSCpiLOfJZH/Wellwd+FlTryl/lHqUq9SlZQepCyvkjwpG5CuI9olV7Z5ywzp3xp0XbMFyaYZbdKlgMots/+/0u+8e4HaXfulWzC9nJaFBIU/FY4FCOn0EztUf9fv6G7OReDH0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PHXPR11MB9640.namprd11.prod.outlook.com (2603:10b6:510:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:03:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 17:03:30 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Mar 2026 10:03:28 -0700
To: Manish Honap <mhonap@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
	Alex Williamson <alex@shazbot.org>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, Srirangan Madhavan
	<smadhavan@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jeshua Smith <jeshuas@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Message-ID: <69b98960907e9_7ee31003b@dwillia2-mobl4.notmuch>
In-Reply-To: <IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
 <69b08f8d8eb97_490a10042@dwillia2-mobl4.notmuch>
 <20260310164630.7abeed30@shazbot.org>
 <69b0c934b2793_2132100ec@dwillia2-mobl4.notmuch>
 <IA1PR12MB90304014081461742C3977F4BD41A@IA1PR12MB9030.namprd12.prod.outlook.com>
Subject: RE: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0058.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PHXPR11MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d12e0c-9d53-408f-6f80-08de84471d8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: QKbo7pZC8EwjpLw2fdNtkUj952rwYOAI3iiAtSg4FcEeM5lWI3DnjY64Oq/ELxzbcz8wTjvBXHfdDVzfHSWsoPByKu5OEeGLFczn0PAh63l8n9xkuWB/anE9zGkck4JduH2YDnZzgyWEIY6EphmVHMnJtSdLSSzLpr5eKLBIhXa3n0TZclTHZcYCekvrH4YNLCute5RYJ53BUp74rDyOetDZs+gL1KCwqgkLX+oBfrb0XnGew+S1DqmVNGddw5PRxp7FNJXTKc/tQa5fpnPwI5mZfkgSiN2L1ofJL498PNMAE4KPJ5aBV4ok8Gl8wb09EaoGZrYtSDo4do7FcQ/eYXaCcDmTE8zQL9NQtSzg25lQq7GcCaCPfkHtaqaeo6PuIDXd4BjAL5Zhgi+tDDKuDveP2NlupGt19ejKBDJLglEHqDdCPTvo4hMehPBtNGz3kW6CCVVVdbLIkZBHd762+ygrqnUNMmNVwPudAsVXxhXrSFfegm4qX9POAcsp9dfmowsl/IEoDDabbC+zsXnqhEtLiGI+c8XG0kzVuBtxsUXAaNsZdvx2srIHGnnLbF0hQ1+kNO6EXsJhswv50uQpmVl/1ae6JLSJB+X736ZHXSXWxGGqJghmcDK2fNPGHVxGfpL2m0bAGEfwxhxOphX6LWJtVLNwalkKcLlv3z9sZwQ3lknuIMFA4vSBpGJiANaThPc9AjNvd7/UGEtiSnLoBMpnMxCSl6q77QE5hykYKoXthzZW7xWqt0aPVO9OYJ0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJ2R2RDRUJlS3BpaUZ2M0hLbUtzUFRIYzZPWlYvRDlTWlVIazlQOEhuaFRm?=
 =?utf-8?B?dzBrenlYN1I3eGJ3V0MzZlFNeEhrV2FGZ0xhMzdMUmtTdlBTZ1JzVFV2WVBp?=
 =?utf-8?B?cUNXUml2Y05tUkhQSmx0ODE5MWUxSkVmWVMwaHJuR0dnYy9jdVU1NS94ekpH?=
 =?utf-8?B?elE2WW9hU3hGMEs5eDMzd2RySnQ0QStCQkNsTGZMQzdydUR4TzUvODNEZGVY?=
 =?utf-8?B?dTRyTUFSV3dldzhDZHpSOExYWUxKY2RMQzl1WVEvbDJENDI5NmlIb05xUExS?=
 =?utf-8?B?RnNBNnhXazVibEhXS0FHUDdtSWM5RVRZanVFVXF1cDloVE1KbmdCMEEvOUxy?=
 =?utf-8?B?VHZWWXdoT0RZb2pCOTBXMjQzYUg3NkRPOWFIOFVDYmpJU1dwRWhBOGxXSUs2?=
 =?utf-8?B?UkcvYTJ6STlkS01pS3FZZXhGckRLTXVLQjVpQmhPZG5DTkdzNkhzVTMvTzRV?=
 =?utf-8?B?ODlaMWtwNXZlMzV3MFRHcTdYKzdXWlFEQjVLekFZQWVOcndVckRKZTZkTmRE?=
 =?utf-8?B?dG1weUJzaU9RaFMxOXQ1b04vRmpaYVRRK2xXcER0RDZJNFhYR1l3TFRGQ0V5?=
 =?utf-8?B?TDhjWnpXQUhUNzhpWUM4bmkrOFdOQkxpbzJQR0xPVDR2cG9sd0tTUklhUGc5?=
 =?utf-8?B?bWxPQjB0TzRJTjZiN01DYTdLZkluMlE1eEpiOTdNQitTVkptSmVObHdpN3Nu?=
 =?utf-8?B?Kzg1WXROVVhVL05Ja3h1K05EMHJaTE1DdEpoWmR1dm5SZ2k3czRubXpRSFp6?=
 =?utf-8?B?anZzemtqWW1mNWxCQi9ocVl3dWNHa2E5bjZ1Z1pWRUNvTEFGUUYzUC9iWDNn?=
 =?utf-8?B?VXZEa2JiMlR5d2N1S0ZZcVN5TVVXZnA0MTJwOE1QcDBlQ0ZUOEx1RHkrK0JG?=
 =?utf-8?B?OURLcGRaT000ejdhQjJHSmxEWjJBWm5HWmN3SVZLcFF4Q3gzZE01VUdybElz?=
 =?utf-8?B?d0UyZXhRdmcwdzR5S0pZODNkVjBmb1REWU9xUVRpT0xrU01zdzBvd2RKdXVF?=
 =?utf-8?B?VXQrTDlOOW1uRzN5bG5TZVROQzk0L3BZUFpzRGJvK2tOSVJadE9TenZNc2xY?=
 =?utf-8?B?Y0FEWGJPTXFaMDdELzJ3OHlVWUR6aHVPTmZObkRTeCt1K3hxek1oTXRMYVdo?=
 =?utf-8?B?R1lwMUk0Qkp3TjJVTDR3WG5UODdWVzRGMHdUdmRXS0hxV0FkSHlpcGh6bDdx?=
 =?utf-8?B?WHJocmJZQUFybWx5Q0xOcWpRNE9nMHZVaVhjRnA0VTEvekZjNHp2NWRXMG1D?=
 =?utf-8?B?Q2J0Um5zMUdFcm9YbXM2dFhCSExYdkRMclQ5NWNkNmQ3ZVZDcnAzM0gwWXVp?=
 =?utf-8?B?bGFjbVh6bTFHTU5lSGFsNlhXM2pDeXBJN0xBSFA4THVOcTZoZW5qN0ZZVlpW?=
 =?utf-8?B?ZE83L0dXUnUvc2M5WkVJSEdmelZlUkxXMjJUVTRlTk9maEVReFQ4Q1Z3Vnp0?=
 =?utf-8?B?OGlaK3ZITjJMQTRjbndXM3M0eUZFU3F5bXlBM2c5bWpISG42dGNFa0IzNlJS?=
 =?utf-8?B?M3pSWHRHU2xBR3BuR1F6VUlycW9DKzBJYjNhZjdmNzVhcDhSUHVPQnFldGFk?=
 =?utf-8?B?dmg2YzVjM3c3amc2YlpDU1ZCT1VtMjBIR1JnbGlXZ0ZEMHU1d2NZZGZDWklI?=
 =?utf-8?B?OFliU2g0NGxuTm5LS05EYXV5QnhmWVVWM2lHeEZUdEZodm5VcWV3c0RuUHp4?=
 =?utf-8?B?dmZoSWpraC94cVlXRFV4c0lIZkY4Z01aRVlpeWlEc1ZtOS9NejNSRnQ1OXNs?=
 =?utf-8?B?SzRQZmJnNzF6YlpXdngrejVqV042YzJPV21YTHh1QmVoNThSZnltcG1tcEl4?=
 =?utf-8?B?a2dlb1NNVVpEbnJ1MmJvWllhUlVMbk0wUksyLzQrYlA2bS9aYWRUTjlkK3U3?=
 =?utf-8?B?aFJ4OWRITm1lMG1LU1dhaEVMQnJJWndNOXJ5WkdyNjcrVWJXOVdLZDlza3lm?=
 =?utf-8?B?WmtqRUQxSVd6d2V3ZVN5WVQ3a0pzSlI2SWxQbis3dDMwSWhVaHlLczd3bmZr?=
 =?utf-8?B?S0ZrOUdtUmVrUnNwcVRNeFJ1WWxVSVllZGdOUk9IdG5ISWgrTm51ekUxTWFF?=
 =?utf-8?B?UXZUTm1lcjlnQnVIWldwbkdSMy8veTZhd29wMTZ4NmVCb1JXVDBHK09kQXhC?=
 =?utf-8?B?cXpKVWVHTjhzS0xJSW1Cb0dURzlQcmFRNmVkVHlYNDZGYzEvQWYraXZPZ3hB?=
 =?utf-8?B?bHZwNUcwcHVnRnVnQzNZcnI3SmJ2TVJkaXNUaGVvWWJOdU1yNmJ6cmtCK2c3?=
 =?utf-8?B?WGdZRzJGR1dVcTB6OFBtQVV4ZC92bk1ZaWhDdG1udm53czNwRVBTRHJwYWJT?=
 =?utf-8?B?eXhEZEhjUG5JdEgrNXF1OVFtT1JIU1V2Vm1rSngrUm02a1g0RzJhS0p3Uk9h?=
 =?utf-8?Q?aVQqks5IRXbo4eq8=3D?=
X-Exchange-RoutingPolicyChecked: OmFUIFL1bfBBd3PukIEdFtVhzSeFuwXGNqfWGtPU+NGW4xFzvIS7vtftL8aslt4MlfNitMQlMV7NfUljF2eG9WiVFkFXJHqZNLgcmsw56eSeMFkeK9RnVFne7+pFV8qHHIqeFanBNlp4SLgkB4TrrHhPcyaSzuMFhTvjMsAxLfEGpK0yHMAMwyLZifIQBIxjIAvKiZjLjxu67l16UL5DJ3z/iJdXcvPVjfSrKkxl/1FYcSsznWvWYWlsYhZGWu461Y2xIghxSJUCi2sJuZXMuxxMu0ZKMKDtMDaY5hGaL9FKYnmF37elQiiQMfAV/g9PzhC4gJpixKAIRKYKQ9nDCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d12e0c-9d53-408f-6f80-08de84471d8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:03:30.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okt3NRhteRZO7bC8v40FHsXkD9mK2wj6J3g5Xv0rgGEOOPT8y1kClq/+toH64OM33hdCS/YL0x/zMp9eHjjcZwk6tSgtC+lCYMxRtfHlLUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9640
X-OriginatorOrg: intel.com

Manish Honap wrote:
[..]
> > The CXL accelerator series is currently contending with being able to
> > restore device configuration after reset. I expect vfio-cxl to build on
> > that, not push CXL flows into the PCI core.
>=20
> Hello Dan,
>=20
> My VFIO CXL Type-2 passthrough series [1] takes a position on this that I
> would like to explain because I expect you will have similar concerns abo=
ut
> it and I'd rather have this conversation now.
>=20
> Type-2 passthrough series takes the opposite structural approach as you a=
re
> suggesting here: CXL Type-2 support is an optional extension compiled int=
o
> vfio-pci-core (CONFIG_VFIO_CXL_CORE), not a separate driver.
>=20
> Here is the reasoning:
>=20
> 1. Device enumeration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> CXL Type-2 devices (GPU + accelerator class) are enumerated as struct pci=
_dev
> objects.  The kernel discovers them through PCI config space scan, not th=
rough
> the CXL bus. The CXL capability is advertised via the DVSEC (PCI_EXT_CAP_=
ID
> 0x23, Vendor ID 0x1E98), which is PCI config space. There is no CXL bus
> device to bind to.
>=20
> A standalone vfio-cxl driver would therefore need to match on the PCI dev=
ice
> just like vfio-pci does, and then call into vfio-pci-core for every PCI
> concern: config space emulation, BAR region handling, MSI/MSI-X, INTx, DM=
A
> mapping, FLR, and migration callbacks. That is the variant driver pattern
> we rejected in favour of generic CXL passthrough. We have seen this exact

Lore link for this "rejection" discussion?

> outcome with the prior iterations of this series before we moved to the
> enlightened vfio-pci model.

I still do not understand the argument. CXL functionality is a library
that PCI drivers can use. If vfio-pci functionality is also a library
then vfio-cxl is a driver that uses services from both libraries. Where
the module and driver name boundaries are drawn is more an organization
decision not an functional one.

The argument for vfio-cxl organizational independence is more about
being able to tell at a diffstat level the relative PCI vs CXL
maintenance impact / regression risk.

> 2. CXL-CORE involvement
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> CXL type-2 passthrough series does not bypass CXL core. At vfio_pci_probe=
()
> time the CXL enlightenment layer:
>=20
>   - calls cxl_get_hdm_info() to probe the HDM Decoder Capability block,
>   - calls cxl_get_committed_decoder() to locate pre-committed firmware re=
gions,
>   - calls cxl_create_region() / cxl_request_dpa() for dynamic allocation,
>   - creates a struct cxl_memdev via the CXL core (via cxl_probe_component=
_regs,
>     the same path Alejandro's v23 series uses).
>=20
> The CXL core is fully involved.  The difference is that the binding to
> userspace is still through vfio-pci, which already manages the pci_dev
> lifecycle, reset sequencing, and VFIO region/irq API.

Sure, every CXL driver in the system will do the same.

> 3. Standalone vfio-cxl
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> To match the model you are suggesting, vfio-cxl would need to:
>=20
>   (a) Register a new driver on the CXL bus (struct cxl_driver), probing
>       struct cxl_memdev or a new struct cxl_endpoint,

What, why? Just like this patch was series was proposing extending the
PCI core with additional common functionality the proposal is extend the
CXL core object drivers with the same.

>   (b) Re-implement or delegate everything vfio-pci-core provides =E2=80=
=94 config
>       space, BAR regions, IRQs, DMA, FLR, and VFIO container management =
=E2=80=94
>       either by calling vfio-pci-core as a library or by duplicating it, =
and

What is the argument against a library?

>   (c) present to userspace through a new device model distinct from
>       vfio-pci.

CXL is a distinct operational model. What breaks if userspace is
required to explicitly account for CXL passhthrough?

> This is a significant new surface. QEMU's CXL passthrough support already
> builds on vfio-pci: it receives the PCI device via VFIO, reads the
> VFIO_DEVICE_INFO_CAP_CXL capability chain, and exposes the CXL topology.
> A vfio-cxl object model would require non-trivial QEMU changes for someth=
ing
> that already works in the enlightened vfio-pci model.

What specifically about a kernel code organization choice affects the
QEMU implementation? A uAPI is kernel code organization agnostic.

The concern is designing ourselves into a PCI corner when longterm QEMU
benefits from understanding CXL objects. For example, CXL error handling
/ recovery is already well on its way to being performed in terms of CXL
port objects.

> 4. Module dependency
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Current solution: CONFIG_VFIO_CXL_CORE depends on CONFIG_CXL_BUS. We do n=
ot
> add CXL knowledge to the PCI core;

drivers/pci/cxl.c

> we add it to the VFIO layer that is already CXL_BUS-dependent.

Yes, VFIO layer needs CXL enlightenment and VFIO's requirements imply
wider benefits to other CXL capable devices.

> I would very much appreciate your thoughts on [1] considering the above. =
I want
> to understand your thoughts on whether vfio-pci-core can remain the singl=
e
> entry point from userspace, or whether you envision a new VFIO device typ=
e.
>=20
> Jonathan has indicated he has thoughts on this as well; hopefully, we
> can converge on a direction that doesn't require duplicating vfio-pci-cor=
e.

No one is suggesting, "require duplicating vfio-pci-core", please do not
argue with strawman cariacatures like this.

> [1] https://lore.kernel.org/linux-cxl/20260311203440.752648-1-mhonap@nvid=
ia.com/

Will take a look...=
