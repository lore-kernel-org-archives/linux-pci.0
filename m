Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUMSnCPwgbupZ5cFWLMiVxA4FQ2dNWNk+XYhvtEn+F3Ag@mail.gmail.com>
References: <1355412708-20046-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1355412708-20046-4-git-send-email-kirill.shutemov@linux.intel.com>
 <20121213184820.GC12105@kroah.com> <20121213200857.GA24939@otc-wbsnb-06> <CAE9FiQUMSnCPwgbupZ5cFWLMiVxA4FQ2dNWNk+XYhvtEn+F3Ag@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Dec 2012 12:30:04 -0800
Message-ID: <CA+55aFwxmhcgORCnDKwcp5EuzvC0iz02O4QR3H_stTXDbprYSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI Hotplug: workaround for Thunderbolt on Intel
 DZ77RE-75K motherboard
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miles J Penner <miles.j.penner@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Tushar N Dave <tushar.n.dave@intel.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Amos Kong <kongjianjun@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 13, 2012 at 12:25 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> Linus will not be happy with those kind of delay.

Indeed. And the DMI check is bogus too, since the "there can be
delays" is apparently part of the pcie hotplug spec.

So do the sane thing. Retry a few times, with increasingly long delays
(ie something like start with 10ms, then double the delay until you
hit 1s, and then just give up: end result, ~2s total wait, but 10ms
for any sane device that doesn't suck).

No DMI checks, no hacks, not insane default delays.

               Linus
