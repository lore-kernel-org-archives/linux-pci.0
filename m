Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F2EC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 01:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7087218C3
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 01:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZZ7yu53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCUB1a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:27:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44270 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfCUB13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 21:27:29 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so3899714iop.11;
        Wed, 20 Mar 2019 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S9XU4J/k93OsMMylvZ1JNfWGTXAIB9da5OyR+QwYITk=;
        b=lZZ7yu53IUzfpDigDTASS9vYegSXX5dIjqfO9Ae4Nxw/j3EdmkgJbdiyHFdDKsfMqn
         n2wzdMkdaCvgK5RjLpr3buKhyhujov5a6Mc9cyqhTN7KQ7StbHQLAEZbBcQ4H2qdzVRn
         gQIuyOzjVKkyjrEfKXmpgb1AJxyVW5tt39AdLH301xBS1yzatwj+Luoc6kwq5e9IOLHQ
         T5B4wizgQnnctTHHTO85RxNvHnXqELNH/r6ROs/nScg3llDwJIUbMYtqLDdYOSKSw8bf
         iEBUaf6jafpDPrk4HQgeFmEkI95TezO9RCXLmC/D0anbZOOEG3gYxuIlAKKpbDZCkHG9
         UO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9XU4J/k93OsMMylvZ1JNfWGTXAIB9da5OyR+QwYITk=;
        b=EguwsL1DRXD1Po4cBhW+5v6IcmCZLj/WgF4mrNdznpMbzseyKAcLLU2y5RZFjxmc/u
         Svl0gVUJAK8btCSGQr3byxO9J8sy4p9ZrrTD1hpivmKJuz9XqIeZIqgpaRHIDX6kgWSN
         VDGIZbzw4+T0rbdzvMEwbkvEhU1MH4nSu3Hbhzo0jk1O+90If4tQV42AHKmak/kEbNpY
         MK2mnjnXM95MWABeLviNutUgrMdNSgnt1CSPf0+a7MoQ0Z47NbzkB+OCS6fiYGlqDR78
         Aefs536t9mDsCxZP+zJMQSVYV7zV2C4K6yekDfvq/BlpzlW4qYMHxQsRt8ngGY+R/JCe
         EVOA==
X-Gm-Message-State: APjAAAUWiCRUUPzwnOFlwREHAI7o76ejzaNiJN7u6Xz+OKqRwP2Wu9lx
        2MpSziVxC/C20sLX+eEJH2I=
X-Google-Smtp-Source: APXvYqy6AUWaBo++trS+bvcfVUpe1jR8bINT5cJe644bcU7SdBkFGuTWyyR4qGTmWYzszIKIbP63vg==
X-Received: by 2002:a6b:b797:: with SMTP id h145mr735113iof.190.1553131648787;
        Wed, 20 Mar 2019 18:27:28 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::987])
        by smtp.gmail.com with ESMTPSA id v20sm1635196ioh.17.2019.03.20.18.27.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 18:27:27 -0700 (PDT)
Subject: Re: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     austin_bolen@dell.com, Alex Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Shyam_Iyer@dell.com,
        Lukas Wunner <lukas@wunner.de>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>
References: <20190222194808.15962-1-mr.nuke.me@gmail.com>
 <20190320205233.GE251185@google.com>
 <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <156dec38-438d-1ce9-64fa-af95d37c14bd@gmail.com>
Date:   Wed, 20 Mar 2019 20:27:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjDY1C+E0gUHmb6O3THwoTNpm=-qthDRcW+sG2RB430Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/20/19 4:44 PM, Linus Torvalds wrote:
> On Wed, Mar 20, 2019 at 1:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> AFAICT, the consensus there was that it would be better to find some
>> sort of platform solution instead of dealing with it in individual
>> drivers.  The PCI core isn't really a driver, but I think the same
>> argument applies to it: if we had a better way to recover from readl()
>> errors, that way would work equally well in nvme-pci and the PCI core.
> 
> I think that patches with the pattern "if (disconnected) don't do IO"
> are fundamentally broken and we should look for alternatives in all
> cases.
> 
> They are fundamentally broken because they are racy: if it's an actual
> sudden disconnect in the middle of IO, there's no guarantee that we'll
> even be notified in time.
> 
> They are fundamentally broken because they add new magic special cases
> that very few people will ever test, and the people who do test them
> tend to do so with old irrelevant kernels.
> 
> Finally, they are fundamentally broken because they always end up
> being just special cases. One or two special case accesses in a
> driver, or perhaps all accesses of a particular type in just _one_
> special driver.
> 
> Yes, yes, I realize that people want error reporting, and that
> hot-removal can cause various error conditions (perhaps just parity
> errors for the IO, but also perhaps other random errors caused by
> firmware perhaps doing special HW setup).
> 
> But the "you get a fatal interrupt, so avoid the IO" kind of model is
> completely broken, and needs to just be fixed differently. See above
> why it's so completely broken.
> 
> So if the hw is set up to send some kinf of synchronous interrupt or
> machine check that cannot sanely be handled (perhaps because it will
> just repeat forever), we should try to just disable said thing.
> 
> PCIe allows for just polling for errors on the bridges, afaik. It's
> been years since I looked at it, and maybe I'm wrong. And I bet there
> are various "platform-specific value add" registers etc that may need
> tweaking outside of any standard spec for PCIe error reporting. But
> let's do that in a platform driver, to set up the platform to not do
> the silly "I'm just going to die if I see an error" thing.
> 
> It's way better to have a model where you poll each bridge once a
> minute (or one an hour) and let people know "guys, your hardware
> reports errors", than make random crappy changes to random drivers
> because the hardware was set up to die on said errors.
> 
> And if some MIS person wants the "hardware will die" setting, then
> they can damn well have that, and then it's not out problem, but it
> also means that we don't start changing random drivers for that insane
> setting. It's dead, Jim, and it was the users choice.
> 
> Notice how in neither case does it make sense to try to do some "if
> (disconnected) dont_do_io()" model for the drivers.

I disagree with the idea of doing something you know can cause an error 
to propagate. That being said, in this particular case we have come to 
rely a little too much on the if (disconnected) model.

You mentioned in the other thread that fixing the GHES driver will pay 
much higher dividends. I'm working on reviving a couple of changes to do 
just that. Some industry folk were very concerned about the "don't 
panic()" approach, and I want to make sure I fairly present their 
arguments in the cover letter.

I'm hoping one day we'll have the ability to use page tables to prevent 
the situations that we're trying to fix today in less than ideal ways. 
Although there are other places in msi.c that use if (disconnected), I'm 
okay with dropping this change -- provided we come up with an equivalent 
fix.

But even if FFS doesn't crash, do we really want to lose hundreds of 
milliseconds to SMM --on all cores-- when all it takes is a couple of 
cycles to check a flag?

Alex
