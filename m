Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408DC43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EB7208CB
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RYLdJJ7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDZQLX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:11:23 -0400
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:38227
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfDZQLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Apr 2019 12:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdpi7pLoONcNPTV6jRutzoAeKIvRTlbARxM38zuKx3Y=;
 b=RYLdJJ7/ngK4HJjmpE8YbC1B25/dvEZ2e8d+PfK5dcS0y74As2AbGSlbcZdQ2sHnce9Gehjs5FrRiReymxYSUgiFbPkjBkZUUpkFJj5SfbW0JzIW64cSn2YpIp+QSZcoO0X+cpyb2P0YPCnrXVwLHGuK2YS6wBq47QI6mpFGEc4=
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by CY4PR02MB2679.namprd02.prod.outlook.com (2603:10b6:903:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.14; Fri, 26 Apr
 2019 16:11:20 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.12 via Frontend
 Transport; Fri, 26 Apr 2019 16:11:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1792.25
 via Frontend Transport; Fri, 26 Apr 2019 16:11:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50312 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hK3RW-00062Q-Pz; Fri, 26 Apr 2019 09:11:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hK3RR-00029n-MO; Fri, 26 Apr 2019 09:11:13 -0700
Received: from [172.19.1.237]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hK3RO-00028s-Ai; Fri, 26 Apr 2019 09:11:10 -0700
Subject: Re: [Bug 203435] New: Xilinx pcie endpoint DMA not functional for
 ZynqMP PS AXI-PXI DMA endpoint
To:     <bjorn@helgaas.com>, <linux-pci@vger.kernel.org>
CC:     <dtyree@newagemicro.com>, Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
References: <bug-203435-193951@https.bugzilla.kernel.org/>
 <CABhMZUV2bSHUeZErR8=AQrBvuJHeKEMfQJbGTVRgcxZcXp6i2g@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <38d59480-3057-9352-677e-a365ad526990@xilinx.com>
Date:   Fri, 26 Apr 2019 09:11:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABhMZUV2bSHUeZErR8=AQrBvuJHeKEMfQJbGTVRgcxZcXp6i2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(189003)(81156014)(81166006)(4326008)(476003)(31686004)(8676002)(8936002)(336012)(2616005)(6246003)(486006)(2486003)(77096007)(26005)(229853002)(126002)(65826007)(230700001)(23676004)(9786002)(2906002)(11346002)(36386004)(76176011)(446003)(63266004)(44832011)(50466002)(356004)(4744005)(14444005)(64126003)(426003)(36756003)(31696002)(110136005)(70206006)(54906003)(5660300002)(47776003)(70586007)(305945005)(316002)(106002)(65956001)(58126008)(186003)(478600001)(65806001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2679;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38bd2b3-11ec-463e-5db4-08d6ca61d179
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CY4PR02MB2679;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2679:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2679ABFA170531A4DACC4BFEC63E0@CY4PR02MB2679.namprd02.prod.outlook.com>
X-Forefront-PRVS: 001968DD50
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vWyXMIaUFuJ8j3Xf/2bOEYSYJDboJJAz1oPxN3/wXMsSaCmcYCfQIgShHvigakiz5inj4eq0I9uBACyy98x6Lgb3yDY4v3Qu5v65cr50Q7z7ZBwps7IAeCe7HfZLKe+iQswwzA3st7WlidtUmoUhHWMNNu52Y/Xh6teA+ByB/D/fAzesaIHLpNpsCumTDHaIqHwRUj1Z2e/Tjobqbks3Z2CqhEfywD6ovRzw4nffZN+Iam5NZFMZ4JWIx1X7Cxo61ITMrdhPcokyXwT/WUNlLq+Jh4Dxc0YnlEpmzDcfkyZ3YM72BSEDOiyyZqVuMdGg1sO8rG4wuS/0CnQuEMwTFlRyEtD6+yYJZuRODOjWv921lFkOWNZsLuYX4tcd3zT1Yjjcgj5pXTanL/w2kVSY/e9RquA1jAbDwV+a+raVpEE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2019 16:11:19.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38bd2b3-11ec-463e-5db4-08d6ca61d179
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2679
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 26. 04. 19 6:21, Bjorn Helgaas wrote:
> [+cc linux-pci, Xilinx and DMA engine folks]
> 
> I'm not sure what to do with this report.  It mentions "vivado" and
> xilinx_ps_pcie_platform.c, neither of which seems to be in mainline or
> linux-next.  A Google search suggests that Vivado is a Xilinx product;
> maybe this bug report should be directed there?

vivado is xilinx design tool for programmable logic and soc setup.

And this driver is not in mainline but just in xilinx git tree.
It means you can simply close this.
And author should contact Xilinx via forums or via git@xilinx.com if
there is any issue with this driver.

Thanks,
Michal
