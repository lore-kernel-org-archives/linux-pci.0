Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 23 May 2012 09:44:44 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dave Airlie <airlied@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 03/11] intel-gtt: Read 64bit for gmar_bus_addr
Message-ID: <20120523074444.GE5062@phenom.ffwll.local>
References: <1337754877-19759-1-git-send-email-yinghai@kernel.org>
 <1337754877-19759-4-git-send-email-yinghai@kernel.org>
 <CAPM=9tyZLm+F1Sq3-ycOS7GmedjiU7DR-GQ=4Hj0BzaAxHHYxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPM=9tyZLm+F1Sq3-ycOS7GmedjiU7DR-GQ=4Hj0BzaAxHHYxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2012 at 08:21:51AM +0100, Dave Airlie wrote:
> On Wed, May 23, 2012 at 7:34 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > That bar could be 64bit pref mem.
> >
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Cc: David Airlie <airlied@linux.ie>
> 
> Adding Daniel Vetter.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-- 
Daniel Vetter
Mail: daniel@ffwll.ch
Mobile: +41 (0)79 365 57 48
