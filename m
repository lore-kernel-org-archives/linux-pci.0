Return-Path: <SRS0=l7Ns=BQ=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=l7Ns=BQ=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tyler Baicar' <tbaicar@codeaurora.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
Date: Tue, 17 Oct 2017 16:00:40 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0099999@AcuExch.aculab.com>
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
In-Reply-To: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Tyler Baicar
> Sent: 17 October 2017 16:42
> Currently the AER driver uses cper_print_bits() to print the AER status
> string. This causes the status string to not include the proper PCI devic=
e
> name prefix that the other AER prints include. Also, it has a different
> print level than all the other AER prints.
>=20
> Update the AER driver to print the AER status string with the proper stri=
ng
> prefix and proper print level.
>=20
> Previous log example:
>=20
> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> Receiver Error, Bad TLP
...
> New log:
>=20
> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> e1000e 0003:01:00.1: Receiver Error
> e1000e 0003:01:00.1: Bad TLP

Wouldn't it be better to manage to print the above all on 1 line?

...
> index 54c4b69..b718daa 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -206,6 +206,19 @@ void aer_print_port_info(struct pci_dev *dev, struct=
 aer_err_info *info)
>  }
>=20
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> +void dev_print_bits(struct pci_dev *dev, unsigned int bits,
> +		    const char * const strs[], unsigned int strs_size)

static and rename to aer_print_bits since this isn't a generic 'dev'
function.

	David
