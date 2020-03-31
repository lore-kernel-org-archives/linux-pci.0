Return-Path: <SRS0=o29A=5Q=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22062C2D0F1
	for <linux-pci@archiver.kernel.org>; Tue, 31 Mar 2020 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81EF2145D
	for <linux-pci@archiver.kernel.org>; Tue, 31 Mar 2020 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585675880;
	bh=LrlvlkBHzKr4kNUrsHdL37Oi8I8cGKR0DyRleNsADMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oynlmwvo4Lge5DlqXDP/xr8avtuvSbYHNDjTneq1foe84UIF84xYvHPDJJaKZ4/ep
	 61RpDu/fQq/y1i8wTN50lde0C7IdQXy19PfuhL1xOz/ZxPrtdRmaYI6RTJShz+Y65s
	 OrmgqryocGSK1J0eSVsepRhFdpWdK7gMgY7Rpkho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgCaRbT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:31:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36048 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgCaRbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 13:31:19 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so20205968ilp.3;
        Tue, 31 Mar 2020 10:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOTCNUk68yaP4O0Nf+1SblIe6EhJPxK+MXCIVbgI7xw=;
        b=fqUmCtyzKdRzIl0t1MV0d9m5lVg2QKHOj866eJVbAYv/M6azwZu4oeDCqUDgm57uf8
         FxdUKjwt22isMOJgRKzMwlt8K8df6YArGK2WBd7/VBRBmVXBZp7+pMKq9X6pjSibQ2UZ
         YUcb80TJKLekj28AGPJmrZBIRDlSxZLU29s+rDRRrbBOH9AGhYKBaoxjW1657snXBwKt
         uPPSPTgVfk2nMDOf9POYG2NguxVGTZhnliDoIQgl/HPTY5Tc1OMpSEQ/aX5cC0LPnTET
         EorgWnJF4r8EwblEYxM92vkSZS+NitY8i35CygFB67jpOxqruWYvobqozDI1QKwdr1cm
         jQAg==
X-Gm-Message-State: ANhLgQ2vDgllnNPssnB0Q/QEQ3/+eFL18nbFewJMzQrJ4YwkqipbgGB+
        LgXYGgcOXepHUxIqG8DLEQ==
X-Google-Smtp-Source: ADFU+vsJ3SRvLgsjMo8ev6bvl/vR8JNGcpIYqXW44ASNP343cfmpNV7O5DOHMpwI2Xmc5o9QPr1qmA==
X-Received: by 2002:a92:cf47:: with SMTP id c7mr17842611ilr.88.1585675877991;
        Tue, 31 Mar 2020 10:31:17 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t24sm6088325ill.63.2020.03.31.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:31:17 -0700 (PDT)
Received: (nullmailer pid 25591 invoked by uid 1000);
        Tue, 31 Mar 2020 17:31:16 -0000
Date:   Tue, 31 Mar 2020 11:31:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] devicetree: bindings: pci: add ext reset to
 qcom,pcie
Message-ID: <20200331173116.GA25528@bogus>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-6-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-6-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Mar 2020 19:34:48 +0100, Ansuel Smith wrote:
> Document ext reset used in ipq806x soc by qcom pcie driver
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
