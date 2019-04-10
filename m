Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E702C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021C420850
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="E1UPmo46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfDJKCB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:02:01 -0400
Received: from mail-eopbgr90080.outbound.protection.outlook.com ([40.107.9.80]:6496
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbfDJKCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 06:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64yUALrxoopsmzcfG/gwhMqj2N85S+Pbmt6ZeCyeKLU=;
 b=E1UPmo46Yl51xkTuomfaIg5jZojyYepYMgHQ9KYbkpniHFNppGNyAsgeR+BhnJx48MzpyYYu6HRMbBGKeLoMqtY/wQfp4LRVsU9IeTqlmjQxx1N2rzEwdGhN3lHirOtOc5OjeMROl+UdJ4kGIUq8+MlmZNZI6mMrvZQuH7MZs3s=
Received: from DB6PR0601CA0027.eurprd06.prod.outlook.com (2603:10a6:4:17::13)
 by PR1PR06MB5819.eurprd06.prod.outlook.com (2603:10a6:102:10::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.16; Wed, 10 Apr
 2019 10:01:56 +0000
Received: from HE1EUR02FT059.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::204) by DB6PR0601CA0027.outlook.office365.com
 (2603:10a6:4:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.14 via Frontend
 Transport; Wed, 10 Apr 2019 10:01:56 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT059.mail.protection.outlook.com (10.152.11.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 10 Apr 2019 10:01:55 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 10 Apr
 2019 12:01:33 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.439.0;
 Wed, 10 Apr 2019 12:01:34 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <federico.vaga@cern.ch>, Federico Vaga <federico.vaga@cern.ch>
Reply-To: <federico.vaga@cern.ch>, <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-x86_64@vger.kernel.org>
Subject: Re: Device Description for FPGA Components on x86 system
Date:   Wed, 10 Apr 2019 12:01:33 +0200
Message-ID: <6563205.xRkLC0driV@pcbe13614>
In-Reply-To: <1629227.alSmCsHHUc@pcbe13614>
References: <1629227.alSmCsHHUc@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(8676002)(26005)(43066004)(14444005)(46406003)(229853002)(86362001)(450100002)(5660300002)(356004)(33716001)(426003)(446003)(11346002)(16526019)(47776003)(106002)(97756001)(106466001)(2906002)(126002)(50466002)(246002)(336012)(186003)(476003)(4326008)(230700001)(486006)(44832011)(9576002)(4744005)(53546011)(110136005)(8936002)(76176011)(54906003)(305945005)(23726003)(6116002)(316002)(786003)(7636002)(7736002)(74482002)(478600001)(9686003)(6246003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR06MB5819;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db8c963-e606-47d0-3632-08d6bd9b9045
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:PR1PR06MB5819;
X-MS-TrafficTypeDiagnostic: PR1PR06MB5819:
X-Microsoft-Antispam-PRVS: <PR1PR06MB58198F4D0A839FBAF201D729EF2E0@PR1PR06MB5819.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tMcrTDunBBL63KUwygc3lcGvLMZAzsDOI1O5lPm/ccOtM0tL65+0CCgRyGlllzWemwUTWsymvDSoVSg2nLt1uwTKMxAkOjmQxPhLTkwrwCbttPDcHVPp6h+JVVLi3Vnvzy2HMM1uiuQeHwD71n8ZFm8Sq/emkpFjc9aREV4fmNEhVhFq1034Z7LX7WrKgs2Dh62WM182nW9XpUZDaf/etuASTb9POQb0k7CEKkY2In3xUBWZMn2asRh7EktbTMsFPIEl8VweHxaJdf7GBo3ex0oj/8VOItUiwyWrHv516xCiH0GMKe0TDDl+nZ7G2O8s/APricgV07dhFpNQ04yWX53vqv71sBKuWElhteAcoMTzHhL+Eto9oV1IY0qi/c5r2myw6eZbN7OeBFMHiOIC7fVE9QFJFc8wONVOKDNpgYU=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 10:01:55.4596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db8c963-e606-47d0-3632-08d6bd9b9045
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5819
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

sorry to push for an answer but I do not want to take the risk of designing 
something useless. I do not know how should I interpret a no-answer.

If the solution really does not exist today, then I would like to collect 
opinions/arguments/requirements on the topic so that I can write something 
useful not only for CERN but for the entire community.

Thank you

On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> Hello,
> 
> I'm looking for guidance
> 
> What I have:
> * Intel x86_64 computer
> * PCIe card with FPGA on it
> 
> What I want to achieve:
> * load an FPGA bitstream on the card
> * load a device-tree like description for the FPGA devices contained in the
> bitstream
> 
> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but I'm
> puzzled about the x86_64 use-case. I'm not able to find recent and clear
> information.
> 
> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay? Or with
> the DT?
> 
> thanks





