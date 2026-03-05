Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE524334C1C;
	Thu,  5 Mar 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714925; cv=fail; b=CVISiRNzLvtOhWSN/KEIcBB2MWFCB7UhtSs2CYh2FJVpZIblD1EEWrVgWFDtjd3beKJ9S6YxFIiz9YiJpgYHh3iywl82F48QohJ+6RdbEfu8KsGyDZxkxHlMVZzfJ7hNnM/Sjur5HAt5QvBn4RWgrf1gTaRG3SFD4mM6FDIS/3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714925; c=relaxed/simple;
	bh=YoUZo65lK28dj5vj6ccVSpPJx+vqdd+37DZDN5wGeHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RasgrnGdQmGS6k01ZHivOPF6FFtRAYWL5fyMnuyjb1C/j6jXvhQOQY9ZrQGHYZeroNLv4IqK2Reatrbc4G4X10L7oxCXaRKAxTIvHN+x4W3yO9NRe5uNSlVUvasu/ox5UuY6806a12X+NJKoDRLAE/v34U0d2xIdyd6nyqKKK4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HFXrDDBo; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HFXrDDBo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktK2V14EfLnCUemJmRRlDS5GKd+Mb3AdFaDFMoAqQcAO0RFB+TPKvgWrqbNsbkabQHLeR1ADf3oIiUeMr+8ZEQV4QwMGHrH7zvsZowkXWNf0YmntGvJ0mQ7me0YY+aU+FArXvWysH6lkuMuCxY/VeTQCPyMt1uMTnz2DKuh8tPBq7PpIbY6o2wvFrqUCRDdqqSLdeRBdG4OojSLtGJ2oQCCEPxcUNQ+7q3o/Xh+m2X1NKsI0756dP4CUyksQZDqfs1YAgNgaSpNEe3FI0QtUjGYSVP+7reDVgUoUwia+SHV7Ewzr1SpGf8vPVvK/ZQa7tzOx2p8KUgDTZCu/rm9S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qirgkoyMDfoVbcC2KVdR1sbnU2w9vWF4ASb+lgFASOU=;
 b=bmvtCdxu2ec/B4HFYeCiYTLNXgs5U9d/nqN0nlwJiOlTuukNhy0GR3lo+9klpJFu7Nupg/YmjIEtiaB77htJND070KLhgSdLV1VGNPTwFzPPbDOsYqbb+W2Z3w/LPJSQ5RJT/S/EWfQTiQV62sWgbs6/pLxeL3w9cZ0miBvBzjCz/OJRjAE6Iq9DJCHRgLATDAEcql38JU3ykIKuBqvdSDSa79x2zx3Hi2wqEpC8RnnOouVx78CLjKai7fzGlej8+f8LRwLC18mHfid7bFMPJOlw2264jkVU/7SFJP+ilFbaAziOLhbZysPqdmCn3Q9ozCnJYs+BuVu1pBzuPkF/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qirgkoyMDfoVbcC2KVdR1sbnU2w9vWF4ASb+lgFASOU=;
 b=HFXrDDBoNVaCqy+eX0iatLzUIMU+EIrTehFeNiSDjN6VP1Oo0PI5XdqeNOFateO97+11OUYJvTw2u792W0DiVxzcOHWDwKPPZGDalIfGNZBZIu3A1SdsfodcnGYRDSnKv5LQRrKK6QolNSGZJ5oFPmXjuSj5uletk8M2bPNqJktKK6RED6tRWBBD/ehOxe/509uvXfyrumBKN7O+a4a9vIplvPvlkGM9eJHRbEPgcwiCM7M4nYo625cACUXR7M2GXU88JoXh2p2c9iqvO4i0HrTWJPpfDNXfE/tCzKXUOrJv9ZtqIIQqcjp20cQbRlkrQjpVvvsY4jJOSxUxeGHoFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:48:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:48:38 +0000
Date: Thu, 5 Mar 2026 08:48:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: dan.j.williams@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260305124837.GS972761@nvidia.com>
References: <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
 <aZn9cfhv0YRxI1mw@wunner.de>
 <699a3ff3f019a_1cc5100e1@dwillia2-mobl4.notmuch>
 <20260223171527.000016ef@huawei.com>
 <699ca65b5ff9b_1cc510019@dwillia2-mobl4.notmuch>
 <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a903d4511e4_6423c1004d@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8566a4af-f860-4204-6fb9-08de7ab5854b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3122999024|7053199007;
X-Microsoft-Antispam-Message-Info:
	yHU5nRCQsyeu0b2g3H/unERLUt0mmUJMn7ESh9cVkZM4SJmu3c8dxwo3oMF0A5SJ7XDVqxDZDDIzoVwULWgj4N6SqBo03tNdMi5NSmufWAHgvHSA0VA2EJCWkXKtRgm5PLZf6m4UhIK/oGo7JTDNl8zvhI3CKQkz4O4X420+Paos/VG9VI37M5zxJkz9vvR9iX9bcAQzXYziQbyL+QqzwIYK9MRZ2N8DZewrh8nBsMvsyhEC6M5yEDy0J0IWFunUrn3gdQgR2wRqVW3vP1yNTgGCYmWJSUOPn5LpMB04Q3cWRCnpxltbhGkSDmOIuAbNGPRpVPY9hp0j7LULg6VTWfiUnmzvSO7iPhGe9EElHPn8rYkWh87954/16Rf/HJchqpvNDK1b63OPvvkjj7X0S8eoSt6EALyAPeds5unjxeJKJ/IYHHofWk++/7pEbsBJnt/gl4L7lvFQ9DbekG8B1bdt8u2ndsfALFF5tjEVGRdLjcRiEEFMk2pa79GwdpESICZO95B4raQYcFH5GsZQiN5zDK8+BZtIJ2sPCip/7Q1wCgqirTWhNuzCrRRExQpD07Z1mLQ/qevP7YORlvFudzkn3m8UbysiusKgtYi9v12QOOC/72cG/779cPFNQtilW1Mfzs73PE0StetDaeDd72bYQUQt4k9C4qqorHVbyZKpwd8rkrpsLU8uNbR4k65/xnydDFtCxOPKL1d0JTDockpeiZW+M7sNCI+5+Cc5kR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3122999024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MOFOG7vIDG08oE9W14f1EfkicS3YuZ4oMl4dx6/5zodU1bRZd8XwcYI/smVC?=
 =?us-ascii?Q?lIEmFUfvrx23srkBSM6m/9NKGQU3ux8Kg7vEU7KwQyh67fLCKznYKasimD8h?=
 =?us-ascii?Q?4aeES8nyRvzr4KN7FjiLtlW/GxTbVhvP/ypT0aa5lr59REQDMgWQxKaMfFVu?=
 =?us-ascii?Q?sjo5P6nUF7WWOVmVx9VbFAf84XlCIcWPHijdEpv249dkbMmwE6U5ij1HD3xw?=
 =?us-ascii?Q?9NsbVmD9ScxJWcKhRtNvYsvFEUA4TxER/+pz7w1tYa1e6NYT2KJk25PPObEF?=
 =?us-ascii?Q?o331sqfT04FmSmJwdRCcykack1yJOoB7ebag9ZsVmNeSUIboDJS9LsVMgGt4?=
 =?us-ascii?Q?zDaiAbyw0Ho1mbbi4/IEycfMUz+CO1+Lq8gJl+fjtxo2GKqm4esh+RI5kh7f?=
 =?us-ascii?Q?4exdR/8rCnz9ojnXApqf9R+djQLXq4XHZZI9ZYi/FVFAuDL+pAcc7z7uXxRJ?=
 =?us-ascii?Q?+/rXdKmn3N0kS7UkN9WDGoagjJTt5J0H2Glmn30m0weakeivm1OUuMlzdxPf?=
 =?us-ascii?Q?PtgAHhNCtbmDjLzNr2fA1kcwMg3qkVVZEBHjN2junpj3LS+FXkJFXUwNpM4M?=
 =?us-ascii?Q?Y+8y0EakjBswg+9QWjeaEiJKEqEo40glc317Uem+GvaADn1Nf6k8F3bgz/yh?=
 =?us-ascii?Q?Ksx+/r96Bej0Ayjxt9oJofRbaVRsZF2SkEm5pEQc8RbQQ+7vNY8Mx+a1nRJI?=
 =?us-ascii?Q?QchpC/YxTFxzDRi8ZS3MD9LKK1zEujXUdiEH9W8N3ErD/jaC89VzlmUZjHaN?=
 =?us-ascii?Q?dsZ60LjXYNmFICAbMZu/TVhbvreKGIb1d/Lhiyzr7SM7qKxWv6c3dVxJlkNz?=
 =?us-ascii?Q?qWlLypyMbeGql8SAA01o+YipGFxwb+j0QZWgTaBaDSuPH63u1KukTHC4ms36?=
 =?us-ascii?Q?0dVncgM96SFfxOIFy/Zp4cAU5O+CJl8a+cdX9fE26QWpGGuAGdICVHAefc+M?=
 =?us-ascii?Q?axP78jjIztXvEpIf9vbTsIaORjCEEX9z9mA8KPALugMAEXGejdiIEROmMOse?=
 =?us-ascii?Q?1HdFqFsi4BTQPOZr/1eUAL33/iYuvRTXLiYA0LPhtPV3PSQSV3xveLC49Rf+?=
 =?us-ascii?Q?lL2c1fGnO/YzJqzobsUUIvlEnAq02lipTOIiUf1D3Rz91ociVRpJ2Q4A9Czy?=
 =?us-ascii?Q?E7CY4lH1xQGOiOOrQ4TJ+Nx5HMwdNTexHj6bo3gfjC+E8vXR31XtNGZ/2a3O?=
 =?us-ascii?Q?wOcxdliF3RF8ObOTQIapZi+UGNEGaKs0WsitI7wfBMtkPUrS0UXDma107+VQ?=
 =?us-ascii?Q?NS+HGMU3a5e2EluRBolYY2BCIWAdICAtTEPCBHkDxIAlq6k8nNZ6UkXMVucw?=
 =?us-ascii?Q?b74E2QekfprDJE5OK0/Kg2GVWXv0OXTqKzHYnreo3gucTQA9kmnIv2kfiyBh?=
 =?us-ascii?Q?r72jw9s3VhQCi9ck8LVwUk/enACffjtgPqqopTGhqUhij5hCj0OV+8bPN3i1?=
 =?us-ascii?Q?ca6Vswb+mT7OyOLidgA4YxKAGHFE9V11ngh02YS0W2G3jZ5/7EMygvo0m6D8?=
 =?us-ascii?Q?bX7V9EGhKtTzHtWHbS3hI3Zvh+cvYIww6e5lrhED6c+6RmntNVL42z/86CUF?=
 =?us-ascii?Q?Q9IBoSft6d1wPp+/efkDUPz46OVtLPs+t6Yo870YeRi8KZoMIY/lVB+5gD8l?=
 =?us-ascii?Q?J1BBsG5fjEPcck3rdmNdMMwjc4t4JvenKLBvb8oDKXGzJ9UD/H5GMBx4HP7z?=
 =?us-ascii?Q?TcMBxevPEYhhs+GE0bGTBfI/AYpsbVN8QcqrYKBplJ9qt2vpaGcIQkksJbLs?=
 =?us-ascii?Q?ug9a/+lCwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8566a4af-f860-4204-6fb9-08de7ab5854b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:48:37.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkfEFHw0Uv8nChGNFuvpHk3hB00iQazqncHnVOtIRh86rRfzTciXC+XUPhDoQ5UR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

On Wed, Mar 04, 2026 at 08:17:24PM -0800, dan.j.williams@intel.com wrote:

> So I ended up dropping this bit of the proposal because there is no need
> for the kernel to be involved in any decision about the validity and
> sufficiency of device evidence. Userspace has everything it needs to
> make that initial determination. "Authenticated" simply means "evidence
> ready".

Right, this caching was only for the automatic device recovery flow.

I think the kernel still probably needs to check the signed nonce
against the device's public key as part of the SPDM handshake, but it
doesn't need to do any validation of the public key.

> Automatic device recovery into the TCB is a separate concern that needs
> to be prepared to handle more than just "is this device able to generate
> a fresh signature with the same cert chain that userspace saw before".
> Yes, that is a minimal requirement but not sufficient for many cases.
> For example cases that want to validate measurements, interface reports,
> or opt-out of recovery because SPDM session loss is fatal.

Yeah, but it is a pretty good starting point :)

> Authenticate a device
> =====================
> Look in /sys/class/tsm to find a tsmN device which will be either an
> instance associated with native kernel PCI CMA/SPDM or a platform tsm
> like the one provided by AMD SEV-TIO, ARM CCA, Intel TDX, etc...
> 
> echo tsmN > /sys/bus/pci/devices/$device/tsm/connect
> 
> Once that succeeds the PCI/TSM evidence netlink interface is available
> to dump any signatures created during that session establishment.
> 
> After userspace is happy with that evidence it can bind a driver.
> 
> If running in a confidential VM where the TSM driver is capable of
> securing more than just an SPDM session the interface is:
> 
> echo tsmN > /sys/bus/pci/devices/$device/tsm/lock
> 
> Similar evidence can be collected, and when userspace is happy with it
> it can accept the device:
> 
> echo 1 > /sys/bus/pci/devices/$device/tsm/accept
> 
> ...and bind a driver.

Makes sense to me, userspace can figure out what flow to use.

> Auto-recover device (future work)
> =================================
> By default, devices fall out of the TCB on recovery events for the TDISP
> case and need userspace to rerun the lock and accept flow. For the
> native SPDM CMA case the default is that the kernel continues to operate
> the device post recovery and only userspace polling could detect device
> replacement.

Even with SPDM the kernel should know if the SPDM session has to be
restarted right? It could squirt out a netlink multicast message, or a
uevent on these events, so the polling is not baked into the
architecture?

> To go beyond those defaults the kernel needs userpsace to tell it how to
> re-validate the device. I think that can be as simple as a netlink
> message to store hashes of cert chains or measurements and then use
> those in a new challenge / response with the device with a kernel
> decided nonce.

Yeah, I see several reasonable options:

1) Above, kernel is informed of hashes and does an exact content
   compare

2) The driver operating the device has a built in same-device policy
   and deep parses the evidence for equivilance after the private key
   is validated, carefully avoiding volatile evidence bytes.

3) User provides a BPF program and it runs on the evidence

4) Standards bodies define a generic "same device check" algorithm for
   the evidence and core kernel just does this for compatible devices

> The equivalent behavior to what is present in this SPDM proposal is
> extend drivers/pci/tsm/evidence.c to add a netlink operation that tells
> the kernel to cache the public-key and challenge the device regenerate a
> valid signature. Then plumb all the recovery paths to call a new
> 'struct pci_tsm_ops::revalidate()' operation in all the same places
> where this patch set wants to reauthenticate. Later when something more
> sophisticated than "challenge the device to create a signature" comes
> along it can reuse those revalidate() hooks.

That's a nice simple starting point.

> Auto-authenticate devices (future work)
> =======================================
> One of the nice aspects of the .cma keyring proposal is that it would be
> amenable to CONFIG_SYSTEM_EXTRA_CERTIFICATE. Give the kernel the
> certificate to validate device signatures without needing to ask
> userspace. That still comes with the caveat that it is not sufficient
> for the cases that care about more than mere signature verification. I
> am not opposed to that being built just that it is not a policy that is
> implied by the device "authenticated" state. It is policy that is
> incremental to the base which makes no assumptions about kernel
> verification.

I have no specific objection to this, and we have many example of
kernel having built-in policy with an option for userspace to take
control. But I'd like to hear a solid reason for a use case that
requires it. I don't really buy the argument that userspace is too
much flash consumption if all the implementation is doing is checking
a few certs using an already present TLS library.

Jason
