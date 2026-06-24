Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247933B71A3;
	Wed, 24 Jun 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311225; cv=fail; b=ehO6QQrIdx5mtOazDW89FT8aqfg1JXILtf4hpI2yFhowvjA63k4SYD6igHWMgmcsNL2DfEcZjuOdhhY2ssgZBMweoWffz/j4+nfHDj0UY3ZzWUgSyUKEf4Hfb9vyH3bCmqk+tPDl93M4nU3/MWvf9LWYazOmerSPKFEZAioBzo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311225; c=relaxed/simple;
	bh=cU+SrMQqlvwk5Gf6zwvKV3yg9DdghQSjdFOPSIDsc/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czPxB9ZuZExKHuawuTFzOXjzzZGte1erMs9vn6FJVNlBSL+TZfpiCXWYYPrb2r+r4sLfsVWU1xdIXp37z59UIxtKqHJJozOXfmmY1ES0WSWvfeb7ro/1PsujyWLq846LGPlEyZmEJCtoCi2m34ZoPDyOyqZoil8mHs4n5CopCOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ri0TMqgU; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ri0TMqgU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ/hL+sZGNEHjZanBZ+giTPo1pxLpyQ+NUcc94Z+ZzumcM6exoabwYhPVWJf0UDJrhs8BdzcURkSMjHuYa0qLZgR0C5StadV9lx94vTylTpbnbsr5pZaDGDUL86+uJC/hYd7Z5iVsdgaBjpXpnXDR7i1j2t/dEY1PCE4aTApJdp6F3cAZNb4j5804MA4D575CSdcHOrXo7h0YZ3TBUxoRdzi68WDP84wPNwnqC3pC120yzqx6MsCYqeWZfD1xR7wrlVsBSPEfihz2IEJMEtsNh4CWtro7ycg0w+/9kBJcgSbS4oPzGC4r0eLJnG3qUg88+W077vi0Catj/JMDypgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs/Y5/5F2UBzPgdof5iL71T3dTHPgoLTkC8llAFB6Wo=;
 b=qFQi0q9gO8HovkvG9pnb9gqoXdc5yfy6pXfSXITMxiV4pOah26HlW69Ph38JlROVCAC2WPRI0opSzHYK8r5ZY/Ve5REBoOf9cAMmnwrj3b6+1RDLGD4LGOk9oO/YZ6Aff2uQVoSl++3uie0TMqrG5fI9+ZxgNzj34eWmHrVmtZ0PsAMmCs6DnBtcEyA+AXIsz28fdW9AhspItQ08J9+sIkw3fsl+lW4eCX8nu1KIee2lGjAep40uUiuK+/fX1gclp5Ih9qaLMmu2F8+W3TVHQkAWHJ3ujLL8EFljj9RBCXUvfRYqDKTVWFUJ8cjxG23YXGhFv1ZISzD3XapkC4hXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs/Y5/5F2UBzPgdof5iL71T3dTHPgoLTkC8llAFB6Wo=;
 b=ri0TMqgUu07FHB6o2dMbNDCqWfR9+sTyC50IeOeRNgwwuNa63qFA/BiV1dyPKSlrPG6C03zs7R297iHoSvvCJtsm9S6CFkPZbRkjxkNI7bOEOLkK7UuD0rzlplhIp6eD1QIvCO8s/jvR8On6MvEHDY3uVrUM1hHfsRJi8YDCGgYj/xbP4Lr2Hn4ZZDqCCAfXLUcH6fMA7QIN6Im/3P/jyyB8Y74yeWUy4QYsz/xUdy770JU8Cc93Olbw6zEkR6E9NbLUjnC9mJ/WuGA0gLgPvSIRUJMvgOYPrzwPS9Kc6qgLCiVUnxnT9QNXu554Epr3XXTW3YDAFdxHnZxrqhvytA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 14:26:58 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:26:57 +0000
Date: Wed, 24 Jun 2026 22:26:53 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 00/11] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <ajvlJNPOPkm_hj3O@MWDK4CY14F>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 080e2c3e-b678-4c1a-b649-08ded1fca554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	40DsIPhMPllYW40/1Z5Lsi23Sc9P6CBckPC8omMbrqc14EWpefUI5q3Xkdv3f1bxL6zmcxrwtliF10jXnA5WVN578k8Y1ynRKuetAaHax4dEWby4X7vACHCuFWK7llO38BnCXzMW7Lv/1XKAPNswXkp0OBisoBbpDRj7xX7m/ZpuE/ZekPVEIubbKyOIpqosRtk6iEgEI522ABaGTNnoPCnL5hNbuUyUShfVX7ByEf7qq6YcmVM/Umoi0Nct1Ahc1Biyso+RqYY8ujwfAODqiGMzsm1ZvLiBirzrJSdGZ2SLSMUuI0sT+Um7jytQsuEu1grEuvQWq3xhd4+TWNyhdiDmivsSdYjwzi8KNyOyY30DPaAwpRgODzkj8UfjUQtzaTUyj4uR78gDcxbft8uRWnyEoZgZ/ygStcZD3lmMkasNGVhcJ+EGw2tW4K0DKa6PGCSl/WP1d4lC/ijVAOTrzqe7O3asudkZOy2GSBWaO3vJIYZqWc1JCR7L1qTsQsl3x+6NqTou70tKJwDUfHfb632oLSfaziTSP/F5hlOB9aP/MUIEyBSRepShvRLYYF2Q/sGg6Jb2ASD7wEHQ6q0wJo/n1qJr1zTb9nClHH9lu8X8dTzUiUOlTYiEFiL9PpjK5AL1qdkoopVZCVMgm4FW+2Px3OUb6I5GVJAwUPoX2YQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEjsm2i42UdlrRg3AlU140DzOzsRqF5/cB8fDx6S1gvJghi/fYk+z+h7e43O?=
 =?us-ascii?Q?CLThe6/l5F71OZhagiHSns2V/7S1dY5k6e5sjlbkkMJx0Vox3ixO756xk97j?=
 =?us-ascii?Q?OzQdIi1Yqwhbj35RmM8JidQcywg4dNrnByJ1nJ02S1kOOflFZ1HDTNzSPixu?=
 =?us-ascii?Q?zPGWVO/PoTnqHydNDg5Ug4NWXnyw87oCOE8qikoYUtjOGaj4Rs1RCgPpR9UW?=
 =?us-ascii?Q?GZRCnzDKrydCHmsbgeZGW0eII8oYP1kVQoGxtRWHmiu7TQ57TztRheqZd/9e?=
 =?us-ascii?Q?5WqV2vqMJjhqQqV5CUjtkjt4ikNcshZeYn6646w+46sJUW9jLc31lba8pAXv?=
 =?us-ascii?Q?5gdw7EBboCzasEoEE6OPdznBpzu/xEDpgNNe7cM2CYgAfuX1eloynu+pfiu1?=
 =?us-ascii?Q?u1t9gMqYvq0Z/O953emMwQtyZpS6n10bZZ2UF0VQvEY8HvU4/oUT8pjUAGUF?=
 =?us-ascii?Q?DbF3KyIsqlSVmVw89Ug5euqcRDxHL6QjkwL66aqQ2psTlTijgPbCME9C63Bd?=
 =?us-ascii?Q?b8SSibN6jGNjxfJlP2NgyibFh3U3/CkP8DAwrQ+cOy1cYePqFjdBoUc0te38?=
 =?us-ascii?Q?/pMsQpoFmLUSJ8bEa7s20qgQnlmDk5MicI6IihW4hiZG8ONP7PmLjNp9GgYm?=
 =?us-ascii?Q?1wAd7uT6Vkv1PnkCZgnsOsWoJHlbQsixx9T3ni7jCHSFOnZwujf/vKUn4KS0?=
 =?us-ascii?Q?Fid2nyzl/pdCxjzwC+s6XNYRw7ZwJGULYkmqZO05Od5X4ByFv7QoDpimCWF6?=
 =?us-ascii?Q?xnxrppICwLMbFC7/moD1L8ak9IrRI9et5r99pbZ3he0WXAI3qF59bN1gZJnz?=
 =?us-ascii?Q?U9vNo19MwYTQeXSj/OIdnn4kDYLusVh3nwNwzCNkn7rfEmL/Z6j8W3yOBRP7?=
 =?us-ascii?Q?NFV3cLpjxfJ3AuKa7UPMaNg2Te/kyxYz1faIKUgieuPzEqmFM84MqpfGAKrQ?=
 =?us-ascii?Q?37mp3Fp4sZrSdwBtnmvghoWirGlMzaxtCuuPaQTlritfdA6nLJCg2EJq9YFz?=
 =?us-ascii?Q?aAJ8+5HWld3qTncYoKji1jkDHsiO1ftk2t3UX48evEEIESnq2oBWJrtfSEo9?=
 =?us-ascii?Q?kIW5jQSJjmHBm8DLnj9omnKIyv2cntQRCgbpzRKZyn+A2c+7YwYgqnTSO1mh?=
 =?us-ascii?Q?5brFuzY7nIXVRn9IjDFpMrQyfnuFfFABewvOzgipA/0CrzMKkuhTyv4reOkA?=
 =?us-ascii?Q?26mbAGrZJ1cdtFNumLPydFPqXEnqrM8zwKhkPzBpAphNOnCsKw1FEPWEx3Bm?=
 =?us-ascii?Q?t3Eo95utVs28U9DB2rCAOrv7+4zn/Vxm3cfhA9+s8gNcTDkjUR6vEEslq9AO?=
 =?us-ascii?Q?mrSjmk++K7HO2tlUQUmuCKCzZYg9qG1Io9f5XQ7TQq352JcixfuGM2Z5kzOc?=
 =?us-ascii?Q?SmYm23VDaOUI3MX6hejWcBvZ1VroDH4mARtmF/NAziTr5+ggQe3GfgOIYIdl?=
 =?us-ascii?Q?pfgZ6otUtmR1LQVNKoUlHUgmLjgNB9A6sM47XO2rC0EJEbn6YpiS4MdHcFbc?=
 =?us-ascii?Q?6EITnkt/YJRgYpGOY7VMpec/s0nc9kYC68Qzvy9prVHTo3Jw1ZL5+zWesovc?=
 =?us-ascii?Q?xPmNSnSZfivGCPa6RxzsWvv55IwnmB0h5fNJz8GLJxuMoL8t5WSZtv2C2lwc?=
 =?us-ascii?Q?GLmOQhlOGxcnLYmnhdnT6ThSI+h8MDxSmf2Zv5K3BEJMndVg1ZbL4Xd+4zRi?=
 =?us-ascii?Q?hp9ejzFLfJ13AtnpS6fj/HyIyagarxS+elLXaC2n0AcBxxqVemGwXXfCKcDI?=
 =?us-ascii?Q?PMagMEY0Rg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080e2c3e-b678-4c1a-b649-08ded1fca554
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:26:57.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulASFbTS33PUvOLlMEimwwytisPimm6VxZe5HHGKcspgQsMoXTrncUEshlmJxbQCp3F2/Zwv//KyJOueDEubWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

On Tue, Jun 23, 2026 at 03:24:42AM +0800, Srirangan Madhavan wrote:
> Hi folks!
> 
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.
>

Hi Srirangan,

Thanks for the work, I applied your series and run some tests on a
CXL type-2 capable GPU, seems like something is wrong.

Device's BDF is 0002:81:00.0 and DVSEC base is at 0x10c
CAP=0x116, CTRL2=0x11c, STATUS2=0x11e
STATUS2 bits: bit0 CACHE_INV, bit1 RST_DONE, bit2 RST_ERR
CTRL2 bits: bit0 = DISABLE_CACHING

I run all the following command as root.

"""
# b=0002:81:00.0; dev=/sys/bus/pci/devices/$b
# echo cxl_reset > $dev/reset_method
# echo "PRE  CAP=0x$(setpci -s $b 0x116.w) CTRL2=0x$(setpci -s $b 0x11c.w) STATUS2=0x$(setpci -s $b 0x11e.w)"
# dmesg -C
# time echo 1 > $dev/reset
# echo "POST CAP=0x$(setpci -s $b 0x116.w) CTRL2=0x$(setpci -s $b 0x11c.w) STATUS2=0x$(setpci -s $b 0x11e.w)"
"""

So we know,
PRE  CAP=0x8bd7 CTRL2=0x0000 STATUS2=0x8000
==> RESET rc=1 elapsed_ms=114 err=[bash: line 9: echo: write error: Input/output error]
POST CAP=0x8bd7 CTRL2=0x0001 STATUS2=0x8003
device-present=1 reset_method=cxl_reset leaked_cxl_reset_iomem=0

with dmesg no output.

The write() to reset failed with -EIO after ~114 ms, but STATUS2 went 0x8000 -> 0x8003 .
The device completed the reset, so the kernel returned failure for a reset the HW did successfully.
CTRL2 went 0x0000 -> 0x0001, the device's CXL.cache is disabled after the "failed" reset.
~114ms is almost equal to msleep(100) in cxl_reset_wait_done() + the first poll. On the first poll
the Status2 read returns 0xffff, 0xffff has bit 2 set, which the code reads as RST_ERR -> return -EIO with no retry.


After that I ran the same "echo 1 > $dev/reset" in a 25x loop, logging rc, elapsed ms, CTRL2, STATUS2 at each iteration, then dmesg.
"""
PRE  CAP=0x8bd7 CTRL2=0x0001 STATUS2=0x8003
iter  1 rc=1 ms= 114 CTRL2=0x0001 STATUS2=0x8003 present=1
iter  2 rc=1 ms= 171 CTRL2=0xffff STATUS2=0xffff present=1
iter  3 rc=1 ms=   6 CTRL2=0xffff STATUS2=0xffff present=1
[snip]
iter 25 rc=1 ms=   5 CTRL2=0xffff STATUS2=0xffff present=1
### rc histogram:  rc=1 : 25x
### leaked cxl_reset iomem regions: 0
"""

The complete dmesg shows
"""
  [ 1892.870193] ------------[ cut here ]------------
  [ 1892.870215] index 7 is out of range for type 'resource_size_t [6]'
  [ 1892.870218] CPU: 121 UID: 0 PID: 19436 Comm: bash Not tainted 7.1.0-rc7+ #1 PREEMPT(full)
  [ 1892.870221] Hardware name: NVIDIA VR NVL72/P3809-BMC, BIOS NV_SBIOS: 06.02.00.00, OEM_SBIOS: 06.02.00.00 Mon
  Jun  8 08:22:03 PM UTC 2026
  [ 1892.870222] Call trace:
  [ 1892.870223]  show_stack+0x24/0x50 (C)
  [ 1892.870229]  dump_stack_lvl+0x80/0x140
  [ 1892.870236]  dump_stack+0x1c/0x38
  [ 1892.870237]  __ubsan_handle_out_of_bounds+0xd0/0x128
  [ 1892.870242]  pci_restore_iov_state+0x250/0x270
  [ 1892.870249]  pci_restore_state+0x10c/0x2c0
  [ 1892.870251]  pci_dev_restore+0x6c/0xb0
  [ 1892.870252]  pci_reset_function+0x94/0x160
  [ 1892.870254]  reset_store+0x78/0xf0
  [ 1892.870258]  dev_attr_store+0x24/0x78
  [ 1892.870263]  sysfs_kf_write+0x88/0xc8
  [ 1892.870268]  kernfs_fop_write_iter+0x170/0x228
  [ 1892.870272]  vfs_write+0x270/0x3a8
  [ 1892.870276]  ksys_write+0x7c/0x138
  [ 1892.870277]  __arm64_sys_write+0x28/0x50
  [ 1892.870279]  invoke_syscall.constprop.0+0xac/0x100
  [ 1892.870282]  do_el0_svc+0x4c/0x100
  [ 1892.870283]  el0_svc+0x50/0x2b0
  [ 1892.870285]  el0t_64_sync_handler+0xc0/0x108
  [ 1892.870286]  el0t_64_sync+0x1b8/0x1c0
  [ 1892.870291] ---[ end trace ]---
  [ 1892.870293] ------------[ cut here ]------------
  [ 1892.870293] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
  [ 1892.870295] shift exponent 64 is too large for 64-bit type 'long unsigned int'
  [ 1892.870296] CPU: 121 UID: 0 PID: 19436 Comm: bash Not tainted 7.1.0-rc7+ #1 PREEMPT(full)
  [ 1892.870297] Hardware name: NVIDIA VR NVL72/P3809-BMC, BIOS NV_SBIOS: 06.02.00.00, OEM_SBIOS: 06.02.00.00 Mon
  Jun  8 08:22:03 PM UTC 2026
  [ 1892.870298] Call trace:
  [ 1892.870298]  show_stack+0x24/0x50 (C)
  [ 1892.870299]  dump_stack_lvl+0x80/0x140
  [ 1892.870300]  dump_stack+0x1c/0x38
  [ 1892.870301]  __ubsan_handle_shift_out_of_bounds+0x154/0x260
  [ 1892.870302]  pci_rebar_bytes_to_size+0x98/0xc8
  [ 1892.870305]  pci_restore_iov_state+0x1f0/0x270
  [ 1892.870306]  pci_restore_state+0x10c/0x2c0
  [ 1892.870307]  pci_dev_restore+0x6c/0xb0
  [ 1892.870308]  pci_reset_function+0x94/0x160
  [ 1892.870308]  reset_store+0x78/0xf0
  [ 1892.870309]  dev_attr_store+0x24/0x78
  [ 1892.870310]  sysfs_kf_write+0x88/0xc8
  [ 1892.870311]  kernfs_fop_write_iter+0x170/0x228
  [ 1892.870312]  vfs_write+0x270/0x3a8
  [ 1892.870313]  ksys_write+0x7c/0x138
  [ 1892.870314]  __arm64_sys_write+0x28/0x50
  [ 1892.870315]  invoke_syscall.constprop.0+0xac/0x100
  [ 1892.870315]  do_el0_svc+0x4c/0x100
  [ 1892.870316]  el0_svc+0x50/0x2b0
  [ 1892.870317]  el0t_64_sync_handler+0xc0/0x108
  [ 1892.870318]  el0t_64_sync+0x1b8/0x1c0
  [ 1892.870319] ---[ end trace ]---
"""

After iter 1, iter 2 took the device to CTRL2=0xffff STATUS2=0xffff, the config space returns all-ones,
which means the function stopped responding to config cycles and didn't self-recover.
During that iteration's pci_dev_restore(), the PCI core read the device's VF-ReBAR config, which is now 0xffffffff,
and used the garbage as array indices: bar_idx = 7 to dev->sriov->barsz[] which is sized 6. Two UBSAN reports.

Best regards,
Richard Cheng.




> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
> with the existing PCI reset_method interface.
> 
> v7 changes from v6 [2]:
> - Move the ABI from a CXL memdev attribute to PCI reset_method.
> - Drop the memdev dependency from reset entry; advertise cxl_reset for
>   Type 2 functions that report CXL Reset support in the CXL Device DVSEC.
> - Incorporate Dan's HDM reset refactor: shared decoder settings,
>   pci_dev->hdm cached state, and built-in CONFIG_CXL_HDM helpers.
> - Cache endpoint HDM settings during PCI enumeration when MMIO decoding
>   is already enabled, and let CXL core refresh the same cache later.
> - Reduce the earlier PCI/CXL save/restore series [3] to the HDM state
>   cache and restore infrastructure needed by this reset flow.
> - Use cached HDM ranges to reject reset while affected ranges are busy
>   and to invalidate CPU caches before reset.
> - Discover the CXL reset scope with the Non-CXL Function Map and CXL
>   cache/mem capability bits.
> - Quiesce affected sibling functions with PCI save/disable and IOMMU
>   reset prepare/done before executing reset.
> - Restore cached HDM decoder state after reset before completing PCI
>   reset recovery.
> - Keep CXL Reset Memory Clear disabled.
> 
> Motivation:
> -----------
> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>   reset methods.
> 
> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>   the architectural reset mechanism for those protocols.
> 
> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>   before falling back to broader bus reset methods.
> 
> Change Description:
> -------------------
> 
> Patch 1: cxl/hdm: Split decoder programming into a reusable helper
> - Move shared decoder settings to include/cxl/cxl.h.
> - Factor low-level HDM register programming into cxl_commit().
> 
> Patch 2: cxl/hdm: Cache decoder settings on PCI devices
> - Cache CXL core HDM decoder settings in pci_dev->hdm.
> - Refresh the cache as decoders are enumerated, committed, or reset.
> 
> Patch 3: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
> - Snapshot endpoint HDM state during PCI capability initialization when
>   memory decoding is already enabled.
> - Reuse the same cache when CXL core later enumerates the device.
> 
> Patch 4: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
> - Export PCI reset lifecycle helpers for CXL reset orchestration.
> 
> Patch 5: PCI/CXL: Add CXL Device Reset helper
> - Add the internal DVSEC reset sequence.
> - Disable CXL.cache, perform cache writeback where supported, initiate
>   CXL Reset, and wait for completion.
> 
> Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
> - Collect enabled cached HDM ranges.
> - Reject reset if affected ranges are busy and invalidate CPU caches.
> 
> Patch 7: PCI/CXL: Discover the CXL reset scope
> - Discover same-scope CXL functions with the Non-CXL Function Map and
>   CXL cache/mem capability bits.
> 
> Patch 8: PCI/CXL: Coordinate sibling functions for CXL reset
> - Lock, save, disable, and IOMMU-block affected sibling functions.
> - Include mem-capable siblings in HDM range validation and cache flush.
> 
> Patch 9: cxl/pci: Restore CXL HDM state after PCI reset
> - Restore cached global and per-decoder HDM state after reset.
> - Keep IOMMU reset blocks active until HDM restore completes.
> 
> Patch 10: PCI/CXL: Expose CXL Reset as a PCI reset method
> - Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
>   CXL devices.
> 
> Patch 11: Documentation/ABI: Document CXL Reset PCI reset method
> - Document the new reset_method value and reset behavior.
> 
> The CPU cache invalidation step depends on
> cpu_cache_invalidate_memregion() support for the affected address ranges.
> If no provider is available, reset fails before hardware reset is
> requested.
> 
> Example:
> 
>     echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>     echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
> 
> Basic CXL DVSEC reset testing was done on a CXL Type 2 device. The reset
> sequence completed successfully and ResetComplete was observed.
> 
> References:
> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
> [2] https://lore.kernel.org/linux-cxl/20260528083154.137979-1-smadhavan@nvidia.com/
> [3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/
> 
> Srirangan Madhavan (11):
>   cxl/hdm: Split decoder programming into a reusable helper
>   cxl/hdm: Cache decoder settings on PCI devices
>   cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>   PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
>   PCI/CXL: Add CXL Device Reset helper
>   PCI/CXL: Validate HDM ranges before CXL reset
>   PCI/CXL: Discover the CXL reset scope
>   PCI/CXL: Coordinate sibling functions for CXL reset
>   cxl/pci: Restore CXL HDM state after PCI reset
>   PCI/CXL: Expose CXL Reset as a PCI reset method
>   Documentation/ABI: Document CXL Reset PCI reset method
> 
>  Documentation/ABI/testing/sysfs-bus-pci |   14 +
>  drivers/cxl/Kconfig                     |    4 +
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/hdm.c                  |  234 ++---
>  drivers/cxl/core/region.c               |    6 +-
>  drivers/cxl/core/reset.c                | 1276 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   43 -
>  drivers/pci/pci.c                       |   25 +-
>  drivers/pci/probe.c                     |    2 +
>  include/cxl/cxl.h                       |   85 +-
>  include/linux/pci.h                     |   10 +-
>  include/uapi/linux/pci_regs.h           |   15 +
>  tools/testing/cxl/test/cxl.c            |   10 +-
>  13 files changed, 1554 insertions(+), 172 deletions(-)
>  create mode 100644 drivers/cxl/core/reset.c
> 
> base-commit: 72afdd8181219f459142e571999b3b44ef7b85fb
> -- 
> 2.43.0
