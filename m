Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 May 2013 07:21:49 -0300
From: Mauro Carvalho Chehab <mchehab@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Doug Thompson <dougthompson@xmission.com>,
	linux-edac@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Steven Whitehouse <swhiteho@redhat.com>,
	cluster-devel@redhat.com, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Finally eradicate CONFIG_HOTPLUG
Message-ID: <20130521072149.0dac0d9e@redhat.com>
In-Reply-To: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
References: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Tue, 21 May 2013 13:49:35 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Ever since commit 45f035ab9b8f ("CONFIG_HOTPLUG should be always on"),
> it has been basically impossible to build a kernel with CONFIG_HOTPLUG
> turned off.  Remove all the remaining references to it.
> 
> Cc: linux-arch@vger.kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Doug Thompson <dougthompson@xmission.com>
> Cc: linux-edac@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pcmcia@lists.infradead.org
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Steven Whitehouse <swhiteho@redhat.com>
> Cc: cluster-devel@redhat.com
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-pm@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Cheers,
Mauro
