Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F9DC282C0
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 00:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D85C21902
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 00:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZChaMIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfAZAcn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:32:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33824 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZAcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 19:32:43 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so9205641ior.1;
        Fri, 25 Jan 2019 16:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u1SO7X4mwgqbFZQSq726atHOE/SZQX/izHCcb6UexKU=;
        b=gZChaMIx+qvp5NiDGib9haAgnpUXt8XjvfDjby/cmh6myHqGFV3zJHURkDACr2W/dz
         WaHPDv31R7dD40hBNq1i6kV2O70DyNbHxw8jotcIYElGCEsczXWXqQAaonJwGtupltvg
         hAPC4mDpaQgjZ46/pMFglTLqJu+YSWmkf1/zPbydQAi5aS3qTazk54nSsNmMOlzYVF+r
         bN930EDLrGb/7eTWbhmm0Hyocz5/T8VRo1eaYK/kjr+JfSIcv/iWITgkz01oq+psbqlr
         ZjA2ATZVuFojyEnjGxinYEuShrIvMWIGenK/IVmM2KEzF8i95SkpCbl/wgz/JOvAa6V5
         QGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u1SO7X4mwgqbFZQSq726atHOE/SZQX/izHCcb6UexKU=;
        b=pOT3F2jzgB8kg+v1mQco10nt72rfOHSUSlOBalxXWwNlRYMS4HsVRpQWjDwEFj511z
         DsBpiEssEIINcT31EOzwVBci4o7TGyLUXWJd+ZO9/i6QO50Mmwx1bGqJfYEOiqMCkSsD
         Dd4wC/runryKE6wJphrZLz/DZ+dNZCQwHHmbDY3IjdfklRVsXotVwiBKkq14mne7sf3w
         Huwl+Hup9VcMqtGVun6ezNfaWW2u2sdhIeiTmQS5YkLLVeZFMRanniXCBXqormK4SS0l
         VhqompETKrcL6HGzeAIGIW8I//GuQI9pTevzrSJ4QPY2OypicfWXkSOpbPK7IoBSlEno
         lFfw==
X-Gm-Message-State: AJcUukeD1fK4B/QuVYEsTJDDzD5xvRTfMShNhlKzyDWVUV1XrabABLUX
        xByyl3NQayVxlZoIqh+oBvc=
X-Google-Smtp-Source: ALg8bN4wH7X6iJ6v2NLYLjUemrrYY2/i7hrJL4W6diNbmqmVjXM/+y7QQ9cO5B+TSVlkzGuQX95/sQ==
X-Received: by 2002:a5d:81c3:: with SMTP id t3mr8410890iol.93.1548462762363;
        Fri, 25 Jan 2019 16:32:42 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id 134sm13679261itl.25.2019.01.25.16.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 16:32:41 -0800 (PST)
Date:   Fri, 25 Jan 2019 16:32:40 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <20190126003239.GB1837@m-hyperV>
References: <cover.1548232616.git.m.maya.nakamura@gmail.com>
 <87ffdc2eb0642301516378feb1416cf7450bf6c1.1548232616.git.m.maya.nakamura@gmail.com>
 <87sgxi19oy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgxi19oy.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 02:12:13PM +0100, Vitaly Kuznetsov wrote:
> Maya Nakamura <m.maya.nakamura@gmail.com> writes:
> 
> > @@ -460,12 +454,16 @@ struct hv_pcibus_device {
> >  	struct msi_controller msi_chip;
> >  	struct irq_domain *irq_domain;
> >  
> > -	/* hypercall arg, must not cross page boundary */
> > -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > -
> >  	spinlock_t retarget_msi_interrupt_lock;
> >  
> >  	struct workqueue_struct *wq;
> > +
> > +	/* hypercall arg, must not cross page boundary */
> > +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > +
> > +	/*
> > +	 * Don't put anything here: retarget_msi_interrupt_params must be last
> > +	 */
> 
> This change seems to be unrelated and not anyhow described in the commit
> message - or did I miss something?
> 
Thank you for pointing that out. I will add why it was moved in v2.

Maya
> 
> -- 
> Vitaly
