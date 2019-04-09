Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89005C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F27620850
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 23:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDIXl2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:41:28 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:50764 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbfDIXl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 19:41:28 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39Nf0dH019431;
        Tue, 9 Apr 2019 23:41:26 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2rs4en89r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 23:41:25 +0000
Received: from [0.0.0.0] (cce02cs4037-fa12-z.ams.hpecore.net [15.203.233.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id AF34266;
        Tue,  9 Apr 2019 23:41:24 +0000 (UTC)
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux@yadro.com, lukas@wunner.de,
        s.miroshnichenko@yadro.com
References: <20190408195540.GF159318@google.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix re-enabling the slot marked for safe
 removal
From:   Micah Parrish <micah.parrish@hpe.com>
Message-ID: <e11b4d88-f20d-9989-c249-2f235ef0dc28@hpe.com>
Date:   Tue, 9 Apr 2019 17:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408195540.GF159318@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=685 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090150
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Because this bug affects our Proliant nvme hardware, I would like to 
request the patch be merged to 5.1 and 4.19 longterm.

I have filed kernel BZ https://bugzilla.kernel.org/show_bug.cgi?id=203237


Micah Parrish


