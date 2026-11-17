Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936769;
	b=zObAssyPgbkqRfvXBcJfl1hH9E88NAyeHDqr9PtMkGPfsBCzhh7NSNrcZsMlzd7QBzB4
	 wZasJn362sNryNZDNZH/t3THGnBeqJ3IHeYzn6M2tjsFUN5B3OypF8jVScZ39mRgdpDGj
	 n4c+1XhXijJkI5tsL2/j18XBSjx8b9Kf1VIQJ2806yDizEk5KkFZbiPgSHB/rOpSFyJ4h
	 cVYt/DXN43Q44INGYLcBEAs5zJWdnOZCz8k4s4b0qrcLdadWwQAIBT5sXJf24CnI2qln8
	 rOAW69wXPYUeQrwbMyuux8yMSLPrf7g7hIa00RD9PxpHcz8yb9g4mZw7PW17OqpeGYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936769;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vqfz0EpNU0hT0O0exff567jLnATXEDHTzyxcbPchas0=;
	b=hJYArSIc5/mD+ZMgPStsFRIYT6wkOKIXsOfNtBZzjP36FdBPOcOrcq77Q1iDSPEhxG6y
	 rqo1Lv09+bH03a1z3HEDoXYTioEo5NT4VFEXvlaXoQGwTsODUv1AgZFZTSFmC9KGS6mXl
	 5UwZ22ASIc4tnscsA3Q36bPGTXFrIpKdKk/CxM2vqtfhO1d5/8dbBPXVNt948p1dHx8xh
	 kDHUpVDH8J5kRYF/aeA4SDL9IzVe5QdDlsevpronajba1SP6zHKZhsGCqxF/x1pb6loJY
	 D1MyTzuw7jwqAvCR6aXvlMscW2FJ2jb0Bb86R3EuVaJWhhcXqfuRlJl3Ur28aQvZfvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UVD8UE9W;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="jf/1dVBB";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0F606A31C;
	Tue, 17 Nov 2026 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UVD8UE9W;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=jf/1dVBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794936769; x=1826472769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JmAua7ybG9aizaQn6cWUBQeHiOQ21AGEXQ55j4KKv7E=;
  b=UVD8UE9WxjP15Uct3NNzuz8JG/xQVOh3U1GRzBGd94l3UDeLZrSuPywO
   +iClfL1n2bSC1k/AASWsOl2nqgYXkcVRODHcfihWquG6T3U9tQWEELZQa
   tf+5gDPBzchkefEUafnAI+PQ3uf2cqTc+KaTzeS82m2ageJOxu6lcQPz6
   3Q1PtmTBhGN7kpn3kXTc72GIts8lzGSMWOZL7tqLGipbKnT6QXIVEnOEf
   nslKoMLoVfyOHRQhTXWmuHIDjR06KlpXTQ5ocu3N6FwEK+wQ1k/wsKGhG
   lrQRujH+nrzsHyDMzeXWc54BH07iK6HGOZEIU7WMQlc6j1r8fhVAgXv4J
   Q==;
X-CSE-ConnectionGUID: Y+X3v0zWQyOAxqvDlRFGIg==
X-CSE-MsgGUID: dgVdHLVjSOytPMjQy0IWMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3613565"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3613565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:32:47 -0800
X-CSE-ConnectionGUID: XhHf6t2bQLGKELWkv6dLSw==
X-CSE-MsgGUID: MQffG0DYSIyqr9ahJa2rPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9895115"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 09:32:47 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:32:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:32:46 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:32:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMlPluniQz2FbQ4OtpyPKvyxUhENX3Y2g9oOEmyDoHbenm06T2BMWVSRb9yGbKTQBuxQcj+FnSBpCQsmU4k9dAnGTd6AgqhW9nP38qxyYYVA/zees1//lBncwZ0uOG8UOrliyRK0Ea14sFrGhQgKdwSMZon3yf3KEp2Bcowcdq7IV1Whlj2meMpKNhqo9cGCrjdTlQLU0IXnbWiNcHtr9wx6SDOk2sddfmypfg8E4sivhevP/MJPTVjq9SgI51XLPUH5vrzaVhTRLlKO1DJk4BaOxhJLCR4AcqHp+KDa3fh5chOYIsTIqOKpcjNgQoXUX+0rR5vpLjjgwPtYUaeRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqfz0EpNU0hT0O0exff567jLnATXEDHTzyxcbPchas0=;
 b=sUY9YH35nk0qXlKhG6vr+i3AZX1M+Lt7PTf/sBlT9NdJ6z5NPiGn0ujcqc/eqVcDLMaYPF7elGStDJW7R6vaYJlfPVmCiZqvZaZs0g9wforwXsMd01ZXNvurjppMX91b0bSMOBs7pgofvBoXE3K9jWQxVHjPQC+HYRcMUNvui3Gt7vYdVzU4hA+LNgQzHN4ZffZ24K19fe97pJImTO0mntCuT6pToSWlO8jRyj/N6x5N/7ZPHuXuK2MtYSkQJDhrXJPPzC4b8zbDkN+6DpU8uhcoIYcXXn2RPXZT9iMp0unCbpW5uPL5PapGX70JuB8qLL9IiqOwSfnVVI+YKtJwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqfz0EpNU0hT0O0exff567jLnATXEDHTzyxcbPchas0=;
 b=jf/1dVBBxcxWDe+fiDvkfwYKfpwI42Odtj7tN46XUkaI5euyzs3Mn+8aNuGKTrUuBRiiG8aKFho6k4QS3HetUd2KZYi9+ZBUH0dFT5IH4QRw84o28uALcKQU82/vxVXYGGDVt8iUsa/IrVzg/5uOXu9Ttj0ADs8S3AL799PW0CQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:32:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:32:39 +0000
Date: Tue, 17 Nov 2026 09:32:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>, "Joshua
 Machauer" <machaujo@amazon.de>, Alex Williamson <alex.williamson@redhat.com>,
	<vsethi@nvidia.com>, <alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v17 13/19] cxl: Validate and synchronize HDM ranges
 around reset
Message-ID: <avyPsvwV1_lc9va5@aschofie-mobl2.lan>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105185917.2667656-14-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:303:87::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 735cc3a1-fee7-44a1-5172-08df44d0c69f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|5023799004|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261022113327099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009223027099003|261102130727099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: You5vAXzuADRt4F8Om5RSa/fIgXn1JMK+2fqNGo3mmPzp15oOWkER9Q81Q7gb4gU7dIgf5pNk8obg1w1+jEBYy7stpFiiR8Cn/m3qdXmv/xyA1Bu2rR6R4zDWxDHLmsM4jE20ygoMiCPUsQA8dHUObMPoQ/nhDjr8EPM9NVtNFRiLC+JmkSQ0KrNTI/CZoUUJH02sDYvuCAgHHeFqdyWtkdGUmuXjdyK0exI+RJ/gqd0ryEMD8Fd1GhGtX5ti6wUidKKq7BdqNwvdkZLfh9bYiOE7TRqyExQfTfCM/W3rz3ilbof/w4FRVkd8xfl/cnbIugZ0zXOU0z3FPJzVJON398gcRDxO3MX1LBrZb9n5H2um0CxJ93Vk9aAaQKjG8se3mdtCZZamcvXf4B4kCM3+ByuDVJHRoD6cW5kpRvsFfuOHmCNyNu37A9sAS3bYxLcWUkxZBX8nCKvSjKlsLZTQVUQp5gYwF8XSyMjrgFrb7ADnJvXeGhZA83ud/b4pGETFb3fk8j74JvQxNTZelLh8tXh3ei1uShVC/O8vr+bpDaolzzrT4whaKFILD46c51XmJS2cQjvVmdw5Tn9V+LanimYWFQvwYNMzZUOIgfJHJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102130727099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ln0xZyRhSY32RMafge1IrXdScqstCp9AkIdTiBxdyl4mXl4VLWt9+hqi2qV8?=
 =?us-ascii?Q?OD9NUgG9T3XpQk9/0Qp++EY5NmXwwaEZB9pq1gXjE9KxiWeZ/2kL9iXcWgAF?=
 =?us-ascii?Q?oClmX0Y4NXqiTGevjWOv7vWnII12M1bJ0gNrmCGH/KfMQ/kPhjkeqaRTHIQn?=
 =?us-ascii?Q?TwCEqSgky5Uu40+09Z/aDh5iKrMIgTXD3WEYmKJIzZyYUiHE5MPOdyK8j0F6?=
 =?us-ascii?Q?uHPON7JylqQ0mfIrpxCT4dt8z2pwkCiOnm79No3aFjBGZvUcXHOUzaASnpyB?=
 =?us-ascii?Q?/D5alCmifanWV8gb52iyHYjy2ESe60Pcn2FQX53axDX7knqHZILVwwKX9TSX?=
 =?us-ascii?Q?608dshQrXZ5yNeHpgs585SZNMU6zU0EtK/LKXUGuY2eYHauk8rogGs9pgkYZ?=
 =?us-ascii?Q?DpSyGW2942oHdwmkrQGWn65vZh7Sc2RfqJWa8pjVM1GTGRY/pQDUOAoLNYfR?=
 =?us-ascii?Q?E5sA+4fNU6OfEy6BLZ4Tzl3L5KpT+/lkP2dHu1GwEVJssyVqcZrPJ29iUrQp?=
 =?us-ascii?Q?QpQm+/mIrpCd1Ir31xIuEcKc/ngUqEIMVLcieEsNdHXrUEKbhyr2notfqeog?=
 =?us-ascii?Q?V8GN8WeJNickhJeEpqQLAcIVX+7dKEO33/ug/LBjtelQ/oL3VjBCzrrWG7VG?=
 =?us-ascii?Q?EH39ZaowYWemIbVaynWll8v9BaQ6h8QFx7a5LzbnJezMs9c5XOIICc/frAIY?=
 =?us-ascii?Q?zjeEQYojz1f/5Mp7dAJG0Tupq/xQ1hzTkfxlvSbad5Lj9iYYGvFUT0uXZaWJ?=
 =?us-ascii?Q?lD5gslFGuDI/bOyABq1i6JH8PmUAY6ybLQ5nvVR3mRd3CxAShpoE2fQAqyCp?=
 =?us-ascii?Q?ttUCc8+LyBtwbpZKhyVfsKI0+OB8DEzGtzlAFeKG/gDX7I9E/QMPPQToQr6J?=
 =?us-ascii?Q?XGUYAGs5Zr27dZ+kBnU5Guk8SAm16e05fMy92CcaEl8CXt8FCV+rWHfsJmx6?=
 =?us-ascii?Q?h8xTq3GnftM3ATbQlOeR/dqJfkez9HBHBaay4WXqxc1HU1J9jekkUbD5Emlb?=
 =?us-ascii?Q?ioWNkIUOPdgmrvFH71ItVdRzEa5z0xBFhbUGUIQCQ9/Xgp1Cst5EfDS639XI?=
 =?us-ascii?Q?vAf/kqP4tQwvtSFYWoKV4Q6UqdKBkrJwGwe6aNC5zZJC8x5xQOo7lRvLR6Qp?=
 =?us-ascii?Q?l1Pu7A/KNTObkF5k0kgOFLfJFQGNyTtdUXGlFd2VM9LtwlAfQ1SeXB4ZYr3u?=
 =?us-ascii?Q?2EE+BbW7ZuSKVYOrfSWUq4oKlCdpzMPB9cJumAJQsuXBGxmQVoMo5H1vdY14?=
 =?us-ascii?Q?MF4VkgGpZ/Vc0zh+bxUItIKJU0uJz47tC4u/Pb8LJ5m6AGcH5zVGQGcwwO/T?=
 =?us-ascii?Q?47F/Kl0Qpi9lYrco94cQMBKUeoj5uew5H0Fi8gVMlFXrAtiG/uZt1n03wAZ9?=
 =?us-ascii?Q?Grmxeff+NfhuoyT0kTHiWRkozazRKax6s5hdD5GJyRL9BSw5Ts+bH4a7vHhN?=
 =?us-ascii?Q?8yA4f1hgBvvWM7xf++Nm/TEHK6P1FUMJ2JJFPst5hLmA3kfjSeukMTFPfTXU?=
 =?us-ascii?Q?kIoa5xdg5psm7CepiwJeRsbqVMCwbTXIWdwOf0MxEn7bv5UHcUVXRRkOGgoc?=
 =?us-ascii?Q?0UNWvsC4KJK5XdBm0Im3mJ4bkPFzB7GJ1sl4xQj0Z9vDA79VXT+eCs0D0yhQ?=
 =?us-ascii?Q?Lx7+p19mgvGHxueRJQXs46oFPh4F8Yl6V1ePTq7PBz5noRjq9rnrHg07q50m?=
 =?us-ascii?Q?EdRSN6AD/pKTVLkIObiaLH7C4NX0ZMvPE9wuQ8DIXr4FA5xkEqLIBB0iWJeG?=
 =?us-ascii?Q?VQjlXvOSZmp0k3/oEViWvR/IYFnUkIk=3D?=
X-Exchange-RoutingPolicyChecked: u6DdWQyezP7nWCqTe2mGvY0qGKT8/ScXJ0qRl56a/Nsi+y9zvZv+7kYlfoxV6BIHRwns6cskABqeDjm+UCPscv4bZOfEMTzkg3dt/DCEhLp0J2PReyfTsbO52iEuPO2mdA6pQw3W5Kzn/1B8QCxEifFzaXBwXSX+wHDNaSxVE71+I9x/s7F2501fsFL4AXhy2DBeJnGvy3AsaERQZM5sa7sRhf5zwRinhk6AICpK/jtRDMnJ9t7u8yWfz4JetCTO5d/8Ixqb23kIEe4vMSgI+TX+sZ5JL6Eq/mD9aphE2QNU/ky31m/Zpy3u0ZrpyEcKeGWDwsp4Bcg2IRKJ6Cpcyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 735cc3a1-fee7-44a1-5172-08df44d0c69f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:32:38.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pebjmunF6vhon3MB+xdb/4LDQIPSWu0/y/lCvpxEEA0srxZdUepCvAx35sz4QlD4NUDgY3Ua2K587e4VAwo/+e0U70cq3ibdnQKIBMUV6nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 06:59:11PM +0000, Srirangan Madhavan wrote:
> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
> 
> Userspace is expected to offline CXL.mem users before reset. The
> reservation enforces this for claimed ranges: the reset fails while a
> conflicting resource is claimed, and no one can claim the range during
> the reset. It cannot see accesses by code that uses the range without
> claiming it, which the offline expectation also covers.
> 
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Record Normalized Addressing in the cache when
> region discovery sets it, since the cache is filled earlier. A reset that
> takes its snapshot between endpoint probe and that update can still
> miss it.

What prevents reset during this window? If the snapshot misses the
normalized-addressing flag can a reset proceed and use a range that is
not a system physical address?

Does this mean we need to prevent reset until discovery has resolved
the address interpretation, or is there another check that makes
reset safe before then?

> 
> Ignore zero-size decoders because they map no address range. Refuse reset
> when the device decodes memory through its DVSEC ranges instead of HDM
> decoders, since the cache holds no range to reserve for that memory.
> 
> Hold the global cxl_rwsem.region write lock across snapshot, reset and
> restoration to keep the decoder state and reserved ranges stable. This also
> blocks region and decoder sysfs, region probe, poison operations, sanitize
> and region-aware event tracing across CXL devices. The Memory Clear wait
> lasts up to the timeout the device advertises, at most 100 seconds; cache
> flushes and other reset work extend the hold.

Similar to questions on previous versions and in cover letter - 

Can a reset acquire this lock while other CXL devices are still being
discovered and their regions assembled, and block that work for the
full reset duration?

What limits the disruption to unrelated devices, including repeated
resets? Could the locking be scoped to the affected device or regions
rather than holding the global region lock throughout the wait?

> 
> Allow the existing CXL_REGION_INVALIDATION_TEST option to bypass missing
> CPU cache invalidation for test environments without a provider.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 
> ---
> Changes in v17:
> - State that userspace is expected to offline CXL.mem users before
>   reset, and what the HPA reservation does and does not cover (Richard)
>   https://lore.kernel.org/linux-cxl/auQRSOGWEDzB_qjF@MWDK4CY14F/
> - Record Normalized Addressing in the cached decoder when region
>   discovery sets it, and note the short window before that update
>   (Sashiko)
>   https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=13
> - Annotate cxl_region_quiesce_lock()/unlock() and __cxl_reset_execute()
>   for context analysis (Sashiko)
>   https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=15
> - Describe the region lock hold as bounded by the advertised reset
>   timeout, at most 100 seconds, plus cache flushes (Richard)
>   https://lore.kernel.org/linux-cxl/auQC2UECQ8vaelPz@MWDK4CY14F/
> 
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=5944c6e61f14c0dd28d54537be15edb2cadb0e8b
> ---
>  drivers/cxl/Kconfig          |   3 +-
>  drivers/cxl/core/hdm_state.c | 266 ++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c    |  14 ++
>  drivers/pci/cxl.c            |  87 ++++++++++--
>  include/cxl/hdm.h            |  47 ++++++-
>  5 files changed, 406 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8b08bfdc4982..e927e69a3f7b 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -226,7 +226,8 @@ config CXL_REGION_INVALIDATION_TEST
>  	  invalidation mechanism. For example usage of wbinvd is restricted to
>  	  bare metal x86. However, for testing purposes toggling this option
>  	  can disable that data integrity safety and proceed with enabling
> -	  regions when there might be conflicting contents in the CPU cache.
> +	  regions or performing CXL reset when there might be conflicting
> +	  contents in the CPU cache.
>  
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> index 9def4a7439c9..51df56377f7a 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,8 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/memregion.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
> @@ -13,7 +19,8 @@
>  
>  /*
>   * CXL state that must stay available while no CXL driver is bound: the CXL
> - * locks and the per-device HDM cache filled during PCI enumeration.
> + * locks, the per-device HDM cache filled during PCI enumeration, and the
> + * region quiesce used around a reset.
>   */
>  struct cxl_rwsem cxl_rwsem = {
>  	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> @@ -87,6 +94,27 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
>  
> +/**
> + * cxl_hdm_cache_set_normalized() - record Normalized Addressing in the cache
> + * @pdev: endpoint that owns the cache
> + * @id: endpoint decoder id
> + *
> + * Normalized Addressing is determined during region discovery, after the
> + * cache was filled, so the cached decoder lacks it. Record only that flag: the
> + * decoder's software lock must not become a hardware Lock On Commit when the
> + * cache is restored.
> + */
> +void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm || id < 0 || id >= pdev->hdm->decoder_count)
> +		return;
> +
> +	pdev->hdm->settings[id].config.flags |=
> +		CXL_DECODER_F_NORMALIZED_ADDRESSING;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_normalized, "cxl_core");
> +
>  /**
>   * cxl_hdm_cache_release() - unpublish and free cached HDM state
>   * @slot: cache pointer owned by the device
> @@ -105,3 +133,239 @@ void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
>  	}
>  	kfree(info);
>  }
> +
> +/**
> + * cxl_hdm_cache_dvsec_decode() - check for memory decoded by DVSEC ranges
> + * @slot: cache pointer owned by the device
> + *
> + * Return: true if the published state shows CXL.mem enabled while HDM
> + * decoders are globally disabled, so that the device decodes memory through
> + * its DVSEC ranges, which the cache does not describe.
> + */
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	return info && (info->dvsec_ctrl & PCI_DVSEC_CXL_MEM_ENABLE) &&
> +	       !(info->global_ctrl & CXL_HDM_DECODER_ENABLE);
> +}
> +
> +/**
> + * cxl_hdm_cache_snapshot() - copy the published HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Return: a copy the caller frees with kfree(), ERR_PTR(-ENXIO) when nothing
> + * is published, or another ERR_PTR() on failure.
> + */
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
> +{
> +	struct cxl_hdm_info *info, *copy;
> +	size_t size;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	info = *slot;
> +	if (!info)
> +		return ERR_PTR(-ENXIO);
> +	if (info->decoder_count <= 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	size = struct_size(info, settings, info->decoder_count);
> +	if (size == SIZE_MAX)
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	copy = kmemdup(info, size, GFP_KERNEL);
> +	if (!copy)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return copy;
> +}
> +
> +void cxl_region_quiesce_lock(void)
> +	__acquires(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	down_write(&cxl_rwsem.region);
> +	__acquire(cxl_region_quiesce);
> +}
> +
> +void cxl_region_quiesce_unlock(void)
> +	__releases(cxl_region_quiesce)
> +	__context_unsafe(token maps to cxl_rwsem.region)
> +{
> +	__release(cxl_region_quiesce);
> +	up_write(&cxl_rwsem.region);
> +}
> +
> +/*
> + * Bound the range twice: request_mem_region() takes resource_size_t while
> + * cpu_cache_invalidate_memregion() takes size_t, and the two differ on
> + * 32-bit builds with CONFIG_PHYS_ADDR_T_64BIT. range_len() can also reach
> + * RESOURCE_SIZE_MAX + 1 for a full-width range, and wraps to zero when
> + * resource_size_t is 64-bit, which the !len test catches.
> + */
> +static int cxl_hdm_range_validate(const struct range *hpa_range)
> +{
> +	u64 len = range_len(hpa_range);
> +
> +	if (!len)
> +		return -EINVAL;
> +	if (hpa_range->end > RESOURCE_SIZE_MAX || len > RESOURCE_SIZE_MAX ||
> +	    len > SIZE_MAX)
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_range_add(struct cxl_hdm_quiesce *q,
> +			     const struct range *hpa_range)
> +{
> +	struct cxl_hdm_range *range, *next, *new_range;
> +	int rc;
> +
> +	rc = cxl_hdm_range_validate(hpa_range);
> +	if (rc)
> +		return rc;
> +
> +	list_for_each_entry(range, &q->ranges, list)
> +		if (range_contains(&range->hpa_range, hpa_range))
> +			return 0;
> +
> +	new_range = kzalloc_obj(*new_range);
> +	if (!new_range)
> +		return -ENOMEM;
> +
> +	new_range->hpa_range = *hpa_range;
> +	new_range->len = range_len(hpa_range);
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		if (range_contains(hpa_range, &range->hpa_range)) {
> +			list_del(&range->list);
> +			kfree(range);
> +		}
> +	}
> +	list_add_tail(&new_range->list, &q->ranges);
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_collect(struct cxl_hdm_quiesce *q,
> +				  const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	for (int i = 0; i < snapshot->decoder_count; i++) {
> +		const struct cxl_decoder_config *config =
> +			&snapshot->settings[i].config;
> +
> +		/* A committed zero-size decoder maps no HPA. */
> +		if (!(config->flags & CXL_DECODER_F_ENABLE) ||
> +		    !range_len(&config->hpa_range))
> +			continue;
> +
> +		if (config->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
> +			return -EOPNOTSUPP;
> +
> +		rc = cxl_hdm_range_add(q, &config->hpa_range);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_request(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +
> +		range->res = request_mem_region(hpa_range->start, range->len,
> +						"cxl_reset");
> +		if (!range->res)
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_hdm_ranges_invalidate(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range;
> +	int rc = 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +		pr_info_once("CXL reset: bypassing CPU cache invalidation for testing\n");
> +		return 0;
> +	}
> +
> +	list_for_each_entry(range, &q->ranges, list) {
> +		const struct range *hpa_range = &range->hpa_range;
> +		int rc2;
> +
> +		rc2 = cpu_cache_invalidate_memregion(hpa_range->start, range->len);
> +		rc = rc ?: rc2;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_hdm_quiesce_prepare() - take the HPA ranges of a device out of use
> + * @q: quiesce state to initialize
> + * @snapshot: HDM state from cxl_hdm_cache_snapshot()
> + *
> + * Reserve every enabled system-physical range in @snapshot exclusively, then
> + * write back and invalidate CPU caches for them. Call
> + * cxl_hdm_quiesce_destroy() afterwards whether or not this succeeds.
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +{
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	INIT_LIST_HEAD(&q->ranges);
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
> +		return -ENXIO;
> +
> +	rc = cxl_hdm_ranges_collect(q, snapshot);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_hdm_ranges_request(q);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +/* Evict lines fetched during reset before DMA exclusion ends. */
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +{
> +	return cxl_hdm_ranges_invalidate(q);
> +}
> +
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q)
> +{
> +	struct cxl_hdm_range *range, *next;
> +
> +	list_for_each_entry_safe(range, next, &q->ranges, list) {
> +		list_del(&range->list);
> +		if (range->res)
> +			release_mem_region(range->hpa_range.start,
> +					   resource_size(range->res));
> +		kfree(range);
> +	}
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8cfc06df3134..b06dd9b901f0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -12,6 +12,7 @@
>  #include <linux/idr.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/string_choices.h>
> +#include <cxl/hdm.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> @@ -3840,6 +3841,19 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	if (IS_ERR(cxlrd))
>  		return PTR_ERR(cxlrd);
>  
> +	/*
> +	 * Translation setup may have marked the decoder as Normalized
> +	 * Addressing, after the PCI cache was filled. Record it for reset.
> +	 */
> +	if (cxled->cxld.config.flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
> +		struct pci_dev *pdev __free(pci_dev_put) =
> +			cxl_port_get_uport_pci_dev(cxled_to_port(cxled));
> +
> +		if (pdev)
> +			cxl_hdm_cache_set_normalized(pdev,
> +						     cxled->cxld.config.id);
> +	}
> +
>  	/*
>  	 * Ensure that, if multiple threads race to construct_region()
>  	 * for the HPA range, one does the construction and the others
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 9ac5948f595b..af8ec8db20f1 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -15,6 +15,7 @@
>  #include <linux/iommu.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/memregion.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -23,6 +24,13 @@
>  
>  #include "pci.h"
>  
> +struct cxl_pci_cache {
> +	struct cxl_hdm_quiesce quiesce;
> +	u16 saved_ctrl2;
> +	/* A cache-policy write was attempted and may need undoing. */
> +	bool cache_disabled;
> +};
> +
>  /* Find the CXL Device DVSEC and read its capability register. */
>  static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
>  {
> @@ -335,6 +343,23 @@ static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
>  	return rc;
>  }
>  
> +/* Shared range reservation, host invalidation, and device cache writeback. */
> +static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 cap,
> +				   const struct cxl_hdm_info *snapshot,
> +				   struct cxl_pci_cache *cache)
> +	__must_hold(cxl_region_quiesce)
> +{
> +	int rc;
> +
> +	rc = cxl_hdm_quiesce_prepare(&cache->quiesce, snapshot);
> +	if (rc)
> +		return rc;
> +
> +	/* Track an attempted change so partial failures still restore policy. */
> +	cache->cache_disabled = true;
> +	return cxl_reset_disable_cache(pdev, dvsec, cap);
> +}
> +
>  static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>  {
>  	unsigned long deadline;
> @@ -389,7 +414,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
>  				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>  }
>  
> -static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> +			      struct cxl_hdm_quiesce *q)
> +	__must_hold(cxl_region_quiesce)
>  {
>  	int rc, rc2;
>  
> @@ -414,29 +441,61 @@ static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc = rc ?: rc2;
>  
> +	rc2 = cxl_hdm_quiesce_flush(q);
> +	if (rc2)
> +		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", rc2);
> +	rc = rc ?: rc2;
> +
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
>  }
>  
> -static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +static int cxl_reset_quiesced(struct pci_dev *pdev, int dvsec, u16 cap)
> +	__must_hold(cxl_region_quiesce)
>  {
> -	u16 saved_ctrl2;
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
> +	struct cxl_pci_cache cache = {};
>  	int rc, rc2;
>  
> -	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> +				  &cache.saved_ctrl2);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> -	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
> +	if (PCI_POSSIBLE_ERROR(cache.saved_ctrl2))
>  		return -ENODEV;
>  
> -	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot)) {
> +		pci_err(pdev, "CXL HDM decoder state unavailable: %ld\n",
> +			PTR_ERR(snapshot));
> +		return PTR_ERR(snapshot);
> +	}
> +
> +	rc = cxl_reset_cache_prepare(pdev, dvsec, cap, snapshot, &cache);
> +	if (rc && !cache.cache_disabled) {
> +		pci_err(pdev, "failed to prepare CXL reset ranges: %d\n", rc);
> +		cxl_hdm_quiesce_destroy(&cache.quiesce);
> +		return rc;
> +	}
>  	if (!rc)
> -		rc = __cxl_reset_execute(pdev, dvsec, cap);
> +		rc = __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
>  	/* Restore cache policy after any attempt to disable caching. */
> -	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
> +	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
> +	cxl_hdm_quiesce_destroy(&cache.quiesce);
>  	return rc ?: rc2;
>  }
>  
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc;
> +
> +	cxl_region_quiesce_lock();
> +	rc = cxl_reset_quiesced(pdev, dvsec, cap);
> +	cxl_region_quiesce_unlock();
> +
> +	return rc;
> +}
> +
>  int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	u16 dvsec, cap, ctrl;
> @@ -463,5 +522,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (probe)
>  		return 0;
>  
> +	/* The cache is owned by @pdev and does not require a bound CXL driver. */
> +	if (!pdev->hdm)
> +		return -ENOTTY;
> +
> +	/* Memory decoded through DVSEC ranges has no HPA ranges to quiesce. */
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm))
> +		return -ENOTTY;
> +
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    !IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST))
> +		return -ENOTTY;
> +
>  	return cxl_reset_execute(pdev, dvsec, cap);
>  }
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 0604dcc439c9..49b36a45c682 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -3,10 +3,14 @@
>  #ifndef __CXL_HDM_H__
>  #define __CXL_HDM_H__
>  
> +#include <linux/list.h>
>  #include <linux/types.h>
> +
>  #include <cxl/cxl.h>
>  
> +struct device;
>  struct pci_dev;
> +struct resource;
>  struct cxl_endpoint_decoder;
>  
>  /**
> @@ -45,7 +49,6 @@ struct cxl_hdm_info {
>  	bool dvsec_ctrl_valid;
>  	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>  };
> -struct device;
>  
>  int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
>  				 resource_size_t size);
> @@ -55,6 +58,48 @@ void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
>  void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  				   struct cxl_endpoint_decoder *cxled);
>  int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +void cxl_hdm_cache_set_normalized(struct pci_dev *pdev, int id);
>  void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
> +bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
> +struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
> +
> +/*
> + * Region quiesce blocks CXL region commit and teardown, and with them decoder
> + * reprogramming, while reset handling captures or restores HDM decoder state.
> + */
> +token_context_lock(cxl_region_quiesce);
> +
> +/**
> + * struct cxl_hdm_range - HPA range held exclusively across a reset
> + * @list: entry in &cxl_hdm_quiesce.ranges
> + * @hpa_range: system physical address range decoded by the device
> + * @len: length of @hpa_range
> + * @res: reservation of @hpa_range, once requested
> + */
> +struct cxl_hdm_range {
> +	struct list_head list;
> +	struct range hpa_range;
> +	u64 len;
> +	struct resource *res;
> +};
> +
> +/**
> + * struct cxl_hdm_quiesce - HPA ranges held exclusively across a reset
> + * @ranges: list of &struct cxl_hdm_range, see cxl_hdm_quiesce_prepare()
> + */
> +struct cxl_hdm_quiesce {
> +	struct list_head ranges;
> +};
> +
> +void cxl_region_quiesce_lock(void)
> +	__acquires(cxl_region_quiesce);
> +void cxl_region_quiesce_unlock(void)
> +	__releases(cxl_region_quiesce);
> +int cxl_hdm_quiesce_prepare(struct cxl_hdm_quiesce *q,
> +			    const struct cxl_hdm_info *snapshot)
> +	__must_hold(cxl_region_quiesce);
> +int cxl_hdm_quiesce_flush(struct cxl_hdm_quiesce *q)
> +	__must_hold(cxl_region_quiesce);
> +void cxl_hdm_quiesce_destroy(struct cxl_hdm_quiesce *q);
>  
>  #endif /* __CXL_HDM_H__ */
> -- 
> 2.43.0
> 
