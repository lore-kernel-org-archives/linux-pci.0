Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58824 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbbFYPks (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jun 2015 11:40:48 -0400
Date: Thu, 25 Jun 2015 17:40:31 +0200
From: Borislav Petkov <bp@suse.de>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: mingo@kernel.org, arnd@arndb.de, bhelgaas@google.com,
	luto@amacapital.net, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomi.valkeinen@ti.com, mst@redhat.com, toshi.kani@hp.com,
	linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com,
	benh@kernel.crashing.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>, konrad.wilk@oracle.com,
	ville.syrjala@linux.intel.com, david.vrabel@citrix.com,
	jbeulich@suse.com,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Subject: Re: [PATCH v8 6/9] lib: devres: add pcim_iomap_wc() variants
Message-ID: <20150625154031.GB4898@pd.tnic>
References: <1435195342-26879-1-git-send-email-mcgrof@do-not-panic.com>
 <1435195342-26879-7-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1435195342-26879-7-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 06:22:19PM -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Now that we have pci_iomap_wc() add the respective
> devres helpers. These go unexported for now but
> note that should they later be exported this
> must go with EXPORT_SYMBOL_GPL().

Do I see it correctly, those are not used in this patchset?

If so, then let's keep this patch in the bag and pick it up only when
those functions have users.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
