Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424338E8A6;
	Thu,  6 Aug 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040798; cv=fail; b=ip8YHQRmGClcUKFENzhp+sD48SXwpnLH8RKDs85GDuDeCrpDCk+A2Kdl90rkobFs5i/hZ8rDlpALBj7Vxh+tUyD+sqGe5LMbMKUwdroAUXE7sGWrZUkcm0aTTntvoeczfLRpofWa9Stt012UZNsqLijI8faENe5uBa7ch/uURtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040798; c=relaxed/simple;
	bh=aFIWqtXlNhRjqKLYm3KK3AZ8nvELk6W26iFHeGdqQRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DwU3hIVbClPHdjcuRKP27mncvfB0KRSyMviXQgdRY2lXK/vRrsRxaXci9RFHd5JGsEmbMMXMPo2xZ+651Tty9WIXtlY6Z6/Df8J4yGXQ25T0jK7AmHhZbUDoxOWl953O4hiqqd3mw+fF9JW2r40ZzKDR5/BuGZ9wP7oGAyCBH2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=yKM+m8GX; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yKM+m8GX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2d/Np+IdjRDicf7r21vXMn7wZlXWqLSPsOQY91Y68Tdlr7aV4Wlbdy0PpMmF+XqdBCtDUIJPVvUN27DK4MM1i8vJ2dnczhihxgz4iiLXpTK2GLYUgcNyEl99NE4CUA1qixGGHL2+mih4dUxLTCzaWg0o3frTD9zgLeqL6V2I50/WQuUe1i/ZXARuO0LlRueUtdgFWtF3FvCWA+js9l5pDE8RCcwYqQSX+I+8KpCYLeG7IwCsSf5C7ng9EzNVQTSEfKkkEJhOupLdRy5NR8YM6E/aCYymo9KdcZZ1Rfh2jPHSJQwp6A6iGcRtGj+cR1351crvk75Lik2CnTLXh/iNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OCSQsJnAv8gJLwCckuvnaYSSQpK0jYdx8x/h1eGrXQ=;
 b=VvqMx2Sj8YRHk4bq9tTvMqtqIeWM/TNH9XZtx4x+Nsn8x/8ZLV96beNBivbbmec00P0ReefSfVLgxy+XrmNLwzB1e3CPGDydrJ+phgYPZTbg7AenvhkWQAVjLG+ABw+ri4q908Ygv4OqDp+BMTxl8oJ+y6oTGg38mQ3PdO/2QauKHtiN3/Z8VY/03CJ/jVt6+qCdY+YNJ/XrhrIYKXEkimSYMzynoOanngyE3bSKcAXPs7wZqgED2RN1x+TRF/Hz9yX6+Sia4doOZX2lo3tAPTazG/11FE1R3WcjMozPU3Z/5WK2XmaU2lGr9dsJgqqkk8PNRQvG/ZEfqqmNApG7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OCSQsJnAv8gJLwCckuvnaYSSQpK0jYdx8x/h1eGrXQ=;
 b=yKM+m8GXjSWM3ZQyOAflffM4pTRcdZkbX2VgR1E9IHNLR0dpduaT7drGLeT1ug3kIsO9WNIeo9p6rsrQJFiXmlTXPQo0UkMQnqMxL8wDQoLISz8xAa+SZ5zXWmlruE3+fid+drAwW8D2nVUQ0gd+dFEj9GfpOmkONJbx6Mq2GpwZWoN+wDmowIdpced5h9n2EeGUJoS+xrYrPciz2ZTbGKf+xijhMh5urEoHaXIKazLGhB0lMRckqy7mZ0dzMufxC2vcoYbYVwnyB7+Jux0hjZSRJuMlyhFruDVc3kfCIwWo6oTY/JHqR/B2vzn2Q+HAIZF1BpMjb/BSnEBjTF8EIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 18:26:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:26:33 +0000
Date: Thu, 6 Aug 2026 14:26:26 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, Frank.Li@nxp.com, akhilrajeev@nvidia.com,
	mukesh.savaliya@oss.qualcomm.com, rafael@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 02/14] i3c: Fix unlocked dereference of dev->desc in
 i3c_device_get_supported_xfer_mode()
Message-ID: <anTR0k-CIRvGcQG4@lizhi-Precision-Tower-5810>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131857.119830-3-adrian.hunter@intel.com>
X-ClientProxiedBy: SA9PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:806:28::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9abbf2-02c2-4957-6a91-08def3e83e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|11063799006|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	+D/fC3c5Cp1X6+2vuNgXBe1TcfpYrFbzpYYekmTz1li4Pi5w95q9dqYX1ZYu+d9RpQYBEd817V5CE+kSruhxAkHj+BfCy85KZx++YYsw9LOiVX9H9tw0WRFSwqLxGxQ0sAm8Jv4zogRHGW5UAzQIQ+tI2Juuc1HXq3TWnqflQqwc7BCNbyIEPN+Xtn5oVnMJQaP5R2c2TK9lfX3Apgwq0ej3jDc/DJ3DoWQjRBLFGmW50ePm2unfk/XZsQbivpACbJWQMzUMOEILTrR8cRgqLSpmyRQR4g2HiPHYZSYoRD/Gv5IMjZ39WCvs3Jf1GCq6vAi4YZ7jcIKXL7pX0ztyvTifJzZtte7skBSrbjwNLXJxx+xeMhNKfbHSPwhg4rbbF2k3U30gRZXUwa46dt5wXIMViimnN/6DY7gTxvkGvw+vthJVXH5c6KKMnQHdD+sFiDpSnOu+ss3UbKr9KK5sq20aLpiksMChu99zFu9L9EHOPhS4r0bbBe+JHQpc1Sq+URJPzWVLAmA/fWOyo8wp2nBtyB14wCe3m7o13Bity0pDOQxn/3TpU3DCYAqb4UH0FAxWrF14iYxgweXiz1/wUih0klPivZhlfzPxChg71riHN7ojx8gms1Q+xIdMxXDu9fAiacd6GeHbY2iHpedIvP/UBQ9qZAFI6ilMaYBN0hw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDmP1EyODN4m+CqQ3UYtzfBSTQ9wii1lTIV+SVwzYGu3Ou0tn8YPp8oOOack?=
 =?us-ascii?Q?x7qjhfz1qvZXOQ+kIjEvbDFKIkMCDrEdV+dSEiQXUP8zUBlrzd1LAdPJ9k4l?=
 =?us-ascii?Q?U1UuDAr4Rzavzm8FOL1eklROd+b/XEI2nzaLgLtCs+y2NtSXLd//vTbLojpP?=
 =?us-ascii?Q?idCfqfCunEdb9EDrmq7TKRgeVTKS8V76fmFJYq3nsxnPGw0ZJk2vAm8xhChO?=
 =?us-ascii?Q?3uMmnUY4l/yYMlJ5+LZjYeoPOIM/ttjMiI/g5u9n3eeSUN9f6HbpGa2QwbbW?=
 =?us-ascii?Q?HStYwdBrweEYjKn7CMeSW723UALgAIcxYh6bIcBuQbq2mQMd4QwZBCLkLkXG?=
 =?us-ascii?Q?dL6CG3gJPLICDcRXm2uw7bVm2o32aJbmUI7IYSxNT5hHUzNSxD2D9/nifK5X?=
 =?us-ascii?Q?0j6865iD734kDuT+UjI4yHy/47cAZnxErrRj3Yazwv6hEQfE/Z/9J65PvHN+?=
 =?us-ascii?Q?WRrQ5qiotIRcEyBUB4808+gDqIWrjc8N9k3yxLMYAyS0XfGFzyelgU0jQCxe?=
 =?us-ascii?Q?utjMh7tdrgfO3hWJ6MqGrSA1H6rAnfVZL2tsnzuqJM4VVjwnoo+Va3X2C7JV?=
 =?us-ascii?Q?DWDwAc9IGY1cf/xO2KlBqH9ZQKk+bpi6c0f12mnUNrWERmn5Byujc2LPVtGD?=
 =?us-ascii?Q?/aEwPOS/uuIxNEnA+yy+F2y6NiTL7q6efONyfXUY7N5yxsKYEEEABJNTO3SW?=
 =?us-ascii?Q?rTfCTURuWgfx9ytDUJ7pcVsZ0xe//b66M/3nk6s3UyuoY4DCzxyEOoHhakMR?=
 =?us-ascii?Q?98F2yCMNdbZEk3MmXI+gBvNE1cq7sPwws/zJDEGchIU5Hb5hgZAtUKPw29VF?=
 =?us-ascii?Q?3Xogy7yVFyt8CRluF+ovCnPqbsuJUNpL7VB1M0VZ/2/w0Yl8w3byaNCi3ztc?=
 =?us-ascii?Q?brEMoqspTgZ06gNduCbAv0hSQUclRcDEOcWSvNkaeWdunFTlky67hWW/pAPD?=
 =?us-ascii?Q?2P4pnNzS/pjtjDFPO9Q1DBDOpf0cEQtnmLHpHIVnWgsJrvxDukn7FhsndMXj?=
 =?us-ascii?Q?/sFPMW/4wuZKjyDt/9nBkYIJeC1ltdKtiiN+ogPcq/Dwqn7FNFNC5jb6EIBW?=
 =?us-ascii?Q?lioPEmOIK/SlBaoHf72fgzGDJb/PT6B4RFSAijCw7fdKH9xle+U9fYUXkVuz?=
 =?us-ascii?Q?d1zXrM8DyYxhycO5ty85pqMzZwmR3T+7wj0kIAcMIuwu4LIuK0p9n4T8CsFI?=
 =?us-ascii?Q?aNJsV/4YEltn8690mgu5lB9EhrjDchl4fkxLvMhlgynt90HmGKlJ29CgX1Y0?=
 =?us-ascii?Q?PnVHtdb1yrEFD1WjDmSlxTvZG+6Cm/9YqvcU4HNwfwxGQa6roQt3GhFQsgjN?=
 =?us-ascii?Q?z46koy49AIQHfXrRXEflt1PNt9rmP5EIdlDJRHJ+w7dbGdzHy66RKMBLpmw2?=
 =?us-ascii?Q?zmPwvjhtV6PSjUbtO3la5udrusUP5VyMHgQ9e7uaN1jqG9jD3yVMJ3for+Dw?=
 =?us-ascii?Q?ktooQRigWWbYxd3NBBYNjRwH96ZrI5wzRlk5Oal3jgawmrqrhrYYxdf8qMRU?=
 =?us-ascii?Q?hqmpRI39TM4sO5UL/ZjZox5hggP6hJzwwXZKZntGuGgV+eBavmzbr/ZfpWC/?=
 =?us-ascii?Q?L+4j8lSLVLlqTZ3XZ8jz+rz7xpshauHRiK55PfZeNglUQBb5YrEnG90yrvgD?=
 =?us-ascii?Q?JUr9Ab4S6bU8UcgHVrhLiNMyv9+oty0gKMDiCELbHniiwWwwQDZ5cU8ZDf2c?=
 =?us-ascii?Q?/vjN/WKmk3Zdv27606Q8J3eXtPxst9dV8l5pI4dsU9Wd4ihr9J02M8QooMle?=
 =?us-ascii?Q?2S9W6arW7S1AYV2fn2lfTkhdoEp3a7LKYQi7klKsw0E4L9UFKhxy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9abbf2-02c2-4957-6a91-08def3e83e25
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:26:33.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp0JNv5PMSZk19g1sGOvejC3E2V9zt+CJvUDjLrOnBkAiTDUfaRDdaauxcGfykEHuBUduhYB9BZQJVvpKJXd2VLNnuA6fpHqQeg+MZw5W76nbGzHRr0UNy/F13wz9QeA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344

On Thu, Aug 06, 2026 at 04:18:45PM +0300, Adrian Hunter wrote:
> i3c_device_get_supported_xfer_mode() uses dev->desc to obtain the
> master controller.  However, dev->desc must not be dereferenced unless
> bus->lock is held, and this function does not take that lock.
>
> The function only needs access to the master controller associated with
> the device's bus.  Use dev->bus instead, which is always valid for the
> lifetime of the device and does not require dereferencing dev->desc.
>
> Fixes: 256a21743d91 ("i3c: Add HDR API support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>
> Changes in V4:
>
> 	None
>
> Changes in V3:
>
> 	New patch
>
>
>  drivers/i3c/device.c    | 2 +-
>  drivers/i3c/internals.h | 5 +++++
>  drivers/i3c/master.c    | 6 ------
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 101eaa77de68..a3778282e84c 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(i3c_device_match_id);
>   */
>  u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
>  {
> -	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
> +	return i3c_bus_to_i3c_master(dev->bus)->this->info.hdr_cap | BIT(I3C_SDR);
>  }
>  EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
>
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0f1f3f766623..86a36b951e0d 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -72,4 +72,9 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
>  	}
>  }
>
> +static inline struct i3c_master_controller *i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
> +{
> +	return container_of(i3cbus, struct i3c_master_controller, bus);
> +}
> +
>  #endif /* I3C_INTERNAL_H */
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d2fb1a110521..c7bb52b71d88 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -102,12 +102,6 @@ void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
>  	up_read(&bus->lock);
>  }
>
> -static struct i3c_master_controller *
> -i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
> -{
> -	return container_of(i3cbus, struct i3c_master_controller, bus);
> -}
> -
>  static struct i3c_master_controller *dev_to_i3cmaster(struct device *dev)
>  {
>  	return container_of(dev, struct i3c_master_controller, dev);
> --
> 2.53.0
>
