Return-Path: <SRS0=vfl7=DH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E419BC4727E
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 18:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9429020791
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601490107;
	bh=xyRSpRoOEJ2r6YYj+QXW2X2ELCdMvlyAVb2RyB3Fy5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iaLl6bkI52Rv45lEp/tSOPZu3KM6a1j4tLOk80ctF91KKE5swObBvKYG1muOTWfUv
	 wXA5B8KwHGHZAUrDbH9EABPhg9qRiN2r4J93yEgAtW9Bv7WF2pkKGv56FNhQ1TRfKq
	 8iiNGUnziTkl9MIHY6vC/Fi4yw9Xy4E2+cWP+y3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgI3SVo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Sep 2020 14:21:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41244 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:21:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id q21so2764063ota.8;
        Wed, 30 Sep 2020 11:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hd2ocInfi4avQ8AdBOhBE6fs1Q1midhjtlq5o5WVWcE=;
        b=f6s++lUzyzKdChrlh8I6a5BPuEuZHR3EbOzXV8TsQzZai4AiGf7JtYlbyf4eRa+ggV
         DqxDp0ACeSKOLmYXfYiz/gNfXUsjogbKZ2zxa97hqW3Ds8diNCUTR6lJ/WOLw9viWQ5o
         oH5RBWDm7OhL9BM1oI/GZhJ/QPKQUa0Aeijdlh6NfHjXR4HV0n+zjuPz1q6htiz6Yftr
         IzW/fwlmtM+qUY3Aeafc24s6ndFaw4m1rc/iQmMV8cip/iugvG9lUJ4vXyEheMISxpcg
         ZVlxGg7we/Z7nwa96drnEJz/S7MCLfIdg6StSv8jHEdW8fGzgoZR5r/qcMDYDcND+w5j
         zv1Q==
X-Gm-Message-State: AOAM533g200JJC1Hz6eHJeFbxSZub+Hqi2tRhC+xf9leP+ZMbEkBZvhE
        jG3D7iA2k1DbjJHwYlzM5Q==
X-Google-Smtp-Source: ABdhPJxyEnxtE5TN21dfNl5HNX7z/8XKKNKHcxJqiex1hzRxLB7plOS8FUvEWWricA3DV1qIvpltSA==
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr2412279otc.327.1601490100656;
        Wed, 30 Sep 2020 11:21:40 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g21sm629885oos.36.2020.09.30.11.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:21:40 -0700 (PDT)
Received: (nullmailer pid 3176490 invoked by uid 1000);
        Wed, 30 Sep 2020 18:21:38 -0000
Date:   Wed, 30 Sep 2020 13:21:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2] PCI: keystone: Enable compile-testing on !ARM
Message-ID: <20200930182138.GA3176461@bogus>
References: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
 <20200906195128.279342-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906195128.279342-1-alex.dewar90@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 06 Sep 2020 20:51:27 +0100, Alex Dewar wrote:
> Currently the Keystone driver can only be compile-tested on ARM, but
> this restriction seems unnecessary. Get rid of it to increase test
> coverage.
> 
> Build-tested with allyesconfig on x86, ppc, mips and riscv.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
