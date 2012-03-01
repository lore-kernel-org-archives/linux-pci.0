Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo4fp9fOR-N9RBnGW3m_SjnL_85fuhjQNNLrPygSPX0SYQ@mail.gmail.com>
References: <1330622227-4209-1-git-send-email-yinghai@kernel.org>
	<20120301172435.GA8505@kroah.com>
	<CAE9FiQXTJArPua7RbAVZBRp5CrdtXbHXziU+3L4ygAkn2VqTFQ@mail.gmail.com>
	<CAErSpo4fp9fOR-N9RBnGW3m_SjnL_85fuhjQNNLrPygSPX0SYQ@mail.gmail.com>
Date: Thu, 1 Mar 2012 11:20:34 -0800
Message-ID: <CAE9FiQWhAPRuV4TYNDzD=cyfTWSAyprHDu43ALP5gBtecro5Vg@mail.gmail.com>
Subject: Re: [RFC PATCH] usb, PCI: split quirk for usb host controller to three
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2012 at 10:20 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Hmm...  From the description, I thought this patch only took advantage
> of DECLARE_PCI_FIXUP_CLASS_FINAL to remove the "if (pdev->class ==
> XXX)" tests.
>
> If it *also* skips a disable/enable sequence on non-xhci controllers,
> please make that a separate patch so it's clear what's happening.
>
> It's very important to be clear about these things for people who are
> deciding whether to backport patches into distros.  All the zillions
> of PCI changes we're doing make their lives hard enough without having
> subtle behavior changes hidden in patches that seem to be "code
> restructure only, no behavior change."

sure, will separate the patch to small ones.

Thanks

Yinghai
