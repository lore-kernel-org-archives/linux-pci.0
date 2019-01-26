Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2CC282C0
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 00:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2DF218B0
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 00:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iem6TZp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbfAZAWz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:22:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38402 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZAWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 19:22:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so5473104pfi.5;
        Fri, 25 Jan 2019 16:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmQF2ztk6C7oZdxNx9BxsKJ6l7A6BuJIUZ1aFfpxZE8=;
        b=iem6TZp/VhSCjsUsdvV+GxJK3d0ksfif6hLxmm6yqAeDQJcHd9qUo6TMcHsXcQADF6
         1HHptX1/LfshZR2MnFKUXCQvwaM7yLdBmGN7UX/1qtgwA0OPaxKrGlzSvhv0hWOWKZNe
         jBkK56lsNbI5Lni5IW21tgV950LjgTBRT1c2VOiUm5fILMVLwMvp9HEa4m5ftxdUm909
         GEWeQfhWxj/lSCxbmyGzbur9fjS19vJ09x1s+hvlZju0RxqlCrMxHHApVaYUFrGlaylx
         mz5O6EZEjDSd79hOzKl3VdthwLlOwDuVlDuHXv81IuiQtL/rYa9hMDBqv/h8yMCMMdZP
         Pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmQF2ztk6C7oZdxNx9BxsKJ6l7A6BuJIUZ1aFfpxZE8=;
        b=Wt7zUBWgVsziOVzJnOzwSUkJUAkhb7rE0QRcjtQOUywhR+e+gciXvV5Jmq7aK4y3un
         JFt4mq0ZKmHlE7N8TAOdFC+Yc22/WT4r6SMFFOukB9+fngGOvpE3Qh0Rl4pZDtqKFdIp
         zQkt5IWGd8ayszn22XV78y+DPNC5jSvSyo/s1PlwHBn0DMNOdAehECbLaQgmzVBvD32O
         H2nyy5WhsFuCSid1Hl3a2CJ8g7N+HzYxdc4hXGUmwPrZQ2tcf2+rdB7zv3dJXfIu+HyI
         3H3Pz5ua/gENFlAgbKb5Am9oh6MgGlTHlYCMV1Jqgt4kBgXjgiCBlrrWX5x4Yp8YR3Dh
         7jxw==
X-Gm-Message-State: AJcUukdosrVGxbL+Akr6aoWPR9MkX8UQ43wPC2f0H0Olt1BT4XqE2xiP
        BQjg6361a6Fe1UZQVuauutmr1bTsuDA=
X-Google-Smtp-Source: ALg8bN7MQIt54+cnjIVfkaOHfD8KheRLSbu8lbn7/WoqhZ6X+GO6T/dt6AGVwCHyZ/WFrapkw6EOtw==
X-Received: by 2002:a62:4641:: with SMTP id t62mr12892535pfa.141.1548462174338;
        Fri, 25 Jan 2019 16:22:54 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id r66sm41369677pfk.157.2019.01.25.16.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 16:22:53 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:22:52 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, marcelo.cerri@canonical.com,
        vkuznets@redhat.com, haiyangz@microsoft.com,
        driverdev-devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <20190126002251.GA1837@m-hyperV>
References: <cover.1548232616.git.m.maya.nakamura@gmail.com>
 <885d207cd90a558364d611e4ebd64a87aa8962d7.1548232616.git.m.maya.nakamura@gmail.com>
 <20190124122918.GL4482@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124122918.GL4482@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 03:29:18PM +0300, Dan Carpenter wrote:
> On Wed, Jan 23, 2019 at 01:02:12PM -0800, Maya Nakamura wrote:
> > @@ -908,12 +906,12 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	struct retarget_msi_interrupt *params;
> >  	struct hv_pcibus_device *hbus;
> >  	struct cpumask *dest;
> > +	cpumask_var_t tmp;
> >  	struct pci_bus *pbus;
> >  	struct pci_dev *pdev;
> >  	unsigned long flags;
> >  	u32 var_size = 0;
> > -	int cpu_vmbus;
> > -	int cpu;
> > +	int cpu, nr_bank = 0;
>                         ^^^^^
> No need to initialize this to a bogus value.  It's misleading and it
> turns off GCC's uninitialized variable warning so it can lead to bugs.
>
Thank you for pointing that out. I will remove its initialization in v2.

> > @@ -953,29 +951,28 @@ static void hv_irq_unmask(struct irq_data *data)
> >  		 */
> >  		params->int_target.flags |=
> >  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> > -		params->int_target.vp_set.valid_bank_mask =
> > -			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
> > +
> > +		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {
> > +			dev_err(&hbus->hdev->device, "out of memory");
> 
> 
> No need for this error message.  alloc_cpumask_var() already has better
> debug messages built in.
> 
I will delete this dev_err() in v2.

> > +			return;
> 
> We can't return directly.  We need to unlock first.
> 
I will unlock in v2.

> > +		if (!nr_bank) {
> > +			dev_err(&hbus->hdev->device, "too high CPU");
> 
> This error message is not useful.
> 
I will delete this dev_err() in v2.

Maya
> 
> regards,
> dan carpenter
> 
