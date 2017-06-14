Return-Path: <SRS0=52KJ=5T=linaro.org=linus.walleij@kernel.org>
Return-Path: <SRS0=52KJ=5T=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170613043416.GB14217@kroah.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com> <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com> <20170613041842.GA13308@kroah.com>
 <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com> <20170613043416.GB14217@kroah.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Jun 2017 11:59:29 +0200
Message-ID: <CACRpkdZyup+dH6Yp747yLyaC8DSbA8bEnk37gJKnmnjBvjn=-A@mail.gmail.com>
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <helgaas@kernel.org>,
	kernel test robot <fengguang.wu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, wfg@linux.intel.com,
	Alan Cox <alan@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
	David Herrmann <dh.herrmann@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 6:34 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> Ah, that makes sense.  Well, someone can always work on expanding the
> range of dynamic char major numbers if they are running out of them on a
> real system, I'll gladly take patches for that :)

I started to take a stab at it at one point and incorporated some feedback
from Torvalds etc, it's here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=chrdev-warn&id=65e5b1e9eb3f777ab7535b74b490e882eeec79d7

It tries to use all "holes" in the chardev major map to shun in a bit
more devices when we run out of the high dynamic major range.

Making them all dynamic seemed dangerous because I was afraid
of userspace ABI breakage because of old userlands with
static mknod:s.

I lost interest when it turned out that the zeroday QEMU stuff was
generating random machines that have no counterpart in the real
world, and then the exercise seemed a bit academic.

The last failures were due to (AFAICT) some relationship between
major and minor numbers that I didn't untangle.

If there is interest I could try to revive it.

Yours,
Linus Walleij
