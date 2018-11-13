Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE26C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 07:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CE32243E
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 07:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOA4XTig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CE32243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbeKMROE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:14:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37798 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKMROE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 12:14:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so10298581wmc.2;
        Mon, 12 Nov 2018 23:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjpTyhKii+Hn5/AOUl7Xd+8XHWn0qJXU4g7MOUx5pEk=;
        b=HOA4XTigUc2KgDhhQIUwTxxzCe6zft9gqptb19utqgcF+5lsZiBkVTJ3O6HThk4Hit
         w+RIqKHYOrv6tt/UUP+Y2u21pMHTfTJs4KaZy82sjTr7hin+TNl12pYhdvFbJ27Xw6P8
         9yCNp09vOWGmellRT3ETQOIptAYxA/PxgvXto8k20DcW9cRQAwjuxdS+vd7i9WwF06jw
         nKR2yjmE3vZjiBAOAKHvqD24WKlvbyJinNV7Vf7v2WTE+4sBZx5Y6VgcsvMrQ28zMdTi
         s0k7HOGYZ01S3hI/pQ5ZeCf0zWry8KzW+ZlXiDQ8Dqh3AwBnIrSv7Vi9Fu3g8CqsYbIa
         1A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjpTyhKii+Hn5/AOUl7Xd+8XHWn0qJXU4g7MOUx5pEk=;
        b=Ojm0JOljMFNNrbBWilKuPFtb8Rq+ByWQq0C1kHkQv2/S69/JXpxvhGrcpqNQuCRD6W
         1uRxcXnEaRIPJV+zlMGm7n+bSikFRnR9znj5dkxUElzAzBd9lIyg+09cGuSQD8LZAknu
         TeFCCQWM+2zZ9agm6NNphi6SfMqm/+2Rgc/mWoIl4F6q85XiLik30ZF5lyx5/PFyhE2J
         SnYcmiUdCsFw3Zm9KvcV7poiuv6cAJTi2nAK0d5trAieQJ8+CezfVtPXdvsfxbRbCjPh
         MhT7+5IL/T8gtRNg8QEvyDz85EWd/ORWUObcml7iExk9lMt6YwiCSUE9fSDsthsteV1c
         aEGA==
X-Gm-Message-State: AGRZ1gI5J1F5mC9qK6YbcfPG2ykXDPG59D6h7QVyf9GvE9fUQgD1V5Ai
        rp3gsQasdrqzjxMxtfjt4SIDewkp
X-Google-Smtp-Source: AJdET5dz/+bPZJ13jXlv/a+OWDzqTFN62lSm+J8lB1ZlCIKGRd6Py5vbAN/kOAr/OxSZFF0NjbggjQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6-v6mr2117821wmi.77.1542093436440;
        Mon, 12 Nov 2018 23:17:16 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y83-v6sm8342337wmg.13.2018.11.12.23.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:17:15 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:17:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] PCI changes for v4.20
Message-ID: <20181113071712.GA2353@gmail.com>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> PCI changes:
> 
>   - Pay attention to device-specific _PXM node values (Jonathan Cameron)

There's a new boot regression, my AMD ThreadRipper system (MSI X399 SLI 
PLUS (MS-7B09)) hangs during early bootup, and I have bisected it down to 
this commit:

  bad7dcd94f39: ACPI/PCI: Pay attention to device-specific _PXM node values

Reverting it solves the hang.

Unfortunately there's no console output when it hangs, even with 
earlyprintk. It just hangs after the "loading initrd" line.

Config is an Ubuntu-ish config with PROVE_LOCKING=y and a few other debug 
options.

All my other testsystems boot fine with similar configs, so it's probably 
something specific to this system.

Thanks,

	Ingo
