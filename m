Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo4nnY27oB3tShgL8DLStHk+ApYFUGWo_=cAEqRJnVK91A@mail.gmail.com>
References: <1331623594-30543-1-git-send-email-yinghai@kernel.org>
	<1331623594-30543-6-git-send-email-yinghai@kernel.org>
	<CAErSpo4nnY27oB3tShgL8DLStHk+ApYFUGWo_=cAEqRJnVK91A@mail.gmail.com>
Date: Thu, 15 Mar 2012 20:23:07 -0700
Message-ID: <CAE9FiQWr9VfJbjTNECoR-CfD=M9hFvVx1fcvhAEBDi1eV=kLwA@mail.gmail.com>
Subject: Re: [PATCH 05/12] PCI: Add addon_resource support for pci_dev
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2012 at 2:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> There are some interesting ideas here.  Do they all have to be in the
> same patch?
>
>  - for_each...() helpers
>  - pci_dev_resource_n() stuff
>  - addon resource stuff
>  - addon resource ops

ok, will split them to several ones.

Yinghai
