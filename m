Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
In-Reply-To: <87va7kbjqu.fsf@linux.intel.com>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com> <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org> <874lgcufsu.fsf@linux.intel.com> <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org> <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com> <87y3cgbjyf.fsf@linux.intel.com> <87va7kbjqu.fsf@linux.intel.com>
Date: Wed, 05 Sep 2018 08:29:56 +0300
Message-ID: <87sh2objfv.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <felipe.balbi@linux.intel.com> writes:
> Felipe Balbi <felipe.balbi@linux.intel.com> writes:
>>> Since this applies to all resets, I think you also need to get rid of
>>>> waits following different reset types in step #2 and return immediatel=
y.
>>>> I suggest you review callers of pci_dev_wait() and tap in there.
>>>
>>> I agree; I think we should be able to skip the delays in pcie_flr(),
>>> pci_af_flr(), etc.
>>
>> but that's why I put the code in pci_dev_wait(). Both pcie_flr() and
>> pci_af_flr() call pci_dev_wait(); or are you saying that the msleep(100)
>> call in pci_af_flr() can also be removed if (dev->imm_ready)?
>
> What about moving that msleep() to pci_dev_wait() itself?

this will incur and extra 100ms delay on D3->D0 transitions and bus
reset. Is that acceptable or would you prefer to add another check on
pcie_flr() and pci_af_flr()?

=2D=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluPadQACgkQzL64meEa
mQZpjQ/+Jaahh8BjQUVUdCeI3GGhIp7JwY61+XtH/pKTrwS+PWXpb9NINO1QOPGg
T5b+u0JnIhERJjUAu3CGi5w3PFtECQvBLTt2oKp4l+PoGdrOWYDjJetgNsqm3zB/
z9x+p7AjZ67/SZsapWSkXjxBQq3leo6kJ4WSznwJzgEtiTA8fBGBzNtAI0PQUx0M
beOgEvcifJVz/FdjY2Cv0NBRl3qBLk6kaVf/R/9iZo0hHB09gSlslxlQAOGbi1Rl
JEAxcbAmQKaTtMJCiHLvJJR7AyLPtNHbkCydLD41vmEOhOo5xFu+WBxq94nsTusp
KlwWAFelNK4q1iKt+m7GKfVcYVEqiEA9DzJslTUM/rHn48wtCaGIXUOnnDrh2bZF
0ORM2FM0E7WL1y2j2FR6eaeAiQeXiEwrXRVIdszrHlj4dDooRgbJ0sT5DyUUMJNV
Tjtd47TH5fkeRlmU1BQZEYcNi7gt22K9HAusMdKtAcdxS1Ccv7l5XcuBcuAD7Bvk
4PCgWfJwio54TWmfWIxIBZtQY6zNg8mP5pEW2+vg6zHNSse06SAWRLDaiNreMbz8
pnUpqU1y4TLS3rS7Y46I1bAdRzn00NTVR8tiRHeCrt0m3Ye10dBgcJxv8MXiNMQg
rEwU/FQfPAwQyxdpSExn8wn/6Xh2pCZJ0kiX1XoN44bxWQpFVQY=
=kyQC
-----END PGP SIGNATURE-----
--=-=-=--
