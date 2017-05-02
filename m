Return-Path: <SRS0=ZRtg=4I=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=ZRtg=4I=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 1/4] PCI: add resizeable BAR infrastructure v4
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
 <1493126394-1239-2-git-send-email-deathsimple@vodafone.de>
 <CAHp75VfJKkFTXbia=CiZapriEg6ObUh=js6cKJv3xe=2DBHbqA@mail.gmail.com>
Cc: helgaas@kernel.org, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <bd126097-1aa4-eeb0-39fd-2e8820b448c5@vodafone.de>
Date: Tue, 2 May 2017 16:56:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VfJKkFTXbia=CiZapriEg6ObUh=js6cKJv3xe=2DBHbqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 26.04.2017 um 18:45 schrieb Andy Shevchenko:
> [SNIP]
>> -#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # bars */
>> -#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # bars */
>> +#define  PCI_REBAR_CTRL_NBAR_MASK      (7 << 5)        /* mask for # BARs */
>> +#define  PCI_REBAR_CTRL_NBAR_SHIFT     5       /* shift for # BARs */
> I understand why, but I dunno it worth to do.
Bjorn suggested that. Either way is fine with me, but he needs to stick 
his signed-of-by on it when pushing it upstream. So his opinion usually 
wins.

All other comments will be integrated in the next version of the patch.

Thanks for the review,
Christian.
