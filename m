Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2ACC43460
	for <linux-pci@archiver.kernel.org>; Wed, 19 May 2021 19:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30A76135A
	for <linux-pci@archiver.kernel.org>; Wed, 19 May 2021 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhESTBT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 May 2021 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESTBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:01:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D9C06175F;
        Wed, 19 May 2021 11:59:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q2so10529963pfh.13;
        Wed, 19 May 2021 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M073CmbM6OvFOLG+SWp0SNpXEbUxhFfHxxoda72NgXE=;
        b=Ekc2ScXY1SHvF4H29yTRhgjiTSWV6Cyne34MQrajkIT3p2pu6mu773Qlyr0kpC2NNU
         P+GJiyNV1K2vRtkjtAhIgI9VHVYmFkAxziAc3YITYD5dCFwhGNrQytvT7wWGVjrLLVt/
         Z+eGZOsPbQoTabmseviirRgNiL7jb93KoBbw+F8LkLIJVv78TKzBCCrYFTn6M7Wbv/bo
         0UQmBpP3G5FMrLaiP4lB4mvY0KeluMFddI6VD1W8D7dp8q/8Zp42g/wrvlGw3mxI6q03
         5p/katWWYvUn05FJWNltsTeqIMenps29TVH4Onz8E4y1A5fSnj1TT7Ka2b9bvOBYDjcG
         zYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M073CmbM6OvFOLG+SWp0SNpXEbUxhFfHxxoda72NgXE=;
        b=BsbJr/rM6Oo/8pJ2QMuMyAtmP9Kz5N/EXAfbqRaN54DRaFK8F5zF1Wkc2KK8Hvxs26
         yU8vrT9GBZmGyw/6FGRMDHRblakWH5SZP+YExTdnd9Ee1j5wyfeP4UHyAzknDmMWNepN
         WMnHhijYxh4kw5YSzbwB924ro/IRTCx7XN+NKD5usBQqbatT2BGYRi1JFAzTnIgUZY0I
         EHUrS0So6C/UfdWnp1gH14vYljyjI5XPvq4r8C71z8Q/vXDXvInNZ42TH23xqckR/cML
         0O1v0C+pvH/WfmaR5tYCpDlU1mnCnRO9spUXGpyJQ6RpVbC5CSBYV8R6ISMdxjxKPIxz
         HdHA==
X-Gm-Message-State: AOAM532kBAsNC6l2wuEMFq/te67xj4FRMBkDSRuSOc3duhVyO/YrU2Qt
        gY235xn1LJSCzcAy4ZiyAsE=
X-Google-Smtp-Source: ABdhPJyp0yRJO2tDNgGd4CfLo9HXihdjW7DvkJwzlUWA3fY93WK5PBHIJbH2WL1TmMBXCaStbeZwNQ==
X-Received: by 2002:a65:48c2:: with SMTP id o2mr575344pgs.376.1621450797716;
        Wed, 19 May 2021 11:59:57 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 63sm140020pfz.26.2021.05.19.11.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 11:59:57 -0700 (PDT)
Subject: Re: [PATCH v7 11/15] dma-direct: Add a new wrapper
 __dma_direct_free_pages()
To:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-12-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8c274da9-db90-cb42-c9b2-815ee0c6fca3@gmail.com>
Date:   Wed, 19 May 2021 11:59:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-12-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add a new wrapper __dma_direct_free_pages() that will be useful later
> for swiotlb_free().
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
