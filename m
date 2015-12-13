Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1450039022.20678.3.camel@perches.com>
Subject: Re: [PATCH 05/10] drivers/pci: make host/pci-rcar-gen2.c explicitly
 non-modular
From: Joe Perches <joe@perches.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Date: Sun, 13 Dec 2015 12:37:02 -0800
In-Reply-To: <20151213181517.GB32362@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
	 <1449970917-12633-6-git-send-email-paul.gortmaker@windriver.com>
	 <CAMuHMdUJzRMaRosLSUhH=_1Li+u4eWeqjee6iUoeWfac_2G3wA@mail.gmail.com>
	 <20151213181517.GB32362@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2015-12-13 at 13:15 -0500, Paul Gortmaker wrote:
> [Re: [PATCH 05/10] drivers/pci: make host/pci-rcar-gen2.c explicitly
> non-modular] On 13/12/2015 (Sun 11:59) Geert Uytterhoeven wrote:
> 
> > CC MODULE_AUTHOR
> 
> Thanks, I just assumed get-maintainer.pl would have automatically
> collected that up with the other names it emits.  Apparently not.
> 
> Joe: is there a reason it doesn't use the module author field?

Because it's frequently out-of-date and the
MAINTAINERS entry is generally enough.

If you want to add it, there's an option for it
	--file-emails

> Paul

cheers, Joe

