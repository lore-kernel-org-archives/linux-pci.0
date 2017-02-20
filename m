Return-Path: <linux-kernel-owner@vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
References: <20170210145124.GA24594@kroah.com>
 <1486749440-24309-1-git-send-email-logang@deltatee.com>
 <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
 <CAA9_cmfbJEPhCj_Ukav841zW5P=uYkTir4jFRTKyOvzHmJNmVg@mail.gmail.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Stephen Bates <stephen.bates@microsemi.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2cd5df88-c018-3e76-fd08-483fec374932@deltatee.com>
Date: Sun, 19 Feb 2017 21:22:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAA9_cmfbJEPhCj_Ukav841zW5P=uYkTir4jFRTKyOvzHmJNmVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] switchtec: cleanup cdev init
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/02/17 02:43 PM, Dan Williams wrote:
> Is this race present for all file operations? I've only seen it with
> mmap() and late faults. So if these other drivers do not support mmap
> it's not clear they can trigger the failure.

I don't see how it's related to mmap only. I think there's a number of
variations on this but the race I see happens if you try to take a
reference to the device in the open/close handlers of a char device file.

If a driver puts the last remaining reference in the release handler,
then the device structure will be freed, and on returning from the
release handler, the char_dev code will try to put the last reference to
the cdev structure which may have already been free'd. There needs to be
a way for the cdev structure to take a reference on the device structure
so it doesn't get freed and the kobj.parent trick seems to accomplish
this fairly well.

Really, in any situation where there's a cdev and a device in the same
structure, the life cycles of the two become linked but their reference
counts are not and that is the problem here.

I feel like a number of developers have made the same realization
independently so this would probably be a good thing to clean up.

See these commits for examples spanning around 5 years:

4a215aa Input: fix use-after-free introduced with dynamic minor changes
0d5b7da iio: Prevent race between IIO chardev opening and IIO device
ba0ef85 tpm: Fix initialization of the cdev

Also, seems both my brother and I have independently looked into this
exact issue:

https://www.mail-archive.com/linux-rdma@vger.kernel.org/msg25692.html

So, I think it would be a good idea to clean it up with Dan's proposed
API cleanup. If I have some time tomorrow, I may throw together a patch
set with that patch and the changes to the instances around the kernel.

Logan
