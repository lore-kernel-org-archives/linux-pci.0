Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
In-Reply-To: <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com> <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org> <874lgcufsu.fsf@linux.intel.com> <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org> <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com>
Date: Wed, 05 Sep 2018 08:18:48 +0300
Message-ID: <87y3cgbjyf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Aug 03, 2018 at 01:25:58PM -0400, Sinan Kaya wrote:
>> On 8/3/2018 2:26 AM, Felipe Balbi wrote:
>> > Sinan Kaya <okaya@kernel.org> writes:
>> >=20
>> > > On 8/2/2018 7:36 AM, Felipe Balbi wrote:
>> > > > PCIe GEN4 defines a new bit on Status Register which tells us that=
, if
>> > > > Set, a function is immediately ready after a Reset. This means that
>> > > > all delays after a Conventional or Function Reset can be skipped.
>> > >=20
>> > > Can you give a reference to the section of the specification? or
>> > > a pointer to the ECN?
>> >=20
>> > Section 7.5.1.1.4 of PCIe GEN4 spec. Table 7-4:
>> >=20
>> > Immediate Readiness =E2=80=93 This optional bit, when Set, indicates t=
he
>> > Function is guaranteed to be ready to successfully complete valid
>> > configuration accesses at any time following any reset that the host is
>> > capable of issuing Configuration Requests to this Function.
>> >=20
>> > When this bit is Set, for accesses to this Function, software is exempt
>> > from all requirements to delay configuration accesses following any ty=
pe
>> > of reset, including but not limited to the timing requirements defined
>> > in Section 6.6.  How this guarantee is established is beyond the scope
>> > of this document.
>> >=20
>> > It is permitted that system software/firmware provide mechanisms that
>> > supersede the indication provided by this bit, however such
>> > software/firmware mechanisms are outside the scope of this
>> > specification.
>> >=20
>>=20
>> Thanks for the spec reference.
>
> Yes.  Please include the reference in the changelog of v2.

will do

>> I think the patch is touching the wrong places. pci_dev_wait() is there
>> to wait for CRS response to finish following reset.
>>=20
>> Typical sequences are:
>> 1. Do some kind of reset in another routine
>> 2. Wait reset specific wait time (1sec for secondary bus reset as an
>> example and 100ms for d3-d0 transition)
>> 3. call pci_dev_wait() after reset to see if device can accept config
>> transactions.
>>=20
>> Since this applies to all resets, I think you also need to get rid of
>> waits following different reset types in step #2 and return immediately.
>> I suggest you review callers of pci_dev_wait() and tap in there.
>
> I agree; I think we should be able to skip the delays in pcie_flr(),
> pci_af_flr(), etc.

but that's why I put the code in pci_dev_wait(). Both pcie_flr() and
pci_af_flr() call pci_dev_wait(); or are you saying that the msleep(100)
call in pci_af_flr() can also be removed if (dev->imm_ready)?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluPZzgACgkQzL64meEa
mQZ3ehAA0QdWAt/FsnbRJQ6jaHYMA+Mp5NXP7cozXng1xilydDochQCavrKdasgb
ZlZQkkfBcKzQfUPCGUFBEz+GS31Ak9WQpUn3xoET2AJSNwkWFdblO61ciapGLE53
biblSL/ARdyF1RkKr87JjJ37TVaxG8JZY3n4+pfCi/ci4WrV4gbE5z0KNayXJlzx
oOjt0GaOH3v+K8GAtY7i8hgVTAIhQr95P6APYAmldzsokN34+kK0uYzwbiMytAxh
J8U+u/MAWjZ5wvoAbx6gLa1jQXKOMpwjKJqrKnWbdm7BmpfvB1Eph8TLHTVZg0xJ
K+Wl0eHGrTJQNQiY2NNRsbuZROXgq7DfAgiXNdTdaWQxRUFfnL5c6MdhRNgr+h1k
dfajYhVvRThYAle1Tws0FT/3Ix37B/QUr6hG47jBLsbPr/4VZ6tntpNEJshFXSo4
bW2pjQ/bzUhqV64nsV83uKDGZCO0suWhmGeDPmccYeIN0CPieusItyYS3a/b/DbB
1xoAiSywMIaRGZSgnbyl4PVTUUjGyFCaG6bupI0jngqe8bXtWTVUS5VIH7kfORUn
D5qBmLh/FhCoYLpu6A8KfDSIUnlSF4N8ChIKrOxyZIBG01W8nwRBCMPb5DUYoYSO
UaHT0f93G2z4FuBN5+HYV1DaUm3RUmKFB8SrTM0ljn2F1U8+PzQ=
=qmF2
-----END PGP SIGNATURE-----
--=-=-=--
