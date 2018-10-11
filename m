Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66251C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEE42085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="soxFUwGJ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SJxYQYfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEE42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeJKXoR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:44:17 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34840 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbeJKXoR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 19:44:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGDejp005443;
        Thu, 11 Oct 2018 09:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=zdoICzqt+/BwVeoq1sZW3/Zqfm0BXrQWMZFt8Y7LdIw=;
 b=soxFUwGJKhXwpxdIcCJ6UJHdvZLBtE9puZB//I+ln/bDqGfH9gDwb8Lml3weQOSiios+
 q2brY3HDyBipuLQ0t7qtV7iYX6GLSg2LrwJxhET7CqNkG4GrreR3Kd5uphC7f1pDlVNK
 QCt4CFcgH7a+bSGYTVc1beXqtXDs5IR316xxqUfS9pJaylVxv21FSRnp1QM3Bqze8mfK
 73WnOEtVR2P/phLiKl7VIWeyssHosAYxHs3gFNrfM2v98hKE5r7ifpKfNpnziKty0uix
 ZLv8CaCkNMyJ2LR1D0ywrTY3MCHI9HK74qnrhmhBChQItRM5hhCmeJIP8x591tfL/rL8 tQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0180.outbound.protection.outlook.com [216.32.180.180])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwx7qk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Oct 2018 09:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdoICzqt+/BwVeoq1sZW3/Zqfm0BXrQWMZFt8Y7LdIw=;
 b=SJxYQYfH5ajnNyLqFAA0kwT3XvfldAKacuJ1R4joZnFBP3CUlbHwvQVMb3Lv3UgQoXu3KSQQaNlBDfKjaZQEMhvYXL4ZGGhbdoo8blGyFyyUA1eq0oDU+x8YpGOXQs0HP6Z3o4hBaCePu5T3ni+YtnYqp8RPK+JICjq5DPegDAY=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 BLUPR0701MB1825.namprd07.prod.outlook.com (2a01:111:e400:5164::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Thu, 11 Oct
 2018 16:16:09 +0000
Received: from BY2NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Thu, 11 Oct 2018 16:16:08 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT036.mail.protection.outlook.com (10.152.100.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Thu, 11 Oct 2018 16:16:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGG6TM031333
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:16:07 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 11 Oct 2018 18:16:12 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Oct 2018 18:16:12 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGG5pN000395;
        Thu, 11 Oct 2018 17:16:05 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9BGG5dh000392;
        Thu, 11 Oct 2018 17:16:05 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v4 2/4] PCI: cadence: Write MSI data with 32bits
Date:   Thu, 11 Oct 2018 17:15:54 +0100
Message-ID: <1539274554-32252-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(36092001)(199004)(189003)(86362001)(5660300001)(105596002)(106466001)(305945005)(2906002)(50466002)(126002)(7636002)(2616005)(2351001)(476003)(51416003)(54906003)(356004)(6666004)(36756003)(47776003)(478600001)(6916009)(50226002)(8936002)(8676002)(246002)(26826003)(4326008)(87636003)(14444005)(107886003)(186003)(48376002)(486006)(336012)(16586007)(42186006)(316002)(26005)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1825;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT036;1:LDdaLBGzb8WS9A0puU4fhiXjRF32iC1bU5FanvI0s9Yxpe10uWDXfVfovI9geWf/U6X3qSQBqq2T1DF8dr1MwFgZG/RXgEiAWNK4TIaV37Ydw4J3rrkz2D0ZKgBLOiD2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8a1262-62bc-482c-f31a-08d62f94da4f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BLUPR0701MB1825;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1825;3:XRzn2RgpeBLnVbKrQltcuNtp2PiwD0DqiqN7D8l1c/QGbvaYnErfVzOiSOWe1ODvJAWgRgFzEhO830gv7EXlrnPpP5YCJscCMyiSoRylffXJhhdeaVy4ezgIsEYKlERQxtkIU7/AzilqJbAALIeHJpnEvMSTQyy/YTxAArWeF8LhHZgsOw4XkKY/58HlODMAkKXi9XKckkf9xzMqmbzo8ddCIrxV4HzoMyfC5/qyRUSe8ux8/fIQAnK7UffRypZYytcYhL7Mr88jrV93ehMHO1t2hhElAwQvnQOkYqZbKE0oVRoXZnZ2OMzc/YCKQVlJQiFnuzDvOMEMT2pIVJfM5ZhFVFw998PKvKiU06cyzmA=;25:zwyrY+LRgFsR++qi7bSbBAHTVGnwYolu9fqNrbSfGXHk3fCSl7KyPLfyUpe4A6ronuj0MzPD/M92Pive9wLboOs5W2sj0lbeGkoE83oRaSQnf0nofYOEeC+eHt204MpddrUpo7zdn+1HLeAvYcKQm4HVxZTjIyEkT9KaedM6qWfxAcK05f2nyUC7QOSfo1MH2iUcGGc/bWcxbnWvmbPKR/82v2eyHmnq79zg1z2ZlArbNbxI8A6upfgMjBAuIuausteZFoa0/zlp8QUGenV3N2CV+VIfUs+yJF7d054zN3dOivQp1fXBQ3OPOTpc4fTLATuSVP7RmxRFK7RSsTBzchKNptCbcVMM6MNIx+BEGpY=
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1825:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1825;31:7Jvv+4f+vfZq05BxnarticCBFVuoeD6Cb/qt5K+lL+pHrIAbWvt3rWVpmgoyh9h0FZVbeD3KBTEH/Bkf5UA3wn7KR7f8hrgiK3EPfc+d/Bl4LaET4tsy2woGycDqWuG8JQZO/lHc55gwjU3kWKdYtRUZsFW3YFZp5cZ3eeQWWNXSRqLQZyWiwutLNTPZHY48lEcw9idZ9JH9VFoCfEs9U9A1Qwdt0vfdRLK1Lmr9F+8=;20:tgSkV1XFACb36eIzXulyAftzZ/9FLIyiyt4ANTkGkbMhg7tTb61lQM3LuZ0KDVJKv2/39P4MEwXtpjrqD9OZ/1eBF+JLHUVwxuLj5Nq+vHItHZf8N/eo3CkCTRnhIXmjtwhNvPPvp9yZI0YR76pD2rr7NC+1aHbiAK5lw58p34ytRG0v+lYZ2rdgwXLXOSgS0oGKCd88Ikk/VVhqpQ1L24wL68Y+8cVzH25AK4nIqeUSywaVlwx2WHAP9OzEAhmZiG2jHHoUy3k8zkcMSJj4PjEXXPvwt9ed302W9eD0rDV2MML1lpuBbKd9xadRxpZL7DIv6XmcGDMfweljipqSf0Yjp78sW9QoVlfigPWEm2L0l7iJb2+FL63ZZZUk2iLFhdzJGHh1WFxgfHgEDrN0/GrHaeGy6bIWvahOtQy19BjinX0A7UwsEU+cECNRmJUrtDbR60vfEGhZYZ5PH+SFxvOqTyg6xRic9rECM2zAKp2VkY7ZHUqDVeDaM1gQbXME
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1825900A9678B05F8F356BB9D8E10@BLUPR0701MB1825.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR0701MB1825;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1825;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1825;4:4EbiSsoAPT0jQPr7bKJAvqxyiXkjtobLXbrj5q4Ibze1B0S8DdEB/rgOWi50utwkjQupre2A0Ln9NfDaw+T2+zL1c8fAi9yicxb16mKe8GgQ0AdCQbb+bPQQUhLwiG97EfbExseceQ6T3Bo8Hy2ZEw9F63Hiz+XukjsAue9QZbDBY2N1kKJ73/9IuV5WMBAp4N3BG+ukStSoAybOO/dkXuj/9okKORNHSOR6Q2rZN9v0AzOskwtOF+INMbrMro9dWOw1GYJpxOOQ0yyhUUMjJQvyP4yCMCgMKoXtE8SfVuoe59uXnWUanskRnX1I6ss/
X-Forefront-PRVS: 08220FA8D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1825;23:UPCSdinf5qfTs8sQBqcZVqfKoxIVxUWZCic//5J?=
 =?us-ascii?Q?qIqz/FZ3fMEXUvk+ZeymKksloVwjbtqtw9jvMynFEGTVFfJ1rlSbNU7mcpiP?=
 =?us-ascii?Q?DjrVsepOFOxdp75DisHXWeEzAp+rNd93/r69xTPm4m1dSGe7DOPWU0LRmTwI?=
 =?us-ascii?Q?w4GS5PxfPxZ8Uj1JEaDCKJJoGaFXEj82nF2EY9nHCWh1GyETYm1M+dhuF/sD?=
 =?us-ascii?Q?GWY5xVa4DhoyFRdqmDrcEbImAHPPZL9uV90mXMiPOIVHNP0tImUPSr76CIIA?=
 =?us-ascii?Q?dKRzntFdbEaQf7RpnIRR80/eLQoJelT5q06awuu3/P5cM0lmGz1HJ+t0ePI9?=
 =?us-ascii?Q?rSPLoPu+fHjeJ5FxEXiTQ/MZA7UcXl3l7B6Gvb9HK9ZHCjydmamQ5SZ6O0u8?=
 =?us-ascii?Q?nJPIlbeOWpM2VQJ6eqSqlu79HJHuqGNvgplIEzvUjFwA3GrQKCj3rzjX8oBX?=
 =?us-ascii?Q?SlXkBQKKLxonMZ8HfsqIpOQ9WpXiFqISkjBjFJw1J9lCaj6btyP5Dwcmov2i?=
 =?us-ascii?Q?F1GBfAsHmCQqOxHbv84HlI3pgGzma+O02l8tsWyKtS5pm35MqqD3d/fXXDuJ?=
 =?us-ascii?Q?vVs/5EwtIzeIVXI9Z78RMOn/RXyGmh5xqJNc5EdkPvPTMah62wGZH9M52d/7?=
 =?us-ascii?Q?SDPUKWqYimFa/BRM2QS6wIZZDF2DtzM5Yth70HPr8NyDo2GoMf3ix8tKLTcs?=
 =?us-ascii?Q?sGEj9ePFVij8QQK7yR9Lux/1NSwBclRLg2107Z+AWfX7Vd5dPulMXb+o0q91?=
 =?us-ascii?Q?UxARg4kJBOVL348KQihhIdKE/Ye4kmAGKJS0KIL3hwGx3kEC7Iy91B/gb9E+?=
 =?us-ascii?Q?cvUpJvhR24qmEiNx5vtHqURjfZABF8oNqOezFIvadDbb0EWUMGsmIcxU2hPy?=
 =?us-ascii?Q?NMFhDrSIlLg6E3QWdqtbLN7uzvWDp5FxGDU42toa82RvC29Erd1CR3jktQfl?=
 =?us-ascii?Q?lwftC7slUBZBuMyHx/BIvvLCFqTMiHvTU4bz5WSz87J2B+ZwfVvmOUNVWm6K?=
 =?us-ascii?Q?Nacwidqo6WLHELNRfHxgbNreurNf6oj+A+Cv7+tipqLPss3wIaYNu06sZS8U?=
 =?us-ascii?Q?lKz9F4yM=3D?=
X-Microsoft-Antispam-Message-Info: ZyJ5TWWfZiSl9cbvINIq4AIJOy/ubrIXPtTR7X3aITWMH25/sBdyPy5i53ZlLA1oZEWSEk/ttYQ5vf1FwcfYmhA5pZPYy/ebPfjdDEMhzKt7gO3fxuZa8T7W1R1ttThUjchUkYiVGrWLQ6Wfla6ZUvf2frd9yaZnG9A52l3Nm+fa3/rXBNTzg984OTl1KQVn7ji9d587LmSwaoY0LPsSqmiomGScEGKAtkOQOF2cUzn/FFsiMcmCu072VkrJzsSh/+0mclEbOJbRctNd+WbBqpRGGYg8hKHhzErMIvLvKcWTGVooomE5uW30wcsxRGC/hMVro8WMxv92VFl3n/Ap0FvLlxfaNJ2YVFAHC1+fBHXficyiF8e539Q5NSv1Mf9d0VIzTPmTX6hPN6//bWdPGQ==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1825;6:UaREEP3bNVPV5P98pxXOPDmq/vF6DH5MLgv9/Sg/HjrHihU/l4FfaAgEbqpMMhnyxJu1KyZHZqJZWj6vwedqCpiAJWlJ8B7c/tx7Dg2845p0T05RNH9GUqCy8LeWmdm2l2b1JskdnzEPvDTAHsBiUTLcRQMWeQOQqtllfMbQq23M7ZRr8SHSLURqMMP6JBXwMBIcCLzF18uhh5rkQNqOApKRexDi92KQYvKDZip2T1HGmVCEnCb6qVwPqMw3c4OazpC9Df9fKR0pNOLaFSZDPpjHdoE+KBfV8aRR1ugwlBlLqGydVITwqcONxBOENpLla2Qu83hpyT0LhEARyuCnpYubBIA8QXX+E1SrtoIl6XKp93XYwP6/3ALirqcfF8hZ13KG34I7JhRAhkjySwD440lODx+7F5qF96FVPw5wuFKetoJNqhCfBQ20eqWdtswslUMr4vz65qCO9vnGITlErg==;5:AXG7b6HLD1HJoZU/MbRFXbzhwHZ5DwWZr5hPFiY9EtbnhgNc81BMIzmGkKizhc1Pypb/Uyr/5nXppSP8iixO0CZMI/HXNqqVLPjcQxB5gMA+Nr+50Y2w0KqaL7dRaB5VdfotmEtx4TJEBkshYutm7WGY1o8BR9szsMri6NhvSnw=;7:5jpiip01VzPzBYf69iRjTjuJN3MN4ewjTMLWJJd88gx/skT4KhwmrDoDjOJluNC79nWyxAhaPyokdXbZn7uK0IvQ05GZcZV7aaHD0Fnh3gutdao5qsGQ7091NfrrOs5LX6GSgI7upV3u7/mlZn6sW2aMpIpUtCmnhkdvBueudI79swj7atDA+PQ8jlnXyRbpUDmn8Z0skQoqyPer8fKXDDPtDsoX/gdPl3jJLImWJtwHg0W7DmFFmXjF2MIhlSFo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1825;20:lrOmc7EkQPutA6I9vfFAw7uzIDX6X9Kg42wqP5BL9SBjmjden08ECDZucUdYWEITAxVcTMjkKDWXQuRm4CCpMYMelVeEOCmRHtNzGHFbHN1YQQue1EJRyK1ZeYq1k9GLCekJgSlq73dtonjXZX3pYsacJqgwZO0eu07q/gtnIlext0R0aYYKaVrPtWKG6MYoyH07qu5iQlhP2tD0iXqEhPFkb1Z5y0yAA0LrEmGgYbC+ABtFKfCcXwL/P3YJaAKW
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 16:16:08.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8a1262-62bc-482c-f31a-08d62f94da4f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1825
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
 mlxlogscore=798 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the PCIe specification, although the MSI data is only
16bits, the upper 16bits should be written as 0.  Use writel
instead of writew when writing the MSI data to the host.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 6692654..c3a0889 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -355,7 +355,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
 		ep->irq_pci_fn = fn;
 	}
-	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+	writel(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
 
 	return 0;
 }
-- 
1.9.0

