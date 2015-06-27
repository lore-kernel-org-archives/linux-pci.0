Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35895 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290AbbF0BQ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2015 21:16:29 -0400
MIME-Version: 1.0
In-Reply-To: <1435362871.26815.24.camel@kernel.crashing.org>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1435189081.3790.24.camel@kernel.crashing.org> <4985EFDD773FCB459EF7915D2A3621ADC02F10@nice.asicdesigners.com>
 <6806026.xb91q6Ad7G@wuerfel> <4985EFDD773FCB459EF7915D2A3621ADC031F8@nice.asicdesigners.com>
 <1435272718.3822.7.camel@kernel.crashing.org> <20150626193158.GJ3005@wotan.suse.de>
 <1435356258.26815.13.camel@kernel.crashing.org> <CAB=NE6XwczF6FYXV=RHyK=7ikVk_tGp+h9ouWPyORNENq4+=Kw@mail.gmail.com>
 <1435362871.26815.24.camel@kernel.crashing.org>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 26 Jun 2015 18:16:08 -0700
Message-ID: <CAB=NE6XrpUYBnu05NL2+Te2e5Kmc39DQWptRWRDMfGD9ygOWKw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Russell King <linux@arm.linux.org.uk>,
	Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Casey Leedom <leedom@chelsio.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	David Vrabel <david.vrabel@citrix.com>,
	"venkatesh.pallipadi@intel.com" <venkatesh.pallipadi@intel.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 26, 2015 at 4:54 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2015-06-26 at 15:41 -0700, Luis R. Rodriguez wrote:
>
>> > It wasn't nullified for the main user at the time, the fb. And I
>> > mentioned an IB adapter or two for which the code had been hand
>> tuned.
>>
>> This still means there could be some affected drivers when used on
>> powerpc, no?
>
> Yes. In fact what about things like ARM who also have barriers in their
> writel() ? Won't they also break WC ?

Not sure if they have that write-combine notion on their CPUs /
interconnects. Russel, Stefano, does ARM have write-combining ?

 Luis
