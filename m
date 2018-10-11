Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCBC677FF
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328202085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="P5rGolHv";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SVPsOqed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328202085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeJKXpK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:45:10 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41590 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbeJKXpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 19:45:10 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGDV6w012875;
        Thu, 11 Oct 2018 09:17:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ULjH+o7v2qLfCEDLFrt2x29GI6ZHtRFyETH3SqqNqsg=;
 b=P5rGolHvE7e+Hj62Zd100Wl1j5vu5xwbpMgFrviZAkOz+Rp4UmmhF7NE+wKa+t1dhNGh
 5hrpL3VpsN3gFwfpfkSMJGsX+Ufsj42NKslqSXFgsM+0Fqb3xVFY8RtuhnRsPSCAa5h5
 diBuvpyWkfNHNWhN76mcD6puSvrI4Zfr+4yvB3QwlRtI+g/4VJCNjXD1l6eZjixwjQbg
 t7G85UWI8s+waiJ3wMfBKG7gEoiSlp2dFBJNaFGb4DkOSYQh9ktr5wKF+K3KxGCMgzpm
 yHdqc5HgrwLauwsHXOQE1sgvq8vEg21Nm95Oa56iaFm9erU9NOQV8w+e07lRCt3+UFCm 7A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0184.outbound.protection.outlook.com [216.32.180.184])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2n156fhmp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Oct 2018 09:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULjH+o7v2qLfCEDLFrt2x29GI6ZHtRFyETH3SqqNqsg=;
 b=SVPsOqed0nCKfV7aUQG+WzeMX+lRI9ZuLbI6iZ6cIc15ZdW/dxpW8Q0ehlCnn8J7M5ps9wsI6wMM6EnoWLfuKHy4OMe6Oibf0dmsyL+3XiByGwV9u9ArcWiLRAm9dka5B68TQvIqhgDeBKT5Dw6valwq7LiSY69J4bUrwLRMn68=
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by BLUPR07MB692.namprd07.prod.outlook.com (2a01:111:e400:8a0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Thu, 11 Oct
 2018 16:17:03 +0000
Received: from CO1NAM05FT029.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.15 via Frontend
 Transport; Thu, 11 Oct 2018 16:17:02 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT029.mail.protection.outlook.com (10.152.96.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Thu, 11 Oct 2018 16:17:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGGxiF029100
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:17:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 11 Oct 2018 18:17:05 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Oct 2018 18:17:05 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGGxt4001745;
        Thu, 11 Oct 2018 17:16:59 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9BGGwYa001741;
        Thu, 11 Oct 2018 17:16:58 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v4 4/4] PCI: cadence: Check link is up before sending IRQ from EP
Date:   Thu, 11 Oct 2018 17:16:57 +0100
Message-ID: <1539274617-1661-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(36092001)(199004)(189003)(4326008)(478600001)(87636003)(86362001)(54906003)(476003)(50466002)(126002)(2906002)(336012)(36756003)(26005)(356004)(186003)(47776003)(48376002)(26826003)(426003)(2616005)(486006)(51416003)(105596002)(305945005)(7636002)(16586007)(316002)(106466001)(2351001)(246002)(107886003)(42186006)(6916009)(5660300001)(8676002)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB692;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT029;1:W871CluzlNhalKzqz8GfcaGiJjsSSIf+feKzGsQP+prTxUMQkM2NMi+eL3lUrLELg12noYt4PwPLgjS9+tMTHr6216veisDwKyIbF0MUTQ7/nNR23kdRxzOM5tFgRiFD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee8aee3-02e0-4f2a-9375-08d62f94fa97
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BLUPR07MB692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB692;3:aOE+u3EX0Tk7IRAqnko9C0cyh2cdiWNnijmSbOxKzHLtwc27Bqo/vXCqE6bCTo73HH/1LfVdu8Gz6PWtiBsYF4KIYQAWjUxnvNoeLml68iECRsG+Urmq8UcEBTkpfOQWXZ9VHlf6Rt5gpHB7rV3W0D5TqUw61/Bqf3ugRmq6fytJgAOdd2mCl+VKP6OEwgZxSiyZOzn1vhyJBZqbyOadAWaPS+W07+jmPTV/MGqQKSH/UccJTqBIayZmh1MUM4Oab3hnmU8H4IPURon4VvOiTrkwXL46uuHPu1j4EhUFYyB5mm8zK33+ppA6uyJJiI7bvM6/BdreZRWcczoxZ6f0i8jHGQrfWL/R5upAHezE/Uw=;25:rNnCA5EsuyxcN9+nVFPpJG8z3MkXqxbdufZoP90H7aLEkGbN8Yrs5fbkih9jR04cSvldhsnDe2tUkjsEHcw/5UFbUE66zREgK//jeu3yFGgbUZF8smXf+ghHi6N8iJNulg3+cKdCtZmkioNiYyDQe27KYuV6VbK3Pfgsl9NGZjn9q3Pylwqgqjh7pSZ4otujzaVxjyLeKqzHKiTzjYzU5M7Ih6MzMawEdHgqssfZ9kJNO+TYz6wim1a4wabwKnS2Rsh11zO2vKUS6tUQezZ7jyuZCGtbtd0sWPzo/VB7xQ9woc7mAl2T9WSgafmOW0SgD70t8nMragLwNE9lUixEZQ==
X-MS-TrafficTypeDiagnostic: BLUPR07MB692:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB692;31:Wgant1PijK/FE/OFlKc/UqG3FipKUS9eNxR/VN5P8pJl52w8LIXawM9lHUPKI1N4+8WZZRGWl6IV/c8pv4ImKKgjVjnw+E2wEBNl67CSLVopQ5vGgyYez+fVAx+oD6k2RVf5jSRUZM4SQNVhXP++GsOX6c2v8pT/k5PzNc4eyTUTV5XyhhtQX2KXkwScXBvg1bEs2uVbY9jxelCl3qxqbQlAGvg6VKNPak7yAt8cDQ4=;20:Pl9ezcXn5DBZJfL9EYGi6xLKzqbZTNr9MZVdxMDZDyDesHQ8Yhc52S94YcqAolH4FmTqnbUs5imRpbS1jMU71d5n3dX9PQ8tgk3XHXnhogVhvR5jwIUAJguW/+N9yCh3plAOZEoh8nGO5vzFPlUsfQvXfOWGXRnPQjAtH1HgJZszQjZ4+ej2SZuY98vC+zq73UpdKSOfjYQM6rA360GDm/c70SeTJPBKV+jbvjLRypNtEaXBhr2KfLGpJTGjWbyjpgU8Ns0y759OWCS+GAnWyBeeHRZxPmTZsKxfOTFUsKEVwwgwkIoUzI5koF6PrW869hQAoHfoU++Fm3LdmaMWb/5pbQWrqmc4l8btOtaEBWGxdNK4qh2smO0vMzKyB+8dGxiREzBVmdpzHsWD4fmf4lRuIfnHErxBAPmQ9uDHtcRdZq9YhPdjxBPIhXJcGDmi5EEVBeWJrWqfSNxbwBVYmrDVgPMZoaiD2UFYiW2OfIjZeOXvZQPOSl8ZYiEXsh3e
X-Microsoft-Antispam-PRVS: <BLUPR07MB69200F263D3E7469EE58812D8E10@BLUPR07MB692.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR07MB692;BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB692;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB692;4:t/woUMWT04NwMDuxk4zBvDOFkUhIOEQ4/kFIydtWYeCtDLoyLtGiX+oRc52z22Zj+LRZWPSh5lEXj54cJXc38ymuxbxq7ajQVNFpv3r1tR0wTqsjns3gKN357wfZFid69Ndk+Uraz0JNyYT6w9GoXuHL81ym4pTqZQb+NWOR2ts+NxwnjnZHZ+9dC6Tjf5bu19hPaDWPv8Ox6txuFIfr8w4TKttil9BcEoCqbdauYTQ+G8DnPqwu2nO3XWV5q89k68Z8pmkMZ4bQXs4dkUG0lyTi5V07qPFzwZOcSst+TwA7y6kfV0z/UJef57uXQ2cD
X-Forefront-PRVS: 08220FA8D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR07MB692;23:k5y78K5WvmRzUK5M1VGHxb/UuDdcPHB2u7xKWhxYnN?=
 =?us-ascii?Q?lZnmElEAYTAeUnqS20pealBPyzfLX9G1wpaAfpyznKMsuRLu9Dqey+ti/58G?=
 =?us-ascii?Q?5ztxlU/JmchCmReCrqey3dXmpasB65wAM8gT0Acq6MRgwHB2CVuYGyz9uLZ1?=
 =?us-ascii?Q?+kZdHrusMcNTP/jDF+xjBW6o1Jl5F1V+Q0LquqLrVusgVgbJugK86TTuzY/S?=
 =?us-ascii?Q?3psVWHzkx1hPe2Rl08sidCunMHEmle2Va1i11S/db4Cb+lg+z7Klnu4IovF8?=
 =?us-ascii?Q?Kvl6B0LHkJslrz+B/F8ffAG+yzlZ70IRL9rBX0bl62YAOJoHeDNdLBNi2Hcb?=
 =?us-ascii?Q?WhCIvtOIapJZwwUK1+VGhXB6xsbsdfFhgDNc6+xkEugVSfdziyP1ubKgKlfL?=
 =?us-ascii?Q?kHW+osAj3/1hy+1qW5daFSN9xDNiBdTX6GxUADySx7T00dyMHBQtLfOZPsJs?=
 =?us-ascii?Q?fWFmF/fu0xjq/SUcJW7YVeVtUk1AnH88gjULab6B2iSFvNAEy+pofLnc1kbS?=
 =?us-ascii?Q?bPs9DBaXwC1JHLfCjFmw5mrUOQlI62ce92qnzmYXbOjfKFQuBkgWBJYdVIi+?=
 =?us-ascii?Q?zCX+4ODtRt43nLQnz5XwkSoH/lGWbbruirdbjq4wgvcziPa3RMku/vQgZkWy?=
 =?us-ascii?Q?P5nzCBstG7IDi6kfSNopUXKXcnRZlvHFA3twNnlyxRAPc0k+9uAj1HpIKUEx?=
 =?us-ascii?Q?gD8LdKZyb9xP30p276orEHppFh1DJ48ugESGYGaVpqo3/9PaYf/HrUnmBplH?=
 =?us-ascii?Q?JVpZajC5b+NB/pmckyJ71ioRrlWQGs82vcSzoxSNf9eHhWuHAqz/bfUVB7rW?=
 =?us-ascii?Q?2JbCK6SydRyQ89LsYDv/CH0u36T5kbADCvy0bvu3HLf6SkzxqizW++AVUfdH?=
 =?us-ascii?Q?BjfXxLiO1OmO+FnU3Ink2ZsrpxGJjqPdsU1GXY5IQwU4oIW4ZnmOoxywuxjV?=
 =?us-ascii?Q?/etY7rci22slfN3sZGaK8h5hopj0tkZauEdVeEkD4i+hs6D8i7S16tAUkQB0?=
 =?us-ascii?Q?ynZ2ePaFHhiNrfrvXg3hVr?=
X-Microsoft-Antispam-Message-Info: 3BkBA1aPnnyV8ElnYiqUxKZ2hL4Zr0JAmBY5OrHf+ql4SGI63uREDkPt1w1Ezvz3SP7hWeLQX4in6sORjH/0B6EmwRxx6LMehrU191h7/72PMgk8py6reF9GxbFzpXoAyQGXHqm0vaSzqfWtCHM+P4BSaMMQlcFaYPh1HZ1iOkPm9p0+P1CZrVpMcPhq5KlFm9VXc66Zwqba9cwZfdkVT40NGhfiloPwA/1E8iYcB5YBXUedUCfY64YqNsXOo99XQWz4aIRa32L+Vs1gQnJF5brxojEZGF1aT/YRwtI6a8ailbCpwU7IV+IRvqVOJVjEcOKNGqcN6JgIB19sAi8wJ9uwkNI8F89WsB657lCkdQuItOFvD2oIjaty4KNecgw1n7GoDtU28Pw1QDm8P7duJg==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB692;6:wrZCS8+xdRXubYTZl8mBzUFOugsnh2xbT+e5sbDdIJUA+hTU9aEgIIVbGIPYqCPpg4wsbmoUYA0j00KjXDuueDpNE6f17L7lzxOBZ9N5mT2ZNG0zTLanbvSzANxbicmUm+QeU/cgYF6yiPz32HDncPHe5PmY68LTugivLWx7s5SgLLiwrpwLix1L+d62rp4ELkx8NpFILN25hDgNp7R41JjjU0BFaW5mW0hZKUeLyA9IhcJFch34MIDzynlLItb57esHuD4WzXmN14khAeu6OlAop/AWR21I4z6gwjKAjUlza3NuqBmn39uK99NvNEKSwsSI8S1stkPapqQQZpJa8SFMHucaN9XmIjEhx9zcHoJoS+MSlK6cDmEZxnWFBOrmswyBf5yAItMYaYwnVlqB2rAssPMwIQiJuNkGmzzBLaro9BUEtrmUvU3ibITuZ+JGZYg5M8TylE1vGALuy9ctAQ==;5:5l9J+GTHeWKZB0pMnQ6JTcj5aTJ/GKmu4e5gC0MeWSD8AvtD6bzTqMMoFnfLFBZKVjV6IonYZQUmeQSO1ejpHUaJwHErgQaY3PGIFBCzOgjW0SLm86qSG4FlQrGjQmviyjWyl9nbOAeVhWlS1aXYyqCm1kHkAxHrmMgdAi4RK2Y=;7:Dns2acQqsMSOzuzpEzdR8ijfmmKlCVglOPHmun6OJfNVaRPbUuZumkPks9ZtSHL3qN1CBi7gSBbNyckaYgU/D8ZprjUkYW1Pk7orvD/YJxceCe2aKllX0563c5tVMr4IQegV2t8Qv+q9119RNDEqoC/sHSgcgZJVjUd/+ilpw0iopsJRqchzVVj+s7A2wqEWHvh4gQ3Giul5eu508cVakpZrPsEER59/QBX4u6LWQLAa/ZFU3JzYdJQ2xnw/sr6M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB692;20:cAW2ZRFR4mtx6Ben8axLpJkzWIQtcjDmo3cLkGy3SoKbDOJ5kvkGRAwMWbB2PCxg+oQhK7rpgjdWRHoAhqVcZShN+13Pd9hMNEkgtt08dqADAN8633lDbZmchApzokqkW+4KGnCDI3QkGHs3EKSY0/GykUWYkOvSPgI6H9PUc4QITMZQsuzZ4wZBE6h82JiXUD4S3/suCZI8VZVwrVXsuXRH7umFxOFCxUdf2Mn3A70G1bWoBDw6uzIODVRdDSwb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 16:17:02.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8aee3-02e0-4f2a-9375-08d62f94fa97
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB692
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
 mlxlogscore=371 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If EP attempts to send an IRQ (legacy, MSI or MSI-X) while the
link is not up, return -EINVAL

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index b762214..3667d70 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -370,6 +370,12 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
 				  u16 interrupt_num)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	u32 link_status;
+
+	/* Can't send an IRQ if the link is down. */
+	link_status = cdns_pcie_readl(&ep->pcie, CDNS_PCIE_LM_BASE);
+	if (!(link_status & 0x1))
+		return -EINVAL;
 
 	switch (type) {
 	case PCI_EPC_IRQ_LEGACY:
-- 
1.9.0

