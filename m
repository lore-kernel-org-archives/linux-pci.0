Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021125.outbound.protection.outlook.com [40.107.74.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375711B808;
	Thu,  3 Sep 2026 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422187; cv=fail; b=IDJkY7IlFNDaAOtSLP/cK1OCDrQ7F6pW5zHX6Mv9HD2vR6uDqZoVi2Lug6vuVvmN0crY0qtydZzw2FnQTj5SFzxu8/JF6s5rJf5pyuepiJKe5Q24k8GEzDRCTKESVcMnQPSkp+KYcverdyNrSLh8IKkDIRA4TEAyDaSSct15nB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422187; c=relaxed/simple;
	bh=bEB/QS5lg+o9gnrBxTV4ratz+iXH916n9SJSfLDxt1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yr30DyjQcvrnenwrW12X02z54GlZ51/xwfMHJXOuOMO64H9Vf8WcncpcJpN5gcfkHmLROHD38qohYpzivDRm2o1HoLkh2xLXFAKEsyGwp6EqR1bJB4M/WrHdX9pXmcZRUMPlGLU9CPrQgL6UAvtMszLni9+thwoBWn9aOHLU95g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P4IObDVP; arc=fail smtp.client-ip=40.107.74.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="P4IObDVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwsFK0Oc6y/8Algcz/W1PCBvBRDz+BZq7b4SkM8ivUwPuAb3RHCrk/V4nNttpBM3H7GJ95+ANHLKH5nKct3B59kRxaCK1hJCptR8W2lhXhQ8EBC6brIqFS0+VAgo7K8l7EfByNdZkpYkBfTw5SvmAHWiHbZxhtliyR41pEVbV6MebcQ/VmHGKxKS0E0sqHoJHMnjQE58II3YXUkFNvrrhdkQ2gbv5H5mwoP63Wg1AHrzUl4WFr7zhXNeyu+gpIl2DSjNksy9nkgwZlgGztPP/fQGDeBlHa7R8Ynfz0qDOPAoUE1+vW+jJuuZOO08YLsCAcH6AHQZKq/yOZM+njjmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxP0GxFFLsg1tFuYbZ1cc/lchMAQboP8ZrAqbn0ycns=;
 b=Hs4cOiK7Um3vAuILBZ2ISgPxBdt4N4K2qWhrUFL03/YYm2/SwJBaIbbk+bcJ6FSgcG3iZ8hZskcbXFLewRK2g8YVktXuEZ7lqlf2GpJKH1POn4q0IrAiYmcEUiFDSkaatUva6H6ZA9nEpIdFvIApc1A6s2NlChafDhY+pYeZGxYGgXr3du4KnN+MDZE5ArVuuYE1yhL/G1laPFnGtOMN7bVA12a7oaYqkCTcAXzPMO2ju9/JoH2HgQUAkIdVUuLFtTLDiBHlAdgJtF1fexM8+MYOi+6gznvlbQ14RIAGCurtEDUsxnKz3XwXoufpLFKKjeTYPfoObHZwjLDofIG19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxP0GxFFLsg1tFuYbZ1cc/lchMAQboP8ZrAqbn0ycns=;
 b=P4IObDVPxp7PjmyMvddH3dZo2rQiL5iDNaYvv7O7mc4ROEKUQzRBnHoXElsVkuP/DYR6Tk8EvqHkLUNQEjl0IifDw20C9tS3Nw82n7zHY/BzpCVti516lB7dmG1q/FEYR+pMojH3Sg1bLenUWHHjNB9ypEUHBNOv/5cdc3QTMGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1558.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:56:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:56:20 +0000
Date: Thu, 3 Sep 2026 16:56:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <zxyr55h6s3tjc6pe23wzwb77dxppsljxcagpqhp4u24cqka2ne@fesick6sneto>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
 <apXdm2I33edo8kpZ@ryzen>
 <sor2mm4jzgeprhn3fjw4jmcaowwkhhuus6exi4k5kum6frqvug@gatkk7r4qyxd>
 <apfPWc09CY2o-P5s@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apfPWc09CY2o-P5s@ryzen>
X-ClientProxiedBy: TY6P301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1558:EE_
X-MS-Office365-Filtering-Correlation-Id: 68814a73-b372-425d-7213-08df0990d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099006|6133799003|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	0cov+rzSyN84mphtQlxowkgkOC7PjrDYv0jqLGZAl4PLlq3MCKzQC011EVoMAZhh6qxlUk6+agSAsSbmh8zBMYvzTJYEQPznI107/CRA0vdG4a0gFtBzbiBgPc+Ak2PAsVBvS4F3I6HRcTmlyF4ClAwxQfyJVg0sZ1vNGKDH9AO/tLkGXf/0WA9Ia39ArXLMaGYOetqeevWpGn08SYNS1jtaMwodteCQ32DMikD+zL2Ftor0n30XslF7inRxloxQRk9TdhhgcDF8eh9fJ14fBYbjE6WJezfrPZHAavjUzzvsaAeIEoBbjYY7zI27xGqkc7CPP71M/LYoDpEnBeuog1h7RAtrFluyLJ+/dEusOfj/H96tpRosECkvrQqSU4yD/SnPdatv06kLIhSetCcvi5N5fXEWIaJqfLDOu6f7gA2V+MpLxZcp860FmmAL8aqaoazLeFLaefroWGRPnlyzT86OtHbm2f/wpbuSfNV60d/owWKjOG0xKL7CzHAkCT/zO4rdpofc51S+74dvuNbo3AMTxCPMVp6cSSOwRuU4K/ndRcXRCznf0L8BkZH9qVyTnHpEzR59S+83JJ4eCA4oVlUROJjjGeVmNaKfeO5ODeDP68W6AEk2yH4L/hLBXRX++sKmV5Mne0JATuVhKS0TyiRwR3cj2/gjpF8J8/VRMaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArB+pe3Q5yGj20blE7ndaar0jL4GP1QcmKeARhV7UGq9oOpgxGnLm7xvhFig?=
 =?us-ascii?Q?Am8nfJIn+AgUlAjcfvJbdNl5NFgaaYTgYiWjkrbcSfbOYjePYiWHR4AH4yDj?=
 =?us-ascii?Q?+k1eC758VwUvdfaDQTeuNSt3v3roj4dAyHL/XWt0jdiFFZn+eCVcEcKAAMnU?=
 =?us-ascii?Q?qEgZNMoRsqU64oBu7CnT/Hgno+s/JdF+U+lf6zOFd4vdiov0ZiHYebBYFYII?=
 =?us-ascii?Q?8OqSbK4jI7eqgG6D2m0TWVQ643uJPa9EyGBc0BJ0b0Qws60JpbeU2ZsQ665H?=
 =?us-ascii?Q?xB8oAhXmxSnmMS0lbCqsiqioLR7amclCDI/c096pZk0sLO0ZOtjL+b1r9V9A?=
 =?us-ascii?Q?v7NEKTk/53kbEEDklzlo6tv4MYCdEpZFh873AorWzKLIIy1JmayidG3A/iW4?=
 =?us-ascii?Q?+1dobOUziDGviTQoekJqgfd3A+A/fZxunrM4ZEnQCPcz3SKn0X9siJWzYAo4?=
 =?us-ascii?Q?y71SVzgua/bJ8oeWsnG0up0GOx6kVdl7OaTAwOSH+nJFQc90hm6Xdp8+H8vV?=
 =?us-ascii?Q?WuJD37waaERmQwM0uXHw1F7R8Wqxv62K/fIP+25Wt6Z/zu++02D4A+rEAr1j?=
 =?us-ascii?Q?UKwKFgAjVzmKq9wnkICAxtbfdNuUI7rA3cN55y2/UnbPRWfQ35+waDo95VUP?=
 =?us-ascii?Q?N0hgdurrP7AHvAJRwvXfo66qer7R+8X5WIM8lrTEak2DXGMcIaYbIxZKTIgV?=
 =?us-ascii?Q?OVoDsnmkiP9uO0yVLv/wFBqDmqB9E5d+Bhul6zerjTqEHL8FUWrpuYOU8E+9?=
 =?us-ascii?Q?n4Q0qJIB4O9vKDBneE+8KXavIqBQLAGbL7Lcc1JJJDj0ZMqCcK5ebGXmG/th?=
 =?us-ascii?Q?DFad25XRZ0CM1aQbMn1g1Q9Crfjk5T45KNsDhOCQP+bfVXAfmfRpRTnFKNCI?=
 =?us-ascii?Q?Mh6ls6S7jTzNPMjDRr8DIEYy4yC8F/p/YZJAv4H5FFkyFvhXobh60Oi+S05r?=
 =?us-ascii?Q?fzt7sAzXkwC3BasvCGDM3PCKmJQ6PlKVF0wUO+v/mdgXayDa9IcFCJ0K0XAK?=
 =?us-ascii?Q?peajBXti3diSoLqzbwyrG57V4qf6AlmgcbEVzNA282Sh6j2+2IKW4ixu7m8M?=
 =?us-ascii?Q?GRcbqi7dC7eArEkJS4gJGKGA/8iPguevz5z9HD7Ysii7aAK7x5l18LcinSm5?=
 =?us-ascii?Q?wKYI3gTb2IK1el8ySGaUt7bskUkbutN33/kT3eMR6wE4sLrwUJsbMPBDx7tR?=
 =?us-ascii?Q?CrU72NhUptqJPZIrAL4X3Q4rEDp0Oz5r0C0xbI6OBK+fROnFIu5hgv4iZj42?=
 =?us-ascii?Q?3GaOLgTrEUEViAx2qVb/SdhbBtIlmk+EYZKFbXX2w0HRTHPLZAmDZBgT4jys?=
 =?us-ascii?Q?4uRoc2XtT0ku7QX8FueFE3DV4BrWRqY6bcslqT/rJUNZxjWAH/PoKUpYHYge?=
 =?us-ascii?Q?9w4BsJEXGL7EeP5LL3mPagDtczs9A6Um2XKQJJeq1kG8UBsTRTZXpdi9o0C+?=
 =?us-ascii?Q?GBpgfgaNEfxraPd4q92LNifUpX4k1SC8qkMlbI54KORckyLmFGz+6xqmcC1J?=
 =?us-ascii?Q?vVYCdua3dBWIPiFRVCicr4Lq690ur4jW+c4Eg/ENbHNBRtcqlFYXkeT1xfG6?=
 =?us-ascii?Q?uPrmsFLN0U8gdC9OzQ3kyquJ28ejGufqwstBeqgRTHFNO4OlxvBH/vHF8f+p?=
 =?us-ascii?Q?PV988l2piEq4nYmzguqFdJZmXepHYfOlzINwaPyIsARMwQuI7Uagph5nsrBz?=
 =?us-ascii?Q?zkmJR+KVl8FWs/E+iRWmycc6cjrJ8Gu9VW4DieceZzTVueN57KjSoK2ryP4e?=
 =?us-ascii?Q?68FpxnJr5hXgEgxwceDTKZJV7a5C76i7Mwm0TpXTJv8hmsGUwGIA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68814a73-b372-425d-7213-08df0990d743
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:56:20.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //85/2r8oa5RUcTUKv/VXBPTGPYfl5GxYWgCZrJnR6nlFSPqD19M9s2QeNotoR32auplRo3gLuOYFFbd6PF87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1558

On Wed, Sep 02, 2026 at 09:25:13AM +0200, Niklas Cassel wrote:
> On Wed, Sep 02, 2026 at 11:14:00AM +0900, Koichiro Den wrote:
> > 
> > This still sounds really odd, and it does not obviously explain why both DWORDs
> > at 0x4000 and 0x4004 are affected. I may be missing something important. If
> > anything similar involving iMSIX-TX Table RAM entry #0 has been discussed
> > before, please point me to the relevant thread.
> > 
> > (Also, I can share my current WIP v3 series, which makes pci-epf-test and
> > nvmet-pci-epf use the hardware-owned layout when available, while leaving
> > pci-epf-ntb with its EPF-owned layout. If you have any setup where you could
> > test it, please let me know.)
> 
> Some time ago, I did verify that I could raise an IRQ using
> dw_pcie_ep_raise_msix_irq_doorbell(). If I remember correctly, I did so using
> pci-epf-test and not nvmet-pci-epf.
> 
> Did pci-epf-test work? (From what you explain, it seems to be related to if
> MSI-X Table entry #0 is used or not.)
> 
> Please share your branch. I should have time to do a quick test.
> 
> 
> > 
> > > 
> > > 
> > > What I suggest that you instead do something like:
> > > Patch 1/7: pci-epf-vntb: Fix to actually use MSI-X when requested.
> > >            This probably includes adding the code that is inside the
> > > 	   if (ret == -ENOENT) { }.
> > > Patch 2/7: PCI: endpoint: Support hardware-owned MSI-X table and PBA
> > > Patch 3/7: PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
> > > Patch 4/7: pci-epf-vntb: Add code that calls pci_epc_get_hw_msix_layout()
> > >            and uses that layout, if the function returned success.
> > > Patch 5/7: pci-epf-test: Add code that calls pci_epc_get_hw_msix_layout()
> > >            and uses that layout, if the function returned success.
> > > Patch 6/7: nvmet-pci-epf: Add code that calls pci_epc_get_hw_msix_layout()
> > >            and uses that layout, if the function returned success.
> > > Patch 7/7: pci-epf-ntb: Add comment that explains why it cannot call
> > >            pci_epc_get_hw_msix_layout() like all other EPF drivers that
> > > 	   support MSI-X.
> > > 
> > > 
> > > This way, patch 1/7 can be backported, and will help all users vNTB users,
> > > even the users that do not use RK3588 as an EPC.
> > 
> > That split makes sense. However, given the issue I described above, perhaps I
> > should send patch 1/7 as a standalone fix and hold off on the rest until the
> > issue is understood and resolved.
> 
> Agreed, a standalone 1/7 patch could be picked up without the need to wait for
> any other changes.
> 
> 
> > 
> > Testing vNTB alone (ie. this v2 way) did not expose it because its first data
> > doorbell uses MSI-X Table entry #2. I only found the issue because your
> > suggestion led me to convert and test nvmet-pci-epf, thank you!
> 
> I'm sorry that we have a problem.
> At least it is better to discover it now, rather than discovering it after
> the patches had been merged.

Hello Niklas,

Thanks. Better safe than sorry.

For context, this series is not directly part of the NTB transport direct TX/RX
work I'm working on. Now that we've chosen vNTB-DMA instead of PCI DMA EPF, as
you know, its test coverage can naturally extend beyond my main target, R-Car
S4, to other platforms. Which includes RK3588, that I am sure you know really
well and which I can test on my Rock 5B. That is what led me to look at the
RK3588 MSI-X path now. In short, even if v3 path 1 or patch 2-7 take time to
land, that will not block the direct TX/RX work.

Please save the text between the markers as an mbox and apply it with git am.

------------8<----(from here)------8<-------------

From 26455413434d6cce0aae6562364d971271be729c Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 16:02:45 +0900
Subject: [WIP PATCH v3 1/7] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed with an IOMMU
enabled on the RC.

Configure MSI-X when supported and use the selected type for peer
doorbells. Allocate the MSI-X Table and PBA in the config BAR and
configure db_count entries to cover the link event, the reserved slot,
and the doorbell slots.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Split the vNTB MSI-X fix from hardware-owned layout support. (Niklas)

@Frank, I did not carry over your R-b tag due to the change. Would
appreciate another look when you have cycles. Thank you in advance.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 55 +++++++++++++------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c3caec927d74..fe44ca35462c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -148,6 +148,7 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+	bool peer_msix;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -155,6 +156,7 @@ struct epf_ntb {
 	 */
 	bool msi_doorbell;
 	u32 spad_size;
+	u32 msix_table_offset;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -303,6 +305,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	switch (command) {
 	case COMMAND_CONFIGURE_DOORBELL:
+		WRITE_ONCE(ntb->peer_msix, argument & MSIX_ENABLE);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
 	case COMMAND_TEARDOWN_DOORBELL:
@@ -439,9 +442,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions described in the above diagram.
+ * If the EPC supports MSI-X, allocate space for its Table and PBA between the
+ * control and scratchpad regions.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -462,6 +465,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	spad_count = ntb->spad_count;
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	if (epc_features->msix_capable) {
+		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
+		ctrl_size = ntb->msix_table_offset +
+			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
+			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
+	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -502,12 +511,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
+	struct pci_epf *epf = ntb->epf;
 	struct device *dev;
 	int ret;
 
-	dev = &ntb->epf->dev;
+	dev = &epf->dev;
 
-	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no,
+					    epf->vfunc_no);
 
 	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
 		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
@@ -521,16 +532,24 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	}
 
 	if (epc_features->msi_capable) {
-		ret = pci_epc_set_msi(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      16);
+		ret = pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);
 		if (ret) {
 			dev_err(dev, "MSI configuration failed\n");
 			return ret;
 		}
 	}
 
+	if (epc_features->msix_capable) {
+		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
+				       ntb->db_count,
+				       ntb->epf_ntb_bar[BAR_CONFIG],
+				       ntb->msix_table_offset);
+		if (ret) {
+			dev_err(dev, "MSI-X configuration failed\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1512,6 +1531,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
 	struct pci_epf *epf = ntb->epf;
 	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
+	unsigned int irq_type;
 	u8 func_no, vfunc_no;
 	unsigned int db_bit;
 	u32 interrupt_num;
@@ -1523,6 +1543,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 	func_no = epf->func_no;
 	vfunc_no = epf->vfunc_no;
+	irq_type = READ_ONCE(ntb->peer_msix) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
 
 	/*
 	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
@@ -1536,16 +1557,16 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 
 		while (db_bits) {
 			/*
-			 * pci_epc_raise_irq() for MSI expects a 1-based
-			 * interrupt number. The first usable doorbell starts
-			 * at EPF_IRQ_DB_START in the legacy slot layout.
+			 * pci_epc_raise_irq() expects a 1-based interrupt
+			 * number for MSI and MSI-X. The first usable doorbell
+			 * starts at EPF_IRQ_DB_START in the legacy slot layout.
 			 *
 			 * Legacy mapping (kept for compatibility):
 			 *
-			 *   MSI #1 : link event (reserved)
-			 *   MSI #2 : unused (historical offset)
-			 *   MSI #3 : doorbell bit 0 (DB#0)
-			 *   MSI #4 : doorbell bit 1 (DB#1)
+			 *   IRQ #1 : link event (reserved)
+			 *   IRQ #2 : unused (historical offset)
+			 *   IRQ #3 : doorbell bit 0 (DB#0)
+			 *   IRQ #4 : doorbell bit 1 (DB#1)
 			 *   ...
 			 *
 			 * Do not change this mapping to avoid breaking
@@ -1556,7 +1577,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-						PCI_IRQ_MSI, interrupt_num);
+						irq_type, interrupt_num);
 			if (ret)
 				dev_err(&ntb->ntb.dev,
 					"Failed to raise IRQ for interrupt_num %u: %d\n",
-- 
2.51.0


From 03561be00c5ba5df597c4ae86ba659c8b00d8f78 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 27 Aug 2026 18:12:02 +0900
Subject: [WIP PATCH v3 2/7] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA

Some endpoint controllers expose the MSI-X table and Pending Bit Array
(PBA) in fixed, hardware-owned BAR regions. The EPC set_msix() callback
currently receives only the table BAR and offset and assumes that the PBA
immediately follows the table in the same BAR. It cannot describe a fixed
layout whose table and PBA have independent locations.

Add struct pci_epc_msix_layout and pass the full layout to
pci_epc_set_msix(). Leave layout selection to EPF implementations. For
instance, pci-epf-ntb reads the MSI-X Table from its own BAR. Using a
fixed layout there would require a way to read hardware-owned Table
entries. Add pci_epc_get_hw_msix_layout() for EPFs that want the fixed
layout. Update the existing callers and validate the supplied layout.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Convert the new pci-epf-vntb MSI-X caller to the layout API. (Niklas)
---
 drivers/nvme/target/pci-epf.c                 |  16 ++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   9 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   7 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  30 +++---
 drivers/pci/endpoint/functions/pci-epf-test.c |  17 +--
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  22 ++--
 drivers/pci/endpoint/pci-epc-core.c           | 102 +++++++++++++++++-
 include/linux/pci-epc.h                       |  25 ++++-
 8 files changed, 182 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 9c28367435a5..39f2f3066deb 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -201,7 +201,7 @@ struct nvmet_pci_epf {
 	const struct pci_epc_features	*epc_features;
 
 	void				*reg_bar;
-	size_t				msix_table_offset;
+	struct pci_epc_msix_layout	msix_layout;
 
 	unsigned int			irq_type;
 	unsigned int			nr_vectors;
@@ -2168,8 +2168,14 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 		size_t pba_size;
 
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		nvme_epf->msix_table_offset = reg_size;
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		nvme_epf->msix_layout.table_bar = BAR_0;
+		nvme_epf->msix_layout.table_offset = reg_size;
+		nvme_epf->msix_layout.table_size = msix_table_size;
+		nvme_epf->msix_layout.pba_bar = BAR_0;
+		nvme_epf->msix_layout.pba_offset = reg_size + msix_table_size;
+		nvme_epf->msix_layout.pba_size = pba_size;
 
 		reg_size += msix_table_size + pba_size;
 	}
@@ -2226,8 +2232,8 @@ static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
 	/* Enable MSI-X if supported, otherwise, use MSI. */
 	if (epc_features->msix_capable && epf->msix_interrupts) {
 		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
-				       epf->msix_interrupts, BAR_0,
-				       nvme_epf->msix_table_offset);
+				       epf->msix_interrupts,
+				       &nvme_epf->msix_layout);
 		if (ret) {
 			dev_err(&epf->dev, "Failed to configure MSI-X\n");
 			return ret;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 370b19f4d38f..3e7c6d0acb3b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -293,7 +293,8 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
-				 u16 nr_irqs, enum pci_barno bir, u32 offset)
+				 u16 nr_irqs,
+				 const struct pci_epc_msix_layout *layout)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
@@ -311,12 +312,12 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set MSI-X BAR and offset */
 	reg = cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
-	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
+	/* Set PBA BAR and offset */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index de8ee3db4360..5f4c4cf1ffb9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -737,7 +737,8 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			       u16 nr_irqs, enum pci_barno bir, u32 offset)
+			       u16 nr_irqs,
+			       const struct pci_epc_msix_layout *layout)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -757,11 +758,11 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
-	val = offset | bir;
+	val = layout->table_offset | layout->table_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = layout->pba_offset | layout->pba_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca2188a..f3e0e1b3ffb9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -90,12 +90,11 @@ struct epf_ntb_epc {
 	u8 vfunc_no;
 	bool linkup;
 	bool is_msix;
-	int msix_bar;
 	u32 spad_size;
 	struct pci_epc *epc;
 	struct epf_ntb *epf_ntb;
 	void __iomem *mw_addr[6];
-	size_t msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct epf_ntb_ctrl *reg;
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno epf_ntb_bar[6];
@@ -475,9 +474,9 @@ static int epf_ntb_configure_msi(struct epf_ntb *ntb,
  *
  * The MSI-X address is in the MSI-X table of EP CONTROLLER 2 and
  * the count of doorbell is in ctrl->argument of epf_ntb_epc that is connected
- * to HOST2. MSI-X table is stored memory mapped to ntb_epc->msix_bar and the
- * offset is in ntb_epc->msix_table_offset. From this epf_ntb_configure_msix()
- * gets the MSI-X address and data.
+ * to HOST2. The location of the memory-mapped MSI-X table is described by
+ * ntb_epc->msix_layout. From this epf_ntb_configure_msix() gets the MSI-X
+ * address and data.
  *
  * epf_ntb_configure_msix() also stores the MSI-X data to raise each interrupt
  * in db_data of the peer's control region. This helps the peer to raise
@@ -505,8 +504,8 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
-	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_bar];
-	msix_tbl = epf_bar->addr + ntb_epc->msix_table_offset;
+	epf_bar = &ntb_epc->epf_bar[ntb_epc->msix_layout.table_bar];
+	msix_tbl = epf_bar->addr + ntb_epc->msix_layout.table_offset;
 
 	peer_ntb_epc = ntb->epc[!type];
 	peer_barno = peer_ntb_epc->epf_ntb_bar[BAR_DB_MW1];
@@ -1036,10 +1035,14 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	if (msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * ntb->db_count;
 		ctrl_size = ALIGN(ctrl_size, 8);
-		ntb_epc->msix_table_offset = ctrl_size;
-		ntb_epc->msix_bar = barno;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(ntb->db_count, 8), 8);
+		pba_size = BITS_TO_U64(ntb->db_count) * sizeof(u64);
+
+		ntb_epc->msix_layout.table_bar = barno;
+		ntb_epc->msix_layout.table_offset = ctrl_size;
+		ntb_epc->msix_layout.table_size = msix_table_size;
+		ntb_epc->msix_layout.pba_bar = barno;
+		ntb_epc->msix_layout.pba_offset = ctrl_size + msix_table_size;
+		ntb_epc->msix_layout.pba_size = pba_size;
 		ctrl_size = ctrl_size + msix_table_size + pba_size;
 	}
 
@@ -1317,10 +1320,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 
 	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, func_no, vfunc_no, ntb->db_count,
-				       ntb_epc->msix_bar,
-				       ntb_epc->msix_table_offset);
+				       &ntb_epc->msix_layout);
 		if (ret) {
-			dev_err(dev, "MSI configuration failed\n");
+			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
 		}
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c0..360df7775110 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -82,7 +82,7 @@ struct pci_epf_test {
 	struct pci_epf		*epf;
 	struct config_group	group;
 	enum pci_barno		test_reg_bar;
-	size_t			msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
@@ -1217,8 +1217,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	if (epc_features->msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
 				       epf->msix_interrupts,
-				       epf_test->test_reg_bar,
-				       epf_test->msix_table_offset);
+				       &epf_test->msix_layout);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
@@ -1284,9 +1283,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 
 	if (epc_features->msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		epf_test->msix_table_offset = test_reg_bar_size;
-		/* Align to QWORD or 8 Bytes */
-		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
+		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+
+		epf_test->msix_layout.table_bar = test_reg_bar;
+		epf_test->msix_layout.table_offset = test_reg_bar_size;
+		epf_test->msix_layout.table_size = msix_table_size;
+		epf_test->msix_layout.pba_bar = test_reg_bar;
+		epf_test->msix_layout.pba_offset = test_reg_bar_size +
+						   msix_table_size;
+		epf_test->msix_layout.pba_size = pba_size;
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index fe44ca35462c..e019d6e1ba69 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -156,7 +156,7 @@ struct epf_ntb {
 	 */
 	bool msi_doorbell;
 	u32 spad_size;
-	u32 msix_table_offset;
+	struct pci_epc_msix_layout msix_layout;
 
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
@@ -466,10 +466,18 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	if (epc_features->msix_capable) {
-		ntb->msix_table_offset = ALIGN(ctrl_size, 8);
-		ctrl_size = ntb->msix_table_offset +
-			    ntb->db_count * PCI_MSIX_ENTRY_SIZE +
-			    BITS_TO_U64(ntb->db_count) * sizeof(u64);
+		ntb->msix_layout.table_bar = barno;
+		ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
+		ntb->msix_layout.table_size =
+			ntb->db_count * PCI_MSIX_ENTRY_SIZE;
+		ntb->msix_layout.pba_bar = barno;
+		ntb->msix_layout.pba_offset =
+			ntb->msix_layout.table_offset +
+			ntb->msix_layout.table_size;
+		ntb->msix_layout.pba_size =
+			BITS_TO_U64(ntb->db_count) * sizeof(u64);
+		ctrl_size = ntb->msix_layout.pba_offset +
+			    ntb->msix_layout.pba_size;
 	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
@@ -541,9 +549,7 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 
 	if (epc_features->msix_capable) {
 		ret = pci_epc_set_msix(epf->epc, epf->func_no, epf->vfunc_no,
-				       ntb->db_count,
-				       ntb->epf_ntb_bar[BAR_CONFIG],
-				       ntb->msix_table_offset);
+				       ntb->db_count, &ntb->msix_layout);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
 			return ret;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..4a0ceb62f38f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -113,6 +114,84 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
+static int pci_epc_get_msix_region(const struct pci_epc_features *epc_features,
+				   enum pci_epc_bar_rsvd_region_type type,
+				   enum pci_barno *bar, u32 *offset,
+				   resource_size_t *size)
+{
+	const struct pci_epc_bar_rsvd_region *region;
+	const struct pci_epc_bar_desc *bar_desc;
+	bool found = false;
+	int i, j;
+
+	if (!epc_features)
+		return -ENOENT;
+
+	for (i = BAR_0; i < PCI_STD_NUM_BARS; i++) {
+		bar_desc = &epc_features->bar[i];
+		if (bar_desc->nr_rsvd_regions && !bar_desc->rsvd_regions)
+			return -EINVAL;
+
+		for (j = 0; j < bar_desc->nr_rsvd_regions; j++) {
+			region = &bar_desc->rsvd_regions[j];
+			if (region->type != type)
+				continue;
+
+			if (found || bar_desc->type != BAR_RESERVED || !region->size ||
+			    region->offset > PCI_MSIX_TABLE_OFFSET ||
+			    !IS_ALIGNED(region->offset, 8))
+				return -EINVAL;
+
+			found = true;
+			*bar = i;
+			*offset = region->offset;
+			*size = region->size;
+		}
+	}
+
+	return found ? 0 : -ENOENT;
+}
+
+/**
+ * pci_epc_get_hw_msix_layout() - get a hardware-owned MSI-X table and PBA layout
+ * @epc_features: features provided by an EPC for an endpoint function
+ * @layout: layout to populate
+ *
+ * Return: 0 if the EPC describes both hardware-owned MSI-X regions, -ENOENT if
+ * neither region is described, or an error if the description is invalid.
+ */
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout)
+{
+	struct pci_epc_msix_layout hw_layout;
+	int table_ret, pba_ret;
+
+	if (!layout)
+		return -EINVAL;
+
+	table_ret = pci_epc_get_msix_region(epc_features,
+					    PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+					    &hw_layout.table_bar,
+					    &hw_layout.table_offset,
+					    &hw_layout.table_size);
+	pba_ret = pci_epc_get_msix_region(epc_features,
+					  PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+					  &hw_layout.pba_bar,
+					  &hw_layout.pba_offset,
+					  &hw_layout.pba_size);
+
+	if (table_ret == -ENOENT && pba_ret == -ENOENT)
+		return -ENOENT;
+
+	if (table_ret || pba_ret)
+		return -EINVAL;
+
+	*layout = hw_layout;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_hw_msix_layout);
+
 static bool pci_epc_function_is_valid(struct pci_epc *epc,
 				      u8 func_no, u8 vfunc_no)
 {
@@ -443,14 +522,14 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
  * @nr_irqs: number of MSI-X interrupts required by the EPF
- * @bir: BAR where the MSI-X table resides
- * @offset: Offset pointing to the start of MSI-X table
+ * @layout: MSI-X table and PBA layout selected by the EPF
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno bir, u32 offset)
+		     const struct pci_epc_msix_layout *layout)
 {
+	size_t table_size, pba_size;
 	int ret;
 
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
@@ -459,11 +538,26 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
 	if (nr_irqs < 1 || nr_irqs > 2048)
 		return -EINVAL;
 
+	if (!layout || layout->table_bar < BAR_0 ||
+	    layout->table_bar >= PCI_STD_NUM_BARS ||
+	    layout->pba_bar < BAR_0 || layout->pba_bar >= PCI_STD_NUM_BARS ||
+	    !IS_ALIGNED(layout->table_offset, 8) ||
+	    !IS_ALIGNED(layout->pba_offset, 8) ||
+	    layout->table_offset > PCI_MSIX_TABLE_OFFSET ||
+	    layout->pba_offset > PCI_MSIX_PBA_OFFSET)
+		return -EINVAL;
+
+	table_size = nr_irqs * PCI_MSIX_ENTRY_SIZE;
+	pba_size = BITS_TO_U64(nr_irqs) * sizeof(u64);
+
+	if (layout->table_size < table_size || layout->pba_size < pba_size)
+		return -ENOSPC;
+
 	if (!epc->ops->set_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, bir, offset);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, layout);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..3d28231f092a 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -102,6 +102,24 @@ struct pci_epc_aux_resource {
 	} u;
 };
 
+/**
+ * struct pci_epc_msix_layout - layout of an MSI-X table and PBA
+ * @table_bar: BAR containing the MSI-X table
+ * @table_offset: offset of the MSI-X table within @table_bar
+ * @table_size: size of the MSI-X table region
+ * @pba_bar: BAR containing the MSI-X Pending Bit Array (PBA)
+ * @pba_offset: offset of the MSI-X PBA within @pba_bar
+ * @pba_size: size of the MSI-X PBA region
+ */
+struct pci_epc_msix_layout {
+	enum pci_barno		table_bar;
+	u32			table_offset;
+	resource_size_t		table_size;
+	enum pci_barno		pba_bar;
+	u32			pba_offset;
+	resource_size_t		pba_size;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -147,7 +165,8 @@ struct pci_epc_ops {
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			    u16 nr_irqs, enum pci_barno, u32 offset);
+			    u16 nr_irqs,
+			    const struct pci_epc_msix_layout *layout);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     unsigned int type, u16 interrupt_num);
@@ -381,8 +400,10 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-		     enum pci_barno, u32 offset);
+		     const struct pci_epc_msix_layout *layout);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
+int pci_epc_get_hw_msix_layout(const struct pci_epc_features *epc_features,
+			       struct pci_epc_msix_layout *layout);
 int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
 			u32 entry_size, u32 *msi_data, u32 *msi_addr_offset);
-- 
2.51.0


From 2fe621b05e345eece00569203da88bebab14632e Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 27 Aug 2026 18:12:24 +0900
Subject: [WIP PATCH v3 3/7] PCI: dw-rockchip: Support fixed MSI-X table and
 PBA on RK3588

The RK3588 PCIe endpoint controller exposes its MSI-X table at
BAR4+0x4000 and its PBA at BAR4+0x5000. Describe both as reserved regions
so EPF drivers can select the hardware-owned layout.

The regular DesignWare MSI-X interrupt path reads an EPF-owned table
through epf_bar[]. A reserved, hardware-owned table has no such backing.
Record whether the layout selected for each function matches the
hardware-owned layout, and use the controller MSI-X doorbell on RK3588
only in that case. Continue to use the regular path for EPF-owned
layouts.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - No changes.
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 23 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 28 +++++++++++++++++--
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5f4c4cf1ffb9..afdbc62fbb17 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -736,6 +736,26 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return val + 1;
 }
 
+static bool
+dw_pcie_ep_msix_layout_is_hw_owned(struct dw_pcie_ep *ep,
+				   const struct pci_epc_msix_layout *layout)
+{
+	const struct pci_epc_features *features;
+	struct pci_epc_msix_layout hw_layout;
+
+	if (!ep->ops->get_features)
+		return false;
+
+	features = ep->ops->get_features(ep);
+	if (pci_epc_get_hw_msix_layout(features, &hw_layout))
+		return false;
+
+	return layout->table_bar == hw_layout.table_bar &&
+	       layout->table_offset == hw_layout.table_offset &&
+	       layout->pba_bar == hw_layout.pba_bar &&
+	       layout->pba_offset == hw_layout.pba_offset;
+}
+
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			       u16 nr_irqs,
 			       const struct pci_epc_msix_layout *layout)
@@ -764,6 +784,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
 	val = layout->pba_offset | layout->pba_bar;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
+	ep_func->msix_hw_owned = dw_pcie_ep_msix_layout_is_hw_owned(ep, layout);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
@@ -1112,6 +1133,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
 		return -EINVAL;
+	if (ep_func->msix_hw_owned)
+		return -EOPNOTSUPP;
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
 	tbl_offset = dw_pcie_ep_readl_dbi(ep, func_no, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae940924..d5fd29e42aa7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -495,6 +495,7 @@ struct dw_pcie_ep_func {
 	u8			func_no;
 	u8			msi_cap;	/* MSI capability offset */
 	u8			msix_cap;	/* MSI-X capability offset */
+	bool			msix_hw_owned;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index af26a07c0c9e..f674411d4d04 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -121,6 +121,7 @@ struct rockchip_pcie {
 struct rockchip_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct pci_epc_features *epc_features;
+	bool msix_doorbell;
 };
 
 static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
@@ -488,6 +489,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 				   unsigned int type, u16 interrupt_num)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	struct dw_pcie_ep_func *ep_func;
 
 	switch (type) {
 	case PCI_IRQ_INTX:
@@ -495,6 +498,12 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	case PCI_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
 	case PCI_IRQ_MSIX:
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (rockchip->data->msix_doorbell && ep_func &&
+		    ep_func->msix_hw_owned)
+			return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
+							      interrupt_num);
+
 		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
 	default:
 		dev_err(pci->dev, "UNKNOWN IRQ type\n");
@@ -524,12 +533,24 @@ static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
 		.offset = 0x0,
 		.size = 0x2000,
 	},
+	{
+		/* MSI-X Table (BAR4: MSI-X Table) */
+		.type = PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+		.offset = 0x4000,
+		.size = SZ_4K,
+	},
+	{
+		/* MSI-X PBA (BAR4: MSI-X PBA) */
+		.type = PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+		.offset = 0x5000,
+		.size = SZ_4K,
+	},
 };
 
 /*
- * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
- * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
- * so mark it as RESERVED.
+ * BAR4 on RK3588 exposes the DMA and ATU Port Logic Structures and the MSI-X
+ * table and PBA to the host regardless of iATU settings for BAR4. This means
+ * that BAR4 cannot be used by an EPF driver, so mark it as RESERVED.
  */
 static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	DWC_EPC_COMMON_FEATURES,
@@ -971,6 +992,7 @@ static const struct rockchip_pcie_of_data rockchip_pcie_ep_of_data_rk3568 = {
 static const struct rockchip_pcie_of_data rockchip_pcie_ep_of_data_rk3588 = {
 	.mode = DW_PCIE_EP_TYPE,
 	.epc_features = &rockchip_pcie_epc_features_rk3588,
+	.msix_doorbell = true,
 };
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
-- 
2.51.0


From c1ca5bf342605f38f95c9162ac449c2648e08eb1 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 16:06:56 +0900
Subject: [WIP PATCH v3 4/7] PCI: endpoint: pci-epf-vntb: Use hardware-owned
 MSI-X layout

pci-epf-vntb allocates an MSI-X Table and PBA in its config BAR when the
EPC supports MSI-X. Some endpoint controllers instead provide fixed,
hardware-owned regions for them.

Use the hardware-owned layout when it can hold the configured MSI-X
entries. Keep allocating an EPF-owned Table and PBA when no suitable
hardware-owned layout is available.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Split hardware-owned layout selection from the vNTB MSI-X fix. (Niklas)
  - Fall back to an EPF-owned layout if the fixed regions are too small.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e019d6e1ba69..53ccbbb0ba4b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -443,8 +443,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
  * Allocate the control and scratchpad regions described in the above diagram.
- * If the EPC supports MSI-X, allocate space for its Table and PBA between the
- * control and scratchpad regions.
+ * If the EPC does not provide a hardware-owned MSI-X Table and PBA, allocate
+ * space for them between the control and scratchpad regions.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -457,7 +457,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	struct device *dev = &epf->dev;
 	u32 spad_count;
 	void *base;
-	int i;
+	int i, ret;
 	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
 								epf->func_no,
 								epf->vfunc_no);
@@ -466,18 +466,31 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	if (epc_features->msix_capable) {
-		ntb->msix_layout.table_bar = barno;
-		ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
-		ntb->msix_layout.table_size =
-			ntb->db_count * PCI_MSIX_ENTRY_SIZE;
-		ntb->msix_layout.pba_bar = barno;
-		ntb->msix_layout.pba_offset =
-			ntb->msix_layout.table_offset +
-			ntb->msix_layout.table_size;
-		ntb->msix_layout.pba_size =
-			BITS_TO_U64(ntb->db_count) * sizeof(u64);
-		ctrl_size = ntb->msix_layout.pba_offset +
-			    ntb->msix_layout.pba_size;
+		ret = pci_epc_get_hw_msix_layout(epc_features,
+						 &ntb->msix_layout);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Invalid hardware-owned MSI-X layout\n");
+			return ret;
+		}
+
+		if (ret == -ENOENT ||
+		    ntb->msix_layout.table_size <
+			    ntb->db_count * PCI_MSIX_ENTRY_SIZE ||
+		    ntb->msix_layout.pba_size <
+			    BITS_TO_U64(ntb->db_count) * sizeof(u64)) {
+			ntb->msix_layout.table_bar = barno;
+			ntb->msix_layout.table_offset = ALIGN(ctrl_size, 8);
+			ntb->msix_layout.table_size =
+				ntb->db_count * PCI_MSIX_ENTRY_SIZE;
+			ntb->msix_layout.pba_bar = barno;
+			ntb->msix_layout.pba_offset =
+				ntb->msix_layout.table_offset +
+				ntb->msix_layout.table_size;
+			ntb->msix_layout.pba_size =
+				BITS_TO_U64(ntb->db_count) * sizeof(u64);
+			ctrl_size = ntb->msix_layout.pba_offset +
+				    ntb->msix_layout.pba_size;
+		}
 	}
 	spad_size = 2 * spad_count * sizeof(u32);
 
-- 
2.51.0


From 37012c2e462072056376f2e47e7835fa3a434451 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 16:07:59 +0900
Subject: [WIP PATCH v3 5/7] PCI: endpoint: pci-epf-test: Use hardware-owned
 MSI-X layout

pci-epf-test always allocates an MSI-X Table and PBA in its test register
BAR. This duplicates fixed regions provided by endpoint controllers that
own the MSI-X layout.

Use the hardware-owned layout when it can hold the configured MSI-X
entries and omit the duplicate regions from the test register BAR. Keep
the existing EPF-owned layout as the fallback.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 36 +++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 360df7775110..02505f7ca6c8 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -1278,20 +1278,36 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	enum pci_barno bar;
 	const struct pci_epc_features *epc_features = epf_test->epc_features;
 	size_t test_reg_size;
+	int ret;
 
 	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
 
 	if (epc_features->msix_capable) {
-		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
-
-		epf_test->msix_layout.table_bar = test_reg_bar;
-		epf_test->msix_layout.table_offset = test_reg_bar_size;
-		epf_test->msix_layout.table_size = msix_table_size;
-		epf_test->msix_layout.pba_bar = test_reg_bar;
-		epf_test->msix_layout.pba_offset = test_reg_bar_size +
-						   msix_table_size;
-		epf_test->msix_layout.pba_size = pba_size;
+		ret = pci_epc_get_hw_msix_layout(epc_features,
+						 &epf_test->msix_layout);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Invalid hardware-owned MSI-X layout\n");
+			return ret;
+		}
+
+		if (ret == -ENOENT ||
+		    epf_test->msix_layout.table_size <
+			    PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts ||
+		    epf_test->msix_layout.pba_size <
+			    BITS_TO_U64(epf->msix_interrupts) * sizeof(u64)) {
+			msix_table_size =
+				PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
+			pba_size = BITS_TO_U64(epf->msix_interrupts) *
+				   sizeof(u64);
+
+			epf_test->msix_layout.table_bar = test_reg_bar;
+			epf_test->msix_layout.table_offset = test_reg_bar_size;
+			epf_test->msix_layout.table_size = msix_table_size;
+			epf_test->msix_layout.pba_bar = test_reg_bar;
+			epf_test->msix_layout.pba_offset =
+				test_reg_bar_size + msix_table_size;
+			epf_test->msix_layout.pba_size = pba_size;
+		}
 	}
 	test_reg_size = test_reg_bar_size + msix_table_size + pba_size;
 
-- 
2.51.0


From a12222a044dcba8d08af7eeee45a12c9e985f502 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 16:08:57 +0900
Subject: [WIP PATCH v3 6/7] nvmet: pci-epf: Use hardware-owned MSI-X layout

The NVMe PCI endpoint function always allocates an MSI-X Table and PBA in
BAR0. This duplicates fixed regions provided by endpoint controllers that
own the MSI-X layout.

Use the hardware-owned layout when it can hold the configured MSI-X
entries and omit the duplicate regions from BAR0. Keep the existing
EPF-owned layout as the fallback.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch.
---
 drivers/nvme/target/pci-epf.c | 45 ++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 39f2f3066deb..b0b74486faa3 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2135,7 +2135,7 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 	struct pci_epf *epf = nvme_epf->epf;
 	const struct pci_epc_features *epc_features = nvme_epf->epc_features;
 	size_t reg_size, reg_bar_size;
-	size_t msix_table_size = 0;
+	int ret;
 
 	/*
 	 * The first free BAR will be our register BAR and per NVMe
@@ -2158,26 +2158,43 @@ static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
 
 	/*
 	 * Calculate the size of the register bar: NVMe registers first with
-	 * enough space for the doorbells, followed by the MSI-X table
-	 * if supported.
+	 * enough space for the doorbells, followed by the MSI-X table if
+	 * supported and not provided by the EPC.
 	 */
 	reg_size = NVME_REG_DBS + (NVMET_NR_QUEUES * 2 * sizeof(u32));
 	reg_size = ALIGN(reg_size, 8);
 
 	if (epc_features->msix_capable) {
-		size_t pba_size;
-
-		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
-		pba_size = BITS_TO_U64(epf->msix_interrupts) * sizeof(u64);
+		size_t msix_table_size, pba_size;
 
-		nvme_epf->msix_layout.table_bar = BAR_0;
-		nvme_epf->msix_layout.table_offset = reg_size;
-		nvme_epf->msix_layout.table_size = msix_table_size;
-		nvme_epf->msix_layout.pba_bar = BAR_0;
-		nvme_epf->msix_layout.pba_offset = reg_size + msix_table_size;
-		nvme_epf->msix_layout.pba_size = pba_size;
+		ret = pci_epc_get_hw_msix_layout(epc_features,
+						 &nvme_epf->msix_layout);
+		if (ret && ret != -ENOENT) {
+			dev_err(&epf->dev,
+				"Invalid hardware-owned MSI-X layout\n");
+			return ret;
+		}
 
-		reg_size += msix_table_size + pba_size;
+		if (ret == -ENOENT ||
+		    nvme_epf->msix_layout.table_size <
+			    PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts ||
+		    nvme_epf->msix_layout.pba_size <
+			    BITS_TO_U64(epf->msix_interrupts) * sizeof(u64)) {
+			msix_table_size =
+				PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
+			pba_size = BITS_TO_U64(epf->msix_interrupts) *
+				   sizeof(u64);
+
+			nvme_epf->msix_layout.table_bar = BAR_0;
+			nvme_epf->msix_layout.table_offset = reg_size;
+			nvme_epf->msix_layout.table_size = msix_table_size;
+			nvme_epf->msix_layout.pba_bar = BAR_0;
+			nvme_epf->msix_layout.pba_offset =
+				reg_size + msix_table_size;
+			nvme_epf->msix_layout.pba_size = pba_size;
+
+			reg_size += msix_table_size + pba_size;
+		}
 	}
 
 	if (epc_features->bar[BAR_0].type == BAR_FIXED) {
-- 
2.51.0


From a803e5b9b57f36a88d313646336e802845ac1cfe Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Tue, 1 Sep 2026 16:09:34 +0900
Subject: [WIP PATCH v3 7/7] PCI: endpoint: pci-epf-ntb: Document EPF-owned
 MSI-X layout

pci-epf-ntb reads host-programmed MSI-X Table entries through epf_bar[]
to set up peer outbound mappings. A hardware-owned Table does not have
that backing.

Document why pci-epf-ntb keeps its Table and PBA in EPF-owned memory
instead of selecting a hardware-owned layout like the other converted
EPF drivers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch.
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index f3e0e1b3ffb9..adef3b9dc2fc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1031,6 +1031,12 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
 	spad_size = spad_count * 4;
 
+	/*
+	 * Keep the MSI-X Table and PBA in EPF-owned memory.
+	 * epf_ntb_configure_msix() reads host-programmed Table entries through
+	 * epf_bar[] to set up peer outbound mappings. A hardware-owned Table has
+	 * no such backing.
+	 */
 	msix_capable = epc_features->msix_capable;
 	if (msix_capable) {
 		msix_table_size = PCI_MSIX_ENTRY_SIZE * ntb->db_count;
-- 
2.51.0

------------8<-----(end here)------8<-------------

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
