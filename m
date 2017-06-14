Return-Path: <SRS0=yVtC=5T=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=yVtC=5T=deltatee.com=logang@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
 <20170613043416.GB14217@kroah.com>
 <CACRpkdZyup+dH6Yp747yLyaC8DSbA8bEnk37gJKnmnjBvjn=-A@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 kernel test robot <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, wfg@linux.intel.com,
 Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 David Airlie <airlied@linux.ie>, David Herrmann <dh.herrmann@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c3148aca-5707-1858-d889-af004321b140@deltatee.com>
Date: Wed, 14 Jun 2017 09:49:52 -0600
MIME-Version: 1.0
In-Reply-To: <CACRpkdZyup+dH6Yp747yLyaC8DSbA8bEnk37gJKnmnjBvjn=-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

On 14/06/17 03:59 AM, Linus Walleij wrote:
> I started to take a stab at it at one point and incorporated some feedback
> from Torvalds etc, it's here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=chrdev-warn&id=65e5b1e9eb3f777ab7535b74b490e882eeec79d7

Yes, thanks, I did find your work after a google search. However, seeing
it seems to recover only a handful of numbers with some significant
complexity required it seemed like a stopgap solution anyway. I posted a
proposal in this thread that simply extends the dynamic range into a
region above 256 which seems to work well. This means regular
configurations won't be affected an any configuration requiring more
than 20 dynamic majors will simply end up with high numbers.

So unless anyone can think of a reason why this won't work, it's my
preferred direction.

> Making them all dynamic seemed dangerous because I was afraid
> of userspace ABI breakage because of old userlands with
> static mknod:s.

I agree.

Logan
