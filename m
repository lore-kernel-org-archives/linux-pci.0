Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] New Microsemi PCI Switch Management Driver
To: Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <2eb2b814-d621-5d8d-8366-4c4e9f789208@deltatee.com>
 <e27a2363-1b11-f74b-532d-7de089875c90@deltatee.com>
 <2bab7df0-9ae0-67e1-1f06-208d1359a4d5@codeaurora.org>
CC: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Wei Zhang <wzhang@fb.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <8b97cdc9-20ef-df2a-bb6c-86275866dcd8@fb.com>
Date: Thu, 23 Feb 2017 13:54:26 -0700
MIME-Version: 1.0
In-Reply-To: <2bab7df0-9ae0-67e1-1f06-208d1359a4d5@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2017 01:51 PM, Sinan Kaya wrote:
> On 2/23/2017 3:36 PM, Logan Gunthorpe wrote:
>> We're still waiting on any kind of response from Bjorn. (If you're
>> listening please say something!)
>>
>> Does anyone have any suggestions for dealing with an unresponsive
>> maintainer? Or a way for us to move forward with this quickly and get it
>> merged?
> 
> You'll want to be careful during the merge window (these days) as the
> maintainer is usually busy with code delivery. You can't rush your code in at
> the last minute.
> 
> [GIT PULL] PCI changes for v4.11]
> 
> Here is a list of all the patches waiting to be reviewed. 
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_linux-2Dpci_list_&d=DwIC-g&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=1BfGDtZjAoX-qj9haoqNB7onGlV0IrYOSvLRdecBk88&s=LXm-NTK2rl_GWfVm9dlVB66fhl1ckx-Ar-2z80daybc&e= 
> 
> You'll just have to wait your turn.

The code was posted 2/2, and a ping was sent 2/17 and now today. I don't
think it's unreasonable to expect a response within a month. It's not
a major new feature in the core of PCI, it's a basic driver.

-- 
Jens Axboe
