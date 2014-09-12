Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ghbnqkeh9k.fsf@quad.gouders.net>
References: <ghiol53r9u.fsf@lena.gouders.net>
	<CAMxnaaXiEZeJOsgQ6ZSbiqy5Z1zNoXonwNSQNRyRhV0t5jveYQ@mail.gmail.com>
	<ghwq9k3m6z.fsf@lena.gouders.net>
	<CAMxnaaUqTMf1uEQUqrAGjym8ZrQaBf2QbE4Jqxh2t6a2JgJkOQ@mail.gmail.com>
	<ghioku5l29.fsf@lena.gouders.net>
	<CAErSpo7j=a3y2MVsvEQGQ4B63_mNCyZSRNXNEZa-2++xs88NmQ@mail.gmail.com>
	<CAE9FiQUXvuZo2bQSRg0vpuDVYrnkcXDu7KZBNp-YgXbKa2LQhw@mail.gmail.com>
	<ghppf15236.fsf@quad.gouders.net>
	<CAErSpo5SVUOz+qa_x5JTC+-Y5ewTyYzA0N=jyPtK9LaguRrt=w@mail.gmail.com>
	<ghd2b1svdw.fsf@quad.gouders.net>
	<CAErSpo5e0GOdVbZdQYriP+aWziKELpb9BWTgJ4ERPia354CM5w@mail.gmail.com>
	<ghvbotd8es.fsf@quad.gouders.net>
	<ghzje5f5zt.fsf@lena.gouders.net>
	<ghbnqkeh9k.fsf@quad.gouders.net>
Date: Fri, 12 Sep 2014 13:39:04 -0700
Message-ID: <CAE9FiQXQesrDMqf1b6ZhHdmY_wEEUrOEvNO4N_d6WtaNMGNLww@mail.gmail.com>
Subject: Re: [BUG] Bisected Problem with LSI PCI FC Adapter
From: Yinghai Lu <yinghai@kernel.org>
To: Dirk Gouders <dirk@gouders.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 12, 2014 at 1:05 PM, Dirk Gouders <dirk@gouders.net> wrote:
> Dirk Gouders <dirk@gouders.net> writes:
>
> I now applied your patches and tested them:
>
> echo 1 > /sys/bus/pci/devices/0000\:00\:0a.0/pcie_link_disable
> echo 0 > /sys/bus/pci/devices/0000\:00\:0a.0/pcie_link_disable
>
> The FC Adapter did not show up, this is the dmesg output (I also tested
> with 0b.0):
>
> [  143.294168] pcieport 0000:00:0a.0: pcie_link_disable_set: lnk_ctrl = 18
> [  148.284456] pcieport 0000:00:0a.0: pcie_link_disable_set: lnk_ctrl = 8
> [  304.065942] pcieport 0000:00:0b.0: pcie_link_disable_set: lnk_ctrl = 18
> [  309.035278] pcieport 0000:00:0b.0: pcie_link_disable_set: lnk_ctrl = 8
>
> So, probably my test environment does not work as expected and I have to
> test it on the failing machine.

You need to rescan the pci devices.
like

echo 1 >  /sys/bus/pci/rescan

Thanks

Yinghai
