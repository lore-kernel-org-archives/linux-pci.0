Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3650DC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E384B2083E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 15:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Tjl5gpPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfDJPOE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:14:04 -0400
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:45511
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732908AbfDJPOD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 11:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7EtTtBV1Hn50AaXA78pW6N2in8l1szT+DfC13o/yTE=;
 b=Tjl5gpPAbYs7UBesx6KEu486I2OPMICOEdSe3eZP4lb8VGw3D43HM8Ms+tI6IwaAi3RJxKryd3Clts6YadJMrS4FUplagEgo8brHGWAGvUAA7bAxHJur+5Ydlyeo6U4ChAgmhdllS8/ncbLUL6GhR5M4JwF+yvCBVvjXYP/X15A=
Received: from AM5PR0601CA0026.eurprd06.prod.outlook.com
 (2603:10a6:203:68::12) by DB7PR06MB5813.eurprd06.prod.outlook.com
 (2603:10a6:10:58::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.13; Wed, 10 Apr
 2019 15:13:58 +0000
Received: from VE1EUR02FT032.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::208) by AM5PR0601CA0026.outlook.office365.com
 (2603:10a6:203:68::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Wed, 10 Apr 2019 15:13:58 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT032.mail.protection.outlook.com (10.152.12.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Wed, 10 Apr 2019 15:13:57 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 10 Apr
 2019 17:13:31 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.439.0;
 Wed, 10 Apr 2019 17:13:34 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Eric Schwarz <eas@sw-optimization.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, <linux-x86_64@vger.kernel.org>,
        <linux-fpga-owner@vger.kernel.org>
Subject: Re: Device Description for FPGA Components on x86 system
Date:   Wed, 10 Apr 2019 17:13:32 +0200
Message-ID: <2706675.qmhD4SUPsn@pcbe13614>
In-Reply-To: <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
References: <1629227.alSmCsHHUc@pcbe13614> <31100498.IIhqzTXyFT@pcbe13614> <CANk1AXSQCFGE94R8ZxVSF2Gp+diCHJhFJPSVSx+iEyWp2URcpw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB5813;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ce44d3-7e9e-4613-0fdc-08d6bdc727b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(5565046)(2017052603328)(7193020);SRVR:DB7PR06MB5813;
X-MS-TrafficTypeDiagnostic: DB7PR06MB5813:
X-MS-Exchange-PUrlCount: 7
X-Microsoft-Antispam-PRVS: <DB7PR06MB581384D441485137553F3CAEEF2E0@DB7PR06MB5813.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: izymWfnRuvmC7cxu3RWGoNXnA9wwOPhZTjGHIXxlAJgb2JM3EFCAXTqCV6lQfLiQRuWG6hmjr7b+w5ImqjuG/mJ6vGfJvXdJAoBdUmIycEc3rcsYUoZSd8eUswL/d5SUOOJUbpR8XaCzJb5DHbrbGyU/OJAGE29Ii06WsBJFJiYKnU+KbZfDBi5pG7cXApc6j2zMgWPjUH/FZmt6yTNVAs7F2hDz2audDg2WnE8FSIXcq0o1g3OlfldeEY95sjEJ7QPsS4M09MajAPYOrCc7gZ0OVWzJC2Ul6IgYuOzzvJ3F8ihJgLKjPkahC7rbECVCI5eN1AwVQBwCLVKTsSbd6YC64Wslgu0kOhALfbcWEsvHXNfd7ps3XLpyHBtL82A3k8d7f1bapWXdC4FE3ceZNWelvZX1qCD5gtuGMmecSNO2TGvXKNydFmOHjiZ+GUr+UZbIglnz/x+tCvDyqBxSWr+bhu99d+iEbrL3DM7Ef9eW5a6JwJU+CI1qhTDqiEP6zCntNyjb0auh6876qFLGDGxWtV/iwO7cGJJ36dj/tcw=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 15:13:57.8893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ce44d3-7e9e-4613-0fdc-08d6bdc727b0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5813
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alan,

thanks for your answer

On Wednesday, April 10, 2019 4:21:09 PM CEST Alan Tull wrote:
> On Wed, Apr 10, 2019 at 7:50 AM Federico Vaga <federico.vaga@cern.ch> wrote:
> 
> Hi Federico,
> 
> I wish I could point you to a complete solution, but there is a lot of
> work to be done in this area.  Most of what is in the kernel is a low
> level in-kernel API [4].  As you correctly state, the hardest part of
> this is doing the enumerating if you are on x86 and aren't using
> devicetree.
> 
> > Hi,
> > 
> > P.S. sorry if I'm too verbose, hopefully it is useful
> > 
> > thanks for the answer
> > 
> > On Wednesday, April 10, 2019 12:30:14 PM CEST Eric Schwarz wrote:
> > > Hi,
> > > 
> > > everything you want is already available and on the way to mainline
> > > concerning support for various FPGA loading modes or available for
> > > checkout from a git repository.
> > > All that has already been discussed on the mailing list.
> > > 
> > > FPGA loading interface is available here [1].
> > > Patchset missing for FPGA loading has been sent to the mailing list from
> > > Anatolij Gustschin for various Linux kernel versions. Link to the most
> > > recent patchset version [2].
> > > FPGA Manager mailing list archive link [3] - Please read up the story
> > > here around those patches and also the replies of the others.
> > 
> > This does not answer the problem, which perhaps need to be clarified.
> > 
> > Loading FPGA is **not** the problem, I listed it in the things I want to
> > achieve because it is a pre-requirement for the real problem and because
> > the two processes are linked (or could be).
> > 
> > I continue by commenting myself below, trying to make the use case
> > clearer.
> > 
> > > Cheers
> > > Eric
> > > 
> > > [1] https://github.com/vdsao/fpga-cfg
> > > [2] https://marc.info/?l=linux-fpga&m=155078072107199&w=2
> > > [3] https://marc.info/?l=linux-fpga
> > > 
> > > Am 10.04.2019 12:01, schrieb Federico Vaga:
> > > > Hello,
> > > > 
> > > > sorry to push for an answer but I do not want to take the risk of
> > > > designing
> > > > something useless. I do not know how should I interpret a no-answer.
> > > > 
> > > > If the solution really does not exist today, then I would like to
> > > > collect
> > > > opinions/arguments/requirements on the topic so that I can write
> > > > something
> > > > useful not only for CERN but for the entire community.
> > > > 
> > > > Thank you
> > > > 
> > > > On Wednesday, March 27, 2019 6:17:18 PM CEST Federico Vaga wrote:
> > > >> Hello,
> > > >> 
> > > >> I'm looking for guidance
> > > >> 
> > > >> What I have:
> > > >> * Intel x86_64 computer
> > > >> * PCIe card with FPGA on it
> > > >> 
> > > >> What I want to achieve:
> > > >> * load an FPGA bitstream on the card
> > > >> * load a device-tree like description for the FPGA devices contained
> > > >> in the bitstream
> > 
> > Let me first elaborate on my knowledge to avoid misunderstandings.
> > 
> > On ARM, nowadays, we boot with a device tree. Later we program an FPGA in
> > which there are other devices described by a device tree overlay. This can
> > be done easily.
> > 
> > A typical PC (x86/x86_64) does not boot with DeviceTree (it is possible,
> > but it is not common and probably not even suggested, not sure), instead
> > it uses ACPI.
> 
> I have heard it suggested that we work on using DT overlays on x86*.
> It's clear there's work to be done to make that work.  I don't know if
> anybody has really tried.  It seems impractical to map or translate a
> x86 systems ACPI into a DT and go from there.  


> One suggestion a few
> years ago was adding a partial DT that had nodes that could serve as
> overlay targets and have that running in parallel with ACPI.

This is also one of my ideas for a solution to our problems. Are you able to 
easily retrieve that conversation? Perhaps this is something on which I can 
work on.

> > The FPGA Manager has support only for DeviceTree (there are patching
> > floating around to load a bitstream with configfs, debugfs or a
> > chardevice (guilty))
> There's one other interface in the kernel upstream. The DFL (device
> feature list) framework built on the FPGA manager/bridge/region stuff
> [5].   It's probably not what you specifically are looking for, I'm
> mentioning as it exists in upstream.  It has a limited type of
> enumeration and appears to mostly be geared for acceleration rather
> than adding and enumerating any random hardware block.  Also it
> requires specific bitstreams as the feature list is in fpga fabric.
> 
> > Most drivers foresee a DeviceTree loading but not an ACPI one (my feeling,
> > I did not extract exact numbers from the sources)
> > 
> > DeviceTree overlay requires that the system boots with DeviceTree.
> > 
> > DeviceTree and ACPI do not work together
> > 
> > So, this is the state of art that I am aware of. Correct me if, and where,
> > I am wrong.
> > 
> > 
> > Restarting from this point. I have a PC (x86_64) with a PCIe FPGA card
> > (e.g. sis8160, spec, links below). How to load the FPGA bitstream (not
> > really a problem as you correctly pointed out) **and** load all the
> > IP-core instances in that FPGA bitstream so that drivers will start
> > running?
> > 
> > - Is there a recommendation for such use case?
> > - ACPI SSDT overlay?
> > - DT overlay?
> > - is there a standard way to load FPGA IP-core devices which is
> > architecture independent?
> > 
> > A simple and practical example. The i2c-ocore.c is a platform_driver for
> > an
> > HDL I2C Master from open cores. I synthesize it and then load it on the
> > FPGA. How to create the Linux platform_device instance to driver that
> > IP-core? How to do that when you have also IRQ controller(s), DMA
> > engine(s), EEPROM(s) and other devices?
> > 
> > The fastest solution is to do what was common on ARM systems: having all
> > platform devices declared (hard coded) in a file and load them. Which is
> > not a good solution, for the same reasons why arm stuff moved to
> > devicetree.
> > 
> > Is it clearer?
> > 
> > I do not know if it important to highlight but those cards are extensible,
> > potentially any FMC module could be plugged and this needs a different
> > FPGA, with different FPGA devices etc. So, It is not possible to hardcode
> > the description of all possible FPGA code (infinite) that can enable the
> > usage of all possible FMC module (not infinite, but definitively grater
> > than 1)
> > 
> > 
> > https://www.struck.de/sis8160.html
> > https://ohwr.org/project/spec/wikis/home
> > 
> > > >> This is achievable on ARM with DeviceTree, overlay-dt, fpga-mgr; but
> > > >> I'm
> > > >> puzzled about the x86_64 use-case. I'm not able to find recent and
> > > >> clear
> > > >> information.
> > > >> 
> > > >> Does anyone know if this is doable? Perhaps with ACPI SSDTs overlay?
> > > >> Or with
> > > >> the DT?
> > > >> 
> > > >> thanks
> 
> Thanks,
> Alan
> 
> [4] https://www.kernel.org/doc/html/latest/driver-api/fpga/index.html
> [5] https://github.com/torvalds/linux/blob/master/Documentation/fpga/dfl.txt




