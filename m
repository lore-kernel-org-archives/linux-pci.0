Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdbv1ok6U-xOtH0t5esJ_SD0Sn_JDpxmZg6XViargOM99g@mail.gmail.com>
References: <20171011140224.3770968-1-arnd@arndb.de> <CACRpkdbv1ok6U-xOtH0t5esJ_SD0Sn_JDpxmZg6XViargOM99g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Oct 2017 21:08:57 +0200
Message-ID: <CAK8P3a2w-tgwvr-HcPiMN9hBwOvXJsbUM+iYtkpU1Zu_vhOeCg@mail.gmail.com>
Subject: Re: [PATCH] PCI: v3-semi: print resources using %pR format string
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 9:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Oct 11, 2017 at 4:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Ah this again.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Sorry about it, is it that checkpatch doesn't warn for this?

I only find this during randconfig builds, I don't think there is an easy way
for checkpatch to find it.

       Arnd
