Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B850EC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC582133D
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 12:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="KpTA8OA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfDJMud (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:50:33 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:33934
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbfDJMud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 08:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZbykvsrqheIkadTmTfQpah9ybucsfUeIOL7muFKAwo=;
 b=KpTA8OA+evlL1msbxAbiNwkCYLKw+2P0KS4v+5UBGxwOLYzZ2gC1SbzpS9vfQn15KjTHyJpNYQBvBzkEn3dK6cyXdJfsCKwyPC/ZFYnSBMMCJbD5b1aGtGBYBvqjxbaNwyUfvcKLNHl7f4+2d/cEX5lKZYw/QCEwx09VS57e/94=
Received: from AM6PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:20b:14::36)
 by DB7PR06MB5499.eurprd06.prod.outlook.com (2603:10a6:10:37::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.21; Wed, 10 Apr
 2019 12:50:24 +0000
Received: from HE1EUR02FT029.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e05::201) by AM6PR06CA0023.outlook.office365.com
 (2603:10a6:20b:14::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Wed, 10 Apr 2019 12:50:24 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; sw-optimization.com; dkim=none (message not signed)
 header.d=none;sw-optimization.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 HE1EUR02FT029.mail.protection.outlook.com (10.152.10.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 10 Apr 2019 12:50:23 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 10 Apr
 2019 14:50:04 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.439.0;
 Wed, 10 Apr 2019 14:50:05 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Eric Schwarz <eas@sw-optimization.com>
Reply-To: <federico.vaga@cern.ch>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-x86_64@vger.kernel.org>, <linux-fpga-owner@vger.kernel.org>
Subject: Re: Device Description for FPGA Components on x86 system
Date:   Wed, 10 Apr 2019 14:50:05 +0200
Message-ID: <31100498.IIhqzTXyFT@pcbe13614>
In-Reply-To: <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
References: <1629227.alSmCsHHUc@pcbe13614> <6563205.xRkLC0driV@pcbe13614> <dae0b7ba500cc03fab23956eac85ca79@sw-optimization.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(51914003)(3450700001)(74482002)(7636002)(786003)(97756001)(76176011)(246002)(6116002)(9576002)(316002)(53546011)(305945005)(86362001)(7736002)(5660300002)(230700001)(229853002)(54906003)(14444005)(8676002)(23726003)(8936002)(106002)(43066004)(478600001)(186003)(16526019)(966005)(4326008)(44832011)(33716001)(126002)(26005)(11346002)(6246003)(446003)(356004)(336012)(2906002)(486006)(476003)(50466002)(426003)(47776003)(6916009)(9686003)(6306002)(46406003)(106466001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB5499;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0ce196-13b2-4740-8d10-08d6bdb3195a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DB7PR06MB5499;
X-MS-TrafficTypeDiagnostic: DB7PR06MB5499:
X-MS-Exchange-PUrlCount: 5
X-Microsoft-Antispam-PRVS: <DB7PR06MB54992BB2D4E22D813A151D53EF2E0@DB7PR06MB5499.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JnluyWqDTsEne8hVhb/Z021nVHwzdOT94i4oKFqlpoN8EgFqvpliWw+QB/dJOIEqum+C+IQhSgmkgNXxADyfcUoNt4jq/zaK5554gfbCsNDceUN1jmtut2CvRCho4dYv40GJ4chVJ4i65ouzQpm+TKsOmq1YjdhacqgsNUA+pMxlOSpy6ymWAVjas2Xy03wt01ak/HWRXisfPx5BYjLp1myqFgNzrCM0TUzzbetOoumtt4GghnpplKEOjIttSSEhK9y+Dqv6PT1qPGPoCwzCcLxprODAPxTsagr28qSCZIEBNQxZHJxif4vyhQCBJ25Q5bHEnFpx6Gr57sEMPrVt/6NHD9m3GyxCabiRXYSirONm+q9H7XHo8wTaRaL6nn7HqM3JETmb19RsErFt9FTetOumVbbVRSCxqHj2fy5bDfQ=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 12:50:23.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0ce196-13b2-4740-8d10-08d6bdb3195a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5499
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

P.S. sorry if I'm too verbose, hopefully it is useful

thanks for the answer

On Wednesday, April 10, 2019 12:30:14 PM CEST Eric Schwarz wrote:
> Hi,
> 
> everything you want is already available and on the way to mainline
> concerning support for various FPGA loading modes or available for
> checkout from a git repository.
> All that has already been discussed on the mailing list.
> 
> FPGA loading interface is available here [1].
> Patchset missing for FPGA loading has been sent to the mailing list from
> Anatolij Gustschin for various Linux kernel versions. Link to the most
> recent patchset version [2].
> FPGA Manager mailing list archive link [3] - Please read up the story
> here around those patches and also the replies of the others.

This does not answer the problem, which perhaps need to be clarified.

Loading FPGA is **not** the problem, I listed it in the things I want to 
achieve because it is a pre-requirement for the real problem and because the 
two processes are linked (or could be).

I continue by commenting myself below, trying to make the use case clearer.

> 
> Cheers
> Eric
> 
> [1] https://github.com/vdsao/fpga-cfg
> [2] https://marc.info/?l=linux-fpga&m=155078072107199&w=2
> [3] https://marc.info/?l=linux-fpga
> 
> Am 10.04.2019 12:01, schrieb Federico Vaga:
> > Hello,
> > 
> > sorry to push for an answer but I do not want to take the risk of
> > designing
> > something useless. I do not know how should I interpret a no-answer.
> > 
> > If the solution really does not exist today, then I would like to
> > collect
> > opinions/arguments/requirements on the topic so that I can write
> > something
> > useful not only for CERN but for the entire community.
> > 
> > Thank you
> > 
> > On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> >> Hello,
> >> 
> >> I'm looking for guidance
> >> 
> >> What I have:
> >> * Intel x86_64 computer
> >> * PCIe card with FPGA on it
> >> 
> >> What I want to achieve:
> >> * load an FPGA bitstream on the card
> >> * load a device-tree like description for the FPGA devices contained
> >> in the bitstream

Let me first elaborate on my knowledge to avoid misunderstandings.

On ARM, nowadays, we boot with a device tree. Later we program an FPGA in 
which there are other devices described by a device tree overlay. This can be 
done easily.

A typical PC (x86/x86_64) does not boot with DeviceTree (it is possible, but 
it is not common and probably not even suggested, not sure), instead it uses 
ACPI.

The FPGA Manager has support only for DeviceTree (there are patching floating 
around to load a bitstream with configfs, debugfs or a chardevice (guilty))

Most drivers foresee a DeviceTree loading but not an ACPI one (my feeling, I 
did not extract exact numbers from the sources)

DeviceTree overlay requires that the system boots with DeviceTree.

DeviceTree and ACPI do not work together

So, this is the state of art that I am aware of. Correct me if, and where, I 
am wrong.


Restarting from this point. I have a PC (x86_64) with a PCIe FPGA card (e.g. 
sis8160, spec, links below). How to load the FPGA bitstream (not really a 
problem as you correctly pointed out) **and** load all the IP-core instances 
in that FPGA bitstream so that drivers will start running?

- Is there a recommendation for such use case?
- ACPI SSDT overlay? 
- DT overlay?
- is there a standard way to load FPGA IP-core devices which is architecture 
independent?

A simple and practical example. The i2c-ocore.c is a platform_driver for an 
HDL I2C Master from open cores. I synthesize it and then load it on the FPGA. 
How to create the Linux platform_device instance to driver that IP-core? How 
to do that when you have also IRQ controller(s), DMA engine(s), EEPROM(s) and 
other devices?

The fastest solution is to do what was common on ARM systems: having all 
platform devices declared (hard coded) in a file and load them. Which is not a 
good solution, for the same reasons why arm stuff moved to devicetree.

Is it clearer?

I do not know if it important to highlight but those cards are extensible, 
potentially any FMC module could be plugged and this needs a different FPGA, 
with different FPGA devices etc. So, It is not possible to hardcode the 
description of all possible FPGA code (infinite) that can enable the usage of 
all possible FMC module (not infinite, but definitively grater than 1)


https://www.struck.de/sis8160.html
https://ohwr.org/project/spec/wikis/home


> >> 
> >> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but
> >> I'm
> >> puzzled about the x86_64 use-case. I'm not able to find recent and
> >> clear
> >> information.
> >> 
> >> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay?
> >> Or with
> >> the DT?
> >> 
> >> thanks




