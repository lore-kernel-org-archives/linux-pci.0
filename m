Return-Path: <SRS0=xLzV=LU=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=xLzV=LU=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
References: <1533875532-24954-1-git-send-email-okaya@kernel.org> <20180905212028.GS107892@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180905212028.GS107892@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Sep 2018 11:05:48 +0200
Message-ID: <CAJZ5v0jA5ibsHseygjOrG_Azw_Xj7y0=TAMks7x-i-yT4+E9QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: correct error message for ASPM disabling
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: okaya@kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 5, 2018 at 11:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 10, 2018 at 04:32:11AM +0000, Sinan Kaya wrote:
> > If _OSC execution fails today for platforms without an _OSC
> > entry, code is printing a misleading message saying disabling
> > ASPM as follows:
> >
> > acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
> >
> > We need to ensure that platform supports ASPM to begin with.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reported-by: Michael Kelley <mikelley@microsoft.com>
>
> Tentatively applied both to pci/aspm for v4.20, thanks!
>
> Rafael, let me know if you object or would rather put these through your tree.

I have no problems with these and they can go in via the PCI tree as
far as I'm concerned.

Thanks,
Rafael
