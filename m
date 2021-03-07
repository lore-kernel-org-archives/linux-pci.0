Return-Path: <SRS0=3JU5=IF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32B0C433E0
	for <linux-pci@archiver.kernel.org>; Sun,  7 Mar 2021 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A636A65177
	for <linux-pci@archiver.kernel.org>; Sun,  7 Mar 2021 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCGRgl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 7 Mar 2021 12:36:41 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37981 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCGRgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 12:36:23 -0500
Received: by mail-oi1-f182.google.com with SMTP id v192so984540oia.5;
        Sun, 07 Mar 2021 09:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bzvWL3GDgfoWZ5JORzL1BZkw/ySSrs66mvUv37cteBY=;
        b=GP9FAt+XI7zIQq8nQvczYexRZhX11iacS28Vso9ELstPJbU2usrzipBEGg5LGnHNUK
         A4EscmyHHr/qnlT5jjuKzd1/16bdh9KRqjJ+J296jqYTnzKKqFLQtN09cvHMEEhRsW1W
         oVtdCLB1Zz+0s1YdWFPkgZwz5KxEfBX1nd1qv4Yt8JEtFm4oHNFbm4Wu2qDx3ARK+JFE
         AbDjoG2JnGtuFCEC2IVPKHqnP2I8h5f3iGybkrGvWSGORZW37Z6kCJ/1I8xJWsh9y2bW
         1eVBZNAZ7PYLaqOU6bAVB4lYIu26y/XIUvdFVEPt1whDPOHmcPnD2S+4cOZcTT0ywZvO
         RZNg==
X-Gm-Message-State: AOAM531mPWGL6+62jvxs0btb+HQo6agZQLjRXqjZ+XvoF1Bc0Lsjq7ST
        YorLFHDVIkXrc5MgbNEuzP6mY0+ajnroDw==
X-Google-Smtp-Source: ABdhPJy0NMyHuUgnVbprZQvaSJB7jUsWstmXPz0PeWYvca0t861PjYy3fdwowvxsX0dqeHoeEoguww==
X-Received: by 2002:aca:bb04:: with SMTP id l4mr14174805oif.9.1615138583009;
        Sun, 07 Mar 2021 09:36:23 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o25sm2170501otk.11.2021.03.07.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 09:36:22 -0800 (PST)
Date:   Sun, 7 Mar 2021 18:36:19 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Select configfs dependency
Message-ID: <YEUPExklfpWYVEMx@rocinante>
References: <20210125113445.2341590-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210125113445.2341590-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> The newly added pci-epf-ntb driver uses configfs, which
> causes a link failure when that is disabled at compile-time:
> 
> arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-ntb.o: in function `epf_ntb_add_cfs':
> pci-epf-ntb.c:(.text+0x954): undefined reference to `config_group_init_type_name'
[...]

Thank you for fixing this!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
