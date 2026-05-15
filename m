Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CE3DA7FD;
	Fri, 15 May 2026 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820729; cv=fail; b=leTJycNQqkYKDQ7wtm1N2WrydhiT1qDeLcJD5bR8ei3J245Ic9R6Sib+9nx6Hn/frHxNvuzSUm+ZEs8NK7Nnk/1AjdzMQ+ep/IVmrJ/ZP9/vGSeGs/IVFp5FoJWYXTw/79aQTyR03ZUBGJsOoakNdLl6zXz9VKVCSSEdmz5rumU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820729; c=relaxed/simple;
	bh=QYRLtShICPaN5Cn9tnZtiNBm64yDXghHct/wFOMdjQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S2QkRNSIKbL0O8+mY8JQR6wfJ2Fk/T7X2kgz+BF+n1rAkIvNds1PNwy3Nc48DvywYBz+3YLgivoT6M/LejvP5fdXjU9eTRIo8TXgt68/Ya5pM6oS/rFPuPQKHKDD6CMKfXE8BZoNo24B91aoOJQ3YjJY417Oj8NFYOcpm1AOnTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iu35Uo2o; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iu35Uo2o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlbFdr3vW2O2Vy93bseHH8m9B24QIjcwBmVKRltx0jS1NoyFHAYjIKr7hIVpUd3IwX8xUU1uZ0j0uphikl5I7dhXKiKwyaxaSH1nsEWd6+1VrRerOSF6I/OYwd9ZzhAGh4yor6bzHYvtz6AcIWej2/+IfT3xN/v7pVjxqxsyO/WV99YcTeDUdNQEIRh5myrJMQjq8G6J5YFEMNP/J+vggGV550X//s1yqsZCDmfhmKV1HSnUmODnPgFBJAgIladB8RcLkN8hVEqPKXJXANCupKeG9DFXRvsV1k3ZRIrJ5ggslAtmfHuX4B2enMI0denNVgpzF795h4ufMjXkdxMQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql/yWFbe6jeVzVyeeXr/zEdyk2wzBWjtashLsUzKeVY=;
 b=SwNKzf19Ve6AW3rGl/gODc4SIYQLfcCUpV9U8U8F8F2mDwIMNPj3YdID11gdgJgVALhTASnIxGsYZkZ6y2qWMiOXcI4CvbostLLAr3lae+6+tIFVgU2VRdA2txr7XDRpEjcfMk/VbKEnJl4Oj7SeUTfMoeZ1LxOSifUo+JYeeFDYKv3QmFa4d4godFYxa7er9Q/6gT9+GZBgJdrI7RfVuCLHRy+5dnAD/V4cAvoxrim6J2UXbwSJjd7hjlibnlsgCVK29DdXYDVol62E26PDWkW2XJ0dvODhkr8tcnPXpGXlg5YqxPIKOpyTqI9UOlwdeo0ACqywNBnDGFlFs5ZdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql/yWFbe6jeVzVyeeXr/zEdyk2wzBWjtashLsUzKeVY=;
 b=Iu35Uo2o7z2D3la+9sdxRdUsf4GExee3M8/B+ogp9Ali6W8F8o7GfbGOoGRjPkP5HeQRErMC+NYOqhi/HbUsz6Pm4Q7XZNtd0qXx+48/tI2sODzntI7mbauY0SgBdsdP9u3BM9wE2nhsBhTJJ9i46XKhMVGMAwyDyCchQ/mL3dQ=
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 04:52:02 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::b9) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 04:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 04:52:00 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 23:51:58 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 23:51:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 23:51:58 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64F4prfX3129581;
	Thu, 14 May 2026 23:51:53 -0500
Message-ID: <3853ba15-d096-4cf4-b52f-8a2e5f50fe53@ti.com>
Date: Fri, 15 May 2026 10:21:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] PCI: endpoint: Add API for DOE initialization and
 setup in EPC core
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <corbet@lwn.net>,
	<kishon@kernel.org>, <skhan@linuxfoundation.org>, <lukas@wunner.de>,
	<cassel@kernel.org>, <alistair@alistair23.me>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-4-a-garg7@ti.com>
 <m4z3q3pe3ro5vkl4uq4zkewpjdqccgeact2hj4tjnkonttx4vr@ndan37zzwgxc>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <m4z3q3pe3ro5vkl4uq4zkewpjdqccgeact2hj4tjnkonttx4vr@ndan37zzwgxc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 37040f4d-3174-4b84-489d-08deb23db38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lnm0o5QpqWkLQLEx2iXX7rOXLcO8geyLjEOoxiwnJOhM56pwBwpn1Tn7naR8cFNFq2vH1YEwXyxsXTuaQqA32ePAxoQYFJkZknexN4KCXk4YMXv1jQOILqN+3eblfsGMMWpMyXxh+QE6OR+hIgfPqCgkk4Qi3bvqQOyEskNZtvmlxcn/O81vUGaDFmQAwcAoa8VMB4QId1h1nQ4Lrt0sz4ugmmPxM9XpPJd9Qj3DDoEK7KFMAErhhrOfssj2KujPiMFClcPw1jgWPABkrDpE4W8WuWnIDjpXm91GctNhHby0xVTbNzWYyyX9DA5H8eJ1MhDQmK+8PE3Bo/iwTFgWgsgOl9SppPVF/2ZibIzymz2euRhw6c0nrVQ1ZT2/wiqsD2ZOUeB0lb9hi5yME134iAPytckX7iRAJOcoOf91F0CK/U6XHsRv5ZZ+vH3GwF/V8IOczUrRa79ZWN2xa0LLjQCW1Fn4N+Xm7vfIxGdn2qcppFTO4LaHOkh21+O4AK/LJIPsgZnOUqpr0EjYJ1Nu5HvYNdCuomg3YHBxNsxQDTBDw5eamG3fvtOTxbTcFjGqyIV/wCRnvVDoNnD2eVbEKPV8KncyLlKuO9MnwPo/DKY9GfCOL+0Th/GDA0sqnrjGkg66CK6C3QADtSEGOymXrwRU1VZ4hnyJM0qkMXgAdmJB7W4qYIuLPfxkegi48b9+t1y9vpDPsrO1djVLJ4unbZZ+/gVVFCxPLKNxohERfw4=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gN+pG27q8lTZSdU8XLntk9vBk4EjdISbTYxaopsCwqLB5gx69SuncTRZb7KXbOKtiFXD8vsFM48bhtHDCkfslPtKNB0h97aL99VvcmLmMdo1jbzMMcDsC2Gatv1/vH8kzlVeEH7z35+kCFx4A/lOOX1S4xkMOzcyJ9RXEUtmd9FZFHUWYwc7OCLP4D0BIRSRyQ4P+Iiq1P0NrodeHl6t0i3PZdmUsxnlV+817sq2n6Z/NjHgpru21KGJIPjZ2aQYrlFmbUjf5rmChS4ZTnj+2366oXnYqsJiiohfcBATWpzBTTarpIM7KdjoidoDGAbmdEdufCOBJ9nHHdm7SzE7sufpveO3GWfxMcV/RUptiJqjZ3pgyD/LQIr2Wrksjapdmd0K+NCE1GcLW4AeMqDfFLwzO/LTTKj7az76NalVv/nAdg1UWoG+2OvOqXhC5Bf2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 04:52:00.7166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37040f4d-3174-4b84-489d-08deb23db38e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798



On 14/05/26 13:38, Manivannan Sadhasivam wrote:
> On Mon, Apr 27, 2026 at 10:47:24AM +0530, Aksh Garg wrote:
>> Add pci_epc_setup_doe() API in EPC core driver to initialize and setup
>> the DOE framework for an endpoint controller. The API discovers the DOE
>> capabilities (extended capability ID 0x2E), and registers each discovered
>> DOE mailbox for all the functions in the endpoint controller. This API
>> should be invoked by the controller driver during probe based on the
>> doe_capable feature.
>>
>> Add pci_epc_destroy_doe() API in EPC core driver for cleanup of DOE
>> resources, which should be invoked by the controller driver during
>> controller cleanup based on the doe_capable feature.
>>
>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>
>> Changes from v2 to v3:
>> - Rebased on 7.1-rc1.
>>
>> Changes since v1:
>> - New patch added to v2 (not present in v1)
>>
>> v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/
>>
>> This patch is introduced based on the feedback provided by Manivannan
>> Sadhasivam at [1].
>>
> 
> Sweet! But I was expecting you to add atleast one EPC driver implementation to
> make use of these APIs.
> 
> Also, why can't you call these APIs from the EPC core directly? Maybe during
> pci_epc_init_notify() once the register accesses become valid.

Can we add the DOE initialization API to pci_epc_init_notify()? This
API seems to be called to notify the EPF drivers that the EPC device's
initialization has been completed, as the name and description suggests.
As 'pci_epc_doe_setup' is a part of EPC initialization, I thought the
EPC drivers should call this API before calling the pci_epc_init_notify().

However, I agree with your suggestion to call the DOE setup API directly
from the EPC core instead of sprinkling over the EPC drivers. I would
recommend renaming the pci_epc_init_notify() API (and hence the
pci_epc_deinit_notify() as well) to something like 
pci_epc_init_complete(), and add the DOE setup API/logic just before the
logic of notifying the EPF devices.

Please suggest if the above would be acceptable.

Regards,
Aksh Garg

> 
> - Mani
> 
>> [1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/
>>
>>   drivers/pci/endpoint/pci-epc-core.c | 71 +++++++++++++++++++++++++++++
>>   include/linux/pci-epc.h             | 21 +++++++++
>>   2 files changed, 92 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index 6c3c58185fc5..5a95a07b7d3a 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -14,6 +14,8 @@
>>   #include <linux/pci-epf.h>
>>   #include <linux/pci-ep-cfs.h>
>>   
>> +#include "../pci.h"
>> +
>>   static const struct class pci_epc_class = {
>>   	.name = "pci_epc",
>>   };
>> @@ -548,6 +550,75 @@ void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
>>   
>> +/**
>> + * pci_epc_doe_setup() - Setup and discover DOE mailboxes for all functions
>> + * @epc: the EPC device on which DOE mailboxes has to be setup
>> + *
>> + * Discover DOE (Data Object Exchange) capabilities for all physical functions
>> + * in the endpoint controller and register DOE mailboxes.
>> + *
>> + * This API should be called by the controller driver during initialization
>> + * if DOE support is available (indicated by doe_capable in pci_epc_features).
>> + *
>> + * RETURNS: 0 on success, -errno on failure
>> + */
>> +int pci_epc_doe_setup(struct pci_epc *epc)
>> +{
>> +	u16 cap_offset = 0;
>> +	u8 func_no;
>> +	int ret;
>> +
>> +	if (!epc || !epc->ops || !epc->ops->find_ext_capability)
>> +		return -EINVAL;
>> +
>> +	/* Initialize DOE framework for this controller */
>> +	ret = pci_ep_doe_init(epc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Discover DOE capabilities for all functions */
>> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
>> +		while ((cap_offset = epc->ops->find_ext_capability(epc, func_no, 0,
>> +								   cap_offset,
>> +								   PCI_EXT_CAP_ID_DOE))) {
>> +			/* Register this DOE mailbox */
>> +			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
>> +			if (ret) {
>> +				dev_err(&epc->dev,
>> +					"[pf%d:offset %x] failed to add DOE mailbox\n",
>> +					func_no, cap_offset);
>> +			}
>> +		}
>> +	}
>> +
>> +	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_doe_setup);
>> +
>> +/**
>> + * pci_epc_doe_destroy() - Destroy and cleanup DOE mailboxes
>> + * @epc: the EPC device on which DOE mailboxes has to be destroyed
>> + *
>> + * Destroy all DOE mailboxes registered on this endpoint controller and
>> + * free associated resources.
>> + *
>> + * This API should be called by the controller driver during controller cleanup
>> + * if DOE support is available (indicated by doe_capable in pci_epc_features).
>> + *
>> + * RETURNS: 0 on success, -errno on failure
>> + */
>> +int pci_epc_doe_destroy(struct pci_epc *epc)
>> +{
>> +	if (!epc)
>> +		return -EINVAL;
>> +
>> +	pci_ep_doe_destroy(epc);
>> +	dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_doe_destroy);
>> +
>>   /**
>>    * pci_epc_clear_bar() - reset the BAR
>>    * @epc: the EPC device for which the BAR has to be cleared
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index dd26294c8175..7b0f258ef330 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -84,6 +84,8 @@ struct pci_epc_map {
>>    * @start: ops to start the PCI link
>>    * @stop: ops to stop the PCI link
>>    * @get_features: ops to get the features supported by the EPC
>> + * @find_ext_capability: ops to find extended capability offset for a function
>> + *			 in endpoint controller
>>    * @owner: the module owner containing the ops
>>    */
>>   struct pci_epc_ops {
>> @@ -115,6 +117,8 @@ struct pci_epc_ops {
>>   	void	(*stop)(struct pci_epc *epc);
>>   	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>>   						       u8 func_no, u8 vfunc_no);
>> +	u16	(*find_ext_capability)(struct pci_epc *epc, u8 func_no,
>> +				       u8 vfunc_no, u16 start, u8 cap);
>>   	struct module *owner;
>>   };
>>   
>> @@ -270,6 +274,7 @@ struct pci_epc_bar_desc {
>>    * @msi_capable: indicate if the endpoint function has MSI capability
>>    * @msix_capable: indicate if the endpoint function has MSI-X capability
>>    * @intx_capable: indicate if the endpoint can raise INTx interrupts
>> + * @doe_capable: indicate if the endpoint function has DOE capability
>>    * @bar: array specifying the hardware description for each BAR
>>    * @align: alignment size required for BAR buffer allocation
>>    */
>> @@ -280,6 +285,7 @@ struct pci_epc_features {
>>   	unsigned int	msi_capable : 1;
>>   	unsigned int	msix_capable : 1;
>>   	unsigned int	intx_capable : 1;
>> +	unsigned int	doe_capable : 1;
>>   	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
>>   	size_t	align;
>>   };
>> @@ -368,6 +374,21 @@ int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>   		       struct pci_epc_map *map);
>>   
>> +#ifdef CONFIG_PCI_ENDPOINT_DOE
>> +int pci_epc_doe_setup(struct pci_epc *epc);
>> +int pci_epc_doe_destroy(struct pci_epc *epc);
>> +#else
>> +static inline int pci_epc_doe_setup(struct pci_epc *epc)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int pci_epc_doe_destroy(struct pci_epc *epc)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif
>> +
>>   #else
>>   static inline void pci_epc_init_notify(struct pci_epc *epc)
>>   {
>> -- 
>> 2.34.1
>>
> 

