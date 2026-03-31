Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5353EE1D1;
	Tue, 31 Mar 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964812; cv=fail; b=KRfN3OT31/hYQpRLR3YpEa0ZypJTSKNHtzdDy1Y1krOem3hP9WFFBdAAealYoAbov4gnuJd8bn9rPtTl+Pthr/ZEu/7zKSOj+T2iYzaKDuD4tvME3VTKV6rmYluI/jtbaw4m72X46vnRNQCjNFvD4TWhlTVhUljdDII0lSp3GGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964812; c=relaxed/simple;
	bh=n0047owRs9cjcxr0wBEiXKWqm3o+4KXaDNLfzISk5SQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HTfGDH2Zt3obTZ1GMg3B1qes1QwCy0ryryY3ezX0H9JRPqVIE9tkQw9alEqgMWgj6jAtGqfNgUDqsNuBiyHfEy3vuwfuloCtgok2eE1U96fkQCrd9T1QcwffUhz9z4noZr9BIgox1VVbLM3VDpFUb0U2uD01XFHpfyqKiXDtAFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGLNkl2o; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGLNkl2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774964806; x=1806500806;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=n0047owRs9cjcxr0wBEiXKWqm3o+4KXaDNLfzISk5SQ=;
  b=IGLNkl2opshDOiAFNwsW8L9UtmEqhCudVaGAOwP/cKLUcJmYJoyaUNpr
   DHzljbSAvKgaafCO9Qo5oE6/YqREWLURYcH3SN1+wcweexGXQSyWZOG2D
   6df4NdqgSHcTNjqCxyneEP3s5+yitSt0gskLvTlHqixJKU0Sy2zTzAKL4
   SHdWN5f6mHPWXJ8iWfKzfTFCTZIUDuQhNHbwj0bd6PsZHbKjS17JLYMaS
   TO645lSVYZ6r1hdcD/fBv+PZrGGeJIzOo0Qz/DJVKydoqrv/+C0moKV1K
   qrYtb9MiXaCUjzB8XUYKvP9cdjN8qm54laHvWpIYtKhL5i6Uz7NOU5wYn
   g==;
X-CSE-ConnectionGUID: VSkhJQmTSnykzuHuK/vFVg==
X-CSE-MsgGUID: FAbyOuiLQIKGGdtteLkrrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87369436"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87369436"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 06:46:43 -0700
X-CSE-ConnectionGUID: 0c7SdJfbTOySTtvpQxIbAg==
X-CSE-MsgGUID: rN7xfp2GSEGohAgVefweLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223068737"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 06:46:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 06:46:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 06:46:41 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 06:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NecE5xqA7KjWmobWH9j1oN+V9+OBjH0ZRhjFYNdbOXydlZu8zhe/yjx6KEP/hLFHm1IGbxmVsPrK/JrjLHfhZz1oPkT/G5XJB2+FM0/nW+pHMUigIMDMd1CkuI3rHeYlWhbmpfsvmiP9prod/yjIT7xh/02R/8uq/Uc6zMZEBnuCuAQCDaujjWIOQLCL+nP1Qfs7bOjPJzcfZALecwxFk8OUKeqHUPogQj/Bh0UvD97oncDXB2NGw/zitqFyLb+q2gTWTfwRWeblOlFOJm/q1mOdB51JYCfe1MI6/rOK+ki0SzN/fc9+33dGHL+AIddcZ1LX4yqxF1cdWMtD9LBKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewcQwd9gs2/BbAbphx0xQZ/QVJKOsRc3v4nMNHyZPxM=;
 b=T/2aFHkKH5FqaXLZ7y321qTM8oAUTXOs1Id58NoNDgGzVHuSsDBJXpi5XgKxZFdKZ4y4H8rlyNTkyEDWdg+cgzuNYvIQwEDj85iKsIFlbAhkF0Ge20b3fZ5qxK6am3vd4+EJYV5QoQ5ejzcehFxHeUpS7BN3OCioHZLt3LVskozQgjV3VIZVhnGmKTcqMK7wUal1tKz3nEH/hhquiyXT6Y7123IfVW+t9a3F5Il+surlXlt6LR677nzHPj8Lq6850f5MntO98hWXMlCh6fclLKMaN///OdMCwy/qpYmNWPeZPh1VufTIAsW1/pFsq225ZTYECQGJstgPRC2eCWggOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 13:46:39 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 13:46:38 +0000
Date: Tue, 31 Mar 2026 21:46:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Guanghui Feng
	<guanghuifeng@linux.alibaba.com>, <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Inochi Amaoto <inochiama@gmail.com>, Nam Cao
	<namcao@linutronix.de>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>, Xunlei Pang <xlpang@linux.alibaba.com>,
	<oliver.yang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize
Message-ID: <202603312126.697741fb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324014754.4973-3-kanie@linux.alibaba.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CO1PR11MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9eb616-1193-4780-475d-08de8f2beed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: JC1SfobFThM5XbVRBHR3rnzyMBdb+5QMVPF2e93zVMlBQHLk9UuZ7gBMki3/Nf+KNxxSTDYfxXP8T85K6vHtnMqek52Na+Fbu7ZaFFg57dGk4pnxd7yQmKVszBJegeQMzv1nU0o0DC8JCp5b3ujTYWSnFTPG7AHD0nJpMXHbk37ZB1Nmrh49jA/3XQP4fFtn/Jv66naFbpwMXDmvV/jTbetX0gJq8c0wkoebVneyDopHJ2d03ZqpSeuarlykaTcpVIuMP5uXFr9XZxoOABsrf2CMotcz+Nm34ftGMYWNhuppQ6v24KCNneLd/9dmSfcvfW4uu/sWcR8k9tPD/T9Kc732Rk3Ld2bu/9+PkJjv3T+WmmeDUNCRLF6hSPQk331EHodisDPK511wX7Q56LzwonstL5sl6Du9b6PX1LHf2CYzjcrH/aCVJPK4dz71I/qaFEfOeurMC6APgZrQUBagNJKoXs1PzpvK1MF4/rNXpcRTH4hOwSnXEqbVGRapZP3RYVDT2Hey1mu3KbhPZ45CrZxRhodvPOQL0qd3rBtQAQ4Q7BBZpEO7yZ6PVNkr85lTLAndx3VGC+W2OFIle3mLRiSUUifLq2X00tloF9Sh5i9A2Wv+R/J7rl+wo6GNCNw9eVBo+WrzouYW90BBG7YBpOHuO29ielBsfsbbft7S3sM/TxG5yZO4Yl7+0RHQQCOD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFrolM4a2jLXF3ks8cXtyUB0j+vxCbk76+LpKyT36/LswKbzMHYklQbpy9+t?=
 =?us-ascii?Q?2ejwbn82PZCSM8Y/qP8BBTihtS237X1RNoifYH1OnsizX5kmlZgl+tHKCZCw?=
 =?us-ascii?Q?qsHvc2pLT/oqaKibOlaqT6qVb48bkhFWZIaRtaTZJwnPy5dnfI0bxeZax75R?=
 =?us-ascii?Q?YhUPa/Zcn9QeA1H8KyzlYYPcjgG2HjgDjTQ3cu/TufzG+3Rfb1eK1YOaPAdJ?=
 =?us-ascii?Q?zJbbP0EgyHuSj3erO8wau0tlYvoq1vpoNZfsyl+czBbJGE98Be+qFAZV3bYg?=
 =?us-ascii?Q?zQ7yToujRirTg5O1kkhyS0Eg2FvOEg5qBBncprThF0wGwFcT5RNGFG2heg7u?=
 =?us-ascii?Q?1KhUVNdu83GsPrMIcAbLOUSRXjcGTawDVbfq4sp1x13jwnA58+oZOo3c3rw3?=
 =?us-ascii?Q?CNBfNa7DD+ASI7fX3juUnn86vl1bNv9/K+AJXxNMg4+vyr70vwkEWxfzGIEL?=
 =?us-ascii?Q?y0kp/a3afPwRXPkLfGWBvGf/nsIfCGECKxSZoQtHp37x5nsTvwvgYJNWDe/l?=
 =?us-ascii?Q?1mapmx93Wez7rKb/dfzx3k0FVg/1lMKo+MTXprXFEPGutAWQpI8Uj0uyzPFL?=
 =?us-ascii?Q?xPOqKp/4Hcu9braP8LNmbXpFgSEJVfZW7cYp0x2/aa4j7Y5E6ubiZiZ4P7TD?=
 =?us-ascii?Q?FPNcdpiT8vAvlVHSxfUO/eOkDP7VYKUZyKYLhKvpkGXo6YGNeIgVY26DF8mp?=
 =?us-ascii?Q?7idU0oF+AoD62Kc2y00iEjcdSjG5EfJJ4MLgQkU5zFRMVxRbfyrMdgBQm/Nz?=
 =?us-ascii?Q?LCWhpB+7pxmBFah5dCkj8WSEgZWTnXwoRQhlGNTPwWG/+p4uGAGxxAZ1sjAo?=
 =?us-ascii?Q?0KfVXA2QGo7meLaIVLGbhPGe15EwBuIrYw0R2Rtcw7BqglsGvbAfdaFeQlsd?=
 =?us-ascii?Q?b4LeaC2pOOXPjEGITioKvp1pNUBSQSPFqjDlAy3MbCOTXsMwCUXguTgBs2b5?=
 =?us-ascii?Q?ZYj8xJfiXSaD/Hd5/sk5KKSgT2nmbATs0tg5kv74mvaxiAZtrzbN9XtUCR3+?=
 =?us-ascii?Q?PSUTRVCG8hEcVB40SSly9sHS3PCBuXNMTdKcls76j0/4MLQkhRHpBDBA7z6y?=
 =?us-ascii?Q?oGl2vL+/OzBTWfSyL0pXxEY6BJ0U+TjztfjIVIUBcSmVGJMIKcjtWb2gqZ8j?=
 =?us-ascii?Q?ujA5eWnvR/SzTkek8nrL+4WLjyh2pdRJe61ZlBEneInO8UMPg9LM5j6NGg0t?=
 =?us-ascii?Q?60lB+vSCLV7d1A31BGQ3c0T+KW/7lvI7S+yxY/DY+1CiLc1KVXgt5+0tSvq/?=
 =?us-ascii?Q?6lUf/HxuRWfbnGz4w3qmWN+yKawLVN+SHksnY1OJbdb1TwwHCicMk9/YUOks?=
 =?us-ascii?Q?ksNdyd3GM4+K7ftuw/F7W6yrMeBbzYlcc0qO6olb6HSDRspsbqzTUxHGHJLZ?=
 =?us-ascii?Q?qOBHQTnGd/l/tOdqAE81EFpShri63gMw4uifN6odvOs6nyQFoWXFAS04T+Jg?=
 =?us-ascii?Q?2cCk5A8MGeFfvhWzZBJSjEmSnjabGmRBTL4/pDh0phCLS7MB7d6bXyRvt/7n?=
 =?us-ascii?Q?GHPFZ7nSxJKvHZ1HH4bmXMsbz6x8E3yhSwKhIAdmCpkYQRhvUA0pLzaSyR7n?=
 =?us-ascii?Q?sc1C9VvPSYazV6Hto+5d8lXdHZcAwMBDfQhbrmIkXUIpX1X0tKAqtngbwYaB?=
 =?us-ascii?Q?lBB+oUun8aw7/C6QOVCP0qojH3+lf1opwqn/eCcKbRn4lvunDI0bEkl0d3hf?=
 =?us-ascii?Q?VepZFlOlSRP5TLQqyZfY4iZ7oDNxoQ10WpmLabtrQz+uiPnIkgF7Wt1soxre?=
 =?us-ascii?Q?PYN8jJgDQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: cOUhld+apvEAlH+SJ2NDzDNoSD0P2hqSrpx9EAziA79TzdEkl6D2trbNDhnpNShOJeWsZHxsICMFZANxb0Mjvfstx+P2R7is39Z2nlfAaeSaHiL4BN894YQXVryvpGCV1qgpOCx3/RSKUEsYSSF9Lg3UDkMrvKraQzCUzgykdWG2Guozy8u1RFiGzUge3+3BddAVZVCxdAqVCQavONvRG/2GUBboBQ48zvdkdkap+H0zk/2qYEn/bkhfnX09QjYzIfVmAVJMZvINkDNZmVccXgjggiP8fr0DT0A+82/3om4AfwKWc/zlstvLphq86V7sGd9IWdU7aApxDDOO2KauUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9eb616-1193-4780-475d-08de8f2beed8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:46:38.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofgRPWGC9E/j39CggPDBgW9Ke1hgwXKQnx1rfjawvC9yVMCjj0+hCp0lP7GehooCmpOHFiA6n99k5eoBmkI+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:msi_domain_update_hwsize" on:

commit: 8812ea3b58e360d64259b4b79523cec52ff6a014 ("[PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize")
url: https://github.com/intel-lab-lkp/linux/commits/Guixin-Liu/genirq-msi-Introduce-update-hwsize-helper/20260324-104239
base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
patch link: https://lore.kernel.org/all/20260324014754.4973-3-kanie@linux.alibaba.com/
patch subject: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603312126.697741fb-lkp@intel.com



kern  :warn  : [  227.562210] [   T1839] ------------[ cut here ]------------
kern  :warn  : [  227.568011] [   T1929] idxd 0000:74:02.0: No in-kernel DMA with PASID. -1
kern  :warn  : [  227.573941] [   T1839] WARNING: kernel/irq/msi.c:605 at msi_domain_update_hwsize+0xd2/0x130, CPU#0: 2/1839
kern  :warn  : [  227.592907] [   T1839] Modules linked in: intel_cstate pmt_discovery drm_client_lib cxl_acpi intel_sdsi pmt_class intel_qat mei_me idxd(+) drm_shmem_helper soundcore libie nvme(+) cxl_port i2c_i801 intel_uncore pcspkr acpi_power_meter libie_adminq isst_if_common nvme_core drm_kms_helper mei idxd_bus intel_vsec crc8 i2c_smbus i2c_ismt wmi ipmi_si acpi_ipmi cxl_core ipmi_devintf einj ipmi_msghandler pinctrl_emmitsburg acpi_pad joydev pfr_update pfr_telemetry binfmt_misc drm nfnetlink ip_tables x_tables sch_fq_codel
kern  :info  : [  227.597293] [   T1929] idxd 0000:74:02.0: Intel(R) Accelerator Device (v100)
kern  :warn  : [  227.643806] [   T1839] CPU: 0 UID: 0 PID: 1839 Comm: kworker/0:2 Tainted: G S                  7.0.0-rc1-00098-g8812ea3b58e3 #1 PREEMPT(full)
kern  :info  : [  227.652130] [   T1868] idxd 0000:e7:01.0: enabling device (0144 -> 0146)
kern  :warn  : [  227.665534] [   T1839] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  227.665537] [   T1839] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9532.D02.2309201845 09/20/2023
kern  :warn  : [  227.665540] [   T1839] Workqueue: sync_wq local_pci_probe_callback
kern  :warn  : [  227.673200] [   T1868] idxd 0000:e7:01.0: No in-kernel DMA with PASID. -1
kern  :warn  : [  227.678012] [   T1839] RIP: 0010:msi_domain_update_hwsize (kernel/irq/msi.c:605 (discriminator 7) kernel/irq/msi.c:1147 (discriminator 7))
kern  :warn  : [  227.678017] [   T1839] Code: cc 48 8d bd 80 03 00 00 e8 8b 81 4c 00 48 8b 85 80 03 00 00 be ff ff ff ff 48 8d 78 70 e8 76 9d 8f 01 85 c0 0f 85 6b ff ff ff <0f> 0b e9 64 ff ff ff 0f 0b 5b b8 ed ff ff ff 5d 41 5c c3 cc cc cc
All code
========
   0:	cc                   	int3
   1:	48 8d bd 80 03 00 00 	lea    0x380(%rbp),%rdi
   8:	e8 8b 81 4c 00       	call   0x4c8198
   d:	48 8b 85 80 03 00 00 	mov    0x380(%rbp),%rax
  14:	be ff ff ff ff       	mov    $0xffffffff,%esi
  19:	48 8d 78 70          	lea    0x70(%rax),%rdi
  1d:	e8 76 9d 8f 01       	call   0x18f9d98
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 6b ff ff ff    	jne    0xffffffffffffff95
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 64 ff ff ff       	jmp    0xffffffffffffff95
  31:	0f 0b                	ud2
  33:	5b                   	pop    %rbx
  34:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
  39:	5d                   	pop    %rbp
  3a:	41 5c                	pop    %r12
  3c:	c3                   	ret
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	cc                   	int3

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 64 ff ff ff       	jmp    0xffffffffffffff6b
   7:	0f 0b                	ud2
   9:	5b                   	pop    %rbx
   a:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
   f:	5d                   	pop    %rbp
  10:	41 5c                	pop    %r12
  12:	c3                   	ret
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
kern  :warn  : [  227.678022] [   T1839] RSP: 0018:ff11000136797920 EFLAGS: 00010246
kern  :info  : [  227.692041] [    T407] nvme nvme1: pci function 0000:a8:00.0

kern  :warn  : [  227.697311] [   T1839] RAX: 0000000000000000 RBX: 0000000000000081 RCX: 0000000000000001
kern  :info  : [  227.720115] [   T1868] idxd 0000:e7:01.0: Intel(R) Accelerator Device (v100)
kern  :warn  : [  227.733477] [   T1839] RDX: 0000000000000001 RSI: ff1100013bac6898 RDI: ff11000136789030
kern  :warn  : [  227.733482] [   T1839] RBP: ff110030888620d0 R08: 0000000000000001 R09: ffe21c0026cf2f0c
kern  :info  : [  227.734061] [   T2446] ipmi_ssif: IPMI SSIF Interface driver
kern  :info  : [  227.741722] [   T1845] idxd 0000:f1:02.0: enabling device (0140 -> 0142)
kern  :warn  : [  227.742240] [    T407] ------------[ cut here ]------------
kern  :warn  : [  227.742244] [    T407] WARNING: kernel/irq/msi.c:605 at msi_domain_update_hwsize+0xd2/0x130, CPU#64: 0/407
kern  :warn  : [  227.742254] [    T407] Modules linked in: qat_4xxx(+) intel_cstate ipmi_ssif pmt_discovery drm_client_lib cxl_acpi intel_sdsi pmt_class intel_qat mei_me idxd(+) drm_shmem_helper soundcore libie nvme(+) cxl_port i2c_i801 intel_uncore pcspkr acpi_power_meter libie_adminq isst_if_common nvme_core drm_kms_helper mei idxd_bus intel_vsec crc8 i2c_smbus i2c_ismt wmi ipmi_si acpi_ipmi cxl_core ipmi_devintf einj ipmi_msghandler pinctrl_emmitsburg acpi_pad joydev pfr_update pfr_telemetry binfmt_misc drm nfnetlink ip_tables x_tables sch_fq_codel
kern  :warn  : [  227.742324] [    T407] CPU: 64 UID: 0 PID: 407 Comm: kworker/64:0 Tainted: G S                  7.0.0-rc1-00098-g8812ea3b58e3 #1 PREEMPT(full)
kern  :warn  : [  227.742329] [    T407] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  227.742331] [    T407] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9532.D02.2309201845 09/20/2023
kern  :warn  : [  227.742333] [    T407] Workqueue: sync_wq local_pci_probe_callback
kern  :warn  : [  227.742339] [    T407] RIP: 0010:msi_domain_update_hwsize (kernel/irq/msi.c:605 (discriminator 7) kernel/irq/msi.c:1147 (discriminator 7))
kern  :warn  : [  227.742343] [    T407] Code: cc 48 8d bd 80 03 00 00 e8 8b 81 4c 00 48 8b 85 80 03 00 00 be ff ff ff ff 48 8d 78 70 e8 76 9d 8f 01 85 c0 0f 85 6b ff ff ff <0f> 0b e9 64 ff ff ff 0f 0b 5b b8 ed ff ff ff 5d 41 5c c3 cc cc cc
All code
========
   0:	cc                   	int3
   1:	48 8d bd 80 03 00 00 	lea    0x380(%rbp),%rdi
   8:	e8 8b 81 4c 00       	call   0x4c8198
   d:	48 8b 85 80 03 00 00 	mov    0x380(%rbp),%rax
  14:	be ff ff ff ff       	mov    $0xffffffff,%esi
  19:	48 8d 78 70          	lea    0x70(%rax),%rdi
  1d:	e8 76 9d 8f 01       	call   0x18f9d98
  22:	85 c0                	test   %eax,%eax
  24:	0f 85 6b ff ff ff    	jne    0xffffffffffffff95
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 64 ff ff ff       	jmp    0xffffffffffffff95
  31:	0f 0b                	ud2
  33:	5b                   	pop    %rbx
  34:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
  39:	5d                   	pop    %rbp
  3a:	41 5c                	pop    %r12
  3c:	c3                   	ret
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	cc                   	int3

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 64 ff ff ff       	jmp    0xffffffffffffff6b
   7:	0f 0b                	ud2
   9:	5b                   	pop    %rbx
   a:	b8 ed ff ff ff       	mov    $0xffffffed,%eax
   f:	5d                   	pop    %rbp
  10:	41 5c                	pop    %r12
  12:	c3                   	ret
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
kern  :warn  : [  227.742347] [    T407] RSP: 0018:ff11002084c7f920 EFLAGS: 00010246
kern  :warn  : [  227.742351] [    T407] RAX: 0000000000000000 RBX: 0000000000000081 RCX: 0000000000000001
kern  :warn  : [  227.742353] [    T407] RDX: 0000000000000001 RSI: ff110020dbdb8898 RDI: ff11002084c73d30
kern  :warn  : [  227.742356] [    T407] RBP: ff1100209020a0d0 R08: 0000000000000001 R09: ffe21c041098ff0c
kern  :warn  : [  227.742358] [    T407] R10: ff11002084c7f867 R11: 0000000000000000 R12: 0000000000000000
kern  :warn  : [  227.742360] [    T407] R13: 0000000000000081 R14: ff1100209020a0d0 R15: 0000000000000000
kern  :warn  : [  227.742363] [    T407] FS:  0000000000000000(0000) GS:ff11002eb3b3d000(0000) knlGS:0000000000000000
kern  :warn  : [  227.742365] [    T407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  227.742368] [    T407] CR2: 00005577e39810b8 CR3: 0000004077672004 CR4: 0000000000771ef0
kern  :warn  : [  227.742371] [    T407] PKRU: 55555554
kern  :warn  : [  227.742373] [    T407] Call Trace:
kern  :warn  : [  227.742375] [    T407]  <TASK>
kern  :warn  : [  227.742391] [    T407]  pci_setup_msix_device_domain (drivers/pci/msi/irqdomain.c:278 (discriminator 1))
kern  :warn  : [  227.742399] [    T407]  __pci_enable_msix_range (drivers/pci/msi/msi.c:850 (discriminator 1))
kern  :warn  : [  227.742406] [    T407]  ? pci_free_irq_vectors (drivers/pci/msi/api.c:382)
kern  :warn  : [  227.742412] [    T407]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
kern  :warn  : [  227.742422] [    T407]  pci_alloc_irq_vectors_affinity (drivers/pci/msi/api.c:270)
kern  :warn  : [  227.742428] [    T407]  ? __pfx_pci_alloc_irq_vectors_affinity (drivers/pci/msi/api.c:255)
kern  :warn  : [  227.742432] [    T407]  ? pci_free_msi_irqs (drivers/pci/msi/msi.c:929)
kern  :warn  : [  227.742443] [    T407] nvme_setup_io_queues (drivers/nvme/host/pci.c:2746 drivers/nvme/host/pci.c:2832) nvme
kern  :warn  : [  227.742466] [    T407]  ? __pfx_nvme_setup_io_queues (drivers/nvme/host/pci.c:2763) nvme
kern  :warn  : [  227.742482] [    T407]  ? __pfx_nvme_calc_irq_sets (drivers/nvme/host/pci.c:2678) nvme
kern  :warn  : [  227.742495] [    T407]  ? preempt_count_sub (kernel/sched/core.c:5782 kernel/sched/core.c:5778 kernel/sched/core.c:5800)
kern  :warn  : [  227.742501] [    T407]  ? nvme_setup_host_mem (drivers/nvme/host/pci.c:2519) nvme
kern  :warn  : [  227.742514] [    T407]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:179 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3))
kern  :warn  : [  227.742521] [    T407] nvme_probe.cold (drivers/nvme/host/pci.c:3589) nvme
kern  :warn  : [  227.742537] [    T407]  ? __pfx_nvme_probe (drivers/nvme/host/pci.c:3530) nvme
kern  :warn  : [  227.742552] [    T407]  local_pci_probe (drivers/pci/pci-driver.c:324)
kern  :warn  : [  227.742557] [    T407]  local_pci_probe_callback (drivers/pci/pci-driver.c:352 (discriminator 1))
kern  :warn  : [  227.742561] [    T407]  process_one_work (arch/x86/include/asm/jump_label.h:37 include/trace/events/workqueue.h:110 kernel/workqueue.c:3280)
kern  :warn  : [  227.742571] [    T407]  ? __pfx_process_one_work (kernel/workqueue.c:3177)
kern  :warn  : [  227.742575] [    T407]  ? lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [  227.742579] [    T407]  ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 1))
kern  :warn  : [  227.742586] [    T407]  ? __pfx_local_pci_probe_callback (drivers/pci/pci-driver.c:349)
kern  :warn  : [  227.742591] [    T407]  worker_thread (kernel/workqueue.c:3352 (discriminator 2) kernel/workqueue.c:3439 (discriminator 2))
kern  :warn  : [  227.742597] [    T407]  ? __kthread_parkme (kernel/kthread.c:303 (discriminator 1))
kern  :warn  : [  227.742602] [    T407]  ? __pfx_worker_thread (kernel/workqueue.c:3385)
kern  :warn  : [  227.742606] [    T407]  kthread (kernel/kthread.c:467)
kern  :warn  : [  227.742609] [    T407]  ? kthread (kernel/kthread.c:443 (discriminator 1))
kern  :warn  : [  227.742612] [    T407]  ? __pfx_kthread (kernel/kthread.c:412)
kern  :warn  : [  227.742617] [    T407]  ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [  227.742623] [    T407]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
kern  :warn  : [  227.742629] [    T407]  ? __switch_to (include/linux/thread_info.h:142 (discriminator 2) arch/x86/kernel/process.h:17 (discriminator 2) arch/x86/kernel/process_64.c:676 (discriminator 2))
kern  :warn  : [  227.742634] [    T407]  ? __pfx_kthread (kernel/kthread.c:412)
kern  :warn  : [  227.742639] [    T407]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [  227.742651] [    T407]  </TASK>
kern  :warn  : [  227.742653] [    T407] irq event stamp: 2041
kern  :warn  : [  227.742654] [    T407] hardirqs last  enabled at (2047): vprintk_emit (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 kernel/printk/printk.c:2021 kernel/printk/printk.c:2478)
kern  :warn  : [  227.742659] [    T407] hardirqs last disabled at (2052): vprintk_emit (kernel/printk/printk.c:2000 (discriminator 3) kernel/printk/printk.c:2478 (discriminator 3))
kern  :warn  : [  227.742662] [    T407] softirqs last  enabled at (1836): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
kern  :warn  : [  227.742668] [    T407] softirqs last disabled at (1831): __irq_exit_rcu (kernel/softirq.c:657 kernel/softirq.c:496 kernel/softirq.c:723)
kern  :warn  : [  227.742671] [    T407] ---[ end trace 0000000000000000 ]---
kern  :warn  : [  227.746239] [   T1839] R10: ff11000136797867 R11: 0000000000000000 R12: 0000000000000000
kern  :warn  : [  227.746243] [   T1839] R13: 0000000000000081 R14: ff110030888620d0 R15: 0000000000000000
kern  :warn  : [  227.746246] [   T1839] FS:  0000000000000000(0000) GS:ff11000eb5d3d000(0000) knlGS:0000000000000000
kern  :warn  : [  227.748790] [   T1845] idxd 0000:f1:02.0: No in-kernel DMA with PASID. -1
kern  :warn  : [  227.757536] [   T1839] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  227.757540] [   T1839] CR2: 00007fd8fe021c70 CR3: 0000004077672004 CR4: 0000000000771ef0
kern  :warn  : [  227.757543] [   T1839] PKRU: 55555554
kern  :warn  : [  227.757545] [   T1839] Call Trace:
kern  :info  : [  227.780919] [   T1845] idxd 0000:f1:02.0: Intel(R) Accelerator Device (v100)
kern  :warn  : [  227.782837] [   T1839]  <TASK>
kern  :info  : [  227.796542] [    T407] nvme nvme1: 128/0/0 default/read/poll queues
kern  :warn  : [  227.802183] [   T1839]  pci_setup_msix_device_domain (drivers/pci/msi/irqdomain.c:278 (discriminator 1))
kern  :info  : [  227.835748] [   T1670] nvme nvme1: Ignoring bogus Namespace Identifiers
kern  :warn  : [  227.866727] [   T1839]  __pci_enable_msix_range (drivers/pci/msi/msi.c:850 (discriminator 1))
kern  :info  : [  227.962311] [   T1670]  nvme1n1: p1 p2 p3 p4
kern  :warn  : [  227.967364] [   T1839]  ? pci_free_irq_vectors (drivers/pci/msi/api.c:382)
kern  :warn  : [  227.967372] [   T1839]  ? lock_release (kernel/locking/lockdep.c:470 (discriminator 4) kernel/locking/lockdep.c:5891 (discriminator 4) kernel/locking/lockdep.c:5875 (discriminator 4))
kern  :warn  : [  228.376774] [   T1839]  pci_alloc_irq_vectors_affinity (drivers/pci/msi/api.c:270)
kern  :warn  : [  228.383465] [   T1839]  ? __pfx_pci_alloc_irq_vectors_affinity (drivers/pci/msi/api.c:255)
kern  :warn  : [  228.390737] [   T1839]  ? pci_free_msi_irqs (drivers/pci/msi/msi.c:929)
kern  :warn  : [  228.396166] [   T1839] nvme_setup_io_queues (drivers/nvme/host/pci.c:2746 drivers/nvme/host/pci.c:2832) nvme
kern  :warn  : [  228.402590] [   T1839]  ? __pfx_nvme_setup_io_queues (drivers/nvme/host/pci.c:2763) nvme
kern  :warn  : [  228.409578] [   T1839]  ? __pfx_nvme_calc_irq_sets (drivers/nvme/host/pci.c:2678) nvme
kern  :warn  : [  228.416373] [   T1839]  ? preempt_count_sub (kernel/sched/core.c:5782 kernel/sched/core.c:5778 kernel/sched/core.c:5800)
kern  :warn  : [  228.421804] [   T1839]  ? nvme_setup_host_mem (drivers/nvme/host/pci.c:2519) nvme
kern  :warn  : [  228.428205] [   T1839]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:179 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3))
kern  :warn  : [  228.434597] [   T1839] nvme_probe.cold (drivers/nvme/host/pci.c:3589) nvme
kern  :warn  : [  228.440519] [   T1839]  ? __pfx_nvme_probe (drivers/nvme/host/pci.c:3530) nvme
kern  :warn  : [  228.446532] [   T1839]  local_pci_probe (drivers/pci/pci-driver.c:324)
kern  :warn  : [  228.451561] [   T1839]  local_pci_probe_callback (drivers/pci/pci-driver.c:352 (discriminator 1))
kern  :warn  : [  228.457464] [   T1839]  process_one_work (arch/x86/include/asm/jump_label.h:37 include/trace/events/workqueue.h:110 kernel/workqueue.c:3280)
kern  :warn  : [  228.462789] [   T1839]  ? __pfx_process_one_work (kernel/workqueue.c:3177)
kern  :warn  : [  228.468694] [   T1839]  ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 1))
kern  :warn  : [  228.474999] [   T1839]  ? __pfx_local_pci_probe_callback (drivers/pci/pci-driver.c:349)
kern  :warn  : [  228.481681] [   T1839]  worker_thread (kernel/workqueue.c:3352 (discriminator 2) kernel/workqueue.c:3439 (discriminator 2))
kern  :warn  : [  228.486713] [   T1839]  ? __kthread_parkme (kernel/kthread.c:303 (discriminator 1))
kern  :warn  : [  228.492136] [   T1839]  ? __pfx_worker_thread (kernel/workqueue.c:3385)
kern  :warn  : [  228.497749] [   T1839]  kthread (kernel/kthread.c:467)
kern  :warn  : [  228.502188] [   T1839]  ? kthread (kernel/kthread.c:443 (discriminator 1))
kern  :warn  : [  228.506714] [   T1839]  ? __pfx_kthread (kernel/kthread.c:412)
kern  :warn  : [  228.511743] [   T1839]  ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [  228.516771] [   T1839]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
kern  :warn  : [  228.522398] [   T1839]  ? __switch_to (include/linux/thread_info.h:142 (discriminator 2) arch/x86/kernel/process.h:17 (discriminator 2) arch/x86/kernel/process_64.c:676 (discriminator 2))
kern  :warn  : [  228.527456] [   T1839]  ? __pfx_kthread (kernel/kthread.c:412)
kern  :warn  : [  228.532497] [   T1839]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [  228.537734] [   T1839]  </TASK>
kern  :warn  : [  228.541003] [   T1839] irq event stamp: 215957
kern  :warn  : [  228.545733] [   T1839] hardirqs last  enabled at (215971): __up_console_sem (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 kernel/printk/printk.c:347)
kern  :warn  : [  228.556322] [   T1839] hardirqs last disabled at (215984): __up_console_sem (kernel/printk/printk.c:345 (discriminator 3))
kern  :warn  : [  228.566915] [   T1839] softirqs last  enabled at (215908): handle_softirqs (kernel/softirq.c:469 (discriminator 2) kernel/softirq.c:650 (discriminator 2))
kern  :warn  : [  228.577608] [   T1839] softirqs last disabled at (215903): __irq_exit_rcu (kernel/softirq.c:657 kernel/softirq.c:496 kernel/softirq.c:723)
kern  :warn  : [  228.588198] [   T1839] ---[ end trace 0000000000000000 ]---
kern  :info  : [  228.608877] [   T2296] i40e: Intel(R) Ethernet Connection XL710 Network Driver
kern  :info  : [  228.616739] [   T2296] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
kern  :info  : [  228.706584] [   T1839] nvme nvme0: 128/0/0 default/read/poll queues
kern  :info  : [  228.737888] [   T1644] nvme nvme0: Ignoring bogus Namespace Identifiers


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260331/202603312126.697741fb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

