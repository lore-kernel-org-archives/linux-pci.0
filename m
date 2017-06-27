MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
References: <1498555451-55073-1-git-send-email-ryder.lee@mediatek.com>
Date: Tue, 27 Jun 2017 08:20:44 -0500
Message-ID: <CABhMZUW0q3iAwsf6_ykEM1wTnEv1O9gMP3YUvXzr+HDwJq=VXA@mail.gmail.com>
Subject: Re: [RESEND PATCH] critical patch to fix pci-tree build bot failure
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 27, 2017 at 4:24 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> Hi Stephen and Andrew,
>
> Could you help to apply this patch? Seems Bjorn didn't response it these days.

I'm not dead, but I was on vacation most of last week.  I'll resolve this today.

> This patch(based on pci-next tree) will fix the following build bot failure:
>>> On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:
>>>
>>> This build failure is still present in -next:
>>>
>>> >     arm-allmodconfig
>>> > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit
>>> > declaration of function 'pci_register_host_bridge'
>>> > [-Werror=implicit-function-declaration]
>>>
>>> and we're at -rc7 now.
>
> This is because pci/host-mediatek is a seperate branch in pci-tree, but merge together without proper modifications(eg. some API changes).
>
> Hi Bjorn,
> I rewrote commit message. Please ignore my previous one, sorry for inconvenience.
>
> Thanks a lot!
>
> Ryder Lee (1):
>   PCI: mediatek: change to use the new host bridge interface
>
>  drivers/pci/host/pcie-mediatek.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> --
> 1.9.1
>
