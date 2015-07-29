Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Jul 2015 10:55:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Message-ID: <20150729155509.GA31170@google.com>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com>
 <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com>
 <20150729012255.GA18606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150729012255.GA18606@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 08:22:55PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2015 at 02:50:39PM -0700, Duc Dang wrote:

> > Do you have another PCIe card to try on the same reboot test on this board?
> 
> I've seen this on at least two Mellanox cards.  I'm running similar tests
> on a different type of card now.

FWIW, reboot tests on two machines with Mellanox cards failed, while the
same test on a machine with a different proprietary card succeeded.
