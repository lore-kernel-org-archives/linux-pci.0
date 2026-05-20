Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAC233924;
	Wed, 20 May 2026 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251774; cv=fail; b=e2CpQmX0Y9/Vd9aqlCeavz+4YEaOjlczPHh8Oih6eAZGDsm6rX2mIzZpkiDI8BOA411ng111rFlHpr21LyMQ1Lvk2ZffkmEKCl37uIHOcdJblxQYKk7dWz0ghDWOOdTPDX4fBRM4iziogk0eup24w2ehYbx8I2flYrFJ5v4UVv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251774; c=relaxed/simple;
	bh=k9JPi9cGS+Bi4ah0sYb5+SGnukctdvmmV71wJtLYJFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c77tpUK8wTMdCj6SXWJKqp6ALk5nBM3mbT/U8xWrnFC/RvYi7TLu8QlVTC7ZQc2O+Ry4l3xM6zWJmWNDuTj+dRP6nvGxoOWSO5m7n/b+9l9LObKeRjK/rF0YpFNn4g5XlIkJvekbJuz9Ry3PjF7AaNxpQCVj99JVO/qQAxZqFaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jNg2Bo2a; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jNg2Bo2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPwZoz7D0yBrGq9KQLNpI6Lo0fnkcFZiiT1UHUBprSWvcRqDuGefkF0x/pZqL9DExuk+AY13KPvJ6ZwJVDWps+FhNgUhd2p/FpQN8ldvNFV896v73wtphBYeRIg13JbZ9xi3tlq77HsTMXUxBYks5wv+AHJoLDe/a7pXrTDTMakyyUYUXEXbwUTXVbMWEEbHvsBj93ThbLfa/6cIb+KTd8Pkv7ijUvBDCS+IAbIsPvD13TitmsBA2MvtBme77fO0tP6YW+WEkF2VpTuXKYE5iBBuiyBvJ9nIn2+t9ZFQQUs6ZaR8lPT/FBQt5jySh2PwP7KtiRmCJwljuQqQcTjJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrKHuvoZnUGl6MhZXtGcpZkEyuyEd5G3AoUNULQwFK0=;
 b=nJcYdSumsSO+HpQ/V1Sv5uNtkky8AEbNoSPE3z3YrDHm9YRtr5urNCajZlPwWtUs5fjjJlWYLf9uguF+jlBAtBUFrJYGZ8bo8jTe3qNnBqnbcrSz+Wh3r+OpcaqIwbVZc0RIxLUx0gRwQyZSUZXvcNglABznRffIQksxhTjmBtWuls22myGhuSUReeS2r0oR9wyuIT6g9cnQ4vxND7m4942SjV6BHGi+BeyaE9+qnR5tcNTmfT/VbFwlezFm3CYBlShoKXwsmeRIsG99KVX3okZs66STgLTKORRAPSmSOl7cb7oXEVQidlrI/HlvRH3Y0ivsQbM2s4NqfQbJ5ipIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrKHuvoZnUGl6MhZXtGcpZkEyuyEd5G3AoUNULQwFK0=;
 b=jNg2Bo2aGIcXAvjebyq1TlWb7R+Ep2u5v6s/LfTGHstcpJA8/4AwssRnF6+1JZ4wOuveacal2pWfdd3KW6VSyM2ju+OPUrUF3GKcNQXmnafut9dcsaJlzWFRR+TU6RPxz5BPXkYBSr3tiGvCATe+lTWRED+X79UF/udykFSTGA4=
Received: from CH2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:610:54::35)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 04:36:09 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::f) by CH2PR11CA0025.outlook.office365.com
 (2603:10b6:610:54::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Wed,
 20 May 2026 04:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 04:36:09 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 23:36:09 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 23:36:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 23:36:08 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K4a5Dn1243820;
	Tue, 19 May 2026 23:36:06 -0500
Message-ID: <6ca26fc1-27d8-45ae-8f16-3266e90e74eb@ti.com>
Date: Wed, 20 May 2026 10:06:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Hans Zhang <18255117159@163.com>, Manikandan Karunakaran Pillai
	<mpillai@cadence.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-4-18255117159@163.com>
 <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
 <e3fa093e-28a5-46a1-a10e-e8065d127d08@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <e3fa093e-28a5-46a1-a10e-e8065d127d08@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 746c78a3-661e-410b-6bed-08deb629508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vjtHy7bFCDQ9Fk6/9uHw+BQmL9zcI9fo4YB8yzABXe4j1jbIBtHnjUZUhN3KGBx8dy55+fbMTbq9QP4aaQuuD+Y7elfA7zZN9GweavHzifvVvQRKw+RUCkAVpe/68DgGMH6YjWNQty7i3jVFpd0Vlj7uEXtDy1zbWOXY9HLOLV0Cl5bbnZttz3sfeULC+yURmNLcnkMff7bzJfGR5PJazEVHOggc6a7fVr/5tq+QyEBM36S8MbvOLvybXMDtS9cSmOhWRi6r6IsXxLpjLsqgz0DP5f0n7loT63BPMes2AjAuMZ9b1GzHPW/9DA9Rkx90D9k5Ghc/AH/xhw2Grhcf/QoZYBLggVBBozzo9tQ1pBhVLQeoYPJ+K7UbkzPNFOkRBCh0gw+XZEEaA7yZ4eW7Qsc89PsTeLjuHEQyzuL1TX+UVXxhI/yS63hPeJrEGeBgHHt+XcSdNAyVkUaqb996GEL8WVgi8fZZT9WAouWDTChmoZpLY41kGLO182nGn4fZqChxH0N73GIPM2ZyozNMsUkGGJDgnSVoi6ny/nCby8QsN2QREHPDWQ+rM+8/xY6KggLU6UQdxdl34WtkvBEOd7VVSYtj+tiXS2cdT8X0RAlBkkbElmu1Z0skh9L8CM7f+ddKATsCBxiBIIpAdbJX1CHrQiznV2rAlpLnLcqAMf79z7bTPGRrv7IL+mGKhB0QOJVT+oDFO+OW1nXU/RQG/r1mCQqG+UrpXbo1u2VB5k4=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ih7vqYi5Nc+hBuXY6QxpWyhKtYjzwX3dwZvt7HI+7wlaTiJGh8JoCEM73iIEkBmieyX8GVPIWRjpKVwXk6OuyuN61LwHjhdS+lyOxgd8xZ2QfSbEjeSd1nrsJkt0hM0ueMI8vFiJMAa8GXCvKaF3065SCVbShOZ99IJdvXvFGpJxmzlvCs7ESR0KpGmm8eFQamN7AVEpioDbVhhxdbrKAFiChwtPc9q8yKq6LWC+G/hE71bvRtJwu6IgkasZrnYcCZZGnmmGcDNwnZMB9hP7jMmBaf6j/f/WD8ZUzjxN9NdktPNftKCP1lZtV/Kai3r16bZzgGKrdqgpew4LTA5V2L9D5uKJWo+lSIBovQ7Tb3UbMbQSggpC5PZJvs9383OuB/7qJoJUkLjGsS/umlf9TvntFOnAFjLrO5yZ1XbsMz3Um8wLL/wp2ShquRMJWdUE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 04:36:09.3698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c78a3-661e-410b-6bed-08deb629508f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074



On 20/05/26 08:29, Hans Zhang wrote:
> 
> 
> On 5/20/26 10:34, Manikandan Karunakaran Pillai wrote:
>>> EXTERNAL MAIL
>>>
>>>
>>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>>> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
>>> appropriate register access based on the 'is_hpa' flag.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>> .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>>> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>>> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>>> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>>> 4 files changed, 112 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>> b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>> index 97c5deef2b1a..0a308f95e9f6 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>> @@ -13,6 +13,58 @@
>>>
>>> #define CDNS_DEBUGFS_BUF_MAX        128
>>
>> Where is CDNS_DEBUGFS_BUF_MAX used for ?
> 
> Hi Manikandan,
> 
> Thank you very much for your reply and reminder.
> 
> This macro definition was used in patch 0002. Since I compiled the code 
> after applying all three patches together, I didn't notice this issue. 
> The next version will be fixed and will be included in patch 0002.

I didn't understood the issue here. The macro definition was indeed 
introduced in patch 0002 itself right? Am I missing something here?

> 
> Best regards,
> Hans
> 

