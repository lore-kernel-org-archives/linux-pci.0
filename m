Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11807C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 05:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6D82177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 05:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saglBR9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfA2Ftf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:49:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51396 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfA2Ftf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 00:49:35 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so2439847ite.1;
        Mon, 28 Jan 2019 21:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sqT6eOS6rlMfFX6BABqo1r9scBD9HvXuo8A4Z+A64To=;
        b=saglBR9Gq8QG8/rznlQcqqWgRJwFXLPGMwPRwZKz/iEeyRun8cwQey/D1j+963srU8
         5d7j28N6TrjQaGAY06qbdcSRN/Oww6NgBgtI/ymbEzAMiKIIWXog+kY7qINfVHaG0adE
         5HSk+SMjFb4n/ZpwrkxIlNcgxcPNS1f9stIFcQDeJq0zPaj7Lg6QTjo9xpNeoh4wpHQC
         cSMLvQX3NTAHu0OS0+Nijjnb4VS5Dk4QKDRPE3rSY8ru9I/AeoxyXJFU7WqBAHDWCPfm
         D8UFeymkR36yN1x2hQH2O/dwx7eW91fWyFoAuH7yZEt7rtU/1Tltmqc8BR2ccbzMPdkJ
         r7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sqT6eOS6rlMfFX6BABqo1r9scBD9HvXuo8A4Z+A64To=;
        b=GJSKbFgaStHzBdwfpp8ROAxXr5rKmPbEzhbB9sYTMRIV2o6jay7flAzZp5vcpwHzDt
         bFztv2bGtOdXIXUSbiipR7yfMZtGfERDpkQVtrj9eGM2Wyw7E93ZzNFNitDTFqSzN3oq
         GPVG6JMvTms3EDZDTsIGNldV829g5tGDH9Z13QAgUCu7ivcIG4DrcZS7Cts5L8R1087D
         NxBi1gFlvqaPbYU97ZOZ8rW8dV9imhqjDD42Yp+geGEvuR1qkBJEJvqZh6Z2XgLa3tGn
         a2mZjGRIAI9d9NShpiuYylRIG8K999Hyr2CStqyqlquwhA+TrFD7BhDLCDp5fAp5NF6F
         TnCQ==
X-Gm-Message-State: AJcUukfETNPdGr6HOyZZfz2gVD0Nxa/Hl/PrK8s8ztLJGyNEkuDsKrxR
        24qLRK5XOzBBhVGHzxtFytY=
X-Google-Smtp-Source: ALg8bN7L2LXrkWkhgceO1siXsM/12lTby+znAVNU6D9SI53yI4VEE/sWmgnetw2UuZFEqENtYA420Q==
X-Received: by 2002:a24:b044:: with SMTP id b4mr12166782itj.164.1548740974099;
        Mon, 28 Jan 2019 21:49:34 -0800 (PST)
Received: from m-hyperV (50-47-88-57.evrt.wa.frontiernet.net. [50.47.88.57])
        by smtp.gmail.com with ESMTPSA id m186sm879621ita.2.2019.01.28.21.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 21:49:33 -0800 (PST)
Date:   Mon, 28 Jan 2019 21:49:32 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <20190129054930.GA1269@m-hyperV>
References: <cover.1548489092.git.m.maya.nakamura@gmail.com>
 <2fa660dc51189316590021c4ee8aeaac79b8270f.1548489092.git.m.maya.nakamura@gmail.com>
 <BL0PR2101MB09148DD8AB57D5CD2C41A797D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB09148DD8AB57D5CD2C41A797D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 27, 2019 at 05:11:48AM +0000, Michael Kelley wrote:
> From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Saturday, January 26, 2019 12:52 AM
> > 
> > Remove a duplicate definition of VP set (hv_vp_set) and use the common
> > definition (hv_vpset) that is used in other places.
> > 
> > Change the order of the members in struct hv_pcibus_device so that the
> > declaration of retarget_msi_interrupt_params is the last member. Struct
> > hv_vpset, which contains a flexible array, is nested two levels deep in
> > struct hv_pcibus_device via retarget_msi_interrupt_params.
> > 
> > Add a comment that retarget_msi_interrupt_params should be the last member
> > of struct hv_pcibus_device.
> > 
> > Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> > ---
> > Change in v2:
> > - None
> > 
> 
> Right -- there was no code change.  But it's customary to note that
> you updated the commit message.
> 
Thank you for your feedback. I will edit the change log in v3.

> Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
