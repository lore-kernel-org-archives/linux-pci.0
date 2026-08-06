Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3350276;
	Thu,  6 Aug 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042026; cv=fail; b=qrwlW0JV/M9xf57s7rNiSqZj5o3oLElHBCOFQcnKK/fmA0DNwx/+L836ihEsaTBV5TUV0fKelUIKiGaxMeIEy1Cm+zO8wjfA8qXeyaO5ALSEfpcDG8tdRZU5X4c3Bd5A36xAbySPgTUfioVudKxrLMoYy7gwQc/wHGrAH+2dH3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042026; c=relaxed/simple;
	bh=jYzwX0mdHUPVz7BxeDn/7EfrJeNjHmVsQSe1p7G51Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gh1Q+OZt3MrQMEFnwZPxgI8xKRSo8gsfsZLPUdrOKFJFk1l8HhSfpL6BppkaDj4/5tP3qBfv4hALUstdTaxN2REC1twJmjYv/X0gLKoIEgVwPrTkcsaP2uriuMMYeMVbAj3QqFrppKN4c6p9VfuhpgNMguQoKFgvk6yY8eQjFRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gMR373j3; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gMR373j3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxVOYvGUslHP7cvFMrRfuST9QkxSWq/psMob/UUzhliGgdubxh+vSQtlr5icwc2dwwLWNsFkCEIDZ9t8IpT6ahRFbWF1X/QSEA7PaBdRSmG6hmM0RiGSyqt+2F2CY4JxYPDKZCkKqEhnb/wq7tAyxhsRea/YUecIgJ6T3NomibWGqvMell91VjeADyiaY6m50SLr5L+hmeiErvEuB2wbA2UPghbbhs/chnxyb+s3di+cqykcQfeizNW7GynPY1+bhWE5fzeA/+4+i+fUlTwqHPcgAAyDtNDPzF0dFXx5C/ZLbc9HVkz4z/ie4hwg4WAFxea5lV8oKmFfGTOa0cPlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5iyke4tRgBTUsfQMHoHQ0KdBh/660RiPxT2QxZthFA=;
 b=Y+YLA4yPNRxJFMfLnaOxPtXw+Bueir5aE5Xq2mNHxSj5UcTbopHk2BQCVzpoYAPkZOIZVxCeY/QKJq69qXQZtlInp1t2rLCQaqR6RLxZmTJOUa6PJYa8YpI+Wo4Wme09cSUw/+CAi6K2EPhW/M1LdMH14umVf/sGIMNW/PiV2yYsSGWHeElyMDgBL2IH4x8tzS7eRHGLEaSTBpTbjppnDBG/iIyzEAqjvErEdsncnNc9h6YWIhA45ohhrzotbC+qrlcqrXA94OAGx7VkOOaL1Scw/5P6IlrxM26IAh52xbSp8NAgHpox4xmhK+hBt43MNFK7Tqx3vbA/k4DeFI3uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5iyke4tRgBTUsfQMHoHQ0KdBh/660RiPxT2QxZthFA=;
 b=gMR373j3QRF3xfzqLrs0HH1dBUGb+7uDbqsOy0YBkC3RYcG7Dr2teythojBraNwWDKjpsSfeeMaEuWWrWjOhY097b8SP2CRVHgAK8onYko/99t5mCFUKj1zRJGaOZTutPDTL8Vjq/RLgG/qi19KQXlrEns2hsdoTZhh3VcIXjXyfasaMj5Jnx6aAFuEFsqY1YnYAiuJz0+/8WNGLKcGhiyyL6hiPVeQhwJGOHiE3xpz09DfZj4ZRE+Hc2MRfUCMXNcadgWIJGVytV9bDXaKzRpTiwl0pZf0/rgqvGB74Nv+eOKmbKUo7c7aojnNa6vS85IvZJhiQ+CZpwTB02HeKxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 18:47:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:46:59 +0000
Date: Thu, 6 Aug 2026 14:46:53 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 10/14] i3c: master: Add helper to query bus wakeup
 requirements
Message-ID: <anTWnakfL4H8RE8j@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-11-adrian.hunter@intel.com>
X-ClientProxiedBy: SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db778a8-a462-4453-cc94-08def3eb191f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|366016|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EFl9X/sU21hk3AgJNKJOajbWbdaYZ1j5Cmp5j97ej6EEhDZLH0IjJTlLgsri4fatYMoI/8hlGj72KWVmgjkpx1ibhbs4uXTrEyPr9V2ysGtlMSr4XaBhrE3tS+nFYx7ZCMYvoFrFious2xb7HtOM28GNbJe4z4Eqb2lyQkSaesY/xR6z6BZyinjPsiZehJbfGZF4Hqvo45QOgWWExiY+uIfgfkD47SebFC7MAar71GVJG0NpqMjzD5nE0yhoQnMeYdTwNQNR3e5oSJgWF9BXqkO8LAhyF3jWrYcvcqDuH+h5PtZAWYzO4T5yMDXz2/vjjf3tG4PHgXny3dVT7x1nlgLCvHV2bpR/KMXOgIEokEE6QYJralp6YwYk3ygpe6eEY8DLqnjC7PGUexADM7DgbrSNK5972qJNkmgPFbvx4LCFAJ0xyib1kr4xuECyTSxJdJ47JoFPN8rISL13hyKATASJD+Uucal6NkZpPeiBz739zFQ2ry+z6sjaW7ChnLcE9O06q2jtSHLWljYBRn2nXeB7yA/Vw82XvLV3vdBBUs/BvbWVVV80BCWUkJdtPAE4BjP2Dp2siH6LzphfrxzbMbWircG0Bhe4YEweHd6F4SB1cLNjCky4m3XwPll8neZu35ZhLa/gFPgHbckhdFHHi/lObJqZdJgsat0a7Nkj9zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgx5NhFxqHZrYZ9RVq1Nz4lr/jYIXSC3VEC0KA92m9WA8JUSw7hhBE4bz6TP?=
 =?us-ascii?Q?vOq8lwffte8yZLUXLstNQFUr9Zafy+8X/lIpqlsVtBI75A/NGKDfkk/Nryvu?=
 =?us-ascii?Q?XIuFuoo6mMUy1mqlTuJAzThYa5nVRzCM4HrdZP7mLAy12vhCv/5sFM3RA8i3?=
 =?us-ascii?Q?GgUXK4QDY5tKWJ9KZE72Q+b/HBKyN3x/gNQSIDfn/Rm4ri9vGpkSv8lvWX7J?=
 =?us-ascii?Q?/ebNDABA+jk+y1ML72tlscluwFqxhBRaIElsUye0DkE/IEmLhENVLBxHK82I?=
 =?us-ascii?Q?kDX4QXZQeMPEeDTIWYf8uX5breaauPmrOtSL7dkiUXoly42gCy5GZWDAJNSZ?=
 =?us-ascii?Q?XBurd1sSLrM4hkjKDNYMw9miLfQnLflL715pTIQbtC47i1xwYZyzL6+il0qL?=
 =?us-ascii?Q?hD6xXO8Sw0H8bPlW/C6EBNgoQIkUg6oirRE4vEFS7/JCFKHYc68RSu9Ihk4x?=
 =?us-ascii?Q?OL9JOyukrO1kJ91NFPMgde1qZtCNhkNr8z+fi3/qUwCOENfW0QcNOZFm4k3a?=
 =?us-ascii?Q?W6PvpjHNmwD3s9YsCUnbZ658xiS/om+2wIJCiqgAQ8WUjiO/UgyS9Qo+6jLW?=
 =?us-ascii?Q?BrpqW5AFe7ZwGTS8u7H7jMkAGXV0vaqPqd/NtKrro9q9LIFPbS4k2w+IfdIV?=
 =?us-ascii?Q?0TgklqEKCteQm4lfftTvWeksYkpfBq5B/NcIPZaSJAc8mT00sfcxHf0SzJN6?=
 =?us-ascii?Q?Pd4cKk0Fbu6LzME7DGwtj1DAgMuyEMUVcvbb0f3SWmjrHwfPIOZVgPv9Tv92?=
 =?us-ascii?Q?aYTvZsORUwNIOskGCUHCMT0OuQrnlyysCIbDjoOt9aFDDyH5MFLcUmoBMO15?=
 =?us-ascii?Q?dmQRECBH6CgbIwoszo0neSUzzwxrXSgsD8gnnoTBrshXUpEDoZMP2L4oRRwd?=
 =?us-ascii?Q?a6n5gSkRczWDR+U2bWqHVgGOn5sq/2LAYocBlkT++lc2TBze/6hlvXmtnBKA?=
 =?us-ascii?Q?BoKw6rsCdjfhLWCKiEiViMAqOulPpjmED6YnQqtmkQWU/Qjew2IrDIqH09VM?=
 =?us-ascii?Q?gDWrleeqlWerkaWG9EMLYN2QFmK4Y3VIJjXVw63EkiVDrVSLsNPUTpoSikJ6?=
 =?us-ascii?Q?NTuv4+luwejZdtz2QwfofVIih9BmewBGuFOoKIZKLgmiN69OIyaGVA0VyVYs?=
 =?us-ascii?Q?ge9ZxlEx7lHLaweHqTSlIbJDUTBC0cxc9nbnrz3mgflXzXqcP/BM35kH1Mhm?=
 =?us-ascii?Q?e5nbupWJiM+vAXj7Qi8e+T8lSMjP2rUHSZlhOL+Vr2UVFyJCCI057y1FL050?=
 =?us-ascii?Q?Qu97pUmShkMXvTBeZIkswPNZG/JaOIA55iVXbsyCnl2+Q0yWUIgRdPejTpA8?=
 =?us-ascii?Q?z1yMLZG/iDQcpDqgF3Yi0m1RGc7hcczvGbuYgfR/zhnKVOAbEilS6D02JuOb?=
 =?us-ascii?Q?SLuQaJY8opnRitgG0azfJryoFB81EFhwJBaSkENe3lcswkDDcYaD9VmMPnad?=
 =?us-ascii?Q?Lj+48AGUHpNkIXL92NPKTXb3oMyBUkdUTJYrAWWQQllCw74LfBjeCeIsycUK?=
 =?us-ascii?Q?9f6jpIERX0VaPMB9EKbZ1Y9rZXeBOZ1PxYeQOV16RUGenRrJBn6Mepdb/oe2?=
 =?us-ascii?Q?qqhAB7sZZp5urbyfe3JhsXi0BtCJ/T1/99APK3hCtUA5yCyAedPjQGIynh7b?=
 =?us-ascii?Q?6gfjLjTChshgrDooU33Ix34W5NoNs8qjRZ15oYO41XB3UUCBcpjT9xiP23c9?=
 =?us-ascii?Q?atuYNP9qZaDQfKj+AtPIaKKfHnJpN/3l97lvaiWusSpGpCSe+DYOVmYDiEu7?=
 =?us-ascii?Q?tthMZVa/BpPo8GP2mcK4kqKZgPgH2Vci++Bi/5ijeRnzK6035rQ2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db778a8-a462-4453-cc94-08def3eb191f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:46:59.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spQxmnFQ465MnqVrtOQLOt2heM5Xv06UnyQYtIaSaOZnKmYp45++2Ze1AK1YR8IEEbevXlpMafFxJa1kYWGBgearnWLSaK317qt7csm518xMLPY2siJ36JIiAmcHwNLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

On Thu, Aug 06, 2026 at 04:18:53PM +0300, Adrian Hunter wrote:
> Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
> on an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
>
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	Renamed i3c_master_any_wakeup_enabled() to
> 	i3c_master_has_wakeup_enabled_devs().
>
> Changes in V3:
>
> 	Skip the master device explicitly.  Added kernel-doc noting
> 	that wakeup enablement is user space policy, so the helper is
> 	meant to be called from a system suspend callback.
>
> Changes in V2:
>
> 	i3c_master_any_wakeup_enabled() now also requires the device to
> 	have IBI enabled, not just system wakeup enabled, so that a
> 	device with no active IBI request does not keep PCI PME enabled.
> 	desc->ibi_lock is taken while checking.  The commit message and
> 	kernel-doc are updated to match.
>
>
>  drivers/i3c/master.c       | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/i3c/master.h |  1 +
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6c5341491944..afcd7a21a3e6 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2147,6 +2147,41 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
>  	i3c_master_register_new_i3c_devs(master);
>  }
>
> +/**
> + * i3c_master_has_wakeup_enabled_devs() - check if any device can wake the system
> + * @master: I3C master controller
> + *
> + * Iterate over devices on the bus and return true if any device has
> + * system wakeup enabled and IBI enabled.
> + *
> + * Whether a device is enabled for system wakeup is user space policy,
> + * settable at any time through the device's power/wakeup sysfs attribute,
> + * so the answer is only stable once user space is frozen.  Call this from
> + * a system suspend callback.
> + *
> + * Return: true if any device may wake the system via IBI, false otherwise.
> + */
> +bool i3c_master_has_wakeup_enabled_devs(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	bool wakeup = false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (!desc->dev || desc == master->this || !device_may_wakeup(&desc->dev->dev))
> +			continue;
> +		guard(mutex)(&desc->ibi_lock);
> +		if (desc->ibi && desc->ibi->enabled) {
> +			wakeup = true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_has_wakeup_enabled_devs);
> +
>  /**
>   * i3c_master_dma_map_single() - Map buffer for single DMA transfer
>   * @dev: device object of a device doing DMA
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 9d675d01522c..82d9886e7f12 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -765,6 +765,7 @@ void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
>  				  struct i3c_ibi_slot *slot);
>
>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
> +bool i3c_master_has_wakeup_enabled_devs(struct i3c_master_controller *master);
>
>  struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
>
> --
> 2.53.0
>
