Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6817C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9A520850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ny3JbFc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDLNzs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:55:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50964 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLNzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 09:55:47 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so750458itk.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2019 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gquYWNtyiDFD8zSco8VAHGlZ70+bwhOA4CR36IIQ6XU=;
        b=Ny3JbFc0iF6R15kjcoljJv37xxY89PDlkGJPWRWwpNG5BfGJAQqaUoPdjiLcNdJPiv
         sWrmj9FsJdyc3CnwBP12KUYfEq1fIQ8GqC6b5LeLr8U2hs5if/dXKPqQ3ZPsIUTd4t2s
         wilS1pG9dqwExpJ/Qbjgp1NNHow28XojADA7SrG0WJeXMwabTD4/xUJDxd2YMhI2BOyo
         rc0XlAmn6eab1RRzkMOxoSdXOJZgGdatxh4H3bkGDwuxMPQAvAVkMA2Vjm35qIpZI8FD
         Nw3qnbFZ9Gz2L9TpFyoN5JWHG43ihtNAh3WIQee30P8UyyBrVh+ED3hiG7TlJjb5+V9u
         dEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gquYWNtyiDFD8zSco8VAHGlZ70+bwhOA4CR36IIQ6XU=;
        b=gx4UgTsXNoCPDulZqvYUZYcJ+W7JJjLS9okkAQbMgZ14xSiRIH389mJd4Iav3J305k
         4TKFNVmh5VzfurxdrEI23JALqmMB/+vyJJ31f5mEA6Nx7n8ocWRQoDo3RPffG9JUzbNt
         EWjP0VXtqywQtLWowD49elNKQzbz9ZD03Djud4VOLSP3rjDeGDbewFXDUqIFzRxBAp8q
         yvU7QFzXNmvx26CKzS4r5BG1kohPPMIVaIAT5SiAHDlMcnSz2MqVEtbVCp7QtHSvrevc
         3wbX2JUWuhcu8M+V6z5zuUjd3p+3Qxy/hm42oXpe6+pyL8xEgWTQoT8JuIcIr3o0HzSH
         cU2g==
X-Gm-Message-State: APjAAAVeG0WbCoIOTVEPmXGIzt7xVRdYMfBy5ni/brJHOXkqNidzbdmw
        JL4Srltwz5RRvBfdjReiwWLyhg==
X-Google-Smtp-Source: APXvYqw2iU65ywMDghRwip175i90q4YoX8jZtKU0ScVQEc5KOia1FNYfFqg47xxNM+NYtxdDXY0q5w==
X-Received: by 2002:a02:a083:: with SMTP id g3mr41339053jah.44.1555077346987;
        Fri, 12 Apr 2019 06:55:46 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id m132sm16587434ioa.53.2019.04.12.06.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 06:55:46 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hEwee-0000zW-PD; Fri, 12 Apr 2019 10:55:44 -0300
Date:   Fri, 12 Apr 2019 10:55:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Message-ID: <20190412135544.GB3765@ziepe.ca>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com>
 <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
 <20190411182938.GB14495@ziepe.ca>
 <A503C24F5B2FB844864C0DD400A8F742121C859F@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A503C24F5B2FB844864C0DD400A8F742121C859F@ORSMSX108.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 08:37:53PM +0000, Arumugam, Kamenee wrote:

> On Thu, Apr 11, 2019 at 06:22:45PM +0000, Arumugam, Kamenee wrote:
> 
> > This is a device bug then. 
> 
> > A RDMA device must accept and respond to all TLPs that the CPU could create for the user accessible BAR pages.
> 
> > A user process must not be able to crash the CPU or make the device malfunction by accessing the exposed BAR page. This includes a broad range of topics, like mis-aligned acceses, SSE instructions, atomics, >etc.
> 
> > Is blocking AER even enough here? If the device isn't generating a reasonable reply I have a bad feeling worse will happen.
> 
> After blocking unsupported request error, we don't see any other issue including no system hang. 

Are you specifically testing all the special TLPs the CPU can produce?

Jason
