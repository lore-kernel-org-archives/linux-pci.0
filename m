Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58203C67869
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 05:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2034F2087D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hYfd+ye0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2034F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJLNSH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:18:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeJLNSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2018 09:18:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so3221970pfq.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2018 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=UwuBMdn2VIVTVT9X1qTiX7FN9975DLuM9XO6zA0tq9Q=;
        b=hYfd+ye0xjpwCbddwqnbzk0c0ApqY26AyA32OQgit9RVDleelbaBCdsUleGdce9PRm
         YSktCKrGcaMCOnW+PMZYypOorkZtvGQDzqIkFYC97/EKClbs+wMR+ukLc0LZ13dKrqc7
         ulVU5pOYgDEljK/Y/WhBAJ18uGVuhevVEfles=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=UwuBMdn2VIVTVT9X1qTiX7FN9975DLuM9XO6zA0tq9Q=;
        b=bjIObkDdY3jUiRt2pkbT/oZo1pESiqtDguSyuy8faRdcWmtHgWdi9+0TiE4SY5GVCe
         s4KiaQghxw0naG4HhOTegn3PW/XlT9hLgauqDb3glRBMagkkkLQlaIXFBA/EogyLTBqi
         LuWiCGLDG9NqmmfxDbbFowHIZ+sIiS4eWSZcObzn8+Uo+dCWfoaudOkOK8i2haMkMxZ2
         6F5+NpqEvrLV6HU6ur0fIJ7Dl3cW1OKZCjAx+PCT+xatBDKxydREuMl1Njsa6kd5C7oo
         iqeOD+Q4B5FYqJFhVlOJGwKOOSz8RGSyX19AXOADU00TZNeKT+ZYvh1FnRtJq7cOgRMV
         2yNA==
X-Gm-Message-State: ABuFfojpoH27Ip4bZpVegnJ0qGO9TnT1IdR/lfwJOE7k+1VBCTvC+xGc
        3mC7GQ9covcwdckrVAynkwEHVGP3Tukgw04URgd2UQ==
X-Google-Smtp-Source: ACcGV60vo0ptaKlBOA/kYsLhjBbDAR7rZ9fQ/V2I0johfs3fPybM74AsTqc2zhl6t5b0HcOufZij3uz8jZL/L/4cbHk=
X-Received: by 2002:a62:7788:: with SMTP id s130-v6mr4632872pfc.189.1539323240422;
 Thu, 11 Oct 2018 22:47:20 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20180926213241.GI28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927070327.wvl5glb4c7gtjoa3@wunner.de> <20180927184746.GM28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927190959.dio4qwti3i4accjm@wunner.de> <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
 <20181001204051.GD142872@bhelgaas-glaptop.roam.corp.google.com>
 <20181002140443.GA120535@bhelgaas-glaptop.roam.corp.google.com> <CA+RiK65MkxcHapivDqcGC5pM=OL8MHN3nk58_kxmS-hsKCGWkA@mail.gmail.com>
In-Reply-To: <CA+RiK65MkxcHapivDqcGC5pM=OL8MHN3nk58_kxmS-hsKCGWkA@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFBUqZXEDZ0Ud70cAeEw6Wvjo9uEQI0XrumAbcSckACilsm7wHKQQOcAPZxilQAudzfcwJS/lY/Adig7scAvtoG9aXKYUVw
Date:   Fri, 12 Oct 2018 11:17:19 +0530
Message-ID: <4829012be7988318dcfe406a79cc5e35@mail.gmail.com>
Subject: RE: [PATCH v4 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        helgaas@kernel.org
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com,
        Oliver <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Bjorn,

Please provide your valuable suggestion/reply here.

Thank you,
Sreekanth

-----Original Message-----
From: Suganath Prabu Subramani
[mailto:suganath-prabu.subramani@broadcom.com]
Sent: Monday, October 8, 2018 12:15 PM
To: helgaas@kernel.org
Cc: lukas@wunner.de; linux-scsi@vger.kernel.org; linux-pci@vger.kernel.org;
Andy Shevchenko; Sathya Prakash; Sreekanth Reddy;
linux-kernel@vger.kernel.org; benh@kernel.crashing.org; ruscur@russell.cc;
sbobroff@linux.ibm.com; Oliver
Subject: Re: [PATCH v4 1/6] mpt3sas: Introduce
mpt3sas_base_pci_device_is_available

On Tue, Oct 2, 2018 at 7:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Oct 01, 2018 at 03:40:51PM -0500, Bjorn Helgaas wrote:
> > I think the names "pci_device_is_present()" and
> > "mpt3sas_base_pci_device_is_available()" contribute to the problem
> > because they make promises that can't be kept -- all we can say is
> > that the device *was* present, but we know whether it is *still*
> > present.

Bjorn,

In the patch we are using '!' (i.e. not operation) of
pci_device_is_present(),
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
