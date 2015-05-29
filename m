Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5567FFB6.5050108@ti.com>
Date: Fri, 29 May 2015 08:57:10 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	<venkatesh.pallipadi@intel.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOk?= =?UTF-8?B?bMOk?=
	<ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com> <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com> <20150521223321.GG32152@google.com> <20150522002341.GM23057@wotan.suse.de> <20150526174008.GN32152@google.com> <20150527200402.GS23057@wotan.suse.de> <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com>
In-Reply-To: <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QGRSIbsXSk0hlMjJVcaF8WFWgP1tiPtca"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--QGRSIbsXSk0hlMjJVcaF8WFWgP1tiPtca
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/05/15 03:36, Luis R. Rodriguez wrote:
> On Wed, May 27, 2015 at 1:04 PM, Luis R. Rodriguez <mcgrof@suse.com> wr=
ote:
>> On Tue, May 26, 2015 at 12:40:08PM -0500, Bjorn Helgaas wrote:
>>> On Fri, May 22, 2015 at 02:23:41AM +0200, Luis R. Rodriguez wrote:
>>>> On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
>>>>>
>>>>> I tentatively put this (and the rest of the series) on a pci/resour=
ce
>>>>> branch.  I'm hoping you'll propose some clarification about
>>>>> EXPORT_SYMBOL_GPL().
>>>>
>>>> EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
>>>> only run that code. So for instance although we have "Dual BSD/GPL"
>>>> tags for modules pure "BSD" tags do not exist for module tags and
>>>> cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
>>>> who do believe tha at run time all kernel modules are GPL [1] [2].
>>>> And to be precise even though the FSF may claim a list of licenses
>>>> are GPL-compatible we cannot rely on this list alone for our own
>>>> goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
>>>> discuss this on lkml [2].
>>>
>>> By "propose some clarification," I meant that I hoped you would propo=
se a
>>> patch to Documentation/ that would give maintainers some guidance.
>>
>> I *really really* would hate to do so but only because you insist, I'l=
l look
>> into this...
>=20
> OK done. Please let me know if there is anything else I can do to
> help. Also as per review with Tomi, the framebuffer maintainer, he
> would prefer for only the required symbols to go through your tree.
> We'd then wait for the next merge window for them to perculate to
> Linus' tree and once there I'd send him a pull request for the
> framebuffer device driver changes alone. So this does mean we'll have
> no users of the symbols for a full release, but again, this is as per
> Tomi's preference. This strategy is also the preference then for the
> pci_iomap_wc() series as well. With that in mind, perhaps the lib
> patch can go in as we'd have no users but we do have a few future
> possible expected users.

I don't have any issue with fbdev changes going through other trees, but
I'd rather do that only if there are good reasons to go that way.

These changes to fbdev drivers look like cleanups, so they are not
critical, right? Does delaying the fbdev changes until the dependencies
are in prevent some other development?

 Tomi


--QGRSIbsXSk0hlMjJVcaF8WFWgP1tiPtca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZ/+2AAoJEPo9qoy8lh71SLwQAIngt1BSCG0yRTCVn57PtkcH
/nq5d+hZ/+vZoGIRVRsqLkjAAtDNXhGbyOyDHexq68HNSDDSkVixYAty0jz7swM8
uaa90Ov9jEYxw78CUsDwoiNwjaD+whNrplifTasq+3cLCntSKWnSM/DQtwTRIl1d
x1r+lzN9cwOGWN4tLBA8nQAdtI44/t9YF9Gn7qXGnZh8jY0Pe36a1Xj2pWYEDxZm
YHRKzREK9VpZTkSfz8LR8ua1YVfez0hMgCN7R5FPBpco3WirOz7ByebKy4RsttXV
ieyuyqSSbEMIzHL4k4gcw9s/SxLtyek5mby249DCYSP0rbmwT++bGyycgr7Vq6P0
MvEcO1iw0OtO8QrIuCKIlZ4QFox8ph91O3CeKzvM4+MVgP0Ah2euDRg6V0yf2EXM
cqF9qNtwhLXcNqlwU8eDIMKLOBSb0SL1T6jPm2X5OGsZ7g7EFFl2cMUy+aHpl8Ld
z6tlzm7KeGM1HS6fp/OFuRc6nwC510oMqNiO2WAn8OWLkoKiogzBqyTvOaC/bG0g
9N046epoz3St+htxIwtBi5KcuFgPJZxDSebHGwLtiBpv2LxjJ143zBiLqA1w8+SF
DbamQ0N3xP/sMI6nGXbKHRN2CLkEfz02PXx0dlKYwQr1kjqLAUKJ7v7yyo8798rw
5RDJmS+JMOx4lAaEWazM
=5jWs
-----END PGP SIGNATURE-----

--QGRSIbsXSk0hlMjJVcaF8WFWgP1tiPtca--
