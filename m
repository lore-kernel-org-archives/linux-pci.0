Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588516D32D;
	Fri,  5 Apr 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325720; cv=fail; b=hkTLfOAo0RuKy5Lc5aqXx5h9Wm96QQhpIvEAbKkc5vDrnT6LQ33vqSlP1gQ9SBJcZ76v6ldA0IBaqeEgDpVmYzBCtD8NZqhlehgk5I5oHvLAMOSB50I6SZHUm37CM+htdD4Wl6FF44SP28y6JhjIKHrmwbfTj49ADEik/SGCln0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325720; c=relaxed/simple;
	bh=pHpnc90QYBeWgdTGfHrN1sfJulJpShZX0aCLoyB6YIQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkSI7y4jt9Zg9xD96Z3CfxMQnmOPNQcmPt8fWvvjfK9rw74URDrCXhShwRBbU0uBVVL6itmzPAcUcgZDSW/bdRy+4EHVDJuIgrcQTLaNJJhxmRTgZyD5TU3yrSl41fMNpQP5Olwsj5jlxnsqScJ8JAU0t91y/8Ex7VHmv1slu64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gH5W+3Vb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gH5W+3Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712325719; x=1743861719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pHpnc90QYBeWgdTGfHrN1sfJulJpShZX0aCLoyB6YIQ=;
  b=gH5W+3VblDoeoQ9TX06PwZzYCigEsNUMpXAliMmIGRfbE9owggCfa3Yq
   p3Jr5kpwNMm7q+1UP17Y/eCOF34zS248vq+eCZdfoXImkFNNCsSossq/v
   gFzq32KOHDlWxELyBGL480yKw0HgN9jcQeJFtkJ33jOToDphHuxhgxJ6a
   PiDtXB6Ofv1gKruFOl8otQkkd2axFoNiU4UP2yVKDrn+Cfv4UqyM+Q7mG
   mDCvSZ5hptkfeDZuyZGQk1bkI/Wi8xjxLU06BZMqobT94eSZRCQ0eTg+f
   QVCldKwlThlhk+kbBfgVE/2Ck7h+2B2VHmi3xvyuVAA2EvLzNHV486yDc
   Q==;
X-CSE-ConnectionGUID: H8dq0kW1QDWz30DZVoUlwA==
X-CSE-MsgGUID: aFs8RG1ZRKKK2Qt1slye7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="30130334"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="30130334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:01:58 -0700
X-CSE-ConnectionGUID: TQE7lpZyR0yXOSkLv0ojQw==
X-CSE-MsgGUID: Ek7qVqaQRlCJkx9mvGRq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19088920"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 07:01:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 07:01:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 07:01:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 07:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mh9Gh8G7V4KZAv4RQR1+LYAkfC6sutDaL/AbyoC4Bh6y2JrVtg3StKLf/exe8P1H0bDmxaz7TncXHZLc5DWSp1R9MapsCIoRszghS7tzDG8o8CiGOUjjvG+SJJFIWChWURidJ8rP45wPgDULyCWF6YlvEHz1I85vPKy67y9GRk4c1965sLGG9KGEb09X0qvGPOP4D92ILSRoUybBurSqbI0Wme4hDHjuMrBHOwFhCxjoTI0lRaMKqzZYGWrD+KYdzDR1O4lTFluXPYTLQIwpuyL3r8M9m2AJRDoVjqyBl5ei9QI4FnNyEuwH5RjtDqlSqjBw4WYyXigAUbmnQA6EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUXHD+OA/rzMlZyzJDxTUjAKObyQlbURbRmIUSr4bGM=;
 b=mUS68+ve/5USYyEAArUyrqNy9aVbnyfFpEsrbrGGtJsMxuCnrH/R3gXb7wUd+a3dxSE1gpyMuIBo+cTGcBbChERLxk1V0NgTGL4r2yL+4iMLFfxE1MY+MhA/aNogQvOo1Xfxd5FMYMNhdiysdRPXpRQh0sUfCYYSOtvgvVCLSA0ek0EuqD51wJEXvLwiq0f0MIuFBqyk77r0M3UkuyZ2ENhQ9auyU/XUftvcou88BmcQIoPGrpO7XdCUlE6tti2hGmcFeil5pZIoLABBR6StX4Z6hmo7oaUyZB6JX57RvTMd0op/pCG8JxaDC+0VH0dSe4cnDg1d3rV4E10Lp/9BsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CYXPR11MB8730.namprd11.prod.outlook.com (2603:10b6:930:e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 14:01:55 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:01:55 +0000
Message-ID: <1f8af726-9ec1-4c93-a126-6672b5647c23@intel.com>
Date: Fri, 5 Apr 2024 16:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0266.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::31) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CYXPR11MB8730:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZZtxQQ9jgdFL9svPISkF+dx6DYyvJx6El3Fsg1V1CNfe+rk0y6cEZPnYMAcg6VBlZlvpxxl+5RSQLtEmOVZxX/svUioP/sGkC67IuLzQUKiyQHwOvFAVXes+Vo3omQprAeBEQk6fOnXoBHqNjZ/LGe0ir1MrA+QkOq4UmudMg+BMjWSIXsezAJG4eTNkR9GeVyx5GqmS85jTS+ckG4T17IYcwLhJT8T9Do+44il0swdJPP408vfW0aH3g1rV4xn1z6ozGoZeVXmeO+ge8D7ldRafmK9Qjje13p+U5oSlHouXGAomgM+R/aywl4KlHPEL9Ei8kA7/oYabiiNy4OhS4hB0o0iL474fxPLBYQG3E90RPNXewqiqTPXTNq8mcrmNUd8uh1CeWmu6WCVI5rnajT8lJePZc1fZP8b6eCLQbWiq6SYee+ajUepM2bBjkj6eYwysRVJXbLM9cA7jgLoxx+7qGo8odtGx7nUQvPea9OgYPXvkOmT3n2oou0Zd+okREH8AULQnT7VCu8+Jf64DsO+TcuHFl3gm1aBX9wbsbOtGI0B1b9H1tH33G0TsAcHREnfDImp3dr75OKLs+Nyk1xKPpnUovBdMkNd0l1dFjYF4rl1B3dMOCxrWUmnTQLcq6fucVpMyXeQjTXbyfAZPEEoitJOkJ/zb6W5cTX2Gso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3c5MUJ3QjNaQ0VHSDdxc2tObW1nR3JsOE1HN2VsdER4bStOOWJlVEMwdUxr?=
 =?utf-8?B?c3p0cGR5a2lVeVcrZGNoR3o2YkNHK3V4eVBzblo4ODUzY3RYTGlDeHU1Sncv?=
 =?utf-8?B?bUxJc3YxWnJ2UDBJUDNOaVVKekppT1ZPU3BwNTlHSGlGWlhrSzdaWlNYR3Vz?=
 =?utf-8?B?V09ySE0reGJVY2hLWU1lQnp3bXVEYU9Oc2lMQ1REY2NkeDlaWGRzR0QyZUI2?=
 =?utf-8?B?YXg3WlZXQ1A5ODF1aFRZcjQ3WnhGQnpJQ0VXTkNYS0hoZjJLMmNxWVJ6WXdF?=
 =?utf-8?B?Tm92b3RyYmNkMEpXQktxTHpnZTVIaFpBTWQ5Y0wycVVEYisyTTRBR0RVcTZ1?=
 =?utf-8?B?aDBva282MmE0c3JFcmNjVWF3UjRYQ1krcEtQUjkreDZQWVZoR0hmVFFhTnQ3?=
 =?utf-8?B?aGpYS3NheDkrR0RlVERNbWo1bis5S0l0ckhhemtQUkR2a1V1dXVndFBvVVN2?=
 =?utf-8?B?eC95S1hUTUVUd2FaaE9oNjdIWlIxWDRINXJFNmJoTnEwenlXVnI3UXMxbmVi?=
 =?utf-8?B?QWtCMFRraCtLd0RGUU12aWIxaEU1MHA2ekhOemNWNzFyREhpU1M4ZHh4Y0lP?=
 =?utf-8?B?N2NOd1QrSkNjeHM0UnpuQk1idjJTYThpbUI4aHFocnBMTE8yMFdrQ0cwM1hi?=
 =?utf-8?B?MGgvMU1lOEViOGFFWW5McWIzcm03cTQyQTRKeXJ0R2laY2RWbXFMOUlKcGF0?=
 =?utf-8?B?Qkt4V3R1MGhmNGNnSzlaNnYvbS9YU2lRdWJBUzNRaGNtSzRyRkEySDk2ZTFD?=
 =?utf-8?B?cTRhT1o4MURyRWtuMmtRSnZHQVBTNkVFK3JEd0VhdjQraTg4KzUvc3A2QmVa?=
 =?utf-8?B?L0twY082cytqbmJyaTJTYWNrNzZ4RVk4WjBtek1CRzh4anJwV0d3WnRqdEdW?=
 =?utf-8?B?VWZTSW5uR09rcmp4Wmw5NFcrZEEvY1h6Y29vS3prRFFlUlU4dFA4NWhnT1BO?=
 =?utf-8?B?WXB1S0E0NDdZaHROb05RUW5kV1llcnNiZHBHNWVkSkNFYWdEMmFIaHI0dDYz?=
 =?utf-8?B?NWF3b2g5MldpNWhsQVgvdzFNWUxKMnZIcXBheGJrTE4wTGNCS1ZwUE0vYk80?=
 =?utf-8?B?cEZqN0Z5c0Z1UDFMMzByM0JMN2YwSWFkaG15Vzl0T2NNSURQR1BoZmdHTHFj?=
 =?utf-8?B?VnRxNE5zQmpxWkhFZXlVZ0IrR0JwNHJzSWRoRlFxaG1MQktMZXcrQnNIQmky?=
 =?utf-8?B?aE1Ga1U1cHRMTmF4U0NRMDUyLzZLZlhvcXU5SFB6VUEyT0JZbnJnblcxWlVF?=
 =?utf-8?B?NDRLYzFUVmZQK2g4bVd5N1F0S1FSMk04WkNiRDFQU0N6UHFVQzRJRThDdkZn?=
 =?utf-8?B?SGtTbm1ycHhwY2QwbTVhTXJjU1FCeUVxeXdBck56UEFSdk0rRi9TZ2FWYW5j?=
 =?utf-8?B?SktnM2JYWVNLM3pUL3cvdGNPVVFCbTNiYXl2YVJHMnpzUDZROXpKTkVaR0x6?=
 =?utf-8?B?WjhMRHdReDZUM1hvUGo0VkxlU1VFNVJoNlBTU2xIWTZwdjlMQ3BhM0pxUmgy?=
 =?utf-8?B?WGxtR3AwaERuQ29vSmdjT2tsaDhJYzRMMVhqa3p6MFMwZGdseTR4czU5bmNm?=
 =?utf-8?B?TXFxZWN0ODhjSFNpakRNMERVUndZZU0rbTAwbFc5OEQ5Tk5ESnYxUHNaRDRo?=
 =?utf-8?B?eW9ZY2lxeGRWaVlUWjVzVSs1TklWcWFGMEFabWd3b2JreTh3TUNjcERiYzds?=
 =?utf-8?B?VzFRQkJ6ejBXNEY5eHdTc21OL2kxMWlBTVF3NTR5R3l5dG1wYkRKeEpHWSth?=
 =?utf-8?B?TVdRMEFqRnZFVHk5cUNaZWhFUzdjV0tsOFRnVnZmTjNnVllnSVRsNitheWhv?=
 =?utf-8?B?enpydGZCbEZzNVlQMFp5bDBNTE52YTRYZ3M4Q1JISjBNWmtHZnUzc2NuSG9G?=
 =?utf-8?B?eUUra0FmN1pENTNnclJQOHpqMG5hdVJGRUQrQi8vZjdIUHRpWVl0eTVpbWcy?=
 =?utf-8?B?cGtLMURUUU85TU9PcVljMDEwRFNrZkZjcG5FRE1vMHpPYmw0NjZuUDlIWFlI?=
 =?utf-8?B?WC93Y0FTSU9Pbmgyb1BqWWM1bXRYTTFkdHM3bUFMc1dWTSsyNDF2TytDRmx6?=
 =?utf-8?B?Ky9jUlpUT2tuaUhVbGFKejNqNjh4bzJpOGFGdGVTT0FsU2lIYmdWQVpmR2M4?=
 =?utf-8?B?OGNaVXFVYmpoS1g0M2F1cHcxSkRDNENNRGphR2RmUVNUbzJPLzZ4YXFweEpu?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dfafdd-912a-44d9-0433-08dc5578f392
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 14:01:55.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XlWaNnZa2qxqs2L543lgYUVBaNRSP5CtGbP4caIqutFudIalrJKhSHxOVUECqbcqXPqH3IJgI/WYghLV/OR3A32lYva9977Xs7Us7ZRPZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8730
X-OriginatorOrg: intel.com

On 4/3/24 22:08, Alexander Duyck wrote:
> This patch set includes the necessary patches to enable basic Tx and Rx
> over the Meta Platforms Host Network Interface. To do this we introduce a
> new driver and driver and directories in the form of
> "drivers/net/ethernet/meta/fbnic".
> 
> Due to submission limits the general plan to submit a minimal driver for
> now almost equivalent to a UEFI driver in functionality, and then follow up
> over the coming weeks enabling additional offloads and more features for
> the device.
> 
> The general plan is to look at adding support for ethtool, statistics, and
> start work on offloads in the next set of patches.
> 
> ---
> 
> Alexander Duyck (15):
>        PCI: Add Meta Platforms vendor ID
>        eth: fbnic: add scaffolding for Meta's NIC driver
>        eth: fbnic: Allocate core device specific structures and devlink interface
>        eth: fbnic: Add register init to set PCIe/Ethernet device config
>        eth: fbnic: add message parsing for FW messages
>        eth: fbnic: add FW communication mechanism
>        eth: fbnic: allocate a netdevice and napi vectors with queues
>        eth: fbnic: implement Tx queue alloc/start/stop/free
>        eth: fbnic: implement Rx queue alloc/start/stop/free
>        eth: fbnic: Add initial messaging to notify FW of our presence
>        eth: fbnic: Enable Ethernet link setup
>        eth: fbnic: add basic Tx handling
>        eth: fbnic: add basic Rx handling
>        eth: fbnic: add L2 address programming
>        eth: fbnic: write the TCAM tables used for RSS control and Rx to host
> 
> 
>   MAINTAINERS                                   |    7 +
>   drivers/net/ethernet/Kconfig                  |    1 +
>   drivers/net/ethernet/Makefile                 |    1 +
>   drivers/net/ethernet/meta/Kconfig             |   29 +
>   drivers/net/ethernet/meta/Makefile            |    6 +
>   drivers/net/ethernet/meta/fbnic/Makefile      |   18 +
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  148 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  912 ++++++++
>   .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   86 +
>   .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  823 ++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  133 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  251 +++
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 1025 +++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   83 +
>   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  470 +++++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   59 +
>   drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  633 ++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 +++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
>   drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1873 +++++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  125 ++
>   include/linux/pci_ids.h                       |    2 +
>   25 files changed, 8292 insertions(+)

Even if this is just a basic scaffolding for what will come, it's hard
to believe that no patch was co-developed, or should be marked as
authored-by some other developer.

[...]
