Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B87FC282C2
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 00:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3521907
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 00:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="zzGI0QxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfBHAos (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:44:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43804 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBHAor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 19:44:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so592569plb.10
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2019 16:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wznN+y12reWBSQTdtzPZ8cy66iIKsaDRYoHm15ZaGBw=;
        b=zzGI0QxY/5HxBp+GWrZZSg8vA4nSkRm/76vCw4evx2Y6wNFZ7XG6/UlsRHoHU+ciCD
         pLcNl8zUxMAlD3xs60bCpC0sjGlhjVzeYsVmPuG+pQMAXEGMAR7lEm8FFV2x3PHvgTYm
         C60xJKezmS4pHl3dS0wDeUfpXp+gMgsSpIHPIEO7YTZGkrbVoxfbykUKAb8/w64z6F1T
         EB14nqHDNj7hj4jIIWnsJ0rzHzHQ+KQ3qDD87yNc7ScewIY5XUF0iX+YdE6VESP1a38z
         YLmcQN+FtxnllY/feEiWtG5mqfZTCP7R1uE3J9fPsdBjeO+KPnK/uMr7S0/Ph+4nZrwu
         v4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wznN+y12reWBSQTdtzPZ8cy66iIKsaDRYoHm15ZaGBw=;
        b=eKFy9H6vbt50k8ZcrLIOWZHjzIxEAlw8vkDMJBxIK/LQ/RCmluG6wzghJD5YpN4O+D
         WTYQnxOe/QCqHm9iUbb+J6a4YniD8sCE8NIGSaKAx/BpDMq29QojrHbRG5UKJokpTl4a
         XxIB0wpLhTJFjuaGvT1CrHPB7C2QvPkLqq/IYN+g0yH23xbyINuLTh/WzVAz411DU6rg
         MBaklzEhhhnWcdBkbIC52RuW2QrtX/W584Eewee0Uq54CvVHK1p1wlrVp3Cp/E+fviIU
         RU+e91QmKNeA8bDabpWytVMJXy7nCM9iadPaLYQuRNLXL/goRunrRAnOOvSXqDKVV1RS
         yt5w==
X-Gm-Message-State: AHQUAub7xttAOqDnVPkms2W6i5t6Tv4PvIrZK6BfUY19dwOrrYDG6DUX
        ZEg5iL8QekUc/J+By9CQRuUUzg==
X-Google-Smtp-Source: AHgI3IYTopvnKuoQw+oGntRfrKrOYUseWQ0d5U+pbGmEKI8EloUi2nT6TEliB7/lh2mN/ynhwrcb9A==
X-Received: by 2002:a17:902:14e:: with SMTP id 72mr19720850plb.287.1549586686992;
        Thu, 07 Feb 2019 16:44:46 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o25sm419861pfk.185.2019.02.07.16.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:44:46 -0800 (PST)
Date:   Thu, 7 Feb 2019 16:44:39 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Message-ID: <20190207164420.7f7c38fa@hermes.lan>
In-Reply-To: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Feb 2019 20:36:32 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> When we unload pci-hyperv, the host doesn't send us a PCI_EJECT message.
> In this case we also need to make sure the sysfs pci slot directory
> is removed, otherwise "cat /sys/bus/pci/slots/2/address" will trigger
> "BUG: unable to handle kernel paging request". And, if we unload/reload
> the driver several times, we'll have multiple pci slot directories in
> /sys/bus/pci/slots/ like this:
> 
> root@localhost:~# ls -rtl  /sys/bus/pci/slots/
> total 0
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2
> drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
> drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2
> 
> The patch adds the missing code, and in hv_eject_device_work() it also
> moves pci_destroy_slot() to an earlier place where we hold the pci lock.
> 
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>

Acked-by: Stephen Hemminger <sthemmin@microsoft.com>
