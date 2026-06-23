Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F782C375E;
	Tue, 23 Jun 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192282; cv=fail; b=t4j6nzl++mThoJTSXXDu4p+PsCgQOcofYLKL7nwYtGqK8IpMT69KBPLFb3mCtSG4YNJf42M1OkcR4XQ6h5o91Zva9WlsGf7GmXqnC505fko2i3jlOeu/cgYfxDzSx2xGh3Zix0BNRgYehCUAzFvFMkvmLiKoUqZQU8SpqgONK00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192282; c=relaxed/simple;
	bh=pcuMYYS+nEmzdua711oJ27mKmT9Qo4EpJQXASMP6sE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XuRYviByY5PbLeBU5VFrlfOGe52c7NNvvHK1fFMThMF5pSn1BastRsTmzT8LSj3Q5/UinQ+ScPTOm53kFx54xam8ZFgJIIo8Ob30yK0VdnZUWW0SkKKCnB9wCjRb6nJdEIxs77Samq0E2mzlw8Se5zPnoWuo6k63cbAcAk1i/SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ih6pnPPN; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a7VW2gjG; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ih6pnPPN";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a7VW2gjG"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mQFf296954;
	Tue, 23 Jun 2026 00:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=IIT/s238uM7wWJ0IerYUJmQe2CwHoUEqiuCn7Fzzl
	Sk=; b=ih6pnPPNYRvS9dl8H0Ime1YLgM94Q81UvXb9mKcQLPjJ5le37/d2q+vtG
	EPq5Ewyml1snTWMhVnc+os5QknxbN8QYzEgW+UDDUMJRbLDK3lrm4c2l9cR6dBTO
	kTVrjtnia8HGXJtbO3PonHKqHZ3Ivo9ufcZtxuuLRlH4ryJDx816j4ILSX+KqEtJ
	+5a/35ZMEugsrPKM1QhOA7FiAabewFnKSByptNPFcRui3tA68boSGRESQoY7kGHY
	VDTc/ZoZOHkZxLzSD1Kpic6rToYfGtbkALx6Ampdna3wUG7CbzrKWg3oP4ysoU5D
	4A/mD1Ic4aTjVMNMeVVwI13xQ8GIw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ey43bnbdr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 00:24:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRKjm+91LNMWITy8cxCHmAYLO3iIlARfzRLH1VoZ6WN6HnConZuYs8d1Ho0pvoMwVF8jCna05Wf9jtwQypCCezjGZmGLCTZ9TjtUNsNd8wO8OA1X2m/klTUdl0dJ2fmp8aEfEm8o5USRvw92t3T8/agqm58sDCzRNTDzqfNu6tUKIf3BnKEl+EhAifeowgdcX4SGzMvWLTKma8mkiBhVeZx8mGHsHw2rmf8R24eHFwkpx+ln79Cn3XGbNf+hbKaMTS7eNbajxpW05gc/8lgSFEDs1CtNu8y6b/QzFEcEPZjjIG7D1rspaD3zncNFsl4yFSCjlPVao26V+EeWG4hhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIT/s238uM7wWJ0IerYUJmQe2CwHoUEqiuCn7FzzlSk=;
 b=k/5L5rlkuYHRbIgA7r3BPjkOYiNaP9k6sSWiSODAG/E7p7g8pkY+i+cpC8CsisDOjA8xs0+Tuq20uZc77mxAs5YkguONmXKppZj2SAVWLVPZSHNaqtap2oaOMSCWwD9hgk+5yR/zNuVJElHHlUQjkai8vv4A66xTRTVNwmEvN26Jh0HTirYh4+m7vv36bf7S/zdHPGkVKqrdJFIVL423Jl+wvE38VsL45jYjsCZUqlORoCIwdgV5Ru0JfwMlw300Hg1Enad9sLtaHbAoWDdyNZlf5WjOBcX8rIRpO4LtfgCooKJP2q3JIoI0GQEPIQ1I7UhsqppcOav/MMKdyQ7m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIT/s238uM7wWJ0IerYUJmQe2CwHoUEqiuCn7FzzlSk=;
 b=a7VW2gjGefgPtWe29p2hYgAbXncRWDNhG33GZbr8kxzHXSR+9ZOyQlo3kCy1yOaJcNFG7tKtkyBGwa9yvnhPq34MshWDgg7yfYkrN5IriTnxU+eIk6V0QL5HS8gEd2elAFVFR4964dfWo+v2FJgaeglesqC1jG7BXzD/rsPcje4=
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:24:15 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::51) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Tue,
 23 Jun 2026 05:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 05:24:13 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 00:24:08 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 00:24:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 00:24:08 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N5Nmdr2138124;
	Tue, 23 Jun 2026 00:23:49 -0500
Message-ID: <1ad01870-e2f9-485c-9206-23ee6de1d1ba@ti.com>
Date: Tue, 23 Jun 2026 10:53:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mpillai@cadence.com>,
        <unicorn_wang@outlook.com>, <me@ziyao.cc>, <18255117159@163.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <danishanwar@ti.com>
References: <20260605071922.1724499-1-a-garg7@ti.com>
 <4lijgllolvtbvmzmluuslhkc7empdpizxhva6ysau7kssuqd5z@drkzb5afd4ba>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <4lijgllolvtbvmzmluuslhkc7empdpizxhva6ysau7kssuqd5z@drkzb5afd4ba>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ed7775-19cb-415c-d23e-08ded0e7a992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|32650700020|7416014|376014|22082099003|18002099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	j4XC5iOtwG8mxwKvWOU5Y1C/K/QXl5DEMDqG73a+UwpONHPed5qKLLtWleHwABxv8Kktpi6tGfZi1vtIGdJFrzfIqZm5frPdnVfAL8Y06jaSzQbBX0BHsaVF1HusaE3a6a1qAKOCZMyYORsbf1avKh6y13L4AeF+TEzUAB0fkKrsvWBx/4pyWP5m6dzCimM+3EcuORhxc5VAnSpJW/E0dNRGoxYw5+SzyaecTiUX71iJsCD1XEFaEzLjD6N31b2uXd8VUlJnnK+xi8ydpylixUp1fiJT7UvaL2NFn836t36zYOIKhMnfA46Gsn6FjgSD+TnkWUDO79IkmImxEy0qP7HDxMybpOjjY5aKltcsifDF6UbDEbrnrb8ct69/sHKCj4tdy7cm49SUd1AAE/kRfQwuztw6uQgwhyN4+aSPuRmGm0138jNyy/5CGKYsgT+nl8j3fsJfx/m6CJ3pjZi4uur3rjpbgdHe+6ewGrc7ZZ3s2B5iRwhHGeY0eQk7AtPEdjXmc7Vsj9Ss7qYaf0yz+MFY1bh/H+NHReBVgXmKtun/HCML9w4N37AJ2uHbK4pg1pEmQ84KvtOhI4sBK2y1m+MUKO9NPC97zK9kNF9EPGKvbQs4gWpYcqiz++xgbTD4qoa9/RJ4XGvUK2XMXdMr8E2RdNhIZRj4GCfHztAjuX/1wWmbIN+54JwldbgulDQetYGIzsVmodqFEkOGZPNg2Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(32650700020)(7416014)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AXRk+isodXEm7F2qmHgz/Y3ZCKvC8qlE1cVoJovYTIIlQnnYzY9rTmmirHdDZGJ+Vzykb7RhPgcer7MU/v9/gLU4Vw+4oTQkUMuQUTT0Fs7REpfYBbnRyZAu2E9IzJtc2Uz9JYIgI++xHKUyrDPW13MLdfZjku/L9QjYDDCOC6aO59QjMPiKDzZ7XAj0s7/W4U1mPKI+i6338xdsNKKAch4wQDu+M0I2gNFJcvWP9uIDSRoJ8uJfq6z9SKb9LqOnhUhysmdV91q2ppbJQHprCR/1A3RwyaMHHI5C4zAvadcJBYLBal1XpcLshkSUYQ5T8weA2A20bmJoyujJN+09pNa3uVsNeaXaFWF5Ti3p+9JooY+eRS5kj2EhfmsMotGfWkbHp9TIQ5ycNM2BTn3RFQv9U8o3W+0F3WshudaiP/iFDpaLID5VkXys3BSZbs2p
X-Exchange-RoutingPolicyChecked:
	KW+sECKuOblibZC7TiVPoX3ylB5MCljMW9QMTcjX4m6hghRqIx6mmlXstVLqAuzmSuvsmwo9vXLLaK5XGJXH7ftiAFqBc6dqih+fEdVOBq43dyu+lP+5MVyFBc9axq8kBg5e/V7baHtHMXZn31YsoZg6Vb7B0qMPMpQqCGpqX0rJVbPMDShaN7K3bUzTctwZ6ETKXZd/TXPATXkDk4Lawla1h6Jaqg7ywaoWIBy0WleL39ei8m+se+Vm3lXIO4LV7FjZOGkjPi3FwXWWZ8QEaa772Ibw5rOpc2ndqE8FLdK4JXMxWB8jkl9/rLMT6BD2mAkAq7HHxJrhjMAjFJGB8w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:24:13.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ed7775-19cb-415c-d23e-08ded0e7a992
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0MSBTYWx0ZWRfX71GEY/WFMzmQ
 XpZtU5ipBczghbayB0vGP+0FktsuN8K/0SKSxsyyvq1OVayAZg8Px6QL83tJ5Yb2GbPau3nH6S+
 6EGdWYrUCL2HcRi4775gmWNywIC1C0Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0MSBTYWx0ZWRfX5bVFY3gR722P
 +qxkAn2OQ2zn7jmiYKNwZ3IvX3Z5uJCd+r0TmkK1nxiPyvHqJKiIwND73C4/vVZuXW6ApN4Eoqr
 hBzU8kQSpTvVinmLgUqTKNIqInNlqFh4Vv7rOjYqF9w0YbFSDWrhqH5g2v5PAO8aso9GQba7ne7
 f14Im+1W+UI4QwFVahaRXPiTRdr/S+aMCBiJKIhLjE9Pbr+FfoTUfmB+GfQ1LwxjK9kkFqUTBZJ
 PPed+acE0qt1oQxs6e7noKeAaJ7Xr0S06i/TrzXNxh46pkwqR/BWKva8rWFybgDFKoa5qHCRzpp
 YaiVHWoSffYGJFzoVDsZnhKavzmbnO/2Ce06fgCnL9diSc+iHQ7S7QTxZe30uOcEjnIOhi2uicv
 6TJSLrupvlQ1hNDdERh1LeM9WeRw5NNj5ses1JDByKrgFDXOgdA75/In4wRFshEHix8VSXPLQbq
 seuVlQNyEHI6CanugWQ==
X-Authority-Analysis: v=2.4 cv=TPl1jVla c=1 sm=1 tr=0 ts=6a3a1883 cx=c_pps
 a=xsXPfmOQRNjzd7Jig0hzfA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=sozttTNsAAAA:8
 a=3CAaLWsximPUyNgftz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PTsghsYa9np-qmM80Pgf7kfSxWIclBNt
X-Proofpoint-GUID: PTsghsYa9np-qmM80Pgf7kfSxWIclBNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230041



On 22/06/26 20:22, Manivannan Sadhasivam wrote:
> On Fri, Jun 05, 2026 at 12:49:22PM +0530, Aksh Garg wrote:
>> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
>> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
>> during the resume operation blocks the resume operation unnecessarily for
>> ~1s even when no endpoint device is connected.
>>
>> Add skip_link_polling flag to track link state across suspend/resume
>> cycles. If link was down before suspend, skip the expensive polling
>> in resume since no endpoint was present.
>>
> 
> Won't you need the delay if a device gets plugged while the host was suspended?
> We had this same concern with the DWC drivers and we left the delay as-is as
> nothing prevents an user to connect a device when the host was suspended.

Yes, that is true. However, the platforms that do not support hot-plug 
can skip the delay during resume since no device could have been 
connected while suspended (only those platform's driver would be 
expected to set 'rc->skip_link_polling) just like what Tegra264 PCIe 
driver tries to do at [1], where the driver sets "pcie->link_up = false" 
if the link is down during the probe and if the controller doesn't 
support hot-plug.

Even if a user connects a device (when the host was suspended) to a 
platform which doesn't support hotplug, the user is expected to run a 
bus rescan, which doesn't call cdns_pcie_host_link_setup() anyway, hence 
the flag 'skip_link_polling' is not taken into account in that case.

[1]: 
https://lore.kernel.org/all/20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com/

> 
> - Mani
> 
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>   drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>>   drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>>   drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>>   4 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index bfdfe98d5aba..849eb8bb9e45 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>>   	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>>   
>>   	if (pcie->mode == PCI_MODE_RC) {
>> +		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
>> +
>> +		/* If link is down before suspend, skip polling in resume */
>> +		rc->skip_link_polling = !j721e_pcie_link_up(pcie->cdns_pcie);
>> +
>>   		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>>   		clk_disable_unprepare(pcie->refclk);
>>   	}
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> index 0f540bed58e8..d78c1282a5ee 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> @@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>>   		return ret;
>>   	}
>>   
>> +	if (rc->skip_link_polling)
>> +		return 0;
>> +
>>   	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>>   	if (ret)
>>   		dev_dbg(dev, "PCIe link never came up\n");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0bc9e6e90e0e..026414c21ee1 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>>   		return ret;
>>   	}
>>   
>> +	if (rc->skip_link_polling)
>> +		return 0;
>> +
>>   	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>>   	if (ret)
>>   		dev_dbg(dev, "PCIe link never came up\n");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 574e9cf4d003..01e49ecccc7b 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -117,6 +117,8 @@ struct cdns_pcie {
>>    * @no_inbound_map: Whether inbound mapping is supported
>>    * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
>>    * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
>> + * @skip_link_polling: Skip link polling in resume if link was down before
>> + *		       suspend, to avoid long delay in resume
>>    */
>>   struct cdns_pcie_rc {
>>   	struct cdns_pcie	pcie;
>> @@ -131,6 +133,7 @@ struct cdns_pcie_rc {
>>   	unsigned int            no_inbound_map:1;
>>   	unsigned int            quirk_broken_aspm_l0s:1;
>>   	unsigned int            quirk_broken_aspm_l1:1;
>> +	unsigned int		skip_link_polling:1;
>>   };
>>   
>>   /**
>> -- 
>> 2.34.1
>>
> 

