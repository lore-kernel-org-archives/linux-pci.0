Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB89C10F00
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 04:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C6218C3
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 04:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWQZDE0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfCUEOP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:14:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34133 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfCUEOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 00:14:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so1176496wmc.1;
        Wed, 20 Mar 2019 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmPilxTQKenjtaEJ0oDKh1+q1uMdZc5rwTXs7nvfLJE=;
        b=uWQZDE0gRSdobkQj2ta08/t+L4UkErpmPgBn2skMCGYCCZa9I4c0bfOVuimFkzFUNx
         uUwFYJJkvY3F+YDwTsOAU4PsuTedAJiyypGa1/vM8WmSM5kg45UiCHEsDo2ytTt2RSNu
         ZNP41UYOT1eeyBLSVzHomtPyTJY8JLZ1I6/RD8ZlQAH7o1V7NdBsFZCmRgct3yyR2wgm
         buFVr0DN2OTnModGYrYwwfNmiw2U4mLHxgfKC2PPKsqaOw5cWvjGr54IfELJIgL5XIRZ
         EeV+wgGW1WVRpZDfQN1EPgv43TYXwQb5BDkXkH1T2BVoRDtj4Y2DArGmn7mMyfg5Pgi3
         od9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmPilxTQKenjtaEJ0oDKh1+q1uMdZc5rwTXs7nvfLJE=;
        b=DU/XARTJB71w7tZOOs/grh9a32jQUnqxHQKNBQMwdhuT9E58rGDLAakoI/+K9cMl5l
         A3rDrEXQ1nRA0/mysK72X4g8V4Z+AnJKC4GipbRMgKngP1b8wnNYPYrbORckVOLcomMe
         lRdbivZoidt9DNUFgeNYjsMX4VgpVg+ILNvzwdeAhkaCnubXc4lKMtp46qt4KvktIjvw
         r6/ljR97Nt+eZh1XXScAC5DrZEQIh24P3cvu1G4nI6uizvQYmJEmOpzzi3g9DsCw3taI
         3Jwb/NDwS/3I9YpVxi7B+useVzOyB/iImuUYeFMnzpWivK9IczedgJ+53X1G9XVxI+l6
         7Aww==
X-Gm-Message-State: APjAAAWJ4JGNbuYuv7jp3RgXQQKLQH7jGorEu+v64CO78IfYImvUrgbd
        POXuVvy5V+SEtLWXrqKTvK4otqJq
X-Google-Smtp-Source: APXvYqx6oFgbYUmQXqILV9WCpEtmzJvt4/U6UdcvJfG/D3RjbQGu+EfUZYCufm5FFJm4yTpxg6btgA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr976222wmh.53.1553141652749;
        Wed, 20 Mar 2019 21:14:12 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id 7sm8759550wrc.81.2019.03.20.21.14.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 21:14:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <CAMuHMdW5+aKVFdQYF-xiO3JyoyNYDwOTQqF8BJgku1b7ZzD1Mw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c7fa1a3c-f3cb-2c9c-3321-c8b53da609f2@gmail.com>
Date:   Thu, 21 Mar 2019 04:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW5+aKVFdQYF-xiO3JyoyNYDwOTQqF8BJgku1b7ZzD1Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/19 9:47 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace unsigned long with u32 type for variables holding
>> register values, since the registers are 32bit. Note that
>> rcar_pcie_msi_irq() still uses unsigned long because both
>> find_first_bit() and __fls() require unsigned long as an
>> argument.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
>> index 1408c8aa758b..857d88fd03d5 100644
>> --- a/drivers/pci/controller/pcie-rcar.c
>> +++ b/drivers/pci/controller/pcie-rcar.c
>> @@ -169,7 +169,7 @@ enum {
>>
>>  static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>>  {
>> -       int shift = 8 * (where & 3);
>> +       u32 shift = 8 * (where & 3);
> 
> shift is not a register value, so IMHO the original type is fine (the "int"
> comes from the pci_ops API, BTW).

I presume it should be at least unsigned ?

[...]

-- 
Best regards,
Marek Vasut
