Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xensource.com, linux-fbdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v7 0/9] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Date: Tue, 23 Jun 2015 12:53:45 +0200
Message-ID: <2962702.QXZzP3RbKY@wuerfel>
In-Reply-To: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 19 June 2015 15:08:23 Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Arnd,
> 
> After a long-winded conversation with Bjorn over use of
> EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL() he's noted he'd
> be OK if this goes through you as an alternative. This series
> goes unmodified from the last posted v6 series, I am just
> reposting and addressing this to you now in hopes you might
> be comfortable with my use of EXPORT_SYMBOL_GPL() on new
> PAT interfaces. I use EXPORT_SYMBOL_GPL() for new PAT symbols,
> this parallels Ingo's stated preference as "we don't want
> proprietary modules mucking around with new code PAT interfaces,
> we only want modules we can analyze and fix in detail" [1].
> Other than this Bjorn seemed comfortable with the series and
> even had provided an Ack to the series, the EXPORT_SYMBOL_GPL()
> thing was the ony thing he was not comfortable with, and also
> that of the devres change going in with no users yet.
> 
> Tomi has already Ack'd the framebuffer driver specific changes
> and is comfortable with the driver changes to go through the
> tree that the depending symbols depend on.
> 
> I typically had submitted two series for these patches but since
> the patches are all related and now already Acked I've bundled
> them together and rebased them on top of today's linux-next tree.
> This series is part of a larger effort to help avoid direct use
> of MTRR code and instead replace it with more generic PAT
> interfaces, I posted a full description of the entire series
> recently [2].
> 
> Please let me know if there are any issues.
> 

Hi Luis,

sorry for messing up your plans, but I'm currently on parental
leave and not taking any patches for arm-soc or asm-generic
until I'm back at work in around 3 months.

I've briefly looked at your patches and they all look reasonable
to me, but it would be best if you could find someone else to
take them. Please an my 'Acked-by' to patches 1, 5 and 6.

	Arnd
