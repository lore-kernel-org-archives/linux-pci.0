Return-Path: <SRS0=LLyr=PC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C66C43387
	for <linux-pci@archiver.kernel.org>; Tue, 25 Dec 2018 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A688921908
	for <linux-pci@archiver.kernel.org>; Tue, 25 Dec 2018 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545744840;
	bh=j5nUKZW4Zuf5jlhdElcyjPJnMlLaOlu/C4IPsUzEhwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JcOGGcvwGbkcWV+9KtRU5VguH4BrjSYFKMNjYmtHXjgp5Ni42DutbxxVkubsKyS3l
	 7JaKl9ycTB3eXHHJbqsebeqk57e0JZtNk9k3pc7UmHWYwRm2OhraAVxzBCS9pMcCCi
	 zd2JORZhIT3ifzWd256uvjqqSPRIPIg1UCi7haM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbeLYNd4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Dec 2018 08:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeLYNd4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Dec 2018 08:33:56 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4E52229E;
        Tue, 25 Dec 2018 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545744835;
        bh=j5nUKZW4Zuf5jlhdElcyjPJnMlLaOlu/C4IPsUzEhwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qGmHRTYuLIATHBBBMY8039gt+Ja6GJIlBeF958ZLBbNT0A7lJqJqgTPDns0UfIDuv
         NWKqdyeANrsexs+ot4lT/boGmh/l8oF1RRfFHtR+akzJ24WA/H1tvsCi1fj04eb+0s
         lCd21rLRgC4C8gD7YH89yKyI9B575RBsMV/Dxrhc=
Received: by mail-oi1-f179.google.com with SMTP id c206so11500796oib.0;
        Tue, 25 Dec 2018 05:33:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbjVuDbCGU6yhuZejT82MpTNTaLX2ERGcnNkdxHjWDvo+Sq2bFa
        MQKC9EpzFcJ2Q16d6gm0TW0ty5jVAxrWKu2Jdc4=
X-Google-Smtp-Source: AFSGD/XVv17Lm+ig99BwA9BZJIRolyNMaAfyalz1JoGWOpwhtHDis5stqhNaogwPTLXLtvt6AdHeZgGKdSAHjeDnqMM=
X-Received: by 2002:aca:c186:: with SMTP id r128mr10979240oif.52.1545744834780;
 Tue, 25 Dec 2018 05:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20181222001452.7474-1-okaya@kernel.org> <20181222001452.7474-7-okaya@kernel.org>
 <20181222080317.qicyihyauia6n63w@wunner.de> <CAHp75VfTmWN4bTNPaTL2KYYUWARvix67ynx2cKGzhO3o-0VY=g@mail.gmail.com>
In-Reply-To: <CAHp75VfTmWN4bTNPaTL2KYYUWARvix67ynx2cKGzhO3o-0VY=g@mail.gmail.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 25 Dec 2018 16:33:43 +0300
X-Gmail-Original-Message-ID: <CAK9iUCMUELeXMaqnXWxGKaEKX6OkfpWxvSxWiGjuNpvxneCk0g@mail.gmail.com>
Message-ID: <CAK9iUCMUELeXMaqnXWxGKaEKX6OkfpWxvSxWiGjuNpvxneCk0g@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 24, 2018 at 5:05 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, December 22, 2018, Lukas Wunner <lukas@wunner.de> wrote:
>>
>> On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
>> > Code is scanning PCI bus to find out if it is switchable or not. If
>> > CONFIG_PCI is not set, assume unswitchable.
>> >
>>
>> You can also drop the "platform/x86: " prefix from the subject if you
>> like, all previous commits to this driver just use "apple-gmux: ".
>>
>> If you are okay with these changes, feel free to add my Reviewed-by
>> when respinning.
>>
> I'm not okay with dropping prefix. You can but may not, please, remove the prefix.
>

You mean 'keep the prefix' above, right?

What is the consensus?

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
