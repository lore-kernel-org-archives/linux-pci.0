Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45087 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbbFYUsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jun 2015 16:48:23 -0400
Date: Thu, 25 Jun 2015 22:48:08 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: akpm@linux-foundation.org, mingo@elte.hu, syrjala@sci.fi,
	ville.syrjala@linux.intel.com, luto@amacapital.net,
	tomi.valkeinen@ti.com, mst@redhat.com, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pci@vger.kernel.org, airlied@redhat.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH v5 0/3] atyfb: address MTRR corner case
Message-ID: <20150625204808.GD4898@pd.tnic>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 06:34:17PM -0700, Luis R. Rodriguez wrote:
> Luis R. Rodriguez (3):
>   video: fbdev: atyfb: clarify ioremap() base and length used
>   video: fbdev: atyfb: replace MTRR UC hole with strong UC
>   video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
> 
>  drivers/video/fbdev/aty/atyfb.h      |  5 +--
>  drivers/video/fbdev/aty/atyfb_base.c | 74 +++++++++++-------------------------
>  2 files changed, 24 insertions(+), 55 deletions(-)

Took those too along with

"[PATCH] video: fbdev: atyfb: move framebuffer length fudging to helper"

which was missing here.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
