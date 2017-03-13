Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pegasos-out.vodafone.de ([80.84.1.38]:45755 "EHLO
        pegasos-out.vodafone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdCMJno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2017 05:43:44 -0400
Subject: Re: [PATCH 1/5] PCI: add resizeable BAR infrastructure v2
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
 <CAHp75Vet-gb_mXA2Uwdai+G2AeJ4p10eTjgmC2h5Gnmosd69WA@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <28e64c07-ac7f-5f1f-0b3d-0e487f8fdfd4@vodafone.de>
Date: Mon, 13 Mar 2017 10:43:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75Vet-gb_mXA2Uwdai+G2AeJ4p10eTjgmC2h5Gnmosd69WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 06.03.2017 um 13:20 schrieb Andy Shevchenko:
> On Mon, Mar 6, 2017 at 1:40 PM, Christian König <deathsimple@vodafone.de> wrote:
>> +       for (i = 0; i < nbars; ++i, pos += 8) {
> 8 is defined somewhere in the spec? (Yes, I understand that is just 64
> bits shift)

Yes, it is defined in the spec, see "Figure 7-x1 Resizable BAR Capability".

It just doesn't have a name or something if that's what you are asking for.

I've addressed all other comments in code and will send out the next 
version of the patch set today.

Thanks for the comments,
Christian.
