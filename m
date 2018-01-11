Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Jan 2018 20:04:16 +0100
From: Borislav Petkov <bp@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ACPI: Disable AER when _OSC control bit is clear.
Message-ID: <20180111190415.3jd4uffpp6weshzf@pd.tnic>
References: <20180111150316.19951-1-Yazen.Ghannam@amd.com>
 <CAJZ5v0gU6var3gNQsp2GkSujbR=vB2Zj4dZHKNOzfAtC76jFbA@mail.gmail.com>
 <DM5PR12MB191612888094C4794951FAE4F8160@DM5PR12MB1916.namprd12.prod.outlook.com>
 <CAJZ5v0ie_FntO=TO1X_tX9xzz-t6Q_yeWvTfhqufTbYBdwMGJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJZ5v0ie_FntO=TO1X_tX9xzz-t6Q_yeWvTfhqufTbYBdwMGJg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 07:03:23PM +0100, Rafael J. Wysocki wrote:
> >> > +       if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
> >>
> >> One of the operators above needs to be a && I suppose?
> >>
> >
> > It's a 3-way bitwise AND to check that OSC_PCI_EXPRESS_AER_CONTROL is
> > set in both "requested" and "control".
> >
> > IOW, we check if AER was requested by the OS and that the platform
> > granted the request.
> 
> OK

This definitely needs a comment - people will keep tripping over this.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
