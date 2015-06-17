Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42623 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757572AbbFQRc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 13:32:28 -0400
Date: Wed, 17 Jun 2015 19:32:26 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Borislav Petkov <bp@suse.de>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	Andy Lutomirski <luto@amacapital.net>,
	linux-pci@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-ID: <20150617173226.GI11147@wotan.suse.de>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6VYvd-Au58QRJprCquuvJkY9NYe1x8FmbW7qAhVrVE=QQ@mail.gmail.com>
 <20150519175310.GH23057@wotan.suse.de>
 <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com>
 <CAB=NE6UdW2d6zO1hYbTnPcoZWt8+Yg5KdWE_bdqAuR_ysey_+A@mail.gmail.com>
 <557FCD1A.4020105@ti.com>
 <20150616190504.GH11147@wotan.suse.de>
 <55810E42.4080500@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55810E42.4080500@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 17, 2015 at 09:05:54AM +0300, Tomi Valkeinen wrote:
> Hi Luis,
> 
> On 16/06/15 22:05, Luis R. Rodriguez wrote:
> 
> > Can the fbdev parts go through Bjorn's tree? We last discussed if the series
> > was important to be fully merged or not by v4.2 and I recentlty provided a
> > long winded review of the entire series to help maintainers pick and choose
> > and decide [1].
> > 
> > Based on this can the fbdev patches from both of these series go through Bjorn's tree?
> 
> Yes, they can go through Bjorn's tree if there are no non-trivial
> conflicts with the main fbdev stuff. linux-next should contain all the
> fbdev patches going for 4.2.

Great, thanks Tomi.

  Luis
