Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CDAC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01822086C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548866582;
	bh=lPBOYsEs8JxBZNGkW3vW7y1W+HAfHYWNbLTpf5JxzDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ziTa/1uEUsZiYPB8XLnutJo8QZt7U2nnv8VVmw4tTx2YTIk88XYyTzomNIC0xNtIY
	 UjP7HWnmagac0J5Vrv/BlWTT/rQZTqxICxeLULaiLb1NzPeUq4GbyvKZRuQ+a9kJUV
	 kXqkLP6Ls/g5PmA0XE6QW0cFHFYfsY1es8FU+kuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfA3QnB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:43:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32791 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbfA3QnB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 11:43:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so190187oib.0;
        Wed, 30 Jan 2019 08:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CY7nTY/8T1Ycsym2d5JXBXpnuhaUKp2zsdKKkwffbmY=;
        b=VQju7NJH4Oc4R1BrquYvTozzZTkmQQCjUwyAuvojzpk2mn3lsQ+kcD1FhhjOsS8vAz
         I/UzMsQuIAZpEI/jdsneq054FnZyh7lv8ifqrUEiYJKQKLI1O7CsazxZb8dpoKab0SUv
         Nxc2pkfgHDeRtRm/vg6sOOZwtx7vgo2gsYUmGDe02aT+2eeiYNqyqsvJT8CFOJmzjMXC
         nDpcJN7nk/DrWkh9iwgzhXuCy//EBuCiZfqKjEy6czsntDAFQp/jZb0Q+Aq33GRHtnKs
         /gILDgM4VTyBPBAiKwZwX1+qVZLiCrxXgmhP3FAGTJIEJrinbDCCmYP7sNUjVIOE10e6
         8WZg==
X-Gm-Message-State: AHQUAubcp9Pt4RSynl22KQ1unzyNrmZftH+I/tdtV7dqwFeWrMcY1tz4
        st2RAdD+oO88BsFN7ytmkg==
X-Google-Smtp-Source: AHgI3IbGmpBZyciBWnKQ2UHsO3J7DKVZp+2R7MDdSUMtLm/5l14bJX/iLcfedSZXuE2ml0adjKo6vQ==
X-Received: by 2002:aca:c312:: with SMTP id t18mr13451373oif.92.1548866580105;
        Wed, 30 Jan 2019 08:43:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm780979oil.15.2019.01.30.08.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:42:59 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:42:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: dra7xx: Add properties to
 enable x2 lane in dra7
Message-ID: <20190130164259.GA4191@bogus>
References: <20190124082957.29077-1-kishon@ti.com>
 <20190124082957.29077-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124082957.29077-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Jan 2019 13:59:56 +0530, Kishon Vijay Abraham I wrote:
> Add syscon properties required for configuring PCIe in x2 lane mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
