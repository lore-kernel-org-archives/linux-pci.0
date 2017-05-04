Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=EjUq=4K=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v3
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
 <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
 <CAHp75VfSFBYgHRsX2JSH0zdSEW8VvXbNMVvBBsD9kKgzGr-v2w@mail.gmail.com>
Cc: helgaas@kernel.org, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <5a9a94f3-34b3-9484-a455-f5b2ee0b4d51@vodafone.de>
Date: Thu, 4 May 2017 11:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VfSFBYgHRsX2JSH0zdSEW8VvXbNMVvBBsD9kKgzGr-v2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 26.04.2017 um 19:00 schrieb Andy Shevchenko:
> [SNIP]
>> +       while (1) {
> This raises red flag. Care to refactor?
> Also do {} while () syntax allows faster to get that the loop body
> goes at least once.

I've tried to refactor this, but couldn't come up with something which 
works and is readable at the same time.

Any suggestion how this should look like?

Christian.
