Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6AEE49A5
	for <linux-pci@archiver.kernel.org>; Mon, 21 Aug 2023 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHUSbz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjHUSbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:31:55 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02826400;
        Mon, 21 Aug 2023 11:31:52 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-570b3ebb3faso150858eaf.0;
        Mon, 21 Aug 2023 11:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692642712; x=1693247512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cpTLlf63vU43t54PAMmVd0PPwP7u1THayVq4sVIl7g=;
        b=JfGzh3qk8vtdTilYPOxmK7ODFgBb6zGRaALDrC6rBApqlCoaUWBQBl6R0PRMqyZzy0
         LqMQRVBuP1+um0sWg18ifcaEQjBTPMKwyQ1/qOKC6errJwgdHDQ0bdTlzWjQdyNzBj8i
         r+/FSM6+2D2xkqQaEnJDbzlr//PhTYJ1vIm6K649fpMw55QH2XNiQSWDliuULqq1N4VW
         Emy7ex555sMBz9TTnNefzy3PQSERr3cWEVodq83d0eRdxz/ajW1U7zwrqy+01SujR/7D
         vb0+C0R6CNThKJhPIa8r8ubTb8VyIUEDaMwisNAlrrfXsrnCtIMswx/XZlPT0pmERXvf
         cISg==
X-Gm-Message-State: AOJu0YwOchjWyXp7FLCNb4+FBBiN0xlPHz+LXmT4nsC1VokY218m/mTj
        nNO/KY9xf6XSPZf38srQj4kDaYnxKbDoluWboZc=
X-Google-Smtp-Source: AGHT+IGQl/N1CAf5FS93CymNiEu99nmDY0DB59wzwQEm40CQxDSHEExh6kjRB5xk8iBFKZURM3XAjRbeUAN7YLVx7dg=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr7004853oov.0.1692642712068; Mon, 21 Aug
 2023 11:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194007.27410-1-mario.limonciello@amd.com>
In-Reply-To: <20230818194007.27410-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:31:36 +0200
Message-ID: <CAJZ5v0gNZNRs4hpV5QxxTaPDu1Mp-vDhN-fZZ+_6AZg+nDmg1A@mail.gmail.com>
Subject: Re: [PATCH v14.b 0/7] Export LPS0 constraints
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> LPS0 constraints can be useful to other parts of the kernel to make
> decisions what state to put devices into.
>
> In v14 this series has been split into 3 parts.
>  part A: Immediate fix for AMD issue.
>  part B: LPS0 export improvements
>  part C: Long term solution for all vendors
>
> This is part B, it can be applied and reviewed independently from part A.
>
> Andy Shevchenko (1):
>   ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
>
> Mario Limonciello (6):
>   ACPI: Adjust #ifdef for *_lps0_dev use
>   ACPI: x86: s2idle: Post-increment variables when getting constraints
>   ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
>   ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
>   ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
>   ACPI: x86: s2idle: Add a function to get constraints for a device
>
>  drivers/acpi/x86/s2idle.c | 96 +++++++++++++++++++++++++--------------
>  include/linux/acpi.h      | 10 +++-
>  2 files changed, 70 insertions(+), 36 deletions(-)
>
> --

All applied as 6.6 material, but I rewrote the last patch my way, so
please see the result in the bleeding-edge branch and let me know if
there's anything wrong with it.

Thanks!
