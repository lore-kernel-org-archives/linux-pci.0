Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A8C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D053222CED
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566932041;
	bh=S2iNYboOs/JV+sv5ni6/MgAlBU8bZlXuuJwhs21Z9es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TSkpkKp9fPAbw9P2N8sacb8+g6QhTz5KlrBGhQMihDOkDzMFq3aiPIAArQ71k778s
	 mixOMoFAWGLlLhJ5Utv8IHD63zwZDGbKJkEtxec7KW8K+cSKjt+FY9nwoATlB43wsP
	 ko3iwKfduIjAJiAZHn91zLTqGNz/7DZ9muHDAir8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfH0SyB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:54:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46349 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0SyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 14:54:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so144416otk.13;
        Tue, 27 Aug 2019 11:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N7oNktNQAUJH+sUHR0NB6EzuIGhp5QVB1/RE4ZususQ=;
        b=U1+xEInR37D4PbXFBM/4nPkBzcRt/4uhJepXmOx94G72ERhAHWT9arpCoj5dBSMBCY
         gmjRDHC3C0CKRsqF7etqwzjThz0Dsz+u3ZxXZMQKdVAA+WtNxnhbGE103tKzbUIm3LXw
         9J7FpwbxX2ogRugbyc6iHArmZdLkjtwRMUyJXFQv69ISUPrl247DJJ3MH/S+6+CqXyF4
         DINxy1liwj6UytMzv3dgUd4KtIqd1rsFk0spzngdQohX5q6vSz/g2NxJ/eiEBztaA9hT
         Xf/oql/x5qgfZPkaEzs208QQvc1pplO/KJCw+AJS/3u6OBXtDR7Tbp/YO18HSvseokvj
         q4AQ==
X-Gm-Message-State: APjAAAUa2u+PjhS37vQ/4aI9d/wftE3u3frIna1V8obSBQ1gDMpunXcU
        dmxxPB1pJHimpfKF3pR3jw==
X-Google-Smtp-Source: APXvYqysJkT3ZlMc3kBvdVSqg7vjs4HFGv+NzrWjVBelfZ61WEOj5tO22xXj2jDmx/odK753dKDh+g==
X-Received: by 2002:a9d:390:: with SMTP id f16mr41363otf.93.1566932039790;
        Tue, 27 Aug 2019 11:53:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n32sm65214otn.61.2019.08.27.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:53:59 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:53:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andrew.murray@arm.com,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, alisaidi@amazon.com,
        ronenk@amazon.com, barakw@amazon.com, talel@amazon.com,
        hanochu@amazon.com, hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonnyc@amazon.com
Subject: Re: [PATCH v4 5/7] dt-bindings: PCI: Add Amazon's Annapurna Labs
 PCIe host bridge binding
Message-ID: <20190827185358.GA23134@bogus>
References: <20190821153545.17635-1-jonnyc@amazon.com>
 <20190821154745.31834-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821154745.31834-1-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 21 Aug 2019 18:47:43 +0300, Jonathan Chocron wrote:
> Document Amazon's Annapurna Labs PCIe host bridge.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  .../devicetree/bindings/pci/pcie-al.txt       | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
