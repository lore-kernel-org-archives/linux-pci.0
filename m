Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37761 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbESWrO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 18:47:14 -0400
MIME-Version: 1.0
In-Reply-To: <20150519224452.GT31666@google.com>
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com> <20150519224452.GT31666@google.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 19 May 2015 15:46:52 -0700
Message-ID: <CAB=NE6VhdEpiTrxW=VqjsJ94pDzcL5XwEgJyJ07D3-14KAdt9g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Airlie <airlied@linux.ie>, daniel.vetter@intel.com,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 3:44 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks! Who's tree should this go through?

  Luis
