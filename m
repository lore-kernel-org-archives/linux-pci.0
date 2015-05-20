Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59690 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbETJGD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 05:06:03 -0400
Message-ID: <555C4E34.30803@ti.com>
Date: Wed, 20 May 2015 12:04:52 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	David Airlie <airlied@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel.vetter@intel.com>,
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
	Antonino Daplas <adaplas@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOk?= =?UTF-8?B?bMOk?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Subject: Re: [PATCH v5 1/5] pci: add pci_iomap_wc() variants
References: <1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com> <20150519224452.GT31666@google.com> <CAB=NE6VhdEpiTrxW=VqjsJ94pDzcL5XwEgJyJ07D3-14KAdt9g@mail.gmail.com> <CAErSpo6B3_vRq-4YTSPg4f927WChZ4MXnZRY7wWCvQgZJ=9eOQ@mail.gmail.com> <CAB=NE6U8Fg1TuU9ceVCBHJwR2j+DetDz+L3ZqcJzvSy3_wvPUA@mail.gmail.com> <1347189446.1486831.1432078140756.JavaMail.zimbra@redhat.com> <CAB=NE6VkAT7JidB4ty0C1tAWTc__-tgTvzHa5OdPazrDzCv0-g@mail.gmail.com>
In-Reply-To: <CAB=NE6VkAT7JidB4ty0C1tAWTc__-tgTvzHa5OdPazrDzCv0-g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ENX7e6Ox3fskVsJltBCisjfSmuTn0r38d"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--ENX7e6Ox3fskVsJltBCisjfSmuTn0r38d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/05/15 02:45, Luis R. Rodriguez wrote:
> On Tue, May 19, 2015 at 4:29 PM, David Airlie <airlied@redhat.com> wrot=
e:
>>
>>> On Tue, May 19, 2015 at 4:02 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>>>> [-cc Venkatesh (bouncing)
>>>>
>>>> On Tue, May 19, 2015 at 5:46 PM, Luis R. Rodriguez
>>>> <mcgrof@do-not-panic.com> wrote:
>>>>> On Tue, May 19, 2015 at 3:44 PM, Bjorn Helgaas <bhelgaas@google.com=
>
>>>>> wrote:
>>>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>> Thanks! Who's tree should this go through?
>>>>
>>>> I don't know.  This is the only patch that went to linux-pci, so I
>>>> haven't seen the rest.
>>>
>>> Oh I only rev'd a v5 for 1/5 as that's the only one that had feedback=

>>> asking for changes.
>>>
>>> Patch v4 2/5 was for "lib: devres: add pcim_iomap_wc() variants", you=

>>> had questions about EXPORT_SYMBOL_GPL() and the fact that this is not=

>>> yet used. I replied. This patch can then be ignored but again, I'd
>>> hate for folks to go in and try to add a non EXPORT_SYMBOL_GPL()
>>> symbol of this.
>>>
>>> Patches v4 3-5 remain intact, I had addressed it to you, but failed t=
o
>>> Cc linux-pci, I'll go ahead and bounce those now.
>>>
>>> Just today Dave Arlie provided a Reviewed-by to some simple
>>> framebuffer device driver changes. I wonder if these changes should g=
o
>>> through the framebuffer tree provided you already gave the Acked-by
>>> for the PCI parts, or if the PCI parts should go in first and only
>>> later (I guess we'd have to wait) then intake the driver changes that=

>>> use the symbol.
>>>
>>> What we decide should likely also apply to the series that adds
>>> pci_ioremap_wc_bar() and makes use of it on drivers.
>>>
>>> Dave, Tomi, any preference?
>>>
>>
>> Maybe send Bjorn a pull request with a tree with the pci changes, and =
the fb changes reviewed-by me and acked by Tomi.
>>
>> Seems like it could be the simplest path forward.
>=20
> Works with me, Bjorn, are you OK with that?
>=20
> Dave, Tomi, I still need your Reviewed-by and Acked-by's Tomi on these
> two PCI series. Please let me know if I should resend those first, but
> I think I had Cc'd you folks already on them.

For the fb parts:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I don't have anything in my fbdev-next branch touching the fbdev drivers
changed in this series, so merging via some other tree might go fine
without conflicts.

 Tomi


--ENX7e6Ox3fskVsJltBCisjfSmuTn0r38d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXE40AAoJEPo9qoy8lh71ewQQAJ3y7kSqcQzWh406zzq126tm
yfvVoER01zwG8e8CpIWHmiCVDbmw1buMgMD2GZr+mhpomSSnkABlfzUdNwncstnI
UlVGA+mFedocmt3kX9zhKaOXhqMHOTy18lwmmiEVpSbEM69n0qE8hTxFsml6LaNz
wDkArhry/M397DB6c3DL+X9hJ1PTLeF6PPkksp1acxZCXhVK2J3VjCkpLfgaJqWK
GV5l7T+CYw+ZtGc72wE2Dna+yw9rrkDT4tIekJiFnRWpGGDZDna7M/Kw7/SbR//m
fAqaRveMfMwse0kdHd63B5yjw7wwBAdt/3mK/RyQCUNm63I5MGf2bSOZcvp4Ek/0
o2qWtm9i6pNW9PPrYixf9crQgyTZOjD+qis4HQxP4pNf35/voYcpPaeCjY/F75pz
ujDNbU/LsILcYflwX5yOEOmm/7FoDQXeQLElZM4/3AxagFIwYZQbh80HLe4K+k+F
me5O0zyXkQ7fmsTMqYBzMooSPi5r/ZKRdZLm80TixwTu31c5r6FdImYWg7Iw/wBk
s8fujkx+hbYkzr8MsOqu8OiooeHZ5z3Uz6Kf9b5nznQzwrK/a5TbwPRyK2HWn76l
ULhBKBSpty4Tq67wEsKtjtk2ddhgwBw5VgXAunub8GT0TAwiqME/p5E8sGNoPnTx
iJorH5iQ7UN8/3br9yLn
=bPjz
-----END PGP SIGNATURE-----

--ENX7e6Ox3fskVsJltBCisjfSmuTn0r38d--
