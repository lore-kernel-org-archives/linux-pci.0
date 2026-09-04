Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448783CB574;
	Fri,  4 Sep 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538336; cv=fail; b=V2lCqqp0hh5v5etObuBdCMSFebwnkx9Bw23hlvKFeuykvfucoIc88SAUnHtV2EBppRd/mMGRw6uYBpFDjRkS224MnS+kCxbV5bLgRO2cqHx9+vbL8kzVVzAkv+P/3t8R+DjPFgTMS/FsQXs3h5NyvNHAVvzbPWaSl6/ZftKAM4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538336; c=relaxed/simple;
	bh=ysjau9911CSYcDxZhTNcMoGk3wxRzSDNp0uGvRCusEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rIJSq+Ftdh0M8tNW0yW2ftVCxg3YvU2VbtG68dM7DzhUUQv31/vjJgqopxytphVfoLYA01ejGXmy9/VLepqdffGO98B0v09CvFExqz7JvNbjdznIWOFMgtoViDKZ25XO9mrjEiJtiDHn9ZZ86C4/0od+ZUHsvpkXkeiMDj+ZeVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A8OV7QGd; arc=fail smtp.client-ip=52.101.125.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A8OV7QGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVBo5W46YPBjh73USjEpP8MksSQ09CTZX1QcIqRceobcKhmAdPJqZ+jqu+TWWXPjue5etcNUqT88HiSuxIkokGP8AFH47ywZsRI/7fnnTHlgIpcqYlbbVk3NF3Q82wiLi2ffYjwCzhZ4jTTIL9Wba+ctKINCdOvBnpqCxj8jzyxkDqLT+54CeItfoVfWyucASgW7TKistZbQchUvl5wX7MuWUEeLk2bULIiKNKZaimLO6B+9G7PQsiKYVuqIrliEl7/Bc7fZW4edFa4EdOLP1Nbf5/VJEqPKNCcpPKVwyJFMI/OOQcVx2YKAnaDU3/lK3nWHh0PJFR69Qmy2DS0aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0/wH2GM//vJL7ISJlS+ropXVWk83WR8n3loJWBu60Q=;
 b=IaY9FPodrA8BAlLlVnAukzaW/fpjaIbtyXbmVSocYd44Px+sw+lNxxz956U3OCkJHzHppzvhGAggigkGhjRQe9IyXUsKSCKm8bn5YlisnzVk/iPg+Ws26+5BL6Wn8ARDKQhYkHgrt3FlBdUVnfuciL/+6esKuT+jCUtPWwnoHGLUzMlukpdE1y4FHqNgDhfNR6VFfyEBDJQO14z3vkY+wxXmpEYk95IgTYKPuzuXJKhCirYoT1BBVeR8LBBNsjPK5FsHB5H2oI/9AlY+0/NPjDSDYkoTPTMi1APmlMnkQ69HbLSlvrX1/3gNt4eztj+QK3jdbdO/wSOYOmeECHleXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0/wH2GM//vJL7ISJlS+ropXVWk83WR8n3loJWBu60Q=;
 b=A8OV7QGdgEl3noXJk/UvuYmdyHIlRQ1Je39YoERwxPsAaqiOw4hw1e9qHMHWSnUHHRMh5r0jdJ5V9W1jB2HW6gvpxIYa24l2vZw4o5Y2ZpVPVoLLSta6C4z70obTY72cKbuPkwGTPzvWIimdOsO6H97Ih19IRLJMPAZFCBMRtBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:12:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 16:12:05 +0000
Date: Sat, 5 Sep 2026 01:12:04 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Track link state from both
 sides
Message-ID: <55rephslx56s34vh7z5tv2juhcoscudbloxcjsqxbw5vlky4nx@i4xtlf7p2662>
References: <20260904065335.3059625-1-den@valinux.co.jp>
 <apreL-yPOQlH3Caa@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apreL-yPOQlH3Caa@SMW015318>
X-ClientProxiedBy: TY4P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a99d8d3-e1d7-449e-4a72-08df0a9f435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|3023799007|10067099003|4143699003|6133799003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GBr7oQ3SzwSSrEk6iZCz6SP6jmk4CKh6PJZvvPH282Iz/MOKbPXZ4CE6Zk0Q8zYXlZLH0WxokTIK1S/kiWSKNO+wjlhsvudxT3ZFSCEQDY60ctLQKH852sTNjg0fodluPyAV9fZGHWH6A510+zye1BIvmwjcKEHeGeX9uBdJOPFjG5OB2beGl6GjMfXmsSdXytAHSRNkaBYPUFsZMpEJvTfW5W4/3ooNjmFZh7b4SkAqjd+xc6vvjuRMGn/4YJ03MtSNcoasgOKrA7B1gDvho/Wn7kaaecsIzJaRF1bWV+KJDfzzh+93pKuNMVLJEWsKm486aAcYX6PYpMvP//1CRJqshoTpt0SwAv1/EsTwmKICYpQntLu/Qo4oWKx7Z87Z7iTL/BBH0d1nuYou0LScF/IzExbX0kkhTfZdtj8AlWsPHrNbiev0kfVMiwpnALO0U23nuYtdb/7FqwCM+SWTqTDxlPikNpqJDRv7Hyu5HH05/se94PbVUHaLOth/ixqXYPs0atFTV+8WTav1fXyzaOLC+Tu6Ty8w0evnC1WQedCfokCOLgvdjHwQOwwaQwuYteiGgSCiz9PYPT8SnXYWl+3FAM3s9JvP+XJ5234K/AAZZR5C6gEU8kCFiVdtiaAw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(3023799007)(10067099003)(4143699003)(6133799003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9g9mHZzz9XQ1RH8S6raiRQOsjHmWRVeQo0bki+yR/HKWUOzoEBSeyVEaqGB?=
 =?us-ascii?Q?nHdfUUCurXxazVe5XGYXRIChXzJUYjl4ArwpxPRV/wQWN5cDKeYxtxUOhHfM?=
 =?us-ascii?Q?1ivZyf1yUfwgNx6BrOX31pPwGh1/jROXYUHtBBIVR2YPJH7RhIvNy9bRwzSJ?=
 =?us-ascii?Q?E9eT1yC3jN9UGH07VTn37owkoE7LvumwdEc5dfOUnSmn8L6gF33ab4s5tq7q?=
 =?us-ascii?Q?D5MutnshUj6GgBYWBMaX+QKBYgmIlfMxi1CU69XcaVPu9FfLrPMHSgmhnpG3?=
 =?us-ascii?Q?zY4MQFswM2+J5qF5JADGjxcThkGAlIZT5g6z5SBC1TtBzkAIWwpiI2gl+VX8?=
 =?us-ascii?Q?P6ME+xs6Y/fwghUSubN9LPFNRdIoauakEuGCzjp+uk1rGH2sH82BZkiak3Db?=
 =?us-ascii?Q?y2hlG27J+mFYvnB/2LKlVTJiC93/YcrEkSBOI4ZHMUStYrrU/wY58R1aV6+7?=
 =?us-ascii?Q?++fqQi7ePto2pqmu9DNWAROH3u3ZUSTFGgASbZ63RDNsr31ElWUe/1BMx1p2?=
 =?us-ascii?Q?E2e3Jj2aquJBw0n7fqL2KjXTkX9N4G4pAWSyE15+PD+/H5JX9LGJJ93PKsui?=
 =?us-ascii?Q?ynDvPKudRvsZKjruzZoITj1JTD7a5NWn0IVSZEAP7HZQj2FWAuJjkcQ2lEeR?=
 =?us-ascii?Q?CZhvnWEdStvNcz8WUWJAcXL21crPQyW7K8Uw8RiERIgsXPIaDgA3BsNwbveY?=
 =?us-ascii?Q?GTiqTCfWBYqGq1rVSVEA7HLLEtZ2D9LHfppeFEN+tzYETfuLBTQEYDd2ez36?=
 =?us-ascii?Q?ux0xyVvd3jpD18CoEyvdNn5lznYIH4CFwvrtYYfkziO6WjpqoNM//kWd7RnB?=
 =?us-ascii?Q?NN+6YlWSuiU9tx2yEQDUMPkawcH2F9wpUs1tkgzEK+dcKObEtYdHgEEXf+Qn?=
 =?us-ascii?Q?loAR6Q8cRNHG7IPQuUmLabJniBzh1fmmz9CZs5b1BW2uqIrHajs0MgNgOhkj?=
 =?us-ascii?Q?RpSPJEFeb12ubUleAePbzo7rH6TAPgkQj8I+dsPXaljD052PE9atLJK3XcEO?=
 =?us-ascii?Q?he0fgglBR7/ornaXMGdKeib4xu5Pn3ApMha3VJEnOrljA7WffQhxxkVzjBT8?=
 =?us-ascii?Q?ATY1ZZQ9qZPIY7Oa2Wb+FDENTRvjeScpUKvwzbJ5jnTlvhLl+Y69VIqmId8y?=
 =?us-ascii?Q?H1+HLFV0Amikl0dTZ5Ng3E0ild9SR9gRryW+Jc5WvWxkup9lLkqVdV3yh37j?=
 =?us-ascii?Q?aDLWU1mHVJoJbZfONqQrB+/lExnXhkPo7kZ9MXFXG2E93V4Sg5YthbfD4bt2?=
 =?us-ascii?Q?VmrvzzGzXUuo8T8Y2hq5KFNkwFdqohXKZ550NICNTH6sSyNtdIxUKqmqq08I?=
 =?us-ascii?Q?fHogsoEnvCoeii4lAcc+yu4zYflnFYESZTdX7sd1O2AIFDJPl0BdqAF4UDwc?=
 =?us-ascii?Q?3XlEyY92GpvZ0cgshJgKbAsmzoj+v9zf3ZacBBP/FhjsyQl0HVgQdFOENhDd?=
 =?us-ascii?Q?rS9SsTGiTE1ynyuIcZU9jIPww7XdyjsHLDtx1g4rIZlJxCNG6OxDO9zBtU3z?=
 =?us-ascii?Q?GrtbMR3S2ASSPcAVxVQ5qpSBnXPVi4gS8qnRZp+cERNulru3JngxvMmYFFex?=
 =?us-ascii?Q?5ex6/3DedqxT2QqVzLnHu4eSpB2oLayDAEnWqSWXAmMY1L1n6lSWPxAnvzUx?=
 =?us-ascii?Q?l0zJl7/ro9MIeqPAq2LohKT9cdYkXgmXPmzCTIz2zf7toAk5kLdaXfcCJQn2?=
 =?us-ascii?Q?bncYhVxcx/MYhEqSpflSbEUFOHjUc21dcYFtYExmMyc0JkySfuogDPY+gI7q?=
 =?us-ascii?Q?aJbAIs34D1tinU2+xLnCTapIR0t7XEdFvLDeEVi6o9Q2AcjCd7v0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a99d8d3-e1d7-449e-4a72-08df0a9f435f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:12:05.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJbGzur1ABJlmW57Fmfyfd02PEdWoefR9hSipPny3mF6HK86+ocArkeKGsL06cQ2GMDExP0IEnxSH8q9m9njAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

On Fri, Sep 04, 2026 at 10:05:19AM -0500, Frank Li wrote:
> On Fri, Sep 04, 2026 at 03:53:35PM +0900, Koichiro Den wrote:
> > The control-region link status is currently updated only by
> > COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> > NTB link callbacks are empty. Consequently, the HOST can see the link as
> > up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> > leaves LINK_STATUS_UP set without notifying the HOST.
> >
> > ntb_netdev can hide this device-level state bug because ntb_transport uses
> > a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> > device link state directly:
> >
> > After bringing both sides up, start this waiter on the HOST:
> >
> >   echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
> >
> > While it is blocked, disable the link on the VHOST:
> >
> >   echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
> >
> > Without this patch, the second command succeeds, but peer0/link on the
> > HOST remains Y and the waiter does not return.
> >
> > Track HOST and VHOST enablement separately and report the effective link
> > as up only when both sides have enabled it, as pci-epf-ntb does for its
> > two physical hosts. Notify the other side only when this effective state
> > changes. Serialize the two paths because HOST commands run from delayed
> > work while the VHOST callbacks may run concurrently.
> >
> > With this patch, peer0/link on the HOST changes to N and the waiter
> > returns.
> >
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Note: This is a standalone fix, but it conflicts with the following
> > series:
> >
> >   [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table and PBA
> >   https://lore.kernel.org/r/20260830151948.3547577-1-den@valinux.co.jp/
> >
> > That series still has pending issues and will need more work. I will base
> > v3 on this fix and make the new link-event IRQ honor the MSI/MSI-X
> > selection made by the HOST.
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 82 +++++++++++++++----
> >  1 file changed, 65 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index fba65abfb6b2..51200223f53c 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/slab.h>
> >
> >  #include <linux/pci-ep-msi.h>
> > @@ -147,7 +148,10 @@ struct epf_ntb {
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> >
> > -	bool linkup;
> > +	/* Serialize HOST and VHOST link state changes. */
> > +	struct mutex link_lock;
> > +	bool host_linkup;
> > +	bool vhost_linkup;
> >
> >  	/*
> >  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > @@ -178,24 +182,42 @@ static struct pci_epf_header epf_ntb_header = {
> >  	.interrupt_pin	= PCI_INTERRUPT_INTA,
> >  };
> >
> > +static void epf_ntb_update_link(struct epf_ntb *ntb)
> > +{
> > +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> > +
> > +	/* The link is usable only after both sides have enabled it. */
> > +	if (ntb->host_linkup && ntb->vhost_linkup)
> > +		link_status |= LINK_STATUS_UP;
> > +	else
> > +		link_status &= ~LINK_STATUS_UP;
> > +
> > +	WRITE_ONCE(ntb->reg->link_status, link_status);
> > +}
> > +
> >  /**
> > - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> > + * epf_ntb_link_up() - Update the HOST link state
> >   * @ntb: NTB device that facilitates communication between HOST and VHOST
> > - * @link_up: true or false indicating Link is UP or Down
> > + * @link_up: true when the HOST has enabled the link
> >   *
> > - * Once NTB function in HOST invoke ntb_link_enable(),
> > - * this NTB function driver will trigger a link event to VHOST.
> > - *
> > - * Returns: Zero for success, or an error code in case of failure
> > + * Returns: Zero for success
> >   */
> >  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  {
> > -	if (link_up)
> > -		ntb->reg->link_status |= LINK_STATUS_UP;
> > -	else
> > -		ntb->reg->link_status &= ~LINK_STATUS_UP;
> > +	bool notify;
> > +
> > +	scoped_guard(mutex, &ntb->link_lock) {
> > +		notify = ntb->host_linkup != link_up && ntb->vhost_linkup;
> > +		ntb->host_linkup = link_up;
> > +		epf_ntb_update_link(ntb);
> > +	}
> > +
> > +	if (notify) {
> > +		/* Publish link status before completing the HOST command. */
> > +		dma_wmb();
> > +		ntb_link_event(&ntb->ntb);
> > +	}
> >
> > -	ntb_link_event(&ntb->ntb);
> >  	return 0;
> >  }
> >
> > @@ -320,7 +342,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  		ctrl->command_status = COMMAND_STATUS_OK;
> >  		break;
> >  	case COMMAND_LINK_UP:
> > -		ntb->linkup = true;
> >  		ret = epf_ntb_link_up(ntb, true);
> >  		if (ret < 0)
> >  			ctrl->command_status = COMMAND_STATUS_ERROR;
> > @@ -328,7 +349,6 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  			ctrl->command_status = COMMAND_STATUS_OK;
> >  		goto reset_handler;
> >  	case COMMAND_LINK_DOWN:
> > -		ntb->linkup = false;
> >  		ret = epf_ntb_link_up(ntb, false);
> >  		if (ret < 0)
> >  			ctrl->command_status = COMMAND_STATUS_ERROR;
> > @@ -1456,11 +1476,34 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_dev *ndev, int idx,
> >  	return 0;
> >  }
> >
> > +static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
> > +{
> > +	struct pci_epf *epf = ntb->epf;
> > +	bool notify;
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &ntb->link_lock) {
> > +		notify = ntb->vhost_linkup != link_up && ntb->host_linkup;
> > +		ntb->vhost_linkup = link_up;
> > +		epf_ntb_update_link(ntb);
> > +	}
> > +
> > +	if (!notify)
> > +		return 0;
> > +
> > +	ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> > +				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> > +	if (ret)
> > +		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> >  static int vntb_epf_link_enable(struct ntb_dev *ntb,
> >  			enum ntb_speed max_speed,
> >  			enum ntb_width max_width)
> >  {
> > -	return 0;
> > +	return vntb_epf_set_link(ntb_ndev(ntb), true);
> >  }
> >
> >  static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
> > @@ -1620,7 +1663,7 @@ static u64 vntb_epf_link_is_up(struct ntb_dev *ndev,
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >
> > -	return ntb->reg->link_status;
> > +	return READ_ONCE(ntb->reg->link_status);
> >  }
> >
> >  static int vntb_epf_db_clear_mask(struct ntb_dev *ndev, u64 db_bits)
> > @@ -1638,7 +1681,7 @@ static int vntb_epf_db_clear(struct ntb_dev *ndev, u64 db_bits)
> >
> >  static int vntb_epf_link_disable(struct ntb_dev *ntb)
> >  {
> > -	return 0;
> > +	return vntb_epf_set_link(ntb_ndev(ntb), false);
> >  }
> >
> >  static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> > @@ -1750,6 +1793,10 @@ static int epf_ntb_bind(struct pci_epf *epf)
> >  		goto err_bar_alloc;
> >  	}
> >
> > +	ntb->host_linkup = false;
> > +	ntb->vhost_linkup = false;
> > +	ntb->reg->link_status = 0;
> > +
> >  	ret = epf_ntb_epc_init(ntb);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to initialize EPC\n");
> > @@ -1833,6 +1880,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >  	epf->header = &epf_ntb_header;
> >  	ntb->epf = epf;
> >  	ntb->vbus_number = 0xff;
> > +	mutex_init(&ntb->link_lock);
> 
> devm_mutex_init();

Thanks for pointing that out. I will use it in v2.

Also, Sashiko's feedback seems valid. I have tested the updated patch with
ntb_tool again and confirmed that when the VHOST brings the link down, the
link_event waiters on both sides return. I will send v2 shortly.

Best regards,
Koichiro

> 
> others look good.
> 
> Frank
> >
> >  	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> >  	disable_work(&ntb->peer_db_work);
> > --
> > 2.51.0
> >
