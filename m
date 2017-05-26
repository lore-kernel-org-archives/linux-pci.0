Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170526054604.GA18291@lst.de>
References: <20170520132129.16430-1-hch@lst.de> <20170520132129.16430-2-hch@lst.de>
 <20170520165954.GA26936@lst.de> <20170526054604.GA18291@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 May 2017 08:46:19 -0700
Message-ID: <CA+55aFxcVjUQVwLuej5Tm1G-wp2ZJYjktTJaSaK_cWqMoQjymQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/msi: fix the pci_alloc_irq_vectors_affinity stub
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 25, 2017 at 10:46 PM, Christoph Hellwig <hch@lst.de> wrote:
> Bjorn,
>
> can you take this regression fix and sent it to Linux before -rc3?
> I had hope we could get it into -rc2 but already missed that, and
> I haven't heard a comment since..

I took it directly..

                 Linus
