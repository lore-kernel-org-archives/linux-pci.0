Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021076.outbound.protection.outlook.com [40.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121C357CE9;
	Sat, 12 Sep 2026 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225042; cv=fail; b=WThs91++HNw8N1vYFi9PYAfvvhbwi9hwG5RkbIHMiwt6Nn4ZuOg1lVH6d4yBUJQUQqhLneiC17pJ/MFjCXLCclssoUbzDcLi2QaxaOwx9AdoORd6jmfr7CZCRcPoeWRwST/eVPpgKCWv7C59QfWKsVvEKHsM/Dy+/uXVLY/DWlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225042; c=relaxed/simple;
	bh=QQ1RxTC+278ukU0OvhNFceEVzJCBYMTtSxAS57VkdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cG0fhcpUqZm/LNG9DF9DACft7HuwDsBO1yEP/fhSdrt6q1rERx0eE3hdlsUpRUokG1Jz9We5OAO9DvaZPLS+KS+KUNbg/95wZt4CMFYIdAxfp1WvR4tvJQ14MbaMAm3JXDeJtC4nFOzqnj+iDRtPmUGABUuX49bvPHPilsvd6gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=neFp3Fs9; arc=fail smtp.client-ip=40.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="neFp3Fs9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxAt0drM5AXR2O03s4DIm4hg2CZ9c4RXL8necdxo62fREkzU3FVoQQnV98BG/XAqLxmdc1S6SE3AAF6zR30AM4uwQBsZw4d6tHGf8AayK0XJFSMdq+a8nHGdMe+0lpHkKgxuukZStcMsc3qXGYzZkKxcc5XPvmuHh1IuwQn2Vv/h5QKz5m+d8Vtmzb1dekzhphBEGZTBzUEc1AtQihuPbhsI599JCXBXr7KHrTIcK9DLq4PsaVCemVd1bOjamfyL0v/UKg4VFYMyY8GAPwj0qDWNsRbhItKKN8y0dA40aH5tXMRnTmi/7meCAY6Te/vKsBwIln9ca0d0UO77qOIMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBKfSunlyaKNCqDgnJINasPXCcZuCY2dXwNtLFNSsb0=;
 b=VMUYfrv4QVh8/kvFaxVdGdzlyu9mTH+2hoyrm3JyOBfApsrT9ICaN2k/mm/LlpH6/3/jD4zwbA65m780qZU1CK65+8q1u5aTTkX6Rl9qOXicAAthXITMa2nIL3jhjequ/QLc8/xkMtHCQR4HARUr4nsxQHxuaCEZJzLJ0RZWb+accC9QQs7YAPpNrcrtQWcnR1NKYXe8RWa2gNB0EeBvmtiynkwR57CNnKwZXK/ISj9iUtJekqs5tbckjPUfsmX3Zdh+Zd5g4ZnR/hyTSUzSEja7lq77h30qyONIQ7Z4IpIwp0Ygj4Kq5rPTuVl2cEixPLgcyi+jMz4mRwxss2amaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBKfSunlyaKNCqDgnJINasPXCcZuCY2dXwNtLFNSsb0=;
 b=neFp3Fs9bBxHfr32lCRD1gEX6TkZNdkzNCQ1KkBCRiDrZWTpXRkGi2XS3VYGyZmWJlKrNGQvvhqfLzbrQ7uYCrf9CqlAMTBsBTkgksf2hYTe6x8w2f8+LMq/vWzrwfbYAx1yRB9EQQzWetJkHIFAO2KTvRHWnZnAVzgqJMPbenc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3924.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 14:57:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 14:57:14 +0000
Date: Sat, 12 Sep 2026 23:57:13 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB
 and PCI bus lifetime
Message-ID: <t7ocqmfomd5kotla734wmffdbea3onkq43lkarfeiwkcii2jwj@osrsxx3qaeko>
References: <20260901063238.631166-3-den@valinux.co.jp>
 <20260911214507.GA582865@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911214507.GA582865@bhelgaas>
X-ClientProxiedBy: TY4P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3924:EE_
X-MS-Office365-Filtering-Correlation-Id: 15641e36-8e49-4c42-0381-08df10de21c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nTFt+8alhWIc2nKJzhj7oHNU2txCclbiAGgBe2M8DOkRIs/djFpjYVjw05l+KcxT1SV3br7EIA472jJkXtXq+gG/hzQ3Pe1XRVED0pvAv3DZZAlNgf0fIq3vac6ZPe8+TCfHOKJnevd7pKva8588yKBLho4o/5H/GIEWwRY0cN700j7R7CwkuR7GtimNvRnyBk3ANO/pyZbWSZbAAKEQIL+0MLtPYsWvo9FMNqs8n1v12QbiOJUYExag6J0M5jz9gYKmBoJ0BgUwTetdlMKMEoScuKzexE+VRcI9jFlJsbj3y4Q7X2J1mmTfw8xilMSAP126c8f6s068QvdKWFeeEUMEinahFsGC2nmtmqYo783IO4Dpqsb5xsxei51lnWSPe1A02q7UVZAXAVpCcwVaviM4GzkpyeMZFnGauZzLP6EPhSNmBzdvka37cMGGo9oBLUdwAbTDxXB918NaKo1MEovIkUG8NgF+ha73XNnq/iD7Iun6frzfCV0eVnA8yIaDwO04U5McYp06tSo4Q8G/KnrU/fMmOQIaPLRmwEyNqJqKiMTjTJiXsQGkNCQzDw6gfuSAy/roz4+l4bFYDDZybnyB3ljbH6abSXr/bHqM5I8og+U7jno33ro5gfHEhCPp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yaXRI3Jg3vvXmN5Axk9NDgH2SdM+DPVM0sro9a1DJ7lc6Ry27dvErWgfvWf2?=
 =?us-ascii?Q?6dK8WSK1rtE9KefoZTQwuvHIvfCfq/cO8d0bau2q8VIBLwcEWhA5pLYK75xX?=
 =?us-ascii?Q?QoBTneT9bU9YwZI67RlyQb0JvtA11eVwsIZ2p3jHCQ8+BGcUsCOFXXsMGwte?=
 =?us-ascii?Q?eTaieVPI9fyH+aV6Po3szWimZIWniA/ajo7FfRoXaesYU+wLpbAISxs3r/ei?=
 =?us-ascii?Q?LeD/oGjItpWJSLNcG3F+xnezljwI5pVNH7hXdx9jRqVMc44Yn44zECc8hW8K?=
 =?us-ascii?Q?nLNGJkZxv5+WTtO0TtnQQZkenwLqt/5JzoxHZ6rLi0rvuMUmyk5J99hsCp0U?=
 =?us-ascii?Q?JrnAH5gCOVgtOopDm0W4Djoykvmd1DUy8l3q08FLR/QdN4XuYMj6ywMK6Qnv?=
 =?us-ascii?Q?EgBUAYpjUwqL+vvHIwUHCnq3JB3e7bJmQ8uEaxUpE/OgBqWGkZ1ftM4cHcz9?=
 =?us-ascii?Q?4C0O306L1WXSuzQyoQqusVCOkOTHL8OQFjiXt89Ai/2sZnfVvUv5J86yCv4e?=
 =?us-ascii?Q?O14np1U7fgrRtj1dEDwUzJ962OwFoPlJa3B0xEGkDR9fk55q9FWuW3e52qRt?=
 =?us-ascii?Q?btqbc7BXqo/vHVDwQH6dAuMMcaj+2aExDdxapIAGXmrupQ+lYMObrSX36pTy?=
 =?us-ascii?Q?9gLw0uozvmt8/qcoJb718ux+boPnDUMKF4TbxLD9rZRQG4+BuOcRnHLKEOxW?=
 =?us-ascii?Q?lvv/zh8fKK6tkH9RyAWc/SStlvVvXE+VFq2oGXFD36nM11Cy9LKQ3/dJhwrN?=
 =?us-ascii?Q?eYQnmPl2N8zpDZ+LC7loRaKWsxysS/AcyX4TK2zTCHY8getOWsvaKrmk9vkH?=
 =?us-ascii?Q?5x0pBpQy5M1ZVYVfdFhs2ImYeORfgT+/+gNvkJ3GEEFIxuYz0TBx9d/kIafk?=
 =?us-ascii?Q?RyrNXvdFugaZPd62Z1Qc2yW0Ed5nL/t6M94XMa5CpMLyTt1PpVEd0T2ImwnR?=
 =?us-ascii?Q?WTtvHHWis7AECez7xMvDnSTMz2euXdoDFwmJY25KcEYPc8CI48+RmU24qS+V?=
 =?us-ascii?Q?AprkkGM3bvEed3y75JLOSo7cCk8iQ8L8ZwlGL4OKi8VrHgCyLxb5glDZ0kHv?=
 =?us-ascii?Q?kAXhXd3vPQj/rKlG+uUhmP0c0RID6pwA2L8y9qxanw8YNH8m+Br9Fc2JAy/c?=
 =?us-ascii?Q?YOVwTuhvTf2pGeX793oCid7zaLvoFBnpP++qycJ+QGPMjcsJLWB1A1corKE3?=
 =?us-ascii?Q?FmPmrciaH3pH5APcDP5sK6SMD8Evd2l0TqSy0M3So+QynNXBE42U+pPMKMiS?=
 =?us-ascii?Q?BUDHMv/kB9iO8OlEQtyamDnOzZBASL9J0pCRY1GSNipBcbj5TB8pQ+o7rndB?=
 =?us-ascii?Q?eS4HvPMqI/O9VYZzQWV2Su+XnLMVEjsaRunOk3FTUAC/0vXokebwLZj7fLl6?=
 =?us-ascii?Q?dEMKRob1qmRtk3goW+NkCy/HCS/Br6/RMqdTw4gMzw9r+8BxdffJezEgEDJo?=
 =?us-ascii?Q?Zr5GopW6YUN1WltSafBQG+cz6Acimk9xJ+ODOd+Tzam5o/wHM2o/cUKhlXxy?=
 =?us-ascii?Q?5ih5q1/6X1xji42TDL14xHeb4ISnNnS6y2hFy/KsBwilVlvL4+9zPwyGWbpB?=
 =?us-ascii?Q?I9E4axQiton/fkMIdAV07vyxtp50oiJAPOd1j7+TK2dEZdO+9f+H099GhSCF?=
 =?us-ascii?Q?6BYgTtmfOzAif3lcPf91NhQJDntlQHD54eu8aXvm3xruD6W8rE/La9/Pcj5b?=
 =?us-ascii?Q?iKdNH2v3cXoxUJ9LEH7IC1DAE3oGQaK3OhR8GekM1PZwgY+pj5K027VMrESo?=
 =?us-ascii?Q?BWjcziJ7Se/nZVnLR4fYfFbj1fyIYKZGFfASU23qWi7zz7n/Enmt?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 15641e36-8e49-4c42-0381-08df10de21c3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 14:57:14.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPzUT1labPoGj0Y/7CJRQ1EcBFxnx4a5RY7MVzCyz8lsVLZgqlximEM7tuRPnBkGnYkyIP5LgChch87hH64rdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3924

On Fri, Sep 11, 2026 at 04:45:07PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 01, 2026 at 03:32:38PM +0900, Koichiro Den wrote:
> > The virtual PCI driver registers an ntb_dev but has no remove callback.
> > Unbinding the endpoint function can therefore free BARs while the NTB
> > device and its client still use them. It also leaves the virtual PCI
> > devices and root bus allocated.
> > 
> > Allocate an ntb_dev for each virtual PCI probe and unregister it from the
> > matching remove callback. Start command processing only after registration.
> > Publish the device for doorbell IRQs at the same point. During remove, stop
> > the command work and drain IRQ handlers before unregistering the device.
> > 
> > Retain the root bus returned by pci_scan_bus() so it can be removed on
> > unbind. Unregister the virtual PCI driver before releasing endpoint
> > resources. Stop and remove the root bus under the PCI rescan/remove lock,
> > then release its host bridge.
> > 
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Cc: stable@vger.kernel.org # 6.0+
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v6:
> >   - Rework v5 patch 5 on v7.3-rc1.
> >   - Publish ntb_dev only after registration, and tie command work and
> >     doorbell delivery to its lifetime.
> >   - Retain and remove the virtual root bus, then release its host bridge.
> >   - Drop v5 patch 4; f7245901de89 ("PCI: Check parent for NULL in
> >     of_pci_bus_release_domain_nr()") fixed the bug it worked around.
> >     v5: https://lore.kernel.org/r/20260226084142.2226875-6-den@valinux.co.jp/
> > 
> > @Frank, the code changed substantially since v5, so I did not carry your
> > R-b tag. I would appreciate another look.
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 85 +++++++++++++++----
> >  1 file changed, 70 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 412e8cc6fb1d..992f5e7f8d4a 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -132,7 +132,7 @@ struct epf_ntb_ctrl {
> >  } __packed;
> >  
> >  struct epf_ntb {
> > -	struct ntb_dev ntb;
> > +	struct ntb_dev *ntb;
> >  	struct pci_epf *epf;
> >  	struct config_group group;
> >  
> > @@ -166,10 +166,15 @@ struct epf_ntb {
> >  	void __iomem *vpci_mw_addr[MAX_MW];
> >  
> >  	struct delayed_work cmd_handler;
> > +	struct pci_bus *vpci_bus;
> >  };
> >  
> >  #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
> > -#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
> > +
> > +static struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
> > +{
> > +	return ntb->pdev->sysdata;
> > +}
> >  
> >  static struct pci_epf_header epf_ntb_header = {
> >  	.vendorid	= PCI_ANY_ID,
> > @@ -195,7 +200,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
> >  	else
> >  		ntb->reg->link_status &= ~LINK_STATUS_UP;
> >  
> > -	ntb_link_event(&ntb->ntb);
> > +	ntb_link_event(ntb->ntb);
> >  	return 0;
> >  }
> >  
> > @@ -284,7 +289,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  	     i++) {
> >  		if (ntb->epf_db[i]) {
> >  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> > -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> > +			ntb_db_event(ntb->ntb, i - EPF_IRQ_DB_START);
> >  			ntb->epf_db[i] = 0;
> >  		}
> >  	}
> > @@ -348,12 +353,18 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >  static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> >  {
> >  	struct epf_ntb *ntb = data;
> > +	struct ntb_dev *ndev;
> >  	int i;
> >  
> > +	/* Pair with smp_store_release() in pci_vntb_probe(). */
> > +	ndev = smp_load_acquire(&ntb->ntb);
> > +	if (!ndev)
> > +		return IRQ_HANDLED;
> > +
> >  	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
> >  		if (irq == ntb->epf->db_msg[i].virq) {
> >  			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
> > -			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
> > +			ntb_db_event(ndev, i - EPF_IRQ_DB_START);
> >  		}
> >  
> >  	return IRQ_HANDLED;
> > @@ -985,7 +996,6 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  	}
> >  
> >  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> > -	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
> >  
> >  	atomic64_set(&ntb->peer_db_pending, 0);
> >  	enable_work(&ntb->peer_db_work);
> > @@ -1340,6 +1350,7 @@ static int vpci_scan_bus(void *sysdata)
> >  		pci_unlock_rescan_remove();
> >  		return -EINVAL;
> >  	}
> > +	ndev->vpci_bus = vpci_bus;
> >  
> >  	pci_bus_add_devices(vpci_bus);
> >  
> > @@ -1425,7 +1436,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	int ret;
> >  	struct device *dev;
> >  
> > -	dev = &ntb->ntb.dev;
> > +	dev = &ndev->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> >  	epf_bar->phys_addr = addr;
> > @@ -1563,7 +1574,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
> >  			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> >  						PCI_IRQ_MSI, interrupt_num);
> >  			if (ret)
> > -				dev_err(&ntb->ntb.dev,
> > +				dev_err(&epf->dev,
> >  					"Failed to raise IRQ for interrupt_num %u: %d\n",
> >  					interrupt_num, ret);
> >  		}
> > @@ -1681,13 +1692,18 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >  
> >  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > -	int ret;
> >  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> >  	struct device *dev = &pdev->dev;
> > +	struct ntb_dev *ntb;
> > +	int ret;
> > +
> > +	ntb = devm_kzalloc(dev, sizeof(*ntb), GFP_KERNEL);
> > +	if (!ntb)
> > +		return -ENOMEM;
> >  
> > -	ndev->ntb.pdev = pdev;
> > -	ndev->ntb.topo = NTB_TOPO_NONE;
> > -	ndev->ntb.ops =  &vntb_epf_ops;
> > +	ntb->pdev = pdev;
> > +	ntb->topo = NTB_TOPO_NONE;
> > +	ntb->ops = &vntb_epf_ops;
> >  
> >  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >  	if (ret) {
> > @@ -1695,16 +1711,41 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  		return ret;
> >  	}
> >  
> > -	ret = ntb_register_device(&ndev->ntb);
> > +	ret = ntb_register_device(ntb);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to register NTB device\n");
> >  		return ret;
> >  	}
> >  
> > +	/* Publish after ntb_register_device() succeeds. */
> > +	smp_store_release(&ndev->ntb, ntb);
> > +	queue_delayed_work(kpcintb_workqueue, &ndev->cmd_handler, 0);
> > +
> >  	dev_dbg(dev, "PCI Virtual NTB driver loaded\n");
> >  	return 0;
> >  }
> >  
> > +static void pci_vntb_remove(struct pci_dev *pdev)
> > +{
> > +	struct epf_ntb *ndev = pdev->sysdata;
> > +	struct ntb_dev *ntb;
> > +	unsigned int i;
> > +
> > +	/* Stop the work reader, then close and drain the IRQ gate. */
> > +	cancel_delayed_work_sync(&ndev->cmd_handler);
> > +
> > +	ntb = xchg(&ndev->ntb, NULL);
> > +
> > +	if (ndev->msi_doorbell)
> > +		for (i = 0; i < ndev->db_count; i++) {
> > +			if (epf_ntb_db_irq_is_duplicated(ndev->epf, i))
> > +				continue;
> > +			synchronize_irq(ndev->epf->db_msg[i].virq);
> > +		}
> > +
> > +	ntb_unregister_device(ntb);
> > +}
> > +
> >  static struct pci_device_id pci_vntb_table[] = {
> >  	{
> >  		PCI_DEVICE(0xffff, 0xffff),
> > @@ -1716,6 +1757,7 @@ static struct pci_driver vntb_pci_driver = {
> >  	.name           = "pci-vntb",
> >  	.id_table       = pci_vntb_table,
> >  	.probe          = pci_vntb_probe,
> > +	.remove         = pci_vntb_remove,
> >  };
> >  
> >  /* ============ PCIe EPF Driver Bind ====================*/
> > @@ -1796,12 +1838,25 @@ static int epf_ntb_bind(struct pci_epf *epf)
> >   */
> >  static void epf_ntb_unbind(struct pci_epf *epf)
> >  {
> > +	struct pci_host_bridge *bridge;
> >  	struct epf_ntb *ntb = epf_get_drvdata(epf);
> >  
> > +	pci_unregister_driver(&vntb_pci_driver);
> > +
> > +	if (ntb->vpci_bus) {
> > +		bridge = to_pci_host_bridge(ntb->vpci_bus->bridge);
> 
> Where was this host bridge allocated?

The existing pci_scan_bus() call allocates it during bind:

-> epf_ntb_bind()
  -> vpci_scan_bus()
    -> pci_scan_bus()
      -> pci_create_root_bus()
        -> pci_alloc_host_bridge()

Best regards,
Koichiro

> 
> > +		pci_lock_rescan_remove();
> > +		pci_stop_root_bus(ntb->vpci_bus);
> > +		pci_remove_root_bus(ntb->vpci_bus);
> > +		ntb->vpci_bus = NULL;
> > +		pci_unlock_rescan_remove();
> > +
> > +		pci_free_host_bridge(bridge);
> > +	}
> > +
> >  	epf_ntb_epc_cleanup(ntb);
> >  	epf_ntb_config_spad_bar_free(ntb);
> > -
> > -	pci_unregister_driver(&vntb_pci_driver);
> >  }
> >  
> >  // EPF driver probe
> > -- 
> > 2.51.0
> > 
