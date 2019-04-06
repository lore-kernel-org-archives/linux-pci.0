Return-Path: <SRS0=JDZy=SI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225BBC10F06
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413B21855
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530801;
	bh=i1khhDzOfk0T1cPyQEKgGWFF1xbet5wTpW33ptOdR0w=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=ZZidMi71S1PcG3h59c2FfJbc5spSyIC43ADvBuD4aHhOrjAJndCTtQFq2o4FoJ29h
	 t5EHy8JegjspuB5zfsxPxRqQmABnxCd1jN00aSlWVD2/s4jbWmQnOCcKq6gV7rd5H5
	 fzXxKBVZtORsqd/5yeI8vNJB76iIEO5bCkJWLOzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDFGGk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35029 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDFGGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Apr 2019 02:06:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so4203428pgf.2;
        Fri, 05 Apr 2019 23:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=WAMthSx2bU8mDIQ4mLRHADFVQjt6SyB35RFmOBugveY=;
        b=QhsolZb8Vsqe18h1eWgLzP3JkQGLQwGULSEOIh324C/eAAjzt++Iu2IiQnrhRP8zlb
         QTHnNbgYYO/FfkGBM5uLl8OM++lsbQLdOsMtDvsNVSnaNbi5+NGCqL+u9j2zVuUVF5EP
         b71JeLMbiMbRBmjBx5fSeendVqs8YCH8d1RRD8JJHssbrGXCvD0IgbCGvZl3yXiIzCqv
         MOhkl1pjniOWlF2O/bRqxnbt5WCIHPalsPlS5/wqPrGgt+0i4cWLtPrBTwHpPRJ97g+L
         GHOcfnalHM2qlbxeLUbZfIkQXOxfJSDFOto0Bp6ygV0OQ/xDhFGjVwGYuPNrA9niisoQ
         qrkw==
X-Gm-Message-State: APjAAAVx9zoNltGyNEi79l4jP+PVdqXKo54Qoz/5iPm8n5/ejCFGSXpS
        POSglPkBWBjXvaxFLyL45g==
X-Google-Smtp-Source: APXvYqxY7GQRwDKWFTGU9iyr4W/yDm+rltYiGaW0azH1NoZCHipp0sqi/1+yvjaOyxRhZObNt6oiBQ==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr16335915pgh.199.1554530798942;
        Fri, 05 Apr 2019 23:06:38 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id f71sm16850074pfc.109.2019.04.05.23.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:38 -0700 (PDT)
Message-ID: <5ca841ee.1c69fb81.1ba7b.707f@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:36 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add external-facing PCIe port property
References: <20190402131548.41949-1-jean-philippe.brucker@arm.com> <20190402131548.41949-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20190402131548.41949-2-jean-philippe.brucker@arm.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com,
        Jeremy.Linton@arm.com, Robin.Murphy@arm.com
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  2 Apr 2019 14:15:47 +0100, Jean-Philippe Brucker wrote:
> Provide a way for the firmware to tell the OS which devices are external
> to the machine and therefore untrusted. The property can describe for
> example Thunderbolt and other user-accessible ports, which should always
> have the strongest IOMMU protection.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

