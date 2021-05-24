Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82CAC04FF3
	for <linux-pci@archiver.kernel.org>; Mon, 24 May 2021 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B895661209
	for <linux-pci@archiver.kernel.org>; Mon, 24 May 2021 12:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhEXMTf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 May 2021 08:19:35 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36503 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhEXMTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 May 2021 08:19:34 -0400
Received: by mail-lf1-f41.google.com with SMTP id m11so40416009lfg.3;
        Mon, 24 May 2021 05:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qHHwYpnZdXBduLX77qXsMzrBNcDpuZOBYfiZAoU4g70=;
        b=ahto/4SqdE+9wdg9ve4RXSn1sm3Mtk5NlcyAKI0Y7kmBCT748H39KeCln5j/e1gWd/
         y5RFQcjOudkMyrq4fv9cZ4BMJMkgSMrp+24FblkVKbTaQW5NYSTSfwCgBTUn/GG4PuHK
         71zklwa5LjNqunSHMvk7H11sjZcWX/wgxsAFN+DRPg/cC9nit1uyruQJ8hJRBgvj7Xau
         CguDpimq5G5GwVm2lFAYkXI3msCUbfjjs4a1VKqgTkqGEZg+o2En20basF0rSJOTOrMR
         RXZtctv+iwP9dPldInUCHUFQvABNIjLrczz7MCnaAuUFpQIEfAl5sdu3LzxXKs0Jc+8W
         eyTQ==
X-Gm-Message-State: AOAM533V2B/cSnAIk8uAaxz9Kbnta9Qui6+5k4blW9rWCDFvN2B39EnH
        6Ds2J83dljWjCWi3PR8omMs=
X-Google-Smtp-Source: ABdhPJyULdcqpPJP33cxbf0HmCP8CNypXmxiOd+IXj6RPrqkpOssPHXh/1dbZwYSfzDExkbSAqz9Rw==
X-Received: by 2002:ac2:5f04:: with SMTP id 4mr10116074lfq.557.1621858685076;
        Mon, 24 May 2021 05:18:05 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p7sm1415873lfr.184.2021.05.24.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:18:04 -0700 (PDT)
Date:   Mon, 24 May 2021 14:18:03 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Thokala, Srikanth" <srikanth.thokala@intel.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: Re: [PATCH v9 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20210524121803.GC244904@rocinante.localdomain>
References: <20210518150050.7427-1-srikanth.thokala@intel.com>
 <20210518150050.7427-3-srikanth.thokala@intel.com>
 <20210524103027.GA244904@rocinante.localdomain>
 <PH0PR11MB5595DDC966EF6BFE3B9A921885269@PH0PR11MB5595.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5595DDC966EF6BFE3B9A921885269@PH0PR11MB5595.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srikanth,

[...]
> > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> Thank you, Krzysztof, for the "Reviewed-by".

Thank you for working on the driver. :)

	Krzysztof
