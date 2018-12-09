Return-Path: <SRS0=iymf=OS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A6C07E85
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B1920867
	for <linux-pci@archiver.kernel.org>; Sun,  9 Dec 2018 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544371423;
	bh=sE+9yYgh9S2Y9eIElXrf5vlc9uTv2OI6tljGGi30j4Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=LPEbIEJud3dI8K0jsmZamQ8hF6iPMrz/N0MhuxD/xfayxatjKblPrgM4MS0DPKiYA
	 pouLBaVF5yCbGLnO6Z9k6doDKVIOGUHsbuHz3+UxupVrUrHeCEZnGmle4vPk/2Splv
	 0K2UCGNERXuAIAwZWKwb03eJ5rOTkersOojncO/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B1920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLIQDm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeLIQDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Dec 2018 11:03:42 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D00F20672;
        Sun,  9 Dec 2018 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544371421;
        bh=sE+9yYgh9S2Y9eIElXrf5vlc9uTv2OI6tljGGi30j4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tRRm0lxPzcihgzb4kwodfYtDmssbU62iJ2EuWch+MX/doMv4yymbk4BqJGvLsCOhs
         Fu1orrWXOQLu/6PS1EdZ6h5OFTjye4DkY42hjiYLFcLKoMWUEptjdss8NLze0cIccx
         ZvovzDEod3VtR9PbOCTHYTECGCGFG53QIM5KquUQ=
Subject: Re: [PATCH v2 3/3] PCI/ACPI: allow ACPI to be built without PCI
 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com,
        Christian Koenig <christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, devel@acpica.org
References: <20181208214644.5374-1-okaya@kernel.org>
 <20181208214644.5374-3-okaya@kernel.org>
 <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <c5fbd30d-370c-929d-d64b-dbc45f9a3f90@kernel.org>
Date:   Sun, 9 Dec 2018 11:03:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/2018 1:20 AM, Andy Shevchenko wrote:
>> +#ifdef CONFIG_PCI
>>   struct pci_dev *acpi_get_pci_dev(acpi_handle);
>> +#else
>> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)
> Can you spell handle fully?
> 

Yeah, I can do that.
