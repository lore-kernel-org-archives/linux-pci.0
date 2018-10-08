Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98BC00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932FB2087C
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 06:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QfBasqX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932FB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeJHNyS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:54:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeJHNyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 09:54:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so8789614qtq.12
        for <linux-pci@vger.kernel.org>; Sun, 07 Oct 2018 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxXzZzH/WuAUz2hsKhOq6X6eSW+Olg6W4tnfFIsFAAk=;
        b=QfBasqX60zFNglIEO+K4fGh7HNUS4C8c/vDPPOz6PVzpKYWLkO7yck14tb347iYaE+
         vR8h39giv5IVwRo2ama050liHxz1YAuZjuDNaR+hmcyBI+HkrlOXeFTrseFNq11VfigC
         +tnbSCEieszbHW4Qf1LN/0jI0EjWsHKnB+1O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxXzZzH/WuAUz2hsKhOq6X6eSW+Olg6W4tnfFIsFAAk=;
        b=LEUzcAchrEmL7v3ikoPGaklGi9XiG2V+2Mt8zDQzQ+z070odtujIk8c7362HvyPwJY
         UFFQBEbIMf1eXqdGD2vTFQT2Qa0ujasWIQAHodZfTnH0VZV2dvp3/s/XEcew/fW1OS0V
         G6sxe9Qi3R5QRIJ2AfLwxiU91mGA6rzacpEO7RKTs7gs6WEJSHlXBwLBQVkg/o38GkP2
         Jjl6c6I8bdcQVdg0ExHcKVFRmlyIAeElLWTgPuSX3RWAsqVRJzGM1sCgTLu5Tto2aJqc
         MXdKkO4oTT94n9unP/HPheniXEgDQcHHmImy5pIbeKOBEGrci5TgBCBZPgeBiKjqRpd6
         aDQg==
X-Gm-Message-State: ABuFfojxVP//Nk9uZ8uTGPoSowh/VwWB9fz2a6sBl7onm76Mpa26Y2yW
        b5wWCDo8DMMlixeX0vPIlR0R1Q7aSYSKFB+m6fEKAIyX
X-Google-Smtp-Source: ACcGV61xfy9iAFX9FPUVbrMkdxqFtq6aZ0EbS7TGr5H1COTq6ENLP8PLb4wgu56uypQvC9SpMNuPJGxyyifmqNyTa5I=
X-Received: by 2002:ac8:256e:: with SMTP id 43-v6mr18120164qtn.88.1538981047551;
 Sun, 07 Oct 2018 23:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20180926213241.GI28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927070327.wvl5glb4c7gtjoa3@wunner.de> <20180927184746.GM28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927190959.dio4qwti3i4accjm@wunner.de> <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
 <20181001204051.GD142872@bhelgaas-glaptop.roam.corp.google.com> <20181002140443.GA120535@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181002140443.GA120535@bhelgaas-glaptop.roam.corp.google.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Mon, 8 Oct 2018 12:14:40 +0530
Message-ID: <CA+RiK65MkxcHapivDqcGC5pM=OL8MHN3nk58_kxmS-hsKCGWkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     helgaas@kernel.org
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com,
        Oliver <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 2, 2018 at 7:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 01, 2018 at 03:40:51PM -0500, Bjorn Helgaas wrote:
> > I think the names "pci_device_is_present()" and
> > "mpt3sas_base_pci_device_is_available()" contribute to the problem
> > because they make promises that can't be kept -- all we can say is
> > that the device *was* present, but we know whether it is *still*
> > present.

Bjorn,

In the patch we are using '!' (i.e. not operation) of pci_device_is_present(),
which is logically same as pci_device_is absent, and it is
same for mpt3sas_base_pci_device_is_available().
My understanding is that, you want us to rename these functions for
better readability
Is that correct ?


> Oops, I meant "we DON'T know whether it is still present."
>
> > I think it would be better if the interfaces were something
> > like "pci_device_is_absent()" because that gives a result we can rely
> > on.  If that returns true, we know the device is definitely gone.
> >
> > Bjorn
