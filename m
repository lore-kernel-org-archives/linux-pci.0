Return-Path: <SRS0=8WXH=2E=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=8WXH=2E=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170223181549.GA10177@bhelgaas-glaptop.roam.corp.google.com>
References: <20170223181549.GA10177@bhelgaas-glaptop.roam.corp.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Feb 2017 11:35:46 -0800
Message-ID: <CA+55aFx1L0rhBHRRsgDch31aU+Y-8C=tiFZHUnL2wnrifi+yVw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.11
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 23, 2017 at 10:15 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git c4d052ce970e

Ok, so this is just strange.

I do not generally pull the random SHA1's directly, I want a branch
name or a tag-name.

(Honesty in advertising: I *have* pulled the direct SHA name in the
past, simply because I didn't want to pull a whole branch. But then I
edit up the end result to have a sensible name, because I want one).

So I don't take pull requests that don't have sane branch or tag
names. Because that's just odd.

Please fix up you repository. Or ratrher, please fix your pull
request. Because what I think I actually want to pull is

    tags/pci-v4.11-changes

which is the signed tag that you have that actually points to that
commit. But you use some completely broken request-pull script that
screwed everything up.

Please just burn that piece of crap code on the altar to the goddess
of good taste.

           Linus
