Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C587C00140
	for <linux-pci@archiver.kernel.org>; Sun, 21 Aug 2022 11:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHULaB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 21 Aug 2022 07:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHUL37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 07:29:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00C1AF04;
        Sun, 21 Aug 2022 04:29:57 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M9Y9K6P8szlVjT;
        Sun, 21 Aug 2022 19:26:45 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 21 Aug 2022 19:29:55 +0800
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 21 Aug 2022 19:29:55 +0800
Received: from dggpemm500007.china.huawei.com ([7.185.36.183]) by
 dggpemm500007.china.huawei.com ([7.185.36.183]) with mapi id 15.01.2375.024;
 Sun, 21 Aug 2022 19:29:55 +0800
From:   zhuangshengen <zhuangshengen@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>
Subject: =?gb2312?B?s7e72DogW1F1ZXN0aW9uXSBBbnkgcGxhbiB0byBzdXBwb3J0IGVuYWJsZSBQ?=
 =?gb2312?Q?CI_SRIOV_concurrently_in_kernel_side=3F?=
Thread-Topic: [Question] Any plan to support enable PCI SRIOV concurrently in
 kernel side?
Thread-Index: AQHYtVFWspPz1b9KT9CKr88dkJbU8g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Sun, 21 Aug 2022 11:29:55 +0000
Message-ID: <11cd67a391a14a0db3bd3cf2be3e614b@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.222.141]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

emh1YW5nc2hlbmdlbiC9q7O3u9jTyrz+obBbUXVlc3Rpb25dIEFueSBwbGFuIHRvIHN1cHBvcnQg
ZW5hYmxlIFBDSSBTUklPViBjb25jdXJyZW50bHkgaW4ga2VybmVsIHNpZGU/obGhow==
