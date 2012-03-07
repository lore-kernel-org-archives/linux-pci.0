MIME-Version: 1.0
In-Reply-To: <1331018040-30725-9-git-send-email-yinghai@kernel.org>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-9-git-send-email-yinghai@kernel.org>
Date: Tue, 6 Mar 2012 20:53:50 -0700
Message-ID: <CABhMZUXsZD7YgViGxtvFyu8Pi2+QXfJ4rJwqZq9ybQt8UGTM9w@mail.gmail.com>
Subject: Re: [PATCH 08/23] PNPACPI: Fix device ref leaking in acpi_pnp_match
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org, Len Brown <lenb@kernel.org>,
	Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> During testing pci root bus removal, found some root bus bridge is not fr=
eed.
>
> If booting with pnpacpi=3Doff, those hostbridge could be freed without pr=
oblem.
>
> It turns out that some devices reference are not released during acpi_pnp=
_match.
>
> that match should not hold one device ref during every calling.
>
> Add put_device calling before returning.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@kernel.org
> Cc: Len Brown <lenb@kernel.org>
> Cc: Adam Belay <abelay@mit.edu>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/pnp/pnpacpi/core.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index b00c176..d21e8f5 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -321,9 +321,14 @@ static int __init acpi_pnp_match(struct device *dev,=
 void *_pnp)
> =A0{
> =A0 =A0 =A0 =A0struct acpi_device *acpi =3D to_acpi_device(dev);
> =A0 =A0 =A0 =A0struct pnp_dev *pnp =3D _pnp;
> + =A0 =A0 =A0 struct device *physical_device;
> +
> + =A0 =A0 =A0 physical_device =3D acpi_get_physical_device(acpi->handle);
> + =A0 =A0 =A0 if (physical_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_device(physical_device);
>
> =A0 =A0 =A0 =A0/* true means it matched */
> - =A0 =A0 =A0 return !acpi_get_physical_device(acpi->handle)
> + =A0 =A0 =A0 return !physical_device
> =A0 =A0 =A0 =A0 =A0 =A0&& compare_pnp_id(pnp->id, acpi_device_hid(acpi));
> =A0}
>

I spent about an hour convincing myself that this patch does the right
thing.  I *think* it does, but it certainly is not obvious.  It's
always nicer if the get/put are in the same function or in functions
that obviously correspond to each other.  But you didn't create this
mess, so I don't hold you responsible for fixing it :)

Bjorn
