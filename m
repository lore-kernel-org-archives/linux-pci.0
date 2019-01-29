Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12913C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 05:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDF20989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 05:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7fyfFUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfA2FxB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:53:01 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36052 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfA2FxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 00:53:01 -0500
Received: by mail-pf1-f173.google.com with SMTP id b85so9177982pfc.3;
        Mon, 28 Jan 2019 21:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/SewdR6wKsBsNQMKun9e4VxMtE3JKxYJIEzVBfUPqc=;
        b=p7fyfFUXz0EzZrC8S+WE1MKGhZLI46DYsfaVFHYWOTzU2KAeeuR18N54O0frR/z/0D
         cb0uLxHj4UsZdSuxmcdPNG3MpqkHru9dmOMHG2VgJXtf7MJig+n6ChqZ9Tl+5z3475ss
         n4Bz88eUzY8uBqAGosMI7c7KAphyeCzYbKMeqyLNFvFvqQikeIKiDApp4BtmxSIjmDYn
         4SmmCpMyUdHGucrX+evr5Own6tAcxNp1j19R4DJKcy/g1uqnLUyu3ouL5ZY6n5shwxI+
         /UytOvdHnK0Hkf6WE3s8XiL3KJUc83XaM/X3TlXhNOdu1TwloXWxOJnq71gm2YillRir
         +UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/SewdR6wKsBsNQMKun9e4VxMtE3JKxYJIEzVBfUPqc=;
        b=ltAcs0WEplozTtABm9P+23nEBcOBma6Op9S0kAVAkGldX2GTanu85MNZdy0JAMy/1L
         5LJlJITarjsxSVFWUTaO0EuNmY5GkBYOOVPzsB48IgcN4dNorpr6WlzH2KFMbdY4c4po
         a7E9AeNUyJ/NRinVoTjLiiRyfoiKkdWxDzdV9YaoTNv4or7JrI/TLPgi9V8K4ewSdC0m
         SzjWx8DCLvtcYdljGSzaqYlpr8+eP2UL1d4bWsJkTELUgWSUxs0lw00SDoK/cn4v93Xb
         IiP1b8VwTVlDN8dLfHlTprObVrfOV3QyIISlHmfZHg7kTIevs5lExU5NAdGOVah47IpI
         hqjA==
X-Gm-Message-State: AJcUukfNrA1YOcHeRaSJByJg4z29QrzupjeetrfeZ371MilZ0pVR9PRy
        uipe/hvTfOooJaEfRd5RzlU=
X-Google-Smtp-Source: ALg8bN4zDFbVCsmw/apYj+XgxRTqFdNOTqTqs6d19EwKU/yva291BKTbZTrmpL8FXahFoWwSON68jA==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr24615422pfi.44.1548741180164;
        Mon, 28 Jan 2019 21:53:00 -0800 (PST)
Received: from m-hyperV (50-47-88-57.evrt.wa.frontiernet.net. [50.47.88.57])
        by smtp.gmail.com with ESMTPSA id c72sm67272735pfb.107.2019.01.28.21.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 21:52:59 -0800 (PST)
Date:   Mon, 28 Jan 2019 21:52:57 -0800
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
Subject: Re: [PATCH v2 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <20190129055256.GB1269@m-hyperV>
References: <cover.1548489092.git.m.maya.nakamura@gmail.com>
 <4b94f3bb88f56e4c5ca05c1c6ee73f9c6c6a88e7.1548489092.git.m.maya.nakamura@gmail.com>
 <BL0PR2101MB09148770FD324F4F14F4B306D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR2101MB09148770FD324F4F14F4B306D7950@BL0PR2101MB0914.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 27, 2019 at 05:22:06AM +0000, Michael Kelley wrote:
> From: Maya Nakamura <m.maya.nakamura@gmail.com>  Sent: Saturday, January 26, 2019 12:55 AM
> >
> > @@ -953,29 +951,27 @@ static void hv_irq_unmask(struct irq_data *data)
> >  		 */
> >  		params->int_target.flags |=
> >  			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> > -		params->int_target.vp_set.valid_bank_mask =
> > -			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
> > +
> > +		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {
> > +			res = 1;
> > +			goto exit_unlock;
> > +		}
> > +
> > +		cpumask_and(tmp, dest, cpu_online_mask);
> > +		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
> > +		free_cpumask_var(tmp);
> > +
> > +		if (!nr_bank) {
> 
> There are two failures cases in cpumask_to_vpset().  One case returns
> 0, and the other case returns -1.  The above test only catches the 0
> failure case.  Need to modify the test to catch both cases.
> 
> Michael
> 
Thank you for your feedback. I will correct it in v3.

Maya

> > +			res = 1;
> > +			goto exit_unlock;
> > +		}
> > 
> 
