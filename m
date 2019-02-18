Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5065217D7
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 15:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfBRPam convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:30:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60641 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfBRPak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Feb 2019 10:30:40 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gvksP-0003be-VW
        for linux-pci@vger.kernel.org; Mon, 18 Feb 2019 15:30:38 +0000
Received: by mail-wr1-f72.google.com with SMTP id f4so7731415wrj.11
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 07:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WaGTEdXE+vaK7oGBKrOh7PwEqKyfMIF38YXf9nli32o=;
        b=QFJPYWoAyRB7oyExYbeCe7Z+G4V86he3GawHbMrYqXp+IBCuUjYNXIiV83BWXS7J6X
         5i/d0VzTQUtuPlVVGSAEBm5N6Q0ruPGe+A7IrlD1kCqF75soDE3ANZPQOvj2eptOcBjk
         JgOu8FHnpOz5hXdz07P9opO1b1qRkw2jnReWQ7ei66eD3g6MWrDcsn4vxc7icgO5JDwV
         SDtrNCKurIJOO2DAxnmtXNlGGA1MePZqI8Bro69/JdO1UY7xB6t+GojtK5ZierVOp33l
         eK656mg+YZnjI+gJQnSIR7T+BuYZpRBBdW+oRa0lzPNXem01moObr5Ub4CY3AklaHg4n
         3Csg==
X-Gm-Message-State: AHQUAuZrSGxGKCWNsGszTbUijTUSblr8+S/TTh/XdhhFhI60HPKKcnwS
        RrEEqxzYUD4dYgL9IMdfR8ITwtf1ljdHLSgcuO+EsldUNEgN55DEx6a20tKB+33yIw0zF0wwPkn
        XLJYlHOvqYuGLoxXe888Yz+F4S66Og5nwCR5Mqw==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr17364491wme.66.1550503837557;
        Mon, 18 Feb 2019 07:30:37 -0800 (PST)
X-Google-Smtp-Source: AHgI3Ibet73p/lCoxKJQxrESL6ViDpXsrEFnp4Rnvg7d6HFQC42HO6hCIeSvpNOeVI+vcyeWj/4iZQ==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr17364472wme.66.1550503837118;
        Mon, 18 Feb 2019 07:30:37 -0800 (PST)
Received: from [192.168.48.237] ([194.158.46.138])
        by smtp.gmail.com with ESMTPSA id b4sm9197416wmj.3.2019.02.18.07.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 07:30:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190204172057.GB9160@google.com>
Date:   Mon, 18 Feb 2019 16:30:35 +0100
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7070C6C7-AA47-4F5F-A456-7DEEA7405F48@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
 <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
 <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
 <20190204172057.GB9160@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Feb 4, 2019, at 6:20 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Sun, Feb 03, 2019 at 01:46:50AM +0800, Kai Heng Feng wrote:
>>> On Jan 28, 2019, at 3:51 PM, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>> 
>>>> If I understand correctly, the bugzilla lspci
>>>> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
>>>> at point 8, and it shows PME_Status=1 when it should be 0.
>>>> 
>>>> If we write a 1 to PME_Status to clear it, and it remains set, that's
>>>> obviously a hardware defect, and Intel should document that in an
>>>> erratum, and a quirk would be the appropriate way to work around it.
>>>> But I doubt that's what's happening.
>>> 
>>> I’ll ask them if they can provide an erratum.
>> 
>> Got confirmed with e1000e folks, I219 (the device in question) doesn’t
>> really support runtime D3.
> 
> Did you get a reference, e.g., an intel.com URL for that?  Intel
> usually publishes errata for hardware defects, which is nice because
> it means every customer doesn't have to experimentally rediscover
> them.

Unfortunately no.

> 
>> I also checked the behavior of the device under Windows, and it
>> stays at D0 all the time even when it’s not in use.
> 
> I think there are two possible explanations for this:
> 
>  1) This device requires a Windows or a driver update with a
>  device-specific quirk similar to what you're proposing for Linux.

I am sure the latest driver is loaded under Windows.

> 
>  2) Windows correctly detects that this device doesn't support D3,
>  and Linux has a bug and does not detect that.

I think that’s the case.

> 
> Obviously nobody wants to require OS or driver updates just for minor
> device changes, and the PCI and ACPI specs are designed to allow
> generic, non device-specific code to detect D3 support, so the first
> case should be a result of a hardware defect.

Yea, that’s why my original idea is to workaround it in PCI/ACPI.

> 
>> So I sent a patch [1] to disable it.
>> 
>> [1] https://lkml.org/lkml/2019/2/2/200
> 
> OK.  Since that's in drivers/net/..., I have no objection and the
> e1000e maintainers would deal with that.

Thanks.

Kai-Heng

> 
> Bjorn

