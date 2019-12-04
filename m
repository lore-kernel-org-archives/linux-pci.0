Return-Path: <SRS0=0eF7=Z2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B4C43603
	for <linux-pci@archiver.kernel.org>; Wed,  4 Dec 2019 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426E020803
	for <linux-pci@archiver.kernel.org>; Wed,  4 Dec 2019 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbhaO1dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfLDT4P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:56:15 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:35807 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDT4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2019 14:56:15 -0500
Received: by mail-il1-f171.google.com with SMTP id g12so709622ild.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Dec 2019 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y5s64cDULUztNcj+XAj5kwGyOnu+jNjLT/oyzvuGnI=;
        b=lbhaO1dQlgHzGQ5/4HMIQNpdlZiHVoUDGDV3tjj+/pi9pCZkoep1cf8V5QgBeOuDIc
         toI/ovwS4rTeWE1+5kTjhxxL6kjb470G5qpiOx7GJiwRRr6VnK7pFMMvyeGZ35NguKoc
         ZUYtXiubBjwoKVFPdR+LKkSzD6rZPTo+nxA0wQPPlcAVH+nMhxUHeaitXbcgh/QZK0AY
         WnhjKU90RXxBnb3PtXqXI0cB8HPWPyhA19OAc1qwA9s0xDr/R+VedqHa6C8WpX2sS+Rc
         ioOvWq9xQCNBh9qS+xGfoOIkcnncMmOVcioOtRdojOpxJJwOmFY5Jbgl8UjtXOyrT5JU
         rtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y5s64cDULUztNcj+XAj5kwGyOnu+jNjLT/oyzvuGnI=;
        b=HNJNyXc3YHFv37P3GhHVSCn0hhamp1G4pq7eqjPFdqSrrpuZ+JMhtoguMuW26tYd1r
         OP+4q7MjwdMlgYIHdw0jPNF43tGedjGFER3Y8wocIapyB91CXH0QjBW5YKhYcEr/eeoN
         xB6TIxMH5FqQSbV/oWOCAvqureTgCA6dbaJpvnNd77gguNGacUGNNduw5uI451IQGYjv
         baCxaZ1e9HnKehAxvm3XDv3x9fIK+2knf3h1L5RBXGHWRU25x3NhYvv1CqbH6t1xz23U
         86WpnFdULH9acDXj733xkFvBQhsJvTw7AIYbzxqZSobPpUSr15QhwYZGbeQ8wpX2u5Gr
         2UsA==
X-Gm-Message-State: APjAAAVaVC123IpmGL+OH/W0lg4RklficKAxERLArKGcqtwVsiWVmGYk
        xzakaAco5ne6klUNWKOPF/ancXGWeeOT7TLrTMa+pg==
X-Google-Smtp-Source: APXvYqwcACr24vKI7KQDbUQ+bw+TFSeLsgeQxf8+wvOA5AzZx+sH5UELtEFDWXQ2Polwg3Dv76CvaUjj30dIjMIEWnY=
X-Received: by 2002:a92:d609:: with SMTP id w9mr5538958ilm.46.1575489374145;
 Wed, 04 Dec 2019 11:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
 <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com> <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
In-Reply-To: <CALCETrWZwN-R=He2s1DLet8iOxB_AbuSGOJ3y7zW=qUmx33C=A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Dec 2019 11:56:02 -0800
Message-ID: <CACdnJuvTR2r_myJX2bQ8XTDw_HxM-EgqhVLaUJVCa+VQS+6Qrg@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 4, 2019 at 11:50 AM Andy Lutomirski <luto@amacapital.net> wrote:

> Wouldn't it also be applicable in the much simpler case where the
> firmware hands over control with no IOMMU configured but also with the
> busmastering bit cleared.  Does firmware do this?  Does the kernel
> currently configure the iOMMU before enabling busmastering?

We already handle this case - the kernel doesn't activate busmastering
until after it does IOMMU setup.
