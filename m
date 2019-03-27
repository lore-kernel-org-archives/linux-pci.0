Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0985C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C12206C0
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 17:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="VHAfts1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfC0RRn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:17:43 -0400
Received: from mail-eopbgr90053.outbound.protection.outlook.com ([40.107.9.53]:61520
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfC0RRn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 13:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggt2jDzPGUhcGamveXfCVTIM88RdqMc6+zSW/PuE51I=;
 b=VHAfts1MyKiYc5V5HdQfVhVzmwsyh5s7mznWA+ZHtvJIskO9rOqEcWqJ6Sedut4frBxf/L+xqy/GPdPWwP/C/qTrJo2cTnBi9JKePMX4czX5jk6sH571cRdhr7KNwJybu6Mgk9TpJU7MGWzBEvl1vaXCmupP6RgSCvVO7OSV3oU=
Received: from DB8PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:10:100::34)
 by PR1PR06MB4907.eurprd06.prod.outlook.com (2603:10a6:102:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.19; Wed, 27 Mar
 2019 17:17:39 +0000
Received: from HE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::203) by DB8PR06CA0021.outlook.office365.com
 (2603:10a6:10:100::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Wed, 27 Mar 2019 17:17:38 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT056.mail.protection.outlook.com (10.152.11.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.9 via Frontend Transport; Wed, 27 Mar 2019 17:17:38 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 27 Mar
 2019 18:17:18 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.439.0;
 Wed, 27 Mar 2019 18:17:20 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-x86_64@vger.kernel.org>
Reply-To: <federico.vaga@cern.ch>
Subject: Device Description for FPGA Components on x86 system
Date:   Wed, 27 Mar 2019 18:17:18 +0100
Message-ID: <1629227.alSmCsHHUc@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR06MB4907;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09cc0d6-d779-4533-ba8c-08d6b2d81ced
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(5565046)(2017052603328)(7153060)(7193020);SRVR:PR1PR06MB4907;
X-MS-TrafficTypeDiagnostic: PR1PR06MB4907:
X-Microsoft-Antispam-PRVS: <PR1PR06MB490713623AD87F472BDA1770EF580@PR1PR06MB4907.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0989A7979C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nWo+B0PgKMZ3aPvTxL6G9E3tbxQHP2AgNk21pDgSD1AUHDkjsNPRdASpipLl7tynDFnhVEaUyGW2gQJc0dGF/eeb2iRafhgsgtMwSid04Z7FS8eoShhWKrvmrJJXC0ig/aFjw70ytPJr3Wz/2VWnXedxE4359kdV1Bjd5vV4ps0JhfJ3iWydUQHoMpAtE8UJR5MnpF+SZhOiQuDnJz7OCj7tAYMXGh1zBTy+Fb/kSz5nuxUFL72x/uciafZozwhOze5ecgSzs5OdXhzTSdZOYskP8KDn1I/nkCAxosStEA8U/gFyT8zF508s2j6ZV0OkjwITpAI+F2cbNKwQ1/HrnjHb3b+YycaB8e7g0CqADoB09nqbRnJmhsQgnjX6B11KBaO7c4cKoffv8umB+dG2ntm1KyhuOmbj0wVZmOBPc4WmqcgnMJuqkqVvuyMNTdTsEXqRsBu8PJEJgjQ4/a3XtbfoAl9AbUubfeBqNRNr73otMTVI4R11Av/eBz43bDmy5D/nb57EbVsVaeNbWq6SKNKtKDpoTfL40JSiAAwlP24=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2019 17:17:38.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f09cc0d6-d779-4533-ba8c-08d6b2d81ced
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4907
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I'm looking for guidance

What I have:
* Intel x86_64 computer
* PCIe card with FPGA on it

What I want to achieve:
* load an FPGA bitstream on the card
* load a device-tree like description for the FPGA devices contained in the 
bitstream

This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but I'm 
puzzled about the x86_64 use-case. I'm not able to find recent and clear 
information.

Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay? Or with 
the DT?

thanks 




