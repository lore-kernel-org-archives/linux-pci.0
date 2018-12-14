Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D153C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53CE206BA
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 14:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BsEDjYVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeLNOct (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:32:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52942 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbeLNOct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 09:32:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214143247euoutp02b18efebd6c8fcf3ee524c522d24f687d~wOZEsZX1l2009420094euoutp02o
        for <linux-pci@vger.kernel.org>; Fri, 14 Dec 2018 14:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214143247euoutp02b18efebd6c8fcf3ee524c522d24f687d~wOZEsZX1l2009420094euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544797967;
        bh=sj04uWSIW75nN0BNvGMyFx823Dac7VELrVPqgsRW6Dk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BsEDjYVyfxewQssGJ6bcI/IsQSryNhUGPw0mRipw1ccpnkiQiNbuaOIyYX2xfFXwb
         pUufP1yU63E+XwuUB8xGk1xx5X7y5vpSa4u/dcePnZA+5sdCebCV62QSenqd2V/Sc5
         DWc9Fztou2WZoZ/TXVdc6qDtAMt+3rP5tYA1c2DY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181214143246eucas1p1c107c17fd69434dda6e5ce8e842376a2~wOZDh4Qg72879328793eucas1p1A;
        Fri, 14 Dec 2018 14:32:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.DD.04441.E0FB31C5; Fri, 14
        Dec 2018 14:32:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181214143245eucas1p22e0c6976b5e9ae3cb3244b67fc4958f7~wOZCobIoo2112921129eucas1p20;
        Fri, 14 Dec 2018 14:32:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181214143245eusmtrp217df2ccb42f453f0cf3562115e46c99a~wOZCYM7AA1860818608eusmtrp2o;
        Fri, 14 Dec 2018 14:32:45 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-62-5c13bf0ed34c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.A2.04128.D0FB31C5; Fri, 14
        Dec 2018 14:32:45 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181214143244eusmtip19382af90672e2f93fcec1efd2d1a220b~wOZBowl0i0905109051eusmtip1E;
        Fri, 14 Dec 2018 14:32:44 +0000 (GMT)
Subject: Re: [PATCH 15/15] dma-mapping: bypass indirect calls for dma-direct
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e509aa31-aa97-8c54-9205-cd2c086ba9fe@samsung.com>
Date:   Fri, 14 Dec 2018 15:32:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214142435.GA18448@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOzo7D2fHM8s2uDAwMtaT++MySDIkDRQRFkAm19KCWU9vJ
        yqJSLC/L7IrZENOkvI0y765QnK5VYjrFspuFTitpurK7YbkdLP/7vc/7PLzfAx9NsH+kPnRc
        wiFem6COV1Fysv7Bz64AjxZl5KpJM4tbb5yV4oy8MFxeaZbgc6cnCVzUEoKLGgZleMD8RYJv
        lQwj7Mgak+JeYwGFOwstFG512KT4V65JguvGy2T4Y/cAiQdz7TL8o2pIusGTMxQaEFdy/4OE
        q67IprhXT+9T3MP8SZK73F+KuHvPUylu5GqbhPs0/ILkxpv7KK7WZKW4ieol29wj5Oui+fi4
        w7x2ZeheeWxlWi9Ksrsf/VGbjlKRUa5DbjQwa6DJdEWiQ3KaZcoQjHSlycThC4Lm9jFCHCYQ
        5DwbI2ci974ZKCezTCmC8iZ/0TSOIONJpWuhZLZA8Tsz4WQvRgXDo53IaSKYCRLSqp65FhQT
        BDq7zhVQMKHQ02xw6STjC48dvyROnsdEwnBqMyl6POHRNZuL3Rh/KH1dKnUywSyFBnsBIbI3
        vLBddxUCppaGrBtWQnx2OLyxP5CKrIRRS61M5EXwp2kmkI4gM18vE4ccBHUFjZToCoE2i3U6
        TU+f8IM7xpWiHAZv7+a7ZGA8oN/uKT7CAy7VXyVEWQFZGazoXg56y+1/Z1u7e4gLSKWfVU0/
        q45+Vh39/7tFiKxA3nyyoInhhaAE/kigoNYIyQkxgVGJmmo0/S07piyfG9HXnn0mxNBI5a6I
        vcRGslL1YSFFY0JAEyovxc4zykhWEa1OOcZrE/dok+N5wYQW0qTKW3F8ztvdLBOjPsQf4Pkk
        XjuzldBuPqko0LB+0/fgCPmpqcy8lpOhioqO2I7+LSXnFSfa9msm574/83np82BH+q6LlZt3
        mT8UFv9GaMBqbC8JvujXVpTyW5kZnz8+FJ4n963r2BiVmPVta9jLsveblx1ckL6oSkgL0mXX
        7Fj7aqg7N8Z0M2D+2OJTstX1U0m27RGXu+x9ZTWFlIoUYtVBKwitoP4L2aXJG5IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xu7q8+4VjDJrOCFocXNTNatE2zdFi
        5eqjTBa9Lb+ZLRbst7ZYsP0Ru8W9o1+YLJYtfspo8aHjHavF5V1z2CzOzjvOZnHwwxNWi199
        h5gstr5fwW7x5sI9FotHfW/ZLX5seMzqIOixZt4aRo/Fe14yeWxa1cnmcefaHjaPEzN+s3hM
        vrGc0WP3zQY2j2fTDzN5fHx6i8Xj/b6rbB5bDl1k8/i8SS6AJ0rPpii/tCRVISO/uMRWKdrQ
        wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY3XjZcaCtzwVP7Y0MzYw7uLqYuTk
        kBAwkdj9bQ1bFyMXh5DAUkaJP1dvMUEkZCROTmtghbCFJf5c64IqessoseLIG7AiYQEfiYXP
        jzKD2CICShJPX51lBCliFvjJIvHtxG9miI5GJomrv3vAOtgEDCW63oKM4uTgFbCTuLRvDVg3
        i4CqxKkPv4BqODhEBWIkni2ohigRlDg58wkLiM0poCOx/O5ysIuYBdQl/sy7xAxhy0tsfzsH
        yhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKT
        w7ZjP7fsYOx6F3yIUYCDUYmH98AUoRgh1sSy4srcQ4wSHMxKIrxhrcIxQrwpiZVVqUX58UWl
        OanFhxhNgX6byCwlmpwPTFx5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6
        mDg4pRoY2y7y5q69IvAyy+Lw7jkct/+/e3P4bsZM8UMVy+xvOL6a3Xdyo35hpa6HRpZzWWC1
        x7722QWc09awRO/7xDBlGgtj3NZvtREX9A6vu3J3Qf/tH3POr2Z7+Cz49Jbbd648fm2auVlS
        e1nIGqOVU6z/WVt1XXDar+I31+cLhzXHZlO32arWPxp3RCqxFGckGmoxFxUnAgA15o2oJAMA
        AA==
X-CMS-MailID: 20181214143245eucas1p22e0c6976b5e9ae3cb3244b67fc4958f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181207190927epcas1p457ae0498c01d1730723889bc7c9ed40d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181207190927epcas1p457ae0498c01d1730723889bc7c9ed40d
References: <20181207190720.18517-1-hch@lst.de>
        <CGME20181207190927epcas1p457ae0498c01d1730723889bc7c9ed40d@epcas1p4.samsung.com>
        <20181207190720.18517-16-hch@lst.de>
        <edef688d-da7b-d42d-2890-7cf1ec415ac5@samsung.com>
        <20181214142435.GA18448@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 2018-12-14 15:24, Christoph Hellwig wrote:
> On Fri, Dec 14, 2018 at 03:11:37PM +0100, Marek Szyprowski wrote:
>> Hi Christoph,
>>
>> On 2018-12-07 20:07, Christoph Hellwig wrote:
>>> Avoid expensive indirect calls in the fast path DMA mapping
>>> operations by directly calling the dma_direct_* ops if we are using
>>> the directly mapped DMA operations.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> This breaks direct DMA on ARM64 (also todays linux-next). NULL
>> dev->dma_ops fallbacks to get_arch_dma_ops(), which in turn returns
>> non-functional &dma_dummy_ops on ARM64...
> Yeah, fallback from direct (NULL) dev->dma_ops to something else won't
> work with NULL as the indicator.
>
> Fortunately we shouldn't even need that thanks to the patch from Robin
> that explicitly set the dummy ops where needed.
>
> Can you try the patch below?

Yes, it fixes the problem.

> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index 273e778f7de2..95dbf3ef735a 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -26,11 +26,7 @@
>  
>  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  {
> -	/*
> -	 * We expect no ISA devices, and all other DMA masters are expected to
> -	 * have someone call arch_setup_dma_ops at device creation time.
> -	 */
> -	return &dma_dummy_ops;
> +	return NULL;
>  }
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

