Return-Path: <lftan.linux@gmail.com>
Return-Path: <lftan.linux@gmail.com>
MIME-Version: 1.0
Sender: lftan.linux@gmail.com
In-Reply-To: <20160722210705.GA32142@localhost>
References: <1466499193-1987-1-git-send-email-lftan@altera.com> <20160722210705.GA32142@localhost>
From: Ley Foon Tan <lftan@altera.com>
Date: Mon, 25 Jul 2016 13:07:27 +0800
Message-ID: <CAFiDJ5-4hHtg9uqeHucMLDu1Y6m2zyRA85TQueCWxsqLofQLAQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: altera: fix link retrain
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 23, 2016 at 5:07 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 21, 2016 at 04:53:11PM +0800, Ley Foon Tan wrote:
> > This 2 patches fix the issue before and after retrain link.
> >
> > Ley Foon Tan (2):
> >   PCI: altera: check link status before retrain link
> >   PCI: altera: Polling for link up status after retrain the link
> >
> >  drivers/pci/host/pcie-altera.c | 48 +++++++++++++++++++++++++++---------------
> >  1 file changed, 31 insertions(+), 17 deletions(-)
>
> I applied these to pci/host-altera for v4.8, thanks!
>
> I split the code move into its own patch so the bug fix is clearly
> visible.  I also fixed these whitespace errors:
>
>   if(!altera_pcie_link_is_up(pcie))
>   while(!altera_pcie_link_is_up(pcie)) {
>
> A space is required after "if" and "while".
Hi Bjorn

Thanks a lot!

Regards
Ley Foon
