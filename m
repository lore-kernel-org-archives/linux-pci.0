Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 22 Dec 2011 13:59:11 -0500 (EST)
Message-Id: <20111222.135911.584309149966835644.davem@davemloft.net>
To: bhelgaas@google.com
Cc: James.Bottomley@hansenpartnership.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAErSpo7yoWOg8P1NAi70HJX=OMyO6XUwnUBxVq3P0YK87eP5tw@mail.gmail.com>
References: <CAErSpo7d3hHeJU87zYo=yJoG3eqOZ4QggkOyNnu7xuJe8oG9Qg@mail.gmail.com>
	<1318607132.3018.30.camel@dabdike.int.hansenpartnership.com>
	<CAErSpo7yoWOg8P1NAi70HJX=OMyO6XUwnUBxVq3P0YK87eP5tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 20 Dec 2011 08:55:53 -0700

> This series has been in linux-next for a while now (via Jesse's PCI
> tree), so this would be a good time to try it out if you haven't
> already.
> 
> I know ia64 has been exercised a bit (thanks, Tony), but I haven't
> heard anything about arm, mips, parisc, powerpc, sparc, etc.
> 
> There is one outstanding bug fix for alpha that Jesse hasn't
> integrated yet, but as far as I know, everything else is in good
> shape.

I'll give it a quick test on sparc64 today.
