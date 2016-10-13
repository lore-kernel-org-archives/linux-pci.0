Return-Path: <linus971@gmail.com>
Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20161013140746.GA14174@localhost>
References: <20161013140746.GA14174@localhost>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Oct 2016 16:48:46 -0700
Message-ID: <CA+55aFxxsn1kBZDtjbvgnaDQe7LJuHg2WL049dCxRxwWnncoFg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.9
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 7:07 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Here are some more changes I'd like to have in v4.9.  There's one small
> Tegra bug fix in the PHY poweroff path, which is only used in failure
> paths.  The rest is all strictly cleanup that should make host bridge
> drivers more readable, but shouldn't actually change any behavior.

Ugh:

> PCI changes for the v4.9 merge window:
>
>   Altera host bridge driver
>     Add local struct device pointers (Bjorn Helgaas)

Your "summary" is actually less legible than the shortlog, and looks
entirely auto-generated.

That's against the whole point of having a summary for a pull request.

Please tell me what changed, don't auto-generate pointless unreadable crud. Ok?

                Linus
