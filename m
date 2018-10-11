Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E8C67802
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE04213A2
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZlCZTCjU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="J3arEbIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE04213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeJKXnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:43:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41014 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729586AbeJKXnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 19:43:47 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGDUaV012872;
        Thu, 11 Oct 2018 09:15:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=3JCdEAsiCak0T6HcNvBiRiIkZ243+JCSZDRwwDNopVc=;
 b=ZlCZTCjU+VzB0GxBz6q4aWN9qnuyv4XVVNEirI1AMp81dbyql2u+8g7iH8M/zo6zBN/0
 2PMj8n4FiAw9+3b9b27mrsu1juoTyK6Tuoecy5Pfkhmw1s7n5W4JsO6RcdlGN0GUcUCC
 np2VIRTtXHyhAjISP/iu0IH87utrYuzYkyutXk8QQLvbPUOouG7JY3HrmKvlHATtScda
 gYvUPFfOcGIunH7o0Dd8sDwah8weycuB1bUfyzU8dbRQw0AxdnI749nGM+m+YHLPzN9B
 FXjOfa8s2nQ0PyVDchzZnJExXio3r+5V2JLAbhNNqb8P5cxyJpnDlis1WjT8Rj/UL+kG YQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0119.outbound.protection.outlook.com [216.32.180.119])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2n156fhmg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Oct 2018 09:15:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JCdEAsiCak0T6HcNvBiRiIkZ243+JCSZDRwwDNopVc=;
 b=J3arEbICiLW1wo42JCejdQY7ux3ATT4yhMF6c3Yv9o5ufpGIjFzuoIhDD7mpVggeFGVNJsB5hzg4FO4lHqcTcPQmBV1LA4wR+b+BUIh827Nmym9DW9sIbNJksRLdNlUumzLho3rFuqp5mA4xuqBCyO4TzTFv3LEKnrPFNNMC8bQ=
Received: from BYAPR07CA0012.namprd07.prod.outlook.com (2603:10b6:a02:bc::25)
 by SN1PR0701MB1837.namprd07.prod.outlook.com (2a01:111:e400:517c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Thu, 11 Oct
 2018 16:15:40 +0000
Received: from DM3NAM05FT028.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BYAPR07CA0012.outlook.office365.com
 (2603:10b6:a02:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.14 via Frontend
 Transport; Thu, 11 Oct 2018 16:15:40 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT028.mail.protection.outlook.com (10.152.98.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Thu, 11 Oct 2018 16:15:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGFbxq031266
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:15:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 11 Oct 2018 18:15:22 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Oct 2018 18:15:22 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGFClM031214;
        Thu, 11 Oct 2018 17:15:12 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9BGF5o8031045;
        Thu, 11 Oct 2018 17:15:05 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v4 0/4] Fixes for cadence EP driver
Date:   Thu, 11 Oct 2018 17:15:03 +0100
Message-ID: <1539274503-30876-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(36092001)(189003)(199004)(48376002)(426003)(50466002)(6916009)(16586007)(476003)(2616005)(5660300001)(4326008)(42186006)(8676002)(51416003)(26826003)(86362001)(478600001)(316002)(26005)(14444005)(8936002)(87636003)(486006)(186003)(126002)(2351001)(107886003)(36756003)(305945005)(7636002)(106466001)(105596002)(54906003)(47776003)(50226002)(2906002)(246002)(336012)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0701MB1837;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT028;1:xoVhSv35Zqopg6CUIiQBEeoIOk561FEH0Vt3Qu87ekNUvaKmOqAwDV0dN2oB1bfkiK9Kw/P4YB2FRM98JBmNlbRxbVgmxMZ4uRYO2n+THc88yXPNb86VC0suIhjIx9r+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf468d86-c433-49fb-993a-08d62f94c99e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR0701MB1837;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1837;3:3OOjDAvWKe4bHUoayaKt5NeuwdvBpfD6XljnCUPxn4RwO4NodYV55QWwKtSO1nzcAYsPW3wgHuVNTLbAZNKTAQG398+cLWhDwGeD0GKB9Vpj1f2ezksgN9gMjv8tvl/JeUqCRKvGygkUhQqwX2Ys8wD+YJzhwcLD7urp57wl6ldR6G/eh5W3tHD7pqG1TIg8DMsAf2UCnQKv3H34vK2PCwEDc0bjBvYhIqp8+O7PBXt4u3sfRxIkq78yzxD3QdU504BpAU8JnGv8J3nnb3MfLA5SQmLCYnzOsTaYWns/dgwNWEOov0Rs9rm/E9Z7HRelkeAYbplA+rayi3ZH+5QhMXdinzNAW+5riPUiNwddxdc=;25:IHcnd5eOiJDWIzk4QL01pcO5JPDyJJjNiZmnxzSReErfKCFjGXQumbA8w8fpB3zo6H5vxeWrB0tEmY1UYmfQh7sFNS4OIk6lFg4VDUSoRdwHP2VqrI4myIanP/Lf8Gg4iE5VoGWHOi7qXVbYMph8ZEge7EZOYldUE5UPLFQzuMQt5B1hLhzu240F7UbUMaRo1mJG314HxdFgqqsOhmS1uJdPB51C+J0aYb5AFTqmZFRo7QoS8fK/5jK3LmlCw2J9HSoYXXiefcnCXw0FvJcVshK17lqhTs4B8iHJQTFvoQ7lKhJoa0VN3BNNgnJ2stzwiKqNHm5nSRMw6EnCZQg1gljzoybefziWy0kITGWZMPA=
X-MS-TrafficTypeDiagnostic: SN1PR0701MB1837:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1837;31:TuPqU5HKOOcMxEIkGT/xnmro5nhTyDHz7blHktxZlRTuBa9//4iiu6dqYlv2WA3V+FEmYQMESZIOm4W+m88A+URYrxddE423hZD1xKDdlAMwOmQsACTycXDnueGOCg44uXAQ+Y9fzL3v4XWyyuYH3ijPVt0gI6v7JVhlDdzWJx9beDkwSgLx7OBYKwo8NhNpuJML4EhYrGGHxRA/P3dvgGf/SbfG3Td0P+aNBnOSXwc=;20:U8vrwn8Lz+MUsB5seW6kIIp27eIKrJLFrsmKDtqF/tbKah2YuHZrANcR4xgCechqUowj6NcOV80d4C1mcgrSMA/0jK01G0TSUETGnf/s+bbOa5Q/jMbdhGVgts3jFFwtuZbpQ1WeeINfBz1oi35SRZvAwNydjfhA+VLsnrOZRoadSO+TiqBXjpdp0trm/nBOqp1yKZqFwFFzcF/cxB6Bq3R8/Io6l5Z9rnSbt54fWp1vj/jMFbq1eb8j3R7mK+vVtb323oScj3rFoNsuvb+KADQ27OahAoBzMuuG/zv+BgPxsQjUvw8+H1duWXgAGBNw2iEzqkpSLV4bcbjydjsCEsi18v/nrAUPEbzIOKiXkyxXmGC0lLjw++0IWjdlr9ZN/JQEmspRK32fc4jGKhtXtoMN169TKTFzOo02yOfCeXutGgSlmeKVbfWOcbMbfXjMHB6rPvj2ja2BFbVZKNFNPAmJMjWkjQlpvz7vsVnJWYu2YMDNvqo+btHSmhsklF04
X-Microsoft-Antispam-PRVS: <SN1PR0701MB183721AEA057B48D7289BCC3D8E10@SN1PR0701MB1837.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN1PR0701MB1837;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0701MB1837;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1837;4:qWwlCAVNCi1FmwvDtLCivcj7/fIdDLadiVsgbZyRQjcQHql6W4APgPmHeYkz4T5J7AuRudCwvBuKrpUMOvToTeCXxTHVI886QD0ypCYe2gnuhnb3BloNHGBIpto18HGdI1ZJX4YJ1RdlogneTiBcoDGSoQceGkDhGhJ9KNFV/7DRO1sbt9w6h01hI/pP8LPf6mXvfM1HSKyCdgCHVYK+Tom91gylFyTZGrBYSE3OKHIaeqUCCTyns6TpMJ9T7i5gfXAFeREQlQZ3WezCubgTDg==
X-Forefront-PRVS: 08220FA8D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0701MB1837;23:3MUPzck2wQL9unTG7rX3Qvezedu/VijSxYgyIMp?=
 =?us-ascii?Q?csuJ/+BDSryYIxibNb0MU+I3ffCa1nHa3yXjR560YmpcGhAnLByYx/YiLG63?=
 =?us-ascii?Q?AWc4IkVMlW7LuS9WALSkKd/XnfD996u+n1chK5ua0YP46IngA89js7QgU/nh?=
 =?us-ascii?Q?0esQuAM0TOgceFQlAksvfvkAzxKAvn3oQA5WbUQFiHGU3pj4B80L5eue93a/?=
 =?us-ascii?Q?S4RSx5+7Up/BfLojNMHrIbF65ef/DJQWkN7tMYFmYiGKW4ynk6pPEcnsXDJU?=
 =?us-ascii?Q?42XVsbiamrnlPZOhjwxjWfDjZPuVFGK8ziOx4HmPwuDhG4C08n922rreezuB?=
 =?us-ascii?Q?D4SGHNMNwOhzHHWppYa9iSUJUpADTplivFw4R6PY4w05oRZws8JB7pOT0XdX?=
 =?us-ascii?Q?MTxfWN1s4Pf5m8Qj+F3i7El9/rYTnYBIOCyt39NngawOzhis2QT/36sI+qsG?=
 =?us-ascii?Q?IdGihZ21qaJ4fwOAFcimnhzhTCeXNg3TNkZccpqXz3DSiw1mzi75yILpUD+f?=
 =?us-ascii?Q?hsFgn/T5L37ZRYHfAguZQatPrKFdmwk/W+QRDd6JWzl4Zt88S58uQpFg8MZz?=
 =?us-ascii?Q?MQxNJkbUrP17s20mUKH3dUsLeRpLUAq/n/wfhu96x2q0FlF3rO8lpUKf7BcT?=
 =?us-ascii?Q?JhCUCM+cYBpLUPsoIRAAbiedIxY8BCyZJ3QCLKICtA8Ir/Tsv8Ho9LVpt6Mg?=
 =?us-ascii?Q?HV9Bpp7Yyd24UrhyF95YReaoqk2zV8SIFh3pFtYGj0Yzei83ifmS5r1I1xks?=
 =?us-ascii?Q?J/zs7tVsGA9bLmEZhSoDwtKnkYz/VpaPpWTOH9fGkt8YPttrbdAjE5RXgxYC?=
 =?us-ascii?Q?nNg6AEq74je4w4UYxrP2ztZP5upM3zA/ve/Ewd993R42tZOjVzvs2BuoXX02?=
 =?us-ascii?Q?YqHGKm1svaq7TTPg54Fm7jsGDuQrAZQs8tyGt0QrPsplHS0sa2BLwTz6DVKq?=
 =?us-ascii?Q?Eb60ikcbQPesJB532fTUVZDJzskFie2+FOEYTviBcIyESYtsa1GbUyMOPIgj?=
 =?us-ascii?Q?sqLq0jqC9K58nw3dB+DukPFAz4kl+Y+SFT3yuoivDsduShQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8ZmQHuYzAW1c35T8ADZpCFqBeP31mBI875bOAVpLt01w9t0qOOqiU+6DDpotbTjiJPSg/ViGJV9QMkWbHfSulXI1Wh2qXf9kAveZsgMVcTaK3bQkPznW3+uGmggSL+vWQRKz3MD2mwrR99tCQbV/43dKqwY+SFbjzdfQVHmhAGL1NUJ1qCAlUMWuGnwd+NfRG95P+TjbUDZr4wvzu/+k7bnA5FUTjNKHCtabjOhDAuYSBO1aVn4f6yE1yVtBw4PoeihiBRR/ksWGrGB0BmVI43Ma3AxpRVeynrB2EbIvHhDOw2HaZZrY9e0GedPhIoYtv8dsV/iH++btnLWxc98be/mg0h+CJFIsx6dmu269iniBK6usPQ1nwof9I9xNu+6WBZGLzQLPg88fVViQAkE8OQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1837;6:QCEJtp7KEvC+AkFLpuyMu3Tcn1XgnfnEnbZQQEKu70jKzFqsirS/WrB0+LFVztOmyNnr3j9ShXZ9oEZvmIZb+wF9DHHQ6O6Mm8XmHXmJ3Z12m0ufFIk3TqkuF6GvQlit8yJdD8A1KZDe450XHTn0W5JW2JVpgK5PPylVcLoZ/Hzalu3s4t0B9KP6NzC8lx86aqLK0MUvTgrD4tPt85NX4jVLxFAMc4tc9vLYlYRqQgozu2lUHbjjSzMKCTHFMVxdanhVqGcQptpdhmxPJqBPA/KAceGqAQnoCLbiepLh/BJC8NDaNlC4bf1aIfSrBWkbHwv9SlQ6C1K46buiw7dydgaMV0lpuNXIv8AHFwaKx0bZ374Y62RTWutuoiVvsbALdUJVD1N1yeGmXSf5KkCLazz5X8FNJRPX397flZOm98OGjdVvomWZmcBwnfficYXSpTHH24vUSm7OaedPQ5Cvuw==;5:Mi/vWwji6qbQWns1Wul8DW9HmbuMWLibGyRlBhbop9ElDssemJfAZdnSgsDim54umjahAGN7+a83jHKSL1f3o2z7Y33ckROllqb0YC35sKzql8pIQTwiDHksSfsgWr1vvoZ1SstM23ozRMVA5afkdSh9LdsWAGVL6D8h1wq63SA=;7:kOvJHXiT987PZACuNaX0oGJjbC8b6Fe13J2e8VEFF1OGYrJpDfpal6ovWYEnG+TqwEpLKPqiN2UQXDmXPN/evvmfeMoTqKhcx15a2yJdHWeGfgFd5VqWaDg3lcaxktNpKAGBEpQcnnBIOLEA1bstm5CEKi+H40sx1ODBTJ0uaec4+UGXwYA/uhuhRTjCy4f57WM/xPKuwB8qa05mTjMcApsMDPoQ5eSjemNxdHnCc1ck2jcBtndEzQTl9ZcZR2BX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0701MB1837;20:6Sc/qAY5NgY85lTGIU5NLOEJvGIamhVQSaN0UsJqe4zq5w0IzT6TIcVypE40JJqLvp98ef6lZ7d6TMv6+Wkp/F8yibGVlmTeRZvhyfVycPc7+eUrKZavwUFwu1CAXsS82eNvZCzaBXinSy8hzGP4sH0bx/BCwBnw1kgs4oi67TdABryMD0FiR7A5/LTeBsV1u5ZTDbPg8jQZk0RYup7LmLnf5ZVUx65YFSQSn+6fp/R1BRgSuCgrrtz9Lrac9uaz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 16:15:40.0189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf468d86-c433-49fb-993a-08d62f94c99e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0701MB1837
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=271 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These patches were previously in the patch series:
  "Add MSI-X support for cadence EP driver"

They add fixes for MSI issues discovered during testing of MSI-X
  - Use AXI region 0 for interrupt signalling
  - Write MSI with 32bit value rather than 16bit
  - Check for masking before sending MSI
  - Check link is up before sending IRQ

Changes since v3:
  - Rebase on Lorenzo's pci/cadence branch

Changes since v2:
  - None

Changes since v1:
  - Rebased on 4.18-rc1
  - Update commit log to mark first 4 patches as fixes
  - Correct formatting issues pointed out by checkpatch --strict


Alan Douglas (4):
  PCI: cadence: Use AXI region 0 to signal interrupts from EP
  PCI: cadence: Write MSI data with 32bits
  PCI: cadence: Check whether MSI is masked before sending it
  PCI: cadence: Check link is up before sending IRQ from EP

 drivers/pci/controller/pcie-cadence-ep.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
1.9.0

