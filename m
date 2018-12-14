Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA3C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F320811
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544804987;
	bh=4vNHedYSvUHYn4EQJGz2bDRcOwfuYlyvLs21kNJCSZ4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JDAt7/OmMGvhnY+KqepDGwcSHG55kNvEK+fAXE6xC+2Eq2RXwFXF6gDnldc5CcPRL
	 Wk0j4d/h0VFe1G9KOZsiqHJOlevgJOtF8uusg7D858G44VI6OCYLhBhlnRLFmE40X7
	 N2eTjKXD8wAUzpdRjFTov0ZdGBAtA07KUSkQ6pkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeLNQ3p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbeLNQ3p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 11:29:45 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE98A206C2;
        Fri, 14 Dec 2018 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544804985;
        bh=4vNHedYSvUHYn4EQJGz2bDRcOwfuYlyvLs21kNJCSZ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1/26zYzQed48i3ECAJ0dKvXzVW/Qs8pUpB2RWpANdPF5TnEH4wx0K/zZrRqQA5esa
         MFeotr7zRZmW6hpsQasyXp3sWS+LVpwUTOXW610t6/c+sl/SvCw6umzEfmdtj6I9Y2
         TncMf+o2gyjQs6t8E3b5qlYic1+ionTcU0W/f6mo=
Subject: Re: [PATCH v8 3/4] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com,
        ckoenig.leichtzumerken@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, devel@acpica.org
References: <20181214031252.28707-1-okaya@kernel.org>
 <20181214031252.28707-4-okaya@kernel.org>
 <CAJZ5v0j6u=E5xY-a=_D8wO5u=GOX9of3sG572pMSW+eB_e58Ow@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <578bb84f-ab1d-7e44-a6e1-7b0ff51c743a@kernel.org>
Date:   Fri, 14 Dec 2018 11:29:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j6u=E5xY-a=_D8wO5u=GOX9of3sG572pMSW+eB_e58Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/14/2018 4:19 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 14, 2018 at 4:13 AM Sinan Kaya<okaya@kernel.org>  wrote:
>> We are compiling PCI code today for systems with ACPI and no PCI
>> device present. Remove the useless code and reduce the tight
>> dependency.
>>
>> Signed-off-by: Sinan Kaya<okaya@kernel.org>
> Bjorn, any objections here?
> 

Found a breakage in arm64 build without CONFIG_PCI. I'll post a new version
soon.
