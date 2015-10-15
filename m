Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHhAz+iwiXihW11FK7tDQyCGMN0k10fRLLtfnQ49V2ncBRidvQ@mail.gmail.com>
References: <CAHhAz+iwiXihW11FK7tDQyCGMN0k10fRLLtfnQ49V2ncBRidvQ@mail.gmail.com>
Date: Thu, 15 Oct 2015 13:31:13 +0200
Message-ID: <CAFLxGvxLtxxja=yAyC=Z4LjvfPkp8NW0vFa4NJg7dmYFjan+3Q@mail.gmail.com>
Subject: Re: sdhci-pci or sdhci_pci
From: Richard Weinberger <richard.weinberger@gmail.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 1:00 PM, Muni Sekhar <munisekharrms@gmail.com> wrote:
>  [ Please keep me in CC as I'm not subscribed to the list]
>
> Hello,
>
> I loaded sdhci-pci.ko, but lsmod shows it as sdhci_pci.
> Why is that lsmod shows wrong module name( '-' changed to '_')?
>
>
> # lsmod
> Module                  Size  Used by
> sdhci_pci              23301  0
> sdhci                  43685  1 sdhci_pci

The problem is that module names must contain a dash. This is why kbuild
is renaming them.
IIRC because the modalias mechanism is using them.
CC'ing Rusty. Maybe he can give more details. :)

-- 
Thanks,
//richard
