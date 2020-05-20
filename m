Return-Path: <SRS0=tlVJ=7C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0CC433E0
	for <linux-pci@archiver.kernel.org>; Wed, 20 May 2020 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E73220829
	for <linux-pci@archiver.kernel.org>; Wed, 20 May 2020 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590008444;
	bh=0Z2v/kefoBkdkREWhRlzmZEWpLGErHE5PSYbD4AGoJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DYNWd6B4mcFbuQWQ4w+nNg+ZuwdIM84fR+LKvQhZsOWUmiPKrMMicRtWC0L19Xto
	 0XFZ6sBzdR4QoA0RqVbQZDuzMpsa1rz8HteFGR8O/KJMaEneMnmzEln1TPBob0nG1n
	 4PyEAzl44PZCN1SlRVsU+fREtDvNTUqA40OoNVnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgETVAn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 May 2020 17:00:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44562 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgETVAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 17:00:43 -0400
Received: by mail-il1-f194.google.com with SMTP id j3so4734281ilk.11;
        Wed, 20 May 2020 14:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22KntiyCXX5NTzrXlSNQxxRBUuFEA96HmLFnfqb9gVM=;
        b=pt77CnfS01b+HKYSsttsUhi6AydRi8UNQm4Va/z0FyMDX+P/2MtaYCMU2wBCG9P6/Q
         rM/pFrr0W9jZj0q39IlQA3+4UZbqK3kQpmpuwfdF/PpKK0IUQn6IHyKz/B8/Ffh/b6t+
         Ja0oIBM13XFG/vtFJQulz77cYgEZt+bQVExZpOuFjaPtkXhsXuPIsP1Vcm1cTzLf7KqN
         hzBoPi2oTpKyHCMwE2oCZAlWpiqRhUJ5WDQ+UXRcBZvHj9Q/lVcdVNQKiERH5NnBVzX9
         /VuJG8QluI75JfSHUV/X4wU652VxRMGaLKAqlqXovFJqawNyaiLzRRhFjjW5Vkb7HBno
         RxRA==
X-Gm-Message-State: AOAM532o4qEelbd3NU9Vg4rJjfSwrhNis7VivokgvN10DbQYPvvpq5fA
        t6QmEiqA6OC7bhxTHqn0Sw==
X-Google-Smtp-Source: ABdhPJyLyciyfc0BqWJ4DaAISOi4+9eI1wdPc6QhaXqIq19XB/lhFjiNex1IpZkrMVX9db1W0K6Dow==
X-Received: by 2002:a92:ba46:: with SMTP id o67mr5622645ili.66.1590008441917;
        Wed, 20 May 2020 14:00:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w88sm1933147ilk.83.2020.05.20.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:00:41 -0700 (PDT)
Received: (nullmailer pid 570764 invoked by uid 1000);
        Wed, 20 May 2020 21:00:40 -0000
Date:   Wed, 20 May 2020 15:00:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 02/14] linux/kernel.h: Add PTR_ALIGN_DOWN macro
Message-ID: <20200520210040.GA570718@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-3-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:17 +0530, Kishon Vijay Abraham I wrote:
> Add a macro for aligning down a pointer. This is useful to get an
> aligned register address when a device allows only word access and
> doesn't allow half word or byte access.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/linux/kernel.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
