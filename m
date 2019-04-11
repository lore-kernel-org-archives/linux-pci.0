Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E62C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C132083E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZ/XerVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDKS3m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:29:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38464 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKS3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 14:29:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so8302304qth.5
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2019 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+mWAyprOrUEog4xOHIMxAKBjMgvdmNhakLkR6iLN7Q=;
        b=SZ/XerVGc443kh4FlddTGeYDFe+BuEEGVCuKsGDxMgmjZjqsyzi0xL8sFwOxukLHCK
         hwuPrRnJ/HEDS39RWku1e2q972axu19uUXMxySTKzAsW3GzzX/bRZcYNF+UAHo/aLX6R
         l3osEWNAvzbwf/QnArdShyBm9/d4gHHOYKFLT8CYT2FECPqyZfUAqaQbEubM7ChLJZ0q
         ptve+CYy4DnXfqmfor/YXYTXMkcnl4gLwjBO0fud6ZA2kIUxjotKXQghM6XNyHKB0JpU
         hdrQX64PLcE3/3QjsKxNZDJLZqxF84bKdeHlYYywAVYvyrrdQydSelzB1Q3uBcogF7NM
         cZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+mWAyprOrUEog4xOHIMxAKBjMgvdmNhakLkR6iLN7Q=;
        b=tm4+m9g3S4UGZkFJHPCExISs8Av5E5oDh4h7CERufOsbnUUuPteTr7MgIajwXofaoz
         cvJOegtwMq1Pi0J0QKprRfKWNfabwZQVMGNEFS5kH67+aHCg+rgJ71cY/yf8ESGGL+Il
         mzXrH7Tj+cxiNWbK82bRJWIuRB8TZZ2cmrjkN3UrCwBBJ9yvhXfEDUw6ZdgKKEjfoxjM
         sDS5e604a221wEp1zE/mIHumc8GHkOjwTywGB7fcxPdjO2lxqEYQN85ArxELluWHX6y+
         37LXzWTqtNrVo2T+WhmKlsLvnKSW4UOWtbUnWrsdjttLfUXQ+IRexiUvhfOsv+sb6uFi
         Tl+w==
X-Gm-Message-State: APjAAAW1SO1fH87zSOWcyO4ajm3unylk7cC5J0VDwJ3heZGznA/mmfsD
        qdX6f2WOD9KHxFHLjb2ucBdfZw==
X-Google-Smtp-Source: APXvYqwFYRfE8aC+miwD5OZY4kbrvXR9Aret/En6N2mJSFyJFtI5zAujJYatI9Jxed+wtYPVa+tQHA==
X-Received: by 2002:aed:3f49:: with SMTP id q9mr44683764qtf.279.1555007380913;
        Thu, 11 Apr 2019 11:29:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g34sm28680505qtc.9.2019.04.11.11.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 11:29:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hEeSB-0007PM-0D; Thu, 11 Apr 2019 15:29:39 -0300
Date:   Thu, 11 Apr 2019 15:29:38 -0300
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
Message-ID: <20190411182938.GB14495@ziepe.ca>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com>
 <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 06:22:45PM +0000, Arumugam, Kamenee wrote:

> > What exactly is causing the UR?  Is it something the driver could
> > potentially avoid, e.g., an AtomicOp that HFI doesn't support?  I
> > have a > vague notion that InfiniBand allows some sort of direct
> > user-space access to hardware; is there something there that can
> > cause a UR?
> 
> HFI PCIe BAR are mapped to user space to implement kernel bypass for
> MPI/PSM jobs. In this case, user-level application is making
> spurious read accesses (invalid width access) to this memory mapping
> causing the device to report an unsupported request error through
> AER. The spurious read accesses may be due to errant application
> behavior (e.g. reading beyond the end of an array).

This is a device bug then. 

A RDMA device must accept and respond to all TLPs that the CPU could
create for the user accessible BAR pages.

A user process must not be able to crash the CPU or make the device
malfunction by accessing the exposed BAR page. This includes a broad
range of topics, like mis-aligned acceses, SSE instructions, atomics,
etc.

Is blocking AER even enough here? If the device isn't generating a
reasonable reply I have a bad feeling worse will happen.

Jason
