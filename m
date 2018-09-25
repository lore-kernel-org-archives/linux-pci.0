Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF7DC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7198320843
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 06:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Yl+Dm+aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeIYM1C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:27:02 -0400
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:11344
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeIYM1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 08:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5BW6Kacb6l0R6i2sQGjslyr4XDrM93C4BLkB00bIUM=;
 b=Yl+Dm+aOaDBLjXpHbSg8vF7RDPghEAWhlCH+IgHLVRR/Flr0AX1dAA2FMr/GZdMSrzsnPkelyD5DRhDqfikGe1CV/K17eSkL8hhpxLx2J3iQ2HQSe7oYGjy+17o8gLxJ63l+ZTqOd5S0c/AKPySya9JMVt7KgzBHAH2xWHAxG04=
Received: from BYAPR02CA0005.namprd02.prod.outlook.com (2603:10b6:a02:ee::18)
 by BYAPR02MB4760.namprd02.prod.outlook.com (2603:10b6:a03:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Tue, 25 Sep
 2018 06:21:00 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0005.outlook.office365.com
 (2603:10b6:a02:ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 06:21:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 06:20:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g4giR-0005RK-6I; Mon, 24 Sep 2018 23:20:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g4giM-0007AM-2H; Mon, 24 Sep 2018 23:20:54 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8P6KniW027610;
        Mon, 24 Sep 2018 23:20:49 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g4giG-00078Q-TL; Mon, 24 Sep 2018 23:20:49 -0700
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180829183440.13601-1-robh@kernel.org>
 <20180921092930.GA20641@e107981-ln.cambridge.arm.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c850f535-3704-35e3-a67b-064351b041df@xilinx.com>
Date:   Tue, 25 Sep 2018 08:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921092930.GA20641@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(438002)(3190300001)(199004)(189003)(23676004)(65826007)(186003)(5660300001)(2486003)(47776003)(64126003)(65806001)(230700001)(8936002)(6666003)(65956001)(229853002)(26005)(77096007)(50466002)(76176011)(106002)(53546011)(426003)(36756003)(6246003)(126002)(446003)(316002)(9786002)(63266004)(2616005)(11346002)(58126008)(476003)(31696002)(54906003)(44832011)(486006)(356003)(81156014)(81166006)(478600001)(106466001)(2906002)(305945005)(110136005)(31686004)(8676002)(336012)(4326008)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4760;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT032;1:IMvdFlFPK3QiGriz7y7hwDlpXbmDK5Wdrw6GESsKc3Zb3QtTC4B/t1uYF4na2raarAtK/cnNndnUZTA6UY8RzTbN+isYSpVJWI2GbihRbdozNwlnXtx2MknLPUjyCPPe
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a37c9382-4294-4054-f8b1-08d622af0fdf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;3:zAoHdZs0y57sPTH25qcqnE7UamCcoEMOJPMKtpa+hKaqjgouEjm5znvSK+wj4DsP/zq7Wnv4uPtJiC1UNhhl85GDdg7/hMJ1PaG9KBUE/A8Fo7BGf1bvzfwVMCefrwgIQbpmspjqILm0FTK8Vn7Ziqm+4QxJm+AElzv/MZfVvQH7vEuNchWrEpeSgUzh/BaJS4NAvYShDk9Jo6/dCNShlsTRMZcvywBUQT2U1OAA9Uoxgg0GpP5h1+JG2Y86RCKLRq1MyTyPci8tRgKTau3ZwQK4/RyS4W/rpoCSe4S5G5++hhf8/OhU5ZYDmNRLBHBs49LcXxzZG+xy01rGk7qR6x3nSdrdHb8mqFublCrMjyg=;25:DV878SU4lHWX/ibO4RJGCNFptPZdX9jWyVzHNsFWugf3r7Z5UxV50II/IKiIMTwuRBQzYWhedihCV5elOO8C5aq/Td+tlyiMAnrmOqCQX4MnPoBlBx9RXEEBAdKE/ojFpAMNLtvTodAkLOQ3by+6f8vmOVi2If6sRcOZisbG5kyZzAm7Y6pQh3WkKjYpFh02HzUte8k0ahRz+L6o5gcWH6JqHl8CjI5+KCN4uJyg0okLp18hqEyciEqxdFDCUhBPt9oFx3388G/0nR24ZhRZtU9hw0EVZA5fYnRwwxAxxk0BbzDMXFLPNxr8OK7QD5T+8ZzPzqNwGLNqj1yne0LvUw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4760:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;31:HWHxcoqOW/8Ry7UqO57RhpoAEqmNU2NrX0WSPuR6OtPFSZIP9GmHfuX+WOKm8+k9HmIv9PvIIrVB7cQky7QRu+PYnU1pLpV1l1qNcOonOtTB5uQV7bHBp9+92MBo2KyazGiRYXvRbLRC4ep6O3VYRJJc/DG9MrRAfLlowqFiSR3JpETLzPDUBxWBcfrf6OfGlI6calQlGIFgqt6yyANg+JhGC+YxwZECsa+2B+IMWQY=;20:/scWpsfnUQJurtBUqgiq2ygI2wHMWlJ0vlXUGzeo2VNDjz4VIJtGHz4vQNs0Wj6JQV+TnJXzCsV13mYj3ZS8LXYoLPqwAueeNjPLqg+mkKTAxowpEPlkI0a0Iv8Opt0s8tWw4w2N1+UtkblEP77LeW7/lf7AGEZaf66ZiWXqxB3OzjKQ43HeRxz/HP7+sBTuQmcadtzpB5UrRm0pzWYIieYeyQZwQkfn+H5FFnSTyPnMNcz2p4cNt+8B7shkCLwl3RcdRCouSnBz/ESFHQvkctt3D0Brqu28w1XhcBO/E791gHT3pE1m+emIIGUpW/Qi9ncQoVreetqBkvC05dfLOcUKgxhOf+orhgAW0QXurWPf9Lb73cLUdOTXTMBO9VSfJ2DiiDMN0BxIhjYuLCVieNbXukzAS8mTmXC6STVDqeo+d49oP/PDY2aFUgz9dZsqgZmIMaf6eGCGoPIJHasr7WEvvNZjUdRD0DfhnU1wQEMzLTwQv6H5Qd3Y2eEdnUNJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4760A7728916F772C14E0CDCC6160@BYAPR02MB4760.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(211936372134217)(153496737603132)(72806322054110)(192813158149592)(9452136761055)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR02MB4760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;4:Y1JcN3KZtSbN8YpUQ19iqqdA8srtyuy93tJGSUCPzpYtIQYuUBbXiZvTYDNx9f0mgZVSZL9AmAolNIKxhfTP1i76nuH45/eh9PD+GxuOE+Ls5Ai0aRPEkwtNJ+tg54dcWyPFQ9bSaJV9qjCXs98KKnH/GVMARC40jnod+bTkAGMhTYC+WJClxfI76Ac/2dTJhdmm55kHgycbRfmvthd7g4zSwkTiD6CSaRUXe/pULHiua8hTeqSvSrIwUz+3QkSbV17OGQzHBV4WHTTyChq7+JcNz0aCIQIbIyR8y0sqbyHx6S33ws2SD7w+SzwECS7Pr6Q8Vye1HTJN+Sd1hD6YHVgkKhavnu3ZYmFQviEu4rMulK2ZZMseCZwx2fsZBPoSASnbFUClgiLgRg5sObL60zbshSH7Djofo4r50VP6dLT6ymuUOvICjRDkKNlrz0hDNpniUpmqDIavcmPnAOqFnR8u8QJ0Urbt+UxKBBFqFFpSlyDOGv2TQq6VeBRFMgZaW8hADAW7ACSj2BcCoLobcA==
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NzYwOzIzOmQ5ZVBVT3o1ZENwckhrTi9XK1YvejE2d3Nj?=
 =?utf-8?B?WFZoV2wraXplREs3SnpYdS9YZDdNakFKcWVoaGtHMjZCK3BqRW9PVktqOXBJ?=
 =?utf-8?B?enErcjIzRGtEcjRBNWhpbk54LzhuRGxrbzByZUlEa3RCRHd1K3llM2tRb2Zl?=
 =?utf-8?B?K0RhSU50a2J0ZlJNOHlKTWV0YUZGSGRlT05sU0lUZ05yUXNjZ01KT3JMQURL?=
 =?utf-8?B?dGpnd3hQU3orY3NTVUN5RUg5Ulg1cUpYcDBuMEh6Tm9DUTF4bGVONEJSSDJO?=
 =?utf-8?B?dWMyK1gxV25jUG15U1poUGlmRHUwaVdvME5lN0RpWWZqWmFKZjdRTVZxK1lY?=
 =?utf-8?B?Z0VvMmtHdE44MXRKNFpEOXpwVFBzd292TWc0dUdEdUdsNHNxNlI3SEpCb0JG?=
 =?utf-8?B?TGt1RlFkWHpRTmFPZ01GZTNjM1RGbGFVUG1YUDk2K0ZKS2Fjemt4d0psWXlU?=
 =?utf-8?B?UFQ3emNmTmhaRUVEMXBmdk5BSUVRalpDYlZyRnp6eDhvVDVlYSt5ZXZtY2hK?=
 =?utf-8?B?MCtDSE9vdEtGUFZPR3hEZmVxMS9wcm94ZVJFZGpQN1VzVWhubUVFZnlLTUt2?=
 =?utf-8?B?amtRRSs3dmFFa2wyWkgxVVRLbnppejBMRTQ1bE8rTFZWZlNEV0xDekZieEZV?=
 =?utf-8?B?YWpKMkthdWZvcHpBaklVb3VhNmR0WTgzd0xwWTBhN2huQ1BSMjlEWUpCMXZ5?=
 =?utf-8?B?c0pYc3NpVXF4L3ZkcVVxeFBscDF5NFV4QkxIeHc1MXRrR0VRRUo0SE4vL2ZM?=
 =?utf-8?B?eFJScWNmS0lVWDI5cXNHbUlwbUd5Rm91ajZFK09KcFJnRlExWWF6NzFjUkda?=
 =?utf-8?B?RXBmS01lQ2FwZ2ZYQStLM0wvVFhaOHkxUGRoc2JyK0RJUnBXMXNRSmFwQnZw?=
 =?utf-8?B?SjBYNEhDRTd1NWg0Y29pKzFuMUw2K21Ba2tJQ3FLeUZIWjF2T3lJbkF2dE1t?=
 =?utf-8?B?ZFpuUWU3Y2RVVnFxcXUwRG9CRmZSRWlrWXN1bzBXeUNTckRZU2pPSXdzMmFG?=
 =?utf-8?B?dTJLb3E2VlRnVjBHYWZXdjA5c0hQc0V1UTBNMDUyS1VIaGVQaXAydWhpeTVY?=
 =?utf-8?B?MnZWQXczdnQ2QnN5VDd2YzhQMnlXYStueHBDMG5XS0ZoOHp2cTB5K0dlODZE?=
 =?utf-8?B?VDVaNE5xcE1sMVVLK25kZGJMWStjMTRqUW5xMThxNEpxdzR1eXlkMHNtclBm?=
 =?utf-8?B?WWp0N2IrVUQ5bVRYRnJubVVtUTJ4eUxFR1NKL1hTS1JmblY4aGZhRmxOb3ZQ?=
 =?utf-8?B?VXE1WVNUYW5WQ1NtZXorTmM5QTFWMER6Z3hjYWhnak1uYitleVZoUnA3RTRT?=
 =?utf-8?B?MnEyUDNFZ0owL0RoUXJVaWUyM0dxMUJhRk95YVlLY3VCUDNsaitsTktGck9X?=
 =?utf-8?B?NzFlV1ExQVRyTlk4eUVxNlpNcFlHdDhvVEhlRGJIRnI0dFJ1dmF1VlJLc0pP?=
 =?utf-8?B?eStFRW5zbEJSQWVEeUltWTgyNTVPL09GZ3hEdUNDdmJEd0Q0RnZEOFNkaEg1?=
 =?utf-8?B?alprRVV3eERJNzZjZzFVNThTNjJYWkxWSS9nOXpFcnBjN3V0RXRoNHVEWFNH?=
 =?utf-8?B?aGRXV3ZkWFQxOWc4dTJuMVBFdXNsMkVNYmN6dXJGT1dDMTZxQ2YxeURGdWFm?=
 =?utf-8?B?dnBFTjJ4amEyU29ncGRPTTk4bnVFRWRld0pZakxybGtTOTU3dUZEdnNMVmdV?=
 =?utf-8?B?R0VRdVl3cE51cVlFcndTL29qVFNzYkZnZGdtQzN3enJIa1Z2bFlrWVVVTzBE?=
 =?utf-8?B?OEJUcjIyRE5wUzc1SXhXZz09?=
X-Microsoft-Antispam-Message-Info: F69Xx2cNlPbz5n8mB8C/W96Xm0xt8HcVJjiwWR7SVynBnBgSITCvRWYFFKk0jRwBgFFh9SEVXtcVfDWXOA38J7kIlmsL1wvx8pNPrp6fq1/0vK1hOWVMvVSbtsqiGiPucNJzLKi0ciNtyHgCGs7b4r/oHevEwVrdiEP6FoQ3pprO758exLheqNAk05bXegNvNwOH8Ip4IEdp8SKle2dkOExVFELLgJv88Mgm1gGxbGuCSWWPXHP57YDoi1VAn/+n9dawYGNz69/ymg8oB4kYCAQzHaDn4gTlRU4Ojjs2YyBVPzLTZCuTQsEj/aSrPx90t35DU9vjeSAX/6gwYl3XwhdYbbFYXFut5g4HtQuzoCQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;6:eC/FNvbYNXRPjCtzXAUx22otcj2axRefsSr8yUNvu+HykV113qPniYf/13lgXxY+GOvcVX8dv1WXwgJ79tk1TE69X0cncyPmmYJAfP4FVLMqUKeCf2opqQNZrkB5kdGzCFPikBL91mA+kjzxmVSh5kSMoUNlTQDnoOUQj6iLQ2IwXwCWLyrGAaIc7T216P0fnmw4+DSwF6BeN4PVgR6XNG/R/ne5NP7EpF2grUy7PjVq4g/ePAgtpXyuzvca7NNoPzvTwLL7fjRN2CuluTxaFMnbnXUcBtcI4Nof/iBbmFNGj2wKgbHBbrYb4Ce6942q5M5MgiF+A2cLy5KPkR7xYrCfkqza78vo9Ujh+110XQZbrneucDl/S9KZhBgcXSdcHm7cNvFkSac3pF6j5qjmdVCXVuHCsbSvm6vviLdrk4waU1R7vLzizVe329Uv3r2hkiI3HNHAWlOjUF1Vwsq7Tg==;5:b/nYSYJ98rKW9KoiT9tGbqzs1Z2jzBnnhRpoS5XkAEMhhzX22TMvtw49LHX4kqaZYgShHs19T3Jwqx/a5nQAQFbNAqqODkbhBJYAwN6qfNt52yMJvWCXnBJRnsO31wp77cgaWwt+Dbo7cLNr76Ryioikap0smuTSL07rS/pTpZE=;7:nI/Gw1TpA60wBg9HEVlAPWFGAGPapdcZI9YSVI6hNWaseJP+uowJHPJVAfUE5LFiD1n6zbQfeX5uQY+JFMiMAOhuMcesADJJGYkeJrDK3XrNwL+50biUqa5hAiw0l11B9t1ia06ZRcFEpdf3/rJXPr7fU1ZAO2kFNbrvvFvEqNXZrG9090vnDFvBQXfuw4vPvCFo2EYiGnOhhSlaZqIJuVyl071KsMaVWCdF9w8w8dQNWrm9QXF4P9tLsQW5/vgl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 06:20:59.5773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c9382-4294-4054-f8b1-08d622af0fdf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4760
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 21.9.2018 11:29, Lorenzo Pieralisi wrote:
> On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
>> PCI host drivers have already matched on compatible strings, so checking
>> device_type is redundant. Also, device_type is considered deprecated for
>> FDT though we've still been requiring it for PCI hosts as it is useful
>> for finding PCI buses.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Alan Douglas <adouglas@cadence.com>
>> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/pci/controller/pci-host-common.c   | 8 --------
>>  drivers/pci/controller/pcie-cadence-host.c | 7 -------
>>  drivers/pci/controller/pcie-mobiveil.c     | 7 -------
>>  drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
>>  drivers/pci/controller/pcie-xilinx.c       | 7 -------
>>  5 files changed, 38 deletions(-)
> 
> Hi Michal,
> 
> are you OK with these changes ?


This change is fine.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
